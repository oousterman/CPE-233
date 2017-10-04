library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Exp3_Main1 is
  Port ( FROM_IMMED, FROM_STACK, INTERUPTS : in STD_LOGIC_VECTOR (9 downto 0);
         PC_LD, PC_INC, RST, CLK : in STD_LOGIC;
         PC_MUX_SEL : in STD_LOGIC_VECTOR (1 downto 0);
         IR : out STD_LOGIC_VECTOR (17 downto 0));
end Exp3_Main1;

architecture Behavioral of Exp3_Main1 is

component Program_Counter_Exp3
        port (  RESET : in std_logic;
                CLK : in std_logic;
                LD : in std_logic;
                EN : in std_logic;
                COUNT : out std_logic_vector (9 downto 0);
                FROM_IMMED, FROM_STACK, INTERUPTS : in std_logic_vector (9 downto 0);
                PC_MUX_SEL : in std_logic_vector (1 downto 0)); 
end component;

component ProgramROM_Exp3
        port (     ADDRESS : in std_logic_vector(9 downto 0); 
                   INSTRUCTION : out std_logic_vector(17 downto 0); 
                   CLK : in std_logic);  
end component;

signal PC_COUNT : STD_LOGIC_VECTOR (9 downto 0);

begin

PC: Program_Counter_Exp3  
    port Map (  RESET => RST,
                CLK => CLK,
                LD => PC_LD,
                EN => PC_INC,
                FROM_IMMED => FROM_IMMED,
                FROM_STACK => FROM_STACK,
                INTERUPTS => INTERUPTS,
                PC_MUX_SEL => PC_MUX_SEL,
                COUNT => PC_COUNT);
                
PROM: ProgramROM_Exp3
    port map ( ADDRESS => PC_COUNT,
               INSTRUCTION => IR,
               CLK => CLK);
                

end Behavioral;
