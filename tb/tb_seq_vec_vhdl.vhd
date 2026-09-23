-- Vector dump for adau1978_sequencer, VHDL side. Pairs with tb/tb_seq_vec.v:
-- both drive the identical stimulus and write one line per clock, and the two
-- files must match byte for byte. This is the module's equivalence check,
-- because the formal proof does not close on it. See notes/conversion.md.
--
-- BOOT_DELAY_CYCLES is scaled down so the boot sequence is reached quickly; the
-- Verilog side is generated with the top's real value, so the generic is
-- overridden to match only when G_BOOT is passed.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity tb_seq_vec_vhdl is
    generic (
        G_BOOT    : integer := 7500000;
        G_CYCLES  : integer := 40000;
        G_OUTFILE : string  := "vec_vhdl.txt"
    );
end entity tb_seq_vec_vhdl;

architecture sim of tb_seq_vec_vhdl is
    signal clk : std_logic := '0';
    signal rst_n : std_logic := '0';
    signal udp_req, i2c_busy, i2c_ack_error, i2c_addr_nack : std_logic := '0';
    signal udp_adc_sel, udp_ch_sel : std_logic_vector(1 downto 0) := "00";
    signal udp_gain, i2c_data_rd : std_logic_vector(7 downto 0) := (others => '0');

    signal boot_done, udp_ack, i2c_ena, i2c_rd_mode, i2c_probe, i2c_fault : std_logic;
    signal adc_pll_lock, adc_cfg_ok : std_logic;
    signal i2c_addr : std_logic_vector(6 downto 0);
    signal i2c_reg_addr, i2c_data_wr : std_logic_vector(7 downto 0);
    signal dbg_rd_pll, dbg_rd_sai, dbg_scan_cnt, dbg_scan_addr : std_logic_vector(7 downto 0);
    signal dbg_scan_mask, dbg_ot, dbg_health, dbg_vfy_mask : std_logic_vector(7 downto 0);

    signal lfsr : unsigned(31 downto 0) := x"12345678";
    signal done : boolean := false;
begin
    clk <= not clk after 10 ns when not done else '0';

    uut : entity work.adau1978_sequencer
        generic map (BOOT_DELAY_CYCLES => G_BOOT)
        port map (
            clk => clk, rst_n => rst_n, boot_done => boot_done,
            udp_req => udp_req, udp_ack => udp_ack, udp_adc_sel => udp_adc_sel,
            udp_ch_sel => udp_ch_sel, udp_gain => udp_gain,
            i2c_ena => i2c_ena, i2c_addr => i2c_addr, i2c_reg_addr => i2c_reg_addr,
            i2c_data_wr => i2c_data_wr, i2c_busy => i2c_busy,
            i2c_ack_error => i2c_ack_error, i2c_rd_mode => i2c_rd_mode,
            i2c_probe => i2c_probe, i2c_addr_nack => i2c_addr_nack,
            i2c_data_rd => i2c_data_rd, i2c_fault => i2c_fault,
            adc_pll_lock => adc_pll_lock, adc_cfg_ok => adc_cfg_ok,
            dbg_rd_pll => dbg_rd_pll, dbg_rd_sai => dbg_rd_sai,
            dbg_scan_cnt => dbg_scan_cnt, dbg_scan_addr => dbg_scan_addr,
            dbg_scan_mask => dbg_scan_mask, dbg_ot => dbg_ot,
            dbg_health => dbg_health, dbg_vfy_mask => dbg_vfy_mask);

    -- the same 32-bit LFSR the Verilog side uses, advanced once per clock
    stim : process
        file f : text;
        variable l : line;
        variable v : unsigned(31 downto 0) := x"12345678";
        variable fb : std_logic;
        variable flags : std_logic_vector(7 downto 0);
        variable addr8 : std_logic_vector(7 downto 0);
        variable wr16  : std_logic_vector(15 downto 0);
        variable rd32  : std_logic_vector(31 downto 0);
        variable dbg32 : std_logic_vector(31 downto 0);
        variable prev  : std_logic_vector(95 downto 0) := (others => 'U');
        variable cur   : std_logic_vector(95 downto 0);
    begin
        file_open(f, G_OUTFILE, write_mode);
        rst_n <= '0';
        for i in 0 to 9 loop wait until rising_edge(clk); end loop;
        rst_n <= '1';

        for i in 0 to G_CYCLES - 1 loop
            wait until rising_edge(clk);
            -- drive inputs from the LFSR, then record everything after settling
            fb := v(31) xor v(21) xor v(1) xor v(0);
            v := v(30 downto 0) & fb;
            i2c_busy      <= v(0);
            i2c_ack_error <= v(1) and v(2);
            i2c_addr_nack <= v(3) and v(4);
            i2c_data_rd   <= std_logic_vector(v(15 downto 8));
            udp_req       <= v(5) and v(6) and v(7);
            udp_adc_sel   <= std_logic_vector(v(17 downto 16));
            udp_ch_sel    <= std_logic_vector(v(19 downto 18));
            udp_gain      <= std_logic_vector(v(27 downto 20));
            wait for 1 ns;
            flags := boot_done & udp_ack & i2c_ena & i2c_rd_mode &
                     i2c_probe & i2c_fault & adc_pll_lock & adc_cfg_ok;
            addr8 := '0' & i2c_addr;
            wr16  := i2c_reg_addr & i2c_data_wr;
            rd32  := dbg_rd_pll & dbg_rd_sai & dbg_scan_cnt & dbg_scan_addr;
            dbg32 := dbg_scan_mask & dbg_ot & dbg_health & dbg_vfy_mask;
            cur := flags & addr8 & wr16 & rd32 & dbg32;
            -- only record a line when an output changes: the boot delay is
            -- 7.5 M cycles and a line per cycle would be gigabytes
            next when cur = prev;
            prev := cur;
            write(l, integer'image(i));
            write(l, string'(" "));
            write(l, to_hstring(flags));
            write(l, string'(" "));
            write(l, to_hstring(addr8));
            write(l, string'(" "));
            write(l, to_hstring(wr16));
            write(l, string'(" "));
            write(l, to_hstring(rd32));
            write(l, string'(" "));
            write(l, to_hstring(dbg32));
            writeline(f, l);
        end loop;

        file_close(f);
        report "wrote " & integer'image(G_CYCLES) & " vectors";
        done <= true;
        wait for 20 ns;
        std.env.stop;
    end process;
end architecture sim;
