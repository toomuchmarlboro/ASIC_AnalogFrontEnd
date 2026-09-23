#!/usr/bin/env bash
# adau1978_sequencer: the VHDL under GHDL and src/adau1978_sequencer.v under
# Icarus, same stimulus, outputs diffed. The module's equivalence check, because
# the formal proof does not close on it. See notes/conversion.md.
#
# Usage: tbrun "cd <repo> && bash tb/run_seq_vec.sh [cycles]"
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$HERE")"
N="${1:-40000}"
W="$ROOT/.sim/seq_vec"
mkdir -p "$W"; cd "$W"; rm -f *.txt *.cf *.vvp

ghdl -a --std=08 "$ROOT/legacy/rtl/adau_sequencer.vhd" "$HERE/tb_seq_vec_vhdl.vhd"
ghdl -r --std=08 tb_seq_vec_vhdl -gG_CYCLES="$N" -gG_OUTFILE=vec_vhdl.txt 2>&1 | grep -vE "warning|\\^|bounds" || true

iverilog -g2012 -o seq.vvp -s tb_seq_vec "$HERE/tb_seq_vec.v" "$ROOT/src/adau1978_sequencer.v"
vvp -n seq.vvp +cycles="$N" +out=vec_v.txt | tail -1

# GHDL's to_hstring writes uppercase hex, Icarus's %X writes lowercase, so the
# comparison ignores case. Everything else must match exactly.
if diff -iq vec_vhdl.txt vec_v.txt > /dev/null; then
    echo "SEQUENCER EQUIVALENT: $(wc -l < vec_v.txt) vectors identical"
else
    echo "SEQUENCER MISMATCH at line $(diff -i vec_vhdl.txt vec_v.txt | head -1)"
    diff -i vec_vhdl.txt vec_v.txt | head -6
    exit 1
fi
