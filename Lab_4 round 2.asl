

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


(0001)                            || .CSEG 
(0002)                       048  || .ORG 0x30
(0003)                            || 
(0004)  CS-0x030  0x36023  0x030  || start:  MOV r0,0X23
(0005)  CS-0x031  0x36167         ||         MOV r1,0X67
(0006)  CS-0x032  0x36208         ||         MOV r2,0X08
(0007)  CS-0x033  0x36300         ||         MOV r3,0X00
(0008)                            || 
(0009)  CS-0x034  0x18000         || CLC
(0010)  CS-0x035  0x10301         || LSR r3
(0011)  CS-0x036  0x10001         || LSR r0
(0012)  CS-0x037  0x10101         || LSR r1
(0013)  CS-0x038  0x10300         || LSL r3
(0014)                            || ;SUB r2,0X01
(0015)                            || BRN 0X34
            syntax error
            syntax error

(0016)  CS-0x039  0x10301         || LSR r3 
(0017)  CS-0x03A  0x10001         || LSR r0
(0018)                            || 		;BRN start
(0019)                            || 
(0020)                            || 
(0021)                            || 





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
START          0x030   (0004)  ||  


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
