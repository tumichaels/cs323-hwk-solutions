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
				DIE("%s", "switch error when reading input");
				break;
		}
	} 
}

enum parse_states {PTEXT, ESC, MNAME, MARGS, MBRACE};
typedef enum parse_states *P_state;

bool
parse_char(P_state state, int input,
		   String_t out, 
		   String_t m_args[], int *brace_balance, int *num_args) {

	switch (*state) {
		case PTEXT:
			switch (input) {
				case '\\':
					*state = ESC;
					break;

				default:
					str_add_char(out, input);
					break;
			}
			break;

		case ESC:
			switch (input) {
				case '%':
				case '\\':
				case '{':
				case '}':
				case '#':
					str_add_char(out, input);
					*state = PTEXT;
					break;

				default:
					if (isalnum(input)) {
						str_add_char(m_args[0], input);
						*state = MNAME;
					} else {
						str_add_char(out, '\\');
						str_add_char(out, input);
						*state = PTEXT;
					}
					break;
			}
			break;

		case MNAME:
			if (isalnum(input)) {
				str_add_char(m_args[0], input);
			} else if (input == '{') {
				*brace_balance = 1;
				*state = MARGS;
				return true;
			} else {
				DIE("%s", "ERROR: macro names must be alphanumeric");
			}
			break;

		case MARGS:
			if (input == '}' && *brace_balance == 1) {
				*num_args -= 1;
				if (*num_args == 0) {
					*state = PTEXT;
				} else {
					*state = MBRACE;
				}
			} else {
				if (input == '{') {
					*brace_balance += 1;
				} else if (input == '}') {
					*brace_balance -= 1;
				}
				str_add_char(m_args[*num_args], input);
			}
			break;

		case MBRACE:
			if (input != '{') {
				DIE("%s", "ERROR: expected additional argument for macro");
			} else {
				*brace_balance = 1;
				*state = MARGS;
			}
			break;

		default:
			DIE("%s", "ERROR: switch error when parsing input");
			break;
	}
	return false;
}

typedef String_t (*M_func) (M_list, String_t *);

void
load_macro(M_list, String_t, M_func *, int *, String_t);

void
parse_text(M_list user_macros, P_state state, String_t text,
		   String_t *m_args, int *brace_balance, int *num_args,
		   String_t out) {

	int input;

	
	bool find_func = false;
	M_func *eval_macro = malloc(sizeof(M_func));
	while ((input = str_get_char(text)) != '\0') {
		find_func = parse_char(state, input,
							   out, m_args, 
							   brace_balance, num_args);

		if (find_func) {
			load_macro(user_macros, m_args[0], eval_macro, num_args, m_args[4]);
			if (*eval_macro == NULL) {
				DIE("%s: %s", "ERROR: no macro with given name", str_as_c_string(m_args[0]));
			}
		} else if (*state == PTEXT && *num_args == 0) {
			String_t new_text = (*eval_macro)(user_macros, m_args);
			
			// clean out args
			*num_args = -1;
			for (int i = 0; i<5; i++) {
				str_destroy(m_args[i]);
				m_args[i] = str_create();
			}

			parse_text(user_macros, state, new_text,
					   m_args, brace_balance, num_args,
					   out);
			
			str_destroy(new_text);
		}
	}
	free(eval_macro);
}

String_t
exec_def(M_list user_macros, String_t *args) {
	if (ml_get_macro_text(user_macros, args[2]) != NULL) {
		DIE("%s", "ERROR: cannot define existing macro");
	} else {
		ml_add_macro(user_macros, args[2], args[1]);
	}
	return str_create();
}

String_t
exec_undef(M_list user_macros, String_t *args) {
	if (!ml_del_macro(user_macros, args[1])) {
		DIE("%s", "ERROR: cannot undefine non-existent macro");
	}
	return str_create();
}

String_t
exec_if(M_list user_macros, String_t *args) {
	if (str_is_empty(args[3])) {
		return str_cpy(args[1]);
	} else {
		return str_cpy(args[2]);
	}
}

String_t
exec_ifdef(M_list user_macros, String_t *args) {
	if(!ml_get_macro_text(user_macros, args[3])) {
		return str_cpy(args[1]);
	} else {
		return str_cpy(args[2]);
	}
}

