#!/usr/bin/env bash
# Equivalence check for the top-level patches: PLL removal, tristate split,
# FIFO binding (0001..0003).
# See tb/tb_top_port.vhd, notes/clocking.md, notes/ports.md.
# Needs ghdl on PATH (notes/environment.md, `tbrun`).
#
# The patched top is built from the vendored source and the patches in patches/,
# applied in order, so the chain legacy VHDL -> patches -> simulation is
# reproducible.
#
# Usage: bash tb/run_top_port.sh [--fast] [stop_us]
#   default   unmodified boot delays, 12 ms: PLL lock, PHY reset release at 10 ms
#   --fast    the boot counters scaled down 1000x, and the I2C bit time 10x, in
#             BOTH tops, so the ADC reset release, the sequencer's boot on the
#             I2C bus and the power enables are reached
#   stop_us   simulated microseconds, default 12000 (fast: 20000)
#   VCD=<file.vcd>  dump the signals listed in tb/waves/top_port.opt
#   TRACE=true   print every edge on the reference's I2C pads
#   MUTATE_FILE=<sed script>  same, from a file
#   MUTATE='<sed expr>'  test hook: edit the patched top before it is built, to
#             prove the check can fail

set -e
FAST=0
if [ "$1" = "--fast" ]; then FAST=1; shift; fi
STOP="${1:-$([ $FAST -eq 1 ] && echo 20000 || echo 12000)}"

HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$HERE")"
RTL="$ROOT/legacy/rtl"
WORKDIR="${WORKDIR:-$ROOT/.sim/top_port}"

mkdir -p "$WORKDIR"; cd "$WORKDIR"; rm -f *.vhd *.cf *.o e~* 2>/dev/null || true

cp "$RTL/top_system.vhd" top_ref.vhd
patch -s -o top_dut1.vhd "$RTL/top_system.vhd" "$ROOT/patches/0001-top-system-remove-pll.patch"
patch -s -o top_dut2.vhd top_dut1.vhd "$ROOT/patches/0002-top-system-split-tristates.patch"
patch -s -o top_dut.vhd top_dut2.vhd "$ROOT/patches/0003-top-system-bind-async-fifo.patch"

[ -n "$MUTATE" ] && sed -i "$MUTATE" top_dut.vhd
[ -n "$MUTATE_FILE" ] && sed -i -f "$MUTATE_FILE" top_dut.vhd

if [ $FAST -eq 1 ]; then
    # the same edit, once each, to both copies
    for f in top_ref.vhd top_dut.vhd; do
        for pat in "phy_rst_cnt < 500000 then:phy_rst_cnt < 500 then" \
                   "adc_rst_cnt < 5000000 then:adc_rst_cnt < 5000 then" \
                   "pwr_cnt < 50000000 then:pwr_cnt < 50000 then" \
                   "pwr_cnt >= 25000000 then:pwr_cnt >= 25000 then" \
                   "pwr_cnt >= 50000000 then:pwr_cnt >= 50000 then" \
                   "BOOT_DELAY_CYCLES => 7500000:BOOT_DELAY_CYCLES => 7500" \
                   "QUARTER_BIT_CYCLES => 250:QUARTER_BIT_CYCLES => 25"; do
            from="${pat%%:*}"; to="${pat#*:}"
            [ "$(grep -c "$from" $f)" -eq 1 ] || { echo "pattern '$from' not found once in $f" >&2; exit 2; }
            sed -i "s/$from/$to/" $f
        done
    done
    echo "boot counters scaled 1000x, I2C bit time 10x, in both tops"
fi

SUBS="$RTL/net_pkg.vhd $RTL/decim_coef_pkg.vhd $RTL/crc32.vhd $RTL/tdm8_master.vhd $RTL/tdm8_rx.vhd \
      $RTL/tdm16_merge.vhd $RTL/decimator.vhd $RTL/packet_formatter.vhd $RTL/rmii_rx.vhd $RTL/rmii_tx.vhd \
      $RTL/udp_tx_core.vhd $RTL/udp_rx_core.vhd $RTL/arp_responder.vhd $RTL/i2c_master.vhd $RTL/adau_sequencer.vhd \
      $HERE/async_fifo_model.vhd $HERE/i2c_ack_slave.vhd"

ghdl -a --std=08 --work=ref $SUBS $HERE/pll_audio_model.vhd top_ref.vhd
ghdl -a --std=08 --work=work $SUBS top_dut.vhd $HERE/tb_top_port.vhd
WAVE=""
[ -n "$VCD" ] && WAVE="--vcd=$VCD --read-wave-opt=$HERE/waves/top_port.opt"
ghdl -r --std=08 --work=work tb_top_port $WAVE -gG_STOP_US="$STOP" -gG_TRACE_I2C="${TRACE:-false}" 2>&1 | grep -vE "^\S+:\d+:\d+:@0ms:.*NUMERIC_STD|metavalue" 
