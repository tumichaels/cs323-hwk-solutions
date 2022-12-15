#include "lib.h"
#include "malloc.h"


#define ALLOC_SLOWDOWN 100
#define MAX_ALLOC 100
extern uint8_t end[];

uint8_t *heap_top;
uint8_t *heap_bottom;
uint8_t *stack_bottom;

char s[1000];
void process_main(void) {
    pid_t p = getpid();
    srand(p);
    heap_bottom = heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);

    /* Single elements on heap of varying sizes */
//    for(int i = 1; i < 64; ++i) {
//        for(int j = 1; j < 64; ++j) {
//            void *ptr = calloc(i,j);
//            assert(ptr != NULL);
//
//            for(int k = 0; k < i*j; ++k) {
//                assert(((char *)ptr)[k] == 0);
//            }
//
//            free(ptr);
//        }
//        defrag();
//    }
    

//    void *ptr = malloc(PAGESIZE);
//    malloc(PAGESIZE);
//    malloc(PAGESIZE);
//    ptr = malloc(PAGESIZE);
//    *((int*)ptr) = 1;
//	
//    if ((*((size_t *)((uintptr_t)ptr - 8)) & ~0xF ) == (0x50))
//	    panic("success!");
//

	mem_tog(0);
	void *ptr1 = malloc(8);
	void *ptr2 = malloc(16);
	void *ptr3 = malloc(24);

	struct heap_info_struct s1;
	heap_info(&s1);

	app_printf(0x700, "number of allocs: %d\n", s1.num_allocs);
	app_printf(0x700, "alloc list: \n");
	for (int i = 0; i < s1.num_allocs; i++) {
		app_printf(0x700, "    alloc'd region %d: %p    size: 0x%lx\n", i+1, s1.ptr_array[i], s1.size_array[i]);
	}
	

    TEST_PASS();
}
