#!/usr/bin/env bash
# Phase 2: whole-chip synthesis from VHDL through the ghdl-yosys-plugin.
# See notes/conversion.md. Run inside the OpenLane nix-shell (`olrun`).
#
# Builds the patched top from legacy/rtl + patches/, imports every VHDL module
# with the plugin, replaces the unbound async_fifo blackbox with the real
# src/async_fifo.v, then synthesises to sky130 cells.
#
# Usage: olrun "cd <repo> && bash synth/run_top_ghdl.sh [work_dir]"
#   LIB=<liberty>   default: the sky130_fd_sc_hd tt corner from the volare PDK
#   STRATEGY=fast|area   fast = abc -fast (default, minutes), area = abc -liberty

set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$HERE")"
WORK="${1:-$ROOT/.sim/ghdl_top}"
RTL="$ROOT/legacy/rtl"
STRATEGY="${STRATEGY:-fast}"

if [ -z "$LIB" ]; then
    set -- "$HOME"/.volare/volare/sky130/versions/*
    LIB="$1/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib"
fi
[ -f "$LIB" ] || { echo "no liberty at $LIB" >&2; exit 2; }

mkdir -p "$WORK"; cd "$WORK"
patch -s -o t1.vhd "$RTL/top_system.vhd" "$ROOT/patches/0001-top-system-remove-pll.patch"
patch -s -o t2.vhd t1.vhd "$ROOT/patches/0002-top-system-split-tristates.patch"
patch -s -o top_asic.vhd t2.vhd "$ROOT/patches/0003-top-system-bind-async-fifo.patch"

# dependency order; tdm16_rx is excluded (built but not active), ip/ is gone
FILES="$RTL/net_pkg.vhd $RTL/decim_coef_pkg.vhd $RTL/crc32.vhd $RTL/tdm8_master.vhd \
$RTL/tdm8_rx.vhd $RTL/tdm16_merge.vhd $RTL/decimator.vhd $RTL/packet_formatter.vhd \
$RTL/rmii_rx.vhd $RTL/rmii_tx.vhd $RTL/udp_tx_core.vhd $RTL/udp_rx_core.vhd \
$RTL/arp_responder.vhd $RTL/i2c_master.vhd $RTL/adau_sequencer.vhd top_asic.vhd"

# lpflow_* are power-gating cells with no logic function; one power domain here.
NOUSE="-dont_use sky130_fd_sc_hd__lpflow_*"
if [ "$STRATEGY" = area ]; then ABC="abc -liberty $LIB -D 40000 $NOUSE"; else ABC="abc -fast -liberty $LIB -D 40000 $NOUSE"; fi

# --latches: adau_sequencer's dead signal poll_ot infers one. See notes/conversion.md.
# read_liberty -lib first: without the cell models `check` cannot tell an
# output pin from an input and reports every mapped flop as undriven.
yosys -m ghdl -l synth.log -p "
read_liberty -lib $LIB
ghdl --std=08 --latches $FILES -e top_system
delete async_fifo
read_verilog $ROOT/src/async_fifo.v
hierarchy -check -top top_system
tee -o check_pre.rpt check
synth -top top_system -flatten
dfflibmap -liberty $LIB
opt -full
$ABC
setundef -zero
opt_merge
opt_clean -purge
tee -o check_post.rpt check
tee -o stat.rpt stat -liberty $LIB
write_verilog -noattr top_system_netlist.v
"
echo "netlist: $WORK/top_system_netlist.v"
