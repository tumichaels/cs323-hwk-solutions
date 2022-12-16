#include "malloc.h"

// size and alignment macros
#define	ALIGNMENT 16 // every address is 16 byte aligned, 
#define ALIGN(size) (((size) + (ALIGNMENT - 1)) & ~(ALIGNMENT - 1))

#define MIN_PAYLOAD_SIZE 24	// 16 bytes for 2 addresses, 8 bytes for footer

#define CHUNK_SIZE (1 << 14)
#define CHUNK_ALIGN(size) (((size) + (CHUNK_SIZE - 1)) & ~(CHUNK_SIZE - 1)) // request memory in multiples of CHUNK_SIZE

#define OVERHEAD (sizeof(block_header))

// macros for working with raw pointer
#define GET(p) (*(size_t *)(p))

#define GET_ALLOC(p) (GET(p) & 0x1)		// by packing these more densely, this is becomes a value
#define GET_SIZE(p) (GET(p) & ~0xF)

#define PUT(p, val) (GET(p) = (val))	// these help us set the size and alloc
#define PACK(size, alloc) ((size) | (alloc))

// macros for working with payload pointers
#define HDRP(bp) ((char *) (bp) - sizeof(block_header))
#define NEXT_BLKP(bp) ((char *) (bp) + GET_SIZE(HDRP(bp)))

// you'll use these on payload pointers, but they're only meaningful on free pointers
#define FTRP(bp) ((char *)(bp) + GET_SIZE(HDRP(bp)) - sizeof(block_header) - sizeof(block_footer))
#define PREV_BLKP(bp) ((char*)(bp) - GET_SIZE(HDRP(bp) - sizeof(block_footer)))


// macros for working with a free pointer <-- free pointers are payload pointers
//	do i really need this double cast?
#define NEXT_FPTR(bp) (*((char **)(bp)))
#define PREV_FPTR(bp) (*((char **)(bp + sizeof(void *))))

int initialized_heap;

void *prologue_block;
void *free_list;

typedef size_t block_header;
typedef size_t block_footer;

size_t num_allocs;

// annoyingly, even with lazy allocation, or perhaps because of it, the moment
// we start filling out the headers, we instantly use up the entire page worth
// of memory. If I had some more time / motivation / reward, I would definitely
// want to try and optimize this 
void heap_init(void) {

	// prologue block
	sbrk(sizeof(block_header) + sizeof(block_header));
	prologue_block = sbrk(sizeof(block_footer));
	PUT(HDRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
	PUT(FTRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	

	// terminal block
	sbrk(sizeof(block_header));
	PUT(HDRP(NEXT_BLKP(prologue_block)), PACK(0, 1));	

	free_list = NULL;

	initialized_heap = 1;
}

void free(void *firstbyte) {
	if (firstbyte == NULL)
		return;

	// setup free things: alloc, list ptrs, footer
	PUT(HDRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
	NEXT_FPTR(firstbyte) = free_list;
	PREV_FPTR(firstbyte) = NULL;
	PUT(FTRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	

	// add to free_list
	PREV_FPTR(free_list) = firstbyte;
	free_list = firstbyte;

	num_allocs--;

	return;
}

// extend is called when you don't have a free block big enough
//	we call extend inside malloc, so it should only ever be
//	called with new_size >= MIN_PAYLOAD_SIZE 
//
//	the reason allocating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
int extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
	void *bp = sbrk(chunk_aligned_size);
	if (bp == (void *)-1)
		return -1;

	// setup pointer
	PUT(HDRP(bp), PACK(chunk_aligned_size, 0));	
	NEXT_FPTR(bp) = free_list;	
	PREV_FPTR(bp) = NULL;
	PUT(FTRP(bp), PACK(chunk_aligned_size, 0));	
	
	// add to head of free_list
	if (free_list)
		PREV_FPTR(free_list) = bp;
	free_list = bp;

	// update terminal block
	PUT(HDRP(NEXT_BLKP(bp)), PACK(0, 1));	

	return 0;
}

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
		PUT(HDRP(bp), PACK(size, 1));

		void *leftover_mem_ptr = NEXT_BLKP(bp);

		PUT(HDRP(leftover_mem_ptr), PACK(extra_size, 0));	
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp); // pointers to the next free blocks
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
		PUT(FTRP(leftover_mem_ptr), PACK(extra_size, 0));	

		// update the free list
		if (free_list == bp)
			free_list = leftover_mem_ptr;

		if (PREV_FPTR(bp))
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp

		if (NEXT_FPTR(bp))
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
								    
	}
	else {
		// update the free list
		if (free_list == bp)
			free_list = NEXT_FPTR(bp);

		if (PREV_FPTR(bp))
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
		if (NEXT_FPTR(bp))
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 

		PUT(HDRP(bp), PACK(GET_SIZE(HDRP(bp)), 1));	
	}
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
			num_allocs++;
			return bp;
		}

		bp = NEXT_FPTR(bp);
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	if (extend(aligned_size)) {
		return NULL;
	}
	set_allocated(bp, aligned_size);
	num_allocs++;
    return bp;
}

void *calloc(uint64_t num, uint64_t sz) {
	void *bp = malloc(num * sz);
	if (bp)							// protect against num=0 or size=0 or just no memory
		memset(bp, 0, num * sz);
	return bp;
}

