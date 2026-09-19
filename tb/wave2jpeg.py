#!/usr/bin/env python3
"""Render a VCD as a ModelSim-style wave window, saved as JPEG (or PNG/PDF).

For reports. Reads the VCD that GHDL (--vcd=) or Icarus ($dumpfile) writes,
draws the chosen signals over a time window: black background, green traces,
buses as hex-valued segments, X in red, Z in blue, a name column on the left
and optional cursors. See notes/waveforms.md.

Usage:
  wave2jpeg.py <file.vcd> <signals.txt> -o out.jpg [--from NS] [--to NS]
               [--cursor NS ...] [--title TEXT] [--width PX]

signals.txt, one signal per line:
  <path> [label] [radix]
  path   VCD hierarchical name, dot-separated, e.g. tb_top_port.u_dut.lrclk_out
         (a trailing name is enough if it is unique)
  label  what to print in the name column (default: last path component)
  radix  hex | bin | dec | udec | analog (buses only, default hex). analog draws
         the unsigned value as a stepped line three rows tall, like ModelSim's
         analog format, labelled with its min and max in the window
  A line "-- text" draws a divider with that text. '#' starts a comment.

Needs matplotlib (notes/environment.md: ~/tools/wave-venv).
"""

import argparse
import re
import sys

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt  # noqa: E402
import matplotlib.ticker  # noqa: E402

BG, GRID, WAVE, BUSFILL = "#000000", "#2a2a2a", "#00ff00", "#003300"
XCOL, ZCOL, TXT, NAME, CUR = "#ff3030", "#4080ff", "#ffffff", "#e0e0e0", "#ffff00"

TIMESCALE_FS = {"fs": 1, "ps": 10**3, "ns": 10**6, "us": 10**9, "ms": 10**12, "s": 10**15}


# ---------------------------------------------------------------- VCD reading

def read_vcd(path, wanted):
    """Return (timescale_fs, {fullname: (width, [(t, value_str), ...])}).
    Only ids needed by `wanted` (a predicate on full names) are recorded."""
    scope, ids, width, names = [], {}, {}, {}
    ts_fs = 10**6
    data = {}
    t = 0
    with open(path) as f:
        header = True
        buf = []
        for line in f:
            if header:
                buf.append(line)
                if "$enddefinitions" in line:
                    header = False
                    toks = " ".join(buf).split()
                    i = 0
                    while i < len(toks):
                        k = toks[i]
                        if k == "$timescale":
                            j = toks.index("$end", i)
                            m = re.match(r"(\d+)\s*([a-z]+)", "".join(toks[i + 1:j]))
                            ts_fs = int(m.group(1)) * TIMESCALE_FS[m.group(2)]
                            i = j
                        elif k == "$scope":
                            scope.append(toks[i + 2]); i += 3
                        elif k == "$upscope":
                            scope.pop(); i += 1
                        elif k == "$var":
                            w, code, ref = int(toks[i + 2]), toks[i + 3], toks[i + 4]
                            j = toks.index("$end", i)
                            full = ".".join(scope + [ref])
                            if wanted(full):
                                ids.setdefault(code, []).append(full)
                                width[full] = w
                                data[full] = []
                            i = j
                        i += 1
                continue
            line = line.strip()
            if not line:
                continue
            c = line[0]
            if c == "#":
                t = int(line[1:])
            elif c in "bBrR":
                val, code = line[1:].split()
                for n in ids.get(code, ()):
                    data[n].append((t, val.lower()))
            elif c in "01xXzZuUwWlLhH-":
                code = line[1:]
                for n in ids.get(code, ()):
                    data[n].append((t, c.lower()))
    return ts_fs, {n: (width[n], data[n]) for n in data}


def resolve(spec, available):
    if spec in available:
        return spec
    hits = [n for n in available if n.split("[")[0] == spec or n.endswith("." + spec) or n.split("[")[0].endswith("." + spec)]
    if len(hits) == 1:
        return hits[0]
    if not hits:
        sys.exit(f"wave2jpeg: no signal matches '{spec}'")
    sys.exit(f"wave2jpeg: '{spec}' is ambiguous: {hits[:5]}")


# ---------------------------------------------------------------- values

def norm_bit(v):
    return {"h": "1", "l": "0", "u": "x", "w": "x", "-": "x"}.get(v, v)


