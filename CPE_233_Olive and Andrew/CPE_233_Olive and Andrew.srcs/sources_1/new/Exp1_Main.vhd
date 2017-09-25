library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Exp1_Main is
    port ( start : in STD_LOGIC;
           clk : in STD_LOGIC;
           DISP_EN : out STD_LOGIC_VECTOR (7 downto 0);
           SEGMENTS : out STD_LOGIC_VECTOR (7 downto 0));
           
end Exp1_Main;



architecture Behavioral of Exp1_Main is

component Comarator_GT
        port (  a : in STD_LOGIC_VECTOR (7 downto 0);
                b : in STD_LOGIC_VECTOR (7 downto 0);
                GT : out STD_LOGIC);
end component;

component MUX_2x1
        port ( a : in STD_LOGIC_VECTOR (7 downto 0);
               b : in STD_LOGIC_VECTOR (7 downto 0);
               sel : in STD_LOGIC;
               res : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component Counter_4Bit
        port (  RESET : in std_logic;
                CLK : in std_logic;
                LD : in std_logic;
                EN : in std_logic; 
                DIN : in std_logic_vector (3 downto 0); 
                COUNT : out std_logic_vector (3 downto 0)); 
end component;

component MUX_4x1
        port (  a : in STD_LOGIC_VECTOR (7 downto 0);
                b : in STD_LOGIC_VECTOR (7 downto 0);
                c : in STD_LOGIC_VECTOR (7 downto 0);
                d : in STD_LOGIC_VECTOR (7 downto 0);
                sel : in STD_LOGIC_VECTOR (1 downto 0);
                res : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component RAM_16x8
        port (IN_DATA  : in  STD_LOGIC_VECTOR (7 downto 0);
	          OUT_DATA : out STD_LOGIC_VECTOR (7 downto 0); 
              ADDR     : in  STD_LOGIC_VECTOR (4 downto 0);
              WE       : in  STD_LOGIC; 
              CLK      : in  STD_LOGIC);
end component;

component RCA_5Bit
        port (A,B : in std_logic_vector(3 downto 0); 
              Cin : in std_logic; 
	          Co : out std_logic; 
		  	  SUM : out std_logic_vector(3 downto 0)); 
end component;

component ROM_Exp1
        port (ADDR : in  STD_LOGIC_VECTOR(3 downto 0); 
              DATA : out STD_LOGIC_VECTOR(7 downto 0));
end component;

component Register_8Bit
        port (d_in : in STD_LOGIC_VECTOR (7 downto 0);
              load : in STD_LOGIC;
              d_out : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component FSM_Exp1
        port ( BTN : in STD_LOGIC;
               RCO0, RCO1, GT, CLK : in  STD_LOGIC;
               RSEL : out STD_LOGIC_VECTOR(1 downto 0); 
               LD0, LD1, CSEL, EN0, EN1, WE, CL : out STD_LOGIC);
end component;


begin

FSM1: FSM_Exp1
    port Map(  BTN => start
               RCO0 => 
               RCO1 =>
               GT =>
               CLK =>
               RSEL => 
               LD0 =>
               LD1 =>
               CSEL =>
               EN0 =>
               EN1 =>
               WE =>
               CL =>);


end Behavioral;
