	AREA Lab3, CODE, READWRITE
	ENTRY
	
Main	
		B	Q357
		B	Q359
		B	Q360
		B	LastQuestion
		B	Done
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;	Question 357
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;We need to swap the following registers. Do this 
;using block moves.
;Before After
;r1 	r3
;r2 	r4
;r3 	r5
;r4 	r6
;r5 	r7
;r6 	r1
;r7 	r2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Q357	
		;r1 <- r3
		;r2 <- r4
		;r3 <- r5
		;r4 <- r6
		;r5 <- r7
		;r6 <- r1
		;r7 <- r2
		ADR	sp,Base

		MOV	r1,#1
		MOV r2,#2
		MOV r3,#3
		MOV r4,#4
		MOV r5,#5
		MOV r6,#6
		MOV r7,#7
		
		STMIA sp!,{r3-r7}
		STMIA sp!,{r1,r2}
		
		LDMDB sp!,{r3-r7}
		LDMDB sp!,{r1,r2}
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
; Question 3.59:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;Write a function (subroutine) that inputs a data 
;value in register r0 and returns value in r0. The 
;function returns y = a + bx + cx^2, where a, b, 
;and c are parameters built into the function (i.e., they 
;are not passed to it). The subroutine also performs 
;clipping. If the output is greater than a value d, it 
;is constrained to d (clipped). The input in r0 is a 
;positive binary value in the range 0 to 0xFF. Apart 
;from r0, no other registers may be modified by this 
;subroutine.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Q359
		SUB		r13,r13,#4
		STR		r15,[r13]
		B		Routine

		
Routine
		STMDB	sp!,{r1-r4} ; save state of registers since we
							; need these to use MUL - will restore after use
		MOV		r0,#2
		
		;LDR		r1,var_A
		LDR		r2,var_B
		LDR		r3,var_C
		LDR		r4,var_D
					
		MUL		r1,r0,r0	;r1 <- x^2
		MUL		r2,r0,r2	;r2 <- b*x
		
		;LDR		r0,var_A
		MUL		r0,r3,r0	;r0 <- c*x^2
		ADD		r0,r0,r2	;r0 <- b*x + c*x^2
		
		LDR		r2,var_A
		ADD		r0,r0,r2	;r0 <- a + bx + cx^2
		
		CMP		r0,r4		;compare result to cap value
		BLE		Finish
		MOV		r0,r4		;else, too big, replace with cap
		
Finish		
		LDMIA	sp!,{r1-r4}	;restore registers
		B		Done
	
var_A	DCD		1
var_B	DCD		2
var_C	DCD		3
var_D	DCD		50	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Question 3.60
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;A computer has three eight-element vectors in memory,
;Va,Vb, and Vc. Each element of a vector is a 32-bit word.
;Write the code to calculate all elements of Vc if the ith
;element is given by Vci = 1/2(Vai+Vbi).
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Q360
    		MOV 	r0,#1			;counter variable
    		
    		ADR		r1,VectorA		;set registers to
    		ADR		r2,VectorB		;vector data
    		ADR		r3,VectorC
    			
Loop	    LDR 	r4,[r1],#4
    		LDR 	r5,[r2],#4
    		CMP 	r0,#8 			;if at 8, then all 8 calcs finished
    		BEQ 	Done
    		ADD		r0,#1 			;else increment our loop counter
    		ADD 	r7,r4,r5		;r7 <- Vai + Vbi
    		ASR		r7,r7,#1 		;shift one bit = 1/2(value)
    		
    		STR		r7,[r3],#4 	;r7 <- Vc = value
    		
    		B		Loop
			
            B 		Done

VectorA		DCD 1,1,1,1,2,2,2,2
VectorB		DCD 2,2,2,2,3,3,3,3
VectorC		DCD	0,0,0,0,0,0,0,0
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
; Last Question	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;A function which tests the endianness of the system, and 
;flips it as requested. This will be expanded upon in a 
;later lab to examine the concept of endian neutral 
;programming
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LastQuestion
	ADR		sp,EndianNum
	MOV		r1,#0x00000001
	
	STRB 	sp!,{r1}
	LDRH 	sp!,{r2}
	
	CMP		r2,#0x0001
	BEQ		Reverse			;if == then little endian
	B		Done			;else, do nothing
	
Reverse
	
	;;Reverse bits here?
	
	B		Done
	
Little
	
	
Done	B		Done	


	AREA Lab3, DATA, READWRITE
Base		DCD	0x11111111	;stack base and dummy data (Q359)
EndianNum	DCD	0x00000000 	;(LastQuestion)

	END