# conversion — Phase 2

**The design is converted to Verilog.** `src/` holds the whole chip as
Verilog-2005, generated from the vendored VHDL, plus the hand-written FIFO.
That is what `CLAUDE.md`'s definition of done requires ("`src/` contains
synthesisable Verilog") and what the Phase 4 config reads (`dir::src/*.v`).

Date: 2026-09-20. Source: `UATR_TDM` commit
`c1fc108c68fad7cef11b884a3e889c5dd4281cc6`, vendored in `legacy/rtl` and
byte-identical to it.

**A detour worth recording.** The first attempt stopped at the GHDL *plugin*
route, which synthesises straight from VHDL without producing Verilog at all.
`CLAUDE.md` does say "keep VHDL end to end and skip the conversion entirely" if
the plugin works, and it does work - but the definition of done and the Phase 4
config both want Verilog in `src/`, and `WORKFLOW.md` prescribes
`ghdl --synth --out=verilog`. The deliverable wins. The plugin work was not
wasted: it proved the whole design elaborates and synthesises, and it found the
four toolchain problems below, which apply to either route. It is still used,
as the independent reference in the equivalence proofs.

## How the conversion is run

```bash
tbrun "cd <repo> && bash synth/convert_vhdl.sh"      # seconds
```

It applies `patches/0001..0003` to `legacy/rtl/top_system.vhd`, analyses the
design, and runs **one** conversion:

```
ghdl --synth --std=08 --latches --out=verilog top_system
```

then splits the result into one file per module in `src/`, with a provenance
header on each. Every file says `DO NOT EDIT`; they are regenerated, not
maintained.

**Why the whole hierarchy in one pass, not file by file.** Three modules take
generic values from the top: `adau1978_sequencer` (`BOOT_DELAY_CYCLES`
7 500 000, not the entity default 2 000 000), `i2c_master`
(`QUARTER_BIT_CYCLES` 250) and `rmii_rx` (`G_ENFORCE_FCS` false, default true).
Converting each file on its own would silently bake in the **entity defaults**
and produce a chip that boots with the wrong delays. Converting from the top
applies the top's generic map. This is the single most dangerous trap in the
per-module route WORKFLOW.md describes, and it is why the script does it
differently.

## What is in src/

| File | From | Notes |
| --- | --- | --- |
| `crc32.v`, `tdm8_master.v`, `tdm8_rx.v`, `tdm16_merge.v`, `decimator.v`, `packet_formatter.v`, `rmii_rx.v`, `rmii_tx.v`, `udp_tx_core.v`, `udp_rx_core.v`, `arp_responder.v`, `i2c_master.v`, `adau1978_sequencer.v` | the matching `legacy/rtl/*.vhd` | generated |
| `top_system.v` | `legacy/rtl/top_system.vhd` + patches 0001-0003 | generated |
| `async_fifo.v` | nothing - written by hand | the replacement for the vendor FIFO, [fifo.md](fifo.md) |

19 539 lines in total. `tdm16_rx` is excluded, as the brief says, and is not
instantiated by the top. `ip/` is gone: the PLL was deleted in Phase 1a.

**Gates.** `grep -rniE 'altera|altpll|lpm_|scfifo' src/` returns nothing.
`iverilog -g2005 -s top_system src/*.v` elaborates the whole design, which also
proves every instance in `top_system.v` resolves to a module with matching
ports.

**`phase0/tdm8_rx.v`.** The Phase 0 hand conversion moved out of `src/` to
`phase0/`, and `config_tdm8_rx.json` now points there, so run `tdm8rx4` still
reproduces. It is not part of the chip: the chip's `tdm8_rx` is generated with
everything else, so one tool and one source produce the whole design. The two
differ in that the hand one takes an active-low `rst_n`, worth about 11 % of
that module and about 0.04 % of the chip. See `phase0/README.md`.

## Four toolchain findings, each real and each still current

**1. `--latches`, because of a dead signal in `adau_sequencer`.** Both the
conversion and the plugin fail with `error: latch infered for net "poll_ot" (use --latches)`.
`poll_ot` is declared `-- retained, unused`, assigned only in the reset branch
of the clocked process and never read. The FPGA build accepts it because
Quartus strips it. With `--latches` the import succeeds and the latch is
optimised away: there is no `dlxt*` or `dlrt*` cell in the final netlist. The
legacy source is not edited. If a *real* latch ever appears, this flag would
hide it, so the netlist is checked for latch cells after every run.

