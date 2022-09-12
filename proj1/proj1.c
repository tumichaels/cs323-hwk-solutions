#include "proj1.h"
#include <assert.h>
#include "string_t.h"
#include "user_macro.h"

enum read_states {R_PTEXT, R_ESC, R_COMM, R_END_COMM};

// reads an input, whether stdin or a file into a
// buffer, removing comments as it goes
void
input_to_string(FILE *stream, String_t out) {

	enum read_states state = R_PTEXT;
	int nextchar; // careful about nullchar mid file

	while(EOF != (nextchar = getc(stream))) {

		switch (state) {

			case R_PTEXT:
				switch (nextchar) {
					case '%':
						state = R_COMM;
						break;

					case '\\':
						str_add_char(out, nextchar);
						state = R_ESC;
						break;

					default:
						str_add_char(out, nextchar);
						break;
				}
				break;

			case R_ESC:
				str_add_char(out, nextchar);
				state = R_PTEXT;
				break;

			case R_COMM:
				if ('\n' == nextchar) {
					state = R_END_COMM;
				}
				break;

			case R_END_COMM:
				switch (nextchar) {
					case ' ':
					case '\t':
						break;

					default:
					str_add_char(out, nextchar);
					state = R_PTEXT;
					break;
			}
			break;

		default:
			DIE("%s", "switch error when reading out");
			break;
		}
	} 
}

enum parse_states {P_PTEXT, P_ESC, P_MACRO};

String_t
parse_macro_name(String_t input, int *i);

String_t *
parse_macro_args(String_t input, int *i, int num_args);

typedef String_t (*Macro_func)(Macro_list, String_t, String_t[]);

void
load_macro(Macro_list, String_t, int *, Macro_func *, String_t *);

// returns a string equal to expanded input 
String_t
parse_text(Macro_list user_macros, String_t input) {

	String_t out = str_create(); 

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
						str_add_char(out, nextchar);
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
						str_add_char(out, nextchar);
						state = P_PTEXT;
						break;

					default:
						if (isalnum(nextchar)) {
							i--; // look at this char again next time around
							state = P_MACRO;
						} else {
							str_add_char(out, '\\');
							str_add_char(out, nextchar);
							state = P_PTEXT;
						}
						break;
				}
				break;

			case P_MACRO: 
				// from above we know this won't be an escape
				assert(nextchar != '\\');

				String_t macro_name = parse_macro_name(input, &i); 

				// not sure whether i should make a macro struct
				Macro_func *mf = malloc(sizeof(Macro_func));
				int *num_args = malloc(sizeof(int));
				String_t *macro_text = malloc(sizeof(String_t)); 

				load_macro(user_macros, macro_name, num_args, mf, macro_text);
				str_destroy(macro_name);

				if (NULL == *mf) {
					DIE("%s", "ERROR: could not find macro with \
							given name");
				}

				// store all args in an array
				String_t *args = parse_macro_args(input, &i, *num_args);

				// now we have to actually do the macros
				String_t expanded = (**mf)(user_macros, *macro_text, args);
				free(macro_text);
				free(mf);
				for (int j = 0; j < *num_args; j++) {
					str_destroy(args[j]);
				}
				free(num_args);
				free(args);

				String_t recurse = parse_text(user_macros, expanded);
				str_destroy(expanded);

				if (!str_is_empty(recurse)) {
					str_cat(out, recurse);
				}
				str_destroy(recurse);

                state = P_PTEXT;
                break;

            default:
                DIE("%s", "switch error when parsing input");
                break;
        }
    }
    return out;
}

String_t
parse_macro_name(String_t input, int *i) {

    String_t macro_name = str_create();

    int nextchar = str_get_char(input, *i);

    while(isalnum(nextchar)) {
        str_add_char(macro_name, nextchar);
        (*i)++;
        nextchar = str_get_char(input, *i); 
    }
    if ('{' != nextchar) {
        DIE("%s", "ERROR: macro names may not contain \
                non-alphanumeric characters");
    }
    return macro_name;
}

