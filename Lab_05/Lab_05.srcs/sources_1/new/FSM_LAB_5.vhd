library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity FSM_LAB_5 is 
    port ( BTN, RCO0, RCO1, GT, CLK : in  STD_LOGIC; 
           MxSel0 : out STD_LOGIC_VECTOR(1 downto 0); 
           WE, CLR, CEN0, MxSel1, LDRG0 : out STD_LOGIC;
           STATE : out STD_LOGIC_VECTOR (2 downto 0));
end FSM_LAB_5;
architecture Behavioral of FSM_LAB_5 is
   type state_type is (Disp, Trans, Comp, LdRegSt, LdSt0, LdSt1); 
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
      STATE <= "111";
      
      case PS is  
         when Disp =>    -- items regarding state ST0
            CEN0 <= '1';  -- Moore output 
            STATE<= "001";
            if (BTN = '0') then 
                   NS <= Disp;
            else  
                   NS <= Trans; CLR <= '1';
            end if; 
                
         when Trans =>    -- items regarding state ST1
            CEN0 <= '1';  -- Moore output
            WE <= '1';
            MxSel0 <= "10";
            MxSel1 <= '0';
            STATE <= "010";
            if (RCO0 = '0') then 
                   NS <= Trans;
            else  
                   NS <= Comp; CLR <= '1'; WE <= '0';
            end if; 
                
         when Comp =>    -- items regarding state ST2
            CEN0 <= '1';  -- Moore output 
            MxSel1 <= '0';
            STATE <= "011";
            if (RCO1 = '1') then
                NS <= Disp;
            elsif (GT = '1') then
                NS <= LdRegSt; CEN0 <= '0';
            else
                NS <= Comp;
            end if;
         
         when LdRegSt =>
            STATE <= "100";
            LDRG0 <= '1';
            NS <= LdSt0;
                
         when LdSt0 =>    -- items regarding state ST3
            LDRG0 <= '0';  -- Moore output
            WE <= '1';
            MxSel0 <= "00";
            MxSel1 <= '1';
            CEN0 <= '0';
            STATE <= "101";
                NS <= LdSt1;


    
     when LdSt1 =>
        WE <= '1';
        MxSel0 <= "01";
        MxSel1 <= '0';
        CEN0 <= '0';
        STATE <= "110";
        NS <= Comp;
                         
     when others => -- the catch all condition
            NS <= Disp;
     end case; 
     
   end process comb_proc; 
 
end Behavioral;