**2. `read_liberty -lib` before `check`, or every flop looks undriven.**
Without the cell models loaded, Yosys's `check` does not know `Q` is an output
and reports "used but has no driver" for every mapped flop: 85 693 of them on
this design, and 13 of them on real top-level outputs. That is a false alarm,
confirmed by finding `.Q(\lrclk_d )` driving the wire in the written netlist.
OpenLane reads blackbox models for the same reason. This cost most of the
debugging time on the trial and is the reason the script reads the liberty
first.

**3. The active-high reset costs one inverter per flop, chip-wide.** The same
finding as Phase 0 ([decisions.md](decisions.md)), now confirmed at the top
level: sky130 has only an active-low asynchronous reset flop, and the legacy
VHDL resets active-high. `tdm8_rx` through the plugin is 1 093 cells and
15 679 µm², against 1 094 and 15 688 µm² for the hand-converted active-high
Verilog in `tdm8rx1` - the two routes agree to 0.06 %, which is a useful
cross-check of the plugin. The active-low `rst_n` version is 644 cells and
13 998 µm². **The saving is available chip-wide and has not been taken**, see
*Open*.

**4. `-dont_use sky130_fd_sc_hd__lpflow_*`.** Without it ABC picks 62
`lpflow_inputiso0p_1` power-gating isolation cells. Same exclusion OpenLane
makes; there is one power domain here.

## The two synthesis paths agree

The converted Verilog is synthesised on its own, no VHDL and no plugin, by
`synth/run_src.sh`. The VHDL path, `synth/run_top_ghdl.sh`, is kept as the
cross-check.

| Path | Cells | Cell area | `check` |
| --- | --- | --- | --- |
| VHDL through the plugin | 628 684 | 4.196 mm² | 0 problems |
| **`src/*.v` through plain Yosys** | **637 096** | **4.213 mm²** | 0 problems |

1.3 % more cells and 0.4 % more area on the Verilog path. They are not expected
to be identical: the plugin hands Yosys GHDL's own netlist, while the Verilog
path re-parses the RTL GHDL emitted, so the optimiser starts from slightly
different structures. Both map cleanly and both are free of vendor cells. The
Verilog number is the one that counts, because it is what Phase 4 will build.

Runtime: 3 min 31 s for the VHDL path, 3 min 53 s for the Verilog path.

## Cell mix

The chip is dominated by the decimator's delay-line arrays, which are
flip-flops here because there is no third-party SRAM macro (rule 2).

| Cell | Count |
| --- | --- |
| `nand2_1` | 175 239 |
| `o21ai_0` | 166 461 |
| `dfxtp_1` (flop, no reset) | 83 891 |
| `nor2_1` | 67 206 |
| `clkinv_1` | 57 708 |
| `a21oi_1` | 51 067 |
| `mux2_2` | 16 061 |
| `dfrtp_1` (flop, async reset) | 1 948 |

85 839 flops in total. 83 891 of them have no reset, which is the decimator's
RAM arrays and is correct: the FPGA original does not reset them either.

## Verification: every module proved against its VHDL

`CLAUDE.md` requires each module to pass its check before it moves on. The
converted Verilog is checked against the VHDL it came from **formally**, not
just by simulation: `synth/equiv_src.sh` builds a miter between the entity
imported by the plugin (gold) and `src/<module>.v` (gate), and asks Yosys to
prove them equivalent.

```bash
olrun "cd <repo> && bash synth/equiv_src.sh"          # about 90 s for the provable ones
```

The recipe needs `memory_map` (the SAT solver cannot import inferred ROM/RAM
cells) and `async2sync` (it has no model for asynchronous resets), and for
`tdm16_merge` a port rename, see *Port-name case* below.

| Module | Result |
| --- | --- |
| `crc32` | **equivalent, proven** |
| `tdm8_master` | **equivalent, proven** |
| `tdm16_merge` | **equivalent, proven** |
| `packet_formatter` | **equivalent, proven** |
| `udp_tx_core` | **equivalent, proven** |
| `udp_rx_core` | **equivalent, proven** |
| `arp_responder` | **equivalent, proven** |
| `rmii_tx` | **equivalent, proven** |
| `rmii_rx` | **equivalent, proven** |
| `i2c_master` | **equivalent, proven** |
| `tdm8_rx` | proof does not close (105 cells); **equivalent in simulation**, about 310 000 comparisons |
| `adau1978_sequencer` | proof leaves **2 cells**; **equivalent by vector comparison** over 8.3 M cycles, see below |
| `decimator` | not attempted: 596 k cells, far past what the solver will take |
| `top_system` | not attempted at this level; covered by the modules plus the checks below |

