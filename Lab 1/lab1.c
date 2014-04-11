#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <math.h>

#define F64_EXP_MASK 0x7FF0000000000000
#define F64_EXP_SHIFT 52
#define F64_GET_EXP(fp) (fp & F64_EXP_MASK) >> F64_EXP_SHIFT
#define F64_GET_SIGN(fp) fp >> F64_SIGN_SHIFT

#define F64_MANT_MASK 0xFFFFFFFFFFFFFL
#define F64_MANT_SHIFT 0

// We're not actually using these
// #define F64_GET_MANT_HIGH(fp)
// #define F64_GET_MANT_LOW(fp)

#define F64_SIGN_SHIFT 63;

// Biasing is done because exponents have to be signed values in order to be able to represent both
// tiny and large values, but two's complement, the usual representation for signed values,
// would make comparison harder.
//
// For a double-precision number, an exponent in the range −1022 .. +1023 is
// biased by adding 2^11-1, or 1023, to get a value in the range 1 .. 2046
// Source: http://en.wikipedia.org/wiki/Exponent_bias
#define F64_EXP_BIAS 1023
#define F64_SET_EXP

int get_sign(double x)
{
	unsigned long int *bits = (unsigned long int *) &x; //The double represented as bits
	int sign = F64_GET_SIGN(*bits); //Holds the sign bit as an int (1 or 0)
	return sign;
}

double frexp_2(double x, int *exp)
{
	double mantissa; //Holds the 52 mantissa bits
	unsigned long int *bits = (unsigned long int *) &x; //The double represented as bits
	int sign = get_sign(x);

	//Sign bit is 1; Number is negative, or Sign bit is 0; Number is positive.
	//3070 = 2047 + 1023
	//If the number is negative,
	*exp = sign ? ((*bits >> F64_EXP_SHIFT) - 3070) : ((*bits >> F64_EXP_SHIFT) - (F64_EXP_BIAS - 1));

	mantissa = *bits & F64_MANT_MASK;
	mantissa = (((mantissa/pow(2,52)) + 1)/2);

	return pow(-1, sign) * mantissa;
}

int main(int argc, char *argv[])
{
	// Pointers for exponents to our implementation and
	// actual implementations of frexp, respectively
	unsigned int e_ours, e_actual;
	double input;

	if (argc < 2){
		printf("Must input a number.");
		exit(1);
	}

	input = atof(argv[1]);

	double x = frexp_2(input, &e_ours);
	printf("Our frexp: %f * 2^%d\n\n", x, e_ours);

	double y = frexp(input, &e_actual);
	printf("Actual frexp: %f * 2^%d\n\n", y, e_actual);

	//Extract the features
	printf("Feature extraction:\n");
	/*
	* value is treated as a double
	*/
	printf("If the value is treated as a double: \n");
	printf("The mantissa is: %f\n", x);
	printf("The sign is: %d\n", get_sign(x));
	printf("The exponent is: %d\n", e_ours);
	/*
	* value is treated as a long
	*/
	printf("If the value is treated as a long: \n");
	printf("The value is: %l\n", (long) x);
	printf("The sign is: %l\n", (long) get_sign(x));
	/*
	* value is treated as a 8 chars
	*/
	printf("If the value is treated as 8 characters: \n");
	printf("The characters are: %s\n", (char) x);

	return 0;
}
