library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Exp1_Main is
    port ( BTN_IN : in STD_LOGIC;
           clk : in STD_LOGIC;
           DISP_EN : out STD_LOGIC_VECTOR (3 downto 0);
           SEGMENTS : out STD_LOGIC_VECTOR (7 downto 0));
           
end Exp1_Main;



architecture Behavioral of Exp1_Main is

component CLK_reducer
        Port (CLK : in std_logic;
              FCLK,SCLK : out std_logic);
end component;


component Comarator_GT
        port (  a : in STD_LOGIC_VECTOR (7 downto 0);
                b : in STD_LOGIC_VECTOR (7 downto 0);
                GT : out STD_LOGIC);
end component;

component MUX_2x1
        port ( a : in STD_LOGIC_VECTOR (3 downto 0);
               b : in STD_LOGIC_VECTOR (3 downto 0);
               sel : in STD_LOGIC;
               res : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component Counter_4Bit
        port (  RESET : in std_logic;
                CLK : in std_logic;
                LD : in std_logic;
                EN : in std_logic; 
                DIN : in std_logic_vector (3 downto 0); 
                COUNT : out std_logic_vector (3 downto 0);
                RCO : out std_logic); 
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
              ADDR     : in  STD_LOGIC_VECTOR (3 downto 0);
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
               LD0, LD1, CSEL, EN0, EN1, WE, CL, VALID : out STD_LOGIC);
end component;

component sseg_dec_uni
        Port ( COUNT1 : in std_logic_vector(13 downto 0); 
               COUNT2 : in std_logic_vector(7 downto 0);
               SEL : in std_logic_vector(1 downto 0);
               dp_oe : in std_logic;
               dp : in std_logic_vector(1 downto 0); 					  
               CLK : in std_logic;
			   SIGN : in std_logic;
			   VALID : in std_logic;
               DISP_EN : out std_logic_vector(3 downto 0);
               SEGMENTS : out std_logic_vector(7 downto 0));
end component;

signal COUNTER0_RCO, COUNTER1_RCO, COMPARATOR_GT,FSM_VALID: STD_LOGIC;
signal FSM_LD0, FSM_LD1, FSM_EN0, FSM_EN1, FSM_WE, FSM_CL, FSM_CSEL, FSM_RCO0, FSM_RCO1, RCA_CO: std_LOGIC;
signal FSM_RSEL: STD_LOGIC_VECTOR(1 downto 0);
signal RCA_OUT, COUNTER0_COUNT, COUNTER_MUX_OUT : STD_LOGIC_VECTOR (3 downto 0);
signal ROM_DATA, REG0_OUT, REG1_OUT, RAM_MUX_OUT, RAM_DATA_OUT:STD_LOGIC_VECTOR (7 downto 0);
signal RAM_DOUT_13Bit : STD_LOGIC_VECTOR (13 downto 0);

signal s0, slow_CLK: STD_LOGIC;
signal s2 : STD_LOGIC_VECTOR (3 downto 0);

begin

process (RAM_DOUT_13Bit, RAM_DATA_OUT)
begin
RAM_DOUT_13Bit <= "000000" & RAM_DATA_OUT;
end process;

CLK_SLOW: CLK_reducer
    port map(CLK => clk,
             FCLK => slow_CLK,
             SCLK => s0);

FSM1: FSM_Exp1
    port Map(  BTN => BTN_IN,
               RCO0 => FSM_RCO0,
               RCO1 => FSM_RCO1,
               GT => COMPARATOR_GT,
               CLK => slow_CLK,
               RSEL => FSM_RSEL,
               LD0 => FSM_LD0,
               LD1 => FSM_LD1,
               CSEL => FSM_CSEL,
               EN0 => FSM_EN0,
               EN1 => FSM_EN1,
               WE => FSM_WE,
               CL => FSM_CL,
               VALID => FSM_VALID);
               
COUNTER0: Counter_4bit  
    port Map (  RESET => FSM_CL,
                CLK => slow_CLK,
                LD => '0', 
                EN => FSM_EN0,
                DIN => "0000",
                COUNT => COUNTER0_COUNT,
                RCO => FSM_RCO0);
                
COUNTER1: Counter_4bit
    port Map (  RESET => FSM_CL,
                CLK => slow_CLK,
                LD => '0', 
                EN => FSM_RCO0,
                DIN => "0000",
                COUNT => s2,
                RCO => FSM_RCO1);
                
COUNTER_MUX: MUX_2x1
    port Map (  a => RCA_OUT,
                b => COUNTER0_COUNT,
                sel => FSM_CSEL,
                res => COUNTER_MUX_OUT);
                
RAM_MUX: MUX_4x1
    port Map (  a => ROM_DATA,
                b => REG1_OUT,
                c => REG0_OUT,
                d => "00000000",
                sel => FSM_RSEL,
                res => RAM_MUX_OUT);
                
RAM: RAM_16x8
    port Map (  IN_DATA  => RAM_MUX_OUT,
                OUT_DATA => RAM_DATA_OUT,
                ADDR     => COUNTER_MUX_OUT,
                WE       => FSM_WE,
                CLK      => slow_CLK);

REG0: Register_8Bit
    port Map (  d_in => RAM_DATA_OUT,
                load => FSM_LD0,
                d_out => REG0_OUT);
                
REG1: Register_8Bit
    port Map (  d_in => RAM_DATA_OUT,
                load => FSM_LD1,
                d_out => REG1_OUT);

ROM: ROM_Exp1
    port Map (  ADDR => COUNTER0_COUNT,
                DATA => ROM_DATA);

COMPARATOR: Comarator_GT
    port Map (  a => REG0_OUT,
                b => REG1_OUT,
                GT => COMPARATOR_GT);

RCA: RCA_5Bit
    port Map (  A => COUNTER0_COUNT,
                B => "0001",
                Cin => '0',
                Co => RCA_CO,
                SUM => RCA_OUT);

SSEG_DISPLAY: sseg_dec_uni
    port Map (  COUNT1 => RAM_DOUT_13Bit,
                COUNT2 => "00000000",
                SEL    => "10",
                dp_oe  => '0',
                dp     => "00",
                CLK    => clk,
                SIGN   => '0',
                VALID  => FSM_VALID,
                DISP_EN => DISP_EN,
                SEGMENTS => SEGMENTS);
                

end Behavioral;








