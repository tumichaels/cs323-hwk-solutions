
obj/p-malloc.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	53                   	push   %rbx
  100005:	48 83 ec 08          	sub    $0x8,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100009:	cd 31                	int    $0x31
  10000b:	89 c3                	mov    %eax,%ebx
    pid_t p = getpid();

    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10000d:	b8 2f 30 10 00       	mov    $0x10302f,%eax
  100012:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100018:	48 89 05 e9 1f 00 00 	mov    %rax,0x1fe9(%rip)        # 102008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10001f:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100022:	48 83 e8 01          	sub    $0x1,%rax
  100026:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10002c:	48 89 05 cd 1f 00 00 	mov    %rax,0x1fcd(%rip)        # 102000 <stack_bottom>
  100033:	eb 02                	jmp    100037 <process_main+0x37>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  100035:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
	if ((rand() % ALLOC_SLOWDOWN) < p) {
  100037:	e8 98 06 00 00       	call   1006d4 <rand>
  10003c:	48 63 d0             	movslq %eax,%rdx
  10003f:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  100046:	48 c1 fa 25          	sar    $0x25,%rdx
  10004a:	89 c1                	mov    %eax,%ecx
  10004c:	c1 f9 1f             	sar    $0x1f,%ecx
  10004f:	29 ca                	sub    %ecx,%edx
  100051:	6b d2 64             	imul   $0x64,%edx,%edx
  100054:	29 d0                	sub    %edx,%eax
  100056:	39 d8                	cmp    %ebx,%eax
  100058:	7d db                	jge    100035 <process_main+0x35>
	    void * ret = malloc(PAGESIZE);
  10005a:	bf 00 10 00 00       	mov    $0x1000,%edi
  10005f:	e8 b6 01 00 00       	call   10021a <malloc>
	    if(ret == NULL)
  100064:	48 85 c0             	test   %rax,%rax
  100067:	74 04                	je     10006d <process_main+0x6d>
		break;
	    *((int*)ret) = p;       // check we have write access
  100069:	89 18                	mov    %ebx,(%rax)
  10006b:	eb c8                	jmp    100035 <process_main+0x35>
  10006d:	cd 32                	int    $0x32
  10006f:	eb fc                	jmp    10006d <process_main+0x6d>

0000000000100071 <heap_init>:
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  100071:	bf 10 00 00 00       	mov    $0x10,%edi
  100076:	cd 3a                	int    $0x3a
  100078:	48 89 05 a1 1f 00 00 	mov    %rax,0x1fa1(%rip)        # 102020 <result.0>
  10007f:	cd 3a                	int    $0x3a
  100081:	48 89 c2             	mov    %rax,%rdx
  100084:	48 89 05 95 1f 00 00 	mov    %rax,0x1f95(%rip)        # 102020 <result.0>
	// prologue block
	void *prologue_block;
	sbrk(sizeof(block_header));
	prologue_block = sbrk(sizeof(block_footer));

	GET_SIZE(HDRP(prologue_block)) = sizeof(block_header) + sizeof(block_footer);
  10008b:	48 c7 40 f0 20 00 00 	movq   $0x20,-0x10(%rax)
  100092:	00 
	GET_ALLOC(HDRP(prologue_block)) = 1;
  100093:	c7 40 f8 01 00 00 00 	movl   $0x1,-0x8(%rax)
	GET_SIZE(FTRP(prologue_block)) = sizeof(block_header) + sizeof(block_footer);
  10009a:	48 c7 00 20 00 00 00 	movq   $0x20,(%rax)
  1000a1:	cd 3a                	int    $0x3a
  1000a3:	48 89 05 76 1f 00 00 	mov    %rax,0x1f76(%rip)        # 102020 <result.0>

	// terminal block
	sbrk(sizeof(block_header));
	GET_SIZE(HDRP(NEXT_BLKP(prologue_block))) = 0;
  1000aa:	48 8b 42 f0          	mov    -0x10(%rdx),%rax
  1000ae:	48 c7 44 02 f0 00 00 	movq   $0x0,-0x10(%rdx,%rax,1)
  1000b5:	00 00 
	GET_ALLOC(HDRP(NEXT_BLKP(prologue_block))) = 0;
  1000b7:	48 8b 42 f0          	mov    -0x10(%rdx),%rax
  1000bb:	c7 44 02 f8 00 00 00 	movl   $0x0,-0x8(%rdx,%rax,1)
  1000c2:	00 

	free_list = NULL;
  1000c3:	48 c7 05 42 1f 00 00 	movq   $0x0,0x1f42(%rip)        # 102010 <free_list>
  1000ca:	00 00 00 00 

	initialized_heap = 1;
  1000ce:	c7 05 40 1f 00 00 01 	movl   $0x1,0x1f40(%rip)        # 102018 <initialized_heap>
  1000d5:	00 00 00 
}
  1000d8:	c3                   	ret    

00000000001000d9 <free>:

void free(void *firstbyte) {
	if (firstbyte == NULL)
  1000d9:	48 85 ff             	test   %rdi,%rdi
  1000dc:	74 34                	je     100112 <free+0x39>
		return;

	// setup free things: alloc, list ptrs, footer
	GET_ALLOC(HDRP(firstbyte)) = 0;
  1000de:	c7 47 f8 00 00 00 00 	movl   $0x0,-0x8(%rdi)
	NEXT_FPTR(firstbyte) = free_list;
  1000e5:	48 8b 05 24 1f 00 00 	mov    0x1f24(%rip),%rax        # 102010 <free_list>
  1000ec:	48 89 07             	mov    %rax,(%rdi)
	PREV_FPTR(firstbyte) = NULL;
  1000ef:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  1000f6:	00 
	GET_SIZE(FTRP(firstbyte)) = GET_SIZE(HDRP(firstbyte));
  1000f7:	48 8b 47 f0          	mov    -0x10(%rdi),%rax
  1000fb:	48 89 44 07 e0       	mov    %rax,-0x20(%rdi,%rax,1)

	// add to free_list
	PREV_FPTR(free_list) = firstbyte;
  100100:	48 8b 05 09 1f 00 00 	mov    0x1f09(%rip),%rax        # 102010 <free_list>
  100107:	48 89 78 08          	mov    %rdi,0x8(%rax)
	free_list = firstbyte;
  10010b:	48 89 3d fe 1e 00 00 	mov    %rdi,0x1efe(%rip)        # 102010 <free_list>

	return;
}
  100112:	c3                   	ret    

0000000000100113 <extend>:
//
//	the reason alloating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
void extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  100113:	48 81 c7 ff 3f 00 00 	add    $0x3fff,%rdi
  10011a:	48 81 e7 00 c0 ff ff 	and    $0xffffffffffffc000,%rdi
  100121:	cd 3a                	int    $0x3a
  100123:	48 89 05 f6 1e 00 00 	mov    %rax,0x1ef6(%rip)        # 102020 <result.0>
	void *bp = sbrk(chunk_aligned_size);

	// setup pointer
	GET_SIZE(HDRP(bp)) = chunk_aligned_size;
  10012a:	48 89 78 f0          	mov    %rdi,-0x10(%rax)
	GET_ALLOC(HDRP(bp)) = 0;
  10012e:	c7 40 f8 00 00 00 00 	movl   $0x0,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  100135:	48 8b 15 d4 1e 00 00 	mov    0x1ed4(%rip),%rdx        # 102010 <free_list>
  10013c:	48 89 10             	mov    %rdx,(%rax)
	PREV_FPTR(bp) = NULL;
  10013f:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  100146:	00 
	GET_SIZE(FTRP(bp)) = GET_SIZE(HDRP(bp));
  100147:	48 89 7c 07 e0       	mov    %rdi,-0x20(%rdi,%rax,1)

	// add to head of free_list
	if (free_list)
  10014c:	48 8b 15 bd 1e 00 00 	mov    0x1ebd(%rip),%rdx        # 102010 <free_list>
  100153:	48 85 d2             	test   %rdx,%rdx
  100156:	74 04                	je     10015c <extend+0x49>
		PREV_FPTR(free_list) = bp;
  100158:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  10015c:	48 89 05 ad 1e 00 00 	mov    %rax,0x1ead(%rip)        # 102010 <free_list>

	// update terminal block
	GET_SIZE(HDRP(NEXT_BLKP(bp))) = 0;
  100163:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  100167:	48 c7 44 10 f0 00 00 	movq   $0x0,-0x10(%rax,%rdx,1)
  10016e:	00 00 
	GET_ALLOC(HDRP(NEXT_BLKP(bp))) = 1;
  100170:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  100174:	c7 44 10 f8 01 00 00 	movl   $0x1,-0x8(%rax,%rdx,1)
  10017b:	00 
}
  10017c:	c3                   	ret    

