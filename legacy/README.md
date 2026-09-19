# legacy — the FPGA sources, read-only

Copy of the VHDL this port is derived from, so the verification testbenches
have their reference in the clone and the conversion chain is recorded in one
place.

| | |
| --- | --- |
| Source | `TDM_UATR` repo, `rtl/` and `sim/` |
| Commit | `c1fc108c68fad7cef11b884a3e889c5dd4281cc6` |
| Dated | 2026-09-17 — *Add claw actuator control, and vendor HACAR_dash's Device Status window* |
| Working tree at copy | clean |
| Copied | 2026-09-19 |

**Never edit anything in here.** It is a reference, not a source. The FPGA build
runs off the real repo and that is the only copy that matters. To refresh, copy
again and update the commit above — do not patch files in place, or the chain
stops meaning anything.

## What was left out

`ip/` — the Altera megafunctions, `pll_audio` and `async_fifo`. They are
third-party and the whole point of Phase 1 is that they do not appear in this
design. Vendoring them into the repo that carries our ownership declaration
would be careless even in a folder marked legacy.

The FIFO's width and depth still have to be read from the real megafunction
rather than guessed. That happens on the Windows machine, where the Quartus
project is, and the numbers go in `notes/fifo.md`.

`decimator.vhd`, `decim_coef_pkg.vhd`, `net_pkg.vhd` and `tdm16_rx.vhd` were
copied with the rest for completeness. `tdm16_rx` is excluded from the port —
built but not active in the current configuration.
