# clocking — PLL removal, the external clock, domains, reset (Phase 1a)

Specification for the top-level change, written from `UATR_TDM` commit
`c1fc108c68fad7cef11b884a3e889c5dd4281cc6`. `top_system` is converted last
(Phase 3), so there is no code for this yet; the FIFO
([fifo.md](fifo.md)) is the only part built. Date: 2026-09-19.

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
