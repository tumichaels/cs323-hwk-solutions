
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
uint8_t *heap_top;
uint8_t *heap_bottom;
uint8_t *stack_bottom;

char s[1000];
void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100004:	cd 31                	int    $0x31
  100006:	89 c7                	mov    %eax,%edi
    pid_t p = getpid();
    srand(p);
  100008:	e8 4e 07 00 00       	call   10075b <srand>
    heap_bottom = heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10000d:	b8 27 34 10 00       	mov    $0x103427,%eax
  100012:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100018:	48 89 05 d9 23 00 00 	mov    %rax,0x23d9(%rip)        # 1023f8 <heap_top>
  10001f:	48 89 05 ca 23 00 00 	mov    %rax,0x23ca(%rip)        # 1023f0 <heap_bottom>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100026:	48 89 e0             	mov    %rsp,%rax
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100029:	48 83 e8 01          	sub    $0x1,%rax
  10002d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100033:	48 89 05 ae 23 00 00 	mov    %rax,0x23ae(%rip)        # 1023e8 <stack_bottom>
    //     }
    //     defrag();
    // }
    //

    void *ptr = malloc(64);
  10003a:	bf 40 00 00 00       	mov    $0x40,%edi
  10003f:	e8 71 03 00 00       	call   1003b5 <malloc>
    if (ptr == (void*)0x103030)
  100044:	48 3d 30 30 10 00    	cmp    $0x103030,%rax
  10004a:	74 0f                	je     10005b <process_main+0x5b>
	    panic("success!");

    TEST_PASS();
  10004c:	bf c9 14 10 00       	mov    $0x1014c9,%edi
  100051:	b8 00 00 00 00       	mov    $0x0,%eax
  100056:	e8 99 00 00 00       	call   1000f4 <kernel_panic>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  10005b:	bf c0 14 10 00       	mov    $0x1014c0,%edi
  100060:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  100062:	eb fe                	jmp    100062 <process_main+0x62>

0000000000100064 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100064:	55                   	push   %rbp
  100065:	48 89 e5             	mov    %rsp,%rbp
  100068:	48 83 ec 50          	sub    $0x50,%rsp
  10006c:	49 89 f2             	mov    %rsi,%r10
  10006f:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100073:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100077:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10007b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  10007f:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100084:	85 ff                	test   %edi,%edi
  100086:	78 2e                	js     1000b6 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  100088:	48 63 ff             	movslq %edi,%rdi
  10008b:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  100092:	cc cc cc 
  100095:	48 89 f8             	mov    %rdi,%rax
  100098:	48 f7 e2             	mul    %rdx
  10009b:	48 89 d0             	mov    %rdx,%rax
  10009e:	48 c1 e8 02          	shr    $0x2,%rax
  1000a2:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  1000a6:	48 01 c2             	add    %rax,%rdx
  1000a9:	48 29 d7             	sub    %rdx,%rdi
  1000ac:	0f b6 b7 1d 15 10 00 	movzbl 0x10151d(%rdi),%esi
  1000b3:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  1000b6:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  1000bd:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1000c1:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1000c5:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1000c9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  1000cd:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1000d1:	4c 89 d2             	mov    %r10,%rdx
  1000d4:	8b 3d 22 8f fb ff    	mov    -0x470de(%rip),%edi        # b8ffc <cursorpos>
  1000da:	e8 ce 11 00 00       	call   1012ad <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  1000df:	3d 30 07 00 00       	cmp    $0x730,%eax
  1000e4:	ba 00 00 00 00       	mov    $0x0,%edx
  1000e9:	0f 4d c2             	cmovge %edx,%eax
  1000ec:	89 05 0a 8f fb ff    	mov    %eax,-0x470f6(%rip)        # b8ffc <cursorpos>
    }
}
  1000f2:	c9                   	leave  
  1000f3:	c3                   	ret    

