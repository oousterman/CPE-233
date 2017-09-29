library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity FSM_Exp1 is 
    port ( BTN, RCO0,RCO1, GT, CLK : in  STD_LOGIC; 
           RSEL : out STD_LOGIC_VECTOR(1 downto 0); 
           LD0, CSEL, LD1, EN0, EN1, WE, CL,VALID : out STD_LOGIC);
             
end FSM_Exp1;
architecture Behavioral of FSM_Exp1 is
   type state_type is (ST0,ST1,ST2,ST3,ST4,ST5,ST6); 
   signal PS,NS : state_type; 
begin
   sync_proc: process(CLK,NS)
   begin
    if (rising_edge(CLK)) then  
         PS <= NS; 
     end if; 
   end process sync_proc; 
   comb_proc: process(PS,BTN, RCO0,RCO1,GT)
   begin
       
      LD0 <= '0';
      LD1 <= '0';
      CSEL <= '0';
      EN0 <= '0';
      EN1 <= '0';
      WE <= '0';
      CL <= '0';
      RSEL <= "00";
      VALID <= '0';
      
      case PS is  
         when ST0 =>    --WAIT AND DISPLAY
            CSEL <= '1';  -- Moore output 
            EN0 <= '1';
            if (BTN = '0') then 
                   NS <= ST0; VALID <= '1';  
            else  
                   NS <= ST1; CL <= '1';
            end if; 
                
         when ST1 =>    -- LOAD RAM
            CSEL <= '1';  -- Moore output
            WE <= '1';
            EN0 <= '1';
            CL <= '0';
            if (RCO0 = '0') then 
                   NS <= ST1;
            else  
                   NS <= ST2;
            end if; 
                
         when ST2 =>    -- LOAD REG0
            CSEL <= '1';  -- Moore output 
            LD0 <= '1';
            NS <= ST3;
                
         when ST3 =>    -- LOAD REG1
            LD1 <= '1';  -- Moore output 
            if (GT = '1') then 
                   NS <= ST6;
            else  
                   NS <= ST4;   
            end if;
    
     when ST4 =>
        RSEL <= "10";
        WE <= '1';
        NS <= ST5;
     when ST5 =>
        RSEL <= "01";
        WE <= '1';
        CSEL <= '1';
        NS <= ST6;
     when ST6 =>
        EN0 <= '1';
        if (RCO1 = '0' and RCO0 = '1') then    --LOOKS LIKE YOURE TESTING RCO0 WHEN YOU SHOULD BE TESTING RCA-CO
                   NS <= ST6;
        elsif (RCO1 = '0' and RCO0 = '0') then --^^^^
                   NS <= ST2;
        elsif (RCO1 = '0' and RCO0 = '1') then --^^^^
                   NS <= ST2; EN0 <= '1';
        else
                   NS <= ST0; 
        end if;  
                         
     when others => -- the catch all condition
            NS <= ST0;
     end case; 
        
   end process comb_proc; 
 
end Behavioral;