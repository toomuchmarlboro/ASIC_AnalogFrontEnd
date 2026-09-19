# Phase 1 — remove the vendor IP

Status: **1b done and verified; 1a and 1c specified, code waits for Phase 3;
one finding threatens the schedule.** Date: 2026-09-19.

Source read: `UATR_TDM` cloned to `~/UATR_TDM`, HEAD
`c1fc108c68fad7cef11b884a3e889c5dd4281cc6`, byte-identical to `legacy/rtl` and
`legacy/sim` (`diff -rq`, only `modelsim.ini` and `wave.do` extra in `sim/`).

| Item | State | Record |
| --- | --- | --- |
| 1a PLL removal | specified, no code (top level is Phase 3) | [clocking.md](clocking.md) |
| 1b async FIFO | **built, verified**: `src/async_fifo.v`, 512 x 8 | [fifo.md](fifo.md) |
| 1c tristate split | specified, no code (top level is Phase 3) | [ports.md](ports.md) |

The Phase 1 gate, `grep -rniE 'altera|altpll|lpm_|scfifo' src/`, returns
nothing today. It is trivially true until the top level exists.

## Where the brief and the source disagree

Found by reading the sources instead of the brief. Each changes a Phase 1 or
later plan.

| # | `CLAUDE.md` says | The source says |
| --- | --- | --- |
| 1 | Inventory has no decimator | `top_system` instantiates `decimator` and **`C_DECIMATE := true`**. It is the shipping default. `decimator.vhd` is 573 lines plus `decim_coef_pkg.vhd` |
| 2 | Two clocks | Three: `clk_24m576`, `rmii_ref_clk`, `clk_50m_board` |
| 3 | Two `inout`s, `sda` and `scl` | Three: `eth_mdio` too |
| 4 | "Verify the FIFO against `sim/tb_chain.vhd`" | `tb_chain` does not contain the FIFO. It tests `tdm8_master` -> `tdm8_rx` -> `tdm16_merge` only |
| 5 | `packet_formatter`: "watch the buffer, likely the largest block" | It has no buffer. It streams into the FIFO. The FIFO is the buffer |
| 6 | Delete `u_pll`, add `clk_24m576` | `pll_locked` also produces the system reset, `buffer_state`, the ADC boot reset and two status bits in the packet. Needs a replacement |
| 7 | Remove `c0` / `c1` / `c2` logic | `c0` and `c1` are already `open`. `c3` is a phase-shifted clock used only when `C_LRCLK_RETIME`, which is false |
| 8 | 1024-deep FIFO implied | 410 bytes is the requirement. 512 covers it, see [fifo.md](fifo.md) |

## The decimator, and why it threatens the schedule

Decision, 2026-09-19, by the project owner: **include it**, made when the size
was only estimated as "likely over 1 mm²".

Measured the same day. `decimator.vhd` converts cleanly through GHDL
(`ghdl --synth --std=08 --out=verilog decimator`, no errors) and reports its
memories: `ram1_a` and `ram1_b`, 24 bits x 512 each, and `ram2`, 24 bits x
2 736, about **90 kbit**, plus three coefficient ROMs. Synthesised in
OpenLane's Yosys, quick effort (`abc -fast`, `dfflibmap`, tt/25C liberty,
scratchpad `dec/quick.ys`):

| | |
| --- | --- |
| Cells | 625 612 |
| Area | **3 989 967 µm² = 3.99 mm²** |
| Flops | 78 853 `dfxtp_1`, 236 `dfrtp_1` |
| Combinational | about 2.4 mm² of the total: the read and write multiplexing of the arrays, 166 490 `o21ai_0` |

For scale: `tdm8_rx` is 0.014 mm², the FIFO 0.177 mm² (`fifo.md`). The decimator
is roughly ten times everything else in the design put together.

The full-effort OpenLane synthesis (`SYNTH_STRATEGY "AREA 0"`, the config
default) had been sitting in ABC for over 30 minutes on a 252 000-gate netlist
when it was stopped by hand, unfinished. It can be rerun; the config is in the scratchpad `dec/cfg_dec.json`. Place and route of a design this
size, about 650 000 cells and a core of roughly 12 mm² at 35 % utilisation,
has not been tried on this server and is the schedule risk. The arrays are
inferred RAM on the FPGA. The ASIC has no third-party SRAM macro to use (rule
2), so they are flip-flops with a multiplexer tree.

Options this leaves, for the owner:

1. Keep it, accept the run time, and plan Phase 4 for a long flow.
2. Keep it but store the arrays in latches (`dlxtp`, about 25 % smaller than
   flops). A restructure of the arrays; the owner has allowed restructuring but
   not for this.
3. Set `C_DECIMATE := false`. The source documents that path as the known-good
   reference and `top_system` strips the block in that case. Packets stay at
   96 kHz.

## Not done, and why

- **1a and 1c code.** They edit `top_system`, which is converted last.
- **`rmii_tx`-accurate FIFO test.** The system test models its handshake.
  The real module arrives in Phase 2.
- **Provenance and conversion records** for the two GHDL conversions used in the
  tests (`packet_formatter`, `udp_tx_core`). They are test inputs in the
  scratch `.sim/`, not deliverables; the deliverable conversions belong in
  `conversion.md` at Phase 2.
