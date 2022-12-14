
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
  100037:	e8 63 05 00 00       	call   10059f <rand>
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
  10005f:	e8 d1 01 00 00       	call   100235 <malloc>
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
  10007f:	cd 3a                	int    $0x3a
  100081:	48 89 05 a0 1f 00 00 	mov    %rax,0x1fa0(%rip)        # 102028 <result.0>
// want to try and optimize this 
void heap_init(void) {

	// prologue block
	sbrk(sizeof(block_header));
	prologue_block = sbrk(sizeof(block_footer));
  100088:	48 89 05 89 1f 00 00 	mov    %rax,0x1f89(%rip)        # 102018 <prologue_block>

	GET_SIZE(HDRP(prologue_block)) = sizeof(block_header) + sizeof(block_footer);
  10008f:	48 c7 40 f0 20 00 00 	movq   $0x20,-0x10(%rax)
  100096:	00 
	GET_ALLOC(HDRP(prologue_block)) = 1;
  100097:	48 8b 05 7a 1f 00 00 	mov    0x1f7a(%rip),%rax        # 102018 <prologue_block>
  10009e:	c7 40 f8 01 00 00 00 	movl   $0x1,-0x8(%rax)
	GET_SIZE(FTRP(prologue_block)) = sizeof(block_header) + sizeof(block_footer);
  1000a5:	48 8b 05 6c 1f 00 00 	mov    0x1f6c(%rip),%rax        # 102018 <prologue_block>
  1000ac:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  1000b0:	48 c7 44 10 e0 20 00 	movq   $0x20,-0x20(%rax,%rdx,1)
  1000b7:	00 00 
  1000b9:	cd 3a                	int    $0x3a
  1000bb:	48 89 05 66 1f 00 00 	mov    %rax,0x1f66(%rip)        # 102028 <result.0>

	// terminal block
	sbrk(sizeof(block_header));
	GET_SIZE(HDRP(NEXT_BLKP(prologue_block))) = 0;
  1000c2:	48 8b 05 4f 1f 00 00 	mov    0x1f4f(%rip),%rax        # 102018 <prologue_block>
  1000c9:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  1000cd:	48 c7 44 10 f0 00 00 	movq   $0x0,-0x10(%rax,%rdx,1)
  1000d4:	00 00 
	GET_ALLOC(HDRP(NEXT_BLKP(prologue_block))) = 0;
  1000d6:	48 8b 05 3b 1f 00 00 	mov    0x1f3b(%rip),%rax        # 102018 <prologue_block>
  1000dd:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  1000e1:	c7 44 10 f8 00 00 00 	movl   $0x0,-0x8(%rax,%rdx,1)
  1000e8:	00 

	free_list = NULL;
  1000e9:	48 c7 05 1c 1f 00 00 	movq   $0x0,0x1f1c(%rip)        # 102010 <free_list>
  1000f0:	00 00 00 00 

	initialized_heap = 1;
  1000f4:	c7 05 22 1f 00 00 01 	movl   $0x1,0x1f22(%rip)        # 102020 <initialized_heap>
  1000fb:	00 00 00 
}
  1000fe:	c3                   	ret    

00000000001000ff <free>:

void free(void *firstbyte) {
	if (firstbyte == NULL)
  1000ff:	48 85 ff             	test   %rdi,%rdi
  100102:	74 29                	je     10012d <free+0x2e>
		return;

	// setup free things: alloc, list ptrs, footer
	GET_ALLOC(HDRP(firstbyte)) = 0;
  100104:	c7 47 f8 00 00 00 00 	movl   $0x0,-0x8(%rdi)
	NEXT_FPTR(firstbyte) = free_list;
  10010b:	48 8b 05 fe 1e 00 00 	mov    0x1efe(%rip),%rax        # 102010 <free_list>
  100112:	48 89 07             	mov    %rax,(%rdi)
	PREV_FPTR(firstbyte) = NULL;
  100115:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  10011c:	00 
	GET_SIZE(FTRP(firstbyte)) = GET_SIZE(HDRP(firstbyte));
  10011d:	48 8b 47 f0          	mov    -0x10(%rdi),%rax
  100121:	48 89 44 07 e0       	mov    %rax,-0x20(%rdi,%rax,1)

	// add to free_list
	free_list = firstbyte;
  100126:	48 89 3d e3 1e 00 00 	mov    %rdi,0x1ee3(%rip)        # 102010 <free_list>

	return;
}
  10012d:	c3                   	ret    

000000000010012e <extend>:
//
//	the reason alloating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
void extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  10012e:	48 81 c7 ff 3f 00 00 	add    $0x3fff,%rdi
  100135:	48 81 e7 00 c0 ff ff 	and    $0xffffffffffffc000,%rdi
  10013c:	cd 3a                	int    $0x3a
  10013e:	48 89 05 e3 1e 00 00 	mov    %rax,0x1ee3(%rip)        # 102028 <result.0>
	void *bp = sbrk(chunk_aligned_size);

	// setup pointer
	GET_SIZE(HDRP(bp)) = chunk_aligned_size;
  100145:	48 89 78 f0          	mov    %rdi,-0x10(%rax)
	GET_ALLOC(HDRP(bp)) = 0;
  100149:	c7 40 f8 00 00 00 00 	movl   $0x0,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  100150:	48 8b 15 b9 1e 00 00 	mov    0x1eb9(%rip),%rdx        # 102010 <free_list>
  100157:	48 89 10             	mov    %rdx,(%rax)
	PREV_FPTR(bp) = NULL;
  10015a:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  100161:	00 
	GET_SIZE(FTRP(bp)) = chunk_aligned_size;
  100162:	48 89 7c 07 e0       	mov    %rdi,-0x20(%rdi,%rax,1)

	// add to head of free_list
	if (free_list)
  100167:	48 8b 15 a2 1e 00 00 	mov    0x1ea2(%rip),%rdx        # 102010 <free_list>
  10016e:	48 85 d2             	test   %rdx,%rdx
  100171:	74 04                	je     100177 <extend+0x49>
		PREV_FPTR(free_list) = bp;
  100173:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  100177:	48 89 05 92 1e 00 00 	mov    %rax,0x1e92(%rip)        # 102010 <free_list>

	// update terminal block
	GET_SIZE(HDRP(NEXT_BLKP(bp))) = 0;
  10017e:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  100182:	48 c7 44 10 f0 00 00 	movq   $0x0,-0x10(%rax,%rdx,1)
  100189:	00 00 
	GET_ALLOC(HDRP(NEXT_BLKP(bp))) = 1;
  10018b:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  10018f:	c7 44 10 f8 01 00 00 	movl   $0x1,-0x8(%rax,%rdx,1)
  100196:	00 
}
  100197:	c3                   	ret    