**"Not proven" is not "not equivalent".** No counterexample was produced for
any module. The induction simply does not close: on `tdm8_rx` the unproven cell
count falls as the depth rises (191 at depth 10, 168 at 40, 105 at 120), which
is the signature of a proof that is converging, not of a difference.

### Port-name case

`ghdl --synth --out=verilog` **lowercases port names when it converts a whole
hierarchy** (`ch_data_A` becomes `ch_data_a`) but preserves the VHDL case when
it converts a single entity. Inside `src/` this is consistent, since one pass
generated both the module and its instantiation, and `iverilog -g2005` proves
the connections resolve. It matters when mixing files from the two modes, which
is what the equivalence recipe does, so the gold side is renamed to match.

### adau1978_sequencer, by vector comparison

The proof gets to within 2 unproven cells once `memory_map` is added (24
without it), but does not close. So the module is checked behaviourally
instead, and in a way that does not lean on one tool:

```bash
tbrun "cd <repo> && bash tb/run_seq_vec.sh 8300000"
```

`tb/tb_seq_vec_vhdl.vhd` runs the **VHDL under GHDL**;
`tb/tb_seq_vec.v` runs **`src/adau1978_sequencer.v` under Icarus**. Both drive
the identical stimulus - the same 32-bit LFSR, advanced once per clock, feeding
`i2c_busy`, `i2c_ack_error`, `i2c_addr_nack`, `i2c_data_rd`, `udp_req`,
`udp_adc_sel`, `udp_ch_sel` and `udp_gain` - and both write a line whenever any
output changes. The files are diffed.

**8 300 000 cycles, 460 output-change events, identical.** The run is long on
purpose: `BOOT_DELAY_CYCLES` is 7 500 000, so anything shorter only tests the
delay counter. The vectors show the boot traffic starting at cycle 7 500 002
and the register writes to addresses 0x11 through 0x71 that follow.

Two different simulators, two languages, one stimulus. That is a stronger
statement than a single-tool simulation, and it closes the gap the formal
proof left.

One wrinkle worth knowing: GHDL's `to_hstring` writes uppercase hex and
Icarus's `%X` writes lowercase, so the comparison ignores case. Everything else
must match exactly.

### The other checks that still apply

| Module | Check | Result |
| --- | --- | --- |
| `crc32` | golden vectors, `tb/tb_crc32.vhd` | **PASS** |
| `tdm16_merge` | `tb/tb_tdm16_merge_gate.v`: RTL against its sky130 netlist, 3 seeds x 200 frames | **PASS**, 0 mismatches in about 9 700 comparisons |
| `tdm8_rx` | `tb/tb_tdm8_rx_gate.v`: the VHDL, both hand conversions, **`src/tdm8_rx.v`** and the post-route netlist, all in one simulation | **PASS**, about 310 000 comparisons, 0 mismatches on every DUT |
| `async_fifo` | `tb/tb_async_fifo.v`, `tb/tb_fifo_system.v` | **PASS** (Phase 1b) |
| `top_system` | `tb/tb_top_port.vhd`, patches 0001-0003 against the PLL original | **PASS**, 6.4 M samples, 0 mismatches. This checks the *patches*, on the VHDL side |

### crc32, and a detail worth recording

`tb/tb_crc32.vhd` feeds `"123456789"` and gets **`0x649C2FD3`**, the value the
brief names.

For the receive residue the brief names `0xC704DD7B`. The testbench feeds the
message and then its FCS exactly as `rmii_tx` puts it on the wire - each byte
a bit-reversed slice of `crc_out` - and reads back `0x38FB2284` on `crc_out`.
That is the complement of `0xC704DD7B`: **the residue magic number is the
value of the internal register, and `crc_out` is that register inverted**
(`crc_out <= not crc_reg` in `crc32.vhd`). The check compares `not crc_out`
and passes. Anyone re-deriving this from the brief alone will hit the same
thing.

