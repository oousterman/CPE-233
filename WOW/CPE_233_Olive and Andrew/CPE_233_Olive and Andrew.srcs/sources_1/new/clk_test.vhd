----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/29/2017 01:04:44 AM
-- Design Name: 
-- Module Name: clk_test - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_test is
    Port ( clk : in STD_LOGIC;
           clk_out : out STD_LOGIC;
           clk_temp : buffer STD_LOGIC);
end clk_test;

architecture Behavioral of clk_test is

begin

process
begin
    if (rising_edge(clk)) then
        clk_temp <= not clk_temp;
    end if;
end process;

clk_out <= clk_temp;

end Behavioral;
