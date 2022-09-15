;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Hsiang-Yin Hsieh
; Email: hhsie011@ucr.edu
; 
; Assignment name: Assignment 3
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
LD R6, Value_addr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
LD R4, HEX_0
AND	R2, R2, #0
ADD	R2, R2, #4
AND	R5, R5, #0

DO_WHILE_LOOP
	ADD	R5, R5, #4
	NESTED_LOOP
		ADD	R0, R4, #0
		ADD	R3, R1, #0
		BRzp PRINT_ZERO
		
		ADD	R0, R0, #1
		
	PRINT_ZERO
		OUT
		ADD	R1, R1, R1
		ADD	R5, R5, #-1
		BRp	NESTED_LOOP
	END_NESTED_LOOP
	
	ADD	R2, R2, #-2
	BRn NO_SPACE
	
	LD	R0, SPACE_CH
	OUT
	
	NO_SPACE
	ADD	R2, R2, #1
	BRp	DO_WHILE_LOOP
END_DO_WHILE_LOOP

LD	R0, NEWLINE_CH
OUT
;--------------------------------


HALT
;---------------	
;Data
;---------------
Value_addr	.FILL xB800	; The address where value to be displayed is stored
HEX_0	.FILL	x30
SPACE_CH	.FILL	x20
NEWLINE_CH	.FILL	x0A

.ORIG xB800					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
