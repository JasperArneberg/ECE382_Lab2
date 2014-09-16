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
message:	.byte		0xf8,0xb7,0x46,0x8c,0xb2,0x46,0xdf,0xac,0x42,0xcb,0xba,0x03,0xc7,0xba,0x5a,0x8c,0xb3,0x46,0xc2,0xb8,0x57,0xc4,0xff,0x4a,0xdf,0xff,0x12,0x9a,0xff,0x41,0xc5,0xab,0x50,0x82,0xff,0x03,0xe5,0xab,0x03,0xc3,0xb1,0x4f,0xd5,0xff,0x40,0xc3,0xb1,0x57,0xcd,0xb6,0x4d,0xdf,0xff,0x4f,0xc9,0xab,0x57,0xc9,0xad,0x50,0x80,0xff,0x53,0xc9,0xad,0x4a,0xc3,0xbb,0x50,0x80,0xff,0x42,0xc2,0xbb,0x03,0xdf,0xaf,0x42,0xcf,0xba,0x50,0x8f
key:		.byte		0xac,0xdf,0x23

message_length:		.equ		100
key_length:			.equ		3

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