0000000000100198 <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
  100198:	48 89 f8             	mov    %rdi,%rax
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  10019b:	48 8b 57 f0          	mov    -0x10(%rdi),%rdx
  10019f:	48 29 f2             	sub    %rsi,%rdx

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  1001a2:	48 83 fa 30          	cmp    $0x30,%rdx
  1001a6:	76 57                	jbe    1001ff <set_allocated+0x67>
		GET_SIZE(HDRP(bp)) = size;
  1001a8:	48 89 77 f0          	mov    %rsi,-0x10(%rdi)
		void *leftover_mem_ptr = NEXT_BLKP(bp);
  1001ac:	48 01 fe             	add    %rdi,%rsi

		GET_SIZE(HDRP(leftover_mem_ptr)) = extra_size;
  1001af:	48 89 56 f0          	mov    %rdx,-0x10(%rsi)
		GET_ALLOC(HDRP(leftover_mem_ptr)) = 0;
  1001b3:	c7 46 f8 00 00 00 00 	movl   $0x0,-0x8(%rsi)

		// add pointers to previous and next free block
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp);
  1001ba:	48 8b 0f             	mov    (%rdi),%rcx
  1001bd:	48 89 0e             	mov    %rcx,(%rsi)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  1001c0:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  1001c4:	48 89 4e 08          	mov    %rcx,0x8(%rsi)
	
		GET_SIZE(FTRP(leftover_mem_ptr)) = extra_size;
  1001c8:	48 89 54 16 e0       	mov    %rdx,-0x20(%rsi,%rdx,1)

		// update the free list
		if (free_list == bp)
  1001cd:	48 39 3d 3c 1e 00 00 	cmp    %rdi,0x1e3c(%rip)        # 102010 <free_list>
  1001d4:	74 20                	je     1001f6 <set_allocated+0x5e>
			free_list = leftover_mem_ptr;

		if (PREV_FPTR(bp))
  1001d6:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1001da:	48 85 d2             	test   %rdx,%rdx
  1001dd:	74 03                	je     1001e2 <set_allocated+0x4a>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  1001df:	48 89 32             	mov    %rsi,(%rdx)
		if (NEXT_FPTR(bp))
  1001e2:	48 8b 10             	mov    (%rax),%rdx
  1001e5:	48 85 d2             	test   %rdx,%rdx
  1001e8:	74 04                	je     1001ee <set_allocated+0x56>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  1001ea:	48 89 72 08          	mov    %rsi,0x8(%rdx)
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
		if (NEXT_FPTR(bp))
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
	}
	
	GET_ALLOC(HDRP(bp)) = 1;
  1001ee:	c7 40 f8 01 00 00 00 	movl   $0x1,-0x8(%rax)
}
  1001f5:	c3                   	ret    
			free_list = leftover_mem_ptr;
  1001f6:	48 89 35 13 1e 00 00 	mov    %rsi,0x1e13(%rip)        # 102010 <free_list>
  1001fd:	eb d7                	jmp    1001d6 <set_allocated+0x3e>
		if (free_list == bp)
  1001ff:	48 39 3d 0a 1e 00 00 	cmp    %rdi,0x1e0a(%rip)        # 102010 <free_list>
  100206:	74 21                	je     100229 <set_allocated+0x91>
		if (PREV_FPTR(bp))
  100208:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10020c:	48 85 d2             	test   %rdx,%rdx
  10020f:	74 06                	je     100217 <set_allocated+0x7f>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  100211:	48 8b 08             	mov    (%rax),%rcx
  100214:	48 89 0a             	mov    %rcx,(%rdx)
		if (NEXT_FPTR(bp))
  100217:	48 8b 10             	mov    (%rax),%rdx
  10021a:	48 85 d2             	test   %rdx,%rdx
  10021d:	74 cf                	je     1001ee <set_allocated+0x56>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  10021f:	48 8b 48 08          	mov    0x8(%rax),%rcx
  100223:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100227:	eb c5                	jmp    1001ee <set_allocated+0x56>
			free_list = NEXT_FPTR(bp);
  100229:	48 8b 17             	mov    (%rdi),%rdx
  10022c:	48 89 15 dd 1d 00 00 	mov    %rdx,0x1ddd(%rip)        # 102010 <free_list>
  100233:	eb d3                	jmp    100208 <set_allocated+0x70>

0000000000100235 <malloc>:

void *malloc(uint64_t numbytes) {
  100235:	55                   	push   %rbp
  100236:	48 89 e5             	mov    %rsp,%rbp
  100239:	41 55                	push   %r13
  10023b:	41 54                	push   %r12
  10023d:	53                   	push   %rbx
  10023e:	48 83 ec 08          	sub    $0x8,%rsp
  100242:	49 89 fc             	mov    %rdi,%r12
	if (!initialized_heap)
  100245:	83 3d d4 1d 00 00 00 	cmpl   $0x0,0x1dd4(%rip)        # 102020 <initialized_heap>
  10024c:	74 68                	je     1002b6 <malloc+0x81>
		heap_init();

	if (numbytes == 0)
  10024e:	4d 85 e4             	test   %r12,%r12
  100251:	74 77                	je     1002ca <malloc+0x95>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  100253:	49 83 c4 1f          	add    $0x1f,%r12
  100257:	49 83 e4 f0          	and    $0xfffffffffffffff0,%r12
  10025b:	b8 30 00 00 00       	mov    $0x30,%eax
  100260:	49 39 c4             	cmp    %rax,%r12
  100263:	4c 0f 42 e0          	cmovb  %rax,%r12
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);

	void *bp = free_list;
  100267:	48 8b 1d a2 1d 00 00 	mov    0x1da2(%rip),%rbx        # 102010 <free_list>
	while (bp) {
  10026e:	48 85 db             	test   %rbx,%rbx
  100271:	74 0e                	je     100281 <malloc+0x4c>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  100273:	4c 39 63 f0          	cmp    %r12,-0x10(%rbx)
  100277:	73 44                	jae    1002bd <malloc+0x88>
			set_allocated(bp, aligned_size);
			return bp;
		}

		bp = NEXT_FPTR(bp);
  100279:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  10027c:	48 85 db             	test   %rbx,%rbx
  10027f:	75 f2                	jne    100273 <malloc+0x3e>
  100281:	bf 00 00 00 00       	mov    $0x0,%edi
  100286:	cd 3a                	int    $0x3a
  100288:	49 89 c5             	mov    %rax,%r13
  10028b:	48 89 05 96 1d 00 00 	mov    %rax,0x1d96(%rip)        # 102028 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  100292:	48 89 c3             	mov    %rax,%rbx
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	extend(aligned_size);
  100295:	4c 89 e7             	mov    %r12,%rdi
  100298:	e8 91 fe ff ff       	call   10012e <extend>
	set_allocated(bp, aligned_size);
  10029d:	4c 89 e6             	mov    %r12,%rsi
  1002a0:	4c 89 ef             	mov    %r13,%rdi
  1002a3:	e8 f0 fe ff ff       	call   100198 <set_allocated>
    return bp;
}
  1002a8:	48 89 d8             	mov    %rbx,%rax
  1002ab:	48 83 c4 08          	add    $0x8,%rsp
  1002af:	5b                   	pop    %rbx
  1002b0:	41 5c                	pop    %r12
  1002b2:	41 5d                	pop    %r13
  1002b4:	5d                   	pop    %rbp
  1002b5:	c3                   	ret    
		heap_init();
  1002b6:	e8 b6 fd ff ff       	call   100071 <heap_init>
  1002bb:	eb 91                	jmp    10024e <malloc+0x19>
			set_allocated(bp, aligned_size);
  1002bd:	4c 89 e6             	mov    %r12,%rsi
  1002c0:	48 89 df             	mov    %rbx,%rdi
  1002c3:	e8 d0 fe ff ff       	call   100198 <set_allocated>
			return bp;
  1002c8:	eb de                	jmp    1002a8 <malloc+0x73>
		return NULL;
  1002ca:	bb 00 00 00 00       	mov    $0x0,%ebx
  1002cf:	eb d7                	jmp    1002a8 <malloc+0x73>

00000000001002d1 <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
    return 0;
}
  1002d1:	b8 00 00 00 00       	mov    $0x0,%eax
  1002d6:	c3                   	ret    

00000000001002d7 <realloc>:

void *realloc(void * ptr, uint64_t sz) {
    return 0;
}
  1002d7:	b8 00 00 00 00       	mov    $0x0,%eax
  1002dc:	c3                   	ret    

00000000001002dd <defrag>:

void defrag() {
}
  1002dd:	c3                   	ret    

00000000001002de <heap_info>:

int heap_info(heap_info_struct * info) {
    return 0;
}
  1002de:	b8 00 00 00 00       	mov    $0x0,%eax
  1002e3:	c3                   	ret    

00000000001002e4 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  1002e4:	55                   	push   %rbp
  1002e5:	48 89 e5             	mov    %rsp,%rbp
  1002e8:	48 83 ec 28          	sub    $0x28,%rsp
  1002ec:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1002f0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1002f4:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1002f8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1002fc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100300:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100304:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100308:	eb 1c                	jmp    100326 <memcpy+0x42>
        *d = *s;
  10030a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10030e:	0f b6 10             	movzbl (%rax),%edx
  100311:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100315:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100317:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10031c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100321:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100326:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10032b:	75 dd                	jne    10030a <memcpy+0x26>
    }
    return dst;
  10032d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100331:	c9                   	leave  
  100332:	c3                   	ret    

