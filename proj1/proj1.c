#include "proj1.h"
#include <assert.h>
// an enhanced c-style string
struct string_t {
	size_t pos;
	size_t top;
	size_t size;
	char *buff;
};

typedef struct string_t * String_t;
#define STR_SIZE (16)

String_t
str_create(void) {
	String_t s = malloc(sizeof(struct string_t));
	s->pos = 0;
	s->top = 0;
	s->size = STR_SIZE;
	s->buff = malloc(s->size);
	s->buff[s->top] = '\0';
	return s;
}

void
str_destroy(String_t s) {
	if (!s) {
		return;
	}
	free(s->buff);
	free(s);
}

void
str_add_char(String_t s, char c) {
	if (s->top+1 >= s->size) {
		s->buff = DOUBLE(s->buff, s->size);
	}
	s->buff[s->top++] = c;
	s->buff[s->top] = '\0';
}

char
str_get_char(String_t s) {
	assert(s->pos <= s->top);
	return s->buff[s->pos++];
}

bool
str_eq(String_t s1, String_t s2) {
	if (!(s1 && s2)) {
		return false;
	}
	for(size_t i=0; i < s1->top; i++) {
		if (s1->buff[i] != s2->buff[i]) {
			return false; // no need to check len because \0 term
		}
	}
	return true;
}

char *
str_as_c_string(String_t s) {
	return s->buff;
}

bool
str_is_empty(String_t s) {
	return s->top ==0;
}

void
str_cat(String_t dest, String_t src) {
	while(dest->size <= dest->top + src->top) {
		dest->buff = DOUBLE(dest->buff, dest->size);
	}
	for (size_t i = 0; i < src->top; i++ ) {
		dest->buff[dest->top++] = src->buff[i];
	}
	dest->buff[dest->top] = '\0';
}

String_t
str_cpy(String_t src) {
	String_t s = str_create();
	str_cat(s, src);
	return s;
}

String_t
str_from_c_string(char *c) {
	String_t s = str_create();
	for (size_t i = 0; c[i]; i++) {
		str_add_char(s, c[i]);
	}
	return s;
}

void
str_go_to_end(String_t s) {
	s->pos = s->top;
}
// a string_t storage mechanism
struct macro_list {
	size_t top;
	size_t size;
	String_t *lst;
};

typedef struct macro_list *M_list;
#define LST_SIZE (8)

M_list
ml_create(void) {
	M_list ml = malloc(sizeof(struct macro_list));
	ml->top = 0;
	ml->size = LST_SIZE;
	ml->lst = malloc(sizeof(String_t) * ml->size);

	return ml;
}

void
ml_destroy(M_list ml) {
	for (size_t i=0; i<ml->top; i++) {
		str_destroy(ml->lst[i]);
	}
	free(ml->lst);
	free(ml);
}

void
ml_add_macro(M_list ml, String_t name, String_t text) {
	if (ml->top+1 >= ml->size) {
		ml->size *=2; // safe bc min ml->size = 8
		ml->lst = realloc(ml->lst, sizeof(String_t)*ml->size);
	}
	ml->lst[ml->top++] = str_cpy(name);
	ml->lst[ml->top++] = str_cpy(text);
}

String_t
ml_get_macro_text(M_list ml, String_t name) {

	for (size_t i = 0; i < ml->top; i+=2) {
		if (str_eq(name, ml->lst[i])) {
			return ml->lst[i+1];
		}
	}
	return NULL;
}

void
ml_del_macro(M_list ml, String_t name) {
	bool built_in = false;
	bool deleted = false;

	for (size_t i=0; i< ml->top; i+=2) {
		if(str_eq(name, ml->lst[i])) {
			str_destroy(ml->lst[i]);
			str_destroy(ml->lst[i+1]);
			ml->lst[i] = NULL;
			ml->lst[i+1] = NULL;
			deleted = true;
		}
	}

	if (strcmp(str_as_c_string(name), "def") == 0 || 
	    strcmp(str_as_c_string(name), "undef") == 0 || 
	    strcmp(str_as_c_string(name), "if") == 0 || 
	    strcmp(str_as_c_string(name), "ifdef") == 0 || 
	    strcmp(str_as_c_string(name), "include") == 0 || 
	    strcmp(str_as_c_string(name), "expandafter") == 0 ) {

		built_in = true;
	}

	if (!deleted && built_in) {
		DIE("%s", "ERROR: cannot undefine built-in macro");
	} else if (!deleted && !built_in) {
		DIE("%s", "ERROR: cannot undefine non-existent macro");
	}
}

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

enum parse_states {PTEXT, ESC, MNAME, MARGS, MBRACE, MESC};
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
				switch (input) {
					case '\\':
						*state = MESC;
						break;

					case '{':
						*brace_balance += 1;
						str_add_char(m_args[*num_args], input);
						break;

					case '}':
						*brace_balance -= 1;
						str_add_char(m_args[*num_args], input);
						break;

					default:
						str_add_char(m_args[*num_args], input);
						break;
				}
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

		case MESC:
			str_add_char(m_args[*num_args], '\\');
			str_add_char(m_args[*num_args], input);
			*state = MARGS;
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
		String_t *m_args, M_func *eval_macro,
		int *brace_balance, int *num_args,
		String_t out) {

	int input;


	bool find_func = false;
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
					m_args, eval_macro,
					brace_balance, num_args,
					out);

			str_destroy(new_text);
		}
	}
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
	ml_del_macro(user_macros, args[1]);	
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

String_t 
exec_expandafter(M_list user_macros, String_t *args) {

	P_state state = malloc(sizeof(enum parse_states)); *state = PTEXT;
	String_t *m_args = malloc(sizeof(String_t)*5);
	for (int i = 0; i<5; i++) {
		m_args[i] = str_create();
	}

	M_func *eval_macro = malloc(sizeof(M_func));
	int *brace_balance = malloc(sizeof(int)); *brace_balance = 0;
	int *num_args = malloc(sizeof(int)); *num_args = -1;

	String_t after = str_create();

	parse_text(user_macros, state, args[1],
			m_args, eval_macro,
			brace_balance, num_args,
			after);

	String_t out = str_cpy(args[2]);
	str_cat(out, after);

	free(state);
	for(int i = 0; i<5; i++) {
		str_destroy(m_args[i]);
	}
	free(m_args);
	free(eval_macro);
	free(brace_balance);
	free(num_args);

	return out;
}

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
	} else if (strcmp(str_as_c_string(m_name), "expandafter") == 0)  {
		*f_ptr = &exec_expandafter;
		*n_args = 2;
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
	M_func *eval_macro = malloc(sizeof(M_func));
	int *brace_balance = malloc(sizeof(int)); *brace_balance = 0;
	int *num_args = malloc(sizeof(int)); *num_args = -1;

	String_t out = str_create();

	parse_text(user_macros, state, read,
			m_args, eval_macro,
			brace_balance, num_args,
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
	free(eval_macro);
	free(m_args);
	free(brace_balance);
	free(num_args);

	str_destroy(out);

	return 0;
}
