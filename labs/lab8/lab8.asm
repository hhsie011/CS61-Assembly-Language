;=================================================
; Name: Hsiang-Yin Hsieh
; Email: hhsie011@ucr.edu
; 
; Lab: lab 8, ex 1 & 2
; Lab section: 22
; TA: Jang-Shin Enoch Lin
; 
;=================================================

; test harness
					.orig x3000
					LD	R6, SUB_PRINT_OPCODES_3200
					JSRR R6
					
					LD	R6, SUB_FIND_OPCODE_3600
					JSRR R6
				 
					halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
SUB_PRINT_OPCODES_3200	.FILL	x3200
SUB_FIND_OPCODE_3600 .FILL	x3600


;===============================================================================================


; subroutines:
;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODES
; Parameters: None
; Postcondition: The subroutine has printed out a list of every LC3 instruction
;		 		 and corresponding opcode in the following format:
;		 		 ADD = 0001
;		  		 AND = 0101
;		  		 BR = 0000
;		  		 …
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3200
;(1)backup affected registers:
					ST	R1, BACKUP_R1_3200
					ST	R2, BACKUP_R2_3200
					ST	R3, BACKUP_R3_3200
					ST	R4, BACKUP_R4_3200
					ST	R5, BACKUP_R5_3200
					ST	R6, BACKUP_R6_3200
					ST	R7, BACKUP_R7_3200
	
;(2)subroutine algorithm:
					LD	R1, instructions_po_ptr
					LDR	R0, R1, #0
					
					LD	R4, opcodes_po_ptr
					
					OUTER_LOOP
						NESTED_LOOP
							ADD	R0, R0, #0
							BRz END_NESTED_LOOP
							OUT
							ADD	R1, R1, #1
							LDR	R0, R1, #0
							BRnzp NESTED_LOOP
						END_NESTED_LOOP
						
						LD	R0, SPACE_CH
						OUT
						LD	R0, EQUAL_CH
						OUT
						LD	R0, SPACE_CH
						OUT
						
						LDR	R2, R4, #0
						
						LD	R6,	SUB_PRINT_OPCODE_3400
						JSRR R6
						
						LD	R0, NEWLINE_CH
						OUT
						
						ADD	R4, R4, #1
						ADD	R1, R1, #1
						LDR	R0, R1, #0
						BRn	END_OUTER_LOOP
						BRzp OUTER_LOOP
					END_OUTER_LOOP
	
;(3)restore backed up registers
					LD	R1, BACKUP_R1_3200
					LD	R2, BACKUP_R2_3200
					LD	R3, BACKUP_R3_3200
					LD	R4, BACKUP_R4_3200
					LD	R5, BACKUP_R5_3200
					LD	R6, BACKUP_R6_3200
					LD	R7, BACKUP_R7_3200

;(4)Return:						 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODES local data
opcodes_po_ptr		.fill x4000
instructions_po_ptr	.fill x4100

SUB_PRINT_OPCODE_3400	.FILL	x3400

BACKUP_R1_3200	.BLKW	#1
BACKUP_R2_3200	.BLKW	#1
BACKUP_R3_3200	.BLKW	#1
BACKUP_R4_3200	.BLKW	#1
BACKUP_R5_3200	.BLKW	#1
BACKUP_R6_3200	.BLKW	#1
BACKUP_R7_3200	.BLKW	#1

SPACE_CH	.FILL	x20
EQUAL_CH	.FILL	x3D	
NEWLINE_CH	.FILL	x0A
;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE
; Parameters: R2 containing a 4-bit op-code in the 4 LSBs of the register
; Postcondition: The subroutine has printed out just the 4 bits as 4 ascii 1s and 0s
;				 The output is NOT newline terminated.
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3400			 
;(1)backup affected registers:
					ST	R0, BACKUP_R0_3400
					ST	R1, BACKUP_R1_3400
					ST	R2, BACKUP_R2_3400
					ST	R3, BACKUP_R3_3400
					ST	R4, BACKUP_R4_3400
					ST	R5, BACKUP_R5_3400
					ST	R6, BACKUP_R6_3400
					ST	R7, BACKUP_R7_3400
	
;(2)subroutine algorithm:
					AND	R1, R1, #0
					ADD	R1, R1, #12
					
					LOOP_1
						ADD	R2, R2, R2
						ADD	R1, R1, #-1
						BRp	LOOP_1
					END_LOOP_1
					
					ADD	R1, R1, #4
					LD	R0, HEX_0
					ADD	R3, R0, #0
					NOT	R3, R3
					ADD	R3, R3, #1
					
					LOOP_2
						ADD	R2, R2, #0
						BRzp PRINT
						ADD R0, R0, #1
						
						PRINT
						OUT
						
						ADD	R4, R0, R3
						BRz STILL_ZERO
						ADD R0, R0, #-1
						
						STILL_ZERO
						ADD	R2, R2, R2
						ADD	R1, R1, #-1
						BRp LOOP_2
					END_LOOP_2
	
