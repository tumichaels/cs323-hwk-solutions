
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
  100004:	41 57                	push   %r15
  100006:	41 56                	push   %r14
  100008:	41 55                	push   %r13
  10000a:	41 54                	push   %r12
  10000c:	53                   	push   %rbx
  10000d:	48 83 ec 08          	sub    $0x8,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100011:	cd 31                	int    $0x31
  100013:	89 c7                	mov    %eax,%edi
    pid_t p = getpid();
    srand(p);
  100015:	e8 03 09 00 00       	call   10091d <srand>
    heap_bottom = heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10001a:	b8 1f 34 10 00       	mov    $0x10341f,%eax
  10001f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100025:	48 89 05 cc 23 00 00 	mov    %rax,0x23cc(%rip)        # 1023f8 <heap_top>
  10002c:	48 89 05 bd 23 00 00 	mov    %rax,0x23bd(%rip)        # 1023f0 <heap_bottom>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100033:	48 89 e0             	mov    %rsp,%rax
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100036:	48 83 e8 01          	sub    $0x1,%rax
  10003a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100040:	48 89 05 a1 23 00 00 	mov    %rax,0x23a1(%rip)        # 1023e8 <stack_bottom>
  100047:	bb 01 00 00 00       	mov    $0x1,%ebx
  10004c:	41 89 df             	mov    %ebx,%r15d
