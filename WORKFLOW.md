# WORKFLOW — UATR_TDM ASIC port

Operational procedure. For rules and constraints see [CLAUDE.md](CLAUDE.md).

**Target:** SKY130 GDSII of the UATR_TDM RTL, for DTLST registration with DJKI.
Registration only — not fabrication.
**Deadline:** mid-October 2026.

---

## Status

| Phase | State |
| --- | --- |
| 0 — prove the path | Synthesis done. **OpenLane back end not yet run** |
| 1 — vendor IP removal | Starting |
| 2 — bulk conversion | Not started |
| 3 — integration | Not started |
| 4 — flow | Not started |
| 5 — filing artifacts | Not started |

Phase 0 result: `tdm8_rx` synthesises to 644 cells, 13 432.88 µm², 450 flops,
83.8 % sequential. Projected core ~38 000 µm² at 35 % utilisation, about 195 µm
square. A 16-channel system fits inside 1 mm² comfortably.

**Open risk:** the back end (OpenROAD, Magic, Netgen) is unproven. Clean synthesis
says nothing about routing congestion, the power grid or LVS. This must be retired
by **1 October**.

---

## Machines

**No WSL. No Docker.** The Windows laptop runs native Windows builds only; the lab
server runs the Linux toolchain over SSH.

**The server is the primary machine.** Everything that can run there, runs there —
one toolchain to install, one environment to debug, and the machine with the RAM.
Windows is a client plus three things it does better.

### Which phase must run where

| Phase | Machine | Why |
| --- | --- | --- |
| 0 — back-end proof | **MUST be Linux** | OpenLane |
| 1 — vendor IP removal | Either; **do it on the server** | Text and RTL work |
| 2 — bulk conversion | Either; **do it on the server** | GHDL runs on both |
| 3 — integration | Either; **do it on the server** | Text and RTL work |
| 4 — flow to GDSII | **MUST be Linux** | OpenLane |
| 5a — layout plots | Either | KLayout runs on both |
| 5b — uraian, filing | **Windows** | Office documents, DJKI portal |
| Quartus cross-check | **Windows** | Your Quartus install is there |

Only two things genuinely *must* be Linux, and they are the same thing: OpenLane.
Nothing on the RTL side is Windows-only. So the simplest arrangement is to do the
work on the server and keep Windows for the GUI and the paperwork.

### Why OpenLane cannot run on Windows

OpenLane is distributed as a Nix flake or a Docker image, and both require Linux.
The tools inside it — OpenROAD, Magic, Netgen, OpenSTA — have no native Windows
builds. With WSL and Docker off the table, **the lab server is the only place the
flow can run.** That makes the 1 October gate a hard dependency on server access,
not a preference.

---

## One-time setup

### Server — primary (Linux, over SSH)

Install the full toolchain here. This is where you will spend most of your time.

```bash
# --- Nix, with the OpenLane binary cache ---
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install --no-confirm --extra-conf "
extra-substituters = https://openlane.cachix.org
extra-trusted-public-keys = openlane.cachix.org-1:qqdwh+QMNGmZAuyeQJTH9ErW57OWSvdtuwfBKdS254E=
"
# close all terminals, reconnect

# --- OpenLane + SKY130 PDK ---
git clone https://github.com/efabless/openlane2.git
cd openlane2 && nix-shell
openlane --log-level ERROR --condensed --show-progress-bar --smoke-test

# --- RTL toolchain (Debian/Ubuntu) ---
sudo apt install ghdl gtkwave iverilog verilator git
# or use OSS CAD Suite linux-x64, which bundles Yosys, GHDL,
# the ghdl-yosys-plugin, Icarus, Verilator and Surfer in one tarball:
#   https://github.com/YosysHQ/oss-cad-suite-build/releases
#   source <path>/oss-cad-suite/environment

# --- KLayout, if you want plots without pulling files down ---
sudo apt install klayout
```

The smoke test downloads the PDK as a side effect. Needs ~16 GB RAM free and
30–50 GB disk.

