# ports — tristate split and the top-level port map (Phase 1c)

Specification for Phase 3, written from `UATR_TDM` commit
`c1fc108c68fad7cef11b884a3e889c5dd4281cc6`. No code yet. Date: 2026-09-19.

Rule: no `inout` anywhere in the converted design. Tristate resolution belongs
to a pad cell, which this design does not have. There are **three** `inout`
ports, not two.

## `i2c_scl`, `i2c_sda`

The FPGA drives them open-drain, with a swap that compensates a schematic error
(`C_I2C_SWAP := true`, load-bearing, kept):

```vhdl
i2c_scl <= '0' when ((not C_I2C_SWAP) and m_scl_o = '0') or (C_I2C_SWAP and m_sda_o = '0') else 'Z';
i2c_sda <= '0' when ((not C_I2C_SWAP) and m_sda_o = '0') or (C_I2C_SWAP and m_scl_o = '0') else 'Z';
m_scl_i <= i2c_sda when C_I2C_SWAP else i2c_scl;
m_sda_i <= i2c_scl when C_I2C_SWAP else i2c_sda;
```

Each `inout` becomes three ports. The pad is `oe ? o : high-Z`; `o` is held at
0 because the line is only ever driven low:

| Was | Becomes | Direction | Value |
| --- | --- | --- | --- |
| `inout i2c_scl` | `i2c_scl_i` | in | the pad level, read back |
| | `i2c_scl_o` | out | constant 0 |
| | `i2c_scl_oe` | out | `(not C_I2C_SWAP and m_scl_o = '0') or (C_I2C_SWAP and m_sda_o = '0')` |
| `inout i2c_sda` | `i2c_sda_i` | in | the pad level, read back |
| | `i2c_sda_o` | out | constant 0 |
| | `i2c_sda_oe` | out | `(not C_I2C_SWAP and m_sda_o = '0') or (C_I2C_SWAP and m_scl_o = '0')` |

Read-back is unchanged in form:
`m_scl_i = C_I2C_SWAP ? i2c_sda_i : i2c_scl_i` and the mirror for `m_sda_i`.

**Open-drain semantics unchanged:** the line is pulled low exactly when the
old expression was `'0'`, and released otherwise. `i2c_master` already exposes
`scl_o` / `sda_o` / `scl_i` / `sda_i` and its stuck-line and drive-OK checks
read the pad level back, so it needs no change. **To confirm at Phase 3** by
simulation of the converted top level; nothing has been run here.

## `eth_mdio`

A third `inout`. The source ties it permanently high-impedance and never reads
it:

```vhdl
eth_mdc  <= '0';
eth_mdio <= 'Z';   -- High impedance (safe for bidirectional)
```

Split the same way, in the cheapest faithful form:

| Was | Becomes | Direction | Value |
| --- | --- | --- | --- |
| `inout eth_mdio` | `eth_mdio_i` | in | unused |
| | `eth_mdio_o` | out | constant 0 |
| | `eth_mdio_oe` | out | constant 0 (never drives) |

**Proposal, not yet confirmed.** The alternative is dropping the pin, which
changes the port list of a PHY-facing signal for no gain.

## The other port changes for the top level

| Port | Change |
| --- | --- |
| `clk_24m576` | new input, replaces the PLL, see [clocking.md](clocking.md) |
| `rst_n` | new input, active-low, replaces `pll_locked`, see [clocking.md](clocking.md) |
| `clk_50m_board` | kept as an input, third clock |
| `rmii_ref_clk` | kept |
| `i2c_scl`, `i2c_sda`, `eth_mdio` | split as above |

The full port list with widths goes in `integration.md` at Phase 3.
