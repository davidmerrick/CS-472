#include <math.h>
#include <stdint.h>

#define F64_EXP_MAX 

#define F64_EXP_MASK 
#define F64_EXP_SHIFT
#define F64_GET_EXP(fp)

#define F64_MANT_MASK
#define F64_MANT_SHIFT
#define F64_GET_MANT_HIGH(fp)
#define F64_GET_MANT_LOW(fp)

#define F64_EXP_BIAS
#define F64_SET_EXP

double frexp(x, exp)
		double x;
		int *exp;

	union
	{
		double v;
		struct uint64_t s;
	} u;
	
	//1 = sign
	//11 = exp -> int
	//52 = fraction -> long
	
	
	if(x == 0)
	{
		*exp = 0;
		return (0.0);
	}
	else if(x == NAN)
	{
		return NAN;
	}
	else if(x == INFINITY || x == -INFINITY)
	{
		return x;
	}
	else if(x >= 0.5 && x < 1)
	{
		*exp = 0;
		return x;
	}
	else if(x != 0)
	{
		int expCount;
		
		while(x > 1)
		{
			x = x / 2.0;
			expCount++;
		}
		*exp = expCount;
		return x;
	}
	else
	{
		//error
	}
	
	if(value)
	{
		u.v = value;
		
		*exp = (u.s & 0x7		//011111111111000x52
		
	}
	
}

void featureExt(value, eptr)
{
	/*
	* value is treated as a double
	*/
	printf("If the value is treated as a double: ");
	printf("The mantissa is: ");
	printf("The sign is : ");
	printf("The exponent is : ");
	/*
	* value is treated as a long
	*/
	printf("If the value is treated as a long: ");
	printf("The value is: ");
	printf("The sign is: ");
	/*
	* value is treated as a 8 chars
	*/
	printf("If the value is treated as 8 characters: ");
	printf("The characters are: ");
}