**Run this before starting Phase 1.** It is the unproven part of the project.

Note the Linux build of OSS CAD Suite *does* include GHDL and the
ghdl-yosys-plugin — the Windows build does not. Another reason to work server-side.

### Windows laptop — client

Three jobs: SSH terminal, GUI viewing, paperwork. Install only what serves those.

| Tool | Source | For |
| --- | --- | --- |
| Windows Terminal + OpenSSH | Built in | SSH sessions to the server |
| Git for Windows | git-scm.com | Local clone, if you edit locally |
| KLayout | klayout.de installer | Viewing GDSII pulled down from the server |
| Quartus Prime Lite | Already installed | Cross-checking converted Verilog |
| Office / LibreOffice | — | The uraian |

Optional, only if you want to work locally rather than over SSH:

| Tool | Source | Note |
| --- | --- | --- |
| GHDL | MSYS2: `pacman -S mingw-w64-ucrt-x86_64-ghdl-mcode` | mcode backend, native Windows |
| OSS CAD Suite (Windows x64) | GitHub releases, `environment.bat` | Yosys, Icarus — **no GHDL, no plugin** |

If you take the optional route, the conversion command is
`ghdl --synth --out=verilog`, which needs no plugin and works identically on both
platforms. That is why nothing on the RTL side is locked to Linux.

### Working over SSH

Claude Code runs fine on the server over SSH — that is a normal, supported setup.
The login flow wants a browser, so either paste the callback URL back into the
terminal, or forward the port:

```bash
ssh -L 54545:localhost:54545 user@labserver
```

For KLayout's GUI, three options in order of preference: pull the GDSII down and
view it in native Windows KLayout (simplest, the files are small); AnyDesk to the
server desktop; or X11 forwarding with `ssh -X`, which is usually sluggish for
layout viewing.

```bash
scp user@labserver:~/UATR_TDM/asic/runs/full1/final/gds/top_system.gds .
```

---

## The loop

Server-side, the normal case:

```
server (SSH):  edit → ghdl --synth → verify → openlane run → inspect reports
laptop:        scp the GDSII down → klayout → plots
```

If you prefer editing locally:

```
laptop:  edit → verify → commit → push
server:  pull → openlane run → commit results
laptop:  pull → klayout → plots
```

Keep `asic/` on its own branch. Never merge it into whatever branch the Quartus
build tracks.

```bash
git checkout -b asic-port
```

---

## Documentation

**Standing rule: anyone joining this project later must be able to rebuild every
artifact from the repository alone, without asking.**

Two reasons. Handover — this outlives whoever is at the keyboard. And DTLST
provenance: if originality is ever challenged, the documented chain from our RTL to
the GDSII is the evidence that the layout is our own work.

### Where it lives

```
asic/notes/
├── README.md          index — what each file is, read first
├── environment.md     exact tool versions (write this first)
├── provenance.md      the RTL → GDSII chain
├── decisions.md       why non-obvious choices were made
├── phase0.md          synthesis proof
├── clocking.md        PLL removal, external clock requirement
├── fifo.md            CDC FIFO design and verification
├── ports.md           tristate split, top-level port map
├── conversion.md      per-module conversion record
├── integration.md     top level, clock domains, CDC inventory
├── runs.md            one entry per OpenLane run, including failures
├── results.md         final numbers
├── drc.md             remaining violations, if any
└── filing.md          plots, uraian claims, evidence map
```

### Three rules

1. **Never record a result without the command that produced it.** A number with no
   command is not reproducible, and at review time you will not remember.
2. **Record versions, not just tool names.** OpenLane and the SKY130 PDK are moving
   targets. A run that is not version-pinned will not reproduce next year.
3. **Write deviations down when they happen.** Reconstructed reasoning is wrong
   reasoning. If you lowered utilisation to 25, say so and say why, that day.

### environment.md — write this before Phase 1

The single most important file for reproducibility. Without it the flow cannot be
rerun, because the tools will have moved.

