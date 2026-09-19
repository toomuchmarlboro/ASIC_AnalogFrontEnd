# fifo — the CDC FIFO (Phase 1b)

Replaces the Altera `dcfifo` in `ip/async_fifo`. Source: `src/async_fifo.v`.
Date: 2026-09-19.

## The megafunction, as read

From `ip/async_fifo/async_fifo.vhd` in `UATR_TDM` commit
`c1fc108c68fad7cef11b884a3e889c5dd4281cc6` (`grep` on the `GENERIC MAP` block,
not from memory):

| Parameter | Value |
| --- | --- |
| `lpm_type` | `dcfifo`, `intended_device_family` "Cyclone IV E" |
| `lpm_width` | **8** |
| `lpm_numwords` | **1024** (`lpm_widthu` 10) |
| `lpm_showahead` | OFF, standard read mode |
| `overflow_checking`, `underflow_checking` | ON, ON |
| `use_eab` | ON (block RAM) |
| `rdsync_delaypipe`, `wrsync_delaypipe` | 4, 4 |
| Ports | `data[7:0]`, `wrclk`, `wrreq`, `wrfull`, `rdclk`, `rdreq`, `q[7:0]`, `rdempty` |

Instance in `top_system.vhd`: write side `clk_18m` (24.576 MHz, the audio
clock), read side `rmii_ref_clk` (50 MHz). **`rdempty` and `wrfull` are both
left `open`.** Nothing reads the flags. `packet_formatter` writes without
looking at `wrfull`, and `udp_tx_core` reads a fixed 410 payload bytes after a
toggle handshake without looking at `rdempty`.

## What was chosen

| | Megafunction | Here | Why |
| --- | --- | --- | --- |
| Width | 8 | 8 | one byte per write, unchanged |
| Depth | 1024 | **512** (`ADDR_WIDTH` 9) | measured, below |
| Sync stages | 4 | 2 | standard two-flop synchroniser, see *CDC* |

**Depth.** 1024 x 8 fits one M9K block, which suggests a wizard default rather
than a calculated requirement (nothing in the source says which); the design
does not need it. The requirement is
one whole packet, 410 bytes, because `udp_tx_core` only starts reading after
the packet is complete. Measured with the real `packet_formatter` and
`udp_tx_core`, see *Verification*:

| Frame rate | Line stall before the packet is sent | Peak occupancy | Depth 512 |
| --- | --- | --- | --- |
| 96 kHz | 0 | 410 | ok |
| 96 kHz | 7 µs (an ARP frame ahead) | 464 | ok |
| 96 kHz | 15 µs | 489 | ok |
| 96 kHz | 17 µs | 511 | **overflows** |
| 24 kHz | 0 to 7 µs | 410 | ok |
| 24 kHz | 40 to 60 µs | 470 | ok |
| 24 kHz | 80 µs | 512 | **overflows** |

Depth 256 fails outright, as it must: a packet is 410 bytes. So the smallest
power of two is 512. It tolerates about 15 µs of transmit-line stall at 96 kHz
and about 60 µs at 24 kHz. The largest realistic stall is one ARP frame ahead
on the line, about 7 µs (a 60-byte frame plus preamble, FCS and gap at
100 Mbit/s). The decimated 24 kHz stream is the shipping configuration, so the
margin there is about 8x.

**Why this matters more than usual.** `packet_formatter` never checks
`wrfull`, so an overflow is a silently dropped byte, and every later byte in
the stream is then one position off, because the reader always takes 410 bytes
per packet. It does not recover. The margin above is what keeps that from
happening. If the design is ever changed so the line can stall longer than
about 15 µs at 96 kHz, this depth must go back up.

**Cost.** Synthesised alone with OpenLane's Yosys (`f9`, scratchpad,
`--to Yosys.Synthesis`): 11 588 cells, **176 906 µm²**, of which 4 096
`dfxtp` are the storage array. 1024 deep would be about twice that. No latches
inferred, no problems in the `check` pass, Verilog-2005 clean.

## Structure

- Storage: `reg [7:0] mem [0:511]`, written in the write domain, read in the
  read domain.
- Binary read and write pointers, one bit wider than the address, so full and
  empty are distinguishable.
- Each pointer is converted to Gray code **in its own domain and registered**,
  then goes through two flops in the other domain.
- `wrfull`: the next Gray write pointer equals the synchronised Gray read
  pointer with its top two bits inverted. `rdempty`: the next Gray read pointer
  equals the synchronised Gray write pointer. Both registered.
