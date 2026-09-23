# decisions — non-obvious choices

One entry per choice: date, decision, alternatives, reason. Newest last.

## 2026-09-19 — Rootless Nix on the lab server

**Decision.** Run OpenLane through `nix-portable` in `~/tools/`, no root.

**Alternatives.** The Determinate Nix installer (needs root and `/nix`); Docker
(`docker.sock` is `root:docker`, the account is not in the group); asking the
server admin for either; conda packages for the point tools (off the
documented OpenLane 2 path, version drift).

**Reason.** No sudo, and user namespaces work. Cost and reproduction steps are
in [environment.md](environment.md). If an admin later installs Nix
system-wide, nothing here needs to change except the shell wrapper.

## 2026-09-19 — Active-low reset port on `tdm8_rx`

**Decision.** `src/tdm8_rx.v` takes `rst_n`, active-low, instead of the VHDL
`rst`, active-high. Asynchronous style kept.

**Authorised by.** The project owner, in session: "its fine if restructured".
This overrides the CLAUDE.md line about not restructuring reset trees, for
this change only. CLAUDE.md itself is not edited.

**Alternatives tried, all on `tdm8_rx`, synthesis only.**

| Attempt | Cells | Area µm² | Inverters |
| --- | --- | --- | --- |
| `rst` active-high port (`tdm8rx1`) | 1 094 | 15 687.5 | 451 |
| `wire rst_n = ~rst`, flops on `negedge rst_n` (`tdm8rx2`) | 1 094 | 15 687.5 | 451 |
| `SYNTH_ABC_BUFFERING` off, `SYNTH_ABC_AREA_USE_NF`, `AREA 1`: same result. `AREA 3`: 19 413.6. `DELAY 0`: 17 849.6 | not recorded | 15 687.5 to 19 413.6 | 451 (`DELAY 0`: 643) |
| `rst_n` as the port (`tdm8rx3`) | 644 | 13 998.4 | 1 |

**Reason.** Yosys folds an inverter on a reset back into the flop's polarity
before mapping. `dfflegalize` then re-inserts one `$_NOT_` per flop to reach
the library's active-low flop, and OpenLane's final `abc` does not merge them
(the standalone script had an `opt_merge` after `abc`, which is why the laptop
run showed one). Only a reset that is active-low at its source avoids it.
Post-route, `tdm8rx3` against `tdm8rx1`: 2 552 to 2 019 instances, 23 259 to
21 225 µm² (-8.7 %), die 52 005 to 46 796 µm², power -8 %.

**Consequences for later phases.** This is a convention to adopt, not a
one-off. The same per-flop inverter will appear in every module that resets
with an active-high `rst`. Give every converted module an active-low `rst_n`
port, and make the ASIC top-level reset an active-low input (`rst_n`), so no
inverter is left for Yosys to fold across the flattened hierarchy. `top_system`
on the FPGA is not touched. Where the VHDL derives `rst` from something
active-high, invert once in the top level.

**Verification of the change.** [phase0.md](phase0.md), *Netlist-to-RTL check*.

## 2026-09-19 — Hold slack margin 0.1 ns to 0

**Decision.** `PL_RESIZER_HOLD_SLACK_MARGIN` and `GRT_RESIZER_HOLD_SLACK_MARGIN`
set to 0 in `config_tdm8_rx.json`.

**Alternatives.** Keep the 0.1 ns default (447 to 450 hold delay cells, the
largest single growth item in the layout); change CTS settings to cut skew
(no effect on hold cell count in any of nine runs); change the RTL (nothing to
change, the shift register is the design).

**Reason.** The hold cells exist because a 255-stage flop-to-flop shift
register has paths shorter than the clock skew. The default margin roughly
doubles them. Measured: 450 to 246 hold cells, about 2 000 µm² (-9.6 %).
Result is hold slack of +11 ps at the worst of nine corners, with no
violations.

**Cost, stated plainly.** That is no cushion. It is acceptable because this
layout is registered and not fabricated, and no silicon has to tolerate
process variation beyond what the signoff corners cover. It would be the wrong
setting for anything that will run. **Revisit for the full chip:** the margin
is applied to `config_tdm8_rx.json` only. `config.json` is unchanged.

## 2026-09-19 — CTS sink clustering size 25 to 8

**Decision.** `CTS_SINK_CLUSTERING_SIZE` 8 in `config_tdm8_rx.json`.
`CTS_SINK_CLUSTERING_MAX_DIAMETER` left at its default 50.

**Alternatives.** Sizes 6, 7, 9, 10, 12 and diameters 30 and 50, eleven runs
in [runs.md](runs.md). Only 7 and 8 reach zero max-fanout violations. Diameter
30 doubles the clock buffers for no gain. Raising `MAX_FANOUT_CONSTRAINT`
instead would hide the violation rather than remove it.

**Reason.** The 33 violations were all CTS buffers, 14 to 17 sinks against the
PDK limit of 10, because one clock net feeds 450 flops. Size 8 clears them.
Chosen over 7 on clock buffer count (78 against 80).

**Caveat.** It is tuned to this design. 9 and 6 do not pass, so it is not a
robust rule. Expect to redo the sweep for the full chip, which has two clocks.

## 2026-09-19 — FIFO 512 deep, not 1024

**Decision.** `src/async_fifo.v` defaults to `ADDR_WIDTH` 9, 512 x 8.

**Alternatives.** 1024 x 8, the megafunction's size; 256 x 8.

