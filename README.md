ECE382_Lab2
===========

Lab 2: Cryptography

C3C Jasper Arneberg  
T5 ECE 382
Capt Trimble  

##Prelab
###Concept

The truth table below demonstrates the following:  
```
(A xor B) xor B = A  
```

| A | B | C = A xor B | C xor B |
| :--: | :--: | :--: | :----: |
| 0 | 0 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 0 | 1 |
| 1 | 1 | 0 | 1 |

This shows how the key (B) is used to encrypt and then decrypt a message.

###Flowchart
A flowchart was developed for the basic functionality.
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





##Lab

###Objective
The purpose of this lab is to get familiar with subroutines. Both call-by-value and call-by-address subroutines must be used in decrypting a message using a key.

###Debugging

###Testing


####Basic Functionality: 
Decoding the basic functionality test gave the following message:  
```
Congratulations! You decrypted the ECE382 message and achieved required functionality#
```

####B Functionality: 
Decoding the B functionality test gave the following message:  
```
The message key length is 16 bits. It only contains letters, periods, and spaces.
```

####A Functionality: 
At first, the hint found in the B functionality was confusing. It was interpreted as 16 bytes instead of 16 bits. A key length of 16 bits means that it is 2 bytes long.  

To solve this problem, one assumption was tested: the last character is a period.  

This was tested by performing an xor on the last encoded character, 0x90, and the period ASCII code, 0x2E. The result for this was 0xBE.  

Next, the code was decrypted using a key of 0xFF,0xBE. This code was chosen because the last character was an even number. Here was the result:
```
.	a	.	t	.	.	.	e	.	t	.	.
.	v	.	r	.	g	.	.	.	F	.	i
.	n	.	l	.	.	.	G	.	o	.	.
.	G	.	o	.	.
```
This shows that the initial assumption was most likely correct. All of the decrypted values were characters or punctuation.

To solve for the first byte of the key, a second pivotal assumption was made: the characters before 'F' and the two instances of 'G' are spaces. This is supported by the fact that all of these characters are encoded with a value of 0x53.  

To find the first byte of the key, an xor was performed between the encoded character 0x53 and the ASCII code for a space, 0x20. This gave a result of 0x73.

Using a key of 0x73,0xBE, the following result was obtained:
```
F	a	s	t	.	.	N	e	a	t	.	.
A	v	e	r	a	g	e	.	.	F	r	i
e	n	d	l	y	.	.	G	o	o	d	.
.	G	o	o	d	.
```

The message is "Fast, Neat, Average, Friendly, Good, Good."

##Conclusion

##Documentation
None.
