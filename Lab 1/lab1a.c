#include <stdio.h>
#include <stdint.h>
#include <sys/types.h>
#include <math.h>
#include <sys/cdefs.h>
//#include <machine/ieee.h>


#define F64_EXP_MAX 

#define F64_EXP_MASK 0x7FF0000000000000
#define F64_EXP_SHIFT 52
#define F64_GET_EXP(fp)

#define F64_MANT_MASK 0x000FFFFFFFFFFFFF
#define F64_MANT_SHIFT 0
#define F64_GET_MANT_HIGH(fp)
#define F64_GET_MANT_LOW(fp)

#define F64_EXP_BIAS
#define F64_SET_EXP



double frexp(x, exp)
		double x;
		int *exp;
{
	union
	{
		double v;
		uint64_t s;
		//struct ieee_double s;
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

	else if(x)
	{
		u.v = x;
		u.v = (u.s & F64_MANT_MASK) >> F64_MANT_MASK;
		*exp = (u.s & F64_EXP_MASK) >> F64_EXP_SHIFT;
		return x;
		
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


void printBits(size_t const size, void const * const ptr)
{
    unsigned char *b = (unsigned char*) ptr;
    unsigned char byte;
    int i, j;

    for (i=size-1;i>=0;i--)
    {
        for (j=7;j>=0;j--)
        {
            byte = b[i] & (1<<j);
            byte >>= j;
            printf("%u", byte);
        }
    }
    puts("");
}


int main(int argc, const char* argv[])
{
	double number = 1.0;
	int* ptr; //= (int*)malloc(sizeof(int));
	double reNum = frexp(number, ptr);

	printBits(12, &reNum);
}