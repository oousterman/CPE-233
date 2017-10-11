library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity FSM is 
    port ( BTN, RCO0, RCO1, GT, CLK : in  STD_LOGIC; 
           MxSel0 : out STD_LOGIC_VECTOR(1 downto 0); 
           WE, CLR, CEN0, MxSel1, LDRG0 : out STD_LOGIC);  
end FSM;
architecture Behavioral of FSM is
   type state_type is (Disp, Trans, Comp, LdSt0, LdSt1); 
   signal PS,NS : state_type; 
begin
   sync_proc: process(CLK,NS)
   begin
    if (rising_edge(CLK)) then  
         PS <= NS; 
     end if; 
   end process sync_proc; 
   comb_proc: process(PS, BTN, RCO0, RCO1,GT)
   begin
       
      CLR <= '0';
      CEN0 <= '0';
      MxSel1 <= '0';
      LDRG0 <= '0';
      WE <= '0';
      MxSel0 <= "00";
      
      case PS is  
         when Disp =>    -- items regarding state ST0
            CEN0 <= '1';  -- Moore output 
            if (BTN = '0') then 
                   NS <= Disp;
            else  
                   NS <= Trans; CLR <= '1';
            end if; 
                
         when Trans =>    -- items regarding state ST1
            CEN0 <= '1';  -- Moore output
            WE <= '1';
            MxSel0 <= "10";
            MxSel1 <= '0';
            if (RCO0 = '0') then 
                   NS <= Trans;
            else  
                   NS <= Comp; CLR <= '1'; WE <= '0';
            end if; 
                
         when Comp =>    -- items regarding state ST2
            CEN0 <= '1';  -- Moore output 
            MxSel1 <= '0';
            if (RCO0 = '1') then
                NS <= Disp;
            elsif (GT = '1') then
                NS <= LdSt0; CEN0 <= '0';
            else
                NS <= Comp;
            end if;
                
         when LdSt0 =>    -- items regarding state ST3
            LDRG0 <= '1';  -- Moore output
            WE <= '1';
            MxSel0 <= "00";
            MxSel1 <= '1';
            CEN0 <= '0';
                NS <= LdSt1; LDRG0 <= '0';


    
     when LdSt1 =>
        WE <= '1';
        MxSel0 <= "01";
        MxSel1 <= '0';
        CEN0 <= '0';
        NS <= Comp; WE <= '0';
                         
     when others => -- the catch all condition
            NS <= Disp;
     end case; 
     
   end process comb_proc; 
 
end Behavioral;