----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/22/2017 03:18:39 PM
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is
    Port ( BTN : in STD_LOGIC;
           RCO0 : in STD_LOGIC;
           RCO1 : in STD_LOGIC;
           GT : in STD_LOGIC;
           CSEL : out STD_LOGIC_VECTOR (1 downto 0);
           RSEL : in STD_LOGIC;
           LD0 : in STD_LOGIC;
           LD1 : in STD_LOGIC;
           EN0 : in STD_LOGIC;
           EN1 : in STD_LOGIC;
           WE : in STD_LOGIC;
           CL : in STD_LOGIC);
end FSM;

architecture Behavioral of FSM is

begin


end Behavioral;
