# phase0 — the hand-converted tdm8_rx

`tdm8_rx.v` is the Phase 0 conversion: written by hand from
`legacy/rtl/tdm8_rx.vhd`, verified bit-exact against it, and the source of the
Phase 0 GDSII (run `tdm8rx4`, see `notes/runs.md`). `config_tdm8_rx.json`
points here, so that run still reproduces.

It is **not** part of the chip. The chip's `tdm8_rx` is in `src/`, generated
with everything else from the VHDL in Phase 2, so that one tool and one source
produce the whole design. The two differ in one way that matters: this one
takes an active-low `rst_n`, which saves about 11 % of the module's area, and
the generated one keeps the VHDL's active-high `rst`. Chip-wide that saving is
about 0.04 %, which is why it was not carried across. See
`notes/conversion.md`, *Open*.

Kept because it is verified work, it is what the Phase 0 numbers were measured
on, and it is the worked example of what a hand conversion of this design looks
like if the GHDL route ever has to be abandoned.