;(3)restore backed up registers
					LD 	R0, BACKUP_R0_3400
					LD	R1, BACKUP_R1_3400
					LD	R2, BACKUP_R2_3400
					LD	R3, BACKUP_R3_3400
					LD	R4, BACKUP_R4_3400
					LD	R5, BACKUP_R5_3400
					LD	R6, BACKUP_R6_3400
					LD	R7, BACKUP_R7_3400

;(4)Return:				 		 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE local data
					BACKUP_R0_3400	.BLKW	#1
					BACKUP_R1_3400	.BLKW	#1
					BACKUP_R2_3400	.BLKW	#1
					BACKUP_R3_3400	.BLKW	#1
					BACKUP_R4_3400	.BLKW	#1
					BACKUP_R5_3400	.BLKW	#1
					BACKUP_R6_3400	.BLKW	#1
					BACKUP_R7_3400	.BLKW	#1

					HEX_0			.FILL	x30
;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_FIND_OPCODE
; Parameters: None
; Postcondition: The subroutine has invoked the SUB_GET_STRING subroutine and stored a string
; 				as local data; it has searched the AL instruction list for that string, and reported
;				either the instruction/opcode pair, OR "Invalid instruction"
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3600
;(1)backup affected registers:
					ST	R0, BACKUP_R0_3600
					ST	R1, BACKUP_R1_3600
					ST	R2, BACKUP_R2_3600
					ST	R3, BACKUP_R3_3600
					ST	R4, BACKUP_R4_3600
					ST	R5, BACKUP_R5_3600
					ST	R6, BACKUP_R6_3600
					ST	R7, BACKUP_R7_3600
	
;(2)subroutine algorithm:
					LD	R2, STR_ADDR
					LD	R6, SUB_GET_STRING_3800
					JSRR R6
					
					LD	R1, instructions_fo_ptr
					LD	R2, STR_ADDR
					AND	R0, R0, #0
					
					FIND_LOOP
						ADD	R3, R1, #0
						LDR	R5, R2, #0
						LDR	R4, R3, #0
						CHECK_LOOP
							NOT	R4, R4
							ADD	R4, R4, #1
							ADD	R4, R4, R5
							BRnp NEXT_WORD
							ADD	R3, R3, #1
							ADD	R2, R2, #1
							LDR	R4, R3, #0
							LDR	R5, R2, #0
							BRnp CHECK_LOOP
							ADD	R4, R4, #0
							BRz PRINT_LINE
							BRnp NEXT_WORD
						END_CHECK_LOOP
						
						NEXT_WORD
						ADD	R0, R0, #1
						FIND_LOOP_2
							ADD R1, R1, #1
							LDR	R4, R1,	#0
							BRnp FIND_LOOP_2
						END_FIND_LOOP_2
						
						ADD	R1, R1, #1
						LDR	R4, R1, #0
						BRz	PRINT_INVALID
						LD	R2, STR_ADDR
						BRnzp FIND_LOOP
						
						PRINT_LINE
						ADD	R3, R0, #0
						LD	R2, STR_ADDR
						PRINT_LOOP
							LDR	R0, R2, #0
							BRz	END_PRINT_LOOP
							OUT
							ADD R2, R2, #1
							BRnzp PRINT_LOOP
						END_PRINT_LOOP
						LD	R1, opcodes_fo_ptr
						INCREMENT_LOOP
							ADD	R1, R1, #1
							ADD	R3, R3, #-1
							BRp INCREMENT_LOOP
						END_INCREMENT_LOOP
						LD	R0, SPACE_CHAR
						OUT
						LD	R0, EQUAL_CHAR
						OUT
						LD	R0, SPACE_CHAR
						OUT
						LDR	R2, R1, #0
						LD	R6, SUB_PRINT_OPCODE
						JSRR R6
						BRnzp END_FIND_LOOP
						
						PRINT_INVALID
						LEA	R0, INVALID_MSG
						PUTS
						BRnzp END_FIND_LOOP
					END_FIND_LOOP
					
					
;(3)restore backed up registers
					LD 	R0, BACKUP_R0_3600
					LD	R1, BACKUP_R1_3600
					LD	R2, BACKUP_R2_3600
					LD	R3, BACKUP_R3_3600
					LD	R4, BACKUP_R4_3600
					LD	R5, BACKUP_R5_3600
					LD	R6, BACKUP_R6_3600
					LD	R7, BACKUP_R7_3600

;(4)Return:
				 ret
;-----------------------------------------------------------------------------------------------
; SUB_FIND_OPCODE local data
opcodes_fo_ptr			.fill x4000
instructions_fo_ptr		.fill x4100

BACKUP_R0_3600	.BLKW	#1
BACKUP_R1_3600	.BLKW	#1
BACKUP_R2_3600	.BLKW	#1
BACKUP_R3_3600	.BLKW	#1
BACKUP_R4_3600	.BLKW	#1
BACKUP_R5_3600	.BLKW	#1
BACKUP_R6_3600	.BLKW	#1
BACKUP_R7_3600	.BLKW	#1

