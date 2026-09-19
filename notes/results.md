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

## tdm8_rx — post-route, OpenLane run `tdm8rx1`

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
  the netlist matches the RTL. That gate-level check is still deferred, see
  [phase0.md](phase0.md).
