;=================================================
; Name: Hsiang-Yin Hsieh
; Email: hhsie011
; 
; Lab: lab 6, ex 1
; Lab section: 22
; TA: Jang-Shin Enoch Lin
; 
;=================================================
.ORIG x3000
;---------------
;Instructions
;---------------
	LD	R6,	SUB_LOAD_VALUE_3200
	JSRR R6
	ADD	R1, R1, #1
	
	LD	R6, SUB_PRINT_VALUE_3400
	JSRR	R6
	
	LD	R0, NEWLINE_CHAR
	OUT
	
	HALT
;---------------
;Local data
;---------------
NEWLINE_CHAR	.FILL	x0A
SUB_LOAD_VALUE_3200		.FILL	x3200
SUB_PRINT_VALUE_3400	.FILL	x3400
;=======================================================================
;subroutine: SUB_LOAD_VALUE_3200
;Input (N/A): no input
;Postcondition: R1 has been loaded with a hard-coded value
;Return value (R1): a hard-coded value
;=======================================================================
.ORIG x3200
;subroutine instructions:

;(1)backup affected registers:
;	ST	R1, BACKUP_R1_3200
	ST	R2, BACKUP_R2_3200
	ST	R3, BACKUP_R3_3200
	ST	R4, BACKUP_R4_3200
	ST	R5, BACKUP_R5_3200
	ST	R6, BACKUP_R6_3200
	ST	R7, BACKUP_R7_3200
	
;(2)subroutine algorithm:
	LD	R1,	HARD_CODED_VAL
	
;(3)restore backed up registers
;	LD	R1, BACKUP_R1_3200
	LD	R2, BACKUP_R2_3200
	LD	R3, BACKUP_R3_3200
	LD	R4, BACKUP_R4_3200
	LD	R5, BACKUP_R5_3200
	LD	R6, BACKUP_R6_3200
	LD	R7, BACKUP_R7_3200

;(4)Return:
	ret
	
;Local data for subroutine LOAD_VALUE_3200
;BACKUP_R1_3200	.BLKW	#1
BACKUP_R2_3200	.BLKW	#1
BACKUP_R3_3200	.BLKW	#1
BACKUP_R4_3200	.BLKW	#1
BACKUP_R5_3200	.BLKW	#1
BACKUP_R6_3200	.BLKW	#1
BACKUP_R7_3200	.BLKW	#1

HARD_CODED_VAL	.FILL	#32767
NEWLINE_CH		.FILL	x0A
;=======================================================================
;subroutine: SUB_PRINT_VALUE_3400
;Input (R1): value to be printed to console
;Postcondition: value stored in R1 has been printed to console
;Return value (N/A): no return value
;=======================================================================
.ORIG x3400
;subroutine instructions:

;(1)backup affected registers:
	ST	R1, BACKUP_R1_3400
	ST	R2, BACKUP_R2_3400
	ST	R3, BACKUP_R3_3400
	ST	R4, BACKUP_R4_3400
	ST	R5, BACKUP_R5_3400
	ST	R6, BACKUP_R6_3400
	ST	R7, BACKUP_R7_3400
	
;(2)subroutine algorithm:
	AND	R2, R2, #0
	ADD	R2, R2, #-1
	AND	R3, R3, #0
	ADD	R3, R3, #-1
	AND	R4, R4, #0
	ADD	R4, R4, #9
	AND	R6, R6, #0
	LD	R6, LAST_DIGIT
	
	ADD	R1,	R1, #0
	BRzp DO_WHILE_LOOP
	LD	R0, NEG_SIGN
	OUT
	NOT	R1, R1
	ADD	R1, R1, #1
	
	DO_WHILE_LOOP
		INNER_LOOP
			ADD	R5, R1,	R2
			BRp	CONTINUE
			BRz REFACTOR
			ADD	R4, R4, #1
			NOT	R3, R3
			ADD	R3, R3, #1
			ADD R2, R2, R3
			
			REFACTOR
			ADD	R4, R4, #-10
			NOT	R4, R4
			ADD	R4, R4, #1
			BRnzp PRINT
			
			CONTINUE
			ADD	R2, R3, R2
			ADD	R4, R4, #-1
			BRp	INNER_LOOP
			
			ADD	R4, R4, #9
			ADD	R3, R2, #0
			ADD	R6, R6, #1
			BRnzp INNER_LOOP
		END_INNER_LOOP
		
		PRINT
		LD	R5, LAST_DIGIT
		NOT	R5, R5
		ADD	R5, R5, #1
		ADD	R5, R5, R6
		ADD	R5, R5, #1
		BRzp	OUTPUT_DIGIT
		LD	R0, HEX_0
		OUT
		
		OUTPUT_DIGIT
		ADD	R0, R4, #0
		LD	R5, HEX_0
		ADD	R0, R0, R5
		OUT
		
		ADD	R5, R1, R2
		BRz CHECK_VAL
		
		ADD	R1, R1, R2
		AND	R2, R2, #0
		ADD	R2, R2, #-1
		AND	R3, R3, #0
		ADD	R3, R3, #-1
		AND	R4, R4, #0
		ADD	R4, R4, #9
		ST	R6, LAST_DIGIT
		AND	R6, R6, #0
		BRnzp DO_WHILE_LOOP
		
		CHECK_VAL
		ADD	R5, R1, #-10
		BRn END_DO_WHILE_LOOP
		
		LD	R0, HEX_0
		ZERO_LOOP
			OUT
			ADD	R6, R6, #-1
			BRp	ZERO_LOOP
		END_ZERO_LOOP
	END_DO_WHILE_LOOP
	
;(3)restore backed up registers
	LD	R1, BACKUP_R1_3400
	LD	R2, BACKUP_R2_3400
	LD	R3, BACKUP_R3_3400
	LD	R4, BACKUP_R4_3400
	LD	R5, BACKUP_R5_3400
	LD	R6, BACKUP_R6_3400
	LD	R7, BACKUP_R7_3400

;(4)Return:
	ret
	
;Local data for subroutine LOAD_VALUE_3200
BACKUP_R1_3400	.BLKW	#1
BACKUP_R2_3400	.BLKW	#1
BACKUP_R3_3400	.BLKW	#1
BACKUP_R4_3400	.BLKW	#1
BACKUP_R5_3400	.BLKW	#1
BACKUP_R6_3400	.BLKW	#1
BACKUP_R7_3400	.BLKW	#1

NEG_SIGN		.FILL	x2D
HEX_0			.FILL	x30
LAST_DIGIT		.BLKW	#1

.END
