;=================================================
; Name: Hsiang-Yin Hsieh
; Email: hhsie011@ucr.edu
; 
; Lab: lab 9, ex 3
; Lab section: 22
; TA: Jang-Shin Enoch Lin
; 
;=================================================

; test harness
					.orig x3000
				
					LD	R4, BASE
					LD	R5, MAX
					ADD	R6, R4, #0
					
					MAIN_LOOP
						LD	R1, HEX_0
						NOT	R1, R1
						ADD	R1, R1, #1
					
						LEA	R0, USER_PROMPT
						PUTS
						GETC
						OUT
						
						ADD	R0, R0, R1
						LD	R2, SUB_STACK_PUSH_3200
						JSRR R2
						
						LD	R0, NEWLINE
						OUT
						
						LEA	R0, USER_PROMPT	
						PUTS	
						GETC
						OUT
						
						ADD	R0, R0, R1
						LD	R2, SUB_STACK_PUSH_3200
						JSRR R2
						
						LD	R0, NEWLINE
						OUT
						
						LEA	R0, ASTERISK_PROMPT
						PUTS
						GETC
						OUT
						
						LD	R0, NEWLINE
						OUT
						
						LD	R2, SUB_RPN_MULTIPLY_3600
						JSRR R2
						
						LD	R2, SUB_STACK_POP_3400
						JSRR R2
						ADD	R1, R0, #0
						
						LD	R2, SUB_PRINT_DECIMAL_3800
						JSRR R2
						
						LD	R0, NEWLINE
						OUT
						
						ADD	R1, R0, #0
						NOT	R1, R1
						ADD	R1, R1, #1
						
						LEA	R0, END_PROMPT
						PUTS
						
						GETC
						OUT
						
						ADD	R1, R0, R1
						BRz MAIN_LOOP
					END_MAIN_LOOP
					
					LD	R0, NEWLINE
					OUT
				 
				 
					halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
HEX_0	.FILL	x30
BASE	.FILL	xA000
MAX		.FILL	xA005
NEWLINE	.FILL	x0A
USER_PROMPT		.STRINGZ	"Enter a single numeric digit character: "
ASTERISK_PROMPT	.STRINGZ	"Enter '*': "
END_PROMPT		.STRINGZ	"Press [Enter] to continue. Any other key to leave.\n"

SUB_STACK_PUSH_3200 	.FILL	x3200
SUB_STACK_POP_3400		.FILL	x3400
SUB_RPN_MULTIPLY_3600	.FILL	x3600
SUB_PRINT_DECIMAL_3800	.FILL	x3800
;===============================================================================================


; subroutines:

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1). 
;		    If the stack was already full (TOS = MAX), the subroutine has printed an
;		    overflow error message and terminated.
; Return Value: R6 ← updated TOS
;------------------------------------------------------------------------------------------
					.orig x3200
;(1)backup affected registers
					ST	R0, BACKUP_R0_3200
					ST	R1, BACKUP_R1_3200
					ST	R2, BACKUP_R2_3200
					ST	R3, BACKUP_R3_3200
					ST	R4, BACKUP_R4_3200
					ST	R5, BACKUP_R5_3200
					ST	R7, BACKUP_R7_3200

;(2)subroutine algorithm:
					NOT	R5, R5
					ADD	R5, R5, #1
					ADD	R5, R5, R6
					BRzp OVERFLOW
					
					ADD	R6, R6, #1
					STR	R0, R6, #0
					BRnzp FINISH
					
					OVERFLOW
					LEA	R0, ERROR_MSG_OVER
					PUTS
					
					FINISH

;(3)restore backed up registers:
					LD	R0, BACKUP_R0_3200
					LD	R1, BACKUP_R1_3200
					LD	R2, BACKUP_R2_3200
					LD	R3, BACKUP_R3_3200
					LD	R4, BACKUP_R4_3200
					LD	R5, BACKUP_R5_3200
					LD	R7, BACKUP_R7_3200
					 
;(4)return:					
					ret
;-----------------------------------------------------------------------------------------------
; SUB_STACK_PUSH local data
ERROR_MSG_OVER	.STRINGZ	"\nError: Overflow occurred"

BACKUP_R0_3200	.BLKW	#1
BACKUP_R1_3200	.BLKW	#1
BACKUP_R2_3200	.BLKW	#1
BACKUP_R3_3200	.BLKW	#1
BACKUP_R4_3200	.BLKW	#1
BACKUP_R5_3200	.BLKW	#1
BACKUP_R7_3200	.BLKW	#1


;===============================================================================================


;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available                      ;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[TOS] off of the stack.
;		    If the stack was already empty (TOS = BASE), the subroutine has printed
;                an underflow error message and terminated.
; Return Value: R0 ← value popped off the stack
;		   R6 ← updated TOS
;------------------------------------------------------------------------------------------
					.orig x3400
;(1)backup affected registers:
					ST	R1, BACKUP_R1_3400
					ST	R2, BACKUP_R2_3400
					ST	R3, BACKUP_R3_3400
					ST	R4, BACKUP_R4_3400
					ST	R5, BACKUP_R5_3400
					ST	R7, BACKUP_R7_3400
				 
;(2)subroutine algorithm:
					NOT	R4, R4
					ADD	R4, R4, #1
					ADD	R4, R4, R6
					BRz	UNDERFLOW
					
					LDR	R0, R6, #0
					ADD	R6, R6, #-1	
					BRnzp DONE
					
					UNDERFLOW
					LEA	R0, ERROR_MSG_UNDER
					PUTS
					
					DONE

