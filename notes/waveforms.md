# waveforms — figures for reports

All figures are in `figures/`, JPEG, regenerated from the testbenches and the
recorded numbers. Nothing in them is drawn by hand.

## How to regenerate

```bash
# waveforms: runs the testbenches with a VCD dump, then renders (about 4 min)
tbrun "cd <repo> && PY=$HOME/tools/wave-venv/bin/python bash tb/make_waveforms.sh"
# charts of measured results (seconds)
~/tools/wave-venv/bin/python tb/plots.py
```

`tbrun` and the venv are in [environment.md](environment.md).

## The tools

- **`tb/wave2jpeg.py`** draws a VCD as a ModelSim-style wave window: black
  background, green traces, buses as hex segments with their value, X in red,
  Z in blue, divider rows, cursors, and an `analog` display for counts such as
  FIFO occupancy. Signal lists are plain text in `tb/waves/*.txt` (path, label,
  radix). Works on VCDs from Icarus and from GHDL.
- **VCD dumps are off by default.** The Verilog testbenches take `+vcd=<file>`
  and `+vcd_until=<n>` (n in that file's time unit), so pass/fail runs are
  unchanged. The GHDL bench takes `VCD=<file>` in `run_top_port.sh` and dumps
  only the signals in `tb/waves/top_port.opt`, because a full dump of the top
  level is gigabytes.
- **`tb/plots.py`** draws the charts. Every number in it is copied from a note
  that names the run or command behind it, with the source next to the data.
  Light theme, colours from the reference palette, checked with the palette
  validator (both series slots pass every check on the light surface).

## Waveforms

| Figure | Testbench | What it shows |
| --- | --- | --- |
| `tdm8_rx_overview.jpg` | `tb_tdm8_rx_gate`, pattern case, `tdm8rx4` post-route netlist | three frames; the VHDL, RTL and gate outputs latch the same `A1A1A1 .. 181818` |
| `tdm8_rx_capture_zoom.jpg` | same | the frame boundary: LRCLK rise at 21 036.7 ns, `lrclk_d` / `lrclk_d2` edge detect, latch update at 21 097.8 ns, `sdata` launched on the falling BCLK edge |
| `fifo_fill_drain.jpg` | `tb_async_fifo`, depth 8, first 5 µs | fill past full (extra writes ignored), drain past empty |
| `fifo_fill_zoom.jpg` | same | one Gray bit per write; `wrfull` at `wgray = 1100` against `rgray_sync = 0000` |
| `fifo_drain_zoom.jpg` | same | `q` one `rdclk` after `rdreq`; `rdempty` at `rgray = wgray_sync`; `wrfull` clears after the synchroniser |
| `fifo_system_overview.jpg` | `tb_fifo_system`, depth 512, 96 kHz, 7 µs stall | three packets through the real formatter and UDP core; occupancy peaks at 464 and never drains to 0, because the next packet's frames arrive while one is sent |
| `fifo_system_packet_start.jpg` | same | `packet_ready` toggle, the 7 µs grant stall, 42 header bytes, then the first FIFO reads; the peak is reached just as reading starts |
| `top_port_boot.jpg` | `tb_top_port --fast`, reference vs both patches | boot: release at 20 µs, ADC reset release, I2C boot traffic, two UDP frames, every pair identical |
| `top_port_i2c.jpg` | same | one I2C byte: the reference's `inout` pad and the patched top's pad built from `_oe`, identical; `i2c_sda` carries the clock because of `C_I2C_SWAP` |

Depth 8 in the FIFO unit figures is for legibility only; the design uses 512.

## Charts

| Figure | Data from | What it shows |
| --- | --- | --- |
| `chart_tdm8_rx_area_by_run.jpg` | [runs.md](runs.md), `metrics.json` of `tdm8rx1..4` | post-route area and instance count per Phase 0 run, and what each change bought |
| `chart_cts_cluster_sweep.jpg` | [runs.md](runs.md), CTS sweep | fanout violations and clock buffers against cluster size; why 8 |
| `chart_fifo_depth_vs_stall.jpg` | [fifo.md](fifo.md), depth table | peak occupancy against line stall at 96 and 24 kHz, bytes lost where 512 is exceeded |
| `chart_block_area.jpg` | [results.md](results.md), [fifo.md](fifo.md), [phase1.md](phase1.md) | synthesised area per block measured so far; the decimator is about 95 % |

The block-area chart mixes a quick synthesis (decimator, `abc -fast`) with
OpenLane synthesis (the others), and says so on the figure. It will be redrawn
from post-route numbers once the blocks have been through the flow.
