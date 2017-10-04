library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity my_nand2 is  
    port(   A,B : in STD_LOGIC;           
            f : out STD_LOGIC);  
end my_nand2;  
 
architecture my_nand2 of my_nand2 is  
begin    
    f <= a NAND b;  
end my_nand2;  
 
 
entity testnand is  
end testnand;  
 
architecture stimulus of testnand is  

component my_nand2
   port (   A,B : in STD_LOGIC;
            f : out STD_LOGIC);     
end component;  
 
   signal A,B,Y : std_logic;  
 
begin    -- instantiate the NAND gate    
n1: my_nand2     
    port map (a,b,y);  
 
   process
          constant PERIOD: time := 40 ns;  -- let's be generic    
   begin       
        A <= '1';  B <= '1';        
        wait for PERIOD;  
 
       A <= '1';  B <= '0';        
       wait for PERIOD;  
 
      A <= '0';  B <= '1';       
       wait for PERIOD;  
 
      A <= '0';  B <= '0';        
      wait for PERIOD;        
      wait;     
end process;  
end stimulus;