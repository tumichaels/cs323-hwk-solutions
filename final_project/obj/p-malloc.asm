
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
  10000d:	b8 37 30 10 00       	mov    $0x103037,%eax
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
  100037:	e8 48 09 00 00       	call   100984 <rand>
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
  10005f:	e8 df 01 00 00       	call   100243 <malloc>
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
  100078:	48 89 05 a9 1f 00 00 	mov    %rax,0x1fa9(%rip)        # 102028 <result.0>
  10007f:	bf 08 00 00 00       	mov    $0x8,%edi
  100084:	cd 3a                	int    $0x3a
  100086:	48 89 05 9b 1f 00 00 	mov    %rax,0x1f9b(%rip)        # 102028 <result.0>
// want to try and optimize this 
void heap_init(void) {

	// prologue block
	sbrk(sizeof(block_header) + sizeof(block_header));
	prologue_block = sbrk(sizeof(block_footer));
  10008d:	48 89 05 84 1f 00 00 	mov    %rax,0x1f84(%rip)        # 102018 <prologue_block>
	PUT(HDRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  100094:	48 c7 40 f8 11 00 00 	movq   $0x11,-0x8(%rax)
  10009b:	00 
	PUT(FTRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  10009c:	48 8b 15 75 1f 00 00 	mov    0x1f75(%rip),%rdx        # 102018 <prologue_block>
  1000a3:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  1000a7:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  1000ab:	48 c7 44 02 f0 11 00 	movq   $0x11,-0x10(%rdx,%rax,1)
  1000b2:	00 00 
  1000b4:	cd 3a                	int    $0x3a
  1000b6:	48 89 05 6b 1f 00 00 	mov    %rax,0x1f6b(%rip)        # 102028 <result.0>

	// terminal block
	sbrk(sizeof(block_header));
	PUT(HDRP(NEXT_BLKP(prologue_block)), PACK(0, 1));	
  1000bd:	48 8b 15 54 1f 00 00 	mov    0x1f54(%rip),%rdx        # 102018 <prologue_block>
  1000c4:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  1000c8:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  1000cc:	48 c7 44 02 f8 01 00 	movq   $0x1,-0x8(%rdx,%rax,1)
  1000d3:	00 00 

	free_list = NULL;
  1000d5:	48 c7 05 30 1f 00 00 	movq   $0x0,0x1f30(%rip)        # 102010 <free_list>
  1000dc:	00 00 00 00 

	initialized_heap = 1;
  1000e0:	c7 05 36 1f 00 00 01 	movl   $0x1,0x1f36(%rip)        # 102020 <initialized_heap>
  1000e7:	00 00 00 
}
  1000ea:	c3                   	ret    

00000000001000eb <free>:

void free(void *firstbyte) {
	if (firstbyte == NULL)
  1000eb:	48 85 ff             	test   %rdi,%rdi
  1000ee:	74 35                	je     100125 <free+0x3a>
		return;

	// setup free things: alloc, list ptrs, footer
	PUT(HDRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  1000f0:	48 8b 47 f8          	mov    -0x8(%rdi),%rax
  1000f4:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  1000f8:	48 89 47 f8          	mov    %rax,-0x8(%rdi)
	NEXT_FPTR(firstbyte) = free_list;
  1000fc:	48 8b 15 0d 1f 00 00 	mov    0x1f0d(%rip),%rdx        # 102010 <free_list>
  100103:	48 89 17             	mov    %rdx,(%rdi)
	PREV_FPTR(firstbyte) = NULL;
  100106:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  10010d:	00 
	PUT(FTRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  10010e:	48 89 44 07 f0       	mov    %rax,-0x10(%rdi,%rax,1)

	// add to free_list
	PREV_FPTR(free_list) = firstbyte;
  100113:	48 8b 05 f6 1e 00 00 	mov    0x1ef6(%rip),%rax        # 102010 <free_list>
  10011a:	48 89 78 08          	mov    %rdi,0x8(%rax)
	free_list = firstbyte;
  10011e:	48 89 3d eb 1e 00 00 	mov    %rdi,0x1eeb(%rip)        # 102010 <free_list>

	return;
}
  100125:	c3                   	ret    

0000000000100126 <extend>:
//
//	the reason allocating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
int extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  100126:	48 81 c7 ff ff 00 00 	add    $0xffff,%rdi
  10012d:	66 bf 00 00          	mov    $0x0,%di
  100131:	cd 3a                	int    $0x3a
  100133:	48 89 05 ee 1e 00 00 	mov    %rax,0x1eee(%rip)        # 102028 <result.0>
	void *bp = sbrk(chunk_aligned_size);
	if (bp == (void *)-1)
  10013a:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  10013e:	74 49                	je     100189 <extend+0x63>
		return -1;

	// setup pointer
	PUT(HDRP(bp), PACK(chunk_aligned_size, 0));	
  100140:	48 89 78 f8          	mov    %rdi,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  100144:	48 8b 15 c5 1e 00 00 	mov    0x1ec5(%rip),%rdx        # 102010 <free_list>
  10014b:	48 89 10             	mov    %rdx,(%rax)
	PREV_FPTR(bp) = NULL;
  10014e:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  100155:	00 
	PUT(FTRP(bp), PACK(chunk_aligned_size, 0));	
  100156:	48 89 7c 07 f0       	mov    %rdi,-0x10(%rdi,%rax,1)
	
	// add to head of free_list
	if (free_list)
  10015b:	48 8b 15 ae 1e 00 00 	mov    0x1eae(%rip),%rdx        # 102010 <free_list>
  100162:	48 85 d2             	test   %rdx,%rdx
  100165:	74 04                	je     10016b <extend+0x45>
		PREV_FPTR(free_list) = bp;
  100167:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  10016b:	48 89 05 9e 1e 00 00 	mov    %rax,0x1e9e(%rip)        # 102010 <free_list>

	// update terminal block
	PUT(HDRP(NEXT_BLKP(bp)), PACK(0, 1));	
  100172:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  100176:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  10017a:	48 c7 44 10 f8 01 00 	movq   $0x1,-0x8(%rax,%rdx,1)
  100181:	00 00 

	return 0;
  100183:	b8 00 00 00 00       	mov    $0x0,%eax
  100188:	c3                   	ret    
		return -1;
  100189:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10018e:	c3                   	ret    

000000000010018f <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
  10018f:	48 89 f8             	mov    %rdi,%rax
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  100192:	48 8b 57 f8          	mov    -0x8(%rdi),%rdx
  100196:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  10019a:	48 29 f2             	sub    %rsi,%rdx

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  10019d:	48 83 fa 20          	cmp    $0x20,%rdx
  1001a1:	76 5b                	jbe    1001fe <set_allocated+0x6f>
		PUT(HDRP(bp), PACK(size, 1));
  1001a3:	48 89 f1             	mov    %rsi,%rcx
  1001a6:	48 83 c9 01          	or     $0x1,%rcx
  1001aa:	48 89 4f f8          	mov    %rcx,-0x8(%rdi)

		void *leftover_mem_ptr = NEXT_BLKP(bp);
  1001ae:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  1001b2:	48 01 fe             	add    %rdi,%rsi

		PUT(HDRP(leftover_mem_ptr), PACK(extra_size, 0));	
  1001b5:	48 89 56 f8          	mov    %rdx,-0x8(%rsi)
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp); // pointers to the next free blocks
  1001b9:	48 8b 0f             	mov    (%rdi),%rcx
  1001bc:	48 89 0e             	mov    %rcx,(%rsi)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  1001bf:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  1001c3:	48 89 4e 08          	mov    %rcx,0x8(%rsi)
		PUT(FTRP(leftover_mem_ptr), PACK(extra_size, 0));	
  1001c7:	48 89 d1             	mov    %rdx,%rcx
  1001ca:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  1001ce:	48 89 54 0e f0       	mov    %rdx,-0x10(%rsi,%rcx,1)

		// update the free list
		if (free_list == bp)
  1001d3:	48 39 3d 36 1e 00 00 	cmp    %rdi,0x1e36(%rip)        # 102010 <free_list>
  1001da:	74 19                	je     1001f5 <set_allocated+0x66>
			free_list = leftover_mem_ptr;

		if (PREV_FPTR(bp))
  1001dc:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1001e0:	48 85 d2             	test   %rdx,%rdx
  1001e3:	74 03                	je     1001e8 <set_allocated+0x59>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  1001e5:	48 89 32             	mov    %rsi,(%rdx)

		if (NEXT_FPTR(bp))
  1001e8:	48 8b 00             	mov    (%rax),%rax
  1001eb:	48 85 c0             	test   %rax,%rax
  1001ee:	74 46                	je     100236 <set_allocated+0xa7>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  1001f0:	48 89 70 08          	mov    %rsi,0x8(%rax)
  1001f4:	c3                   	ret    
			free_list = leftover_mem_ptr;
  1001f5:	48 89 35 14 1e 00 00 	mov    %rsi,0x1e14(%rip)        # 102010 <free_list>
  1001fc:	eb de                	jmp    1001dc <set_allocated+0x4d>
								    
	}
	else {
		// update the free list
		if (free_list == bp)
  1001fe:	48 39 3d 0b 1e 00 00 	cmp    %rdi,0x1e0b(%rip)        # 102010 <free_list>
  100205:	74 30                	je     100237 <set_allocated+0xa8>
			free_list = NEXT_FPTR(bp);

		if (PREV_FPTR(bp))
  100207:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10020b:	48 85 d2             	test   %rdx,%rdx
  10020e:	74 06                	je     100216 <set_allocated+0x87>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  100210:	48 8b 08             	mov    (%rax),%rcx
  100213:	48 89 0a             	mov    %rcx,(%rdx)
		if (NEXT_FPTR(bp))
  100216:	48 8b 10             	mov    (%rax),%rdx
  100219:	48 85 d2             	test   %rdx,%rdx
  10021c:	74 08                	je     100226 <set_allocated+0x97>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  10021e:	48 8b 48 08          	mov    0x8(%rax),%rcx
  100222:	48 89 4a 08          	mov    %rcx,0x8(%rdx)

		PUT(HDRP(bp), PACK(GET_SIZE(HDRP(bp)), 1));	
  100226:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  10022a:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  10022e:	48 83 ca 01          	or     $0x1,%rdx
  100232:	48 89 50 f8          	mov    %rdx,-0x8(%rax)
	}
}
  100236:	c3                   	ret    
			free_list = NEXT_FPTR(bp);
  100237:	48 8b 17             	mov    (%rdi),%rdx
  10023a:	48 89 15 cf 1d 00 00 	mov    %rdx,0x1dcf(%rip)        # 102010 <free_list>
  100241:	eb c4                	jmp    100207 <set_allocated+0x78>

0000000000100243 <malloc>:

void *malloc(uint64_t numbytes) {
  100243:	55                   	push   %rbp
  100244:	48 89 e5             	mov    %rsp,%rbp
  100247:	41 55                	push   %r13
  100249:	41 54                	push   %r12
  10024b:	53                   	push   %rbx
  10024c:	48 83 ec 08          	sub    $0x8,%rsp
  100250:	49 89 fc             	mov    %rdi,%r12
	if (!initialized_heap)
  100253:	83 3d c6 1d 00 00 00 	cmpl   $0x0,0x1dc6(%rip)        # 102020 <initialized_heap>
  10025a:	74 6b                	je     1002c7 <malloc+0x84>
		heap_init();

	if (numbytes == 0)
  10025c:	4d 85 e4             	test   %r12,%r12
  10025f:	0f 84 82 00 00 00    	je     1002e7 <malloc+0xa4>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  100265:	49 83 c4 17          	add    $0x17,%r12
  100269:	49 83 e4 f0          	and    $0xfffffffffffffff0,%r12
  10026d:	b8 20 00 00 00       	mov    $0x20,%eax
  100272:	49 39 c4             	cmp    %rax,%r12
  100275:	4c 0f 42 e0          	cmovb  %rax,%r12
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);
	
	void *bp = free_list;
  100279:	48 8b 1d 90 1d 00 00 	mov    0x1d90(%rip),%rbx        # 102010 <free_list>
	while (bp) {
  100280:	48 85 db             	test   %rbx,%rbx
  100283:	74 15                	je     10029a <malloc+0x57>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  100285:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  100289:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  10028d:	4c 39 e0             	cmp    %r12,%rax
  100290:	73 3c                	jae    1002ce <malloc+0x8b>
			set_allocated(bp, aligned_size);
			return bp;
		}

		bp = NEXT_FPTR(bp);
  100292:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  100295:	48 85 db             	test   %rbx,%rbx
  100298:	75 eb                	jne    100285 <malloc+0x42>
  10029a:	bf 00 00 00 00       	mov    $0x0,%edi
  10029f:	cd 3a                	int    $0x3a
  1002a1:	49 89 c5             	mov    %rax,%r13
  1002a4:	48 89 05 7d 1d 00 00 	mov    %rax,0x1d7d(%rip)        # 102028 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  1002ab:	48 89 c3             	mov    %rax,%rbx
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	if (extend(aligned_size)) {
  1002ae:	4c 89 e7             	mov    %r12,%rdi
  1002b1:	e8 70 fe ff ff       	call   100126 <extend>
  1002b6:	85 c0                	test   %eax,%eax
  1002b8:	75 34                	jne    1002ee <malloc+0xab>
		return NULL;
	}
	set_allocated(bp, aligned_size);
  1002ba:	4c 89 e6             	mov    %r12,%rsi
  1002bd:	4c 89 ef             	mov    %r13,%rdi
  1002c0:	e8 ca fe ff ff       	call   10018f <set_allocated>
    return bp;
  1002c5:	eb 12                	jmp    1002d9 <malloc+0x96>
		heap_init();
  1002c7:	e8 a5 fd ff ff       	call   100071 <heap_init>
  1002cc:	eb 8e                	jmp    10025c <malloc+0x19>
			set_allocated(bp, aligned_size);
  1002ce:	4c 89 e6             	mov    %r12,%rsi
  1002d1:	48 89 df             	mov    %rbx,%rdi
  1002d4:	e8 b6 fe ff ff       	call   10018f <set_allocated>
}
  1002d9:	48 89 d8             	mov    %rbx,%rax
  1002dc:	48 83 c4 08          	add    $0x8,%rsp
  1002e0:	5b                   	pop    %rbx
  1002e1:	41 5c                	pop    %r12
  1002e3:	41 5d                	pop    %r13
  1002e5:	5d                   	pop    %rbp
  1002e6:	c3                   	ret    
		return NULL;
  1002e7:	bb 00 00 00 00       	mov    $0x0,%ebx
  1002ec:	eb eb                	jmp    1002d9 <malloc+0x96>
		return NULL;
  1002ee:	bb 00 00 00 00       	mov    $0x0,%ebx
  1002f3:	eb e4                	jmp    1002d9 <malloc+0x96>