000000000010017d <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
  10017d:	48 89 f8             	mov    %rdi,%rax
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  100180:	48 8b 57 f0          	mov    -0x10(%rdi),%rdx
  100184:	48 29 f2             	sub    %rsi,%rdx

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  100187:	48 83 fa 30          	cmp    $0x30,%rdx
  10018b:	76 57                	jbe    1001e4 <set_allocated+0x67>
		GET_SIZE(HDRP(bp)) = size;
  10018d:	48 89 77 f0          	mov    %rsi,-0x10(%rdi)
		void *leftover_mem_ptr = NEXT_BLKP(bp);
  100191:	48 01 fe             	add    %rdi,%rsi

		GET_SIZE(HDRP(leftover_mem_ptr)) = extra_size;
  100194:	48 89 56 f0          	mov    %rdx,-0x10(%rsi)
		GET_ALLOC(HDRP(leftover_mem_ptr)) = 0;
  100198:	c7 46 f8 00 00 00 00 	movl   $0x0,-0x8(%rsi)
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp); // pointers to the nearby free blocks
  10019f:	48 8b 0f             	mov    (%rdi),%rcx
  1001a2:	48 89 0e             	mov    %rcx,(%rsi)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  1001a5:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  1001a9:	48 89 4e 08          	mov    %rcx,0x8(%rsi)
		GET_SIZE(FTRP(leftover_mem_ptr)) = GET_SIZE(HDRP(leftover_mem_ptr));
  1001ad:	48 89 54 16 e0       	mov    %rdx,-0x20(%rsi,%rdx,1)

		// update the free list
		if (free_list == bp)
  1001b2:	48 39 3d 57 1e 00 00 	cmp    %rdi,0x1e57(%rip)        # 102010 <free_list>
  1001b9:	74 20                	je     1001db <set_allocated+0x5e>
			free_list = leftover_mem_ptr;

		if (PREV_FPTR(bp))
  1001bb:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1001bf:	48 85 d2             	test   %rdx,%rdx
  1001c2:	74 03                	je     1001c7 <set_allocated+0x4a>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  1001c4:	48 89 32             	mov    %rsi,(%rdx)
		if (NEXT_FPTR(bp))
  1001c7:	48 8b 10             	mov    (%rax),%rdx
  1001ca:	48 85 d2             	test   %rdx,%rdx
  1001cd:	74 04                	je     1001d3 <set_allocated+0x56>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  1001cf:	48 89 72 08          	mov    %rsi,0x8(%rdx)
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
		if (NEXT_FPTR(bp))
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
	}
	
	GET_ALLOC(HDRP(bp)) = 1;
  1001d3:	c7 40 f8 01 00 00 00 	movl   $0x1,-0x8(%rax)
}
  1001da:	c3                   	ret    
			free_list = leftover_mem_ptr;
  1001db:	48 89 35 2e 1e 00 00 	mov    %rsi,0x1e2e(%rip)        # 102010 <free_list>
  1001e2:	eb d7                	jmp    1001bb <set_allocated+0x3e>
		if (free_list == bp)
  1001e4:	48 39 3d 25 1e 00 00 	cmp    %rdi,0x1e25(%rip)        # 102010 <free_list>
  1001eb:	74 21                	je     10020e <set_allocated+0x91>
		if (PREV_FPTR(bp))
  1001ed:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1001f1:	48 85 d2             	test   %rdx,%rdx
  1001f4:	74 06                	je     1001fc <set_allocated+0x7f>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  1001f6:	48 8b 08             	mov    (%rax),%rcx
  1001f9:	48 89 0a             	mov    %rcx,(%rdx)
		if (NEXT_FPTR(bp))
  1001fc:	48 8b 10             	mov    (%rax),%rdx
  1001ff:	48 85 d2             	test   %rdx,%rdx
  100202:	74 cf                	je     1001d3 <set_allocated+0x56>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  100204:	48 8b 48 08          	mov    0x8(%rax),%rcx
  100208:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10020c:	eb c5                	jmp    1001d3 <set_allocated+0x56>
			free_list = NEXT_FPTR(bp);
  10020e:	48 8b 17             	mov    (%rdi),%rdx
  100211:	48 89 15 f8 1d 00 00 	mov    %rdx,0x1df8(%rip)        # 102010 <free_list>
  100218:	eb d3                	jmp    1001ed <set_allocated+0x70>

000000000010021a <malloc>:

void *malloc(uint64_t numbytes) {
  10021a:	55                   	push   %rbp
  10021b:	48 89 e5             	mov    %rsp,%rbp
  10021e:	41 55                	push   %r13
  100220:	41 54                	push   %r12
  100222:	53                   	push   %rbx
  100223:	48 83 ec 08          	sub    $0x8,%rsp
  100227:	49 89 fc             	mov    %rdi,%r12
	if (!initialized_heap)
  10022a:	83 3d e7 1d 00 00 00 	cmpl   $0x0,0x1de7(%rip)        # 102018 <initialized_heap>
  100231:	74 66                	je     100299 <malloc+0x7f>
		heap_init();

	if (numbytes == 0)
  100233:	4d 85 e4             	test   %r12,%r12
  100236:	0f 84 86 00 00 00    	je     1002c2 <malloc+0xa8>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  10023c:	49 83 c4 1f          	add    $0x1f,%r12
  100240:	49 83 e4 f0          	and    $0xfffffffffffffff0,%r12
  100244:	b8 30 00 00 00       	mov    $0x30,%eax
  100249:	49 39 c4             	cmp    %rax,%r12
  10024c:	4c 0f 42 e0          	cmovb  %rax,%r12
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);

	void *bp = free_list;
  100250:	48 8b 1d b9 1d 00 00 	mov    0x1db9(%rip),%rbx        # 102010 <free_list>
	while (bp) {
  100257:	48 85 db             	test   %rbx,%rbx
  10025a:	74 0e                	je     10026a <malloc+0x50>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  10025c:	4c 39 63 f0          	cmp    %r12,-0x10(%rbx)
  100260:	73 3e                	jae    1002a0 <malloc+0x86>
			set_allocated(bp, aligned_size);
			return bp;
		}

		bp = NEXT_FPTR(bp);
  100262:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  100265:	48 85 db             	test   %rbx,%rbx
  100268:	75 f2                	jne    10025c <malloc+0x42>
  10026a:	bf 00 00 00 00       	mov    $0x0,%edi
  10026f:	cd 3a                	int    $0x3a
  100271:	49 89 c5             	mov    %rax,%r13
  100274:	48 89 05 a5 1d 00 00 	mov    %rax,0x1da5(%rip)        # 102020 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  10027b:	48 89 c3             	mov    %rax,%rbx
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	if (bp == (void *)0xffffffffffffffef){
  10027e:	48 83 f8 ef          	cmp    $0xffffffffffffffef,%rax
  100282:	74 35                	je     1002b9 <malloc+0x9f>
		panic("I'm panicking");
		return NULL;}
	extend(aligned_size);
  100284:	4c 89 e7             	mov    %r12,%rdi
  100287:	e8 87 fe ff ff       	call   100113 <extend>
	set_allocated(bp, aligned_size);
  10028c:	4c 89 e6             	mov    %r12,%rsi
  10028f:	4c 89 ef             	mov    %r13,%rdi
  100292:	e8 e6 fe ff ff       	call   10017d <set_allocated>
    return bp;
  100297:	eb 12                	jmp    1002ab <malloc+0x91>
		heap_init();
  100299:	e8 d3 fd ff ff       	call   100071 <heap_init>
  10029e:	eb 93                	jmp    100233 <malloc+0x19>
			set_allocated(bp, aligned_size);
  1002a0:	4c 89 e6             	mov    %r12,%rsi
  1002a3:	48 89 df             	mov    %rbx,%rdi
  1002a6:	e8 d2 fe ff ff       	call   10017d <set_allocated>
}
  1002ab:	48 89 d8             	mov    %rbx,%rax
  1002ae:	48 83 c4 08          	add    $0x8,%rsp
  1002b2:	5b                   	pop    %rbx
  1002b3:	41 5c                	pop    %r12
  1002b5:	41 5d                	pop    %r13
  1002b7:	5d                   	pop    %rbp
  1002b8:	c3                   	ret    
    asm volatile ("int %0" : /* no result */
  1002b9:	bf 70 14 10 00       	mov    $0x101470,%edi
  1002be:	cd 30                	int    $0x30
 loop: goto loop;
  1002c0:	eb fe                	jmp    1002c0 <malloc+0xa6>
		return NULL;
  1002c2:	bb 00 00 00 00       	mov    $0x0,%ebx
  1002c7:	eb e2                	jmp    1002ab <malloc+0x91>

00000000001002c9 <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  1002c9:	55                   	push   %rbp
  1002ca:	48 89 e5             	mov    %rsp,%rbp
  1002cd:	41 54                	push   %r12
  1002cf:	53                   	push   %rbx
	void *bp = malloc(num * sz);
  1002d0:	48 0f af fe          	imul   %rsi,%rdi
  1002d4:	49 89 fc             	mov    %rdi,%r12
  1002d7:	e8 3e ff ff ff       	call   10021a <malloc>
  1002dc:	48 89 c3             	mov    %rax,%rbx
	memset(bp, 0, num * sz);
  1002df:	4c 89 e2             	mov    %r12,%rdx
  1002e2:	be 00 00 00 00       	mov    $0x0,%esi
  1002e7:	48 89 c7             	mov    %rax,%rdi
  1002ea:	e8 28 02 00 00       	call   100517 <memset>
	return bp;
}
  1002ef:	48 89 d8             	mov    %rbx,%rax
  1002f2:	5b                   	pop    %rbx
  1002f3:	41 5c                	pop    %r12
  1002f5:	5d                   	pop    %rbp
  1002f6:	c3                   	ret    

