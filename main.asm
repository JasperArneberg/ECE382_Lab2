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
message:	.byte		0x35,0xdf,0x00,0xca,0x5d,0x9e,0x3d,0xdb,0x12,0xca,0x5d,0x9e,0x32,0xc8,0x16,0xcc,0x12,0xd9,0x16,0x90,0x53,0xf8,0x01,0xd7,0x16,0xd0,0x17,0xd2,0x0a,0x90,0x53,0xf9,0x1c,0xd1,0x17,0x90,0x53,0xf9,0x1c,0xd1,0x17,0x90
key:		.byte		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00

message_length:		.equ		42
key_length:			.equ		8

			.data
results:	.space		42					;256 bytes of memory in RAM
			.text							;back to ROM
;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer

;-------------------------------------------------------------------------------
                                            ; Main loop here
;-------------------------------------------------------------------------------
testkey:
		mov.b		#0x90,		R4
		mov.b		#0x2E,		R5
		xor			R4,			R5

initialize:
		;load key and memory addresses
		mov			#message,	R5
		mov			#key,		R6
		mov			#results,	R7
		clr			R9						;message loop counter
		mov			#key_length,R10
		mov			#message_length,R12
		clr			R13						;key loop counter
		call		#decrypt_message

end:
		jmp			end						;infinite loop

;---------------------------------------------------
;Subroutine Name: decrpyt_message
;Author: C2C Jasper Arneberg, USAF
;Function: Decrpyts message using key
;Inputs: message address in R5, key address in R6, result
;		address in R7, message length in R12
;Outputs: result in RAM
;Registers destroyed: R9
;---------------------------------------------------
decrypt_message:
		;load next byte, store in R8
    	mov.b		@R5+,		R8
    	;load key byte

    	call 		#decrypt_byte
    	;store result in R8 to RAM
    	mov.b		R8,			0(R7)
    	inc			R7
    	inc 		R9
    	cmp			R12, 	R9					;compare to message length
    	jnz			decrypt_message
    ret

;---------------------------------------------------
;Subroutine Name: decrpyt_byte
;Author: C2C Jasper Arneberg, USAF
;Function: Decrpyts single byte
;Inputs: message byte in R8, key in R6, key_length in R10
;Outputs: result in R8
;Registers destroyed: R8
;---------------------------------------------------
decrypt_byte:
    	;xor R8 message byte and R6 key
    	;get key byte

    	mov.b		@R6+,		R11
    	xor.b		R11,		R8

    	inc			R13							;key loop counter
    	cmp			R13,		R10
    	jnz			exit_dec_byte

    	clr			R13							;reset key loop counter
    	mov			#key,		R6

exit_dec_byte
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
