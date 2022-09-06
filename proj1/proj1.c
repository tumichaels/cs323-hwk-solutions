#include "proj1.h"
#include "queue.h"

// for now we pretend all input comes from stdin
// should be able to modify this to take other
// input / output sources like getc does
void
add_input_to_queue(Queue q) {

	// buffer info
	int plaintext = true;

	size_t top = 0;
	size_t buff_size = 16;
	// I should only malloc if needed, not sure when
	int *buff = malloc(sizeof(int)*buff_size);

	int nextchar;

	// TODO: change getchar
	// to getc at some point
	while((nextchar = getchar()) != EOF) {
		
		if (plaintext && nextchar == '\\'){
			// add a plaintext block to q
			buff = realloc(buff, sizeof(int)*top);
			struct elt *e = elt_create(buff, true);
			enq(q, e);
			
			// change buffer to macro mode
			plaintext = false;
			top = 0;

		} else if (!(plaintext) && !isalnum(nextchar)) {
			DIE("ERROR: non-alphanumeric character in macro name");
		} else {
			// dynamic buffer add
			if (top >= buff_size) {
				buff_size *= 2;
				realloc(buff, sizeof(int)*buff_size);
			}

			buff[top] = nextchar;
			top++;
		}
	}
	
}


// we also need a search function that can look
// up macro names
int
find_macro(int *name) {}
