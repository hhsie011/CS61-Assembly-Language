;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Hsiang-Yin Hsieh
; Email: hhsie011@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 22
; TA: Jang-Shin Enoch Lin
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R2
;=================================================================================

					.ORIG x3000		
;-------------
;Instructions
;-------------
				OUTER_LOOP
; output intro prompt
					LD	R0, introPromptPtr
					PUTS
; Set up flags, counters, accumulators as needed
					AND	R1, R1, #0
					ADD	R1, R1, #5
					
					AND	R2, R2, #0
					
					LD	R3, NEWLINE_CH
					NOT	R3, R3
					ADD	R3, R3, #1
					
					AND	R4, R4, #0
					ADD	R4, R4, #1
; Get first character, test for '\n', '+', '-', digit/non-digit 	
					GETC
					OUT
					; is very first character = '\n'? if so, just quit (no message)!
					ADD	R3, R3, R0
					BRz	LAST_POINT
					; is it = '+'? if so, ignore it, go get digits
					LD	R3, PLUS_SIGN
					NOT	R3, R3
					ADD	R3, R3, #1
					ADD	R3, R3, R0
					BRz	DO_WHILE_LOOP
					; is it = '-'? if so, set neg flag, go get digits
					LD	R3, MINUS_SIGN
					NOT	R3, R3
					ADD	R3, R3, #1
					ADD	R3, R3, R0
					BRnp CHECK_DIGIT
					
					ADD	R4, R4, #-1
					BRz	DO_WHILE_LOOP
					
					CHECK_DIGIT	
					; is it < '0'? if so, it is not a digit	- o/p error message, start over
					LD	R3, HEX_0
					NOT	R3, R3
					ADD	R3, R3, #1
					ADD	R3, R3, R0
					BRn	ERROR_MESSAGE
					; is it > '9'? if so, it is not a digit	- o/p error message, start over
					LD	R3, HEX_0
					ADD	R3, R3, #9
					NOT	R3, R3
					ADD	R3, R3, #1
					ADD	R3, R3, R0
					BRnz STORE_DIGIT
					
					ERROR_MESSAGE
					LD	R0, NEWLINE_CH
					OUT
					LD	R0, errorMessagePtr
					PUTS
					ADD	R3, R3, #1
					BRp	OUTER_LOOP
					; if none of the above, first character is first numeric digit - convert it to number & store in target register!
					STORE_DIGIT
					LD	R3, HEX_0
					NOT	R3, R3
					ADD	R3, R3, #1
					ADD	R2, R3, R0
; Now get remaining digits (max 5) from user, testing each to see if it is a digit, and build up number in accumulator
					DO_WHILE_LOOP
						GETC
						OUT
						
						LD	R3, NEWLINE_CH
						NOT	R3, R3
						ADD	R3, R3, #1
						ADD	R3, R3, R0
						BRz LAST_POINT
						
						LD	R3, HEX_0
						NOT	R3, R3
						ADD	R3, R3, #1
						ADD	R3, R3, R0
						BRn	ERROR_MSG
						
						LD	R3, HEX_0
						ADD	R3, R3, #9
						NOT	R3, R3
						ADD	R3, R3, #1
						ADD	R3, R3, R0
						BRnz STR_DIGIT
						
						ERROR_MSG
						LD	R0, NEWLINE_CH
						OUT
						LD	R0, errorMessagePtr
						PUTS
						ADD	R3, R3, #0
						BRnzp OUTER_LOOP
						
						STR_DIGIT
						LD	R3, HEX_0
						NOT	R3, R3
						ADD	R3, R3, #1
						ADD	R0, R3, R0
						
						AND	R5,	R5, #0
						ADD	R5, R5, #9
						
						ADD	R6, R2, #0
						
						INNER_LOOP
							ADD	R2, R6, R2
							ADD	R5, R5, #-1
							BRp	INNER_LOOP
						END_INNER_LOOP
						
						ADD	R2, R2, R0
						
						ADD	R1, R1, #-1
						BRp	DO_WHILE_LOOP
					END_DO_WHILE_LOOP
				END_OUTER_LOOP
					; remember to end with a newline!
					LD	R0, NEWLINE_CH
					OUT
					LAST_POINT
					
					ADD	R4, R4, #0
					BRp NOT_NEG
					
					NOT	R2, R2
					ADD	R2, R2, #1
					
					NOT_NEG
					HALT

;---------------	
; Program Data
;---------------

introPromptPtr		.FILL xA100
errorMessagePtr		.FILL xA200
NEWLINE_CH			.FILL x0A
PLUS_SIGN			.FILL x2B
MINUS_SIGN			.FILL x2D
HEX_0				.FILL x30
;------------
; Remote data
;------------
					.ORIG xA100			; intro prompt
					.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
					
					
					.ORIG xA200			; error message
					.STRINGZ	"ERROR: invalid input\n"

;---------------
; END of PROGRAM
;---------------
					.END


;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