00000000001002f5 <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  1002f5:	55                   	push   %rbp
  1002f6:	48 89 e5             	mov    %rsp,%rbp
  1002f9:	41 54                	push   %r12
  1002fb:	53                   	push   %rbx
	void *bp = malloc(num * sz);
  1002fc:	48 0f af fe          	imul   %rsi,%rdi
  100300:	49 89 fc             	mov    %rdi,%r12
  100303:	e8 3b ff ff ff       	call   100243 <malloc>
  100308:	48 89 c3             	mov    %rax,%rbx
	if (bp)							// protect against num=0 or size=0 or just no memory
  10030b:	48 85 c0             	test   %rax,%rax
  10030e:	74 10                	je     100320 <calloc+0x2b>
		memset(bp, 0, num * sz);
  100310:	4c 89 e2             	mov    %r12,%rdx
  100313:	be 00 00 00 00       	mov    $0x0,%esi
  100318:	48 89 c7             	mov    %rax,%rdi
  10031b:	e8 a7 04 00 00       	call   1007c7 <memset>
	return bp;
}
  100320:	48 89 d8             	mov    %rbx,%rax
  100323:	5b                   	pop    %rbx
  100324:	41 5c                	pop    %r12
  100326:	5d                   	pop    %rbp
  100327:	c3                   	ret    

