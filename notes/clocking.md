# clocking — PLL removal, the external clock, domains, reset (Phase 1a)

Written from `UATR_TDM` commit `c1fc108c68fad7cef11b884a3e889c5dd4281cc6`.
Date: 2026-09-19.

**Status: implemented as a patch and verified.** `top_system` itself is
converted to Verilog last (Phase 3); until then the change lives as
`patches/0001-top-system-remove-pll.patch` against the vendored
`legacy/rtl/top_system.vhd`, so the chain stays *legacy VHDL, patch, GHDL,
Verilog*. See *The patch* and *Verification* at the end.

**Requirement: the design needs an external 24.576 MHz clock source.**

## What `u_pll` provides today

`pll_audio` (ALTPLL, `ip/pll_audio`) takes `clk_50m_board` and produces:

| Output | Frequency | Used for |
| --- | --- | --- |
| `c0` | 12.288 MHz | nothing, `open` |
| `c1` | 18.432 MHz | nothing, `open` |
| `c2` | 24.576 MHz | **`clk_18m`**, the audio clock: `tdm8_master`, `tdm8_rx` / `tdm16_rx`, `tdm16_merge`, the decimator, `packet_formatter`, the FIFO write side, and the `bclk_out` pad |
| `c3` | 24.576 MHz, phase shifted | `clk_lr`, only when `C_LRCLK_RETIME` is true. It is **false** |
| `locked` | | `pll_locked` |

The signal is still called `clk_18m` although it has been 24.576 MHz since the
rate change; the source comments say so.

## What is removed and what is added

- Delete `u_pll`. Add input **`clk_24m576`**, drive `clk_18m` from it directly.
- `c0` and `c1` are already unconnected. Nothing to do.
- `c3`, `clk_lr` and the LRCLK re-timing register are dead code while
  `C_LRCLK_RETIME` is false, which is how the frozen firmware ships. Remove
  them rather than add a phase-shifted clock input. Turning re-timing back on
  is then not possible without a second, phase-shifted external clock. The
  constants `C_LRCLK_RETIME` and `C_LRCLK_PHASE_PS` go with it.
- The `c0` / `c1` / `c2` selection is only a comment and a port map, so it
  disappears with the instance. The ASIC has one clock rate. Record: the
  48 kHz and 72 kHz options no longer exist.

**Board implication.** The 24.576 MHz has to come from an external oscillator
and reach the chip's `clk_24m576` pin. The chip also **outputs** the clock:
`bclk_out <= clk_18m`, so the pad passes the external clock on to the ADCs. On
the FPGA that path came straight off the PLL with dedicated routing and a
jitter guarantee (the source says so, next to the `c2` assignment). On the
ASIC it goes through the input pad, the clock tree and an output pad. That is
a difference to keep in view if this design were ever built; for registration
it is only a note.

## Clock domains: three, not two

`CLAUDE.md` and `config.json` assume two clocks. The source has three.

| Clock | Source | What runs on it |
| --- | --- | --- |
| `clk_24m576` | new external input | the audio path above, FIFO write side |
| `rmii_ref_clk` | 50 MHz from the Ethernet PHY | `rmii_rx`, `rmii_tx`, `udp_tx_core`, `udp_rx_core`, `arp_responder`, `i2c_master`, `adau_sequencer`, the phantom-power watchdog, FIFO read side |
| `clk_50m_board` | 50 MHz board oscillator, formerly also the PLL input | heartbeat LED, PHY boot-reset delay, ADC boot-reset delay, PLL-lock fault counters, +15 V / +48 V enable sequencing |

`clk_50m_board` and `rmii_ref_clk` are both nominally 50 MHz but come from
separate oscillators, so they are not the same domain. The Phase 4 config needs
`CLOCK_PORT` with three entries. **Proposal: keep `clk_50m_board` as an input**,
so every board-level function stays as built. Folding it into `rmii_ref_clk`
would be simpler, but it changes the CDC structure of a design whose
behaviour is meant to stay identical.

## Reset

The audio-domain reset is derived from the PLL:

```
sys_rst   <= not pll_locked;
sys_rst_n <= not sys_rst;
```

`pll_locked` also drives `buffer_state` (the clock-buffer enable pin), the ADC
boot-reset delay, and two fault indicators (`pll_drop`, `pll_ever_lost`) that
occupy bits in the debug status bytes of the packet. Removing the PLL removes
`pll_locked`, so it needs a replacement. Several things depend on the choice.

**Proposal, not yet confirmed by the owner.** New input **`rst_n`**, active
low. Internally `pll_locked` becomes "reset released", so
`sys_rst <= not rst_n` and everything downstream is unchanged, including the
packet's status bits and therefore the wire format. `pll_drop` and
`pll_ever_lost` then count and latch external reset assertions after the first
release, which is a cosmetic change of meaning. This also fits the active-low
reset convention adopted in [decisions.md](decisions.md), and it is what the
FIFO's `rst_n` connects to.

Alternatives: a power-on-reset circuit on the chip (new analogue-ish logic
nobody asked for); or an input carrying the external clock-valid signal. The
first is out of scope, the second is the same as `rst_n` with a different name.

## The patch

`patches/0001-top-system-remove-pll.patch`, 199 lines of unified diff, taking
`top_system.vhd` from 1 783 to 1 668 lines. Five edits, each marked `[ASIC]`:

1. Two new ports, `clk_24m576` and `rst_n`, ahead of `clk_50m_board`.
2. `component pll_audio` removed.
3. The LRCLK re-timing constants (`C_LRCLK_RETIME`, `C_LRCLK_PHASE_PS`) and
   their long comment blocks replaced by a short note. `clk_lr` and
   `lrclk_pin_r` removed with them.
4. The `clk_lr` register process, and the `else lrclk_pin_r when C_LRCLK_RETIME`
   branch of the `lrclk_out` mux. `lrclk_out` is now `lrclk_int`, exactly what
   the frozen firmware drove with `C_LRCLK_RETIME` false.
5. The `u_pll` instance replaced by two assignments:
   ```vhdl
   clk_18m    <= clk_24m576;
   pll_locked <= rst_n;
   ```

`pll_locked` is kept as an internal name so nothing downstream changes:
`sys_rst`, `buffer_state`, the PHY and ADC boot delays, the power sequencing
and the fault counters are untouched, and so is the packet's status byte.

Applied under the owner's instruction "proceed PLL", using the defaults
proposed above: three clock ports, external `rst_n`, retime path removed. They
are recorded in [decisions.md](decisions.md) and can still be reversed.

Not in this patch: the tristate split ([ports.md](ports.md)), the FIFO
instantiation, and the decimator decision.

## Verification

An equivalence simulation, `tb/tb_top_port.vhd` run by
`tb/run_top_port.sh [--fast] [stop_us]`, GHDL, VHDL-2008.

- **ref**: the unpatched legacy `top_system`, with a behavioural stand-in for
  the ALTPLL (`tb/pll_audio_model.vhd`) generating the same 24.576 MHz, and
  `locked` rising at 20 µs.
- **dut**: the patched `top_system`, given that clock on `clk_24m576` with the
  same edges, and `rst_n` released at 20 µs.
- The same stimulus into both: a 50 MHz board clock, an unrelated 50 MHz PHY
  clock at 10.001 ns half-period (so the two domains drift against each other),
  random serial data on both SDATA lines, I2C pull-ups, idle receive path.
- All 17 output bits, `i2c_scl`, `i2c_sda` and `eth_mdio` included, compared
  every 5 ns from 1 µs on, which includes the moment of lock. Any difference
  fails the run.
- The FIFO in both is a simulation model (`tb/async_fifo_model.vhd`), because the
  real replacement is Verilog and is verified separately ([fifo.md](fifo.md)).
  Both models are test-only and never enter `src/`.

| Run | Simulated | Samples | Mismatches |
| --- | --- | --- | --- |
| Unmodified boot delays | 12 ms | 2 400 000 | **0** |
| `--fast`: the five boot counters divided by 1000 in **both** tops | 20 ms | 4 000 000 | **0** |

Coverage, from the toggle counts in the reference (12 ms / 20 ms runs):
`bclk_out` 589 776 / 982 993 edges (24.576 MHz), `lrclk_out` 2 300 / 3 836
(the 96 kHz pulse), `buffer_state` released once, `phy_rst_n` released once (at
10 ms, unscaled), `rmii_tx_en` 70 / 118 and `rmii_txd` about 24 000 / 41 000
(35 and 59 UDP frames), and in the `--fast` run `adc_rst_n` released and
`en_15v` enabled once each. The `--fast` counters are the PHY reset, the ADC
reset and the power sequencing; scaling changes only when those events happen.

**Negative control.** Two deliberately broken patched tops, both must fail and
did: `pll_locked` forced to `'1'` (16 438 mismatches, first at 1 µs on
`buffer_state`), and the audio clock inverted (59 800 mismatches, first on
`bclk_out`).

**Not exercised, so not verified by this run:**

- `en_48v` (needs a UDP flags packet to arrive), the heartbeat LED (an 84 ms
  period) and the debug LEDs. The receive path had no frames injected.
- The I2C boot beyond its first transactions: there is no ADC model, so the
  sequencer sees no acknowledge and the bus shows only 4 SCL and 22 SDA edges.
- Anything after 20 ms.

These paths depend on the patch only through `clk_18m`, `sys_rst` and
`pll_locked`, whose waveforms are identical in both tops throughout, so a
difference there is not expected. That is an argument, not a measurement.

**A GHDL warning to expect.** Every run prints `adau_sequencer.vhd:648:50:
static expression violates bounds`, from `to_unsigned(C_GAIN_PROBE_IDX, 2)`
with `C_GAIN_PROBE_IDX = -1`, inside a branch guarded by
`C_GAIN_PROBE_IDX >= 0`. It is legacy code, not touched, harmless in these
runs, but it is exactly the kind of thing that can turn into an error when
`adau_sequencer` is converted in Phase 2. Noted there.

## Provenance

| | |
| --- | --- |
| Source | `legacy/rtl/top_system.vhd`, sha256 `60802465b529e30bcf46b9cc2188117ca7545ec3184d637e359a9f43d2431760` |
| Patch | `patches/0001-top-system-remove-pll.patch`, sha256 `0975f3136d53966e2ac1df3f897c399b20f5a273d17016f7da98a5d06c9aa73d` |
| Result | patched `top_system.vhd`, sha256 `0c0329a22512544beb9468e7ed411f9476a261f34048282f16e12f8ce5af6cf9` |
| Rebuild | `patch -o top_system_asic.vhd legacy/rtl/top_system.vhd patches/0001-top-system-remove-pll.patch` |

Confirmed: the patch applied to the vendored file reproduces the patched file
byte for byte (`cmp`).
