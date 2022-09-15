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
;---------------
;Instructions
;---------------
	LEA	R0, USER_MESSAGE
	PUTS
	
	GETC
	OUT
	ADD	R1, R0, #0
	LD	R0, NEWLINE_CH
	OUT
	
	LEA	R0, OUTPUT_MESSAGE_1
	PUTS
	ADD	R0, R1, #0
	OUT
	LEA	R0, OUTPUT_MESSAGE_2
	PUTS 
	
	LD	R6, SUB_PARITY_CHECK
	JSRR R6
	
	ADD	R0, R2, #0
	LD	R3, HEX_0
	ADD	R0, R0, R3
	OUT
	
	LD	R0, NEWLINE_CH
	OUT
	
	HALT
;---------------
;Local data
;---------------	
USER_MESSAGE		.STRINGZ	"Enter a single character:\n"
OUTPUT_MESSAGE_1	.STRINGZ	"The number of 1's in '"
OUTPUT_MESSAGE_2	.STRINGZ	"' is: "	
SUB_PARITY_CHECK	.FILL	x3200
HEX_0				.FILL	x30
NEWLINE_CH			.FILL	x0A
;=======================================================================
;subroutine: SUB_PARITY_CHECK_3200
;Input (R1): a single character stored in R1
;Postcondition: the number of 1's in the binary representation of the 
;				input character has been counted
;Return value (R2): number of 1's in the binary representation of the 
;					character stored in R1
;=======================================================================
.ORIG x3200
;subroutine instructions:

;(1)backup affected registers:
;	ST	R1, BACKUP_R1_3200
;	ST	R2, BACKUP_R2_3200
	ST	R3, BACKUP_R3_3200
	ST	R4, BACKUP_R4_3200
	ST	R5, BACKUP_R5_3200
	ST	R6, BACKUP_R6_3200
	ST	R7, BACKUP_R7_3200
	
;(2)subroutine algorithm:
	AND	R2, R2, #0
	AND	R3, R3, #0
	ADD	R3, R3, #15
	ADD	R3, R3, #1
	
	DO_WHILE_LOOP
		ADD	R1, R1, #0
		BRzp DOUBLE_INPUT
		ADD	R2, R2, #1
		
		DOUBLE_INPUT
		ADD	R1, R1, R1
		
		ADD	R3, R3, #-1
		BRp	DO_WHILE_LOOP
	END_DO_WHILE_LOOP
	
;(3)restore backed up registers
;	LD	R1, BACKUP_R1_3200
;	LD	R2, BACKUP_R2_3200
	LD	R3, BACKUP_R3_3200
	LD	R4, BACKUP_R4_3200
	LD	R5, BACKUP_R5_3200
	LD	R6, BACKUP_R6_3200
	LD	R7, BACKUP_R7_3200

;(4)Return:
	ret
	
;Local data for subroutine PARITY_CHECK_3200
;BACKUP_R1_3200	.BLKW	#1
;BACKUP_R2_3200	.BLKW	#1
BACKUP_R3_3200	.BLKW	#1
BACKUP_R4_3200	.BLKW	#1
BACKUP_R5_3200	.BLKW	#1
BACKUP_R6_3200	.BLKW	#1
BACKUP_R7_3200	.BLKW	#1

.END
