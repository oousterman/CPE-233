;-------------------------------------------------------------------- 
;- Port and Memory Constants 
;-------------------------------------------------------------------- 


;-------------------------------------------------------------------- 
.CSEG 
.ORG 0x01 	   

;-- input a value from the switch port and multiply it by 4
;-- place the result in register 20 (r20)

init:    CLI                        ; turn off interrupt

main:    IN    r8, 0x99			    ; input value
         MOV   r9, 0x03             ; init loop count
         MOV   r20, 0x00            ; clear accumulator
       
loop:    ADD   r20, r8              ; accumulate
         SUB   r9, 0x01             ; decrement loop count
         BRNE  loop                 ; repeat if necessary

		 OUT   r20, 0x33 			;Output to 0x33
         BRN   main                 ; do it all again