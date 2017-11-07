
.EQU    LEDS      = 0x74
.EQU	SWITCHES  = 0x75

.CSEG
.ORG	0x10

init:		IN 		R1, SWITCHES	;initialize with current switches
			AND		R2, xFE			;set register as flag with LSB unset
			MOV		R3, x00			;set register for LEDs off
			SEI

LED_ON:		OUT		R1, LEDS		
LED_OFF:	TEST	R2, x01
			BREQ		main
			OUT		R3, LEDS

INTER:		IN		R1, SWITCHES
			SEI

ISR:		EXOR	R2
			RETID

.ORG 	x3FF
			BRN		ISR 
