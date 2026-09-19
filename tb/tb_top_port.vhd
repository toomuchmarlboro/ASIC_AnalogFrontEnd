-- Equivalence check for the top-level port changes:
--   patches/0001-top-system-remove-pll.patch       notes/clocking.md
--   patches/0002-top-system-split-tristates.patch  notes/ports.md
--
--   ref  the unpatched legacy top_system, with a behavioural stand-in for the
--        ALTPLL (pll_audio_model.vhd), in library "ref"
--   dut  the patched top_system, fed the same clock on the clk_24m576 pin and
--        the same release on rst_n, in library "work"
--
-- Same stimulus into both; every output is compared every 5 ns and the run
-- fails on any difference. The FIFO is a simulation model in both. The
-- open-drain pads are compared as levels on the board net: in ref the top
-- drives the net itself, in dut a pad model made from the new _o / _oe ports
-- does, and both nets have the same pull-up and the same I2C slave.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ref;

entity tb_top_port is
    generic (G_STOP_US : integer := 12000; G_TRACE_I2C : boolean := false);
end entity tb_top_port;

architecture sim of tb_top_port is

    constant N_OUT : integer := 17;
    type names_t is array (0 to N_OUT - 1) of string(1 to 12);
    constant NAMES : names_t := (
        "adc_rst_n   ", "test_led    ", "debug_led_rx", "debug_led_tx",
        "en_15v      ", "en_48v      ", "i2c_scl     ", "i2c_sda     ",
        "bclk_out    ", "lrclk_out   ", "phy_rst_n   ", "rmii_tx_en  ",
        "rmii_txd(1) ", "rmii_txd(0) ", "eth_mdc     ", "eth_mdio    ",
        "buffer_state");

    signal clk24, clk50, rmii_clk : std_logic := '0';
    signal rst_n   : std_logic := '0';
    signal sdata_a, sdata_b : std_logic := '0';
    signal crs_dv  : std_logic := '0';
    signal rxd     : std_logic_vector(1 downto 0) := "00";

    -- reference outputs
    signal r_adc_rst, r_test_led, r_led_rx, r_led_tx, r_en15, r_en48 : std_logic;
    signal r_bclk, r_lrclk, r_phy_rst, r_tx_en, r_mdc, r_buf : std_logic;
    signal r_txd : std_logic_vector(1 downto 0);
    signal r_scl, r_sda, r_mdio : std_logic;

    -- patched outputs
    signal d_adc_rst, d_test_led, d_led_rx, d_led_tx, d_en15, d_en48 : std_logic;
    signal d_bclk, d_lrclk, d_phy_rst, d_tx_en, d_mdc, d_buf : std_logic;
    signal d_txd : std_logic_vector(1 downto 0);
    signal d_scl, d_sda, d_mdio : std_logic;                 -- the pad nets
    signal d_scl_i, d_scl_o, d_scl_oe : std_logic;
    signal d_sda_i, d_sda_o, d_sda_oe : std_logic;
    signal d_mdio_i, d_mdio_o, d_mdio_oe : std_logic;

    signal o_ref, o_dut : std_logic_vector(N_OUT - 1 downto 0);

