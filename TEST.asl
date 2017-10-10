

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
(0002)                            || 
(0003)                       032  || .EQU SWITCH_PORT = 0x20   
(0004)                            || 
(0005)                            || .CSEG 
(0006)                       032  || .ORG 0x20 	   
(0007)                            || 
(0008)  CS-0x020  0x360FF         ||          MOV   r0,0xFF             ; set stack pointer at 0xFF
(0009)  CS-0x021  0x14000         ||          WSP   r0
(0010)                            || 
(0011)  CS-0x022  0x32820  0x022  || main:    IN    r8, SWITCH_PORT     ; input value
(0012)  CS-0x023  0x08181         ||          CALL  Sub_5x              ; make subroutine call
(0013)  CS-0x024  0x08110         ||          BRN   main                ; do it again 
(0014)                            || 
(0015)                            || .CSEG 
(0016)                       048  || .ORG 0x30
(0017)                            || ;-----------------------------------------------------------
(0018)                            || ;-- multiply value in r8 by 5; place result in r20
(0019)                            || ;-----------------------------------------------------------
(0020)  CS-0x030  0x36905  0x030  || Sub_5x:  MOV   r9, 0x05            ; init loop count
(0021)  CS-0x031  0x37400         ||          MOV   r20, 0x00           ; clear accumulator
(0022)                            ||        
(0023)  CS-0x032  0x03440  0x032  || loop:    ADD   r20, r8             ; accumulate
(0024)  CS-0x033  0x2C901         ||          SUB   r9, 0x01            ; decrement loop count
(0025)  CS-0x034  0x08193         ||          BRNE  loop                ; repeat if necessary
(0026)  CS-0x035  0x18002         ||          RET                       ; do it all again
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
LOOP           0x032   (0023)  ||  0025 
MAIN           0x022   (0011)  ||  0013 
SUB_5X         0x030   (0020)  ||  0012 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
SWITCH_PORT    0x020   (0003)  ||  0011 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
