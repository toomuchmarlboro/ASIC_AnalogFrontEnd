# notes — index

| File | What it is |
| --- | --- |
| [environment.md](environment.md) | Tool versions, per machine. Append, never overwrite |
| [phase0.md](phase0.md) | Phase 0: conversion, verification, synthesis, open blocker |
| [runs.md](runs.md) | One entry per OpenLane run, failures included |
| [results.md](results.md) | Numbers, each traceable to the command that produced it |
| [tdm8_rx.md](tdm8_rx.md) | `tdm8_rx` conversion record — folds into `conversion.md` at Phase 2 |

Not yet written, one per WORKFLOW.md: `provenance.md`, `decisions.md`,
`clocking.md`, `fifo.md`, `ports.md`, `conversion.md`, `integration.md`,
`runs.md`, `drc.md`, `filing.md`.

## Where Phase 0 stands

Done. `tdm8_rx` went through the whole flow on the lab server, run `tdm8rx1`:
GDSII, LVS clean, DRC clean. Details in [phase0.md](phase0.md), numbers in
[results.md](results.md). Open item carried into later phases: gate-level
equivalence of the synthesised netlist to the RTL.

To reproduce, source the environment described in
[environment.md](environment.md) and run:

```bash
olrun "cd <repo> && openlane --run-tag tdm8rx1 config_tdm8_rx.json"
```

Next is Phase 1, which per WORKFLOW.md needs `environment.md` first (now
written) and the vendor IP removal in the `TDM_UATR` repo sources, which are
not yet on this server.
