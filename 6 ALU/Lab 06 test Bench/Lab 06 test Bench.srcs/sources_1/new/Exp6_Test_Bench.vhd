----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/15/2017 10:40:24 PM
-- Design Name: 
-- Module Name: Exp6_Test_Bench - Behavioral
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

entity Exp6_Test_Bench is 
end Exp6_Test_Bench;

architecture stimulus of Exp6_Test_Bench is
    
    component ALU_RAT
        port(   A       : in STD_LOGIC_VECTOR (7 downto 0);
                B       : in STD_LOGIC_VECTOR (7 downto 0);
                Sel     : in STD_LOGIC_VECTOR (3 downto 0);
                Cin     : in STD_LOGIC;
                Result  : out STD_LOGIC_VECTOR (7 downto 0);
                C       : out STD_LOGIC;
                Z       : out STD_LOGIC);
    end component;

    signal C_in     : STD_LOGIC;
    signal Selin    : STD_LOGIC_VECTOR (3 downto 0);
    signal Ain      : STD_LOGIC_VECTOR (7 downto 0);
    signal Bin      : STD_LOGIC_VECTOR (7 downto 0);
    signal Resultout: STD_LOGIC_VECTOR (7 downto 0);
    signal Cout     : STD_LOGIC;
    signal Zout     : STD_LOGIC;
    signal CLK      : STD_LOGIC := '0';
    signal done     : STD_LOGIC := '0';
    constant PERIOD : time := 40 ns;

begin
--    ALU: ALU_RAT
--    port map (Ain, Bin, Selin, C_in, Resultout, Cout, Zout);
    
    my_clk:process
    begin
        while(done = '0') loop
            wait for PERIOD/2;
            CLK <= NOT CLK;
        end loop;
        wait;
    end process
    
    process
    begin
        Selin <= x"0";     --ADD
        Ain <= x"AA"; 
        Bin <= x"AA";
        C_in <= '0';
        wait for PERIOD;

        Selin <= x"1";      --ADDC
        Ain <= x"C8"; 
        Bin <= x"36";
        C_in <= '1';
        wait for PERIOD;
        
        Selin <= x"2";      --SUB
        Ain <= x"C8"; 
        Bin <= x"64";
        C_in <= '0';
        wait for PERIOD;
        
        Selin <= x"3";      --SUBC
        Ain <= x"C8"; 
        Bin <= x"C8";
        C_in <= '1';
        wait for PERIOD;
        
        Selin <= x"4";      --CMP
        Ain <= x"AA"; 
        Bin <= x"FF";
        C_in <= '0';
        wait for PERIOD;
        
        Selin <= x"4";      --CMP
        Ain <= x"AA"; 
        Bin <= x"AA";
        C_in <= '0';
        wait for PERIOD;
        
        Selin <= x"5";      --AND
        Ain <= x"AA"; 
        Bin <= x"CC";
        C_in <= '0';
        wait for PERIOD;
                
        Selin <= x"6";      --OR
        Ain <= x"AA"; 
        Bin <= x"AA";
        C_in <= '0';
        wait for PERIOD;
                        
        Selin <= x"7";      --EXOR
        Ain <= x"AA"; 
        Bin <= x"AA";
        C_in <= '0';
        wait for PERIOD;
        
        Selin <= x"8";      --TEST
        Ain <= x"AA"; 
        Bin <= x"55";
        C_in <= '0';
        wait for PERIOD;
                
        Selin <= x"9";      --LSL
        Ain <= x"01"; 
        Bin <= x"12";
        C_in <= '1';
        wait for PERIOD;
        
        Selin <= x"10";     --LSR
        Ain <= x"81"; 
        Bin <= x"33";
        C_in <= '0';
        wait for PERIOD;
                
        Selin <= x"12";     --ROL
        Ain <= x"01"; 
        Bin <= x"AB";
        C_in <= '1';
        wait for PERIOD;
        
        Selin <= x"12";     --ROR
        Ain <= x"81"; 
        Bin <= x"3C";
        C_in <= '0';
        wait for PERIOD;
        
        Selin <= x"13";     --ASR
        Ain <= x"81"; 
        Bin <= x"81";
        C_in <= '0';
        wait for PERIOD;
                
        Selin <= x"14";     --MOV
        Ain <= x"50"; 
        Bin <= x"30";
        C_in <= '0';
        wait for PERIOD;
       
    end process;
end stimulus;
    
    
    
    
    
    
    
--        port Map(   A       <= Ain,
--                    B       <= Bin,
--                    Sel     <= Selin,
--                    Cin     <= C_in,
--                    Result  <= Resultout,
--                    C       <= Cout,
--                    Z       <= Zout);
                    



end stimulus;






























