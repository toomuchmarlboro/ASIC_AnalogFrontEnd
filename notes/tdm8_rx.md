# tdm8_rx — conversion notes

Source: `rtl/tdm8_rx.vhd` (unmodified). Output: `src/tdm8_rx.v`, Verilog-2005.

The reasoning behind `C_BIT_ADJ`, the edge choices and the frame format lives
in the comments of the VHDL original and is not duplicated here. Read it there.
This file records only what the conversion changed.

## Deviations from the VHDL — there are three

1. **`sdata_f` gained a reset.** The VHDL relies on the initialiser
   `signal sdata_f : std_logic := '0'` and its falling-edge process has no
   reset path. That works on an FPGA because the bitstream loads the flop;
   silicon powers up unknown. The Verilog flop resets to `1'b0`, which is the
   state the FPGA starts in, so behaviour is unchanged wherever `rst` is
   asserted at power-up — and the equivalence run confirms it.

   This is the only flop in the module that had no reset. `shift_reg`,
   `lrclk_d` and `lrclk_d2` carry initialisers too but are already covered by
   the existing reset, so those initialisers are redundant and were dropped.

2. **The reset port is `rst_n`, active-low.** The VHDL port is `rst`,
   active-high. sky130 has only an active-low asynchronous-reset flop
   (`dfrtp`), so an active-high reset costs one inverter in front of every
   flop, 450 of them, and no OpenLane synthesis option or RTL idiom avoids it
   (Yosys folds `wire rst_n = ~rst` straight back into the flop polarity).
   Making the port active-low removes them: run `tdm8rx3` against `tdm8rx1`
   is -8.7 % cell area. Behaviour is the same with `rst_n = ~rst`. The two
   testbenches drive it that way. Decision record: [decisions.md](decisions.md).

3. **Nothing else.** `C_BIT_ADJ` is still `-1`, `shift_reg` is still 264 bits,
   the output latch is still 192, the slice arithmetic is the same expression
   with the same constants.

## Reset style — kept asynchronous, deliberately, now active-low

The brief prefers synchronous reset where the conversion is straightforward.
Here it is not. `rst` is released while `bclk_in` — driven by `tdm8_master`,
which is held in the same reset — is still idle. A synchronous reset would have
no clock edge to act on, so the flops would never leave X. Noted and left as
async, which is what the brief says to do in that case.

## Constants

`C_BIT_ADJ` and `C_RAW_CAPTURE` are `localparam`, not `parameter`. They are
VHDL *constants* in the original, not generics, and `C_BIT_ADJ` must not be
overridable from a wrapper — a wrong value is silent, it just puts every
channel one bit out. The brief's list of build constants to carry across as
parameters (`C_I2C_SWAP`, `C_ENABLE_48V`, …) belongs to `top_system`.

## Sign extension

Nothing to check: the module contains no arithmetic. The only expressions
involving `C_BIT_ADJ` are slice bounds, constant-folded at elaboration in both
languages. `255 + C_BIT_ADJ - 32*k` is signed in Verilog because `C_BIT_ADJ` is
`localparam integer`, matching the VHDL `integer`.

## Verification

Bit-exact against the original in three stimulus configurations, and the known
pattern decodes exactly under the framing the RTL is built for. Method and
numbers in [phase0.md](phase0.md).

Re-verified on the server after the `rst_n` change, against the GHDL-converted
VHDL, the earlier Verilog, and both OpenLane netlists, with three additional
random-stimulus cases that include mid-run resets: `tb/run_tdm8_rx_gate.sh`.
All pass. The ModelSim testbench `tb/tb_tdm8_rx_equiv.vhd` was updated for the
port and has not been re-run.