0000000000100333 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100333:	55                   	push   %rbp
  100334:	48 89 e5             	mov    %rsp,%rbp
  100337:	48 83 ec 28          	sub    $0x28,%rsp
  10033b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10033f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100343:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100347:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10034b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  10034f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100353:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100357:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10035b:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  10035f:	73 6a                	jae    1003cb <memmove+0x98>
  100361:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100365:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100369:	48 01 d0             	add    %rdx,%rax
  10036c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100370:	73 59                	jae    1003cb <memmove+0x98>
        s += n, d += n;
  100372:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100376:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  10037a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10037e:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  100382:	eb 17                	jmp    10039b <memmove+0x68>
            *--d = *--s;
  100384:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100389:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  10038e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100392:	0f b6 10             	movzbl (%rax),%edx
  100395:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100399:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  10039b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10039f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1003a3:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1003a7:	48 85 c0             	test   %rax,%rax
  1003aa:	75 d8                	jne    100384 <memmove+0x51>
    if (s < d && s + n > d) {
  1003ac:	eb 2e                	jmp    1003dc <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1003ae:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1003b2:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1003b6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1003ba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003be:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1003c2:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  1003c6:	0f b6 12             	movzbl (%rdx),%edx
  1003c9:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1003cb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1003cf:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1003d3:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1003d7:	48 85 c0             	test   %rax,%rax
  1003da:	75 d2                	jne    1003ae <memmove+0x7b>
        }
    }
    return dst;
  1003dc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1003e0:	c9                   	leave  
  1003e1:	c3                   	ret    

00000000001003e2 <memset>:

void* memset(void* v, int c, size_t n) {
  1003e2:	55                   	push   %rbp
  1003e3:	48 89 e5             	mov    %rsp,%rbp
  1003e6:	48 83 ec 28          	sub    $0x28,%rsp
  1003ea:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1003ee:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  1003f1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1003f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1003f9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1003fd:	eb 15                	jmp    100414 <memset+0x32>
        *p = c;
  1003ff:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100402:	89 c2                	mov    %eax,%edx
  100404:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100408:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10040a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10040f:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100414:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100419:	75 e4                	jne    1003ff <memset+0x1d>
    }
    return v;
  10041b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10041f:	c9                   	leave  
  100420:	c3                   	ret    

0000000000100421 <strlen>:

size_t strlen(const char* s) {
  100421:	55                   	push   %rbp
  100422:	48 89 e5             	mov    %rsp,%rbp
  100425:	48 83 ec 18          	sub    $0x18,%rsp
  100429:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  10042d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100434:	00 
  100435:	eb 0a                	jmp    100441 <strlen+0x20>
        ++n;
  100437:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  10043c:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100441:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100445:	0f b6 00             	movzbl (%rax),%eax
  100448:	84 c0                	test   %al,%al
  10044a:	75 eb                	jne    100437 <strlen+0x16>
    }
    return n;
  10044c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100450:	c9                   	leave  
  100451:	c3                   	ret    

0000000000100452 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100452:	55                   	push   %rbp
  100453:	48 89 e5             	mov    %rsp,%rbp
  100456:	48 83 ec 20          	sub    $0x20,%rsp
  10045a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10045e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100462:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100469:	00 
  10046a:	eb 0a                	jmp    100476 <strnlen+0x24>
        ++n;
  10046c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100471:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100476:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10047a:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  10047e:	74 0b                	je     10048b <strnlen+0x39>
  100480:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100484:	0f b6 00             	movzbl (%rax),%eax
  100487:	84 c0                	test   %al,%al
  100489:	75 e1                	jne    10046c <strnlen+0x1a>
    }
    return n;
  10048b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  10048f:	c9                   	leave  
  100490:	c3                   	ret    

0000000000100491 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100491:	55                   	push   %rbp
  100492:	48 89 e5             	mov    %rsp,%rbp
  100495:	48 83 ec 20          	sub    $0x20,%rsp
  100499:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10049d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1004a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1004a5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1004a9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1004ad:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1004b1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1004b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004b9:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1004bd:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  1004c1:	0f b6 12             	movzbl (%rdx),%edx
  1004c4:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  1004c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004ca:	48 83 e8 01          	sub    $0x1,%rax
  1004ce:	0f b6 00             	movzbl (%rax),%eax
  1004d1:	84 c0                	test   %al,%al
  1004d3:	75 d4                	jne    1004a9 <strcpy+0x18>
    return dst;
  1004d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1004d9:	c9                   	leave  
  1004da:	c3                   	ret    

00000000001004db <strcmp>:

int strcmp(const char* a, const char* b) {
  1004db:	55                   	push   %rbp
  1004dc:	48 89 e5             	mov    %rsp,%rbp
  1004df:	48 83 ec 10          	sub    $0x10,%rsp
  1004e3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1004e7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1004eb:	eb 0a                	jmp    1004f7 <strcmp+0x1c>
        ++a, ++b;
  1004ed:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1004f2:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1004f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004fb:	0f b6 00             	movzbl (%rax),%eax
  1004fe:	84 c0                	test   %al,%al
  100500:	74 1d                	je     10051f <strcmp+0x44>
  100502:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100506:	0f b6 00             	movzbl (%rax),%eax
  100509:	84 c0                	test   %al,%al
  10050b:	74 12                	je     10051f <strcmp+0x44>
  10050d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100511:	0f b6 10             	movzbl (%rax),%edx
  100514:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100518:	0f b6 00             	movzbl (%rax),%eax
  10051b:	38 c2                	cmp    %al,%dl
  10051d:	74 ce                	je     1004ed <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  10051f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100523:	0f b6 00             	movzbl (%rax),%eax
  100526:	89 c2                	mov    %eax,%edx
  100528:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10052c:	0f b6 00             	movzbl (%rax),%eax
  10052f:	38 d0                	cmp    %dl,%al
  100531:	0f 92 c0             	setb   %al
  100534:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100537:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10053b:	0f b6 00             	movzbl (%rax),%eax
  10053e:	89 c1                	mov    %eax,%ecx
  100540:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100544:	0f b6 00             	movzbl (%rax),%eax
  100547:	38 c1                	cmp    %al,%cl
  100549:	0f 92 c0             	setb   %al
  10054c:	0f b6 c0             	movzbl %al,%eax
  10054f:	29 c2                	sub    %eax,%edx
  100551:	89 d0                	mov    %edx,%eax
}
  100553:	c9                   	leave  
  100554:	c3                   	ret    

0000000000100555 <strchr>:

char* strchr(const char* s, int c) {
  100555:	55                   	push   %rbp
  100556:	48 89 e5             	mov    %rsp,%rbp
  100559:	48 83 ec 10          	sub    $0x10,%rsp
  10055d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100561:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100564:	eb 05                	jmp    10056b <strchr+0x16>
        ++s;
  100566:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  10056b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10056f:	0f b6 00             	movzbl (%rax),%eax
  100572:	84 c0                	test   %al,%al
  100574:	74 0e                	je     100584 <strchr+0x2f>
  100576:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10057a:	0f b6 00             	movzbl (%rax),%eax
  10057d:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100580:	38 d0                	cmp    %dl,%al
  100582:	75 e2                	jne    100566 <strchr+0x11>
    }
    if (*s == (char) c) {
  100584:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100588:	0f b6 00             	movzbl (%rax),%eax
  10058b:	8b 55 f4             	mov    -0xc(%rbp),%edx
  10058e:	38 d0                	cmp    %dl,%al
  100590:	75 06                	jne    100598 <strchr+0x43>
        return (char*) s;
  100592:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100596:	eb 05                	jmp    10059d <strchr+0x48>
    } else {
        return NULL;
  100598:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  10059d:	c9                   	leave  
  10059e:	c3                   	ret    

000000000010059f <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  10059f:	55                   	push   %rbp
  1005a0:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1005a3:	8b 05 87 1a 00 00    	mov    0x1a87(%rip),%eax        # 102030 <rand_seed_set>
  1005a9:	85 c0                	test   %eax,%eax
  1005ab:	75 0a                	jne    1005b7 <rand+0x18>
        srand(819234718U);
  1005ad:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1005b2:	e8 24 00 00 00       	call   1005db <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1005b7:	8b 05 77 1a 00 00    	mov    0x1a77(%rip),%eax        # 102034 <rand_seed>
  1005bd:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  1005c3:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1005c8:	89 05 66 1a 00 00    	mov    %eax,0x1a66(%rip)        # 102034 <rand_seed>
    return rand_seed & RAND_MAX;
  1005ce:	8b 05 60 1a 00 00    	mov    0x1a60(%rip),%eax        # 102034 <rand_seed>
  1005d4:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1005d9:	5d                   	pop    %rbp
  1005da:	c3                   	ret    

00000000001005db <srand>:

void srand(unsigned seed) {
  1005db:	55                   	push   %rbp
  1005dc:	48 89 e5             	mov    %rsp,%rbp
  1005df:	48 83 ec 08          	sub    $0x8,%rsp
  1005e3:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  1005e6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1005e9:	89 05 45 1a 00 00    	mov    %eax,0x1a45(%rip)        # 102034 <rand_seed>
    rand_seed_set = 1;
  1005ef:	c7 05 37 1a 00 00 01 	movl   $0x1,0x1a37(%rip)        # 102030 <rand_seed_set>
  1005f6:	00 00 00 
}
  1005f9:	90                   	nop
  1005fa:	c9                   	leave  
  1005fb:	c3                   	ret    

00000000001005fc <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  1005fc:	55                   	push   %rbp
  1005fd:	48 89 e5             	mov    %rsp,%rbp
  100600:	48 83 ec 28          	sub    $0x28,%rsp
  100604:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100608:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10060c:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  10060f:	48 c7 45 f8 20 15 10 	movq   $0x101520,-0x8(%rbp)
  100616:	00 
    if (base < 0) {
  100617:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  10061b:	79 0b                	jns    100628 <fill_numbuf+0x2c>
        digits = lower_digits;
  10061d:	48 c7 45 f8 40 15 10 	movq   $0x101540,-0x8(%rbp)
  100624:	00 
        base = -base;
  100625:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100628:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10062d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100631:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100634:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100637:	48 63 c8             	movslq %eax,%rcx
  10063a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10063e:	ba 00 00 00 00       	mov    $0x0,%edx
  100643:	48 f7 f1             	div    %rcx
  100646:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10064a:	48 01 d0             	add    %rdx,%rax
  10064d:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100652:	0f b6 10             	movzbl (%rax),%edx
  100655:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100659:	88 10                	mov    %dl,(%rax)
        val /= base;
  10065b:	8b 45 dc             	mov    -0x24(%rbp),%eax
  10065e:	48 63 f0             	movslq %eax,%rsi
  100661:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100665:	ba 00 00 00 00       	mov    $0x0,%edx
  10066a:	48 f7 f6             	div    %rsi
  10066d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100671:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100676:	75 bc                	jne    100634 <fill_numbuf+0x38>
    return numbuf_end;
  100678:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10067c:	c9                   	leave  
  10067d:	c3                   	ret    

000000000010067e <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  10067e:	55                   	push   %rbp
  10067f:	48 89 e5             	mov    %rsp,%rbp
  100682:	53                   	push   %rbx
  100683:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  10068a:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100691:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100697:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10069e:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1006a5:	e9 8a 09 00 00       	jmp    101034 <printer_vprintf+0x9b6>
        if (*format != '%') {
  1006aa:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006b1:	0f b6 00             	movzbl (%rax),%eax
  1006b4:	3c 25                	cmp    $0x25,%al
  1006b6:	74 31                	je     1006e9 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  1006b8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1006bf:	4c 8b 00             	mov    (%rax),%r8
  1006c2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006c9:	0f b6 00             	movzbl (%rax),%eax
  1006cc:	0f b6 c8             	movzbl %al,%ecx
  1006cf:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1006d5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1006dc:	89 ce                	mov    %ecx,%esi
  1006de:	48 89 c7             	mov    %rax,%rdi
  1006e1:	41 ff d0             	call   *%r8
            continue;
  1006e4:	e9 43 09 00 00       	jmp    10102c <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  1006e9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  1006f0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1006f7:	01 
  1006f8:	eb 44                	jmp    10073e <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  1006fa:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100701:	0f b6 00             	movzbl (%rax),%eax
  100704:	0f be c0             	movsbl %al,%eax
  100707:	89 c6                	mov    %eax,%esi
  100709:	bf 40 13 10 00       	mov    $0x101340,%edi
  10070e:	e8 42 fe ff ff       	call   100555 <strchr>
  100713:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100717:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  10071c:	74 30                	je     10074e <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  10071e:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100722:	48 2d 40 13 10 00    	sub    $0x101340,%rax
  100728:	ba 01 00 00 00       	mov    $0x1,%edx
  10072d:	89 c1                	mov    %eax,%ecx
  10072f:	d3 e2                	shl    %cl,%edx
  100731:	89 d0                	mov    %edx,%eax
  100733:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100736:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10073d:	01 
  10073e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100745:	0f b6 00             	movzbl (%rax),%eax
  100748:	84 c0                	test   %al,%al
  10074a:	75 ae                	jne    1006fa <printer_vprintf+0x7c>
  10074c:	eb 01                	jmp    10074f <printer_vprintf+0xd1>
            } else {
                break;
  10074e:	90                   	nop
            }
        }

        // process width
        int width = -1;
  10074f:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100756:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10075d:	0f b6 00             	movzbl (%rax),%eax
  100760:	3c 30                	cmp    $0x30,%al
  100762:	7e 67                	jle    1007cb <printer_vprintf+0x14d>
  100764:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10076b:	0f b6 00             	movzbl (%rax),%eax
  10076e:	3c 39                	cmp    $0x39,%al
  100770:	7f 59                	jg     1007cb <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100772:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100779:	eb 2e                	jmp    1007a9 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  10077b:	8b 55 e8             	mov    -0x18(%rbp),%edx
  10077e:	89 d0                	mov    %edx,%eax
  100780:	c1 e0 02             	shl    $0x2,%eax
  100783:	01 d0                	add    %edx,%eax
  100785:	01 c0                	add    %eax,%eax
  100787:	89 c1                	mov    %eax,%ecx
  100789:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100790:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100794:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10079b:	0f b6 00             	movzbl (%rax),%eax
  10079e:	0f be c0             	movsbl %al,%eax
  1007a1:	01 c8                	add    %ecx,%eax
  1007a3:	83 e8 30             	sub    $0x30,%eax
  1007a6:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1007a9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007b0:	0f b6 00             	movzbl (%rax),%eax
  1007b3:	3c 2f                	cmp    $0x2f,%al
  1007b5:	0f 8e 85 00 00 00    	jle    100840 <printer_vprintf+0x1c2>
  1007bb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007c2:	0f b6 00             	movzbl (%rax),%eax
  1007c5:	3c 39                	cmp    $0x39,%al
  1007c7:	7e b2                	jle    10077b <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  1007c9:	eb 75                	jmp    100840 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  1007cb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007d2:	0f b6 00             	movzbl (%rax),%eax
  1007d5:	3c 2a                	cmp    $0x2a,%al
  1007d7:	75 68                	jne    100841 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  1007d9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007e0:	8b 00                	mov    (%rax),%eax
  1007e2:	83 f8 2f             	cmp    $0x2f,%eax
  1007e5:	77 30                	ja     100817 <printer_vprintf+0x199>
  1007e7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007ee:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1007f2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007f9:	8b 00                	mov    (%rax),%eax
  1007fb:	89 c0                	mov    %eax,%eax
  1007fd:	48 01 d0             	add    %rdx,%rax
  100800:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100807:	8b 12                	mov    (%rdx),%edx
  100809:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10080c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100813:	89 0a                	mov    %ecx,(%rdx)
  100815:	eb 1a                	jmp    100831 <printer_vprintf+0x1b3>
  100817:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10081e:	48 8b 40 08          	mov    0x8(%rax),%rax
  100822:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100826:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10082d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100831:	8b 00                	mov    (%rax),%eax
  100833:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100836:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10083d:	01 
  10083e:	eb 01                	jmp    100841 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100840:	90                   	nop
        }

        // process precision
        int precision = -1;
  100841:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100848:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10084f:	0f b6 00             	movzbl (%rax),%eax
  100852:	3c 2e                	cmp    $0x2e,%al
  100854:	0f 85 00 01 00 00    	jne    10095a <printer_vprintf+0x2dc>
            ++format;
  10085a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100861:	01 
            if (*format >= '0' && *format <= '9') {
  100862:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100869:	0f b6 00             	movzbl (%rax),%eax
  10086c:	3c 2f                	cmp    $0x2f,%al
  10086e:	7e 67                	jle    1008d7 <printer_vprintf+0x259>
  100870:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100877:	0f b6 00             	movzbl (%rax),%eax
  10087a:	3c 39                	cmp    $0x39,%al
  10087c:	7f 59                	jg     1008d7 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10087e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100885:	eb 2e                	jmp    1008b5 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100887:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  10088a:	89 d0                	mov    %edx,%eax
  10088c:	c1 e0 02             	shl    $0x2,%eax
  10088f:	01 d0                	add    %edx,%eax
  100891:	01 c0                	add    %eax,%eax
  100893:	89 c1                	mov    %eax,%ecx
  100895:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10089c:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1008a0:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1008a7:	0f b6 00             	movzbl (%rax),%eax
  1008aa:	0f be c0             	movsbl %al,%eax
  1008ad:	01 c8                	add    %ecx,%eax
  1008af:	83 e8 30             	sub    $0x30,%eax
  1008b2:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1008b5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008bc:	0f b6 00             	movzbl (%rax),%eax
  1008bf:	3c 2f                	cmp    $0x2f,%al
  1008c1:	0f 8e 85 00 00 00    	jle    10094c <printer_vprintf+0x2ce>
  1008c7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008ce:	0f b6 00             	movzbl (%rax),%eax
  1008d1:	3c 39                	cmp    $0x39,%al
  1008d3:	7e b2                	jle    100887 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  1008d5:	eb 75                	jmp    10094c <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  1008d7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008de:	0f b6 00             	movzbl (%rax),%eax
  1008e1:	3c 2a                	cmp    $0x2a,%al
  1008e3:	75 68                	jne    10094d <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  1008e5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008ec:	8b 00                	mov    (%rax),%eax
  1008ee:	83 f8 2f             	cmp    $0x2f,%eax
  1008f1:	77 30                	ja     100923 <printer_vprintf+0x2a5>
  1008f3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008fa:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1008fe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100905:	8b 00                	mov    (%rax),%eax
  100907:	89 c0                	mov    %eax,%eax
  100909:	48 01 d0             	add    %rdx,%rax
  10090c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100913:	8b 12                	mov    (%rdx),%edx
  100915:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100918:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10091f:	89 0a                	mov    %ecx,(%rdx)
  100921:	eb 1a                	jmp    10093d <printer_vprintf+0x2bf>
  100923:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10092a:	48 8b 40 08          	mov    0x8(%rax),%rax
  10092e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100932:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100939:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10093d:	8b 00                	mov    (%rax),%eax
  10093f:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100942:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100949:	01 
  10094a:	eb 01                	jmp    10094d <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  10094c:	90                   	nop
            }
            if (precision < 0) {
  10094d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100951:	79 07                	jns    10095a <printer_vprintf+0x2dc>
                precision = 0;
  100953:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  10095a:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100961:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100968:	00 
        int length = 0;
  100969:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100970:	48 c7 45 c8 46 13 10 	movq   $0x101346,-0x38(%rbp)
  100977:	00 
    again:
        switch (*format) {
  100978:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10097f:	0f b6 00             	movzbl (%rax),%eax
  100982:	0f be c0             	movsbl %al,%eax
  100985:	83 e8 43             	sub    $0x43,%eax
  100988:	83 f8 37             	cmp    $0x37,%eax
  10098b:	0f 87 9f 03 00 00    	ja     100d30 <printer_vprintf+0x6b2>
  100991:	89 c0                	mov    %eax,%eax
  100993:	48 8b 04 c5 58 13 10 	mov    0x101358(,%rax,8),%rax
  10099a:	00 
  10099b:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  10099d:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  1009a4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1009ab:	01 
            goto again;
  1009ac:	eb ca                	jmp    100978 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1009ae:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1009b2:	74 5d                	je     100a11 <printer_vprintf+0x393>
  1009b4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009bb:	8b 00                	mov    (%rax),%eax
  1009bd:	83 f8 2f             	cmp    $0x2f,%eax
  1009c0:	77 30                	ja     1009f2 <printer_vprintf+0x374>
  1009c2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009c9:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1009cd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009d4:	8b 00                	mov    (%rax),%eax
  1009d6:	89 c0                	mov    %eax,%eax
  1009d8:	48 01 d0             	add    %rdx,%rax
  1009db:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009e2:	8b 12                	mov    (%rdx),%edx
  1009e4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1009e7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009ee:	89 0a                	mov    %ecx,(%rdx)
  1009f0:	eb 1a                	jmp    100a0c <printer_vprintf+0x38e>
  1009f2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009f9:	48 8b 40 08          	mov    0x8(%rax),%rax
  1009fd:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a01:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a08:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a0c:	48 8b 00             	mov    (%rax),%rax
  100a0f:	eb 5c                	jmp    100a6d <printer_vprintf+0x3ef>
  100a11:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a18:	8b 00                	mov    (%rax),%eax
  100a1a:	83 f8 2f             	cmp    $0x2f,%eax
  100a1d:	77 30                	ja     100a4f <printer_vprintf+0x3d1>
  100a1f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a26:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a2a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a31:	8b 00                	mov    (%rax),%eax
  100a33:	89 c0                	mov    %eax,%eax
  100a35:	48 01 d0             	add    %rdx,%rax
  100a38:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a3f:	8b 12                	mov    (%rdx),%edx
  100a41:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a44:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a4b:	89 0a                	mov    %ecx,(%rdx)
  100a4d:	eb 1a                	jmp    100a69 <printer_vprintf+0x3eb>
  100a4f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a56:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a5a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a5e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a65:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a69:	8b 00                	mov    (%rax),%eax
  100a6b:	48 98                	cltq   
  100a6d:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100a71:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a75:	48 c1 f8 38          	sar    $0x38,%rax
  100a79:	25 80 00 00 00       	and    $0x80,%eax
  100a7e:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100a81:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100a85:	74 09                	je     100a90 <printer_vprintf+0x412>
  100a87:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a8b:	48 f7 d8             	neg    %rax
  100a8e:	eb 04                	jmp    100a94 <printer_vprintf+0x416>
  100a90:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a94:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100a98:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100a9b:	83 c8 60             	or     $0x60,%eax
  100a9e:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100aa1:	e9 cf 02 00 00       	jmp    100d75 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100aa6:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100aaa:	74 5d                	je     100b09 <printer_vprintf+0x48b>
  100aac:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ab3:	8b 00                	mov    (%rax),%eax
  100ab5:	83 f8 2f             	cmp    $0x2f,%eax
  100ab8:	77 30                	ja     100aea <printer_vprintf+0x46c>
  100aba:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ac1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ac5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100acc:	8b 00                	mov    (%rax),%eax
  100ace:	89 c0                	mov    %eax,%eax
  100ad0:	48 01 d0             	add    %rdx,%rax
  100ad3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ada:	8b 12                	mov    (%rdx),%edx
  100adc:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100adf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ae6:	89 0a                	mov    %ecx,(%rdx)
  100ae8:	eb 1a                	jmp    100b04 <printer_vprintf+0x486>
  100aea:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100af1:	48 8b 40 08          	mov    0x8(%rax),%rax
  100af5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100af9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b00:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b04:	48 8b 00             	mov    (%rax),%rax
  100b07:	eb 5c                	jmp    100b65 <printer_vprintf+0x4e7>
  100b09:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b10:	8b 00                	mov    (%rax),%eax
  100b12:	83 f8 2f             	cmp    $0x2f,%eax
  100b15:	77 30                	ja     100b47 <printer_vprintf+0x4c9>
  100b17:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b1e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b22:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b29:	8b 00                	mov    (%rax),%eax
  100b2b:	89 c0                	mov    %eax,%eax
  100b2d:	48 01 d0             	add    %rdx,%rax
  100b30:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b37:	8b 12                	mov    (%rdx),%edx
  100b39:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b3c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b43:	89 0a                	mov    %ecx,(%rdx)
  100b45:	eb 1a                	jmp    100b61 <printer_vprintf+0x4e3>
  100b47:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b4e:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b52:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b56:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b5d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b61:	8b 00                	mov    (%rax),%eax
  100b63:	89 c0                	mov    %eax,%eax
  100b65:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100b69:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100b6d:	e9 03 02 00 00       	jmp    100d75 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100b72:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100b79:	e9 28 ff ff ff       	jmp    100aa6 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100b7e:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100b85:	e9 1c ff ff ff       	jmp    100aa6 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100b8a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b91:	8b 00                	mov    (%rax),%eax
  100b93:	83 f8 2f             	cmp    $0x2f,%eax
  100b96:	77 30                	ja     100bc8 <printer_vprintf+0x54a>
  100b98:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b9f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ba3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100baa:	8b 00                	mov    (%rax),%eax
  100bac:	89 c0                	mov    %eax,%eax
  100bae:	48 01 d0             	add    %rdx,%rax
  100bb1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bb8:	8b 12                	mov    (%rdx),%edx
  100bba:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bbd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bc4:	89 0a                	mov    %ecx,(%rdx)
  100bc6:	eb 1a                	jmp    100be2 <printer_vprintf+0x564>
  100bc8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bcf:	48 8b 40 08          	mov    0x8(%rax),%rax
  100bd3:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100bd7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bde:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100be2:	48 8b 00             	mov    (%rax),%rax
  100be5:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100be9:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100bf0:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100bf7:	e9 79 01 00 00       	jmp    100d75 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100bfc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c03:	8b 00                	mov    (%rax),%eax
  100c05:	83 f8 2f             	cmp    $0x2f,%eax
  100c08:	77 30                	ja     100c3a <printer_vprintf+0x5bc>
  100c0a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c11:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c15:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c1c:	8b 00                	mov    (%rax),%eax
  100c1e:	89 c0                	mov    %eax,%eax
  100c20:	48 01 d0             	add    %rdx,%rax
  100c23:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c2a:	8b 12                	mov    (%rdx),%edx
  100c2c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c2f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c36:	89 0a                	mov    %ecx,(%rdx)
  100c38:	eb 1a                	jmp    100c54 <printer_vprintf+0x5d6>
  100c3a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c41:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c45:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c49:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c50:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c54:	48 8b 00             	mov    (%rax),%rax
  100c57:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100c5b:	e9 15 01 00 00       	jmp    100d75 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100c60:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c67:	8b 00                	mov    (%rax),%eax
  100c69:	83 f8 2f             	cmp    $0x2f,%eax
  100c6c:	77 30                	ja     100c9e <printer_vprintf+0x620>
  100c6e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c75:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c79:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c80:	8b 00                	mov    (%rax),%eax
  100c82:	89 c0                	mov    %eax,%eax
  100c84:	48 01 d0             	add    %rdx,%rax
  100c87:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c8e:	8b 12                	mov    (%rdx),%edx
  100c90:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c93:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c9a:	89 0a                	mov    %ecx,(%rdx)
  100c9c:	eb 1a                	jmp    100cb8 <printer_vprintf+0x63a>
  100c9e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ca5:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ca9:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100cad:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cb4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100cb8:	8b 00                	mov    (%rax),%eax
  100cba:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100cc0:	e9 67 03 00 00       	jmp    10102c <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  100cc5:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100cc9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100ccd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cd4:	8b 00                	mov    (%rax),%eax
  100cd6:	83 f8 2f             	cmp    $0x2f,%eax
  100cd9:	77 30                	ja     100d0b <printer_vprintf+0x68d>
  100cdb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ce2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ce6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ced:	8b 00                	mov    (%rax),%eax
  100cef:	89 c0                	mov    %eax,%eax
  100cf1:	48 01 d0             	add    %rdx,%rax
  100cf4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cfb:	8b 12                	mov    (%rdx),%edx
  100cfd:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d00:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d07:	89 0a                	mov    %ecx,(%rdx)
  100d09:	eb 1a                	jmp    100d25 <printer_vprintf+0x6a7>
  100d0b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d12:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d16:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d1a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d21:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d25:	8b 00                	mov    (%rax),%eax
  100d27:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100d2a:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100d2e:	eb 45                	jmp    100d75 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  100d30:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d34:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100d38:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d3f:	0f b6 00             	movzbl (%rax),%eax
  100d42:	84 c0                	test   %al,%al
  100d44:	74 0c                	je     100d52 <printer_vprintf+0x6d4>
  100d46:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d4d:	0f b6 00             	movzbl (%rax),%eax
  100d50:	eb 05                	jmp    100d57 <printer_vprintf+0x6d9>
  100d52:	b8 25 00 00 00       	mov    $0x25,%eax
  100d57:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100d5a:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100d5e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d65:	0f b6 00             	movzbl (%rax),%eax
  100d68:	84 c0                	test   %al,%al
  100d6a:	75 08                	jne    100d74 <printer_vprintf+0x6f6>
                format--;
  100d6c:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100d73:	01 
            }
            break;
  100d74:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100d75:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d78:	83 e0 20             	and    $0x20,%eax
  100d7b:	85 c0                	test   %eax,%eax
  100d7d:	74 1e                	je     100d9d <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100d7f:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d83:	48 83 c0 18          	add    $0x18,%rax
  100d87:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100d8a:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100d8e:	48 89 ce             	mov    %rcx,%rsi
  100d91:	48 89 c7             	mov    %rax,%rdi
  100d94:	e8 63 f8 ff ff       	call   1005fc <fill_numbuf>
  100d99:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100d9d:	48 c7 45 c0 46 13 10 	movq   $0x101346,-0x40(%rbp)
  100da4:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100da5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100da8:	83 e0 20             	and    $0x20,%eax
  100dab:	85 c0                	test   %eax,%eax
  100dad:	74 48                	je     100df7 <printer_vprintf+0x779>
  100daf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100db2:	83 e0 40             	and    $0x40,%eax
  100db5:	85 c0                	test   %eax,%eax
  100db7:	74 3e                	je     100df7 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  100db9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dbc:	25 80 00 00 00       	and    $0x80,%eax
  100dc1:	85 c0                	test   %eax,%eax
  100dc3:	74 0a                	je     100dcf <printer_vprintf+0x751>
                prefix = "-";
  100dc5:	48 c7 45 c0 47 13 10 	movq   $0x101347,-0x40(%rbp)
  100dcc:	00 
            if (flags & FLAG_NEGATIVE) {
  100dcd:	eb 73                	jmp    100e42 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100dcf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dd2:	83 e0 10             	and    $0x10,%eax
  100dd5:	85 c0                	test   %eax,%eax
  100dd7:	74 0a                	je     100de3 <printer_vprintf+0x765>
                prefix = "+";
  100dd9:	48 c7 45 c0 49 13 10 	movq   $0x101349,-0x40(%rbp)
  100de0:	00 
            if (flags & FLAG_NEGATIVE) {
  100de1:	eb 5f                	jmp    100e42 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100de3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100de6:	83 e0 08             	and    $0x8,%eax
  100de9:	85 c0                	test   %eax,%eax
  100deb:	74 55                	je     100e42 <printer_vprintf+0x7c4>
                prefix = " ";
  100ded:	48 c7 45 c0 4b 13 10 	movq   $0x10134b,-0x40(%rbp)
  100df4:	00 
            if (flags & FLAG_NEGATIVE) {
  100df5:	eb 4b                	jmp    100e42 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100df7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dfa:	83 e0 20             	and    $0x20,%eax
  100dfd:	85 c0                	test   %eax,%eax
  100dff:	74 42                	je     100e43 <printer_vprintf+0x7c5>
  100e01:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e04:	83 e0 01             	and    $0x1,%eax
  100e07:	85 c0                	test   %eax,%eax
  100e09:	74 38                	je     100e43 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  100e0b:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100e0f:	74 06                	je     100e17 <printer_vprintf+0x799>
  100e11:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100e15:	75 2c                	jne    100e43 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  100e17:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100e1c:	75 0c                	jne    100e2a <printer_vprintf+0x7ac>
  100e1e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e21:	25 00 01 00 00       	and    $0x100,%eax
  100e26:	85 c0                	test   %eax,%eax
  100e28:	74 19                	je     100e43 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  100e2a:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100e2e:	75 07                	jne    100e37 <printer_vprintf+0x7b9>
  100e30:	b8 4d 13 10 00       	mov    $0x10134d,%eax
  100e35:	eb 05                	jmp    100e3c <printer_vprintf+0x7be>
  100e37:	b8 50 13 10 00       	mov    $0x101350,%eax
  100e3c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100e40:	eb 01                	jmp    100e43 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  100e42:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100e43:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100e47:	78 24                	js     100e6d <printer_vprintf+0x7ef>
  100e49:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e4c:	83 e0 20             	and    $0x20,%eax
  100e4f:	85 c0                	test   %eax,%eax
  100e51:	75 1a                	jne    100e6d <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  100e53:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100e56:	48 63 d0             	movslq %eax,%rdx
  100e59:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100e5d:	48 89 d6             	mov    %rdx,%rsi
  100e60:	48 89 c7             	mov    %rax,%rdi
  100e63:	e8 ea f5 ff ff       	call   100452 <strnlen>
  100e68:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100e6b:	eb 0f                	jmp    100e7c <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  100e6d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100e71:	48 89 c7             	mov    %rax,%rdi
  100e74:	e8 a8 f5 ff ff       	call   100421 <strlen>
  100e79:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100e7c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e7f:	83 e0 20             	and    $0x20,%eax
  100e82:	85 c0                	test   %eax,%eax
  100e84:	74 20                	je     100ea6 <printer_vprintf+0x828>
  100e86:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100e8a:	78 1a                	js     100ea6 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  100e8c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100e8f:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100e92:	7e 08                	jle    100e9c <printer_vprintf+0x81e>
  100e94:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100e97:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100e9a:	eb 05                	jmp    100ea1 <printer_vprintf+0x823>
  100e9c:	b8 00 00 00 00       	mov    $0x0,%eax
  100ea1:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100ea4:	eb 5c                	jmp    100f02 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100ea6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ea9:	83 e0 20             	and    $0x20,%eax
  100eac:	85 c0                	test   %eax,%eax
  100eae:	74 4b                	je     100efb <printer_vprintf+0x87d>
  100eb0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100eb3:	83 e0 02             	and    $0x2,%eax
  100eb6:	85 c0                	test   %eax,%eax
  100eb8:	74 41                	je     100efb <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100eba:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ebd:	83 e0 04             	and    $0x4,%eax
  100ec0:	85 c0                	test   %eax,%eax
  100ec2:	75 37                	jne    100efb <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  100ec4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100ec8:	48 89 c7             	mov    %rax,%rdi
  100ecb:	e8 51 f5 ff ff       	call   100421 <strlen>
  100ed0:	89 c2                	mov    %eax,%edx
  100ed2:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100ed5:	01 d0                	add    %edx,%eax
  100ed7:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100eda:	7e 1f                	jle    100efb <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  100edc:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100edf:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100ee2:	89 c3                	mov    %eax,%ebx
  100ee4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100ee8:	48 89 c7             	mov    %rax,%rdi
  100eeb:	e8 31 f5 ff ff       	call   100421 <strlen>
  100ef0:	89 c2                	mov    %eax,%edx
  100ef2:	89 d8                	mov    %ebx,%eax
  100ef4:	29 d0                	sub    %edx,%eax
  100ef6:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100ef9:	eb 07                	jmp    100f02 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  100efb:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100f02:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100f05:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100f08:	01 d0                	add    %edx,%eax
  100f0a:	48 63 d8             	movslq %eax,%rbx
  100f0d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f11:	48 89 c7             	mov    %rax,%rdi
  100f14:	e8 08 f5 ff ff       	call   100421 <strlen>
  100f19:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100f1d:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100f20:	29 d0                	sub    %edx,%eax
  100f22:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100f25:	eb 25                	jmp    100f4c <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  100f27:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f2e:	48 8b 08             	mov    (%rax),%rcx
  100f31:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f37:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f3e:	be 20 00 00 00       	mov    $0x20,%esi
  100f43:	48 89 c7             	mov    %rax,%rdi
  100f46:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100f48:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100f4c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f4f:	83 e0 04             	and    $0x4,%eax
  100f52:	85 c0                	test   %eax,%eax
  100f54:	75 36                	jne    100f8c <printer_vprintf+0x90e>
  100f56:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100f5a:	7f cb                	jg     100f27 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  100f5c:	eb 2e                	jmp    100f8c <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  100f5e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f65:	4c 8b 00             	mov    (%rax),%r8
  100f68:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f6c:	0f b6 00             	movzbl (%rax),%eax
  100f6f:	0f b6 c8             	movzbl %al,%ecx
  100f72:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f78:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f7f:	89 ce                	mov    %ecx,%esi
  100f81:	48 89 c7             	mov    %rax,%rdi
  100f84:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  100f87:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  100f8c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f90:	0f b6 00             	movzbl (%rax),%eax
  100f93:	84 c0                	test   %al,%al
  100f95:	75 c7                	jne    100f5e <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  100f97:	eb 25                	jmp    100fbe <printer_vprintf+0x940>
            p->putc(p, '0', color);
  100f99:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fa0:	48 8b 08             	mov    (%rax),%rcx
  100fa3:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100fa9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fb0:	be 30 00 00 00       	mov    $0x30,%esi
  100fb5:	48 89 c7             	mov    %rax,%rdi
  100fb8:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  100fba:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  100fbe:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  100fc2:	7f d5                	jg     100f99 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  100fc4:	eb 32                	jmp    100ff8 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  100fc6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fcd:	4c 8b 00             	mov    (%rax),%r8
  100fd0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100fd4:	0f b6 00             	movzbl (%rax),%eax
  100fd7:	0f b6 c8             	movzbl %al,%ecx
  100fda:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100fe0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fe7:	89 ce                	mov    %ecx,%esi
  100fe9:	48 89 c7             	mov    %rax,%rdi
  100fec:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  100fef:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  100ff4:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  100ff8:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  100ffc:	7f c8                	jg     100fc6 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  100ffe:	eb 25                	jmp    101025 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  101000:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101007:	48 8b 08             	mov    (%rax),%rcx
  10100a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101010:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101017:	be 20 00 00 00       	mov    $0x20,%esi
  10101c:	48 89 c7             	mov    %rax,%rdi
  10101f:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  101021:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101025:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101029:	7f d5                	jg     101000 <printer_vprintf+0x982>
        }
    done: ;
  10102b:	90                   	nop
    for (; *format; ++format) {
  10102c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101033:	01 
  101034:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10103b:	0f b6 00             	movzbl (%rax),%eax
  10103e:	84 c0                	test   %al,%al
  101040:	0f 85 64 f6 ff ff    	jne    1006aa <printer_vprintf+0x2c>
    }
}
  101046:	90                   	nop
  101047:	90                   	nop
  101048:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  10104c:	c9                   	leave  
  10104d:	c3                   	ret    

000000000010104e <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  10104e:	55                   	push   %rbp
  10104f:	48 89 e5             	mov    %rsp,%rbp
  101052:	48 83 ec 20          	sub    $0x20,%rsp
  101056:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10105a:	89 f0                	mov    %esi,%eax
  10105c:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10105f:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  101062:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101066:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10106a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10106e:	48 8b 40 08          	mov    0x8(%rax),%rax
  101072:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  101077:	48 39 d0             	cmp    %rdx,%rax
  10107a:	72 0c                	jb     101088 <console_putc+0x3a>
        cp->cursor = console;
  10107c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101080:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  101087:	00 
    }
    if (c == '\n') {
  101088:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  10108c:	75 78                	jne    101106 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  10108e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101092:	48 8b 40 08          	mov    0x8(%rax),%rax
  101096:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  10109c:	48 d1 f8             	sar    %rax
  10109f:	48 89 c1             	mov    %rax,%rcx
  1010a2:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1010a9:	66 66 66 
  1010ac:	48 89 c8             	mov    %rcx,%rax
  1010af:	48 f7 ea             	imul   %rdx
  1010b2:	48 c1 fa 05          	sar    $0x5,%rdx
  1010b6:	48 89 c8             	mov    %rcx,%rax
  1010b9:	48 c1 f8 3f          	sar    $0x3f,%rax
  1010bd:	48 29 c2             	sub    %rax,%rdx
  1010c0:	48 89 d0             	mov    %rdx,%rax
  1010c3:	48 c1 e0 02          	shl    $0x2,%rax
  1010c7:	48 01 d0             	add    %rdx,%rax
  1010ca:	48 c1 e0 04          	shl    $0x4,%rax
  1010ce:	48 29 c1             	sub    %rax,%rcx
  1010d1:	48 89 ca             	mov    %rcx,%rdx
  1010d4:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  1010d7:	eb 25                	jmp    1010fe <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  1010d9:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1010dc:	83 c8 20             	or     $0x20,%eax
  1010df:	89 c6                	mov    %eax,%esi
  1010e1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010e5:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010e9:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1010ed:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1010f1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1010f5:	89 f2                	mov    %esi,%edx
  1010f7:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  1010fa:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1010fe:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101102:	75 d5                	jne    1010d9 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101104:	eb 24                	jmp    10112a <console_putc+0xdc>
        *cp->cursor++ = c | color;
  101106:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  10110a:	8b 55 e0             	mov    -0x20(%rbp),%edx
  10110d:	09 d0                	or     %edx,%eax
  10110f:	89 c6                	mov    %eax,%esi
  101111:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101115:	48 8b 40 08          	mov    0x8(%rax),%rax
  101119:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10111d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101121:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101125:	89 f2                	mov    %esi,%edx
  101127:	66 89 10             	mov    %dx,(%rax)
}
  10112a:	90                   	nop
  10112b:	c9                   	leave  
  10112c:	c3                   	ret    

000000000010112d <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  10112d:	55                   	push   %rbp
  10112e:	48 89 e5             	mov    %rsp,%rbp
  101131:	48 83 ec 30          	sub    $0x30,%rsp
  101135:	89 7d ec             	mov    %edi,-0x14(%rbp)
  101138:	89 75 e8             	mov    %esi,-0x18(%rbp)
  10113b:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  10113f:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  101143:	48 c7 45 f0 4e 10 10 	movq   $0x10104e,-0x10(%rbp)
  10114a:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10114b:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  10114f:	78 09                	js     10115a <console_vprintf+0x2d>
  101151:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101158:	7e 07                	jle    101161 <console_vprintf+0x34>
        cpos = 0;
  10115a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  101161:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101164:	48 98                	cltq   
  101166:	48 01 c0             	add    %rax,%rax
  101169:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  10116f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101173:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101177:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  10117b:	8b 75 e8             	mov    -0x18(%rbp),%esi
  10117e:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101182:	48 89 c7             	mov    %rax,%rdi
  101185:	e8 f4 f4 ff ff       	call   10067e <printer_vprintf>
    return cp.cursor - console;
  10118a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10118e:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  101194:	48 d1 f8             	sar    %rax
}
  101197:	c9                   	leave  
  101198:	c3                   	ret    

