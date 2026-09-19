# ASIC port of UATR_TDM — working brief

## Goal

Produce a SKY130 GDSII of the UATR_TDM RTL using OpenLane, for registration as a
Desain Tata Letak Sirkuit Terpadu (DTLST) with DJKI Indonesia.

**Registration only. This design will not be fabricated.** There is no tapeout, no
shuttle, no foundry. The GDSII itself is the deliverable.

Deadline: mid-October 2026.

---

## Hard rules

1. **Never modify `rtl/`, `ip/`, `sim/`, `hardware/`, `python/`, or the Quartus
   project files** (`TDM_UATR.qpf`, `.qsf`, `.sdc`). The FPGA build is running on
   live hardware and must keep working. All ASIC work lives in `asic/`.

2. **No third-party IP in the output.** The DTLST ownership declaration asserts the
   design is ours. Altera megafunctions must be *removed and reimplemented*, not
   wrapped, stubbed, or black-boxed. This is a legal requirement, not a technical
   preference.

3. **Behavioural equivalence is the requirement.** Every converted module must pass
   its existing testbench before it goes near synthesis. Do not improve, refactor,
   or optimise the RTL during conversion.

4. **Verilog-2005 only.** Yosys has mature Verilog-2005 support. No SystemVerilog,
   no VHDL-2008 constructs leaking through.

---

## Directory layout

Create and work only in:

```
asic/
├── src/              converted Verilog, synthesisable
├── tb/               testbenches (Verilog or VHDL via GHDL)
├── notes/            conversion notes, one .md per non-obvious module
└── config.json       OpenLane configuration
```

---

## Task order

Do not reorder these. Phase 0 exists specifically to catch systemic problems before
bulk work.

### Phase 0 — Prove the path with one module

Convert **`rtl/tdm8_rx.vhd` only**. Verify against `sim/tb_tdm8_rx.vhd`. Get it
through OpenLane to a GDSII.

Stop here and report the area and cell count before doing anything else. If this
module cannot get through the flow, nothing else will either, and the plan changes.

### Phase 1 — Remove the vendor IP

Three items, detailed below. This is the critical path of the project.

### Phase 2 — Bulk conversion

The remaining modules, in dependency order, each verified against its testbench.

### Phase 3 — Integration

Top level, port list, both clock domains.

### Phase 4 — Flow

Full-stack OpenLane run, iterate to a clean GDSII.

---

## File inventory

| Source | Action | Notes |
| --- | --- | --- |
| `rtl/tdm8_rx.vhd` | Convert first | 264-bit shift register + 192-bit latch. Phase 0 target |
| `rtl/tdm8_master.vhd` | Convert | Generates LRCLK, 1 BCLK pulse at 96 kHz |
| `rtl/tdm16_merge.vhd` | Convert | Merges two TDM8 streams into 16 channels |
| `rtl/crc32.vhd` | Convert | Golden vectors exist — see Verification |
| `rtl/rmii_tx.vhd` | Convert | RMII MAC TX |
| `rtl/rmii_rx.vhd` | Convert | RMII MAC RX |
| `rtl/udp_tx_core.vhd` | Convert | Ethernet + IP + UDP headers |
| `rtl/udp_rx_core.vhd` | Convert | UDP receive, gain control |
| `rtl/arp_responder.vhd` | Convert | ARP replies |
| `rtl/packet_formatter.vhd` | Convert | 410-byte payload. Watch the buffer — likely the largest block by area |
| `rtl/i2c_master.vhd` | Convert | Open-drain output needs splitting — see below |
| `rtl/adau_sequencer.vhd` | Convert | Register boot FSM |
| `rtl/top_system.vhd` | Convert last | Needs port changes — see Phase 3 |
| `rtl/tdm16_rx.vhd` | **Exclude** | Built but not active in the current configuration |
| `ip/pll_audio/pll_audio.vhd` | **Delete** | ALTPLL megafunction — see Phase 1 |
| `ip/async_fifo/async_fifo.vhd` | **Reimplement** | Altera FIFO megafunction — see Phase 1 |

---

## Phase 1 in detail

### 1a. Remove the PLL

Delete the `u_pll` instance from the top level. Add `clk_24m576` as an input port and
drive the audio domain from it directly.

Remove the `c0` / `c1` / `c2` output-selection logic — the ASIC takes one external
master clock. Record in `asic/notes/clocking.md` that the design requires an external
24.576 MHz clock source.

### 1b. Reimplement the async FIFO

Write a generic dual-clock FIFO in Verilog. Standard structure:

- Storage array, depth a power of two
- Binary read and write pointers, one extra bit for full/empty disambiguation
- Each pointer converted to Gray code before crossing
- Each Gray pointer through two flip-flops in the destination domain
- `full` and `empty` derived from the synchronised pointers

Before writing it, **read the existing `.qip`/megafunction parameters and report the
current width and depth.** Do not guess. If the depth looks like a wizard default
rather than a calculated requirement, say so and propose a smaller one — area matters
here and a shallower FIFO that still covers the burst is acceptable.

Verify against `sim/tb_chain.vhd`.

### 1c. Split the tristates

`top_system.vhd` uses open-drain buffers for I2C. Replace each bidirectional port
with three unidirectional ports:

```
inout  sda   →   input sda_i, output sda_o, output sda_oe
inout  scl   →   input scl_i, output scl_o, output scl_oe
```

Tristate resolution belongs to a pad cell, which we do not have and do not need.
Keep the internal open-drain semantics identical.

---

