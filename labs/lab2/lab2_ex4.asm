;=================================================
; Name: Hsiang-Yin Hsieh
; Email: hhsie011@ucr.edu
; 
; Lab: lab 2, ex 4
; Lab section: 22
; TA: Jang-Shin Enoch Lin
; 
;=================================================
.ORIG x3000
;--------------
;Instructions
;--------------

	LD	R0, HEX_61
	LD	R1, HEX_1A
	
	DO_WHILE_LOOP
		OUT
		ADD R0, R0, #1
		ADD	R1, R1, #-1
	BRp	DO_WHILE_LOOP
	
	HALT

;-------------
;Local data
;-------------
	HEX_61	.FILL	x61
	HEX_1A	.FILL	x1A

.END
