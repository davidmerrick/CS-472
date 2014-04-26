#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int isPalindrome(char *testString)
{
	int back = (int) strlen(testString);

	if(back % 2 != 1){
		return -1; //Error. String needs to be of odd number length
	}

	//Iterate through the string
	for(int i=0; i < (((int) strlen(testString)/2)); i++){
		if(testString[i] != testString[back-1]){
			return 0; //Not a palindrome
		}
		back--;
	}

	return 1;
}

int main(int argc, char **argv)
{
	char *testString1 = "not";
	char *testString2 = "dad";

	printf("Is \"%s\" a palindrome? %d\n", testString1, isPalindrome(testString1));
	printf("Is \"%s\" a palindrome? %d\n", testString2, isPalindrome(testString2));
}
