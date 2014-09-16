ECE382_Lab2
===========

Lab 2: Cryptography

C3C Jasper Arneberg  
T5 ECE 382
Capt Trimble  

#Prelab
###Flowchart
A basic flowchart was developed for the basic functionality.
![alt text](https://github.com/JasperArneberg/ECE382_Lab2/blob/master/prelab2_flowchart.jpg?raw=true "Prelab Flowchart")

###Pseudocode and Interfaces
Pseudocode was developed for the prelab. Additionally, the inputs and outputs for each subroutine were explicitly listed.
```
initialize:
	;load key and memory addresses
	call		decrypt_message

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

decrpyt_message:
    	;load next byte, store in R8
    	call 		decrypt_byte
    	;store result in R8 to RAM
    ret

;---------------------------------------------------
;Subroutine Name: decrpyt_byte
;Author: C2C Jasper Arneberg, USAF
;Function: Decrpyts single byte
;Inputs: message byte in R8, key value in R6
;Outputs: result in R8
;Registers destroyed: R8
;---------------------------------------------------

decrpyt_byte:
    	;xor R8 message byte and R6 key
    ret
```





#Lab

##Objective
The purpose of this lab is to get familiar with subroutines. Both call-by-value and call-by-address subroutines must be used in decrypting a message using a key.

##Debugging

##Testing


####Basic Functionality: 

####B Functionality: 

####A Functionality: 

#Conclusion

#Documentation
None.
