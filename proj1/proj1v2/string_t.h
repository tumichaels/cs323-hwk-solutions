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
