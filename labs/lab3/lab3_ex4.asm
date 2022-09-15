;=================================================
; Name: Hsiang-Yin Hsieh
; Email: hhsie011@ucr.edu
; 
; Lab: lab 3, ex 4
; Lab section: 22
; TA: Jang-Shin Enoch Lin
; 
;=================================================
.ORIG x3000
;---------------
;Instructions
;---------------
	LD	R1, ARRAY_PTR
	LD	R2, NEWLINE_CH
	NOT	R3, R2
	ADD	R3, R3, #1
	
	DO_WHILE_LOOP
		GETC
		OUT
		STR	R0, R1, #0
		ADD	R1, R1, #1
		ADD	R4, R0, R3
	BRnp	DO_WHILE_LOOP
	
	ADD	R0, R2, #0
	OUT
	
	LD	R1, ARRAY_PTR
	
	DO_WHILE_LOOP_2
		LDR	R0, R1, #0
		ADD	R5, R0, #0
		OUT
		ADD R0, R2, #0
		OUT
		ADD	R1, R1, #1
		ADD	R4, R5, R3
	BRnp DO_WHILE_LOOP_2
	
	HALT
;---------------
;Local data
;---------------
	ARRAY_PTR	.FILL	x4000
	NEWLINE_CH	.FILL	x0A

.END