def fmt_bus(v, width, radix):
    v = "".join(norm_bit(c) for c in v).rjust(width, v[0] if v[0] in "xz" else "0")
    if "x" in v:
        return "X"
    if "z" in v:
        return "Z"
    n = int(v, 2)
    if radix == "bin":
        return v
    if radix == "udec":
        return str(n)
    if radix == "dec":
        return str(n - (1 << width) if v[0] == "1" else n)
    return "%0*X" % ((width + 3) // 4, n)


def value_at(changes, t):
    v = None
    for tt, vv in changes:
        if tt > t:
            break
        v = vv
    return v


# ---------------------------------------------------------------- drawing

def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("vcd")
    ap.add_argument("signals")
    ap.add_argument("-o", "--out", required=True)
    ap.add_argument("--from", dest="t0", type=float, default=None, help="window start, ns")
    ap.add_argument("--to", dest="t1", type=float, default=None, help="window end, ns")
    ap.add_argument("--cursor", type=float, action="append", default=[], help="cursor time, ns")
    ap.add_argument("--title", default="")
    ap.add_argument("--width", type=int, default=1800, help="image width, px")
    a = ap.parse_args()

    rows = []
    for raw in open(a.signals):
        line = raw.split("#")[0].strip()
        if not line:
            continue
        if line.startswith("--"):
            rows.append(("div", line[2:].strip()))
            continue
        parts = line.split()
        if len(parts) > 3 or (len(parts) == 3 and parts[2] not in ("hex", "bin", "dec", "udec", "analog")):
            sys.exit(f"wave2jpeg: bad line (labels may not contain spaces): {raw.rstrip()}")
        rows.append(("sig", parts[0],
                     parts[1] if len(parts) > 1 else None,
                     parts[2] if len(parts) > 2 else "hex"))

    specs = [r[1] for r in rows if r[0] == "sig"]
    keys = set(s.split(".")[-1].split("[")[0] for s in specs)
    ts_fs, sigs = read_vcd(a.vcd, lambda n: n.split(".")[-1].split("[")[0] in keys or n in specs)
    to_ns = ts_fs / 1e6

    all_t = [t for _, (_, ch) in sigs.items() for t, _ in ch]
    t_end = max(all_t) if all_t else 0
    t0 = a.t0 / to_ns if a.t0 is not None else 0
    t1 = a.t1 / to_ns if a.t1 is not None else t_end
    if t1 <= t0:
        sys.exit("wave2jpeg: empty time window")

    # row geometry: analog rows are three units tall
    tops, y = [], 0.0
    for r in rows:
        tops.append(y)
        y += 3.0 if (r[0] == "sig" and r[3] == "analog") else 1.0
    n = y
    row_h, name_w = 0.42, 3.2
    fig_w = a.width / 100
    fig_h = max(2.0, n * row_h + 1.0 + (0.4 if a.title else 0))
    fig = plt.figure(figsize=(fig_w, fig_h), dpi=100, facecolor=BG)
    top = 1 - (0.45 if a.title else 0.12) / fig_h
    bottom = 0.55 / fig_h
    left = name_w / fig_w
    axn = fig.add_axes([0.005, bottom, left - 0.01, top - bottom], facecolor="#101010")
    ax = fig.add_axes([left, bottom, 0.99 - left, top - bottom], facecolor=BG)
    for x in (axn, ax):
        x.set_ylim(n, 0)
        for sp in x.spines.values():
            sp.set_color("#404040")
    axn.set_xlim(0, 1); axn.set_xticks([]); axn.set_yticks([])
    ax.set_xlim(t0 * to_ns, t1 * to_ns)
    ax.set_yticks([])
    ax.tick_params(colors=NAME, labelsize=8)
    ax.xaxis.grid(True, color=GRID, lw=0.6)
    span_ns = (t1 - t0) * to_ns
    unit, div = ("ms", 1e6) if span_ns >= 1e7 else ("us", 1e3) if span_ns >= 1e5 else ("ns", 1.0)
    ax.xaxis.set_major_formatter(matplotlib.ticker.FuncFormatter(lambda x, _: "%g" % round(x / div, 6)))
    ax.set_xlabel(unit, color=NAME, fontsize=8, labelpad=1)
    if a.title:
        fig.text(0.005, 1 - 0.28 / fig_h, a.title, color=TXT, fontsize=11, va="center")

    lo_frac, hi_frac = 0.78, 0.22       # low / high trace positions within a row
    for i, row in zip(tops, rows):
        if row[0] == "div":
            axn.text(0.03, i + 0.55, row[1], color=CUR, fontsize=8.5, va="center", weight="bold")
            ax.axhline(i + 0.5, color="#505050", lw=0.6)
            continue
        _, spec, label, radix = row
        full = resolve(spec, sigs)
        width, ch = sigs[full]
        label = label or full.split(".")[-1]
        rh = 3.0 if radix == "analog" else 1.0
        axn.text(0.03, i + rh / 2 + 0.05, label, color=NAME, fontsize=8.5, va="center", family="monospace")
        ax.axhline(i + rh, color="#181818", lw=0.5)

        # segments clipped to the window: (start, end, value)
        v0 = value_at(ch, t0)
        segs, cur_t, cur_v = [], t0, v0
        for tt, vv in ch:
            if tt <= t0:
                continue
            if tt >= t1:
                break
            segs.append((cur_t, tt, cur_v)); cur_t, cur_v = tt, vv
        segs.append((cur_t, t1, cur_v))
        segs = [(s * to_ns, e * to_ns, v) for s, e, v in segs]

        if radix == "analog":
            vals = []
            for s_, e_, v in segs:
                b = "".join(norm_bit(c) for c in (v or "x"))
                vals.append(None if any(c in "xz" for c in b) else int(b, 2))
            good = [v for v in vals if v is not None]
            vmin, vmax = (min(good), max(good)) if good else (0, 1)
            rng = (vmax - vmin) or 1
            ytop, ybot = i + 0.25, i + 2.75
            xs, ys = [], []
            for (s_, e_, _), v in zip(segs, vals):
                yv = ybot if v is None else ybot - (v - vmin) / rng * (ybot - ytop)
                xs += [s_, e_]; ys += [yv, yv]
            ax.plot(xs, ys, color=WAVE, lw=1.1)
            ax.fill_between(xs, ys, ybot, color=WAVE, alpha=0.12, lw=0)
            ax.text(t0 * to_ns, ytop, " max %d" % vmax, color=TXT, fontsize=7.5, va="center")
            ax.text(t0 * to_ns, ybot, " min %d" % vmin, color=TXT, fontsize=7.5, va="center")
            continue

        if width == 1:
            ylo, yhi, ymid = i + lo_frac, i + hi_frac, i + 0.5
            prev_y = None
            for s, e, v in segs:
                b = norm_bit(v) if v else "x"
                if b in ("0", "1"):
                    y = ylo if b == "0" else yhi
                    ax.plot([s, e], [y, y], color=WAVE, lw=1.1, solid_capstyle="butt")
                    if prev_y is not None and prev_y != y:
                        ax.plot([s, s], [prev_y, y], color=WAVE, lw=1.1)
                    prev_y = y
                elif b == "z":
                    ax.plot([s, e], [ymid, ymid], color=ZCOL, lw=1.1)
                    prev_y = ymid
                else:
                    ax.fill_between([s, e], ylo, yhi, color=XCOL, alpha=0.35, lw=0)
                    ax.plot([s, e], [ymid, ymid], color=XCOL, lw=1.1)
                    prev_y = ymid
        else:
            ylo, yhi, ymid = i + lo_frac, i + hi_frac, i + 0.5
            span = (t1 - t0) * to_ns
            slope = span * 0.002
            for s, e, v in segs:
                txt = fmt_bus(v, width, radix) if v else "X"
                col = XCOL if txt == "X" else ZCOL if txt == "Z" else WAVE
                d = min(slope, (e - s) / 2)
                xs = [s, s + d, e - d, e, e - d, s + d, s]
                ys = [ymid, yhi, yhi, ymid, ylo, ylo, ymid]
                ax.fill(xs, ys, color=BUSFILL if col == WAVE else col, alpha=1 if col == WAVE else 0.3, lw=0)
                ax.plot(xs, ys, color=col, lw=1.0)
                # label only if the segment is wide enough to hold the text
                if (e - s) / span * (fig_w - name_w) * 100 > 7.5 * len(txt) + 6:
                    ax.text((s + e) / 2, ymid, txt, color=TXT, fontsize=7.5,
                            ha="center", va="center", family="monospace")

    for c in a.cursor:
        ax.axvline(c, color=CUR, lw=1.0)
        ax.text(c, n - 0.05, " %g ns" % c, color=CUR, fontsize=8, va="bottom")

    fmt = a.out.rsplit(".", 1)[-1].lower()
    kw = {"pil_kwargs": {"quality": 95}} if fmt in ("jpg", "jpeg") else {}
    fig.savefig(a.out, facecolor=BG, **kw)
    print(f"wrote {a.out}  ({len([r for r in rows if r[0] == 'sig'])} signals, "
          f"{t0 * to_ns:g} to {t1 * to_ns:g} ns)")


if __name__ == "__main__":
    main()
