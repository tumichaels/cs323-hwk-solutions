#include "proj1.h"

int main(int argc, char **argv)
{
	char nextchar = 0;

	size_t input_size = 1;
	char *input = malloc(input_size*sizeof(char));
	size_t top = 0;

	if (argc == 1) {

		// if it's not an escape character, we don't load into 
		// input and instead just putc immediately, but we want
		// to avoid checking the single character thing all the
		// time so instead
		
		while ((nextchar = getchar()) != '\')


	}
}



// a simple state machine type function code

int plaintext = 1;
int nextchar = 0;

int plaintext
while(1) {
	
	nextchar = getchar()

	if (plaintext) {
		// ask someone if EOF check is necessary
		if (nextchar == '\\' || nextchar == EOF) {
			plaintext = 0;
		} else {
			putchar(nextchar);
		}
	} else {
		if (nextchar == '{') {
			// trim macro name buffer
			// search for macro name
			// execute the macro, which is func pointer
			plaintext = 1;
		} else {
			// add to buffer func
		}
	}

	if (nextchar == EOF) {
		break;
	}
}

// adds char to buff from stdin unless char statisfies cond, then terminate
int* to_buff_until(int *buff, int (*cond)(int)) {

	int nextchar;
	
	size_t top = 0;
	size_t buff_size = 1;


	while (1) {
		
		nextchar = getchar();

		if (top >= buff_size) {
			realloc(buff, (buff_size *= 2) * sizeof(int));
		}
		
		if ((*cond)(nextchar) || nextchar == EOF) {
			realloc(buff, top+1);
			return buff;
		} else {
			buff[top] = nextchar;
			top++;
		}
	}
}
