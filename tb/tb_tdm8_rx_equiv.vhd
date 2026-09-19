-- Phase 0 equivalence check: rtl/tdm8_rx.vhd against src/tdm8_rx.v, one
-- stimulus into both. Converted Verilog is expected in library "conv".
-- See notes/phase0.md.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library conv;

entity tb_tdm8_rx_equiv is
    generic (
        G_SLOT_BCLKS    : integer := 32;   -- 24 data bits + pad
        G_LAUNCH_DELAY  : integer := 0;    -- BCLKs from LRCLK rise to first bit
        G_CHECK_PATTERN : boolean := false
    );
end entity tb_tdm8_rx_equiv;

architecture sim of tb_tdm8_rx_equiv is

    component tdm8_master is
        port (
            rst        : in  std_logic;
            clk_in     : in  std_logic;
            bclk_out   : out std_logic;
            lrclk_out  : out std_logic
        );
    end component;

    component tdm8_rx is
        port (
            rst         : in  std_logic;
            bclk_in     : in  std_logic;
            lrclk_in    : in  std_logic;
            sdata_in    : in  std_logic;
            ch_data_out : out std_logic_vector(191 downto 0)
        );
    end component;

    signal rst         : std_logic := '1';
    signal rst_n       : std_logic;                      -- converted Verilog takes active-low
    signal clk_mclk    : std_logic := '0';
    signal bclk        : std_logic;
    signal lrclk       : std_logic;
    signal sdata_in    : std_logic := '0';

    signal ch_ref      : std_logic_vector(191 downto 0);  -- VHDL original
    signal ch_dut      : std_logic_vector(191 downto 0);  -- converted Verilog

    signal frames_done : integer := 0;
    signal cmp_count   : integer := 0;
    signal err_count   : integer := 0;

    constant CLK_PERIOD : time := 54.25 ns;

    type frame_data_type is array (0 to 7) of std_logic_vector(23 downto 0);
    constant TEST_FRAME : frame_data_type := (
        x"A1A1A1", -- Ch 1
        x"B2B2B2", -- Ch 2
        x"C3C3C3", -- Ch 3
        x"D4D4D4", -- Ch 4
        x"E5E5E5", -- Ch 5
        x"F6F6F6", -- Ch 6
        x"070707", -- Ch 7
        x"181818"  -- Ch 8
    );

begin

    uut_master: tdm8_master
        port map (
            rst        => rst,
            clk_in     => clk_mclk,
            bclk_out   => bclk,
            lrclk_out  => lrclk
        );

    uut_ref: tdm8_rx
        port map (
            rst         => rst,
            bclk_in     => bclk,
            lrclk_in    => lrclk,
            sdata_in    => sdata_in,
            ch_data_out => ch_ref
        );

    rst_n <= not rst;

    uut_dut: entity conv.tdm8_rx
        port map (
            rst_n       => rst_n,
            bclk_in     => bclk,
            lrclk_in    => lrclk,
            sdata_in    => sdata_in,
            ch_data_out => ch_dut
        );

    clk_gen: process
    begin
        clk_mclk <= '0';
        wait for CLK_PERIOD / 2;
        clk_mclk <= '1';
        wait for CLK_PERIOD / 2;
    end process clk_gen;

    stimulus: process
        constant N_BITS : integer := 8 * G_SLOT_BCLKS;
        variable frame_bits : std_logic_vector(0 to N_BITS - 1);
    begin
        frame_bits := (others => '0');
        for ch_idx in 0 to 7 loop
            for bit_idx in 0 to 23 loop
                if ch_idx * G_SLOT_BCLKS + bit_idx + G_LAUNCH_DELAY < N_BITS then
                    frame_bits(ch_idx * G_SLOT_BCLKS + bit_idx + G_LAUNCH_DELAY)
                        := TEST_FRAME(ch_idx)(23 - bit_idx);
                end if;
            end loop;
        end loop;

        rst <= '1';
        sdata_in <= '0';
        wait for 200 ns;

        wait until falling_edge(clk_mclk);
        rst <= '0';

        for frame_idx in 1 to 3 loop

            wait until lrclk = '1';

            for bit_idx in 0 to N_BITS - 1 loop
                sdata_in <= frame_bits(bit_idx);
                wait until falling_edge(bclk);
            end loop;

            frames_done <= frame_idx;

        end loop;

        wait for 300 ns;

        report "slot width          : " & integer'image(G_SLOT_BCLKS) & " BCLKs";
        report "comparisons made    : " & integer'image(cmp_count);
        report "mismatches          : " & integer'image(err_count);

        for ch_idx in 0 to 7 loop
            report "ch" & integer'image(ch_idx + 1) & " ref=" &
                   to_hstring(ch_ref(191 - 24*ch_idx downto 168 - 24*ch_idx)) &
                   "  dut=" &
                   to_hstring(ch_dut(191 - 24*ch_idx downto 168 - 24*ch_idx)) &
                   "  expected=" & to_hstring(TEST_FRAME(ch_idx));
            if G_CHECK_PATTERN then
                assert ch_dut(191 - 24*ch_idx downto 168 - 24*ch_idx)
                       = TEST_FRAME(ch_idx)
                    report "PATTERN FAIL on channel " &
                           integer'image(ch_idx + 1)
                    severity failure;
            end if;
        end loop;

        assert err_count = 0
            report "EQUIVALENCE FAIL: converted Verilog differs from VHDL"
            severity failure;
        assert cmp_count > 500
            report "EQUIVALENCE INCONCLUSIVE: too few comparisons"
            severity failure;

        report "EQUIVALENCE PASS";
        std.env.stop;
    end process stimulus;

    -- Sample a nanosecond after the edge, once every delta has settled.
    compare: process
    begin
        wait until rising_edge(bclk);
        wait for 1 ns;
        if rst = '0' then
            cmp_count <= cmp_count + 1;
            if ch_dut /= ch_ref then
                err_count <= err_count + 1;
                report "MISMATCH at " & time'image(now) &
                       " ref=" & to_hstring(ch_ref) &
                       " dut=" & to_hstring(ch_dut)
                    severity error;
            end if;
        end if;
    end process compare;

end architecture sim;