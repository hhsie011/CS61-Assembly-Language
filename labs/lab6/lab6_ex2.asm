;=================================================
; Name: Hsiang-Yin Hsieh
; Email: hhsie011@ucr.edu
; 
; Lab: lab 6, ex 2
; Lab section: 22
; TA: Jang-Shin Enoch Lin
; 
;=================================================
.ORIG x3000
;----------------
;Instructions
;----------------
	LD	R1,	ARR_PTR
	LD	R6, SUB_GET_STRING
	JSRR	R6
	LD	R0, ARR_PTR
	PUTS
	LD	R0, NEWLINE_CHAR
	OUT
	LD	R6, SUB_IS_A_PALINDROME
	JSRR	R6
	
	LD	R0, ARR_PTR
	PUTS
	LD	R0, SPACE_CHAR
	OUT
	
	ADD	R4, R4, #0
	BRp	PRINT_ONE
	BRz	PRINT_ZERO
	
	PRINT_ONE
	LEA	R0, IS_A_PALINDROME
	PUTS
	BRnzp SKIP
	
	PRINT_ZERO
	LEA	R0, IS_NOT_A_PALINDROME
	PUTS
	
	SKIP
	HALT
;----------------
;Local data
;----------------
NEWLINE_CHAR		.FILL	x0A
SPACE_CHAR			.FILL	x20
ARR_PTR				.FILL	x3400
SUB_GET_STRING		.FILL	x3200	
SUB_IS_A_PALINDROME	.FILL	x3600
IS_A_PALINDROME		.STRINGZ	"IS a palindrome\n"
IS_NOT_A_PALINDROME	.STRINGZ	"IS NOT a palindrome\n"
;------------------------------------------------------------------------------------
;Subroutine: SUB_GET_STRING
;Parameter(R1): The starting address of the character array
;Postcondition: The subroutine has prompted the user to input a string,
;				terminated by the [ENTER] key (the "sentinel"), and has stored
;				the received characters in ana array of characters starting at (R1).
;				the array is NULL-terminated; the sentinel character is NOT stored.
;Return Value(R5): The number of non-sentinel characters read from the user.
;				   R1 contains the starting address of the array unchanged.
;------------------------------------------------------------------------------------
.ORIG x3200
;subroutine instructions:

;(1)backup affected registers:
	ST	R1,	BACKUP_R1_3200
	ST	R2,	BACKUP_R2_3200
	ST	R3,	BACKUP_R3_3200
	ST	R4,	BACKUP_R4_3200
;	ST	R5,	BACKUP_R5_3200
	ST	R6,	BACKUP_R6_3200
	ST	R7,	BACKUP_R7_3200
	
;(2)subroutine algorithm:
	LEA	R0, USER_PROMPT
	PUTS
	
	LD	R2, NEWLINE_CH
	NOT	R2, R2
	ADD	R2, R2, #1
	
	AND	R5, R5, #0
	
	ADD	R4, R1, #0
	
	DO_WHILE_LOOP
		GETC
		OUT
		ADD	R3, R0, R2
		BRz	END_DO_WHILE_LOOP
		STR	R0, R4, #0
		ADD	R4, R4, #1
		ADD	R5, R5, #1
		BRp	DO_WHILE_LOOP
	END_DO_WHILE_LOOP
	
	ADD	R4,	R4, #1
	AND	R2, R2, #0
	STR	R2, R4, #0
	
;(3)restore backed up registers:
	LD	R1, BACKUP_R1_3200
	LD	R2, BACKUP_R2_3200
	LD	R3, BACKUP_R3_3200
	LD	R4, BACKUP_R4_3200
;	LD	R5, BACKUP_R5_3200
	LD	R6, BACKUP_R6_3200
	LD	R7, BACKUP_R7_3200

;(4)Return:
	ret
	
;Local data for subroutine SUB_GET_STRING
BACKUP_R1_3200	.BLKW	#1
BACKUP_R2_3200	.BLKW	#1
BACKUP_R3_3200	.BLKW	#1
BACKUP_R4_3200	.BLKW	#1
;BACKUP_R5_3200	.BLKW	#1
BACKUP_R6_3200	.BLKW	#1
BACKUP_R7_3200	.BLKW	#1

USER_PROMPT		.STRINGZ	"Enter a string, followed by ENTER\n"
NEWLINE_CH		.FILL		x0A
;-----------------
;Remote data
;-----------------
.ORIG x3400
ARRAY	.BLKW	#100
;------------------------------------------------------------------------------------
;Subroutine: SUB_IS_A_PALINDROME
;Parameter(R1): The starting address of a null-terminated string
;Parameter(R5): The number of characters in the array.
;Postcondition: The subroutine has determined whether the string at (R1) is
;				a palindrome or not, and returned a flag to that effect.
;Return Value(R4): R4{1 is if the string is a palindrome, 0 otherwise}
;------------------------------------------------------------------------------------
.ORIG x3600
;subroutine instructions:
	
;(1)backup affected registers:
	ST	R1,	BACKUP_R1_3600
	ST	R2,	BACKUP_R2_3600
	ST	R3,	BACKUP_R3_3600
;	ST	R4,	BACKUP_R4_3600
	ST	R5,	BACKUP_R5_3600
	ST	R6,	BACKUP_R6_3600
	ST	R7,	BACKUP_R7_3600
	
;(2)subroutine algorithm:
	AND	R4, R4, #0
	ADD	R7,	R1, #0
	ADD	R7,	R7, R5
	ADD	R7, R7, #-1
	
	CHECK_PALINDROME_LOOP
		LDR	R2, R1, #0
		LDR	R6, R7, #0
		NOT	R6, R6
		ADD	R6, R6, #1
		ADD	R6,	R2, R6
		BRnp END_CHECK_PALINDROME_LOOP
		
		ADD	R6, R1, #0
		NOT	R6, R6
		ADD	R6, R6, #1
		ADD	R6, R7, R6
		BRz	SET_R4_TO_1
		
		ADD	R6, R6, #-1
		BRz SET_R4_TO_1
		
		ADD	R1, R1, #1
		ADD	R7, R7, #-1
		BRnzp CHECK_PALINDROME_LOOP
		
		SET_R4_TO_1
		ADD	R4, R4, #1
	END_CHECK_PALINDROME_LOOP
	
;(3)restore backed up registers:
	LD	R1, BACKUP_R1_3600
	LD	R2, BACKUP_R2_3600
	LD	R3, BACKUP_R3_3600
;	LD	R4, BACKUP_R4_3600
	LD	R5, BACKUP_R5_3600
	LD	R6, BACKUP_R6_3600
	LD	R7, BACKUP_R7_3600
	
;(4)Return:
	ret
	
;Local data for subroutine SUB_IS_A_PALINDROME
BACKUP_R1_3600	.BLKW	#1
BACKUP_R2_3600	.BLKW	#1
BACKUP_R3_3600	.BLKW	#1
;BACKUP_R4_3600	.BLKW	#1
BACKUP_R5_3600	.BLKW	#1
BACKUP_R6_3600	.BLKW	#1
BACKUP_R7_3600	.BLKW	#1
	
.END
