# Results

## tdm8_rx — synthesis, sky130_fd_sc_hd

Yosys 0.69, `synth_tdm8_rx.ys`, liberty `sky130_fd_sc_hd__tt_025C_1v80`,
`abc -D 40000`. Standalone module, no floorplan, no place and route.

| | |
| --- | --- |
| Cells | 644 |
| Cell area | 13 432.88 µm² (0.0134 mm²) |
| Sequential area | 11 260.80 µm² — 83.8 % |
| Flip-flops | 450 |

| Cell | Count | Area µm² |
| --- | --- | --- |
| `dfrtp_1` (posedge, async reset) | 449 | 11 235.78 |
| `dfrtn_1` (negedge, async reset) | 1 | 25.02 |
| `mux2_1` | 192 | 2 161.92 |
| `clkinv_1` | 1 | 3.75 |
| `nor2b_1` | 1 | 6.26 |

### Reading the numbers

The module is a shift register and a latch, and the area says so — 84 % of it
is flip-flops, and the combinational logic is five cells.

450 flops is the expected count, exactly: 255 of the 264 `shift_reg` bits, all
192 `ch_data_out` bits, `lrclk_d`, `lrclk_d2` and `sdata_f`. The nine missing
shift register bits are `shift_reg[263:255]`, which nothing reads — the
highest bit any slice touches is `255 + C_BIT_ADJ` = 254. They are dead in the
VHDL too; Quartus will have dropped them as well. Nothing to fix, and the
width must stay 264 as written.

The 192 `mux2_1` are the capture enable on the output latch: sky130 has an
enable flop (`edfxtp`) and a reset flop (`dfrtp`) but none with both, so the
enable becomes a feedback mux per bit. That is 2 162 µm², 16 % of the module,
and it is the price of the async reset on the output register.

The single `dfrtn_1` is `sdata_f`, the falling-edge input register.

At `FP_CORE_UTIL = 35` from `config.json` the core would land near
38 000 µm², about 195 µm square. For scale, that leaves a 16-channel system —
two of these plus `tdm16_merge` and `packet_formatter` — comfortably inside a
1 mm² die, which is the useful thing Phase 0 was supposed to establish.

Timing was not closed: `abc` was given the 40 ns target and the logic depth is
one mux, so there is nothing to close. Real numbers need STA after routing.

## tdm8_rx — post-route, OpenLane run `tdm8rx4` — current

OpenLane 2.3.10, sky130A, `config_tdm8_rx.json` as in the repo, `src/tdm8_rx.v`
with the active-low `rst_n` port. Every number is from
`runs/tdm8rx4/final/metrics.json` unless a command is given. Run record and
hashes: [runs.md](runs.md).

| | |
| --- | --- |
| Die | 211.03 x 221.75 µm, 46 795.9 µm² (`design__die__bbox`, `design__die__area`) |
| Core | 39 640.5 µm² (`design__core__area`) |
| Instance area | 19 446.2 µm² (`design__instance__area`), includes tap cells |
| Instances | 1 822, of which 562 tap cells and 1 260 logic and buffer cells. Fill and decap not counted (2 513) |
| Utilisation | 49.1 % (`design__instance__utilization`) |
| Wirelength | 26 976 µm (`route__wirelength`) |
| Power | 1.08 mW total: 0.82 internal, 0.26 switching. OpenLane default activity, not a measured workload (`power__total`) |
| Setup slack | +11.70 ns worst over all corners at `CLOCK_PERIOD` 40 ns. TNS 0 |
| Hold slack | +0.011 ns worst over all corners. TNS 0. **Thin by construction**, see below |
| Implied max clock | about 35 MHz on `bclk_in` (1 / (40 - 11.70) ns). Derived, generic SDC |
| Design frequency | 24.576 MHz BCLK (96 kHz x 256 BCLK/frame) |
| DRC | 0 (Magic `magic__drc_error__count`, KLayout `klayout__drc_error__count`, `route__drc_errors`) |
| LVS | 0 errors, 0 unmatched nets (`design__lvs_*`) |
| Antenna | 0 violating nets |
| Power grid | 0 violations on VPWR and VGND |
| Magic vs KLayout GDS XOR | 0 differences |
| Fanout, slew, cap | **0 violations** in all three (was 33 fanout in `tdm8rx1`) |
| `design__violations` | 0 |
| GDSII | `runs/tdm8rx4/final/gds/tdm8_rx.gds`, sha256 `ec53171cd29fc46180c66c6c9cc2604e941f03c7564bbb914e3d52ce17967124` |

Post-route cell mix, from `52-odb-cellfrequencytables/cell.rpt`: 450
`dfrtp_1`, 192 `mux2_1`, 1 `inv_2`, 248 `dlygate4sd3_1` (hold fixing), 208
`buf_2`, 78 clock-tree buffers (`clkbuf_*`), 562 tap cells.

### Where the area went, `tdm8rx1` to `tdm8rx4`

| | `tdm8rx1` | `tdm8rx4` | Change |
| --- | --- | --- | --- |
| Synthesis cells | 1 094 | 644 | active-low reset port |
| Synthesis area µm² | 15 687.5 | 13 998.4 | -10.8 % |
| Instance area µm² (final) | 23 258.6 | 19 446.2 | -16.4 % |
| Instances (final) | 2 552 | 1 822 | -28.6 % |
| Die area µm² | 52 005.4 | 46 795.9 | -10.0 % |
| Hold cells | 447 | 248 | hold margin 0.1 to 0 ns |
| Max-fanout violations | 33 | 0 | `CTS_SINK_CLUSTERING_SIZE` 25 to 8 |
| Power mW | 1.132 | 1.079 | -4.7 % |