| Record | How to get it |
| --- | --- |
| OS and kernel | `uname -a`, `lsb_release -a` |
| Nix | `nix --version` |
| OpenLane commit | `git -C ~/openlane2 rev-parse HEAD` |
| PDK version / commit | from the OpenLane run's `resolved.json` |
| Yosys | `yosys -V` |
| GHDL | `ghdl --version` |
| Icarus / Verilator | `iverilog -V`, `verilator --version` |
| Magic, Netgen, KLayout, OpenSTA | inside `nix-shell`, each `--version` |
| Standard cell library | e.g. `sky130_fd_sc_hd`, corner `tt_025C_1v80` |

Update it with a date whenever anything changes. Never overwrite the old entry —
append.

### What each phase must document

| Phase | File | Must contain |
| --- | --- | --- |
| 0 | `phase0.md` | Synthesis script, liberty file and corner, `abc` target, cell and area and flop counts, cell-type breakdown, interpretation, and any blocker |
| 1a | `clocking.md` | What was removed, the new input port, the external 24.576 MHz requirement, the board implication |
| 1b | `fifo.md` | **The megafunction's original width and depth as read, not guessed.** Chosen width and depth, with justification if different. Pointer structure and why the Gray coding is safe. Verification result against `tb_chain` |
| 1c | `ports.md` | Signal-by-signal mapping of each `inout` to its three ports, and confirmation the open-drain semantics are unchanged |
| 2 | `conversion.md` | Per module: source file, **source git commit**, exact GHDL command, output file, testbench used, pass/fail, date. Any module hand-converted and why GHDL rejected it |
| 3 | `integration.md` | Full top-level port list with widths and directions, every parameter and its default, clock domain map, and a complete inventory of CDC crossings |
| 4 | `runs.md` | One entry per run: tag, date, config changes against the previous run, outcome, where it failed if it did, key numbers. **Never delete failed runs** — they are how the next person avoids the same wall |
| 4 | `results.md`, `drc.md` | Final area, cell count, frequency, power, each traceable to a run tag. Remaining DRC violations enumerated with rule names |
| 5 | `filing.md` | Which plots were produced, the exact KLayout command or script for each, what the uraian claims, and where the evidence for each claim lives |

### provenance.md — the chain

For DTLST this matters more than anything else in `notes/`. One unbroken, recorded
chain:

```
source VHDL (git commit)
  → conversion command + GHDL version
    → Verilog netlist (file, hash)
      → config.json + run tag
        → GDSII (file, hash, date)
```

Record it as a single table with one row per link. This is what demonstrates the
layout was derived from our own RTL rather than obtained elsewhere.

### decisions.md

One entry per non-obvious choice, in the format the repository's existing
architecture decisions log already uses: date, decision, alternatives considered,
reason.

Things that will need entries: the FIFO depth if it changes from the megafunction's,
the decision to keep the 192 enable muxes rather than drop the output-register
reset, every utilisation and clock-period relaxation, and the fallback trigger if it
fires.

### Gate rule

**A phase is not complete until its document is written.** Not "written up later" —
the document is part of the deliverable, and the reasoning is only accurate while
it is fresh.

---

## Phase 1 — Vendor IP removal

The critical path. Three items. Nothing downstream works until these are done.

### 1a. Remove the PLL — half a day

Delete the `u_pll` instance from `top_system`. Add `clk_24m576` as an input port,
drive the audio domain from it directly, remove the `c0`/`c1`/`c2` selection logic.

Record in `asic/notes/clocking.md` that the design requires an external 24.576 MHz
master clock source.

### 1b. Reimplement the async FIFO — two to four days

**Before writing anything, report the current width and depth.** Read them from the
megafunction parameters — do not guess. If the depth looks like a wizard default
rather than a calculated requirement, propose a smaller one; area matters and a
shallower FIFO that still covers the burst is acceptable.

Structure:

- Storage array, depth a power of two
- Binary read and write pointers, one extra bit for full/empty disambiguation
- Each pointer Gray-coded before crossing
- Each Gray pointer through two flip-flops in the destination domain
- `full` and `empty` derived from the synchronised pointers

Verify against `sim/tb_chain.vhd`.

### 1c. Split the tristates — half a day

```
inout sda  →  input sda_i, output sda_o, output sda_oe
inout scl  →  input scl_i, output scl_o, output scl_oe
```

Keep the internal open-drain semantics identical. Tristate resolution belongs to a
pad cell, which this design does not have and does not need.

### Gate

```bash
grep -rniE 'altera|altpll|lpm_|scfifo' asic/src/   # must return nothing
```

---

## Phase 2 — Bulk conversion

Use GHDL's synthesis output rather than hand conversion. This works on Windows and
needs no plugin:

```bash
ghdl -a --std=08 rtl/tdm8_master.vhd
ghdl --synth --std=08 --out=verilog tdm8_master > asic/src/tdm8_master.v
```

Dependency order:

```
tdm8_master  tdm8_rx  tdm16_merge  crc32
rmii_tx  rmii_rx  arp_responder
udp_tx_core  udp_rx_core
packet_formatter
i2c_master  adau_sequencer
top_system
```

Exclude `tdm16_rx.vhd` — built but not active.

Hand-convert only modules GHDL rejects. Do not hand-convert by preference.

### Per-module gate

| Module | Verify against |
| --- | --- |
| `tdm8_rx` | `sim/tb_tdm8_rx.vhd` |
| `tdm16_merge` | `sim/tb_tdm16.vhd` |
| `crc32` | `"123456789"` → `0x649C2FD3`; RX residue `0xC704DD7B` |
| full chain | `sim/tb_chain.vhd` |

A module is not converted until its check passes.

---

## Phase 3 — Integration

Top level with the Phase 1 port changes applied:

- `clk_24m576` input replacing the PLL
- `rmii_ref_clk` input, 50 MHz
- I2C as six unidirectional ports
- No `inout` anywhere

Carry the build constants across as parameters with unchanged defaults:
`C_I2C_SWAP`, `C_ENABLE_48V`, `C_BUFFER_EN_ACTIVE_HIGH`, `C_SOFT_RESET_FIRST`,
`C_VERIFY_IDX`. `C_I2C_SWAP = true` compensates a schematic error and is
load-bearing.

`C_BIT_ADJ = -1` stays exactly as written.

---

## Phase 4 — Flow

`asic/config.json`:

```json
{
  "DESIGN_NAME": "top_system",
  "VERILOG_FILES": "dir::src/*.v",
  "CLOCK_PORT": ["clk_24m576", "rmii_ref_clk"],
  "CLOCK_PERIOD": 40,
  "FP_CORE_UTIL": 35,
  "PL_TARGET_DENSITY_PCT": 40,
  "SYNTH_STRATEGY": "AREA 0",
  "RUN_LINTER": true
}
```

On the server:

```bash
cd ~/openlane2 && nix-shell
openlane --run-tag full1 ~/UATR_TDM/asic/config.json
```

Tag every run meaningfully — `full1`, `util30`, `clk60ns` — so runs can be compared
rather than overwritten.

### When it fails

**Relax the constraint rather than fix the design.** This layout is for
registration, not deployment. The Cyclone IV already does the real job.

| Symptom | Action |
| --- | --- |
| Routing congestion | `FP_CORE_UTIL` 35 → 30 → 25 |
| Negative setup slack | `CLOCK_PERIOD` 40 → 50 → 60 ns |
| Cell count explosion | Report which module before changing anything |
| CDC paths outside the FIFO | Real bug — report it, it affects the FPGA build too |
| Antenna violations | Enable diode insertion |
| LVS mismatch | Check every port is driven, check PDN covers the core |

### Acceptance

| Result | Required? |
| --- | --- |
| Flow completes to GDSII | Yes — this is the deliverable |
| LVS clean | Strongly wanted — proves the layout is the circuit described |
| DRC clean | Wanted, not required |
| Timing closed | Useful for the uraian, not a blocker |