0000000000101199 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  101199:	55                   	push   %rbp
  10119a:	48 89 e5             	mov    %rsp,%rbp
  10119d:	48 83 ec 60          	sub    $0x60,%rsp
  1011a1:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1011a4:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1011a7:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1011ab:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1011af:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1011b3:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1011b7:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1011be:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1011c2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1011c6:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1011ca:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1011ce:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1011d2:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  1011d6:	8b 75 a8             	mov    -0x58(%rbp),%esi
  1011d9:	8b 45 ac             	mov    -0x54(%rbp),%eax
  1011dc:	89 c7                	mov    %eax,%edi
  1011de:	e8 4a ff ff ff       	call   10112d <console_vprintf>
  1011e3:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  1011e6:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  1011e9:	c9                   	leave  
  1011ea:	c3                   	ret    

00000000001011eb <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  1011eb:	55                   	push   %rbp
  1011ec:	48 89 e5             	mov    %rsp,%rbp
  1011ef:	48 83 ec 20          	sub    $0x20,%rsp
  1011f3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1011f7:	89 f0                	mov    %esi,%eax
  1011f9:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1011fc:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  1011ff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101203:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101207:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10120b:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10120f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101213:	48 8b 40 10          	mov    0x10(%rax),%rax
  101217:	48 39 c2             	cmp    %rax,%rdx
  10121a:	73 1a                	jae    101236 <string_putc+0x4b>
        *sp->s++ = c;
  10121c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101220:	48 8b 40 08          	mov    0x8(%rax),%rax
  101224:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101228:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10122c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101230:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101234:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101236:	90                   	nop
  101237:	c9                   	leave  
  101238:	c3                   	ret    

