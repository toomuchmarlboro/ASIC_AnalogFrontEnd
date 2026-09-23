#!/usr/bin/env bash
# Phase 2 conversion: VHDL -> Verilog for the whole design, into src/.
# See notes/conversion.md. Run inside a shell with ghdl (`tbrun`).
#
# The whole hierarchy is converted in ONE ghdl pass from the patched top, so the
# generic values the top applies (BOOT_DELAY_CYCLES, QUARTER_BIT_CYCLES,
# G_ENFORCE_FCS) are baked into the modules that use them. Converting each file
# separately would silently use the entity defaults instead.
#
# Usage: tbrun "cd <repo> && bash synth/convert_vhdl.sh"
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$HERE")"
L="$ROOT/legacy/rtl"
W="${WORK:-$ROOT/.sim/convert}"
COMMIT="$(git -C "${TDM_UATR:-$HOME/UATR_TDM}" rev-parse HEAD 2>/dev/null || echo unknown)"

mkdir -p "$W"; cd "$W"; rm -f *.vhd *.v *.cf

patch -s -o t1.vhd "$L/top_system.vhd" "$ROOT/patches/0001-top-system-remove-pll.patch"
patch -s -o t2.vhd t1.vhd "$ROOT/patches/0002-top-system-split-tristates.patch"
patch -s -o top_asic.vhd t2.vhd "$ROOT/patches/0003-top-system-bind-async-fifo.patch"

ghdl -a --std=08 "$L/net_pkg.vhd" "$L/decim_coef_pkg.vhd" "$L/crc32.vhd" \
    "$L/tdm8_master.vhd" "$L/tdm8_rx.vhd" "$L/tdm16_merge.vhd" "$L/decimator.vhd" \
    "$L/packet_formatter.vhd" "$L/rmii_rx.vhd" "$L/rmii_tx.vhd" "$L/udp_tx_core.vhd" \
    "$L/udp_rx_core.vhd" "$L/arp_responder.vhd" "$L/i2c_master.vhd" \
    "$L/adau_sequencer.vhd" top_asic.vhd

# --latches: adau_sequencer's dead poll_ot signal infers one. See notes/conversion.md.
ghdl --synth --std=08 --latches --out=verilog top_system > all.v

COMMIT="$COMMIT" python3 - "$W/all.v" "$ROOT/src" <<'PY'
import os, re, sys
src = open(sys.argv[1]).read()
out = sys.argv[2]
commit = os.environ.get("COMMIT", "unknown")
names = re.findall(r'^module ([A-Za-z0-9_]+)', src, re.M)
# ghdl mangles the architecture and generic values into the module name
clean = {n: (re.match(r'^(.*?)_Brtl(_.*)?$', n).group(1) if '_Brtl' in n else n) for n in names}
assert len(set(clean.values())) == len(clean), "name collision after stripping suffixes"
for old, new in clean.items():
    if old != new:
        src = re.sub(r'\b%s\b' % re.escape(old), new, src)
vhd_of = {'adau1978_sequencer': 'adau_sequencer.vhd', 'top_system': 'top_system.vhd'}
n = 0
for part in re.split(r'(?m)^(?=module [A-Za-z0-9_]+\s*$)', src)[1:]:
    mod = re.match(r'module ([A-Za-z0-9_]+)', part).group(1)
    vhd = vhd_of.get(mod, mod + '.vhd')
    extra = (" with patches/0001..0003 applied," if mod == 'top_system' else ",")
    hdr = ("// DO NOT EDIT. Regenerate with synth/convert_vhdl.sh; see notes/conversion.md.\n"
           f"// Generated from legacy/rtl/{vhd}{extra}\n"
           "// by `ghdl --synth --std=08 --latches --out=verilog top_system`, which converts\n"
           "// the whole hierarchy in one pass so the top's generic values are applied.\n"
           f"// Source: UATR_TDM commit {commit}, vendored in legacy/rtl.\n"
           "// GHDL 6.0.0 (mcode). Module names are the VHDL entity names; GHDL's\n"
           "// architecture/generic suffixes are stripped.\n\n")
    open(os.path.join(out, mod + '.v'), 'w').write(hdr + part.rstrip() + "\n")
    n += 1
print("wrote", n, "modules to", out)
PY
echo "src/ now holds the converted design plus the hand-written async_fifo.v"
