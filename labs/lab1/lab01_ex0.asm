;
;Hello world example program
;Also illustrates how to use PUTS (aka: Trap x22)
;
.ORIG x3000
;-------------
;Instructions
;-------------
	LEA	R0, MSG_TO_PRINT	;R0<--the location of the label: MSG_TO_PRINT
	PUTS					;Prints string defined at MSG_TO_PRINT
	
	HALT					;terminate program
;-----------
;Local data
;-----------
	MSG_TO_PRINT	.STRINGZ	"Hello world!!!\n"	

.END