0000000000101239 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101239:	55                   	push   %rbp
  10123a:	48 89 e5             	mov    %rsp,%rbp
  10123d:	48 83 ec 40          	sub    $0x40,%rsp
  101241:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101245:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101249:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  10124d:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101251:	48 c7 45 e8 eb 11 10 	movq   $0x1011eb,-0x18(%rbp)
  101258:	00 
    sp.s = s;
  101259:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10125d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  101261:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  101266:	74 33                	je     10129b <vsnprintf+0x62>
        sp.end = s + size - 1;
  101268:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  10126c:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101270:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101274:	48 01 d0             	add    %rdx,%rax
  101277:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  10127b:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  10127f:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101283:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101287:	be 00 00 00 00       	mov    $0x0,%esi
  10128c:	48 89 c7             	mov    %rax,%rdi
  10128f:	e8 ea f3 ff ff       	call   10067e <printer_vprintf>
        *sp.s = 0;
  101294:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101298:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  10129b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10129f:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1012a3:	c9                   	leave  
  1012a4:	c3                   	ret    

00000000001012a5 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1012a5:	55                   	push   %rbp
  1012a6:	48 89 e5             	mov    %rsp,%rbp
  1012a9:	48 83 ec 70          	sub    $0x70,%rsp
  1012ad:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1012b1:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1012b5:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1012b9:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1012bd:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1012c1:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1012c5:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  1012cc:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1012d0:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  1012d4:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1012d8:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  1012dc:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  1012e0:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  1012e4:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  1012e8:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1012ec:	48 89 c7             	mov    %rax,%rdi
  1012ef:	e8 45 ff ff ff       	call   101239 <vsnprintf>
  1012f4:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  1012f7:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  1012fa:	c9                   	leave  
  1012fb:	c3                   	ret    

00000000001012fc <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  1012fc:	55                   	push   %rbp
  1012fd:	48 89 e5             	mov    %rsp,%rbp
  101300:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101304:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  10130b:	eb 13                	jmp    101320 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  10130d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  101310:	48 98                	cltq   
  101312:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  101319:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10131c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101320:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101327:	7e e4                	jle    10130d <console_clear+0x11>
    }
    cursorpos = 0;
  101329:	c7 05 c9 7c fb ff 00 	movl   $0x0,-0x48337(%rip)        # b8ffc <cursorpos>
  101330:	00 00 00 
}
  101333:	90                   	nop
  101334:	c9                   	leave  
  101335:	c3                   	ret    
