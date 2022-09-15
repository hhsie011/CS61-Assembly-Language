;=================================================
; Name: Hsiang-Yin Hsieh
; Email: hhsie011@ucr.edu
; 
; Lab: lab 4, ex 3
; Lab section: 22
; TA: Jang-Shin Enoch Lin
; 
;=================================================
.ORIG x3000
;------------------
;Instructions
;------------------
	LD	R1, ARRAY_1_PTR
	AND	R2, R2, #0
	ADD	R2, R2, #10
	AND	R3, R3, #0
	ADD	R3, R3, #1
	
	DO_WHILE_LOOP
		STR	R3, R1, #0
		ADD	R3, R3, R3
		ADD	R1, R1, #1
		ADD	R2, R2, #-1
		BRp	DO_WHILE_LOOP
	END_DO_WHILE_LOOP
	
	ADD	R1, R1, #-4
	LDR	R2, R1, #0
	
	HALT
;------------------
;Local data
;------------------
	ARRAY_1_PTR	.FILL	x4000
;------------------
;Remote data
;------------------
.ORIG x4000
	ARRAY_1	.BLKW	#10

.END
