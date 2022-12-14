
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
  100037:	e8 f4 04 00 00       	call   100530 <rand>
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
  10005f:	e8 81 01 00 00       	call   1001e5 <malloc>
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
	return;
}
  1000ff:	c3                   	ret    

0000000000100100 <extend>:
//
//	the reason alloating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
void extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  100100:	48 81 c7 ff 3f 00 00 	add    $0x3fff,%rdi
  100107:	48 81 e7 00 c0 ff ff 	and    $0xffffffffffffc000,%rdi
  10010e:	cd 3a                	int    $0x3a
  100110:	48 89 05 11 1f 00 00 	mov    %rax,0x1f11(%rip)        # 102028 <result.0>
	void *bp = sbrk(chunk_aligned_size);

	// setup pointer
	GET_SIZE(HDRP(bp)) = chunk_aligned_size;
  100117:	48 89 78 f0          	mov    %rdi,-0x10(%rax)
	GET_ALLOC(HDRP(bp)) = 0;
  10011b:	c7 40 f8 00 00 00 00 	movl   $0x0,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  100122:	48 8b 15 e7 1e 00 00 	mov    0x1ee7(%rip),%rdx        # 102010 <free_list>
  100129:	48 89 10             	mov    %rdx,(%rax)
	PREV_FPTR(bp) = NULL;
  10012c:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  100133:	00 
	GET_SIZE(FTRP(bp)) = chunk_aligned_size;
  100134:	48 89 7c 07 e0       	mov    %rdi,-0x20(%rdi,%rax,1)

	// add to head of free_list
	if (free_list)
  100139:	48 8b 15 d0 1e 00 00 	mov    0x1ed0(%rip),%rdx        # 102010 <free_list>
  100140:	48 85 d2             	test   %rdx,%rdx
  100143:	74 04                	je     100149 <extend+0x49>
		PREV_FPTR(free_list) = bp;
  100145:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  100149:	48 89 05 c0 1e 00 00 	mov    %rax,0x1ec0(%rip)        # 102010 <free_list>

	// update terminal block
	GET_SIZE(HDRP(NEXT_BLKP(bp))) = 0;
  100150:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  100154:	48 c7 44 10 f0 00 00 	movq   $0x0,-0x10(%rax,%rdx,1)
  10015b:	00 00 
	GET_ALLOC(HDRP(NEXT_BLKP(bp))) = 1;
  10015d:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  100161:	c7 44 10 f8 01 00 00 	movl   $0x1,-0x8(%rax,%rdx,1)
  100168:	00 
    asm volatile ("int %0" : /* no result */
  100169:	bf d0 12 10 00       	mov    $0x1012d0,%edi
  10016e:	cd 30                	int    $0x30
 loop: goto loop;
  100170:	eb fe                	jmp    100170 <extend+0x70>

0000000000100172 <set_allocated>:
}

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  100172:	48 8b 47 f0          	mov    -0x10(%rdi),%rax
  100176:	48 29 f0             	sub    %rsi,%rax

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  100179:	48 83 f8 30          	cmp    $0x30,%rax
  10017d:	76 45                	jbe    1001c4 <set_allocated+0x52>
		GET_SIZE(HDRP(bp)) = size;
  10017f:	48 89 77 f0          	mov    %rsi,-0x10(%rdi)
		void *leftover_mem_ptr = NEXT_BLKP(bp);
  100183:	48 01 fe             	add    %rdi,%rsi

		GET_SIZE(HDRP(leftover_mem_ptr)) = extra_size;
  100186:	48 89 46 f0          	mov    %rax,-0x10(%rsi)
		GET_ALLOC(HDRP(leftover_mem_ptr)) = 0;
  10018a:	c7 46 f8 00 00 00 00 	movl   $0x0,-0x8(%rsi)

		// add pointers to previous and next free block
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp);
  100191:	48 8b 17             	mov    (%rdi),%rdx
  100194:	48 89 16             	mov    %rdx,(%rsi)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  100197:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10019b:	48 89 56 08          	mov    %rdx,0x8(%rsi)
	
		GET_SIZE(FTRP(leftover_mem_ptr)) = extra_size;
  10019f:	48 89 44 06 e0       	mov    %rax,-0x20(%rsi,%rax,1)

		// update the pointers in previous and next free block to the leftover, as long as they aren't null
		if (PREV_FPTR(bp))
  1001a4:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1001a8:	48 85 c0             	test   %rax,%rax
  1001ab:	74 03                	je     1001b0 <set_allocated+0x3e>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  1001ad:	48 89 30             	mov    %rsi,(%rax)
		if (NEXT_FPTR(bp))
  1001b0:	48 8b 07             	mov    (%rdi),%rax
  1001b3:	48 85 c0             	test   %rax,%rax
  1001b6:	74 04                	je     1001bc <set_allocated+0x4a>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  1001b8:	48 89 70 08          	mov    %rsi,0x8(%rax)
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
		if (NEXT_FPTR(bp))
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
	}
	
	GET_ALLOC(HDRP(bp)) = 1;
  1001bc:	c7 47 f8 01 00 00 00 	movl   $0x1,-0x8(%rdi)
}
  1001c3:	c3                   	ret    
		if (PREV_FPTR(bp))
  1001c4:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1001c8:	48 85 c0             	test   %rax,%rax
  1001cb:	74 06                	je     1001d3 <set_allocated+0x61>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  1001cd:	48 8b 17             	mov    (%rdi),%rdx
  1001d0:	48 89 10             	mov    %rdx,(%rax)
		if (NEXT_FPTR(bp))
  1001d3:	48 8b 07             	mov    (%rdi),%rax
  1001d6:	48 85 c0             	test   %rax,%rax
  1001d9:	74 e1                	je     1001bc <set_allocated+0x4a>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  1001db:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1001df:	48 89 50 08          	mov    %rdx,0x8(%rax)
  1001e3:	eb d7                	jmp    1001bc <set_allocated+0x4a>

00000000001001e5 <malloc>:

void *malloc(uint64_t numbytes) {
  1001e5:	55                   	push   %rbp
  1001e6:	48 89 e5             	mov    %rsp,%rbp
  1001e9:	53                   	push   %rbx
  1001ea:	48 83 ec 08          	sub    $0x8,%rsp
  1001ee:	48 89 fb             	mov    %rdi,%rbx
	if (!initialized_heap)
  1001f1:	83 3d 28 1e 00 00 00 	cmpl   $0x0,0x1e28(%rip)        # 102020 <initialized_heap>
  1001f8:	74 49                	je     100243 <malloc+0x5e>
		heap_init();

	if (numbytes == 0)
  1001fa:	48 85 db             	test   %rbx,%rbx
  1001fd:	74 5c                	je     10025b <malloc+0x76>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  1001ff:	48 8d 73 1f          	lea    0x1f(%rbx),%rsi
  100203:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  100207:	b8 30 00 00 00       	mov    $0x30,%eax
  10020c:	48 39 c6             	cmp    %rax,%rsi
  10020f:	48 0f 42 f0          	cmovb  %rax,%rsi
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);

	void *bp = free_list;
  100213:	48 8b 1d f6 1d 00 00 	mov    0x1df6(%rip),%rbx        # 102010 <free_list>
	while (bp) {
  10021a:	48 85 db             	test   %rbx,%rbx
  10021d:	74 0e                	je     10022d <malloc+0x48>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  10021f:	48 39 73 f0          	cmp    %rsi,-0x10(%rbx)
  100223:	73 25                	jae    10024a <malloc+0x65>
			set_allocated(bp, aligned_size);
			return bp;
		}

		bp = NEXT_FPTR(bp);
  100225:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  100228:	48 85 db             	test   %rbx,%rbx
  10022b:	75 f2                	jne    10021f <malloc+0x3a>
    asm volatile ("int %1" :  "=a" (result)
  10022d:	bf 00 00 00 00       	mov    $0x0,%edi
  100232:	cd 3a                	int    $0x3a
  100234:	48 89 05 ed 1d 00 00 	mov    %rax,0x1ded(%rip)        # 102028 <result.0>
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0) - OVERHEAD;
	extend(aligned_size);
  10023b:	48 89 f7             	mov    %rsi,%rdi
  10023e:	e8 bd fe ff ff       	call   100100 <extend>
		heap_init();
  100243:	e8 29 fe ff ff       	call   100071 <heap_init>
  100248:	eb b0                	jmp    1001fa <malloc+0x15>
			set_allocated(bp, aligned_size);
  10024a:	48 89 df             	mov    %rbx,%rdi
  10024d:	e8 20 ff ff ff       	call   100172 <set_allocated>
	set_allocated(bp, aligned_size);
    return bp;
}
  100252:	48 89 d8             	mov    %rbx,%rax
  100255:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100259:	c9                   	leave  
  10025a:	c3                   	ret    
		return NULL;
  10025b:	bb 00 00 00 00       	mov    $0x0,%ebx
  100260:	eb f0                	jmp    100252 <malloc+0x6d>

0000000000100262 <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
    return 0;
}
  100262:	b8 00 00 00 00       	mov    $0x0,%eax
  100267:	c3                   	ret    

0000000000100268 <realloc>:

void *realloc(void * ptr, uint64_t sz) {
    return 0;
}
  100268:	b8 00 00 00 00       	mov    $0x0,%eax
  10026d:	c3                   	ret    

000000000010026e <defrag>:

void defrag() {
}
  10026e:	c3                   	ret    

000000000010026f <heap_info>:

int heap_info(heap_info_struct * info) {
    return 0;
}
  10026f:	b8 00 00 00 00       	mov    $0x0,%eax
  100274:	c3                   	ret    

0000000000100275 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100275:	55                   	push   %rbp
  100276:	48 89 e5             	mov    %rsp,%rbp
  100279:	48 83 ec 28          	sub    $0x28,%rsp
  10027d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100281:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100285:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100289:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10028d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100291:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100295:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100299:	eb 1c                	jmp    1002b7 <memcpy+0x42>
        *d = *s;
  10029b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10029f:	0f b6 10             	movzbl (%rax),%edx
  1002a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1002a6:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1002a8:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1002ad:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1002b2:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1002b7:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1002bc:	75 dd                	jne    10029b <memcpy+0x26>
    }
    return dst;
  1002be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1002c2:	c9                   	leave  
  1002c3:	c3                   	ret    

00000000001002c4 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1002c4:	55                   	push   %rbp
  1002c5:	48 89 e5             	mov    %rsp,%rbp
  1002c8:	48 83 ec 28          	sub    $0x28,%rsp
  1002cc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1002d0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1002d4:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1002d8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1002dc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  1002e0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1002e4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  1002e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002ec:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  1002f0:	73 6a                	jae    10035c <memmove+0x98>
  1002f2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1002f6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1002fa:	48 01 d0             	add    %rdx,%rax
  1002fd:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100301:	73 59                	jae    10035c <memmove+0x98>
        s += n, d += n;
  100303:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100307:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  10030b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10030f:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  100313:	eb 17                	jmp    10032c <memmove+0x68>
            *--d = *--s;
  100315:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  10031a:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  10031f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100323:	0f b6 10             	movzbl (%rax),%edx
  100326:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10032a:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  10032c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100330:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100334:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100338:	48 85 c0             	test   %rax,%rax
  10033b:	75 d8                	jne    100315 <memmove+0x51>
    if (s < d && s + n > d) {
  10033d:	eb 2e                	jmp    10036d <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  10033f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100343:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100347:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10034b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10034f:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100353:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100357:	0f b6 12             	movzbl (%rdx),%edx
  10035a:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  10035c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100360:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100364:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100368:	48 85 c0             	test   %rax,%rax
  10036b:	75 d2                	jne    10033f <memmove+0x7b>
        }
    }
    return dst;
  10036d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100371:	c9                   	leave  
  100372:	c3                   	ret    

0000000000100373 <memset>:

void* memset(void* v, int c, size_t n) {
  100373:	55                   	push   %rbp
  100374:	48 89 e5             	mov    %rsp,%rbp
  100377:	48 83 ec 28          	sub    $0x28,%rsp
  10037b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10037f:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100382:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100386:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10038a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10038e:	eb 15                	jmp    1003a5 <memset+0x32>
        *p = c;
  100390:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100393:	89 c2                	mov    %eax,%edx
  100395:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100399:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10039b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1003a0:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1003a5:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1003aa:	75 e4                	jne    100390 <memset+0x1d>
    }
    return v;
  1003ac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1003b0:	c9                   	leave  
  1003b1:	c3                   	ret    

00000000001003b2 <strlen>:

size_t strlen(const char* s) {
  1003b2:	55                   	push   %rbp
  1003b3:	48 89 e5             	mov    %rsp,%rbp
  1003b6:	48 83 ec 18          	sub    $0x18,%rsp
  1003ba:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  1003be:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1003c5:	00 
  1003c6:	eb 0a                	jmp    1003d2 <strlen+0x20>
        ++n;
  1003c8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  1003cd:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1003d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1003d6:	0f b6 00             	movzbl (%rax),%eax
  1003d9:	84 c0                	test   %al,%al
  1003db:	75 eb                	jne    1003c8 <strlen+0x16>
    }
    return n;
  1003dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1003e1:	c9                   	leave  
  1003e2:	c3                   	ret    

00000000001003e3 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  1003e3:	55                   	push   %rbp
  1003e4:	48 89 e5             	mov    %rsp,%rbp
  1003e7:	48 83 ec 20          	sub    $0x20,%rsp
  1003eb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1003ef:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1003f3:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1003fa:	00 
  1003fb:	eb 0a                	jmp    100407 <strnlen+0x24>
        ++n;
  1003fd:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100402:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100407:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10040b:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  10040f:	74 0b                	je     10041c <strnlen+0x39>
  100411:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100415:	0f b6 00             	movzbl (%rax),%eax
  100418:	84 c0                	test   %al,%al
  10041a:	75 e1                	jne    1003fd <strnlen+0x1a>
    }
    return n;
  10041c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100420:	c9                   	leave  
  100421:	c3                   	ret    

0000000000100422 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100422:	55                   	push   %rbp
  100423:	48 89 e5             	mov    %rsp,%rbp
  100426:	48 83 ec 20          	sub    $0x20,%rsp
  10042a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10042e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  100432:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100436:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  10043a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  10043e:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100442:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100446:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10044a:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10044e:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100452:	0f b6 12             	movzbl (%rdx),%edx
  100455:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100457:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10045b:	48 83 e8 01          	sub    $0x1,%rax
  10045f:	0f b6 00             	movzbl (%rax),%eax
  100462:	84 c0                	test   %al,%al
  100464:	75 d4                	jne    10043a <strcpy+0x18>
    return dst;
  100466:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10046a:	c9                   	leave  
  10046b:	c3                   	ret    

