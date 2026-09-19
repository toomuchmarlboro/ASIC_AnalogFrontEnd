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

### Lab server — recorded 2026-09-19, see the dated entry at the end of this file

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

## Lab server — 2026-09-19

Host `v-maxwell-pc2`, shared machine, no root, no sudo. Manjaro Linux
26.1.0-pre, kernel 6.12.91-1-MANJARO (`uname -a`), 16 cores, 46 GB RAM.

| Tool | Version | How obtained / how to get it |
| --- | --- | --- |
| Nix | 2.20.6, rootless | `nix-portable`, latest release as of 2026-09-19 (no version pinned; hash below) in `~/tools/`, store in `~/tools/np-store` |
| OpenLane | 2.3.10 | `~/openlane2`, commit `a7b0e6dba75ee7e891ff3d7824b29473d9cad289` (`2.3.10-1-ga7b0e6d`), from `git -C ~/openlane2 rev-parse HEAD` |
| PDK | sky130A, volare `0fe599b2afb6708d281543108caf8310912f54af` | `PDK_ROOT` in the run's `resolved.json` |
| Standard cells | `sky130_fd_sc_hd`, signoff corners nom/min/max x tt_025C_1v80, ss_100C_1v60, ff_n40C_1v95 | OpenLane default |
| Yosys | 0.46 (git e97731b9dda9) | inside `nix-shell`, `yosys -V` |
| OpenROAD | `edf00dff99f6c40d67a30c0e22a8191c5d2ed9d6` | inside `nix-shell`, `openroad -version` prints only the commit |
| OpenSTA | 2.6.0 | inside `nix-shell`, `sta -version` |
| Magic | 8.3.489 | inside `nix-shell`, `magic --version` |
| Netgen | 1.5.278 | inside `nix-shell` |
| KLayout | 0.29.4 | inside `nix-shell`, `klayout -v` |
| GHDL, Icarus, Verilator | **not installed on the server** | needed from Phase 1; not needed for Phase 0 |

Note the synthesis tool differs from the laptop: OpenLane's Yosys is 0.46, the
Phase 0 standalone run used 0.69. Numbers from the two are not interchangeable,
see [runs.md](runs.md) `tdm8rx1`.

### Why rootless Nix

The server has no Nix, `/var/run/docker.sock` is `root:docker` and the account
is not in that group, and `sudo` needs a password. The Determinate installer
and the Docker route both need root. User namespaces work
(`unshare -Ur true`), so `nix-portable` runs Nix without root. Cost: 6.2 GB in
`~/tools/np-store` after the first `nix-shell`, plus the PDK under `~/.volare`.
Cache used: `https://openlane.cachix.org`.

### Reproducing the shell

`~/tools/olenv.sh`, which is not in the repo:

```bash
export NP_LOCATION=$HOME/tools/np-store
export NIX_CONFIG="extra-substituters = https://openlane.cachix.org
extra-trusted-public-keys = openlane.cachix.org-1:qqdwh+QMNGmZAuyeQJTH9ErW57OWSvdtuwfBKdS254E=
experimental-features = nix-command flakes"
olrun() { (cd ~/openlane2 && ~/tools/nix-portable nix-shell --run "$1"); }
```

Then `olrun "cd <repo> && openlane --run-tag <tag> <config>.json"`.

Smoke test (`openlane --log-level ERROR --condensed --smoke-test`, run through
`olrun`) exited 0 on this setup.

### Server RTL tools — added 2026-09-19

| Tool | Version | Source |
| --- | --- | --- |
| Icarus Verilog | 13.0 (stable, v13_0) | nixpkgs, flake registry `nixpkgs` |
| GHDL | 6.0.0, mcode backend, GNAT 15.3.0 | same |
| Verilator | 5.052 2026-09-05 | same |
| nix-portable | sha256 `b409c55904c909ac3aeda3fb1253319f86a89ddd1ba31a5dec33d4a06414c72a` | `~/tools/nix-portable` |

Not the same nixpkgs as OpenLane's shell, so these are separate from Yosys 0.46
and the flow tools above. Run through a second wrapper in `~/tools/olenv.sh`:

```bash
tbrun() { (cd ~/tools && ./nix-portable nix-shell -I nixpkgs=flake:nixpkgs -p iverilog ghdl verilator --run "$1"); }
```

`-I nixpkgs=flake:nixpkgs` is needed: nix-portable's default `<nixpkgs>` is old
enough to call the package `verilog`, and `nix shell --command` fails with
`setting up a private mount namespace: Operation not permitted` inside
nix-portable. `nix-shell -p` works.

The sky130 functional cell models used by the gate-level check are in the PDK:
`$PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/verilog/{primitives.v,sky130_fd_sc_hd.v}`,
PDK `0fe599b2afb6708d281543108caf8310912f54af`, compiled with `-DFUNCTIONAL
-DUNIT_DELAY=`. KLayout, Magic and Netgen remain inside the OpenLane
`nix-shell`. ModelSim is still laptop-only.

### Figure tools — added 2026-09-19

| Tool | Version | Where |
| --- | --- | --- |
| Python venv | system `python3`, venv at `~/tools/wave-venv` | `python3 -m venv ~/tools/wave-venv && ~/tools/wave-venv/bin/pip install matplotlib` |
| matplotlib | 3.11.2 | in that venv |
| Pillow | 12.3.0 | in that venv, pulled in by matplotlib, writes the JPEGs |
| Node.js | system `/usr/bin/node` | only for the palette validator |

A separate venv so the shared conda base environment is not modified. Used by
`tb/wave2jpeg.py`, `tb/plots.py` and `tb/make_waveforms.sh`; see
[waveforms.md](waveforms.md).
