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
#define META(ptr) (*((Meta *)((uintptr_t)ptr - OFFSET - sizeof(size_t)) - 1))
#define SENTINEL(ptr) (*((size_t *)((uintptr_t)ptr - OFFSET - sizeof(size_t))))
#define OCANARY(ptr) (*((size_t *)((uintptr_t)ptr + META(ptr)->sz)))

#define CANARY_SIZE sizeof(unsigned long long)
#define CANARY_VAL 0xdeadbeefdeadbeef // on 32 bit, it's trimmed to deadbeef

#define UNFREED_VAL 0xbeadbabebeadbabe
#define SENTINEL_VAL 0xfadedeaffadedeaf

struct meta {
	// basic stats
	size_t sz;
	const char *file;
	long line;

	// alloc ll
	void *prev;
	void *self;
	void *next;

	// free protections
	size_t freed;
};
typedef struct meta *Meta;

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
	Meta m;

	// src stack overflow: https://tinyurl.com/43kkycew
	size_t malloc_size;
	if (__builtin_add_overflow(sz, sizeof(Meta) + OFFSET + 2*CANARY_SIZE, &malloc_size)){
		out = NULL;
		m = NULL;
	} else {
		out = base_malloc(malloc_size);
		m = (Meta)base_malloc(sizeof(struct meta));
	}

	if (out == NULL || m == NULL) {
		nfail += 1;
		fail_size += sz;
		return out;
	}

	// fill out the metadata 
	m->sz = sz;
	m->file = file;
	m->line = line;
	m->prev = last_active;
	m->self = NULL;
	m->next = NULL;
	m->freed = UNFREED_VAL;

	// load metadata address into leading portion of out
	*(Meta *)out = m;

	// start of returned block
	out = (void *)((uintptr_t)out + sizeof(Meta) + OFFSET + CANARY_SIZE);

	// set canaries and sentinel
	SENTINEL(out) = SENTINEL_VAL;
	UCANARY(out) = CANARY_VAL;
	OCANARY(out) = CANARY_VAL;

	// update ll and last_active
	if (m->prev)
		META(m->prev)->next = out;
	m->self = out;
	last_active = out;

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

	} else if (SENTINEL(ptr) != SENTINEL_VAL) {
		void *temp = last_active;
		assert(temp);

		while (temp){
			if (ptr == temp) {
				break;
			} else if ((uintptr_t)temp < (uintptr_t)ptr && (uintptr_t)ptr < (uintptr_t)temp + META(temp)->sz) {
				fprintf(stdout, "MEMORY BUG: %s:%ld: invalid free of pointer %p, not allocated\n", 
						file, line, ptr);
				fprintf(stdout, "  %s:%ld: %p is %zu bytes inside a %zu byte region allocated here\n", 
						META(temp)->file, META(temp)->line, ptr, (uintptr_t)ptr - (uintptr_t)temp, META(temp)->sz);
				exit(1);
			}
			temp = META(temp)->prev;
		}

		if (temp == NULL) {
			fprintf(stdout, "%s:%ld: %p is outside of any allocated block\n", 
					file, line, ptr); 
			exit(1);
		}

	} else if (META(ptr)->freed != UNFREED_VAL) {
		fprintf(stdout, "MEMORY BUG: %s:%ld: invalid free of pointer %p, double free\n", 
				file, line, ptr);
		exit(1);
	}

	if (UCANARY(ptr) != CANARY_VAL || OCANARY(ptr) != CANARY_VAL) {
		fprintf(stdout, "MEMORY BUG: %s:%ld: detected wild write during free of pointer %p\n", 
				file, line, ptr);
		exit(1);
	}

	// update ll and last active
	if (META(ptr)->prev) 
		META(META(ptr)->prev)->next = META(ptr)->next;
	if (META(ptr)->next) 
		META(META(ptr)->next)->prev = META(ptr)->prev;
	if (ptr == last_active) {
		assert(META(ptr)->next == NULL);
		last_active = META(ptr)->prev;
	}

	// modify the metadata
	META(ptr)->freed = 0x0;

	// update overall data 
	nactive -= 1;
	active_size -= META(ptr)->sz;

	// free the pointer and its metadata
	base_free(ptr);
	base_free(META(ptr));
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
				META(temp)->file, META(temp)->line, temp, META(temp)->sz);
		temp = META(temp)->prev;
	}
}


/// dmalloc_print_heavy_hitter_report()
///    Print a report of heavily-used allocation locations.

void dmalloc_print_heavy_hitter_report() {
	// Your heavy-hitters code here
}
