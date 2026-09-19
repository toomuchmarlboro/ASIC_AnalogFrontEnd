#!/usr/bin/env bash
# System-level FIFO check: packet_formatter -> async_fifo -> udp_tx_core.
# See tb/tb_fifo_system.v and notes/fifo.md. Needs ghdl and iverilog on PATH
# (notes/environment.md, `tbrun`).
#
# Usage: bash tb/run_fifo_system.sh [addr_width] [work_dir]   default 9 (512 deep)

set -e
AW="${1:-9}"
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$HERE")"
WORKDIR="${2:-$ROOT/.sim/fifo_system}"
RTL="$ROOT/legacy/rtl"

mkdir -p "$WORKDIR"; cd "$WORKDIR"; rm -f *.v *.cf *.vvp

ghdl -a --std=08 "$RTL/net_pkg.vhd" "$RTL/packet_formatter.vhd" "$RTL/udp_tx_core.vhd"
ghdl --synth --std=08 --out=verilog packet_formatter > packet_formatter.v
ghdl --synth --std=08 --out=verilog udp_tx_core      > udp_tx_core.v

iverilog -g2012 -Ptb_fifo_system.AW="$AW" -o sys.vvp -s tb_fifo_system \
    "$HERE/tb_fifo_system.v" "$ROOT/src/async_fifo.v" packet_formatter.v udp_tx_core.v

fail=0
run() { echo "### $*"; out="$(vvp -n sys.vvp "$@")"; echo "$out" | grep -E "period|packets|ERROR|PASS|FAIL"; echo "$out" | grep -q "SYSTEM PASS" || fail=1; }

run +period=256  +stall=0        # 96 kHz frames
run +period=256  +stall=7000     # 96 kHz, one ARP-sized frame ahead on the line
run +period=1024 +stall=0        # 24 kHz frames (decimator on)
run +period=1024 +stall=7000
run +period=1024 +stall=40000   # 24 kHz, a long stall

[ $fail -eq 0 ] && echo "ALL SYSTEM CASES PASS" || { echo "SOME SYSTEM CASE FAILED"; exit 1; }