000000000010046c <strcmp>:

int strcmp(const char* a, const char* b) {
  10046c:	55                   	push   %rbp
  10046d:	48 89 e5             	mov    %rsp,%rbp
  100470:	48 83 ec 10          	sub    $0x10,%rsp
  100474:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100478:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10047c:	eb 0a                	jmp    100488 <strcmp+0x1c>
        ++a, ++b;
  10047e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100483:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100488:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10048c:	0f b6 00             	movzbl (%rax),%eax
  10048f:	84 c0                	test   %al,%al
  100491:	74 1d                	je     1004b0 <strcmp+0x44>
  100493:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100497:	0f b6 00             	movzbl (%rax),%eax
  10049a:	84 c0                	test   %al,%al
  10049c:	74 12                	je     1004b0 <strcmp+0x44>
  10049e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004a2:	0f b6 10             	movzbl (%rax),%edx
  1004a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004a9:	0f b6 00             	movzbl (%rax),%eax
  1004ac:	38 c2                	cmp    %al,%dl
  1004ae:	74 ce                	je     10047e <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  1004b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004b4:	0f b6 00             	movzbl (%rax),%eax
  1004b7:	89 c2                	mov    %eax,%edx
  1004b9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004bd:	0f b6 00             	movzbl (%rax),%eax
  1004c0:	38 d0                	cmp    %dl,%al
  1004c2:	0f 92 c0             	setb   %al
  1004c5:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  1004c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004cc:	0f b6 00             	movzbl (%rax),%eax
  1004cf:	89 c1                	mov    %eax,%ecx
  1004d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004d5:	0f b6 00             	movzbl (%rax),%eax
  1004d8:	38 c1                	cmp    %al,%cl
  1004da:	0f 92 c0             	setb   %al
  1004dd:	0f b6 c0             	movzbl %al,%eax
  1004e0:	29 c2                	sub    %eax,%edx
  1004e2:	89 d0                	mov    %edx,%eax
}
  1004e4:	c9                   	leave  
  1004e5:	c3                   	ret    

00000000001004e6 <strchr>:

char* strchr(const char* s, int c) {
  1004e6:	55                   	push   %rbp
  1004e7:	48 89 e5             	mov    %rsp,%rbp
  1004ea:	48 83 ec 10          	sub    $0x10,%rsp
  1004ee:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1004f2:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1004f5:	eb 05                	jmp    1004fc <strchr+0x16>
        ++s;
  1004f7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1004fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100500:	0f b6 00             	movzbl (%rax),%eax
  100503:	84 c0                	test   %al,%al
  100505:	74 0e                	je     100515 <strchr+0x2f>
  100507:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10050b:	0f b6 00             	movzbl (%rax),%eax
  10050e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100511:	38 d0                	cmp    %dl,%al
  100513:	75 e2                	jne    1004f7 <strchr+0x11>
    }
    if (*s == (char) c) {
  100515:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100519:	0f b6 00             	movzbl (%rax),%eax
  10051c:	8b 55 f4             	mov    -0xc(%rbp),%edx
  10051f:	38 d0                	cmp    %dl,%al
  100521:	75 06                	jne    100529 <strchr+0x43>
        return (char*) s;
  100523:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100527:	eb 05                	jmp    10052e <strchr+0x48>
    } else {
        return NULL;
  100529:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  10052e:	c9                   	leave  
  10052f:	c3                   	ret    

0000000000100530 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100530:	55                   	push   %rbp
  100531:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  100534:	8b 05 f6 1a 00 00    	mov    0x1af6(%rip),%eax        # 102030 <rand_seed_set>
  10053a:	85 c0                	test   %eax,%eax
  10053c:	75 0a                	jne    100548 <rand+0x18>
        srand(819234718U);
  10053e:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100543:	e8 24 00 00 00       	call   10056c <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100548:	8b 05 e6 1a 00 00    	mov    0x1ae6(%rip),%eax        # 102034 <rand_seed>
  10054e:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100554:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100559:	89 05 d5 1a 00 00    	mov    %eax,0x1ad5(%rip)        # 102034 <rand_seed>
    return rand_seed & RAND_MAX;
  10055f:	8b 05 cf 1a 00 00    	mov    0x1acf(%rip),%eax        # 102034 <rand_seed>
  100565:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  10056a:	5d                   	pop    %rbp
  10056b:	c3                   	ret    

000000000010056c <srand>:

void srand(unsigned seed) {
  10056c:	55                   	push   %rbp
  10056d:	48 89 e5             	mov    %rsp,%rbp
  100570:	48 83 ec 08          	sub    $0x8,%rsp
  100574:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100577:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10057a:	89 05 b4 1a 00 00    	mov    %eax,0x1ab4(%rip)        # 102034 <rand_seed>
    rand_seed_set = 1;
  100580:	c7 05 a6 1a 00 00 01 	movl   $0x1,0x1aa6(%rip)        # 102030 <rand_seed_set>
  100587:	00 00 00 
}
  10058a:	90                   	nop
  10058b:	c9                   	leave  
  10058c:	c3                   	ret    

000000000010058d <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  10058d:	55                   	push   %rbp
  10058e:	48 89 e5             	mov    %rsp,%rbp
  100591:	48 83 ec 28          	sub    $0x28,%rsp
  100595:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100599:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10059d:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  1005a0:	48 c7 45 f8 c0 14 10 	movq   $0x1014c0,-0x8(%rbp)
  1005a7:	00 
    if (base < 0) {
  1005a8:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  1005ac:	79 0b                	jns    1005b9 <fill_numbuf+0x2c>
        digits = lower_digits;
  1005ae:	48 c7 45 f8 e0 14 10 	movq   $0x1014e0,-0x8(%rbp)
  1005b5:	00 
        base = -base;
  1005b6:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  1005b9:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1005be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1005c2:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  1005c5:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1005c8:	48 63 c8             	movslq %eax,%rcx
  1005cb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1005cf:	ba 00 00 00 00       	mov    $0x0,%edx
  1005d4:	48 f7 f1             	div    %rcx
  1005d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005db:	48 01 d0             	add    %rdx,%rax
  1005de:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1005e3:	0f b6 10             	movzbl (%rax),%edx
  1005e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1005ea:	88 10                	mov    %dl,(%rax)
        val /= base;
  1005ec:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1005ef:	48 63 f0             	movslq %eax,%rsi
  1005f2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1005f6:	ba 00 00 00 00       	mov    $0x0,%edx
  1005fb:	48 f7 f6             	div    %rsi
  1005fe:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100602:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100607:	75 bc                	jne    1005c5 <fill_numbuf+0x38>
    return numbuf_end;
  100609:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10060d:	c9                   	leave  
  10060e:	c3                   	ret    

000000000010060f <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  10060f:	55                   	push   %rbp
  100610:	48 89 e5             	mov    %rsp,%rbp
  100613:	53                   	push   %rbx
  100614:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  10061b:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100622:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100628:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10062f:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100636:	e9 8a 09 00 00       	jmp    100fc5 <printer_vprintf+0x9b6>
        if (*format != '%') {
  10063b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100642:	0f b6 00             	movzbl (%rax),%eax
  100645:	3c 25                	cmp    $0x25,%al
  100647:	74 31                	je     10067a <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  100649:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100650:	4c 8b 00             	mov    (%rax),%r8
  100653:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10065a:	0f b6 00             	movzbl (%rax),%eax
  10065d:	0f b6 c8             	movzbl %al,%ecx
  100660:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100666:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10066d:	89 ce                	mov    %ecx,%esi
  10066f:	48 89 c7             	mov    %rax,%rdi
  100672:	41 ff d0             	call   *%r8
            continue;
  100675:	e9 43 09 00 00       	jmp    100fbd <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  10067a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100681:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100688:	01 
  100689:	eb 44                	jmp    1006cf <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  10068b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100692:	0f b6 00             	movzbl (%rax),%eax
  100695:	0f be c0             	movsbl %al,%eax
  100698:	89 c6                	mov    %eax,%esi
  10069a:	bf e0 12 10 00       	mov    $0x1012e0,%edi
  10069f:	e8 42 fe ff ff       	call   1004e6 <strchr>
  1006a4:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  1006a8:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  1006ad:	74 30                	je     1006df <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  1006af:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  1006b3:	48 2d e0 12 10 00    	sub    $0x1012e0,%rax
  1006b9:	ba 01 00 00 00       	mov    $0x1,%edx
  1006be:	89 c1                	mov    %eax,%ecx
  1006c0:	d3 e2                	shl    %cl,%edx
  1006c2:	89 d0                	mov    %edx,%eax
  1006c4:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  1006c7:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1006ce:	01 
  1006cf:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006d6:	0f b6 00             	movzbl (%rax),%eax
  1006d9:	84 c0                	test   %al,%al
  1006db:	75 ae                	jne    10068b <printer_vprintf+0x7c>
  1006dd:	eb 01                	jmp    1006e0 <printer_vprintf+0xd1>
            } else {
                break;
  1006df:	90                   	nop
            }
        }

        // process width
        int width = -1;
  1006e0:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  1006e7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006ee:	0f b6 00             	movzbl (%rax),%eax
  1006f1:	3c 30                	cmp    $0x30,%al
  1006f3:	7e 67                	jle    10075c <printer_vprintf+0x14d>
  1006f5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006fc:	0f b6 00             	movzbl (%rax),%eax
  1006ff:	3c 39                	cmp    $0x39,%al
  100701:	7f 59                	jg     10075c <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100703:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  10070a:	eb 2e                	jmp    10073a <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  10070c:	8b 55 e8             	mov    -0x18(%rbp),%edx
  10070f:	89 d0                	mov    %edx,%eax
  100711:	c1 e0 02             	shl    $0x2,%eax
  100714:	01 d0                	add    %edx,%eax
  100716:	01 c0                	add    %eax,%eax
  100718:	89 c1                	mov    %eax,%ecx
  10071a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100721:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100725:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10072c:	0f b6 00             	movzbl (%rax),%eax
  10072f:	0f be c0             	movsbl %al,%eax
  100732:	01 c8                	add    %ecx,%eax
  100734:	83 e8 30             	sub    $0x30,%eax
  100737:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10073a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100741:	0f b6 00             	movzbl (%rax),%eax
  100744:	3c 2f                	cmp    $0x2f,%al
  100746:	0f 8e 85 00 00 00    	jle    1007d1 <printer_vprintf+0x1c2>
  10074c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100753:	0f b6 00             	movzbl (%rax),%eax
  100756:	3c 39                	cmp    $0x39,%al
  100758:	7e b2                	jle    10070c <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  10075a:	eb 75                	jmp    1007d1 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  10075c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100763:	0f b6 00             	movzbl (%rax),%eax
  100766:	3c 2a                	cmp    $0x2a,%al
  100768:	75 68                	jne    1007d2 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  10076a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100771:	8b 00                	mov    (%rax),%eax
  100773:	83 f8 2f             	cmp    $0x2f,%eax
  100776:	77 30                	ja     1007a8 <printer_vprintf+0x199>
  100778:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10077f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100783:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10078a:	8b 00                	mov    (%rax),%eax
  10078c:	89 c0                	mov    %eax,%eax
  10078e:	48 01 d0             	add    %rdx,%rax
  100791:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100798:	8b 12                	mov    (%rdx),%edx
  10079a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10079d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007a4:	89 0a                	mov    %ecx,(%rdx)
  1007a6:	eb 1a                	jmp    1007c2 <printer_vprintf+0x1b3>
  1007a8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007af:	48 8b 40 08          	mov    0x8(%rax),%rax
  1007b3:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1007b7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007be:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1007c2:	8b 00                	mov    (%rax),%eax
  1007c4:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  1007c7:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1007ce:	01 
  1007cf:	eb 01                	jmp    1007d2 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  1007d1:	90                   	nop
        }

        // process precision
        int precision = -1;
  1007d2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  1007d9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007e0:	0f b6 00             	movzbl (%rax),%eax
  1007e3:	3c 2e                	cmp    $0x2e,%al
  1007e5:	0f 85 00 01 00 00    	jne    1008eb <printer_vprintf+0x2dc>
            ++format;
  1007eb:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1007f2:	01 
            if (*format >= '0' && *format <= '9') {
  1007f3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007fa:	0f b6 00             	movzbl (%rax),%eax
  1007fd:	3c 2f                	cmp    $0x2f,%al
  1007ff:	7e 67                	jle    100868 <printer_vprintf+0x259>
  100801:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100808:	0f b6 00             	movzbl (%rax),%eax
  10080b:	3c 39                	cmp    $0x39,%al
  10080d:	7f 59                	jg     100868 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10080f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100816:	eb 2e                	jmp    100846 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100818:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  10081b:	89 d0                	mov    %edx,%eax
  10081d:	c1 e0 02             	shl    $0x2,%eax
  100820:	01 d0                	add    %edx,%eax
  100822:	01 c0                	add    %eax,%eax
  100824:	89 c1                	mov    %eax,%ecx
  100826:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10082d:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100831:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100838:	0f b6 00             	movzbl (%rax),%eax
  10083b:	0f be c0             	movsbl %al,%eax
  10083e:	01 c8                	add    %ecx,%eax
  100840:	83 e8 30             	sub    $0x30,%eax
  100843:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100846:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10084d:	0f b6 00             	movzbl (%rax),%eax
  100850:	3c 2f                	cmp    $0x2f,%al
  100852:	0f 8e 85 00 00 00    	jle    1008dd <printer_vprintf+0x2ce>
  100858:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10085f:	0f b6 00             	movzbl (%rax),%eax
  100862:	3c 39                	cmp    $0x39,%al
  100864:	7e b2                	jle    100818 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100866:	eb 75                	jmp    1008dd <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100868:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10086f:	0f b6 00             	movzbl (%rax),%eax
  100872:	3c 2a                	cmp    $0x2a,%al
  100874:	75 68                	jne    1008de <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100876:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10087d:	8b 00                	mov    (%rax),%eax
  10087f:	83 f8 2f             	cmp    $0x2f,%eax
  100882:	77 30                	ja     1008b4 <printer_vprintf+0x2a5>
  100884:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10088b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10088f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100896:	8b 00                	mov    (%rax),%eax
  100898:	89 c0                	mov    %eax,%eax
  10089a:	48 01 d0             	add    %rdx,%rax
  10089d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008a4:	8b 12                	mov    (%rdx),%edx
  1008a6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1008a9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008b0:	89 0a                	mov    %ecx,(%rdx)
  1008b2:	eb 1a                	jmp    1008ce <printer_vprintf+0x2bf>
  1008b4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008bb:	48 8b 40 08          	mov    0x8(%rax),%rax
  1008bf:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1008c3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008ca:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1008ce:	8b 00                	mov    (%rax),%eax
  1008d0:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  1008d3:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1008da:	01 
  1008db:	eb 01                	jmp    1008de <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  1008dd:	90                   	nop
            }
            if (precision < 0) {
  1008de:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1008e2:	79 07                	jns    1008eb <printer_vprintf+0x2dc>
                precision = 0;
  1008e4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  1008eb:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  1008f2:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  1008f9:	00 
        int length = 0;
  1008fa:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100901:	48 c7 45 c8 e6 12 10 	movq   $0x1012e6,-0x38(%rbp)
  100908:	00 
    again:
        switch (*format) {
  100909:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100910:	0f b6 00             	movzbl (%rax),%eax
  100913:	0f be c0             	movsbl %al,%eax
  100916:	83 e8 43             	sub    $0x43,%eax
  100919:	83 f8 37             	cmp    $0x37,%eax
  10091c:	0f 87 9f 03 00 00    	ja     100cc1 <printer_vprintf+0x6b2>
  100922:	89 c0                	mov    %eax,%eax
  100924:	48 8b 04 c5 f8 12 10 	mov    0x1012f8(,%rax,8),%rax
  10092b:	00 
  10092c:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  10092e:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100935:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10093c:	01 
            goto again;
  10093d:	eb ca                	jmp    100909 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  10093f:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100943:	74 5d                	je     1009a2 <printer_vprintf+0x393>
  100945:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10094c:	8b 00                	mov    (%rax),%eax
  10094e:	83 f8 2f             	cmp    $0x2f,%eax
  100951:	77 30                	ja     100983 <printer_vprintf+0x374>
  100953:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10095a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10095e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100965:	8b 00                	mov    (%rax),%eax
  100967:	89 c0                	mov    %eax,%eax
  100969:	48 01 d0             	add    %rdx,%rax
  10096c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100973:	8b 12                	mov    (%rdx),%edx
  100975:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100978:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10097f:	89 0a                	mov    %ecx,(%rdx)
  100981:	eb 1a                	jmp    10099d <printer_vprintf+0x38e>
  100983:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10098a:	48 8b 40 08          	mov    0x8(%rax),%rax
  10098e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100992:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100999:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10099d:	48 8b 00             	mov    (%rax),%rax
  1009a0:	eb 5c                	jmp    1009fe <printer_vprintf+0x3ef>
  1009a2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009a9:	8b 00                	mov    (%rax),%eax
  1009ab:	83 f8 2f             	cmp    $0x2f,%eax
  1009ae:	77 30                	ja     1009e0 <printer_vprintf+0x3d1>
  1009b0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009b7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1009bb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009c2:	8b 00                	mov    (%rax),%eax
  1009c4:	89 c0                	mov    %eax,%eax
  1009c6:	48 01 d0             	add    %rdx,%rax
  1009c9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009d0:	8b 12                	mov    (%rdx),%edx
  1009d2:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1009d5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009dc:	89 0a                	mov    %ecx,(%rdx)
  1009de:	eb 1a                	jmp    1009fa <printer_vprintf+0x3eb>
  1009e0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009e7:	48 8b 40 08          	mov    0x8(%rax),%rax
  1009eb:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1009ef:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009f6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1009fa:	8b 00                	mov    (%rax),%eax
  1009fc:	48 98                	cltq   
  1009fe:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100a02:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a06:	48 c1 f8 38          	sar    $0x38,%rax
  100a0a:	25 80 00 00 00       	and    $0x80,%eax
  100a0f:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100a12:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100a16:	74 09                	je     100a21 <printer_vprintf+0x412>
  100a18:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a1c:	48 f7 d8             	neg    %rax
  100a1f:	eb 04                	jmp    100a25 <printer_vprintf+0x416>
  100a21:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a25:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100a29:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100a2c:	83 c8 60             	or     $0x60,%eax
  100a2f:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100a32:	e9 cf 02 00 00       	jmp    100d06 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100a37:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100a3b:	74 5d                	je     100a9a <printer_vprintf+0x48b>
  100a3d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a44:	8b 00                	mov    (%rax),%eax
  100a46:	83 f8 2f             	cmp    $0x2f,%eax
  100a49:	77 30                	ja     100a7b <printer_vprintf+0x46c>
  100a4b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a52:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a56:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a5d:	8b 00                	mov    (%rax),%eax
  100a5f:	89 c0                	mov    %eax,%eax
  100a61:	48 01 d0             	add    %rdx,%rax
  100a64:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a6b:	8b 12                	mov    (%rdx),%edx
  100a6d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a70:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a77:	89 0a                	mov    %ecx,(%rdx)
  100a79:	eb 1a                	jmp    100a95 <printer_vprintf+0x486>
  100a7b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a82:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a86:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a8a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a91:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a95:	48 8b 00             	mov    (%rax),%rax
  100a98:	eb 5c                	jmp    100af6 <printer_vprintf+0x4e7>
  100a9a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100aa1:	8b 00                	mov    (%rax),%eax
  100aa3:	83 f8 2f             	cmp    $0x2f,%eax
  100aa6:	77 30                	ja     100ad8 <printer_vprintf+0x4c9>
  100aa8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100aaf:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ab3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100aba:	8b 00                	mov    (%rax),%eax
  100abc:	89 c0                	mov    %eax,%eax
  100abe:	48 01 d0             	add    %rdx,%rax
  100ac1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ac8:	8b 12                	mov    (%rdx),%edx
  100aca:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100acd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ad4:	89 0a                	mov    %ecx,(%rdx)
  100ad6:	eb 1a                	jmp    100af2 <printer_vprintf+0x4e3>
  100ad8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100adf:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ae3:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ae7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aee:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100af2:	8b 00                	mov    (%rax),%eax
  100af4:	89 c0                	mov    %eax,%eax
  100af6:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100afa:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100afe:	e9 03 02 00 00       	jmp    100d06 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100b03:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100b0a:	e9 28 ff ff ff       	jmp    100a37 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100b0f:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100b16:	e9 1c ff ff ff       	jmp    100a37 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100b1b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b22:	8b 00                	mov    (%rax),%eax
  100b24:	83 f8 2f             	cmp    $0x2f,%eax
  100b27:	77 30                	ja     100b59 <printer_vprintf+0x54a>
  100b29:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b30:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b34:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b3b:	8b 00                	mov    (%rax),%eax
  100b3d:	89 c0                	mov    %eax,%eax
  100b3f:	48 01 d0             	add    %rdx,%rax
  100b42:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b49:	8b 12                	mov    (%rdx),%edx
  100b4b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b4e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b55:	89 0a                	mov    %ecx,(%rdx)
  100b57:	eb 1a                	jmp    100b73 <printer_vprintf+0x564>
  100b59:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b60:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b64:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b68:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b6f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b73:	48 8b 00             	mov    (%rax),%rax
  100b76:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100b7a:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100b81:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100b88:	e9 79 01 00 00       	jmp    100d06 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100b8d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b94:	8b 00                	mov    (%rax),%eax
  100b96:	83 f8 2f             	cmp    $0x2f,%eax
  100b99:	77 30                	ja     100bcb <printer_vprintf+0x5bc>
  100b9b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ba2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ba6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bad:	8b 00                	mov    (%rax),%eax
  100baf:	89 c0                	mov    %eax,%eax
  100bb1:	48 01 d0             	add    %rdx,%rax
  100bb4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bbb:	8b 12                	mov    (%rdx),%edx
  100bbd:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bc0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bc7:	89 0a                	mov    %ecx,(%rdx)
  100bc9:	eb 1a                	jmp    100be5 <printer_vprintf+0x5d6>
  100bcb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bd2:	48 8b 40 08          	mov    0x8(%rax),%rax
  100bd6:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100bda:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100be1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100be5:	48 8b 00             	mov    (%rax),%rax
  100be8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100bec:	e9 15 01 00 00       	jmp    100d06 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100bf1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bf8:	8b 00                	mov    (%rax),%eax
  100bfa:	83 f8 2f             	cmp    $0x2f,%eax
  100bfd:	77 30                	ja     100c2f <printer_vprintf+0x620>
  100bff:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c06:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c0a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c11:	8b 00                	mov    (%rax),%eax
  100c13:	89 c0                	mov    %eax,%eax
  100c15:	48 01 d0             	add    %rdx,%rax
  100c18:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c1f:	8b 12                	mov    (%rdx),%edx
  100c21:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c24:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c2b:	89 0a                	mov    %ecx,(%rdx)
  100c2d:	eb 1a                	jmp    100c49 <printer_vprintf+0x63a>
  100c2f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c36:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c3a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c3e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c45:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c49:	8b 00                	mov    (%rax),%eax
  100c4b:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100c51:	e9 67 03 00 00       	jmp    100fbd <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  100c56:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100c5a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100c5e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c65:	8b 00                	mov    (%rax),%eax
  100c67:	83 f8 2f             	cmp    $0x2f,%eax
  100c6a:	77 30                	ja     100c9c <printer_vprintf+0x68d>
  100c6c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c73:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c77:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c7e:	8b 00                	mov    (%rax),%eax
  100c80:	89 c0                	mov    %eax,%eax
  100c82:	48 01 d0             	add    %rdx,%rax
  100c85:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c8c:	8b 12                	mov    (%rdx),%edx
  100c8e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c91:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c98:	89 0a                	mov    %ecx,(%rdx)
  100c9a:	eb 1a                	jmp    100cb6 <printer_vprintf+0x6a7>
  100c9c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ca3:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ca7:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100cab:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cb2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100cb6:	8b 00                	mov    (%rax),%eax
  100cb8:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100cbb:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100cbf:	eb 45                	jmp    100d06 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  100cc1:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100cc5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100cc9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100cd0:	0f b6 00             	movzbl (%rax),%eax
  100cd3:	84 c0                	test   %al,%al
  100cd5:	74 0c                	je     100ce3 <printer_vprintf+0x6d4>
  100cd7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100cde:	0f b6 00             	movzbl (%rax),%eax
  100ce1:	eb 05                	jmp    100ce8 <printer_vprintf+0x6d9>
  100ce3:	b8 25 00 00 00       	mov    $0x25,%eax
  100ce8:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100ceb:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100cef:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100cf6:	0f b6 00             	movzbl (%rax),%eax
  100cf9:	84 c0                	test   %al,%al
  100cfb:	75 08                	jne    100d05 <printer_vprintf+0x6f6>
                format--;
  100cfd:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100d04:	01 
            }
            break;
  100d05:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100d06:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d09:	83 e0 20             	and    $0x20,%eax
  100d0c:	85 c0                	test   %eax,%eax
  100d0e:	74 1e                	je     100d2e <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100d10:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d14:	48 83 c0 18          	add    $0x18,%rax
  100d18:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100d1b:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100d1f:	48 89 ce             	mov    %rcx,%rsi
  100d22:	48 89 c7             	mov    %rax,%rdi
  100d25:	e8 63 f8 ff ff       	call   10058d <fill_numbuf>
  100d2a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100d2e:	48 c7 45 c0 e6 12 10 	movq   $0x1012e6,-0x40(%rbp)
  100d35:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100d36:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d39:	83 e0 20             	and    $0x20,%eax
  100d3c:	85 c0                	test   %eax,%eax
  100d3e:	74 48                	je     100d88 <printer_vprintf+0x779>
  100d40:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d43:	83 e0 40             	and    $0x40,%eax
  100d46:	85 c0                	test   %eax,%eax
  100d48:	74 3e                	je     100d88 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  100d4a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d4d:	25 80 00 00 00       	and    $0x80,%eax
  100d52:	85 c0                	test   %eax,%eax
  100d54:	74 0a                	je     100d60 <printer_vprintf+0x751>
                prefix = "-";
  100d56:	48 c7 45 c0 e7 12 10 	movq   $0x1012e7,-0x40(%rbp)
  100d5d:	00 
            if (flags & FLAG_NEGATIVE) {
  100d5e:	eb 73                	jmp    100dd3 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100d60:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d63:	83 e0 10             	and    $0x10,%eax
  100d66:	85 c0                	test   %eax,%eax
  100d68:	74 0a                	je     100d74 <printer_vprintf+0x765>
                prefix = "+";
  100d6a:	48 c7 45 c0 e9 12 10 	movq   $0x1012e9,-0x40(%rbp)
  100d71:	00 
            if (flags & FLAG_NEGATIVE) {
  100d72:	eb 5f                	jmp    100dd3 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100d74:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d77:	83 e0 08             	and    $0x8,%eax
  100d7a:	85 c0                	test   %eax,%eax
  100d7c:	74 55                	je     100dd3 <printer_vprintf+0x7c4>
                prefix = " ";
  100d7e:	48 c7 45 c0 eb 12 10 	movq   $0x1012eb,-0x40(%rbp)
  100d85:	00 
            if (flags & FLAG_NEGATIVE) {
  100d86:	eb 4b                	jmp    100dd3 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100d88:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d8b:	83 e0 20             	and    $0x20,%eax
  100d8e:	85 c0                	test   %eax,%eax
  100d90:	74 42                	je     100dd4 <printer_vprintf+0x7c5>
  100d92:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d95:	83 e0 01             	and    $0x1,%eax
  100d98:	85 c0                	test   %eax,%eax
  100d9a:	74 38                	je     100dd4 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  100d9c:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100da0:	74 06                	je     100da8 <printer_vprintf+0x799>
  100da2:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100da6:	75 2c                	jne    100dd4 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  100da8:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100dad:	75 0c                	jne    100dbb <printer_vprintf+0x7ac>
  100daf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100db2:	25 00 01 00 00       	and    $0x100,%eax
  100db7:	85 c0                	test   %eax,%eax
  100db9:	74 19                	je     100dd4 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  100dbb:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100dbf:	75 07                	jne    100dc8 <printer_vprintf+0x7b9>
  100dc1:	b8 ed 12 10 00       	mov    $0x1012ed,%eax
  100dc6:	eb 05                	jmp    100dcd <printer_vprintf+0x7be>
  100dc8:	b8 f0 12 10 00       	mov    $0x1012f0,%eax
  100dcd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100dd1:	eb 01                	jmp    100dd4 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  100dd3:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100dd4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100dd8:	78 24                	js     100dfe <printer_vprintf+0x7ef>
  100dda:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ddd:	83 e0 20             	and    $0x20,%eax
  100de0:	85 c0                	test   %eax,%eax
  100de2:	75 1a                	jne    100dfe <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  100de4:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100de7:	48 63 d0             	movslq %eax,%rdx
  100dea:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100dee:	48 89 d6             	mov    %rdx,%rsi
  100df1:	48 89 c7             	mov    %rax,%rdi
  100df4:	e8 ea f5 ff ff       	call   1003e3 <strnlen>
  100df9:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100dfc:	eb 0f                	jmp    100e0d <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  100dfe:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100e02:	48 89 c7             	mov    %rax,%rdi
  100e05:	e8 a8 f5 ff ff       	call   1003b2 <strlen>
  100e0a:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100e0d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e10:	83 e0 20             	and    $0x20,%eax
  100e13:	85 c0                	test   %eax,%eax
  100e15:	74 20                	je     100e37 <printer_vprintf+0x828>
  100e17:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100e1b:	78 1a                	js     100e37 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  100e1d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100e20:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100e23:	7e 08                	jle    100e2d <printer_vprintf+0x81e>
  100e25:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100e28:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100e2b:	eb 05                	jmp    100e32 <printer_vprintf+0x823>
  100e2d:	b8 00 00 00 00       	mov    $0x0,%eax
  100e32:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100e35:	eb 5c                	jmp    100e93 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100e37:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e3a:	83 e0 20             	and    $0x20,%eax
  100e3d:	85 c0                	test   %eax,%eax
  100e3f:	74 4b                	je     100e8c <printer_vprintf+0x87d>
  100e41:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e44:	83 e0 02             	and    $0x2,%eax
  100e47:	85 c0                	test   %eax,%eax
  100e49:	74 41                	je     100e8c <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100e4b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e4e:	83 e0 04             	and    $0x4,%eax
  100e51:	85 c0                	test   %eax,%eax
  100e53:	75 37                	jne    100e8c <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  100e55:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e59:	48 89 c7             	mov    %rax,%rdi
  100e5c:	e8 51 f5 ff ff       	call   1003b2 <strlen>
  100e61:	89 c2                	mov    %eax,%edx
  100e63:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100e66:	01 d0                	add    %edx,%eax
  100e68:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100e6b:	7e 1f                	jle    100e8c <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  100e6d:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100e70:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100e73:	89 c3                	mov    %eax,%ebx
  100e75:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e79:	48 89 c7             	mov    %rax,%rdi
  100e7c:	e8 31 f5 ff ff       	call   1003b2 <strlen>
  100e81:	89 c2                	mov    %eax,%edx
  100e83:	89 d8                	mov    %ebx,%eax
  100e85:	29 d0                	sub    %edx,%eax
  100e87:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100e8a:	eb 07                	jmp    100e93 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  100e8c:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100e93:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100e96:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100e99:	01 d0                	add    %edx,%eax
  100e9b:	48 63 d8             	movslq %eax,%rbx
  100e9e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100ea2:	48 89 c7             	mov    %rax,%rdi
  100ea5:	e8 08 f5 ff ff       	call   1003b2 <strlen>
  100eaa:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100eae:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100eb1:	29 d0                	sub    %edx,%eax
  100eb3:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100eb6:	eb 25                	jmp    100edd <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  100eb8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ebf:	48 8b 08             	mov    (%rax),%rcx
  100ec2:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100ec8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ecf:	be 20 00 00 00       	mov    $0x20,%esi
  100ed4:	48 89 c7             	mov    %rax,%rdi
  100ed7:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100ed9:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100edd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ee0:	83 e0 04             	and    $0x4,%eax
  100ee3:	85 c0                	test   %eax,%eax
  100ee5:	75 36                	jne    100f1d <printer_vprintf+0x90e>
  100ee7:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100eeb:	7f cb                	jg     100eb8 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  100eed:	eb 2e                	jmp    100f1d <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  100eef:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ef6:	4c 8b 00             	mov    (%rax),%r8
  100ef9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100efd:	0f b6 00             	movzbl (%rax),%eax
  100f00:	0f b6 c8             	movzbl %al,%ecx
  100f03:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f09:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f10:	89 ce                	mov    %ecx,%esi
  100f12:	48 89 c7             	mov    %rax,%rdi
  100f15:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  100f18:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  100f1d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f21:	0f b6 00             	movzbl (%rax),%eax
  100f24:	84 c0                	test   %al,%al
  100f26:	75 c7                	jne    100eef <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  100f28:	eb 25                	jmp    100f4f <printer_vprintf+0x940>
            p->putc(p, '0', color);
  100f2a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f31:	48 8b 08             	mov    (%rax),%rcx
  100f34:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f3a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f41:	be 30 00 00 00       	mov    $0x30,%esi
  100f46:	48 89 c7             	mov    %rax,%rdi
  100f49:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  100f4b:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  100f4f:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  100f53:	7f d5                	jg     100f2a <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  100f55:	eb 32                	jmp    100f89 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  100f57:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f5e:	4c 8b 00             	mov    (%rax),%r8
  100f61:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100f65:	0f b6 00             	movzbl (%rax),%eax
  100f68:	0f b6 c8             	movzbl %al,%ecx
  100f6b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f71:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f78:	89 ce                	mov    %ecx,%esi
  100f7a:	48 89 c7             	mov    %rax,%rdi
  100f7d:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  100f80:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  100f85:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  100f89:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  100f8d:	7f c8                	jg     100f57 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  100f8f:	eb 25                	jmp    100fb6 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  100f91:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f98:	48 8b 08             	mov    (%rax),%rcx
  100f9b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100fa1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fa8:	be 20 00 00 00       	mov    $0x20,%esi
  100fad:	48 89 c7             	mov    %rax,%rdi
  100fb0:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  100fb2:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100fb6:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100fba:	7f d5                	jg     100f91 <printer_vprintf+0x982>
        }
    done: ;
  100fbc:	90                   	nop
    for (; *format; ++format) {
  100fbd:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100fc4:	01 
  100fc5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100fcc:	0f b6 00             	movzbl (%rax),%eax
  100fcf:	84 c0                	test   %al,%al
  100fd1:	0f 85 64 f6 ff ff    	jne    10063b <printer_vprintf+0x2c>
    }
}
  100fd7:	90                   	nop
  100fd8:	90                   	nop
  100fd9:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100fdd:	c9                   	leave  
  100fde:	c3                   	ret    

0000000000100fdf <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100fdf:	55                   	push   %rbp
  100fe0:	48 89 e5             	mov    %rsp,%rbp
  100fe3:	48 83 ec 20          	sub    $0x20,%rsp
  100fe7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100feb:	89 f0                	mov    %esi,%eax
  100fed:	89 55 e0             	mov    %edx,-0x20(%rbp)
  100ff0:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  100ff3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100ff7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100ffb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100fff:	48 8b 40 08          	mov    0x8(%rax),%rax
  101003:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  101008:	48 39 d0             	cmp    %rdx,%rax
  10100b:	72 0c                	jb     101019 <console_putc+0x3a>
        cp->cursor = console;
  10100d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101011:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  101018:	00 
    }
    if (c == '\n') {
  101019:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  10101d:	75 78                	jne    101097 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  10101f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101023:	48 8b 40 08          	mov    0x8(%rax),%rax
  101027:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  10102d:	48 d1 f8             	sar    %rax
  101030:	48 89 c1             	mov    %rax,%rcx
  101033:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  10103a:	66 66 66 
  10103d:	48 89 c8             	mov    %rcx,%rax
  101040:	48 f7 ea             	imul   %rdx
  101043:	48 c1 fa 05          	sar    $0x5,%rdx
  101047:	48 89 c8             	mov    %rcx,%rax
  10104a:	48 c1 f8 3f          	sar    $0x3f,%rax
  10104e:	48 29 c2             	sub    %rax,%rdx
  101051:	48 89 d0             	mov    %rdx,%rax
  101054:	48 c1 e0 02          	shl    $0x2,%rax
  101058:	48 01 d0             	add    %rdx,%rax
  10105b:	48 c1 e0 04          	shl    $0x4,%rax
  10105f:	48 29 c1             	sub    %rax,%rcx
  101062:	48 89 ca             	mov    %rcx,%rdx
  101065:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101068:	eb 25                	jmp    10108f <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  10106a:	8b 45 e0             	mov    -0x20(%rbp),%eax
  10106d:	83 c8 20             	or     $0x20,%eax
  101070:	89 c6                	mov    %eax,%esi
  101072:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101076:	48 8b 40 08          	mov    0x8(%rax),%rax
  10107a:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10107e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101082:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101086:	89 f2                	mov    %esi,%edx
  101088:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  10108b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10108f:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101093:	75 d5                	jne    10106a <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101095:	eb 24                	jmp    1010bb <console_putc+0xdc>
        *cp->cursor++ = c | color;
  101097:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  10109b:	8b 55 e0             	mov    -0x20(%rbp),%edx
  10109e:	09 d0                	or     %edx,%eax
  1010a0:	89 c6                	mov    %eax,%esi
  1010a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010a6:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010aa:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1010ae:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1010b2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1010b6:	89 f2                	mov    %esi,%edx
  1010b8:	66 89 10             	mov    %dx,(%rax)
}
  1010bb:	90                   	nop
  1010bc:	c9                   	leave  
  1010bd:	c3                   	ret    

00000000001010be <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1010be:	55                   	push   %rbp
  1010bf:	48 89 e5             	mov    %rsp,%rbp
  1010c2:	48 83 ec 30          	sub    $0x30,%rsp
  1010c6:	89 7d ec             	mov    %edi,-0x14(%rbp)
  1010c9:	89 75 e8             	mov    %esi,-0x18(%rbp)
  1010cc:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1010d0:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  1010d4:	48 c7 45 f0 df 0f 10 	movq   $0x100fdf,-0x10(%rbp)
  1010db:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1010dc:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  1010e0:	78 09                	js     1010eb <console_vprintf+0x2d>
  1010e2:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  1010e9:	7e 07                	jle    1010f2 <console_vprintf+0x34>
        cpos = 0;
  1010eb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  1010f2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010f5:	48 98                	cltq   
  1010f7:	48 01 c0             	add    %rax,%rax
  1010fa:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  101100:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101104:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101108:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  10110c:	8b 75 e8             	mov    -0x18(%rbp),%esi
  10110f:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101113:	48 89 c7             	mov    %rax,%rdi
  101116:	e8 f4 f4 ff ff       	call   10060f <printer_vprintf>
    return cp.cursor - console;
  10111b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10111f:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  101125:	48 d1 f8             	sar    %rax
}
  101128:	c9                   	leave  
  101129:	c3                   	ret    

