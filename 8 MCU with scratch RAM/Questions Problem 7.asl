

List FileKey 
----------------------------------------------------------------------
C1      C2      C3      C4    || C5
--------------------------------------------------------------
C1:  Address (decimal) of instruction in source file. 
C2:  Segment (code or data) and address (in code or data segment) 
       of inforation associated with current linte. Note that not all
       source lines will contain information in this field.  
C3:  Opcode bits (this field only appears for valid instructions.
C4:  Data field; lists data for labels and assorted directives. 
C5:  Raw line from source code.
----------------------------------------------------------------------


(0001)                            || 
(0002)                            || .CSEG
(0003)                       001  || .ORG		0x01
(0004)                            || 
(0005)                     0x001  || INIT:	
(0006)  CS-0x001  0x37E00         || 		MOV		r30,0x00
(0007)  CS-0x002  0x15E00         || 		WSP		r30
(0008)                            || 
(0009)  CS-0x003  0x36100         || 		MOV		r1, 0x00	;Count signal 
(0010)  CS-0x004  0x363FF         || 		MOV 	r3, 0xFF	;reference to set scratch RAM
(0011)  CS-0x005  0x08039         || 		CALL	LOOP
(0012)  CS-0x006  0x36503         || 		MOV		r5, 0x03
(0013)                            || 
(0014)                     0x007  || LOOP:	
(0015)  CS-0x007  0x12301         || 		PUSH	r3			;set Scratch ram memory location to 0x00
(0016)  CS-0x008  0x2C101         || 		SUB		r1, 0x01	;subtract counter
(0017)  CS-0x009  0x0803B         || 		BRNE		LOOP	





Symbol Table Key 
----------------------------------------------------------------------
C1             C2     C3      ||  C4+
-------------  ----   ----        -------
C1:  name of symbol
C2:  the value of symbol 
C3:  source code line number where symbol defined
C4+: source code line number of where symbol is referenced 
----------------------------------------------------------------------


-- Labels
------------------------------------------------------------ 
INIT           0x001   (0005)  ||  
LOOP           0x007   (0014)  ||  0011 0017 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
--> No ".EQU" directives used


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
