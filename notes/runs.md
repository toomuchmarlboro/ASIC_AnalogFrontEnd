# runs — one entry per OpenLane run

Never delete a failed run. Newest last.

## tdm8rx1 — 2026-09-19 — Phase 0, first back-end run

| | |
| --- | --- |
| Command | `olrun "cd <repo> && openlane --run-tag tdm8rx1 config_tdm8_rx.json"` (`olrun` defined in [environment.md](environment.md)) |
| Config | `config_tdm8_rx.json`, sha256 `263c28ed47ce0073982143eecf92f0a566a8132d20e4e52d03ebdc125c0c9230` |
| Source | `src/tdm8_rx.v`, sha256 `fa7181d14ffd2d8b27f86043730ab28f5261a8c715235729f512e13d4e1e80f9` |
| Config change vs previous run | none, first run |
| Tools | OpenLane 2.3.10 `a7b0e6d`, PDK sky130A `0fe599b2`, see [environment.md](environment.md) |
| Outcome | **Flow complete, 78 stages, no failures. GDSII produced.** Wall time about 1 min 39 s |
| GDSII | `runs/tdm8rx1/final/gds/tdm8_rx.gds`, 3 426 552 bytes, sha256 `4a02cbb6ab1e18258fb4948b6135db8272b8f575b1921fba71b4ae5e42540268` |
| Manufacturability report | Antenna passed, LVS passed, DRC passed (`74-misc-reportmanufacturability`) |

`runs/` is gitignored. The run directory stays on the server; the hash above
identifies the GDSII.

Key numbers, all from `runs/tdm8rx1/final/metrics.json`, tabulated in
[results.md](results.md).

### Things this run showed that the Windows synthesis did not

**1. OpenLane's synthesis is bigger than the standalone one.** Same RTL, same
liberty family:

| | Standalone Yosys 0.69 (`synth_tdm8_rx.ys`) | OpenLane Yosys 0.46, `AREA 0` |
| --- | --- | --- |
| Cells | 644 | 1 094 |
| Area | 13 432.88 µm² | 15 687.55 µm² |
| `inv_2` / inverters | 1 | 451 |

Cause, read from `06-yosys-synthesis/tdm8_rx.nl.v`: the reset input `rst` is
active-high and the sky130 flop `dfrtp` has an active-low `RESET_B`. OpenLane's
netlist gets one `inv_2` on `rst` **per flop**, 450 of them, plus one on
`bclk_in`. The standalone script ran `opt_merge` after `abc`, which collapsed
them to one. Function is unaffected. It costs roughly 450 x 3.75 µm² of area
and adds a reset-net buffer tree. Not fixed: changing reset
polarity is a restructure, and `CLAUDE.md` says note it and move on.

**2. Hold fixing added 447 delay cells.** The module is a 255-stage
flop-to-flop shift register, so every stage is a direct Q-to-D path. With CTS
skew (worst hold skew about -0.28 ns) those paths violate hold, and the
resizer inserted 447 `dlygate4sd3_1`. That is the largest single growth item
between synthesis and the final layout. Final hold slack is +0.133 ns, no
violations.

**3. Utilisation ended at 52 %, not 35 %.** `FP_CORE_UTIL 35` sizes the core
from the synthesised area (15 688 / 0.35 is about 44 800 µm², core is 44 317.5
µm²). Buffers, hold cells and tap cells added afterwards took instance area to
23 258.6 µm². That is expected behaviour, not a config error.

**4. 33 max-fanout violations, all on the clock tree.** `metrics.json` has
`design__max_fanout_violation__count = 33` in every corner, while
`design__violations` is 0 and the checker passes. Slew and capacitance
violations are both 0. Read from
`54-openroad-stapostpnr/nom_tt_025C_1v80/checks.rpt`: every violating pin is a
CTS buffer (`clkbuf_leaf_*_bclk_in`, `clkbuf_*__f_bclk_in`) driving 14 to 17
flops against a limit of 10. It is a consequence of one clock net feeding 450
flops. Not a data or reset net. Left as is; the flow's own checker does not
treat it as a failure and it does not affect LVS or DRC.

### Warnings in the flow log (`runs/tdm8rx1/warning.log`)

- `PNR_SDC_FILE` and `SIGNOFF_SDC_FILE` undefined: OpenLane used its generic
  fallback SDC. Timing numbers therefore assume generic IO delays. Fine for
  Phase 0; the full chip needs a real SDC before timing is quoted.
- `GRT-0097 No global routing found for nets`, `CTS-0041 Net "net288" has 1
  sinks`, `DRT-0349 LEF58_ENCLOSURE ... layer mcon`: all informational in this
  OpenLane/PDK combination.
- `VSRC_LOC_FILES` unset: IR-drop figure (0.111 mV worst) is not meaningful
  for a chip meant for manufacture, and this one is not.