String_t
exec_include(M_list user_macros, String_t *args) {
	FILE *fp;
	fp = fopen(str_as_c_string(args[1]), "r");
	String_t out = str_create();
	input_to_string(fp, out);
	fclose(fp);
	return out;
}

//String_t 
//exec_expandafter(M_list user_macros, String_t *args) {
//	
//	P_state state = malloc(sizeof(enum parse_states)); *state = PTEXT;
//
//	String_t out_back = str_create();
//	String_t *m_name = malloc(sizeof(String_t)); *m_name = str_create();
//
//	int *brace_balance = malloc(sizeof(int)); int *num_args = malloc(sizeof(int));
//	String_t *m_args = malloc(sizeof(String_t) * 3);
//	m_args[0] = str_create();
//	m_args[1] = str_create();
//	m_args[2] = str_create();
//
//	parse_text(args[0],
//			   user_macros, state,
//			   out_back, m_name,
//			   brace_balance, num_args, m_args);
//
//	String_t out = str_cpy(args[1]);
//	str_cat(out, out_back);
//
//	free(state);
//	str_destroy(out_back);
//
//	str_destroy(*m_name);
//	free(brace_balance); free(num_args);
//
//	str_destroy(m_args[0]);
//	str_destroy(m_args[1]);
//	str_destroy(m_args[2]);
//	free(m_args);
//
//	return out;
//}

String_t
exec_user(M_list user_macros, String_t *args) {
    String_t out = str_create();
    bool esc = false;

    int nextchar;
    while ((nextchar = str_get_char(args[4]))){ 
        if (!esc) {
            switch(nextchar) {
                case '\\':
                    esc = true;
                    break;

                case '#':
                    str_cat(out, args[1]);
                    break;

                default:
                    str_add_char(out, nextchar);
                    break;
            }
        } else {
            switch(nextchar) {
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

void
load_macro(M_list um, String_t m_name, M_func *f_ptr, int *n_args, String_t txt) {

	*f_ptr = NULL;

	if (strcmp(str_as_c_string(m_name), "def") == 0)  {
		*f_ptr = &exec_def;
		*n_args = 2;
	} else if (strcmp(str_as_c_string(m_name), "undef") == 0)  {
		*f_ptr = &exec_undef;
		*n_args = 1;
	} else if (strcmp(str_as_c_string(m_name), "if") == 0)  {
		*f_ptr = &exec_if;
		*n_args = 3;
	} else if (strcmp(str_as_c_string(m_name), "ifdef") == 0)  {
		*f_ptr = &exec_ifdef;
		*n_args = 3;
	} else if (strcmp(str_as_c_string(m_name), "include") == 0)  {
		*f_ptr = &exec_include;
		*n_args = 1;
//	} else if (strcmp(str_as_c_string(m_name), "expandafter") == 0)  {
//		*f_ptr = &exec_expandafter;
//		*n_args = 2;
	} else { 
		String_t temp = ml_get_macro_text(um, m_name);
		if (temp) {
			*f_ptr = &exec_user;
			*n_args = 1;
			str_cat(txt, temp);
		}
	} 
}


int 
main(int argc, char **argv){
	String_t read = str_create();

	if (argc ==1) {
		input_to_string(stdin, read);
	} else {
		for (int i = 1; i < argc; i++) {
			FILE *fp;
			fp = fopen(argv[i], "r");
			input_to_string(fp, read);
			fclose(fp);
		}
	}

	M_list user_macros = ml_create();
	P_state state = malloc(sizeof(enum parse_states)); *state = PTEXT;
	String_t *m_args = malloc(sizeof(String_t)*5);

	for (int i = 0; i<5; i++) {
		m_args[i] = str_create();
	}
	int *brace_balance = malloc(sizeof(int)); *brace_balance = 0;
	int *num_args = malloc(sizeof(int)); *num_args = -1;

	String_t out = str_create();

	parse_text(user_macros, state, read,
			   m_args, brace_balance, num_args,
			   out);

	if (*state != PTEXT) {
		DIE("%s", "ERROR: input terminated before parsing was complete");
	}
	printf("%s", str_as_c_string(out));

	ml_destroy(user_macros);
	free(state);
	str_destroy(read);

	for(int i = 0; i<5; i++) {
		str_destroy(m_args[i]);
	}
	free(m_args);
	free(brace_balance);
	free(num_args);

	str_destroy(out);
	
	return 0;
}


