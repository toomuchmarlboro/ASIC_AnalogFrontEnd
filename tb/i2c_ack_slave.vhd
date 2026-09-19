-- SIMULATION ONLY. A minimal I2C slave that acknowledges every address and
-- every written byte, and returns all ones on reads (it releases SDA and lets
-- the pull-up win). It exists so the master in top_system gets real
-- acknowledges and the bus does more than a few edges. Not an ADAU1978 model.
-- Never goes in src/.

library ieee;
use ieee.std_logic_1164.all;

entity i2c_ack_slave is
    port (
        scl : in    std_logic;
        sda : inout std_logic
    );
end entity i2c_ack_slave;

architecture sim of i2c_ack_slave is
    signal drive_low : std_logic := '0';
begin
    sda <= '0' when drive_low = '1' else 'Z';

    process (scl, sda)
        variable active  : boolean := false;
        variable nclk    : integer := 0;      -- rising SCL edges in this byte, 1..9
        variable bytenum : integer := 0;
        variable rw      : std_logic := '0';
    begin
        -- START: SDA falls while SCL is high. STOP: SDA rises while SCL is high.
        if falling_edge(sda) and scl = '1' and drive_low = '0' then
            active := true; nclk := 0; bytenum := 0;
        elsif rising_edge(sda) and scl = '1' and drive_low = '0' then
            active := false; nclk := 0;
        end if;

        if active then
            if rising_edge(scl) then
                nclk := nclk + 1;
                if bytenum = 0 and nclk = 8 then
                    rw := to_x01(sda);        -- last address bit is R/W
                end if;
            elsif falling_edge(scl) then
                if nclk = 8 then
                    -- acknowledge the address, and every byte the master writes
                    if bytenum = 0 or rw = '0' then drive_low <= '1'; end if;
                elsif nclk = 9 then
                    drive_low <= '0';
                    nclk := 0;
                    bytenum := bytenum + 1;
                end if;
            end if;
        end if;
    end process;
end architecture sim;
