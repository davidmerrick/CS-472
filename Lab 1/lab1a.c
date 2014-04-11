#include <stdio.h>
#include <stdint.h>
#include <math.h>


#define F64_EXP_MAX 

#define F64_EXP_MASK 0x7FF0000000000000
#define F64_EXP_SHIFT 52
#define F64_GET_EXP(fp)

#define F64_MANT_MASK 0x000FFFFFFFFFFFFF
#define F64_MANT_SHIFT 0
#define F64_GET_MANT_HIGH(fp)
#define F64_GET_MANT_LOW(fp)

#define F64_EXP_BIAS 1023
#define F64_SET_EXP

typedef union{
	double num;
	struct{
		unsigned long long int mantissa : 52;
		unsigned long long int exponent : 11;
		unsigned long long int sign : 1;
	} num_bits;
} u;


double frexp(double x, int *exp)
{

	double mant;
	u nb;

	nb.num = x;
	*exp = nb.num_bits.exponent - (F64_EXP_BIAS - 1);
	mant = ((nb.num_bits.mantissa)/(pow(2.0,52)) + 1) / 2;
	
	printf("Sign = %d\n",nb.num_bits.sign);
	printf("Exponent = %d\n", *exp);
	printf("Mantissa = %f\n\n", pow(-1, nb.num_bits.sign) * nb.num_bits.mantissa);

	/*
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
		return u.v;		
	}
	*/
	
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
	double number = 10.0;
	unsigned int expon;

	double reNum = frexp(number, &expon);

	printBits(64, &reNum);
	return;
}