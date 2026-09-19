# Phase 0 — prove the path with `tdm8_rx`

Status: **complete. Conversion, verification, synthesis and the OpenLane back end all done; GDSII produced, LVS and DRC clean, gate-level netlist verified.**
Date: 2026-09-19. Back end run on the lab server; final run `tdm8rx4`.

## What was done

1. `rtl/tdm8_rx.vhd` converted to `src/tdm8_rx.v` (Verilog-2005). Conversion
   notes and the two deliberate deviations: [tdm8_rx.md](tdm8_rx.md).
2. Verified bit-exact against the original VHDL under three stimulus
   configurations, plus a known-pattern check. Results below.
3. Synthesised standalone to sky130_fd_sc_hd with Yosys. Area and cell count
   in [results.md](results.md).
4. OpenLane could not be run on the laptop. Run on the lab server instead:
   GDSII, LVS clean, DRC clean. See *Back end* below.
5. Reset port made active-low, and the synthesised and post-route netlists
   simulated against the RTL and the VHDL. See *Netlist-to-RTL check* below.

## Verification

The check runs the unmodified `rtl/tdm8_rx.vhd` and the converted
`src/tdm8_rx.v` side by side in one simulation, both fed from the same
`tdm8_master` and the same SDATA stream, and compares the 192-bit output one
nanosecond after every rising BCLK edge. `tb/tb_tdm8_rx_equiv.vhd`, run by
`tb/run_tdm8_rx_equiv.sh`.

This is stronger than running `sim/tb_tdm8_rx.vhd` against the conversion,
because that testbench contains no assertions at all — it drives three frames
and stops. Its stimulus is reused verbatim as one of the three cases.

| Case | Slot | Launch offset | Comparisons | Mismatches | Pattern |
| --- | --- | --- | --- | --- | --- |
| As built | 32 BCLKs | +1 BCLK | 1542 | 0 | exact |
| Legacy launch model | 32 BCLKs | 0 | 1542 | 0 | one bit off |
| `sim/tb_tdm8_rx.vhd` stimulus | 24 BCLKs | 0 | 966 | 0 | misaligned |

**Equivalence: 0 mismatches in all three cases.** That is the requirement, and
it is met.

### On the pattern column

The testbench in `sim/` predates the current configuration. It sends eight
contiguous 24-bit slots at 18.432 MHz; the RTL decodes eight 32-BCLK slots out
of a 256-BCLK frame, which is what `tdm8_master` generates and what the
ADAU1978 is configured for. The two disagree about the frame, so the legacy
stimulus cannot produce the expected channel values from *either* the VHDL or
the Verilog — case 3 above shows both returning the same wrong answer.

Case 1 is the same testbench with the framing the RTL is actually built for:
32-BCLK slots and the ADC framing one BCLK after the LRCLK rise, which is the
launch offset `C_BIT_ADJ = -1` encodes since `tdm8_master` moved LRCLK to the
falling edge of BCLK. There the decode is exact: `A1A1A1`, `B2B2B2`, … ,
`181818` on channels 1 to 8.

So case 1 independently confirms `C_BIT_ADJ = -1` is the right value for the
current `tdm8_master`, by construction rather than by measurement. It was not
changed and must not be.

Case 2 is the same framing with the old launch model, and it decodes one bit
early — every channel is its expected value shifted left by one
(`A1A1A1` → `434342`). That is exactly the relationship the constant describes.

## Synthesis

Standalone Yosys run, `synth_tdm8_rx.ys`, `sky130_fd_sc_hd` at tt/25C/1.80V,
`abc -D 40000` (the 40 ns period from `config.json`). Numbers in
[results.md](results.md).

`sky130_fd_sc_hd__lpflow_*` is excluded from the cell choice, as OpenLane does.
Without the exclusion ABC picks `lpflow_isobufsrc_1` for one buffer; it is a
power-gating cell, it carries no logic function in the liberty, and it has no
business in a design with one power domain.

## Back end — OpenLane on the lab server

Final run `tdm8rx4`, 2026-09-19. Full record of all fourteen runs and the sweep:
[runs.md](runs.md). Numbers: [results.md](results.md). Versions:
[environment.md](environment.md).

Result: flow completed, no failures. **GDSII produced. LVS: 0 errors. DRC: 0
(Magic and KLayout). Antenna: 0. Fanout, slew, cap violations: 0. Setup slack
+11.70 ns at 40 ns, hold +0.011 ns.** Die 211.03 x 221.75 µm, 19 446 µm² of
cells, 1 822 instances including tap cells.

What this retires: the risk that the back end was unproven. The design routes,
the power grid is complete, and LVS closes. It was the open item for the 1
October gate, and it closed on 19 September.

### What the first run turned up, and what was done about it

The first run (`tdm8rx1`) completed clean but showed three things the
standalone synthesis had not. All three were dealt with the same day, on the
project owner's instruction that restructuring is fine.