void process_main(void) {
  10004f:	49 89 de             	mov    %rbx,%r14
  100052:	41 89 dd             	mov    %ebx,%r13d
  100055:	41 bc 01 00 00 00    	mov    $0x1,%r12d

    /* Single elements on heap of varying sizes */
    for(int i = 1; i < 64; ++i) {
        for(int j = 1; j < 64; ++j) {
            void *ptr = calloc(i,j);
  10005b:	4c 89 e6             	mov    %r12,%rsi
  10005e:	48 89 df             	mov    %rbx,%rdi
  100061:	e8 70 04 00 00       	call   1004d6 <calloc>
            assert(ptr != NULL);
  100066:	48 85 c0             	test   %rax,%rax
  100069:	74 55                	je     1000c0 <process_main+0xc0>

            for(int k = 0; k < i*j; ++k) {
  10006b:	48 89 c2             	mov    %rax,%rdx
  10006e:	4a 8d 0c 30          	lea    (%rax,%r14,1),%rcx
  100072:	45 85 ed             	test   %r13d,%r13d
  100075:	7e 0e                	jle    100085 <process_main+0x85>
                assert(((char *)ptr)[k] == 0);
  100077:	80 3a 00             	cmpb   $0x0,(%rdx)
  10007a:	75 58                	jne    1000d4 <process_main+0xd4>
            for(int k = 0; k < i*j; ++k) {
  10007c:	48 83 c2 01          	add    $0x1,%rdx
  100080:	48 39 ca             	cmp    %rcx,%rdx
  100083:	75 f2                	jne    100077 <process_main+0x77>
            }

            free(ptr);
  100085:	48 89 c7             	mov    %rax,%rdi
  100088:	e8 50 02 00 00       	call   1002dd <free>
        for(int j = 1; j < 64; ++j) {
  10008d:	49 83 c4 01          	add    $0x1,%r12
  100091:	45 01 fd             	add    %r15d,%r13d
  100094:	49 01 de             	add    %rbx,%r14
  100097:	49 83 fc 40          	cmp    $0x40,%r12
  10009b:	75 be                	jne    10005b <process_main+0x5b>
        }
        defrag();
  10009d:	b8 00 00 00 00       	mov    $0x0,%eax
  1000a2:	e8 9c 04 00 00       	call   100543 <defrag>
    for(int i = 1; i < 64; ++i) {
  1000a7:	48 83 c3 01          	add    $0x1,%rbx
  1000ab:	48 83 fb 40          	cmp    $0x40,%rbx
  1000af:	75 9b                	jne    10004c <process_main+0x4c>
//     defrag();
// 	
//     if (*((size_t *)((uintptr_t)ptr - 16)) == (1<<14))
// 	    panic("success!");

    TEST_PASS();
  1000b1:	bf b2 16 10 00       	mov    $0x1016b2,%edi
  1000b6:	b8 00 00 00 00       	mov    $0x0,%eax
  1000bb:	e8 b8 00 00 00       	call   100178 <kernel_panic>
            assert(ptr != NULL);
  1000c0:	ba 80 16 10 00       	mov    $0x101680,%edx
  1000c5:	be 18 00 00 00       	mov    $0x18,%esi
  1000ca:	bf 8c 16 10 00       	mov    $0x10168c,%edi
  1000cf:	e8 72 01 00 00       	call   100246 <assert_fail>
                assert(((char *)ptr)[k] == 0);
  1000d4:	ba 9c 16 10 00       	mov    $0x10169c,%edx
  1000d9:	be 1b 00 00 00       	mov    $0x1b,%esi
  1000de:	bf 8c 16 10 00       	mov    $0x10168c,%edi
  1000e3:	e8 5e 01 00 00       	call   100246 <assert_fail>

00000000001000e8 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  1000e8:	55                   	push   %rbp
  1000e9:	48 89 e5             	mov    %rsp,%rbp
  1000ec:	48 83 ec 50          	sub    $0x50,%rsp
  1000f0:	49 89 f2             	mov    %rsi,%r10
  1000f3:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1000f7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1000fb:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1000ff:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  100103:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100108:	85 ff                	test   %edi,%edi
  10010a:	78 2e                	js     10013a <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  10010c:	48 63 ff             	movslq %edi,%rdi
  10010f:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  100116:	cc cc cc 
  100119:	48 89 f8             	mov    %rdi,%rax
  10011c:	48 f7 e2             	mul    %rdx
  10011f:	48 89 d0             	mov    %rdx,%rax
  100122:	48 c1 e8 02          	shr    $0x2,%rax
  100126:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  10012a:	48 01 c2             	add    %rax,%rdx
  10012d:	48 29 d7             	sub    %rdx,%rdi
  100130:	0f b6 b7 05 17 10 00 	movzbl 0x101705(%rdi),%esi
  100137:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  10013a:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  100141:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100145:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100149:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10014d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  100151:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100155:	4c 89 d2             	mov    %r10,%rdx
  100158:	8b 3d 9e 8e fb ff    	mov    -0x47162(%rip),%edi        # b8ffc <cursorpos>
  10015e:	e8 0c 13 00 00       	call   10146f <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100163:	3d 30 07 00 00       	cmp    $0x730,%eax
  100168:	ba 00 00 00 00       	mov    $0x0,%edx
  10016d:	0f 4d c2             	cmovge %edx,%eax
  100170:	89 05 86 8e fb ff    	mov    %eax,-0x4717a(%rip)        # b8ffc <cursorpos>
    }
}
  100176:	c9                   	leave  
  100177:	c3                   	ret    

0000000000100178 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  100178:	55                   	push   %rbp
  100179:	48 89 e5             	mov    %rsp,%rbp
  10017c:	53                   	push   %rbx
  10017d:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100184:	48 89 fb             	mov    %rdi,%rbx
  100187:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  10018b:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  10018f:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100193:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100197:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  10019b:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  1001a2:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1001a6:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  1001aa:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  1001ae:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  1001b2:	ba 07 00 00 00       	mov    $0x7,%edx
  1001b7:	be cd 16 10 00       	mov    $0x1016cd,%esi
  1001bc:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  1001c3:	e8 5e 04 00 00       	call   100626 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  1001c8:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  1001cc:	48 89 da             	mov    %rbx,%rdx
  1001cf:	be 99 00 00 00       	mov    $0x99,%esi
  1001d4:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  1001db:	e8 9b 13 00 00       	call   10157b <vsnprintf>
  1001e0:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  1001e3:	85 d2                	test   %edx,%edx
  1001e5:	7e 0f                	jle    1001f6 <kernel_panic+0x7e>
  1001e7:	83 c0 06             	add    $0x6,%eax
  1001ea:	48 98                	cltq   
  1001ec:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  1001f3:	0a 
  1001f4:	75 2a                	jne    100220 <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  1001f6:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  1001fd:	48 89 d9             	mov    %rbx,%rcx
  100200:	ba d7 16 10 00       	mov    $0x1016d7,%edx
  100205:	be 00 c0 00 00       	mov    $0xc000,%esi
  10020a:	bf 30 07 00 00       	mov    $0x730,%edi
  10020f:	b8 00 00 00 00       	mov    $0x0,%eax
  100214:	e8 c2 12 00 00       	call   1014db <console_printf>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  100219:	48 89 df             	mov    %rbx,%rdi
  10021c:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  10021e:	eb fe                	jmp    10021e <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  100220:	48 63 c2             	movslq %edx,%rax
  100223:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  100229:	0f 94 c2             	sete   %dl
  10022c:	0f b6 d2             	movzbl %dl,%edx
  10022f:	48 29 d0             	sub    %rdx,%rax
  100232:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  100239:	ff 
  10023a:	be d5 16 10 00       	mov    $0x1016d5,%esi
  10023f:	e8 8f 05 00 00       	call   1007d3 <strcpy>
  100244:	eb b0                	jmp    1001f6 <kernel_panic+0x7e>

0000000000100246 <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  100246:	55                   	push   %rbp
  100247:	48 89 e5             	mov    %rsp,%rbp
  10024a:	48 89 f9             	mov    %rdi,%rcx
  10024d:	41 89 f0             	mov    %esi,%r8d
  100250:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100253:	ba e0 16 10 00       	mov    $0x1016e0,%edx
  100258:	be 00 c0 00 00       	mov    $0xc000,%esi
  10025d:	bf 30 07 00 00       	mov    $0x730,%edi
  100262:	b8 00 00 00 00       	mov    $0x0,%eax
  100267:	e8 6f 12 00 00       	call   1014db <console_printf>
    asm volatile ("int %0" : /* no result */
  10026c:	bf 00 00 00 00       	mov    $0x0,%edi
  100271:	cd 30                	int    $0x30
 loop: goto loop;
  100273:	eb fe                	jmp    100273 <assert_fail+0x2d>

0000000000100275 <heap_init>:
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  100275:	bf 10 00 00 00       	mov    $0x10,%edi
  10027a:	cd 3a                	int    $0x3a
  10027c:	48 89 05 8d 21 00 00 	mov    %rax,0x218d(%rip)        # 102410 <result.0>
  100283:	cd 3a                	int    $0x3a
  100285:	48 89 c2             	mov    %rax,%rdx
  100288:	48 89 05 81 21 00 00 	mov    %rax,0x2181(%rip)        # 102410 <result.0>
	// prologue block
	void *prologue_block;
	sbrk(sizeof(block_header));
	prologue_block = sbrk(sizeof(block_footer));

	GET_SIZE(HDRP(prologue_block)) = sizeof(block_header) + sizeof(block_footer);
  10028f:	48 c7 40 f0 20 00 00 	movq   $0x20,-0x10(%rax)
  100296:	00 
	GET_ALLOC(HDRP(prologue_block)) = 1;
  100297:	c7 40 f8 01 00 00 00 	movl   $0x1,-0x8(%rax)
	GET_SIZE(FTRP(prologue_block)) = sizeof(block_header) + sizeof(block_footer);
  10029e:	48 c7 00 20 00 00 00 	movq   $0x20,(%rax)
  1002a5:	cd 3a                	int    $0x3a
  1002a7:	48 89 05 62 21 00 00 	mov    %rax,0x2162(%rip)        # 102410 <result.0>

	// terminal block
	sbrk(sizeof(block_header));
	GET_SIZE(HDRP(NEXT_BLKP(prologue_block))) = 0;
  1002ae:	48 8b 42 f0          	mov    -0x10(%rdx),%rax
  1002b2:	48 c7 44 02 f0 00 00 	movq   $0x0,-0x10(%rdx,%rax,1)
  1002b9:	00 00 
	GET_ALLOC(HDRP(NEXT_BLKP(prologue_block))) = 0;
  1002bb:	48 8b 42 f0          	mov    -0x10(%rdx),%rax
  1002bf:	c7 44 02 f8 00 00 00 	movl   $0x0,-0x8(%rdx,%rax,1)
  1002c6:	00 

	free_list = NULL;
  1002c7:	48 c7 05 2e 21 00 00 	movq   $0x0,0x212e(%rip)        # 102400 <free_list>
  1002ce:	00 00 00 00 

	initialized_heap = 1;
  1002d2:	c7 05 2c 21 00 00 01 	movl   $0x1,0x212c(%rip)        # 102408 <initialized_heap>
  1002d9:	00 00 00 
}
  1002dc:	c3                   	ret    

00000000001002dd <free>:

void free(void *firstbyte) {
	if (firstbyte == NULL)
  1002dd:	48 85 ff             	test   %rdi,%rdi
  1002e0:	74 34                	je     100316 <free+0x39>
		return;

	// setup free things: alloc, list ptrs, footer
	GET_ALLOC(HDRP(firstbyte)) = 0;
  1002e2:	c7 47 f8 00 00 00 00 	movl   $0x0,-0x8(%rdi)
	NEXT_FPTR(firstbyte) = free_list;
  1002e9:	48 8b 05 10 21 00 00 	mov    0x2110(%rip),%rax        # 102400 <free_list>
  1002f0:	48 89 07             	mov    %rax,(%rdi)
	PREV_FPTR(firstbyte) = NULL;
  1002f3:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  1002fa:	00 
	GET_SIZE(FTRP(firstbyte)) = GET_SIZE(HDRP(firstbyte));
  1002fb:	48 8b 47 f0          	mov    -0x10(%rdi),%rax
  1002ff:	48 89 44 07 e0       	mov    %rax,-0x20(%rdi,%rax,1)

	// add to free_list
	PREV_FPTR(free_list) = firstbyte;
  100304:	48 8b 05 f5 20 00 00 	mov    0x20f5(%rip),%rax        # 102400 <free_list>
  10030b:	48 89 78 08          	mov    %rdi,0x8(%rax)
	free_list = firstbyte;
  10030f:	48 89 3d ea 20 00 00 	mov    %rdi,0x20ea(%rip)        # 102400 <free_list>

	return;
}
  100316:	c3                   	ret    

0000000000100317 <extend>:
//
//	the reason alloating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
int extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  100317:	48 81 c7 ff 3f 00 00 	add    $0x3fff,%rdi
  10031e:	48 81 e7 00 c0 ff ff 	and    $0xffffffffffffc000,%rdi
  100325:	cd 3a                	int    $0x3a
  100327:	48 89 05 e2 20 00 00 	mov    %rax,0x20e2(%rip)        # 102410 <result.0>
	void *bp = sbrk(chunk_aligned_size);
	if (bp == (void *)-1)
  10032e:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  100332:	74 58                	je     10038c <extend+0x75>
		return -1;

	// setup pointer
	GET_SIZE(HDRP(bp)) = chunk_aligned_size;
  100334:	48 89 78 f0          	mov    %rdi,-0x10(%rax)
	GET_ALLOC(HDRP(bp)) = 0;
  100338:	c7 40 f8 00 00 00 00 	movl   $0x0,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  10033f:	48 8b 15 ba 20 00 00 	mov    0x20ba(%rip),%rdx        # 102400 <free_list>
  100346:	48 89 10             	mov    %rdx,(%rax)
	PREV_FPTR(bp) = NULL;
  100349:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  100350:	00 
	GET_SIZE(FTRP(bp)) = GET_SIZE(HDRP(bp));
  100351:	48 89 7c 07 e0       	mov    %rdi,-0x20(%rdi,%rax,1)

	// add to head of free_list
	if (free_list)
  100356:	48 8b 15 a3 20 00 00 	mov    0x20a3(%rip),%rdx        # 102400 <free_list>
  10035d:	48 85 d2             	test   %rdx,%rdx
  100360:	74 04                	je     100366 <extend+0x4f>
		PREV_FPTR(free_list) = bp;
  100362:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  100366:	48 89 05 93 20 00 00 	mov    %rax,0x2093(%rip)        # 102400 <free_list>

	// update terminal block
	GET_SIZE(HDRP(NEXT_BLKP(bp))) = 0;
  10036d:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  100371:	48 c7 44 10 f0 00 00 	movq   $0x0,-0x10(%rax,%rdx,1)
  100378:	00 00 
	GET_ALLOC(HDRP(NEXT_BLKP(bp))) = 1;
  10037a:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  10037e:	c7 44 10 f8 01 00 00 	movl   $0x1,-0x8(%rax,%rdx,1)
  100385:	00 
	return 0;
  100386:	b8 00 00 00 00       	mov    $0x0,%eax
  10038b:	c3                   	ret    
		return -1;
  10038c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  100391:	c3                   	ret    

0000000000100392 <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
  100392:	48 89 f8             	mov    %rdi,%rax
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  100395:	48 8b 57 f0          	mov    -0x10(%rdi),%rdx
  100399:	48 29 f2             	sub    %rsi,%rdx

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  10039c:	48 83 fa 30          	cmp    $0x30,%rdx
  1003a0:	76 57                	jbe    1003f9 <set_allocated+0x67>
		GET_SIZE(HDRP(bp)) = size;
  1003a2:	48 89 77 f0          	mov    %rsi,-0x10(%rdi)
		void *leftover_mem_ptr = NEXT_BLKP(bp);
  1003a6:	48 01 fe             	add    %rdi,%rsi

		GET_SIZE(HDRP(leftover_mem_ptr)) = extra_size;
  1003a9:	48 89 56 f0          	mov    %rdx,-0x10(%rsi)
		GET_ALLOC(HDRP(leftover_mem_ptr)) = 0;
  1003ad:	c7 46 f8 00 00 00 00 	movl   $0x0,-0x8(%rsi)
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp); // pointers to the nearby free blocks
  1003b4:	48 8b 0f             	mov    (%rdi),%rcx
  1003b7:	48 89 0e             	mov    %rcx,(%rsi)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  1003ba:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  1003be:	48 89 4e 08          	mov    %rcx,0x8(%rsi)
		GET_SIZE(FTRP(leftover_mem_ptr)) = GET_SIZE(HDRP(leftover_mem_ptr));
  1003c2:	48 89 54 16 e0       	mov    %rdx,-0x20(%rsi,%rdx,1)

		// update the free list
		if (free_list == bp)
  1003c7:	48 39 3d 32 20 00 00 	cmp    %rdi,0x2032(%rip)        # 102400 <free_list>
  1003ce:	74 20                	je     1003f0 <set_allocated+0x5e>
			free_list = leftover_mem_ptr;

		if (PREV_FPTR(bp))
  1003d0:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1003d4:	48 85 d2             	test   %rdx,%rdx
  1003d7:	74 03                	je     1003dc <set_allocated+0x4a>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  1003d9:	48 89 32             	mov    %rsi,(%rdx)
		if (NEXT_FPTR(bp))
  1003dc:	48 8b 10             	mov    (%rax),%rdx
  1003df:	48 85 d2             	test   %rdx,%rdx
  1003e2:	74 04                	je     1003e8 <set_allocated+0x56>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  1003e4:	48 89 72 08          	mov    %rsi,0x8(%rdx)
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
		if (NEXT_FPTR(bp))
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
	}
	
	GET_ALLOC(HDRP(bp)) = 1;
  1003e8:	c7 40 f8 01 00 00 00 	movl   $0x1,-0x8(%rax)
}
  1003ef:	c3                   	ret    
			free_list = leftover_mem_ptr;
  1003f0:	48 89 35 09 20 00 00 	mov    %rsi,0x2009(%rip)        # 102400 <free_list>
  1003f7:	eb d7                	jmp    1003d0 <set_allocated+0x3e>
		if (free_list == bp)
  1003f9:	48 39 3d 00 20 00 00 	cmp    %rdi,0x2000(%rip)        # 102400 <free_list>
  100400:	74 21                	je     100423 <set_allocated+0x91>
		if (PREV_FPTR(bp))
  100402:	48 8b 50 08          	mov    0x8(%rax),%rdx
  100406:	48 85 d2             	test   %rdx,%rdx
  100409:	74 06                	je     100411 <set_allocated+0x7f>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  10040b:	48 8b 08             	mov    (%rax),%rcx
  10040e:	48 89 0a             	mov    %rcx,(%rdx)
		if (NEXT_FPTR(bp))
  100411:	48 8b 10             	mov    (%rax),%rdx
  100414:	48 85 d2             	test   %rdx,%rdx
  100417:	74 cf                	je     1003e8 <set_allocated+0x56>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  100419:	48 8b 48 08          	mov    0x8(%rax),%rcx
  10041d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100421:	eb c5                	jmp    1003e8 <set_allocated+0x56>
			free_list = NEXT_FPTR(bp);
  100423:	48 8b 17             	mov    (%rdi),%rdx
  100426:	48 89 15 d3 1f 00 00 	mov    %rdx,0x1fd3(%rip)        # 102400 <free_list>
  10042d:	eb d3                	jmp    100402 <set_allocated+0x70>

