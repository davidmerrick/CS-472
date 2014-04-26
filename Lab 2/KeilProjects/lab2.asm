		AREA Lab2, CODE, READONLY
		ENTRY
		
Start	MOV r0,#1			;Load the registers with values
		MOV r1,#1
		MOV r2,#1
		MOV r3,#1
		MOV r4,#1
		MOV r5,#0
		
		ADD r5,r0,r1		;Add value in r0 and value in r1, and store in r5
		ADD r5,r5,r2		;Add value of r5 and value in r2, store in r5
		
		MUL r2,r3,r4			;Multiply value of r3 and value of r4, store in r3
		
		SUB r5,r5,r2		;Subtract value of r3 from value in r5, store in r5
		
		END