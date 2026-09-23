# provenance — the chain from our RTL to the layout

For DTLST this matters more than anything else in `notes/`: it is the recorded
chain showing the layout was derived from our own RTL rather than obtained
elsewhere. Every link is a file with a hash and the exact command that produced
the next one.

Hashes are sha256, shown to 16 characters; the full values are reproducible
with `sha256sum`. Date: 2026-09-20.

## Link 0 — the source RTL

| | |
| --- | --- |
| Repository | `UATR_TDM` (ours, the FPGA design running on hardware) |
| Commit | `c1fc108c68fad7cef11b884a3e889c5dd4281cc6` |
| Vendored copy | `legacy/rtl/`, `legacy/sim/`, byte-identical (`diff -rq`) |
| Read-only | nothing in `legacy/` is ever edited; see `legacy/README.md` |

`legacy/rtl/top_system.vhd` sha256 `60802465b529e30b…`

## Link 1 — the ASIC changes, as patches

The FPGA sources are not edited. The three ASIC-specific changes are unified
diffs applied at build time, so the chain stays *our VHDL + our patches*.

| Patch | What | sha256 |
| --- | --- | --- |
| `patches/0001-top-system-remove-pll.patch` | PLL removed, `clk_24m576` and `rst_n` added, dead LRCLK re-time path dropped | `0975f3136d53966e…` |
| `patches/0002-top-system-split-tristates.patch` | three `inout` ports split into nine unidirectional ones | `cbc0c8f15409efa7…` |
| `patches/0003-top-system-bind-async-fifo.patch` | FIFO bound to `src/async_fifo.v`, with the reset the megafunction lacked | `68751a654208907e…` |

Rebuild: `patch -o t1.vhd legacy/rtl/top_system.vhd patches/0001-*.patch`, then
0002 onto `t1.vhd`, then 0003. Verified byte-identical to the file the
conversion consumed. Each patch is verified against the unpatched design by
simulation: [clocking.md](clocking.md), [ports.md](ports.md).

## Link 2 — conversion to Verilog

| | |
| --- | --- |
| Command | `ghdl --synth --std=08 --latches --out=verilog top_system`, one pass over the whole hierarchy |
| Wrapper | `synth/convert_vhdl.sh` (applies the patches, converts, splits, adds provenance headers) |
| Tool | GHDL 6.0.0 (mcode), see [environment.md](environment.md) |
| Output | `src/*.v`, 14 generated modules, 19 539 lines |

| File | sha256 |
| --- | --- |
| `src/top_system.v` | `f6ccf19e5bc1f3a7…` |
| all of `src/*.v` concatenated | `3ddb7e78611684bf…` |

`src/async_fifo.v` (sha256 `f101cc17cba97dbe…`) is **not** converted: it is
written from scratch to replace the vendor megafunction, which is a legal
requirement, not a technical one. Its design and verification:
[fifo.md](fifo.md).

Equivalence of each converted module to the VHDL it came from is **formally
proven** for 10 of 12 checkable modules, and checked by simulation for the
rest: [conversion.md](conversion.md).

## Link 3 — configuration

| File | Design | sha256 |
| --- | --- | --- |
| `config.json` | `top_system`, the full chip | `3c3d901821a147a8…` |
| `config_tdm8_rx.json` | `tdm8_rx` alone, Phase 0 | `9f2f5856d3b52450…` |

## Link 4 — layout

### Phase 0, complete

| | |
| --- | --- |
| Input | `phase0/tdm8_rx.v` sha256 `f808ffcb82642f87…` (the hand conversion, kept so this run reproduces) |
| Config | `config_tdm8_rx.json` |
| Flow | OpenLane 2.3.10 commit `a7b0e6db…`, PDK sky130A `0fe599b2…`, run tag `tdm8rx4` |
| Output | `runs/tdm8rx4/final/gds/tdm8_rx.gds` sha256 `ec53171cd29fc461…` |
| Signoff | LVS 0 errors, DRC 0, antenna 0 |

Full record: [runs.md](runs.md). The netlist was simulated against the VHDL,
[phase0.md](phase0.md).

### Full chip — not yet built

Phase 4. The synthesis half is proven: `src/*.v` maps to 637 096 sky130 cells,
4.21 mm², with `check` clean ([conversion.md](conversion.md)). Place and route
of the whole chip has not been run; the decimator's feasibility run
([runs.md](runs.md), `decflow`) is what is known so far.

## What this chain does not cover

- The **FPGA sources themselves** are covered by their own repository history,
  not here.
- `legacy/ip/` is deliberately absent: the vendor megafunctions are not
  vendored into the repository that carries the ownership declaration.
- The Phase 0 GDSII is of `tdm8_rx` alone, not the registered design. The
  artifact for filing is the full-chip GDSII, which does not exist yet.