;(3)restore backed up registers:
					LD	R1, BACKUP_R1_3400
					LD	R2, BACKUP_R2_3400
					LD	R3, BACKUP_R3_3400
					LD	R4, BACKUP_R4_3400
					LD	R5, BACKUP_R5_3400
					LD	R7, BACKUP_R7_3400
				 
;(4)return:				 				 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_STACK_POP local data
ERROR_MSG_UNDER	.STRINGZ	"Error: Underflow occurred\n"

BACKUP_R1_3400	.BLKW	#1
BACKUP_R2_3400	.BLKW	#1
BACKUP_R3_3400	.BLKW	#1
BACKUP_R4_3400	.BLKW	#1
BACKUP_R5_3400	.BLKW	#1
BACKUP_R7_3400	.BLKW	#1


;===============================================================================================

;------------------------------------------------------------------------------------------
; Subroutine: SUB_RPN_MULTIPLY
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped off the top two values of the stack,
;		    multiplied them together, and pushed the resulting value back
;		    onto the stack.
; Return Value: R6 ← updated TOS address
;------------------------------------------------------------------------------------------
					.orig x3600
;(1)backup affected registers:
					ST	R0, BACKUP_R0_3600
					ST	R1, BACKUP_R1_3600
					ST	R2, BACKUP_R2_3600
					ST	R3, BACKUP_R3_3600
					ST	R4, BACKUP_R4_3600
					ST	R5, BACKUP_R5_3600
					ST	R7, BACKUP_R7_3600
				 
;(2)subroutine algorithm:
					LD	R1, SUB_STACK_POP
					JSRR R1
					ADD	R3, R0, #0
					
					LD	R1, SUB_STACK_POP
					JSRR R1
					ADD	R2, R0, #0
					
					MULT_LOOP
						ADD	R3, R3, #-1
						BRz	END_MULT_LOOP
						ADD	R0, R0, R2
						BRnzp MULT_LOOP
					END_MULT_LOOP
					
					LD	R1,	SUB_STACK_PUSH
					JSRR R1
					
					
;(3)restore backed up registers:
					LD	R0, BACKUP_R0_3600
					LD	R1, BACKUP_R1_3600
					LD	R2, BACKUP_R2_3600
					LD	R3, BACKUP_R3_3600
					LD	R4, BACKUP_R4_3600
					LD	R5, BACKUP_R5_3600
					LD	R7, BACKUP_R7_3600
				 
;(4)return:		
					ret
;-----------------------------------------------------------------------------------------------
; SUB_RPN_MULTIPLY local data
BACKUP_R0_3600	.BLKW	#1
BACKUP_R1_3600	.BLKW	#1
BACKUP_R2_3600	.BLKW	#1
BACKUP_R3_3600	.BLKW	#1
BACKUP_R4_3600	.BLKW	#1
BACKUP_R5_3600	.BLKW	#1
BACKUP_R7_3600	.BLKW	#1

SUB_STACK_PUSH	.FILL	x3200
SUB_STACK_POP	.FILL	x3400

HEX_ZERO	.FILL	x30
;===============================================================================================



; SUB_MULTIPLY		

; SUB_GET_NUM		

; SUB_PRINT_DECIMAL		Only needs to be able to print 1 or 2 digit numbers. 
;						You can use your lab 7 s/r.
;------------------------------------------------------------------------------------------
;Subroutine: SUB_PRINT_DECIMAL
;Parameter (R1): value to be printed to console
;Postcondition: value stored in R1 has been printed to console
;Return value (N/A): no return value
;------------------------------------------------------------------------------------------
.ORIG x3800
;subroutine instructions:

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
	AND	R2, R2, #0
	ADD	R2, R2, #-10
	ADD	R2, R1, R2
	BRn SINGLE_DIGIT
	
	AND	R2, R2, #0
	ADD	R2, R2, #-10
	AND	R3, R3, #0
	ADD	R3, R3, #-10
	AND R5, R5, #0
	ADD	R5, R5, #1
	
	TEN_LOOP
		ADD	R5, R5, #1
		ADD	R2, R2, R3
		ADD	R4, R1, R2
		BRnz PRINT_TEN
		BRp TEN_LOOP
	END_TEN_LOOP
	
	PRINT_TEN
	ADD	R4, R4, #0
	BRz PRINT
	
	ADD	R5, R5, #-1
	ADD	R2, R2, #10
	
	PRINT
	LD	R3, HEX_Z
	ADD	R0, R3, R5
	OUT
	
	ADD	R1, R1, R2
	
	SINGLE_DIGIT
	LD	R3, HEX_Z
	ADD	R0, R1, R3
	OUT
	
;(3)restore backed up registers
	LD	R0, BACKUP_R0_3800
	LD	R1, BACKUP_R1_3800
	LD	R2, BACKUP_R2_3800
	LD	R3, BACKUP_R3_3800
	LD	R4, BACKUP_R4_3800
	LD	R5, BACKUP_R5_3800
	LD	R6, BACKUP_R6_3800
	LD	R7, BACKUP_R7_3800

;(4)Return:
	ret
	
;Local data for subroutine LOAD_VALUE_3200
BACKUP_R0_3800	.BLKW	#1
BACKUP_R1_3800	.BLKW	#1
BACKUP_R2_3800	.BLKW	#1
BACKUP_R3_3800	.BLKW	#1
BACKUP_R4_3800	.BLKW	#1
BACKUP_R5_3800	.BLKW	#1
BACKUP_R6_3800	.BLKW	#1
BACKUP_R7_3800	.BLKW	#1

HEX_Z			.FILL	x30
