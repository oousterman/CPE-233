
.CSEG
.ORG 0X01


MAIN:	IN 		r21, 0X00	;take in numbers
		IN		r20, 0X01
		MOV 	r31, 0X00	;Clear sum

		MOV 	r17, r21	;Move hundreds place into multiplier register
		CALL 	MULTI
		MOV 	r17, r18
		CALL 	MULTI
		ADD 	r31, r18
		CALL 	TENS		;Sets up 10's place
		CALL 	MULTI
		ADD 	r31, r18
		AND 	R20, 0X0F	;Isolate one's place
		ADD 	r31, r20
		BRN 	MAIN

MULTI:	MOV		r9, 0X0A	;Init loop to 10x
		MOV 	r18, 0X00	;Clear counter
LOOP:	ADD   	r18, r17    ; accumulate
        SUB   	r9, 0x01    ; decrement loop count
        BRNE  	LOOP       	; repeat if necessary
		RET

TENS:	PUSH 	r20
		MOV 	r10, 0X04
		CLC
SHIFT:	LSR 	r20
		SUB 	r10, 0X01
		BRNE	SHIFT
		MOV 	r17, r20
		POP 	r20
		RET







