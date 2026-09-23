#!/usr/bin/env bash
# Synthesise src/*.v (the converted Verilog deliverable) to sky130 cells with
# plain Yosys - no VHDL, no ghdl plugin. Cross-checks the VHDL path in
# synth/run_top_ghdl.sh. See notes/conversion.md.
#
# Usage: olrun "cd <repo> && bash synth/run_src.sh [work_dir]"
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$HERE")"
WORK="${1:-$ROOT/.sim/src_synth}"
if [ -z "$LIB" ]; then
    set -- "$HOME"/.volare/volare/sky130/versions/*
    LIB="$1/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib"
fi
mkdir -p "$WORK"; cd "$WORK"
yosys -l synth_src.log -p "
read_liberty -lib $LIB
read_verilog $ROOT/src/*.v
hierarchy -check -top top_system
synth -top top_system -flatten
dfflibmap -liberty $LIB
opt -full
abc -fast -liberty $LIB -D 40000 -dont_use sky130_fd_sc_hd__lpflow_*
setundef -zero
opt_merge
opt_clean -purge
tee -o check.rpt check
tee -o stat.rpt stat -liberty $LIB
write_verilog -noattr top_system_netlist.v
"
echo "netlist: $WORK/top_system_netlist.v"
