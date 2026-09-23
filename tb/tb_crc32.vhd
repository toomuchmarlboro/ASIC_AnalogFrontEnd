-- crc32 golden-vector check, the one CLAUDE.md names: "123456789" must give
-- 0x649C2FD3, and feeding a frame plus its CRC must leave the RX residue
-- 0xC704DD7B. Works on the VHDL or on a synthesised netlist (library conv).
--
--   ghdl -a --std=08 legacy/rtl/crc32.vhd tb/tb_crc32.vhd && ghdl -r --std=08 tb_crc32
--
-- Gate-level crc32 is checked separately in Verilog, see tb/run_gate_modules.sh.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_crc32 is
end entity tb_crc32;

architecture sim of tb_crc32 is
    signal clk     : std_logic := '0';
    signal rst     : std_logic := '1';
    signal en      : std_logic := '0';
    signal data_in : std_logic_vector(7 downto 0) := (others => '0');
    signal crc_out : std_logic_vector(31 downto 0);
    signal done    : boolean := false;

    constant CHECK    : std_logic_vector(31 downto 0) := x"649C2FD3";
    constant RESIDUE  : std_logic_vector(31 downto 0) := x"C704DD7B";
begin

    clk <= not clk after 10 ns when not done else '0';

    uut : entity work.crc32 port map (clk => clk, rst => rst, en => en,
                                      data_in => data_in, crc_out => crc_out);

    stim : process
        -- one byte through the CRC
        procedure feed (b : std_logic_vector(7 downto 0)) is
        begin
            wait until falling_edge(clk);
            data_in <= b;
            en      <= '1';
            wait until falling_edge(clk);
            en      <= '0';
        end procedure;

        variable crc_le : std_logic_vector(31 downto 0);
    begin
        rst <= '1';
        wait for 45 ns;
        wait until falling_edge(clk);
        rst <= '0';

        -- "123456789"
        for i in 0 to 8 loop
            feed(std_logic_vector(to_unsigned(character'pos('1') + i, 8)));
        end loop;
        wait until falling_edge(clk);

        report "crc of 123456789 = 0x" & to_hstring(crc_out) &
               "  expected 0x" & to_hstring(CHECK);
        assert crc_out = CHECK
            report "CRC32 FAIL: check value wrong" severity failure;

        -- RX residue: the same message followed by its FCS exactly as rmii_tx
        -- puts it on the wire - each byte is a bit-reversed slice of crc_out,
        -- see rmii_tx.vhd, the SEND_FCS bytes.
        crc_le := crc_out;
        rst <= '1';
        wait until falling_edge(clk);
        rst <= '0';
        for i in 0 to 8 loop
            feed(std_logic_vector(to_unsigned(character'pos('1') + i, 8)));
        end loop;
        feed(crc_le(24) & crc_le(25) & crc_le(26) & crc_le(27) &
             crc_le(28) & crc_le(29) & crc_le(30) & crc_le(31));
        feed(crc_le(16) & crc_le(17) & crc_le(18) & crc_le(19) &
             crc_le(20) & crc_le(21) & crc_le(22) & crc_le(23));
        feed(crc_le(8)  & crc_le(9)  & crc_le(10) & crc_le(11) &
             crc_le(12) & crc_le(13) & crc_le(14) & crc_le(15));
        feed(crc_le(0)  & crc_le(1)  & crc_le(2)  & crc_le(3)  &
             crc_le(4)  & crc_le(5)  & crc_le(6)  & crc_le(7));
        wait until falling_edge(clk);

        -- The residue magic number is the value of the internal register, and
        -- crc_out is that register inverted (crc32.vhd: crc_out <= not crc_reg),
        -- so the check is against the complement of crc_out.
        report "rx residue (internal register) = 0x" & to_hstring(not crc_out) &
               "  expected 0x" & to_hstring(RESIDUE);
        assert (not crc_out) = RESIDUE
            report "CRC32 FAIL: residue wrong" severity failure;

        report "CRC32 PASS";
        done <= true;
        wait for 20 ns;
        std.env.stop;
    end process;

end architecture sim;
