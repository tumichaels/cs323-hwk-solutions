
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
  100037:	e8 a1 06 00 00       	call   1006dd <rand>
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
  10005f:	e8 c7 01 00 00       	call   10022b <malloc>
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
int extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  100113:	48 81 c7 ff 3f 00 00 	add    $0x3fff,%rdi
  10011a:	48 81 e7 00 c0 ff ff 	and    $0xffffffffffffc000,%rdi
  100121:	cd 3a                	int    $0x3a
  100123:	48 89 05 f6 1e 00 00 	mov    %rax,0x1ef6(%rip)        # 102020 <result.0>
	void *bp = sbrk(chunk_aligned_size);
	if (bp == (void *)-1)
  10012a:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  10012e:	74 58                	je     100188 <extend+0x75>
		return -1;

	// setup pointer
	GET_SIZE(HDRP(bp)) = chunk_aligned_size;
  100130:	48 89 78 f0          	mov    %rdi,-0x10(%rax)
	GET_ALLOC(HDRP(bp)) = 0;
  100134:	c7 40 f8 00 00 00 00 	movl   $0x0,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  10013b:	48 8b 15 ce 1e 00 00 	mov    0x1ece(%rip),%rdx        # 102010 <free_list>
  100142:	48 89 10             	mov    %rdx,(%rax)
	PREV_FPTR(bp) = NULL;
  100145:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  10014c:	00 
	GET_SIZE(FTRP(bp)) = GET_SIZE(HDRP(bp));
  10014d:	48 89 7c 07 e0       	mov    %rdi,-0x20(%rdi,%rax,1)

	// add to head of free_list
	if (free_list)
  100152:	48 8b 15 b7 1e 00 00 	mov    0x1eb7(%rip),%rdx        # 102010 <free_list>
  100159:	48 85 d2             	test   %rdx,%rdx
  10015c:	74 04                	je     100162 <extend+0x4f>
		PREV_FPTR(free_list) = bp;
  10015e:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  100162:	48 89 05 a7 1e 00 00 	mov    %rax,0x1ea7(%rip)        # 102010 <free_list>

	// update terminal block
	GET_SIZE(HDRP(NEXT_BLKP(bp))) = 0;
  100169:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  10016d:	48 c7 44 10 f0 00 00 	movq   $0x0,-0x10(%rax,%rdx,1)
  100174:	00 00 
	GET_ALLOC(HDRP(NEXT_BLKP(bp))) = 1;
  100176:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  10017a:	c7 44 10 f8 01 00 00 	movl   $0x1,-0x8(%rax,%rdx,1)
  100181:	00 
	return 0;
  100182:	b8 00 00 00 00       	mov    $0x0,%eax
  100187:	c3                   	ret    
		return -1;
  100188:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10018d:	c3                   	ret    

000000000010018e <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
  10018e:	48 89 f8             	mov    %rdi,%rax
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  100191:	48 8b 57 f0          	mov    -0x10(%rdi),%rdx
  100195:	48 29 f2             	sub    %rsi,%rdx

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  100198:	48 83 fa 30          	cmp    $0x30,%rdx
  10019c:	76 57                	jbe    1001f5 <set_allocated+0x67>
		GET_SIZE(HDRP(bp)) = size;
  10019e:	48 89 77 f0          	mov    %rsi,-0x10(%rdi)
		void *leftover_mem_ptr = NEXT_BLKP(bp);
  1001a2:	48 01 fe             	add    %rdi,%rsi

		GET_SIZE(HDRP(leftover_mem_ptr)) = extra_size;
  1001a5:	48 89 56 f0          	mov    %rdx,-0x10(%rsi)
		GET_ALLOC(HDRP(leftover_mem_ptr)) = 0;
  1001a9:	c7 46 f8 00 00 00 00 	movl   $0x0,-0x8(%rsi)
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp); // pointers to the nearby free blocks
  1001b0:	48 8b 0f             	mov    (%rdi),%rcx
  1001b3:	48 89 0e             	mov    %rcx,(%rsi)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  1001b6:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  1001ba:	48 89 4e 08          	mov    %rcx,0x8(%rsi)
		GET_SIZE(FTRP(leftover_mem_ptr)) = GET_SIZE(HDRP(leftover_mem_ptr));
  1001be:	48 89 54 16 e0       	mov    %rdx,-0x20(%rsi,%rdx,1)

		// update the free list
		if (free_list == bp)
  1001c3:	48 39 3d 46 1e 00 00 	cmp    %rdi,0x1e46(%rip)        # 102010 <free_list>
  1001ca:	74 20                	je     1001ec <set_allocated+0x5e>
			free_list = leftover_mem_ptr;

		if (PREV_FPTR(bp))
  1001cc:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1001d0:	48 85 d2             	test   %rdx,%rdx
  1001d3:	74 03                	je     1001d8 <set_allocated+0x4a>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  1001d5:	48 89 32             	mov    %rsi,(%rdx)
		if (NEXT_FPTR(bp))
  1001d8:	48 8b 10             	mov    (%rax),%rdx
  1001db:	48 85 d2             	test   %rdx,%rdx
  1001de:	74 04                	je     1001e4 <set_allocated+0x56>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  1001e0:	48 89 72 08          	mov    %rsi,0x8(%rdx)
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
		if (NEXT_FPTR(bp))
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
	}
	
	GET_ALLOC(HDRP(bp)) = 1;
  1001e4:	c7 40 f8 01 00 00 00 	movl   $0x1,-0x8(%rax)
}
  1001eb:	c3                   	ret    
			free_list = leftover_mem_ptr;
  1001ec:	48 89 35 1d 1e 00 00 	mov    %rsi,0x1e1d(%rip)        # 102010 <free_list>
  1001f3:	eb d7                	jmp    1001cc <set_allocated+0x3e>
		if (free_list == bp)
  1001f5:	48 39 3d 14 1e 00 00 	cmp    %rdi,0x1e14(%rip)        # 102010 <free_list>
  1001fc:	74 21                	je     10021f <set_allocated+0x91>
		if (PREV_FPTR(bp))
  1001fe:	48 8b 50 08          	mov    0x8(%rax),%rdx
  100202:	48 85 d2             	test   %rdx,%rdx
  100205:	74 06                	je     10020d <set_allocated+0x7f>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  100207:	48 8b 08             	mov    (%rax),%rcx
  10020a:	48 89 0a             	mov    %rcx,(%rdx)
		if (NEXT_FPTR(bp))
  10020d:	48 8b 10             	mov    (%rax),%rdx
  100210:	48 85 d2             	test   %rdx,%rdx
  100213:	74 cf                	je     1001e4 <set_allocated+0x56>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  100215:	48 8b 48 08          	mov    0x8(%rax),%rcx
  100219:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10021d:	eb c5                	jmp    1001e4 <set_allocated+0x56>
			free_list = NEXT_FPTR(bp);
  10021f:	48 8b 17             	mov    (%rdi),%rdx
  100222:	48 89 15 e7 1d 00 00 	mov    %rdx,0x1de7(%rip)        # 102010 <free_list>
  100229:	eb d3                	jmp    1001fe <set_allocated+0x70>

000000000010022b <malloc>:

void *malloc(uint64_t numbytes) {
  10022b:	55                   	push   %rbp
  10022c:	48 89 e5             	mov    %rsp,%rbp
  10022f:	41 55                	push   %r13
  100231:	41 54                	push   %r12
  100233:	53                   	push   %rbx
  100234:	48 83 ec 08          	sub    $0x8,%rsp
  100238:	49 89 fc             	mov    %rdi,%r12
	if (!initialized_heap)
  10023b:	83 3d d6 1d 00 00 00 	cmpl   $0x0,0x1dd6(%rip)        # 102018 <initialized_heap>
  100242:	74 60                	je     1002a4 <malloc+0x79>
		heap_init();

	if (numbytes == 0)
  100244:	4d 85 e4             	test   %r12,%r12
  100247:	74 7b                	je     1002c4 <malloc+0x99>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  100249:	49 83 c4 1f          	add    $0x1f,%r12
  10024d:	49 83 e4 f0          	and    $0xfffffffffffffff0,%r12
  100251:	b8 30 00 00 00       	mov    $0x30,%eax
  100256:	49 39 c4             	cmp    %rax,%r12
  100259:	4c 0f 42 e0          	cmovb  %rax,%r12
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);

	void *bp = free_list;
  10025d:	48 8b 1d ac 1d 00 00 	mov    0x1dac(%rip),%rbx        # 102010 <free_list>
	while (bp) {
  100264:	48 85 db             	test   %rbx,%rbx
  100267:	74 0e                	je     100277 <malloc+0x4c>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  100269:	4c 39 63 f0          	cmp    %r12,-0x10(%rbx)
  10026d:	73 3c                	jae    1002ab <malloc+0x80>
			set_allocated(bp, aligned_size);
			return bp;
		}

		bp = NEXT_FPTR(bp);
  10026f:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  100272:	48 85 db             	test   %rbx,%rbx
  100275:	75 f2                	jne    100269 <malloc+0x3e>
  100277:	bf 00 00 00 00       	mov    $0x0,%edi
  10027c:	cd 3a                	int    $0x3a
  10027e:	49 89 c5             	mov    %rax,%r13
  100281:	48 89 05 98 1d 00 00 	mov    %rax,0x1d98(%rip)        # 102020 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  100288:	48 89 c3             	mov    %rax,%rbx
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	if (extend(aligned_size)) {
  10028b:	4c 89 e7             	mov    %r12,%rdi
  10028e:	e8 80 fe ff ff       	call   100113 <extend>
  100293:	85 c0                	test   %eax,%eax
  100295:	75 34                	jne    1002cb <malloc+0xa0>
		return NULL;
	}
	set_allocated(bp, aligned_size);
  100297:	4c 89 e6             	mov    %r12,%rsi
  10029a:	4c 89 ef             	mov    %r13,%rdi
  10029d:	e8 ec fe ff ff       	call   10018e <set_allocated>
    return bp;
  1002a2:	eb 12                	jmp    1002b6 <malloc+0x8b>
		heap_init();
  1002a4:	e8 c8 fd ff ff       	call   100071 <heap_init>
  1002a9:	eb 99                	jmp    100244 <malloc+0x19>
			set_allocated(bp, aligned_size);
  1002ab:	4c 89 e6             	mov    %r12,%rsi
  1002ae:	48 89 df             	mov    %rbx,%rdi
  1002b1:	e8 d8 fe ff ff       	call   10018e <set_allocated>
}
  1002b6:	48 89 d8             	mov    %rbx,%rax
  1002b9:	48 83 c4 08          	add    $0x8,%rsp
  1002bd:	5b                   	pop    %rbx
  1002be:	41 5c                	pop    %r12
  1002c0:	41 5d                	pop    %r13
  1002c2:	5d                   	pop    %rbp
  1002c3:	c3                   	ret    
		return NULL;
  1002c4:	bb 00 00 00 00       	mov    $0x0,%ebx
  1002c9:	eb eb                	jmp    1002b6 <malloc+0x8b>
		return NULL;
  1002cb:	bb 00 00 00 00       	mov    $0x0,%ebx
  1002d0:	eb e4                	jmp    1002b6 <malloc+0x8b>

00000000001002d2 <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  1002d2:	55                   	push   %rbp
  1002d3:	48 89 e5             	mov    %rsp,%rbp
  1002d6:	41 54                	push   %r12
  1002d8:	53                   	push   %rbx
	void *bp = malloc(num * sz);
  1002d9:	48 0f af fe          	imul   %rsi,%rdi
  1002dd:	49 89 fc             	mov    %rdi,%r12
  1002e0:	e8 46 ff ff ff       	call   10022b <malloc>
  1002e5:	48 89 c3             	mov    %rax,%rbx
	memset(bp, 0, num * sz);
  1002e8:	4c 89 e2             	mov    %r12,%rdx
  1002eb:	be 00 00 00 00       	mov    $0x0,%esi
  1002f0:	48 89 c7             	mov    %rax,%rdi
  1002f3:	e8 28 02 00 00       	call   100520 <memset>
	return bp;
}
  1002f8:	48 89 d8             	mov    %rbx,%rax
  1002fb:	5b                   	pop    %rbx
  1002fc:	41 5c                	pop    %r12
  1002fe:	5d                   	pop    %rbp
  1002ff:	c3                   	ret    

0000000000100300 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  100300:	55                   	push   %rbp
  100301:	48 89 e5             	mov    %rsp,%rbp
  100304:	41 54                	push   %r12
  100306:	53                   	push   %rbx
  100307:	48 89 fb             	mov    %rdi,%rbx
	// first check if there's enough space in the block already
	if (GET_SIZE(HDRP(ptr)) >= sz)
  10030a:	48 39 77 f0          	cmp    %rsi,-0x10(%rdi)
  10030e:	72 08                	jb     100318 <realloc+0x18>
	void *bigger_ptr = malloc(sz);
	memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
	free(ptr);

    return bigger_ptr;
}
  100310:	48 89 d8             	mov    %rbx,%rax
  100313:	5b                   	pop    %rbx
  100314:	41 5c                	pop    %r12
  100316:	5d                   	pop    %rbp
  100317:	c3                   	ret    
	void *bigger_ptr = malloc(sz);
  100318:	48 89 f7             	mov    %rsi,%rdi
  10031b:	e8 0b ff ff ff       	call   10022b <malloc>
  100320:	49 89 c4             	mov    %rax,%r12
	memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
  100323:	48 8b 53 f0          	mov    -0x10(%rbx),%rdx
  100327:	48 89 de             	mov    %rbx,%rsi
  10032a:	48 89 c7             	mov    %rax,%rdi
  10032d:	e8 f0 00 00 00       	call   100422 <memcpy>
	free(ptr);
  100332:	48 89 df             	mov    %rbx,%rdi
  100335:	e8 9f fd ff ff       	call   1000d9 <free>
    return bigger_ptr;
  10033a:	4c 89 e3             	mov    %r12,%rbx
  10033d:	eb d1                	jmp    100310 <realloc+0x10>

000000000010033f <defrag>:

void defrag() {
	void *fp = free_list;
  10033f:	48 8b 05 ca 1c 00 00 	mov    0x1cca(%rip),%rax        # 102010 <free_list>
	while (fp != NULL) {
  100346:	48 85 c0             	test   %rax,%rax
  100349:	75 3a                	jne    100385 <defrag+0x46>
			GET_SIZE(FTRP(prev_block)) = GET_SIZE(HDRP(prev_block));
		}

		fp = NEXT_FPTR(fp);
	}
}
  10034b:	c3                   	ret    
				free_list = NEXT_FPTR(next_block);
  10034c:	48 8b 0a             	mov    (%rdx),%rcx
  10034f:	48 89 0d ba 1c 00 00 	mov    %rcx,0x1cba(%rip)        # 102010 <free_list>
  100356:	eb 43                	jmp    10039b <defrag+0x5c>
			fp = NEXT_FPTR(fp);
  100358:	48 8b 00             	mov    (%rax),%rax
			continue;
  10035b:	eb 23                	jmp    100380 <defrag+0x41>
				free_list = NEXT_FPTR(fp);
  10035d:	48 8b 08             	mov    (%rax),%rcx
  100360:	48 89 0d a9 1c 00 00 	mov    %rcx,0x1ca9(%rip)        # 102010 <free_list>
  100367:	e9 88 00 00 00       	jmp    1003f4 <defrag+0xb5>
			GET_SIZE(HDRP(prev_block)) = GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp));
  10036c:	48 8b 48 f0          	mov    -0x10(%rax),%rcx
  100370:	48 03 4a f0          	add    -0x10(%rdx),%rcx
  100374:	48 89 4a f0          	mov    %rcx,-0x10(%rdx)
			GET_SIZE(FTRP(prev_block)) = GET_SIZE(HDRP(prev_block));
  100378:	48 89 4c 0a e0       	mov    %rcx,-0x20(%rdx,%rcx,1)
		fp = NEXT_FPTR(fp);
  10037d:	48 8b 00             	mov    (%rax),%rax
	while (fp != NULL) {
  100380:	48 85 c0             	test   %rax,%rax
  100383:	74 c6                	je     10034b <defrag+0xc>
		void *next_block = NEXT_BLKP(fp);
  100385:	48 89 c2             	mov    %rax,%rdx
  100388:	48 03 50 f0          	add    -0x10(%rax),%rdx
		if (!GET_ALLOC(HDRP(next_block))) {
  10038c:	83 7a f8 00          	cmpl   $0x0,-0x8(%rdx)
  100390:	75 39                	jne    1003cb <defrag+0x8c>
			if (free_list == next_block)
  100392:	48 39 15 77 1c 00 00 	cmp    %rdx,0x1c77(%rip)        # 102010 <free_list>
  100399:	74 b1                	je     10034c <defrag+0xd>
			if (PREV_FPTR(next_block)) 
  10039b:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  10039f:	48 85 c9             	test   %rcx,%rcx
  1003a2:	74 06                	je     1003aa <defrag+0x6b>
				NEXT_FPTR(PREV_FPTR(next_block)) = NEXT_FPTR(next_block);
  1003a4:	48 8b 32             	mov    (%rdx),%rsi
  1003a7:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(next_block)) 
  1003aa:	48 8b 0a             	mov    (%rdx),%rcx
  1003ad:	48 85 c9             	test   %rcx,%rcx
  1003b0:	74 08                	je     1003ba <defrag+0x7b>
				PREV_FPTR(NEXT_FPTR(next_block)) = PREV_FPTR(next_block);
  1003b2:	48 8b 72 08          	mov    0x8(%rdx),%rsi
  1003b6:	48 89 71 08          	mov    %rsi,0x8(%rcx)
			GET_SIZE(HDRP(fp)) = GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block));
  1003ba:	48 8b 52 f0          	mov    -0x10(%rdx),%rdx
  1003be:	48 03 50 f0          	add    -0x10(%rax),%rdx
  1003c2:	48 89 50 f0          	mov    %rdx,-0x10(%rax)
			GET_SIZE(FTRP(fp)) = GET_SIZE(HDRP(fp));
  1003c6:	48 89 54 10 e0       	mov    %rdx,-0x20(%rax,%rdx,1)
		void *prev_block = PREV_BLKP(fp);
  1003cb:	48 89 c2             	mov    %rax,%rdx
  1003ce:	48 2b 50 e0          	sub    -0x20(%rax),%rdx
		if (GET_SIZE(HDRP(prev_block)) != GET_SIZE(FTRP(prev_block))){
  1003d2:	48 8b 4a f0          	mov    -0x10(%rdx),%rcx
  1003d6:	48 3b 4c 0a e0       	cmp    -0x20(%rdx,%rcx,1),%rcx
  1003db:	0f 85 77 ff ff ff    	jne    100358 <defrag+0x19>
		if (!GET_ALLOC(HDRP(prev_block))) {
  1003e1:	83 7a f8 00          	cmpl   $0x0,-0x8(%rdx)
  1003e5:	75 96                	jne    10037d <defrag+0x3e>
			if (free_list == fp)
  1003e7:	48 39 05 22 1c 00 00 	cmp    %rax,0x1c22(%rip)        # 102010 <free_list>
  1003ee:	0f 84 69 ff ff ff    	je     10035d <defrag+0x1e>
			if (PREV_FPTR(fp)) 
  1003f4:	48 8b 48 08          	mov    0x8(%rax),%rcx
  1003f8:	48 85 c9             	test   %rcx,%rcx
  1003fb:	74 06                	je     100403 <defrag+0xc4>
				NEXT_FPTR(PREV_FPTR(fp)) = NEXT_FPTR(fp);
  1003fd:	48 8b 30             	mov    (%rax),%rsi
  100400:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(fp)) 
  100403:	48 8b 08             	mov    (%rax),%rcx
  100406:	48 85 c9             	test   %rcx,%rcx
  100409:	0f 84 5d ff ff ff    	je     10036c <defrag+0x2d>
				PREV_FPTR(NEXT_FPTR(fp)) = PREV_FPTR(fp);
  10040f:	48 8b 70 08          	mov    0x8(%rax),%rsi
  100413:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  100417:	e9 50 ff ff ff       	jmp    10036c <defrag+0x2d>

000000000010041c <heap_info>:

int heap_info(heap_info_struct *info) {
    return 0;
}
  10041c:	b8 00 00 00 00       	mov    $0x0,%eax
  100421:	c3                   	ret    

0000000000100422 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100422:	55                   	push   %rbp
  100423:	48 89 e5             	mov    %rsp,%rbp
  100426:	48 83 ec 28          	sub    $0x28,%rsp
  10042a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10042e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100432:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100436:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10043a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  10043e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100442:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100446:	eb 1c                	jmp    100464 <memcpy+0x42>
        *d = *s;
  100448:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10044c:	0f b6 10             	movzbl (%rax),%edx
  10044f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100453:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100455:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10045a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10045f:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100464:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100469:	75 dd                	jne    100448 <memcpy+0x26>
    }
    return dst;
  10046b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10046f:	c9                   	leave  
  100470:	c3                   	ret    

0000000000100471 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100471:	55                   	push   %rbp
  100472:	48 89 e5             	mov    %rsp,%rbp
  100475:	48 83 ec 28          	sub    $0x28,%rsp
  100479:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10047d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100481:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100485:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100489:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  10048d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100491:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100495:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100499:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  10049d:	73 6a                	jae    100509 <memmove+0x98>
  10049f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1004a3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1004a7:	48 01 d0             	add    %rdx,%rax
  1004aa:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1004ae:	73 59                	jae    100509 <memmove+0x98>
        s += n, d += n;
  1004b0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1004b4:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1004b8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1004bc:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1004c0:	eb 17                	jmp    1004d9 <memmove+0x68>
            *--d = *--s;
  1004c2:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1004c7:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1004cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004d0:	0f b6 10             	movzbl (%rax),%edx
  1004d3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004d7:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1004d9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1004dd:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1004e1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1004e5:	48 85 c0             	test   %rax,%rax
  1004e8:	75 d8                	jne    1004c2 <memmove+0x51>
    if (s < d && s + n > d) {
  1004ea:	eb 2e                	jmp    10051a <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1004ec:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1004f0:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1004f4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1004f8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004fc:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100500:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100504:	0f b6 12             	movzbl (%rdx),%edx
  100507:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100509:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10050d:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100511:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100515:	48 85 c0             	test   %rax,%rax
  100518:	75 d2                	jne    1004ec <memmove+0x7b>
        }
    }
    return dst;
  10051a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10051e:	c9                   	leave  
  10051f:	c3                   	ret    

0000000000100520 <memset>:

void* memset(void* v, int c, size_t n) {
  100520:	55                   	push   %rbp
  100521:	48 89 e5             	mov    %rsp,%rbp
  100524:	48 83 ec 28          	sub    $0x28,%rsp
  100528:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10052c:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  10052f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100533:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100537:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10053b:	eb 15                	jmp    100552 <memset+0x32>
        *p = c;
  10053d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100540:	89 c2                	mov    %eax,%edx
  100542:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100546:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100548:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10054d:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100552:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100557:	75 e4                	jne    10053d <memset+0x1d>
    }
    return v;
  100559:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10055d:	c9                   	leave  
  10055e:	c3                   	ret    

000000000010055f <strlen>:

size_t strlen(const char* s) {
  10055f:	55                   	push   %rbp
  100560:	48 89 e5             	mov    %rsp,%rbp
  100563:	48 83 ec 18          	sub    $0x18,%rsp
  100567:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  10056b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100572:	00 
  100573:	eb 0a                	jmp    10057f <strlen+0x20>
        ++n;
  100575:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  10057a:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  10057f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100583:	0f b6 00             	movzbl (%rax),%eax
  100586:	84 c0                	test   %al,%al
  100588:	75 eb                	jne    100575 <strlen+0x16>
    }
    return n;
  10058a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  10058e:	c9                   	leave  
  10058f:	c3                   	ret    

0000000000100590 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100590:	55                   	push   %rbp
  100591:	48 89 e5             	mov    %rsp,%rbp
  100594:	48 83 ec 20          	sub    $0x20,%rsp
  100598:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10059c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1005a0:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1005a7:	00 
  1005a8:	eb 0a                	jmp    1005b4 <strnlen+0x24>
        ++n;
  1005aa:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1005af:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1005b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005b8:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  1005bc:	74 0b                	je     1005c9 <strnlen+0x39>
  1005be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1005c2:	0f b6 00             	movzbl (%rax),%eax
  1005c5:	84 c0                	test   %al,%al
  1005c7:	75 e1                	jne    1005aa <strnlen+0x1a>
    }
    return n;
  1005c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1005cd:	c9                   	leave  
  1005ce:	c3                   	ret    

00000000001005cf <strcpy>:

char* strcpy(char* dst, const char* src) {
  1005cf:	55                   	push   %rbp
  1005d0:	48 89 e5             	mov    %rsp,%rbp
  1005d3:	48 83 ec 20          	sub    $0x20,%rsp
  1005d7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1005db:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1005df:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1005e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1005e7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1005eb:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1005ef:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1005f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005f7:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1005fb:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  1005ff:	0f b6 12             	movzbl (%rdx),%edx
  100602:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100604:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100608:	48 83 e8 01          	sub    $0x1,%rax
  10060c:	0f b6 00             	movzbl (%rax),%eax
  10060f:	84 c0                	test   %al,%al
  100611:	75 d4                	jne    1005e7 <strcpy+0x18>
    return dst;
  100613:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100617:	c9                   	leave  
  100618:	c3                   	ret    

0000000000100619 <strcmp>:

int strcmp(const char* a, const char* b) {
  100619:	55                   	push   %rbp
  10061a:	48 89 e5             	mov    %rsp,%rbp
  10061d:	48 83 ec 10          	sub    $0x10,%rsp
  100621:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100625:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100629:	eb 0a                	jmp    100635 <strcmp+0x1c>
        ++a, ++b;
  10062b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100630:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100635:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100639:	0f b6 00             	movzbl (%rax),%eax
  10063c:	84 c0                	test   %al,%al
  10063e:	74 1d                	je     10065d <strcmp+0x44>
  100640:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100644:	0f b6 00             	movzbl (%rax),%eax
  100647:	84 c0                	test   %al,%al
  100649:	74 12                	je     10065d <strcmp+0x44>
  10064b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10064f:	0f b6 10             	movzbl (%rax),%edx
  100652:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100656:	0f b6 00             	movzbl (%rax),%eax
  100659:	38 c2                	cmp    %al,%dl
  10065b:	74 ce                	je     10062b <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  10065d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100661:	0f b6 00             	movzbl (%rax),%eax
  100664:	89 c2                	mov    %eax,%edx
  100666:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10066a:	0f b6 00             	movzbl (%rax),%eax
  10066d:	38 d0                	cmp    %dl,%al
  10066f:	0f 92 c0             	setb   %al
  100672:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100675:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100679:	0f b6 00             	movzbl (%rax),%eax
  10067c:	89 c1                	mov    %eax,%ecx
  10067e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100682:	0f b6 00             	movzbl (%rax),%eax
  100685:	38 c1                	cmp    %al,%cl
  100687:	0f 92 c0             	setb   %al
  10068a:	0f b6 c0             	movzbl %al,%eax
  10068d:	29 c2                	sub    %eax,%edx
  10068f:	89 d0                	mov    %edx,%eax
}
  100691:	c9                   	leave  
  100692:	c3                   	ret    

0000000000100693 <strchr>:

char* strchr(const char* s, int c) {
  100693:	55                   	push   %rbp
  100694:	48 89 e5             	mov    %rsp,%rbp
  100697:	48 83 ec 10          	sub    $0x10,%rsp
  10069b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  10069f:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1006a2:	eb 05                	jmp    1006a9 <strchr+0x16>
        ++s;
  1006a4:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1006a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006ad:	0f b6 00             	movzbl (%rax),%eax
  1006b0:	84 c0                	test   %al,%al
  1006b2:	74 0e                	je     1006c2 <strchr+0x2f>
  1006b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006b8:	0f b6 00             	movzbl (%rax),%eax
  1006bb:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1006be:	38 d0                	cmp    %dl,%al
  1006c0:	75 e2                	jne    1006a4 <strchr+0x11>
    }
    if (*s == (char) c) {
  1006c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006c6:	0f b6 00             	movzbl (%rax),%eax
  1006c9:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1006cc:	38 d0                	cmp    %dl,%al
  1006ce:	75 06                	jne    1006d6 <strchr+0x43>
        return (char*) s;
  1006d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006d4:	eb 05                	jmp    1006db <strchr+0x48>
    } else {
        return NULL;
  1006d6:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1006db:	c9                   	leave  
  1006dc:	c3                   	ret    

00000000001006dd <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1006dd:	55                   	push   %rbp
  1006de:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1006e1:	8b 05 41 19 00 00    	mov    0x1941(%rip),%eax        # 102028 <rand_seed_set>
  1006e7:	85 c0                	test   %eax,%eax
  1006e9:	75 0a                	jne    1006f5 <rand+0x18>
        srand(819234718U);
  1006eb:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1006f0:	e8 24 00 00 00       	call   100719 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1006f5:	8b 05 31 19 00 00    	mov    0x1931(%rip),%eax        # 10202c <rand_seed>
  1006fb:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100701:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100706:	89 05 20 19 00 00    	mov    %eax,0x1920(%rip)        # 10202c <rand_seed>
    return rand_seed & RAND_MAX;
  10070c:	8b 05 1a 19 00 00    	mov    0x191a(%rip),%eax        # 10202c <rand_seed>
  100712:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100717:	5d                   	pop    %rbp
  100718:	c3                   	ret    

0000000000100719 <srand>:

void srand(unsigned seed) {
  100719:	55                   	push   %rbp
  10071a:	48 89 e5             	mov    %rsp,%rbp
  10071d:	48 83 ec 08          	sub    $0x8,%rsp
  100721:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100724:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100727:	89 05 ff 18 00 00    	mov    %eax,0x18ff(%rip)        # 10202c <rand_seed>
    rand_seed_set = 1;
  10072d:	c7 05 f1 18 00 00 01 	movl   $0x1,0x18f1(%rip)        # 102028 <rand_seed_set>
  100734:	00 00 00 
}
  100737:	90                   	nop
  100738:	c9                   	leave  
  100739:	c3                   	ret    

000000000010073a <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  10073a:	55                   	push   %rbp
  10073b:	48 89 e5             	mov    %rsp,%rbp
  10073e:	48 83 ec 28          	sub    $0x28,%rsp
  100742:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100746:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10074a:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  10074d:	48 c7 45 f8 60 16 10 	movq   $0x101660,-0x8(%rbp)
  100754:	00 
    if (base < 0) {
  100755:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100759:	79 0b                	jns    100766 <fill_numbuf+0x2c>
        digits = lower_digits;
  10075b:	48 c7 45 f8 80 16 10 	movq   $0x101680,-0x8(%rbp)
  100762:	00 
        base = -base;
  100763:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100766:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10076b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10076f:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100772:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100775:	48 63 c8             	movslq %eax,%rcx
  100778:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10077c:	ba 00 00 00 00       	mov    $0x0,%edx
  100781:	48 f7 f1             	div    %rcx
  100784:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100788:	48 01 d0             	add    %rdx,%rax
  10078b:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100790:	0f b6 10             	movzbl (%rax),%edx
  100793:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100797:	88 10                	mov    %dl,(%rax)
        val /= base;
  100799:	8b 45 dc             	mov    -0x24(%rbp),%eax
  10079c:	48 63 f0             	movslq %eax,%rsi
  10079f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1007a3:	ba 00 00 00 00       	mov    $0x0,%edx
  1007a8:	48 f7 f6             	div    %rsi
  1007ab:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  1007af:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  1007b4:	75 bc                	jne    100772 <fill_numbuf+0x38>
    return numbuf_end;
  1007b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1007ba:	c9                   	leave  
  1007bb:	c3                   	ret    

00000000001007bc <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1007bc:	55                   	push   %rbp
  1007bd:	48 89 e5             	mov    %rsp,%rbp
  1007c0:	53                   	push   %rbx
  1007c1:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  1007c8:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1007cf:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1007d5:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1007dc:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1007e3:	e9 8a 09 00 00       	jmp    101172 <printer_vprintf+0x9b6>
        if (*format != '%') {
  1007e8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007ef:	0f b6 00             	movzbl (%rax),%eax
  1007f2:	3c 25                	cmp    $0x25,%al
  1007f4:	74 31                	je     100827 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  1007f6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1007fd:	4c 8b 00             	mov    (%rax),%r8
  100800:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100807:	0f b6 00             	movzbl (%rax),%eax
  10080a:	0f b6 c8             	movzbl %al,%ecx
  10080d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100813:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10081a:	89 ce                	mov    %ecx,%esi
  10081c:	48 89 c7             	mov    %rax,%rdi
  10081f:	41 ff d0             	call   *%r8
            continue;
  100822:	e9 43 09 00 00       	jmp    10116a <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100827:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  10082e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100835:	01 
  100836:	eb 44                	jmp    10087c <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  100838:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10083f:	0f b6 00             	movzbl (%rax),%eax
  100842:	0f be c0             	movsbl %al,%eax
  100845:	89 c6                	mov    %eax,%esi
  100847:	bf 80 14 10 00       	mov    $0x101480,%edi
  10084c:	e8 42 fe ff ff       	call   100693 <strchr>
  100851:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100855:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  10085a:	74 30                	je     10088c <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  10085c:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100860:	48 2d 80 14 10 00    	sub    $0x101480,%rax
  100866:	ba 01 00 00 00       	mov    $0x1,%edx
  10086b:	89 c1                	mov    %eax,%ecx
  10086d:	d3 e2                	shl    %cl,%edx
  10086f:	89 d0                	mov    %edx,%eax
  100871:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100874:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10087b:	01 
  10087c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100883:	0f b6 00             	movzbl (%rax),%eax
  100886:	84 c0                	test   %al,%al
  100888:	75 ae                	jne    100838 <printer_vprintf+0x7c>
  10088a:	eb 01                	jmp    10088d <printer_vprintf+0xd1>
            } else {
                break;
  10088c:	90                   	nop
            }
        }

        // process width
        int width = -1;
  10088d:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100894:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10089b:	0f b6 00             	movzbl (%rax),%eax
  10089e:	3c 30                	cmp    $0x30,%al
  1008a0:	7e 67                	jle    100909 <printer_vprintf+0x14d>
  1008a2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008a9:	0f b6 00             	movzbl (%rax),%eax
  1008ac:	3c 39                	cmp    $0x39,%al
  1008ae:	7f 59                	jg     100909 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1008b0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  1008b7:	eb 2e                	jmp    1008e7 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  1008b9:	8b 55 e8             	mov    -0x18(%rbp),%edx
  1008bc:	89 d0                	mov    %edx,%eax
  1008be:	c1 e0 02             	shl    $0x2,%eax
  1008c1:	01 d0                	add    %edx,%eax
  1008c3:	01 c0                	add    %eax,%eax
  1008c5:	89 c1                	mov    %eax,%ecx
  1008c7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008ce:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1008d2:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1008d9:	0f b6 00             	movzbl (%rax),%eax
  1008dc:	0f be c0             	movsbl %al,%eax
  1008df:	01 c8                	add    %ecx,%eax
  1008e1:	83 e8 30             	sub    $0x30,%eax
  1008e4:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1008e7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008ee:	0f b6 00             	movzbl (%rax),%eax
  1008f1:	3c 2f                	cmp    $0x2f,%al
  1008f3:	0f 8e 85 00 00 00    	jle    10097e <printer_vprintf+0x1c2>
  1008f9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100900:	0f b6 00             	movzbl (%rax),%eax
  100903:	3c 39                	cmp    $0x39,%al
  100905:	7e b2                	jle    1008b9 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100907:	eb 75                	jmp    10097e <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100909:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100910:	0f b6 00             	movzbl (%rax),%eax
  100913:	3c 2a                	cmp    $0x2a,%al
  100915:	75 68                	jne    10097f <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100917:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10091e:	8b 00                	mov    (%rax),%eax
  100920:	83 f8 2f             	cmp    $0x2f,%eax
  100923:	77 30                	ja     100955 <printer_vprintf+0x199>
  100925:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10092c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100930:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100937:	8b 00                	mov    (%rax),%eax
  100939:	89 c0                	mov    %eax,%eax
  10093b:	48 01 d0             	add    %rdx,%rax
  10093e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100945:	8b 12                	mov    (%rdx),%edx
  100947:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10094a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100951:	89 0a                	mov    %ecx,(%rdx)
  100953:	eb 1a                	jmp    10096f <printer_vprintf+0x1b3>
  100955:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10095c:	48 8b 40 08          	mov    0x8(%rax),%rax
  100960:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100964:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10096b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10096f:	8b 00                	mov    (%rax),%eax
  100971:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100974:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10097b:	01 
  10097c:	eb 01                	jmp    10097f <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  10097e:	90                   	nop
        }

        // process precision
        int precision = -1;
  10097f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100986:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10098d:	0f b6 00             	movzbl (%rax),%eax
  100990:	3c 2e                	cmp    $0x2e,%al
  100992:	0f 85 00 01 00 00    	jne    100a98 <printer_vprintf+0x2dc>
            ++format;
  100998:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10099f:	01 
            if (*format >= '0' && *format <= '9') {
  1009a0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009a7:	0f b6 00             	movzbl (%rax),%eax
  1009aa:	3c 2f                	cmp    $0x2f,%al
  1009ac:	7e 67                	jle    100a15 <printer_vprintf+0x259>
  1009ae:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009b5:	0f b6 00             	movzbl (%rax),%eax
  1009b8:	3c 39                	cmp    $0x39,%al
  1009ba:	7f 59                	jg     100a15 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1009bc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  1009c3:	eb 2e                	jmp    1009f3 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  1009c5:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  1009c8:	89 d0                	mov    %edx,%eax
  1009ca:	c1 e0 02             	shl    $0x2,%eax
  1009cd:	01 d0                	add    %edx,%eax
  1009cf:	01 c0                	add    %eax,%eax
  1009d1:	89 c1                	mov    %eax,%ecx
  1009d3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009da:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1009de:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1009e5:	0f b6 00             	movzbl (%rax),%eax
  1009e8:	0f be c0             	movsbl %al,%eax
  1009eb:	01 c8                	add    %ecx,%eax
  1009ed:	83 e8 30             	sub    $0x30,%eax
  1009f0:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1009f3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009fa:	0f b6 00             	movzbl (%rax),%eax
  1009fd:	3c 2f                	cmp    $0x2f,%al
  1009ff:	0f 8e 85 00 00 00    	jle    100a8a <printer_vprintf+0x2ce>
  100a05:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a0c:	0f b6 00             	movzbl (%rax),%eax
  100a0f:	3c 39                	cmp    $0x39,%al
  100a11:	7e b2                	jle    1009c5 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100a13:	eb 75                	jmp    100a8a <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100a15:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a1c:	0f b6 00             	movzbl (%rax),%eax
  100a1f:	3c 2a                	cmp    $0x2a,%al
  100a21:	75 68                	jne    100a8b <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100a23:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a2a:	8b 00                	mov    (%rax),%eax
  100a2c:	83 f8 2f             	cmp    $0x2f,%eax
  100a2f:	77 30                	ja     100a61 <printer_vprintf+0x2a5>
  100a31:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a38:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a3c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a43:	8b 00                	mov    (%rax),%eax
  100a45:	89 c0                	mov    %eax,%eax
  100a47:	48 01 d0             	add    %rdx,%rax
  100a4a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a51:	8b 12                	mov    (%rdx),%edx
  100a53:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a56:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a5d:	89 0a                	mov    %ecx,(%rdx)
  100a5f:	eb 1a                	jmp    100a7b <printer_vprintf+0x2bf>
  100a61:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a68:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a6c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a70:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a77:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a7b:	8b 00                	mov    (%rax),%eax
  100a7d:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100a80:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100a87:	01 
  100a88:	eb 01                	jmp    100a8b <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100a8a:	90                   	nop
            }
            if (precision < 0) {
  100a8b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100a8f:	79 07                	jns    100a98 <printer_vprintf+0x2dc>
                precision = 0;
  100a91:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100a98:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100a9f:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100aa6:	00 
        int length = 0;
  100aa7:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100aae:	48 c7 45 c8 86 14 10 	movq   $0x101486,-0x38(%rbp)
  100ab5:	00 
    again:
        switch (*format) {
  100ab6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100abd:	0f b6 00             	movzbl (%rax),%eax
  100ac0:	0f be c0             	movsbl %al,%eax
  100ac3:	83 e8 43             	sub    $0x43,%eax
  100ac6:	83 f8 37             	cmp    $0x37,%eax
  100ac9:	0f 87 9f 03 00 00    	ja     100e6e <printer_vprintf+0x6b2>
  100acf:	89 c0                	mov    %eax,%eax
  100ad1:	48 8b 04 c5 98 14 10 	mov    0x101498(,%rax,8),%rax
  100ad8:	00 
  100ad9:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100adb:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100ae2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ae9:	01 
            goto again;
  100aea:	eb ca                	jmp    100ab6 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100aec:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100af0:	74 5d                	je     100b4f <printer_vprintf+0x393>
  100af2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100af9:	8b 00                	mov    (%rax),%eax
  100afb:	83 f8 2f             	cmp    $0x2f,%eax
  100afe:	77 30                	ja     100b30 <printer_vprintf+0x374>
  100b00:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b07:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b0b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b12:	8b 00                	mov    (%rax),%eax
  100b14:	89 c0                	mov    %eax,%eax
  100b16:	48 01 d0             	add    %rdx,%rax
  100b19:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b20:	8b 12                	mov    (%rdx),%edx
  100b22:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b25:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b2c:	89 0a                	mov    %ecx,(%rdx)
  100b2e:	eb 1a                	jmp    100b4a <printer_vprintf+0x38e>
  100b30:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b37:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b3b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b3f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b46:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b4a:	48 8b 00             	mov    (%rax),%rax
  100b4d:	eb 5c                	jmp    100bab <printer_vprintf+0x3ef>
  100b4f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b56:	8b 00                	mov    (%rax),%eax
  100b58:	83 f8 2f             	cmp    $0x2f,%eax
  100b5b:	77 30                	ja     100b8d <printer_vprintf+0x3d1>
  100b5d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b64:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b68:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b6f:	8b 00                	mov    (%rax),%eax
  100b71:	89 c0                	mov    %eax,%eax
  100b73:	48 01 d0             	add    %rdx,%rax
  100b76:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b7d:	8b 12                	mov    (%rdx),%edx
  100b7f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b82:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b89:	89 0a                	mov    %ecx,(%rdx)
  100b8b:	eb 1a                	jmp    100ba7 <printer_vprintf+0x3eb>
  100b8d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b94:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b98:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b9c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ba3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ba7:	8b 00                	mov    (%rax),%eax
  100ba9:	48 98                	cltq   
  100bab:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100baf:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100bb3:	48 c1 f8 38          	sar    $0x38,%rax
  100bb7:	25 80 00 00 00       	and    $0x80,%eax
  100bbc:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100bbf:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100bc3:	74 09                	je     100bce <printer_vprintf+0x412>
  100bc5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100bc9:	48 f7 d8             	neg    %rax
  100bcc:	eb 04                	jmp    100bd2 <printer_vprintf+0x416>
  100bce:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100bd2:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100bd6:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100bd9:	83 c8 60             	or     $0x60,%eax
  100bdc:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100bdf:	e9 cf 02 00 00       	jmp    100eb3 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100be4:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100be8:	74 5d                	je     100c47 <printer_vprintf+0x48b>
  100bea:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bf1:	8b 00                	mov    (%rax),%eax
  100bf3:	83 f8 2f             	cmp    $0x2f,%eax
  100bf6:	77 30                	ja     100c28 <printer_vprintf+0x46c>
  100bf8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bff:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c03:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c0a:	8b 00                	mov    (%rax),%eax
  100c0c:	89 c0                	mov    %eax,%eax
  100c0e:	48 01 d0             	add    %rdx,%rax
  100c11:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c18:	8b 12                	mov    (%rdx),%edx
  100c1a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c1d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c24:	89 0a                	mov    %ecx,(%rdx)
  100c26:	eb 1a                	jmp    100c42 <printer_vprintf+0x486>
  100c28:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c2f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c33:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c37:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c3e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c42:	48 8b 00             	mov    (%rax),%rax
  100c45:	eb 5c                	jmp    100ca3 <printer_vprintf+0x4e7>
  100c47:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c4e:	8b 00                	mov    (%rax),%eax
  100c50:	83 f8 2f             	cmp    $0x2f,%eax
  100c53:	77 30                	ja     100c85 <printer_vprintf+0x4c9>
  100c55:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c5c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c60:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c67:	8b 00                	mov    (%rax),%eax
  100c69:	89 c0                	mov    %eax,%eax
  100c6b:	48 01 d0             	add    %rdx,%rax
  100c6e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c75:	8b 12                	mov    (%rdx),%edx
  100c77:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c7a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c81:	89 0a                	mov    %ecx,(%rdx)
  100c83:	eb 1a                	jmp    100c9f <printer_vprintf+0x4e3>
  100c85:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c8c:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c90:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c94:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c9b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c9f:	8b 00                	mov    (%rax),%eax
  100ca1:	89 c0                	mov    %eax,%eax
  100ca3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100ca7:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100cab:	e9 03 02 00 00       	jmp    100eb3 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100cb0:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100cb7:	e9 28 ff ff ff       	jmp    100be4 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100cbc:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100cc3:	e9 1c ff ff ff       	jmp    100be4 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100cc8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ccf:	8b 00                	mov    (%rax),%eax
  100cd1:	83 f8 2f             	cmp    $0x2f,%eax
  100cd4:	77 30                	ja     100d06 <printer_vprintf+0x54a>
  100cd6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cdd:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ce1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ce8:	8b 00                	mov    (%rax),%eax
  100cea:	89 c0                	mov    %eax,%eax
  100cec:	48 01 d0             	add    %rdx,%rax
  100cef:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cf6:	8b 12                	mov    (%rdx),%edx
  100cf8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100cfb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d02:	89 0a                	mov    %ecx,(%rdx)
  100d04:	eb 1a                	jmp    100d20 <printer_vprintf+0x564>
  100d06:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d0d:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d11:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d15:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d1c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d20:	48 8b 00             	mov    (%rax),%rax
  100d23:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100d27:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100d2e:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100d35:	e9 79 01 00 00       	jmp    100eb3 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100d3a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d41:	8b 00                	mov    (%rax),%eax
  100d43:	83 f8 2f             	cmp    $0x2f,%eax
  100d46:	77 30                	ja     100d78 <printer_vprintf+0x5bc>
  100d48:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d4f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d53:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d5a:	8b 00                	mov    (%rax),%eax
  100d5c:	89 c0                	mov    %eax,%eax
  100d5e:	48 01 d0             	add    %rdx,%rax
  100d61:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d68:	8b 12                	mov    (%rdx),%edx
  100d6a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d6d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d74:	89 0a                	mov    %ecx,(%rdx)
  100d76:	eb 1a                	jmp    100d92 <printer_vprintf+0x5d6>
  100d78:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d7f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d83:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d87:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d8e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d92:	48 8b 00             	mov    (%rax),%rax
  100d95:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100d99:	e9 15 01 00 00       	jmp    100eb3 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100d9e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100da5:	8b 00                	mov    (%rax),%eax
  100da7:	83 f8 2f             	cmp    $0x2f,%eax
  100daa:	77 30                	ja     100ddc <printer_vprintf+0x620>
  100dac:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100db3:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100db7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dbe:	8b 00                	mov    (%rax),%eax
  100dc0:	89 c0                	mov    %eax,%eax
  100dc2:	48 01 d0             	add    %rdx,%rax
  100dc5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dcc:	8b 12                	mov    (%rdx),%edx
  100dce:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100dd1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dd8:	89 0a                	mov    %ecx,(%rdx)
  100dda:	eb 1a                	jmp    100df6 <printer_vprintf+0x63a>
  100ddc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100de3:	48 8b 40 08          	mov    0x8(%rax),%rax
  100de7:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100deb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100df2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100df6:	8b 00                	mov    (%rax),%eax
  100df8:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100dfe:	e9 67 03 00 00       	jmp    10116a <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  100e03:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100e07:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100e0b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e12:	8b 00                	mov    (%rax),%eax
  100e14:	83 f8 2f             	cmp    $0x2f,%eax
  100e17:	77 30                	ja     100e49 <printer_vprintf+0x68d>
  100e19:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e20:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e24:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e2b:	8b 00                	mov    (%rax),%eax
  100e2d:	89 c0                	mov    %eax,%eax
  100e2f:	48 01 d0             	add    %rdx,%rax
  100e32:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e39:	8b 12                	mov    (%rdx),%edx
  100e3b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e3e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e45:	89 0a                	mov    %ecx,(%rdx)
  100e47:	eb 1a                	jmp    100e63 <printer_vprintf+0x6a7>
  100e49:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e50:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e54:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e58:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e5f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e63:	8b 00                	mov    (%rax),%eax
  100e65:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100e68:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100e6c:	eb 45                	jmp    100eb3 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  100e6e:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100e72:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100e76:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e7d:	0f b6 00             	movzbl (%rax),%eax
  100e80:	84 c0                	test   %al,%al
  100e82:	74 0c                	je     100e90 <printer_vprintf+0x6d4>
  100e84:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e8b:	0f b6 00             	movzbl (%rax),%eax
  100e8e:	eb 05                	jmp    100e95 <printer_vprintf+0x6d9>
  100e90:	b8 25 00 00 00       	mov    $0x25,%eax
  100e95:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100e98:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100e9c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ea3:	0f b6 00             	movzbl (%rax),%eax
  100ea6:	84 c0                	test   %al,%al
  100ea8:	75 08                	jne    100eb2 <printer_vprintf+0x6f6>
                format--;
  100eaa:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100eb1:	01 
            }
            break;
  100eb2:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100eb3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100eb6:	83 e0 20             	and    $0x20,%eax
  100eb9:	85 c0                	test   %eax,%eax
  100ebb:	74 1e                	je     100edb <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100ebd:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100ec1:	48 83 c0 18          	add    $0x18,%rax
  100ec5:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100ec8:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100ecc:	48 89 ce             	mov    %rcx,%rsi
  100ecf:	48 89 c7             	mov    %rax,%rdi
  100ed2:	e8 63 f8 ff ff       	call   10073a <fill_numbuf>
  100ed7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100edb:	48 c7 45 c0 86 14 10 	movq   $0x101486,-0x40(%rbp)
  100ee2:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100ee3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ee6:	83 e0 20             	and    $0x20,%eax
  100ee9:	85 c0                	test   %eax,%eax
  100eeb:	74 48                	je     100f35 <printer_vprintf+0x779>
  100eed:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ef0:	83 e0 40             	and    $0x40,%eax
  100ef3:	85 c0                	test   %eax,%eax
  100ef5:	74 3e                	je     100f35 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  100ef7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100efa:	25 80 00 00 00       	and    $0x80,%eax
  100eff:	85 c0                	test   %eax,%eax
  100f01:	74 0a                	je     100f0d <printer_vprintf+0x751>
                prefix = "-";
  100f03:	48 c7 45 c0 87 14 10 	movq   $0x101487,-0x40(%rbp)
  100f0a:	00 
            if (flags & FLAG_NEGATIVE) {
  100f0b:	eb 73                	jmp    100f80 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100f0d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f10:	83 e0 10             	and    $0x10,%eax
  100f13:	85 c0                	test   %eax,%eax
  100f15:	74 0a                	je     100f21 <printer_vprintf+0x765>
                prefix = "+";
  100f17:	48 c7 45 c0 89 14 10 	movq   $0x101489,-0x40(%rbp)
  100f1e:	00 
            if (flags & FLAG_NEGATIVE) {
  100f1f:	eb 5f                	jmp    100f80 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100f21:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f24:	83 e0 08             	and    $0x8,%eax
  100f27:	85 c0                	test   %eax,%eax
  100f29:	74 55                	je     100f80 <printer_vprintf+0x7c4>
                prefix = " ";
  100f2b:	48 c7 45 c0 8b 14 10 	movq   $0x10148b,-0x40(%rbp)
  100f32:	00 
            if (flags & FLAG_NEGATIVE) {
  100f33:	eb 4b                	jmp    100f80 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100f35:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f38:	83 e0 20             	and    $0x20,%eax
  100f3b:	85 c0                	test   %eax,%eax
  100f3d:	74 42                	je     100f81 <printer_vprintf+0x7c5>
  100f3f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f42:	83 e0 01             	and    $0x1,%eax
  100f45:	85 c0                	test   %eax,%eax
  100f47:	74 38                	je     100f81 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  100f49:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100f4d:	74 06                	je     100f55 <printer_vprintf+0x799>
  100f4f:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100f53:	75 2c                	jne    100f81 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  100f55:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100f5a:	75 0c                	jne    100f68 <printer_vprintf+0x7ac>
  100f5c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f5f:	25 00 01 00 00       	and    $0x100,%eax
  100f64:	85 c0                	test   %eax,%eax
  100f66:	74 19                	je     100f81 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  100f68:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100f6c:	75 07                	jne    100f75 <printer_vprintf+0x7b9>
  100f6e:	b8 8d 14 10 00       	mov    $0x10148d,%eax
  100f73:	eb 05                	jmp    100f7a <printer_vprintf+0x7be>
  100f75:	b8 90 14 10 00       	mov    $0x101490,%eax
  100f7a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100f7e:	eb 01                	jmp    100f81 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  100f80:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100f81:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100f85:	78 24                	js     100fab <printer_vprintf+0x7ef>
  100f87:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f8a:	83 e0 20             	and    $0x20,%eax
  100f8d:	85 c0                	test   %eax,%eax
  100f8f:	75 1a                	jne    100fab <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  100f91:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100f94:	48 63 d0             	movslq %eax,%rdx
  100f97:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100f9b:	48 89 d6             	mov    %rdx,%rsi
  100f9e:	48 89 c7             	mov    %rax,%rdi
  100fa1:	e8 ea f5 ff ff       	call   100590 <strnlen>
  100fa6:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100fa9:	eb 0f                	jmp    100fba <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  100fab:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100faf:	48 89 c7             	mov    %rax,%rdi
  100fb2:	e8 a8 f5 ff ff       	call   10055f <strlen>
  100fb7:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100fba:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fbd:	83 e0 20             	and    $0x20,%eax
  100fc0:	85 c0                	test   %eax,%eax
  100fc2:	74 20                	je     100fe4 <printer_vprintf+0x828>
  100fc4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100fc8:	78 1a                	js     100fe4 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  100fca:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100fcd:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100fd0:	7e 08                	jle    100fda <printer_vprintf+0x81e>
  100fd2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100fd5:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100fd8:	eb 05                	jmp    100fdf <printer_vprintf+0x823>
  100fda:	b8 00 00 00 00       	mov    $0x0,%eax
  100fdf:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100fe2:	eb 5c                	jmp    101040 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100fe4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fe7:	83 e0 20             	and    $0x20,%eax
  100fea:	85 c0                	test   %eax,%eax
  100fec:	74 4b                	je     101039 <printer_vprintf+0x87d>
  100fee:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ff1:	83 e0 02             	and    $0x2,%eax
  100ff4:	85 c0                	test   %eax,%eax
  100ff6:	74 41                	je     101039 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100ff8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ffb:	83 e0 04             	and    $0x4,%eax
  100ffe:	85 c0                	test   %eax,%eax
  101000:	75 37                	jne    101039 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  101002:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101006:	48 89 c7             	mov    %rax,%rdi
  101009:	e8 51 f5 ff ff       	call   10055f <strlen>
  10100e:	89 c2                	mov    %eax,%edx
  101010:	8b 45 bc             	mov    -0x44(%rbp),%eax
  101013:	01 d0                	add    %edx,%eax
  101015:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  101018:	7e 1f                	jle    101039 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  10101a:	8b 45 e8             	mov    -0x18(%rbp),%eax
  10101d:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101020:	89 c3                	mov    %eax,%ebx
  101022:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101026:	48 89 c7             	mov    %rax,%rdi
  101029:	e8 31 f5 ff ff       	call   10055f <strlen>
  10102e:	89 c2                	mov    %eax,%edx
  101030:	89 d8                	mov    %ebx,%eax
  101032:	29 d0                	sub    %edx,%eax
  101034:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101037:	eb 07                	jmp    101040 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  101039:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  101040:	8b 55 bc             	mov    -0x44(%rbp),%edx
  101043:	8b 45 b8             	mov    -0x48(%rbp),%eax
  101046:	01 d0                	add    %edx,%eax
  101048:	48 63 d8             	movslq %eax,%rbx
  10104b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10104f:	48 89 c7             	mov    %rax,%rdi
  101052:	e8 08 f5 ff ff       	call   10055f <strlen>
  101057:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  10105b:	8b 45 e8             	mov    -0x18(%rbp),%eax
  10105e:	29 d0                	sub    %edx,%eax
  101060:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101063:	eb 25                	jmp    10108a <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  101065:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10106c:	48 8b 08             	mov    (%rax),%rcx
  10106f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101075:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10107c:	be 20 00 00 00       	mov    $0x20,%esi
  101081:	48 89 c7             	mov    %rax,%rdi
  101084:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101086:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  10108a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10108d:	83 e0 04             	and    $0x4,%eax
  101090:	85 c0                	test   %eax,%eax
  101092:	75 36                	jne    1010ca <printer_vprintf+0x90e>
  101094:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101098:	7f cb                	jg     101065 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  10109a:	eb 2e                	jmp    1010ca <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  10109c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010a3:	4c 8b 00             	mov    (%rax),%r8
  1010a6:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1010aa:	0f b6 00             	movzbl (%rax),%eax
  1010ad:	0f b6 c8             	movzbl %al,%ecx
  1010b0:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1010b6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010bd:	89 ce                	mov    %ecx,%esi
  1010bf:	48 89 c7             	mov    %rax,%rdi
  1010c2:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  1010c5:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  1010ca:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1010ce:	0f b6 00             	movzbl (%rax),%eax
  1010d1:	84 c0                	test   %al,%al
  1010d3:	75 c7                	jne    10109c <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  1010d5:	eb 25                	jmp    1010fc <printer_vprintf+0x940>
            p->putc(p, '0', color);
  1010d7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010de:	48 8b 08             	mov    (%rax),%rcx
  1010e1:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1010e7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010ee:	be 30 00 00 00       	mov    $0x30,%esi
  1010f3:	48 89 c7             	mov    %rax,%rdi
  1010f6:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  1010f8:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  1010fc:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  101100:	7f d5                	jg     1010d7 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  101102:	eb 32                	jmp    101136 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  101104:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10110b:	4c 8b 00             	mov    (%rax),%r8
  10110e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101112:	0f b6 00             	movzbl (%rax),%eax
  101115:	0f b6 c8             	movzbl %al,%ecx
  101118:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10111e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101125:	89 ce                	mov    %ecx,%esi
  101127:	48 89 c7             	mov    %rax,%rdi
  10112a:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  10112d:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  101132:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  101136:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  10113a:	7f c8                	jg     101104 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  10113c:	eb 25                	jmp    101163 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  10113e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101145:	48 8b 08             	mov    (%rax),%rcx
  101148:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10114e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101155:	be 20 00 00 00       	mov    $0x20,%esi
  10115a:	48 89 c7             	mov    %rax,%rdi
  10115d:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  10115f:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101163:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101167:	7f d5                	jg     10113e <printer_vprintf+0x982>
        }
    done: ;
  101169:	90                   	nop
    for (; *format; ++format) {
  10116a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101171:	01 
  101172:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101179:	0f b6 00             	movzbl (%rax),%eax
  10117c:	84 c0                	test   %al,%al
  10117e:	0f 85 64 f6 ff ff    	jne    1007e8 <printer_vprintf+0x2c>
    }
}
  101184:	90                   	nop
  101185:	90                   	nop
  101186:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  10118a:	c9                   	leave  
  10118b:	c3                   	ret    

000000000010118c <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  10118c:	55                   	push   %rbp
  10118d:	48 89 e5             	mov    %rsp,%rbp
  101190:	48 83 ec 20          	sub    $0x20,%rsp
  101194:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101198:	89 f0                	mov    %esi,%eax
  10119a:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10119d:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  1011a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1011a4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1011a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011ac:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011b0:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  1011b5:	48 39 d0             	cmp    %rdx,%rax
  1011b8:	72 0c                	jb     1011c6 <console_putc+0x3a>
        cp->cursor = console;
  1011ba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011be:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  1011c5:	00 
    }
    if (c == '\n') {
  1011c6:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  1011ca:	75 78                	jne    101244 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  1011cc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011d0:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011d4:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1011da:	48 d1 f8             	sar    %rax
  1011dd:	48 89 c1             	mov    %rax,%rcx
  1011e0:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1011e7:	66 66 66 
  1011ea:	48 89 c8             	mov    %rcx,%rax
  1011ed:	48 f7 ea             	imul   %rdx
  1011f0:	48 c1 fa 05          	sar    $0x5,%rdx
  1011f4:	48 89 c8             	mov    %rcx,%rax
  1011f7:	48 c1 f8 3f          	sar    $0x3f,%rax
  1011fb:	48 29 c2             	sub    %rax,%rdx
  1011fe:	48 89 d0             	mov    %rdx,%rax
  101201:	48 c1 e0 02          	shl    $0x2,%rax
  101205:	48 01 d0             	add    %rdx,%rax
  101208:	48 c1 e0 04          	shl    $0x4,%rax
  10120c:	48 29 c1             	sub    %rax,%rcx
  10120f:	48 89 ca             	mov    %rcx,%rdx
  101212:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101215:	eb 25                	jmp    10123c <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  101217:	8b 45 e0             	mov    -0x20(%rbp),%eax
  10121a:	83 c8 20             	or     $0x20,%eax
  10121d:	89 c6                	mov    %eax,%esi
  10121f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101223:	48 8b 40 08          	mov    0x8(%rax),%rax
  101227:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10122b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  10122f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101233:	89 f2                	mov    %esi,%edx
  101235:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  101238:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10123c:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101240:	75 d5                	jne    101217 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101242:	eb 24                	jmp    101268 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  101244:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  101248:	8b 55 e0             	mov    -0x20(%rbp),%edx
  10124b:	09 d0                	or     %edx,%eax
  10124d:	89 c6                	mov    %eax,%esi
  10124f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101253:	48 8b 40 08          	mov    0x8(%rax),%rax
  101257:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10125b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  10125f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101263:	89 f2                	mov    %esi,%edx
  101265:	66 89 10             	mov    %dx,(%rax)
}
  101268:	90                   	nop
  101269:	c9                   	leave  
  10126a:	c3                   	ret    

000000000010126b <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  10126b:	55                   	push   %rbp
  10126c:	48 89 e5             	mov    %rsp,%rbp
  10126f:	48 83 ec 30          	sub    $0x30,%rsp
  101273:	89 7d ec             	mov    %edi,-0x14(%rbp)
  101276:	89 75 e8             	mov    %esi,-0x18(%rbp)
  101279:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  10127d:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  101281:	48 c7 45 f0 8c 11 10 	movq   $0x10118c,-0x10(%rbp)
  101288:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101289:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  10128d:	78 09                	js     101298 <console_vprintf+0x2d>
  10128f:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101296:	7e 07                	jle    10129f <console_vprintf+0x34>
        cpos = 0;
  101298:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  10129f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1012a2:	48 98                	cltq   
  1012a4:	48 01 c0             	add    %rax,%rax
  1012a7:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  1012ad:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1012b1:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1012b5:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1012b9:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1012bc:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  1012c0:	48 89 c7             	mov    %rax,%rdi
  1012c3:	e8 f4 f4 ff ff       	call   1007bc <printer_vprintf>
    return cp.cursor - console;
  1012c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1012cc:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1012d2:	48 d1 f8             	sar    %rax
}
  1012d5:	c9                   	leave  
  1012d6:	c3                   	ret    

00000000001012d7 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  1012d7:	55                   	push   %rbp
  1012d8:	48 89 e5             	mov    %rsp,%rbp
  1012db:	48 83 ec 60          	sub    $0x60,%rsp
  1012df:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1012e2:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1012e5:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1012e9:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1012ed:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1012f1:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1012f5:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1012fc:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101300:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101304:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101308:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  10130c:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101310:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101314:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101317:	8b 45 ac             	mov    -0x54(%rbp),%eax
  10131a:	89 c7                	mov    %eax,%edi
  10131c:	e8 4a ff ff ff       	call   10126b <console_vprintf>
  101321:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101324:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101327:	c9                   	leave  
  101328:	c3                   	ret    

0000000000101329 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101329:	55                   	push   %rbp
  10132a:	48 89 e5             	mov    %rsp,%rbp
  10132d:	48 83 ec 20          	sub    $0x20,%rsp
  101331:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101335:	89 f0                	mov    %esi,%eax
  101337:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10133a:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  10133d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101341:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101345:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101349:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10134d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101351:	48 8b 40 10          	mov    0x10(%rax),%rax
  101355:	48 39 c2             	cmp    %rax,%rdx
  101358:	73 1a                	jae    101374 <string_putc+0x4b>
        *sp->s++ = c;
  10135a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10135e:	48 8b 40 08          	mov    0x8(%rax),%rax
  101362:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101366:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10136a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10136e:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101372:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101374:	90                   	nop
  101375:	c9                   	leave  
  101376:	c3                   	ret    

0000000000101377 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101377:	55                   	push   %rbp
  101378:	48 89 e5             	mov    %rsp,%rbp
  10137b:	48 83 ec 40          	sub    $0x40,%rsp
  10137f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101383:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101387:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  10138b:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  10138f:	48 c7 45 e8 29 13 10 	movq   $0x101329,-0x18(%rbp)
  101396:	00 
    sp.s = s;
  101397:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10139b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  10139f:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1013a4:	74 33                	je     1013d9 <vsnprintf+0x62>
        sp.end = s + size - 1;
  1013a6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1013aa:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1013ae:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1013b2:	48 01 d0             	add    %rdx,%rax
  1013b5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1013b9:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1013bd:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1013c1:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1013c5:	be 00 00 00 00       	mov    $0x0,%esi
  1013ca:	48 89 c7             	mov    %rax,%rdi
  1013cd:	e8 ea f3 ff ff       	call   1007bc <printer_vprintf>
        *sp.s = 0;
  1013d2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013d6:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1013d9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013dd:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1013e1:	c9                   	leave  
  1013e2:	c3                   	ret    

00000000001013e3 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1013e3:	55                   	push   %rbp
  1013e4:	48 89 e5             	mov    %rsp,%rbp
  1013e7:	48 83 ec 70          	sub    $0x70,%rsp
  1013eb:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1013ef:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1013f3:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1013f7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1013fb:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1013ff:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101403:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  10140a:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10140e:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101412:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101416:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  10141a:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  10141e:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101422:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101426:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10142a:	48 89 c7             	mov    %rax,%rdi
  10142d:	e8 45 ff ff ff       	call   101377 <vsnprintf>
  101432:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101435:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101438:	c9                   	leave  
  101439:	c3                   	ret    

000000000010143a <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  10143a:	55                   	push   %rbp
  10143b:	48 89 e5             	mov    %rsp,%rbp
  10143e:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101442:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101449:	eb 13                	jmp    10145e <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  10144b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10144e:	48 98                	cltq   
  101450:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  101457:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10145a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10145e:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101465:	7e e4                	jle    10144b <console_clear+0x11>
    }
    cursorpos = 0;
  101467:	c7 05 8b 7b fb ff 00 	movl   $0x0,-0x48475(%rip)        # b8ffc <cursorpos>
  10146e:	00 00 00 
}
  101471:	90                   	nop
  101472:	c9                   	leave  
  101473:	c3                   	ret    
