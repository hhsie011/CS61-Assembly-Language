;=================================================
; Name: Hsiang-Yin Hsieh 
; Email: hhsie011@ucr.edu
; 
; Lab: lab 5, ex 1
; Lab section: 22
; TA: Jang-Shin Enoch Lin
; 
;=================================================
.ORIG x3000
;------------------
;Instructions
;------------------
	LD	R1, ARRAY_1_PTR
	AND	R2, R2, #0
	ADD	R2, R2, #10
	AND	R3, R3, #0
	ADD	R3, R3, #1
	
	DO_WHILE_LOOP
		STR	R3, R1, #0
		ADD	R3, R3, R3
		ADD	R1, R1, #1
		ADD	R2, R2, #-1
		BRp	DO_WHILE_LOOP
	END_DO_WHILE_LOOP
	
	ADD	R1, R1, #-4
	LDR	R2, R1, #0
	
	ADD	R1, R1, #-6
	AND	R2, R2, #0
	ADD	R2, R2, #10
	
;	OUTPUT_LOOP
;		LDR	R0, R1, #0 
;		OUT
;		ADD	R1, R1, #1
;		ADD	R2, R2, #-1
;		BRp OUTPUT_LOOP
;	END_OUTPUT_LOOP
	
	PRINT_LOOP
		LDR	R3, R1, #0
		LD	R6, SUB_PRINT_BINARY_3200
		JSRR R6
		ADD	R1, R1, #1
		ADD	R2, R2, #-1
		BRp	PRINT_LOOP
	END_PRINT_LOOP
	
	HALT
;------------------
;Local data
;------------------
	ARRAY_1_PTR	.FILL	x4000
	SUB_PRINT_BINARY_3200	.FILL	x3200
;------------------
;=======================================================================
;subroutine: SUB_PRINT_BINARY_3200
;Input (R3): the address that contains the value whose signed bianry 
;			 value will be printed
;Postcondition: the subroutined has printed the binary representation 
;				of the original value in R1
;Return value (N/A): no return value
;=======================================================================
.ORIG x3200
;subroutine instructions:

;(1)backup affected registers:
	ST	R2, BACKUP_R2_3200
	ST	R4, BACKUP_R4_3200
	ST	R5, BACKUP_R5_3200
	ST	R7, BACKUP_R7_3200
	
;(2)subroutine algorithm:
	LD R4, HEX_0
	AND	R2, R2, #0
	ADD	R2, R2, #4
	AND	R5, R5, #0

	DO_WHILE_LOOP_2
		ADD	R5, R5, #4
		NESTED_LOOP
			ADD	R0, R4, #0
			ADD	R3, R3, #0
			BRzp PRINT_ZERO
			
			ADD	R0, R0, #1
			
		PRINT_ZERO
			OUT
			ADD	R3, R3, R3
			ADD	R5, R5, #-1
			BRp	NESTED_LOOP
		END_NESTED_LOOP
		
		ADD	R2, R2, #-2
		BRn NO_SPACE
		
		LD	R0, SPACE_CH
		OUT
		
		NO_SPACE
		ADD	R2, R2, #1
		BRp	DO_WHILE_LOOP_2
	END_DO_WHILE_LOOP_2

	LD	R0, NEWLINE_CH
	OUT
	
;(3)restore backed up registers
	LD	R2, BACKUP_R2_3200
	LD	R4, BACKUP_R4_3200
	LD	R5, BACKUP_R5_3200
	LD	R7, BACKUP_R7_3200

;(4)Return:
	ret
	
;Local data for subroutine PRINT_BINARY_3200
BACKUP_R2_3200	.BLKW	#1
BACKUP_R4_3200	.BLKW	#1
BACKUP_R5_3200	.BLKW	#1
BACKUP_R7_3200	.BLKW	#1

HEX_0	.FILL	x30
SPACE_CH	.FILL	x20
NEWLINE_CH	.FILL	x0A
;------------------
;Remote data
;------------------
.ORIG x4000
	ARRAY_1	.BLKW	#10

.END
