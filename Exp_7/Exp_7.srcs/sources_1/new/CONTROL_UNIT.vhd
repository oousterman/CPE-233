
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


Entity CONTROL_UNIT is
    Port ( CLK           : in   STD_LOGIC;
           C             : in   STD_LOGIC;
           Z             : in   STD_LOGIC;
           INT           : in   STD_LOGIC;
           RESET         : in   STD_LOGIC;
           OPCODE_HI_5   : in   STD_LOGIC_VECTOR (4 downto 0);
           OPCODE_LO_2   : in   STD_LOGIC_VECTOR (1 downto 0);
              
           PC_LD         : out  STD_LOGIC;
           PC_INC        : out  STD_LOGIC;
           PC_MUX_SEL    : out  STD_LOGIC_VECTOR(1 downto 0); 		  

           SP_LD         : out  STD_LOGIC;
           SP_INCR       : out  STD_LOGIC;
           SP_DECR       : out  STD_LOGIC;
 
           RF_WR         : out  STD_LOGIC;
           RF_WR_SEL     : out  STD_LOGIC_VECTOR (1 downto 0);

           ALU_OPY_SEL   : out  STD_LOGIC;
           ALU_SEL       : out  STD_LOGIC_VECTOR (3 downto 0);

           SCR_WR        : out  STD_LOGIC;
           SCR_DATA_SEL  : out  STD_LOGIC; 
           SCR_ADDR_SEL  : out  STD_LOGIC_VECTOR (1 downto 0);

           FLG_C_LD      : out  STD_LOGIC;
           FLG_C_SET     : out  STD_LOGIC;
           FLG_C_CLR     : out  STD_LOGIC;
           FLG_SHAD_LD   : out  STD_LOGIC;
           FLG_LD_SEL    : out  STD_LOGIC;
           FLG_Z_LD      : out  STD_LOGIC;
              
           I_SET         : out  STD_LOGIC;
           I_CLR         : out  STD_LOGIC;

           RST           : out  STD_LOGIC;
           IO_STRB       : out  STD_LOGIC);
end;

architecture Behavioral of CONTROL_UNIT is

   type state_type is (ST_init, ST_fet, ST_exec);
   signal PS,NS : state_type;
   
   signal sig_OPCODE_7: std_logic_vector (6 downto 0);

begin
   
   -- create 7-bit opcode field for instruction decoding
   sig_OPCODE_7 <= OPCODE_HI_5 & OPCODE_LO_2;

   sync_p: process (CLK, NS, RESET)
   begin
      if (rising_edge(CLK)) then 
         if (RESET = '1') then
            PS <= ST_init;
         else
            PS <= NS;
         end if;
      end if; 
   end process sync_p;


   comb_p: process (sig_OPCODE_7, PS, C, Z)
   begin
   
    	-- schedule everything to known values -----------------------
      PC_LD      <= '0';   
      PC_MUX_SEL <= "00";   	    
      PC_INC     <= '0';		  			      				

      SP_LD   <= '0';   
      SP_INCR <= '0'; 
      SP_DECR <= '0'; 
 
      RF_WR     <= '0';   
      RF_WR_SEL <= "00";   
  
      ALU_OPY_SEL <= '0';  
      ALU_SEL     <= "0000";       			

      SCR_WR       <= '0';       
      SCR_DATA_SEL <= '0';       
      SCR_ADDR_SEL <= "00";  
      
      FLG_C_SET   <= '0';   
	  FLG_C_CLR   <= '0'; 
      FLG_C_LD    <= '0';   
      FLG_Z_LD    <= '0'; 
      FLG_LD_SEL  <= '0';   
      FLG_SHAD_LD <= '0';    

      I_SET   <= '0';        
      I_CLR   <= '0';    

      IO_STRB <= '0';      
      RST     <= '0'; 
            
   case PS is
      
    -- STATE: the init cycle ------------------------------------
	-- Initialize all control outputs to non-active states and 
    --   Reset the PC and SP to all zeros.
	when ST_init => 
         RST <= '1'; 
	     NS <= ST_fet;
						 	
				
      -- STATE: the fetch cycle -----------------------------------
      when ST_fet => 
         NS <= ST_exec;
         PC_INC <= '1';  -- increment PC
            
            
      -- STATE: the execute cycle ---------------------------------
      when ST_exec => 
         NS <= ST_fet;
         PC_INC <= '0';  -- don't increment PC
				
	     case sig_OPCODE_7 is		

		  -- BRN -------------------
              when "0010000" =>   
                    PC_LD      <= '1';   
                    PC_MUX_SEL <= "00";           
                    PC_INC     <= '0';
                    NS <= ST_fet;
		  -- SUB reg-reg  --------
              when "0000110" =>					
                    ALU_OPY_SEL <= '0';  
                    ALU_SEL     <= "0010"; 
                    RF_WR     <= '1';   
                    RF_WR_SEL <= "00";
                    NS <= ST_fet;  
		  -- IN reg-immed  ------
              when "1100100" | "1100101" | "1100110" | "1100111" =>		                             
                    RF_WR     <= '1';   
                    RF_WR_SEL <= "11";
                    NS <= ST_fet;
		  -- OUT reg-immed  ------
              when "1101000" | "1101001" | "1101010" | "1101011" =>		               
                    IO_STRB <= '1';
                    NS <= ST_fet;
		  -- MOV reg-immed  ------
              when "1101100" | "1101101" | "1101110" | "1101111" =>		               
                    RF_WR     <= '1';   
                    RF_WR_SEL <= "01";
                    NS <= ST_fet;
              when others =>  -- for inner case
                  NS <= ST_fet;       

            end case; -- inner execute case statement


          when others =>    -- for outer case
               NS <= ST_fet;		    
			 
				 
	    end case;  -- outer init/fetch/execute case
       
   end process comb_p;
   
   
end Behavioral;