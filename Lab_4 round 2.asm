.CSEG 
.ORG 0x30

start:  MOV r0,0X23
        MOV r1,0X67
        MOV r2,0X08
        MOV r3,0X00

CLC
LSR r3
LSR r0
LSR r1
LSL r3
;SUB r2,0X01
BRN 0X34
LSR r3 
LSR r0
		;BRN start