String_t *
parse_macro_args(String_t input, int *i, int num_args) {

    // ask what this does exactly?
    String_t *args = malloc(sizeof(String_t)*num_args);

    int nextchar = str_get_char(input, *i);

    for (int j=0; j < num_args; j++) {
        args[j] = str_create();

        assert(nextchar == '{');
        int brace_balance = 1;

        (*i)++; //move on from start of first brace
        nextchar = str_get_char(input, *i);

        while(!(nextchar == '}' && brace_balance == 1)) {
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
            (*i)++;
            nextchar = str_get_char(input, *i);
        }
	// move on from last rbrace 
	(*i)++;
	nextchar = str_get_char(input, *i);
    }
    (*i)--; // end on last rbrace to advance properly
    return args;
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

String_t
exec_def(Macro_list, String_t, String_t[]);

String_t
exec_undef(Macro_list, String_t, String_t[]);

String_t
exec_if(Macro_list, String_t, String_t[]);

String_t
exec_ifdef(Macro_list, String_t, String_t[]);

String_t
exec_include(Macro_list, String_t, String_t[]);

String_t
exec_expandafter(Macro_list, String_t, String_t[]);

String_t
exec_user(Macro_list, String_t, String_t[]);

void
load_macro(Macro_list user_macros,
        String_t name, 
        int *num_args,           
        Macro_func *func, 
        String_t *text){

    *func = NULL;

    char *s_name = str_make_c_string(name);

    if (strcmp(s_name, "def") == 0) {
        *num_args = 2;
        *func = &exec_def;

    } else if (strcmp(s_name, "undef") == 0) {
        *num_args = 1;
        *func = &exec_undef;

    } else if (strcmp(s_name, "if") == 0) {
        *num_args = 3;
        *func = &exec_if;

    } else if (strcmp(s_name, "ifdef") == 0) {
        *num_args = 3;
        *func = &exec_ifdef;

    } else if (strcmp(s_name, "include") == 0) {
        *num_args = 1;
        *func = &exec_include;

    } else if (strcmp(s_name, "expandafter") == 0) {
        *num_args = 2;
        *func = &exec_expandafter;

    } else if ((*text = ml_get_macro_text(user_macros, name))){
        *num_args = 1;
        *func = &exec_user;
    }

    free(s_name);
}


String_t
exec_def(Macro_list user_macros, String_t text, String_t args[]) {
    if (ml_get_macro_text(user_macros, args[0])) {
        DIE("%s", "ERROR: cannot define existing macro");
    } else {
        ml_add_macro(user_macros, args[0], args[1]);
    }
    return str_create();
}

String_t
exec_undef(Macro_list user_macros, String_t text, String_t args[]) {
    if (!ml_del_macro(user_macros, args[0])) {
        DIE("%s", "ERROR: cannot undefine non-existent macro");
    }
    return str_create();
}

String_t
exec_if(Macro_list user_macros, String_t text, String_t args[]) {
    if (str_is_empty(args[0])) {
        return str_cpy(args[2]);
    } else {
        return str_cpy(args[1]);
    }
}

String_t
exec_ifdef(Macro_list user_macros, String_t text, String_t args[]) {
    if(ml_get_macro_text(user_macros, args[0])) {
        return str_cpy(args[1]);
    } else {
        return str_cpy(args[0]);
    }
}

String_t
exec_include(Macro_list user_macros, String_t text, String_t args[]) {
    FILE *fp;
    fp = fopen(str_make_c_string(args[0]), "r");
    String_t out = str_create();
    input_to_string(fp, out);
    fclose(fp);
    return out;
}

String_t 
exec_expandafter(Macro_list user_macros, String_t text, String_t args[]) {
    String_t out = str_cpy(args[0]);
    str_cat(out, parse_text(user_macros, args[1]));
    return out;
}

String_t
exec_user(Macro_list user_macros, String_t text, String_t args[]) {
    String_t out = str_create();
    int esc = 0;
    for (size_t i = 0; i < str_len(text); i++) {
        int nextchar = str_get_char(text, i);
        if (!esc) {
            switch(nextchar) {
                case '\\':
                    esc = true;
                    break;

                case '#':
                    str_cat(out, args[0]);
                    break;

                default:
                    str_add_char(out, nextchar);
                    break;
            }
        } else {
            switch(nextchar) {
                case '%':
                case '\\':
                case '{':
                case '}':
                case '#':
                    str_add_char(out, nextchar);
                    break;

                default:
                    str_add_char(out, '\\');
                    str_add_char(out, nextchar);
                    break;
            }
            esc = false;
        }
    }
    return out;
}

int
main(int argc, char **argv) {

    String_t read = str_create();

    if (argc == 1) {
        input_to_string(stdin, read);
        
    } else {
        for (int i = 1; i < argc; i++) {
            FILE *fp;
            fp = fopen(argv[i], "r");
            input_to_string(fp, read);
            fclose(fp);
        }
    }

    Macro_list ml = ml_create();
    String_t disp = parse_text(ml, read);
    str_print(disp);
//
    str_destroy(read);
    ml_destroy(ml);
    str_destroy(disp);

    return 0;
}
