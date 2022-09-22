#define M61_DISABLE 1
#include "dmalloc.hh"
#include <cstdlib>
#include <cstring>
#include <cstdio>
#include <cinttypes>
#include <cassert>

// You may write code here.
// (Helper functions, types, structs, macros, globals, etc.)

typedef struct header {
	size_t sz;
	const char *file;
	long line;
	bool prev_free;
} Header;

unsigned long long nactive = 0;				// number of active allocations [#malloc - #free]
unsigned long long active_size = 0;			// number of bytes in active allocations
unsigned long long ntotal = 0;				// number of allocations, total
unsigned long long total_size = 0;			// number of bytes in allocations, total
unsigned long long nfail = 0;				// number of failed allocation attempts
unsigned long long fail_size = 0;			// number of bytes in failed allocation attempts
										
// TODO: there's a better way to deal with these
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
	if (__builtin_add_overflow(sz, sizeof(Header), &malloc_size)){
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
	Header *h = (Header *) out;
	h->sz = sz;
	h->file = file;
	h->line = line;

	nactive += 1;
	active_size += sz;
	ntotal += 1;
	total_size += sz;

	out = (Header *)out + 1; // actual address given to user 

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
		fprintf(stderr, "MEMORY BUG: %s: %ld: invalid free of pointer 0x%.*" PRIXPTR ", not in heap\n", 
				file, line, (int)sizeof(uintptr_t)*2, (uintptr_t)ptr);
		// fprintf(stderr, "\t%s: %ld: 0x%.*" PRIXPTR "is ")
		exit(1);

	}


	// successful free results
	size_t sz = ((Header *)ptr - 1)->sz;
	
	nactive -= 1;
	active_size -= sz;
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
}


/// dmalloc_print_heavy_hitter_report()
///    Print a report of heavily-used allocation locations.

void dmalloc_print_heavy_hitter_report() {
    // Your heavy-hitters code here
}
