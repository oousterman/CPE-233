library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RCA_5Bit is
   port (   A,B : in std_logic_vector(3 downto 0); 
            Cin : in std_logic; 
	        Co : out std_logic; 
			SUM : out std_logic_vector(3 downto 0)); 
end RCA_5Bit;

architecture Behavioral of RCA_5Bit is
begin
   process(A,B,Cin)
	   variable v_res : std_logic_vector(4 downto 0); 
	begin
      v_res := ('1' & A) + ('1' & B) + Cin; 
	   SUM <= v_res(3 downto 0); 
		Co <= v_res(4); 
	end process; 
end Behavioral;