;=================================================
; Name: Hsiang-Yin Hsieh
; Email: hhsie011@ucr.edu
; 
; Lab: lab 6, ex 1
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
	
	HALT
;----------------
;Local data
;----------------
ARR_PTR			.FILL	x3400
SUB_GET_STRING	.FILL	x3200	
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


.END
