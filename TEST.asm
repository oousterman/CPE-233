

.EQU SWITCH_PORT = 0x20   

.CSEG 
.ORG 0x20 	   

         MOV   r0,0xFF             ; set stack pointer at 0xFF
         WSP   r0

main:    IN    r8, SWITCH_PORT     ; input value
         CALL  Sub_5x              ; make subroutine call
         BRN   main                ; do it again 

.CSEG 
.ORG 0x30
;-----------------------------------------------------------
;-- multiply value in r8 by 5; place result in r20
;-----------------------------------------------------------
Sub_5x:  MOV   r9, 0x05            ; init loop count
         MOV   r20, 0x00           ; clear accumulator
       
loop:    ADD   r20, r8             ; accumulate
         SUB   r9, 0x01            ; decrement loop count
         BRNE  loop                ; repeat if necessary
         RET                       ; do it all again