- `q` is a register updated on the `rdclk` edge that samples `rdreq` while not
  empty. That is standard read mode: `udp_tx_core` says "q settles one clock
  after rdreq" and takes a byte every four clocks.

**Why the Gray coding is safe.** Only one bit of a Gray pointer changes per
increment, so a synchroniser flop that samples it mid-change sees either the
old or the new value, never a wrong one. Both errors are conservative: a stale
read pointer makes `wrfull` assert early, a stale write pointer makes
`rdempty` assert late. Neither can cause an overflow or an underflow. The
pointers are registered before crossing so no combinational glitch reaches the
synchroniser.

**Reset, which the megafunction did not have.** The FPGA original comes up in a
known state from the bitstream. Silicon does not. `rst_n` is asynchronous,
active-low, and released separately in each domain by a two-flop
synchroniser, so no domain leaves reset on a clock edge that races it. Both
sides are reset together, which is required: resetting only one side would
leave the pointers disagreeing. The top level drives it from the audio-domain
reset, see [clocking.md](clocking.md).

## CDC

The FIFO is one crossing. It is not the only one in `top_system`: the
`packet_ready` toggle into `udp_tx_core`'s three-flop synchroniser, and the
`dbg*_sync` status paths, each cross a domain on their own. The inventory
belongs in `integration.md` at Phase 3.

The megafunction used four synchroniser stages and this uses two. The consumer
does not depend on the difference: after the trigger it waits 42 header bytes
at four clocks each, about 170 clocks, before its first payload read, which is
far longer than either synchroniser.

## Verification

`sim/tb_chain.vhd`, which `CLAUDE.md` names for this check, **does not contain
the FIFO**. It tests `tdm8_master`, `tdm8_rx` and `tdm16_merge` only. So two
new testbenches do the work, both Icarus Verilog through `tbrun`.

**Unit test**, `tb/tb_async_fifo.v`. Independent clocks, a scoreboard of every
accepted write and read. It fills past full (overflow must be ignored), drains
past empty (underflow must be ignored), runs random traffic at six duty
cycles, and resets in the middle of traffic. Checks order, count, flags, and
that occupancy never exceeds the depth.

```
iverilog -g2012 -Ptb_async_fifo.AW=<n> -o .sim/fifo.vvp tb/tb_async_fifo.v src/async_fifo.v
vvp -n .sim/fifo.vvp [+wper=<ps> +rper=<ps>]
```

Passes at depth 512, 1024, 16, 8 and 4, and at write/read clock ratios
24.576/50 MHz (the real one), 50/24.576, 30/50 and 49.97/50 MHz. Minimum
`ADDR_WIDTH` is 2.

**Negative control.** Three deliberately broken copies, each must fail and did:
no underflow guard (reads of words never written), no overflow guard (more
than DEPTH words held), and a full flag without the inverted top bits
(`wrfull` never set correctly, 3 errors at once).

**System test**, `tb/tb_fifo_system.v`, run by `tb/run_fifo_system.sh [aw]`.
The real `packet_formatter` and `udp_tx_core`, both through `ghdl --synth
--out=verilog` from `legacy/rtl`, with this FIFO between them and a model of
`rmii_tx`'s handshake (one acknowledge per four clocks, optional grant delay).
Every payload byte `udp_tx_core` sends is compared, in order, with the byte
`packet_formatter` wrote. Five cases at depth 512, 40 packets each:

| Case | Bytes checked | Dropped | Errors | Peak |
| --- | --- | --- | --- | --- |
| 96 kHz, no stall | 16 400 | 0 | 0 | 410 |
| 96 kHz, 7 µs stall | 16 400 | 0 | 0 | 464 |
| 24 kHz, no stall | 16 400 | 0 | 0 | 410 |
| 24 kHz, 7 µs stall | 16 400 | 0 | 0 | 410 |
| 24 kHz, 40 µs stall | 16 400 | 0 | 0 | 470 |

`ALL SYSTEM CASES PASS`. The depth table above comes from the same testbench
with growing stalls.

## What this does not show

- **Metastability.** RTL simulation is zero-delay and cannot show it. The
  argument is structural: two-flop synchronisers on single-bit-change Gray
  pointers. No formal CDC tool was run.
- **The real `rmii_tx`.** Modelled by its documented contract, not run.
  `rmii_tx` is converted in Phase 2, and the full chain check belongs there.
- **Stalls beyond the table.** Anything that holds the line longer than about
  15 µs at 96 kHz overflows silently. Nothing in the current design does.