00000000001002f7 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  1002f7:	55                   	push   %rbp
  1002f8:	48 89 e5             	mov    %rsp,%rbp
  1002fb:	41 54                	push   %r12
  1002fd:	53                   	push   %rbx
  1002fe:	48 89 fb             	mov    %rdi,%rbx
	// first check if there's enough space in the block already
	if (GET_SIZE(HDRP(ptr)) >= sz)
  100301:	48 39 77 f0          	cmp    %rsi,-0x10(%rdi)
  100305:	72 08                	jb     10030f <realloc+0x18>
	void *bigger_ptr = malloc(sz);
	memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
	free(ptr);

    return bigger_ptr;
}
  100307:	48 89 d8             	mov    %rbx,%rax
  10030a:	5b                   	pop    %rbx
  10030b:	41 5c                	pop    %r12
  10030d:	5d                   	pop    %rbp
  10030e:	c3                   	ret    
	void *bigger_ptr = malloc(sz);
  10030f:	48 89 f7             	mov    %rsi,%rdi
  100312:	e8 03 ff ff ff       	call   10021a <malloc>
  100317:	49 89 c4             	mov    %rax,%r12
	memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
  10031a:	48 8b 53 f0          	mov    -0x10(%rbx),%rdx
  10031e:	48 89 de             	mov    %rbx,%rsi
  100321:	48 89 c7             	mov    %rax,%rdi
  100324:	e8 f0 00 00 00       	call   100419 <memcpy>
	free(ptr);
  100329:	48 89 df             	mov    %rbx,%rdi
  10032c:	e8 a8 fd ff ff       	call   1000d9 <free>
    return bigger_ptr;
  100331:	4c 89 e3             	mov    %r12,%rbx
  100334:	eb d1                	jmp    100307 <realloc+0x10>

0000000000100336 <defrag>:

void defrag() {
	void *fp = free_list;
  100336:	48 8b 05 d3 1c 00 00 	mov    0x1cd3(%rip),%rax        # 102010 <free_list>
	while (fp != NULL) {
  10033d:	48 85 c0             	test   %rax,%rax
  100340:	75 3a                	jne    10037c <defrag+0x46>
			GET_SIZE(FTRP(prev_block)) = GET_SIZE(HDRP(prev_block));
		}

		fp = NEXT_FPTR(fp);
	}
}
  100342:	c3                   	ret    
				free_list = NEXT_FPTR(next_block);
  100343:	48 8b 0a             	mov    (%rdx),%rcx
  100346:	48 89 0d c3 1c 00 00 	mov    %rcx,0x1cc3(%rip)        # 102010 <free_list>
  10034d:	eb 43                	jmp    100392 <defrag+0x5c>
			fp = NEXT_FPTR(fp);
  10034f:	48 8b 00             	mov    (%rax),%rax
			continue;
  100352:	eb 23                	jmp    100377 <defrag+0x41>
				free_list = NEXT_FPTR(fp);
  100354:	48 8b 08             	mov    (%rax),%rcx
  100357:	48 89 0d b2 1c 00 00 	mov    %rcx,0x1cb2(%rip)        # 102010 <free_list>
  10035e:	e9 88 00 00 00       	jmp    1003eb <defrag+0xb5>
			GET_SIZE(HDRP(prev_block)) = GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp));
  100363:	48 8b 48 f0          	mov    -0x10(%rax),%rcx
  100367:	48 03 4a f0          	add    -0x10(%rdx),%rcx
  10036b:	48 89 4a f0          	mov    %rcx,-0x10(%rdx)
			GET_SIZE(FTRP(prev_block)) = GET_SIZE(HDRP(prev_block));
  10036f:	48 89 4c 0a e0       	mov    %rcx,-0x20(%rdx,%rcx,1)
		fp = NEXT_FPTR(fp);
  100374:	48 8b 00             	mov    (%rax),%rax
	while (fp != NULL) {
  100377:	48 85 c0             	test   %rax,%rax
  10037a:	74 c6                	je     100342 <defrag+0xc>
		void *next_block = NEXT_BLKP(fp);
  10037c:	48 89 c2             	mov    %rax,%rdx
  10037f:	48 03 50 f0          	add    -0x10(%rax),%rdx
		if (!GET_ALLOC(HDRP(next_block))) {
  100383:	83 7a f8 00          	cmpl   $0x0,-0x8(%rdx)
  100387:	75 39                	jne    1003c2 <defrag+0x8c>
			if (free_list == next_block)
  100389:	48 39 15 80 1c 00 00 	cmp    %rdx,0x1c80(%rip)        # 102010 <free_list>
  100390:	74 b1                	je     100343 <defrag+0xd>
			if (PREV_FPTR(next_block)) 
  100392:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  100396:	48 85 c9             	test   %rcx,%rcx
  100399:	74 06                	je     1003a1 <defrag+0x6b>
				NEXT_FPTR(PREV_FPTR(next_block)) = NEXT_FPTR(next_block);
  10039b:	48 8b 32             	mov    (%rdx),%rsi
  10039e:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(next_block)) 
  1003a1:	48 8b 0a             	mov    (%rdx),%rcx
  1003a4:	48 85 c9             	test   %rcx,%rcx
  1003a7:	74 08                	je     1003b1 <defrag+0x7b>
				PREV_FPTR(NEXT_FPTR(next_block)) = PREV_FPTR(next_block);
  1003a9:	48 8b 72 08          	mov    0x8(%rdx),%rsi
  1003ad:	48 89 71 08          	mov    %rsi,0x8(%rcx)
			GET_SIZE(HDRP(fp)) = GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block));
  1003b1:	48 8b 52 f0          	mov    -0x10(%rdx),%rdx
  1003b5:	48 03 50 f0          	add    -0x10(%rax),%rdx
  1003b9:	48 89 50 f0          	mov    %rdx,-0x10(%rax)
			GET_SIZE(FTRP(fp)) = GET_SIZE(HDRP(fp));
  1003bd:	48 89 54 10 e0       	mov    %rdx,-0x20(%rax,%rdx,1)
		void *prev_block = PREV_BLKP(fp);
  1003c2:	48 89 c2             	mov    %rax,%rdx
  1003c5:	48 2b 50 e0          	sub    -0x20(%rax),%rdx
		if (GET_SIZE(HDRP(prev_block)) != GET_SIZE(FTRP(prev_block))){
  1003c9:	48 8b 4a f0          	mov    -0x10(%rdx),%rcx
  1003cd:	48 3b 4c 0a e0       	cmp    -0x20(%rdx,%rcx,1),%rcx
  1003d2:	0f 85 77 ff ff ff    	jne    10034f <defrag+0x19>
		if (!GET_ALLOC(HDRP(prev_block))) {
  1003d8:	83 7a f8 00          	cmpl   $0x0,-0x8(%rdx)
  1003dc:	75 96                	jne    100374 <defrag+0x3e>
			if (free_list == fp)
  1003de:	48 39 05 2b 1c 00 00 	cmp    %rax,0x1c2b(%rip)        # 102010 <free_list>
  1003e5:	0f 84 69 ff ff ff    	je     100354 <defrag+0x1e>
			if (PREV_FPTR(fp)) 
  1003eb:	48 8b 48 08          	mov    0x8(%rax),%rcx
  1003ef:	48 85 c9             	test   %rcx,%rcx
  1003f2:	74 06                	je     1003fa <defrag+0xc4>
				NEXT_FPTR(PREV_FPTR(fp)) = NEXT_FPTR(fp);
  1003f4:	48 8b 30             	mov    (%rax),%rsi
  1003f7:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(fp)) 
  1003fa:	48 8b 08             	mov    (%rax),%rcx
  1003fd:	48 85 c9             	test   %rcx,%rcx
  100400:	0f 84 5d ff ff ff    	je     100363 <defrag+0x2d>
				PREV_FPTR(NEXT_FPTR(fp)) = PREV_FPTR(fp);
  100406:	48 8b 70 08          	mov    0x8(%rax),%rsi
  10040a:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  10040e:	e9 50 ff ff ff       	jmp    100363 <defrag+0x2d>

0000000000100413 <heap_info>:

int heap_info(heap_info_struct *info) {
    return 0;
}
  100413:	b8 00 00 00 00       	mov    $0x0,%eax
  100418:	c3                   	ret    

0000000000100419 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100419:	55                   	push   %rbp
  10041a:	48 89 e5             	mov    %rsp,%rbp
  10041d:	48 83 ec 28          	sub    $0x28,%rsp
  100421:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100425:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100429:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10042d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100431:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100435:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100439:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  10043d:	eb 1c                	jmp    10045b <memcpy+0x42>
        *d = *s;
  10043f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100443:	0f b6 10             	movzbl (%rax),%edx
  100446:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10044a:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  10044c:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100451:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100456:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  10045b:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100460:	75 dd                	jne    10043f <memcpy+0x26>
    }
    return dst;
  100462:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100466:	c9                   	leave  
  100467:	c3                   	ret    