**Reason.** A packet is 410 bytes and `udp_tx_core` reads it only after it is
complete, so 256 cannot work (confirmed, 154 dropped bytes) and 512 is the
smallest power of two. Measured peak occupancy with the real producer and
consumer is 410, or 464 with a 7 µs transmit-line stall. Stall tolerance at 512
is about 15 µs at 96 kHz and about 60 µs at 24 kHz, against a realistic worst
case of about 7 µs. 1024 would cost twice the storage, about 0.18 mm² more,
for headroom nothing uses. Evidence: [fifo.md](fifo.md).

**Cost.** Overflow is silent and unrecoverable, because `packet_formatter`
never checks `wrfull`. The margin is what protects against it. Revisit if the
line can ever stall longer than about 15 µs at 96 kHz.

## 2026-09-19 — Include the decimator (owner decision, needs re-confirmation)

**Decision.** The ASIC includes `decimator`, so `C_DECIMATE` stays `true`, the
frozen firmware's default. Chosen by the project owner from three options.

**Alternatives.** Exclude it and set `C_DECIMATE := false` (the documented
known-good reference configuration, 96 kHz packets); or measure first.

**Status.** Made before the area was known. Measured afterwards: 3.99 mm² and
625 612 cells for the decimator alone, roughly ten times the rest of the
design. **Re-confirmed by the owner the same day, after seeing that figure**
("go do both"). A place-and-route feasibility run followed, see
[phase1.md](phase1.md). Full-effort synthesis is 5.43 mm²; the die is about
15.6 mm².

## 2026-09-19 — `SYNTH_STRATEGY "AREA 3"` for the decimator

**Decision.** Synthesise the decimator with OpenLane's `AREA 3` script.

**Alternatives.** The default `AREA 0`, which was stopped after 30 minutes in
ABC on a 252 000-gate netlist, unfinished.

**Reason.** `AREA 3` finished in 7 minutes. It is the only strategy measured to
finish on this block. Whether the full chip keeps `AREA 0` for everything else
is a Phase 4 question.

## 2026-09-19 — Top-level defaults proposed, three applied on "proceed PLL"

Proposed first, with reasons in [clocking.md](clocking.md) and
[ports.md](ports.md). The owner then said "proceed PLL", and the first, second
and fourth were applied in `patches/0001-top-system-remove-pll.patch`, and the
third in `patches/0002-top-system-split-tristates.patch`. They can still be
reversed.

- **Applied.** Keep `clk_50m_board` as a third clock input rather than fold it
  into `rmii_ref_clk`. The config's `CLOCK_PORT` then has three entries.
- **Applied.** Replace `pll_locked` with an external active-low `rst_n`, keeping
  the packet's status bits and so the wire format.
- **Applied** in patch 0002 on "go do both". Split `eth_mdio` into `_i`,
  `_o` = 0, `_oe` = 0 like the I2C pins.
- **Applied.** Remove the `c3` phase-shifted clock and the LRCLK re-timing
  path, dead while `C_LRCLK_RETIME` is false.

## 2026-09-20 — Phase 2: convert to Verilog with `ghdl --synth`, in one pass

**Decision.** `src/` holds the whole chip as generated Verilog-2005, produced
by `synth/convert_vhdl.sh` in a single `ghdl --synth --out=verilog` pass from
the patched top. No module is hand-converted.

**Superseded on the same day:** the first decision was to keep VHDL end to end
through the GHDL Yosys plugin, on the strength of `CLAUDE.md`'s "keep VHDL end
to end and skip the conversion entirely". That reading ignored the definition
of done ("`src/` contains synthesisable Verilog"), the Phase 4 config
(`dir::src/*.v`) and WORKFLOW.md's Phase 2 route. The owner caught it. The
plugin is still used, as the reference side of the equivalence proofs.

**Why one pass and not file by file.** Three modules take generic values from
the top. Converting files separately bakes in the entity defaults instead -
`BOOT_DELAY_CYCLES` 2 000 000 rather than 7 500 000, and so on - which would
produce a chip that boots wrongly and looks fine. See
[conversion.md](conversion.md).

**Alternatives.** Per-module `ghdl --synth --out=verilog` into `src/*.v`, which
is WORKFLOW.md's Phase 2 route; or hand conversion, which `CLAUDE.md` says to
use only for what the plugin rejects.

**Reason.** `CLAUDE.md` allows one day to try the plugin before falling back.
It took well under a day: the whole chip imports and synthesises in 3.5 minutes
to 628 684 cells, `check` clean, no Altera references. Four things were needed
(`--latches`, `read_liberty` before `check`, the lpflow exclusion, and the FIFO
blackbox swap), all recorded in [conversion.md](conversion.md). Keeping VHDL
means the FPGA sources stay the single source of truth, there is no generated
Verilog to re-verify or to drift, and the DTLST provenance chain is shorter:
our VHDL, our patches, one tool, the netlist.

**Cost.** OpenLane's own `VHDL_FILES` path calls `ghdl` without `--std=08` or
`--latches`, so the Phase 4 flow cannot simply be pointed at the VHDL. Either
the flow runs on a netlist produced by `synth/run_top_ghdl.sh`, or those two
flags have to reach OpenLane's ghdl call. That is the first thing to settle in
Phase 4.

## 2026-09-20 — `tb_chain` and `tb_tdm16` are not usable as gates

**Decision.** Replace them: `tb/tb_tdm16_merge_gate.v` for `tdm16_merge`, and
the top-level `tb/tb_top_port.vhd` for the chain. Record `tb_chain`'s failure
rather than work around it.

**Reason.** `sim/tb_tdm16.vhd` has no assertions at all, and `sim/tb_chain.vhd`
fails on the unmodified FPGA sources. Neither can gate this port.
[conversion.md](conversion.md) has the evidence for both.

**Open.** `tb_chain`'s failure is not diagnosed. It is on the FPGA side, not
ours, but it deserves an hour before anyone trusts the `sim/` directory again.
