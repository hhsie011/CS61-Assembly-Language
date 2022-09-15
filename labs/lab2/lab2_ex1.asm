;=================================================
; Name: Hsiang-Yin Hsieh
; Email: hhsie011@ucr.edu
; 
; Lab: lab 2. ex 1
; Lab section: 22
; TA: Jang-Shin Enoch Lin
; 
;=================================================
.ORIG x3000
;-------------
;Instructions
;-------------
	LD	R3, DEC_65
	LD	R4, HEX_41
	
	HALT
;-------------
;Local data
;-------------
	DEC_65	.FILL	#65
	HEX_41	.FILL	x41
.end
