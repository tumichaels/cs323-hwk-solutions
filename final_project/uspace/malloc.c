#include "malloc.h"

// size and alignment macros
#define	ALIGNMENT 16 // every address is 16 byte aligned, it's also my word sizw
#define ALIGN(size) (((size) + (ALIGNMENT - 1)) & ~(ALIGNMENT - 1))

#define MIN_PAYLOAD_SIZE 32

#define CHUNK_SIZE (1 << 14)
#define CHUNK_ALIGN(size) (((size) + (CHUNK_SIZE - 1)) & ~(CHUNK_SIZE - 1)) // request memory in multiples of CHUNK_SIZE

#define OVERHEAD (sizeof(block_header))

// macros for working with raw pointer
#define GET_SIZE(p) ((block header *) (p))->size
#define GET_ALLOC(p) ((block header *) (p))->allocated

// macros for working with payload pointers
#define HDRP(bp) ((char *) (bp) - sizeof(block_header))
#define NEXT_BLKP(bp) ((char *) (bp) + GET_SIZE(HDRP(bp)))

#define FTRP(bp) ((char *)(bp) + GET_SIZE(HDRP(bp)) - OVERHEAD)
#define PREV_BLKP(bp) ((char *)(bp) - GET_SIZE((char *)(bp) - OVERHEAD))

// macros for working with a free pointer <-- free pointers are payload pointers
//	do i really need this double cast?
#define NEXT_FPTR(bp) (*(bp))
#define PREV_FPTR(bp) (*(bp + sizeof(void *)))

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
// want to try and optimize this 
void heap_init(void) {
	sbrk(sizeof(block_header));
	first_block_payload = sbrk(sizeof(block_footer));

	// this sets up the prologue block 
	GET_SIZE(HDRP(first_block_payload)) = sizeof(block_header) + sizeof(block_footer);
	GET_ALLOC(HDRP(first_block_payload)) = 1;
	GET_SIZE(FTRP(first_block_payload)) = sizeof(block_header) + sizeof(block_footer);

	sbrk(OVERHEAD + MIN_PAYLOAD_SIZE);
	free_list = NEXT_BLKP(first_block_payload);

	// set up that first free block
	// TODO: pointers in the free blocks
	GET_SIZE(HDRP(free_list)) = CHUNK_SIZE; 
	GET_ALLOC(HDRP(free_list)) = 0;
	NEXT_FPTR(free_list) = FTRP(free_list) + sizeof(block_footer) + sizeof(block_header); // the terminal block
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
//	we call extend inside malloc, so it should only ever be
//	called with new_size >= MIN_PAYLOAD_SIZE 
void extend(size_t new_size) {
	size_t aligned_size = CHUNK_ALIGN(new_size);	
	void *bp = sbrk(aligned_size);

	GET_SIZE(HDRP(bp)) = chunk_size;
	GET_ALLOC(HDRP(bp)) = 0;

	GET_SIZE(HDRP(NEXT_BLKP(bp))) = 0;
	GET_ALLOC(HDRP(NEXT_BLKP(bp))) = 1;
}

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
		GET_SIZE(HDRP(bp)) = size;
		GET_SIZE(HDRP(NEXT_BLKP(bp))) = extra_size;
		GET_ALLOC(HDRP(NEXT_BLKP(bp))) = 0;
		NEXT_FPTR(NEXT_BLKP(bp)) = NEXT_FPTR(bp);
		PREV_FPTR(NEXT_BLKP(bp)) = PREV_FPTR(bp);
		GET_SIZE(FTRP(NEXT_BLKP(bp))) = extra_size;
	}

	GET_ALLOC(HDRP(bp)) = 1;
}

void *malloc(uint64_t numbytes) {
	if (numbytes == 0)
		return NULL;

	int aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
						? OVERHEAD + MIN_PAYLOADSIZE 
						: ALIGN(numbytes + OVERHEAD);

	void *bp = free_list;
	while (GET_SIZE(HDRP(bp)) != 0) {
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
			set_allocated(bp, aligned_size);
			return bp;
		}
		bp = NEXT_FPTR(bp);
	}

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
