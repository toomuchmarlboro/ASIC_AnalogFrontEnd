#!/usr/bin/env python3
"""Charts of the measured results, for reports. See notes/waveforms.md.

Every number here is copied from a notes/ file, which names the command or run
that produced it; the source is given next to each dataset. Rerun a measurement,
update the number here, rerun this script.

Usage: python3 tb/plots.py [out_dir]     default notes/figures
Needs matplotlib (notes/environment.md: ~/tools/wave-venv).
"""

import os
import sys

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt  # noqa: E402

OUT = sys.argv[1] if len(sys.argv) > 1 else os.path.join(os.path.dirname(__file__), "..", "notes", "figures")

# Light theme, reference palette slots 1-2 (validated: all checks pass on #fcfcfb)
SURFACE, INK, INK2, GRIDC = "#fcfcfb", "#0b0b0b", "#52514e", "#e4e3df"
S1, S2 = "#2a78d6", "#eb6834"
REF = "#8a8984"          # reference lines: neutral, not a series colour

plt.rcParams.update({
    "figure.facecolor": SURFACE, "axes.facecolor": SURFACE, "savefig.facecolor": SURFACE,
    "axes.edgecolor": GRIDC, "axes.labelcolor": INK2, "xtick.color": INK2, "ytick.color": INK2,
    "text.color": INK, "font.size": 10, "axes.titlesize": 12, "axes.titleweight": "bold",
    "axes.titlelocation": "left", "axes.spines.top": False, "axes.spines.right": False,
    "axes.grid": True, "grid.color": GRIDC, "grid.linewidth": 0.8, "axes.axisbelow": True,
})


def save(fig, name):
    path = os.path.join(OUT, name)
    fig.savefig(path, dpi=150, bbox_inches="tight", pil_kwargs={"quality": 92})
    plt.close(fig)
    print("wrote", path)


def fifo_depth():
    # notes/fifo.md, depth table; tb/run_fifo_system.sh with growing +stall, AW=9
    s96 = [(0, 410, 0), (7, 464, 0), (15, 489, 0), (17, 511, 3), (20, 512, 8), (30, 512, 58)]
    s24 = [(0, 410, 0), (7, 410, 0), (40, 470, 0), (60, 470, 0), (80, 512, 8)]
    fig, ax = plt.subplots(figsize=(9, 4.8))
    for data, col, lab, mk in ((s96, S1, "96 kHz frames", "o"), (s24, S2, "24 kHz frames (decimated)", "s")):
        x = [d[0] for d in data]; y = [d[1] for d in data]
        ax.plot(x, y, color=col, lw=2, marker=mk, ms=8, mec=SURFACE, mew=2, label=lab, zorder=3)
        for sx, sy, drop in data:
            if drop:
                dx = {17: -14, 20: 8}.get(sx, 0) if col == S1 else -6
                ax.annotate(f"{drop} lost", (sx, sy), xytext=(dx, 10), textcoords="offset points",
                            ha="center" if dx == 0 else ("right" if dx < 0 else "left"),
                            fontsize=8.5, color=INK2)
    ax.axhline(512, color=REF, lw=1.2, ls="--")
    ax.text(50, 515, "FIFO depth 512", color=INK2, fontsize=9, va="bottom", ha="center")
    ax.axhline(410, color=REF, lw=1.2, ls=":")
    ax.text(81, 402, "one packet, 410 bytes", color=INK2, fontsize=9, va="top", ha="right")
    ax.axvspan(0, 7, color=S1, alpha=0.06, lw=0)
    ax.text(3.5, 386, "realistic\nstall", ha="center", va="bottom", fontsize=8.5, color=INK2)
    ax.set_xlim(-2, 82); ax.set_ylim(380, 570)
    ax.set_xlabel("transmit-line stall before the packet is sent (µs)")
    ax.set_ylabel("peak FIFO occupancy (bytes)")
    ax.set_title("FIFO occupancy against line stall: 512 deep covers about 15 µs at 96 kHz, 60 µs at 24 kHz")
    ax.legend(frameon=False, loc="upper left", bbox_to_anchor=(0.02, 1.0), ncol=2)
    fig.text(0, -0.02, "Source: tb/tb_fifo_system.v, real packet_formatter and udp_tx_core, 40 packets per point. notes/fifo.md",
             fontsize=8, color=INK2)
    save(fig, "chart_fifo_depth_vs_stall.jpg")