| Finding in `tdm8rx1` | Cause | Fix | Effect |
| --- | --- | --- | --- |
| 450 inverters on the reset | sky130 has only an active-low reset flop; OpenLane's `dfflegalize` puts one inverter per flop and never merges them | Reset port made active-low, `rst_n` | Instances 2 552 to 2 019, area 23 259 to 21 225 µm² |
| 447 hold delay cells | Shift register: flop-to-flop paths shorter than the clock skew, plus a default 0.1 ns hold margin | `PL_` and `GRT_RESIZER_HOLD_SLACK_MARGIN` 0.1 to 0 | Hold cells 450 to 248, area to about 19 250 µm². **Hold slack is only +11 ps** |
| 33 max-fanout violations | CTS buffers driving 14 to 17 sinks against a limit of 10 | `CTS_SINK_CLUSTERING_SIZE` 25 to 8 | 0 violations, +200 µm² of clock buffers |

Net, `tdm8rx1` to `tdm8rx4`: cell area -16.4 %, instances -28.6 %, die area
-10.0 %, power -4.7 %.

The reset change needed two attempts. The obvious edit, `wire rst_n = ~rst`,
did nothing (`tdm8rx2`): Yosys folds the inverter back into the flop polarity.
Only an active-low *port* works. That is a convention for the rest of the
port, not just this module: [decisions.md](decisions.md).

The hold margin is a real relaxation, not a free win. With margin 0 every
corner meets hold with 11 ps to spare. That is fine for a layout that is
registered and not fabricated, and it is written down as such.

## Netlist-to-RTL check

LVS proves the layout matches the netlist. It does not prove the netlist
matches the RTL, and the ModelSim equivalence run on the laptop compared VHDL
to Verilog only. This closes that gap and repeats the VHDL check on the
server, where ModelSim is not available.

`tb/tb_tdm8_rx_gate.v`, run by `tb/run_tdm8_rx_gate.sh <netlist.v>` inside a
shell with GHDL and Icarus (`tbrun`, see [environment.md](environment.md)).
One stimulus into four implementations, compared 1 ns after every rising BCLK
and 1 ns after every reset assertion:

| Name | What it is |
| --- | --- |
| `ref` | `legacy/rtl/tdm8_rx.vhd` through `ghdl --synth --out=verilog`. Keeps the VHDL initial values |
| `v1` | `src/tdm8_rx.v` as first verified on the laptop, `git show 39e609a:src/tdm8_rx.v`, active-high `rst` |
| `rtl` | `src/tdm8_rx.v` now, active-low `rst_n` |
| `gate` | the netlist under test, on the sky130 functional cell models from the PDK |

`tdm8_master` is also GHDL-converted from `legacy/rtl`, so the clocks come from
the original VHDL. BCLK is 24.576 MHz.

Six cases. The first three are the laptop's, with the same framing and launch
offsets. Three more are new: 400 frames of random serial data each, with an
asynchronous reset dropped in at a random moment about one frame in eight
(50, 51 and 60 resets), about 103 000 comparisons per case. The last three are
where the bulk of the coverage comes from, see the negative control below.

Result on both netlists of `tdm8rx4`, the synthesised one
(`06-yosys-synthesis/tdm8_rx.nl.v`) and the post-route one
(`final/nl/tdm8_rx.nl.v`, including clock tree and hold cells):

| Case | Comparisons | Mismatches v1 / rtl / gate |
| --- | --- | --- |
| slot 32, launch 1, known pattern | 1 031 | 0 / 0 / 0, pattern exact on all 8 channels |
| slot 32, launch 0 | 1 031 | 0 / 0 / 0 |
| slot 24, launch 0 | 967 | 0 / 0 / 0 |
| random, seed 1 | 102 936 | 0 / 0 / 0 |
| random, seed 2 | 102 940 | 0 / 0 / 0 |
| random, seed 3 | 103 044 | 0 / 0 / 0 |

`ALL CASES PASS` for both netlists. That covers three claims: the VHDL and the
Verilog agree on the server as well as on the laptop, the active-low change
did not alter behaviour (`v1` against `rtl`), and the synthesised and routed
netlists compute what the RTL computes.

**Negative control.** A test that cannot fail proves nothing. One `mux2_1`
input in the synthesised netlist, `\shift_reg[7]` on an `A1` pin, was rewired
to `\shift_reg[8]` (scratchpad copy `mutant.nl.v`). The three structured cases
still passed: the mutated bit is channel 8's LSB, and the test pattern `181818`
has its two lowest bits both 0, so swapping them changes nothing. The
random cases failed at once: 45 045 mismatches in seed 1. So the structured
cases alone would have missed this, and the random cases are what carry the
check.

**Limits.** Zero-delay simulation. It shows the netlists are functionally
equal to the RTL. It does not check hold timing across the clock tree; that is
STA's job and the flow reports hold met in all nine corners. One condition
carries over from the conversion notes: SDATA is held low while reset is
asserted, because the VHDL's `sdata_f` has no reset and ours does
([tdm8_rx.md](tdm8_rx.md), deviation 1). The original ModelSim testbench
`tb/tb_tdm8_rx_equiv.vhd` was edited for the `rst_n` port (an inverted `rst`
signal) and **has not been re-run**, since ModelSim is on the laptop. The
server check above supersedes it in coverage, but re-running it there would
keep the two chains consistent.

## Server setup

The server had no Nix and no Docker access for this account. The toolchain was
installed rootless with `nix-portable`. Steps and cost in
[environment.md](environment.md).

## Deferred

Nothing from Phase 0. The gate-level check that was listed here was done, see
*Netlist-to-RTL check*.
