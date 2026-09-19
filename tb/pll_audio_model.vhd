-- SIMULATION ONLY. Behavioural stand-in for the removed ALTPLL, so the unpatched
-- top_system can be simulated as the reference in tb_top_port. Not part of the
-- ASIC design and never goes in src/. See notes/clocking.md.
--
-- c2 is the 24.576 MHz audio clock, generated with the same period and phase as
-- the clk_24m576 the testbench gives the patched top, so both see identical
-- edges. locked rises at 20 us, when the testbench releases rst_n.

library ieee;
use ieee.std_logic_1164.all;

entity pll_audio is
    port (
        areset : in  std_logic;
        inclk0 : in  std_logic;
        c0     : out std_logic;
        c1     : out std_logic;
        c2     : out std_logic;
        c3     : out std_logic;
        locked : out std_logic
    );
end entity pll_audio;

architecture sim of pll_audio is
    signal clk : std_logic := '0';
begin
    clk    <= not clk after 20.345 ns;
    c0     <= '0';
    c1     <= '0';
    c2     <= clk;
    c3     <= transport clk after 25.431 ns;
    locked <= '0', '1' after 20 us;
end architecture sim;
