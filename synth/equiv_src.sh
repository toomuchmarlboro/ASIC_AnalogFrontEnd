#!/usr/bin/env bash
# Prove each converted src/*.v module formally equivalent to the VHDL entity it
# came from: gold = the entity through the ghdl plugin, gate = src/<module>.v.
# memory_map turns inferred ROM/RAM into logic: the SAT solver cannot import
# memory cells, which is what stalls the proof on adau1978_sequencer.
# See notes/conversion.md.
#
# Usage: olrun "cd <repo> && bash synth/equiv_src.sh [module ...]"
#   no arguments: every module that has a generic-free or generic-pinned recipe
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$HERE")"
L="$ROOT/legacy/rtl"
W="${WORK:-$ROOT/.sim/equiv}"
mkdir -p "$W"

# module | extra vhd files | ghdl generic overrides, matching top_system's generic map
recipe() {
  case "$1" in
    crc32)              DEPS=""                                      GEN="" ;;
    tdm8_master)        DEPS=""                                      GEN="" ;;
    tdm8_rx)            DEPS=""                                      GEN="" ;;
    tdm16_merge)        DEPS=""                                      GEN="" ;;
    packet_formatter)   DEPS=""                                      GEN="" ;;
    udp_tx_core)        DEPS="$L/net_pkg.vhd"                        GEN="" ;;
    udp_rx_core)        DEPS=""                                      GEN="" ;;
    arp_responder)      DEPS=""                                      GEN="" ;;
    rmii_tx)            DEPS="$L/crc32.vhd"                          GEN="" ;;
    rmii_rx)            DEPS="$L/crc32.vhd"                          GEN="-gG_ENFORCE_FCS=false" ;;  # gate side also needs src/crc32.v
    i2c_master)         DEPS=""                                      GEN="-gQUARTER_BIT_CYCLES=250" ;;
    adau1978_sequencer) DEPS=""                                      GEN="-gBOOT_DELAY_CYCLES=7500000" ;;
    decimator)          DEPS="$L/decim_coef_pkg.vhd"                 GEN="" ;;
    *) echo "no recipe for $1" >&2; return 1 ;;
  esac
  case "$1" in
    adau1978_sequencer) VHD="$L/adau_sequencer.vhd" ;;
    *)                  VHD="$L/$1.vhd" ;;
  esac
}

MODS="${*:-crc32 tdm8_master tdm8_rx tdm16_merge packet_formatter udp_tx_core udp_rx_core arp_responder rmii_tx rmii_rx i2c_master adau1978_sequencer}"
fail=0
for m in $MODS; do
    recipe "$m"
    # a module that instantiates another needs its submodule source on the gate side
    case "$m" in
        rmii_tx|rmii_rx) GATE_EXTRA="$ROOT/src/crc32.v" ;;
        *)               GATE_EXTRA="" ;;
    esac
    # ghdl --synth lowercases port names when it converts the whole hierarchy,
    # while the plugin import keeps the VHDL case; rename the gold side to match
    GOLD_FIX=""
    if [ "$m" = tdm16_merge ]; then
        GOLD_FIX=$(printf 'select -module tdm16_merge\nrename \\ch_data_A \\ch_data_a\nrename \\ch_data_B \\ch_data_b\nselect -clear')
    fi
    # depth for equiv_induct: the default is enough except where noted
    case "$m" in
        tdm8_rx|adau1978_sequencer) SEQ=120 ;;
        *)                          SEQ=10 ;;
    esac
    printf '%-20s ' "$m"
    cat > "$W/$m.ys" <<YS
ghdl --std=08 --latches $GEN $DEPS $VHD -e $m
prep -flatten -top $m
$GOLD_FIX
memory_map
async2sync
design -stash gold
read_verilog $ROOT/src/$m.v $GATE_EXTRA
prep -flatten -top $m
memory_map
async2sync
design -stash gate
design -copy-from gold -as gold $m
design -copy-from gate -as gate $m
equiv_make gold gate equiv
prep -flatten -top equiv
equiv_simple -seq 5
equiv_induct -seq $SEQ
equiv_status -assert
YS
    if yosys -m ghdl -q -s "$W/$m.ys" > "$W/$m.log" 2>&1; then
        echo "EQUIVALENT  ($(grep -oE '[0-9]+ cells proven' "$W/$m.log" | tail -1))"
    else
        echo "NOT PROVEN  - see $W/$m.log"; fail=1
    fi
done
[ $fail -eq 0 ] && echo "ALL MODULES EQUIVALENT" || { echo "SOME MODULE NOT PROVEN"; exit 1; }
