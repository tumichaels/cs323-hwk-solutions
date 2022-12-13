#include "malloc.h"

// size and alignment macros
#define	ALIGNMENT 16
#define ALIGN(size) (((size) + (ALIGNMENT - 1)) & ~(ALIGNMENT - 1))

#define CHUNK_SIZE (1 << 6)
#define CHUNK_ALIGN(size) (((size) + (CHUNK_SIZE - 1)) & ~(CHUNK_SIZE - 1)) // allocate blocks in multiple of CHUNK_SIZE

#define OVERHEAD (sizeof(block_header) + sizeof(block_footer))

// macros for working with raw pointer
#define GET_SIZE(p) ((block header *) (p))->size
#define GET_ALLOC(p) ((block header *) (p))->allocated

// macros for working with payload pointers
#define HDRP(bp) ((char *) (bp) - sizeof(block_header))
#define NEXT_BLKP(bp) ((char *) (bp) + GET_SIZE(HDRP(bp)))

#define FTRP(bp) ((char *)(bp) + GET_SIZE(HDRP(bp)) - OVERHEAD)
#define PREV_BLKP(bp) ((char *)(bp) - GET_SIZE((char *)(bp) - OVERHEAD))

// macros for working with a free pointer <-- free pointers are payload pointers
// do i really need this double cast?
#define NEXT_FPTR(bp) ((void *)((char *)(bp)))
#define PREV_FPTR(bp) ((void *)((char *)(bp) + sizeof(char *)))

void *first_block_payload;
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
// of memory. If I had some more time / motivation / reward, I would diefinitely
// want to try and optimize this bs
void heap_init(void) {
	sbrk(sizeof(block_header));
	first_block_payload = sbrk(sizeof(block_footer));

	// this sets up the prologue block (prologue block has size=OVERHEAD)
	GET_SIZE(HDRP(first_block_payload)) = OVERHEAD;
	GET_ALLOC(HDRP(first_block_payload)) = 1;
	GET_SIZE(FTRP(first_block_payload)) = OVERHEAD;

	sbrk(CHUNK_SIZE);
	free_list = NEXT_BLKP(first_block_payload);

	// set up that first free block
	// TODO: pointers in the free blocks
	GET_SIZE(HDRP(free_list)) = CHUNK_SIZE; 
	GET_ALLOC(HDRP(free_list)) = 0;
	NEXT_FPTR(free_list) = NULL;
	PREV_FPTR(free_list) = NULL;	
	GET_SIZE(FTRP(free_list)) = CHUNK_SIZE;

	// set up the terminal block
	sbrk(sizeof(block_header));
	GET_SIZE(NEXT_BLKP(free_list)) = 0;
	GET_ALLOC(NEXT_BLKP(free_list)) = 1;
}

void free(void *firstbyte) {
	return;
}


// extend is called when you don't have a free block big enough
void extend(size_t new_size) {
	size_t aligned_size = CHUNK_ALIGN(new_size);	
	void *bp = sbrk(aligned_size);

	GET_SIZE(HDRP(bp)) = chunk_size;

}


void *malloc(uint64_t numbytes) {
	

    return NULL;
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
