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

To solve for the first byte of the key, a second pivotal assumption was made: the characters before 'F' and the two instances of 'G' are spaces. This is supported by the fact that all of these characters are originally encoded with a value of 0x53.  

To find the first byte of the key, an xor was performed between the encoded character 0x53 and the ASCII code for a space, 0x20. This gave a result of 0x73.

Using a key of 0x73,0xBE, the following result was obtained:
```
F	a	s	t	.	.	N	e	a	t	.	.
A	v	e	r	a	g	e	.	.	F	r	i
e	n	d	l	y	.	.	G	o	o	d	.
.	G	o	o	d	.
```

The message is "Fast, Neat, Average, Friendly, Good, Good."

###Debugging
During A functionality testing, the predicted first byte of the key was at first incorrect. This was because the key 0xFF,0xBE was used for the original decryption of the message. When this key was used, the values of the odd characters were changed, and then these changed values were accidentally carried over to the next part of testing. Instead, a code of 0x00,0xBE should have been used. This would have preserved the original values of the odd characters.

One error that was encountered was that the program did execute for the entire message. This was caused because the message_length parameter was not the appropriate length for the message. This was updated manually, and the program worked. To make this program better, it should be able to automatically calculate the message length and key length parameters. This potentially could be done by appending a special stop code to the end of the key and message.

##Conclusion
This lab taught how to effectively write subroutines so that they can be resused. It was a little challenging at first to learn the syntax and operation of the subroutines, but they saved a lot of time in the long run. The flowchart and general organization of the program was made much simpler.

This lab also gave some insight into real-world applications of cryptography. One of these applications is that it is often easier to crack a password by guessing what the password might contain. This recognizes the human factors that go into composing a password. It also demonstrates that it is important to create passwords that are not easily guessable. I just updated my password for my Google account because it contained seven lowercase characters. I now feel much more secure owning a password with uppercase, lower case, special characters, and numbers.

This lab was rewarding in that there was a secret message to find for each part. Overall, it was a fun and worthwhile endeavor.

##Documentation
None.
