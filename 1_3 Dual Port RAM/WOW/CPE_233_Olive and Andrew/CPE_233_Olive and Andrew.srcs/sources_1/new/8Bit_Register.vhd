

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity 8Bit_Register is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           sel : in STD_LOGIC;
           res : out STD_LOGIC_VECTOR (7 downto 0));
end 8Bit_Register;

architecture Behavioral of 8Bit_Register is

begin
    select1: process (a,b, sel)
    begin
        if sel = '0' then
            res <= a;
        else
            res <= b;
        end if;
    end process;
    
end Behavioral;
