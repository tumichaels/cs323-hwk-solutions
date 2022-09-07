#include "proj1.h"
#include "queue.h"
#include <assert.h>

// we model off of assignment 6 from cs223

int process_file(char *filename);
char * eval_macros(char *input, size_t input_size);


#define STR_SIZE (16)

char *
add_char(char *ptr, size_t top, size_t ptr_size, int c) {
    if (top >= ptr_size) {
        ptr = DOUBLE(ptr, ptr_size);
    }

    ptr[top] = c;
    top++;

    return ptr;
}

int main() {

    // this grabs all user input and stuffs it in a buffer
    // the advantage to doing this over reading the input
    // directly is when you expand you don't need to switch
    // between stdin and a buffer, just between buffers
    size_t input_size = STR_SIZE;
    char *input = malloc(input_size);
    size_t top = 0;

    int nextchar;

    while((nextchar = getchar()) != EOF) {
        input = add_char(input, top, input_size, nextchar);
    }

    input_size = top;
    input = realloc(input, input_size);

}

enum s {PTEXT, ESC, MACRO} state;

char *
eval_macros(char *input, size_t input_size) {

    size_t out_size = STR_SIZE;
    char *out = malloc(out_size);
    size_t top = 0;

    
    state = PTEXT;

    for (int i = 0; i < input_size; i++) {

        int nextchar = input[i];

        switch (state) {

            case PTEXT:
                if (nextchar == '\\') {
                    state = ESC;
                } else {
                    out = add_char(out, top, out_size, nextchar); 
                }
                break;

            case ESC:
                switch (nextchar) {
                    case '%':
                    case '\\':
                    case '{':
                    case '}':
                    case '#':
                        add_char(out, top, out_size, nextchar);
                        break;

                    default:
                        i--; // look at this char again next time around
                        break;
                }
            
            case MACRO:
                // from above we know this won't be an escape
                assert(nextchar != '}');

                size_t macro_size = STR_SIZE;
                char *macro = malloc(macro_size);
                size_t top = 0;

                while(isalnum(nextchar)) {
                    nextchar = input[i];
                    macro = add_char(macro, top, macro_size, nextchar);
                    i++;
                }

                if (nextchar != '{') {
                    DIE("%s", "ERROR: macro names may not contain \
                               alphanumeric characters");
                }

                // here comes actual macro evaluation :(
        }


    }

}

