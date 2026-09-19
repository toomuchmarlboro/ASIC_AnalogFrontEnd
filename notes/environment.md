# environment — tool versions and why each was chosen

Append entries with a date. Never overwrite an old one: a run that is not
version-pinned will not reproduce next year.

## Versions

### Windows laptop — 2026-09-19

| Tool | Version | Path |
| --- | --- | --- |
| OS | Windows 11 Pro 10.0.22621 | — |
| ModelSim ASE | 16.1 (ModelSim 10.5b) | `C:\intelFPGA\16.1\modelsim_ase\win32aloem` |
| Questa FSE | 2025.2 — compilers only, `vsim` unlicensed | `C:\altera_lite\25.1std\questa_fse\win64` |
| Yosys | 0.69 (git 9f75ca1f9) | OSS CAD Suite `2026-09-18`, Windows x64 |
| Icarus Verilog, Verilator | as shipped in that suite | same |
| Standard cells | `sky130_fd_sc_hd`, corner `tt_025C_1v80` | `pdk/`, from OpenROAD-flow-scripts |
| Quartus Prime Lite | 25.1std | `C:\altera_lite\25.1std` |
| Python | 3.14 | `C:\Python314` |
| GHDL | **not installed** | needed for the Phase 2 route |
| KLayout | **not installed** | needed for Phase 5 plots |

### Lab server — not yet recorded

Fill in on first use: `uname -a`, `lsb_release -a`, `nix --version`,
`git -C ~/openlane2 rev-parse HEAD`, PDK commit from the run's `resolved.json`,
`yosys -V`, `ghdl --version`, `iverilog -V`, `verilator --version`, and each of
Magic, Netgen, KLayout, OpenSTA inside `nix-shell`.

## Why these tools

This machine is Windows 11 with no admin rights in the working session. What
follows is what actually runs here, found rather than assumed.

## Simulation — ModelSim ASE 16.1

`C:\intelFPGA\16.1\modelsim_ase\win32aloem`. VHDL-2008 and Verilog-2005, mixed
language, no licence file needed. This is what `tb/run_tdm8_rx_equiv.sh` uses.

Questa FSE 25.1 is also installed (`C:\altera_lite\25.1std\questa_fse\win64`)
and is the newer tool. `vcom`, `vlog` and `vmap` work; **`vsim` refuses to
start without a licence** (`SALT_LICENSE_SERVER` unset). If a licence is ever
obtained, switch by setting `MSIM=C:/altera_lite/25.1std/questa_fse/win64` —
nothing else in the scripts needs to change.

Mixed-language instantiation is load-bearing for the equivalence testbenches:
the VHDL reference and the converted Verilog are instantiated in the same
testbench, the Verilog from library `conv` via `entity conv.<name>`.

## Synthesis — Yosys 0.69

From the OSS CAD Suite Windows build (2026-09-18 release), unpacked in the
session scratchpad; it needs no installation and no admin rights. It also
carries Icarus Verilog and Verilator, which are the fallback if the ModelSim
route ever goes away.

`yowasp-yosys` (pip) was tried first — it runs, but it cannot execute ABC, so
it dies silently partway through technology mapping. Not usable for this.

## PDK — liberty only

`pdk/sky130_fd_sc_hd__tt_025C_1v80.lib`, 12.8 MB, taken from
OpenROAD-flow-scripts (`flow/platforms/sky130hd/lib/`). That is enough for
`dfflibmap`, `abc` and area reporting, and nothing else in Phase 0 needs a full
PDK. The full sky130A — LEF, GDS, tech files — is only needed once the flow
runs, and it comes with OpenLane.

The Google `skywater-pdk-libs-sky130_fd_sc_hd` repository stores `.lib.json`,
not `.lib`; it needs the PDK build flow to produce a usable liberty. Do not go
there for a quick file.

## Place and route — not available

No Docker, no WSL distribution, no Windows builds of OpenROAD, Magic, KLayout
or Netgen. See [phase0.md](phase0.md), *Blocker*.

## Layout note

`pdk/`, `out/` and `.sim/` are working directories, not part of the design.
Only `src/`, `tb/`, `notes/` and `config.json` are deliverables.