000000000010112a <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  10112a:	55                   	push   %rbp
  10112b:	48 89 e5             	mov    %rsp,%rbp
  10112e:	48 83 ec 60          	sub    $0x60,%rsp
  101132:	89 7d ac             	mov    %edi,-0x54(%rbp)
  101135:	89 75 a8             	mov    %esi,-0x58(%rbp)
  101138:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  10113c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101140:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101144:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101148:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  10114f:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101153:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101157:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10115b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  10115f:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101163:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101167:	8b 75 a8             	mov    -0x58(%rbp),%esi
  10116a:	8b 45 ac             	mov    -0x54(%rbp),%eax
  10116d:	89 c7                	mov    %eax,%edi
  10116f:	e8 4a ff ff ff       	call   1010be <console_vprintf>
  101174:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101177:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  10117a:	c9                   	leave  
  10117b:	c3                   	ret    

000000000010117c <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  10117c:	55                   	push   %rbp
  10117d:	48 89 e5             	mov    %rsp,%rbp
  101180:	48 83 ec 20          	sub    $0x20,%rsp
  101184:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101188:	89 f0                	mov    %esi,%eax
  10118a:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10118d:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101190:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101194:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101198:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10119c:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1011a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1011a4:	48 8b 40 10          	mov    0x10(%rax),%rax
  1011a8:	48 39 c2             	cmp    %rax,%rdx
  1011ab:	73 1a                	jae    1011c7 <string_putc+0x4b>
        *sp->s++ = c;
  1011ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1011b1:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011b5:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1011b9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1011bd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1011c1:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1011c5:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1011c7:	90                   	nop
  1011c8:	c9                   	leave  
  1011c9:	c3                   	ret    

