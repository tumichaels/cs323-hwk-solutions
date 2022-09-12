// creates a string_t struct which is a 
// custom char array class


struct string_t {
    size_t top;         // # of chars in string/position to add next char
    size_t buff_size;
    char *buff;
};

typedef struct string_t * String_t;

#define STR_SIZE (16)

// creates an empty String_t
String_t
str_create(void) {
    String_t s = malloc(sizeof (struct string_t));
    s->top = 0;
    s->buff_size = STR_SIZE;
    s->buff = malloc(s->buff_size);
    return s;
}

// frees a String_t
void
str_destroy(String_t s) {
    if (NULL == s) {
        return;
    }
    free(s->buff);
    free(s);
}

// adds a single char to a String_t
void
str_add_char(String_t s, char c) {
    if (s->top >= s->buff_size) {
        s->buff = DOUBLE(s->buff, s->buff_size);
    }
    s->buff[s->top] = c;
    s->top++;
}

// concatenates src into dest
void
str_cat(String_t dest, String_t src) {
    while(dest->buff_size <= dest->top + src->top) {
        dest->buff = DOUBLE(dest->buff, dest->buff_size);
    }
    for (size_t i = 0; i < src->top; i++) {
        dest->buff[dest->top] = src->buff[i];
        dest->top++;
    }
}

// returns number of chars in the String_t
int 
str_len(String_t s) {
    return s->top;
}

// assume you have a valid position
// get the char from that pos
char
str_get_char(String_t s, size_t pos) {
    assert(pos < s->top);
    return s->buff[pos];
}

// returns true if the buffers
// contain equal content up to
// top
//
// comparing to null pointer is always false
int
str_eq(String_t s1, String_t s2) {
    if (!(s1 && s2) || (s1->top != s2->top)) {
        return false;
    } else {
        for (size_t i = 0; i < s1->top; i++) {
            if (s1->buff[i] != s2->buff[i]) {
                return false;
            }
        }
        return true;
    }
}

// creates a c-string based on String_t s
char *
str_make_c_string(String_t s) {
    char *out = malloc(s->top + 1);
    for (int i = 0; i < s->top; i++) {
        out[i] = s->buff[i];
    }
    out[s->top] = '\0';
    return out;
}

int
str_is_empty(String_t s) {
    return s->top == 0;
}

String_t
str_cpy(String_t src) {
    String_t out = malloc(sizeof(struct string_t));
    out->top = src->top;
    out->buff_size = src->buff_size;
    out->buff = malloc(out->buff_size);

    for (size_t i = 0; i < out->top; i++) {
        out->buff[i] = src->buff[i];
    }
    return out;
}

void
str_print(String_t s) {
    for (size_t i = 0; i < s->top; i++) {
        putchar(s->buff[i]);
    }
}
