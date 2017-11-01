
.CSEG
.ORG		0x01

INIT:	
		MOV		r30,0x00
		WSP		r30

		MOV		r1, 0x00	;Count signal 
		MOV 	r3, 0xFF	;reference to set scratch RAM
		CALL	LOOP
		MOV		r5, 0x03

LOOP:	
		PUSH	r3			;set Scratch ram memory location to 0x00
		SUB		r1, 0x01	;subtract counter
		BRNE		LOOP	
