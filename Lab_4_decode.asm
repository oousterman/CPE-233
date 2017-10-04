.CSEG 
.ORG 0X30

start:	MOV r0,0X23
		MOV r1,0X67
		MOV r2,0X08
		MOV r3,0X00
loop:	CLC
		LSR r3
		LSR r0
		LSR r1
		LSL r3 
		SUB r2,0X01 
		BRNE loop 
		LSR r3 
		LSR r0
		BRN  