

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
(0003)                       001  || .ORG 0X01
(0004)                            || 
(0005)                            || 
(0006)  CS-0x001  0x33500  0x001  || MAIN:	IN 		r21, 0X00	;take in numbers
(0007)  CS-0x002  0x33401         || 		IN		r20, 0X01
(0008)  CS-0x003  0x37F00         || 		MOV 	r31, 0X00	;Clear sum
(0009)                            || 
(0010)  CS-0x004  0x051A9         || 		MOV 	r17, r21	;Move hundreds place into multiplier register
(0011)  CS-0x005  0x08079         || 		CALL 	MULTI
(0012)  CS-0x006  0x05191         || 		MOV 	r17, r18
(0013)  CS-0x007  0x08079         || 		CALL 	MULTI
(0014)  CS-0x008  0x03F90         || 		ADD 	r31, r18
(0015)  CS-0x009  0x080A9         || 		CALL 	TENS		;Sets up 10's place
(0016)  CS-0x00A  0x08079         || 		CALL 	MULTI
(0017)  CS-0x00B  0x03F90         || 		ADD 	r31, r18
(0018)  CS-0x00C  0x2140F         || 		AND 	R20, 0X0F	;Isolate one's place
(0019)  CS-0x00D  0x03FA0         || 		ADD 	r31, r20
(0020)  CS-0x00E  0x08008         || 		BRN 	MAIN
(0021)                            || 
(0022)  CS-0x00F  0x3690A  0x00F  || MULTI:	MOV		r9, 0X0A	;Init loop to 10x
(0023)  CS-0x010  0x37200         || 		MOV 	r18, 0X00	;Clear counter
(0024)  CS-0x011  0x03288  0x011  || LOOP:	ADD   	r18, r17    ; accumulate
(0025)  CS-0x012  0x2C901         ||         SUB   	r9, 0x01    ; decrement loop count
(0026)  CS-0x013  0x0808B         ||         BRNE  	LOOP       	; repeat if necessary
(0027)  CS-0x014  0x18002         || 		RET
(0028)                            || 
(0029)  CS-0x015  0x13401  0x015  || TENS:	PUSH 	r20
(0030)  CS-0x016  0x36A04         || 		MOV 	r10, 0X04
(0031)  CS-0x017  0x18000         || 		CLC
(0032)  CS-0x018  0x11401  0x018  || SHIFT:	LSR 	r20
(0033)  CS-0x019  0x2CA01         || 		SUB 	r10, 0X01
(0034)  CS-0x01A  0x080C3         || 		BRNE	SHIFT
(0035)  CS-0x01B  0x051A1         || 		MOV 	r17, r20
(0036)  CS-0x01C  0x13402         || 		POP 	r20
(0037)  CS-0x01D  0x18002         || 		RET
(0038)                            || 
(0039)                            || 
(0040)                            || 
(0041)                            || 
(0042)                            || 
(0043)                            || 
(0044)                            || 





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
LOOP           0x011   (0024)  ||  0026 
MAIN           0x001   (0006)  ||  0020 
MULTI          0x00F   (0022)  ||  0011 0013 0016 
SHIFT          0x018   (0032)  ||  0034 
TENS           0x015   (0029)  ||  0015 


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