00000000001000f4 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  1000f4:	55                   	push   %rbp
  1000f5:	48 89 e5             	mov    %rsp,%rbp
  1000f8:	53                   	push   %rbx
  1000f9:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100100:	48 89 fb             	mov    %rdi,%rbx
  100103:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100107:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  10010b:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  10010f:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100113:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  100117:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  10011e:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100122:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100126:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  10012a:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  10012e:	ba 07 00 00 00       	mov    $0x7,%edx
  100133:	be e4 14 10 00       	mov    $0x1014e4,%esi
  100138:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  10013f:	e8 20 03 00 00       	call   100464 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100144:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100148:	48 89 da             	mov    %rbx,%rdx
  10014b:	be 99 00 00 00       	mov    $0x99,%esi
  100150:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100157:	e8 5d 12 00 00       	call   1013b9 <vsnprintf>
  10015c:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  10015f:	85 d2                	test   %edx,%edx
  100161:	7e 0f                	jle    100172 <kernel_panic+0x7e>
  100163:	83 c0 06             	add    $0x6,%eax
  100166:	48 98                	cltq   
  100168:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  10016f:	0a 
  100170:	75 2a                	jne    10019c <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  100172:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  100179:	48 89 d9             	mov    %rbx,%rcx
  10017c:	ba ee 14 10 00       	mov    $0x1014ee,%edx
  100181:	be 00 c0 00 00       	mov    $0xc000,%esi
  100186:	bf 30 07 00 00       	mov    $0x730,%edi
  10018b:	b8 00 00 00 00       	mov    $0x0,%eax
  100190:	e8 84 11 00 00       	call   101319 <console_printf>
    asm volatile ("int %0" : /* no result */
  100195:	48 89 df             	mov    %rbx,%rdi
  100198:	cd 30                	int    $0x30
 loop: goto loop;
  10019a:	eb fe                	jmp    10019a <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  10019c:	48 63 c2             	movslq %edx,%rax
  10019f:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  1001a5:	0f 94 c2             	sete   %dl
  1001a8:	0f b6 d2             	movzbl %dl,%edx
  1001ab:	48 29 d0             	sub    %rdx,%rax
  1001ae:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  1001b5:	ff 
  1001b6:	be ec 14 10 00       	mov    $0x1014ec,%esi
  1001bb:	e8 51 04 00 00       	call   100611 <strcpy>
  1001c0:	eb b0                	jmp    100172 <kernel_panic+0x7e>

00000000001001c2 <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  1001c2:	55                   	push   %rbp
  1001c3:	48 89 e5             	mov    %rsp,%rbp
  1001c6:	48 89 f9             	mov    %rdi,%rcx
  1001c9:	41 89 f0             	mov    %esi,%r8d
  1001cc:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  1001cf:	ba f8 14 10 00       	mov    $0x1014f8,%edx
  1001d4:	be 00 c0 00 00       	mov    $0xc000,%esi
  1001d9:	bf 30 07 00 00       	mov    $0x730,%edi
  1001de:	b8 00 00 00 00       	mov    $0x0,%eax
  1001e3:	e8 31 11 00 00       	call   101319 <console_printf>
    asm volatile ("int %0" : /* no result */
  1001e8:	bf 00 00 00 00       	mov    $0x0,%edi
  1001ed:	cd 30                	int    $0x30
 loop: goto loop;
  1001ef:	eb fe                	jmp    1001ef <assert_fail+0x2d>

00000000001001f1 <heap_init>:
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  1001f1:	bf 10 00 00 00       	mov    $0x10,%edi
  1001f6:	cd 3a                	int    $0x3a
  1001f8:	48 89 05 19 22 00 00 	mov    %rax,0x2219(%rip)        # 102418 <result.0>
  1001ff:	cd 3a                	int    $0x3a
  100201:	48 89 05 10 22 00 00 	mov    %rax,0x2210(%rip)        # 102418 <result.0>
// want to try and optimize this 
void heap_init(void) {

	// prologue block
	sbrk(sizeof(block_header));
	prologue_block = sbrk(sizeof(block_footer));
  100208:	48 89 05 f9 21 00 00 	mov    %rax,0x21f9(%rip)        # 102408 <prologue_block>

	GET_SIZE(HDRP(prologue_block)) = sizeof(block_header) + sizeof(block_footer);
  10020f:	48 c7 40 f0 20 00 00 	movq   $0x20,-0x10(%rax)
  100216:	00 
	GET_ALLOC(HDRP(prologue_block)) = 1;
  100217:	48 8b 05 ea 21 00 00 	mov    0x21ea(%rip),%rax        # 102408 <prologue_block>
  10021e:	c7 40 f8 01 00 00 00 	movl   $0x1,-0x8(%rax)
	GET_SIZE(FTRP(prologue_block)) = sizeof(block_header) + sizeof(block_footer);
  100225:	48 8b 05 dc 21 00 00 	mov    0x21dc(%rip),%rax        # 102408 <prologue_block>
  10022c:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  100230:	48 c7 44 10 e0 20 00 	movq   $0x20,-0x20(%rax,%rdx,1)
  100237:	00 00 
  100239:	cd 3a                	int    $0x3a
  10023b:	48 89 05 d6 21 00 00 	mov    %rax,0x21d6(%rip)        # 102418 <result.0>

	// terminal block
	sbrk(sizeof(block_header));
	GET_SIZE(HDRP(NEXT_BLKP(prologue_block))) = 0;
  100242:	48 8b 05 bf 21 00 00 	mov    0x21bf(%rip),%rax        # 102408 <prologue_block>
  100249:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  10024d:	48 c7 44 10 f0 00 00 	movq   $0x0,-0x10(%rax,%rdx,1)
  100254:	00 00 
	GET_ALLOC(HDRP(NEXT_BLKP(prologue_block))) = 0;
  100256:	48 8b 05 ab 21 00 00 	mov    0x21ab(%rip),%rax        # 102408 <prologue_block>
  10025d:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  100261:	c7 44 10 f8 00 00 00 	movl   $0x0,-0x8(%rax,%rdx,1)
  100268:	00 

	free_list = NULL;
  100269:	48 c7 05 8c 21 00 00 	movq   $0x0,0x218c(%rip)        # 102400 <free_list>
  100270:	00 00 00 00 

	initialized_heap = 1;
  100274:	c7 05 92 21 00 00 01 	movl   $0x1,0x2192(%rip)        # 102410 <initialized_heap>
  10027b:	00 00 00 
}
  10027e:	c3                   	ret    

000000000010027f <free>:

void free(void *firstbyte) {
	if (firstbyte == NULL)
  10027f:	48 85 ff             	test   %rdi,%rdi
  100282:	74 29                	je     1002ad <free+0x2e>
		return;

	// setup free things: alloc, list ptrs, footer
	GET_ALLOC(HDRP(firstbyte)) = 0;
  100284:	c7 47 f8 00 00 00 00 	movl   $0x0,-0x8(%rdi)
	NEXT_FPTR(firstbyte) = free_list;
  10028b:	48 8b 05 6e 21 00 00 	mov    0x216e(%rip),%rax        # 102400 <free_list>
  100292:	48 89 07             	mov    %rax,(%rdi)
	PREV_FPTR(firstbyte) = NULL;
  100295:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  10029c:	00 
	GET_SIZE(FTRP(firstbyte)) = GET_SIZE(HDRP(firstbyte));
  10029d:	48 8b 47 f0          	mov    -0x10(%rdi),%rax
  1002a1:	48 89 44 07 e0       	mov    %rax,-0x20(%rdi,%rax,1)

	// add to free_list
	free_list = firstbyte;
  1002a6:	48 89 3d 53 21 00 00 	mov    %rdi,0x2153(%rip)        # 102400 <free_list>

	return;
}
  1002ad:	c3                   	ret    

00000000001002ae <extend>:
//
//	the reason alloating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
void extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  1002ae:	48 81 c7 ff 3f 00 00 	add    $0x3fff,%rdi
  1002b5:	48 81 e7 00 c0 ff ff 	and    $0xffffffffffffc000,%rdi
  1002bc:	cd 3a                	int    $0x3a
  1002be:	48 89 05 53 21 00 00 	mov    %rax,0x2153(%rip)        # 102418 <result.0>
	void *bp = sbrk(chunk_aligned_size);

	// setup pointer
	GET_SIZE(HDRP(bp)) = chunk_aligned_size;
  1002c5:	48 89 78 f0          	mov    %rdi,-0x10(%rax)
	GET_ALLOC(HDRP(bp)) = 0;
  1002c9:	c7 40 f8 00 00 00 00 	movl   $0x0,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  1002d0:	48 8b 15 29 21 00 00 	mov    0x2129(%rip),%rdx        # 102400 <free_list>
  1002d7:	48 89 10             	mov    %rdx,(%rax)
	PREV_FPTR(bp) = NULL;
  1002da:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  1002e1:	00 
	GET_SIZE(FTRP(bp)) = chunk_aligned_size;
  1002e2:	48 89 7c 07 e0       	mov    %rdi,-0x20(%rdi,%rax,1)

	// add to head of free_list
	if (free_list)
  1002e7:	48 8b 15 12 21 00 00 	mov    0x2112(%rip),%rdx        # 102400 <free_list>
  1002ee:	48 85 d2             	test   %rdx,%rdx
  1002f1:	74 04                	je     1002f7 <extend+0x49>
		PREV_FPTR(free_list) = bp;
  1002f3:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  1002f7:	48 89 05 02 21 00 00 	mov    %rax,0x2102(%rip)        # 102400 <free_list>

	// update terminal block
	GET_SIZE(HDRP(NEXT_BLKP(bp))) = 0;
  1002fe:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  100302:	48 c7 44 10 f0 00 00 	movq   $0x0,-0x10(%rax,%rdx,1)
  100309:	00 00 
	GET_ALLOC(HDRP(NEXT_BLKP(bp))) = 1;
  10030b:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  10030f:	c7 44 10 f8 01 00 00 	movl   $0x1,-0x8(%rax,%rdx,1)
  100316:	00 
}
  100317:	c3                   	ret    

0000000000100318 <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
  100318:	48 89 f8             	mov    %rdi,%rax
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  10031b:	48 8b 57 f0          	mov    -0x10(%rdi),%rdx
  10031f:	48 29 f2             	sub    %rsi,%rdx

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  100322:	48 83 fa 30          	cmp    $0x30,%rdx
  100326:	76 57                	jbe    10037f <set_allocated+0x67>
		GET_SIZE(HDRP(bp)) = size;
  100328:	48 89 77 f0          	mov    %rsi,-0x10(%rdi)
		void *leftover_mem_ptr = NEXT_BLKP(bp);
  10032c:	48 01 fe             	add    %rdi,%rsi

		GET_SIZE(HDRP(leftover_mem_ptr)) = extra_size;
  10032f:	48 89 56 f0          	mov    %rdx,-0x10(%rsi)
		GET_ALLOC(HDRP(leftover_mem_ptr)) = 0;
  100333:	c7 46 f8 00 00 00 00 	movl   $0x0,-0x8(%rsi)

		// add pointers to previous and next free block
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp);
  10033a:	48 8b 0f             	mov    (%rdi),%rcx
  10033d:	48 89 0e             	mov    %rcx,(%rsi)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  100340:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  100344:	48 89 4e 08          	mov    %rcx,0x8(%rsi)
	
		GET_SIZE(FTRP(leftover_mem_ptr)) = extra_size;
  100348:	48 89 54 16 e0       	mov    %rdx,-0x20(%rsi,%rdx,1)

		// update the free list
		if (free_list == bp)
  10034d:	48 39 3d ac 20 00 00 	cmp    %rdi,0x20ac(%rip)        # 102400 <free_list>
  100354:	74 20                	je     100376 <set_allocated+0x5e>
			free_list = leftover_mem_ptr;

		if (PREV_FPTR(bp))
  100356:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10035a:	48 85 d2             	test   %rdx,%rdx
  10035d:	74 03                	je     100362 <set_allocated+0x4a>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  10035f:	48 89 32             	mov    %rsi,(%rdx)
		if (NEXT_FPTR(bp))
  100362:	48 8b 10             	mov    (%rax),%rdx
  100365:	48 85 d2             	test   %rdx,%rdx
  100368:	74 04                	je     10036e <set_allocated+0x56>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  10036a:	48 89 72 08          	mov    %rsi,0x8(%rdx)
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
		if (NEXT_FPTR(bp))
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
	}
	
	GET_ALLOC(HDRP(bp)) = 1;
  10036e:	c7 40 f8 01 00 00 00 	movl   $0x1,-0x8(%rax)
}
  100375:	c3                   	ret    
			free_list = leftover_mem_ptr;
  100376:	48 89 35 83 20 00 00 	mov    %rsi,0x2083(%rip)        # 102400 <free_list>
  10037d:	eb d7                	jmp    100356 <set_allocated+0x3e>
		if (free_list == bp)
  10037f:	48 39 3d 7a 20 00 00 	cmp    %rdi,0x207a(%rip)        # 102400 <free_list>
  100386:	74 21                	je     1003a9 <set_allocated+0x91>
		if (PREV_FPTR(bp))
  100388:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10038c:	48 85 d2             	test   %rdx,%rdx
  10038f:	74 06                	je     100397 <set_allocated+0x7f>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  100391:	48 8b 08             	mov    (%rax),%rcx
  100394:	48 89 0a             	mov    %rcx,(%rdx)
		if (NEXT_FPTR(bp))
  100397:	48 8b 10             	mov    (%rax),%rdx
  10039a:	48 85 d2             	test   %rdx,%rdx
  10039d:	74 cf                	je     10036e <set_allocated+0x56>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  10039f:	48 8b 48 08          	mov    0x8(%rax),%rcx
  1003a3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1003a7:	eb c5                	jmp    10036e <set_allocated+0x56>
			free_list = NEXT_FPTR(bp);
  1003a9:	48 8b 17             	mov    (%rdi),%rdx
  1003ac:	48 89 15 4d 20 00 00 	mov    %rdx,0x204d(%rip)        # 102400 <free_list>
  1003b3:	eb d3                	jmp    100388 <set_allocated+0x70>

