		AREA Lab2, CODE, READONLY
		ENTRY
		
Start	ADR r0,A			;Point the registers to the memory locations
		ADR r1,B
		ADR r2,C
		ADR r3,D
		ADR r4,E
		
		ADD r5,r0,r1		;Add value in r0 and value in r1, and store in r5
		ADD r5,r5,r2		;Add value of r5 and value in r2, store in r5
		
		MUL r2,r3,r4		;Multiply value of r3 and value of r4, store in r3
		
		SUB r5,r5,r2		;Subtract value of r3 from value in r5, store in r5
		
A		DCD 1				;Assign labels for each memory location
B		DCD 2				;and store values in those locations
C		DCD 3
D		DCD 1
E		DCD 0
		
		END					;Done