0000000000100468 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100468:	55                   	push   %rbp
  100469:	48 89 e5             	mov    %rsp,%rbp
  10046c:	48 83 ec 28          	sub    $0x28,%rsp
  100470:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100474:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100478:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10047c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100480:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  100484:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100488:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  10048c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100490:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  100494:	73 6a                	jae    100500 <memmove+0x98>
  100496:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10049a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10049e:	48 01 d0             	add    %rdx,%rax
  1004a1:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1004a5:	73 59                	jae    100500 <memmove+0x98>
        s += n, d += n;
  1004a7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1004ab:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1004af:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1004b3:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1004b7:	eb 17                	jmp    1004d0 <memmove+0x68>
            *--d = *--s;
  1004b9:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1004be:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1004c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004c7:	0f b6 10             	movzbl (%rax),%edx
  1004ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004ce:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1004d0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1004d4:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1004d8:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1004dc:	48 85 c0             	test   %rax,%rax
  1004df:	75 d8                	jne    1004b9 <memmove+0x51>
    if (s < d && s + n > d) {
  1004e1:	eb 2e                	jmp    100511 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1004e3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1004e7:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1004eb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1004ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004f3:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1004f7:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  1004fb:	0f b6 12             	movzbl (%rdx),%edx
  1004fe:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100500:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100504:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100508:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  10050c:	48 85 c0             	test   %rax,%rax
  10050f:	75 d2                	jne    1004e3 <memmove+0x7b>
        }
    }
    return dst;
  100511:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100515:	c9                   	leave  
  100516:	c3                   	ret    

0000000000100517 <memset>:

void* memset(void* v, int c, size_t n) {
  100517:	55                   	push   %rbp
  100518:	48 89 e5             	mov    %rsp,%rbp
  10051b:	48 83 ec 28          	sub    $0x28,%rsp
  10051f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100523:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100526:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10052a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10052e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100532:	eb 15                	jmp    100549 <memset+0x32>
        *p = c;
  100534:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100537:	89 c2                	mov    %eax,%edx
  100539:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10053d:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10053f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100544:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100549:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10054e:	75 e4                	jne    100534 <memset+0x1d>
    }
    return v;
  100550:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100554:	c9                   	leave  
  100555:	c3                   	ret    

0000000000100556 <strlen>:

size_t strlen(const char* s) {
  100556:	55                   	push   %rbp
  100557:	48 89 e5             	mov    %rsp,%rbp
  10055a:	48 83 ec 18          	sub    $0x18,%rsp
  10055e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100562:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100569:	00 
  10056a:	eb 0a                	jmp    100576 <strlen+0x20>
        ++n;
  10056c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100571:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100576:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10057a:	0f b6 00             	movzbl (%rax),%eax
  10057d:	84 c0                	test   %al,%al
  10057f:	75 eb                	jne    10056c <strlen+0x16>
    }
    return n;
  100581:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100585:	c9                   	leave  
  100586:	c3                   	ret    

0000000000100587 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100587:	55                   	push   %rbp
  100588:	48 89 e5             	mov    %rsp,%rbp
  10058b:	48 83 ec 20          	sub    $0x20,%rsp
  10058f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100593:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100597:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  10059e:	00 
  10059f:	eb 0a                	jmp    1005ab <strnlen+0x24>
        ++n;
  1005a1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1005a6:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1005ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005af:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  1005b3:	74 0b                	je     1005c0 <strnlen+0x39>
  1005b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1005b9:	0f b6 00             	movzbl (%rax),%eax
  1005bc:	84 c0                	test   %al,%al
  1005be:	75 e1                	jne    1005a1 <strnlen+0x1a>
    }
    return n;
  1005c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1005c4:	c9                   	leave  
  1005c5:	c3                   	ret    

00000000001005c6 <strcpy>:

char* strcpy(char* dst, const char* src) {
  1005c6:	55                   	push   %rbp
  1005c7:	48 89 e5             	mov    %rsp,%rbp
  1005ca:	48 83 ec 20          	sub    $0x20,%rsp
  1005ce:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1005d2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1005d6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1005da:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1005de:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1005e2:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1005e6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1005ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005ee:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1005f2:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  1005f6:	0f b6 12             	movzbl (%rdx),%edx
  1005f9:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  1005fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005ff:	48 83 e8 01          	sub    $0x1,%rax
  100603:	0f b6 00             	movzbl (%rax),%eax
  100606:	84 c0                	test   %al,%al
  100608:	75 d4                	jne    1005de <strcpy+0x18>
    return dst;
  10060a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10060e:	c9                   	leave  
  10060f:	c3                   	ret    

0000000000100610 <strcmp>:

int strcmp(const char* a, const char* b) {
  100610:	55                   	push   %rbp
  100611:	48 89 e5             	mov    %rsp,%rbp
  100614:	48 83 ec 10          	sub    $0x10,%rsp
  100618:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  10061c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100620:	eb 0a                	jmp    10062c <strcmp+0x1c>
        ++a, ++b;
  100622:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100627:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10062c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100630:	0f b6 00             	movzbl (%rax),%eax
  100633:	84 c0                	test   %al,%al
  100635:	74 1d                	je     100654 <strcmp+0x44>
  100637:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10063b:	0f b6 00             	movzbl (%rax),%eax
  10063e:	84 c0                	test   %al,%al
  100640:	74 12                	je     100654 <strcmp+0x44>
  100642:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100646:	0f b6 10             	movzbl (%rax),%edx
  100649:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10064d:	0f b6 00             	movzbl (%rax),%eax
  100650:	38 c2                	cmp    %al,%dl
  100652:	74 ce                	je     100622 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100654:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100658:	0f b6 00             	movzbl (%rax),%eax
  10065b:	89 c2                	mov    %eax,%edx
  10065d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100661:	0f b6 00             	movzbl (%rax),%eax
  100664:	38 d0                	cmp    %dl,%al
  100666:	0f 92 c0             	setb   %al
  100669:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  10066c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100670:	0f b6 00             	movzbl (%rax),%eax
  100673:	89 c1                	mov    %eax,%ecx
  100675:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100679:	0f b6 00             	movzbl (%rax),%eax
  10067c:	38 c1                	cmp    %al,%cl
  10067e:	0f 92 c0             	setb   %al
  100681:	0f b6 c0             	movzbl %al,%eax
  100684:	29 c2                	sub    %eax,%edx
  100686:	89 d0                	mov    %edx,%eax
}
  100688:	c9                   	leave  
  100689:	c3                   	ret    

000000000010068a <strchr>:

char* strchr(const char* s, int c) {
  10068a:	55                   	push   %rbp
  10068b:	48 89 e5             	mov    %rsp,%rbp
  10068e:	48 83 ec 10          	sub    $0x10,%rsp
  100692:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100696:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100699:	eb 05                	jmp    1006a0 <strchr+0x16>
        ++s;
  10069b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1006a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006a4:	0f b6 00             	movzbl (%rax),%eax
  1006a7:	84 c0                	test   %al,%al
  1006a9:	74 0e                	je     1006b9 <strchr+0x2f>
  1006ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006af:	0f b6 00             	movzbl (%rax),%eax
  1006b2:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1006b5:	38 d0                	cmp    %dl,%al
  1006b7:	75 e2                	jne    10069b <strchr+0x11>
    }
    if (*s == (char) c) {
  1006b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006bd:	0f b6 00             	movzbl (%rax),%eax
  1006c0:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1006c3:	38 d0                	cmp    %dl,%al
  1006c5:	75 06                	jne    1006cd <strchr+0x43>
        return (char*) s;
  1006c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006cb:	eb 05                	jmp    1006d2 <strchr+0x48>
    } else {
        return NULL;
  1006cd:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1006d2:	c9                   	leave  
  1006d3:	c3                   	ret    

00000000001006d4 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1006d4:	55                   	push   %rbp
  1006d5:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1006d8:	8b 05 4a 19 00 00    	mov    0x194a(%rip),%eax        # 102028 <rand_seed_set>
  1006de:	85 c0                	test   %eax,%eax
  1006e0:	75 0a                	jne    1006ec <rand+0x18>
        srand(819234718U);
  1006e2:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1006e7:	e8 24 00 00 00       	call   100710 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1006ec:	8b 05 3a 19 00 00    	mov    0x193a(%rip),%eax        # 10202c <rand_seed>
  1006f2:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  1006f8:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1006fd:	89 05 29 19 00 00    	mov    %eax,0x1929(%rip)        # 10202c <rand_seed>
    return rand_seed & RAND_MAX;
  100703:	8b 05 23 19 00 00    	mov    0x1923(%rip),%eax        # 10202c <rand_seed>
  100709:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  10070e:	5d                   	pop    %rbp
  10070f:	c3                   	ret    

0000000000100710 <srand>:

void srand(unsigned seed) {
  100710:	55                   	push   %rbp
  100711:	48 89 e5             	mov    %rsp,%rbp
  100714:	48 83 ec 08          	sub    $0x8,%rsp
  100718:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  10071b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10071e:	89 05 08 19 00 00    	mov    %eax,0x1908(%rip)        # 10202c <rand_seed>
    rand_seed_set = 1;
  100724:	c7 05 fa 18 00 00 01 	movl   $0x1,0x18fa(%rip)        # 102028 <rand_seed_set>
  10072b:	00 00 00 
}
  10072e:	90                   	nop
  10072f:	c9                   	leave  
  100730:	c3                   	ret    

0000000000100731 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100731:	55                   	push   %rbp
  100732:	48 89 e5             	mov    %rsp,%rbp
  100735:	48 83 ec 28          	sub    $0x28,%rsp
  100739:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10073d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100741:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100744:	48 c7 45 f8 60 16 10 	movq   $0x101660,-0x8(%rbp)
  10074b:	00 
    if (base < 0) {
  10074c:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100750:	79 0b                	jns    10075d <fill_numbuf+0x2c>
        digits = lower_digits;
  100752:	48 c7 45 f8 80 16 10 	movq   $0x101680,-0x8(%rbp)
  100759:	00 
        base = -base;
  10075a:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  10075d:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100762:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100766:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100769:	8b 45 dc             	mov    -0x24(%rbp),%eax
  10076c:	48 63 c8             	movslq %eax,%rcx
  10076f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100773:	ba 00 00 00 00       	mov    $0x0,%edx
  100778:	48 f7 f1             	div    %rcx
  10077b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10077f:	48 01 d0             	add    %rdx,%rax
  100782:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100787:	0f b6 10             	movzbl (%rax),%edx
  10078a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10078e:	88 10                	mov    %dl,(%rax)
        val /= base;
  100790:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100793:	48 63 f0             	movslq %eax,%rsi
  100796:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10079a:	ba 00 00 00 00       	mov    $0x0,%edx
  10079f:	48 f7 f6             	div    %rsi
  1007a2:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  1007a6:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  1007ab:	75 bc                	jne    100769 <fill_numbuf+0x38>
    return numbuf_end;
  1007ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1007b1:	c9                   	leave  
  1007b2:	c3                   	ret    

00000000001007b3 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1007b3:	55                   	push   %rbp
  1007b4:	48 89 e5             	mov    %rsp,%rbp
  1007b7:	53                   	push   %rbx
  1007b8:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  1007bf:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1007c6:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1007cc:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1007d3:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1007da:	e9 8a 09 00 00       	jmp    101169 <printer_vprintf+0x9b6>
        if (*format != '%') {
  1007df:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007e6:	0f b6 00             	movzbl (%rax),%eax
  1007e9:	3c 25                	cmp    $0x25,%al
  1007eb:	74 31                	je     10081e <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  1007ed:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1007f4:	4c 8b 00             	mov    (%rax),%r8
  1007f7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007fe:	0f b6 00             	movzbl (%rax),%eax
  100801:	0f b6 c8             	movzbl %al,%ecx
  100804:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10080a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100811:	89 ce                	mov    %ecx,%esi
  100813:	48 89 c7             	mov    %rax,%rdi
  100816:	41 ff d0             	call   *%r8
            continue;
  100819:	e9 43 09 00 00       	jmp    101161 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  10081e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100825:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10082c:	01 
  10082d:	eb 44                	jmp    100873 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  10082f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100836:	0f b6 00             	movzbl (%rax),%eax
  100839:	0f be c0             	movsbl %al,%eax
  10083c:	89 c6                	mov    %eax,%esi
  10083e:	bf 80 14 10 00       	mov    $0x101480,%edi
  100843:	e8 42 fe ff ff       	call   10068a <strchr>
  100848:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  10084c:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100851:	74 30                	je     100883 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  100853:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100857:	48 2d 80 14 10 00    	sub    $0x101480,%rax
  10085d:	ba 01 00 00 00       	mov    $0x1,%edx
  100862:	89 c1                	mov    %eax,%ecx
  100864:	d3 e2                	shl    %cl,%edx
  100866:	89 d0                	mov    %edx,%eax
  100868:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  10086b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100872:	01 
  100873:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10087a:	0f b6 00             	movzbl (%rax),%eax
  10087d:	84 c0                	test   %al,%al
  10087f:	75 ae                	jne    10082f <printer_vprintf+0x7c>
  100881:	eb 01                	jmp    100884 <printer_vprintf+0xd1>
            } else {
                break;
  100883:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100884:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  10088b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100892:	0f b6 00             	movzbl (%rax),%eax
  100895:	3c 30                	cmp    $0x30,%al
  100897:	7e 67                	jle    100900 <printer_vprintf+0x14d>
  100899:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008a0:	0f b6 00             	movzbl (%rax),%eax
  1008a3:	3c 39                	cmp    $0x39,%al
  1008a5:	7f 59                	jg     100900 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1008a7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  1008ae:	eb 2e                	jmp    1008de <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  1008b0:	8b 55 e8             	mov    -0x18(%rbp),%edx
  1008b3:	89 d0                	mov    %edx,%eax
  1008b5:	c1 e0 02             	shl    $0x2,%eax
  1008b8:	01 d0                	add    %edx,%eax
  1008ba:	01 c0                	add    %eax,%eax
  1008bc:	89 c1                	mov    %eax,%ecx
  1008be:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008c5:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1008c9:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1008d0:	0f b6 00             	movzbl (%rax),%eax
  1008d3:	0f be c0             	movsbl %al,%eax
  1008d6:	01 c8                	add    %ecx,%eax
  1008d8:	83 e8 30             	sub    $0x30,%eax
  1008db:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1008de:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008e5:	0f b6 00             	movzbl (%rax),%eax
  1008e8:	3c 2f                	cmp    $0x2f,%al
  1008ea:	0f 8e 85 00 00 00    	jle    100975 <printer_vprintf+0x1c2>
  1008f0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008f7:	0f b6 00             	movzbl (%rax),%eax
  1008fa:	3c 39                	cmp    $0x39,%al
  1008fc:	7e b2                	jle    1008b0 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  1008fe:	eb 75                	jmp    100975 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100900:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100907:	0f b6 00             	movzbl (%rax),%eax
  10090a:	3c 2a                	cmp    $0x2a,%al
  10090c:	75 68                	jne    100976 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  10090e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100915:	8b 00                	mov    (%rax),%eax
  100917:	83 f8 2f             	cmp    $0x2f,%eax
  10091a:	77 30                	ja     10094c <printer_vprintf+0x199>
  10091c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100923:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100927:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10092e:	8b 00                	mov    (%rax),%eax
  100930:	89 c0                	mov    %eax,%eax
  100932:	48 01 d0             	add    %rdx,%rax
  100935:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10093c:	8b 12                	mov    (%rdx),%edx
  10093e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100941:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100948:	89 0a                	mov    %ecx,(%rdx)
  10094a:	eb 1a                	jmp    100966 <printer_vprintf+0x1b3>
  10094c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100953:	48 8b 40 08          	mov    0x8(%rax),%rax
  100957:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10095b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100962:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100966:	8b 00                	mov    (%rax),%eax
  100968:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  10096b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100972:	01 
  100973:	eb 01                	jmp    100976 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100975:	90                   	nop
        }

        // process precision
        int precision = -1;
  100976:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  10097d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100984:	0f b6 00             	movzbl (%rax),%eax
  100987:	3c 2e                	cmp    $0x2e,%al
  100989:	0f 85 00 01 00 00    	jne    100a8f <printer_vprintf+0x2dc>
            ++format;
  10098f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100996:	01 
            if (*format >= '0' && *format <= '9') {
  100997:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10099e:	0f b6 00             	movzbl (%rax),%eax
  1009a1:	3c 2f                	cmp    $0x2f,%al
  1009a3:	7e 67                	jle    100a0c <printer_vprintf+0x259>
  1009a5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009ac:	0f b6 00             	movzbl (%rax),%eax
  1009af:	3c 39                	cmp    $0x39,%al
  1009b1:	7f 59                	jg     100a0c <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1009b3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  1009ba:	eb 2e                	jmp    1009ea <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  1009bc:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  1009bf:	89 d0                	mov    %edx,%eax
  1009c1:	c1 e0 02             	shl    $0x2,%eax
  1009c4:	01 d0                	add    %edx,%eax
  1009c6:	01 c0                	add    %eax,%eax
  1009c8:	89 c1                	mov    %eax,%ecx
  1009ca:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009d1:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1009d5:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1009dc:	0f b6 00             	movzbl (%rax),%eax
  1009df:	0f be c0             	movsbl %al,%eax
  1009e2:	01 c8                	add    %ecx,%eax
  1009e4:	83 e8 30             	sub    $0x30,%eax
  1009e7:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1009ea:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009f1:	0f b6 00             	movzbl (%rax),%eax
  1009f4:	3c 2f                	cmp    $0x2f,%al
  1009f6:	0f 8e 85 00 00 00    	jle    100a81 <printer_vprintf+0x2ce>
  1009fc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a03:	0f b6 00             	movzbl (%rax),%eax
  100a06:	3c 39                	cmp    $0x39,%al
  100a08:	7e b2                	jle    1009bc <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100a0a:	eb 75                	jmp    100a81 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100a0c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a13:	0f b6 00             	movzbl (%rax),%eax
  100a16:	3c 2a                	cmp    $0x2a,%al
  100a18:	75 68                	jne    100a82 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100a1a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a21:	8b 00                	mov    (%rax),%eax
  100a23:	83 f8 2f             	cmp    $0x2f,%eax
  100a26:	77 30                	ja     100a58 <printer_vprintf+0x2a5>
  100a28:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a2f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a33:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a3a:	8b 00                	mov    (%rax),%eax
  100a3c:	89 c0                	mov    %eax,%eax
  100a3e:	48 01 d0             	add    %rdx,%rax
  100a41:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a48:	8b 12                	mov    (%rdx),%edx
  100a4a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a4d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a54:	89 0a                	mov    %ecx,(%rdx)
  100a56:	eb 1a                	jmp    100a72 <printer_vprintf+0x2bf>
  100a58:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a5f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a63:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a67:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a6e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a72:	8b 00                	mov    (%rax),%eax
  100a74:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100a77:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100a7e:	01 
  100a7f:	eb 01                	jmp    100a82 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100a81:	90                   	nop
            }
            if (precision < 0) {
  100a82:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100a86:	79 07                	jns    100a8f <printer_vprintf+0x2dc>
                precision = 0;
  100a88:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100a8f:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100a96:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100a9d:	00 
        int length = 0;
  100a9e:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100aa5:	48 c7 45 c8 86 14 10 	movq   $0x101486,-0x38(%rbp)
  100aac:	00 
    again:
        switch (*format) {
  100aad:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ab4:	0f b6 00             	movzbl (%rax),%eax
  100ab7:	0f be c0             	movsbl %al,%eax
  100aba:	83 e8 43             	sub    $0x43,%eax
  100abd:	83 f8 37             	cmp    $0x37,%eax
  100ac0:	0f 87 9f 03 00 00    	ja     100e65 <printer_vprintf+0x6b2>
  100ac6:	89 c0                	mov    %eax,%eax
  100ac8:	48 8b 04 c5 98 14 10 	mov    0x101498(,%rax,8),%rax
  100acf:	00 
  100ad0:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100ad2:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100ad9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ae0:	01 
            goto again;
  100ae1:	eb ca                	jmp    100aad <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100ae3:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100ae7:	74 5d                	je     100b46 <printer_vprintf+0x393>
  100ae9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100af0:	8b 00                	mov    (%rax),%eax
  100af2:	83 f8 2f             	cmp    $0x2f,%eax
  100af5:	77 30                	ja     100b27 <printer_vprintf+0x374>
  100af7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100afe:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b02:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b09:	8b 00                	mov    (%rax),%eax
  100b0b:	89 c0                	mov    %eax,%eax
  100b0d:	48 01 d0             	add    %rdx,%rax
  100b10:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b17:	8b 12                	mov    (%rdx),%edx
  100b19:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b1c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b23:	89 0a                	mov    %ecx,(%rdx)
  100b25:	eb 1a                	jmp    100b41 <printer_vprintf+0x38e>
  100b27:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b2e:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b32:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b36:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b3d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b41:	48 8b 00             	mov    (%rax),%rax
  100b44:	eb 5c                	jmp    100ba2 <printer_vprintf+0x3ef>
  100b46:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b4d:	8b 00                	mov    (%rax),%eax
  100b4f:	83 f8 2f             	cmp    $0x2f,%eax
  100b52:	77 30                	ja     100b84 <printer_vprintf+0x3d1>
  100b54:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b5b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b5f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b66:	8b 00                	mov    (%rax),%eax
  100b68:	89 c0                	mov    %eax,%eax
  100b6a:	48 01 d0             	add    %rdx,%rax
  100b6d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b74:	8b 12                	mov    (%rdx),%edx
  100b76:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b79:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b80:	89 0a                	mov    %ecx,(%rdx)
  100b82:	eb 1a                	jmp    100b9e <printer_vprintf+0x3eb>
  100b84:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b8b:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b8f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b93:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b9a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b9e:	8b 00                	mov    (%rax),%eax
  100ba0:	48 98                	cltq   
  100ba2:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100ba6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100baa:	48 c1 f8 38          	sar    $0x38,%rax
  100bae:	25 80 00 00 00       	and    $0x80,%eax
  100bb3:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100bb6:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100bba:	74 09                	je     100bc5 <printer_vprintf+0x412>
  100bbc:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100bc0:	48 f7 d8             	neg    %rax
  100bc3:	eb 04                	jmp    100bc9 <printer_vprintf+0x416>
  100bc5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100bc9:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100bcd:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100bd0:	83 c8 60             	or     $0x60,%eax
  100bd3:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100bd6:	e9 cf 02 00 00       	jmp    100eaa <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100bdb:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100bdf:	74 5d                	je     100c3e <printer_vprintf+0x48b>
  100be1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100be8:	8b 00                	mov    (%rax),%eax
  100bea:	83 f8 2f             	cmp    $0x2f,%eax
  100bed:	77 30                	ja     100c1f <printer_vprintf+0x46c>
  100bef:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bf6:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100bfa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c01:	8b 00                	mov    (%rax),%eax
  100c03:	89 c0                	mov    %eax,%eax
  100c05:	48 01 d0             	add    %rdx,%rax
  100c08:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c0f:	8b 12                	mov    (%rdx),%edx
  100c11:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c14:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c1b:	89 0a                	mov    %ecx,(%rdx)
  100c1d:	eb 1a                	jmp    100c39 <printer_vprintf+0x486>
  100c1f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c26:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c2a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c2e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c35:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c39:	48 8b 00             	mov    (%rax),%rax
  100c3c:	eb 5c                	jmp    100c9a <printer_vprintf+0x4e7>
  100c3e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c45:	8b 00                	mov    (%rax),%eax
  100c47:	83 f8 2f             	cmp    $0x2f,%eax
  100c4a:	77 30                	ja     100c7c <printer_vprintf+0x4c9>
  100c4c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c53:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c57:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c5e:	8b 00                	mov    (%rax),%eax
  100c60:	89 c0                	mov    %eax,%eax
  100c62:	48 01 d0             	add    %rdx,%rax
  100c65:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c6c:	8b 12                	mov    (%rdx),%edx
  100c6e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c71:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c78:	89 0a                	mov    %ecx,(%rdx)
  100c7a:	eb 1a                	jmp    100c96 <printer_vprintf+0x4e3>
  100c7c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c83:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c87:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c8b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c92:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c96:	8b 00                	mov    (%rax),%eax
  100c98:	89 c0                	mov    %eax,%eax
  100c9a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100c9e:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100ca2:	e9 03 02 00 00       	jmp    100eaa <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100ca7:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100cae:	e9 28 ff ff ff       	jmp    100bdb <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100cb3:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100cba:	e9 1c ff ff ff       	jmp    100bdb <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100cbf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cc6:	8b 00                	mov    (%rax),%eax
  100cc8:	83 f8 2f             	cmp    $0x2f,%eax
  100ccb:	77 30                	ja     100cfd <printer_vprintf+0x54a>
  100ccd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cd4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100cd8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cdf:	8b 00                	mov    (%rax),%eax
  100ce1:	89 c0                	mov    %eax,%eax
  100ce3:	48 01 d0             	add    %rdx,%rax
  100ce6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ced:	8b 12                	mov    (%rdx),%edx
  100cef:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100cf2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cf9:	89 0a                	mov    %ecx,(%rdx)
  100cfb:	eb 1a                	jmp    100d17 <printer_vprintf+0x564>
  100cfd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d04:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d08:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d0c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d13:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d17:	48 8b 00             	mov    (%rax),%rax
  100d1a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100d1e:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100d25:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100d2c:	e9 79 01 00 00       	jmp    100eaa <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100d31:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d38:	8b 00                	mov    (%rax),%eax
  100d3a:	83 f8 2f             	cmp    $0x2f,%eax
  100d3d:	77 30                	ja     100d6f <printer_vprintf+0x5bc>
  100d3f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d46:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d4a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d51:	8b 00                	mov    (%rax),%eax
  100d53:	89 c0                	mov    %eax,%eax
  100d55:	48 01 d0             	add    %rdx,%rax
  100d58:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d5f:	8b 12                	mov    (%rdx),%edx
  100d61:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d64:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d6b:	89 0a                	mov    %ecx,(%rdx)
  100d6d:	eb 1a                	jmp    100d89 <printer_vprintf+0x5d6>
  100d6f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d76:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d7a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d7e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d85:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d89:	48 8b 00             	mov    (%rax),%rax
  100d8c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100d90:	e9 15 01 00 00       	jmp    100eaa <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100d95:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d9c:	8b 00                	mov    (%rax),%eax
  100d9e:	83 f8 2f             	cmp    $0x2f,%eax
  100da1:	77 30                	ja     100dd3 <printer_vprintf+0x620>
  100da3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100daa:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100dae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100db5:	8b 00                	mov    (%rax),%eax
  100db7:	89 c0                	mov    %eax,%eax
  100db9:	48 01 d0             	add    %rdx,%rax
  100dbc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dc3:	8b 12                	mov    (%rdx),%edx
  100dc5:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100dc8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dcf:	89 0a                	mov    %ecx,(%rdx)
  100dd1:	eb 1a                	jmp    100ded <printer_vprintf+0x63a>
  100dd3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dda:	48 8b 40 08          	mov    0x8(%rax),%rax
  100dde:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100de2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100de9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ded:	8b 00                	mov    (%rax),%eax
  100def:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100df5:	e9 67 03 00 00       	jmp    101161 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  100dfa:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100dfe:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100e02:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e09:	8b 00                	mov    (%rax),%eax
  100e0b:	83 f8 2f             	cmp    $0x2f,%eax
  100e0e:	77 30                	ja     100e40 <printer_vprintf+0x68d>
  100e10:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e17:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e1b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e22:	8b 00                	mov    (%rax),%eax
  100e24:	89 c0                	mov    %eax,%eax
  100e26:	48 01 d0             	add    %rdx,%rax
  100e29:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e30:	8b 12                	mov    (%rdx),%edx
  100e32:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e35:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e3c:	89 0a                	mov    %ecx,(%rdx)
  100e3e:	eb 1a                	jmp    100e5a <printer_vprintf+0x6a7>
  100e40:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e47:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e4b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e4f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e56:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e5a:	8b 00                	mov    (%rax),%eax
  100e5c:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100e5f:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100e63:	eb 45                	jmp    100eaa <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  100e65:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100e69:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100e6d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e74:	0f b6 00             	movzbl (%rax),%eax
  100e77:	84 c0                	test   %al,%al
  100e79:	74 0c                	je     100e87 <printer_vprintf+0x6d4>
  100e7b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e82:	0f b6 00             	movzbl (%rax),%eax
  100e85:	eb 05                	jmp    100e8c <printer_vprintf+0x6d9>
  100e87:	b8 25 00 00 00       	mov    $0x25,%eax
  100e8c:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100e8f:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100e93:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e9a:	0f b6 00             	movzbl (%rax),%eax
  100e9d:	84 c0                	test   %al,%al
  100e9f:	75 08                	jne    100ea9 <printer_vprintf+0x6f6>
                format--;
  100ea1:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100ea8:	01 
            }
            break;
  100ea9:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100eaa:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ead:	83 e0 20             	and    $0x20,%eax
  100eb0:	85 c0                	test   %eax,%eax
  100eb2:	74 1e                	je     100ed2 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100eb4:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100eb8:	48 83 c0 18          	add    $0x18,%rax
  100ebc:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100ebf:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100ec3:	48 89 ce             	mov    %rcx,%rsi
  100ec6:	48 89 c7             	mov    %rax,%rdi
  100ec9:	e8 63 f8 ff ff       	call   100731 <fill_numbuf>
  100ece:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100ed2:	48 c7 45 c0 86 14 10 	movq   $0x101486,-0x40(%rbp)
  100ed9:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100eda:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100edd:	83 e0 20             	and    $0x20,%eax
  100ee0:	85 c0                	test   %eax,%eax
  100ee2:	74 48                	je     100f2c <printer_vprintf+0x779>
  100ee4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ee7:	83 e0 40             	and    $0x40,%eax
  100eea:	85 c0                	test   %eax,%eax
  100eec:	74 3e                	je     100f2c <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  100eee:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ef1:	25 80 00 00 00       	and    $0x80,%eax
  100ef6:	85 c0                	test   %eax,%eax
  100ef8:	74 0a                	je     100f04 <printer_vprintf+0x751>
                prefix = "-";
  100efa:	48 c7 45 c0 87 14 10 	movq   $0x101487,-0x40(%rbp)
  100f01:	00 
            if (flags & FLAG_NEGATIVE) {
  100f02:	eb 73                	jmp    100f77 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100f04:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f07:	83 e0 10             	and    $0x10,%eax
  100f0a:	85 c0                	test   %eax,%eax
  100f0c:	74 0a                	je     100f18 <printer_vprintf+0x765>
                prefix = "+";
  100f0e:	48 c7 45 c0 89 14 10 	movq   $0x101489,-0x40(%rbp)
  100f15:	00 
            if (flags & FLAG_NEGATIVE) {
  100f16:	eb 5f                	jmp    100f77 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100f18:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f1b:	83 e0 08             	and    $0x8,%eax
  100f1e:	85 c0                	test   %eax,%eax
  100f20:	74 55                	je     100f77 <printer_vprintf+0x7c4>
                prefix = " ";
  100f22:	48 c7 45 c0 8b 14 10 	movq   $0x10148b,-0x40(%rbp)
  100f29:	00 
            if (flags & FLAG_NEGATIVE) {
  100f2a:	eb 4b                	jmp    100f77 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100f2c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f2f:	83 e0 20             	and    $0x20,%eax
  100f32:	85 c0                	test   %eax,%eax
  100f34:	74 42                	je     100f78 <printer_vprintf+0x7c5>
  100f36:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f39:	83 e0 01             	and    $0x1,%eax
  100f3c:	85 c0                	test   %eax,%eax
  100f3e:	74 38                	je     100f78 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  100f40:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100f44:	74 06                	je     100f4c <printer_vprintf+0x799>
  100f46:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100f4a:	75 2c                	jne    100f78 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  100f4c:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100f51:	75 0c                	jne    100f5f <printer_vprintf+0x7ac>
  100f53:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f56:	25 00 01 00 00       	and    $0x100,%eax
  100f5b:	85 c0                	test   %eax,%eax
  100f5d:	74 19                	je     100f78 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  100f5f:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100f63:	75 07                	jne    100f6c <printer_vprintf+0x7b9>
  100f65:	b8 8d 14 10 00       	mov    $0x10148d,%eax
  100f6a:	eb 05                	jmp    100f71 <printer_vprintf+0x7be>
  100f6c:	b8 90 14 10 00       	mov    $0x101490,%eax
  100f71:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100f75:	eb 01                	jmp    100f78 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  100f77:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100f78:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100f7c:	78 24                	js     100fa2 <printer_vprintf+0x7ef>
  100f7e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f81:	83 e0 20             	and    $0x20,%eax
  100f84:	85 c0                	test   %eax,%eax
  100f86:	75 1a                	jne    100fa2 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  100f88:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100f8b:	48 63 d0             	movslq %eax,%rdx
  100f8e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100f92:	48 89 d6             	mov    %rdx,%rsi
  100f95:	48 89 c7             	mov    %rax,%rdi
  100f98:	e8 ea f5 ff ff       	call   100587 <strnlen>
  100f9d:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100fa0:	eb 0f                	jmp    100fb1 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  100fa2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100fa6:	48 89 c7             	mov    %rax,%rdi
  100fa9:	e8 a8 f5 ff ff       	call   100556 <strlen>
  100fae:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100fb1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fb4:	83 e0 20             	and    $0x20,%eax
  100fb7:	85 c0                	test   %eax,%eax
  100fb9:	74 20                	je     100fdb <printer_vprintf+0x828>
  100fbb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100fbf:	78 1a                	js     100fdb <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  100fc1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100fc4:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100fc7:	7e 08                	jle    100fd1 <printer_vprintf+0x81e>
  100fc9:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100fcc:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100fcf:	eb 05                	jmp    100fd6 <printer_vprintf+0x823>
  100fd1:	b8 00 00 00 00       	mov    $0x0,%eax
  100fd6:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100fd9:	eb 5c                	jmp    101037 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100fdb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fde:	83 e0 20             	and    $0x20,%eax
  100fe1:	85 c0                	test   %eax,%eax
  100fe3:	74 4b                	je     101030 <printer_vprintf+0x87d>
  100fe5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fe8:	83 e0 02             	and    $0x2,%eax
  100feb:	85 c0                	test   %eax,%eax
  100fed:	74 41                	je     101030 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100fef:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ff2:	83 e0 04             	and    $0x4,%eax
  100ff5:	85 c0                	test   %eax,%eax
  100ff7:	75 37                	jne    101030 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  100ff9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100ffd:	48 89 c7             	mov    %rax,%rdi
  101000:	e8 51 f5 ff ff       	call   100556 <strlen>
  101005:	89 c2                	mov    %eax,%edx
  101007:	8b 45 bc             	mov    -0x44(%rbp),%eax
  10100a:	01 d0                	add    %edx,%eax
  10100c:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  10100f:	7e 1f                	jle    101030 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  101011:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101014:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101017:	89 c3                	mov    %eax,%ebx
  101019:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10101d:	48 89 c7             	mov    %rax,%rdi
  101020:	e8 31 f5 ff ff       	call   100556 <strlen>
  101025:	89 c2                	mov    %eax,%edx
  101027:	89 d8                	mov    %ebx,%eax
  101029:	29 d0                	sub    %edx,%eax
  10102b:	89 45 b8             	mov    %eax,-0x48(%rbp)
  10102e:	eb 07                	jmp    101037 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  101030:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  101037:	8b 55 bc             	mov    -0x44(%rbp),%edx
  10103a:	8b 45 b8             	mov    -0x48(%rbp),%eax
  10103d:	01 d0                	add    %edx,%eax
  10103f:	48 63 d8             	movslq %eax,%rbx
  101042:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101046:	48 89 c7             	mov    %rax,%rdi
  101049:	e8 08 f5 ff ff       	call   100556 <strlen>
  10104e:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  101052:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101055:	29 d0                	sub    %edx,%eax
  101057:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10105a:	eb 25                	jmp    101081 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  10105c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101063:	48 8b 08             	mov    (%rax),%rcx
  101066:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10106c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101073:	be 20 00 00 00       	mov    $0x20,%esi
  101078:	48 89 c7             	mov    %rax,%rdi
  10107b:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10107d:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101081:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101084:	83 e0 04             	and    $0x4,%eax
  101087:	85 c0                	test   %eax,%eax
  101089:	75 36                	jne    1010c1 <printer_vprintf+0x90e>
  10108b:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  10108f:	7f cb                	jg     10105c <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  101091:	eb 2e                	jmp    1010c1 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  101093:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10109a:	4c 8b 00             	mov    (%rax),%r8
  10109d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1010a1:	0f b6 00             	movzbl (%rax),%eax
  1010a4:	0f b6 c8             	movzbl %al,%ecx
  1010a7:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1010ad:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010b4:	89 ce                	mov    %ecx,%esi
  1010b6:	48 89 c7             	mov    %rax,%rdi
  1010b9:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  1010bc:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  1010c1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1010c5:	0f b6 00             	movzbl (%rax),%eax
  1010c8:	84 c0                	test   %al,%al
  1010ca:	75 c7                	jne    101093 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  1010cc:	eb 25                	jmp    1010f3 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  1010ce:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010d5:	48 8b 08             	mov    (%rax),%rcx
  1010d8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1010de:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010e5:	be 30 00 00 00       	mov    $0x30,%esi
  1010ea:	48 89 c7             	mov    %rax,%rdi
  1010ed:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  1010ef:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  1010f3:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  1010f7:	7f d5                	jg     1010ce <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  1010f9:	eb 32                	jmp    10112d <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  1010fb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101102:	4c 8b 00             	mov    (%rax),%r8
  101105:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101109:	0f b6 00             	movzbl (%rax),%eax
  10110c:	0f b6 c8             	movzbl %al,%ecx
  10110f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101115:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10111c:	89 ce                	mov    %ecx,%esi
  10111e:	48 89 c7             	mov    %rax,%rdi
  101121:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  101124:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  101129:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  10112d:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  101131:	7f c8                	jg     1010fb <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  101133:	eb 25                	jmp    10115a <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  101135:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10113c:	48 8b 08             	mov    (%rax),%rcx
  10113f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101145:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10114c:	be 20 00 00 00       	mov    $0x20,%esi
  101151:	48 89 c7             	mov    %rax,%rdi
  101154:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  101156:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  10115a:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  10115e:	7f d5                	jg     101135 <printer_vprintf+0x982>
        }
    done: ;
  101160:	90                   	nop
    for (; *format; ++format) {
  101161:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101168:	01 
  101169:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101170:	0f b6 00             	movzbl (%rax),%eax
  101173:	84 c0                	test   %al,%al
  101175:	0f 85 64 f6 ff ff    	jne    1007df <printer_vprintf+0x2c>
    }
}
  10117b:	90                   	nop
  10117c:	90                   	nop
  10117d:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  101181:	c9                   	leave  
  101182:	c3                   	ret    

0000000000101183 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  101183:	55                   	push   %rbp
  101184:	48 89 e5             	mov    %rsp,%rbp
  101187:	48 83 ec 20          	sub    $0x20,%rsp
  10118b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10118f:	89 f0                	mov    %esi,%eax
  101191:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101194:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  101197:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10119b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10119f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011a3:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011a7:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  1011ac:	48 39 d0             	cmp    %rdx,%rax
  1011af:	72 0c                	jb     1011bd <console_putc+0x3a>
        cp->cursor = console;
  1011b1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011b5:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  1011bc:	00 
    }
    if (c == '\n') {
  1011bd:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  1011c1:	75 78                	jne    10123b <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  1011c3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011c7:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011cb:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1011d1:	48 d1 f8             	sar    %rax
  1011d4:	48 89 c1             	mov    %rax,%rcx
  1011d7:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1011de:	66 66 66 
  1011e1:	48 89 c8             	mov    %rcx,%rax
  1011e4:	48 f7 ea             	imul   %rdx
  1011e7:	48 c1 fa 05          	sar    $0x5,%rdx
  1011eb:	48 89 c8             	mov    %rcx,%rax
  1011ee:	48 c1 f8 3f          	sar    $0x3f,%rax
  1011f2:	48 29 c2             	sub    %rax,%rdx
  1011f5:	48 89 d0             	mov    %rdx,%rax
  1011f8:	48 c1 e0 02          	shl    $0x2,%rax
  1011fc:	48 01 d0             	add    %rdx,%rax
  1011ff:	48 c1 e0 04          	shl    $0x4,%rax
  101203:	48 29 c1             	sub    %rax,%rcx
  101206:	48 89 ca             	mov    %rcx,%rdx
  101209:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  10120c:	eb 25                	jmp    101233 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  10120e:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101211:	83 c8 20             	or     $0x20,%eax
  101214:	89 c6                	mov    %eax,%esi
  101216:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10121a:	48 8b 40 08          	mov    0x8(%rax),%rax
  10121e:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101222:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101226:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10122a:	89 f2                	mov    %esi,%edx
  10122c:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  10122f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101233:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101237:	75 d5                	jne    10120e <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101239:	eb 24                	jmp    10125f <console_putc+0xdc>
        *cp->cursor++ = c | color;
  10123b:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  10123f:	8b 55 e0             	mov    -0x20(%rbp),%edx
  101242:	09 d0                	or     %edx,%eax
  101244:	89 c6                	mov    %eax,%esi
  101246:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10124a:	48 8b 40 08          	mov    0x8(%rax),%rax
  10124e:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101252:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101256:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10125a:	89 f2                	mov    %esi,%edx
  10125c:	66 89 10             	mov    %dx,(%rax)
}
  10125f:	90                   	nop
  101260:	c9                   	leave  
  101261:	c3                   	ret    

0000000000101262 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  101262:	55                   	push   %rbp
  101263:	48 89 e5             	mov    %rsp,%rbp
  101266:	48 83 ec 30          	sub    $0x30,%rsp
  10126a:	89 7d ec             	mov    %edi,-0x14(%rbp)
  10126d:	89 75 e8             	mov    %esi,-0x18(%rbp)
  101270:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101274:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  101278:	48 c7 45 f0 83 11 10 	movq   $0x101183,-0x10(%rbp)
  10127f:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101280:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  101284:	78 09                	js     10128f <console_vprintf+0x2d>
  101286:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  10128d:	7e 07                	jle    101296 <console_vprintf+0x34>
        cpos = 0;
  10128f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  101296:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101299:	48 98                	cltq   
  10129b:	48 01 c0             	add    %rax,%rax
  10129e:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  1012a4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1012a8:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1012ac:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1012b0:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1012b3:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  1012b7:	48 89 c7             	mov    %rax,%rdi
  1012ba:	e8 f4 f4 ff ff       	call   1007b3 <printer_vprintf>
    return cp.cursor - console;
  1012bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1012c3:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1012c9:	48 d1 f8             	sar    %rax
}
  1012cc:	c9                   	leave  
  1012cd:	c3                   	ret    

00000000001012ce <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  1012ce:	55                   	push   %rbp
  1012cf:	48 89 e5             	mov    %rsp,%rbp
  1012d2:	48 83 ec 60          	sub    $0x60,%rsp
  1012d6:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1012d9:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1012dc:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1012e0:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1012e4:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1012e8:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1012ec:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1012f3:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1012f7:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1012fb:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1012ff:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101303:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101307:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  10130b:	8b 75 a8             	mov    -0x58(%rbp),%esi
  10130e:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101311:	89 c7                	mov    %eax,%edi
  101313:	e8 4a ff ff ff       	call   101262 <console_vprintf>
  101318:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  10131b:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  10131e:	c9                   	leave  
  10131f:	c3                   	ret    

0000000000101320 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101320:	55                   	push   %rbp
  101321:	48 89 e5             	mov    %rsp,%rbp
  101324:	48 83 ec 20          	sub    $0x20,%rsp
  101328:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10132c:	89 f0                	mov    %esi,%eax
  10132e:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101331:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101334:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101338:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  10133c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101340:	48 8b 50 08          	mov    0x8(%rax),%rdx
  101344:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101348:	48 8b 40 10          	mov    0x10(%rax),%rax
  10134c:	48 39 c2             	cmp    %rax,%rdx
  10134f:	73 1a                	jae    10136b <string_putc+0x4b>
        *sp->s++ = c;
  101351:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101355:	48 8b 40 08          	mov    0x8(%rax),%rax
  101359:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10135d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101361:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101365:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101369:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  10136b:	90                   	nop
  10136c:	c9                   	leave  
  10136d:	c3                   	ret    

000000000010136e <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  10136e:	55                   	push   %rbp
  10136f:	48 89 e5             	mov    %rsp,%rbp
  101372:	48 83 ec 40          	sub    $0x40,%rsp
  101376:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  10137a:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  10137e:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  101382:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101386:	48 c7 45 e8 20 13 10 	movq   $0x101320,-0x18(%rbp)
  10138d:	00 
    sp.s = s;
  10138e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101392:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  101396:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  10139b:	74 33                	je     1013d0 <vsnprintf+0x62>
        sp.end = s + size - 1;
  10139d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1013a1:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1013a5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1013a9:	48 01 d0             	add    %rdx,%rax
  1013ac:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1013b0:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1013b4:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1013b8:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1013bc:	be 00 00 00 00       	mov    $0x0,%esi
  1013c1:	48 89 c7             	mov    %rax,%rdi
  1013c4:	e8 ea f3 ff ff       	call   1007b3 <printer_vprintf>
        *sp.s = 0;
  1013c9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013cd:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1013d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013d4:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1013d8:	c9                   	leave  
  1013d9:	c3                   	ret    

00000000001013da <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1013da:	55                   	push   %rbp
  1013db:	48 89 e5             	mov    %rsp,%rbp
  1013de:	48 83 ec 70          	sub    $0x70,%rsp
  1013e2:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1013e6:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1013ea:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1013ee:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1013f2:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1013f6:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1013fa:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101401:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101405:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101409:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10140d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101411:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101415:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101419:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  10141d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101421:	48 89 c7             	mov    %rax,%rdi
  101424:	e8 45 ff ff ff       	call   10136e <vsnprintf>
  101429:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  10142c:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  10142f:	c9                   	leave  
  101430:	c3                   	ret    

0000000000101431 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101431:	55                   	push   %rbp
  101432:	48 89 e5             	mov    %rsp,%rbp
  101435:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101439:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101440:	eb 13                	jmp    101455 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  101442:	8b 45 fc             	mov    -0x4(%rbp),%eax
  101445:	48 98                	cltq   
  101447:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  10144e:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101451:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101455:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  10145c:	7e e4                	jle    101442 <console_clear+0x11>
    }
    cursorpos = 0;
  10145e:	c7 05 94 7b fb ff 00 	movl   $0x0,-0x4846c(%rip)        # b8ffc <cursorpos>
  101465:	00 00 00 
}
  101468:	90                   	nop
  101469:	c9                   	leave  
  10146a:	c3                   	ret    