def tdm8_area():
    # notes/runs.md: tdm8rx1..4 final/metrics.json
    runs = ["tdm8rx1\nfirst run", "tdm8rx2\nwire rst_n = ~rst", "tdm8rx3\nrst_n port", "tdm8rx4\n+ hold margin 0\n+ CTS size 8"]
    area = [23258.6, 23258.6, 21225.4, 19446.2]
    inst = [2552, 2552, 2019, 1822]
    fig, (a1, a2) = plt.subplots(1, 2, figsize=(11, 4.4))
    for ax, vals, unit, fmt, title in ((a1, area, "µm²", "{:,.0f}", "Cell area after place and route"),
                                       (a2, inst, "instances", "{:,}", "Instances after place and route")):
        bars = ax.bar(range(4), vals, color=S1, width=0.62, zorder=3)
        bars[-1].set_color("#1c5cab")
        for i, v in enumerate(vals):
            ax.text(i, v, fmt.format(v), ha="center", va="bottom", fontsize=9, color=INK)
        ax.set_xticks(range(4)); ax.set_xticklabels(runs, fontsize=8.5)
        ax.set_ylabel(unit); ax.set_title(title, fontsize=11)
        ax.set_ylim(0, max(vals) * 1.15); ax.grid(axis="x", visible=False)
    fig.suptitle("tdm8_rx, Phase 0: -16.4 % cell area and -28.6 % instances from the first run to the final one",
                 x=0.01, ha="left", fontsize=12, weight="bold")
    fig.text(0.01, -0.03, "Source: runs/<tag>/final/metrics.json, OpenLane 2.3.10, sky130A. notes/runs.md, notes/results.md",
             fontsize=8, color=INK2)
    fig.tight_layout()
    save(fig, "chart_tdm8_rx_area_by_run.jpg")


def cts_sweep():
    # notes/runs.md, CTS and hold-margin sweep, CD 50, HM 0
    size = [6, 7, 8, 9, 10]
    fan = [5, 0, 0, 4, 12]
    clk = [91, 80, 78, 64, 63]
    fig, (a1, a2) = plt.subplots(1, 2, figsize=(11, 4.2))
    for ax, vals, title, ylab in ((a1, fan, "Max-fanout violations", "violations"),
                                  (a2, clk, "Clock-tree buffers", "buffers")):
        cols = ["#1c5cab" if s == 8 else S1 for s in size]
        ax.bar(size, vals, color=cols, width=0.6, zorder=3)
        for s, v in zip(size, vals):
            ax.text(s, v, str(v), ha="center", va="bottom", fontsize=9)
        ax.set_xticks(size); ax.set_xlabel("CTS_SINK_CLUSTERING_SIZE")
        ax.set_ylabel(ylab); ax.set_title(title, fontsize=11)
        ax.set_ylim(0, max(vals) * 1.2 + 1); ax.grid(axis="x", visible=False)
    a1.annotate("chosen", (8, 0), xytext=(8, 4.5), ha="center", fontsize=9, color=INK2,
                arrowprops=dict(arrowstyle="-", color=REF, lw=1))
    fig.suptitle("CTS cluster size on tdm8_rx: only 7 and 8 clear every fanout violation; 8 uses fewer clock buffers",
                 x=0.01, ha="left", fontsize=12, weight="bold")
    fig.text(0.01, -0.03, "Source: runs hm0_s6d50 .. hm0_s9d50 and holdm0 (size 10), cluster diameter 50 µm, hold margin 0. notes/runs.md",
             fontsize=8, color=INK2)
    fig.tight_layout()
    save(fig, "chart_cts_cluster_sweep.jpg")


def block_area():
    # synthesis cell area, sky130_fd_sc_hd. tdm8_rx: runs/tdm8rx4 stat.rpt; async_fifo: notes/fifo.md (f9);
    # decimator: notes/phase1.md (quick-effort abc -fast, standalone yosys)
    blocks = [("decimator  (quick synthesis)", 3.989967), ("async_fifo 512 x 8", 0.176906),
              ("tdm8_rx x 2", 2 * 0.013998)]
    fig, ax = plt.subplots(figsize=(9, 3.2))
    names = [b[0] for b in blocks][::-1]; vals = [b[1] for b in blocks][::-1]
    ax.barh(names, vals, color=S1, height=0.55, zorder=3)
    for i, v in enumerate(vals):
        ax.text(v + 0.04, i, f"{v:.3f} mm²", va="center", fontsize=9)
    ax.set_xlim(0, 4.6); ax.set_xlabel("synthesised cell area (mm²)")
    ax.grid(axis="y", visible=False)
    ax.set_title("Synthesised cell area by block: the decimator is about 95 % of what is measured so far")
    fig.text(0, -0.14, "Synthesis only, not post-route. Blocks not yet converted are not shown. Sources: notes/results.md, fifo.md, phase1.md",
             fontsize=8, color=INK2)
    save(fig, "chart_block_area.jpg")


if __name__ == "__main__":
    os.makedirs(OUT, exist_ok=True)
    fifo_depth()
    tdm8_area()
    cts_sweep()
    block_area()
