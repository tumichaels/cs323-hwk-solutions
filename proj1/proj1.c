#include "proj1.h"
#include <assert.h>
#include "string_t.h"

enum read_states {R_PTEXT, R_ESC, R_COMM, R_END_COMM};

int main() {

    // this grabs all user input and stuffs it in a buffer
    // the advantage to doing this over reading the input
    // directly is when you expand you don't need to switch
    // between stdin and a buffer, just between buffers
    String_t input = str_create(); 
    int nextchar;

    enum read_states state = R_PTEXT;

    while((nextchar = getchar()) != EOF) {

        switch (state) {

            case R_PTEXT:
                switch (nextchar) {
                    case '%':
                        state = R_COMM;
                        break;

                    case '\\':
                        state = R_ESC;
                        str_add_char(input, nextchar);
                        break;

                    default:
                        str_add_char(input, nextchar);
                        break;
                }
                break;

            case R_ESC:
                str_add_char(input, nextchar);
                state = R_PTEXT;
                break;

            case R_COMM:
                if (nextchar == '\n') {
                    state = R_END_COMM;
                }
                break;

            case R_END_COMM:
                switch (nextchar) {
                    case ' ':
                    case '\t':
                        break;

                    default:
                        state = R_PTEXT;
                        break;
                }

            default:
                DIE("%s", "switch error when reading input");
                break;
        }
    }
}

enum parse_states {P_PTEXT, P_ESC, P_MACRO};

// get yourself a better function name
// free input after using parse text
String_t
parse_text(String_t input) {

    String_t out = str_create(); // free after final print

    enum parse_states state = P_PTEXT;

    for (int i = 0; i < str_len(input); i++) {

        int nextchar = str_get_char(input, i);

        switch (state) {

            case P_PTEXT:
                switch (nextchar) {

                    case '\\':
                        state = P_ESC;
                        break;

                    default:
                        str_add_char(input, nextchar);
                        break;
                }
                break;

            case P_ESC:
                switch (nextchar) {
                    case '%':
                    case '\\':
                    case '{':
                    case '}':
                    case '#':
                        str_add_char(input, nextchar);
                        break;

                    default:
                        i--; // look at this char again next time around
                        state = P_MACRO;
                        break;
                }
                break;

            case P_MACRO: {
                // from above we know this won't be an escape
                assert(nextchar != '\\');

                String_t macro_name = str_create();

                // collects the macro name
                // make this a function later
                while(isalnum(nextchar)) {
                    nextchar = str_get_char(input, i); 
                    str_add_char(macro_name, nextchar);
                    i++;
                }

                if (nextchar != '{') {
                    DIE("%s", "ERROR: macro names may not contain \
                            non-alphanumeric characters");
                }

                // not sure whether i should make a macro struct 
                // we're going to use the pointer assign value trick

                String_t (*macro_func)(String_t[]);
                int *num_args;

                find_macro(macro_name, macro_func, num_args);
                str_destroy(macro_name);

                if (macro_func == NULL) {
                    DIE("%s", "ERROR: could not find macro with \
                            given name");
                }

                // store all args in an array?
                // make this a function later
                String_t args[*num_args];
                for (int j=0; j < *num_args; j++) {
                    args[j] = str_create();

                    assert(nextchar == '{');
                    int brace_balance = 1;
                    i++; //move on from start of first brace

                    nextchar = str_get_char(input, i);

                    while(!(nextchar == '}' && brace_balance == 1)) {
                        nextchar = str_get_char(input, i);
                        switch(nextchar){

                            case '{':
                                brace_balance++;
                                break;

                            case '}':
                                brace_balance--;
                                break;

                            default:
                                break;
                        }
                        str_add_char(args[j], nextchar);
                        i++;
                    }
                }

                // now we have to actually do the macros
                String_t expanded = (*macro_func)(args); 
                for (int j = 0; j < *num_args; j++) {
                    str_destroy(args[j]);
                }

                str_cat(out, expanded);
                str_destroy(expanded);

                state = P_PTEXT;
                break;}

            default:
                DIE("%s", "switch error when parsing input");
                break;
        }
    }

    // maybe don't destroy here
    //str_destroy(input);

    return out;
}

typedef String_t (*macro_func)(String_t[]);

size_t f_top;
size_t f_size;


macro_func
find_macro(String_t name, String_t (*func)(String_t[]), int *num_args){

    if (str_eq(name, "def") == 0) {
        *num_args = 1;

//    } else if (str_eq(name, "undef") == 0) {
//        
//    } else if (str_eq(name, "if") == 0) {
//        
//    } else if (str_eq(name, "ifdef") == 0) {
//        
//    } else if (str_eq(name, "include") == 0) {
//        
//    } else if (str_eq(name, "expandafter") == 0) {
        
    } else {
        *num_args = 1;
    }

    return func; 
}


// custom macros

/*
 * \def
 * \undef
 * \if
 * \ifdef
 * \include
 * \expandafter
 */
