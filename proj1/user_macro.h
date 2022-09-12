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

bool
ml_del_macro(M_list ml, String_t name) {
    for (size_t i=0; i< ml->top; i+=2)
        if(str_eq(name, ml->lst[i])) {
            str_destroy(ml->lst[i]);
            str_destroy(ml->lst[i+1]);
            ml->lst[i] = NULL;
            ml->lst[i+1] = NULL;
            return true;
        }
    return false;
}