00000000001003b5 <malloc>:

void *malloc(uint64_t numbytes) {
  1003b5:	55                   	push   %rbp
  1003b6:	48 89 e5             	mov    %rsp,%rbp
  1003b9:	41 55                	push   %r13
  1003bb:	41 54                	push   %r12
  1003bd:	53                   	push   %rbx
  1003be:	48 83 ec 08          	sub    $0x8,%rsp
  1003c2:	49 89 fc             	mov    %rdi,%r12
	if (!initialized_heap)
  1003c5:	83 3d 44 20 00 00 00 	cmpl   $0x0,0x2044(%rip)        # 102410 <initialized_heap>
  1003cc:	74 68                	je     100436 <malloc+0x81>
		heap_init();

	if (numbytes == 0)
  1003ce:	4d 85 e4             	test   %r12,%r12
  1003d1:	74 77                	je     10044a <malloc+0x95>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  1003d3:	49 83 c4 1f          	add    $0x1f,%r12
  1003d7:	49 83 e4 f0          	and    $0xfffffffffffffff0,%r12
  1003db:	b8 30 00 00 00       	mov    $0x30,%eax
  1003e0:	49 39 c4             	cmp    %rax,%r12
  1003e3:	4c 0f 42 e0          	cmovb  %rax,%r12
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);

	void *bp = free_list;
  1003e7:	48 8b 1d 12 20 00 00 	mov    0x2012(%rip),%rbx        # 102400 <free_list>
	while (bp) {
  1003ee:	48 85 db             	test   %rbx,%rbx
  1003f1:	74 0e                	je     100401 <malloc+0x4c>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  1003f3:	4c 39 63 f0          	cmp    %r12,-0x10(%rbx)
  1003f7:	73 44                	jae    10043d <malloc+0x88>
			set_allocated(bp, aligned_size);
			return bp;
		}

		bp = NEXT_FPTR(bp);
  1003f9:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  1003fc:	48 85 db             	test   %rbx,%rbx
  1003ff:	75 f2                	jne    1003f3 <malloc+0x3e>
  100401:	bf 00 00 00 00       	mov    $0x0,%edi
  100406:	cd 3a                	int    $0x3a
  100408:	49 89 c5             	mov    %rax,%r13
  10040b:	48 89 05 06 20 00 00 	mov    %rax,0x2006(%rip)        # 102418 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  100412:	48 89 c3             	mov    %rax,%rbx
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	extend(aligned_size);
  100415:	4c 89 e7             	mov    %r12,%rdi
  100418:	e8 91 fe ff ff       	call   1002ae <extend>
	set_allocated(bp, aligned_size);
  10041d:	4c 89 e6             	mov    %r12,%rsi
  100420:	4c 89 ef             	mov    %r13,%rdi
  100423:	e8 f0 fe ff ff       	call   100318 <set_allocated>
    return bp;
}
  100428:	48 89 d8             	mov    %rbx,%rax
  10042b:	48 83 c4 08          	add    $0x8,%rsp
  10042f:	5b                   	pop    %rbx
  100430:	41 5c                	pop    %r12
  100432:	41 5d                	pop    %r13
  100434:	5d                   	pop    %rbp
  100435:	c3                   	ret    
		heap_init();
  100436:	e8 b6 fd ff ff       	call   1001f1 <heap_init>
  10043b:	eb 91                	jmp    1003ce <malloc+0x19>
			set_allocated(bp, aligned_size);
  10043d:	4c 89 e6             	mov    %r12,%rsi
  100440:	48 89 df             	mov    %rbx,%rdi
  100443:	e8 d0 fe ff ff       	call   100318 <set_allocated>
			return bp;
  100448:	eb de                	jmp    100428 <malloc+0x73>
		return NULL;
  10044a:	bb 00 00 00 00       	mov    $0x0,%ebx
  10044f:	eb d7                	jmp    100428 <malloc+0x73>

0000000000100451 <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
    return 0;
}
  100451:	b8 00 00 00 00       	mov    $0x0,%eax
  100456:	c3                   	ret    

0000000000100457 <realloc>:

void *realloc(void * ptr, uint64_t sz) {
    return 0;
}
  100457:	b8 00 00 00 00       	mov    $0x0,%eax
  10045c:	c3                   	ret    

000000000010045d <defrag>:

void defrag() {
}
  10045d:	c3                   	ret    

000000000010045e <heap_info>:

int heap_info(heap_info_struct * info) {
    return 0;
}
  10045e:	b8 00 00 00 00       	mov    $0x0,%eax
  100463:	c3                   	ret    

0000000000100464 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100464:	55                   	push   %rbp
  100465:	48 89 e5             	mov    %rsp,%rbp
  100468:	48 83 ec 28          	sub    $0x28,%rsp
  10046c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100470:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100474:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100478:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10047c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100480:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100484:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100488:	eb 1c                	jmp    1004a6 <memcpy+0x42>
        *d = *s;
  10048a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10048e:	0f b6 10             	movzbl (%rax),%edx
  100491:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100495:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100497:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10049c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1004a1:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1004a6:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1004ab:	75 dd                	jne    10048a <memcpy+0x26>
    }
    return dst;
  1004ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1004b1:	c9                   	leave  
  1004b2:	c3                   	ret    

00000000001004b3 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1004b3:	55                   	push   %rbp
  1004b4:	48 89 e5             	mov    %rsp,%rbp
  1004b7:	48 83 ec 28          	sub    $0x28,%rsp
  1004bb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1004bf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1004c3:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1004c7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1004cb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  1004cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1004d3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  1004d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004db:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  1004df:	73 6a                	jae    10054b <memmove+0x98>
  1004e1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1004e5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1004e9:	48 01 d0             	add    %rdx,%rax
  1004ec:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1004f0:	73 59                	jae    10054b <memmove+0x98>
        s += n, d += n;
  1004f2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1004f6:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1004fa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1004fe:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  100502:	eb 17                	jmp    10051b <memmove+0x68>
            *--d = *--s;
  100504:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100509:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  10050e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100512:	0f b6 10             	movzbl (%rax),%edx
  100515:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100519:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  10051b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10051f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100523:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100527:	48 85 c0             	test   %rax,%rax
  10052a:	75 d8                	jne    100504 <memmove+0x51>
    if (s < d && s + n > d) {
  10052c:	eb 2e                	jmp    10055c <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  10052e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100532:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100536:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10053a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10053e:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100542:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100546:	0f b6 12             	movzbl (%rdx),%edx
  100549:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  10054b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10054f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100553:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100557:	48 85 c0             	test   %rax,%rax
  10055a:	75 d2                	jne    10052e <memmove+0x7b>
        }
    }
    return dst;
  10055c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100560:	c9                   	leave  
  100561:	c3                   	ret    

0000000000100562 <memset>:

void* memset(void* v, int c, size_t n) {
  100562:	55                   	push   %rbp
  100563:	48 89 e5             	mov    %rsp,%rbp
  100566:	48 83 ec 28          	sub    $0x28,%rsp
  10056a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10056e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100571:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100575:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100579:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10057d:	eb 15                	jmp    100594 <memset+0x32>
        *p = c;
  10057f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100582:	89 c2                	mov    %eax,%edx
  100584:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100588:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10058a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10058f:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100594:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100599:	75 e4                	jne    10057f <memset+0x1d>
    }
    return v;
  10059b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10059f:	c9                   	leave  
  1005a0:	c3                   	ret    

00000000001005a1 <strlen>:

size_t strlen(const char* s) {
  1005a1:	55                   	push   %rbp
  1005a2:	48 89 e5             	mov    %rsp,%rbp
  1005a5:	48 83 ec 18          	sub    $0x18,%rsp
  1005a9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  1005ad:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1005b4:	00 
  1005b5:	eb 0a                	jmp    1005c1 <strlen+0x20>
        ++n;
  1005b7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  1005bc:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1005c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1005c5:	0f b6 00             	movzbl (%rax),%eax
  1005c8:	84 c0                	test   %al,%al
  1005ca:	75 eb                	jne    1005b7 <strlen+0x16>
    }
    return n;
  1005cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1005d0:	c9                   	leave  
  1005d1:	c3                   	ret    

00000000001005d2 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  1005d2:	55                   	push   %rbp
  1005d3:	48 89 e5             	mov    %rsp,%rbp
  1005d6:	48 83 ec 20          	sub    $0x20,%rsp
  1005da:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1005de:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1005e2:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1005e9:	00 
  1005ea:	eb 0a                	jmp    1005f6 <strnlen+0x24>
        ++n;
  1005ec:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1005f1:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1005f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005fa:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  1005fe:	74 0b                	je     10060b <strnlen+0x39>
  100600:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100604:	0f b6 00             	movzbl (%rax),%eax
  100607:	84 c0                	test   %al,%al
  100609:	75 e1                	jne    1005ec <strnlen+0x1a>
    }
    return n;
  10060b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  10060f:	c9                   	leave  
  100610:	c3                   	ret    

