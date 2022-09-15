;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Hsiang-Yin Hsieh
; Email: hhsie011@ucr.edu
; 
; Assignment name: Assignment 2
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

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
GETC
ADD	R1, R0, #0
OUT
LD	R0, newline
OUT

GETC
ADD	R2, R0, #0
OUT
LD	R0, newline
OUT

ADD	R0,	R1, #0
OUT
LD	R0, space
OUT
LD	R0, minus
OUT
LD	R0, space
OUT
ADD	R0, R2, #0
OUT
LD	R0, space
OUT
LD	R0, equal
OUT
LD	R0, space
OUT

LD	R3, zero
NOT	R3, R3
ADD	R3, R3, #1

ADD	R1, R1, #1
ADD	R2, R2, #1

NOT	R2, R2
ADD	R2, R2, #1

ADD	R4, R1, R2
BRzp NOT_NEGATIVE
NOT	R4, R4
ADD	R4, R4, #1
LD	R0, minus
OUT

NOT_NEGATIVE
LD	R3, zero
ADD	R4, R4, R3

ADD	R0, R4, #0
OUT
LD 	R0, newline
OUT
;--------------------------------





HALT				; Stop execution of program
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline .FILL '\n'	; newline character - use with LD followed by OUT

zero	.FILL	x30
space	.FILL	x20
minus	.FILL	x2D
equal	.FILL 	x3D

;---------------	
;END of PROGRAM
;---------------	
.END

