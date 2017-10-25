

-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 25.10.2017 21:55:29 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_RAT_MCU is
end tb_RAT_MCU;

architecture tb of tb_RAT_MCU is

    component RAT_MCU
        port (IN_PORT  : in std_logic_vector (7 downto 0);
              RESET    : in std_logic;
              CLK      : in std_logic;
              INT      : in std_logic;
              OUT_PORT : out std_logic_vector (7 downto 0);
              PORT_ID  : out std_logic_vector (7 downto 0);
              IO_STRB  : out std_logic);
    end component;

    signal IN_PORT  : std_logic_vector (7 downto 0);
    signal RESET    : std_logic;
    signal CLK      : std_logic;
    signal INT      : std_logic;
    signal OUT_PORT : std_logic_vector (7 downto 0);
    signal PORT_ID  : std_logic_vector (7 downto 0);
    signal IO_STRB  : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : RAT_MCU
    port map (IN_PORT  => IN_PORT,
              RESET    => RESET,
              CLK      => CLK,
              INT      => INT,
              OUT_PORT => OUT_PORT,
              PORT_ID  => PORT_ID,
              IO_STRB  => IO_STRB);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        IN_PORT <= (others => '0');
        INT <= '0';

        -- Reset generation
        -- EDIT: Check that RESET is really your reset signal
        RESET <= '1';
        wait for 100 ns;
        RESET <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        IN_PORT <= x"01";
        wait for 100 * TbPeriod;
        
        IN_PORT <= x"02";
        wait for 100 * TbPeriod;
        
        IN_PORT <= x"03";
        wait for 100 * TbPeriod;
        
        IN_PORT <= x"04";
        wait for 100 * TbPeriod;
        
        IN_PORT <= x"05";
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_RAT_MCU of tb_RAT_MCU is
    for tb
    end for;
end cfg_tb_RAT_MCU;


