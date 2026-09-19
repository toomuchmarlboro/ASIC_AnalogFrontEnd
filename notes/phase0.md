# Phase 0 — prove the path with `tdm8_rx`

Status: **conversion and verification done, synthesis done, GDSII blocked.**
Date: 2026-09-19.

## What was done

1. `rtl/tdm8_rx.vhd` converted to `src/tdm8_rx.v` (Verilog-2005). Conversion
   notes and the two deliberate deviations: [tdm8_rx.md](tdm8_rx.md).
2. Verified bit-exact against the original VHDL under three stimulus
   configurations, plus a known-pattern check. Results below.
3. Synthesised standalone to sky130_fd_sc_hd with Yosys. Area and cell count
   in [results.md](results.md).
4. OpenLane could not be run on this machine. See *Blocker* below.

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

## Blocker — OpenLane

**Phase 0 cannot finish on this machine as configured.** OpenLane needs Linux:
either Docker (OpenLane 1) or Nix (OpenLane 2), and in both cases the
point-tools — OpenROAD, Magic, KLayout, Netgen — have no Windows builds. On
this machine:

- Docker: not installed.
- WSL: `wsl.exe` is the stub only, no distribution, and the feature install
  needs administrator rights this session does not have.
- The synthesis half of the flow does run natively, which is what produced the
  numbers above, but synthesis is not a GDSII.

Options, in the order I would take them:

1. **Enable WSL2 and install OpenLane 2 inside it.** `wsl --install` from an
   elevated prompt, then a reboot, then a distribution, then Nix. This is the
   path that ends in a GDSII on this laptop and it only needs the user's
   administrator password once.
2. Run the flow on any Linux box or a cloud VM, with `src/` and `config.json`
   copied across.
3. Efabless' hosted flows are gone; do not plan around them.

Until one of those happens, every later phase can still proceed — conversion,
verification and synthesis all run here — but the GDSII, LVS and DRC parts of
the definition of done stay open.

## Deferred

- **Gate-level verification of the synthesised netlist.** Attempted with
  `equiv_make` / `equiv_induct`; Yosys cannot build SAT models for liberty
  blackboxes, so the proof does not complete. A gate-level simulation would
  need the sky130 behavioural cell models, which are a per-cell file set in the
  skywater PDK repo rather than one includable file. Left for the OpenLane run,
  which does its own LVS and STA against the same netlist.
