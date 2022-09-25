#define M61_DISABLE 1
#include "dmalloc.hh"
#include <cstdlib>
#include <cstring>
#include <cstdio>
#include <cinttypes>
#include <cassert>

// You may write code here.
// (Helper functions, types, structs, macros, globals, etc.)

// these macro funcs act on the ptr provided to the user 
#define OFFSET 256
#define UCANARY(ptr) (*((size_t *)ptr - 1))
#define HEAD(ptr) (*((Header *)((uintptr_t)&UCANARY(ptr) - OFFSET) - 1))
#define OCANARY(ptr) (*((size_t *)((uintptr_t)ptr + HEAD(ptr).sz)))

#define CANARY_SIZE sizeof(size_t)
#define CANARY_VAL 0xdeadbeefdeadbeef 
#define PRESENT_VAL 0xbeadbabebeadbabe

typedef struct header {
	// basic stats
	size_t sz;
	const char *file;
	long line;

	// alloc ll
	void *prev;
	void *self;
	void *next;

	// free protections
	bool freed;
	size_t present;
} Header;

void *last_active = 0x0;

unsigned long long nactive = 0;				// number of active allocations [#malloc - #free]
unsigned long long active_size = 0;			// number of bytes in active allocations
unsigned long long ntotal = 0;				// number of allocations, total
unsigned long long total_size = 0;			// number of bytes in allocations, total
unsigned long long nfail = 0;				// number of failed allocation attempts
unsigned long long fail_size = 0;			// number of bytes in failed allocation attempts
uintptr_t heap_min = 0;						// smallest address in any region ever allocated
uintptr_t heap_max = 0;						// largest address in any region ever allocated

/// dmalloc_malloc(sz, file, line)
///    Return a pointer to `sz` bytes of newly-allocated dynamic memory.
///    The memory is not initialized. If `sz == 0`, then dmalloc_malloc must
///    return a unique, newly-allocated pointer value. The allocation
///    request was at location `file`:`line`.

void* dmalloc_malloc(size_t sz, const char* file, long line) {
    (void) file, (void) line;   // avoid uninitialized variable warnings
    // Your code here.

	void *out;

	// src stack overflow: https://tinyurl.com/43kkycew
	size_t malloc_size;
	if (__builtin_add_overflow(sz, sizeof(Header)+ OFFSET + 2*CANARY_SIZE, &malloc_size)){
		out = NULL;
	} else {
		out = base_malloc(malloc_size);
	}

	if (out == NULL) {
		nfail += 1;
		fail_size += sz;
		return out;
	}

	// fill out the header 
	Header* h = (Header *)out;
	h->sz = sz;
	h->file = file;
	h->line = line;
	h->prev = last_active;
	h->self = NULL;
	h->next = NULL;
	h->freed = false;
	h->present = PRESENT_VAL;

	// start of returned block
	out = (void *)((uintptr_t)out + sizeof(Header) + OFFSET + CANARY_SIZE);

	// update ll and last_active
	if (h->prev)
		HEAD(h->prev).next = out;
	h->self = out;
	last_active = out;

	// set canaries
	UCANARY(out) = CANARY_VAL;
	OCANARY(out) = CANARY_VAL;

	// update stats
	nactive += 1;
	active_size += sz;
	ntotal += 1;
	total_size += sz;

	if (ntotal == 1) {
		heap_min = (uintptr_t) out;
		heap_max = (uintptr_t) out + sz;
	} else if ((uintptr_t) out < heap_min) {
		heap_min = (uintptr_t) out;
	} else if ((uintptr_t) out + sz > heap_max) {
		heap_max = (uintptr_t) out + sz;
	}

    return out; 
}


/// dmalloc_free(ptr, file, line)
///    Free the memory space pointed to by `ptr`, which must have been
///    returned by a previous call to dmalloc_malloc. If `ptr == NULL`,
///    does nothing. The free was called at location `file`:`line`.

void dmalloc_free(void* ptr, const char* file, long line) {
    (void) file, (void) line;   // avoid uninitialized variable warnings
    // Your code here.
	
	
	if (ptr == NULL)
		return;

	// valid ptr checks
	if ((uintptr_t)ptr < heap_min || (uintptr_t)ptr > heap_max) {
		fprintf(stdout, "MEMORY BUG: %s:%ld: invalid free of pointer %p, not in heap\n", 
				file, line, ptr);
		// additional error message about outside of heap free 
		exit(1);

	} else if (HEAD(ptr).freed) {
		fprintf(stdout, "MEMORY BUG: %s:%ld: invalid free of pointer %p, double free\n", 
				file, line, ptr);
		exit(1);
	
	} else if (HEAD(ptr).present != PRESENT_VAL|| HEAD(ptr).self != ptr) {
		fprintf(stdout, "MEMORY BUG: %s:%ld: invalid free of pointer %p, not allocated\n", 
				file, line, ptr);

		void *temp = last_active;
		assert(temp);
		while (temp){
			if ((uintptr_t)temp < (uintptr_t)ptr && (uintptr_t)ptr < (uintptr_t)temp + HEAD(temp).sz) {
				fprintf(stdout, "  %s:%ld: %p is %zu bytes inside a %zu byte region allocated here", 
						HEAD(temp).file, HEAD(temp).line, ptr, (uintptr_t)ptr - (uintptr_t)temp, HEAD(temp).sz);
				exit(1);
			}
			temp = HEAD(temp).prev;
		}
		fprintf(stdout, "%s:%ld: %p is outside of any allocated block\n", 
				file, line, ptr); 
		exit(1);
	}

	if (UCANARY(ptr) != CANARY_VAL || OCANARY(ptr) != CANARY_VAL) {
		fprintf(stdout, "MEMORY BUG: %s:%ld: detected wild write during free of pointer %p\n", 
				file, line, ptr);
		exit(1);
	}

	// update ll and last active
	if (HEAD(ptr).prev) 
		HEAD(HEAD(ptr).prev).next = HEAD(ptr).next;
	if (HEAD(ptr).next) 
		HEAD(HEAD(ptr).next).prev = HEAD(ptr).prev;
	if (ptr == last_active) {
		assert(HEAD(ptr).next == NULL);
		last_active = HEAD(ptr).prev;
	}

	// modify the header
	HEAD(ptr).freed = true;

	// update overall data 
	nactive -= 1;
	active_size -= HEAD(ptr).sz;

	base_free(&HEAD(ptr));
}