0000000000100611 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100611:	55                   	push   %rbp
  100612:	48 89 e5             	mov    %rsp,%rbp
  100615:	48 83 ec 20          	sub    $0x20,%rsp
  100619:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10061d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  100621:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100625:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100629:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  10062d:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100631:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100635:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100639:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10063d:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100641:	0f b6 12             	movzbl (%rdx),%edx
  100644:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100646:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10064a:	48 83 e8 01          	sub    $0x1,%rax
  10064e:	0f b6 00             	movzbl (%rax),%eax
  100651:	84 c0                	test   %al,%al
  100653:	75 d4                	jne    100629 <strcpy+0x18>
    return dst;
  100655:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100659:	c9                   	leave  
  10065a:	c3                   	ret    

000000000010065b <strcmp>:

int strcmp(const char* a, const char* b) {
  10065b:	55                   	push   %rbp
  10065c:	48 89 e5             	mov    %rsp,%rbp
  10065f:	48 83 ec 10          	sub    $0x10,%rsp
  100663:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100667:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10066b:	eb 0a                	jmp    100677 <strcmp+0x1c>
        ++a, ++b;
  10066d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100672:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100677:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10067b:	0f b6 00             	movzbl (%rax),%eax
  10067e:	84 c0                	test   %al,%al
  100680:	74 1d                	je     10069f <strcmp+0x44>
  100682:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100686:	0f b6 00             	movzbl (%rax),%eax
  100689:	84 c0                	test   %al,%al
  10068b:	74 12                	je     10069f <strcmp+0x44>
  10068d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100691:	0f b6 10             	movzbl (%rax),%edx
  100694:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100698:	0f b6 00             	movzbl (%rax),%eax
  10069b:	38 c2                	cmp    %al,%dl
  10069d:	74 ce                	je     10066d <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  10069f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006a3:	0f b6 00             	movzbl (%rax),%eax
  1006a6:	89 c2                	mov    %eax,%edx
  1006a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1006ac:	0f b6 00             	movzbl (%rax),%eax
  1006af:	38 d0                	cmp    %dl,%al
  1006b1:	0f 92 c0             	setb   %al
  1006b4:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  1006b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006bb:	0f b6 00             	movzbl (%rax),%eax
  1006be:	89 c1                	mov    %eax,%ecx
  1006c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1006c4:	0f b6 00             	movzbl (%rax),%eax
  1006c7:	38 c1                	cmp    %al,%cl
  1006c9:	0f 92 c0             	setb   %al
  1006cc:	0f b6 c0             	movzbl %al,%eax
  1006cf:	29 c2                	sub    %eax,%edx
  1006d1:	89 d0                	mov    %edx,%eax
}
  1006d3:	c9                   	leave  
  1006d4:	c3                   	ret    

00000000001006d5 <strchr>:

char* strchr(const char* s, int c) {
  1006d5:	55                   	push   %rbp
  1006d6:	48 89 e5             	mov    %rsp,%rbp
  1006d9:	48 83 ec 10          	sub    $0x10,%rsp
  1006dd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1006e1:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1006e4:	eb 05                	jmp    1006eb <strchr+0x16>
        ++s;
  1006e6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1006eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006ef:	0f b6 00             	movzbl (%rax),%eax
  1006f2:	84 c0                	test   %al,%al
  1006f4:	74 0e                	je     100704 <strchr+0x2f>
  1006f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006fa:	0f b6 00             	movzbl (%rax),%eax
  1006fd:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100700:	38 d0                	cmp    %dl,%al
  100702:	75 e2                	jne    1006e6 <strchr+0x11>
    }
    if (*s == (char) c) {
  100704:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100708:	0f b6 00             	movzbl (%rax),%eax
  10070b:	8b 55 f4             	mov    -0xc(%rbp),%edx
  10070e:	38 d0                	cmp    %dl,%al
  100710:	75 06                	jne    100718 <strchr+0x43>
        return (char*) s;
  100712:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100716:	eb 05                	jmp    10071d <strchr+0x48>
    } else {
        return NULL;
  100718:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  10071d:	c9                   	leave  
  10071e:	c3                   	ret    

000000000010071f <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  10071f:	55                   	push   %rbp
  100720:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  100723:	8b 05 f7 1c 00 00    	mov    0x1cf7(%rip),%eax        # 102420 <rand_seed_set>
  100729:	85 c0                	test   %eax,%eax
  10072b:	75 0a                	jne    100737 <rand+0x18>
        srand(819234718U);
  10072d:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100732:	e8 24 00 00 00       	call   10075b <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100737:	8b 05 e7 1c 00 00    	mov    0x1ce7(%rip),%eax        # 102424 <rand_seed>
  10073d:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100743:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100748:	89 05 d6 1c 00 00    	mov    %eax,0x1cd6(%rip)        # 102424 <rand_seed>
    return rand_seed & RAND_MAX;
  10074e:	8b 05 d0 1c 00 00    	mov    0x1cd0(%rip),%eax        # 102424 <rand_seed>
  100754:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100759:	5d                   	pop    %rbp
  10075a:	c3                   	ret    

000000000010075b <srand>:

void srand(unsigned seed) {
  10075b:	55                   	push   %rbp
  10075c:	48 89 e5             	mov    %rsp,%rbp
  10075f:	48 83 ec 08          	sub    $0x8,%rsp
  100763:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100766:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100769:	89 05 b5 1c 00 00    	mov    %eax,0x1cb5(%rip)        # 102424 <rand_seed>
    rand_seed_set = 1;
  10076f:	c7 05 a7 1c 00 00 01 	movl   $0x1,0x1ca7(%rip)        # 102420 <rand_seed_set>
  100776:	00 00 00 
}
  100779:	90                   	nop
  10077a:	c9                   	leave  
  10077b:	c3                   	ret    

000000000010077c <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  10077c:	55                   	push   %rbp
  10077d:	48 89 e5             	mov    %rsp,%rbp
  100780:	48 83 ec 28          	sub    $0x28,%rsp
  100784:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100788:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10078c:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  10078f:	48 c7 45 f8 10 17 10 	movq   $0x101710,-0x8(%rbp)
  100796:	00 
    if (base < 0) {
  100797:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  10079b:	79 0b                	jns    1007a8 <fill_numbuf+0x2c>
        digits = lower_digits;
  10079d:	48 c7 45 f8 30 17 10 	movq   $0x101730,-0x8(%rbp)
  1007a4:	00 
        base = -base;
  1007a5:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  1007a8:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1007ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1007b1:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  1007b4:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1007b7:	48 63 c8             	movslq %eax,%rcx
  1007ba:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1007be:	ba 00 00 00 00       	mov    $0x0,%edx
  1007c3:	48 f7 f1             	div    %rcx
  1007c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007ca:	48 01 d0             	add    %rdx,%rax
  1007cd:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1007d2:	0f b6 10             	movzbl (%rax),%edx
  1007d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1007d9:	88 10                	mov    %dl,(%rax)
        val /= base;
  1007db:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1007de:	48 63 f0             	movslq %eax,%rsi
  1007e1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1007e5:	ba 00 00 00 00       	mov    $0x0,%edx
  1007ea:	48 f7 f6             	div    %rsi
  1007ed:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  1007f1:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  1007f6:	75 bc                	jne    1007b4 <fill_numbuf+0x38>
    return numbuf_end;
  1007f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1007fc:	c9                   	leave  
  1007fd:	c3                   	ret    

00000000001007fe <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1007fe:	55                   	push   %rbp
  1007ff:	48 89 e5             	mov    %rsp,%rbp
  100802:	53                   	push   %rbx
  100803:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  10080a:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100811:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100817:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10081e:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100825:	e9 8a 09 00 00       	jmp    1011b4 <printer_vprintf+0x9b6>
        if (*format != '%') {
  10082a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100831:	0f b6 00             	movzbl (%rax),%eax
  100834:	3c 25                	cmp    $0x25,%al
  100836:	74 31                	je     100869 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  100838:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10083f:	4c 8b 00             	mov    (%rax),%r8
  100842:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100849:	0f b6 00             	movzbl (%rax),%eax
  10084c:	0f b6 c8             	movzbl %al,%ecx
  10084f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100855:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10085c:	89 ce                	mov    %ecx,%esi
  10085e:	48 89 c7             	mov    %rax,%rdi
  100861:	41 ff d0             	call   *%r8
            continue;
  100864:	e9 43 09 00 00       	jmp    1011ac <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100869:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100870:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100877:	01 
  100878:	eb 44                	jmp    1008be <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  10087a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100881:	0f b6 00             	movzbl (%rax),%eax
  100884:	0f be c0             	movsbl %al,%eax
  100887:	89 c6                	mov    %eax,%esi
  100889:	bf 30 15 10 00       	mov    $0x101530,%edi
  10088e:	e8 42 fe ff ff       	call   1006d5 <strchr>
  100893:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100897:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  10089c:	74 30                	je     1008ce <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  10089e:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  1008a2:	48 2d 30 15 10 00    	sub    $0x101530,%rax
  1008a8:	ba 01 00 00 00       	mov    $0x1,%edx
  1008ad:	89 c1                	mov    %eax,%ecx
  1008af:	d3 e2                	shl    %cl,%edx
  1008b1:	89 d0                	mov    %edx,%eax
  1008b3:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  1008b6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1008bd:	01 
  1008be:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008c5:	0f b6 00             	movzbl (%rax),%eax
  1008c8:	84 c0                	test   %al,%al
  1008ca:	75 ae                	jne    10087a <printer_vprintf+0x7c>
  1008cc:	eb 01                	jmp    1008cf <printer_vprintf+0xd1>
            } else {
                break;
  1008ce:	90                   	nop
            }
        }

        // process width
        int width = -1;
  1008cf:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  1008d6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008dd:	0f b6 00             	movzbl (%rax),%eax
  1008e0:	3c 30                	cmp    $0x30,%al
  1008e2:	7e 67                	jle    10094b <printer_vprintf+0x14d>
  1008e4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008eb:	0f b6 00             	movzbl (%rax),%eax
  1008ee:	3c 39                	cmp    $0x39,%al
  1008f0:	7f 59                	jg     10094b <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1008f2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  1008f9:	eb 2e                	jmp    100929 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  1008fb:	8b 55 e8             	mov    -0x18(%rbp),%edx
  1008fe:	89 d0                	mov    %edx,%eax
  100900:	c1 e0 02             	shl    $0x2,%eax
  100903:	01 d0                	add    %edx,%eax
  100905:	01 c0                	add    %eax,%eax
  100907:	89 c1                	mov    %eax,%ecx
  100909:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100910:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100914:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10091b:	0f b6 00             	movzbl (%rax),%eax
  10091e:	0f be c0             	movsbl %al,%eax
  100921:	01 c8                	add    %ecx,%eax
  100923:	83 e8 30             	sub    $0x30,%eax
  100926:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100929:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100930:	0f b6 00             	movzbl (%rax),%eax
  100933:	3c 2f                	cmp    $0x2f,%al
  100935:	0f 8e 85 00 00 00    	jle    1009c0 <printer_vprintf+0x1c2>
  10093b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100942:	0f b6 00             	movzbl (%rax),%eax
  100945:	3c 39                	cmp    $0x39,%al
  100947:	7e b2                	jle    1008fb <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100949:	eb 75                	jmp    1009c0 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  10094b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100952:	0f b6 00             	movzbl (%rax),%eax
  100955:	3c 2a                	cmp    $0x2a,%al
  100957:	75 68                	jne    1009c1 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100959:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100960:	8b 00                	mov    (%rax),%eax
  100962:	83 f8 2f             	cmp    $0x2f,%eax
  100965:	77 30                	ja     100997 <printer_vprintf+0x199>
  100967:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10096e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100972:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100979:	8b 00                	mov    (%rax),%eax
  10097b:	89 c0                	mov    %eax,%eax
  10097d:	48 01 d0             	add    %rdx,%rax
  100980:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100987:	8b 12                	mov    (%rdx),%edx
  100989:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10098c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100993:	89 0a                	mov    %ecx,(%rdx)
  100995:	eb 1a                	jmp    1009b1 <printer_vprintf+0x1b3>
  100997:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10099e:	48 8b 40 08          	mov    0x8(%rax),%rax
  1009a2:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1009a6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009ad:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1009b1:	8b 00                	mov    (%rax),%eax
  1009b3:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  1009b6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1009bd:	01 
  1009be:	eb 01                	jmp    1009c1 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  1009c0:	90                   	nop
        }

        // process precision
        int precision = -1;
  1009c1:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  1009c8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009cf:	0f b6 00             	movzbl (%rax),%eax
  1009d2:	3c 2e                	cmp    $0x2e,%al
  1009d4:	0f 85 00 01 00 00    	jne    100ada <printer_vprintf+0x2dc>
            ++format;
  1009da:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1009e1:	01 
            if (*format >= '0' && *format <= '9') {
  1009e2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009e9:	0f b6 00             	movzbl (%rax),%eax
  1009ec:	3c 2f                	cmp    $0x2f,%al
  1009ee:	7e 67                	jle    100a57 <printer_vprintf+0x259>
  1009f0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009f7:	0f b6 00             	movzbl (%rax),%eax
  1009fa:	3c 39                	cmp    $0x39,%al
  1009fc:	7f 59                	jg     100a57 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1009fe:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100a05:	eb 2e                	jmp    100a35 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100a07:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100a0a:	89 d0                	mov    %edx,%eax
  100a0c:	c1 e0 02             	shl    $0x2,%eax
  100a0f:	01 d0                	add    %edx,%eax
  100a11:	01 c0                	add    %eax,%eax
  100a13:	89 c1                	mov    %eax,%ecx
  100a15:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a1c:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100a20:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100a27:	0f b6 00             	movzbl (%rax),%eax
  100a2a:	0f be c0             	movsbl %al,%eax
  100a2d:	01 c8                	add    %ecx,%eax
  100a2f:	83 e8 30             	sub    $0x30,%eax
  100a32:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100a35:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a3c:	0f b6 00             	movzbl (%rax),%eax
  100a3f:	3c 2f                	cmp    $0x2f,%al
  100a41:	0f 8e 85 00 00 00    	jle    100acc <printer_vprintf+0x2ce>
  100a47:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a4e:	0f b6 00             	movzbl (%rax),%eax
  100a51:	3c 39                	cmp    $0x39,%al
  100a53:	7e b2                	jle    100a07 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100a55:	eb 75                	jmp    100acc <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100a57:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a5e:	0f b6 00             	movzbl (%rax),%eax
  100a61:	3c 2a                	cmp    $0x2a,%al
  100a63:	75 68                	jne    100acd <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100a65:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a6c:	8b 00                	mov    (%rax),%eax
  100a6e:	83 f8 2f             	cmp    $0x2f,%eax
  100a71:	77 30                	ja     100aa3 <printer_vprintf+0x2a5>
  100a73:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a7a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a7e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a85:	8b 00                	mov    (%rax),%eax
  100a87:	89 c0                	mov    %eax,%eax
  100a89:	48 01 d0             	add    %rdx,%rax
  100a8c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a93:	8b 12                	mov    (%rdx),%edx
  100a95:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a98:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a9f:	89 0a                	mov    %ecx,(%rdx)
  100aa1:	eb 1a                	jmp    100abd <printer_vprintf+0x2bf>
  100aa3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100aaa:	48 8b 40 08          	mov    0x8(%rax),%rax
  100aae:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ab2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ab9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100abd:	8b 00                	mov    (%rax),%eax
  100abf:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100ac2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ac9:	01 
  100aca:	eb 01                	jmp    100acd <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100acc:	90                   	nop
            }
            if (precision < 0) {
  100acd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100ad1:	79 07                	jns    100ada <printer_vprintf+0x2dc>
                precision = 0;
  100ad3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100ada:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100ae1:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100ae8:	00 
        int length = 0;
  100ae9:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100af0:	48 c7 45 c8 36 15 10 	movq   $0x101536,-0x38(%rbp)
  100af7:	00 
    again:
        switch (*format) {
  100af8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100aff:	0f b6 00             	movzbl (%rax),%eax
  100b02:	0f be c0             	movsbl %al,%eax
  100b05:	83 e8 43             	sub    $0x43,%eax
  100b08:	83 f8 37             	cmp    $0x37,%eax
  100b0b:	0f 87 9f 03 00 00    	ja     100eb0 <printer_vprintf+0x6b2>
  100b11:	89 c0                	mov    %eax,%eax
  100b13:	48 8b 04 c5 48 15 10 	mov    0x101548(,%rax,8),%rax
  100b1a:	00 
  100b1b:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100b1d:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100b24:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100b2b:	01 
            goto again;
  100b2c:	eb ca                	jmp    100af8 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100b2e:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100b32:	74 5d                	je     100b91 <printer_vprintf+0x393>
  100b34:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b3b:	8b 00                	mov    (%rax),%eax
  100b3d:	83 f8 2f             	cmp    $0x2f,%eax
  100b40:	77 30                	ja     100b72 <printer_vprintf+0x374>
  100b42:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b49:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b4d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b54:	8b 00                	mov    (%rax),%eax
  100b56:	89 c0                	mov    %eax,%eax
  100b58:	48 01 d0             	add    %rdx,%rax
  100b5b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b62:	8b 12                	mov    (%rdx),%edx
  100b64:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b67:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b6e:	89 0a                	mov    %ecx,(%rdx)
  100b70:	eb 1a                	jmp    100b8c <printer_vprintf+0x38e>
  100b72:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b79:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b7d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b81:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b88:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b8c:	48 8b 00             	mov    (%rax),%rax
  100b8f:	eb 5c                	jmp    100bed <printer_vprintf+0x3ef>
  100b91:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b98:	8b 00                	mov    (%rax),%eax
  100b9a:	83 f8 2f             	cmp    $0x2f,%eax
  100b9d:	77 30                	ja     100bcf <printer_vprintf+0x3d1>
  100b9f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ba6:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100baa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bb1:	8b 00                	mov    (%rax),%eax
  100bb3:	89 c0                	mov    %eax,%eax
  100bb5:	48 01 d0             	add    %rdx,%rax
  100bb8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bbf:	8b 12                	mov    (%rdx),%edx
  100bc1:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bc4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bcb:	89 0a                	mov    %ecx,(%rdx)
  100bcd:	eb 1a                	jmp    100be9 <printer_vprintf+0x3eb>
  100bcf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bd6:	48 8b 40 08          	mov    0x8(%rax),%rax
  100bda:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100bde:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100be5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100be9:	8b 00                	mov    (%rax),%eax
  100beb:	48 98                	cltq   
  100bed:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100bf1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100bf5:	48 c1 f8 38          	sar    $0x38,%rax
  100bf9:	25 80 00 00 00       	and    $0x80,%eax
  100bfe:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100c01:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100c05:	74 09                	je     100c10 <printer_vprintf+0x412>
  100c07:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100c0b:	48 f7 d8             	neg    %rax
  100c0e:	eb 04                	jmp    100c14 <printer_vprintf+0x416>
  100c10:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100c14:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100c18:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100c1b:	83 c8 60             	or     $0x60,%eax
  100c1e:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100c21:	e9 cf 02 00 00       	jmp    100ef5 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100c26:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100c2a:	74 5d                	je     100c89 <printer_vprintf+0x48b>
  100c2c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c33:	8b 00                	mov    (%rax),%eax
  100c35:	83 f8 2f             	cmp    $0x2f,%eax
  100c38:	77 30                	ja     100c6a <printer_vprintf+0x46c>
  100c3a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c41:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c45:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c4c:	8b 00                	mov    (%rax),%eax
  100c4e:	89 c0                	mov    %eax,%eax
  100c50:	48 01 d0             	add    %rdx,%rax
  100c53:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c5a:	8b 12                	mov    (%rdx),%edx
  100c5c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c5f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c66:	89 0a                	mov    %ecx,(%rdx)
  100c68:	eb 1a                	jmp    100c84 <printer_vprintf+0x486>
  100c6a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c71:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c75:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c79:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c80:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c84:	48 8b 00             	mov    (%rax),%rax
  100c87:	eb 5c                	jmp    100ce5 <printer_vprintf+0x4e7>
  100c89:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c90:	8b 00                	mov    (%rax),%eax
  100c92:	83 f8 2f             	cmp    $0x2f,%eax
  100c95:	77 30                	ja     100cc7 <printer_vprintf+0x4c9>
  100c97:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c9e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ca2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ca9:	8b 00                	mov    (%rax),%eax
  100cab:	89 c0                	mov    %eax,%eax
  100cad:	48 01 d0             	add    %rdx,%rax
  100cb0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cb7:	8b 12                	mov    (%rdx),%edx
  100cb9:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100cbc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cc3:	89 0a                	mov    %ecx,(%rdx)
  100cc5:	eb 1a                	jmp    100ce1 <printer_vprintf+0x4e3>
  100cc7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cce:	48 8b 40 08          	mov    0x8(%rax),%rax
  100cd2:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100cd6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cdd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ce1:	8b 00                	mov    (%rax),%eax
  100ce3:	89 c0                	mov    %eax,%eax
  100ce5:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100ce9:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100ced:	e9 03 02 00 00       	jmp    100ef5 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100cf2:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100cf9:	e9 28 ff ff ff       	jmp    100c26 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100cfe:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100d05:	e9 1c ff ff ff       	jmp    100c26 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100d0a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d11:	8b 00                	mov    (%rax),%eax
  100d13:	83 f8 2f             	cmp    $0x2f,%eax
  100d16:	77 30                	ja     100d48 <printer_vprintf+0x54a>
  100d18:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d1f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d23:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d2a:	8b 00                	mov    (%rax),%eax
  100d2c:	89 c0                	mov    %eax,%eax
  100d2e:	48 01 d0             	add    %rdx,%rax
  100d31:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d38:	8b 12                	mov    (%rdx),%edx
  100d3a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d3d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d44:	89 0a                	mov    %ecx,(%rdx)
  100d46:	eb 1a                	jmp    100d62 <printer_vprintf+0x564>
  100d48:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d4f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d53:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d57:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d5e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d62:	48 8b 00             	mov    (%rax),%rax
  100d65:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100d69:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100d70:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100d77:	e9 79 01 00 00       	jmp    100ef5 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100d7c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d83:	8b 00                	mov    (%rax),%eax
  100d85:	83 f8 2f             	cmp    $0x2f,%eax
  100d88:	77 30                	ja     100dba <printer_vprintf+0x5bc>
  100d8a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d91:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d95:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d9c:	8b 00                	mov    (%rax),%eax
  100d9e:	89 c0                	mov    %eax,%eax
  100da0:	48 01 d0             	add    %rdx,%rax
  100da3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100daa:	8b 12                	mov    (%rdx),%edx
  100dac:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100daf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100db6:	89 0a                	mov    %ecx,(%rdx)
  100db8:	eb 1a                	jmp    100dd4 <printer_vprintf+0x5d6>
  100dba:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dc1:	48 8b 40 08          	mov    0x8(%rax),%rax
  100dc5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100dc9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dd0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100dd4:	48 8b 00             	mov    (%rax),%rax
  100dd7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100ddb:	e9 15 01 00 00       	jmp    100ef5 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100de0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100de7:	8b 00                	mov    (%rax),%eax
  100de9:	83 f8 2f             	cmp    $0x2f,%eax
  100dec:	77 30                	ja     100e1e <printer_vprintf+0x620>
  100dee:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100df5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100df9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e00:	8b 00                	mov    (%rax),%eax
  100e02:	89 c0                	mov    %eax,%eax
  100e04:	48 01 d0             	add    %rdx,%rax
  100e07:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e0e:	8b 12                	mov    (%rdx),%edx
  100e10:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e13:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e1a:	89 0a                	mov    %ecx,(%rdx)
  100e1c:	eb 1a                	jmp    100e38 <printer_vprintf+0x63a>
  100e1e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e25:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e29:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e2d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e34:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e38:	8b 00                	mov    (%rax),%eax
  100e3a:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100e40:	e9 67 03 00 00       	jmp    1011ac <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  100e45:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100e49:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100e4d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e54:	8b 00                	mov    (%rax),%eax
  100e56:	83 f8 2f             	cmp    $0x2f,%eax
  100e59:	77 30                	ja     100e8b <printer_vprintf+0x68d>
  100e5b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e62:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e66:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e6d:	8b 00                	mov    (%rax),%eax
  100e6f:	89 c0                	mov    %eax,%eax
  100e71:	48 01 d0             	add    %rdx,%rax
  100e74:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e7b:	8b 12                	mov    (%rdx),%edx
  100e7d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e80:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e87:	89 0a                	mov    %ecx,(%rdx)
  100e89:	eb 1a                	jmp    100ea5 <printer_vprintf+0x6a7>
  100e8b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e92:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e96:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e9a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ea1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ea5:	8b 00                	mov    (%rax),%eax
  100ea7:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100eaa:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100eae:	eb 45                	jmp    100ef5 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  100eb0:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100eb4:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100eb8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ebf:	0f b6 00             	movzbl (%rax),%eax
  100ec2:	84 c0                	test   %al,%al
  100ec4:	74 0c                	je     100ed2 <printer_vprintf+0x6d4>
  100ec6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ecd:	0f b6 00             	movzbl (%rax),%eax
  100ed0:	eb 05                	jmp    100ed7 <printer_vprintf+0x6d9>
  100ed2:	b8 25 00 00 00       	mov    $0x25,%eax
  100ed7:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100eda:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100ede:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ee5:	0f b6 00             	movzbl (%rax),%eax
  100ee8:	84 c0                	test   %al,%al
  100eea:	75 08                	jne    100ef4 <printer_vprintf+0x6f6>
                format--;
  100eec:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100ef3:	01 
            }
            break;
  100ef4:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100ef5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ef8:	83 e0 20             	and    $0x20,%eax
  100efb:	85 c0                	test   %eax,%eax
  100efd:	74 1e                	je     100f1d <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100eff:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100f03:	48 83 c0 18          	add    $0x18,%rax
  100f07:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100f0a:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100f0e:	48 89 ce             	mov    %rcx,%rsi
  100f11:	48 89 c7             	mov    %rax,%rdi
  100f14:	e8 63 f8 ff ff       	call   10077c <fill_numbuf>
  100f19:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100f1d:	48 c7 45 c0 36 15 10 	movq   $0x101536,-0x40(%rbp)
  100f24:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100f25:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f28:	83 e0 20             	and    $0x20,%eax
  100f2b:	85 c0                	test   %eax,%eax
  100f2d:	74 48                	je     100f77 <printer_vprintf+0x779>
  100f2f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f32:	83 e0 40             	and    $0x40,%eax
  100f35:	85 c0                	test   %eax,%eax
  100f37:	74 3e                	je     100f77 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  100f39:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f3c:	25 80 00 00 00       	and    $0x80,%eax
  100f41:	85 c0                	test   %eax,%eax
  100f43:	74 0a                	je     100f4f <printer_vprintf+0x751>
                prefix = "-";
  100f45:	48 c7 45 c0 37 15 10 	movq   $0x101537,-0x40(%rbp)
  100f4c:	00 
            if (flags & FLAG_NEGATIVE) {
  100f4d:	eb 73                	jmp    100fc2 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100f4f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f52:	83 e0 10             	and    $0x10,%eax
  100f55:	85 c0                	test   %eax,%eax
  100f57:	74 0a                	je     100f63 <printer_vprintf+0x765>
                prefix = "+";
  100f59:	48 c7 45 c0 39 15 10 	movq   $0x101539,-0x40(%rbp)
  100f60:	00 
            if (flags & FLAG_NEGATIVE) {
  100f61:	eb 5f                	jmp    100fc2 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100f63:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f66:	83 e0 08             	and    $0x8,%eax
  100f69:	85 c0                	test   %eax,%eax
  100f6b:	74 55                	je     100fc2 <printer_vprintf+0x7c4>
                prefix = " ";
  100f6d:	48 c7 45 c0 3b 15 10 	movq   $0x10153b,-0x40(%rbp)
  100f74:	00 
            if (flags & FLAG_NEGATIVE) {
  100f75:	eb 4b                	jmp    100fc2 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100f77:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f7a:	83 e0 20             	and    $0x20,%eax
  100f7d:	85 c0                	test   %eax,%eax
  100f7f:	74 42                	je     100fc3 <printer_vprintf+0x7c5>
  100f81:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f84:	83 e0 01             	and    $0x1,%eax
  100f87:	85 c0                	test   %eax,%eax
  100f89:	74 38                	je     100fc3 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  100f8b:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100f8f:	74 06                	je     100f97 <printer_vprintf+0x799>
  100f91:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100f95:	75 2c                	jne    100fc3 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  100f97:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100f9c:	75 0c                	jne    100faa <printer_vprintf+0x7ac>
  100f9e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fa1:	25 00 01 00 00       	and    $0x100,%eax
  100fa6:	85 c0                	test   %eax,%eax
  100fa8:	74 19                	je     100fc3 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  100faa:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100fae:	75 07                	jne    100fb7 <printer_vprintf+0x7b9>
  100fb0:	b8 3d 15 10 00       	mov    $0x10153d,%eax
  100fb5:	eb 05                	jmp    100fbc <printer_vprintf+0x7be>
  100fb7:	b8 40 15 10 00       	mov    $0x101540,%eax
  100fbc:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100fc0:	eb 01                	jmp    100fc3 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  100fc2:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100fc3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100fc7:	78 24                	js     100fed <printer_vprintf+0x7ef>
  100fc9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fcc:	83 e0 20             	and    $0x20,%eax
  100fcf:	85 c0                	test   %eax,%eax
  100fd1:	75 1a                	jne    100fed <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  100fd3:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100fd6:	48 63 d0             	movslq %eax,%rdx
  100fd9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100fdd:	48 89 d6             	mov    %rdx,%rsi
  100fe0:	48 89 c7             	mov    %rax,%rdi
  100fe3:	e8 ea f5 ff ff       	call   1005d2 <strnlen>
  100fe8:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100feb:	eb 0f                	jmp    100ffc <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  100fed:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100ff1:	48 89 c7             	mov    %rax,%rdi
  100ff4:	e8 a8 f5 ff ff       	call   1005a1 <strlen>
  100ff9:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100ffc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fff:	83 e0 20             	and    $0x20,%eax
  101002:	85 c0                	test   %eax,%eax
  101004:	74 20                	je     101026 <printer_vprintf+0x828>
  101006:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  10100a:	78 1a                	js     101026 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  10100c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10100f:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  101012:	7e 08                	jle    10101c <printer_vprintf+0x81e>
  101014:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101017:	2b 45 bc             	sub    -0x44(%rbp),%eax
  10101a:	eb 05                	jmp    101021 <printer_vprintf+0x823>
  10101c:	b8 00 00 00 00       	mov    $0x0,%eax
  101021:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101024:	eb 5c                	jmp    101082 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  101026:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101029:	83 e0 20             	and    $0x20,%eax
  10102c:	85 c0                	test   %eax,%eax
  10102e:	74 4b                	je     10107b <printer_vprintf+0x87d>
  101030:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101033:	83 e0 02             	and    $0x2,%eax
  101036:	85 c0                	test   %eax,%eax
  101038:	74 41                	je     10107b <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  10103a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10103d:	83 e0 04             	and    $0x4,%eax
  101040:	85 c0                	test   %eax,%eax
  101042:	75 37                	jne    10107b <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  101044:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101048:	48 89 c7             	mov    %rax,%rdi
  10104b:	e8 51 f5 ff ff       	call   1005a1 <strlen>
  101050:	89 c2                	mov    %eax,%edx
  101052:	8b 45 bc             	mov    -0x44(%rbp),%eax
  101055:	01 d0                	add    %edx,%eax
  101057:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  10105a:	7e 1f                	jle    10107b <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  10105c:	8b 45 e8             	mov    -0x18(%rbp),%eax
  10105f:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101062:	89 c3                	mov    %eax,%ebx
  101064:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101068:	48 89 c7             	mov    %rax,%rdi
  10106b:	e8 31 f5 ff ff       	call   1005a1 <strlen>
  101070:	89 c2                	mov    %eax,%edx
  101072:	89 d8                	mov    %ebx,%eax
  101074:	29 d0                	sub    %edx,%eax
  101076:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101079:	eb 07                	jmp    101082 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  10107b:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  101082:	8b 55 bc             	mov    -0x44(%rbp),%edx
  101085:	8b 45 b8             	mov    -0x48(%rbp),%eax
  101088:	01 d0                	add    %edx,%eax
  10108a:	48 63 d8             	movslq %eax,%rbx
  10108d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101091:	48 89 c7             	mov    %rax,%rdi
  101094:	e8 08 f5 ff ff       	call   1005a1 <strlen>
  101099:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  10109d:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1010a0:	29 d0                	sub    %edx,%eax
  1010a2:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1010a5:	eb 25                	jmp    1010cc <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  1010a7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010ae:	48 8b 08             	mov    (%rax),%rcx
  1010b1:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1010b7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010be:	be 20 00 00 00       	mov    $0x20,%esi
  1010c3:	48 89 c7             	mov    %rax,%rdi
  1010c6:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1010c8:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1010cc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010cf:	83 e0 04             	and    $0x4,%eax
  1010d2:	85 c0                	test   %eax,%eax
  1010d4:	75 36                	jne    10110c <printer_vprintf+0x90e>
  1010d6:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1010da:	7f cb                	jg     1010a7 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  1010dc:	eb 2e                	jmp    10110c <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  1010de:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010e5:	4c 8b 00             	mov    (%rax),%r8
  1010e8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1010ec:	0f b6 00             	movzbl (%rax),%eax
  1010ef:	0f b6 c8             	movzbl %al,%ecx
  1010f2:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1010f8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010ff:	89 ce                	mov    %ecx,%esi
  101101:	48 89 c7             	mov    %rax,%rdi
  101104:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  101107:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  10110c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101110:	0f b6 00             	movzbl (%rax),%eax
  101113:	84 c0                	test   %al,%al
  101115:	75 c7                	jne    1010de <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  101117:	eb 25                	jmp    10113e <printer_vprintf+0x940>
            p->putc(p, '0', color);
  101119:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101120:	48 8b 08             	mov    (%rax),%rcx
  101123:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101129:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101130:	be 30 00 00 00       	mov    $0x30,%esi
  101135:	48 89 c7             	mov    %rax,%rdi
  101138:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  10113a:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  10113e:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  101142:	7f d5                	jg     101119 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  101144:	eb 32                	jmp    101178 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  101146:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10114d:	4c 8b 00             	mov    (%rax),%r8
  101150:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101154:	0f b6 00             	movzbl (%rax),%eax
  101157:	0f b6 c8             	movzbl %al,%ecx
  10115a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101160:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101167:	89 ce                	mov    %ecx,%esi
  101169:	48 89 c7             	mov    %rax,%rdi
  10116c:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  10116f:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  101174:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  101178:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  10117c:	7f c8                	jg     101146 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  10117e:	eb 25                	jmp    1011a5 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  101180:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101187:	48 8b 08             	mov    (%rax),%rcx
  10118a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101190:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101197:	be 20 00 00 00       	mov    $0x20,%esi
  10119c:	48 89 c7             	mov    %rax,%rdi
  10119f:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  1011a1:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1011a5:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1011a9:	7f d5                	jg     101180 <printer_vprintf+0x982>
        }
    done: ;
  1011ab:	90                   	nop
    for (; *format; ++format) {
  1011ac:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1011b3:	01 
  1011b4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1011bb:	0f b6 00             	movzbl (%rax),%eax
  1011be:	84 c0                	test   %al,%al
  1011c0:	0f 85 64 f6 ff ff    	jne    10082a <printer_vprintf+0x2c>
    }
}
  1011c6:	90                   	nop
  1011c7:	90                   	nop
  1011c8:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1011cc:	c9                   	leave  
  1011cd:	c3                   	ret    

00000000001011ce <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1011ce:	55                   	push   %rbp
  1011cf:	48 89 e5             	mov    %rsp,%rbp
  1011d2:	48 83 ec 20          	sub    $0x20,%rsp
  1011d6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1011da:	89 f0                	mov    %esi,%eax
  1011dc:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1011df:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  1011e2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1011e6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1011ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011ee:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011f2:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  1011f7:	48 39 d0             	cmp    %rdx,%rax
  1011fa:	72 0c                	jb     101208 <console_putc+0x3a>
        cp->cursor = console;
  1011fc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101200:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  101207:	00 
    }
    if (c == '\n') {
  101208:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  10120c:	75 78                	jne    101286 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  10120e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101212:	48 8b 40 08          	mov    0x8(%rax),%rax
  101216:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  10121c:	48 d1 f8             	sar    %rax
  10121f:	48 89 c1             	mov    %rax,%rcx
  101222:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  101229:	66 66 66 
  10122c:	48 89 c8             	mov    %rcx,%rax
  10122f:	48 f7 ea             	imul   %rdx
  101232:	48 c1 fa 05          	sar    $0x5,%rdx
  101236:	48 89 c8             	mov    %rcx,%rax
  101239:	48 c1 f8 3f          	sar    $0x3f,%rax
  10123d:	48 29 c2             	sub    %rax,%rdx
  101240:	48 89 d0             	mov    %rdx,%rax
  101243:	48 c1 e0 02          	shl    $0x2,%rax
  101247:	48 01 d0             	add    %rdx,%rax
  10124a:	48 c1 e0 04          	shl    $0x4,%rax
  10124e:	48 29 c1             	sub    %rax,%rcx
  101251:	48 89 ca             	mov    %rcx,%rdx
  101254:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101257:	eb 25                	jmp    10127e <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  101259:	8b 45 e0             	mov    -0x20(%rbp),%eax
  10125c:	83 c8 20             	or     $0x20,%eax
  10125f:	89 c6                	mov    %eax,%esi
  101261:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101265:	48 8b 40 08          	mov    0x8(%rax),%rax
  101269:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10126d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101271:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101275:	89 f2                	mov    %esi,%edx
  101277:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  10127a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10127e:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101282:	75 d5                	jne    101259 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101284:	eb 24                	jmp    1012aa <console_putc+0xdc>
        *cp->cursor++ = c | color;
  101286:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  10128a:	8b 55 e0             	mov    -0x20(%rbp),%edx
  10128d:	09 d0                	or     %edx,%eax
  10128f:	89 c6                	mov    %eax,%esi
  101291:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101295:	48 8b 40 08          	mov    0x8(%rax),%rax
  101299:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10129d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1012a1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1012a5:	89 f2                	mov    %esi,%edx
  1012a7:	66 89 10             	mov    %dx,(%rax)
}
  1012aa:	90                   	nop
  1012ab:	c9                   	leave  
  1012ac:	c3                   	ret    

00000000001012ad <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1012ad:	55                   	push   %rbp
  1012ae:	48 89 e5             	mov    %rsp,%rbp
  1012b1:	48 83 ec 30          	sub    $0x30,%rsp
  1012b5:	89 7d ec             	mov    %edi,-0x14(%rbp)
  1012b8:	89 75 e8             	mov    %esi,-0x18(%rbp)
  1012bb:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1012bf:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  1012c3:	48 c7 45 f0 ce 11 10 	movq   $0x1011ce,-0x10(%rbp)
  1012ca:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1012cb:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  1012cf:	78 09                	js     1012da <console_vprintf+0x2d>
  1012d1:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  1012d8:	7e 07                	jle    1012e1 <console_vprintf+0x34>
        cpos = 0;
  1012da:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  1012e1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1012e4:	48 98                	cltq   
  1012e6:	48 01 c0             	add    %rax,%rax
  1012e9:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  1012ef:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1012f3:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1012f7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1012fb:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1012fe:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101302:	48 89 c7             	mov    %rax,%rdi
  101305:	e8 f4 f4 ff ff       	call   1007fe <printer_vprintf>
    return cp.cursor - console;
  10130a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10130e:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  101314:	48 d1 f8             	sar    %rax
}
  101317:	c9                   	leave  
  101318:	c3                   	ret    

