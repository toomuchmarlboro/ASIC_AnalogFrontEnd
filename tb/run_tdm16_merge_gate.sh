#!/usr/bin/env bash
# tdm16_merge: GHDL-converted RTL against its sky130 netlist.
# See tb/tb_tdm16_merge_gate.v, notes/conversion.md. Needs ghdl + iverilog
# (tbrun) and a netlist from synth/run_module_gate.sh (olrun).
#
# Usage: bash tb/run_tdm16_merge_gate.sh [netlist.v]
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$HERE")"
NL="${1:-$ROOT/.sim/gate_modules/tdm16_merge_gate.v}"
W="$ROOT/.sim/tdm16_merge"
PDK="${PDK_ROOT:-$(echo "$HOME"/.volare/volare/sky130/versions/*)}"
LIBV="$PDK/sky130A/libs.ref/sky130_fd_sc_hd/verilog"

[ -f "$NL" ] || { echo "no netlist at $NL - run synth/run_module_gate.sh first" >&2; exit 2; }
mkdir -p "$W"; cd "$W"; rm -f *.v *.cf sim.vvp

ghdl -a --std=08 "$ROOT/legacy/rtl/tdm16_merge.vhd"
ghdl --synth --std=08 --out=verilog tdm16_merge | sed 's/^module tdm16_merge$/module tdm16_merge_ref/' > ref.v
grep -q "^module tdm16_merge_ref" ref.v || { echo "rename failed" >&2; exit 2; }

iverilog -g2012 -DFUNCTIONAL -DUNIT_DELAY= -o sim.vvp -s tb_tdm16_merge_gate \
    "$HERE/tb_tdm16_merge_gate.v" ref.v "$NL" \
    "$LIBV/primitives.v" "$LIBV/sky130_fd_sc_hd.v"

fail=0
for s in 1 2 3; do
    echo "### seed=$s"
    out="$(vvp -n sim.vvp +frames=200 +seed=$s)"
    echo "$out" | grep -E "frames=|MISMATCH|PASS|FAIL"
    echo "$out" | grep -q "TDM16_MERGE PASS" || fail=1
done
[ $fail -eq 0 ] && echo "ALL CASES PASS" || { echo "SOME CASE FAILED"; exit 1; }
