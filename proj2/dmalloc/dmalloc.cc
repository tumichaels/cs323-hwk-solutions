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
#define UCANARY(ptr) (*((unsigned long long *)ptr - 1))
#define HEAD(ptr) (*((Header *)(&UCANARY(ptr)) - 1))
#define OCANARY(ptr) (*((unsigned long long *)((uintptr_t)ptr + HEAD(ptr).sz)))

#define CANARY_SIZE sizeof(unsigned long long)

typedef struct header {
	// basic stats
	size_t sz;
	const char *file;
	long line;

	// alloc ll
	void *prev;
	void *next;

	// free protections
	bool freed;
	unsigned int present;
} Header;

void *last_allocd = 0x0;

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
	if (__builtin_add_overflow(sz, sizeof(Header) + 2*CANARY_SIZE, &malloc_size)){
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
	h->prev = last_allocd;
	h->next = NULL;
	h->freed = false;
	h->present = 0xdeadbeef;

	// start of returned block
	out = (void *)((uintptr_t)out + sizeof(Header) + CANARY_SIZE);

	// update ll
	if (h->prev)
		HEAD(h->prev).next = out;

	// set canaries
	UCANARY(out) = 0xdeadbeefdeadbeef;
	OCANARY(out) = 0xdeadbeefdeadbeef;

	// update stats
	last_allocd = out;
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
		fprintf(stderr, "MEMORY BUG: %s:%ld: invalid free of pointer 0x%" PRIxPTR ", not in heap\n", 
				file, line, (uintptr_t)ptr);
		// fprintf(stderr, "\t%s: %ld: 0x%.*" PRIXPTR "is ")
		exit(1);

	} else if (HEAD(ptr).freed) {
		fprintf(stderr, "MEMORY BUG: %s:%ld: invalid free of pointer 0x%" PRIxPTR ", double free\n", 
				file, line, (uintptr_t)ptr);
		exit(1);
	
	} else if (HEAD(ptr).present != 0xdeadbeef) {
		fprintf(stderr, "MEMORY BUG: %s:%ld: invalid free of pointer 0x%" PRIxPTR ", not allocated\n", 
				file, line, (uintptr_t)ptr);
		exit(1);
	} else {
		void *temp = last_allocd;
		while(temp) {
			if (temp == ptr) {
				break;
			}
			temp = HEAD(temp).prev;
		}
		if (temp == NULL) {
			fprintf(stderr, "MEMORY BUG: %s:%ld: invalid free of pointer 0x%" PRIxPTR ", not allocated\n", 
					file, line, (uintptr_t)ptr);
			exit(1);
		}
	}

	if (UCANARY(ptr) != 0xdeadbeefdeadbeef || OCANARY(ptr) != 0xdeadbeefdeadbeef) {
		fprintf(stderr, "MEMORY BUG: %s:%ld: detected wild write during free of pointer 0x%" PRIxPTR "\n", 
				file, line, (uintptr_t)ptr);
		exit(1);
	}

	// update header
	HEAD(ptr).freed = true;

	// update ll

	// update overall data 
	nactive -= 1;
	active_size -= HEAD(ptr).sz;
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
