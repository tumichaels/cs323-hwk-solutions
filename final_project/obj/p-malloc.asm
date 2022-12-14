
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
  100037:	e8 fd 03 00 00       	call   100439 <rand>
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
  10005f:	e8 bc 00 00 00       	call   100120 <malloc>
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
	first_block_payload = sbrk(sizeof(block_footer));
  100088:	48 89 05 89 1f 00 00 	mov    %rax,0x1f89(%rip)        # 102018 <first_block_payload>

	GET_SIZE(HDRP(first_block_payload)) = sizeof(block_header) + sizeof(block_footer);
  10008f:	48 c7 40 f0 20 00 00 	movq   $0x20,-0x10(%rax)
  100096:	00 
	GET_ALLOC(HDRP(first_block_payload)) = 1;
  100097:	48 8b 05 7a 1f 00 00 	mov    0x1f7a(%rip),%rax        # 102018 <first_block_payload>
  10009e:	c7 40 f8 01 00 00 00 	movl   $0x1,-0x8(%rax)
	GET_SIZE(FTRP(first_block_payload)) = sizeof(block_header) + sizeof(block_footer);
  1000a5:	48 8b 05 6c 1f 00 00 	mov    0x1f6c(%rip),%rax        # 102018 <first_block_payload>
  1000ac:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  1000b0:	48 c7 44 10 e0 20 00 	movq   $0x20,-0x20(%rax,%rdx,1)
  1000b7:	00 00 
  1000b9:	cd 3a                	int    $0x3a
  1000bb:	48 89 05 66 1f 00 00 	mov    %rax,0x1f66(%rip)        # 102028 <result.0>

	// terminal block
	sbrk(sizeof(block_header));
	GET_SIZE(HDRP(NEXT_BLKP(first_block_payload))) = 0;
  1000c2:	48 8b 05 4f 1f 00 00 	mov    0x1f4f(%rip),%rax        # 102018 <first_block_payload>
  1000c9:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  1000cd:	48 c7 44 10 f0 00 00 	movq   $0x0,-0x10(%rax,%rdx,1)
  1000d4:	00 00 
	GET_ALLOC(HDRP(NEXT_BLKP(first_block_payload))) = 1;
  1000d6:	48 8b 05 3b 1f 00 00 	mov    0x1f3b(%rip),%rax        # 102018 <first_block_payload>
  1000dd:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  1000e1:	c7 44 10 f8 01 00 00 	movl   $0x1,-0x8(%rax,%rdx,1)
  1000e8:	00 

	initialized_heap = 1;
  1000e9:	c7 05 2d 1f 00 00 01 	movl   $0x1,0x1f2d(%rip)        # 102020 <initialized_heap>
  1000f0:	00 00 00 
}
  1000f3:	c3                   	ret    

00000000001000f4 <free>:

void free(void *firstbyte) {
	return;
}
  1000f4:	c3                   	ret    

00000000001000f5 <extend>:

// extend is called when you don't have a free block big enough
//	we call extend inside malloc, so it should only ever be
//	called with new_size >= MIN_PAYLOAD_SIZE 
void extend(size_t new_size) {
}
  1000f5:	c3                   	ret    

00000000001000f6 <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  1000f6:	48 8b 47 f0          	mov    -0x10(%rdi),%rax
  1000fa:	48 29 f0             	sub    %rsi,%rax

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  1000fd:	48 83 f8 30          	cmp    $0x30,%rax
  100101:	76 15                	jbe    100118 <set_allocated+0x22>
		GET_SIZE(HDRP(bp)) = size;
  100103:	48 89 77 f0          	mov    %rsi,-0x10(%rdi)
		GET_SIZE(HDRP(NEXT_BLKP(bp))) = extra_size;
  100107:	48 89 44 37 f0       	mov    %rax,-0x10(%rdi,%rsi,1)
		GET_ALLOC(HDRP(NEXT_BLKP(bp))) = 0;
  10010c:	48 8b 47 f0          	mov    -0x10(%rdi),%rax
  100110:	c7 44 07 f8 00 00 00 	movl   $0x0,-0x8(%rdi,%rax,1)
  100117:	00 
		// NEXT_FPTR(NEXT_BLKP(bp)) = NEXT_FPTR(bp);
		// PREV_FPTR(NEXT_BLKP(bp)) = PREV_FPTR(bp);
		// GET_SIZE(FTRP(NEXT_BLKP(bp))) = extra_size;
	}

	GET_ALLOC(HDRP(bp)) = 1;
  100118:	c7 47 f8 01 00 00 00 	movl   $0x1,-0x8(%rdi)
}
  10011f:	c3                   	ret    

0000000000100120 <malloc>:

void *malloc(uint64_t numbytes) {
  100120:	55                   	push   %rbp
  100121:	48 89 e5             	mov    %rsp,%rbp
  100124:	53                   	push   %rbx
  100125:	48 83 ec 08          	sub    $0x8,%rsp
  100129:	48 89 fb             	mov    %rdi,%rbx
	if (!initialized_heap)
  10012c:	83 3d ed 1e 00 00 00 	cmpl   $0x0,0x1eed(%rip)        # 102020 <initialized_heap>
  100133:	74 28                	je     10015d <malloc+0x3d>
		heap_init();

	if (numbytes == 0)
  100135:	48 85 db             	test   %rbx,%rbx
  100138:	74 2a                	je     100164 <malloc+0x44>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  10013a:	48 8d 7b 1f          	lea    0x1f(%rbx),%rdi
  10013e:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
  100142:	b8 30 00 00 00       	mov    $0x30,%eax
  100147:	48 39 c7             	cmp    %rax,%rdi
  10014a:	48 0f 42 f8          	cmovb  %rax,%rdi
  10014e:	cd 3a                	int    $0x3a
  100150:	48 89 05 d1 1e 00 00 	mov    %rax,0x1ed1(%rip)        # 102028 <result.0>
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);

	void *bp = sbrk(aligned_size);
    return bp;
}
  100157:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  10015b:	c9                   	leave  
  10015c:	c3                   	ret    
		heap_init();
  10015d:	e8 0f ff ff ff       	call   100071 <heap_init>
  100162:	eb d1                	jmp    100135 <malloc+0x15>
		return NULL;
  100164:	b8 00 00 00 00       	mov    $0x0,%eax
  100169:	eb ec                	jmp    100157 <malloc+0x37>

000000000010016b <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
    return 0;
}
  10016b:	b8 00 00 00 00       	mov    $0x0,%eax
  100170:	c3                   	ret    

0000000000100171 <realloc>:

void *realloc(void * ptr, uint64_t sz) {
    return 0;
}
  100171:	b8 00 00 00 00       	mov    $0x0,%eax
  100176:	c3                   	ret    

0000000000100177 <defrag>:

void defrag() {
}
  100177:	c3                   	ret    

0000000000100178 <heap_info>:

int heap_info(heap_info_struct * info) {
    return 0;
}
  100178:	b8 00 00 00 00       	mov    $0x0,%eax
  10017d:	c3                   	ret    

