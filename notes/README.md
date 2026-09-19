# notes — index

| File | What it is |
| --- | --- |
| [environment.md](environment.md) | Tool versions, per machine. Append, never overwrite |
| [phase0.md](phase0.md) | Phase 0: conversion, verification, synthesis, open blocker |
| [runs.md](runs.md) | One entry per OpenLane run, failures included |
| [phase1.md](phase1.md) | Phase 1: what is built, what disagrees with the brief, the decimator finding |
| [fifo.md](fifo.md) | The CDC FIFO: megafunction as read, depth chosen by measurement, verification |
| [clocking.md](clocking.md) | PLL removal, external 24.576 MHz clock, three domains, reset |
| [ports.md](ports.md) | Tristate split, three `inout`s, top-level port changes |
| [waveforms.md](waveforms.md) | Every figure in `figures/`, what it shows, how to regenerate it |
| [decisions.md](decisions.md) | Non-obvious choices, with alternatives and cost |
| [results.md](results.md) | Numbers, each traceable to the command that produced it |
| [tdm8_rx.md](tdm8_rx.md) | `tdm8_rx` conversion record — folds into `conversion.md` at Phase 2 |

Not yet written, one per WORKFLOW.md: `provenance.md`, `conversion.md`,
`integration.md`, `drc.md`, `filing.md`.

## Where Phase 0 stands

Done. `tdm8_rx` went through the whole flow on the lab server. Final run
`tdm8rx4`: GDSII, LVS clean, DRC clean, 0 fanout violations, and both the
synthesised and the post-route netlist verified against the RTL. Details in
[phase0.md](phase0.md), numbers in [results.md](results.md).

Things a later phase inherits: converted modules take an active-low `rst_n`
(see [decisions.md](decisions.md)); the hold margin is 0, so hold slack is thin
(+11 ps); the CTS cluster size is tuned to this one design.

To reproduce, source the environment described in
[environment.md](environment.md) and run:

```bash
olrun "cd <repo> && openlane --run-tag tdm8rx4 config_tdm8_rx.json"
tbrun "cd <repo> && bash tb/run_tdm8_rx_gate.sh <repo>/runs/tdm8rx4/final/nl/tdm8_rx.nl.v"
```

Next is Phase 1. It needs the `TDM_UATR` sources for `top_system` and the FIFO
megafunction parameters, which are not on this server; `legacy/` has the RTL
but deliberately not `ip/`.
