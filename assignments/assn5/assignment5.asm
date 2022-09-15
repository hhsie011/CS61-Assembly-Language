;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Hsiang-Yin Hsieh
; Email: hhsie011@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: 22
; TA: Jang-Shin Enoch Lin
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
DO_WHILE_LOOP
	LD	R6, SUB_MENU_3200
	JSRR R6

	AND	R3, R3, #0
	ADD	R3, R3, #-1

	ADD	R4, R1, R3
	BRz	INVOKE_SUB_1
	
	ADD	R3, R3, #-1
	ADD	R4, R1, R3
	BRz INVOKE_SUB_2
	
	ADD	R3, R3, #-1
	ADD	R4, R1, R3
	BRz	INVOKE_SUB_3
	
	ADD	R3, R3, #-1
	ADD	R4, R1, R3
	BRz	INVOKE_SUB_4
	
	ADD	R3, R3, #-1
	ADD	R4, R1, R3
	BRz	INVOKE_SUB_5
	
	ADD	R3, R3, #-1
	ADD	R4, R1, R3
	BRz	INVOKE_SUB_6
	
	ADD	R3, R3, #-1
	ADD	R4, R1, R3
	BRz	END_DO_WHILE_LOOP

	INVOKE_SUB_1
	LD	R6, SUB_ALL_MACHINES_BUSY_3400
	JSRR R6
	
	ADD	R2, R2, #-1
	BRz	PRINT_ALL_BUSY
	
	LEA	R0, allnotbusy
	PUTS
	BRnzp REPEAT
	
	PRINT_ALL_BUSY
	LEA	R0, allbusy
	PUTS
	BRnzp REPEAT
	
	INVOKE_SUB_2
	LD	R6, SUB_ALL_MACHINES_FREE_3600
	JSRR R6
	
	ADD	R2, R2, #-1
	BRz	PRINT_ALL_FREE
	
	LEA	R0, allnotfree
	PUTS
	BRnzp REPEAT
	
	PRINT_ALL_FREE
	LEA	R0, allfree
	PUTS
	BRnzp REPEAT
	
	INVOKE_SUB_3
	LD	R6, SUB_NUM_BUSY_MACHINES_3800
	JSRR R6
	LEA	R0, busymachine1
	PUTS
	ADD	R1, R2, #0
	LD	R6, SUB_PRINT_NUM_4800
	JSRR R6
	LEA	R0, busymachine2
	PUTS
	BRnzp REPEAT
	
	INVOKE_SUB_4
	LD	R6, SUB_NUM_FREE_MACHINES_4000
	JSRR R6
	LEA	R0, freemachine1
	PUTS
	ADD	R1, R2, #0
	LD	R6, SUB_PRINT_NUM_4800
	JSRR R6
	LEA	R0, freemachine2
	PUTS
	BRnzp REPEAT
	
	INVOKE_SUB_5
	LD	R6, SUB_GET_MACHINE_NUM_4600
	JSRR R6
	LEA	R0, status1
	PUTS
	LD	R6, SUB_PRINT_NUM_4800
	JSRR R6
	LD	R6, SUB_MACHINE_STATUS_4200
	JSRR R6
	ADD	R2, R2, #0
	BRz PRINT_BUSY
	LEA	R0, status3
	PUTS
	BRnzp REPEAT
	PRINT_BUSY
	LEA	R0, status2
	PUTS
	BRnzp REPEAT
	
	INVOKE_SUB_6
	LD	R6, SUB_FIRST_FREE_4400
	JSRR R6
	ADD	R2, R2, #0
	BRzp PRINT_NUM
	LEA	R0, firstfree2
	PUTS
	BRnzp REPEAT
	PRINT_NUM
	ADD	R1, R2, #0
	LEA	R0, firstfree1
	PUTS
	LD	R6, SUB_PRINT_NUM_4800
	JSRR R6
	LD	R0, newline
	OUT
	
	REPEAT
	BRnzp DO_WHILE_LOOP
END_DO_WHILE_LOOP

LEA	R0, goodbye
PUTS

