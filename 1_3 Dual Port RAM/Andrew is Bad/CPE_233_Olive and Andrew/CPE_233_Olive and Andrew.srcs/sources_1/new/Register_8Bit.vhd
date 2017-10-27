

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register_8Bit is
    Port (d_in : in STD_LOGIC_VECTOR (7 downto 0);
          load : in STD_LOGIC;
          d_out : out STD_LOGIC_VECTOR (7 downto 0));
end Register_8Bit;

architecture Behavioral of Register_8Bit is

begin
    loadD: process (d_in, load)
    begin
        if load = '1' then
            d_out <= d_in;
        end if;
    end process;
    
end Behavioral;
