// list for user defined macros:
// the name of the macro is in
// the 2*i position and its 
// text is in the 2*i+1 
// position

struct macro_list {
    // number of macro/text pairs
    size_t top;
    size_t size;
    String_t *lst;
};

typedef struct macro_list *Macro_list;
#define LST_SIZE (8)

Macro_list
ml_create(void) {
    Macro_list ml = malloc(sizeof(struct macro_list));
    ml->top = 0;
    ml->size = LST_SIZE;
    ml->lst = malloc(sizeof(String_t) * ml->size);
    return ml;
}

void 
ml_destroy(Macro_list ml) {
    for (size_t i = 0; i < ml->top; i++) {
        str_destroy(ml->lst[i]);
    }
    free(ml->lst);
    free(ml);
}

void
ml_add_macro(Macro_list ml, String_t name, String_t txt) {
    if (ml->top + 2 > ml->size){
        ml->size *= 2;
        ml->lst = realloc(ml->lst, sizeof(String_t) * ml->size);
    }
    // could condense into top++ for both
    ml->lst[ml->top] = str_cpy(name);
    ml->lst[ml->top+1] = str_cpy(txt);
    ml->top += 2;
}

int
ml_check_macro_exists(Macro_list ml, String_t name) {
    for (size_t i = 0; i < ml->top; i+=2) {
        if (str_eq(name, ml->lst[i])) {
            return true;
        }
    }
    return false;
}

int
ml_del_macro(Macro_list ml, String_t name) {
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
