library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Lab_5_Main is
    port ( BTN_IN       : in STD_LOGIC;
           clk          : in STD_LOGIC;
           DISP_EN      : out STD_LOGIC_VECTOR (3 downto 0);
           SEGMENTS     : out STD_LOGIC_VECTOR (7 downto 0));
           
end Lab_5_Main;



architecture Behavioral of Lab_5_Main is

component CLK_reducer
        Port (CLK       : in std_logic;
              FCLK,SCLK : out std_logic);
end component;


component Comparator_GT
        port (  a       : in STD_LOGIC_VECTOR (7 downto 0);
                b       : in STD_LOGIC_VECTOR (7 downto 0);
                GT      : out STD_LOGIC);
end component;

component MUX_2x1
        port ( a        : in STD_LOGIC_VECTOR (3 downto 0);
               b        : in STD_LOGIC_VECTOR (3 downto 0);
               sel      : in STD_LOGIC;
               res      : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component Counter_4Bit
        port (  RESET   : in std_logic;
                CLK     : in std_logic;
                LD      : in std_logic;
                EN      : in std_logic; 
                DIN     : in std_logic_vector (3 downto 0); 
                COUNT   : out std_logic_vector (3 downto 0);
                RCO     : out std_logic); 
end component;

component MUX_4x1
        port (  a       : in STD_LOGIC_VECTOR (7 downto 0);
                b       : in STD_LOGIC_VECTOR (7 downto 0);
                c       : in STD_LOGIC_VECTOR (7 downto 0);
                d       : in STD_LOGIC_VECTOR (7 downto 0);
                sel     : in STD_LOGIC_VECTOR (1 downto 0);
                res     : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component Dual_Port_Ram
       port (   D_IN    : in     STD_LOGIC_VECTOR (7 downto 0);
                DX_OUT  : out    STD_LOGIC_VECTOR (7 downto 0);
                DY_OUT  : out    STD_LOGIC_VECTOR (7 downto 0);
                ADRX    : in     STD_LOGIC_VECTOR (3 downto 0);
                ADRY    : in     STD_LOGIC_VECTOR (3 downto 0);
                WE      : in     STD_LOGIC;
                CLK     : in     STD_LOGIC);
end component;

component RCA_4Bit
        port (A         : in std_logic_vector(3 downto 0);
              B         : in std_logic_vector(3 downto 0); 
              Cin       : in std_logic; 
	          Co        : out std_logic; 
		  	  SUM       : out std_logic_vector(3 downto 0)); 
end component;

component ROM
        port (ADDR      : in  STD_LOGIC_VECTOR(3 downto 0); 
              DATA      : out STD_LOGIC_VECTOR(7 downto 0));
end component;

component Register_8Bit
        port (d_in      : in STD_LOGIC_VECTOR (7 downto 0);
              load      : in STD_LOGIC;
              d_out     : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component FSM_LAB_5
        port ( BTN      : in STD_LOGIC;
               RCO0     : in STD_LOGIC;
               RCO1     : in STD_LOGIC;
               GT       : in STD_LOGIC;
               CLK      : in STD_LOGIC;
               MxSel0   : out STD_LOGIC_VECTOR(1 downto 0);
               CEN0     : out STD_LOGIC;                      
               WE       : out STD_LOGIC;
               CLR      : out STD_LOGIC;
               MxSel1   : out STD_LOGIC;
               LDRG0    : out STD_LOGIC;
               STATE    : out STD_LOGIC_VECTOR(3 downto 0));
end component;

component sseg_dec_uni
        Port ( COUNT1   : in std_logic_vector(13 downto 0); 
               COUNT2   : in std_logic_vector(7 downto 0);
               SEL      : in std_logic_vector(1 downto 0);
               dp_oe    : in std_logic;
               dp       : in std_logic_vector(1 downto 0); 					  
               CLK      : in std_logic;
			   SIGN     : in std_logic;
			   VALID    : in std_logic;
               DISP_EN  : out std_logic_vector(3 downto 0);
               SEGMENTS : out std_logic_vector(7 downto 0));
end component;

--SIGNALS--
signal CNT0_RCO         : std_logic;
signal CNT1_RCO         : std_logic;
signal COMPAR_GT        : std_logic;
signal FSM_WE           : std_logic;
signal FSM_CLR          : std_logic;
signal FSM_CEN0         : std_logic;
signal FSM_MxSel1       : std_logic;
signal FSM_LDRG0        : std_logic;
signal SLW_CLK          : std_logic;
signal FST_CLK          : std_logic;
signal FSM_MxSel0       : std_logic_vector(1 downto 0);
signal FSM_STATE        : std_logic_vector(3 downto 0);
signal NONE             : std_logic_vector(3 downto 0);
signal MUX1_OUT         : std_logic_vector(3 downto 0);
signal CNT0             : std_logic_vector(3 downto 0);
signal RCA_SUM          : std_logic_vector(3 downto 0);
signal ROM_OUT          : std_logic_vector(7 downto 0);
signal MUX0_OUT         : std_logic_vector(7 downto 0);
signal REG0_OUT         : std_logic_vector(7 downto 0);
signal RAM_OUT_X        : std_logic_vector(7 downto 0);
signal RAM_OUT_Y        : std_logic_vector(7 downto 0);
signal RAM_OUT_X_13Bit  : std_logic_vector(13 downto 0);




begin

process (RAM_OUT_X_13Bit, RAM_OUT_X)
begin
RAM_OUT_X_13Bit <= "000000" & RAM_OUT_X;
end process;

CLK_SLOW: CLK_reducer
    port map(  CLK =>       clk,
               FCLK =>      FST_CLK,
               SCLK =>      SLW_CLK);

FSM1: FSM_LAB_5
    port Map(  BTN =>       BTN_IN,
               RCO0 =>      CNT0_RCO,
               RCO1 =>      CNT1_RCO,
               GT =>        COMPAR_GT,
               CLK =>       CLK,
               MxSel0 =>    FSM_MxSel0,
               LDRG0 =>     FSM_LDRG0,
               MxSel1 =>    FSM_MxSel1,
               CEN0 =>      FSM_CEN0,
               WE =>        FSM_WE,
               CLR =>       FSM_CLR,
               STATE =>     FSM_STATE);
               
COUNTER0: Counter_4bit  
    port Map (  RESET =>    FSM_CLR,
                CLK =>      CLK,
                LD =>       '0',
                EN =>       FSM_CEN0,
                DIN =>      "0000",
                COUNT =>    CNT0,
                RCO =>      CNT0_RCO);
                
COUNTER1: Counter_4bit
    port Map (  RESET =>    FSM_CLR,
                CLK =>      CLK,
                LD =>       '0', 
                EN =>       CNT0_RCO,
                DIN =>      "0000",
                COUNT =>    NONE,
                RCO =>      CNT1_RCO);
                
MUX_1: MUX_2x1
    port Map (  a =>        CNT0,
                b =>        RCA_SUM,
                sel =>      FSM_MxSel1,
                res =>      MUX1_OUT);
                
MUX_0: MUX_4x1
    port Map (  a =>        REG0_OUT,
                b =>        RAM_OUT_Y,
                c =>        ROM_OUT,
                d =>        "00000000",
                sel =>      FSM_MxSel0,
                res =>      MUX0_OUT);
                
RAM: Dual_Port_Ram
    port Map (  D_IN =>     MUX0_OUT,
                DX_OUT =>   RAM_OUT_X,
                DY_OUT =>   RAM_OUT_Y,
                ADRX =>     MUX1_OUT,
                ADRY =>     RCA_SUM,
                WE =>       FSM_WE,
                CLK =>      CLK);

REG0: Register_8Bit
    port Map (  d_in =>     RAM_OUT_X,
                load =>     FSM_LDRG0,
                d_out =>    REG0_OUT);

ROM_Main: ROM
    port Map (  ADDR =>     CNT0,
                DATA =>     ROM_OUT);

COMPARATOR: Comparator_GT
    port Map (  a =>        RAM_OUT_X,
                b =>        RAM_OUT_Y,
                GT =>       COMPAR_GT);

RCA: RCA_4Bit
    port Map (  A =>        CNT0,
                B =>        "0001",
                Cin =>      '0',
                SUM =>      RCA_SUM);

SSEG_DISPLAY: sseg_dec_uni
    port Map (  COUNT1 =>   RAM_OUT_X_13Bit,
                COUNT2 =>   "00000000",
                SEL    =>   "10",
                dp_oe  =>   '0',
                dp     =>   "00",
                CLK    =>   CLK,
                SIGN   =>   '0',
                VALID  =>   '1',
                DISP_EN =>  DISP_EN,
                SEGMENTS => SEGMENTS);
                

end Behavioral;