---

## Phase 5 — Filing artifacts

```bash
klayout runs/full1/final/gds/top_system.gds
```

Produce, as high-resolution images or PDF:

1. Full die, all layers
2. Per-layer plots — each metal layer separately, plus the cell layer
3. A zoom into a routed region where individual cells and wires are distinguishable
4. **An annotated floorplan** with each block labelled — the two `tdm8_rx`
   instances, `tdm16_merge`, `packet_formatter`, the FIFO, the MAC, the sequencer

Item 4 has to be made by hand and is the most valuable. It is what turns a picture
into evidence that the layout implements the described system.

### The uraian

Write it around what makes the design specific — originality is the registrability
test. Cover:

- Function: 16-channel 24-bit 96 kHz acquisition, TDM deserialisation, framing, UDP
- Block architecture, matching the annotated floorplan
- Design choices that are ours: 2× TDM8 rather than TDM16 or 4× TDM4, 32-BCLK slot
  width, external 24.576 MHz master clock, the Gray-code CDC FIFO
- Process: SKY130 130 nm CMOS, standard-cell digital
- Numbers from Phase 4: die area, cell count, clock frequency, power
- **The enable-mux finding.** sky130 has `edfxtp` (enable) and `dfrtp` (reset) but
  no cell with both, so the output latch enable becomes a feedback mux per bit —
  192 muxes, 2 162 µm², 16 % of `tdm8_rx`. On the Cyclone IV the logic element has
  both built in and this costs nothing. A concrete, design-specific example of the
  silicon layout differing structurally from the FPGA mapping.

The repository's architecture decisions log already covers most of this, including
*why* 2× TDM8 over the alternatives — which is exactly the not-commonplace argument.

### Archive

Keep RTL, config, the full run directory and the GDSII together, dated. If
originality is challenged, the run log showing the design built from our own
sources is the evidence.

---

## Gates and dates

| Date | Gate | If missed |
| --- | --- | --- |
| **now** | `environment.md` written, versions pinned | Nothing downstream is reproducible until this exists |
| **1 Oct** | OpenLane back end proven on `tdm8_rx`, `phase0.md` closed | Escalate. This is a project-level risk, not a task |
| **2 Oct** | Phase 1 complete, no vendor IP in `asic/src/`, `clocking.md` + `fifo.md` + `ports.md` written | Compress Phase 2 by converting only the fallback scope |
| **8 Oct** | **Complete full-stack GDSII**, `runs.md` current | **Switch to fallback scope** |
| **12 Oct** | Plots and uraian drafted, `provenance.md` complete | File with whatever DRC state exists |
| mid-Oct | Submitted through Sentra HKI | — |

Each gate carries its documentation. A phase whose document is unwritten has not
passed its gate, regardless of whether the code works.

### Administrative, parallel track

Runs alongside the engineering, not after it.

- Confirm Sentra HKI internal lead time **this week**. If they need two weeks, the
  real engineering deadline is early October, not mid-October
- Ask DJKI, via Sentra HKI, whether a standard-cell layout generated by an automated
  flow from our own RTL is registrable. Should be yes — the layout is the work, and
  RTL origin establishes ownership — but confirm before committing the effort
- Draft the ownership declaration
- Fee: Rp400 000 for educational institutions, against Rp700 000 for a general
  individual applicant. File under ITS

---

## Fallback scope

If there is no complete GDSII by **8 October**, drop to the audio path only:
two `tdm8_rx` instances, `tdm16_merge`, `packet_formatter`.

This removes the async FIFO entirely — it exists only to cross from the 24.576 MHz
audio domain to the 50 MHz Ethernet domain, and the audio path alone is
single-clock. That deletes the riskiest work item rather than shrinking it, and
removes the two-clock-tree problem from the flow at the same time.

A 16-channel TDM acquisition and framing macro is still a specific system and still
defensible as an original layout design.

**Make this call on the date, not by optimism.**