/// dmalloc_calloc(nmemb, sz, file, line)
///    Return a pointer to newly-allocated dynamic memory big enough to
///    hold an array of `nmemb` elements of `sz` bytes each. If `sz == 0`,
///    then must return a unique, newly-allocated pointer value. Returned
///    memory should be initialized to zero. The allocation request was at
///    location `file`:`line`.

void* dmalloc_calloc(size_t nmemb, size_t sz, const char* file, long line) {
	size_t malloc_size;
	if (__builtin_mul_overflow(nmemb, sz, &malloc_size)) {
		nfail += 1;
		fail_size += malloc_size;
		return NULL;
	}

	void* ptr = dmalloc_malloc(nmemb * sz, file, line);
    if (ptr) {
        memset(ptr, 0, nmemb * sz);
    }
    return ptr;
}


/// dmalloc_get_statistics(stats)
///    Store the current memory statistics in `*stats`.

void dmalloc_get_statistics(dmalloc_statistics* stats) {
    // Stub: set all statistics to enormous numbers
    memset(stats, 255, sizeof(dmalloc_statistics));
	stats->nactive = nactive;
	stats->active_size = active_size;
	stats->ntotal = ntotal;
	stats->total_size = total_size;
	stats->nfail = nfail;
	stats->fail_size = fail_size;
	stats->heap_min = heap_min;
	stats->heap_max = heap_max;
}


/// dmalloc_print_statistics()
///    Print the current memory statistics.

void dmalloc_print_statistics() {
    dmalloc_statistics stats;
    dmalloc_get_statistics(&stats);

    printf("alloc count: active %10llu   total %10llu   fail %10llu\n",
           stats.nactive, stats.ntotal, stats.nfail);
    printf("alloc size:  active %10llu   total %10llu   fail %10llu\n",
           stats.active_size, stats.total_size, stats.fail_size);
}


/// dmalloc_print_leak_report()
///    Print a report of all currently-active allocated blocks of dynamic
///    memory.

void dmalloc_print_leak_report() {
    // Your code here.
	void *temp = last_active;
	while(temp) {
		fprintf(stdout, "LEAK CHECK: %s:%ld: allocated object %p with size %zu\n", 
				HEAD(temp).file, HEAD(temp).line, temp, HEAD(temp).sz);
		temp = HEAD(temp).prev;
	}
}


/// dmalloc_print_heavy_hitter_report()
///    Print a report of heavily-used allocation locations.

void dmalloc_print_heavy_hitter_report() {
    // Your heavy-hitters code here
	
	Header loc_lst[5];
	memset(loc_lst, 0, sizeof(Header)*5);

	size_t sub_count = 0;

	void *block = last_active;
	while (block) {
		Header loc = HEAD(block);

		size_t loc_lst_min = loc_lst[0].sz;
		int i;
		for (i=0; i<5; i++) {
			if (loc_lst[i].sz < loc_lst_min)
				loc_lst_min = loc_lst[i].sz;
			if (loc_lst[i].file == NULL) {
				loc_lst[i] = loc;
				break;
			} else if (loc_lst[i].file == loc.file && loc_lst[i].line == loc.line) {
				loc_lst[i].sz += loc.sz; // no overflow bc its not actually likely
				break;
			}
		}

		if (i == 5) {
			sub_count += loc_lst_min;
			for (int j = 0; j<5; j++) {
				// negative or 0
				if (__builtin_sub_overflow(loc_lst[j].sz, loc_lst_min, &(loc_lst[j].sz))) {
					memset(&(loc_lst[j]), 0, sizeof(Header));
					i = j; // this is a free spot
				}	
			}

			if (__builtin_sub_overflow(loc.sz, loc_lst_min, &(loc_lst[i].sz))) {
				loc_lst[i].sz = 0;
			} else {
				loc_lst[i] = loc;
				loc_lst[i].sz -= loc_lst_min;
			}
		}

		block = HEAD(block).prev;
	}

	for (int i = 4; i>=0; i--){
		for(int j = 0; j<i; j++) {
			if (loc_lst[j].sz < loc_lst[j+1].sz) {
				// swap
				Header temp = loc_lst[j];
				loc_lst[j] = loc_lst[j+1];
				loc_lst[j+1] = temp;
			}
		}
	}

	for (int i=0; i<5; i++) {
		if ((float)(loc_lst[i].sz)/active_size < 0.2) {
			break;
		}
		printf("HEAVY HITTER: %s:%ld: %zu (~%.2f%%)\n",
			   loc_lst[i].file, loc_lst[i].line, loc_lst[i].sz, (float)(loc_lst[i].sz)/active_size * 100);
	}
}
