library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Program_Counter_Exp3 is
  port (  RESET : in std_logic;
                CLK : in std_logic;
                LD : in std_logic;
                EN : in std_logic; 
                --DIN : in std_logic_vector (3 downto 0); 
                COUNT : out std_logic_vector (9 downto 0);
                FROM_IMMED, FROM_STACK, INTERUPTS : in std_logic_vector (9 downto 0);
                PC_MUX_SEL : in std_logic_vector (1 downto 0)); 
end Program_Counter_Exp3; 

architecture Behavioral of Program_Counter_Exp3 is 

component MUX_4x1_10Bit
        port (  a : in STD_LOGIC_VECTOR (9 downto 0);
                b : in STD_LOGIC_VECTOR (9 downto 0);
                c : in STD_LOGIC_VECTOR (9 downto 0);
                d : in STD_LOGIC_VECTOR (9 downto 0);
                sel : in STD_LOGIC_VECTOR (1 downto 0);
                res : out STD_LOGIC_VECTOR (9 downto 0));
end component;

   signal  t_cnt : std_logic_vector(9 downto 0); 
   signal  D_IN : std_logic_vector (9 downto 0);
begin 
         
RAM_MUX: MUX_4x1_10Bit
    port Map (  a => FROM_IMMED,
                b => FROM_STACK,
                c => INTERUPTS,
                d => "0000000000",
                sel => PC_MUX_SEL,
                res => D_IN);

   process (CLK, RESET, LD, EN, t_cnt) 
   begin
      if (RESET = '1') then    
         t_cnt <= (others => '0'); -- async clear
      elsif (rising_edge(CLK)) then
         if (LD = '1') then     t_cnt <= D_IN;  -- load
         else 
            if (EN = '1') then  t_cnt <= t_cnt + 1; -- incr
            else                t_cnt <= t_cnt; -- const
            end if;
         end if;
      end if;
   end process;

   COUNT <= t_cnt; 

end Behavioral; 
