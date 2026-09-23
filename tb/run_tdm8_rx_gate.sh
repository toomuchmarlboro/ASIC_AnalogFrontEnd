#!/usr/bin/env bash
# Server-side equivalence and gate-level check for tdm8_rx.
# See tb/tb_tdm8_rx_gate.v for what is compared, and notes/phase0.md.
#
# Needs ghdl and iverilog on PATH (notes/environment.md, `tbrun`), and the
# sky130 PDK from the OpenLane volare install.
#
# Usage: bash tb/run_tdm8_rx_gate.sh <netlist.v> [work_dir]
#   netlist.v  a netlist of module tdm8_rx built from sky130_fd_sc_hd cells,
#              e.g. runs/<tag>/06-yosys-synthesis/tdm8_rx.nl.v
#
# Compares: the VHDL through GHDL, the first hand conversion (git), the Phase 0
# hand conversion in phase0/, the Phase 2 generated module in src/, and the
# netlist. See notes/conversion.md.
#   PDK_ROOT   defaults to the only volare sky130 version under ~/.volare
#   V1_REV     git revision of the earlier src/tdm8_rx.v, default 39e609a

set -e

NETLIST="$(realpath "${1:?usage: $0 <netlist.v> [work_dir]}")"
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$HERE")"
WORKDIR="${2:-$ROOT/.sim/gate}"
V1_REV="${V1_REV:-39e609a}"

if [ -z "$PDK_ROOT" ]; then
    set -- "$HOME"/.volare/volare/sky130/versions/*
    [ $# -eq 1 ] || { echo "several PDK versions, set PDK_ROOT" >&2; exit 2; }
    PDK_ROOT="$1"
fi
LIB="$PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/verilog"
[ -f "$LIB/sky130_fd_sc_hd.v" ] || { echo "no cell models at $LIB" >&2; exit 2; }

mkdir -p "$WORKDIR"
cd "$WORKDIR"
rm -f *.v *.cf sim.vvp

# both conversions must stay Verilog-2005
iverilog -g2005 -o /dev/null "$ROOT/phase0/tdm8_rx.v"
iverilog -g2005 -o /dev/null "$ROOT/src/tdm8_rx.v"

# Reference: the FPGA VHDL, synthesised by GHDL. Keeps the VHDL initial values.
ghdl -a --std=08 "$ROOT/legacy/rtl/tdm8_master.vhd" "$ROOT/legacy/rtl/tdm8_rx.vhd"
ghdl --synth --std=08 --out=verilog tdm8_master > tdm8_master.v
ghdl --synth --std=08 --out=verilog tdm8_rx     | sed 's/^module tdm8_rx$/module tdm8_rx_vhdl/' > tdm8_rx_vhdl.v

# The Phase 0 conversion as first verified, and the netlist under test.
git -C "$ROOT" show "$V1_REV:src/tdm8_rx.v" | sed 's/^module tdm8_rx /module tdm8_rx_v1 /' > tdm8_rx_v1.v
sed -E 's/^module tdm8_rx\b/module tdm8_rx_conv/' "$ROOT/src/tdm8_rx.v" > tdm8_rx_conv.v
grep -q '^module tdm8_rx_conv' tdm8_rx_conv.v || { echo "rename failed: conv" >&2; exit 2; }
sed -E 's/^module tdm8_rx\b/module tdm8_rx_gate/' "$NETLIST" > tdm8_rx_gate.v
grep -q '^module tdm8_rx_v1'   tdm8_rx_v1.v   || { echo "rename failed: v1" >&2;   exit 2; }
grep -q '^module tdm8_rx_vhdl' tdm8_rx_vhdl.v || { echo "rename failed: vhdl" >&2; exit 2; }
grep -q '^module tdm8_rx_gate' tdm8_rx_gate.v || { echo "rename failed: gate" >&2; exit 2; }

iverilog -g2012 -DFUNCTIONAL -DUNIT_DELAY= -o sim.vvp -s tb_tdm8_rx_gate \
    "$HERE/tb_tdm8_rx_gate.v" "$ROOT/phase0/tdm8_rx.v" tdm8_rx_conv.v \
    tdm8_master.v tdm8_rx_vhdl.v tdm8_rx_v1.v tdm8_rx_gate.v \
    "$LIB/primitives.v" "$LIB/sky130_fd_sc_hd.v"

fail=0
run_case() {
    echo "### $*"
    out="$(vvp -n sim.vvp "$@")"
    echo "$out" | grep -E "comparisons|MISMATCH|ch[0-9]|FAIL|PASS|INCONCLUSIVE|slot="
    echo "$out" | grep -q "EQUIVALENCE PASS" || fail=1
}

run_case +slot=32 +launch=1 +pattern=1     # as built: 256-BCLK frame, ADC one BCLK late
run_case +slot=32 +launch=0                 # same framing, legacy launch model
run_case +slot=24 +launch=0                 # sim/tb_tdm8_rx.vhd's original stimulus
run_case +random=1 +frames=400 +seed=1
run_case +random=1 +frames=400 +seed=2
run_case +random=1 +frames=400 +seed=3

if [ $fail -eq 0 ]; then echo "ALL CASES PASS"; else echo "SOME CASE FAILED"; exit 1; fi
