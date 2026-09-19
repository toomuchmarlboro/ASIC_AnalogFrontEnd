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

## Pending

| | |
| --- | --- |
| Post-route area | needs OpenLane |
| Clock frequency | needs STA |
| Power | needs OpenLane |
| LVS / DRC | needs OpenLane |

OpenLane has not been run — see [phase0.md](phase0.md), *Blocker*.
