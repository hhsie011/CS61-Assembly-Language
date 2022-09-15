;=================================================
; Name: Hsiang-Yin Hsieh
; Email: hhsie011@ucr.edu
; 
; Lab: lab 5, ex 3
; Lab section: 22
; TA: Jang-Shin Lin
; 
;=================================================
.ORIG x3000
;---------------
;Instructions
;---------------
	LD	R6, SUB_READ_BINARY_3200
	JSRR R6
	
	LD	R6, SUB_PRINT_BINARY_3400
	JSRR R6
	
	HALT
;---------------
;Local data
	SUB_READ_BINARY_3200	.FILL	x3200
	SUB_PRINT_BINARY_3400	.FILL	x3400
;---------------
;=======================================================================
;subroutine: SUB_READ_BINARY_3200
;Input (N/A): no input
;Postcondition:	the user has entered 17 ascii characters and the 16 1's 
;				and 0's have been stored in R2 as a 16-bit value
;Return (R2): the 16-bit value stored in R2
;=======================================================================
.ORIG x3200
;subroutine instructions:

;(1)backup affected registers:
	ST	R1, BACKUP_R1_3200
	ST	R3, BACKUP_R3_3200
	ST	R4, BACKUP_R4_3200
	ST	R7, BACKUP_R7_3200
	
;(2)subroutine algorithm:
	LD	R1, DEC_16
	AND	R2, R2, #0
	LD	R3, HEX_B
	NOT	R3, R3
	ADD	R3, R3, #1
	
	CHECK_B_LOOP
		GETC
		OUT
		ADD	R4, R0, R3
		BRz	END_CHECK_B_LOOP
		LEA	R0, ERROR_MESSAGE_B
		PUTS
		ADD	R0, R0, R0
		BRnzp CHECK_B_LOOP
	END_CHECK_B_LOOP
	
	
	LD	R3, HEX_0
	NOT	R3, R3
	ADD	R3, R3, #1
	
	DO_WHILE_LOOP
		GETC
		OUT
		ADD	R4,	R0, R3
		BRz IS_ZERO_OR_ONE
		
		ADD	R4, R4, #-1
		BRnp CHECK_SPACE
		ADD	R4,	R4, #1
		
		IS_ZERO_OR_ONE
		ADD	R2, R2, R2
		ADD	R4, R0, R3
		BRz	DECREMENT
		
		ADD	R2, R2, #1
		
		DECREMENT
		ADD	R1, R1, #-1
		BRp	DO_WHILE_LOOP
		BRz	END_DO_WHILE_LOOP
		
		CHECK_SPACE
		LD	R3, SPACE_CHAR
		NOT	R3, R3
		ADD	R3, R3, #1
		ADD	R4, R0, R3
		BRz	RELOAD
		
		LEA	R0, ERROR_MESSAGE
		PUTS
		BRnzp RELOAD
		
		RELOAD
		LD	R3, HEX_0
		NOT	R3, R3
		ADD	R3, R3, #1
		BRnzp DO_WHILE_LOOP
		
	END_DO_WHILE_LOOP

;(3)restore backed up registers:
	LD	R1, BACKUP_R1_3200
	LD	R3, BACKUP_R3_3200
	LD	R4, BACKUP_R4_3200
	LD	R7, BACKUP_R7_3200
	
;(4)return:
	ret

;Local data for SUB_READ_BINARY_3200
	BACKUP_R1_3200	.BLKW	#1
	BACKUP_R3_3200	.BLKW	#1
	BACKUP_R4_3200	.BLKW	#1
	BACKUP_R7_3200	.BLKW	#1

	DEC_16	.FILL	#16
	HEX_B	.FILL	x62
	HEX_0	.FILL	x30
	SPACE_CHAR	.FILL	x20
	ERROR_MESSAGE_B	.STRINGZ	"\nPlease enter 'b'.\n"
	ERROR_MESSAGE	.STRINGZ	"\nError: invalid input\n"
;=======================================================================
;subroutine: SUB_PRINT_BINARY_3400
;Input (R2): the address that contains the value whose signed bianry 
;			 value will be printed
;Postcondition: the subroutined has printed the binary representation 
;				of the value stored in R2
;Return value (N/A): no return value
;=======================================================================
.ORIG x3400	
;subroutine instructions:

;(1)backup affected registers:
	ST	R2, BACKUP_R2_3400
	ST	R3, BACKUP_R3_3400
	ST	R4, BACKUP_R4_3400
	ST	R5, BACKUP_R5_3400
	ST	R7, BACKUP_R7_3400
	
;(2)subroutine algorithm:
	LD	R0, NEWLINE_CH
	OUT

	LD R4, HEXA_0
	AND	R3, R3, #0
	ADD	R3, R3, #4
	AND	R5, R5, #0

	DO_WHILE_LOOP_2
		ADD	R5, R5, #4
		NESTED_LOOP
			ADD	R0, R4, #0
			ADD	R2, R2, #0
			BRzp PRINT_ZERO
			
			ADD	R0, R0, #1
			
		PRINT_ZERO
			OUT
			ADD	R2, R2, R2
			ADD	R5, R5, #-1
			BRp	NESTED_LOOP
		END_NESTED_LOOP
		
		ADD	R3, R3, #-2
		BRn NO_SPACE
		
		LD	R0, SPACE_CH
		OUT
		
		NO_SPACE
		ADD	R3, R3, #1
		BRp	DO_WHILE_LOOP_2
	END_DO_WHILE_LOOP_2

	LD	R0, NEWLINE_CH
	OUT
	
;(3)restore backed up registers
	LD	R2, BACKUP_R2_3400
	LD	R3, BACKUP_R3_3400
	LD	R4, BACKUP_R4_3400
	LD	R5, BACKUP_R5_3400
	LD	R7, BACKUP_R7_3400

;(4)Return:
	ret
	
;Local data for subroutine PRINT_BINARY_3400
BACKUP_R2_3400	.BLKW	#1
BACKUP_R3_3400	.BLKW	#1
BACKUP_R4_3400	.BLKW	#1
BACKUP_R5_3400	.BLKW	#1
BACKUP_R7_3400	.BLKW	#1

HEXA_0	.FILL	x30
SPACE_CH	.FILL	x20
NEWLINE_CH	.FILL	x0A


.END