0000000000101319 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  101319:	55                   	push   %rbp
  10131a:	48 89 e5             	mov    %rsp,%rbp
  10131d:	48 83 ec 60          	sub    $0x60,%rsp
  101321:	89 7d ac             	mov    %edi,-0x54(%rbp)
  101324:	89 75 a8             	mov    %esi,-0x58(%rbp)
  101327:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  10132b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10132f:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101333:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101337:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  10133e:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101342:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101346:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10134a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  10134e:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101352:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101356:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101359:	8b 45 ac             	mov    -0x54(%rbp),%eax
  10135c:	89 c7                	mov    %eax,%edi
  10135e:	e8 4a ff ff ff       	call   1012ad <console_vprintf>
  101363:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101366:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101369:	c9                   	leave  
  10136a:	c3                   	ret    

000000000010136b <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  10136b:	55                   	push   %rbp
  10136c:	48 89 e5             	mov    %rsp,%rbp
  10136f:	48 83 ec 20          	sub    $0x20,%rsp
  101373:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101377:	89 f0                	mov    %esi,%eax
  101379:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10137c:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  10137f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101383:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101387:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10138b:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10138f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101393:	48 8b 40 10          	mov    0x10(%rax),%rax
  101397:	48 39 c2             	cmp    %rax,%rdx
  10139a:	73 1a                	jae    1013b6 <string_putc+0x4b>
        *sp->s++ = c;
  10139c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1013a0:	48 8b 40 08          	mov    0x8(%rax),%rax
  1013a4:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1013a8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1013ac:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1013b0:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1013b4:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1013b6:	90                   	nop
  1013b7:	c9                   	leave  
  1013b8:	c3                   	ret    

