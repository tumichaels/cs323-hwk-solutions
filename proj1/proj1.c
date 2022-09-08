#include "proj1.h"
#include <assert.h>
#include "string_t.h"

enum read_states {PTEXT, ESC, COMM, END_COMM};

int main() {

    // this grabs all user input and stuffs it in a buffer
    // the advantage to doing this over reading the input
    // directly is when you expand you don't need to switch
    // between stdin and a buffer, just between buffers
    String_t input = str_create(); 
    int nextchar;

    enum read_states state = PTEXT;

    while((nextchar = getchar()) != EOF) {

        switch (state) {

            case PTEXT:
                switch (nextchar) {
                    case '%':
                        state = PTEXT;
                        break;

                    case '\\':
                        state = ESC;
                        str_add_char(input, nextchar);
                        break;

                    default:
                        str_add_char(input, nextchar);
                        break;
                }
                break;

            case ESC:
                str_add_char(input, nextchar);
                state = PTEXT;
                break;

            case COMM:
                if (nextchar == '\n') {
                    state = END_COMM;
                }
                break;

            case END_COMM:
                switch (nextchar) {
                    case ' ':
                    case '\t':
                        break;
                    
                    default:
                        state = PTEXT;
                        break;
                }

            default:
                DIE("%s", "switch error when reading input");
                break;
        }
    }
}

enum parse_states {PTEXT, ESC, MACRO};

// get yourself a better function name
String_t
state_machine(String_t input) {

    String_t out = str_create();

    enum parse_states state = PTEXT;

    for (int i = 0; i < str_len(input); i++) {

        int nextchar = str_get_char(input, i);

        switch (state) {

            // TODO: Comments!!!
            case PTEXT:
                switch (nextchar) {

                    case '\\':
                        state = ESC;
                        break;

                    default:
                        str_add_char(input, nextchar);
                        break;
                }
                break;

            case ESC:
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
                        state = MACRO;
                        break;
                }

            case MACRO:
                // from above we know this won't be an escape
                assert(nextchar != '\\');

                String_t macro = str_create();

                // we're now manually advancing where we are in the count
                // might want to set up a separate variable for this loop
                // then I can recombine at the ende
                while(isalnum(nextchar)) {
                    nextchar = str_get_char(input, i); 
                    str_add_char(macro, nextchar);
                    i++;
                }

                if (nextchar != '{') {
                    DIE("%s", "ERROR: macro names may not contain \
                            non-alphanumeric characters");
                }

                // here comes actual macro evaluation :(
                int num_args = find_macro(macro);

                if (num_args == 0) {
                    DIE("%s", "ERROR: could not find macro with \
                            given name");
                }

                // store all args in an array?
                String_t args[num_args];
                for (int j=0; j < num_args; j++) {
                    args[j] = str_create();

                    assert(nextchar == '{');
                    i++; //move on from start of first brace
                    nextchar = str_get_char(input, i);

                    // simple state machine to collect args
                    // we'll make it a function later
                    int brace_balance = 0;

                    // "while ending cond isn't true  xP"
                    //  i can write a solution that doesn't
                    //  break the convention, but it will
                    //  mean some of my variables get desync'd
                    //  probably dangerous!!!
                    while(!(nextchar == '}' && brace_balance == 0)) {
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
                String_t expanded = eval_macro(macro, args);
                str_cat(out, expanded);

                state = PTEXT;
        }
    }

    return out;
}