000000000010017e <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  10017e:	55                   	push   %rbp
  10017f:	48 89 e5             	mov    %rsp,%rbp
  100182:	48 83 ec 28          	sub    $0x28,%rsp
  100186:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10018a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10018e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100192:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100196:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  10019a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10019e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  1001a2:	eb 1c                	jmp    1001c0 <memcpy+0x42>
        *d = *s;
  1001a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1001a8:	0f b6 10             	movzbl (%rax),%edx
  1001ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1001af:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1001b1:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1001b6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1001bb:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1001c0:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1001c5:	75 dd                	jne    1001a4 <memcpy+0x26>
    }
    return dst;
  1001c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1001cb:	c9                   	leave  
  1001cc:	c3                   	ret    

00000000001001cd <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1001cd:	55                   	push   %rbp
  1001ce:	48 89 e5             	mov    %rsp,%rbp
  1001d1:	48 83 ec 28          	sub    $0x28,%rsp
  1001d5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1001d9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1001dd:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1001e1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1001e5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  1001e9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1001ed:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  1001f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1001f5:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  1001f9:	73 6a                	jae    100265 <memmove+0x98>
  1001fb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1001ff:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100203:	48 01 d0             	add    %rdx,%rax
  100206:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  10020a:	73 59                	jae    100265 <memmove+0x98>
        s += n, d += n;
  10020c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100210:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100214:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100218:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  10021c:	eb 17                	jmp    100235 <memmove+0x68>
            *--d = *--s;
  10021e:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100223:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100228:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10022c:	0f b6 10             	movzbl (%rax),%edx
  10022f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100233:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100235:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100239:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10023d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100241:	48 85 c0             	test   %rax,%rax
  100244:	75 d8                	jne    10021e <memmove+0x51>
    if (s < d && s + n > d) {
  100246:	eb 2e                	jmp    100276 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100248:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10024c:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100250:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100254:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100258:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10025c:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100260:	0f b6 12             	movzbl (%rdx),%edx
  100263:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100265:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100269:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10026d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100271:	48 85 c0             	test   %rax,%rax
  100274:	75 d2                	jne    100248 <memmove+0x7b>
        }
    }
    return dst;
  100276:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10027a:	c9                   	leave  
  10027b:	c3                   	ret    

000000000010027c <memset>:

void* memset(void* v, int c, size_t n) {
  10027c:	55                   	push   %rbp
  10027d:	48 89 e5             	mov    %rsp,%rbp
  100280:	48 83 ec 28          	sub    $0x28,%rsp
  100284:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100288:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  10028b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10028f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100293:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100297:	eb 15                	jmp    1002ae <memset+0x32>
        *p = c;
  100299:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10029c:	89 c2                	mov    %eax,%edx
  10029e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002a2:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1002a4:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1002a9:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1002ae:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1002b3:	75 e4                	jne    100299 <memset+0x1d>
    }
    return v;
  1002b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1002b9:	c9                   	leave  
  1002ba:	c3                   	ret    

00000000001002bb <strlen>:

size_t strlen(const char* s) {
  1002bb:	55                   	push   %rbp
  1002bc:	48 89 e5             	mov    %rsp,%rbp
  1002bf:	48 83 ec 18          	sub    $0x18,%rsp
  1002c3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  1002c7:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1002ce:	00 
  1002cf:	eb 0a                	jmp    1002db <strlen+0x20>
        ++n;
  1002d1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  1002d6:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1002db:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1002df:	0f b6 00             	movzbl (%rax),%eax
  1002e2:	84 c0                	test   %al,%al
  1002e4:	75 eb                	jne    1002d1 <strlen+0x16>
    }
    return n;
  1002e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1002ea:	c9                   	leave  
  1002eb:	c3                   	ret    

00000000001002ec <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  1002ec:	55                   	push   %rbp
  1002ed:	48 89 e5             	mov    %rsp,%rbp
  1002f0:	48 83 ec 20          	sub    $0x20,%rsp
  1002f4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1002f8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1002fc:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100303:	00 
  100304:	eb 0a                	jmp    100310 <strnlen+0x24>
        ++n;
  100306:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  10030b:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100310:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100314:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100318:	74 0b                	je     100325 <strnlen+0x39>
  10031a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10031e:	0f b6 00             	movzbl (%rax),%eax
  100321:	84 c0                	test   %al,%al
  100323:	75 e1                	jne    100306 <strnlen+0x1a>
    }
    return n;
  100325:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100329:	c9                   	leave  
  10032a:	c3                   	ret    

000000000010032b <strcpy>:

char* strcpy(char* dst, const char* src) {
  10032b:	55                   	push   %rbp
  10032c:	48 89 e5             	mov    %rsp,%rbp
  10032f:	48 83 ec 20          	sub    $0x20,%rsp
  100333:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100337:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  10033b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10033f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100343:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100347:	48 8d 42 01          	lea    0x1(%rdx),%rax
  10034b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  10034f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100353:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100357:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  10035b:	0f b6 12             	movzbl (%rdx),%edx
  10035e:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100360:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100364:	48 83 e8 01          	sub    $0x1,%rax
  100368:	0f b6 00             	movzbl (%rax),%eax
  10036b:	84 c0                	test   %al,%al
  10036d:	75 d4                	jne    100343 <strcpy+0x18>
    return dst;
  10036f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100373:	c9                   	leave  
  100374:	c3                   	ret    

0000000000100375 <strcmp>:

int strcmp(const char* a, const char* b) {
  100375:	55                   	push   %rbp
  100376:	48 89 e5             	mov    %rsp,%rbp
  100379:	48 83 ec 10          	sub    $0x10,%rsp
  10037d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100381:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100385:	eb 0a                	jmp    100391 <strcmp+0x1c>
        ++a, ++b;
  100387:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10038c:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100391:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100395:	0f b6 00             	movzbl (%rax),%eax
  100398:	84 c0                	test   %al,%al
  10039a:	74 1d                	je     1003b9 <strcmp+0x44>
  10039c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003a0:	0f b6 00             	movzbl (%rax),%eax
  1003a3:	84 c0                	test   %al,%al
  1003a5:	74 12                	je     1003b9 <strcmp+0x44>
  1003a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003ab:	0f b6 10             	movzbl (%rax),%edx
  1003ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003b2:	0f b6 00             	movzbl (%rax),%eax
  1003b5:	38 c2                	cmp    %al,%dl
  1003b7:	74 ce                	je     100387 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  1003b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003bd:	0f b6 00             	movzbl (%rax),%eax
  1003c0:	89 c2                	mov    %eax,%edx
  1003c2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003c6:	0f b6 00             	movzbl (%rax),%eax
  1003c9:	38 d0                	cmp    %dl,%al
  1003cb:	0f 92 c0             	setb   %al
  1003ce:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  1003d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003d5:	0f b6 00             	movzbl (%rax),%eax
  1003d8:	89 c1                	mov    %eax,%ecx
  1003da:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003de:	0f b6 00             	movzbl (%rax),%eax
  1003e1:	38 c1                	cmp    %al,%cl
  1003e3:	0f 92 c0             	setb   %al
  1003e6:	0f b6 c0             	movzbl %al,%eax
  1003e9:	29 c2                	sub    %eax,%edx
  1003eb:	89 d0                	mov    %edx,%eax
}
  1003ed:	c9                   	leave  
  1003ee:	c3                   	ret    

00000000001003ef <strchr>:

char* strchr(const char* s, int c) {
  1003ef:	55                   	push   %rbp
  1003f0:	48 89 e5             	mov    %rsp,%rbp
  1003f3:	48 83 ec 10          	sub    $0x10,%rsp
  1003f7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1003fb:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1003fe:	eb 05                	jmp    100405 <strchr+0x16>
        ++s;
  100400:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100405:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100409:	0f b6 00             	movzbl (%rax),%eax
  10040c:	84 c0                	test   %al,%al
  10040e:	74 0e                	je     10041e <strchr+0x2f>
  100410:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100414:	0f b6 00             	movzbl (%rax),%eax
  100417:	8b 55 f4             	mov    -0xc(%rbp),%edx
  10041a:	38 d0                	cmp    %dl,%al
  10041c:	75 e2                	jne    100400 <strchr+0x11>
    }
    if (*s == (char) c) {
  10041e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100422:	0f b6 00             	movzbl (%rax),%eax
  100425:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100428:	38 d0                	cmp    %dl,%al
  10042a:	75 06                	jne    100432 <strchr+0x43>
        return (char*) s;
  10042c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100430:	eb 05                	jmp    100437 <strchr+0x48>
    } else {
        return NULL;
  100432:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100437:	c9                   	leave  
  100438:	c3                   	ret    

0000000000100439 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100439:	55                   	push   %rbp
  10043a:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  10043d:	8b 05 ed 1b 00 00    	mov    0x1bed(%rip),%eax        # 102030 <rand_seed_set>
  100443:	85 c0                	test   %eax,%eax
  100445:	75 0a                	jne    100451 <rand+0x18>
        srand(819234718U);
  100447:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  10044c:	e8 24 00 00 00       	call   100475 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100451:	8b 05 dd 1b 00 00    	mov    0x1bdd(%rip),%eax        # 102034 <rand_seed>
  100457:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  10045d:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100462:	89 05 cc 1b 00 00    	mov    %eax,0x1bcc(%rip)        # 102034 <rand_seed>
    return rand_seed & RAND_MAX;
  100468:	8b 05 c6 1b 00 00    	mov    0x1bc6(%rip),%eax        # 102034 <rand_seed>
  10046e:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100473:	5d                   	pop    %rbp
  100474:	c3                   	ret    

0000000000100475 <srand>:

void srand(unsigned seed) {
  100475:	55                   	push   %rbp
  100476:	48 89 e5             	mov    %rsp,%rbp
  100479:	48 83 ec 08          	sub    $0x8,%rsp
  10047d:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100480:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100483:	89 05 ab 1b 00 00    	mov    %eax,0x1bab(%rip)        # 102034 <rand_seed>
    rand_seed_set = 1;
  100489:	c7 05 9d 1b 00 00 01 	movl   $0x1,0x1b9d(%rip)        # 102030 <rand_seed_set>
  100490:	00 00 00 
}
  100493:	90                   	nop
  100494:	c9                   	leave  
  100495:	c3                   	ret    

0000000000100496 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100496:	55                   	push   %rbp
  100497:	48 89 e5             	mov    %rsp,%rbp
  10049a:	48 83 ec 28          	sub    $0x28,%rsp
  10049e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1004a2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1004a6:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  1004a9:	48 c7 45 f8 b0 13 10 	movq   $0x1013b0,-0x8(%rbp)
  1004b0:	00 
    if (base < 0) {
  1004b1:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  1004b5:	79 0b                	jns    1004c2 <fill_numbuf+0x2c>
        digits = lower_digits;
  1004b7:	48 c7 45 f8 d0 13 10 	movq   $0x1013d0,-0x8(%rbp)
  1004be:	00 
        base = -base;
  1004bf:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  1004c2:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1004c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1004cb:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  1004ce:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1004d1:	48 63 c8             	movslq %eax,%rcx
  1004d4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1004d8:	ba 00 00 00 00       	mov    $0x0,%edx
  1004dd:	48 f7 f1             	div    %rcx
  1004e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004e4:	48 01 d0             	add    %rdx,%rax
  1004e7:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1004ec:	0f b6 10             	movzbl (%rax),%edx
  1004ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1004f3:	88 10                	mov    %dl,(%rax)
        val /= base;
  1004f5:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1004f8:	48 63 f0             	movslq %eax,%rsi
  1004fb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1004ff:	ba 00 00 00 00       	mov    $0x0,%edx
  100504:	48 f7 f6             	div    %rsi
  100507:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  10050b:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100510:	75 bc                	jne    1004ce <fill_numbuf+0x38>
    return numbuf_end;
  100512:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100516:	c9                   	leave  
  100517:	c3                   	ret    

0000000000100518 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100518:	55                   	push   %rbp
  100519:	48 89 e5             	mov    %rsp,%rbp
  10051c:	53                   	push   %rbx
  10051d:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100524:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  10052b:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100531:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100538:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  10053f:	e9 8a 09 00 00       	jmp    100ece <printer_vprintf+0x9b6>
        if (*format != '%') {
  100544:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10054b:	0f b6 00             	movzbl (%rax),%eax
  10054e:	3c 25                	cmp    $0x25,%al
  100550:	74 31                	je     100583 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  100552:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100559:	4c 8b 00             	mov    (%rax),%r8
  10055c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100563:	0f b6 00             	movzbl (%rax),%eax
  100566:	0f b6 c8             	movzbl %al,%ecx
  100569:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10056f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100576:	89 ce                	mov    %ecx,%esi
  100578:	48 89 c7             	mov    %rax,%rdi
  10057b:	41 ff d0             	call   *%r8
            continue;
  10057e:	e9 43 09 00 00       	jmp    100ec6 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100583:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  10058a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100591:	01 
  100592:	eb 44                	jmp    1005d8 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  100594:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10059b:	0f b6 00             	movzbl (%rax),%eax
  10059e:	0f be c0             	movsbl %al,%eax
  1005a1:	89 c6                	mov    %eax,%esi
  1005a3:	bf d0 11 10 00       	mov    $0x1011d0,%edi
  1005a8:	e8 42 fe ff ff       	call   1003ef <strchr>
  1005ad:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  1005b1:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  1005b6:	74 30                	je     1005e8 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  1005b8:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  1005bc:	48 2d d0 11 10 00    	sub    $0x1011d0,%rax
  1005c2:	ba 01 00 00 00       	mov    $0x1,%edx
  1005c7:	89 c1                	mov    %eax,%ecx
  1005c9:	d3 e2                	shl    %cl,%edx
  1005cb:	89 d0                	mov    %edx,%eax
  1005cd:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  1005d0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1005d7:	01 
  1005d8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1005df:	0f b6 00             	movzbl (%rax),%eax
  1005e2:	84 c0                	test   %al,%al
  1005e4:	75 ae                	jne    100594 <printer_vprintf+0x7c>
  1005e6:	eb 01                	jmp    1005e9 <printer_vprintf+0xd1>
            } else {
                break;
  1005e8:	90                   	nop
            }
        }

        // process width
        int width = -1;
  1005e9:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  1005f0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1005f7:	0f b6 00             	movzbl (%rax),%eax
  1005fa:	3c 30                	cmp    $0x30,%al
  1005fc:	7e 67                	jle    100665 <printer_vprintf+0x14d>
  1005fe:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100605:	0f b6 00             	movzbl (%rax),%eax
  100608:	3c 39                	cmp    $0x39,%al
  10060a:	7f 59                	jg     100665 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10060c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100613:	eb 2e                	jmp    100643 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100615:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100618:	89 d0                	mov    %edx,%eax
  10061a:	c1 e0 02             	shl    $0x2,%eax
  10061d:	01 d0                	add    %edx,%eax
  10061f:	01 c0                	add    %eax,%eax
  100621:	89 c1                	mov    %eax,%ecx
  100623:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10062a:	48 8d 50 01          	lea    0x1(%rax),%rdx
  10062e:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100635:	0f b6 00             	movzbl (%rax),%eax
  100638:	0f be c0             	movsbl %al,%eax
  10063b:	01 c8                	add    %ecx,%eax
  10063d:	83 e8 30             	sub    $0x30,%eax
  100640:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100643:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10064a:	0f b6 00             	movzbl (%rax),%eax
  10064d:	3c 2f                	cmp    $0x2f,%al
  10064f:	0f 8e 85 00 00 00    	jle    1006da <printer_vprintf+0x1c2>
  100655:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10065c:	0f b6 00             	movzbl (%rax),%eax
  10065f:	3c 39                	cmp    $0x39,%al
  100661:	7e b2                	jle    100615 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100663:	eb 75                	jmp    1006da <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100665:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10066c:	0f b6 00             	movzbl (%rax),%eax
  10066f:	3c 2a                	cmp    $0x2a,%al
  100671:	75 68                	jne    1006db <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100673:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10067a:	8b 00                	mov    (%rax),%eax
  10067c:	83 f8 2f             	cmp    $0x2f,%eax
  10067f:	77 30                	ja     1006b1 <printer_vprintf+0x199>
  100681:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100688:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10068c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100693:	8b 00                	mov    (%rax),%eax
  100695:	89 c0                	mov    %eax,%eax
  100697:	48 01 d0             	add    %rdx,%rax
  10069a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1006a1:	8b 12                	mov    (%rdx),%edx
  1006a3:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1006a6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1006ad:	89 0a                	mov    %ecx,(%rdx)
  1006af:	eb 1a                	jmp    1006cb <printer_vprintf+0x1b3>
  1006b1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1006b8:	48 8b 40 08          	mov    0x8(%rax),%rax
  1006bc:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1006c0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1006c7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1006cb:	8b 00                	mov    (%rax),%eax
  1006cd:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  1006d0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1006d7:	01 
  1006d8:	eb 01                	jmp    1006db <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  1006da:	90                   	nop
        }

        // process precision
        int precision = -1;
  1006db:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  1006e2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006e9:	0f b6 00             	movzbl (%rax),%eax
  1006ec:	3c 2e                	cmp    $0x2e,%al
  1006ee:	0f 85 00 01 00 00    	jne    1007f4 <printer_vprintf+0x2dc>
            ++format;
  1006f4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1006fb:	01 
            if (*format >= '0' && *format <= '9') {
  1006fc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100703:	0f b6 00             	movzbl (%rax),%eax
  100706:	3c 2f                	cmp    $0x2f,%al
  100708:	7e 67                	jle    100771 <printer_vprintf+0x259>
  10070a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100711:	0f b6 00             	movzbl (%rax),%eax
  100714:	3c 39                	cmp    $0x39,%al
  100716:	7f 59                	jg     100771 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100718:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  10071f:	eb 2e                	jmp    10074f <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100721:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100724:	89 d0                	mov    %edx,%eax
  100726:	c1 e0 02             	shl    $0x2,%eax
  100729:	01 d0                	add    %edx,%eax
  10072b:	01 c0                	add    %eax,%eax
  10072d:	89 c1                	mov    %eax,%ecx
  10072f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100736:	48 8d 50 01          	lea    0x1(%rax),%rdx
  10073a:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100741:	0f b6 00             	movzbl (%rax),%eax
  100744:	0f be c0             	movsbl %al,%eax
  100747:	01 c8                	add    %ecx,%eax
  100749:	83 e8 30             	sub    $0x30,%eax
  10074c:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10074f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100756:	0f b6 00             	movzbl (%rax),%eax
  100759:	3c 2f                	cmp    $0x2f,%al
  10075b:	0f 8e 85 00 00 00    	jle    1007e6 <printer_vprintf+0x2ce>
  100761:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100768:	0f b6 00             	movzbl (%rax),%eax
  10076b:	3c 39                	cmp    $0x39,%al
  10076d:	7e b2                	jle    100721 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  10076f:	eb 75                	jmp    1007e6 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100771:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100778:	0f b6 00             	movzbl (%rax),%eax
  10077b:	3c 2a                	cmp    $0x2a,%al
  10077d:	75 68                	jne    1007e7 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  10077f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100786:	8b 00                	mov    (%rax),%eax
  100788:	83 f8 2f             	cmp    $0x2f,%eax
  10078b:	77 30                	ja     1007bd <printer_vprintf+0x2a5>
  10078d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100794:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100798:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10079f:	8b 00                	mov    (%rax),%eax
  1007a1:	89 c0                	mov    %eax,%eax
  1007a3:	48 01 d0             	add    %rdx,%rax
  1007a6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007ad:	8b 12                	mov    (%rdx),%edx
  1007af:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1007b2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007b9:	89 0a                	mov    %ecx,(%rdx)
  1007bb:	eb 1a                	jmp    1007d7 <printer_vprintf+0x2bf>
  1007bd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007c4:	48 8b 40 08          	mov    0x8(%rax),%rax
  1007c8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1007cc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007d3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1007d7:	8b 00                	mov    (%rax),%eax
  1007d9:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  1007dc:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1007e3:	01 
  1007e4:	eb 01                	jmp    1007e7 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  1007e6:	90                   	nop
            }
            if (precision < 0) {
  1007e7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1007eb:	79 07                	jns    1007f4 <printer_vprintf+0x2dc>
                precision = 0;
  1007ed:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  1007f4:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  1007fb:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100802:	00 
        int length = 0;
  100803:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  10080a:	48 c7 45 c8 d6 11 10 	movq   $0x1011d6,-0x38(%rbp)
  100811:	00 
    again:
        switch (*format) {
  100812:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100819:	0f b6 00             	movzbl (%rax),%eax
  10081c:	0f be c0             	movsbl %al,%eax
  10081f:	83 e8 43             	sub    $0x43,%eax
  100822:	83 f8 37             	cmp    $0x37,%eax
  100825:	0f 87 9f 03 00 00    	ja     100bca <printer_vprintf+0x6b2>
  10082b:	89 c0                	mov    %eax,%eax
  10082d:	48 8b 04 c5 e8 11 10 	mov    0x1011e8(,%rax,8),%rax
  100834:	00 
  100835:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100837:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  10083e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100845:	01 
            goto again;
  100846:	eb ca                	jmp    100812 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100848:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  10084c:	74 5d                	je     1008ab <printer_vprintf+0x393>
  10084e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100855:	8b 00                	mov    (%rax),%eax
  100857:	83 f8 2f             	cmp    $0x2f,%eax
  10085a:	77 30                	ja     10088c <printer_vprintf+0x374>
  10085c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100863:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100867:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10086e:	8b 00                	mov    (%rax),%eax
  100870:	89 c0                	mov    %eax,%eax
  100872:	48 01 d0             	add    %rdx,%rax
  100875:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10087c:	8b 12                	mov    (%rdx),%edx
  10087e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100881:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100888:	89 0a                	mov    %ecx,(%rdx)
  10088a:	eb 1a                	jmp    1008a6 <printer_vprintf+0x38e>
  10088c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100893:	48 8b 40 08          	mov    0x8(%rax),%rax
  100897:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10089b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008a2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1008a6:	48 8b 00             	mov    (%rax),%rax
  1008a9:	eb 5c                	jmp    100907 <printer_vprintf+0x3ef>
  1008ab:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008b2:	8b 00                	mov    (%rax),%eax
  1008b4:	83 f8 2f             	cmp    $0x2f,%eax
  1008b7:	77 30                	ja     1008e9 <printer_vprintf+0x3d1>
  1008b9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008c0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1008c4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008cb:	8b 00                	mov    (%rax),%eax
  1008cd:	89 c0                	mov    %eax,%eax
  1008cf:	48 01 d0             	add    %rdx,%rax
  1008d2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008d9:	8b 12                	mov    (%rdx),%edx
  1008db:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1008de:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008e5:	89 0a                	mov    %ecx,(%rdx)
  1008e7:	eb 1a                	jmp    100903 <printer_vprintf+0x3eb>
  1008e9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008f0:	48 8b 40 08          	mov    0x8(%rax),%rax
  1008f4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1008f8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008ff:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100903:	8b 00                	mov    (%rax),%eax
  100905:	48 98                	cltq   
  100907:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  10090b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10090f:	48 c1 f8 38          	sar    $0x38,%rax
  100913:	25 80 00 00 00       	and    $0x80,%eax
  100918:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  10091b:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  10091f:	74 09                	je     10092a <printer_vprintf+0x412>
  100921:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100925:	48 f7 d8             	neg    %rax
  100928:	eb 04                	jmp    10092e <printer_vprintf+0x416>
  10092a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10092e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100932:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100935:	83 c8 60             	or     $0x60,%eax
  100938:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  10093b:	e9 cf 02 00 00       	jmp    100c0f <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100940:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100944:	74 5d                	je     1009a3 <printer_vprintf+0x48b>
  100946:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10094d:	8b 00                	mov    (%rax),%eax
  10094f:	83 f8 2f             	cmp    $0x2f,%eax
  100952:	77 30                	ja     100984 <printer_vprintf+0x46c>
  100954:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10095b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10095f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100966:	8b 00                	mov    (%rax),%eax
  100968:	89 c0                	mov    %eax,%eax
  10096a:	48 01 d0             	add    %rdx,%rax
  10096d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100974:	8b 12                	mov    (%rdx),%edx
  100976:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100979:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100980:	89 0a                	mov    %ecx,(%rdx)
  100982:	eb 1a                	jmp    10099e <printer_vprintf+0x486>
  100984:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10098b:	48 8b 40 08          	mov    0x8(%rax),%rax
  10098f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100993:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10099a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10099e:	48 8b 00             	mov    (%rax),%rax
  1009a1:	eb 5c                	jmp    1009ff <printer_vprintf+0x4e7>
  1009a3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009aa:	8b 00                	mov    (%rax),%eax
  1009ac:	83 f8 2f             	cmp    $0x2f,%eax
  1009af:	77 30                	ja     1009e1 <printer_vprintf+0x4c9>
  1009b1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009b8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1009bc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009c3:	8b 00                	mov    (%rax),%eax
  1009c5:	89 c0                	mov    %eax,%eax
  1009c7:	48 01 d0             	add    %rdx,%rax
  1009ca:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009d1:	8b 12                	mov    (%rdx),%edx
  1009d3:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1009d6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009dd:	89 0a                	mov    %ecx,(%rdx)
  1009df:	eb 1a                	jmp    1009fb <printer_vprintf+0x4e3>
  1009e1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009e8:	48 8b 40 08          	mov    0x8(%rax),%rax
  1009ec:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1009f0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009f7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1009fb:	8b 00                	mov    (%rax),%eax
  1009fd:	89 c0                	mov    %eax,%eax
  1009ff:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100a03:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100a07:	e9 03 02 00 00       	jmp    100c0f <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100a0c:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100a13:	e9 28 ff ff ff       	jmp    100940 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100a18:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100a1f:	e9 1c ff ff ff       	jmp    100940 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100a24:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a2b:	8b 00                	mov    (%rax),%eax
  100a2d:	83 f8 2f             	cmp    $0x2f,%eax
  100a30:	77 30                	ja     100a62 <printer_vprintf+0x54a>
  100a32:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a39:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a3d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a44:	8b 00                	mov    (%rax),%eax
  100a46:	89 c0                	mov    %eax,%eax
  100a48:	48 01 d0             	add    %rdx,%rax
  100a4b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a52:	8b 12                	mov    (%rdx),%edx
  100a54:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a57:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a5e:	89 0a                	mov    %ecx,(%rdx)
  100a60:	eb 1a                	jmp    100a7c <printer_vprintf+0x564>
  100a62:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a69:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a6d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a71:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a78:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a7c:	48 8b 00             	mov    (%rax),%rax
  100a7f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100a83:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100a8a:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100a91:	e9 79 01 00 00       	jmp    100c0f <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100a96:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a9d:	8b 00                	mov    (%rax),%eax
  100a9f:	83 f8 2f             	cmp    $0x2f,%eax
  100aa2:	77 30                	ja     100ad4 <printer_vprintf+0x5bc>
  100aa4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100aab:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100aaf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ab6:	8b 00                	mov    (%rax),%eax
  100ab8:	89 c0                	mov    %eax,%eax
  100aba:	48 01 d0             	add    %rdx,%rax
  100abd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ac4:	8b 12                	mov    (%rdx),%edx
  100ac6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ac9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ad0:	89 0a                	mov    %ecx,(%rdx)
  100ad2:	eb 1a                	jmp    100aee <printer_vprintf+0x5d6>
  100ad4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100adb:	48 8b 40 08          	mov    0x8(%rax),%rax
  100adf:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ae3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aea:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100aee:	48 8b 00             	mov    (%rax),%rax
  100af1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100af5:	e9 15 01 00 00       	jmp    100c0f <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100afa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b01:	8b 00                	mov    (%rax),%eax
  100b03:	83 f8 2f             	cmp    $0x2f,%eax
  100b06:	77 30                	ja     100b38 <printer_vprintf+0x620>
  100b08:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b0f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b13:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b1a:	8b 00                	mov    (%rax),%eax
  100b1c:	89 c0                	mov    %eax,%eax
  100b1e:	48 01 d0             	add    %rdx,%rax
  100b21:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b28:	8b 12                	mov    (%rdx),%edx
  100b2a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b2d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b34:	89 0a                	mov    %ecx,(%rdx)
  100b36:	eb 1a                	jmp    100b52 <printer_vprintf+0x63a>
  100b38:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b3f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b43:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b47:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b4e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b52:	8b 00                	mov    (%rax),%eax
  100b54:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100b5a:	e9 67 03 00 00       	jmp    100ec6 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  100b5f:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100b63:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100b67:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b6e:	8b 00                	mov    (%rax),%eax
  100b70:	83 f8 2f             	cmp    $0x2f,%eax
  100b73:	77 30                	ja     100ba5 <printer_vprintf+0x68d>
  100b75:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b7c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b80:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b87:	8b 00                	mov    (%rax),%eax
  100b89:	89 c0                	mov    %eax,%eax
  100b8b:	48 01 d0             	add    %rdx,%rax
  100b8e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b95:	8b 12                	mov    (%rdx),%edx
  100b97:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b9a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ba1:	89 0a                	mov    %ecx,(%rdx)
  100ba3:	eb 1a                	jmp    100bbf <printer_vprintf+0x6a7>
  100ba5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bac:	48 8b 40 08          	mov    0x8(%rax),%rax
  100bb0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100bb4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bbb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100bbf:	8b 00                	mov    (%rax),%eax
  100bc1:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100bc4:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100bc8:	eb 45                	jmp    100c0f <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  100bca:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100bce:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100bd2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bd9:	0f b6 00             	movzbl (%rax),%eax
  100bdc:	84 c0                	test   %al,%al
  100bde:	74 0c                	je     100bec <printer_vprintf+0x6d4>
  100be0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100be7:	0f b6 00             	movzbl (%rax),%eax
  100bea:	eb 05                	jmp    100bf1 <printer_vprintf+0x6d9>
  100bec:	b8 25 00 00 00       	mov    $0x25,%eax
  100bf1:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100bf4:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100bf8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bff:	0f b6 00             	movzbl (%rax),%eax
  100c02:	84 c0                	test   %al,%al
  100c04:	75 08                	jne    100c0e <printer_vprintf+0x6f6>
                format--;
  100c06:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100c0d:	01 
            }
            break;
  100c0e:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100c0f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c12:	83 e0 20             	and    $0x20,%eax
  100c15:	85 c0                	test   %eax,%eax
  100c17:	74 1e                	je     100c37 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100c19:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100c1d:	48 83 c0 18          	add    $0x18,%rax
  100c21:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100c24:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100c28:	48 89 ce             	mov    %rcx,%rsi
  100c2b:	48 89 c7             	mov    %rax,%rdi
  100c2e:	e8 63 f8 ff ff       	call   100496 <fill_numbuf>
  100c33:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100c37:	48 c7 45 c0 d6 11 10 	movq   $0x1011d6,-0x40(%rbp)
  100c3e:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100c3f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c42:	83 e0 20             	and    $0x20,%eax
  100c45:	85 c0                	test   %eax,%eax
  100c47:	74 48                	je     100c91 <printer_vprintf+0x779>
  100c49:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c4c:	83 e0 40             	and    $0x40,%eax
  100c4f:	85 c0                	test   %eax,%eax
  100c51:	74 3e                	je     100c91 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  100c53:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c56:	25 80 00 00 00       	and    $0x80,%eax
  100c5b:	85 c0                	test   %eax,%eax
  100c5d:	74 0a                	je     100c69 <printer_vprintf+0x751>
                prefix = "-";
  100c5f:	48 c7 45 c0 d7 11 10 	movq   $0x1011d7,-0x40(%rbp)
  100c66:	00 
            if (flags & FLAG_NEGATIVE) {
  100c67:	eb 73                	jmp    100cdc <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100c69:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c6c:	83 e0 10             	and    $0x10,%eax
  100c6f:	85 c0                	test   %eax,%eax
  100c71:	74 0a                	je     100c7d <printer_vprintf+0x765>
                prefix = "+";
  100c73:	48 c7 45 c0 d9 11 10 	movq   $0x1011d9,-0x40(%rbp)
  100c7a:	00 
            if (flags & FLAG_NEGATIVE) {
  100c7b:	eb 5f                	jmp    100cdc <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100c7d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c80:	83 e0 08             	and    $0x8,%eax
  100c83:	85 c0                	test   %eax,%eax
  100c85:	74 55                	je     100cdc <printer_vprintf+0x7c4>
                prefix = " ";
  100c87:	48 c7 45 c0 db 11 10 	movq   $0x1011db,-0x40(%rbp)
  100c8e:	00 
            if (flags & FLAG_NEGATIVE) {
  100c8f:	eb 4b                	jmp    100cdc <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100c91:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c94:	83 e0 20             	and    $0x20,%eax
  100c97:	85 c0                	test   %eax,%eax
  100c99:	74 42                	je     100cdd <printer_vprintf+0x7c5>
  100c9b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c9e:	83 e0 01             	and    $0x1,%eax
  100ca1:	85 c0                	test   %eax,%eax
  100ca3:	74 38                	je     100cdd <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  100ca5:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100ca9:	74 06                	je     100cb1 <printer_vprintf+0x799>
  100cab:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100caf:	75 2c                	jne    100cdd <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  100cb1:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100cb6:	75 0c                	jne    100cc4 <printer_vprintf+0x7ac>
  100cb8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cbb:	25 00 01 00 00       	and    $0x100,%eax
  100cc0:	85 c0                	test   %eax,%eax
  100cc2:	74 19                	je     100cdd <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  100cc4:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100cc8:	75 07                	jne    100cd1 <printer_vprintf+0x7b9>
  100cca:	b8 dd 11 10 00       	mov    $0x1011dd,%eax
  100ccf:	eb 05                	jmp    100cd6 <printer_vprintf+0x7be>
  100cd1:	b8 e0 11 10 00       	mov    $0x1011e0,%eax
  100cd6:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100cda:	eb 01                	jmp    100cdd <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  100cdc:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100cdd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100ce1:	78 24                	js     100d07 <printer_vprintf+0x7ef>
  100ce3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ce6:	83 e0 20             	and    $0x20,%eax
  100ce9:	85 c0                	test   %eax,%eax
  100ceb:	75 1a                	jne    100d07 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  100ced:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100cf0:	48 63 d0             	movslq %eax,%rdx
  100cf3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100cf7:	48 89 d6             	mov    %rdx,%rsi
  100cfa:	48 89 c7             	mov    %rax,%rdi
  100cfd:	e8 ea f5 ff ff       	call   1002ec <strnlen>
  100d02:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100d05:	eb 0f                	jmp    100d16 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  100d07:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100d0b:	48 89 c7             	mov    %rax,%rdi
  100d0e:	e8 a8 f5 ff ff       	call   1002bb <strlen>
  100d13:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100d16:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d19:	83 e0 20             	and    $0x20,%eax
  100d1c:	85 c0                	test   %eax,%eax
  100d1e:	74 20                	je     100d40 <printer_vprintf+0x828>
  100d20:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100d24:	78 1a                	js     100d40 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  100d26:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100d29:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100d2c:	7e 08                	jle    100d36 <printer_vprintf+0x81e>
  100d2e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100d31:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100d34:	eb 05                	jmp    100d3b <printer_vprintf+0x823>
  100d36:	b8 00 00 00 00       	mov    $0x0,%eax
  100d3b:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100d3e:	eb 5c                	jmp    100d9c <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100d40:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d43:	83 e0 20             	and    $0x20,%eax
  100d46:	85 c0                	test   %eax,%eax
  100d48:	74 4b                	je     100d95 <printer_vprintf+0x87d>
  100d4a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d4d:	83 e0 02             	and    $0x2,%eax
  100d50:	85 c0                	test   %eax,%eax
  100d52:	74 41                	je     100d95 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100d54:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d57:	83 e0 04             	and    $0x4,%eax
  100d5a:	85 c0                	test   %eax,%eax
  100d5c:	75 37                	jne    100d95 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  100d5e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100d62:	48 89 c7             	mov    %rax,%rdi
  100d65:	e8 51 f5 ff ff       	call   1002bb <strlen>
  100d6a:	89 c2                	mov    %eax,%edx
  100d6c:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100d6f:	01 d0                	add    %edx,%eax
  100d71:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100d74:	7e 1f                	jle    100d95 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  100d76:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100d79:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100d7c:	89 c3                	mov    %eax,%ebx
  100d7e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100d82:	48 89 c7             	mov    %rax,%rdi
  100d85:	e8 31 f5 ff ff       	call   1002bb <strlen>
  100d8a:	89 c2                	mov    %eax,%edx
  100d8c:	89 d8                	mov    %ebx,%eax
  100d8e:	29 d0                	sub    %edx,%eax
  100d90:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100d93:	eb 07                	jmp    100d9c <printer_vprintf+0x884>
        } else {
            zeros = 0;
  100d95:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100d9c:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100d9f:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100da2:	01 d0                	add    %edx,%eax
  100da4:	48 63 d8             	movslq %eax,%rbx
  100da7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100dab:	48 89 c7             	mov    %rax,%rdi
  100dae:	e8 08 f5 ff ff       	call   1002bb <strlen>
  100db3:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100db7:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100dba:	29 d0                	sub    %edx,%eax
  100dbc:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100dbf:	eb 25                	jmp    100de6 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  100dc1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100dc8:	48 8b 08             	mov    (%rax),%rcx
  100dcb:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100dd1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100dd8:	be 20 00 00 00       	mov    $0x20,%esi
  100ddd:	48 89 c7             	mov    %rax,%rdi
  100de0:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100de2:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100de6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100de9:	83 e0 04             	and    $0x4,%eax
  100dec:	85 c0                	test   %eax,%eax
  100dee:	75 36                	jne    100e26 <printer_vprintf+0x90e>
  100df0:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100df4:	7f cb                	jg     100dc1 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  100df6:	eb 2e                	jmp    100e26 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  100df8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100dff:	4c 8b 00             	mov    (%rax),%r8
  100e02:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e06:	0f b6 00             	movzbl (%rax),%eax
  100e09:	0f b6 c8             	movzbl %al,%ecx
  100e0c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100e12:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e19:	89 ce                	mov    %ecx,%esi
  100e1b:	48 89 c7             	mov    %rax,%rdi
  100e1e:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  100e21:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  100e26:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e2a:	0f b6 00             	movzbl (%rax),%eax
  100e2d:	84 c0                	test   %al,%al
  100e2f:	75 c7                	jne    100df8 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  100e31:	eb 25                	jmp    100e58 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  100e33:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e3a:	48 8b 08             	mov    (%rax),%rcx
  100e3d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100e43:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e4a:	be 30 00 00 00       	mov    $0x30,%esi
  100e4f:	48 89 c7             	mov    %rax,%rdi
  100e52:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  100e54:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  100e58:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  100e5c:	7f d5                	jg     100e33 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  100e5e:	eb 32                	jmp    100e92 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  100e60:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e67:	4c 8b 00             	mov    (%rax),%r8
  100e6a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100e6e:	0f b6 00             	movzbl (%rax),%eax
  100e71:	0f b6 c8             	movzbl %al,%ecx
  100e74:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100e7a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e81:	89 ce                	mov    %ecx,%esi
  100e83:	48 89 c7             	mov    %rax,%rdi
  100e86:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  100e89:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  100e8e:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  100e92:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  100e96:	7f c8                	jg     100e60 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  100e98:	eb 25                	jmp    100ebf <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  100e9a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ea1:	48 8b 08             	mov    (%rax),%rcx
  100ea4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100eaa:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100eb1:	be 20 00 00 00       	mov    $0x20,%esi
  100eb6:	48 89 c7             	mov    %rax,%rdi
  100eb9:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  100ebb:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100ebf:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100ec3:	7f d5                	jg     100e9a <printer_vprintf+0x982>
        }
    done: ;
  100ec5:	90                   	nop
    for (; *format; ++format) {
  100ec6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ecd:	01 
  100ece:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ed5:	0f b6 00             	movzbl (%rax),%eax
  100ed8:	84 c0                	test   %al,%al
  100eda:	0f 85 64 f6 ff ff    	jne    100544 <printer_vprintf+0x2c>
    }
}
  100ee0:	90                   	nop
  100ee1:	90                   	nop
  100ee2:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100ee6:	c9                   	leave  
  100ee7:	c3                   	ret    

0000000000100ee8 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100ee8:	55                   	push   %rbp
  100ee9:	48 89 e5             	mov    %rsp,%rbp
  100eec:	48 83 ec 20          	sub    $0x20,%rsp
  100ef0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100ef4:	89 f0                	mov    %esi,%eax
  100ef6:	89 55 e0             	mov    %edx,-0x20(%rbp)
  100ef9:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  100efc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100f00:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100f04:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100f08:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f0c:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  100f11:	48 39 d0             	cmp    %rdx,%rax
  100f14:	72 0c                	jb     100f22 <console_putc+0x3a>
        cp->cursor = console;
  100f16:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100f1a:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  100f21:	00 
    }
    if (c == '\n') {
  100f22:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  100f26:	75 78                	jne    100fa0 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  100f28:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100f2c:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f30:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  100f36:	48 d1 f8             	sar    %rax
  100f39:	48 89 c1             	mov    %rax,%rcx
  100f3c:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  100f43:	66 66 66 
  100f46:	48 89 c8             	mov    %rcx,%rax
  100f49:	48 f7 ea             	imul   %rdx
  100f4c:	48 c1 fa 05          	sar    $0x5,%rdx
  100f50:	48 89 c8             	mov    %rcx,%rax
  100f53:	48 c1 f8 3f          	sar    $0x3f,%rax
  100f57:	48 29 c2             	sub    %rax,%rdx
  100f5a:	48 89 d0             	mov    %rdx,%rax
  100f5d:	48 c1 e0 02          	shl    $0x2,%rax
  100f61:	48 01 d0             	add    %rdx,%rax
  100f64:	48 c1 e0 04          	shl    $0x4,%rax
  100f68:	48 29 c1             	sub    %rax,%rcx
  100f6b:	48 89 ca             	mov    %rcx,%rdx
  100f6e:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  100f71:	eb 25                	jmp    100f98 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  100f73:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100f76:	83 c8 20             	or     $0x20,%eax
  100f79:	89 c6                	mov    %eax,%esi
  100f7b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100f7f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f83:	48 8d 48 02          	lea    0x2(%rax),%rcx
  100f87:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  100f8b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f8f:	89 f2                	mov    %esi,%edx
  100f91:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  100f94:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  100f98:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  100f9c:	75 d5                	jne    100f73 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  100f9e:	eb 24                	jmp    100fc4 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  100fa0:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  100fa4:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100fa7:	09 d0                	or     %edx,%eax
  100fa9:	89 c6                	mov    %eax,%esi
  100fab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100faf:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fb3:	48 8d 48 02          	lea    0x2(%rax),%rcx
  100fb7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  100fbb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100fbf:	89 f2                	mov    %esi,%edx
  100fc1:	66 89 10             	mov    %dx,(%rax)
}
  100fc4:	90                   	nop
  100fc5:	c9                   	leave  
  100fc6:	c3                   	ret    

0000000000100fc7 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  100fc7:	55                   	push   %rbp
  100fc8:	48 89 e5             	mov    %rsp,%rbp
  100fcb:	48 83 ec 30          	sub    $0x30,%rsp
  100fcf:	89 7d ec             	mov    %edi,-0x14(%rbp)
  100fd2:	89 75 e8             	mov    %esi,-0x18(%rbp)
  100fd5:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100fd9:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  100fdd:	48 c7 45 f0 e8 0e 10 	movq   $0x100ee8,-0x10(%rbp)
  100fe4:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100fe5:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  100fe9:	78 09                	js     100ff4 <console_vprintf+0x2d>
  100feb:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  100ff2:	7e 07                	jle    100ffb <console_vprintf+0x34>
        cpos = 0;
  100ff4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  100ffb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ffe:	48 98                	cltq   
  101000:	48 01 c0             	add    %rax,%rax
  101003:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  101009:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  10100d:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101011:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  101015:	8b 75 e8             	mov    -0x18(%rbp),%esi
  101018:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  10101c:	48 89 c7             	mov    %rax,%rdi
  10101f:	e8 f4 f4 ff ff       	call   100518 <printer_vprintf>
    return cp.cursor - console;
  101024:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101028:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  10102e:	48 d1 f8             	sar    %rax
}
  101031:	c9                   	leave  
  101032:	c3                   	ret    

0000000000101033 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  101033:	55                   	push   %rbp
  101034:	48 89 e5             	mov    %rsp,%rbp
  101037:	48 83 ec 60          	sub    $0x60,%rsp
  10103b:	89 7d ac             	mov    %edi,-0x54(%rbp)
  10103e:	89 75 a8             	mov    %esi,-0x58(%rbp)
  101041:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  101045:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101049:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10104d:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101051:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101058:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10105c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101060:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101064:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101068:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  10106c:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101070:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101073:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101076:	89 c7                	mov    %eax,%edi
  101078:	e8 4a ff ff ff       	call   100fc7 <console_vprintf>
  10107d:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101080:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101083:	c9                   	leave  
  101084:	c3                   	ret    

0000000000101085 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101085:	55                   	push   %rbp
  101086:	48 89 e5             	mov    %rsp,%rbp
  101089:	48 83 ec 20          	sub    $0x20,%rsp
  10108d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101091:	89 f0                	mov    %esi,%eax
  101093:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101096:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101099:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10109d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  1010a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1010a5:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1010a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1010ad:	48 8b 40 10          	mov    0x10(%rax),%rax
  1010b1:	48 39 c2             	cmp    %rax,%rdx
  1010b4:	73 1a                	jae    1010d0 <string_putc+0x4b>
        *sp->s++ = c;
  1010b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1010ba:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010be:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1010c2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1010c6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1010ca:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1010ce:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1010d0:	90                   	nop
  1010d1:	c9                   	leave  
  1010d2:	c3                   	ret    

00000000001010d3 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1010d3:	55                   	push   %rbp
  1010d4:	48 89 e5             	mov    %rsp,%rbp
  1010d7:	48 83 ec 40          	sub    $0x40,%rsp
  1010db:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  1010df:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  1010e3:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  1010e7:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1010eb:	48 c7 45 e8 85 10 10 	movq   $0x101085,-0x18(%rbp)
  1010f2:	00 
    sp.s = s;
  1010f3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1010f7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1010fb:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  101100:	74 33                	je     101135 <vsnprintf+0x62>
        sp.end = s + size - 1;
  101102:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101106:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10110a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10110e:	48 01 d0             	add    %rdx,%rax
  101111:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101115:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101119:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  10111d:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101121:	be 00 00 00 00       	mov    $0x0,%esi
  101126:	48 89 c7             	mov    %rax,%rdi
  101129:	e8 ea f3 ff ff       	call   100518 <printer_vprintf>
        *sp.s = 0;
  10112e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101132:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  101135:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101139:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  10113d:	c9                   	leave  
  10113e:	c3                   	ret    

000000000010113f <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  10113f:	55                   	push   %rbp
  101140:	48 89 e5             	mov    %rsp,%rbp
  101143:	48 83 ec 70          	sub    $0x70,%rsp
  101147:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  10114b:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  10114f:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101153:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101157:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10115b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  10115f:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101166:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10116a:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  10116e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101172:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101176:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  10117a:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  10117e:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101182:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101186:	48 89 c7             	mov    %rax,%rdi
  101189:	e8 45 ff ff ff       	call   1010d3 <vsnprintf>
  10118e:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101191:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101194:	c9                   	leave  
  101195:	c3                   	ret    

0000000000101196 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101196:	55                   	push   %rbp
  101197:	48 89 e5             	mov    %rsp,%rbp
  10119a:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10119e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  1011a5:	eb 13                	jmp    1011ba <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  1011a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1011aa:	48 98                	cltq   
  1011ac:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  1011b3:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1011b6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1011ba:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1011c1:	7e e4                	jle    1011a7 <console_clear+0x11>
    }
    cursorpos = 0;
  1011c3:	c7 05 2f 7e fb ff 00 	movl   $0x0,-0x481d1(%rip)        # b8ffc <cursorpos>
  1011ca:	00 00 00 
}
  1011cd:	90                   	nop
  1011ce:	c9                   	leave  
  1011cf:	c3                   	ret    