begin

    clk24    <= not clk24    after 20.345 ns;    -- 24.576 MHz, same as the PLL model
    clk50    <= not clk50    after 10 ns;        -- board oscillator
    rmii_clk <= not rmii_clk after 10.001 ns;    -- PHY clock, not phase-locked to it
    rst_n    <= '1' after 20 us;                 -- same instant the PLL model locks

    -- I2C is open drain with a pull-up on the board
    r_scl <= 'H';  r_sda <= 'H';
    d_scl <= 'H';  d_sda <= 'H';

    -- the pad cell the ASIC does not have: oe ? o : high-Z, and the level back in
    d_scl  <= d_scl_o  when d_scl_oe  = '1' else 'Z';
    d_sda  <= d_sda_o  when d_sda_oe  = '1' else 'Z';
    d_mdio <= d_mdio_o when d_mdio_oe = '1' else 'Z';
    d_scl_i  <= d_scl;
    d_sda_i  <= d_sda;
    d_mdio_i <= d_mdio;

    -- An acknowledging slave on each board. The board wires the FPGA's SCL pin
    -- to the ADC's SDA and the FPGA's SDA pin to the ADC's SCL (the schematic
    -- error C_I2C_SWAP compensates), so the slave's clock is the SDA pad.
    u_slave_ref : entity work.i2c_ack_slave port map (scl => r_sda, sda => r_scl);
    u_slave_dut : entity work.i2c_ack_slave port map (scl => d_sda, sda => d_scl);

    -- random serial data on both lines, launched on the falling edge
    process (clk24)
        variable la : unsigned(15 downto 0) := x"ACE1";
        variable lb : unsigned(15 downto 0) := x"1D0F";
    begin
        if falling_edge(clk24) then
            la := la(14 downto 0) & (la(15) xor la(13) xor la(12) xor la(10));
            lb := lb(14 downto 0) & (lb(15) xor lb(14) xor lb(12) xor lb(3));
            sdata_a <= la(0);
            sdata_b <= lb(0);
        end if;
    end process;

    u_ref : entity ref.top_system
        port map (
            clk_50m_board => clk50,
            adc_rst_n     => r_adc_rst,
            test_led      => r_test_led,
            debug_led_rx  => r_led_rx,
            debug_led_tx  => r_led_tx,
            en_15v        => r_en15,
            en_48v        => r_en48,
            i2c_scl       => r_scl,
            i2c_sda       => r_sda,
            bclk_out      => r_bclk,
            lrclk_out     => r_lrclk,
            sdata_in_A    => sdata_a,
            sdata_in_B    => sdata_b,
            phy_rst_n     => r_phy_rst,
            rmii_ref_clk  => rmii_clk,
            rmii_tx_en    => r_tx_en,
            rmii_txd      => r_txd,
            rmii_crs_dv   => crs_dv,
            rmii_rxd      => rxd,
            eth_mdc       => r_mdc,
            eth_mdio      => r_mdio,
            buffer_state  => r_buf
        );

    u_dut : entity work.top_system
        port map (
            clk_24m576    => clk24,
            rst_n         => rst_n,
            clk_50m_board => clk50,
            adc_rst_n     => d_adc_rst,
            test_led      => d_test_led,
            debug_led_rx  => d_led_rx,
            debug_led_tx  => d_led_tx,
            en_15v        => d_en15,
            en_48v        => d_en48,
            i2c_scl_i     => d_scl_i,
            i2c_scl_o     => d_scl_o,
            i2c_scl_oe    => d_scl_oe,
            i2c_sda_i     => d_sda_i,
            i2c_sda_o     => d_sda_o,
            i2c_sda_oe    => d_sda_oe,
            bclk_out      => d_bclk,
            lrclk_out     => d_lrclk,
            sdata_in_A    => sdata_a,
            sdata_in_B    => sdata_b,
            phy_rst_n     => d_phy_rst,
            rmii_ref_clk  => rmii_clk,
            rmii_tx_en    => d_tx_en,
            rmii_txd      => d_txd,
            rmii_crs_dv   => crs_dv,
            rmii_rxd      => rxd,
            eth_mdc       => d_mdc,
            eth_mdio_i    => d_mdio_i,
            eth_mdio_o    => d_mdio_o,
            eth_mdio_oe   => d_mdio_oe,
            buffer_state  => d_buf
        );

    o_ref <= r_adc_rst & r_test_led & r_led_rx & r_led_tx & r_en15 & r_en48 & r_scl & r_sda &
             r_bclk & r_lrclk & r_phy_rst & r_tx_en & r_txd(1) & r_txd(0) & r_mdc & r_mdio & r_buf;
    o_dut <= d_adc_rst & d_test_led & d_led_rx & d_led_tx & d_en15 & d_en48 & d_scl & d_sda &
             d_bclk & d_lrclk & d_phy_rst & d_tx_en & d_txd(1) & d_txd(0) & d_mdc & d_mdio & d_buf;

    -- optional: every edge on the reference's I2C pads, for debugging the bus
    trace : process (r_scl, r_sda)
    begin
        if G_TRACE_I2C then
            report "i2c ref  scl=" & to_string(r_scl) & " sda=" & to_string(r_sda);
        end if;
    end process trace;

    check : process
        type cnt_t is array (0 to N_OUT - 1) of integer;
        variable toggles : cnt_t := (others => 0);
        variable prev    : std_logic_vector(N_OUT - 1 downto 0) := (others => 'U');
        variable samples, errors : integer := 0;
        variable idle    : integer := 0;
    begin
        loop
            wait for 5 ns;
            samples := samples + 1;
            if now > 1 us then
                if o_ref /= o_dut then
                    errors := errors + 1;
                    if errors <= 5 then
                        report "MISMATCH at " & time'image(now) &
                               " ref=" & to_string(o_ref) & " dut=" & to_string(o_dut)
                            severity error;
                    end if;
                end if;
            end if;
            for i in 0 to N_OUT - 1 loop
                if now > 1 us and prev(N_OUT - 1 - i) /= o_ref(N_OUT - 1 - i) then
                    toggles(i) := toggles(i) + 1;
                end if;
            end loop;
            prev := o_ref;
            exit when now >= G_STOP_US * 1 us;
        end loop;

        report "run length          : " & integer'image(G_STOP_US) & " us";
        report "samples compared    : " & integer'image(samples);
        report "mismatches          : " & integer'image(errors);
        for i in 0 to N_OUT - 1 loop
            report "toggles " & NAMES(i) & ": " & integer'image(toggles(i));
        end loop;
        assert errors = 0 report "EQUIVALENCE FAIL: patched top differs from the PLL original"
            severity failure;
        report "EQUIVALENCE PASS";
        std.env.stop;
    end process check;

end architecture sim;