000000000010042f <malloc>:

void *malloc(uint64_t numbytes) {
  10042f:	55                   	push   %rbp
  100430:	48 89 e5             	mov    %rsp,%rbp
  100433:	41 55                	push   %r13
  100435:	41 54                	push   %r12
  100437:	53                   	push   %rbx
  100438:	48 83 ec 08          	sub    $0x8,%rsp
  10043c:	49 89 fc             	mov    %rdi,%r12
	if (!initialized_heap)
  10043f:	83 3d c2 1f 00 00 00 	cmpl   $0x0,0x1fc2(%rip)        # 102408 <initialized_heap>
  100446:	74 60                	je     1004a8 <malloc+0x79>
		heap_init();

	if (numbytes == 0)
  100448:	4d 85 e4             	test   %r12,%r12
  10044b:	74 7b                	je     1004c8 <malloc+0x99>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  10044d:	49 83 c4 1f          	add    $0x1f,%r12
  100451:	49 83 e4 f0          	and    $0xfffffffffffffff0,%r12
  100455:	b8 30 00 00 00       	mov    $0x30,%eax
  10045a:	49 39 c4             	cmp    %rax,%r12
  10045d:	4c 0f 42 e0          	cmovb  %rax,%r12
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);

	void *bp = free_list;
  100461:	48 8b 1d 98 1f 00 00 	mov    0x1f98(%rip),%rbx        # 102400 <free_list>
	while (bp) {
  100468:	48 85 db             	test   %rbx,%rbx
  10046b:	74 0e                	je     10047b <malloc+0x4c>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  10046d:	4c 39 63 f0          	cmp    %r12,-0x10(%rbx)
  100471:	73 3c                	jae    1004af <malloc+0x80>
			set_allocated(bp, aligned_size);
			return bp;
		}

		bp = NEXT_FPTR(bp);
  100473:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  100476:	48 85 db             	test   %rbx,%rbx
  100479:	75 f2                	jne    10046d <malloc+0x3e>
  10047b:	bf 00 00 00 00       	mov    $0x0,%edi
  100480:	cd 3a                	int    $0x3a
  100482:	49 89 c5             	mov    %rax,%r13
  100485:	48 89 05 84 1f 00 00 	mov    %rax,0x1f84(%rip)        # 102410 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  10048c:	48 89 c3             	mov    %rax,%rbx
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	if (extend(aligned_size)) {
  10048f:	4c 89 e7             	mov    %r12,%rdi
  100492:	e8 80 fe ff ff       	call   100317 <extend>
  100497:	85 c0                	test   %eax,%eax
  100499:	75 34                	jne    1004cf <malloc+0xa0>
		return NULL;
	}
	set_allocated(bp, aligned_size);
  10049b:	4c 89 e6             	mov    %r12,%rsi
  10049e:	4c 89 ef             	mov    %r13,%rdi
  1004a1:	e8 ec fe ff ff       	call   100392 <set_allocated>
    return bp;
  1004a6:	eb 12                	jmp    1004ba <malloc+0x8b>
		heap_init();
  1004a8:	e8 c8 fd ff ff       	call   100275 <heap_init>
  1004ad:	eb 99                	jmp    100448 <malloc+0x19>
			set_allocated(bp, aligned_size);
  1004af:	4c 89 e6             	mov    %r12,%rsi
  1004b2:	48 89 df             	mov    %rbx,%rdi
  1004b5:	e8 d8 fe ff ff       	call   100392 <set_allocated>
}
  1004ba:	48 89 d8             	mov    %rbx,%rax
  1004bd:	48 83 c4 08          	add    $0x8,%rsp
  1004c1:	5b                   	pop    %rbx
  1004c2:	41 5c                	pop    %r12
  1004c4:	41 5d                	pop    %r13
  1004c6:	5d                   	pop    %rbp
  1004c7:	c3                   	ret    
		return NULL;
  1004c8:	bb 00 00 00 00       	mov    $0x0,%ebx
  1004cd:	eb eb                	jmp    1004ba <malloc+0x8b>
		return NULL;
  1004cf:	bb 00 00 00 00       	mov    $0x0,%ebx
  1004d4:	eb e4                	jmp    1004ba <malloc+0x8b>

00000000001004d6 <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  1004d6:	55                   	push   %rbp
  1004d7:	48 89 e5             	mov    %rsp,%rbp
  1004da:	41 54                	push   %r12
  1004dc:	53                   	push   %rbx
	void *bp = malloc(num * sz);
  1004dd:	48 0f af fe          	imul   %rsi,%rdi
  1004e1:	49 89 fc             	mov    %rdi,%r12
  1004e4:	e8 46 ff ff ff       	call   10042f <malloc>
  1004e9:	48 89 c3             	mov    %rax,%rbx
	memset(bp, 0, num * sz);
  1004ec:	4c 89 e2             	mov    %r12,%rdx
  1004ef:	be 00 00 00 00       	mov    $0x0,%esi
  1004f4:	48 89 c7             	mov    %rax,%rdi
  1004f7:	e8 28 02 00 00       	call   100724 <memset>
	return bp;
}
  1004fc:	48 89 d8             	mov    %rbx,%rax
  1004ff:	5b                   	pop    %rbx
  100500:	41 5c                	pop    %r12
  100502:	5d                   	pop    %rbp
  100503:	c3                   	ret    

0000000000100504 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  100504:	55                   	push   %rbp
  100505:	48 89 e5             	mov    %rsp,%rbp
  100508:	41 54                	push   %r12
  10050a:	53                   	push   %rbx
  10050b:	48 89 fb             	mov    %rdi,%rbx
	// first check if there's enough space in the block already
	if (GET_SIZE(HDRP(ptr)) >= sz)
  10050e:	48 39 77 f0          	cmp    %rsi,-0x10(%rdi)
  100512:	72 08                	jb     10051c <realloc+0x18>
	void *bigger_ptr = malloc(sz);
	memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
	free(ptr);

    return bigger_ptr;
}
  100514:	48 89 d8             	mov    %rbx,%rax
  100517:	5b                   	pop    %rbx
  100518:	41 5c                	pop    %r12
  10051a:	5d                   	pop    %rbp
  10051b:	c3                   	ret    
	void *bigger_ptr = malloc(sz);
  10051c:	48 89 f7             	mov    %rsi,%rdi
  10051f:	e8 0b ff ff ff       	call   10042f <malloc>
  100524:	49 89 c4             	mov    %rax,%r12
	memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
  100527:	48 8b 53 f0          	mov    -0x10(%rbx),%rdx
  10052b:	48 89 de             	mov    %rbx,%rsi
  10052e:	48 89 c7             	mov    %rax,%rdi
  100531:	e8 f0 00 00 00       	call   100626 <memcpy>
	free(ptr);
  100536:	48 89 df             	mov    %rbx,%rdi
  100539:	e8 9f fd ff ff       	call   1002dd <free>
    return bigger_ptr;
  10053e:	4c 89 e3             	mov    %r12,%rbx
  100541:	eb d1                	jmp    100514 <realloc+0x10>

0000000000100543 <defrag>:

