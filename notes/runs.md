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
and adds a reset-net buffer tree. **Fixed in `tdm8rx3`** by making the reset
port active-low, see below and [decisions.md](decisions.md).

**2. Hold fixing added 447 delay cells** (reduced to 248 in `tdm8rx4`, below). The module is a 255-stage
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
flops. Not a data or reset net. The flow's own checker does not treat it as a
failure. **Fixed in `tdm8rx4`** with `CTS_SINK_CLUSTERING_SIZE`.

### Warnings in the flow log (`runs/tdm8rx1/warning.log`)

- `PNR_SDC_FILE` and `SIGNOFF_SDC_FILE` undefined: OpenLane used its generic
  fallback SDC. Timing numbers therefore assume generic IO delays. Fine for
  Phase 0; the full chip needs a real SDC before timing is quoted.
- `GRT-0097 No global routing found for nets`, `CTS-0041 Net "net288" has 1
  sinks`, `DRT-0349 LEF58_ENCLOSURE ... layer mcon`: all informational in this
  OpenLane/PDK combination.
- `VSRC_LOC_FILES` unset: IR-drop figure (0.111 mV worst) is not meaningful
  for a chip meant for manufacture, and this one is not.

## tdm8rx2 — 2026-09-19 — RTL only: `wire rst_n = ~rst`

Command as `tdm8rx1`, `src/tdm8_rx.v` changed to derive `rst_n = ~rst` and reset
on `negedge rst_n`, config unchanged. **No effect.** Same 1 094 cells, same 451
`inv_2`, same final numbers. Yosys folds the inverter back into the flop
polarity before mapping. Kept for the record, superseded by `tdm8rx3`.

Synthesis-only experiments on the same question, run from the scratchpad with
`openlane --to Yosys.Synthesis` (not retained): `SYNTH_ABC_BUFFERING` off,
`SYNTH_ABC_AREA_USE_NF`, `SYNTH_STRATEGY` `AREA 1`, `AREA 3`, `DELAY 0`. None
removed the inverters. Results in [decisions.md](decisions.md).

## tdm8rx3 — 2026-09-19 — reset port made active-low

`src/tdm8_rx.v` port `rst` becomes `rst_n`, active-low. Config unchanged from
`tdm8rx1`. Outcome: flow complete, LVS 0, DRC 0.

| | `tdm8rx1` | `tdm8rx3` |
| --- | --- | --- |
| Synthesis cells | 1 094 | 644 |
| Synthesis area µm² | 15 687.5 | 13 998.4 |
| Inverters (final) | 450 | 1 |
| Instances (final, incl. tap) | 2 552 | 2 019 |
| Instance area µm² (final) | 23 258.6 | 21 225.4 |
| Die area µm² | 52 005.4 | 46 795.9 |
| Power mW | 1.132 | 1.045 |
| Hold cells | 447 | 448 |
| Max-fanout violations | 33 | 29 |

The area saving is the removed inverters and the reset buffering they needed.
Hold cells and clock-tree fanout are untouched by this change, as expected.

## CTS and hold-margin sweep — 2026-09-19

All on the `tdm8rx3` RTL. Each is `openlane --run-tag <tag> -c KEY=VALUE ...
config_tdm8_rx.json`, ~1.5 min. CS = `CTS_SINK_CLUSTERING_SIZE`, CD =
`CTS_SINK_CLUSTERING_MAX_DIAMETER` (default 50), HM = `PL_RESIZER_HOLD_SLACK_MARGIN`
and `GRT_RESIZER_HOLD_SLACK_MARGIN` together (default 0.1). Every run: LVS 0,
DRC 0 (Magic and KLayout), antenna 0, `design__violations` 0.

| Tag | CS | CD | HM | Instances | Area µm² | Hold cells | Clock bufs | Fanout viol | Hold WS ns |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `tdm8rx3` | 25 | 50 | 0.1 | 2 019 | 21 225.4 | 448 | 52 | 29 | 0.133 |
| `cts10` | 10 | 50 | 0.1 | 2 014 | 21 290.4 | 450 | 63 | 12 | 0.137 |
| `cts8` | 8 | 30 | 0.1 | 2 103 | 22 537.9 | 449 | 121 | 7 | 0.258 |
| `holdm0` | 10 | 50 | 0 | 1 810 | 19 248.5 | 246 | 63 | 12 | 0.014 |
| `hm0_s9d50` | 9 | 50 | 0 | 1 812 | 19 273.5 | 246 | 64 | 4 | 0.019 |
| `hm0_s9d30` | 9 | 30 | 0 | 1 908 | 20 564.7 | 247 | 123 | 7 | 0.011 |
| `hm0_s10d30` | 10 | 30 | 0 | 1 907 | 20 578.5 | 247 | 121 | 7 | 0.011 |
| `hm0_s12d30` | 12 | 30 | 0 | 1 907 | 20 578.5 | 247 | 121 | 7 | 0.011 |
| `hm0_s8d50` | 8 | 50 | 0 | 1 822 | 19 446.2 | 248 | 78 | **0** | 0.011 |
| `hm0_s7d50` | 7 | 50 | 0 | 1 825 | 19 506.2 | 248 | 80 | **0** | 0.015 |
| `hm0_s6d50` | 6 | 50 | 0 | 1 837 | 19 677.6 | 247 | 91 | 5 | 0.010 |

