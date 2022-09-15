;=================================================
; Name: Hsiang-Yin Hsieh
; Email: hhsie011@ucr.edu
; 
; Lab: lab 3, ex 1
; Lab section: 22
; TA: Jang-Shin Enoch Lin
; 
;=================================================
.ORIG x3000
;-------------
;Instructions
;-------------
	LD	R5, DATA_PTR
	ADD	R6, R5, #1
	
	LDR	R3, R5, #0
	LDR	R4, R6, #0
	
	ADD	R3, R3, #1
	ADD	R4, R4, #1
	
	STR	R3, R5, #0
	STR	R4, R6, #0
	
	HALT
;-------------
;Local data
;-------------
	DATA_PTR	.FILL	x4000

;;Remote data
.ORIG x4000
	DEC_65	.FILL	#65
	HEX_41	.FILL	x41
	
.end