void defrag() {
	void *fp = free_list;
  100543:	48 8b 05 b6 1e 00 00 	mov    0x1eb6(%rip),%rax        # 102400 <free_list>
	while (fp != NULL) {
  10054a:	48 85 c0             	test   %rax,%rax
  10054d:	75 3a                	jne    100589 <defrag+0x46>
			GET_SIZE(FTRP(prev_block)) = GET_SIZE(HDRP(prev_block));
		}

		fp = NEXT_FPTR(fp);
	}
}
  10054f:	c3                   	ret    
				free_list = NEXT_FPTR(next_block);
  100550:	48 8b 0a             	mov    (%rdx),%rcx
  100553:	48 89 0d a6 1e 00 00 	mov    %rcx,0x1ea6(%rip)        # 102400 <free_list>
  10055a:	eb 43                	jmp    10059f <defrag+0x5c>
			fp = NEXT_FPTR(fp);
  10055c:	48 8b 00             	mov    (%rax),%rax
			continue;
  10055f:	eb 23                	jmp    100584 <defrag+0x41>
				free_list = NEXT_FPTR(fp);
  100561:	48 8b 08             	mov    (%rax),%rcx
  100564:	48 89 0d 95 1e 00 00 	mov    %rcx,0x1e95(%rip)        # 102400 <free_list>
  10056b:	e9 88 00 00 00       	jmp    1005f8 <defrag+0xb5>
			GET_SIZE(HDRP(prev_block)) = GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp));
  100570:	48 8b 48 f0          	mov    -0x10(%rax),%rcx
  100574:	48 03 4a f0          	add    -0x10(%rdx),%rcx
  100578:	48 89 4a f0          	mov    %rcx,-0x10(%rdx)
			GET_SIZE(FTRP(prev_block)) = GET_SIZE(HDRP(prev_block));
  10057c:	48 89 4c 0a e0       	mov    %rcx,-0x20(%rdx,%rcx,1)
		fp = NEXT_FPTR(fp);
  100581:	48 8b 00             	mov    (%rax),%rax
	while (fp != NULL) {
  100584:	48 85 c0             	test   %rax,%rax
  100587:	74 c6                	je     10054f <defrag+0xc>
		void *next_block = NEXT_BLKP(fp);
  100589:	48 89 c2             	mov    %rax,%rdx
  10058c:	48 03 50 f0          	add    -0x10(%rax),%rdx
		if (!GET_ALLOC(HDRP(next_block))) {
  100590:	83 7a f8 00          	cmpl   $0x0,-0x8(%rdx)
  100594:	75 39                	jne    1005cf <defrag+0x8c>
			if (free_list == next_block)
  100596:	48 39 15 63 1e 00 00 	cmp    %rdx,0x1e63(%rip)        # 102400 <free_list>
  10059d:	74 b1                	je     100550 <defrag+0xd>
			if (PREV_FPTR(next_block)) 
  10059f:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  1005a3:	48 85 c9             	test   %rcx,%rcx
  1005a6:	74 06                	je     1005ae <defrag+0x6b>
				NEXT_FPTR(PREV_FPTR(next_block)) = NEXT_FPTR(next_block);
  1005a8:	48 8b 32             	mov    (%rdx),%rsi
  1005ab:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(next_block)) 
  1005ae:	48 8b 0a             	mov    (%rdx),%rcx
  1005b1:	48 85 c9             	test   %rcx,%rcx
  1005b4:	74 08                	je     1005be <defrag+0x7b>
				PREV_FPTR(NEXT_FPTR(next_block)) = PREV_FPTR(next_block);
  1005b6:	48 8b 72 08          	mov    0x8(%rdx),%rsi
  1005ba:	48 89 71 08          	mov    %rsi,0x8(%rcx)
			GET_SIZE(HDRP(fp)) = GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block));
  1005be:	48 8b 52 f0          	mov    -0x10(%rdx),%rdx
  1005c2:	48 03 50 f0          	add    -0x10(%rax),%rdx
  1005c6:	48 89 50 f0          	mov    %rdx,-0x10(%rax)
			GET_SIZE(FTRP(fp)) = GET_SIZE(HDRP(fp));
  1005ca:	48 89 54 10 e0       	mov    %rdx,-0x20(%rax,%rdx,1)
		void *prev_block = PREV_BLKP(fp);
  1005cf:	48 89 c2             	mov    %rax,%rdx
  1005d2:	48 2b 50 e0          	sub    -0x20(%rax),%rdx
		if (GET_SIZE(HDRP(prev_block)) != GET_SIZE(FTRP(prev_block))){
  1005d6:	48 8b 4a f0          	mov    -0x10(%rdx),%rcx
  1005da:	48 3b 4c 0a e0       	cmp    -0x20(%rdx,%rcx,1),%rcx
  1005df:	0f 85 77 ff ff ff    	jne    10055c <defrag+0x19>
		if (!GET_ALLOC(HDRP(prev_block))) {
  1005e5:	83 7a f8 00          	cmpl   $0x0,-0x8(%rdx)
  1005e9:	75 96                	jne    100581 <defrag+0x3e>
			if (free_list == fp)
  1005eb:	48 39 05 0e 1e 00 00 	cmp    %rax,0x1e0e(%rip)        # 102400 <free_list>
  1005f2:	0f 84 69 ff ff ff    	je     100561 <defrag+0x1e>
			if (PREV_FPTR(fp)) 
  1005f8:	48 8b 48 08          	mov    0x8(%rax),%rcx
  1005fc:	48 85 c9             	test   %rcx,%rcx
  1005ff:	74 06                	je     100607 <defrag+0xc4>
				NEXT_FPTR(PREV_FPTR(fp)) = NEXT_FPTR(fp);
  100601:	48 8b 30             	mov    (%rax),%rsi
  100604:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(fp)) 
  100607:	48 8b 08             	mov    (%rax),%rcx
  10060a:	48 85 c9             	test   %rcx,%rcx
  10060d:	0f 84 5d ff ff ff    	je     100570 <defrag+0x2d>
				PREV_FPTR(NEXT_FPTR(fp)) = PREV_FPTR(fp);
  100613:	48 8b 70 08          	mov    0x8(%rax),%rsi
  100617:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  10061b:	e9 50 ff ff ff       	jmp    100570 <defrag+0x2d>

0000000000100620 <heap_info>:

int heap_info(heap_info_struct *info) {
    return 0;
}
  100620:	b8 00 00 00 00       	mov    $0x0,%eax
  100625:	c3                   	ret    

0000000000100626 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100626:	55                   	push   %rbp
  100627:	48 89 e5             	mov    %rsp,%rbp
  10062a:	48 83 ec 28          	sub    $0x28,%rsp
  10062e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100632:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100636:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10063a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10063e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100642:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100646:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  10064a:	eb 1c                	jmp    100668 <memcpy+0x42>
        *d = *s;
  10064c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100650:	0f b6 10             	movzbl (%rax),%edx
  100653:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100657:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100659:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10065e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100663:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100668:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10066d:	75 dd                	jne    10064c <memcpy+0x26>
    }
    return dst;
  10066f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100673:	c9                   	leave  
  100674:	c3                   	ret    

0000000000100675 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100675:	55                   	push   %rbp
  100676:	48 89 e5             	mov    %rsp,%rbp
  100679:	48 83 ec 28          	sub    $0x28,%rsp
  10067d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100681:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100685:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100689:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10068d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  100691:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100695:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100699:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10069d:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  1006a1:	73 6a                	jae    10070d <memmove+0x98>
  1006a3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1006a7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1006ab:	48 01 d0             	add    %rdx,%rax
  1006ae:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1006b2:	73 59                	jae    10070d <memmove+0x98>
        s += n, d += n;
  1006b4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1006b8:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1006bc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1006c0:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1006c4:	eb 17                	jmp    1006dd <memmove+0x68>
            *--d = *--s;
  1006c6:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1006cb:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1006d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006d4:	0f b6 10             	movzbl (%rax),%edx
  1006d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1006db:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1006dd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1006e1:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1006e5:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1006e9:	48 85 c0             	test   %rax,%rax
  1006ec:	75 d8                	jne    1006c6 <memmove+0x51>
    if (s < d && s + n > d) {
  1006ee:	eb 2e                	jmp    10071e <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1006f0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1006f4:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1006f8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1006fc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100700:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100704:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100708:	0f b6 12             	movzbl (%rdx),%edx
  10070b:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  10070d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100711:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100715:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100719:	48 85 c0             	test   %rax,%rax
  10071c:	75 d2                	jne    1006f0 <memmove+0x7b>
        }
    }
    return dst;
  10071e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100722:	c9                   	leave  
  100723:	c3                   	ret    

0000000000100724 <memset>:

void* memset(void* v, int c, size_t n) {
  100724:	55                   	push   %rbp
  100725:	48 89 e5             	mov    %rsp,%rbp
  100728:	48 83 ec 28          	sub    $0x28,%rsp
  10072c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100730:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100733:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100737:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10073b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10073f:	eb 15                	jmp    100756 <memset+0x32>
        *p = c;
  100741:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100744:	89 c2                	mov    %eax,%edx
  100746:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10074a:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10074c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100751:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100756:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10075b:	75 e4                	jne    100741 <memset+0x1d>
    }
    return v;
  10075d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100761:	c9                   	leave  
  100762:	c3                   	ret    

0000000000100763 <strlen>:

size_t strlen(const char* s) {
  100763:	55                   	push   %rbp
  100764:	48 89 e5             	mov    %rsp,%rbp
  100767:	48 83 ec 18          	sub    $0x18,%rsp
  10076b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  10076f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100776:	00 
  100777:	eb 0a                	jmp    100783 <strlen+0x20>
        ++n;
  100779:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  10077e:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100783:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100787:	0f b6 00             	movzbl (%rax),%eax
  10078a:	84 c0                	test   %al,%al
  10078c:	75 eb                	jne    100779 <strlen+0x16>
    }
    return n;
  10078e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100792:	c9                   	leave  
  100793:	c3                   	ret    

0000000000100794 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100794:	55                   	push   %rbp
  100795:	48 89 e5             	mov    %rsp,%rbp
  100798:	48 83 ec 20          	sub    $0x20,%rsp
  10079c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1007a0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1007a4:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1007ab:	00 
  1007ac:	eb 0a                	jmp    1007b8 <strnlen+0x24>
        ++n;
  1007ae:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1007b3:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1007b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007bc:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  1007c0:	74 0b                	je     1007cd <strnlen+0x39>
  1007c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1007c6:	0f b6 00             	movzbl (%rax),%eax
  1007c9:	84 c0                	test   %al,%al
  1007cb:	75 e1                	jne    1007ae <strnlen+0x1a>
    }
    return n;
  1007cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1007d1:	c9                   	leave  
  1007d2:	c3                   	ret    

00000000001007d3 <strcpy>:

