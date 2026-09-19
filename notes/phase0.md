# Phase 0 — prove the path with `tdm8_rx`

Status: **complete. Conversion, verification, synthesis and the OpenLane back end all done; GDSII produced, LVS and DRC clean.**
Date: 2026-09-19. Back end run on the lab server, run tag `tdm8rx1`.

## What was done

1. `rtl/tdm8_rx.vhd` converted to `src/tdm8_rx.v` (Verilog-2005). Conversion
   notes and the two deliberate deviations: [tdm8_rx.md](tdm8_rx.md).
2. Verified bit-exact against the original VHDL under three stimulus
   configurations, plus a known-pattern check. Results below.
3. Synthesised standalone to sky130_fd_sc_hd with Yosys. Area and cell count
   in [results.md](results.md).
4. OpenLane could not be run on the laptop. Run on the lab server instead:
   GDSII, LVS clean, DRC clean. See *Back end* below.

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

Run `tdm8rx1`, 2026-09-19, `config_tdm8_rx.json` unchanged from the repo.
Full record: [runs.md](runs.md). Numbers: [results.md](results.md). Versions:
[environment.md](environment.md).

Result: 78-stage flow completed with no failures. **GDSII produced. LVS: 0
errors. DRC: 0 (Magic and KLayout both). Antenna: 0. Setup slack +11.86 ns at
40 ns, hold +0.133 ns.** Die 222.75 x 233.47 µm, 23 259 µm² of cells, 2 552
instances including tap cells.

What this retires: the risk that the back end was unproven. The design routes,
the power grid is complete, and LVS closes. It was the open item for the 1
October gate, and it closed on 19 September.

What Phase 0 changed in the expectations:

- **Area is about 1.7 x the synthesis number.** 13 433 µm² standalone, 15 688
  µm² in OpenLane's own synthesis, 23 259 µm² final. The growth is 447 hold
  delay cells on the shift register and clock and reset buffering. Anything
  scaled from the standalone synthesis figure should use the final layout
  ratio instead. The earlier statement that a 16-channel system fits well
  inside 1 mm² still holds by a wide margin: the cell area of two of these is about 0.05 mm².
- **OpenLane synthesis puts an inverter on `rst` per flop** (450), which the
  standalone script had merged. Function is unchanged, area is not. Left alone
  under the no-restructure rule. See [runs.md](runs.md).
- **The `tdm8rx1` config needed no relaxation.** No utilisation or clock
  changes were required, so no entry in `decisions.md` for this run.

## Server setup

The server had no Nix and no Docker access for this account. The toolchain was
installed rootless with `nix-portable`. Steps and cost in
[environment.md](environment.md).

## Deferred

- **Gate-level verification of the synthesised netlist.** Attempted with
  `equiv_make` / `equiv_induct`; Yosys cannot build SAT models for liberty
  blackboxes, so the proof does not complete. A gate-level simulation would
  need the sky130 behavioural cell models, which are a per-cell file set in the
  skywater PDK repo rather than one includable file. **Still open after the
  OpenLane run.** LVS shows the layout matches the synthesised netlist and STA
  checks timing, but neither proves the netlist equals the RTL. The PDK is now
  on the server, so this can be done with the cell models under
  `~/.volare/volare/sky130/versions/0fe599b2.../sky130A/libs.ref/sky130_fd_sc_hd/verilog/`.
  Icarus is not yet installed there.