HALT
;---------------	
;Data
;---------------
;Subroutine pointers
SUB_MENU_3200	.FILL	x3200
SUB_ALL_MACHINES_BUSY_3400	.FILL	x3400
SUB_ALL_MACHINES_FREE_3600	.FILL	x3600
SUB_NUM_BUSY_MACHINES_3800	.FILL	x3800
SUB_NUM_FREE_MACHINES_4000	.FILL	x4000
SUB_MACHINE_STATUS_4200	.FILL	x4200
SUB_FIRST_FREE_4400	.FILL	x4400
SUB_GET_MACHINE_NUM_4600	.FILL	x4600
SUB_PRINT_NUM_4800	.FILL	x4800

;Other data 
newline 		.fill '\n'

; Strings for reports from menu subroutines:
goodbye         .stringz "Goodbye!\n"
allbusy         .stringz "All machines are busy\n"
allnotbusy      .stringz "Not all machines are busy\n"
allfree         .stringz "All machines are free\n"
allnotfree		.stringz "Not all machines are free\n"
busymachine1    .stringz "There are "
busymachine2    .stringz " busy machines\n"
freemachine1    .stringz "There are "
freemachine2    .stringz " free machines\n"
status1         .stringz "Machine "
status2		    .stringz " is busy\n"
status3		    .stringz " is free\n"
firstfree1      .stringz "The first available machine is number "
firstfree2      .stringz "No machines are free\n"


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, invited the
;                user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7 (as a number, not a character)
;                    no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
.ORIG x3200

;(1)backup affected registers:
ST	R0, BACKUP_R0_3200
ST	R2, BACKUP_R2_3200
ST	R3, BACKUP_R3_3200
ST	R4, BACKUP_R4_3200
ST	R5, BACKUP_R5_3200
ST	R6, BACKUP_R6_3200
ST	R7, BACKUP_R7_3200

;(2)subroutine algorithm:
LD	R2, Menu_string_addr
LDR	R0, R2, #0

LD	R3, HEX_0
ADD	R3, R3, #1
ADD	R4, R3, #6
NOT	R3, R3
ADD	R3, R3, #1
NOT	R4, R4
ADD	R4, R4, #1

MENU_LOOP
	OUTPUT_LOOP
		OUT
		ADD	R2, R2, #1
		LDR	R0, R2, #0
		BRp	OUTPUT_LOOP
	END_OUTPUT_LOOP
	
	GETC
	OUT
	ADD	R5, R0, #0
	LD	R0, NEWLINE_CH
	OUT
	ADD	R0, R5, #0
	
	ADD	R5, R0, R3
	BRn PRINT_INVALID
	ADD	R5, R0, R4
	BRp	PRINT_INVALID
	BRnz END_MENU_LOOP
	
	PRINT_INVALID
	LEA	R0, Error_msg_1
	PUTS
	LD	R2, Menu_string_addr
	LDR	R0, R2, #0
	BRnzp MENU_LOOP
END_MENU_LOOP

ADD	R1, R0, #0
ADD	R3, R3, #1
ADD	R1, R1, R3

;(3)restore backed up registers:
LD R0, BACKUP_R0_3200
LD R2, BACKUP_R2_3200
LD R3, BACKUP_R3_3200
LD R4, BACKUP_R4_3200
LD R5, BACKUP_R5_3200
LD R6, BACKUP_R6_3200
LD R7, BACKUP_R7_3200

;(4)return:
ret
;--------------------------------
;HINT back up 

;HINT Restore

;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_msg_1	      .STRINGZ "INVALID INPUT\n"
Menu_string_addr  .FILL x6A00

BACKUP_R0_3200	.BLKW	#1
BACKUP_R2_3200	.BLKW	#1
BACKUP_R3_3200	.BLKW	#1
BACKUP_R4_3200	.BLKW	#1
BACKUP_R5_3200	.BLKW	#1
BACKUP_R6_3200	.BLKW	#1
BACKUP_R7_3200	.BLKW	#1

