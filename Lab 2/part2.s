		AREA Lab2, CODE, READONLY
		ENTRY
		
CR		EQU 0x0D
	
Start	MOV r0,#0			;Point the registers to the memory locations
		MOV r1,#0			;Make sure these are initially zero'd out
		MOV r2,#0
		MOV r3,#0			;Use this as loop counter and str length
		LDR r4,=Data		;Point r4 to the data
		MOV r5,#0			;Holds the current position of char to be compared
		MOV	r6,#0			;Hold the length of the string
		MOV	r7,#0			;Use as temp register?
		
		
Loop						;While not last char, get another byte
		LDRB	r1,[r4,r3]	;Read n-th byte
		CMP		r1,#CR		;Compare to the string terminator
		BEQ		Loop_End	;If == to CR, stop
		ADD		r3,r3,#1	;If =/= to CR, increment count
		BAL		Loop		;Loop again

Loop_End	
		LDR		r6,[r3]		;Store length of string in r6 (value of r3, not address,
							;specified with the []
		SUB		r3,r3,#1
		
		CMP		r6,#0		;Compare str length to 0
		BEQ		Zero_Case	;Break if length of string = 0
		CMP		r6,#1		;Compare str length to 1
		BEQ		One_Case	;Break if length of string = 1
		B		Div_Two
		
		
Div_Two			;Finds half the length of the string, so we know how many times to check bytes
		CMP		r3,#0
		BEQ		Load_Half	;If r3 == 0, then length of array is 0, break to Zero_Case
		SUB		r3,r3,#2	;Else, subtract 2 from value of r3
		ADD		r7,r7,#1	;Increment counter
		BAL		Div_Two


Load_Half		
		LDR		r3,[r7]	;Load the value of r7 into r3, which is half the length of the array
							;In other words, we now know how many times to loop through and compare
							;bytes of string
		B		Cmp_Bytes
		

Cmp_Bytes
		CMP		r3,r5
		BEQ		One_Case	;If r3 and r5 hold the same value, then we've gone through the entire list, and
							;everything matches, send to One_Case
		LDRB	r1,[r4,r5]	;Point r1 at the first byte of string
		LDRB	r2,[r4,r6]	;Point r2 at the last byte of the string
		CMP		r1,r2
		BNE		Zero_Case	;If not equivalent, exit and set r0 to 0
		SUB		r6,r6,#1		;Subtract one (because we already checked the last bit)
		ADD		r5,r5,#1		;Add one (because we already checked first bit)
		BAL		Cmp_Bytes	;Keep looping
		

Zero_Case	;Set r0 to 0, meaning string was not a palindrome
		MOV r0,#0
		B Done
	
One_Case	;Set r0 to 1, meaning string was a palindrome
		MOV r0,#1
		B Done

Done

		AREA Data, DATA, ABSOLUTE, READWRITE
Str		DCB "MOM",CR				;Assign labels for each memory location
		
		END					;Done