Reading it:

- **Hold cells respond only to the hold margin.** CTS settings leave them at
  about 448. Setting HM to 0 halves them (450 to 246). The default 0.1 ns
  margin is what was buying the other half.
- **Fanout violations are the CTS tree, not the design.** At CS 10 the leaf
  buffers still drove 11 flops against a limit of 10 (`cts10`). At CS 8 the
  leaves were clean, and what remained (`cts8`, CD 30) were the tree's branch
  buffers, each fanning out to 11 to 12 leaf buffers. CS 8 and CS 7 at CD 50
  reach 0. CS 9 and CS 6 do not, so the result is tuned, not structural. CS 7
  passing too gives some margin either side of CS 8.
- **CD 30 costs clock buffers for nothing.** About 120 against 64 to 80, and no
  fanout benefit. `hm0_s12d30` is identical to `hm0_s10d30`: at CD 30 the
  diameter, not the size, sets the cluster.

Chosen: CS 8, CD 50 (default), HM 0. Chosen over CS 7 on 78 against 80 clock
buffers and slightly less area.

## tdm8rx4 — 2026-09-19 — Phase 0 final

`tdm8rx3` RTL with CS 8 and HM 0 written into `config_tdm8_rx.json` (no `-c`
overrides). Reproduces `hm0_s8d50` exactly: same instance count, area, slacks.

| | |
| --- | --- |
| Command | `olrun "cd <repo> && openlane --run-tag tdm8rx4 config_tdm8_rx.json"` |
| Config | `config_tdm8_rx.json`, sha256 `b2b9264a60d7a0fd95a11dd758fa46efed3544d5853a27562c1eee6b7ef9ee75` |
| Source | `src/tdm8_rx.v`, sha256 `f808ffcb82642f8795911b357eb4a8835323d08370ce787ff20b3dfd2fb7cec9` |
| Outcome | Flow complete. Antenna, LVS, DRC all passed |
| GDSII | `runs/tdm8rx4/final/gds/tdm8_rx.gds`, sha256 `ec53171cd29fc46180c66c6c9cc2604e941f03c7564bbb914e3d52ce17967124` |
| Synthesis netlist | `runs/tdm8rx4/06-yosys-synthesis/tdm8_rx.nl.v`, sha256 `253345a8955ca5a565a13de31292c132a0ad0436ef21cdf11f720e1f991f2b1f` |
| Post-route netlist | `runs/tdm8rx4/final/nl/tdm8_rx.nl.v`, sha256 `7636c6792c849583245bd889e0019029540005ae176bb3fca39d4067ecc813fc` |
| Gate-level check | both netlists pass all six cases, see [phase0.md](phase0.md) |

Numbers: [results.md](results.md).

## decflow — 2026-09-19/20 — decimator alone, place-and-route feasibility

Not a design run. The question was whether a block of this size can get through
the back end on this server at all, after the owner chose to keep the decimator
([phase1.md](phase1.md)).

| | |
| --- | --- |
| Command | `olrun "cd <scratch> && nice -n 19 timeout 14400 openlane --to OpenROAD.DetailedRouting --run-tag decflow cfg_decflow.json"` |
| Input | `decimator` alone, GHDL-converted, `SYNTH_STRATEGY "AREA 3"`, 40 ns, `FP_CORE_UTIL` 35 |
| Outcome | **Stopped by the 4-hour limit inside detailed routing.** Everything before it completed |

| Stage | Result |
| --- | --- |
| Synthesis (`AREA 3`) | 7 min 9 s, 596 236 cells, 5.43 mm² cell area. `AREA 0` was still in ABC after 30 min and was abandoned |
| Floorplan | die 15.64 mm², core 15.50 mm², about 3.95 mm square |
| Placement, CTS, global route | all completed |
| Detailed routing | reached, ran 18 min of wall time on its first pass, 136 825 violations still open at the cut-off, 38.5 mm of wire placed |
| Peak memory | **18.7 GB** |

Read carefully: the violation count is from an early routing iteration, where a
high number is normal - detailed routing reduces it over successive passes. It
is **not** evidence that the block cannot route. What the run does establish:

- the decimator gets through synthesis, floorplan, placement, CTS and global
  routing without special handling,
- it needs **more than 4 hours** and **about 19 GB** on this machine, and the
  whole chip is larger,
- `AREA 3` is the only synthesis strategy measured to finish on it.

Next time it needs a longer limit and a quiet machine. The server has 46 GB, so
memory is not yet the binding constraint; wall time is.
