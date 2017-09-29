----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/29/2017 03:04:13 AM
-- Design Name: 
-- Module Name: Exp3_Tester - Behavioral
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

entity Exp3_Tester is
  Port (    clk : in STD_LOGIC;
            IR : out STD_LOGIC_VECTOR(17 downto 0));
end Exp3_Tester;

architecture Behavioral of Exp3_Tester is

component Exp3_Main
    port (  FROM_IMMED, FROM_STACK, INTERUPTS : in STD_LOGIC_VECTOR (9 downto 0);
            PC_LD, PC_INC, RST, CLK : in STD_LOGIC;
            PC_MUX_SEL : in STD_LOGIC_VECTOR (1 downto 0);
            IR : out STD_LOGIC_VECTOR (17 downto 0));
end component;

signal IMMED, STACK , INT : STD_LOGIC_VECTOR(9 downto 0);
signal LD, INC, RESET: STD_LOGIC;
signal MUX : STD_LOGIC_VECTOR;
constant PERIOD: time:= 40ns;

begin

main: Exp3_Main
    port Map(   FROM_IMMED =>IMMED,
                FROM_STACK =>STACK,
                INTERUPTS =>INT,
                PC_LD =>LD,
                PC_INC =>INC,
                RST =>RESET,
                CLK =>clk,
                PC_MUX_SEL => MUX,
                IR =>IR);
    process
    begin  
        IMMED <= "00" & x"10";
        STACK <="00" & x"11";
        INT  <= "00" & x"12";
        LD <= '1';
        INC <= '0';
        MUX <= "00"; -- Test Immediate
        RESET <= '0';
--        wait for PERIOD;
        
        MUX <= "01"; -- Test Stack
--        wait for PERIOD;
        
        MUX <= "10"; -- Test Interrups
--        wait for PERIOD;
        
        RESET <='1';
        wait;
    end process;
end Behavioral;
