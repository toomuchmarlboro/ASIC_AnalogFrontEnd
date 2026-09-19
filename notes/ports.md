# ports — tristate split and the top-level port map (Phase 1c)

Written from `UATR_TDM` commit `c1fc108c68fad7cef11b884a3e889c5dd4281cc6`.
Date: 2026-09-19.

**Status: implemented as a patch and verified.**
`patches/0002-top-system-split-tristates.patch`, applied after
`0001-top-system-remove-pll.patch` ([clocking.md](clocking.md)). After both,
`top_system` has no `inout` port. See *The patch* and *Verification* below.

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
read the pad level back, so it needs no change. Confirmed by simulation, see
*Verification*.

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

Applied on the owner's "go do both". The alternative, dropping the pin,
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

## The patch

`patches/0002-top-system-split-tristates.patch`, 66 lines, against the output
of patch 0001. Four edits, each marked `[ASIC]`: the two I2C ports become six,
`eth_mdio` becomes three, the `eth_mdio <= 'Z'` line becomes `_o = 0`,
`_oe = 0`, and the four I2C lines become the `_o` / `_oe` / `_i` form in the
table above. `C_I2C_SWAP` is untouched and still `true`.

| | |
| --- | --- |
| Input | `top_system.vhd` after 0001, sha256 `0c0329a22512544beb9468e7ed411f9476a261f34048282f16e12f8ce5af6cf9` |
| Patch | sha256 `cbc0c8f15409efa709100de893b6e715c5d1efad5a76dc9c4443c0a476d062d5` |
| Result | sha256 `01193ed6420ce1854434185ad100d62b708f833bc56cef600e9aee310bedd4b8` |
| Rebuild | `patch -o p1.vhd legacy/rtl/top_system.vhd patches/0001-*.patch; patch -o top_system_asic.vhd p1.vhd patches/0002-*.patch` |

Confirmed: the two patches applied in order reproduce the result byte for byte.

## Verification

The same equivalence bench as the PLL removal, extended:
`tb/tb_top_port.vhd`, run by `tb/run_top_port.sh [--fast] [stop_us]` (it was
`tb_top_pll` before this change). The reference is still the untouched legacy
top with a PLL model. The patched top now has both patches, and a **pad model
in the testbench** (`oe ? o : 'Z'`, the level fed back to `_i`) builds the
board net from the new ports. Both nets have the same pull-up, and each gets
an acknowledging I2C slave (`tb/i2c_ack_slave.vhd`, simulation only), so the
master sees real acknowledges and the bus actually runs. The pad **levels** on
the two nets are compared, with all the other outputs, every 5 ns.

The slave is wired as the board is: the FPGA's `i2c_scl` pin goes to the ADC's
SDA and `i2c_sda` to its SCL, which is the schematic error `C_I2C_SWAP`
compensates. So on these waveforms the `i2c_sda` pad carries the clock.

`--fast` now also scales the sequencer's boot delay (`BOOT_DELAY_CYCLES`,
7 500 000 to 7 500) and the I2C bit time (`QUARTER_BIT_CYCLES`, 250 to 25), in
both tops. Without that the I2C boot never started inside a simulation that
finishes, and the first 1c runs showed only 4 and 22 edges on the bus.

| Run | Simulated | Samples | Mismatches | Edges on `i2c_scl` / `i2c_sda` |
| --- | --- | --- | --- | --- |
| Unmodified delays | 12 ms | 2 400 000 | **0** | 4 / 22 (the master's self-test only) |
| `--fast` | 20 ms | 4 000 000 | **0** | 1 796 / 5 270 (the sequencer's boot traffic) |

**Negative control.** Three broken versions of the split, each must fail and
did, from 4 ms `--fast` runs:

| Mutation | First mismatch |
| --- | --- |
| `i2c_scl_oe` takes `m_scl_o` instead of `m_sda_o` under the swap | 20.5 µs, on the SCL pad |
| read-back of SCL ignores the swap | 401.7 µs, on the TX pins: the sequencer's status reaches the packet |
| `i2c_sda_oe` polarity inverted | 20.5 µs, on the SDA pad |

Waveforms: `figures/top_port_i2c.jpg` (one I2C byte, reference and patched
pads together) and `figures/top_port_boot.jpg`, see [waveforms.md](waveforms.md).

**Not covered.** The slave acknowledges and returns all ones; it is not an
ADAU1978, so register read-back values are not realistic. `eth_mdio` is never
driven in either top and is only checked to stay released. No real pad cell
exists to check against, by design.
