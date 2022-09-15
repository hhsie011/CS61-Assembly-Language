;=================================================
; Name: Hsiang-Yin Hsieh
; Email: hhsie011@ucr.edu
; 
; Lab: lab 3, ex 2
; Lab section: 22
; TA: Jang-Shin Lin
; 
;=================================================
.ORIG x3000
;---------------
;Instructions
;---------------
	LD	R1, DEC_10
	LEA	R2, ARRAY_1
	
	DO_WHILE_LOOP
		GETC
		OUT
		STR	R0, R2, #0
		ADD	R2, R2, #1
		ADD	R1, R1, #-1
	BRp	DO_WHILE_LOOP
	
	HALT
;---------------
;Local data
;---------------
	ARRAY_1	.BLKW	#10
	DEC_10	.FILL	#10

.END