00000000001011ca <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1011ca:	55                   	push   %rbp
  1011cb:	48 89 e5             	mov    %rsp,%rbp
  1011ce:	48 83 ec 40          	sub    $0x40,%rsp
  1011d2:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  1011d6:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  1011da:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  1011de:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1011e2:	48 c7 45 e8 7c 11 10 	movq   $0x10117c,-0x18(%rbp)
  1011e9:	00 
    sp.s = s;
  1011ea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1011ee:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1011f2:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1011f7:	74 33                	je     10122c <vsnprintf+0x62>
        sp.end = s + size - 1;
  1011f9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1011fd:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101201:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101205:	48 01 d0             	add    %rdx,%rax
  101208:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  10120c:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101210:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101214:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101218:	be 00 00 00 00       	mov    $0x0,%esi
  10121d:	48 89 c7             	mov    %rax,%rdi
  101220:	e8 ea f3 ff ff       	call   10060f <printer_vprintf>
        *sp.s = 0;
  101225:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101229:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  10122c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101230:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  101234:	c9                   	leave  
  101235:	c3                   	ret    

0000000000101236 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  101236:	55                   	push   %rbp
  101237:	48 89 e5             	mov    %rsp,%rbp
  10123a:	48 83 ec 70          	sub    $0x70,%rsp
  10123e:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101242:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  101246:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  10124a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10124e:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101252:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101256:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  10125d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101261:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101265:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101269:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  10126d:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101271:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101275:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101279:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10127d:	48 89 c7             	mov    %rax,%rdi
  101280:	e8 45 ff ff ff       	call   1011ca <vsnprintf>
  101285:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101288:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  10128b:	c9                   	leave  
  10128c:	c3                   	ret    

000000000010128d <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  10128d:	55                   	push   %rbp
  10128e:	48 89 e5             	mov    %rsp,%rbp
  101291:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101295:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  10129c:	eb 13                	jmp    1012b1 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  10129e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1012a1:	48 98                	cltq   
  1012a3:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  1012aa:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1012ad:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1012b1:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1012b8:	7e e4                	jle    10129e <console_clear+0x11>
    }
    cursorpos = 0;
  1012ba:	c7 05 38 7d fb ff 00 	movl   $0x0,-0x482c8(%rip)        # b8ffc <cursorpos>
  1012c1:	00 00 00 
}
  1012c4:	90                   	nop
  1012c5:	c9                   	leave  
  1012c6:	c3                   	ret    
