# ASIC port of UATR_TDM

SKY130 layout of the UATR_TDM receiver, for registering the layout design
(DTLST) with DJKI. It is not going to be fabricated — the GDSII *is* the thing
being registered, so "does it tape out" is not a question anyone needs to
answer here.

The FPGA version is the real product and it is running on hardware right now.
Nothing in this repo touches it. The RTL lives in the `TDM_UATR` repo and is
read-only as far as we're concerned.

## What's here

```
src/        converted Verilog
tb/         testbenches
notes/      everything about why. start at notes/README.md
config*.json  OpenLane configs
```

`config_tdm8_rx.json` is the single-module one for Phase 0.
`config.json` is the full chip and won't work until there's a `top_system` to
point it at.

## Where it's at

Phase 0 is done. `tdm8_rx` is converted, verified against the original VHDL
(0 mismatches), and has been through the full OpenLane flow on the lab server:
GDSII produced, LVS and DRC clean, setup met at 40 ns and hold met in every
corner. Post-route it is 1 822 instances and 19 446 µm² of cells on a
211 x 222 µm die. The synthesised and post-route netlists were both simulated
against the RTL and the VHDL, six cases each, and match.

The first run was bigger, 2 552 instances and 23 259 µm², and had 33 fanout
violations. The reset port was made active-low, the hold margin set to 0 and
CTS clustering tightened; what each change bought and what it cost is in
[notes/phase0.md](notes/phase0.md) and [notes/runs.md](notes/runs.md). One
consequence carries forward: converted modules take an active-low `rst_n`
([notes/decisions.md](notes/decisions.md)).

Phase 1 is done: the PLL is gone, the Altera FIFO is replaced by a 512 x 8
Gray-pointer FIFO of our own, and the three `inout` ports are split. The three
changes live as patches against the vendored FPGA VHDL, each verified against
the original by simulation.

Phase 2 is done: `src/` now holds the whole chip as generated Verilog-2005,
converted from the VHDL in one `ghdl --synth` pass so the top's generic values
are applied. It synthesises on its own to 637 096 cells and 4.21 mm² on
sky130, with no vendor references, and 10 of the 12 checkable modules are
**formally proven** equivalent to the VHDL they came from. The decimator is
about 95 % of the area. Details in [notes/conversion.md](notes/conversion.md).

Phases 1 through 5, and the deadlines, are in [WORKFLOW.md](WORKFLOW.md).

## Running things

Synthesis, on Windows, with the liberty dropped in `pdk/`:

```
yosys -s synth_tdm8_rx.ys
```

The equivalence check, which compiles the original VHDL and the converted
Verilog into one simulation and compares them every BCLK:

```
bash tb/run_tdm8_rx_equiv.sh
```

That one needs ModelSim ASE and a clone of `TDM_UATR` next to this repo. Questa
is also installed on the laptop but its `vsim` wants a licence, so ASE it is.

OpenLane, on the server (rootless Nix, see `notes/environment.md`):

```
cd ~/openlane2 && nix-shell
openlane --run-tag tdm8rx4 <this repo>/config_tdm8_rx.json
```

Gate-level and equivalence check on the server, inside a shell with GHDL and
Icarus (`notes/environment.md`, `tbrun`):

```
bash tb/run_tdm8_rx_gate.sh runs/tdm8rx4/final/nl/tdm8_rx.nl.v
```

## Rules worth knowing before you change anything

No Altera IP anywhere in `src/`. The megafunctions get reimplemented, not
wrapped or stubbed — the ownership declaration says the design is ours and it
has to actually be true.

`C_BIT_ADJ = -1` in `tdm8_rx` was found by measurement on real hardware, not
derived. Leave it alone. Same for the 264-bit and 192-bit widths.

Conversions are meant to be boring. If a module comes out cleaner than the VHDL
did, something got changed that shouldn't have.

The rest is in [CLAUDE.md](CLAUDE.md).

## Notes

Write them as you go. A number with no command next to it is not reproducible,
and if originality ever gets challenged, `notes/provenance.md` — the chain from
our VHDL to the GDSII — is the evidence. That's the whole reason the paperwork
matters more than usual here.
