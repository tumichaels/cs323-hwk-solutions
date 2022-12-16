#include "lib.h"
#include "malloc.h"

void process_main(void) {
	pid_t p = getpid();

	void *ptr = malloc(12);
	log_printf("the header contains\n\tsize: %d\n\tallocated", (char)((char *)ptr - 16), (char)((char *)ptr - 8));
}