void *realloc(void *ptr, uint64_t sz) {
	if (ptr == NULL && sz == 0) {
		return NULL;
	}
	else if (ptr != NULL && sz == 0) {
		free(ptr);
		return NULL;
	}
	else if (ptr == NULL && sz != 0) {
		return malloc(sz);
	}
	else if (GET_SIZE(HDRP(ptr)) >= sz) {
		return ptr;
	}

	void *bigger_ptr = malloc(sz);
	if (bigger_ptr == NULL) {
		return ptr;
	}
	else {
		memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
		free(ptr);
		return bigger_ptr;
	}
}

void defrag() {
	void *fp = free_list;
	while (fp != NULL) {
		// is the block after me free		
		void *next_block = NEXT_BLKP(fp);
		if (!GET_ALLOC(HDRP(next_block))) {
			if (free_list == next_block)
				free_list = NEXT_FPTR(next_block);

			if (PREV_FPTR(next_block)) 
				NEXT_FPTR(PREV_FPTR(next_block)) = NEXT_FPTR(next_block);

			if (NEXT_FPTR(next_block)) 
				PREV_FPTR(NEXT_FPTR(next_block)) = PREV_FPTR(next_block);

			PUT(HDRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
			PUT(FTRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
		}

		// you only need to check the block after, because if the block before is free, you'll
		// bet there by traversing the free list

		fp = NEXT_FPTR(fp);
	}
}

// to avoid really messing with our malloc implementation, we're going to 
// have to allocate both arrays using sbrk, because if we use malloc/free
// then we're changing the free list / alloc'd blocks while we're trying
// to measure them, which seems like a huuuuuge headache
//
// there's a super pathological case where you check which one is alloc'd each
// time and its always these arrays

// it's also easier to just collect all the alloc'd blocks first

// heap sort stuff that operates on the pointer array
#define LEFT_CHILD(x) (2*x + 1)
#define RIGHT_CHILD(x) (2*x + 2)
#define PARENT(x) ((x-1)/2)

void sift_down(void **arr, size_t pos, size_t arr_len) {
	while (LEFT_CHILD(pos) < arr_len) {
		size_t smaller = LEFT_CHILD(pos);
		if (RIGHT_CHILD(pos) < arr_len && GET_SIZE(HDRP(arr[RIGHT_CHILD(pos)])) < GET_SIZE(HDRP(arr[LEFT_CHILD(pos)]))){
			smaller = RIGHT_CHILD(pos);
		}

		if (GET_SIZE(HDRP(arr[pos])) > GET_SIZE(HDRP(arr[smaller]))) {
			void *temp = arr[pos];
			arr[pos] = arr[smaller];
			arr[smaller] = temp;
			pos = smaller;
		}
		else {
			break;
		}
	}
}

void heapify(void **arr, size_t arr_len) {
	for (int i = arr_len - 1; i >= 0; i--) {
		sift_down(arr, i, arr_len);
	}
}

void heapsort(void **arr, size_t arr_len) {
	heapify(arr, arr_len);
	for (int i = arr_len - 1; i >= 0; i--) {
		void *temp = arr[0];
		arr[0] = arr[i];
		arr[i] = temp;
		sift_down(arr, 0, i);
	}
}

int heap_info(heap_info_struct *info) {
	info->num_allocs = num_allocs+2;		// +2 for the two arrays we need
	info->free_space = 0;
	info->largest_free_chunk = 0;

	info->size_array = sbrk(ALIGN(info->num_allocs * sizeof(long) + OVERHEAD));
	if (info->ptr_array == (void *)-1) { // nothing happens on failure
		return -1;
	}
	info->ptr_array = sbrk(ALIGN(info->num_allocs * sizeof(void *) + OVERHEAD));
	if (info->ptr_array == (void *)-1) {
		sbrk(-ALIGN(info->num_allocs * sizeof(long) + OVERHEAD));
		return -1;
	}

	// we manually fill in array metadata
	PUT(HDRP(info->size_array), PACK(ALIGN(info->num_allocs * sizeof(long) + OVERHEAD), 1));
	PUT(HDRP(info->ptr_array), PACK(ALIGN(info->num_allocs * sizeof(void *) + OVERHEAD), 1));

	// terminal block
	PUT(HDRP(NEXT_BLKP(info->ptr_array)), PACK(0, 1));

	// collect all the information by traversing through the heap
	void *bp = NEXT_BLKP(prologue_block); // because the prologue isn't actually allocated
	size_t arr_index = 0;
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
		if (GET_ALLOC(HDRP(bp))) {
			info->ptr_array[arr_index] = bp;
			info->size_array[arr_index] = GET_SIZE(HDRP(bp));
			arr_index++;
		}
		else {
			info->free_space += GET_SIZE(HDRP(bp));
			if(GET_SIZE(HDRP(bp)) > (size_t) (info->largest_free_chunk)) {
				info->largest_free_chunk = GET_SIZE(HDRP(bp));
			}
		}

		bp = NEXT_BLKP(bp);
	}

	// we just need to sort the arrays...
	// we'll use heapsort
	heapsort(info->ptr_array, info->num_allocs);
	for (int i = 0; i < info->num_allocs; i++)
		info->size_array[i] = GET_SIZE(HDRP(info->ptr_array[i]));

    return 0;
}












