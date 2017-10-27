library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ROM is
    Port ( ADDR : in  STD_LOGIC_VECTOR(3 downto 0); 
           DATA : out STD_LOGIC_VECTOR(7 downto 0));
end ROM;
 
architecture Behavioral of ROM is
 
   TYPE vector_array is ARRAY(0 to 15) of STD_LOGIC_VECTOR(7 downto 0); 
   
   CONSTANT my_memory: vector_array := ( X"02", X"0A", X"12", X"1A",
                                         X"04", X"0C", X"14", X"1C",
                                         X"06", X"0E", X"16", X"1E",
                                         X"08", X"10", X"18", X"20");
begin
 
   DATA <= my_memory(CONV_INTEGER(ADDR));
 
end Behavioral;