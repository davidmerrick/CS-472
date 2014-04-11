#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <math.h>

#define F64_EXP_MAX 

#define F64_EXP_MASK 0x7FF0000000000000
#define F64_EXP_SHIFT 52
#define F64_GET_EXP(fp)

#define F64_MANT_MASK 0xFFFFFFFFFFFFFL
#define F64_MANT_SHIFT 0
#define F64_GET_MANT_HIGH(fp)
#define F64_GET_MANT_LOW(fp)

#define F64_SIGN_SHIFT 63;

#define F64_EXP_BIAS 1023
#define F64_SET_EXP


typedef union {
	double num;
	struct {
		unsigned long long int mant : 52;
		unsigned long long int exp : 11;
		unsigned long long int sign : 1;
	} num_str;
} u_bits;


double frexp_2(double x, int *exp)
{
	printf("x: %d\n", x);

	double mant_;
	unsigned long int *num_bits = (unsigned long int *) & x;
	char sign;
	
	if(x == 0)
	{
		*exp = 0;
		
		printf("Sign: %d\n", sign);
		printf("Exponent: %d\n", *exp);
		
		return (0.0);
	}
	else if(x == NAN)
	{
		return NAN
	}
	else if(x == INFINITY || x == -INFINITY)
	{
		return x;
	}
	else{
		sign = *num_bits >> F64_SIGN_SHIFT;
	
		if(!sign)
		{
			*exp = (*num_bits >> F64_EXP_SHIFT) - (F64_EXP_BIAS - 1);
		}
		else
		{
			*exp = (*num_bits >> F64_EXP_SHIFT) - 3070;
		}
	
		mant_ = *num_bits & F64_MANT_MASK;
		mant_ = (((mant_/pow(2,52)) + 1)/2);
		
		printf("Sign: %d\n", sign);
		printf("Exponent: %d\n", *exp);
		printf("Mantissa: %f\n\n", pow(-1, sign) * mant_);
		
		return pow(-1, sign) * mant_;
	}
}

void readAsChar(double x, int *exp)
{
	double mant_;
	unsigned long int *num_bits = (unsigned long int *) & x;
	unsigned char characters;
	
	for(i = 0; i < 8; ++i)
	{
		characters |= (
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


int main(int argc, char *argv[])
{
	unsigned int e;
	double input;
	double q;

	if (argc < 2){
		printf("Must input a number.");
	}

	printf("argv[1]: %s\n", argv[1]);	

	input = atof(argv[1]);
	
	printf("input: %d\n", input);

	q = frexp_2(input, &e);

	printf("\tmyfrexp: %f * 2^%d\n\n", q, e);

	//q = union_frexp(input, &e);

	//printf("\tunion_frexp: %f * 2^%d\n\n", q, e);

	q = frexp(input, &e);

	printf("\tREAL frexp: %f * 2^%d\n\n", q, e);

	return 0;
}
