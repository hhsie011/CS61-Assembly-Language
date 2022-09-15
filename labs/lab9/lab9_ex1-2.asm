;=================================================
; Name: Hsiang-Yin Hsieh
; Email: hhsie011@ucr.edu
; 
; Lab: lab 9, ex 1 & 2
; Lab section: 22
; TA: Jang-Shin Enoch Lin
; 
;=================================================

; test harness
					.orig x3000
					
					LD	R1, HEX_3
					NOT	R1, R1
					ADD	R1, R1, #1
					LD	R4, BASE
					LD	R5, MAX
					ADD	R6, R4, #0
					
					DO_WHILE_LOOP
						LEA R0, MENUSTRING
						PUTS
						GETC
						OUT
						ADD	R3, R0, #0
						LD	R0, NEWLINE
						OUT
						
						ADD	R0, R3, #0
						ADD	R2, R0, R1
						BRz END_DO_WHILE_LOOP
						ADD	R2, R2, #1
						BRz	CALL_POP
						
						GETC
						OUT
						LD R3, SUB_STACK_PUSH_3200
						JSRR R3
						BRnzp PRINT_NEWLINE
						
						CALL_POP
						LD	R3, SUB_STACK_POP_3400
						JSRR R3
						OUT
						BRnzp PRINT_NEWLINE
						
						PRINT_NEWLINE
						LD	R0, NEWLINE
						OUT
						BRnzp DO_WHILE_LOOP
					END_DO_WHILE_LOOP
				 
				 
					halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
MENUSTRING	.STRINGZ	"Enter 1 for push, 2 for pop, or 3 to quit: "
HEX_3	.FILL	x33
BASE	.FILL	xA000
MAX		.FILL	xA005
NEWLINE	.FILL	x0A

SUB_STACK_PUSH_3200 .FILL	x3200
SUB_STACK_POP_3400	.FILL	x3400
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