0000000000100328 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  100328:	55                   	push   %rbp
  100329:	48 89 e5             	mov    %rsp,%rbp
  10032c:	41 54                	push   %r12
  10032e:	53                   	push   %rbx
	if (ptr == NULL && sz == 0) {
  10032f:	48 85 f6             	test   %rsi,%rsi
  100332:	0f 94 c0             	sete   %al
  100335:	49 89 fc             	mov    %rdi,%r12
  100338:	49 09 f4             	or     %rsi,%r12
  10033b:	74 26                	je     100363 <realloc+0x3b>
  10033d:	48 89 fb             	mov    %rdi,%rbx
		return NULL;
	}
	else if (ptr != NULL && sz == 0) {
  100340:	48 85 ff             	test   %rdi,%rdi
  100343:	74 04                	je     100349 <realloc+0x21>
  100345:	84 c0                	test   %al,%al
  100347:	75 22                	jne    10036b <realloc+0x43>
		free(ptr);
		return NULL;
	}
	else if (ptr == NULL && sz != 0) {
  100349:	48 85 db             	test   %rbx,%rbx
  10034c:	75 05                	jne    100353 <realloc+0x2b>
  10034e:	48 85 f6             	test   %rsi,%rsi
  100351:	75 25                	jne    100378 <realloc+0x50>
		return malloc(sz);
	}
	else if (GET_SIZE(HDRP(ptr)) >= sz) {
  100353:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  100357:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
		return ptr;
  10035b:	49 89 dc             	mov    %rbx,%r12
	else if (GET_SIZE(HDRP(ptr)) >= sz) {
  10035e:	48 39 f0             	cmp    %rsi,%rax
  100361:	72 22                	jb     100385 <realloc+0x5d>
	else {
		memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
		free(ptr);
		return bigger_ptr;
	}
}
  100363:	4c 89 e0             	mov    %r12,%rax
  100366:	5b                   	pop    %rbx
  100367:	41 5c                	pop    %r12
  100369:	5d                   	pop    %rbp
  10036a:	c3                   	ret    
		free(ptr);
  10036b:	e8 7b fd ff ff       	call   1000eb <free>
		return NULL;
  100370:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100376:	eb eb                	jmp    100363 <realloc+0x3b>
		return malloc(sz);
  100378:	48 89 f7             	mov    %rsi,%rdi
  10037b:	e8 c3 fe ff ff       	call   100243 <malloc>
  100380:	49 89 c4             	mov    %rax,%r12
  100383:	eb de                	jmp    100363 <realloc+0x3b>
	void *bigger_ptr = malloc(sz);
  100385:	48 89 f7             	mov    %rsi,%rdi
  100388:	e8 b6 fe ff ff       	call   100243 <malloc>
  10038d:	49 89 c4             	mov    %rax,%r12
	if (bigger_ptr == NULL) {
  100390:	48 85 c0             	test   %rax,%rax
  100393:	74 1d                	je     1003b2 <realloc+0x8a>
		memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
  100395:	48 8b 53 f8          	mov    -0x8(%rbx),%rdx
  100399:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  10039d:	48 89 de             	mov    %rbx,%rsi
  1003a0:	48 89 c7             	mov    %rax,%rdi
  1003a3:	e8 21 03 00 00       	call   1006c9 <memcpy>
		free(ptr);
  1003a8:	48 89 df             	mov    %rbx,%rdi
  1003ab:	e8 3b fd ff ff       	call   1000eb <free>
		return bigger_ptr;
  1003b0:	eb b1                	jmp    100363 <realloc+0x3b>
		return ptr;
  1003b2:	49 89 dc             	mov    %rbx,%r12
  1003b5:	eb ac                	jmp    100363 <realloc+0x3b>

00000000001003b7 <defrag>:

void defrag() {
	void *fp = free_list;
  1003b7:	48 8b 15 52 1c 00 00 	mov    0x1c52(%rip),%rdx        # 102010 <free_list>
	while (fp != NULL) {
  1003be:	48 85 d2             	test   %rdx,%rdx
  1003c1:	75 3c                	jne    1003ff <defrag+0x48>
		// you only need to check the block after, because if the block before is free, you'll
		// bet there by traversing the free list

		fp = NEXT_FPTR(fp);
	}
}
  1003c3:	c3                   	ret    
				free_list = NEXT_FPTR(next_block);
  1003c4:	48 8b 08             	mov    (%rax),%rcx
  1003c7:	48 89 0d 42 1c 00 00 	mov    %rcx,0x1c42(%rip)        # 102010 <free_list>
  1003ce:	eb 49                	jmp    100419 <defrag+0x62>
			PUT(HDRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  1003d0:	48 8b 4a f8          	mov    -0x8(%rdx),%rcx
  1003d4:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  1003d8:	48 8b 70 f8          	mov    -0x8(%rax),%rsi
  1003dc:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  1003e0:	48 01 f1             	add    %rsi,%rcx
  1003e3:	48 89 4a f8          	mov    %rcx,-0x8(%rdx)
			PUT(FTRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  1003e7:	48 8b 40 f8          	mov    -0x8(%rax),%rax
  1003eb:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  1003ef:	48 01 c8             	add    %rcx,%rax
  1003f2:	48 89 44 0a f0       	mov    %rax,-0x10(%rdx,%rcx,1)
		fp = NEXT_FPTR(fp);
  1003f7:	48 8b 12             	mov    (%rdx),%rdx
	while (fp != NULL) {
  1003fa:	48 85 d2             	test   %rdx,%rdx
  1003fd:	74 c4                	je     1003c3 <defrag+0xc>
		void *next_block = NEXT_BLKP(fp);
  1003ff:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  100403:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100407:	48 01 d0             	add    %rdx,%rax
		if (!GET_ALLOC(HDRP(next_block))) {
  10040a:	f6 40 f8 01          	testb  $0x1,-0x8(%rax)
  10040e:	75 e7                	jne    1003f7 <defrag+0x40>
			if (free_list == next_block)
  100410:	48 39 05 f9 1b 00 00 	cmp    %rax,0x1bf9(%rip)        # 102010 <free_list>
  100417:	74 ab                	je     1003c4 <defrag+0xd>
			if (PREV_FPTR(next_block)) 
  100419:	48 8b 48 08          	mov    0x8(%rax),%rcx
  10041d:	48 85 c9             	test   %rcx,%rcx
  100420:	74 06                	je     100428 <defrag+0x71>
				NEXT_FPTR(PREV_FPTR(next_block)) = NEXT_FPTR(next_block);
  100422:	48 8b 30             	mov    (%rax),%rsi
  100425:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(next_block)) 
  100428:	48 8b 08             	mov    (%rax),%rcx
  10042b:	48 85 c9             	test   %rcx,%rcx
  10042e:	74 a0                	je     1003d0 <defrag+0x19>
				PREV_FPTR(NEXT_FPTR(next_block)) = PREV_FPTR(next_block);
  100430:	48 8b 70 08          	mov    0x8(%rax),%rsi
  100434:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  100438:	eb 96                	jmp    1003d0 <defrag+0x19>

000000000010043a <sift_down>:
// heap sort stuff that operates on the pointer array
#define LEFT_CHILD(x) (2*x + 1)
#define RIGHT_CHILD(x) (2*x + 2)
#define PARENT(x) ((x-1)/2)

void sift_down(void **arr, size_t pos, size_t arr_len) {
  10043a:	48 89 f1             	mov    %rsi,%rcx
  10043d:	49 89 d3             	mov    %rdx,%r11
	while (LEFT_CHILD(pos) < arr_len) {
  100440:	48 8d 74 36 01       	lea    0x1(%rsi,%rsi,1),%rsi
  100445:	48 39 d6             	cmp    %rdx,%rsi
  100448:	72 3a                	jb     100484 <sift_down+0x4a>
  10044a:	c3                   	ret    
  10044b:	48 89 f0             	mov    %rsi,%rax
		size_t smaller = LEFT_CHILD(pos);
		if (RIGHT_CHILD(pos) < arr_len && GET_SIZE(HDRP(arr[RIGHT_CHILD(pos)])) < GET_SIZE(HDRP(arr[LEFT_CHILD(pos)]))){
			smaller = RIGHT_CHILD(pos);
		}

		if (GET_SIZE(HDRP(arr[pos])) > GET_SIZE(HDRP(arr[smaller]))) {
  10044e:	4c 8d 0c cf          	lea    (%rdi,%rcx,8),%r9
  100452:	4d 8b 01             	mov    (%r9),%r8
  100455:	48 8d 34 c7          	lea    (%rdi,%rax,8),%rsi
  100459:	4c 8b 16             	mov    (%rsi),%r10
  10045c:	49 8b 50 f8          	mov    -0x8(%r8),%rdx
  100460:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100464:	49 8b 4a f8          	mov    -0x8(%r10),%rcx
  100468:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  10046c:	48 39 d1             	cmp    %rdx,%rcx
  10046f:	73 46                	jae    1004b7 <sift_down+0x7d>
			void *temp = arr[pos];
			arr[pos] = arr[smaller];
  100471:	4d 89 11             	mov    %r10,(%r9)
			arr[smaller] = temp;
  100474:	4c 89 06             	mov    %r8,(%rsi)
	while (LEFT_CHILD(pos) < arr_len) {
  100477:	48 8d 74 00 01       	lea    0x1(%rax,%rax,1),%rsi
  10047c:	4c 39 de             	cmp    %r11,%rsi
  10047f:	73 36                	jae    1004b7 <sift_down+0x7d>
			pos = smaller;
  100481:	48 89 c1             	mov    %rax,%rcx
		if (RIGHT_CHILD(pos) < arr_len && GET_SIZE(HDRP(arr[RIGHT_CHILD(pos)])) < GET_SIZE(HDRP(arr[LEFT_CHILD(pos)]))){
  100484:	48 8d 51 01          	lea    0x1(%rcx),%rdx
  100488:	48 8d 04 12          	lea    (%rdx,%rdx,1),%rax
  10048c:	4c 39 d8             	cmp    %r11,%rax
  10048f:	73 ba                	jae    10044b <sift_down+0x11>
  100491:	48 c1 e2 04          	shl    $0x4,%rdx
  100495:	4c 8b 04 17          	mov    (%rdi,%rdx,1),%r8
  100499:	4d 8b 40 f8          	mov    -0x8(%r8),%r8
  10049d:	49 83 e0 f0          	and    $0xfffffffffffffff0,%r8
  1004a1:	48 8b 54 17 f8       	mov    -0x8(%rdi,%rdx,1),%rdx
  1004a6:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  1004aa:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1004ae:	49 39 d0             	cmp    %rdx,%r8
  1004b1:	48 0f 43 c6          	cmovae %rsi,%rax
  1004b5:	eb 97                	jmp    10044e <sift_down+0x14>
		}
		else {
			break;
		}
	}
}
  1004b7:	c3                   	ret    

00000000001004b8 <heapify>:

void heapify(void **arr, size_t arr_len) {
  1004b8:	55                   	push   %rbp
  1004b9:	48 89 e5             	mov    %rsp,%rbp
  1004bc:	41 56                	push   %r14
  1004be:	41 55                	push   %r13
  1004c0:	41 54                	push   %r12
  1004c2:	53                   	push   %rbx
	for (int i = arr_len - 1; i >= 0; i--) {
  1004c3:	41 89 f5             	mov    %esi,%r13d
  1004c6:	41 83 ed 01          	sub    $0x1,%r13d
  1004ca:	78 28                	js     1004f4 <heapify+0x3c>
  1004cc:	49 89 fe             	mov    %rdi,%r14
  1004cf:	49 89 f4             	mov    %rsi,%r12
  1004d2:	49 63 c5             	movslq %r13d,%rax
  1004d5:	48 89 c3             	mov    %rax,%rbx
  1004d8:	41 29 c5             	sub    %eax,%r13d
		sift_down(arr, i, arr_len);
  1004db:	4c 89 e2             	mov    %r12,%rdx
  1004de:	48 89 de             	mov    %rbx,%rsi
  1004e1:	4c 89 f7             	mov    %r14,%rdi
  1004e4:	e8 51 ff ff ff       	call   10043a <sift_down>
	for (int i = arr_len - 1; i >= 0; i--) {
  1004e9:	48 83 eb 01          	sub    $0x1,%rbx
  1004ed:	44 89 e8             	mov    %r13d,%eax
  1004f0:	01 d8                	add    %ebx,%eax
  1004f2:	79 e7                	jns    1004db <heapify+0x23>
	}
}
  1004f4:	5b                   	pop    %rbx
  1004f5:	41 5c                	pop    %r12
  1004f7:	41 5d                	pop    %r13
  1004f9:	41 5e                	pop    %r14
  1004fb:	5d                   	pop    %rbp
  1004fc:	c3                   	ret    

00000000001004fd <heapsort>:

void heapsort(void **arr, size_t arr_len) {
  1004fd:	55                   	push   %rbp
  1004fe:	48 89 e5             	mov    %rsp,%rbp
  100501:	41 54                	push   %r12
  100503:	53                   	push   %rbx
  100504:	49 89 fc             	mov    %rdi,%r12
  100507:	48 89 f3             	mov    %rsi,%rbx
	heapify(arr, arr_len);
  10050a:	e8 a9 ff ff ff       	call   1004b8 <heapify>
	for (int i = arr_len - 1; i >= 0; i--) {
  10050f:	83 eb 01             	sub    $0x1,%ebx
  100512:	78 2b                	js     10053f <heapsort+0x42>
  100514:	48 63 db             	movslq %ebx,%rbx
		void *temp = arr[0];
  100517:	49 8b 04 24          	mov    (%r12),%rax
		arr[0] = arr[i];
  10051b:	49 8b 14 dc          	mov    (%r12,%rbx,8),%rdx
  10051f:	49 89 14 24          	mov    %rdx,(%r12)
		arr[i] = temp;
  100523:	49 89 04 dc          	mov    %rax,(%r12,%rbx,8)
		sift_down(arr, 0, i);
  100527:	48 89 da             	mov    %rbx,%rdx
  10052a:	be 00 00 00 00       	mov    $0x0,%esi
  10052f:	4c 89 e7             	mov    %r12,%rdi
  100532:	e8 03 ff ff ff       	call   10043a <sift_down>
	for (int i = arr_len - 1; i >= 0; i--) {
  100537:	48 83 eb 01          	sub    $0x1,%rbx
  10053b:	85 db                	test   %ebx,%ebx
  10053d:	79 d8                	jns    100517 <heapsort+0x1a>
	}
}
  10053f:	5b                   	pop    %rbx
  100540:	41 5c                	pop    %r12
  100542:	5d                   	pop    %rbp
  100543:	c3                   	ret    

0000000000100544 <heap_info>:

int heap_info(heap_info_struct *info) {
  100544:	55                   	push   %rbp
  100545:	48 89 e5             	mov    %rsp,%rbp
  100548:	53                   	push   %rbx
  100549:	48 83 ec 08          	sub    $0x8,%rsp
  10054d:	48 89 fb             	mov    %rdi,%rbx
	info->num_allocs = 0;
  100550:	c7 07 00 00 00 00    	movl   $0x0,(%rdi)

	// collect the number of allocs :(
	void *bp = NEXT_BLKP(prologue_block); // because the prologue isn't actually allocated
  100556:	48 8b 05 bb 1a 00 00 	mov    0x1abb(%rip),%rax        # 102018 <prologue_block>
  10055d:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  100561:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100565:	48 01 d0             	add    %rdx,%rax
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  100568:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  10056c:	48 83 fa 0f          	cmp    $0xf,%rdx
  100570:	77 17                	ja     100589 <heap_info+0x45>
  100572:	eb 25                	jmp    100599 <heap_info+0x55>
		if (GET_ALLOC(HDRP(bp)))
			info->num_allocs++;
		bp = NEXT_BLKP(bp);
  100574:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  100578:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  10057c:	48 01 d0             	add    %rdx,%rax
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  10057f:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  100583:	48 83 fa 0f          	cmp    $0xf,%rdx
  100587:	76 0a                	jbe    100593 <heap_info+0x4f>
		if (GET_ALLOC(HDRP(bp)))
  100589:	f6 c2 01             	test   $0x1,%dl
  10058c:	74 e6                	je     100574 <heap_info+0x30>
			info->num_allocs++;
  10058e:	83 03 01             	addl   $0x1,(%rbx)
  100591:	eb e1                	jmp    100574 <heap_info+0x30>
	}

	if (info->num_allocs == 0) {
  100593:	8b 03                	mov    (%rbx),%eax
  100595:	85 c0                	test   %eax,%eax
  100597:	75 45                	jne    1005de <heap_info+0x9a>
		info->size_array = NULL;
  100599:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  1005a0:	00 
		info->ptr_array = NULL;
  1005a1:	48 c7 43 10 00 00 00 	movq   $0x0,0x10(%rbx)
  1005a8:	00 
			free(info->ptr_array);
			return -1;
		}
	}

	info->free_space = 0;
  1005a9:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%rbx)
	info->largest_free_chunk = 0;
  1005b0:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%rbx)

	// iterate through list for free space
	bp = NEXT_BLKP(prologue_block); // because the prologue isn't actually allocated
  1005b7:	48 8b 05 5a 1a 00 00 	mov    0x1a5a(%rip),%rax        # 102018 <prologue_block>
  1005be:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1005c2:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1005c6:	48 01 d0             	add    %rdx,%rax
	size_t arr_index = 0;
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  1005c9:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1005cd:	48 83 fa 0f          	cmp    $0xf,%rdx
  1005d1:	0f 86 a3 00 00 00    	jbe    10067a <heap_info+0x136>
	size_t arr_index = 0;
  1005d7:	be 00 00 00 00       	mov    $0x0,%esi
  1005dc:	eb 72                	jmp    100650 <heap_info+0x10c>
		info->size_array = malloc(info->num_allocs * sizeof(long));
  1005de:	48 98                	cltq   
  1005e0:	48 8d 3c c5 00 00 00 	lea    0x0(,%rax,8),%rdi
  1005e7:	00 
  1005e8:	e8 56 fc ff ff       	call   100243 <malloc>
  1005ed:	48 89 43 08          	mov    %rax,0x8(%rbx)
		if (info->size_array == (void *) -1){
  1005f1:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  1005f5:	0f 84 c0 00 00 00    	je     1006bb <heap_info+0x177>
		info->ptr_array = malloc(info->num_allocs * sizeof(void *));
  1005fb:	48 63 3b             	movslq (%rbx),%rdi
  1005fe:	48 c1 e7 03          	shl    $0x3,%rdi
  100602:	e8 3c fc ff ff       	call   100243 <malloc>
  100607:	48 89 43 10          	mov    %rax,0x10(%rbx)
		if (info->ptr_array == (void *) -1){
  10060b:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  10060f:	75 98                	jne    1005a9 <heap_info+0x65>
			free(info->ptr_array);
  100611:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
  100618:	e8 ce fa ff ff       	call   1000eb <free>
			return -1;
  10061d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100622:	e9 8e 00 00 00       	jmp    1006b5 <heap_info+0x171>
			info->size_array[arr_index] = GET_SIZE(HDRP(bp));
			info->ptr_array[arr_index] = bp;
			arr_index++;
		}
		else if (!GET_ALLOC(HDRP(bp))) {
			info->free_space += GET_SIZE(HDRP(bp));
  100627:	83 e2 f0             	and    $0xfffffff0,%edx
  10062a:	01 53 18             	add    %edx,0x18(%rbx)
			if ((int)GET_SIZE(HDRP(bp)) > info->largest_free_chunk){
  10062d:	8b 50 f8             	mov    -0x8(%rax),%edx
  100630:	83 e2 f0             	and    $0xfffffff0,%edx
  100633:	3b 53 1c             	cmp    0x1c(%rbx),%edx
  100636:	7e 03                	jle    10063b <heap_info+0xf7>
				info->largest_free_chunk = GET_SIZE(HDRP(bp));
  100638:	89 53 1c             	mov    %edx,0x1c(%rbx)
			}
		}
		bp = NEXT_BLKP(bp);
  10063b:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  10063f:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100643:	48 01 d0             	add    %rdx,%rax
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  100646:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  10064a:	48 83 fa 0f          	cmp    $0xf,%rdx
  10064e:	76 2a                	jbe    10067a <heap_info+0x136>
		if (GET_ALLOC(HDRP(bp)) && bp != info->size_array && bp != info->ptr_array){
  100650:	f6 c2 01             	test   $0x1,%dl
  100653:	74 d2                	je     100627 <heap_info+0xe3>
  100655:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
  100659:	48 39 c1             	cmp    %rax,%rcx
  10065c:	74 dd                	je     10063b <heap_info+0xf7>
  10065e:	48 39 43 10          	cmp    %rax,0x10(%rbx)
  100662:	74 d7                	je     10063b <heap_info+0xf7>
			info->size_array[arr_index] = GET_SIZE(HDRP(bp));
  100664:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100668:	48 89 14 f1          	mov    %rdx,(%rcx,%rsi,8)
			info->ptr_array[arr_index] = bp;
  10066c:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  100670:	48 89 04 f2          	mov    %rax,(%rdx,%rsi,8)
			arr_index++;
  100674:	48 83 c6 01          	add    $0x1,%rsi
  100678:	eb c1                	jmp    10063b <heap_info+0xf7>
	}

	// sort the damn arrays
	heapsort(info->ptr_array, info->num_allocs);
  10067a:	48 63 33             	movslq (%rbx),%rsi
  10067d:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
  100681:	e8 77 fe ff ff       	call   1004fd <heapsort>
	for (int i = 0; i < info->num_allocs; i++)
  100686:	83 3b 00             	cmpl   $0x0,(%rbx)
  100689:	7e 37                	jle    1006c2 <heap_info+0x17e>
  10068b:	b8 00 00 00 00       	mov    $0x0,%eax
		info->size_array[i] = GET_SIZE(HDRP(info->ptr_array[i]));
  100690:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
  100694:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  100698:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
  10069c:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  1006a0:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1006a4:	48 89 14 c1          	mov    %rdx,(%rcx,%rax,8)
	for (int i = 0; i < info->num_allocs; i++)
  1006a8:	48 83 c0 01          	add    $0x1,%rax
  1006ac:	39 03                	cmp    %eax,(%rbx)
  1006ae:	7f e0                	jg     100690 <heap_info+0x14c>

    return 0;
  1006b0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1006b5:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1006b9:	c9                   	leave  
  1006ba:	c3                   	ret    
			return -1;
  1006bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1006c0:	eb f3                	jmp    1006b5 <heap_info+0x171>
    return 0;
  1006c2:	b8 00 00 00 00       	mov    $0x0,%eax
  1006c7:	eb ec                	jmp    1006b5 <heap_info+0x171>

00000000001006c9 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  1006c9:	55                   	push   %rbp
  1006ca:	48 89 e5             	mov    %rsp,%rbp
  1006cd:	48 83 ec 28          	sub    $0x28,%rsp
  1006d1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1006d5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1006d9:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1006dd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1006e1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1006e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1006e9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  1006ed:	eb 1c                	jmp    10070b <memcpy+0x42>
        *d = *s;
  1006ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006f3:	0f b6 10             	movzbl (%rax),%edx
  1006f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1006fa:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1006fc:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100701:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100706:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  10070b:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100710:	75 dd                	jne    1006ef <memcpy+0x26>
    }
    return dst;
  100712:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100716:	c9                   	leave  
  100717:	c3                   	ret    

0000000000100718 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100718:	55                   	push   %rbp
  100719:	48 89 e5             	mov    %rsp,%rbp
  10071c:	48 83 ec 28          	sub    $0x28,%rsp
  100720:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100724:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100728:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10072c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100730:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  100734:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100738:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  10073c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100740:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  100744:	73 6a                	jae    1007b0 <memmove+0x98>
  100746:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10074a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10074e:	48 01 d0             	add    %rdx,%rax
  100751:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100755:	73 59                	jae    1007b0 <memmove+0x98>
        s += n, d += n;
  100757:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10075b:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  10075f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100763:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  100767:	eb 17                	jmp    100780 <memmove+0x68>
            *--d = *--s;
  100769:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  10076e:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100773:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100777:	0f b6 10             	movzbl (%rax),%edx
  10077a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10077e:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100780:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100784:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100788:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  10078c:	48 85 c0             	test   %rax,%rax
  10078f:	75 d8                	jne    100769 <memmove+0x51>
    if (s < d && s + n > d) {
  100791:	eb 2e                	jmp    1007c1 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100793:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100797:	48 8d 42 01          	lea    0x1(%rdx),%rax
  10079b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10079f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1007a3:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1007a7:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  1007ab:	0f b6 12             	movzbl (%rdx),%edx
  1007ae:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1007b0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1007b4:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1007b8:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1007bc:	48 85 c0             	test   %rax,%rax
  1007bf:	75 d2                	jne    100793 <memmove+0x7b>
        }
    }
    return dst;
  1007c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1007c5:	c9                   	leave  
  1007c6:	c3                   	ret    

00000000001007c7 <memset>:

void* memset(void* v, int c, size_t n) {
  1007c7:	55                   	push   %rbp
  1007c8:	48 89 e5             	mov    %rsp,%rbp
  1007cb:	48 83 ec 28          	sub    $0x28,%rsp
  1007cf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1007d3:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  1007d6:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1007da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1007de:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1007e2:	eb 15                	jmp    1007f9 <memset+0x32>
        *p = c;
  1007e4:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1007e7:	89 c2                	mov    %eax,%edx
  1007e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007ed:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1007ef:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1007f4:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1007f9:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1007fe:	75 e4                	jne    1007e4 <memset+0x1d>
    }
    return v;
  100800:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100804:	c9                   	leave  
  100805:	c3                   	ret    

0000000000100806 <strlen>:

size_t strlen(const char* s) {
  100806:	55                   	push   %rbp
  100807:	48 89 e5             	mov    %rsp,%rbp
  10080a:	48 83 ec 18          	sub    $0x18,%rsp
  10080e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100812:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100819:	00 
  10081a:	eb 0a                	jmp    100826 <strlen+0x20>
        ++n;
  10081c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100821:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100826:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10082a:	0f b6 00             	movzbl (%rax),%eax
  10082d:	84 c0                	test   %al,%al
  10082f:	75 eb                	jne    10081c <strlen+0x16>
    }
    return n;
  100831:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100835:	c9                   	leave  
  100836:	c3                   	ret    

0000000000100837 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100837:	55                   	push   %rbp
  100838:	48 89 e5             	mov    %rsp,%rbp
  10083b:	48 83 ec 20          	sub    $0x20,%rsp
  10083f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100843:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100847:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  10084e:	00 
  10084f:	eb 0a                	jmp    10085b <strnlen+0x24>
        ++n;
  100851:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100856:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  10085b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10085f:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100863:	74 0b                	je     100870 <strnlen+0x39>
  100865:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100869:	0f b6 00             	movzbl (%rax),%eax
  10086c:	84 c0                	test   %al,%al
  10086e:	75 e1                	jne    100851 <strnlen+0x1a>
    }
    return n;
  100870:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100874:	c9                   	leave  
  100875:	c3                   	ret    

0000000000100876 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100876:	55                   	push   %rbp
  100877:	48 89 e5             	mov    %rsp,%rbp
  10087a:	48 83 ec 20          	sub    $0x20,%rsp
  10087e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100882:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  100886:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10088a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  10088e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100892:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100896:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  10089a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10089e:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1008a2:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  1008a6:	0f b6 12             	movzbl (%rdx),%edx
  1008a9:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  1008ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008af:	48 83 e8 01          	sub    $0x1,%rax
  1008b3:	0f b6 00             	movzbl (%rax),%eax
  1008b6:	84 c0                	test   %al,%al
  1008b8:	75 d4                	jne    10088e <strcpy+0x18>
    return dst;
  1008ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1008be:	c9                   	leave  
  1008bf:	c3                   	ret    

00000000001008c0 <strcmp>:

int strcmp(const char* a, const char* b) {
  1008c0:	55                   	push   %rbp
  1008c1:	48 89 e5             	mov    %rsp,%rbp
  1008c4:	48 83 ec 10          	sub    $0x10,%rsp
  1008c8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1008cc:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1008d0:	eb 0a                	jmp    1008dc <strcmp+0x1c>
        ++a, ++b;
  1008d2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1008d7:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1008dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008e0:	0f b6 00             	movzbl (%rax),%eax
  1008e3:	84 c0                	test   %al,%al
  1008e5:	74 1d                	je     100904 <strcmp+0x44>
  1008e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1008eb:	0f b6 00             	movzbl (%rax),%eax
  1008ee:	84 c0                	test   %al,%al
  1008f0:	74 12                	je     100904 <strcmp+0x44>
  1008f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008f6:	0f b6 10             	movzbl (%rax),%edx
  1008f9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1008fd:	0f b6 00             	movzbl (%rax),%eax
  100900:	38 c2                	cmp    %al,%dl
  100902:	74 ce                	je     1008d2 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100904:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100908:	0f b6 00             	movzbl (%rax),%eax
  10090b:	89 c2                	mov    %eax,%edx
  10090d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100911:	0f b6 00             	movzbl (%rax),%eax
  100914:	38 d0                	cmp    %dl,%al
  100916:	0f 92 c0             	setb   %al
  100919:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  10091c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100920:	0f b6 00             	movzbl (%rax),%eax
  100923:	89 c1                	mov    %eax,%ecx
  100925:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100929:	0f b6 00             	movzbl (%rax),%eax
  10092c:	38 c1                	cmp    %al,%cl
  10092e:	0f 92 c0             	setb   %al
  100931:	0f b6 c0             	movzbl %al,%eax
  100934:	29 c2                	sub    %eax,%edx
  100936:	89 d0                	mov    %edx,%eax
}
  100938:	c9                   	leave  
  100939:	c3                   	ret    

000000000010093a <strchr>:

char* strchr(const char* s, int c) {
  10093a:	55                   	push   %rbp
  10093b:	48 89 e5             	mov    %rsp,%rbp
  10093e:	48 83 ec 10          	sub    $0x10,%rsp
  100942:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100946:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100949:	eb 05                	jmp    100950 <strchr+0x16>
        ++s;
  10094b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100950:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100954:	0f b6 00             	movzbl (%rax),%eax
  100957:	84 c0                	test   %al,%al
  100959:	74 0e                	je     100969 <strchr+0x2f>
  10095b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10095f:	0f b6 00             	movzbl (%rax),%eax
  100962:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100965:	38 d0                	cmp    %dl,%al
  100967:	75 e2                	jne    10094b <strchr+0x11>
    }
    if (*s == (char) c) {
  100969:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10096d:	0f b6 00             	movzbl (%rax),%eax
  100970:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100973:	38 d0                	cmp    %dl,%al
  100975:	75 06                	jne    10097d <strchr+0x43>
        return (char*) s;
  100977:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10097b:	eb 05                	jmp    100982 <strchr+0x48>
    } else {
        return NULL;
  10097d:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100982:	c9                   	leave  
  100983:	c3                   	ret    

0000000000100984 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100984:	55                   	push   %rbp
  100985:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  100988:	8b 05 a2 16 00 00    	mov    0x16a2(%rip),%eax        # 102030 <rand_seed_set>
  10098e:	85 c0                	test   %eax,%eax
  100990:	75 0a                	jne    10099c <rand+0x18>
        srand(819234718U);
  100992:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100997:	e8 24 00 00 00       	call   1009c0 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  10099c:	8b 05 92 16 00 00    	mov    0x1692(%rip),%eax        # 102034 <rand_seed>
  1009a2:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  1009a8:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1009ad:	89 05 81 16 00 00    	mov    %eax,0x1681(%rip)        # 102034 <rand_seed>
    return rand_seed & RAND_MAX;
  1009b3:	8b 05 7b 16 00 00    	mov    0x167b(%rip),%eax        # 102034 <rand_seed>
  1009b9:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1009be:	5d                   	pop    %rbp
  1009bf:	c3                   	ret    

00000000001009c0 <srand>:

void srand(unsigned seed) {
  1009c0:	55                   	push   %rbp
  1009c1:	48 89 e5             	mov    %rsp,%rbp
  1009c4:	48 83 ec 08          	sub    $0x8,%rsp
  1009c8:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  1009cb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1009ce:	89 05 60 16 00 00    	mov    %eax,0x1660(%rip)        # 102034 <rand_seed>
    rand_seed_set = 1;
  1009d4:	c7 05 52 16 00 00 01 	movl   $0x1,0x1652(%rip)        # 102030 <rand_seed_set>
  1009db:	00 00 00 
}
  1009de:	90                   	nop
  1009df:	c9                   	leave  
  1009e0:	c3                   	ret    

00000000001009e1 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  1009e1:	55                   	push   %rbp
  1009e2:	48 89 e5             	mov    %rsp,%rbp
  1009e5:	48 83 ec 28          	sub    $0x28,%rsp
  1009e9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1009ed:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1009f1:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  1009f4:	48 c7 45 f8 00 19 10 	movq   $0x101900,-0x8(%rbp)
  1009fb:	00 
    if (base < 0) {
  1009fc:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100a00:	79 0b                	jns    100a0d <fill_numbuf+0x2c>
        digits = lower_digits;
  100a02:	48 c7 45 f8 20 19 10 	movq   $0x101920,-0x8(%rbp)
  100a09:	00 
        base = -base;
  100a0a:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100a0d:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100a12:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100a16:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100a19:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100a1c:	48 63 c8             	movslq %eax,%rcx
  100a1f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100a23:	ba 00 00 00 00       	mov    $0x0,%edx
  100a28:	48 f7 f1             	div    %rcx
  100a2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a2f:	48 01 d0             	add    %rdx,%rax
  100a32:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100a37:	0f b6 10             	movzbl (%rax),%edx
  100a3a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100a3e:	88 10                	mov    %dl,(%rax)
        val /= base;
  100a40:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100a43:	48 63 f0             	movslq %eax,%rsi
  100a46:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100a4a:	ba 00 00 00 00       	mov    $0x0,%edx
  100a4f:	48 f7 f6             	div    %rsi
  100a52:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100a56:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100a5b:	75 bc                	jne    100a19 <fill_numbuf+0x38>
    return numbuf_end;
  100a5d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100a61:	c9                   	leave  
  100a62:	c3                   	ret    

0000000000100a63 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100a63:	55                   	push   %rbp
  100a64:	48 89 e5             	mov    %rsp,%rbp
  100a67:	53                   	push   %rbx
  100a68:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100a6f:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100a76:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100a7c:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100a83:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100a8a:	e9 8a 09 00 00       	jmp    101419 <printer_vprintf+0x9b6>
        if (*format != '%') {
  100a8f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a96:	0f b6 00             	movzbl (%rax),%eax
  100a99:	3c 25                	cmp    $0x25,%al
  100a9b:	74 31                	je     100ace <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  100a9d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100aa4:	4c 8b 00             	mov    (%rax),%r8
  100aa7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100aae:	0f b6 00             	movzbl (%rax),%eax
  100ab1:	0f b6 c8             	movzbl %al,%ecx
  100ab4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100aba:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ac1:	89 ce                	mov    %ecx,%esi
  100ac3:	48 89 c7             	mov    %rax,%rdi
  100ac6:	41 ff d0             	call   *%r8
            continue;
  100ac9:	e9 43 09 00 00       	jmp    101411 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100ace:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100ad5:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100adc:	01 
  100add:	eb 44                	jmp    100b23 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  100adf:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ae6:	0f b6 00             	movzbl (%rax),%eax
  100ae9:	0f be c0             	movsbl %al,%eax
  100aec:	89 c6                	mov    %eax,%esi
  100aee:	bf 20 17 10 00       	mov    $0x101720,%edi
  100af3:	e8 42 fe ff ff       	call   10093a <strchr>
  100af8:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100afc:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100b01:	74 30                	je     100b33 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  100b03:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100b07:	48 2d 20 17 10 00    	sub    $0x101720,%rax
  100b0d:	ba 01 00 00 00       	mov    $0x1,%edx
  100b12:	89 c1                	mov    %eax,%ecx
  100b14:	d3 e2                	shl    %cl,%edx
  100b16:	89 d0                	mov    %edx,%eax
  100b18:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100b1b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100b22:	01 
  100b23:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b2a:	0f b6 00             	movzbl (%rax),%eax
  100b2d:	84 c0                	test   %al,%al
  100b2f:	75 ae                	jne    100adf <printer_vprintf+0x7c>
  100b31:	eb 01                	jmp    100b34 <printer_vprintf+0xd1>
            } else {
                break;
  100b33:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100b34:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100b3b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b42:	0f b6 00             	movzbl (%rax),%eax
  100b45:	3c 30                	cmp    $0x30,%al
  100b47:	7e 67                	jle    100bb0 <printer_vprintf+0x14d>
  100b49:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b50:	0f b6 00             	movzbl (%rax),%eax
  100b53:	3c 39                	cmp    $0x39,%al
  100b55:	7f 59                	jg     100bb0 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100b57:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100b5e:	eb 2e                	jmp    100b8e <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100b60:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100b63:	89 d0                	mov    %edx,%eax
  100b65:	c1 e0 02             	shl    $0x2,%eax
  100b68:	01 d0                	add    %edx,%eax
  100b6a:	01 c0                	add    %eax,%eax
  100b6c:	89 c1                	mov    %eax,%ecx
  100b6e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b75:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100b79:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100b80:	0f b6 00             	movzbl (%rax),%eax
  100b83:	0f be c0             	movsbl %al,%eax
  100b86:	01 c8                	add    %ecx,%eax
  100b88:	83 e8 30             	sub    $0x30,%eax
  100b8b:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100b8e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b95:	0f b6 00             	movzbl (%rax),%eax
  100b98:	3c 2f                	cmp    $0x2f,%al
  100b9a:	0f 8e 85 00 00 00    	jle    100c25 <printer_vprintf+0x1c2>
  100ba0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ba7:	0f b6 00             	movzbl (%rax),%eax
  100baa:	3c 39                	cmp    $0x39,%al
  100bac:	7e b2                	jle    100b60 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100bae:	eb 75                	jmp    100c25 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100bb0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bb7:	0f b6 00             	movzbl (%rax),%eax
  100bba:	3c 2a                	cmp    $0x2a,%al
  100bbc:	75 68                	jne    100c26 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100bbe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bc5:	8b 00                	mov    (%rax),%eax
  100bc7:	83 f8 2f             	cmp    $0x2f,%eax
  100bca:	77 30                	ja     100bfc <printer_vprintf+0x199>
  100bcc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bd3:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100bd7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bde:	8b 00                	mov    (%rax),%eax
  100be0:	89 c0                	mov    %eax,%eax
  100be2:	48 01 d0             	add    %rdx,%rax
  100be5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bec:	8b 12                	mov    (%rdx),%edx
  100bee:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bf1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bf8:	89 0a                	mov    %ecx,(%rdx)
  100bfa:	eb 1a                	jmp    100c16 <printer_vprintf+0x1b3>
  100bfc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c03:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c07:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c0b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c12:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c16:	8b 00                	mov    (%rax),%eax
  100c18:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100c1b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100c22:	01 
  100c23:	eb 01                	jmp    100c26 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100c25:	90                   	nop
        }

        // process precision
        int precision = -1;
  100c26:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100c2d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c34:	0f b6 00             	movzbl (%rax),%eax
  100c37:	3c 2e                	cmp    $0x2e,%al
  100c39:	0f 85 00 01 00 00    	jne    100d3f <printer_vprintf+0x2dc>
            ++format;
  100c3f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100c46:	01 
            if (*format >= '0' && *format <= '9') {
  100c47:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c4e:	0f b6 00             	movzbl (%rax),%eax
  100c51:	3c 2f                	cmp    $0x2f,%al
  100c53:	7e 67                	jle    100cbc <printer_vprintf+0x259>
  100c55:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c5c:	0f b6 00             	movzbl (%rax),%eax
  100c5f:	3c 39                	cmp    $0x39,%al
  100c61:	7f 59                	jg     100cbc <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100c63:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100c6a:	eb 2e                	jmp    100c9a <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100c6c:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100c6f:	89 d0                	mov    %edx,%eax
  100c71:	c1 e0 02             	shl    $0x2,%eax
  100c74:	01 d0                	add    %edx,%eax
  100c76:	01 c0                	add    %eax,%eax
  100c78:	89 c1                	mov    %eax,%ecx
  100c7a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c81:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100c85:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100c8c:	0f b6 00             	movzbl (%rax),%eax
  100c8f:	0f be c0             	movsbl %al,%eax
  100c92:	01 c8                	add    %ecx,%eax
  100c94:	83 e8 30             	sub    $0x30,%eax
  100c97:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100c9a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ca1:	0f b6 00             	movzbl (%rax),%eax
  100ca4:	3c 2f                	cmp    $0x2f,%al
  100ca6:	0f 8e 85 00 00 00    	jle    100d31 <printer_vprintf+0x2ce>
  100cac:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100cb3:	0f b6 00             	movzbl (%rax),%eax
  100cb6:	3c 39                	cmp    $0x39,%al
  100cb8:	7e b2                	jle    100c6c <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100cba:	eb 75                	jmp    100d31 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100cbc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100cc3:	0f b6 00             	movzbl (%rax),%eax
  100cc6:	3c 2a                	cmp    $0x2a,%al
  100cc8:	75 68                	jne    100d32 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100cca:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cd1:	8b 00                	mov    (%rax),%eax
  100cd3:	83 f8 2f             	cmp    $0x2f,%eax
  100cd6:	77 30                	ja     100d08 <printer_vprintf+0x2a5>
  100cd8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cdf:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ce3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cea:	8b 00                	mov    (%rax),%eax
  100cec:	89 c0                	mov    %eax,%eax
  100cee:	48 01 d0             	add    %rdx,%rax
  100cf1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cf8:	8b 12                	mov    (%rdx),%edx
  100cfa:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100cfd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d04:	89 0a                	mov    %ecx,(%rdx)
  100d06:	eb 1a                	jmp    100d22 <printer_vprintf+0x2bf>
  100d08:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d0f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d13:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d17:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d1e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d22:	8b 00                	mov    (%rax),%eax
  100d24:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100d27:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100d2e:	01 
  100d2f:	eb 01                	jmp    100d32 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100d31:	90                   	nop
            }
            if (precision < 0) {
  100d32:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100d36:	79 07                	jns    100d3f <printer_vprintf+0x2dc>
                precision = 0;
  100d38:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100d3f:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100d46:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100d4d:	00 
        int length = 0;
  100d4e:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100d55:	48 c7 45 c8 26 17 10 	movq   $0x101726,-0x38(%rbp)
  100d5c:	00 
    again:
        switch (*format) {
  100d5d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d64:	0f b6 00             	movzbl (%rax),%eax
  100d67:	0f be c0             	movsbl %al,%eax
  100d6a:	83 e8 43             	sub    $0x43,%eax
  100d6d:	83 f8 37             	cmp    $0x37,%eax
  100d70:	0f 87 9f 03 00 00    	ja     101115 <printer_vprintf+0x6b2>
  100d76:	89 c0                	mov    %eax,%eax
  100d78:	48 8b 04 c5 38 17 10 	mov    0x101738(,%rax,8),%rax
  100d7f:	00 
  100d80:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100d82:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100d89:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100d90:	01 
            goto again;
  100d91:	eb ca                	jmp    100d5d <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100d93:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100d97:	74 5d                	je     100df6 <printer_vprintf+0x393>
  100d99:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100da0:	8b 00                	mov    (%rax),%eax
  100da2:	83 f8 2f             	cmp    $0x2f,%eax
  100da5:	77 30                	ja     100dd7 <printer_vprintf+0x374>
  100da7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dae:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100db2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100db9:	8b 00                	mov    (%rax),%eax
  100dbb:	89 c0                	mov    %eax,%eax
  100dbd:	48 01 d0             	add    %rdx,%rax
  100dc0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dc7:	8b 12                	mov    (%rdx),%edx
  100dc9:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100dcc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dd3:	89 0a                	mov    %ecx,(%rdx)
  100dd5:	eb 1a                	jmp    100df1 <printer_vprintf+0x38e>
  100dd7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dde:	48 8b 40 08          	mov    0x8(%rax),%rax
  100de2:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100de6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ded:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100df1:	48 8b 00             	mov    (%rax),%rax
  100df4:	eb 5c                	jmp    100e52 <printer_vprintf+0x3ef>
  100df6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dfd:	8b 00                	mov    (%rax),%eax
  100dff:	83 f8 2f             	cmp    $0x2f,%eax
  100e02:	77 30                	ja     100e34 <printer_vprintf+0x3d1>
  100e04:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e0b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e0f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e16:	8b 00                	mov    (%rax),%eax
  100e18:	89 c0                	mov    %eax,%eax
  100e1a:	48 01 d0             	add    %rdx,%rax
  100e1d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e24:	8b 12                	mov    (%rdx),%edx
  100e26:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e29:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e30:	89 0a                	mov    %ecx,(%rdx)
  100e32:	eb 1a                	jmp    100e4e <printer_vprintf+0x3eb>
  100e34:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e3b:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e3f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e43:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e4a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e4e:	8b 00                	mov    (%rax),%eax
  100e50:	48 98                	cltq   
  100e52:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100e56:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100e5a:	48 c1 f8 38          	sar    $0x38,%rax
  100e5e:	25 80 00 00 00       	and    $0x80,%eax
  100e63:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100e66:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100e6a:	74 09                	je     100e75 <printer_vprintf+0x412>
  100e6c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100e70:	48 f7 d8             	neg    %rax
  100e73:	eb 04                	jmp    100e79 <printer_vprintf+0x416>
  100e75:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100e79:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100e7d:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100e80:	83 c8 60             	or     $0x60,%eax
  100e83:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100e86:	e9 cf 02 00 00       	jmp    10115a <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100e8b:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100e8f:	74 5d                	je     100eee <printer_vprintf+0x48b>
  100e91:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e98:	8b 00                	mov    (%rax),%eax
  100e9a:	83 f8 2f             	cmp    $0x2f,%eax
  100e9d:	77 30                	ja     100ecf <printer_vprintf+0x46c>
  100e9f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ea6:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100eaa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100eb1:	8b 00                	mov    (%rax),%eax
  100eb3:	89 c0                	mov    %eax,%eax
  100eb5:	48 01 d0             	add    %rdx,%rax
  100eb8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ebf:	8b 12                	mov    (%rdx),%edx
  100ec1:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ec4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ecb:	89 0a                	mov    %ecx,(%rdx)
  100ecd:	eb 1a                	jmp    100ee9 <printer_vprintf+0x486>
  100ecf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ed6:	48 8b 40 08          	mov    0x8(%rax),%rax
  100eda:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ede:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ee5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ee9:	48 8b 00             	mov    (%rax),%rax
  100eec:	eb 5c                	jmp    100f4a <printer_vprintf+0x4e7>
  100eee:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ef5:	8b 00                	mov    (%rax),%eax
  100ef7:	83 f8 2f             	cmp    $0x2f,%eax
  100efa:	77 30                	ja     100f2c <printer_vprintf+0x4c9>
  100efc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f03:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100f07:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f0e:	8b 00                	mov    (%rax),%eax
  100f10:	89 c0                	mov    %eax,%eax
  100f12:	48 01 d0             	add    %rdx,%rax
  100f15:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f1c:	8b 12                	mov    (%rdx),%edx
  100f1e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100f21:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f28:	89 0a                	mov    %ecx,(%rdx)
  100f2a:	eb 1a                	jmp    100f46 <printer_vprintf+0x4e3>
  100f2c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f33:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f37:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f3b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f42:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f46:	8b 00                	mov    (%rax),%eax
  100f48:	89 c0                	mov    %eax,%eax
  100f4a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100f4e:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100f52:	e9 03 02 00 00       	jmp    10115a <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100f57:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100f5e:	e9 28 ff ff ff       	jmp    100e8b <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100f63:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100f6a:	e9 1c ff ff ff       	jmp    100e8b <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100f6f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f76:	8b 00                	mov    (%rax),%eax
  100f78:	83 f8 2f             	cmp    $0x2f,%eax
  100f7b:	77 30                	ja     100fad <printer_vprintf+0x54a>
  100f7d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f84:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100f88:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f8f:	8b 00                	mov    (%rax),%eax
  100f91:	89 c0                	mov    %eax,%eax
  100f93:	48 01 d0             	add    %rdx,%rax
  100f96:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f9d:	8b 12                	mov    (%rdx),%edx
  100f9f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100fa2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fa9:	89 0a                	mov    %ecx,(%rdx)
  100fab:	eb 1a                	jmp    100fc7 <printer_vprintf+0x564>
  100fad:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fb4:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fb8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100fbc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fc3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100fc7:	48 8b 00             	mov    (%rax),%rax
  100fca:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100fce:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100fd5:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100fdc:	e9 79 01 00 00       	jmp    10115a <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100fe1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fe8:	8b 00                	mov    (%rax),%eax
  100fea:	83 f8 2f             	cmp    $0x2f,%eax
  100fed:	77 30                	ja     10101f <printer_vprintf+0x5bc>
  100fef:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ff6:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ffa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101001:	8b 00                	mov    (%rax),%eax
  101003:	89 c0                	mov    %eax,%eax
  101005:	48 01 d0             	add    %rdx,%rax
  101008:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10100f:	8b 12                	mov    (%rdx),%edx
  101011:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101014:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10101b:	89 0a                	mov    %ecx,(%rdx)
  10101d:	eb 1a                	jmp    101039 <printer_vprintf+0x5d6>
  10101f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101026:	48 8b 40 08          	mov    0x8(%rax),%rax
  10102a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10102e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101035:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101039:	48 8b 00             	mov    (%rax),%rax
  10103c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  101040:	e9 15 01 00 00       	jmp    10115a <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  101045:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10104c:	8b 00                	mov    (%rax),%eax
  10104e:	83 f8 2f             	cmp    $0x2f,%eax
  101051:	77 30                	ja     101083 <printer_vprintf+0x620>
  101053:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10105a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10105e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101065:	8b 00                	mov    (%rax),%eax
  101067:	89 c0                	mov    %eax,%eax
  101069:	48 01 d0             	add    %rdx,%rax
  10106c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101073:	8b 12                	mov    (%rdx),%edx
  101075:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101078:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10107f:	89 0a                	mov    %ecx,(%rdx)
  101081:	eb 1a                	jmp    10109d <printer_vprintf+0x63a>
  101083:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10108a:	48 8b 40 08          	mov    0x8(%rax),%rax
  10108e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101092:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101099:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10109d:	8b 00                	mov    (%rax),%eax
  10109f:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  1010a5:	e9 67 03 00 00       	jmp    101411 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  1010aa:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1010ae:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  1010b2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010b9:	8b 00                	mov    (%rax),%eax
  1010bb:	83 f8 2f             	cmp    $0x2f,%eax
  1010be:	77 30                	ja     1010f0 <printer_vprintf+0x68d>
  1010c0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010c7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1010cb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010d2:	8b 00                	mov    (%rax),%eax
  1010d4:	89 c0                	mov    %eax,%eax
  1010d6:	48 01 d0             	add    %rdx,%rax
  1010d9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010e0:	8b 12                	mov    (%rdx),%edx
  1010e2:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1010e5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010ec:	89 0a                	mov    %ecx,(%rdx)
  1010ee:	eb 1a                	jmp    10110a <printer_vprintf+0x6a7>
  1010f0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010f7:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010fb:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1010ff:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101106:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10110a:	8b 00                	mov    (%rax),%eax
  10110c:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  10110f:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  101113:	eb 45                	jmp    10115a <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  101115:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101119:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  10111d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101124:	0f b6 00             	movzbl (%rax),%eax
  101127:	84 c0                	test   %al,%al
  101129:	74 0c                	je     101137 <printer_vprintf+0x6d4>
  10112b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101132:	0f b6 00             	movzbl (%rax),%eax
  101135:	eb 05                	jmp    10113c <printer_vprintf+0x6d9>
  101137:	b8 25 00 00 00       	mov    $0x25,%eax
  10113c:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  10113f:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  101143:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10114a:	0f b6 00             	movzbl (%rax),%eax
  10114d:	84 c0                	test   %al,%al
  10114f:	75 08                	jne    101159 <printer_vprintf+0x6f6>
                format--;
  101151:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  101158:	01 
            }
            break;
  101159:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  10115a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10115d:	83 e0 20             	and    $0x20,%eax
  101160:	85 c0                	test   %eax,%eax
  101162:	74 1e                	je     101182 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  101164:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101168:	48 83 c0 18          	add    $0x18,%rax
  10116c:	8b 55 e0             	mov    -0x20(%rbp),%edx
  10116f:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101173:	48 89 ce             	mov    %rcx,%rsi
  101176:	48 89 c7             	mov    %rax,%rdi
  101179:	e8 63 f8 ff ff       	call   1009e1 <fill_numbuf>
  10117e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  101182:	48 c7 45 c0 26 17 10 	movq   $0x101726,-0x40(%rbp)
  101189:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  10118a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10118d:	83 e0 20             	and    $0x20,%eax
  101190:	85 c0                	test   %eax,%eax
  101192:	74 48                	je     1011dc <printer_vprintf+0x779>
  101194:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101197:	83 e0 40             	and    $0x40,%eax
  10119a:	85 c0                	test   %eax,%eax
  10119c:	74 3e                	je     1011dc <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  10119e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011a1:	25 80 00 00 00       	and    $0x80,%eax
  1011a6:	85 c0                	test   %eax,%eax
  1011a8:	74 0a                	je     1011b4 <printer_vprintf+0x751>
                prefix = "-";
  1011aa:	48 c7 45 c0 27 17 10 	movq   $0x101727,-0x40(%rbp)
  1011b1:	00 
            if (flags & FLAG_NEGATIVE) {
  1011b2:	eb 73                	jmp    101227 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  1011b4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011b7:	83 e0 10             	and    $0x10,%eax
  1011ba:	85 c0                	test   %eax,%eax
  1011bc:	74 0a                	je     1011c8 <printer_vprintf+0x765>
                prefix = "+";
  1011be:	48 c7 45 c0 29 17 10 	movq   $0x101729,-0x40(%rbp)
  1011c5:	00 
            if (flags & FLAG_NEGATIVE) {
  1011c6:	eb 5f                	jmp    101227 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  1011c8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011cb:	83 e0 08             	and    $0x8,%eax
  1011ce:	85 c0                	test   %eax,%eax
  1011d0:	74 55                	je     101227 <printer_vprintf+0x7c4>
                prefix = " ";
  1011d2:	48 c7 45 c0 2b 17 10 	movq   $0x10172b,-0x40(%rbp)
  1011d9:	00 
            if (flags & FLAG_NEGATIVE) {
  1011da:	eb 4b                	jmp    101227 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1011dc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011df:	83 e0 20             	and    $0x20,%eax
  1011e2:	85 c0                	test   %eax,%eax
  1011e4:	74 42                	je     101228 <printer_vprintf+0x7c5>
  1011e6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011e9:	83 e0 01             	and    $0x1,%eax
  1011ec:	85 c0                	test   %eax,%eax
  1011ee:	74 38                	je     101228 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  1011f0:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  1011f4:	74 06                	je     1011fc <printer_vprintf+0x799>
  1011f6:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1011fa:	75 2c                	jne    101228 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  1011fc:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  101201:	75 0c                	jne    10120f <printer_vprintf+0x7ac>
  101203:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101206:	25 00 01 00 00       	and    $0x100,%eax
  10120b:	85 c0                	test   %eax,%eax
  10120d:	74 19                	je     101228 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  10120f:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  101213:	75 07                	jne    10121c <printer_vprintf+0x7b9>
  101215:	b8 2d 17 10 00       	mov    $0x10172d,%eax
  10121a:	eb 05                	jmp    101221 <printer_vprintf+0x7be>
  10121c:	b8 30 17 10 00       	mov    $0x101730,%eax
  101221:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101225:	eb 01                	jmp    101228 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  101227:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  101228:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  10122c:	78 24                	js     101252 <printer_vprintf+0x7ef>
  10122e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101231:	83 e0 20             	and    $0x20,%eax
  101234:	85 c0                	test   %eax,%eax
  101236:	75 1a                	jne    101252 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  101238:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10123b:	48 63 d0             	movslq %eax,%rdx
  10123e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101242:	48 89 d6             	mov    %rdx,%rsi
  101245:	48 89 c7             	mov    %rax,%rdi
  101248:	e8 ea f5 ff ff       	call   100837 <strnlen>
  10124d:	89 45 bc             	mov    %eax,-0x44(%rbp)
  101250:	eb 0f                	jmp    101261 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  101252:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101256:	48 89 c7             	mov    %rax,%rdi
  101259:	e8 a8 f5 ff ff       	call   100806 <strlen>
  10125e:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  101261:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101264:	83 e0 20             	and    $0x20,%eax
  101267:	85 c0                	test   %eax,%eax
  101269:	74 20                	je     10128b <printer_vprintf+0x828>
  10126b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  10126f:	78 1a                	js     10128b <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  101271:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101274:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  101277:	7e 08                	jle    101281 <printer_vprintf+0x81e>
  101279:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10127c:	2b 45 bc             	sub    -0x44(%rbp),%eax
  10127f:	eb 05                	jmp    101286 <printer_vprintf+0x823>
  101281:	b8 00 00 00 00       	mov    $0x0,%eax
  101286:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101289:	eb 5c                	jmp    1012e7 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  10128b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10128e:	83 e0 20             	and    $0x20,%eax
  101291:	85 c0                	test   %eax,%eax
  101293:	74 4b                	je     1012e0 <printer_vprintf+0x87d>
  101295:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101298:	83 e0 02             	and    $0x2,%eax
  10129b:	85 c0                	test   %eax,%eax
  10129d:	74 41                	je     1012e0 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  10129f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1012a2:	83 e0 04             	and    $0x4,%eax
  1012a5:	85 c0                	test   %eax,%eax
  1012a7:	75 37                	jne    1012e0 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  1012a9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1012ad:	48 89 c7             	mov    %rax,%rdi
  1012b0:	e8 51 f5 ff ff       	call   100806 <strlen>
  1012b5:	89 c2                	mov    %eax,%edx
  1012b7:	8b 45 bc             	mov    -0x44(%rbp),%eax
  1012ba:	01 d0                	add    %edx,%eax
  1012bc:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  1012bf:	7e 1f                	jle    1012e0 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  1012c1:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1012c4:	2b 45 bc             	sub    -0x44(%rbp),%eax
  1012c7:	89 c3                	mov    %eax,%ebx
  1012c9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1012cd:	48 89 c7             	mov    %rax,%rdi
  1012d0:	e8 31 f5 ff ff       	call   100806 <strlen>
  1012d5:	89 c2                	mov    %eax,%edx
  1012d7:	89 d8                	mov    %ebx,%eax
  1012d9:	29 d0                	sub    %edx,%eax
  1012db:	89 45 b8             	mov    %eax,-0x48(%rbp)
  1012de:	eb 07                	jmp    1012e7 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  1012e0:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  1012e7:	8b 55 bc             	mov    -0x44(%rbp),%edx
  1012ea:	8b 45 b8             	mov    -0x48(%rbp),%eax
  1012ed:	01 d0                	add    %edx,%eax
  1012ef:	48 63 d8             	movslq %eax,%rbx
  1012f2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1012f6:	48 89 c7             	mov    %rax,%rdi
  1012f9:	e8 08 f5 ff ff       	call   100806 <strlen>
  1012fe:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  101302:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101305:	29 d0                	sub    %edx,%eax
  101307:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10130a:	eb 25                	jmp    101331 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  10130c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101313:	48 8b 08             	mov    (%rax),%rcx
  101316:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10131c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101323:	be 20 00 00 00       	mov    $0x20,%esi
  101328:	48 89 c7             	mov    %rax,%rdi
  10132b:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10132d:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101331:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101334:	83 e0 04             	and    $0x4,%eax
  101337:	85 c0                	test   %eax,%eax
  101339:	75 36                	jne    101371 <printer_vprintf+0x90e>
  10133b:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  10133f:	7f cb                	jg     10130c <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  101341:	eb 2e                	jmp    101371 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  101343:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10134a:	4c 8b 00             	mov    (%rax),%r8
  10134d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101351:	0f b6 00             	movzbl (%rax),%eax
  101354:	0f b6 c8             	movzbl %al,%ecx
  101357:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10135d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101364:	89 ce                	mov    %ecx,%esi
  101366:	48 89 c7             	mov    %rax,%rdi
  101369:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  10136c:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  101371:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101375:	0f b6 00             	movzbl (%rax),%eax
  101378:	84 c0                	test   %al,%al
  10137a:	75 c7                	jne    101343 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  10137c:	eb 25                	jmp    1013a3 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  10137e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101385:	48 8b 08             	mov    (%rax),%rcx
  101388:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10138e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101395:	be 30 00 00 00       	mov    $0x30,%esi
  10139a:	48 89 c7             	mov    %rax,%rdi
  10139d:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  10139f:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  1013a3:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  1013a7:	7f d5                	jg     10137e <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  1013a9:	eb 32                	jmp    1013dd <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  1013ab:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1013b2:	4c 8b 00             	mov    (%rax),%r8
  1013b5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1013b9:	0f b6 00             	movzbl (%rax),%eax
  1013bc:	0f b6 c8             	movzbl %al,%ecx
  1013bf:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1013c5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1013cc:	89 ce                	mov    %ecx,%esi
  1013ce:	48 89 c7             	mov    %rax,%rdi
  1013d1:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  1013d4:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  1013d9:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  1013dd:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  1013e1:	7f c8                	jg     1013ab <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  1013e3:	eb 25                	jmp    10140a <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  1013e5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1013ec:	48 8b 08             	mov    (%rax),%rcx
  1013ef:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1013f5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1013fc:	be 20 00 00 00       	mov    $0x20,%esi
  101401:	48 89 c7             	mov    %rax,%rdi
  101404:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  101406:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  10140a:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  10140e:	7f d5                	jg     1013e5 <printer_vprintf+0x982>
        }
    done: ;
  101410:	90                   	nop
    for (; *format; ++format) {
  101411:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101418:	01 
  101419:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101420:	0f b6 00             	movzbl (%rax),%eax
  101423:	84 c0                	test   %al,%al
  101425:	0f 85 64 f6 ff ff    	jne    100a8f <printer_vprintf+0x2c>
    }
}
  10142b:	90                   	nop
  10142c:	90                   	nop
  10142d:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  101431:	c9                   	leave  
  101432:	c3                   	ret    

0000000000101433 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  101433:	55                   	push   %rbp
  101434:	48 89 e5             	mov    %rsp,%rbp
  101437:	48 83 ec 20          	sub    $0x20,%rsp
  10143b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10143f:	89 f0                	mov    %esi,%eax
  101441:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101444:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  101447:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10144b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10144f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101453:	48 8b 40 08          	mov    0x8(%rax),%rax
  101457:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  10145c:	48 39 d0             	cmp    %rdx,%rax
  10145f:	72 0c                	jb     10146d <console_putc+0x3a>
        cp->cursor = console;
  101461:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101465:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  10146c:	00 
    }
    if (c == '\n') {
  10146d:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  101471:	75 78                	jne    1014eb <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  101473:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101477:	48 8b 40 08          	mov    0x8(%rax),%rax
  10147b:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  101481:	48 d1 f8             	sar    %rax
  101484:	48 89 c1             	mov    %rax,%rcx
  101487:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  10148e:	66 66 66 
  101491:	48 89 c8             	mov    %rcx,%rax
  101494:	48 f7 ea             	imul   %rdx
  101497:	48 c1 fa 05          	sar    $0x5,%rdx
  10149b:	48 89 c8             	mov    %rcx,%rax
  10149e:	48 c1 f8 3f          	sar    $0x3f,%rax
  1014a2:	48 29 c2             	sub    %rax,%rdx
  1014a5:	48 89 d0             	mov    %rdx,%rax
  1014a8:	48 c1 e0 02          	shl    $0x2,%rax
  1014ac:	48 01 d0             	add    %rdx,%rax
  1014af:	48 c1 e0 04          	shl    $0x4,%rax
  1014b3:	48 29 c1             	sub    %rax,%rcx
  1014b6:	48 89 ca             	mov    %rcx,%rdx
  1014b9:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  1014bc:	eb 25                	jmp    1014e3 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  1014be:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1014c1:	83 c8 20             	or     $0x20,%eax
  1014c4:	89 c6                	mov    %eax,%esi
  1014c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1014ca:	48 8b 40 08          	mov    0x8(%rax),%rax
  1014ce:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1014d2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1014d6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1014da:	89 f2                	mov    %esi,%edx
  1014dc:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  1014df:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1014e3:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  1014e7:	75 d5                	jne    1014be <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  1014e9:	eb 24                	jmp    10150f <console_putc+0xdc>
        *cp->cursor++ = c | color;
  1014eb:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  1014ef:	8b 55 e0             	mov    -0x20(%rbp),%edx
  1014f2:	09 d0                	or     %edx,%eax
  1014f4:	89 c6                	mov    %eax,%esi
  1014f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1014fa:	48 8b 40 08          	mov    0x8(%rax),%rax
  1014fe:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101502:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101506:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10150a:	89 f2                	mov    %esi,%edx
  10150c:	66 89 10             	mov    %dx,(%rax)
}
  10150f:	90                   	nop
  101510:	c9                   	leave  
  101511:	c3                   	ret    

0000000000101512 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  101512:	55                   	push   %rbp
  101513:	48 89 e5             	mov    %rsp,%rbp
  101516:	48 83 ec 30          	sub    $0x30,%rsp
  10151a:	89 7d ec             	mov    %edi,-0x14(%rbp)
  10151d:	89 75 e8             	mov    %esi,-0x18(%rbp)
  101520:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101524:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  101528:	48 c7 45 f0 33 14 10 	movq   $0x101433,-0x10(%rbp)
  10152f:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101530:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  101534:	78 09                	js     10153f <console_vprintf+0x2d>
  101536:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  10153d:	7e 07                	jle    101546 <console_vprintf+0x34>
        cpos = 0;
  10153f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  101546:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101549:	48 98                	cltq   
  10154b:	48 01 c0             	add    %rax,%rax
  10154e:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  101554:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101558:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  10155c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  101560:	8b 75 e8             	mov    -0x18(%rbp),%esi
  101563:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101567:	48 89 c7             	mov    %rax,%rdi
  10156a:	e8 f4 f4 ff ff       	call   100a63 <printer_vprintf>
    return cp.cursor - console;
  10156f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101573:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  101579:	48 d1 f8             	sar    %rax
}
  10157c:	c9                   	leave  
  10157d:	c3                   	ret    

000000000010157e <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  10157e:	55                   	push   %rbp
  10157f:	48 89 e5             	mov    %rsp,%rbp
  101582:	48 83 ec 60          	sub    $0x60,%rsp
  101586:	89 7d ac             	mov    %edi,-0x54(%rbp)
  101589:	89 75 a8             	mov    %esi,-0x58(%rbp)
  10158c:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  101590:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101594:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101598:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  10159c:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1015a3:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1015a7:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1015ab:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1015af:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1015b3:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1015b7:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  1015bb:	8b 75 a8             	mov    -0x58(%rbp),%esi
  1015be:	8b 45 ac             	mov    -0x54(%rbp),%eax
  1015c1:	89 c7                	mov    %eax,%edi
  1015c3:	e8 4a ff ff ff       	call   101512 <console_vprintf>
  1015c8:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  1015cb:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  1015ce:	c9                   	leave  
  1015cf:	c3                   	ret    

00000000001015d0 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  1015d0:	55                   	push   %rbp
  1015d1:	48 89 e5             	mov    %rsp,%rbp
  1015d4:	48 83 ec 20          	sub    $0x20,%rsp
  1015d8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1015dc:	89 f0                	mov    %esi,%eax
  1015de:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1015e1:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  1015e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1015e8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  1015ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1015f0:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1015f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1015f8:	48 8b 40 10          	mov    0x10(%rax),%rax
  1015fc:	48 39 c2             	cmp    %rax,%rdx
  1015ff:	73 1a                	jae    10161b <string_putc+0x4b>
        *sp->s++ = c;
  101601:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101605:	48 8b 40 08          	mov    0x8(%rax),%rax
  101609:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10160d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101611:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101615:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101619:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  10161b:	90                   	nop
  10161c:	c9                   	leave  
  10161d:	c3                   	ret    

000000000010161e <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  10161e:	55                   	push   %rbp
  10161f:	48 89 e5             	mov    %rsp,%rbp
  101622:	48 83 ec 40          	sub    $0x40,%rsp
  101626:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  10162a:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  10162e:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  101632:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101636:	48 c7 45 e8 d0 15 10 	movq   $0x1015d0,-0x18(%rbp)
  10163d:	00 
    sp.s = s;
  10163e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101642:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  101646:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  10164b:	74 33                	je     101680 <vsnprintf+0x62>
        sp.end = s + size - 1;
  10164d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101651:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101655:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101659:	48 01 d0             	add    %rdx,%rax
  10165c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101660:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101664:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101668:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  10166c:	be 00 00 00 00       	mov    $0x0,%esi
  101671:	48 89 c7             	mov    %rax,%rdi
  101674:	e8 ea f3 ff ff       	call   100a63 <printer_vprintf>
        *sp.s = 0;
  101679:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10167d:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  101680:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101684:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  101688:	c9                   	leave  
  101689:	c3                   	ret    

000000000010168a <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  10168a:	55                   	push   %rbp
  10168b:	48 89 e5             	mov    %rsp,%rbp
  10168e:	48 83 ec 70          	sub    $0x70,%rsp
  101692:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101696:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  10169a:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  10169e:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1016a2:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1016a6:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1016aa:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  1016b1:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1016b5:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  1016b9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1016bd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  1016c1:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  1016c5:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  1016c9:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  1016cd:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1016d1:	48 89 c7             	mov    %rax,%rdi
  1016d4:	e8 45 ff ff ff       	call   10161e <vsnprintf>
  1016d9:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  1016dc:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  1016df:	c9                   	leave  
  1016e0:	c3                   	ret    

00000000001016e1 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  1016e1:	55                   	push   %rbp
  1016e2:	48 89 e5             	mov    %rsp,%rbp
  1016e5:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1016e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  1016f0:	eb 13                	jmp    101705 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  1016f2:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1016f5:	48 98                	cltq   
  1016f7:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  1016fe:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101701:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101705:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  10170c:	7e e4                	jle    1016f2 <console_clear+0x11>
    }
    cursorpos = 0;
  10170e:	c7 05 e4 78 fb ff 00 	movl   $0x0,-0x4871c(%rip)        # b8ffc <cursorpos>
  101715:	00 00 00 
}
  101718:	90                   	nop
  101719:	c9                   	leave  
  10171a:	c3                   	ret    
