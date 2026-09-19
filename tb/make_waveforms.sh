#!/usr/bin/env bash
# Regenerate every waveform figure in notes/figures/ from the testbenches.
# See notes/waveforms.md. Run inside `tbrun` (needs ghdl, iverilog, vvp) with
# PY pointing at a python that has matplotlib, e.g. ~/tools/wave-venv/bin/python.
#
# Usage: PY=~/tools/wave-venv/bin/python bash tb/make_waveforms.sh [netlist.v]
#   netlist.v  tdm8_rx netlist for the gate traces, default runs/tdm8rx4/final/nl/tdm8_rx.nl.v

set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$HERE")"
PY="${PY:-python3}"
NL="${1:-$ROOT/runs/tdm8rx4/final/nl/tdm8_rx.nl.v}"
OUT="$ROOT/notes/figures"
V="$ROOT/.sim/waves"
W="$PY $HERE/wave2jpeg.py"
mkdir -p "$OUT" "$V"
cd "$ROOT"

# tdm8_rx: known pattern, VHDL / RTL / gate
bash tb/run_tdm8_rx_gate.sh "$NL" > /dev/null
( cd .sim/gate && vvp -n sim.vvp +slot=32 +launch=1 +pattern=1 +vcd="$V/tdm8.vcd" > /dev/null )
$W "$V/tdm8.vcd" tb/waves/tdm8_rx_frame.txt -o "$OUT/tdm8_rx_overview.jpg" \
   --title "tdm8_rx - three frames, known pattern A1A1A1..181818: VHDL reference, RTL, post-route netlist"
$W "$V/tdm8.vcd" tb/waves/tdm8_rx_frame.txt -o "$OUT/tdm8_rx_capture_zoom.jpg" \
   --from 20900 --to 21250 --cursor 21036.73 --cursor 21097.765 \
   --title "tdm8_rx - frame boundary: LRCLK rise (21036.7 ns), edge detect lrclk_d/lrclk_d2, 192-bit latch update (21097.8 ns)"

# async_fifo unit test at depth 8, first 5 us
iverilog -g2012 -Ptb_async_fifo.AW=3 -o .sim/fifo_u3.vvp tb/tb_async_fifo.v src/async_fifo.v
vvp -n .sim/fifo_u3.vvp +vcd="$V/fifo_unit.vcd" +vcd_until=5000000 > /dev/null
$W "$V/fifo_unit.vcd" tb/waves/fifo_unit.txt -o "$OUT/fifo_fill_drain.jpg" --from 150 --to 4800 \
   --title "async_fifo (depth 8 for legibility) - fill past full, drain past empty; Gray pointers and their two-flop synchronised copies"
$W "$V/fifo_unit.vcd" tb/waves/fifo_unit.txt -o "$OUT/fifo_fill_zoom.jpg" --from 540 --to 960 \
   --title "async_fifo (depth 8) - fill: one Gray bit changes per write; wrfull when wgray = rgray_sync with top two bits inverted"
$W "$V/fifo_unit.vcd" tb/waves/fifo_unit.txt -o "$OUT/fifo_drain_zoom.jpg" --from 3230 --to 3480 \
   --title "async_fifo (depth 8) - drain: q registered one rdclk after rdreq; rdempty when rgray = wgray_sync; wrfull clears after sync"

# FIFO in the system, depth 512, 96 kHz, 7 us stall
bash tb/run_fifo_system.sh 9 > /dev/null
( cd .sim/fifo_system && vvp -n sys.vvp +period=256 +stall=7000 +packets=3 +vcd="$V/fifo_sys.vcd" +vcd_until=260000 > /dev/null )
$W "$V/fifo_sys.vcd" tb/waves/fifo_system.txt -o "$OUT/fifo_system_overview.jpg" --from 0 --to 250000 \
   --title "FIFO in the system - 96 kHz frames, 7 us line stall: 410-byte packets written at 24.576 MHz, drained at 50 MHz"
$W "$V/fifo_sys.vcd" tb/waves/fifo_system.txt -o "$OUT/fifo_system_packet_start.jpg" --from 75700 --to 87200 --cursor 75866.5 \
   --title "FIFO in the system - packet start: packet_ready toggle, 7 us grant stall, 42 header bytes, first payload reads"

# top level: PLL removed, tristates split, scaled boot
VCD="$V/top_port.vcd" bash tb/run_top_port.sh --fast 2500 > /dev/null 2>&1
$W "$V/top_port.vcd" tb/waves/top_port.txt -o "$OUT/top_port_boot.jpg" --from 0 --to 1000000 --cursor 20000 \
   --title "top_system ref vs dut - boot, counters scaled 1000x: rst_n/lock at 20 us, ADC reset release, I2C boot, UDP frames"
$W "$V/top_port.vcd" tb/waves/top_port.txt -o "$OUT/top_port_i2c.jpg" --from 200800 --to 212500 \
   --title "top_system ref (PLL, inout) vs dut (clk_24m576 pin, split tristates) - one I2C byte; pads identical, dut drives only through _oe"

echo "figures in $OUT"
