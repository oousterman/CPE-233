library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Counter_4Bit is
  port (  RESET : in std_logic;
                CLK : in std_logic;
                LD : in std_logic;
                EN : in std_logic; 
                DIN : in std_logic_vector (3 downto 0); 
                COUNT : out std_logic_vector (3 downto 0)); 
end Counter_4Bit; 

architecture Behavioral of Counter_4Bit is 
   signal  t_cnt : std_logic_vector(3 downto 0); 
begin 
         
   process (CLK, RESET, LD, EN, t_cnt) 
   begin
      if (RESET = '1') then    
         t_cnt <= (others => '0'); -- async clear
      elsif (rising_edge(CLK)) then
         if (LD = '1') then     t_cnt <= DIN;  -- load
         else 
            if (EN = '1') then  t_cnt <= t_cnt + 1; -- incr
            else                t_cnt <= t_cnt; -- const
            end if;
         end if;
      end if;
   end process;

   COUNT <= t_cnt; 

end Behavioral; 
