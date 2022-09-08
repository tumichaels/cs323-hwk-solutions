#include <stdlib.h>
#include <string.h>
#include <stdio.h>

int main() {
    char *a = malloc(5);
    a[0] = 'h';
    a[1] = 'e';
    a[2] = 'l';
    a[3] = 'l';
    a[4] = '\0';

    if (strcmp(a, "hell") == 0) {
        puts("it worked");
    } else {
        puts("it failed");
    }
}
