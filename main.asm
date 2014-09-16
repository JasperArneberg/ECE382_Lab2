;-------------------------------------------------------------------------------
; Lab 2: Cryptogrpahy
; C2C Jasper T. Arneberg
; T5 ECE 382
; Capt Trimble
;
; Documentation: None
;
; Description:
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file

;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section
            .retainrefs                     ; Additionally retain any sections
                                            ; that have references to current
                                            ; section
message:	.byte		0x00, 0x11, 0x11
key:		.equ		0xac

			.data
results:	.space		256					;256 bytes of memory in RAM
			.text							;back to ROM
;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer

;-------------------------------------------------------------------------------
                                            ; Main loop here
;-------------------------------------------------------------------------------

initialize:
		;load key and memory addresses
		mov.b		#message,	R5
		mov.b		#key,		R6
		mov.b		#results,	R7
		call		#decrypt_message

end:
		jmp			end							;infinite loop

;---------------------------------------------------
;Subroutine Name: decrpyt_message
;Author: C2C Jasper Arneberg, USAF
;Function: Decrpyts message using key
;Inputs: message address in R5, key value in R6, result
;		address in R7
;Outputs: result in RAM
;Registers destroyed:
;---------------------------------------------------
decrypt_message:
    	;load next byte, store in R8
    	mov.b		@R5+,		R8
    	call 		#decrypt_byte
    	;store result in R8 to RAM
    	mov.b		R8,			0(R7)
    	inc.b		R7
    ret

;---------------------------------------------------
;Subroutine Name: decrpyt_byte
;Author: C2C Jasper Arneberg, USAF
;Function: Decrpyts single byte
;Inputs: message byte in R8, key value in R6
;Outputs: result in R8
;Registers destroyed: R8
;---------------------------------------------------
decrypt_byte:
    	;xor R8 message byte and R6 key
    	xor.b		R6,			R8
    ret

;-------------------------------------------------------------------------------
;           Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect 	.stack

;-------------------------------------------------------------------------------
;           Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
