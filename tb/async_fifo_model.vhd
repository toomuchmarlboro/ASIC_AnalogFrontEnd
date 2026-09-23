-- SIMULATION ONLY. Behavioural stand-in for the FIFO so the VHDL top_system can
-- be simulated at all: the real replacement, src/async_fifo.v, is Verilog and is
-- verified on its own (tb_async_fifo, tb_fifo_system). Both tops in tb_top_port
-- get this same model, so it cannot make them differ. Never goes in src/.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity async_fifo is
    port (
        -- Default '1' so the unpatched reference top, whose component has no
        -- rst_n, still binds; the patched top drives it from sys_rst_n.
        rst_n   : in  std_logic := '1';
        data    : in  std_logic_vector(7 downto 0);
        rdclk   : in  std_logic;
        rdreq   : in  std_logic;
        wrclk   : in  std_logic;
        wrreq   : in  std_logic;
        q       : out std_logic_vector(7 downto 0);
        rdempty : out std_logic;
        wrfull  : out std_logic
    );
end entity async_fifo;

architecture sim of async_fifo is
    type mem_t is array (0 to 1023) of std_logic_vector(7 downto 0);
    signal mem   : mem_t := (others => (others => '0'));
    signal wptr  : unsigned(10 downto 0) := (others => '0');
    signal rptr  : unsigned(10 downto 0) := (others => '0');
    signal q_r   : std_logic_vector(7 downto 0) := (others => '0');
begin
    process (wrclk, rst_n)
    begin
        if rst_n = '0' then
            wptr <= (others => '0');
        elsif rising_edge(wrclk) then
            if wrreq = '1' and (wptr - rptr) /= 1024 then
                mem(to_integer(wptr(9 downto 0))) <= data;
                wptr <= wptr + 1;
            end if;
        end if;
    end process;

    process (rdclk, rst_n)
    begin
        if rst_n = '0' then
            rptr <= (others => '0');
            q_r  <= (others => '0');
        elsif rising_edge(rdclk) then
            if rdreq = '1' and wptr /= rptr then
                q_r  <= mem(to_integer(rptr(9 downto 0)));
                rptr <= rptr + 1;
            end if;
        end if;
    end process;

    q       <= q_r;
    rdempty <= '1' when wptr = rptr else '0';
    wrfull  <= '1' when (wptr - rptr) = 1024 else '0';
end architecture sim;
