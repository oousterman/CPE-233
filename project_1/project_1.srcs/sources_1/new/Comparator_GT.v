library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Comparator_GT is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           GT : out STD_LOGIC_VECTOR );
end Comparator_GT;

architecture Behavioral of Comparator_GT is

begin
    process(a,b)
    begin
        if (a>b) then
            GT <= '1';
        elsif (a<b) then
            GT <= '0';
        end if;
    end process;
end Behavioral;
