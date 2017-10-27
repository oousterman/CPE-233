library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-----------------------------------------------------------------------
-- Module to divide the clock 
-----------------------------------------------------------------------
entity CLK_reducer is
    Port (       CLK : in std_logic;
           FCLK,SCLK : out std_logic);
end CLK_reducer;

architecture my_clk_div of CLK_reducer is
   constant MAX_COUNT_SLOW : integer := (10000000);  -- clock divider
   constant MAX_COUNT_FAST : integer := (22000000);     -- clock divider 
   signal tmp_clks : std_logic := '0'; 
   signal tmp_clkf : std_logic := '0'; 
	
begin

   my_div_slow: process (clk,tmp_clks)              
      variable div_cnt : integer := 0;   
   begin
      if (rising_edge(clk)) then   
         if (div_cnt = MAX_COUNT_SLOW) then 
            tmp_clks <= not tmp_clks; 
            div_cnt := 0; 
         else
            div_cnt := div_cnt + 1; 
         end if; 
      end if; 
      SCLK <= tmp_clks; 
   end process my_div_slow; 

   my_div_fast: process (clk,tmp_clkf)              
      variable div_cnt : integer := 0;   
   begin
      if (rising_edge(clk)) then   
         if (div_cnt = MAX_COUNT_FAST) then 
            tmp_clkf <= not tmp_clkf; 
            div_cnt := 0; 
         else
            div_cnt := div_cnt + 1; 
         end if; 
      end if; 
      FCLK <= tmp_clkf; 
   end process my_div_fast; 
	
end my_clk_div;