00000000001013b9 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1013b9:	55                   	push   %rbp
  1013ba:	48 89 e5             	mov    %rsp,%rbp
  1013bd:	48 83 ec 40          	sub    $0x40,%rsp
  1013c1:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  1013c5:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  1013c9:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  1013cd:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1013d1:	48 c7 45 e8 6b 13 10 	movq   $0x10136b,-0x18(%rbp)
  1013d8:	00 
    sp.s = s;
  1013d9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1013dd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1013e1:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1013e6:	74 33                	je     10141b <vsnprintf+0x62>
        sp.end = s + size - 1;
  1013e8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1013ec:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1013f0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1013f4:	48 01 d0             	add    %rdx,%rax
  1013f7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1013fb:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1013ff:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101403:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101407:	be 00 00 00 00       	mov    $0x0,%esi
  10140c:	48 89 c7             	mov    %rax,%rdi
  10140f:	e8 ea f3 ff ff       	call   1007fe <printer_vprintf>
        *sp.s = 0;
  101414:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101418:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  10141b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10141f:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  101423:	c9                   	leave  
  101424:	c3                   	ret    

0000000000101425 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  101425:	55                   	push   %rbp
  101426:	48 89 e5             	mov    %rsp,%rbp
  101429:	48 83 ec 70          	sub    $0x70,%rsp
  10142d:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101431:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  101435:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101439:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10143d:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101441:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101445:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  10144c:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101450:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101454:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101458:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  10145c:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101460:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101464:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101468:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10146c:	48 89 c7             	mov    %rax,%rdi
  10146f:	e8 45 ff ff ff       	call   1013b9 <vsnprintf>
  101474:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101477:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  10147a:	c9                   	leave  
  10147b:	c3                   	ret    

000000000010147c <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  10147c:	55                   	push   %rbp
  10147d:	48 89 e5             	mov    %rsp,%rbp
  101480:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101484:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  10148b:	eb 13                	jmp    1014a0 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  10148d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  101490:	48 98                	cltq   
  101492:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  101499:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10149c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1014a0:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1014a7:	7e e4                	jle    10148d <console_clear+0x11>
    }
    cursorpos = 0;
  1014a9:	c7 05 49 7b fb ff 00 	movl   $0x0,-0x484b7(%rip)        # b8ffc <cursorpos>
  1014b0:	00 00 00 
}
  1014b3:	90                   	nop
  1014b4:	c9                   	leave  
  1014b5:	c3                   	ret    
