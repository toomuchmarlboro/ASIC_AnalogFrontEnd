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

Phase 0, half done. `tdm8_rx` is converted, verified against the original VHDL
(0 mismatches, three different stimulus configs), and synthesises to 644 cells
and 13 433 µm² on sky130. Reasonable for what it is — 84 % of that area is
flip-flops, because the module is a 264-bit shift register and a 192-bit latch
and not much else.

What hasn't happened yet is the back end. No place and route, no GDSII, no LVS,
no DRC. That needs OpenLane, OpenLane needs Linux, and the laptop has no WSL
and no Docker. So it moves to the lab server. Until that run happens we don't
actually know the design routes, and clean synthesis is not evidence that it
does.

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

OpenLane, on the server:

```
cd ~/openlane2 && nix-shell
openlane --run-tag tdm8rx1 <this repo>/config_tdm8_rx.json
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
