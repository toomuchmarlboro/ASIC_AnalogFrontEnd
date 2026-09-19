# notes — index

| File | What it is |
| --- | --- |
| [environment.md](environment.md) | Tool versions, per machine. Append, never overwrite |
| [phase0.md](phase0.md) | Phase 0: conversion, verification, synthesis, open blocker |
| [results.md](results.md) | Numbers, each traceable to the command that produced it |
| [tdm8_rx.md](tdm8_rx.md) | `tdm8_rx` conversion record — folds into `conversion.md` at Phase 2 |

Not yet written, one per WORKFLOW.md: `provenance.md`, `decisions.md`,
`clocking.md`, `fifo.md`, `ports.md`, `conversion.md`, `integration.md`,
`runs.md`, `drc.md`, `filing.md`.

## Where Phase 0 stands

Front end done on Windows: converted, verified bit-exact against the VHDL,
synthesised to sky130. Back end — OpenLane, OpenROAD, Magic, Netgen — not yet
run. That is the next thing, and it runs on the server.

To continue Phase 0 there:

```bash
cd ~/openlane2 && nix-shell
openlane --run-tag tdm8rx1 <repo>/config_tdm8_rx.json
```

`config_tdm8_rx.json` is the Phase 0 single-module config. `config.json` is the
Phase 4 full-stack one and will not run until `top_system` exists.

Record the run in `runs.md`, then close out `phase0.md` and `results.md` with
post-route area, cell count, timing, power, LVS and DRC.
