library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Counter_4Bit is
  port (    RESET : in std_logic;
            CLK : in std_logic;
            LD : in std_logic;
            EN : in std_logic; 
            DIN : in std_logic_vector (3 downto 0); 
            COUNT : out std_logic_vector (3 downto 0);
            RCO : out std_logic);
end Counter_4Bit; 

architecture Behavioral of Counter_4Bit is 
   signal  t_cnt : std_logic_vector(3 downto 0);
   signal  OVERFLOW : std_logic;
begin 
         
   process (CLK, RESET, LD, EN, t_cnt, OVERFLOW) 
   begin
      if (RESET = '1') then    
         t_cnt <= (others => '0'); -- async clear
      elsif (rising_edge(CLK)) then
         OVERFLOW <='0';
         if (LD = '1') then     t_cnt <= DIN;  -- load
         else 
            if (EN = '1') then  t_cnt <= t_cnt + 1;
                if(t_cnt = "1111") then OVERFLOW <= '1'; --RCO
                end if; -- incr
            else                t_cnt <= t_cnt; -- const
            end if;
         end if;
      end if;
   end process;

   COUNT <= t_cnt; 
   RCO <= OVERFLOW;

end Behavioral; 
