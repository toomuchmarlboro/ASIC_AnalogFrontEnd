#!/usr/bin/env bash
# Synthesise one VHDL module to sky130 cells with the ghdl plugin, for a
# gate-level check. See notes/conversion.md.
#
# Usage: olrun "cd <repo> && bash synth/run_module_gate.sh <module> [out.v] [extra.vhd ...]"
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$HERE")"
MOD="${1:?usage: $0 <module> [out.v] [extra vhd files]}"; shift
OUT="${1:-$ROOT/.sim/gate_modules/${MOD}_gate.v}"; shift || true
EXTRA="$*"

if [ -z "$LIB" ]; then
    set -- "$HOME"/.volare/volare/sky130/versions/*
    LIB="$1/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib"
fi
mkdir -p "$(dirname "$OUT")"

yosys -m ghdl -p "
read_liberty -lib $LIB
ghdl --std=08 --latches $EXTRA $ROOT/legacy/rtl/${MOD}.vhd -e ${MOD}
synth -top ${MOD} -flatten
dfflibmap -liberty $LIB
opt -full
abc -fast -liberty $LIB -D 40000 -dont_use sky130_fd_sc_hd__lpflow_*
setundef -zero
opt_clean -purge
check
rename ${MOD} ${MOD}_gate
write_verilog -noattr $OUT
stat -liberty $LIB
" | tail -20
echo "wrote $OUT"
