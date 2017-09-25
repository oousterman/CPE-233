library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RAM_16x8 is
    Port ( IN_DATA  : in  STD_LOGIC_VECTOR (7 downto 0);
	       OUT_DATA : out STD_LOGIC_VECTOR (7 downto 0); 
           ADDR     : in  STD_LOGIC_VECTOR (4 downto 0);
           WE       : in  STD_LOGIC; 
           CLK      : in  STD_LOGIC);
end RAM_16x8;

architecture Behavioral of RAM_16x8 is
   TYPE memory is array (0 to 31) of std_logic_vector(3 downto 0);
   SIGNAL MY_RAM : memory := (others => (others =>'0') );
begin

   the_ram: process(CLK,WE,IN_DATA,ADDR,MY_RAM)
   begin
       if (WE = '1') then 
          if (rising_edge(CLK)) then 
              MY_RAM(conv_integer(ADDR)) <= IN_DATA;
          end if; 
       end if; 
 
       OUT_DATA <= MY_RAM(conv_integer(ADDR));
 

   end process the_ram; 
   	
end Behavioral;