char* strcpy(char* dst, const char* src) {
  1007d3:	55                   	push   %rbp
  1007d4:	48 89 e5             	mov    %rsp,%rbp
  1007d7:	48 83 ec 20          	sub    $0x20,%rsp
  1007db:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1007df:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1007e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1007e7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1007eb:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1007ef:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1007f3:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1007f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007fb:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1007ff:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100803:	0f b6 12             	movzbl (%rdx),%edx
  100806:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100808:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10080c:	48 83 e8 01          	sub    $0x1,%rax
  100810:	0f b6 00             	movzbl (%rax),%eax
  100813:	84 c0                	test   %al,%al
  100815:	75 d4                	jne    1007eb <strcpy+0x18>
    return dst;
  100817:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10081b:	c9                   	leave  
  10081c:	c3                   	ret    

000000000010081d <strcmp>:

int strcmp(const char* a, const char* b) {
  10081d:	55                   	push   %rbp
  10081e:	48 89 e5             	mov    %rsp,%rbp
  100821:	48 83 ec 10          	sub    $0x10,%rsp
  100825:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100829:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10082d:	eb 0a                	jmp    100839 <strcmp+0x1c>
        ++a, ++b;
  10082f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100834:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100839:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10083d:	0f b6 00             	movzbl (%rax),%eax
  100840:	84 c0                	test   %al,%al
  100842:	74 1d                	je     100861 <strcmp+0x44>
  100844:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100848:	0f b6 00             	movzbl (%rax),%eax
  10084b:	84 c0                	test   %al,%al
  10084d:	74 12                	je     100861 <strcmp+0x44>
  10084f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100853:	0f b6 10             	movzbl (%rax),%edx
  100856:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10085a:	0f b6 00             	movzbl (%rax),%eax
  10085d:	38 c2                	cmp    %al,%dl
  10085f:	74 ce                	je     10082f <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100861:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100865:	0f b6 00             	movzbl (%rax),%eax
  100868:	89 c2                	mov    %eax,%edx
  10086a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10086e:	0f b6 00             	movzbl (%rax),%eax
  100871:	38 d0                	cmp    %dl,%al
  100873:	0f 92 c0             	setb   %al
  100876:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100879:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10087d:	0f b6 00             	movzbl (%rax),%eax
  100880:	89 c1                	mov    %eax,%ecx
  100882:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100886:	0f b6 00             	movzbl (%rax),%eax
  100889:	38 c1                	cmp    %al,%cl
  10088b:	0f 92 c0             	setb   %al
  10088e:	0f b6 c0             	movzbl %al,%eax
  100891:	29 c2                	sub    %eax,%edx
  100893:	89 d0                	mov    %edx,%eax
}
  100895:	c9                   	leave  
  100896:	c3                   	ret    

0000000000100897 <strchr>:

char* strchr(const char* s, int c) {
  100897:	55                   	push   %rbp
  100898:	48 89 e5             	mov    %rsp,%rbp
  10089b:	48 83 ec 10          	sub    $0x10,%rsp
  10089f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1008a3:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1008a6:	eb 05                	jmp    1008ad <strchr+0x16>
        ++s;
  1008a8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1008ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008b1:	0f b6 00             	movzbl (%rax),%eax
  1008b4:	84 c0                	test   %al,%al
  1008b6:	74 0e                	je     1008c6 <strchr+0x2f>
  1008b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008bc:	0f b6 00             	movzbl (%rax),%eax
  1008bf:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1008c2:	38 d0                	cmp    %dl,%al
  1008c4:	75 e2                	jne    1008a8 <strchr+0x11>
    }
    if (*s == (char) c) {
  1008c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008ca:	0f b6 00             	movzbl (%rax),%eax
  1008cd:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1008d0:	38 d0                	cmp    %dl,%al
  1008d2:	75 06                	jne    1008da <strchr+0x43>
        return (char*) s;
  1008d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008d8:	eb 05                	jmp    1008df <strchr+0x48>
    } else {
        return NULL;
  1008da:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1008df:	c9                   	leave  
  1008e0:	c3                   	ret    

00000000001008e1 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1008e1:	55                   	push   %rbp
  1008e2:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1008e5:	8b 05 2d 1b 00 00    	mov    0x1b2d(%rip),%eax        # 102418 <rand_seed_set>
  1008eb:	85 c0                	test   %eax,%eax
  1008ed:	75 0a                	jne    1008f9 <rand+0x18>
        srand(819234718U);
  1008ef:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1008f4:	e8 24 00 00 00       	call   10091d <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1008f9:	8b 05 1d 1b 00 00    	mov    0x1b1d(%rip),%eax        # 10241c <rand_seed>
  1008ff:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100905:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  10090a:	89 05 0c 1b 00 00    	mov    %eax,0x1b0c(%rip)        # 10241c <rand_seed>
    return rand_seed & RAND_MAX;
  100910:	8b 05 06 1b 00 00    	mov    0x1b06(%rip),%eax        # 10241c <rand_seed>
  100916:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  10091b:	5d                   	pop    %rbp
  10091c:	c3                   	ret    

000000000010091d <srand>:

void srand(unsigned seed) {
  10091d:	55                   	push   %rbp
  10091e:	48 89 e5             	mov    %rsp,%rbp
  100921:	48 83 ec 08          	sub    $0x8,%rsp
  100925:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100928:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10092b:	89 05 eb 1a 00 00    	mov    %eax,0x1aeb(%rip)        # 10241c <rand_seed>
    rand_seed_set = 1;
  100931:	c7 05 dd 1a 00 00 01 	movl   $0x1,0x1add(%rip)        # 102418 <rand_seed_set>
  100938:	00 00 00 
}
  10093b:	90                   	nop
  10093c:	c9                   	leave  
  10093d:	c3                   	ret    

000000000010093e <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  10093e:	55                   	push   %rbp
  10093f:	48 89 e5             	mov    %rsp,%rbp
  100942:	48 83 ec 28          	sub    $0x28,%rsp
  100946:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10094a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10094e:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100951:	48 c7 45 f8 f0 18 10 	movq   $0x1018f0,-0x8(%rbp)
  100958:	00 
    if (base < 0) {
  100959:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  10095d:	79 0b                	jns    10096a <fill_numbuf+0x2c>
        digits = lower_digits;
  10095f:	48 c7 45 f8 10 19 10 	movq   $0x101910,-0x8(%rbp)
  100966:	00 
        base = -base;
  100967:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  10096a:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10096f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100973:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100976:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100979:	48 63 c8             	movslq %eax,%rcx
  10097c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100980:	ba 00 00 00 00       	mov    $0x0,%edx
  100985:	48 f7 f1             	div    %rcx
  100988:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10098c:	48 01 d0             	add    %rdx,%rax
  10098f:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100994:	0f b6 10             	movzbl (%rax),%edx
  100997:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10099b:	88 10                	mov    %dl,(%rax)
        val /= base;
  10099d:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1009a0:	48 63 f0             	movslq %eax,%rsi
  1009a3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1009a7:	ba 00 00 00 00       	mov    $0x0,%edx
  1009ac:	48 f7 f6             	div    %rsi
  1009af:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  1009b3:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  1009b8:	75 bc                	jne    100976 <fill_numbuf+0x38>
    return numbuf_end;
  1009ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1009be:	c9                   	leave  
  1009bf:	c3                   	ret    

00000000001009c0 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1009c0:	55                   	push   %rbp
  1009c1:	48 89 e5             	mov    %rsp,%rbp
  1009c4:	53                   	push   %rbx
  1009c5:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  1009cc:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1009d3:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1009d9:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1009e0:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1009e7:	e9 8a 09 00 00       	jmp    101376 <printer_vprintf+0x9b6>
        if (*format != '%') {
  1009ec:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009f3:	0f b6 00             	movzbl (%rax),%eax
  1009f6:	3c 25                	cmp    $0x25,%al
  1009f8:	74 31                	je     100a2b <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  1009fa:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100a01:	4c 8b 00             	mov    (%rax),%r8
  100a04:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a0b:	0f b6 00             	movzbl (%rax),%eax
  100a0e:	0f b6 c8             	movzbl %al,%ecx
  100a11:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100a17:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100a1e:	89 ce                	mov    %ecx,%esi
  100a20:	48 89 c7             	mov    %rax,%rdi
  100a23:	41 ff d0             	call   *%r8
            continue;
  100a26:	e9 43 09 00 00       	jmp    10136e <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100a2b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100a32:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100a39:	01 
  100a3a:	eb 44                	jmp    100a80 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  100a3c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a43:	0f b6 00             	movzbl (%rax),%eax
  100a46:	0f be c0             	movsbl %al,%eax
  100a49:	89 c6                	mov    %eax,%esi
  100a4b:	bf 10 17 10 00       	mov    $0x101710,%edi
  100a50:	e8 42 fe ff ff       	call   100897 <strchr>
  100a55:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100a59:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100a5e:	74 30                	je     100a90 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  100a60:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100a64:	48 2d 10 17 10 00    	sub    $0x101710,%rax
  100a6a:	ba 01 00 00 00       	mov    $0x1,%edx
  100a6f:	89 c1                	mov    %eax,%ecx
  100a71:	d3 e2                	shl    %cl,%edx
  100a73:	89 d0                	mov    %edx,%eax
  100a75:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100a78:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100a7f:	01 
  100a80:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a87:	0f b6 00             	movzbl (%rax),%eax
  100a8a:	84 c0                	test   %al,%al
  100a8c:	75 ae                	jne    100a3c <printer_vprintf+0x7c>
  100a8e:	eb 01                	jmp    100a91 <printer_vprintf+0xd1>
            } else {
                break;
  100a90:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100a91:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100a98:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a9f:	0f b6 00             	movzbl (%rax),%eax
  100aa2:	3c 30                	cmp    $0x30,%al
  100aa4:	7e 67                	jle    100b0d <printer_vprintf+0x14d>
  100aa6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100aad:	0f b6 00             	movzbl (%rax),%eax
  100ab0:	3c 39                	cmp    $0x39,%al
  100ab2:	7f 59                	jg     100b0d <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100ab4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100abb:	eb 2e                	jmp    100aeb <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100abd:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100ac0:	89 d0                	mov    %edx,%eax
  100ac2:	c1 e0 02             	shl    $0x2,%eax
  100ac5:	01 d0                	add    %edx,%eax
  100ac7:	01 c0                	add    %eax,%eax
  100ac9:	89 c1                	mov    %eax,%ecx
  100acb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ad2:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100ad6:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100add:	0f b6 00             	movzbl (%rax),%eax
  100ae0:	0f be c0             	movsbl %al,%eax
  100ae3:	01 c8                	add    %ecx,%eax
  100ae5:	83 e8 30             	sub    $0x30,%eax
  100ae8:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100aeb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100af2:	0f b6 00             	movzbl (%rax),%eax
  100af5:	3c 2f                	cmp    $0x2f,%al
  100af7:	0f 8e 85 00 00 00    	jle    100b82 <printer_vprintf+0x1c2>
  100afd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b04:	0f b6 00             	movzbl (%rax),%eax
  100b07:	3c 39                	cmp    $0x39,%al
  100b09:	7e b2                	jle    100abd <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100b0b:	eb 75                	jmp    100b82 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100b0d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b14:	0f b6 00             	movzbl (%rax),%eax
  100b17:	3c 2a                	cmp    $0x2a,%al
  100b19:	75 68                	jne    100b83 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100b1b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b22:	8b 00                	mov    (%rax),%eax
  100b24:	83 f8 2f             	cmp    $0x2f,%eax
  100b27:	77 30                	ja     100b59 <printer_vprintf+0x199>
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
  100b57:	eb 1a                	jmp    100b73 <printer_vprintf+0x1b3>
  100b59:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b60:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b64:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b68:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b6f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b73:	8b 00                	mov    (%rax),%eax
  100b75:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100b78:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100b7f:	01 
  100b80:	eb 01                	jmp    100b83 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100b82:	90                   	nop
        }

        // process precision
        int precision = -1;
  100b83:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100b8a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b91:	0f b6 00             	movzbl (%rax),%eax
  100b94:	3c 2e                	cmp    $0x2e,%al
  100b96:	0f 85 00 01 00 00    	jne    100c9c <printer_vprintf+0x2dc>
            ++format;
  100b9c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ba3:	01 
            if (*format >= '0' && *format <= '9') {
  100ba4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bab:	0f b6 00             	movzbl (%rax),%eax
  100bae:	3c 2f                	cmp    $0x2f,%al
  100bb0:	7e 67                	jle    100c19 <printer_vprintf+0x259>
  100bb2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bb9:	0f b6 00             	movzbl (%rax),%eax
  100bbc:	3c 39                	cmp    $0x39,%al
  100bbe:	7f 59                	jg     100c19 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100bc0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100bc7:	eb 2e                	jmp    100bf7 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100bc9:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100bcc:	89 d0                	mov    %edx,%eax
  100bce:	c1 e0 02             	shl    $0x2,%eax
  100bd1:	01 d0                	add    %edx,%eax
  100bd3:	01 c0                	add    %eax,%eax
  100bd5:	89 c1                	mov    %eax,%ecx
  100bd7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bde:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100be2:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100be9:	0f b6 00             	movzbl (%rax),%eax
  100bec:	0f be c0             	movsbl %al,%eax
  100bef:	01 c8                	add    %ecx,%eax
  100bf1:	83 e8 30             	sub    $0x30,%eax
  100bf4:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100bf7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bfe:	0f b6 00             	movzbl (%rax),%eax
  100c01:	3c 2f                	cmp    $0x2f,%al
  100c03:	0f 8e 85 00 00 00    	jle    100c8e <printer_vprintf+0x2ce>
  100c09:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c10:	0f b6 00             	movzbl (%rax),%eax
  100c13:	3c 39                	cmp    $0x39,%al
  100c15:	7e b2                	jle    100bc9 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100c17:	eb 75                	jmp    100c8e <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100c19:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c20:	0f b6 00             	movzbl (%rax),%eax
  100c23:	3c 2a                	cmp    $0x2a,%al
  100c25:	75 68                	jne    100c8f <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100c27:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c2e:	8b 00                	mov    (%rax),%eax
  100c30:	83 f8 2f             	cmp    $0x2f,%eax
  100c33:	77 30                	ja     100c65 <printer_vprintf+0x2a5>
  100c35:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c3c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c40:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c47:	8b 00                	mov    (%rax),%eax
  100c49:	89 c0                	mov    %eax,%eax
  100c4b:	48 01 d0             	add    %rdx,%rax
  100c4e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c55:	8b 12                	mov    (%rdx),%edx
  100c57:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c5a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c61:	89 0a                	mov    %ecx,(%rdx)
  100c63:	eb 1a                	jmp    100c7f <printer_vprintf+0x2bf>
  100c65:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c6c:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c70:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c74:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c7b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c7f:	8b 00                	mov    (%rax),%eax
  100c81:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100c84:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100c8b:	01 
  100c8c:	eb 01                	jmp    100c8f <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100c8e:	90                   	nop
            }
            if (precision < 0) {
  100c8f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100c93:	79 07                	jns    100c9c <printer_vprintf+0x2dc>
                precision = 0;
  100c95:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100c9c:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100ca3:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100caa:	00 
        int length = 0;
  100cab:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100cb2:	48 c7 45 c8 16 17 10 	movq   $0x101716,-0x38(%rbp)
  100cb9:	00 
    again:
        switch (*format) {
  100cba:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100cc1:	0f b6 00             	movzbl (%rax),%eax
  100cc4:	0f be c0             	movsbl %al,%eax
  100cc7:	83 e8 43             	sub    $0x43,%eax
  100cca:	83 f8 37             	cmp    $0x37,%eax
  100ccd:	0f 87 9f 03 00 00    	ja     101072 <printer_vprintf+0x6b2>
  100cd3:	89 c0                	mov    %eax,%eax
  100cd5:	48 8b 04 c5 28 17 10 	mov    0x101728(,%rax,8),%rax
  100cdc:	00 
  100cdd:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100cdf:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100ce6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ced:	01 
            goto again;
  100cee:	eb ca                	jmp    100cba <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100cf0:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100cf4:	74 5d                	je     100d53 <printer_vprintf+0x393>
  100cf6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cfd:	8b 00                	mov    (%rax),%eax
  100cff:	83 f8 2f             	cmp    $0x2f,%eax
  100d02:	77 30                	ja     100d34 <printer_vprintf+0x374>
  100d04:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d0b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d0f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d16:	8b 00                	mov    (%rax),%eax
  100d18:	89 c0                	mov    %eax,%eax
  100d1a:	48 01 d0             	add    %rdx,%rax
  100d1d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d24:	8b 12                	mov    (%rdx),%edx
  100d26:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d29:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d30:	89 0a                	mov    %ecx,(%rdx)
  100d32:	eb 1a                	jmp    100d4e <printer_vprintf+0x38e>
  100d34:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d3b:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d3f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d43:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d4a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d4e:	48 8b 00             	mov    (%rax),%rax
  100d51:	eb 5c                	jmp    100daf <printer_vprintf+0x3ef>
  100d53:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d5a:	8b 00                	mov    (%rax),%eax
  100d5c:	83 f8 2f             	cmp    $0x2f,%eax
  100d5f:	77 30                	ja     100d91 <printer_vprintf+0x3d1>
  100d61:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d68:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d6c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d73:	8b 00                	mov    (%rax),%eax
  100d75:	89 c0                	mov    %eax,%eax
  100d77:	48 01 d0             	add    %rdx,%rax
  100d7a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d81:	8b 12                	mov    (%rdx),%edx
  100d83:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d86:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d8d:	89 0a                	mov    %ecx,(%rdx)
  100d8f:	eb 1a                	jmp    100dab <printer_vprintf+0x3eb>
  100d91:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d98:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d9c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100da0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100da7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100dab:	8b 00                	mov    (%rax),%eax
  100dad:	48 98                	cltq   
  100daf:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100db3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100db7:	48 c1 f8 38          	sar    $0x38,%rax
  100dbb:	25 80 00 00 00       	and    $0x80,%eax
  100dc0:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100dc3:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100dc7:	74 09                	je     100dd2 <printer_vprintf+0x412>
  100dc9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100dcd:	48 f7 d8             	neg    %rax
  100dd0:	eb 04                	jmp    100dd6 <printer_vprintf+0x416>
  100dd2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100dd6:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100dda:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100ddd:	83 c8 60             	or     $0x60,%eax
  100de0:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100de3:	e9 cf 02 00 00       	jmp    1010b7 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100de8:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100dec:	74 5d                	je     100e4b <printer_vprintf+0x48b>
  100dee:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100df5:	8b 00                	mov    (%rax),%eax
  100df7:	83 f8 2f             	cmp    $0x2f,%eax
  100dfa:	77 30                	ja     100e2c <printer_vprintf+0x46c>
  100dfc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e03:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e07:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e0e:	8b 00                	mov    (%rax),%eax
  100e10:	89 c0                	mov    %eax,%eax
  100e12:	48 01 d0             	add    %rdx,%rax
  100e15:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e1c:	8b 12                	mov    (%rdx),%edx
  100e1e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e21:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e28:	89 0a                	mov    %ecx,(%rdx)
  100e2a:	eb 1a                	jmp    100e46 <printer_vprintf+0x486>
  100e2c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e33:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e37:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e3b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e42:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e46:	48 8b 00             	mov    (%rax),%rax
  100e49:	eb 5c                	jmp    100ea7 <printer_vprintf+0x4e7>
  100e4b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e52:	8b 00                	mov    (%rax),%eax
  100e54:	83 f8 2f             	cmp    $0x2f,%eax
  100e57:	77 30                	ja     100e89 <printer_vprintf+0x4c9>
  100e59:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e60:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e64:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e6b:	8b 00                	mov    (%rax),%eax
  100e6d:	89 c0                	mov    %eax,%eax
  100e6f:	48 01 d0             	add    %rdx,%rax
  100e72:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e79:	8b 12                	mov    (%rdx),%edx
  100e7b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e7e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e85:	89 0a                	mov    %ecx,(%rdx)
  100e87:	eb 1a                	jmp    100ea3 <printer_vprintf+0x4e3>
  100e89:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e90:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e94:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e98:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e9f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ea3:	8b 00                	mov    (%rax),%eax
  100ea5:	89 c0                	mov    %eax,%eax
  100ea7:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100eab:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100eaf:	e9 03 02 00 00       	jmp    1010b7 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100eb4:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100ebb:	e9 28 ff ff ff       	jmp    100de8 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100ec0:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100ec7:	e9 1c ff ff ff       	jmp    100de8 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100ecc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ed3:	8b 00                	mov    (%rax),%eax
  100ed5:	83 f8 2f             	cmp    $0x2f,%eax
  100ed8:	77 30                	ja     100f0a <printer_vprintf+0x54a>
  100eda:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ee1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ee5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100eec:	8b 00                	mov    (%rax),%eax
  100eee:	89 c0                	mov    %eax,%eax
  100ef0:	48 01 d0             	add    %rdx,%rax
  100ef3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100efa:	8b 12                	mov    (%rdx),%edx
  100efc:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100eff:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f06:	89 0a                	mov    %ecx,(%rdx)
  100f08:	eb 1a                	jmp    100f24 <printer_vprintf+0x564>
  100f0a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f11:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f15:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f19:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f20:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f24:	48 8b 00             	mov    (%rax),%rax
  100f27:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100f2b:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100f32:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100f39:	e9 79 01 00 00       	jmp    1010b7 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100f3e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f45:	8b 00                	mov    (%rax),%eax
  100f47:	83 f8 2f             	cmp    $0x2f,%eax
  100f4a:	77 30                	ja     100f7c <printer_vprintf+0x5bc>
  100f4c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f53:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100f57:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f5e:	8b 00                	mov    (%rax),%eax
  100f60:	89 c0                	mov    %eax,%eax
  100f62:	48 01 d0             	add    %rdx,%rax
  100f65:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f6c:	8b 12                	mov    (%rdx),%edx
  100f6e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100f71:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f78:	89 0a                	mov    %ecx,(%rdx)
  100f7a:	eb 1a                	jmp    100f96 <printer_vprintf+0x5d6>
  100f7c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f83:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f87:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f8b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f92:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f96:	48 8b 00             	mov    (%rax),%rax
  100f99:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100f9d:	e9 15 01 00 00       	jmp    1010b7 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100fa2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fa9:	8b 00                	mov    (%rax),%eax
  100fab:	83 f8 2f             	cmp    $0x2f,%eax
  100fae:	77 30                	ja     100fe0 <printer_vprintf+0x620>
  100fb0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fb7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100fbb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fc2:	8b 00                	mov    (%rax),%eax
  100fc4:	89 c0                	mov    %eax,%eax
  100fc6:	48 01 d0             	add    %rdx,%rax
  100fc9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fd0:	8b 12                	mov    (%rdx),%edx
  100fd2:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100fd5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fdc:	89 0a                	mov    %ecx,(%rdx)
  100fde:	eb 1a                	jmp    100ffa <printer_vprintf+0x63a>
  100fe0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fe7:	48 8b 40 08          	mov    0x8(%rax),%rax
  100feb:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100fef:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ff6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ffa:	8b 00                	mov    (%rax),%eax
  100ffc:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  101002:	e9 67 03 00 00       	jmp    10136e <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  101007:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  10100b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  10100f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101016:	8b 00                	mov    (%rax),%eax
  101018:	83 f8 2f             	cmp    $0x2f,%eax
  10101b:	77 30                	ja     10104d <printer_vprintf+0x68d>
  10101d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101024:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101028:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10102f:	8b 00                	mov    (%rax),%eax
  101031:	89 c0                	mov    %eax,%eax
  101033:	48 01 d0             	add    %rdx,%rax
  101036:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10103d:	8b 12                	mov    (%rdx),%edx
  10103f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101042:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101049:	89 0a                	mov    %ecx,(%rdx)
  10104b:	eb 1a                	jmp    101067 <printer_vprintf+0x6a7>
  10104d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101054:	48 8b 40 08          	mov    0x8(%rax),%rax
  101058:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10105c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101063:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101067:	8b 00                	mov    (%rax),%eax
  101069:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  10106c:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  101070:	eb 45                	jmp    1010b7 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  101072:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101076:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  10107a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101081:	0f b6 00             	movzbl (%rax),%eax
  101084:	84 c0                	test   %al,%al
  101086:	74 0c                	je     101094 <printer_vprintf+0x6d4>
  101088:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10108f:	0f b6 00             	movzbl (%rax),%eax
  101092:	eb 05                	jmp    101099 <printer_vprintf+0x6d9>
  101094:	b8 25 00 00 00       	mov    $0x25,%eax
  101099:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  10109c:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  1010a0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1010a7:	0f b6 00             	movzbl (%rax),%eax
  1010aa:	84 c0                	test   %al,%al
  1010ac:	75 08                	jne    1010b6 <printer_vprintf+0x6f6>
                format--;
  1010ae:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  1010b5:	01 
            }
            break;
  1010b6:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  1010b7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010ba:	83 e0 20             	and    $0x20,%eax
  1010bd:	85 c0                	test   %eax,%eax
  1010bf:	74 1e                	je     1010df <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  1010c1:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1010c5:	48 83 c0 18          	add    $0x18,%rax
  1010c9:	8b 55 e0             	mov    -0x20(%rbp),%edx
  1010cc:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1010d0:	48 89 ce             	mov    %rcx,%rsi
  1010d3:	48 89 c7             	mov    %rax,%rdi
  1010d6:	e8 63 f8 ff ff       	call   10093e <fill_numbuf>
  1010db:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  1010df:	48 c7 45 c0 16 17 10 	movq   $0x101716,-0x40(%rbp)
  1010e6:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1010e7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010ea:	83 e0 20             	and    $0x20,%eax
  1010ed:	85 c0                	test   %eax,%eax
  1010ef:	74 48                	je     101139 <printer_vprintf+0x779>
  1010f1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010f4:	83 e0 40             	and    $0x40,%eax
  1010f7:	85 c0                	test   %eax,%eax
  1010f9:	74 3e                	je     101139 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  1010fb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010fe:	25 80 00 00 00       	and    $0x80,%eax
  101103:	85 c0                	test   %eax,%eax
  101105:	74 0a                	je     101111 <printer_vprintf+0x751>
                prefix = "-";
  101107:	48 c7 45 c0 17 17 10 	movq   $0x101717,-0x40(%rbp)
  10110e:	00 
            if (flags & FLAG_NEGATIVE) {
  10110f:	eb 73                	jmp    101184 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  101111:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101114:	83 e0 10             	and    $0x10,%eax
  101117:	85 c0                	test   %eax,%eax
  101119:	74 0a                	je     101125 <printer_vprintf+0x765>
                prefix = "+";
  10111b:	48 c7 45 c0 19 17 10 	movq   $0x101719,-0x40(%rbp)
  101122:	00 
            if (flags & FLAG_NEGATIVE) {
  101123:	eb 5f                	jmp    101184 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  101125:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101128:	83 e0 08             	and    $0x8,%eax
  10112b:	85 c0                	test   %eax,%eax
  10112d:	74 55                	je     101184 <printer_vprintf+0x7c4>
                prefix = " ";
  10112f:	48 c7 45 c0 1b 17 10 	movq   $0x10171b,-0x40(%rbp)
  101136:	00 
            if (flags & FLAG_NEGATIVE) {
  101137:	eb 4b                	jmp    101184 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  101139:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10113c:	83 e0 20             	and    $0x20,%eax
  10113f:	85 c0                	test   %eax,%eax
  101141:	74 42                	je     101185 <printer_vprintf+0x7c5>
  101143:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101146:	83 e0 01             	and    $0x1,%eax
  101149:	85 c0                	test   %eax,%eax
  10114b:	74 38                	je     101185 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  10114d:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  101151:	74 06                	je     101159 <printer_vprintf+0x799>
  101153:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  101157:	75 2c                	jne    101185 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  101159:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10115e:	75 0c                	jne    10116c <printer_vprintf+0x7ac>
  101160:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101163:	25 00 01 00 00       	and    $0x100,%eax
  101168:	85 c0                	test   %eax,%eax
  10116a:	74 19                	je     101185 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  10116c:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  101170:	75 07                	jne    101179 <printer_vprintf+0x7b9>
  101172:	b8 1d 17 10 00       	mov    $0x10171d,%eax
  101177:	eb 05                	jmp    10117e <printer_vprintf+0x7be>
  101179:	b8 20 17 10 00       	mov    $0x101720,%eax
  10117e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101182:	eb 01                	jmp    101185 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  101184:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  101185:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101189:	78 24                	js     1011af <printer_vprintf+0x7ef>
  10118b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10118e:	83 e0 20             	and    $0x20,%eax
  101191:	85 c0                	test   %eax,%eax
  101193:	75 1a                	jne    1011af <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  101195:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101198:	48 63 d0             	movslq %eax,%rdx
  10119b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  10119f:	48 89 d6             	mov    %rdx,%rsi
  1011a2:	48 89 c7             	mov    %rax,%rdi
  1011a5:	e8 ea f5 ff ff       	call   100794 <strnlen>
  1011aa:	89 45 bc             	mov    %eax,-0x44(%rbp)
  1011ad:	eb 0f                	jmp    1011be <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  1011af:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1011b3:	48 89 c7             	mov    %rax,%rdi
  1011b6:	e8 a8 f5 ff ff       	call   100763 <strlen>
  1011bb:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  1011be:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011c1:	83 e0 20             	and    $0x20,%eax
  1011c4:	85 c0                	test   %eax,%eax
  1011c6:	74 20                	je     1011e8 <printer_vprintf+0x828>
  1011c8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1011cc:	78 1a                	js     1011e8 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  1011ce:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1011d1:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  1011d4:	7e 08                	jle    1011de <printer_vprintf+0x81e>
  1011d6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1011d9:	2b 45 bc             	sub    -0x44(%rbp),%eax
  1011dc:	eb 05                	jmp    1011e3 <printer_vprintf+0x823>
  1011de:	b8 00 00 00 00       	mov    $0x0,%eax
  1011e3:	89 45 b8             	mov    %eax,-0x48(%rbp)
  1011e6:	eb 5c                	jmp    101244 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  1011e8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011eb:	83 e0 20             	and    $0x20,%eax
  1011ee:	85 c0                	test   %eax,%eax
  1011f0:	74 4b                	je     10123d <printer_vprintf+0x87d>
  1011f2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011f5:	83 e0 02             	and    $0x2,%eax
  1011f8:	85 c0                	test   %eax,%eax
  1011fa:	74 41                	je     10123d <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  1011fc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011ff:	83 e0 04             	and    $0x4,%eax
  101202:	85 c0                	test   %eax,%eax
  101204:	75 37                	jne    10123d <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  101206:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10120a:	48 89 c7             	mov    %rax,%rdi
  10120d:	e8 51 f5 ff ff       	call   100763 <strlen>
  101212:	89 c2                	mov    %eax,%edx
  101214:	8b 45 bc             	mov    -0x44(%rbp),%eax
  101217:	01 d0                	add    %edx,%eax
  101219:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  10121c:	7e 1f                	jle    10123d <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  10121e:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101221:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101224:	89 c3                	mov    %eax,%ebx
  101226:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10122a:	48 89 c7             	mov    %rax,%rdi
  10122d:	e8 31 f5 ff ff       	call   100763 <strlen>
  101232:	89 c2                	mov    %eax,%edx
  101234:	89 d8                	mov    %ebx,%eax
  101236:	29 d0                	sub    %edx,%eax
  101238:	89 45 b8             	mov    %eax,-0x48(%rbp)
  10123b:	eb 07                	jmp    101244 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  10123d:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  101244:	8b 55 bc             	mov    -0x44(%rbp),%edx
  101247:	8b 45 b8             	mov    -0x48(%rbp),%eax
  10124a:	01 d0                	add    %edx,%eax
  10124c:	48 63 d8             	movslq %eax,%rbx
  10124f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101253:	48 89 c7             	mov    %rax,%rdi
  101256:	e8 08 f5 ff ff       	call   100763 <strlen>
  10125b:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  10125f:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101262:	29 d0                	sub    %edx,%eax
  101264:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101267:	eb 25                	jmp    10128e <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  101269:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101270:	48 8b 08             	mov    (%rax),%rcx
  101273:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101279:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101280:	be 20 00 00 00       	mov    $0x20,%esi
  101285:	48 89 c7             	mov    %rax,%rdi
  101288:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10128a:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  10128e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101291:	83 e0 04             	and    $0x4,%eax
  101294:	85 c0                	test   %eax,%eax
  101296:	75 36                	jne    1012ce <printer_vprintf+0x90e>
  101298:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  10129c:	7f cb                	jg     101269 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  10129e:	eb 2e                	jmp    1012ce <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  1012a0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012a7:	4c 8b 00             	mov    (%rax),%r8
  1012aa:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1012ae:	0f b6 00             	movzbl (%rax),%eax
  1012b1:	0f b6 c8             	movzbl %al,%ecx
  1012b4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1012ba:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012c1:	89 ce                	mov    %ecx,%esi
  1012c3:	48 89 c7             	mov    %rax,%rdi
  1012c6:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  1012c9:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  1012ce:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1012d2:	0f b6 00             	movzbl (%rax),%eax
  1012d5:	84 c0                	test   %al,%al
  1012d7:	75 c7                	jne    1012a0 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  1012d9:	eb 25                	jmp    101300 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  1012db:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012e2:	48 8b 08             	mov    (%rax),%rcx
  1012e5:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1012eb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012f2:	be 30 00 00 00       	mov    $0x30,%esi
  1012f7:	48 89 c7             	mov    %rax,%rdi
  1012fa:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  1012fc:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  101300:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  101304:	7f d5                	jg     1012db <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  101306:	eb 32                	jmp    10133a <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  101308:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10130f:	4c 8b 00             	mov    (%rax),%r8
  101312:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101316:	0f b6 00             	movzbl (%rax),%eax
  101319:	0f b6 c8             	movzbl %al,%ecx
  10131c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101322:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101329:	89 ce                	mov    %ecx,%esi
  10132b:	48 89 c7             	mov    %rax,%rdi
  10132e:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  101331:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  101336:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  10133a:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  10133e:	7f c8                	jg     101308 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  101340:	eb 25                	jmp    101367 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  101342:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101349:	48 8b 08             	mov    (%rax),%rcx
  10134c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101352:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101359:	be 20 00 00 00       	mov    $0x20,%esi
  10135e:	48 89 c7             	mov    %rax,%rdi
  101361:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  101363:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101367:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  10136b:	7f d5                	jg     101342 <printer_vprintf+0x982>
        }
    done: ;
  10136d:	90                   	nop
    for (; *format; ++format) {
  10136e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101375:	01 
  101376:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10137d:	0f b6 00             	movzbl (%rax),%eax
  101380:	84 c0                	test   %al,%al
  101382:	0f 85 64 f6 ff ff    	jne    1009ec <printer_vprintf+0x2c>
    }
}
  101388:	90                   	nop
  101389:	90                   	nop
  10138a:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  10138e:	c9                   	leave  
  10138f:	c3                   	ret    

0000000000101390 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  101390:	55                   	push   %rbp
  101391:	48 89 e5             	mov    %rsp,%rbp
  101394:	48 83 ec 20          	sub    $0x20,%rsp
  101398:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10139c:	89 f0                	mov    %esi,%eax
  10139e:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1013a1:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  1013a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1013a8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1013ac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013b0:	48 8b 40 08          	mov    0x8(%rax),%rax
  1013b4:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  1013b9:	48 39 d0             	cmp    %rdx,%rax
  1013bc:	72 0c                	jb     1013ca <console_putc+0x3a>
        cp->cursor = console;
  1013be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013c2:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  1013c9:	00 
    }
    if (c == '\n') {
  1013ca:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  1013ce:	75 78                	jne    101448 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  1013d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013d4:	48 8b 40 08          	mov    0x8(%rax),%rax
  1013d8:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1013de:	48 d1 f8             	sar    %rax
  1013e1:	48 89 c1             	mov    %rax,%rcx
  1013e4:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1013eb:	66 66 66 
  1013ee:	48 89 c8             	mov    %rcx,%rax
  1013f1:	48 f7 ea             	imul   %rdx
  1013f4:	48 c1 fa 05          	sar    $0x5,%rdx
  1013f8:	48 89 c8             	mov    %rcx,%rax
  1013fb:	48 c1 f8 3f          	sar    $0x3f,%rax
  1013ff:	48 29 c2             	sub    %rax,%rdx
  101402:	48 89 d0             	mov    %rdx,%rax
  101405:	48 c1 e0 02          	shl    $0x2,%rax
  101409:	48 01 d0             	add    %rdx,%rax
  10140c:	48 c1 e0 04          	shl    $0x4,%rax
  101410:	48 29 c1             	sub    %rax,%rcx
  101413:	48 89 ca             	mov    %rcx,%rdx
  101416:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101419:	eb 25                	jmp    101440 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  10141b:	8b 45 e0             	mov    -0x20(%rbp),%eax
  10141e:	83 c8 20             	or     $0x20,%eax
  101421:	89 c6                	mov    %eax,%esi
  101423:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101427:	48 8b 40 08          	mov    0x8(%rax),%rax
  10142b:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10142f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101433:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101437:	89 f2                	mov    %esi,%edx
  101439:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  10143c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101440:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101444:	75 d5                	jne    10141b <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101446:	eb 24                	jmp    10146c <console_putc+0xdc>
        *cp->cursor++ = c | color;
  101448:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  10144c:	8b 55 e0             	mov    -0x20(%rbp),%edx
  10144f:	09 d0                	or     %edx,%eax
  101451:	89 c6                	mov    %eax,%esi
  101453:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101457:	48 8b 40 08          	mov    0x8(%rax),%rax
  10145b:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10145f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101463:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101467:	89 f2                	mov    %esi,%edx
  101469:	66 89 10             	mov    %dx,(%rax)
}
  10146c:	90                   	nop
  10146d:	c9                   	leave  
  10146e:	c3                   	ret    

000000000010146f <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  10146f:	55                   	push   %rbp
  101470:	48 89 e5             	mov    %rsp,%rbp
  101473:	48 83 ec 30          	sub    $0x30,%rsp
  101477:	89 7d ec             	mov    %edi,-0x14(%rbp)
  10147a:	89 75 e8             	mov    %esi,-0x18(%rbp)
  10147d:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101481:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  101485:	48 c7 45 f0 90 13 10 	movq   $0x101390,-0x10(%rbp)
  10148c:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10148d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  101491:	78 09                	js     10149c <console_vprintf+0x2d>
  101493:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  10149a:	7e 07                	jle    1014a3 <console_vprintf+0x34>
        cpos = 0;
  10149c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  1014a3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1014a6:	48 98                	cltq   
  1014a8:	48 01 c0             	add    %rax,%rax
  1014ab:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  1014b1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1014b5:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1014b9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1014bd:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1014c0:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  1014c4:	48 89 c7             	mov    %rax,%rdi
  1014c7:	e8 f4 f4 ff ff       	call   1009c0 <printer_vprintf>
    return cp.cursor - console;
  1014cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1014d0:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1014d6:	48 d1 f8             	sar    %rax
}
  1014d9:	c9                   	leave  
  1014da:	c3                   	ret    

00000000001014db <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  1014db:	55                   	push   %rbp
  1014dc:	48 89 e5             	mov    %rsp,%rbp
  1014df:	48 83 ec 60          	sub    $0x60,%rsp
  1014e3:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1014e6:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1014e9:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1014ed:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1014f1:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1014f5:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1014f9:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101500:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101504:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101508:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10150c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101510:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101514:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101518:	8b 75 a8             	mov    -0x58(%rbp),%esi
  10151b:	8b 45 ac             	mov    -0x54(%rbp),%eax
  10151e:	89 c7                	mov    %eax,%edi
  101520:	e8 4a ff ff ff       	call   10146f <console_vprintf>
  101525:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101528:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  10152b:	c9                   	leave  
  10152c:	c3                   	ret    

000000000010152d <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  10152d:	55                   	push   %rbp
  10152e:	48 89 e5             	mov    %rsp,%rbp
  101531:	48 83 ec 20          	sub    $0x20,%rsp
  101535:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101539:	89 f0                	mov    %esi,%eax
  10153b:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10153e:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101541:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101545:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101549:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10154d:	48 8b 50 08          	mov    0x8(%rax),%rdx
  101551:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101555:	48 8b 40 10          	mov    0x10(%rax),%rax
  101559:	48 39 c2             	cmp    %rax,%rdx
  10155c:	73 1a                	jae    101578 <string_putc+0x4b>
        *sp->s++ = c;
  10155e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101562:	48 8b 40 08          	mov    0x8(%rax),%rax
  101566:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10156a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10156e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101572:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101576:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101578:	90                   	nop
  101579:	c9                   	leave  
  10157a:	c3                   	ret    

000000000010157b <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  10157b:	55                   	push   %rbp
  10157c:	48 89 e5             	mov    %rsp,%rbp
  10157f:	48 83 ec 40          	sub    $0x40,%rsp
  101583:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101587:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  10158b:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  10158f:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101593:	48 c7 45 e8 2d 15 10 	movq   $0x10152d,-0x18(%rbp)
  10159a:	00 
    sp.s = s;
  10159b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10159f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1015a3:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1015a8:	74 33                	je     1015dd <vsnprintf+0x62>
        sp.end = s + size - 1;
  1015aa:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1015ae:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1015b2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1015b6:	48 01 d0             	add    %rdx,%rax
  1015b9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1015bd:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1015c1:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1015c5:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1015c9:	be 00 00 00 00       	mov    $0x0,%esi
  1015ce:	48 89 c7             	mov    %rax,%rdi
  1015d1:	e8 ea f3 ff ff       	call   1009c0 <printer_vprintf>
        *sp.s = 0;
  1015d6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1015da:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1015dd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1015e1:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1015e5:	c9                   	leave  
  1015e6:	c3                   	ret    

00000000001015e7 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1015e7:	55                   	push   %rbp
  1015e8:	48 89 e5             	mov    %rsp,%rbp
  1015eb:	48 83 ec 70          	sub    $0x70,%rsp
  1015ef:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1015f3:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1015f7:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1015fb:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1015ff:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101603:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101607:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  10160e:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101612:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101616:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10161a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  10161e:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101622:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101626:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  10162a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10162e:	48 89 c7             	mov    %rax,%rdi
  101631:	e8 45 ff ff ff       	call   10157b <vsnprintf>
  101636:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101639:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  10163c:	c9                   	leave  
  10163d:	c3                   	ret    

000000000010163e <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  10163e:	55                   	push   %rbp
  10163f:	48 89 e5             	mov    %rsp,%rbp
  101642:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101646:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  10164d:	eb 13                	jmp    101662 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  10164f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  101652:	48 98                	cltq   
  101654:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  10165b:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10165e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101662:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101669:	7e e4                	jle    10164f <console_clear+0x11>
    }
    cursorpos = 0;
  10166b:	c7 05 87 79 fb ff 00 	movl   $0x0,-0x48679(%rip)        # b8ffc <cursorpos>
  101672:	00 00 00 
}
  101675:	90                   	nop
  101676:	c9                   	leave  
  101677:	c3                   	ret    