SUB_PRINT_OPCODE 	.FILL	x3400
SUB_GET_STRING_3800	.FILL	x3800
STR_ADDR			.FILL	x3750
INVALID_MSG			.STRINGZ	"Invalid instruction"

SPACE_CHAR		.FILL	x20
EQUAL_CHAR		.FILL	x3D	
NEWLINE_CHAR	.FILL	x0A

.ORIG x3750
USER_STRING		.BLKW	#100

;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameters: R2 - the address to which the null-terminated string will be stored.
; Postcondition: The subroutine has prompted the user to enter a short string, terminated 
; 				by [ENTER]. That string has been stored as a null-terminated character array 
; 				at the address in R2
; Return Value: None (the address in R2 does not need to be preserved)
;-----------------------------------------------------------------------------------------------
					.orig x3800
;(1)backup affected registers:
					ST	R0, BACKUP_R0_3800
					ST	R1, BACKUP_R1_3800
					ST	R2, BACKUP_R2_3800
					ST	R3, BACKUP_R3_3800
					ST	R4, BACKUP_R4_3800
					ST	R5, BACKUP_R5_3800
					ST	R6, BACKUP_R6_3800
					ST	R7, BACKUP_R7_3800
	
;(2)subroutine algorithm:
					LEA	R0, USER_PROMPT
					PUTS
					
					LD	R1, ENTER_KEY
					NOT	R1, R1
					ADD	R1, R1, #1
					
					INPUT_LOOP
						GETC
						OUT
						ADD	R3, R0, R1
						BRz	END_INPUT_LOOP
						
						STR	R0, R2, #0
						ADD	R2, R2, #1
						BRnzp INPUT_LOOP
					END_INPUT_LOOP
					
					AND	R0, R0, #0
					STR	R0, R2, #0
					
;(3)restore backed up registers
					LD 	R0, BACKUP_R0_3800
					LD	R1, BACKUP_R1_3800
					LD	R2, BACKUP_R2_3800
					LD	R3, BACKUP_R3_3800
					LD	R4, BACKUP_R4_3800
					LD	R5, BACKUP_R5_3800
					LD	R6, BACKUP_R6_3800
					LD	R7, BACKUP_R7_3800

;(4)Return:		 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_GET_STRING local data
					BACKUP_R0_3800	.BLKW	#1
					BACKUP_R1_3800	.BLKW	#1
					BACKUP_R2_3800	.BLKW	#1
					BACKUP_R3_3800	.BLKW	#1
					BACKUP_R4_3800	.BLKW	#1
					BACKUP_R5_3800	.BLKW	#1
					BACKUP_R6_3800	.BLKW	#1
					BACKUP_R7_3800	.BLKW	#1

					USER_PROMPT		.STRINGZ	"Enter a short string, terminate by [ENTER]: "
					ENTER_KEY		.FILL		x0A
;===============================================================================================


;-----------------------------------------------------------------------------------------------
; REMOTE DATA
					.ORIG x4000			; list opcodes as numbers, e.g. .fill #12 or .fill xC
opcodes
OP_ADD	.FILL	#1
OP_AND	.FILL	#5
OP_BR	.FILL	#0
OP_JMP	.FILL	#12
OP_JSR	.FILL	#4
OP_JSRR	.FILL	#4
OP_LD	.FILL	#2
OP_LDI	.FILL	#10
OP_LDR	.FILL	#6
OP_LEA	.FILL	#14
OP_NOT	.FILL	#9
OP_RET	.FILL	#12
OP_RTI	.FILL	#8
OP_ST	.FILL	#3
OP_STI	.FILL	#11
OP_STR	.FILL	#7
OP_TRAP	.FILL	#15

					.ORIG x4100			; list AL instructions as null-terminated character strings, e.g. .stringz "JMP"
instructions				 			; - be sure to follow same order in opcode & instruction arrays!
PRINT_ADD	.STRINGZ	"ADD"
PRINT_AND	.STRINGZ	"AND"
PRINT_BR	.STRINGZ	"BR"
PRINT_JMP	.STRINGZ	"JMP"
PRINT_JSR	.STRINGZ	"JSR"
PRINT_JSRR	.STRINGZ	"JSRR"
PRINT_LD	.STRINGZ	"LD"
PRINT_LDI	.STRINGZ	"LDI"
PRINT_LDR	.STRINGZ	"LDR"
PRINT_LEA	.STRINGZ	"LEA"
PRINT_NOT	.STRINGZ	"NOT"
PRINT_RET	.STRINGZ	"RET"
PRINT_RTI	.STRINGZ	"RTI"
PRINT_ST	.STRINGZ	"ST"
PRINT_STI	.STRINGZ	"STI"
PRINT_STR	.STRINGZ	"STR"
PRINT_TRAP	.STRINGZ	"TRAP"
TERMINATOR	.FILL	xFFFF
;===============================================================================================
.END