HEX_0	.FILL	x30
NEWLINE_CH	.FILL	x0A
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY (#1)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3400
;-------------------------------
;(1)backup affected registers:
ST R1, BACKUP_R1_3400
ST R3, BACKUP_R3_3400
ST R4, BACKUP_R4_3400
ST R5, BACKUP_R5_3400
ST R6, BACKUP_R6_3400
ST R7, BACKUP_R7_3400

;(2)subroutine algorithm:
AND	R2, R2, #0
LDI	R1, BUSYNESS_ADDR_ALL_MACHINES_BUSY
ADD	R1, R1, #0
BRnp DO_NOTHING
ADD	R2, R2, #1
DO_NOTHING

;(3)restore backed up registers:
LD R1, BACKUP_R1_3400
LD R3, BACKUP_R3_3400
LD R4, BACKUP_R4_3400
LD R5, BACKUP_R5_3400
LD R6, BACKUP_R6_3400
LD R7, BACKUP_R7_3400

;(4)return:
ret
;--------------------------------
;HINT back up 

;HINT Restore

;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xBA00

BACKUP_R1_3400	.BLKW	#1
BACKUP_R3_3400	.BLKW	#1
BACKUP_R4_3400	.BLKW	#1
BACKUP_R5_3400	.BLKW	#1
BACKUP_R6_3400	.BLKW	#1
BACKUP_R7_3400	.BLKW	#1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE (#2)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3600
;-------------------------------
;(1)backup affected registers:
ST R1, BACKUP_R1_3600
ST R3, BACKUP_R3_3600
ST R4, BACKUP_R4_3600
ST R5, BACKUP_R5_3600
ST R6, BACKUP_R6_3600
ST R7, BACKUP_R7_3600

;(2)subroutine algorithm:
LDI	R1,BUSYNESS_ADDR_ALL_MACHINES_FREE
AND	R2, R2, #0
AND	R3, R3, #0
ADD	R3, R3, #15

ADD	R1, R1, #0
BRzp END_ALL_FREE_LOOP

ALL_FREE_LOOP
	ADD	R1, R1, R1
	BRzp END_ALL_FREE_LOOP
	
	ADD	R3, R3, #-1
	BRp	ALL_FREE_LOOP
	BRz	SET_R2_TO_1
	
	SET_R2_TO_1
	ADD	R2, R2, #1
	BRnzp END_ALL_FREE_LOOP
END_ALL_FREE_LOOP

;(3)restore backed up registers:
LD R1, BACKUP_R1_3600
LD R3, BACKUP_R3_3600
LD R4, BACKUP_R4_3600
LD R5, BACKUP_R5_3600
LD R6, BACKUP_R6_3600
LD R7, BACKUP_R7_3600

;(4)return:
ret
;--------------------------------
;HINT back up 

;HINT Restore

;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xBA00

BACKUP_R1_3600	.BLKW	#1
BACKUP_R3_3600	.BLKW	#1
BACKUP_R4_3600	.BLKW	#1
BACKUP_R5_3600	.BLKW	#1
BACKUP_R6_3600	.BLKW	#1
BACKUP_R7_3600	.BLKW	#1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES (#3)
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy (0)
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3800
;-------------------------------
;(1)backup affected registers:
ST R1, BACKUP_R1_3800
ST R3, BACKUP_R3_3800
ST R4, BACKUP_R4_3800
ST R5, BACKUP_R5_3800
ST R6, BACKUP_R6_3800
ST R7, BACKUP_R7_3800

;(2)subroutine algorithm:
LDI	R1, BUSYNESS_ADDR_NUM_BUSY_MACHINES
AND	R2, R2, #0
AND	R3, R3, #0
ADD	R3, R3, #15

ADD	R1, R1, #0
BRn NUM_BUSY_LOOP
ADD	R2, R2, #1

NUM_BUSY_LOOP
	ADD	R1, R1, R1
	BRn R2_CONSTANT
	
	ADD	R2, R2, #1
	
	R2_CONSTANT
	ADD	R3, R3, #-1
	BRp NUM_BUSY_LOOP
END_NUM_BUSY_LOOP

;(3)restore backed up registers:
LD R1, BACKUP_R1_3800
LD R3, BACKUP_R3_3800
LD R4, BACKUP_R4_3800
LD R5, BACKUP_R5_3800
LD R6, BACKUP_R6_3800
LD R7, BACKUP_R7_3800

;(4)return:
ret
;--------------------------------
;HINT back up 

;HINT Restore

;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xBA00

BACKUP_R1_3800	.BLKW	#1
BACKUP_R3_3800	.BLKW	#1
BACKUP_R4_3800	.BLKW	#1
BACKUP_R5_3800	.BLKW	#1
BACKUP_R6_3800	.BLKW	#1
BACKUP_R7_3800	.BLKW	#1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES (#4)
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free (1)
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4000
;-------------------------------
;(1)backup affected registers:
ST R1, BACKUP_R1_4000
ST R3, BACKUP_R3_4000
ST R4, BACKUP_R4_4000
ST R5, BACKUP_R5_4000
ST R6, BACKUP_R6_4000
ST R7, BACKUP_R7_4000

;(2)subroutine algorithm:
LDI	R1, BUSYNESS_ADDR_NUM_FREE_MACHINES
AND	R2, R2, #0
AND	R3, R3, #0
ADD	R3, R3, #15

ADD	R1, R1, #0
BRzp NUM_FREE_LOOP
ADD	R2, R2, #1

NUM_FREE_LOOP
	ADD	R1, R1, R1
	BRzp R2_NO_CHANGE
	
	ADD	R2, R2, #1
	
	R2_NO_CHANGE
	ADD	R3, R3, #-1
	BRp NUM_FREE_LOOP
END_NUM_FREE_LOOP

;(3)restore backed up registers:
LD R1, BACKUP_R1_4000
LD R3, BACKUP_R3_4000
LD R4, BACKUP_R4_4000
LD R5, BACKUP_R5_4000
LD R6, BACKUP_R6_4000
LD R7, BACKUP_R7_4000

;(4)return:
ret
;--------------------------------
;HINT back up 

;HINT Restore

;--------------------------------
;Data for subroutine NUM_FREE_MACHINES 
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xBA00

BACKUP_R1_4000	.BLKW	#1
BACKUP_R3_4000	.BLKW	#1
BACKUP_R4_4000	.BLKW	#1
BACKUP_R5_4000	.BLKW	#1
BACKUP_R6_4000	.BLKW	#1
BACKUP_R7_4000	.BLKW	#1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS (#5)
; Input (R1): Which machine to check, guaranteed in range {0,15}
; Postcondition: The subroutine has returned a value indicating whether
;                the selected machine (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;              (R1) unchanged
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4200
;-------------------------------
;(1)backup affected registers:
ST R1, BACKUP_R1_4200
ST R3, BACKUP_R3_4200
ST R4, BACKUP_R4_4200
ST R5, BACKUP_R5_4200
ST R6, BACKUP_R6_4200
ST R7, BACKUP_R7_4200

;(2)subroutine algorithm:
AND R3, R3, #0
ADD	R3, R3, #1
ADD	R1, R1, #0
BRz LOGICAL_AND

LOCATE_LOOP
	ADD	R3, R3, R3
	ADD	R1, R1, #-1
	BRp LOCATE_LOOP
END_LOCATE_LOOP

LOGICAL_AND
LDI	R4, BUSYNESS_ADDR_MACHINE_STATUS
AND	R2, R2, #0
AND	R3, R3, R4
ADD R3, R3, #0
BRz	RETURN_BUSY

ADD	R2, R2, #1

RETURN_BUSY

;(3)restore backed up registers:
LD R1, BACKUP_R1_4200
LD R3, BACKUP_R3_4200
LD R4, BACKUP_R4_4200
LD R5, BACKUP_R5_4200
LD R6, BACKUP_R6_4200
LD R7, BACKUP_R7_4200

;(4)return:
ret

;--------------------------------
;HINT back up 

;HINT Restore

;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS.Fill xBA00

BACKUP_R1_4200	.BLKW	#1
BACKUP_R3_4200	.BLKW	#1
BACKUP_R4_4200	.BLKW	#1
BACKUP_R5_4200	.BLKW	#1
BACKUP_R6_4200	.BLKW	#1
BACKUP_R7_4200	.BLKW	#1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE (#6)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4400
;-------------------------------
;(1)backup affected registers:
ST R1, BACKUP_R1_4400
ST R3, BACKUP_R3_4400
ST R4, BACKUP_R4_4400
ST R5, BACKUP_R5_4400
ST R6, BACKUP_R6_4400
ST R7, BACKUP_R7_4400

;(2)subroutine algorithm:
AND	R1, R1, #0
ADD	R1, R1, #1
ADD	R3, R1, #0
NOT	R3, R3
ADD	R3, R3, #1
LDI	R4, BUSYNESS_ADDR_FIRST_FREE
LD	R6, MAX_MASK
NOT	R6, R6
ADD	R6, R6, #1

FIRST_FREE_LOOP
	AND	R5, R1, R4
	ADD	R5, R3, R5
	BRz	END_FIRST_FREE_LOOP
	
	ADD	R5, R1, R6
	BRz NO_FREE
	
	ADD	R1, R1, R1
	ADD	R3, R1, #0
	NOT	R3, R3
	ADD	R3, R3, #1
	BRnzp FIRST_FREE_LOOP
END_FIRST_FREE_LOOP

AND	R2, R2, #0
ADD	R2, R2, #15

DETERMINE_NUM_LOOP
	ADD	R1, R1, #0
	BRn	DONE
	ADD	R1, R1, R1
	ADD	R2, R2, #-1
	BRnzp DETERMINE_NUM_LOOP
END_DETERMINE_NUM_LOOP

NO_FREE
AND	R2, R2, #0
ADD	R2, R2, #-1

DONE

;(3)restore backed up registers:
LD R1, BACKUP_R1_4400
LD R3, BACKUP_R3_4400
LD R4, BACKUP_R4_4400
LD R5, BACKUP_R5_4400
LD R6, BACKUP_R6_4400
LD R7, BACKUP_R7_4400

;(4)return:
ret

;--------------------------------
;HINT back up 

;HINT Restore

;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
BUSYNESS_ADDR_FIRST_FREE .Fill xBA00

BACKUP_R1_4400	.BLKW	#1
BACKUP_R3_4400	.BLKW	#1
BACKUP_R4_4400	.BLKW	#1
BACKUP_R5_4400	.BLKW	#1
BACKUP_R6_4400	.BLKW	#1
BACKUP_R7_4400	.BLKW	#1

MAX_MASK	.FILL	x8000
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: GET_MACHINE_NUM
; Inputs: None
; Postcondition: The number entered by the user at the keyboard has been converted into binary,
;                and stored in R1. The number has been validated to be in the range {0,15}
; Return Value (R1): The binary equivalent of the numeric keyboard entry
; NOTE: You can use your code from assignment 4 for this subroutine, changing the prompt, 
;       and with the addition of validation to restrict acceptable values to the range {0,15}
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4600
;-------------------------------
;(1)backup affected registers:
ST R0, BACKUP_R0_4600
ST R2, BACKUP_R2_4600
ST R3, BACKUP_R3_4600
ST R4, BACKUP_R4_4600
ST R5, BACKUP_R5_4600
ST R6, BACKUP_R6_4600
ST R7, BACKUP_R7_4600

;(2)subroutine algorithm:
AND	R1, R1, #0
LD	R2, GET_MACHINE_NUM_HEX_0
NOT R2, R2
ADD R2, R2, #1
LD	R3, GET_MACHINE_NUM_NEWLINE
NOT	R3, R3
ADD	R3, R3, #1

PROMPT_LOOP
	LEA	R0, prompt
	PUTS
	
	LD	R2, GET_MACHINE_NUM_HEX_0
	NOT R2, R2
	ADD R2, R2, #1
	
	GETC
	OUT
		
	ADD	R4, R0, R2
	BRn ERROR_INPUT
	
	ADD	R2, R2, #-9
	ADD	R4, R0, R2
	BRp ERROR_INPUT
	
	ADD	R2, R2, #9
	ADD	R1, R0, R2
	
	GET_NUM_LOOP
		GETC
		OUT
		
		ADD	R4, R0, R3
		BRz CHECK
		
		ADD	R4, R0, R2
		BRn ERROR_INPUT
		
		ADD	R2, R2, #-9
		ADD	R4, R0, R2
		BRp ERROR_INPUT
		
		ADD	R2, R2, #9
		ADD	R5, R1, #0
		AND	R6, R6, #0
		ADD R6, R6, #9
		
		UPDATE_LOOP
			ADD	R1, R1, R5
			ADD	R6, R6, #-1
			BRp UPDATE_LOOP
		END_UPDATE_LOOP
		ADD	R4, R0, R2
		ADD	R1, R1, R4
		BRnzp GET_NUM_LOOP
	END_GET_NUM_LOOP
	
	CHECK
	ADD	R1, R1, #0
	BRn	ERROR_INPUT
	ADD	R2, R1, #0
	ADD	R2, R2, #-15
	BRp ERROR_INPUT
	BRnz END_PROMPT_LOOP
	
	ERROR_INPUT
	LD R0, GET_MACHINE_NUM_NEWLINE
	OUT
	AND	R1, R1, #0
	LEA	R0, Error_msg_2
	PUTS
	BRnzp PROMPT_LOOP
END_PROMPT_LOOP

;(3)restore backed up registers:
LD R0, BACKUP_R0_4600
LD R2, BACKUP_R2_4600
LD R3, BACKUP_R3_4600
LD R4, BACKUP_R4_4600
LD R5, BACKUP_R5_4600
LD R6, BACKUP_R6_4600
LD R7, BACKUP_R7_4600

;(4)return:
ret
 
;--------------------------------

;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_msg_2 .STRINGZ "ERROR INVALID INPUT\n"

BACKUP_R0_4600	.BLKW	#1
BACKUP_R2_4600	.BLKW	#1
BACKUP_R3_4600	.BLKW	#1
BACKUP_R4_4600	.BLKW	#1
BACKUP_R5_4600	.BLKW	#1
BACKUP_R6_4600	.BLKW	#1
BACKUP_R7_4600	.BLKW	#1

GET_MACHINE_NUM_HEX_0	.FILL	x30
GET_MACHINE_NUM_NEWLINE	.FILL	x0A
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: PRINT_NUM
; Inputs: R1, which is guaranteed to be in range {0,15}
; Postcondition: The subroutine has output the number in R1 as a decimal ascii string, 
; WITHOUT leading 0's, a leading sign, or a trailing newline.
;      Note: that number is guaranteed to be in the range {#0, #15}, 
;            i.e. either a single digit, or '1' followed by a single digit.
; Return Value: None; the value in R1 is unchanged
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4800
;-------------------------------
;(1)backup affected registers:
ST R0, BACKUP_R0_4800
ST R1, BACKUP_R1_4800
ST R2, BACKUP_R2_4800
ST R3, BACKUP_R3_4800
ST R4, BACKUP_R4_4800
ST R5, BACKUP_R5_4800
ST R6, BACKUP_R6_4800
ST R7, BACKUP_R7_4800

;(2)subroutine algorithm:
AND	R2, R2, #0
ADD	R2, R2, #-10
LD	R3, PRINT_NUM_HEX_0

ADD	R4, R1, R2
BRn	SINGLE_DIGIT
ADD	R0, R3, #1
OUT
ADD	R3,	R2, R3

SINGLE_DIGIT
ADD	R0, R1, R3
OUT

;(3)restore backed up registers:
LD R0, BACKUP_R0_4800
LD R1, BACKUP_R1_4800
LD R2, BACKUP_R2_4800
LD R3, BACKUP_R3_4800
LD R4, BACKUP_R4_4800
LD R5, BACKUP_R5_4800
LD R6, BACKUP_R6_4800
LD R7, BACKUP_R7_4800

;(4)return:
ret

;--------------------------------

;--------------------------------
;Data for subroutine print number
;--------------------------------
BACKUP_R0_4800	.BLKW	#1
BACKUP_R1_4800	.BLKW	#1
BACKUP_R2_4800	.BLKW	#1
BACKUP_R3_4800	.BLKW	#1
BACKUP_R4_4800	.BLKW	#1
BACKUP_R5_4800	.BLKW	#1
BACKUP_R6_4800	.BLKW	#1
BACKUP_R7_4800	.BLKW	#1

PRINT_NUM_HEX_0	.FILL	x30


.ORIG x6A00
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xBA00			; Remote data
BUSYNESS .FILL x0000		; <----!!!BUSYNESS VECTOR!!! Change this value to test your program.

;---------------	
;END of PROGRAM
;---------------	
.END