Which change did what, from the sweep in [runs.md](runs.md): the `rst_n` port
(`tdm8rx3`) took instance area 23 259 to 21 225 µm². Hold margin 0 took it to
about 19 250. CTS cluster size 8 added back about 200 µm² of clock buffers and
removed all fanout violations.

### Choices this result depends on

- **Hold margin 0.** OpenLane's default keeps 0.1 ns of extra hold slack. It
  is set to 0 in `config_tdm8_rx.json`, so every corner meets hold with only
  11 ps to spare. Right for a layout that is registered and not fabricated;
  wrong for anything that will run. Entry in [decisions.md](decisions.md).
- **Cluster size 8 is tuned.** Sizes 7 and 8 reach 0 fanout violations; 6 and 9
  do not. A different design will need its own value.

### Synthesis versus final

| Stage | Cells | Area µm² | Source |
| --- | --- | --- | --- |
| Standalone Yosys 0.69 | 644 | 13 432.88 | `synth_tdm8_rx.ys`, above |
| OpenLane Yosys 0.46 | 644 | 13 998.43 | `runs/tdm8rx4/06-yosys-synthesis/reports/stat.rpt` |
| Final layout | 1 822 | 19 446.2 | `metrics.json` |

Cell counts now agree with the standalone run. The area difference is
`dfrtp_2` in OpenLane against `dfrtp_1` standalone; the resizer downsizes to
`dfrtp_1` later. Use the OpenLane numbers for anything quoted as this flow's
result.

### Caveats

- Timing used OpenLane's generic fallback SDC, no `PNR_SDC_FILE` given.
- Power is at default switching activity.
- The gate-level check is zero-delay. It shows the netlists compute what the
  RTL computes; hold timing rests on STA, not on that simulation.

---

## tdm8_rx — post-route, first run `tdm8rx1` (superseded)

Historical. Active-high reset port, default CTS and hold margin. Current
result is `tdm8rx4` above.

OpenLane 2.3.10, sky130A, `config_tdm8_rx.json`. Every number is from
`runs/tdm8rx1/final/metrics.json` unless a command is given. Run record:
[runs.md](runs.md).

| | |
| --- | --- |
| Die | 222.75 x 233.47 µm, 52 005.4 µm² (`design__die__bbox`, `design__die__area`) |
| Core | 44 317.5 µm² (`design__core__area`) |
| Instance area | 23 258.6 µm² (`design__instance__area`), includes tap cells |
| Instances | 2 552, of which 632 tap cells and 1 920 logic and buffer cells. Fill and decap are not counted (2 844 fill/decap instances) |
| Utilisation | 52.5 % (`design__instance__utilization`) |
| Wirelength | 31 783 µm (`route__wirelength`) |
| Power | 1.13 mW total: 0.83 internal, 0.30 switching, leakage negligible. OpenLane default activity, not a measured workload (`power__total`) |
| Setup slack | +11.86 ns worst over all corners, at `CLOCK_PERIOD` 40 ns. TNS 0 |
| Hold slack | +0.133 ns worst over all corners. TNS 0 |
| Implied max clock | about 35 MHz on `bclk_in` (1 / (40 - 11.86) ns). Derived, generic SDC |
| Design frequency | 24.576 MHz BCLK (96 kHz x 256 BCLK/frame), so the 40 ns target is about right |
| DRC | 0 (Magic `magic__drc_error__count`, KLayout `klayout__drc_error__count`, `route__drc_errors`) |
| LVS | 0 errors, 0 unmatched nets, 0 unmatched devices (`design__lvs_*`) |
| Antenna | 0 violating nets and pins |
| Power grid | 0 violations on VPWR and VGND |
| Magic vs KLayout GDS XOR | 0 differences (`design__xor_difference__count`) |
| Fanout | 33 max-fanout violations, all on CTS buffers. Slew and cap: 0. See [runs.md](runs.md) |
| GDSII | `runs/tdm8rx1/final/gds/tdm8_rx.gds`, sha256 `4a02cbb6ab1e18258fb4948b6135db8272b8f575b1921fba71b4ae5e42540268` |

Post-route cell mix, from `52-odb-cellfrequencytables/cell.rpt`: 450
`dfrtp_1`, 192 `mux2_1`, 451 `inv_2`, 447 `dlygate4sd3_1` (hold fixing),
about 350 clock-tree and other buffers, 632 tap cells.

### Synthesis versus final

| Stage | Cells | Area µm² | Source |
| --- | --- | --- | --- |
| Standalone Yosys 0.69 | 644 | 13 432.88 | `synth_tdm8_rx.ys`, above |
| OpenLane Yosys 0.46 | 1 094 | 15 687.55 | `runs/tdm8rx1/06-yosys-synthesis/reports/stat.rpt` |
| Final layout | 2 552 | 23 258.6 | `metrics.json` |

Use the OpenLane numbers, not the standalone ones, for anything quoted as
this flow's result. Why they differ: [runs.md](runs.md), `tdm8rx1`.

### Caveats

- Timing used OpenLane's generic fallback SDC, no `PNR_SDC_FILE` given.
- The power figure is at default switching activity.
- LVS proves the layout matches the synthesised netlist. It does not prove
  the netlist matches the RTL. That gate-level check was done afterwards, on
  the `tdm8rx4` netlists: [phase0.md](phase0.md).
