#!/usr/bin/env bash
# Phase 0 equivalence check. See notes/phase0.md for why ModelSim ASE.
# Usage: bash tb/run_tdm8_rx_equiv.sh [work_dir]

set -e

MSIM="${MSIM:-C:/intelFPGA/16.1/modelsim_ase/win32aloem}"
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$HERE")"
RTL="${RTL:-C:/Users/LENOVO THINKPAD T14/Documents/TDM_UATR/rtl}"
WORKDIR="${1:-$ROOT/.sim}"

mkdir -p "$WORKDIR"
cd "$WORKDIR"
rm -rf work conv modelsim.ini

"$MSIM/vlib.exe" work
"$MSIM/vlib.exe" conv
"$MSIM/vmap.exe" conv conv > /dev/null

"$MSIM/vcom.exe" -2008 -quiet "$RTL/tdm8_master.vhd" "$RTL/tdm8_rx.vhd"
"$MSIM/vlog.exe" -quiet -work conv "$ROOT/src/tdm8_rx.v"
"$MSIM/vcom.exe" -2008 -quiet "$HERE/tb_tdm8_rx_equiv.vhd"

run_case() {
    echo "### slot=$1 BCLKs  launch_delay=$2  check_pattern=$3"
    "$MSIM/vsim.exe" -c \
        -gG_SLOT_BCLKS="$1" -gG_LAUNCH_DELAY="$2" -gG_CHECK_PATTERN="$3" \
        work.tb_tdm8_rx_equiv -do "run -all; quit -f" 2>&1 |
        grep -E "Note:|Error|Failure|Errors:" | sed 's/^# //'
}

run_case 32 1 true    # as built: 256-BCLK frame, ADC frames one BCLK late
run_case 32 0 false   # same framing, legacy launch model
run_case 24 0 false   # sim/tb_tdm8_rx.vhd's original stimulus
