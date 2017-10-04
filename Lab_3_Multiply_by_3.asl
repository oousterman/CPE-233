

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


(0001)                            || ;-------------------------------------------------------------------- 
(0002)                            || ;- Port and Memory Constants 
(0003)                            || ;-------------------------------------------------------------------- 
(0004)                            || 
(0005)                            || 
(0006)                            || ;-------------------------------------------------------------------- 
(0007)                            || .CSEG 
(0008)                       001  || .ORG 0x01 	   
(0009)                            || 
(0010)                            || ;-- input a value from the switch port and multiply it by 4
(0011)                            || ;-- place the result in register 20 (r20)
(0012)                            || 
(0013)  CS-0x001  0x1A001  0x001  || init:    CLI                        ; turn off interrupt
(0014)                            || 
(0015)  CS-0x002  0x32899  0x002  || main:    IN    r8, 0x99			    ; input value
(0016)  CS-0x003  0x36903         ||          MOV   r9, 0x03             ; init loop count
(0017)  CS-0x004  0x37400         ||          MOV   r20, 0x00            ; clear accumulator
(0018)                            ||        
(0019)  CS-0x005  0x03440  0x005  || loop:    ADD   r20, r8              ; accumulate
(0020)  CS-0x006  0x2C901         ||          SUB   r9, 0x01             ; decrement loop count
(0021)  CS-0x007  0x0802B         ||          BRNE  loop                 ; repeat if necessary
(0022)                            || 
(0023)  CS-0x008  0x35433         || 		 OUT   r20, 0x33 			;Output to 0x33
(0024)  CS-0x009  0x08010         ||          BRN   main                 ; do it all again
ary





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
INIT           0x001   (0013)  ||  
LOOP           0x005   (0019)  ||  0021 
MAIN           0x002   (0015)  ||  0024 


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
