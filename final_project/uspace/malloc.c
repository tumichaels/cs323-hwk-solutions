#include "malloc.h"

// size and alignment macros
#define	ALIGNMENT 16 // every address is 16 byte aligned, it's also my word sizw
#define ALIGN(size) (((size) + (ALIGNMENT - 1)) & ~(ALIGNMENT - 1))

#define MIN_PAYLOAD_SIZE 32

#define CHUNK_SIZE (1 << 14)
#define CHUNK_ALIGN(size) (((size) + (CHUNK_SIZE - 1)) & ~(CHUNK_SIZE - 1)) // request memory in multiples of CHUNK_SIZE

#define OVERHEAD (sizeof(block_header))

// macros for working with raw pointer
#define GET_SIZE(p) ((block_header *) (p))->size
#define GET_ALLOC(p) ((block_header *) (p))->allocated

// macros for working with payload pointers
#define HDRP(bp) ((char *) (bp) - sizeof(block_header))
#define NEXT_BLKP(bp) ((char *) (bp) + GET_SIZE(HDRP(bp)))

#define FTRP(bp) ((char *)(bp) + GET_SIZE(HDRP(bp)) - sizeof(block_header) - sizeof(block_footer))
#define PREV_BLKP(bp) ((char *)(bp) - GET_SIZE((char *)(bp) - OVERHEAD))

// macros for working with a free pointer <-- free pointers are payload pointers
//	do i really need this double cast?
#define NEXT_FPTR(bp) (*((char **)(bp)))
#define PREV_FPTR(bp) (*((char **)(bp + sizeof(void *))))

int initialized_heap;

void *prologue_block;
void *free_list;

typedef struct {
	size_t size;
	int allocated;
} block_header;

typedef struct {
	size_t size;
	int filler;
} block_footer;

// annoyingly, even with lazy allocation, or perhaps because of it, the moment
// we start filling out the headers, we instantly use up the entire page worth
// of memory. If I had some more time / motivation / reward, I would definitely
// want to try and optimize this 
void heap_init(void) {

	// prologue block
	sbrk(sizeof(block_header));
	prologue_block = sbrk(sizeof(block_footer));

	GET_SIZE(HDRP(prologue_block)) = sizeof(block_header) + sizeof(block_footer);
	GET_ALLOC(HDRP(prologue_block)) = 1;
	GET_SIZE(FTRP(prologue_block)) = sizeof(block_header) + sizeof(block_footer);

	// terminal block
	sbrk(sizeof(block_header));
	GET_SIZE(HDRP(NEXT_BLKP(prologue_block))) = 0;
	GET_ALLOC(HDRP(NEXT_BLKP(prologue_block))) = 0;

	free_list = NULL;

	initialized_heap = 1;
}

void free(void *firstbyte) {
	return;
}

// extend is called when you don't have a free block big enough
//	we call extend inside malloc, so it should only ever be
//	called with new_size >= MIN_PAYLOAD_SIZE 
//
//	the reason alloating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
void extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
	void *bp = sbrk(chunk_aligned_size);

	// setup pointer
	GET_SIZE(HDRP(bp)) = chunk_aligned_size;
	GET_ALLOC(HDRP(bp)) = 0;
	NEXT_FPTR(bp) = free_list;	
	PREV_FPTR(bp) = NULL;
	GET_SIZE(FTRP(bp)) = chunk_aligned_size;

	// add to head of free_list
	if (free_list)
		PREV_FPTR(free_list) = bp;
	free_list = bp;

	// update terminal block
	GET_SIZE(HDRP(NEXT_BLKP(bp))) = 0;
	GET_ALLOC(HDRP(NEXT_BLKP(bp))) = 1;
	panic("huh");
}

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
		GET_SIZE(HDRP(bp)) = size;
		void *leftover_mem_ptr = NEXT_BLKP(bp);

		GET_SIZE(HDRP(leftover_mem_ptr)) = extra_size;
		GET_ALLOC(HDRP(leftover_mem_ptr)) = 0;

		// add pointers to previous and next free block
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp);
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
	
		GET_SIZE(FTRP(leftover_mem_ptr)) = extra_size;

		// update the pointers in previous and next free block to the leftover, as long as they aren't null
		if (PREV_FPTR(bp))
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
		if (NEXT_FPTR(bp))
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
	}
	else {
		// remove this segement of the list entirely
		if (PREV_FPTR(bp))
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
		if (NEXT_FPTR(bp))
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
	}
	
	GET_ALLOC(HDRP(bp)) = 1;
}

void *malloc(uint64_t numbytes) {
	if (!initialized_heap)
		heap_init();

	if (numbytes == 0)
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);

	void *bp = free_list;
	while (bp) {
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
			set_allocated(bp, aligned_size);
			return bp;
		}

		bp = NEXT_FPTR(bp);
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0) - OVERHEAD;
	extend(aligned_size);
	set_allocated(bp, aligned_size);
    return bp;
}

void *calloc(uint64_t num, uint64_t sz) {
    return 0;
}

void *realloc(void * ptr, uint64_t sz) {
    return 0;
}

void defrag() {
}

int heap_info(heap_info_struct * info) {
    return 0;
}