## Conversion rules

Mechanical mappings:

| VHDL | Verilog |
| --- | --- |
| `process(clk)` + `rising_edge(clk)` | `always @(posedge clk)` |
| `std_logic_vector(N-1 downto 0)` | `wire` / `reg [N-1:0]` |
| `generic` | `parameter` |
| `signed` / `unsigned` | `signed` / plain |
| `others => '0'` | `{N{1'b0}}` |

Things that will bite:

- **Sign extension.** VHDL forces explicit conversions; Verilog does them
  implicitly. This is where conversion bugs hide. Check every arithmetic expression
  involving mixed widths.
- **Initial values.** `signal x : std_logic := '0'` works on an FPGA because the
  bitstream loads a known state. Silicon powers up unknown. Every such signal needs
  an explicit reset instead. Flag any you find that have no reset path.
- **Reset style.** Convert asynchronous reset to synchronous where it is
  straightforward. Do not restructure reset trees to achieve this — note it and
  move on.

Things that must not change:

- **`C_BIT_ADJ = -1`** in `tdm8_rx`. This offset was found by measurement, not
  derived. Preserve it exactly.
- **Register widths.** The 264-bit shift register and 192-bit output latch are
  sized deliberately. Do not "simplify" them.
- **Build constants.** `C_I2C_SWAP`, `C_ENABLE_48V`, `C_BUFFER_EN_ACTIVE_HIGH`,
  `C_SOFT_RESET_FIRST`, `C_VERIFY_IDX` — carry across as parameters with the same
  defaults. `C_I2C_SWAP = true` compensates a schematic error and is load-bearing.

---

## Verification

Every module gets checked before it moves on.

| Module | Check against |
| --- | --- |
| `tdm8_rx` | `sim/tb_tdm8_rx.vhd` — known pattern, frame assertions after three frames |
| `tdm16_merge` | `sim/tb_tdm16.vhd` — 16-channel merge |
| Full chain | `sim/tb_chain.vhd` |
| `crc32` | `"123456789"` must produce `0x649C2FD3`; RX residue `0xC704DD7B` |

Use Icarus Verilog or Verilator. Where a testbench is VHDL, either convert it too or
drive the converted module through GHDL co-simulation — whichever is faster, but the
check must actually run.

**Do not report a module as converted until its check passes.**

---

## Alternative route: GHDL plugin

Before hand-converting anything beyond Phase 0, spend **one day maximum** trying
`ghdl-yosys-plugin` against the real sources:

```bash
ghdl -a --std=08 rtl/tdm8_master.vhd rtl/tdm8_rx.vhd rtl/tdm16_merge.vhd
# ... remaining files in dependency order
yosys -m ghdl -p 'ghdl --std=08 top_system; synth -top top_system'
```

If everything analyses and `synth` completes, keep VHDL end to end and skip the
conversion entirely. If it rejects constructs, **stop at the end of the day** and
fall back to per-module `write_verilog`:

```bash
yosys -m ghdl -p 'ghdl --std=08 tdm8_rx; write_verilog -noattr asic/src/tdm8_rx.v'
```

Do not spend more than a day fixing plugin errors one construct at a time. That
failure mode is what eats the schedule.

---

## OpenLane configuration

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

Two clock domains. The reimplemented FIFO should be the only crossing between them —
if synthesis reports CDC paths anywhere else, that is a real bug worth reporting,
since the Quartus SDC was probably declaring it a false path.

Leave the floorplan automatic. Do not set a die size.

---

## When things fail

**Relax the constraint rather than fix the design.** This layout is for registration,
not deployment — the Cyclone IV already does the real job at 96 kHz. Nothing is
gained by closing timing we do not need.

- Routing congestion → drop `FP_CORE_UTIL` to 30, then 25
- Negative setup slack → raise `CLOCK_PERIOD` to 50 or 60 ns
- Cell count explosion → report which module caused it before changing anything

---

## Do not

- Fix the open LRCLK hold violation. That is an FPGA board timing issue tracked in
  `docs/LRCLK_HOLD_VIOLATION.md` and is separate work.
- Change `C_BIT_ADJ`.
- Add SystemVerilog.
- Wrap the design in Caravel, Caravan, or OpenFrame. Those harnesses are third-party
  layout and we are not fabricating.
- Touch the Quartus project or anything the FPGA build depends on.
- Refactor working RTL while converting it.
- Attribute Claude anywhere in the repository history. No `Co-Authored-By:
  Claude`, no "Generated with Claude Code" footer, not in commit messages, not
  in pull request bodies, not in file headers. The design is ours and the
  history should read that way.

---

## Fallback scope

If the full stack will not close by **8 October**, drop to the audio path only:
two `tdm8_rx` instances, `tdm16_merge`, `packet_formatter`.

This removes the need for the async FIFO entirely — the FIFO exists only to cross
from the 24.576 MHz audio domain to the 50 MHz Ethernet domain, and the audio path
alone is single-clock. That deletes the riskiest work item rather than shrinking it.

A 16-channel TDM acquisition and framing macro is still a specific system and still
defensible as an original layout design.

---

## Definition of done

- `asic/src/` contains synthesisable Verilog with no Altera references
  (grep for `altera`, `altpll`, `lpm_`, `scfifo` — must return nothing)
- Every module passes its testbench
- OpenLane completes to GDSII
- LVS clean
- DRC clean, or remaining violations enumerated in `asic/notes/drc.md`
- Area, cell count, clock frequency and power recorded in `asic/notes/results.md`
