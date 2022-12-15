
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
  10000d:	b8 3f 30 10 00       	mov    $0x10303f,%eax
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
  100037:	e8 f2 09 00 00       	call   100a2e <rand>
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
  10005f:	e8 ea 01 00 00       	call   10024e <malloc>
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
  100078:	48 89 05 b1 1f 00 00 	mov    %rax,0x1fb1(%rip)        # 102030 <result.0>
  10007f:	bf 08 00 00 00       	mov    $0x8,%edi
  100084:	cd 3a                	int    $0x3a
  100086:	48 89 05 a3 1f 00 00 	mov    %rax,0x1fa3(%rip)        # 102030 <result.0>
// want to try and optimize this 
void heap_init(void) {

	// prologue block
	sbrk(sizeof(block_header) + sizeof(block_header));
	prologue_block = sbrk(sizeof(block_footer));
  10008d:	48 89 05 8c 1f 00 00 	mov    %rax,0x1f8c(%rip)        # 102020 <prologue_block>
	PUT(HDRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  100094:	48 c7 40 f8 11 00 00 	movq   $0x11,-0x8(%rax)
  10009b:	00 
	PUT(FTRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  10009c:	48 8b 15 7d 1f 00 00 	mov    0x1f7d(%rip),%rdx        # 102020 <prologue_block>
  1000a3:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  1000a7:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  1000ab:	48 c7 44 02 f0 11 00 	movq   $0x11,-0x10(%rdx,%rax,1)
  1000b2:	00 00 
  1000b4:	cd 3a                	int    $0x3a
  1000b6:	48 89 05 73 1f 00 00 	mov    %rax,0x1f73(%rip)        # 102030 <result.0>

	// terminal block
	sbrk(sizeof(block_header));
	PUT(HDRP(NEXT_BLKP(prologue_block)), PACK(0, 1));	
  1000bd:	48 8b 15 5c 1f 00 00 	mov    0x1f5c(%rip),%rdx        # 102020 <prologue_block>
  1000c4:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  1000c8:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  1000cc:	48 c7 44 02 f8 01 00 	movq   $0x1,-0x8(%rdx,%rax,1)
  1000d3:	00 00 

	free_list = NULL;
  1000d5:	48 c7 05 38 1f 00 00 	movq   $0x0,0x1f38(%rip)        # 102018 <free_list>
  1000dc:	00 00 00 00 

	initialized_heap = 1;
  1000e0:	c7 05 3e 1f 00 00 01 	movl   $0x1,0x1f3e(%rip)        # 102028 <initialized_heap>
  1000e7:	00 00 00 
}
  1000ea:	c3                   	ret    

00000000001000eb <free>:

void free(void *firstbyte) {
	if (firstbyte == NULL)
  1000eb:	48 85 ff             	test   %rdi,%rdi
  1000ee:	74 3d                	je     10012d <free+0x42>
		return;

	// setup free things: alloc, list ptrs, footer
	PUT(HDRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  1000f0:	48 8b 47 f8          	mov    -0x8(%rdi),%rax
  1000f4:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  1000f8:	48 89 47 f8          	mov    %rax,-0x8(%rdi)
	NEXT_FPTR(firstbyte) = free_list;
  1000fc:	48 8b 15 15 1f 00 00 	mov    0x1f15(%rip),%rdx        # 102018 <free_list>
  100103:	48 89 17             	mov    %rdx,(%rdi)
	PREV_FPTR(firstbyte) = NULL;
  100106:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  10010d:	00 
	PUT(FTRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  10010e:	48 89 44 07 f0       	mov    %rax,-0x10(%rdi,%rax,1)

	// add to free_list
	PREV_FPTR(free_list) = firstbyte;
  100113:	48 8b 05 fe 1e 00 00 	mov    0x1efe(%rip),%rax        # 102018 <free_list>
  10011a:	48 89 78 08          	mov    %rdi,0x8(%rax)
	free_list = firstbyte;
  10011e:	48 89 3d f3 1e 00 00 	mov    %rdi,0x1ef3(%rip)        # 102018 <free_list>

	num_allocs--;
  100125:	48 83 2d e3 1e 00 00 	subq   $0x1,0x1ee3(%rip)        # 102010 <num_allocs>
  10012c:	01 

	return;
}
  10012d:	c3                   	ret    

000000000010012e <extend>:
//
//	the reason allocating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
int extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  10012e:	48 81 c7 ff 3f 00 00 	add    $0x3fff,%rdi
  100135:	48 81 e7 00 c0 ff ff 	and    $0xffffffffffffc000,%rdi
  10013c:	cd 3a                	int    $0x3a
  10013e:	48 89 05 eb 1e 00 00 	mov    %rax,0x1eeb(%rip)        # 102030 <result.0>
	void *bp = sbrk(chunk_aligned_size);
	if (bp == (void *)-1)
  100145:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  100149:	74 49                	je     100194 <extend+0x66>
		return -1;

	// setup pointer
	PUT(HDRP(bp), PACK(chunk_aligned_size, 0));	
  10014b:	48 89 78 f8          	mov    %rdi,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  10014f:	48 8b 15 c2 1e 00 00 	mov    0x1ec2(%rip),%rdx        # 102018 <free_list>
  100156:	48 89 10             	mov    %rdx,(%rax)
	PREV_FPTR(bp) = NULL;
  100159:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  100160:	00 
	PUT(FTRP(bp), PACK(chunk_aligned_size, 0));	
  100161:	48 89 7c 07 f0       	mov    %rdi,-0x10(%rdi,%rax,1)
	
	// add to head of free_list
	if (free_list)
  100166:	48 8b 15 ab 1e 00 00 	mov    0x1eab(%rip),%rdx        # 102018 <free_list>
  10016d:	48 85 d2             	test   %rdx,%rdx
  100170:	74 04                	je     100176 <extend+0x48>
		PREV_FPTR(free_list) = bp;
  100172:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  100176:	48 89 05 9b 1e 00 00 	mov    %rax,0x1e9b(%rip)        # 102018 <free_list>

	// update terminal block
	PUT(HDRP(NEXT_BLKP(bp)), PACK(0, 1));	
  10017d:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  100181:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100185:	48 c7 44 10 f8 01 00 	movq   $0x1,-0x8(%rax,%rdx,1)
  10018c:	00 00 

	return 0;
  10018e:	b8 00 00 00 00       	mov    $0x0,%eax
  100193:	c3                   	ret    
		return -1;
  100194:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  100199:	c3                   	ret    

000000000010019a <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
  10019a:	48 89 f8             	mov    %rdi,%rax
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  10019d:	48 8b 57 f8          	mov    -0x8(%rdi),%rdx
  1001a1:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1001a5:	48 29 f2             	sub    %rsi,%rdx

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  1001a8:	48 83 fa 20          	cmp    $0x20,%rdx
  1001ac:	76 5b                	jbe    100209 <set_allocated+0x6f>
		PUT(HDRP(bp), PACK(size, 1));
  1001ae:	48 89 f1             	mov    %rsi,%rcx
  1001b1:	48 83 c9 01          	or     $0x1,%rcx
  1001b5:	48 89 4f f8          	mov    %rcx,-0x8(%rdi)

		void *leftover_mem_ptr = NEXT_BLKP(bp);
  1001b9:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  1001bd:	48 01 fe             	add    %rdi,%rsi

		PUT(HDRP(leftover_mem_ptr), PACK(extra_size, 0));	
  1001c0:	48 89 56 f8          	mov    %rdx,-0x8(%rsi)
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp); // pointers to the next free blocks
  1001c4:	48 8b 0f             	mov    (%rdi),%rcx
  1001c7:	48 89 0e             	mov    %rcx,(%rsi)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  1001ca:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  1001ce:	48 89 4e 08          	mov    %rcx,0x8(%rsi)
		PUT(FTRP(leftover_mem_ptr), PACK(extra_size, 0));	
  1001d2:	48 89 d1             	mov    %rdx,%rcx
  1001d5:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  1001d9:	48 89 54 0e f0       	mov    %rdx,-0x10(%rsi,%rcx,1)

		// update the free list
		if (free_list == bp)
  1001de:	48 39 3d 33 1e 00 00 	cmp    %rdi,0x1e33(%rip)        # 102018 <free_list>
  1001e5:	74 19                	je     100200 <set_allocated+0x66>
			free_list = leftover_mem_ptr;

		if (PREV_FPTR(bp))
  1001e7:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1001eb:	48 85 d2             	test   %rdx,%rdx
  1001ee:	74 03                	je     1001f3 <set_allocated+0x59>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  1001f0:	48 89 32             	mov    %rsi,(%rdx)

		if (NEXT_FPTR(bp))
  1001f3:	48 8b 00             	mov    (%rax),%rax
  1001f6:	48 85 c0             	test   %rax,%rax
  1001f9:	74 46                	je     100241 <set_allocated+0xa7>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  1001fb:	48 89 70 08          	mov    %rsi,0x8(%rax)
  1001ff:	c3                   	ret    
			free_list = leftover_mem_ptr;
  100200:	48 89 35 11 1e 00 00 	mov    %rsi,0x1e11(%rip)        # 102018 <free_list>
  100207:	eb de                	jmp    1001e7 <set_allocated+0x4d>
								    
	}
	else {
		// update the free list
		if (free_list == bp)
  100209:	48 39 3d 08 1e 00 00 	cmp    %rdi,0x1e08(%rip)        # 102018 <free_list>
  100210:	74 30                	je     100242 <set_allocated+0xa8>
			free_list = NEXT_FPTR(bp);

		if (PREV_FPTR(bp))
  100212:	48 8b 50 08          	mov    0x8(%rax),%rdx
  100216:	48 85 d2             	test   %rdx,%rdx
  100219:	74 06                	je     100221 <set_allocated+0x87>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  10021b:	48 8b 08             	mov    (%rax),%rcx
  10021e:	48 89 0a             	mov    %rcx,(%rdx)
		if (NEXT_FPTR(bp))
  100221:	48 8b 10             	mov    (%rax),%rdx
  100224:	48 85 d2             	test   %rdx,%rdx
  100227:	74 08                	je     100231 <set_allocated+0x97>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  100229:	48 8b 48 08          	mov    0x8(%rax),%rcx
  10022d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)

		PUT(HDRP(bp), PACK(GET_SIZE(HDRP(bp)), 1));	
  100231:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  100235:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100239:	48 83 ca 01          	or     $0x1,%rdx
  10023d:	48 89 50 f8          	mov    %rdx,-0x8(%rax)
	}
}
  100241:	c3                   	ret    
			free_list = NEXT_FPTR(bp);
  100242:	48 8b 17             	mov    (%rdi),%rdx
  100245:	48 89 15 cc 1d 00 00 	mov    %rdx,0x1dcc(%rip)        # 102018 <free_list>
  10024c:	eb c4                	jmp    100212 <set_allocated+0x78>

000000000010024e <malloc>:

void *malloc(uint64_t numbytes) {
  10024e:	55                   	push   %rbp
  10024f:	48 89 e5             	mov    %rsp,%rbp
  100252:	41 55                	push   %r13
  100254:	41 54                	push   %r12
  100256:	53                   	push   %rbx
  100257:	48 83 ec 08          	sub    $0x8,%rsp
  10025b:	49 89 fc             	mov    %rdi,%r12
	if (!initialized_heap)
  10025e:	83 3d c3 1d 00 00 00 	cmpl   $0x0,0x1dc3(%rip)        # 102028 <initialized_heap>
  100265:	74 73                	je     1002da <malloc+0x8c>
		heap_init();

	if (numbytes == 0)
  100267:	4d 85 e4             	test   %r12,%r12
  10026a:	0f 84 92 00 00 00    	je     100302 <malloc+0xb4>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  100270:	49 83 c4 17          	add    $0x17,%r12
  100274:	49 83 e4 f0          	and    $0xfffffffffffffff0,%r12
  100278:	b8 20 00 00 00       	mov    $0x20,%eax
  10027d:	49 39 c4             	cmp    %rax,%r12
  100280:	4c 0f 42 e0          	cmovb  %rax,%r12
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);
	
	void *bp = free_list;
  100284:	48 8b 1d 8d 1d 00 00 	mov    0x1d8d(%rip),%rbx        # 102018 <free_list>
	while (bp) {
  10028b:	48 85 db             	test   %rbx,%rbx
  10028e:	74 15                	je     1002a5 <malloc+0x57>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  100290:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  100294:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100298:	4c 39 e0             	cmp    %r12,%rax
  10029b:	73 44                	jae    1002e1 <malloc+0x93>
			set_allocated(bp, aligned_size);
			num_allocs++;
			return bp;
		}

		bp = NEXT_FPTR(bp);
  10029d:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  1002a0:	48 85 db             	test   %rbx,%rbx
  1002a3:	75 eb                	jne    100290 <malloc+0x42>
  1002a5:	bf 00 00 00 00       	mov    $0x0,%edi
  1002aa:	cd 3a                	int    $0x3a
  1002ac:	49 89 c5             	mov    %rax,%r13
  1002af:	48 89 05 7a 1d 00 00 	mov    %rax,0x1d7a(%rip)        # 102030 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  1002b6:	48 89 c3             	mov    %rax,%rbx
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	if (extend(aligned_size)) {
  1002b9:	4c 89 e7             	mov    %r12,%rdi
  1002bc:	e8 6d fe ff ff       	call   10012e <extend>
  1002c1:	85 c0                	test   %eax,%eax
  1002c3:	75 44                	jne    100309 <malloc+0xbb>
		return NULL;
	}
	set_allocated(bp, aligned_size);
  1002c5:	4c 89 e6             	mov    %r12,%rsi
  1002c8:	4c 89 ef             	mov    %r13,%rdi
  1002cb:	e8 ca fe ff ff       	call   10019a <set_allocated>
	num_allocs++;
  1002d0:	48 83 05 38 1d 00 00 	addq   $0x1,0x1d38(%rip)        # 102010 <num_allocs>
  1002d7:	01 
    return bp;
  1002d8:	eb 1a                	jmp    1002f4 <malloc+0xa6>
		heap_init();
  1002da:	e8 92 fd ff ff       	call   100071 <heap_init>
  1002df:	eb 86                	jmp    100267 <malloc+0x19>
			set_allocated(bp, aligned_size);
  1002e1:	4c 89 e6             	mov    %r12,%rsi
  1002e4:	48 89 df             	mov    %rbx,%rdi
  1002e7:	e8 ae fe ff ff       	call   10019a <set_allocated>
			num_allocs++;
  1002ec:	48 83 05 1c 1d 00 00 	addq   $0x1,0x1d1c(%rip)        # 102010 <num_allocs>
  1002f3:	01 
}
  1002f4:	48 89 d8             	mov    %rbx,%rax
  1002f7:	48 83 c4 08          	add    $0x8,%rsp
  1002fb:	5b                   	pop    %rbx
  1002fc:	41 5c                	pop    %r12
  1002fe:	41 5d                	pop    %r13
  100300:	5d                   	pop    %rbp
  100301:	c3                   	ret    
		return NULL;
  100302:	bb 00 00 00 00       	mov    $0x0,%ebx
  100307:	eb eb                	jmp    1002f4 <malloc+0xa6>
		return NULL;
  100309:	bb 00 00 00 00       	mov    $0x0,%ebx
  10030e:	eb e4                	jmp    1002f4 <malloc+0xa6>

0000000000100310 <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  100310:	55                   	push   %rbp
  100311:	48 89 e5             	mov    %rsp,%rbp
  100314:	41 54                	push   %r12
  100316:	53                   	push   %rbx
	void *bp = malloc(num * sz);
  100317:	48 0f af fe          	imul   %rsi,%rdi
  10031b:	49 89 fc             	mov    %rdi,%r12
  10031e:	e8 2b ff ff ff       	call   10024e <malloc>
  100323:	48 89 c3             	mov    %rax,%rbx
	if (bp)							// protect against num=0 or size=0
  100326:	48 85 c0             	test   %rax,%rax
  100329:	74 10                	je     10033b <calloc+0x2b>
		memset(bp, 0, num * sz);
  10032b:	4c 89 e2             	mov    %r12,%rdx
  10032e:	be 00 00 00 00       	mov    $0x0,%esi
  100333:	48 89 c7             	mov    %rax,%rdi
  100336:	e8 36 05 00 00       	call   100871 <memset>
	return bp;
}
  10033b:	48 89 d8             	mov    %rbx,%rax
  10033e:	5b                   	pop    %rbx
  10033f:	41 5c                	pop    %r12
  100341:	5d                   	pop    %rbp
  100342:	c3                   	ret    

0000000000100343 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  100343:	55                   	push   %rbp
  100344:	48 89 e5             	mov    %rsp,%rbp
  100347:	41 54                	push   %r12
  100349:	53                   	push   %rbx
  10034a:	48 89 fb             	mov    %rdi,%rbx
  10034d:	48 89 f7             	mov    %rsi,%rdi
	// first check if there's enough space in the block already (and that it's actually valid ptr)
	if (ptr && GET_SIZE(HDRP(ptr)) >= sz)
  100350:	48 85 db             	test   %rbx,%rbx
  100353:	74 10                	je     100365 <realloc+0x22>
  100355:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  100359:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
		return ptr;
  10035d:	49 89 dc             	mov    %rbx,%r12
	if (ptr && GET_SIZE(HDRP(ptr)) >= sz)
  100360:	48 39 f0             	cmp    %rsi,%rax
  100363:	73 23                	jae    100388 <realloc+0x45>

	// else find or add a big enough block, which is what malloc does
	void *bigger_ptr = malloc(sz);
  100365:	e8 e4 fe ff ff       	call   10024e <malloc>
  10036a:	49 89 c4             	mov    %rax,%r12
	memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
  10036d:	48 8b 53 f8          	mov    -0x8(%rbx),%rdx
  100371:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100375:	48 89 de             	mov    %rbx,%rsi
  100378:	48 89 c7             	mov    %rax,%rdi
  10037b:	e8 f3 03 00 00       	call   100773 <memcpy>
	free(ptr);
  100380:	48 89 df             	mov    %rbx,%rdi
  100383:	e8 63 fd ff ff       	call   1000eb <free>

    return bigger_ptr;
}
  100388:	4c 89 e0             	mov    %r12,%rax
  10038b:	5b                   	pop    %rbx
  10038c:	41 5c                	pop    %r12
  10038e:	5d                   	pop    %rbp
  10038f:	c3                   	ret    

0000000000100390 <defrag>:

void defrag() {
	void *fp = free_list;
  100390:	48 8b 05 81 1c 00 00 	mov    0x1c81(%rip),%rax        # 102018 <free_list>
	while (fp != NULL) {
  100397:	48 85 c0             	test   %rax,%rax
  10039a:	75 50                	jne    1003ec <defrag+0x5c>
			PUT(FTRP(prev_block), PACK(GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp)), 0));	
		}

		fp = NEXT_FPTR(fp);
	}
}
  10039c:	c3                   	ret    
				free_list = NEXT_FPTR(next_block);
  10039d:	48 8b 0a             	mov    (%rdx),%rcx
  1003a0:	48 89 0d 71 1c 00 00 	mov    %rcx,0x1c71(%rip)        # 102018 <free_list>
  1003a7:	eb 5d                	jmp    100406 <defrag+0x76>
			fp = NEXT_FPTR(fp);
  1003a9:	48 8b 00             	mov    (%rax),%rax
			continue;
  1003ac:	eb 39                	jmp    1003e7 <defrag+0x57>
				free_list = NEXT_FPTR(fp);
  1003ae:	48 8b 08             	mov    (%rax),%rcx
  1003b1:	48 89 0d 60 1c 00 00 	mov    %rcx,0x1c60(%rip)        # 102018 <free_list>
  1003b8:	e9 d0 00 00 00       	jmp    10048d <defrag+0xfd>
			PUT(HDRP(prev_block), PACK(GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp)), 0));	
  1003bd:	48 8b 4a f8          	mov    -0x8(%rdx),%rcx
  1003c1:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  1003c5:	48 8b 70 f8          	mov    -0x8(%rax),%rsi
  1003c9:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  1003cd:	48 01 f1             	add    %rsi,%rcx
  1003d0:	48 89 4a f8          	mov    %rcx,-0x8(%rdx)
			PUT(FTRP(prev_block), PACK(GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp)), 0));	
  1003d4:	48 8b 70 f8          	mov    -0x8(%rax),%rsi
  1003d8:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  1003dc:	48 01 ce             	add    %rcx,%rsi
  1003df:	48 89 74 0a f0       	mov    %rsi,-0x10(%rdx,%rcx,1)
		fp = NEXT_FPTR(fp);
  1003e4:	48 8b 00             	mov    (%rax),%rax
	while (fp != NULL) {
  1003e7:	48 85 c0             	test   %rax,%rax
  1003ea:	74 b0                	je     10039c <defrag+0xc>
		void *next_block = NEXT_BLKP(fp);
  1003ec:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1003f0:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1003f4:	48 01 c2             	add    %rax,%rdx
		if (!GET_ALLOC(HDRP(next_block))) {
  1003f7:	f6 42 f8 01          	testb  $0x1,-0x8(%rdx)
  1003fb:	75 4f                	jne    10044c <defrag+0xbc>
			if (free_list == next_block)
  1003fd:	48 39 15 14 1c 00 00 	cmp    %rdx,0x1c14(%rip)        # 102018 <free_list>
  100404:	74 97                	je     10039d <defrag+0xd>
			if (PREV_FPTR(next_block)) 
  100406:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  10040a:	48 85 c9             	test   %rcx,%rcx
  10040d:	74 06                	je     100415 <defrag+0x85>
				NEXT_FPTR(PREV_FPTR(next_block)) = NEXT_FPTR(next_block);
  10040f:	48 8b 32             	mov    (%rdx),%rsi
  100412:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(next_block)) 
  100415:	48 8b 0a             	mov    (%rdx),%rcx
  100418:	48 85 c9             	test   %rcx,%rcx
  10041b:	74 08                	je     100425 <defrag+0x95>
				PREV_FPTR(NEXT_FPTR(next_block)) = PREV_FPTR(next_block);
  10041d:	48 8b 72 08          	mov    0x8(%rdx),%rsi
  100421:	48 89 71 08          	mov    %rsi,0x8(%rcx)
			PUT(HDRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  100425:	48 8b 48 f8          	mov    -0x8(%rax),%rcx
  100429:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  10042d:	48 8b 72 f8          	mov    -0x8(%rdx),%rsi
  100431:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  100435:	48 01 f1             	add    %rsi,%rcx
  100438:	48 89 48 f8          	mov    %rcx,-0x8(%rax)
			PUT(FTRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  10043c:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  100440:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100444:	48 01 ca             	add    %rcx,%rdx
  100447:	48 89 54 08 f0       	mov    %rdx,-0x10(%rax,%rcx,1)
		void *prev_block = PREV_BLKP(fp);
  10044c:	48 8b 48 f0          	mov    -0x10(%rax),%rcx
  100450:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  100454:	48 89 c2             	mov    %rax,%rdx
  100457:	48 29 ca             	sub    %rcx,%rdx
		if (GET_SIZE(HDRP(prev_block)) != GET_SIZE(FTRP(prev_block))){
  10045a:	48 8b 4a f8          	mov    -0x8(%rdx),%rcx
  10045e:	48 89 ce             	mov    %rcx,%rsi
  100461:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  100465:	48 89 cf             	mov    %rcx,%rdi
  100468:	48 33 7c 32 f0       	xor    -0x10(%rdx,%rsi,1),%rdi
  10046d:	48 83 ff 0f          	cmp    $0xf,%rdi
  100471:	0f 87 32 ff ff ff    	ja     1003a9 <defrag+0x19>
		if (!GET_ALLOC(HDRP(prev_block))) {
  100477:	f6 c1 01             	test   $0x1,%cl
  10047a:	0f 85 64 ff ff ff    	jne    1003e4 <defrag+0x54>
			if (free_list == fp)
  100480:	48 39 05 91 1b 00 00 	cmp    %rax,0x1b91(%rip)        # 102018 <free_list>
  100487:	0f 84 21 ff ff ff    	je     1003ae <defrag+0x1e>
			if (PREV_FPTR(fp)) 
  10048d:	48 8b 48 08          	mov    0x8(%rax),%rcx
  100491:	48 85 c9             	test   %rcx,%rcx
  100494:	74 06                	je     10049c <defrag+0x10c>
				NEXT_FPTR(PREV_FPTR(fp)) = NEXT_FPTR(fp);
  100496:	48 8b 30             	mov    (%rax),%rsi
  100499:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(fp)) 
  10049c:	48 8b 08             	mov    (%rax),%rcx
  10049f:	48 85 c9             	test   %rcx,%rcx
  1004a2:	0f 84 15 ff ff ff    	je     1003bd <defrag+0x2d>
				PREV_FPTR(NEXT_FPTR(fp)) = PREV_FPTR(fp);
  1004a8:	48 8b 70 08          	mov    0x8(%rax),%rsi
  1004ac:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  1004b0:	e9 08 ff ff ff       	jmp    1003bd <defrag+0x2d>

00000000001004b5 <sift_down>:
// heap sort stuff that operates on the pointer array
#define LEFT_CHILD(x) (2*x + 1)
#define RIGHT_CHILD(x) (2*x + 2)
#define PARENT(x) ((x-1)/2)

void sift_down(void **arr, size_t pos, size_t arr_len) {
  1004b5:	48 89 f1             	mov    %rsi,%rcx
  1004b8:	49 89 d3             	mov    %rdx,%r11
	while(LEFT_CHILD(pos) < arr_len) {
  1004bb:	48 8d 74 36 01       	lea    0x1(%rsi,%rsi,1),%rsi
  1004c0:	48 39 d6             	cmp    %rdx,%rsi
  1004c3:	72 3a                	jb     1004ff <sift_down+0x4a>
  1004c5:	c3                   	ret    
  1004c6:	48 89 f0             	mov    %rsi,%rax
		size_t smaller = LEFT_CHILD(pos);
		if (RIGHT_CHILD(pos) < arr_len && GET_SIZE(HDRP(arr[RIGHT_CHILD(pos)])) < GET_SIZE(HDRP(arr[LEFT_CHILD(pos)]))) 
			smaller = RIGHT_CHILD(pos);

		if (GET_SIZE(HDRP(arr[pos])) > GET_SIZE(HDRP(arr[smaller]))) {
  1004c9:	4c 8d 0c cf          	lea    (%rdi,%rcx,8),%r9
  1004cd:	4d 8b 01             	mov    (%r9),%r8
  1004d0:	48 8d 34 c7          	lea    (%rdi,%rax,8),%rsi
  1004d4:	4c 8b 16             	mov    (%rsi),%r10
  1004d7:	49 8b 50 f8          	mov    -0x8(%r8),%rdx
  1004db:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1004df:	49 8b 4a f8          	mov    -0x8(%r10),%rcx
  1004e3:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  1004e7:	48 39 d1             	cmp    %rdx,%rcx
  1004ea:	73 46                	jae    100532 <sift_down+0x7d>
			void *temp = arr[pos];
			arr[pos] = arr[smaller];
  1004ec:	4d 89 11             	mov    %r10,(%r9)
			arr[smaller] = temp;
  1004ef:	4c 89 06             	mov    %r8,(%rsi)
	while(LEFT_CHILD(pos) < arr_len) {
  1004f2:	48 8d 74 00 01       	lea    0x1(%rax,%rax,1),%rsi
  1004f7:	4c 39 de             	cmp    %r11,%rsi
  1004fa:	73 36                	jae    100532 <sift_down+0x7d>
			pos = smaller;
  1004fc:	48 89 c1             	mov    %rax,%rcx
		if (RIGHT_CHILD(pos) < arr_len && GET_SIZE(HDRP(arr[RIGHT_CHILD(pos)])) < GET_SIZE(HDRP(arr[LEFT_CHILD(pos)]))) 
  1004ff:	48 8d 51 01          	lea    0x1(%rcx),%rdx
  100503:	48 8d 04 12          	lea    (%rdx,%rdx,1),%rax
  100507:	4c 39 d8             	cmp    %r11,%rax
  10050a:	73 ba                	jae    1004c6 <sift_down+0x11>
  10050c:	48 c1 e2 04          	shl    $0x4,%rdx
  100510:	4c 8b 04 17          	mov    (%rdi,%rdx,1),%r8
  100514:	4d 8b 40 f8          	mov    -0x8(%r8),%r8
  100518:	49 83 e0 f0          	and    $0xfffffffffffffff0,%r8
  10051c:	48 8b 54 17 f8       	mov    -0x8(%rdi,%rdx,1),%rdx
  100521:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  100525:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100529:	49 39 d0             	cmp    %rdx,%r8
  10052c:	48 0f 43 c6          	cmovae %rsi,%rax
  100530:	eb 97                	jmp    1004c9 <sift_down+0x14>
		}
		else{
			break;
		}
	}	
}
  100532:	c3                   	ret    

0000000000100533 <heapify>:

void heapify(void **arr, size_t arr_len) {
  100533:	55                   	push   %rbp
  100534:	48 89 e5             	mov    %rsp,%rbp
  100537:	41 56                	push   %r14
  100539:	41 55                	push   %r13
  10053b:	41 54                	push   %r12
  10053d:	53                   	push   %rbx
	int index = arr_len - 1;
	while(index >= 0) {
  10053e:	41 89 f5             	mov    %esi,%r13d
  100541:	41 83 ed 01          	sub    $0x1,%r13d
  100545:	78 28                	js     10056f <heapify+0x3c>
  100547:	49 89 fe             	mov    %rdi,%r14
  10054a:	49 89 f4             	mov    %rsi,%r12
  10054d:	49 63 c5             	movslq %r13d,%rax
  100550:	48 89 c3             	mov    %rax,%rbx
  100553:	41 29 c5             	sub    %eax,%r13d
		sift_down(arr, index, arr_len);	
  100556:	4c 89 e2             	mov    %r12,%rdx
  100559:	48 89 de             	mov    %rbx,%rsi
  10055c:	4c 89 f7             	mov    %r14,%rdi
  10055f:	e8 51 ff ff ff       	call   1004b5 <sift_down>
	while(index >= 0) {
  100564:	48 83 eb 01          	sub    $0x1,%rbx
  100568:	44 89 e8             	mov    %r13d,%eax
  10056b:	01 d8                	add    %ebx,%eax
  10056d:	79 e7                	jns    100556 <heapify+0x23>
		index--;
	}
}
  10056f:	5b                   	pop    %rbx
  100570:	41 5c                	pop    %r12
  100572:	41 5d                	pop    %r13
  100574:	41 5e                	pop    %r14
  100576:	5d                   	pop    %rbp
  100577:	c3                   	ret    

0000000000100578 <heapsort>:

void heapsort(void **arr, size_t arr_len) {
  100578:	55                   	push   %rbp
  100579:	48 89 e5             	mov    %rsp,%rbp
  10057c:	41 54                	push   %r12
  10057e:	53                   	push   %rbx
  10057f:	49 89 fc             	mov    %rdi,%r12
  100582:	48 89 f3             	mov    %rsi,%rbx
	heapify(arr, arr_len);
  100585:	e8 a9 ff ff ff       	call   100533 <heapify>
	if (arr_len == 0)
  10058a:	48 85 db             	test   %rbx,%rbx
  10058d:	74 34                	je     1005c3 <heapsort+0x4b>
		return;
	for (size_t i = arr_len - 1; i > 1; i--) {
  10058f:	48 83 eb 01          	sub    $0x1,%rbx
  100593:	48 83 fb 01          	cmp    $0x1,%rbx
  100597:	76 2a                	jbe    1005c3 <heapsort+0x4b>
		void *temp = arr[0];
  100599:	49 8b 04 24          	mov    (%r12),%rax
		arr[0] = arr[i];
  10059d:	49 8b 14 dc          	mov    (%r12,%rbx,8),%rdx
  1005a1:	49 89 14 24          	mov    %rdx,(%r12)
		arr[i] = temp;
  1005a5:	49 89 04 dc          	mov    %rax,(%r12,%rbx,8)
		sift_down(arr, 0, i);
  1005a9:	48 89 da             	mov    %rbx,%rdx
  1005ac:	be 00 00 00 00       	mov    $0x0,%esi
  1005b1:	4c 89 e7             	mov    %r12,%rdi
  1005b4:	e8 fc fe ff ff       	call   1004b5 <sift_down>
	for (size_t i = arr_len - 1; i > 1; i--) {
  1005b9:	48 83 eb 01          	sub    $0x1,%rbx
  1005bd:	48 83 fb 01          	cmp    $0x1,%rbx
  1005c1:	75 d6                	jne    100599 <heapsort+0x21>
	}
}
  1005c3:	5b                   	pop    %rbx
  1005c4:	41 5c                	pop    %r12
  1005c6:	5d                   	pop    %rbp
  1005c7:	c3                   	ret    

00000000001005c8 <heap_info>:

int heap_info(heap_info_struct *info) {
  1005c8:	55                   	push   %rbp
  1005c9:	48 89 e5             	mov    %rsp,%rbp
  1005cc:	53                   	push   %rbx
  1005cd:	48 83 ec 08          	sub    $0x8,%rsp
  1005d1:	48 89 fb             	mov    %rdi,%rbx
	info->num_allocs = num_allocs+2;		// +2 for the two arrays we need
  1005d4:	8b 05 36 1a 00 00    	mov    0x1a36(%rip),%eax        # 102010 <num_allocs>
  1005da:	83 c0 02             	add    $0x2,%eax
  1005dd:	89 07                	mov    %eax,(%rdi)
	info->free_space = 0;
  1005df:	c7 47 18 00 00 00 00 	movl   $0x0,0x18(%rdi)
	info->largest_free_chunk = 0;
  1005e6:	c7 47 1c 00 00 00 00 	movl   $0x0,0x1c(%rdi)

	info->size_array = sbrk(ALIGN(info->num_allocs * sizeof(long) + OVERHEAD));
  1005ed:	48 98                	cltq   
  1005ef:	48 8d 3c c5 17 00 00 	lea    0x17(,%rax,8),%rdi
  1005f6:	00 
  1005f7:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
    asm volatile ("int %1" :  "=a" (result)
  1005fb:	cd 3a                	int    $0x3a
  1005fd:	48 89 05 2c 1a 00 00 	mov    %rax,0x1a2c(%rip)        # 102030 <result.0>
  100604:	48 89 43 08          	mov    %rax,0x8(%rbx)
	if (info->ptr_array == (void *)-1) { // nothing happens on failure
  100608:	48 83 7b 10 ff       	cmpq   $0xffffffffffffffff,0x10(%rbx)
  10060d:	0f 84 52 01 00 00    	je     100765 <heap_info+0x19d>
		return -1;
	}
	info->ptr_array = sbrk(ALIGN(info->num_allocs * sizeof(void *) + OVERHEAD));
  100613:	48 63 03             	movslq (%rbx),%rax
  100616:	48 8d 3c c5 17 00 00 	lea    0x17(,%rax,8),%rdi
  10061d:	00 
  10061e:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
  100622:	cd 3a                	int    $0x3a
  100624:	48 89 05 05 1a 00 00 	mov    %rax,0x1a05(%rip)        # 102030 <result.0>
  10062b:	48 89 43 10          	mov    %rax,0x10(%rbx)
	if (info->ptr_array == (void *)-1) {
  10062f:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  100633:	74 72                	je     1006a7 <heap_info+0xdf>
		sbrk(-ALIGN(info->num_allocs * sizeof(long) + OVERHEAD));
		return -1;
	}

	// we manually fill in array metadata
	PUT(HDRP(info->size_array), PACK(ALIGN(info->num_allocs * sizeof(long) + OVERHEAD), 1));
  100635:	48 8b 53 08          	mov    0x8(%rbx),%rdx
  100639:	48 63 03             	movslq (%rbx),%rax
  10063c:	48 8d 04 c5 17 00 00 	lea    0x17(,%rax,8),%rax
  100643:	00 
  100644:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100648:	48 83 c8 01          	or     $0x1,%rax
  10064c:	48 89 42 f8          	mov    %rax,-0x8(%rdx)
	PUT(HDRP(info->ptr_array), PACK(ALIGN(info->num_allocs * sizeof(void *) + OVERHEAD), 1));
  100650:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  100654:	48 63 03             	movslq (%rbx),%rax
  100657:	48 8d 04 c5 17 00 00 	lea    0x17(,%rax,8),%rax
  10065e:	00 
  10065f:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100663:	48 83 c8 01          	or     $0x1,%rax
  100667:	48 89 42 f8          	mov    %rax,-0x8(%rdx)

	// terminal block
	PUT(HDRP(NEXT_BLKP(info->ptr_array)), PACK(0, 1));
  10066b:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  10066f:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  100673:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100677:	48 c7 44 02 f8 01 00 	movq   $0x1,-0x8(%rdx,%rax,1)
  10067e:	00 00 

	// collect all the information by traversing through the heap
	void *bp = NEXT_BLKP(prologue_block); // because the prologue isn't actually allocated
  100680:	48 8b 05 99 19 00 00 	mov    0x1999(%rip),%rax        # 102020 <prologue_block>
  100687:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  10068b:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  10068f:	48 01 d0             	add    %rdx,%rax
	size_t arr_index = 0;
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  100692:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  100696:	48 83 fa 0f          	cmp    $0xf,%rdx
  10069a:	0f 86 84 00 00 00    	jbe    100724 <heap_info+0x15c>
	size_t arr_index = 0;
  1006a0:	b9 00 00 00 00       	mov    $0x0,%ecx
  1006a5:	eb 5a                	jmp    100701 <heap_info+0x139>
		sbrk(-ALIGN(info->num_allocs * sizeof(long) + OVERHEAD));
  1006a7:	48 63 03             	movslq (%rbx),%rax
  1006aa:	48 8d 3c c5 17 00 00 	lea    0x17(,%rax,8),%rdi
  1006b1:	00 
  1006b2:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
  1006b6:	48 f7 df             	neg    %rdi
  1006b9:	cd 3a                	int    $0x3a
  1006bb:	48 89 05 6e 19 00 00 	mov    %rax,0x196e(%rip)        # 102030 <result.0>
		return -1;
  1006c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1006c7:	e9 93 00 00 00       	jmp    10075f <heap_info+0x197>
			info->ptr_array[arr_index] = bp;
			info->size_array[arr_index] = GET_SIZE(HDRP(bp));
			arr_index++;
		}
		else {
			info->free_space += GET_SIZE(HDRP(bp));
  1006cc:	83 e2 f0             	and    $0xfffffff0,%edx
  1006cf:	01 53 18             	add    %edx,0x18(%rbx)
			if(GET_SIZE(HDRP(bp)) > (size_t) (info->largest_free_chunk)) {
  1006d2:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1006d6:	48 89 d6             	mov    %rdx,%rsi
  1006d9:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  1006dd:	48 63 7b 1c          	movslq 0x1c(%rbx),%rdi
  1006e1:	48 39 f7             	cmp    %rsi,%rdi
  1006e4:	73 06                	jae    1006ec <heap_info+0x124>
				info->largest_free_chunk = GET_SIZE(HDRP(bp));
  1006e6:	83 e2 f0             	and    $0xfffffff0,%edx
  1006e9:	89 53 1c             	mov    %edx,0x1c(%rbx)
			}
		}

		bp = NEXT_BLKP(bp);
  1006ec:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1006f0:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1006f4:	48 01 d0             	add    %rdx,%rax
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  1006f7:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1006fb:	48 83 fa 0f          	cmp    $0xf,%rdx
  1006ff:	76 23                	jbe    100724 <heap_info+0x15c>
		if (GET_ALLOC(HDRP(bp))) {
  100701:	f6 c2 01             	test   $0x1,%dl
  100704:	74 c6                	je     1006cc <heap_info+0x104>
			info->ptr_array[arr_index] = bp;
  100706:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  10070a:	48 89 04 ca          	mov    %rax,(%rdx,%rcx,8)
			info->size_array[arr_index] = GET_SIZE(HDRP(bp));
  10070e:	48 8b 73 08          	mov    0x8(%rbx),%rsi
  100712:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  100716:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  10071a:	48 89 14 ce          	mov    %rdx,(%rsi,%rcx,8)
			arr_index++;
  10071e:	48 83 c1 01          	add    $0x1,%rcx
  100722:	eb c8                	jmp    1006ec <heap_info+0x124>
	}

	// we just need to sort the arrays...
	// we'll use heapsort
	heapsort(info->ptr_array, info->num_allocs);
  100724:	48 63 33             	movslq (%rbx),%rsi
  100727:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
  10072b:	e8 48 fe ff ff       	call   100578 <heapsort>
	for (int i = 0; i < info->num_allocs; i++)
  100730:	83 3b 00             	cmpl   $0x0,(%rbx)
  100733:	7e 37                	jle    10076c <heap_info+0x1a4>
  100735:	b8 00 00 00 00       	mov    $0x0,%eax
		info->size_array[i] = GET_SIZE(HDRP(info->ptr_array[i]));
  10073a:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
  10073e:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  100742:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
  100746:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  10074a:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  10074e:	48 89 14 c1          	mov    %rdx,(%rcx,%rax,8)
	for (int i = 0; i < info->num_allocs; i++)
  100752:	48 83 c0 01          	add    $0x1,%rax
  100756:	39 03                	cmp    %eax,(%rbx)
  100758:	7f e0                	jg     10073a <heap_info+0x172>

    return 0;
  10075a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10075f:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100763:	c9                   	leave  
  100764:	c3                   	ret    
		return -1;
  100765:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10076a:	eb f3                	jmp    10075f <heap_info+0x197>
    return 0;
  10076c:	b8 00 00 00 00       	mov    $0x0,%eax
  100771:	eb ec                	jmp    10075f <heap_info+0x197>

0000000000100773 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100773:	55                   	push   %rbp
  100774:	48 89 e5             	mov    %rsp,%rbp
  100777:	48 83 ec 28          	sub    $0x28,%rsp
  10077b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10077f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100783:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100787:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10078b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  10078f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100793:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100797:	eb 1c                	jmp    1007b5 <memcpy+0x42>
        *d = *s;
  100799:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10079d:	0f b6 10             	movzbl (%rax),%edx
  1007a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1007a4:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1007a6:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1007ab:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1007b0:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1007b5:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1007ba:	75 dd                	jne    100799 <memcpy+0x26>
    }
    return dst;
  1007bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1007c0:	c9                   	leave  
  1007c1:	c3                   	ret    

00000000001007c2 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1007c2:	55                   	push   %rbp
  1007c3:	48 89 e5             	mov    %rsp,%rbp
  1007c6:	48 83 ec 28          	sub    $0x28,%rsp
  1007ca:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1007ce:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1007d2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1007d6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1007da:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  1007de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1007e2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  1007e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007ea:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  1007ee:	73 6a                	jae    10085a <memmove+0x98>
  1007f0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1007f4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1007f8:	48 01 d0             	add    %rdx,%rax
  1007fb:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1007ff:	73 59                	jae    10085a <memmove+0x98>
        s += n, d += n;
  100801:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100805:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100809:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10080d:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  100811:	eb 17                	jmp    10082a <memmove+0x68>
            *--d = *--s;
  100813:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100818:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  10081d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100821:	0f b6 10             	movzbl (%rax),%edx
  100824:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100828:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  10082a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10082e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100832:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100836:	48 85 c0             	test   %rax,%rax
  100839:	75 d8                	jne    100813 <memmove+0x51>
    if (s < d && s + n > d) {
  10083b:	eb 2e                	jmp    10086b <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  10083d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100841:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100845:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100849:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10084d:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100851:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100855:	0f b6 12             	movzbl (%rdx),%edx
  100858:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  10085a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10085e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100862:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100866:	48 85 c0             	test   %rax,%rax
  100869:	75 d2                	jne    10083d <memmove+0x7b>
        }
    }
    return dst;
  10086b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10086f:	c9                   	leave  
  100870:	c3                   	ret    

0000000000100871 <memset>:

void* memset(void* v, int c, size_t n) {
  100871:	55                   	push   %rbp
  100872:	48 89 e5             	mov    %rsp,%rbp
  100875:	48 83 ec 28          	sub    $0x28,%rsp
  100879:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10087d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100880:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100884:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100888:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10088c:	eb 15                	jmp    1008a3 <memset+0x32>
        *p = c;
  10088e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100891:	89 c2                	mov    %eax,%edx
  100893:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100897:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100899:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10089e:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1008a3:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1008a8:	75 e4                	jne    10088e <memset+0x1d>
    }
    return v;
  1008aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1008ae:	c9                   	leave  
  1008af:	c3                   	ret    

00000000001008b0 <strlen>:

size_t strlen(const char* s) {
  1008b0:	55                   	push   %rbp
  1008b1:	48 89 e5             	mov    %rsp,%rbp
  1008b4:	48 83 ec 18          	sub    $0x18,%rsp
  1008b8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  1008bc:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1008c3:	00 
  1008c4:	eb 0a                	jmp    1008d0 <strlen+0x20>
        ++n;
  1008c6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  1008cb:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1008d0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1008d4:	0f b6 00             	movzbl (%rax),%eax
  1008d7:	84 c0                	test   %al,%al
  1008d9:	75 eb                	jne    1008c6 <strlen+0x16>
    }
    return n;
  1008db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1008df:	c9                   	leave  
  1008e0:	c3                   	ret    

00000000001008e1 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  1008e1:	55                   	push   %rbp
  1008e2:	48 89 e5             	mov    %rsp,%rbp
  1008e5:	48 83 ec 20          	sub    $0x20,%rsp
  1008e9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1008ed:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1008f1:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1008f8:	00 
  1008f9:	eb 0a                	jmp    100905 <strnlen+0x24>
        ++n;
  1008fb:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100900:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100905:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100909:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  10090d:	74 0b                	je     10091a <strnlen+0x39>
  10090f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100913:	0f b6 00             	movzbl (%rax),%eax
  100916:	84 c0                	test   %al,%al
  100918:	75 e1                	jne    1008fb <strnlen+0x1a>
    }
    return n;
  10091a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  10091e:	c9                   	leave  
  10091f:	c3                   	ret    

0000000000100920 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100920:	55                   	push   %rbp
  100921:	48 89 e5             	mov    %rsp,%rbp
  100924:	48 83 ec 20          	sub    $0x20,%rsp
  100928:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10092c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  100930:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100934:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100938:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  10093c:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100940:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100944:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100948:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10094c:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100950:	0f b6 12             	movzbl (%rdx),%edx
  100953:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100955:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100959:	48 83 e8 01          	sub    $0x1,%rax
  10095d:	0f b6 00             	movzbl (%rax),%eax
  100960:	84 c0                	test   %al,%al
  100962:	75 d4                	jne    100938 <strcpy+0x18>
    return dst;
  100964:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100968:	c9                   	leave  
  100969:	c3                   	ret    

000000000010096a <strcmp>:

int strcmp(const char* a, const char* b) {
  10096a:	55                   	push   %rbp
  10096b:	48 89 e5             	mov    %rsp,%rbp
  10096e:	48 83 ec 10          	sub    $0x10,%rsp
  100972:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100976:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10097a:	eb 0a                	jmp    100986 <strcmp+0x1c>
        ++a, ++b;
  10097c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100981:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100986:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10098a:	0f b6 00             	movzbl (%rax),%eax
  10098d:	84 c0                	test   %al,%al
  10098f:	74 1d                	je     1009ae <strcmp+0x44>
  100991:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100995:	0f b6 00             	movzbl (%rax),%eax
  100998:	84 c0                	test   %al,%al
  10099a:	74 12                	je     1009ae <strcmp+0x44>
  10099c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009a0:	0f b6 10             	movzbl (%rax),%edx
  1009a3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1009a7:	0f b6 00             	movzbl (%rax),%eax
  1009aa:	38 c2                	cmp    %al,%dl
  1009ac:	74 ce                	je     10097c <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  1009ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009b2:	0f b6 00             	movzbl (%rax),%eax
  1009b5:	89 c2                	mov    %eax,%edx
  1009b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1009bb:	0f b6 00             	movzbl (%rax),%eax
  1009be:	38 d0                	cmp    %dl,%al
  1009c0:	0f 92 c0             	setb   %al
  1009c3:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  1009c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009ca:	0f b6 00             	movzbl (%rax),%eax
  1009cd:	89 c1                	mov    %eax,%ecx
  1009cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1009d3:	0f b6 00             	movzbl (%rax),%eax
  1009d6:	38 c1                	cmp    %al,%cl
  1009d8:	0f 92 c0             	setb   %al
  1009db:	0f b6 c0             	movzbl %al,%eax
  1009de:	29 c2                	sub    %eax,%edx
  1009e0:	89 d0                	mov    %edx,%eax
}
  1009e2:	c9                   	leave  
  1009e3:	c3                   	ret    

00000000001009e4 <strchr>:

char* strchr(const char* s, int c) {
  1009e4:	55                   	push   %rbp
  1009e5:	48 89 e5             	mov    %rsp,%rbp
  1009e8:	48 83 ec 10          	sub    $0x10,%rsp
  1009ec:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1009f0:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1009f3:	eb 05                	jmp    1009fa <strchr+0x16>
        ++s;
  1009f5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1009fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009fe:	0f b6 00             	movzbl (%rax),%eax
  100a01:	84 c0                	test   %al,%al
  100a03:	74 0e                	je     100a13 <strchr+0x2f>
  100a05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a09:	0f b6 00             	movzbl (%rax),%eax
  100a0c:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100a0f:	38 d0                	cmp    %dl,%al
  100a11:	75 e2                	jne    1009f5 <strchr+0x11>
    }
    if (*s == (char) c) {
  100a13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a17:	0f b6 00             	movzbl (%rax),%eax
  100a1a:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100a1d:	38 d0                	cmp    %dl,%al
  100a1f:	75 06                	jne    100a27 <strchr+0x43>
        return (char*) s;
  100a21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a25:	eb 05                	jmp    100a2c <strchr+0x48>
    } else {
        return NULL;
  100a27:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100a2c:	c9                   	leave  
  100a2d:	c3                   	ret    

0000000000100a2e <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100a2e:	55                   	push   %rbp
  100a2f:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  100a32:	8b 05 00 16 00 00    	mov    0x1600(%rip),%eax        # 102038 <rand_seed_set>
  100a38:	85 c0                	test   %eax,%eax
  100a3a:	75 0a                	jne    100a46 <rand+0x18>
        srand(819234718U);
  100a3c:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100a41:	e8 24 00 00 00       	call   100a6a <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100a46:	8b 05 f0 15 00 00    	mov    0x15f0(%rip),%eax        # 10203c <rand_seed>
  100a4c:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100a52:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100a57:	89 05 df 15 00 00    	mov    %eax,0x15df(%rip)        # 10203c <rand_seed>
    return rand_seed & RAND_MAX;
  100a5d:	8b 05 d9 15 00 00    	mov    0x15d9(%rip),%eax        # 10203c <rand_seed>
  100a63:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100a68:	5d                   	pop    %rbp
  100a69:	c3                   	ret    

0000000000100a6a <srand>:

void srand(unsigned seed) {
  100a6a:	55                   	push   %rbp
  100a6b:	48 89 e5             	mov    %rsp,%rbp
  100a6e:	48 83 ec 08          	sub    $0x8,%rsp
  100a72:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100a75:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100a78:	89 05 be 15 00 00    	mov    %eax,0x15be(%rip)        # 10203c <rand_seed>
    rand_seed_set = 1;
  100a7e:	c7 05 b0 15 00 00 01 	movl   $0x1,0x15b0(%rip)        # 102038 <rand_seed_set>
  100a85:	00 00 00 
}
  100a88:	90                   	nop
  100a89:	c9                   	leave  
  100a8a:	c3                   	ret    

0000000000100a8b <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100a8b:	55                   	push   %rbp
  100a8c:	48 89 e5             	mov    %rsp,%rbp
  100a8f:	48 83 ec 28          	sub    $0x28,%rsp
  100a93:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100a97:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100a9b:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100a9e:	48 c7 45 f8 b0 19 10 	movq   $0x1019b0,-0x8(%rbp)
  100aa5:	00 
    if (base < 0) {
  100aa6:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100aaa:	79 0b                	jns    100ab7 <fill_numbuf+0x2c>
        digits = lower_digits;
  100aac:	48 c7 45 f8 d0 19 10 	movq   $0x1019d0,-0x8(%rbp)
  100ab3:	00 
        base = -base;
  100ab4:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100ab7:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100abc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100ac0:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100ac3:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100ac6:	48 63 c8             	movslq %eax,%rcx
  100ac9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100acd:	ba 00 00 00 00       	mov    $0x0,%edx
  100ad2:	48 f7 f1             	div    %rcx
  100ad5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100ad9:	48 01 d0             	add    %rdx,%rax
  100adc:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100ae1:	0f b6 10             	movzbl (%rax),%edx
  100ae4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100ae8:	88 10                	mov    %dl,(%rax)
        val /= base;
  100aea:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100aed:	48 63 f0             	movslq %eax,%rsi
  100af0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100af4:	ba 00 00 00 00       	mov    $0x0,%edx
  100af9:	48 f7 f6             	div    %rsi
  100afc:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100b00:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100b05:	75 bc                	jne    100ac3 <fill_numbuf+0x38>
    return numbuf_end;
  100b07:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100b0b:	c9                   	leave  
  100b0c:	c3                   	ret    

0000000000100b0d <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100b0d:	55                   	push   %rbp
  100b0e:	48 89 e5             	mov    %rsp,%rbp
  100b11:	53                   	push   %rbx
  100b12:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100b19:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100b20:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100b26:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100b2d:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100b34:	e9 8a 09 00 00       	jmp    1014c3 <printer_vprintf+0x9b6>
        if (*format != '%') {
  100b39:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b40:	0f b6 00             	movzbl (%rax),%eax
  100b43:	3c 25                	cmp    $0x25,%al
  100b45:	74 31                	je     100b78 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  100b47:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100b4e:	4c 8b 00             	mov    (%rax),%r8
  100b51:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b58:	0f b6 00             	movzbl (%rax),%eax
  100b5b:	0f b6 c8             	movzbl %al,%ecx
  100b5e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100b64:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100b6b:	89 ce                	mov    %ecx,%esi
  100b6d:	48 89 c7             	mov    %rax,%rdi
  100b70:	41 ff d0             	call   *%r8
            continue;
  100b73:	e9 43 09 00 00       	jmp    1014bb <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100b78:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100b7f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100b86:	01 
  100b87:	eb 44                	jmp    100bcd <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  100b89:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b90:	0f b6 00             	movzbl (%rax),%eax
  100b93:	0f be c0             	movsbl %al,%eax
  100b96:	89 c6                	mov    %eax,%esi
  100b98:	bf d0 17 10 00       	mov    $0x1017d0,%edi
  100b9d:	e8 42 fe ff ff       	call   1009e4 <strchr>
  100ba2:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100ba6:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100bab:	74 30                	je     100bdd <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  100bad:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100bb1:	48 2d d0 17 10 00    	sub    $0x1017d0,%rax
  100bb7:	ba 01 00 00 00       	mov    $0x1,%edx
  100bbc:	89 c1                	mov    %eax,%ecx
  100bbe:	d3 e2                	shl    %cl,%edx
  100bc0:	89 d0                	mov    %edx,%eax
  100bc2:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100bc5:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100bcc:	01 
  100bcd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bd4:	0f b6 00             	movzbl (%rax),%eax
  100bd7:	84 c0                	test   %al,%al
  100bd9:	75 ae                	jne    100b89 <printer_vprintf+0x7c>
  100bdb:	eb 01                	jmp    100bde <printer_vprintf+0xd1>
            } else {
                break;
  100bdd:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100bde:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100be5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bec:	0f b6 00             	movzbl (%rax),%eax
  100bef:	3c 30                	cmp    $0x30,%al
  100bf1:	7e 67                	jle    100c5a <printer_vprintf+0x14d>
  100bf3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bfa:	0f b6 00             	movzbl (%rax),%eax
  100bfd:	3c 39                	cmp    $0x39,%al
  100bff:	7f 59                	jg     100c5a <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100c01:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100c08:	eb 2e                	jmp    100c38 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100c0a:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100c0d:	89 d0                	mov    %edx,%eax
  100c0f:	c1 e0 02             	shl    $0x2,%eax
  100c12:	01 d0                	add    %edx,%eax
  100c14:	01 c0                	add    %eax,%eax
  100c16:	89 c1                	mov    %eax,%ecx
  100c18:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c1f:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100c23:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100c2a:	0f b6 00             	movzbl (%rax),%eax
  100c2d:	0f be c0             	movsbl %al,%eax
  100c30:	01 c8                	add    %ecx,%eax
  100c32:	83 e8 30             	sub    $0x30,%eax
  100c35:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100c38:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c3f:	0f b6 00             	movzbl (%rax),%eax
  100c42:	3c 2f                	cmp    $0x2f,%al
  100c44:	0f 8e 85 00 00 00    	jle    100ccf <printer_vprintf+0x1c2>
  100c4a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c51:	0f b6 00             	movzbl (%rax),%eax
  100c54:	3c 39                	cmp    $0x39,%al
  100c56:	7e b2                	jle    100c0a <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100c58:	eb 75                	jmp    100ccf <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100c5a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c61:	0f b6 00             	movzbl (%rax),%eax
  100c64:	3c 2a                	cmp    $0x2a,%al
  100c66:	75 68                	jne    100cd0 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100c68:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c6f:	8b 00                	mov    (%rax),%eax
  100c71:	83 f8 2f             	cmp    $0x2f,%eax
  100c74:	77 30                	ja     100ca6 <printer_vprintf+0x199>
  100c76:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c7d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c81:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c88:	8b 00                	mov    (%rax),%eax
  100c8a:	89 c0                	mov    %eax,%eax
  100c8c:	48 01 d0             	add    %rdx,%rax
  100c8f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c96:	8b 12                	mov    (%rdx),%edx
  100c98:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c9b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ca2:	89 0a                	mov    %ecx,(%rdx)
  100ca4:	eb 1a                	jmp    100cc0 <printer_vprintf+0x1b3>
  100ca6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cad:	48 8b 40 08          	mov    0x8(%rax),%rax
  100cb1:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100cb5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cbc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100cc0:	8b 00                	mov    (%rax),%eax
  100cc2:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100cc5:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ccc:	01 
  100ccd:	eb 01                	jmp    100cd0 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100ccf:	90                   	nop
        }

        // process precision
        int precision = -1;
  100cd0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100cd7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100cde:	0f b6 00             	movzbl (%rax),%eax
  100ce1:	3c 2e                	cmp    $0x2e,%al
  100ce3:	0f 85 00 01 00 00    	jne    100de9 <printer_vprintf+0x2dc>
            ++format;
  100ce9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100cf0:	01 
            if (*format >= '0' && *format <= '9') {
  100cf1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100cf8:	0f b6 00             	movzbl (%rax),%eax
  100cfb:	3c 2f                	cmp    $0x2f,%al
  100cfd:	7e 67                	jle    100d66 <printer_vprintf+0x259>
  100cff:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d06:	0f b6 00             	movzbl (%rax),%eax
  100d09:	3c 39                	cmp    $0x39,%al
  100d0b:	7f 59                	jg     100d66 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100d0d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100d14:	eb 2e                	jmp    100d44 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100d16:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100d19:	89 d0                	mov    %edx,%eax
  100d1b:	c1 e0 02             	shl    $0x2,%eax
  100d1e:	01 d0                	add    %edx,%eax
  100d20:	01 c0                	add    %eax,%eax
  100d22:	89 c1                	mov    %eax,%ecx
  100d24:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d2b:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100d2f:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100d36:	0f b6 00             	movzbl (%rax),%eax
  100d39:	0f be c0             	movsbl %al,%eax
  100d3c:	01 c8                	add    %ecx,%eax
  100d3e:	83 e8 30             	sub    $0x30,%eax
  100d41:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100d44:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d4b:	0f b6 00             	movzbl (%rax),%eax
  100d4e:	3c 2f                	cmp    $0x2f,%al
  100d50:	0f 8e 85 00 00 00    	jle    100ddb <printer_vprintf+0x2ce>
  100d56:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d5d:	0f b6 00             	movzbl (%rax),%eax
  100d60:	3c 39                	cmp    $0x39,%al
  100d62:	7e b2                	jle    100d16 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100d64:	eb 75                	jmp    100ddb <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100d66:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d6d:	0f b6 00             	movzbl (%rax),%eax
  100d70:	3c 2a                	cmp    $0x2a,%al
  100d72:	75 68                	jne    100ddc <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100d74:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d7b:	8b 00                	mov    (%rax),%eax
  100d7d:	83 f8 2f             	cmp    $0x2f,%eax
  100d80:	77 30                	ja     100db2 <printer_vprintf+0x2a5>
  100d82:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d89:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d8d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d94:	8b 00                	mov    (%rax),%eax
  100d96:	89 c0                	mov    %eax,%eax
  100d98:	48 01 d0             	add    %rdx,%rax
  100d9b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100da2:	8b 12                	mov    (%rdx),%edx
  100da4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100da7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dae:	89 0a                	mov    %ecx,(%rdx)
  100db0:	eb 1a                	jmp    100dcc <printer_vprintf+0x2bf>
  100db2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100db9:	48 8b 40 08          	mov    0x8(%rax),%rax
  100dbd:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100dc1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dc8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100dcc:	8b 00                	mov    (%rax),%eax
  100dce:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100dd1:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100dd8:	01 
  100dd9:	eb 01                	jmp    100ddc <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100ddb:	90                   	nop
            }
            if (precision < 0) {
  100ddc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100de0:	79 07                	jns    100de9 <printer_vprintf+0x2dc>
                precision = 0;
  100de2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100de9:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100df0:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100df7:	00 
        int length = 0;
  100df8:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100dff:	48 c7 45 c8 d6 17 10 	movq   $0x1017d6,-0x38(%rbp)
  100e06:	00 
    again:
        switch (*format) {
  100e07:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e0e:	0f b6 00             	movzbl (%rax),%eax
  100e11:	0f be c0             	movsbl %al,%eax
  100e14:	83 e8 43             	sub    $0x43,%eax
  100e17:	83 f8 37             	cmp    $0x37,%eax
  100e1a:	0f 87 9f 03 00 00    	ja     1011bf <printer_vprintf+0x6b2>
  100e20:	89 c0                	mov    %eax,%eax
  100e22:	48 8b 04 c5 e8 17 10 	mov    0x1017e8(,%rax,8),%rax
  100e29:	00 
  100e2a:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100e2c:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100e33:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100e3a:	01 
            goto again;
  100e3b:	eb ca                	jmp    100e07 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100e3d:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100e41:	74 5d                	je     100ea0 <printer_vprintf+0x393>
  100e43:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e4a:	8b 00                	mov    (%rax),%eax
  100e4c:	83 f8 2f             	cmp    $0x2f,%eax
  100e4f:	77 30                	ja     100e81 <printer_vprintf+0x374>
  100e51:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e58:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e5c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e63:	8b 00                	mov    (%rax),%eax
  100e65:	89 c0                	mov    %eax,%eax
  100e67:	48 01 d0             	add    %rdx,%rax
  100e6a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e71:	8b 12                	mov    (%rdx),%edx
  100e73:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e76:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e7d:	89 0a                	mov    %ecx,(%rdx)
  100e7f:	eb 1a                	jmp    100e9b <printer_vprintf+0x38e>
  100e81:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e88:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e8c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e90:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e97:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e9b:	48 8b 00             	mov    (%rax),%rax
  100e9e:	eb 5c                	jmp    100efc <printer_vprintf+0x3ef>
  100ea0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ea7:	8b 00                	mov    (%rax),%eax
  100ea9:	83 f8 2f             	cmp    $0x2f,%eax
  100eac:	77 30                	ja     100ede <printer_vprintf+0x3d1>
  100eae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100eb5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100eb9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ec0:	8b 00                	mov    (%rax),%eax
  100ec2:	89 c0                	mov    %eax,%eax
  100ec4:	48 01 d0             	add    %rdx,%rax
  100ec7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ece:	8b 12                	mov    (%rdx),%edx
  100ed0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ed3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100eda:	89 0a                	mov    %ecx,(%rdx)
  100edc:	eb 1a                	jmp    100ef8 <printer_vprintf+0x3eb>
  100ede:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ee5:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ee9:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100eed:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ef4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ef8:	8b 00                	mov    (%rax),%eax
  100efa:	48 98                	cltq   
  100efc:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100f00:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100f04:	48 c1 f8 38          	sar    $0x38,%rax
  100f08:	25 80 00 00 00       	and    $0x80,%eax
  100f0d:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100f10:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100f14:	74 09                	je     100f1f <printer_vprintf+0x412>
  100f16:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100f1a:	48 f7 d8             	neg    %rax
  100f1d:	eb 04                	jmp    100f23 <printer_vprintf+0x416>
  100f1f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100f23:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100f27:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100f2a:	83 c8 60             	or     $0x60,%eax
  100f2d:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100f30:	e9 cf 02 00 00       	jmp    101204 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100f35:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100f39:	74 5d                	je     100f98 <printer_vprintf+0x48b>
  100f3b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f42:	8b 00                	mov    (%rax),%eax
  100f44:	83 f8 2f             	cmp    $0x2f,%eax
  100f47:	77 30                	ja     100f79 <printer_vprintf+0x46c>
  100f49:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f50:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100f54:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f5b:	8b 00                	mov    (%rax),%eax
  100f5d:	89 c0                	mov    %eax,%eax
  100f5f:	48 01 d0             	add    %rdx,%rax
  100f62:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f69:	8b 12                	mov    (%rdx),%edx
  100f6b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100f6e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f75:	89 0a                	mov    %ecx,(%rdx)
  100f77:	eb 1a                	jmp    100f93 <printer_vprintf+0x486>
  100f79:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f80:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f84:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f88:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f8f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f93:	48 8b 00             	mov    (%rax),%rax
  100f96:	eb 5c                	jmp    100ff4 <printer_vprintf+0x4e7>
  100f98:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f9f:	8b 00                	mov    (%rax),%eax
  100fa1:	83 f8 2f             	cmp    $0x2f,%eax
  100fa4:	77 30                	ja     100fd6 <printer_vprintf+0x4c9>
  100fa6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fad:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100fb1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fb8:	8b 00                	mov    (%rax),%eax
  100fba:	89 c0                	mov    %eax,%eax
  100fbc:	48 01 d0             	add    %rdx,%rax
  100fbf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fc6:	8b 12                	mov    (%rdx),%edx
  100fc8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100fcb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fd2:	89 0a                	mov    %ecx,(%rdx)
  100fd4:	eb 1a                	jmp    100ff0 <printer_vprintf+0x4e3>
  100fd6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fdd:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fe1:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100fe5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fec:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ff0:	8b 00                	mov    (%rax),%eax
  100ff2:	89 c0                	mov    %eax,%eax
  100ff4:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100ff8:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100ffc:	e9 03 02 00 00       	jmp    101204 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  101001:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  101008:	e9 28 ff ff ff       	jmp    100f35 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  10100d:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  101014:	e9 1c ff ff ff       	jmp    100f35 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  101019:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101020:	8b 00                	mov    (%rax),%eax
  101022:	83 f8 2f             	cmp    $0x2f,%eax
  101025:	77 30                	ja     101057 <printer_vprintf+0x54a>
  101027:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10102e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101032:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101039:	8b 00                	mov    (%rax),%eax
  10103b:	89 c0                	mov    %eax,%eax
  10103d:	48 01 d0             	add    %rdx,%rax
  101040:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101047:	8b 12                	mov    (%rdx),%edx
  101049:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10104c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101053:	89 0a                	mov    %ecx,(%rdx)
  101055:	eb 1a                	jmp    101071 <printer_vprintf+0x564>
  101057:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10105e:	48 8b 40 08          	mov    0x8(%rax),%rax
  101062:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101066:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10106d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101071:	48 8b 00             	mov    (%rax),%rax
  101074:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  101078:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  10107f:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  101086:	e9 79 01 00 00       	jmp    101204 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  10108b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101092:	8b 00                	mov    (%rax),%eax
  101094:	83 f8 2f             	cmp    $0x2f,%eax
  101097:	77 30                	ja     1010c9 <printer_vprintf+0x5bc>
  101099:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010a0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1010a4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010ab:	8b 00                	mov    (%rax),%eax
  1010ad:	89 c0                	mov    %eax,%eax
  1010af:	48 01 d0             	add    %rdx,%rax
  1010b2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010b9:	8b 12                	mov    (%rdx),%edx
  1010bb:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1010be:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010c5:	89 0a                	mov    %ecx,(%rdx)
  1010c7:	eb 1a                	jmp    1010e3 <printer_vprintf+0x5d6>
  1010c9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010d0:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010d4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1010d8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010df:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1010e3:	48 8b 00             	mov    (%rax),%rax
  1010e6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  1010ea:	e9 15 01 00 00       	jmp    101204 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  1010ef:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010f6:	8b 00                	mov    (%rax),%eax
  1010f8:	83 f8 2f             	cmp    $0x2f,%eax
  1010fb:	77 30                	ja     10112d <printer_vprintf+0x620>
  1010fd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101104:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101108:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10110f:	8b 00                	mov    (%rax),%eax
  101111:	89 c0                	mov    %eax,%eax
  101113:	48 01 d0             	add    %rdx,%rax
  101116:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10111d:	8b 12                	mov    (%rdx),%edx
  10111f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101122:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101129:	89 0a                	mov    %ecx,(%rdx)
  10112b:	eb 1a                	jmp    101147 <printer_vprintf+0x63a>
  10112d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101134:	48 8b 40 08          	mov    0x8(%rax),%rax
  101138:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10113c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101143:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101147:	8b 00                	mov    (%rax),%eax
  101149:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  10114f:	e9 67 03 00 00       	jmp    1014bb <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  101154:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101158:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  10115c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101163:	8b 00                	mov    (%rax),%eax
  101165:	83 f8 2f             	cmp    $0x2f,%eax
  101168:	77 30                	ja     10119a <printer_vprintf+0x68d>
  10116a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101171:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101175:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10117c:	8b 00                	mov    (%rax),%eax
  10117e:	89 c0                	mov    %eax,%eax
  101180:	48 01 d0             	add    %rdx,%rax
  101183:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10118a:	8b 12                	mov    (%rdx),%edx
  10118c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10118f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101196:	89 0a                	mov    %ecx,(%rdx)
  101198:	eb 1a                	jmp    1011b4 <printer_vprintf+0x6a7>
  10119a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011a1:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011a5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1011a9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011b0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1011b4:	8b 00                	mov    (%rax),%eax
  1011b6:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  1011b9:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  1011bd:	eb 45                	jmp    101204 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  1011bf:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1011c3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  1011c7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1011ce:	0f b6 00             	movzbl (%rax),%eax
  1011d1:	84 c0                	test   %al,%al
  1011d3:	74 0c                	je     1011e1 <printer_vprintf+0x6d4>
  1011d5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1011dc:	0f b6 00             	movzbl (%rax),%eax
  1011df:	eb 05                	jmp    1011e6 <printer_vprintf+0x6d9>
  1011e1:	b8 25 00 00 00       	mov    $0x25,%eax
  1011e6:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  1011e9:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  1011ed:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1011f4:	0f b6 00             	movzbl (%rax),%eax
  1011f7:	84 c0                	test   %al,%al
  1011f9:	75 08                	jne    101203 <printer_vprintf+0x6f6>
                format--;
  1011fb:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  101202:	01 
            }
            break;
  101203:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  101204:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101207:	83 e0 20             	and    $0x20,%eax
  10120a:	85 c0                	test   %eax,%eax
  10120c:	74 1e                	je     10122c <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  10120e:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101212:	48 83 c0 18          	add    $0x18,%rax
  101216:	8b 55 e0             	mov    -0x20(%rbp),%edx
  101219:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  10121d:	48 89 ce             	mov    %rcx,%rsi
  101220:	48 89 c7             	mov    %rax,%rdi
  101223:	e8 63 f8 ff ff       	call   100a8b <fill_numbuf>
  101228:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  10122c:	48 c7 45 c0 d6 17 10 	movq   $0x1017d6,-0x40(%rbp)
  101233:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  101234:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101237:	83 e0 20             	and    $0x20,%eax
  10123a:	85 c0                	test   %eax,%eax
  10123c:	74 48                	je     101286 <printer_vprintf+0x779>
  10123e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101241:	83 e0 40             	and    $0x40,%eax
  101244:	85 c0                	test   %eax,%eax
  101246:	74 3e                	je     101286 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  101248:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10124b:	25 80 00 00 00       	and    $0x80,%eax
  101250:	85 c0                	test   %eax,%eax
  101252:	74 0a                	je     10125e <printer_vprintf+0x751>
                prefix = "-";
  101254:	48 c7 45 c0 d7 17 10 	movq   $0x1017d7,-0x40(%rbp)
  10125b:	00 
            if (flags & FLAG_NEGATIVE) {
  10125c:	eb 73                	jmp    1012d1 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  10125e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101261:	83 e0 10             	and    $0x10,%eax
  101264:	85 c0                	test   %eax,%eax
  101266:	74 0a                	je     101272 <printer_vprintf+0x765>
                prefix = "+";
  101268:	48 c7 45 c0 d9 17 10 	movq   $0x1017d9,-0x40(%rbp)
  10126f:	00 
            if (flags & FLAG_NEGATIVE) {
  101270:	eb 5f                	jmp    1012d1 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  101272:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101275:	83 e0 08             	and    $0x8,%eax
  101278:	85 c0                	test   %eax,%eax
  10127a:	74 55                	je     1012d1 <printer_vprintf+0x7c4>
                prefix = " ";
  10127c:	48 c7 45 c0 db 17 10 	movq   $0x1017db,-0x40(%rbp)
  101283:	00 
            if (flags & FLAG_NEGATIVE) {
  101284:	eb 4b                	jmp    1012d1 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  101286:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101289:	83 e0 20             	and    $0x20,%eax
  10128c:	85 c0                	test   %eax,%eax
  10128e:	74 42                	je     1012d2 <printer_vprintf+0x7c5>
  101290:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101293:	83 e0 01             	and    $0x1,%eax
  101296:	85 c0                	test   %eax,%eax
  101298:	74 38                	je     1012d2 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  10129a:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  10129e:	74 06                	je     1012a6 <printer_vprintf+0x799>
  1012a0:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1012a4:	75 2c                	jne    1012d2 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  1012a6:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1012ab:	75 0c                	jne    1012b9 <printer_vprintf+0x7ac>
  1012ad:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1012b0:	25 00 01 00 00       	and    $0x100,%eax
  1012b5:	85 c0                	test   %eax,%eax
  1012b7:	74 19                	je     1012d2 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  1012b9:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1012bd:	75 07                	jne    1012c6 <printer_vprintf+0x7b9>
  1012bf:	b8 dd 17 10 00       	mov    $0x1017dd,%eax
  1012c4:	eb 05                	jmp    1012cb <printer_vprintf+0x7be>
  1012c6:	b8 e0 17 10 00       	mov    $0x1017e0,%eax
  1012cb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1012cf:	eb 01                	jmp    1012d2 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  1012d1:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  1012d2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1012d6:	78 24                	js     1012fc <printer_vprintf+0x7ef>
  1012d8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1012db:	83 e0 20             	and    $0x20,%eax
  1012de:	85 c0                	test   %eax,%eax
  1012e0:	75 1a                	jne    1012fc <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  1012e2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1012e5:	48 63 d0             	movslq %eax,%rdx
  1012e8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1012ec:	48 89 d6             	mov    %rdx,%rsi
  1012ef:	48 89 c7             	mov    %rax,%rdi
  1012f2:	e8 ea f5 ff ff       	call   1008e1 <strnlen>
  1012f7:	89 45 bc             	mov    %eax,-0x44(%rbp)
  1012fa:	eb 0f                	jmp    10130b <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  1012fc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101300:	48 89 c7             	mov    %rax,%rdi
  101303:	e8 a8 f5 ff ff       	call   1008b0 <strlen>
  101308:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  10130b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10130e:	83 e0 20             	and    $0x20,%eax
  101311:	85 c0                	test   %eax,%eax
  101313:	74 20                	je     101335 <printer_vprintf+0x828>
  101315:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101319:	78 1a                	js     101335 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  10131b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10131e:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  101321:	7e 08                	jle    10132b <printer_vprintf+0x81e>
  101323:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101326:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101329:	eb 05                	jmp    101330 <printer_vprintf+0x823>
  10132b:	b8 00 00 00 00       	mov    $0x0,%eax
  101330:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101333:	eb 5c                	jmp    101391 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  101335:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101338:	83 e0 20             	and    $0x20,%eax
  10133b:	85 c0                	test   %eax,%eax
  10133d:	74 4b                	je     10138a <printer_vprintf+0x87d>
  10133f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101342:	83 e0 02             	and    $0x2,%eax
  101345:	85 c0                	test   %eax,%eax
  101347:	74 41                	je     10138a <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  101349:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10134c:	83 e0 04             	and    $0x4,%eax
  10134f:	85 c0                	test   %eax,%eax
  101351:	75 37                	jne    10138a <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  101353:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101357:	48 89 c7             	mov    %rax,%rdi
  10135a:	e8 51 f5 ff ff       	call   1008b0 <strlen>
  10135f:	89 c2                	mov    %eax,%edx
  101361:	8b 45 bc             	mov    -0x44(%rbp),%eax
  101364:	01 d0                	add    %edx,%eax
  101366:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  101369:	7e 1f                	jle    10138a <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  10136b:	8b 45 e8             	mov    -0x18(%rbp),%eax
  10136e:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101371:	89 c3                	mov    %eax,%ebx
  101373:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101377:	48 89 c7             	mov    %rax,%rdi
  10137a:	e8 31 f5 ff ff       	call   1008b0 <strlen>
  10137f:	89 c2                	mov    %eax,%edx
  101381:	89 d8                	mov    %ebx,%eax
  101383:	29 d0                	sub    %edx,%eax
  101385:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101388:	eb 07                	jmp    101391 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  10138a:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  101391:	8b 55 bc             	mov    -0x44(%rbp),%edx
  101394:	8b 45 b8             	mov    -0x48(%rbp),%eax
  101397:	01 d0                	add    %edx,%eax
  101399:	48 63 d8             	movslq %eax,%rbx
  10139c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1013a0:	48 89 c7             	mov    %rax,%rdi
  1013a3:	e8 08 f5 ff ff       	call   1008b0 <strlen>
  1013a8:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  1013ac:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1013af:	29 d0                	sub    %edx,%eax
  1013b1:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1013b4:	eb 25                	jmp    1013db <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  1013b6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1013bd:	48 8b 08             	mov    (%rax),%rcx
  1013c0:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1013c6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1013cd:	be 20 00 00 00       	mov    $0x20,%esi
  1013d2:	48 89 c7             	mov    %rax,%rdi
  1013d5:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1013d7:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1013db:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1013de:	83 e0 04             	and    $0x4,%eax
  1013e1:	85 c0                	test   %eax,%eax
  1013e3:	75 36                	jne    10141b <printer_vprintf+0x90e>
  1013e5:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1013e9:	7f cb                	jg     1013b6 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  1013eb:	eb 2e                	jmp    10141b <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  1013ed:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1013f4:	4c 8b 00             	mov    (%rax),%r8
  1013f7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1013fb:	0f b6 00             	movzbl (%rax),%eax
  1013fe:	0f b6 c8             	movzbl %al,%ecx
  101401:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101407:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10140e:	89 ce                	mov    %ecx,%esi
  101410:	48 89 c7             	mov    %rax,%rdi
  101413:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  101416:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  10141b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10141f:	0f b6 00             	movzbl (%rax),%eax
  101422:	84 c0                	test   %al,%al
  101424:	75 c7                	jne    1013ed <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  101426:	eb 25                	jmp    10144d <printer_vprintf+0x940>
            p->putc(p, '0', color);
  101428:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10142f:	48 8b 08             	mov    (%rax),%rcx
  101432:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101438:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10143f:	be 30 00 00 00       	mov    $0x30,%esi
  101444:	48 89 c7             	mov    %rax,%rdi
  101447:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  101449:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  10144d:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  101451:	7f d5                	jg     101428 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  101453:	eb 32                	jmp    101487 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  101455:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10145c:	4c 8b 00             	mov    (%rax),%r8
  10145f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101463:	0f b6 00             	movzbl (%rax),%eax
  101466:	0f b6 c8             	movzbl %al,%ecx
  101469:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10146f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101476:	89 ce                	mov    %ecx,%esi
  101478:	48 89 c7             	mov    %rax,%rdi
  10147b:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  10147e:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  101483:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  101487:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  10148b:	7f c8                	jg     101455 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  10148d:	eb 25                	jmp    1014b4 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  10148f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101496:	48 8b 08             	mov    (%rax),%rcx
  101499:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10149f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1014a6:	be 20 00 00 00       	mov    $0x20,%esi
  1014ab:	48 89 c7             	mov    %rax,%rdi
  1014ae:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  1014b0:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1014b4:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1014b8:	7f d5                	jg     10148f <printer_vprintf+0x982>
        }
    done: ;
  1014ba:	90                   	nop
    for (; *format; ++format) {
  1014bb:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1014c2:	01 
  1014c3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1014ca:	0f b6 00             	movzbl (%rax),%eax
  1014cd:	84 c0                	test   %al,%al
  1014cf:	0f 85 64 f6 ff ff    	jne    100b39 <printer_vprintf+0x2c>
    }
}
  1014d5:	90                   	nop
  1014d6:	90                   	nop
  1014d7:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1014db:	c9                   	leave  
  1014dc:	c3                   	ret    

00000000001014dd <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1014dd:	55                   	push   %rbp
  1014de:	48 89 e5             	mov    %rsp,%rbp
  1014e1:	48 83 ec 20          	sub    $0x20,%rsp
  1014e5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1014e9:	89 f0                	mov    %esi,%eax
  1014eb:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1014ee:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  1014f1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1014f5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1014f9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1014fd:	48 8b 40 08          	mov    0x8(%rax),%rax
  101501:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  101506:	48 39 d0             	cmp    %rdx,%rax
  101509:	72 0c                	jb     101517 <console_putc+0x3a>
        cp->cursor = console;
  10150b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10150f:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  101516:	00 
    }
    if (c == '\n') {
  101517:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  10151b:	75 78                	jne    101595 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  10151d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101521:	48 8b 40 08          	mov    0x8(%rax),%rax
  101525:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  10152b:	48 d1 f8             	sar    %rax
  10152e:	48 89 c1             	mov    %rax,%rcx
  101531:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  101538:	66 66 66 
  10153b:	48 89 c8             	mov    %rcx,%rax
  10153e:	48 f7 ea             	imul   %rdx
  101541:	48 c1 fa 05          	sar    $0x5,%rdx
  101545:	48 89 c8             	mov    %rcx,%rax
  101548:	48 c1 f8 3f          	sar    $0x3f,%rax
  10154c:	48 29 c2             	sub    %rax,%rdx
  10154f:	48 89 d0             	mov    %rdx,%rax
  101552:	48 c1 e0 02          	shl    $0x2,%rax
  101556:	48 01 d0             	add    %rdx,%rax
  101559:	48 c1 e0 04          	shl    $0x4,%rax
  10155d:	48 29 c1             	sub    %rax,%rcx
  101560:	48 89 ca             	mov    %rcx,%rdx
  101563:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101566:	eb 25                	jmp    10158d <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  101568:	8b 45 e0             	mov    -0x20(%rbp),%eax
  10156b:	83 c8 20             	or     $0x20,%eax
  10156e:	89 c6                	mov    %eax,%esi
  101570:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101574:	48 8b 40 08          	mov    0x8(%rax),%rax
  101578:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10157c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101580:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101584:	89 f2                	mov    %esi,%edx
  101586:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  101589:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10158d:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101591:	75 d5                	jne    101568 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101593:	eb 24                	jmp    1015b9 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  101595:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  101599:	8b 55 e0             	mov    -0x20(%rbp),%edx
  10159c:	09 d0                	or     %edx,%eax
  10159e:	89 c6                	mov    %eax,%esi
  1015a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1015a4:	48 8b 40 08          	mov    0x8(%rax),%rax
  1015a8:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1015ac:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1015b0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1015b4:	89 f2                	mov    %esi,%edx
  1015b6:	66 89 10             	mov    %dx,(%rax)
}
  1015b9:	90                   	nop
  1015ba:	c9                   	leave  
  1015bb:	c3                   	ret    

00000000001015bc <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1015bc:	55                   	push   %rbp
  1015bd:	48 89 e5             	mov    %rsp,%rbp
  1015c0:	48 83 ec 30          	sub    $0x30,%rsp
  1015c4:	89 7d ec             	mov    %edi,-0x14(%rbp)
  1015c7:	89 75 e8             	mov    %esi,-0x18(%rbp)
  1015ca:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1015ce:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  1015d2:	48 c7 45 f0 dd 14 10 	movq   $0x1014dd,-0x10(%rbp)
  1015d9:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1015da:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  1015de:	78 09                	js     1015e9 <console_vprintf+0x2d>
  1015e0:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  1015e7:	7e 07                	jle    1015f0 <console_vprintf+0x34>
        cpos = 0;
  1015e9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  1015f0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015f3:	48 98                	cltq   
  1015f5:	48 01 c0             	add    %rax,%rax
  1015f8:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  1015fe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101602:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101606:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  10160a:	8b 75 e8             	mov    -0x18(%rbp),%esi
  10160d:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101611:	48 89 c7             	mov    %rax,%rdi
  101614:	e8 f4 f4 ff ff       	call   100b0d <printer_vprintf>
    return cp.cursor - console;
  101619:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10161d:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  101623:	48 d1 f8             	sar    %rax
}
  101626:	c9                   	leave  
  101627:	c3                   	ret    

0000000000101628 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  101628:	55                   	push   %rbp
  101629:	48 89 e5             	mov    %rsp,%rbp
  10162c:	48 83 ec 60          	sub    $0x60,%rsp
  101630:	89 7d ac             	mov    %edi,-0x54(%rbp)
  101633:	89 75 a8             	mov    %esi,-0x58(%rbp)
  101636:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  10163a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10163e:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101642:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101646:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  10164d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101651:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101655:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101659:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  10165d:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101661:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101665:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101668:	8b 45 ac             	mov    -0x54(%rbp),%eax
  10166b:	89 c7                	mov    %eax,%edi
  10166d:	e8 4a ff ff ff       	call   1015bc <console_vprintf>
  101672:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101675:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101678:	c9                   	leave  
  101679:	c3                   	ret    

000000000010167a <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  10167a:	55                   	push   %rbp
  10167b:	48 89 e5             	mov    %rsp,%rbp
  10167e:	48 83 ec 20          	sub    $0x20,%rsp
  101682:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101686:	89 f0                	mov    %esi,%eax
  101688:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10168b:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  10168e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101692:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101696:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10169a:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10169e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1016a2:	48 8b 40 10          	mov    0x10(%rax),%rax
  1016a6:	48 39 c2             	cmp    %rax,%rdx
  1016a9:	73 1a                	jae    1016c5 <string_putc+0x4b>
        *sp->s++ = c;
  1016ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1016af:	48 8b 40 08          	mov    0x8(%rax),%rax
  1016b3:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1016b7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1016bb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1016bf:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1016c3:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1016c5:	90                   	nop
  1016c6:	c9                   	leave  
  1016c7:	c3                   	ret    

00000000001016c8 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1016c8:	55                   	push   %rbp
  1016c9:	48 89 e5             	mov    %rsp,%rbp
  1016cc:	48 83 ec 40          	sub    $0x40,%rsp
  1016d0:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  1016d4:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  1016d8:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  1016dc:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1016e0:	48 c7 45 e8 7a 16 10 	movq   $0x10167a,-0x18(%rbp)
  1016e7:	00 
    sp.s = s;
  1016e8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1016ec:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1016f0:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1016f5:	74 33                	je     10172a <vsnprintf+0x62>
        sp.end = s + size - 1;
  1016f7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1016fb:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1016ff:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101703:	48 01 d0             	add    %rdx,%rax
  101706:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  10170a:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  10170e:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101712:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101716:	be 00 00 00 00       	mov    $0x0,%esi
  10171b:	48 89 c7             	mov    %rax,%rdi
  10171e:	e8 ea f3 ff ff       	call   100b0d <printer_vprintf>
        *sp.s = 0;
  101723:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101727:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  10172a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10172e:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  101732:	c9                   	leave  
  101733:	c3                   	ret    

0000000000101734 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  101734:	55                   	push   %rbp
  101735:	48 89 e5             	mov    %rsp,%rbp
  101738:	48 83 ec 70          	sub    $0x70,%rsp
  10173c:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101740:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  101744:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101748:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10174c:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101750:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101754:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  10175b:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10175f:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101763:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101767:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  10176b:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  10176f:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101773:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101777:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10177b:	48 89 c7             	mov    %rax,%rdi
  10177e:	e8 45 ff ff ff       	call   1016c8 <vsnprintf>
  101783:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101786:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101789:	c9                   	leave  
  10178a:	c3                   	ret    

000000000010178b <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  10178b:	55                   	push   %rbp
  10178c:	48 89 e5             	mov    %rsp,%rbp
  10178f:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101793:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  10179a:	eb 13                	jmp    1017af <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  10179c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10179f:	48 98                	cltq   
  1017a1:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  1017a8:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1017ab:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1017af:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1017b6:	7e e4                	jle    10179c <console_clear+0x11>
    }
    cursorpos = 0;
  1017b8:	c7 05 3a 78 fb ff 00 	movl   $0x0,-0x487c6(%rip)        # b8ffc <cursorpos>
  1017bf:	00 00 00 
}
  1017c2:	90                   	nop
  1017c3:	c9                   	leave  
  1017c4:	c3                   	ret    