### tdm16_merge

`sim/tb_tdm16.vhd`, which `CLAUDE.md` names for this module, **contains no
`assert` and no `report` at all** - it drives waveforms and nothing else, the
same problem `sim/tb_tdm8_rx.vhd` had in Phase 0. It cannot pass or fail, so it
cannot gate anything.

`tb/tb_tdm16_merge_gate.v` replaces it: the GHDL-converted RTL and the module's
own sky130 netlist (774 cells, 14 020 µm², from `synth/run_module_gate.sh`) run
side by side on random channel data, random frame-pulse widths and gaps, and
resets dropped in at random. Every output compared on every clock.

| Seed | Comparisons | Valid pulses | Mismatches |
| --- | --- | --- | --- |
| 1 | 3 279 | 200 | 0 |
| 2 | 3 110 | 200 | 0 |
| 3 | 3 327 | 200 | 0 |

**Negative control.** One netlist connection moved from `ch_data_A[5]` to
`ch_data_A[6]`: 1 545 mismatches on seed 1, 1 460 on seed 2. The check fails
when it should.

### `sim/tb_chain.vhd` does not pass, and not because of anything we changed

Run under GHDL against the **unmodified** `legacy/rtl` - no ASIC patches, no
converted files anywhere in it - `tb_chain` reports:

```
LRCLK period = 256 BCLKs, high for 4 BCLKs      <- correct, matches tdm8_master
tdm16_valid pulses per frame = 1                <- correct
ch1 got 0xX0X000 want 0xA10000   ... 16 channels
=== CHAIN MISMATCH: 16 failures with G_LAUNCH=1 and the current C_BIT_ADJ ===
```

Its two structural assertions pass. The data comparisons fail, with `X` bits in
the captured channels. What was checked: its framing constants are current
(`SLOTW = 32`, `DATAW = 24`, 256-BCLK frame), its reset is properly pulsed, and
it drives '0' outside the slots rather than leaving the line undriven, so the
obvious explanations are ruled out. Its BCLK is 12.288 MHz, half the current
rate, which changes timing but not the decode.

**Not diagnosed further, and not used as a gate.** It fails on the FPGA's own
sources, so it says nothing about this port. Two possibilities worth a later
hour: the testbench predates something in the current chain, or it has never
been run - `net_pkg.vhd` says "there is no simulator licence on this machine",
and the static assertions in `top_system` were written precisely because the
FPGA project could not simulate. It is **not** evidence of a bug in the
conversion; the chain-level check that does run is
[ports.md](ports.md), the whole patched top against the PLL original, 6.4 M
samples and 0 mismatches.

## Open

- **Two modules are not formally proven**, `tdm8_rx` (105 unproven cells) and
  `adau1978_sequencer` (2). Both are covered by simulation instead, and in the
  sequencer's case by a two-simulator vector comparison, so neither is an open
  risk - but neither is a proof either. Closing them would need a deeper
  induction than the solver managed here.
- **The chip-wide active-low reset saving is not taken.** `tdm8_rx` alone went
  from 15 688 to 13 998 µm² (-11 %) when its port became `rst_n`. The same
  inverter-per-flop cost is in every module here: 1 948 reset flops, so roughly
  2 000 inverters, on the order of 7 500 µm² of a 4.2 mm² chip - about 0.2 %,
  because the decimator's 83 891 unreset flops dominate everything. Taking it
  would mean patching the reset polarity of every module rather than one, for a
  fifth of a percent. **Recommend leaving it** unless the decimator is dropped,
  which would change the ratio completely.
- **Gate-level (netlist) checks** exist for `tdm8_rx`, `tdm16_merge` and
  `async_fifo`. The formal proofs above cover RTL-to-RTL, not RTL-to-netlist;
  the netlist side is covered by LVS and STA in Phase 4.
- **`decimator` is unverified at module level.** It is far too large for the
  solver and has no testbench. It is 95 % of the chip's area, so if anything
  deserves a vector comparison next, it is this.
- **`tb_chain`**, above.
- **The `C_GAIN_PROBE_IDX` warning** in `adau_sequencer` (`to_unsigned(-1, 2)`
  inside a branch guarded by `>= 0`) is printed by every GHDL run. Harmless in
  simulation and in synthesis, but it is a static bounds violation and should
  not be left unexamined if that code is ever enabled.
