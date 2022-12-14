
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
  100015:	e8 fa 08 00 00       	call   100914 <srand>
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
  100061:	e8 67 04 00 00       	call   1004cd <calloc>
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
  1000a2:	e8 93 04 00 00       	call   10053a <defrag>
    for(int i = 1; i < 64; ++i) {
  1000a7:	48 83 c3 01          	add    $0x1,%rbx
  1000ab:	48 83 fb 40          	cmp    $0x40,%rbx
  1000af:	75 9b                	jne    10004c <process_main+0x4c>
//     defrag();
// 	
//     if (*((size_t *)((uintptr_t)ptr - 16)) == (1<<14))
// 	    panic("success!");

    TEST_PASS();
  1000b1:	bf a2 16 10 00       	mov    $0x1016a2,%edi
  1000b6:	b8 00 00 00 00       	mov    $0x0,%eax
  1000bb:	e8 b8 00 00 00       	call   100178 <kernel_panic>
            assert(ptr != NULL);
  1000c0:	ba 70 16 10 00       	mov    $0x101670,%edx
  1000c5:	be 18 00 00 00       	mov    $0x18,%esi
  1000ca:	bf 7c 16 10 00       	mov    $0x10167c,%edi
  1000cf:	e8 72 01 00 00       	call   100246 <assert_fail>
                assert(((char *)ptr)[k] == 0);
  1000d4:	ba 8c 16 10 00       	mov    $0x10168c,%edx
  1000d9:	be 1b 00 00 00       	mov    $0x1b,%esi
  1000de:	bf 7c 16 10 00       	mov    $0x10167c,%edi
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
  100130:	0f b6 b7 f5 16 10 00 	movzbl 0x1016f5(%rdi),%esi
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
  10015e:	e8 03 13 00 00       	call   101466 <console_vprintf>
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
  1001b7:	be bd 16 10 00       	mov    $0x1016bd,%esi
  1001bc:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  1001c3:	e8 55 04 00 00       	call   10061d <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  1001c8:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  1001cc:	48 89 da             	mov    %rbx,%rdx
  1001cf:	be 99 00 00 00       	mov    $0x99,%esi
  1001d4:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  1001db:	e8 92 13 00 00       	call   101572 <vsnprintf>
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
  100200:	ba c7 16 10 00       	mov    $0x1016c7,%edx
  100205:	be 00 c0 00 00       	mov    $0xc000,%esi
  10020a:	bf 30 07 00 00       	mov    $0x730,%edi
  10020f:	b8 00 00 00 00       	mov    $0x0,%eax
  100214:	e8 b9 12 00 00       	call   1014d2 <console_printf>
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
  10023a:	be c5 16 10 00       	mov    $0x1016c5,%esi
  10023f:	e8 86 05 00 00       	call   1007ca <strcpy>
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
  100253:	ba d0 16 10 00       	mov    $0x1016d0,%edx
  100258:	be 00 c0 00 00       	mov    $0xc000,%esi
  10025d:	bf 30 07 00 00       	mov    $0x730,%edi
  100262:	b8 00 00 00 00       	mov    $0x0,%eax
  100267:	e8 66 12 00 00       	call   1014d2 <console_printf>
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
void extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  100317:	48 81 c7 ff 3f 00 00 	add    $0x3fff,%rdi
  10031e:	48 81 e7 00 c0 ff ff 	and    $0xffffffffffffc000,%rdi
  100325:	cd 3a                	int    $0x3a
  100327:	48 89 05 e2 20 00 00 	mov    %rax,0x20e2(%rip)        # 102410 <result.0>
	void *bp = sbrk(chunk_aligned_size);

	// setup pointer
	GET_SIZE(HDRP(bp)) = chunk_aligned_size;
  10032e:	48 89 78 f0          	mov    %rdi,-0x10(%rax)
	GET_ALLOC(HDRP(bp)) = 0;
  100332:	c7 40 f8 00 00 00 00 	movl   $0x0,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  100339:	48 8b 15 c0 20 00 00 	mov    0x20c0(%rip),%rdx        # 102400 <free_list>
  100340:	48 89 10             	mov    %rdx,(%rax)
	PREV_FPTR(bp) = NULL;
  100343:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  10034a:	00 
	GET_SIZE(FTRP(bp)) = GET_SIZE(HDRP(bp));
  10034b:	48 89 7c 07 e0       	mov    %rdi,-0x20(%rdi,%rax,1)

	// add to head of free_list
	if (free_list)
  100350:	48 8b 15 a9 20 00 00 	mov    0x20a9(%rip),%rdx        # 102400 <free_list>
  100357:	48 85 d2             	test   %rdx,%rdx
  10035a:	74 04                	je     100360 <extend+0x49>
		PREV_FPTR(free_list) = bp;
  10035c:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  100360:	48 89 05 99 20 00 00 	mov    %rax,0x2099(%rip)        # 102400 <free_list>

	// update terminal block
	GET_SIZE(HDRP(NEXT_BLKP(bp))) = 0;
  100367:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  10036b:	48 c7 44 10 f0 00 00 	movq   $0x0,-0x10(%rax,%rdx,1)
  100372:	00 00 
	GET_ALLOC(HDRP(NEXT_BLKP(bp))) = 1;
  100374:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  100378:	c7 44 10 f8 01 00 00 	movl   $0x1,-0x8(%rax,%rdx,1)
  10037f:	00 
}
  100380:	c3                   	ret    

0000000000100381 <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
  100381:	48 89 f8             	mov    %rdi,%rax
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  100384:	48 8b 57 f0          	mov    -0x10(%rdi),%rdx
  100388:	48 29 f2             	sub    %rsi,%rdx

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  10038b:	48 83 fa 30          	cmp    $0x30,%rdx
  10038f:	76 57                	jbe    1003e8 <set_allocated+0x67>
		GET_SIZE(HDRP(bp)) = size;
  100391:	48 89 77 f0          	mov    %rsi,-0x10(%rdi)
		void *leftover_mem_ptr = NEXT_BLKP(bp);
  100395:	48 01 fe             	add    %rdi,%rsi

		GET_SIZE(HDRP(leftover_mem_ptr)) = extra_size;
  100398:	48 89 56 f0          	mov    %rdx,-0x10(%rsi)
		GET_ALLOC(HDRP(leftover_mem_ptr)) = 0;
  10039c:	c7 46 f8 00 00 00 00 	movl   $0x0,-0x8(%rsi)
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp); // pointers to the nearby free blocks
  1003a3:	48 8b 0f             	mov    (%rdi),%rcx
  1003a6:	48 89 0e             	mov    %rcx,(%rsi)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  1003a9:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  1003ad:	48 89 4e 08          	mov    %rcx,0x8(%rsi)
		GET_SIZE(FTRP(leftover_mem_ptr)) = GET_SIZE(HDRP(leftover_mem_ptr));
  1003b1:	48 89 54 16 e0       	mov    %rdx,-0x20(%rsi,%rdx,1)

		// update the free list
		if (free_list == bp)
  1003b6:	48 39 3d 43 20 00 00 	cmp    %rdi,0x2043(%rip)        # 102400 <free_list>
  1003bd:	74 20                	je     1003df <set_allocated+0x5e>
			free_list = leftover_mem_ptr;

		if (PREV_FPTR(bp))
  1003bf:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1003c3:	48 85 d2             	test   %rdx,%rdx
  1003c6:	74 03                	je     1003cb <set_allocated+0x4a>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  1003c8:	48 89 32             	mov    %rsi,(%rdx)
		if (NEXT_FPTR(bp))
  1003cb:	48 8b 10             	mov    (%rax),%rdx
  1003ce:	48 85 d2             	test   %rdx,%rdx
  1003d1:	74 04                	je     1003d7 <set_allocated+0x56>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  1003d3:	48 89 72 08          	mov    %rsi,0x8(%rdx)
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
		if (NEXT_FPTR(bp))
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
	}
	
	GET_ALLOC(HDRP(bp)) = 1;
  1003d7:	c7 40 f8 01 00 00 00 	movl   $0x1,-0x8(%rax)
}
  1003de:	c3                   	ret    
			free_list = leftover_mem_ptr;
  1003df:	48 89 35 1a 20 00 00 	mov    %rsi,0x201a(%rip)        # 102400 <free_list>
  1003e6:	eb d7                	jmp    1003bf <set_allocated+0x3e>
		if (free_list == bp)
  1003e8:	48 39 3d 11 20 00 00 	cmp    %rdi,0x2011(%rip)        # 102400 <free_list>
  1003ef:	74 21                	je     100412 <set_allocated+0x91>
		if (PREV_FPTR(bp))
  1003f1:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1003f5:	48 85 d2             	test   %rdx,%rdx
  1003f8:	74 06                	je     100400 <set_allocated+0x7f>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  1003fa:	48 8b 08             	mov    (%rax),%rcx
  1003fd:	48 89 0a             	mov    %rcx,(%rdx)
		if (NEXT_FPTR(bp))
  100400:	48 8b 10             	mov    (%rax),%rdx
  100403:	48 85 d2             	test   %rdx,%rdx
  100406:	74 cf                	je     1003d7 <set_allocated+0x56>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  100408:	48 8b 48 08          	mov    0x8(%rax),%rcx
  10040c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100410:	eb c5                	jmp    1003d7 <set_allocated+0x56>
			free_list = NEXT_FPTR(bp);
  100412:	48 8b 17             	mov    (%rdi),%rdx
  100415:	48 89 15 e4 1f 00 00 	mov    %rdx,0x1fe4(%rip)        # 102400 <free_list>
  10041c:	eb d3                	jmp    1003f1 <set_allocated+0x70>

000000000010041e <malloc>:

void *malloc(uint64_t numbytes) {
  10041e:	55                   	push   %rbp
  10041f:	48 89 e5             	mov    %rsp,%rbp
  100422:	41 55                	push   %r13
  100424:	41 54                	push   %r12
  100426:	53                   	push   %rbx
  100427:	48 83 ec 08          	sub    $0x8,%rsp
  10042b:	49 89 fc             	mov    %rdi,%r12
	if (!initialized_heap)
  10042e:	83 3d d3 1f 00 00 00 	cmpl   $0x0,0x1fd3(%rip)        # 102408 <initialized_heap>
  100435:	74 66                	je     10049d <malloc+0x7f>
		heap_init();

	if (numbytes == 0)
  100437:	4d 85 e4             	test   %r12,%r12
  10043a:	0f 84 86 00 00 00    	je     1004c6 <malloc+0xa8>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  100440:	49 83 c4 1f          	add    $0x1f,%r12
  100444:	49 83 e4 f0          	and    $0xfffffffffffffff0,%r12
  100448:	b8 30 00 00 00       	mov    $0x30,%eax
  10044d:	49 39 c4             	cmp    %rax,%r12
  100450:	4c 0f 42 e0          	cmovb  %rax,%r12
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);

	void *bp = free_list;
  100454:	48 8b 1d a5 1f 00 00 	mov    0x1fa5(%rip),%rbx        # 102400 <free_list>
	while (bp) {
  10045b:	48 85 db             	test   %rbx,%rbx
  10045e:	74 0e                	je     10046e <malloc+0x50>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  100460:	4c 39 63 f0          	cmp    %r12,-0x10(%rbx)
  100464:	73 3e                	jae    1004a4 <malloc+0x86>
			set_allocated(bp, aligned_size);
			return bp;
		}

		bp = NEXT_FPTR(bp);
  100466:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  100469:	48 85 db             	test   %rbx,%rbx
  10046c:	75 f2                	jne    100460 <malloc+0x42>
  10046e:	bf 00 00 00 00       	mov    $0x0,%edi
  100473:	cd 3a                	int    $0x3a
  100475:	49 89 c5             	mov    %rax,%r13
  100478:	48 89 05 91 1f 00 00 	mov    %rax,0x1f91(%rip)        # 102410 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  10047f:	48 89 c3             	mov    %rax,%rbx
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	if (bp == (void *)0xffffffffffffffef){
  100482:	48 83 f8 ef          	cmp    $0xffffffffffffffef,%rax
  100486:	74 35                	je     1004bd <malloc+0x9f>
		panic("I'm panicking");
		return NULL;}
	extend(aligned_size);
  100488:	4c 89 e7             	mov    %r12,%rdi
  10048b:	e8 87 fe ff ff       	call   100317 <extend>
	set_allocated(bp, aligned_size);
  100490:	4c 89 e6             	mov    %r12,%rsi
  100493:	4c 89 ef             	mov    %r13,%rdi
  100496:	e8 e6 fe ff ff       	call   100381 <set_allocated>
    return bp;
  10049b:	eb 12                	jmp    1004af <malloc+0x91>
		heap_init();
  10049d:	e8 d3 fd ff ff       	call   100275 <heap_init>
  1004a2:	eb 93                	jmp    100437 <malloc+0x19>
			set_allocated(bp, aligned_size);
  1004a4:	4c 89 e6             	mov    %r12,%rsi
  1004a7:	48 89 df             	mov    %rbx,%rdi
  1004aa:	e8 d2 fe ff ff       	call   100381 <set_allocated>
}
  1004af:	48 89 d8             	mov    %rbx,%rax
  1004b2:	48 83 c4 08          	add    $0x8,%rsp
  1004b6:	5b                   	pop    %rbx
  1004b7:	41 5c                	pop    %r12
  1004b9:	41 5d                	pop    %r13
  1004bb:	5d                   	pop    %rbp
  1004bc:	c3                   	ret    
    asm volatile ("int %0" : /* no result */
  1004bd:	bf fa 16 10 00       	mov    $0x1016fa,%edi
  1004c2:	cd 30                	int    $0x30
 loop: goto loop;
  1004c4:	eb fe                	jmp    1004c4 <malloc+0xa6>
		return NULL;
  1004c6:	bb 00 00 00 00       	mov    $0x0,%ebx
  1004cb:	eb e2                	jmp    1004af <malloc+0x91>

00000000001004cd <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  1004cd:	55                   	push   %rbp
  1004ce:	48 89 e5             	mov    %rsp,%rbp
  1004d1:	41 54                	push   %r12
  1004d3:	53                   	push   %rbx
	void *bp = malloc(num * sz);
  1004d4:	48 0f af fe          	imul   %rsi,%rdi
  1004d8:	49 89 fc             	mov    %rdi,%r12
  1004db:	e8 3e ff ff ff       	call   10041e <malloc>
  1004e0:	48 89 c3             	mov    %rax,%rbx
	memset(bp, 0, num * sz);
  1004e3:	4c 89 e2             	mov    %r12,%rdx
  1004e6:	be 00 00 00 00       	mov    $0x0,%esi
  1004eb:	48 89 c7             	mov    %rax,%rdi
  1004ee:	e8 28 02 00 00       	call   10071b <memset>
	return bp;
}
  1004f3:	48 89 d8             	mov    %rbx,%rax
  1004f6:	5b                   	pop    %rbx
  1004f7:	41 5c                	pop    %r12
  1004f9:	5d                   	pop    %rbp
  1004fa:	c3                   	ret    

00000000001004fb <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  1004fb:	55                   	push   %rbp
  1004fc:	48 89 e5             	mov    %rsp,%rbp
  1004ff:	41 54                	push   %r12
  100501:	53                   	push   %rbx
  100502:	48 89 fb             	mov    %rdi,%rbx
	// first check if there's enough space in the block already
	if (GET_SIZE(HDRP(ptr)) >= sz)
  100505:	48 39 77 f0          	cmp    %rsi,-0x10(%rdi)
  100509:	72 08                	jb     100513 <realloc+0x18>
	void *bigger_ptr = malloc(sz);
	memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
	free(ptr);

    return bigger_ptr;
}
  10050b:	48 89 d8             	mov    %rbx,%rax
  10050e:	5b                   	pop    %rbx
  10050f:	41 5c                	pop    %r12
  100511:	5d                   	pop    %rbp
  100512:	c3                   	ret    
	void *bigger_ptr = malloc(sz);
  100513:	48 89 f7             	mov    %rsi,%rdi
  100516:	e8 03 ff ff ff       	call   10041e <malloc>
  10051b:	49 89 c4             	mov    %rax,%r12
	memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
  10051e:	48 8b 53 f0          	mov    -0x10(%rbx),%rdx
  100522:	48 89 de             	mov    %rbx,%rsi
  100525:	48 89 c7             	mov    %rax,%rdi
  100528:	e8 f0 00 00 00       	call   10061d <memcpy>
	free(ptr);
  10052d:	48 89 df             	mov    %rbx,%rdi
  100530:	e8 a8 fd ff ff       	call   1002dd <free>
    return bigger_ptr;
  100535:	4c 89 e3             	mov    %r12,%rbx
  100538:	eb d1                	jmp    10050b <realloc+0x10>

000000000010053a <defrag>:

void defrag() {
	void *fp = free_list;
  10053a:	48 8b 05 bf 1e 00 00 	mov    0x1ebf(%rip),%rax        # 102400 <free_list>
	while (fp != NULL) {
  100541:	48 85 c0             	test   %rax,%rax
  100544:	75 3a                	jne    100580 <defrag+0x46>
			GET_SIZE(FTRP(prev_block)) = GET_SIZE(HDRP(prev_block));
		}

		fp = NEXT_FPTR(fp);
	}
}
  100546:	c3                   	ret    
				free_list = NEXT_FPTR(next_block);
  100547:	48 8b 0a             	mov    (%rdx),%rcx
  10054a:	48 89 0d af 1e 00 00 	mov    %rcx,0x1eaf(%rip)        # 102400 <free_list>
  100551:	eb 43                	jmp    100596 <defrag+0x5c>
			fp = NEXT_FPTR(fp);
  100553:	48 8b 00             	mov    (%rax),%rax
			continue;
  100556:	eb 23                	jmp    10057b <defrag+0x41>
				free_list = NEXT_FPTR(fp);
  100558:	48 8b 08             	mov    (%rax),%rcx
  10055b:	48 89 0d 9e 1e 00 00 	mov    %rcx,0x1e9e(%rip)        # 102400 <free_list>
  100562:	e9 88 00 00 00       	jmp    1005ef <defrag+0xb5>
			GET_SIZE(HDRP(prev_block)) = GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp));
  100567:	48 8b 48 f0          	mov    -0x10(%rax),%rcx
  10056b:	48 03 4a f0          	add    -0x10(%rdx),%rcx
  10056f:	48 89 4a f0          	mov    %rcx,-0x10(%rdx)
			GET_SIZE(FTRP(prev_block)) = GET_SIZE(HDRP(prev_block));
  100573:	48 89 4c 0a e0       	mov    %rcx,-0x20(%rdx,%rcx,1)
		fp = NEXT_FPTR(fp);
  100578:	48 8b 00             	mov    (%rax),%rax
	while (fp != NULL) {
  10057b:	48 85 c0             	test   %rax,%rax
  10057e:	74 c6                	je     100546 <defrag+0xc>
		void *next_block = NEXT_BLKP(fp);
  100580:	48 89 c2             	mov    %rax,%rdx
  100583:	48 03 50 f0          	add    -0x10(%rax),%rdx
		if (!GET_ALLOC(HDRP(next_block))) {
  100587:	83 7a f8 00          	cmpl   $0x0,-0x8(%rdx)
  10058b:	75 39                	jne    1005c6 <defrag+0x8c>
			if (free_list == next_block)
  10058d:	48 39 15 6c 1e 00 00 	cmp    %rdx,0x1e6c(%rip)        # 102400 <free_list>
  100594:	74 b1                	je     100547 <defrag+0xd>
			if (PREV_FPTR(next_block)) 
  100596:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  10059a:	48 85 c9             	test   %rcx,%rcx
  10059d:	74 06                	je     1005a5 <defrag+0x6b>
				NEXT_FPTR(PREV_FPTR(next_block)) = NEXT_FPTR(next_block);
  10059f:	48 8b 32             	mov    (%rdx),%rsi
  1005a2:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(next_block)) 
  1005a5:	48 8b 0a             	mov    (%rdx),%rcx
  1005a8:	48 85 c9             	test   %rcx,%rcx
  1005ab:	74 08                	je     1005b5 <defrag+0x7b>
				PREV_FPTR(NEXT_FPTR(next_block)) = PREV_FPTR(next_block);
  1005ad:	48 8b 72 08          	mov    0x8(%rdx),%rsi
  1005b1:	48 89 71 08          	mov    %rsi,0x8(%rcx)
			GET_SIZE(HDRP(fp)) = GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block));
  1005b5:	48 8b 52 f0          	mov    -0x10(%rdx),%rdx
  1005b9:	48 03 50 f0          	add    -0x10(%rax),%rdx
  1005bd:	48 89 50 f0          	mov    %rdx,-0x10(%rax)
			GET_SIZE(FTRP(fp)) = GET_SIZE(HDRP(fp));
  1005c1:	48 89 54 10 e0       	mov    %rdx,-0x20(%rax,%rdx,1)
		void *prev_block = PREV_BLKP(fp);
  1005c6:	48 89 c2             	mov    %rax,%rdx
  1005c9:	48 2b 50 e0          	sub    -0x20(%rax),%rdx
		if (GET_SIZE(HDRP(prev_block)) != GET_SIZE(FTRP(prev_block))){
  1005cd:	48 8b 4a f0          	mov    -0x10(%rdx),%rcx
  1005d1:	48 3b 4c 0a e0       	cmp    -0x20(%rdx,%rcx,1),%rcx
  1005d6:	0f 85 77 ff ff ff    	jne    100553 <defrag+0x19>
		if (!GET_ALLOC(HDRP(prev_block))) {
  1005dc:	83 7a f8 00          	cmpl   $0x0,-0x8(%rdx)
  1005e0:	75 96                	jne    100578 <defrag+0x3e>
			if (free_list == fp)
  1005e2:	48 39 05 17 1e 00 00 	cmp    %rax,0x1e17(%rip)        # 102400 <free_list>
  1005e9:	0f 84 69 ff ff ff    	je     100558 <defrag+0x1e>
			if (PREV_FPTR(fp)) 
  1005ef:	48 8b 48 08          	mov    0x8(%rax),%rcx
  1005f3:	48 85 c9             	test   %rcx,%rcx
  1005f6:	74 06                	je     1005fe <defrag+0xc4>
				NEXT_FPTR(PREV_FPTR(fp)) = NEXT_FPTR(fp);
  1005f8:	48 8b 30             	mov    (%rax),%rsi
  1005fb:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(fp)) 
  1005fe:	48 8b 08             	mov    (%rax),%rcx
  100601:	48 85 c9             	test   %rcx,%rcx
  100604:	0f 84 5d ff ff ff    	je     100567 <defrag+0x2d>
				PREV_FPTR(NEXT_FPTR(fp)) = PREV_FPTR(fp);
  10060a:	48 8b 70 08          	mov    0x8(%rax),%rsi
  10060e:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  100612:	e9 50 ff ff ff       	jmp    100567 <defrag+0x2d>

0000000000100617 <heap_info>:

int heap_info(heap_info_struct *info) {
    return 0;
}
  100617:	b8 00 00 00 00       	mov    $0x0,%eax
  10061c:	c3                   	ret    

000000000010061d <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  10061d:	55                   	push   %rbp
  10061e:	48 89 e5             	mov    %rsp,%rbp
  100621:	48 83 ec 28          	sub    $0x28,%rsp
  100625:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100629:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10062d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100631:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100635:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100639:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10063d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100641:	eb 1c                	jmp    10065f <memcpy+0x42>
        *d = *s;
  100643:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100647:	0f b6 10             	movzbl (%rax),%edx
  10064a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10064e:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100650:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100655:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10065a:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  10065f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100664:	75 dd                	jne    100643 <memcpy+0x26>
    }
    return dst;
  100666:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10066a:	c9                   	leave  
  10066b:	c3                   	ret    

000000000010066c <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  10066c:	55                   	push   %rbp
  10066d:	48 89 e5             	mov    %rsp,%rbp
  100670:	48 83 ec 28          	sub    $0x28,%rsp
  100674:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100678:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10067c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100680:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100684:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  100688:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10068c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100690:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100694:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  100698:	73 6a                	jae    100704 <memmove+0x98>
  10069a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10069e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1006a2:	48 01 d0             	add    %rdx,%rax
  1006a5:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1006a9:	73 59                	jae    100704 <memmove+0x98>
        s += n, d += n;
  1006ab:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1006af:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1006b3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1006b7:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1006bb:	eb 17                	jmp    1006d4 <memmove+0x68>
            *--d = *--s;
  1006bd:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1006c2:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1006c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006cb:	0f b6 10             	movzbl (%rax),%edx
  1006ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1006d2:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1006d4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1006d8:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1006dc:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1006e0:	48 85 c0             	test   %rax,%rax
  1006e3:	75 d8                	jne    1006bd <memmove+0x51>
    if (s < d && s + n > d) {
  1006e5:	eb 2e                	jmp    100715 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1006e7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1006eb:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1006ef:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1006f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1006f7:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1006fb:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  1006ff:	0f b6 12             	movzbl (%rdx),%edx
  100702:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100704:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100708:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10070c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100710:	48 85 c0             	test   %rax,%rax
  100713:	75 d2                	jne    1006e7 <memmove+0x7b>
        }
    }
    return dst;
  100715:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100719:	c9                   	leave  
  10071a:	c3                   	ret    

000000000010071b <memset>:

void* memset(void* v, int c, size_t n) {
  10071b:	55                   	push   %rbp
  10071c:	48 89 e5             	mov    %rsp,%rbp
  10071f:	48 83 ec 28          	sub    $0x28,%rsp
  100723:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100727:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  10072a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10072e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100732:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100736:	eb 15                	jmp    10074d <memset+0x32>
        *p = c;
  100738:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10073b:	89 c2                	mov    %eax,%edx
  10073d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100741:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100743:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100748:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10074d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100752:	75 e4                	jne    100738 <memset+0x1d>
    }
    return v;
  100754:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100758:	c9                   	leave  
  100759:	c3                   	ret    

000000000010075a <strlen>:

size_t strlen(const char* s) {
  10075a:	55                   	push   %rbp
  10075b:	48 89 e5             	mov    %rsp,%rbp
  10075e:	48 83 ec 18          	sub    $0x18,%rsp
  100762:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100766:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  10076d:	00 
  10076e:	eb 0a                	jmp    10077a <strlen+0x20>
        ++n;
  100770:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100775:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  10077a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10077e:	0f b6 00             	movzbl (%rax),%eax
  100781:	84 c0                	test   %al,%al
  100783:	75 eb                	jne    100770 <strlen+0x16>
    }
    return n;
  100785:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100789:	c9                   	leave  
  10078a:	c3                   	ret    

000000000010078b <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  10078b:	55                   	push   %rbp
  10078c:	48 89 e5             	mov    %rsp,%rbp
  10078f:	48 83 ec 20          	sub    $0x20,%rsp
  100793:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100797:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  10079b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1007a2:	00 
  1007a3:	eb 0a                	jmp    1007af <strnlen+0x24>
        ++n;
  1007a5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1007aa:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1007af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007b3:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  1007b7:	74 0b                	je     1007c4 <strnlen+0x39>
  1007b9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1007bd:	0f b6 00             	movzbl (%rax),%eax
  1007c0:	84 c0                	test   %al,%al
  1007c2:	75 e1                	jne    1007a5 <strnlen+0x1a>
    }
    return n;
  1007c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1007c8:	c9                   	leave  
  1007c9:	c3                   	ret    

00000000001007ca <strcpy>:

char* strcpy(char* dst, const char* src) {
  1007ca:	55                   	push   %rbp
  1007cb:	48 89 e5             	mov    %rsp,%rbp
  1007ce:	48 83 ec 20          	sub    $0x20,%rsp
  1007d2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1007d6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1007da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1007de:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1007e2:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1007e6:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1007ea:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1007ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007f2:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1007f6:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  1007fa:	0f b6 12             	movzbl (%rdx),%edx
  1007fd:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  1007ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100803:	48 83 e8 01          	sub    $0x1,%rax
  100807:	0f b6 00             	movzbl (%rax),%eax
  10080a:	84 c0                	test   %al,%al
  10080c:	75 d4                	jne    1007e2 <strcpy+0x18>
    return dst;
  10080e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100812:	c9                   	leave  
  100813:	c3                   	ret    

0000000000100814 <strcmp>:

int strcmp(const char* a, const char* b) {
  100814:	55                   	push   %rbp
  100815:	48 89 e5             	mov    %rsp,%rbp
  100818:	48 83 ec 10          	sub    $0x10,%rsp
  10081c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100820:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100824:	eb 0a                	jmp    100830 <strcmp+0x1c>
        ++a, ++b;
  100826:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10082b:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100830:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100834:	0f b6 00             	movzbl (%rax),%eax
  100837:	84 c0                	test   %al,%al
  100839:	74 1d                	je     100858 <strcmp+0x44>
  10083b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10083f:	0f b6 00             	movzbl (%rax),%eax
  100842:	84 c0                	test   %al,%al
  100844:	74 12                	je     100858 <strcmp+0x44>
  100846:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10084a:	0f b6 10             	movzbl (%rax),%edx
  10084d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100851:	0f b6 00             	movzbl (%rax),%eax
  100854:	38 c2                	cmp    %al,%dl
  100856:	74 ce                	je     100826 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100858:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10085c:	0f b6 00             	movzbl (%rax),%eax
  10085f:	89 c2                	mov    %eax,%edx
  100861:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100865:	0f b6 00             	movzbl (%rax),%eax
  100868:	38 d0                	cmp    %dl,%al
  10086a:	0f 92 c0             	setb   %al
  10086d:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100870:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100874:	0f b6 00             	movzbl (%rax),%eax
  100877:	89 c1                	mov    %eax,%ecx
  100879:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10087d:	0f b6 00             	movzbl (%rax),%eax
  100880:	38 c1                	cmp    %al,%cl
  100882:	0f 92 c0             	setb   %al
  100885:	0f b6 c0             	movzbl %al,%eax
  100888:	29 c2                	sub    %eax,%edx
  10088a:	89 d0                	mov    %edx,%eax
}
  10088c:	c9                   	leave  
  10088d:	c3                   	ret    

000000000010088e <strchr>:

char* strchr(const char* s, int c) {
  10088e:	55                   	push   %rbp
  10088f:	48 89 e5             	mov    %rsp,%rbp
  100892:	48 83 ec 10          	sub    $0x10,%rsp
  100896:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  10089a:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  10089d:	eb 05                	jmp    1008a4 <strchr+0x16>
        ++s;
  10089f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1008a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008a8:	0f b6 00             	movzbl (%rax),%eax
  1008ab:	84 c0                	test   %al,%al
  1008ad:	74 0e                	je     1008bd <strchr+0x2f>
  1008af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008b3:	0f b6 00             	movzbl (%rax),%eax
  1008b6:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1008b9:	38 d0                	cmp    %dl,%al
  1008bb:	75 e2                	jne    10089f <strchr+0x11>
    }
    if (*s == (char) c) {
  1008bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008c1:	0f b6 00             	movzbl (%rax),%eax
  1008c4:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1008c7:	38 d0                	cmp    %dl,%al
  1008c9:	75 06                	jne    1008d1 <strchr+0x43>
        return (char*) s;
  1008cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008cf:	eb 05                	jmp    1008d6 <strchr+0x48>
    } else {
        return NULL;
  1008d1:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1008d6:	c9                   	leave  
  1008d7:	c3                   	ret    

00000000001008d8 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1008d8:	55                   	push   %rbp
  1008d9:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1008dc:	8b 05 36 1b 00 00    	mov    0x1b36(%rip),%eax        # 102418 <rand_seed_set>
  1008e2:	85 c0                	test   %eax,%eax
  1008e4:	75 0a                	jne    1008f0 <rand+0x18>
        srand(819234718U);
  1008e6:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1008eb:	e8 24 00 00 00       	call   100914 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1008f0:	8b 05 26 1b 00 00    	mov    0x1b26(%rip),%eax        # 10241c <rand_seed>
  1008f6:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  1008fc:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100901:	89 05 15 1b 00 00    	mov    %eax,0x1b15(%rip)        # 10241c <rand_seed>
    return rand_seed & RAND_MAX;
  100907:	8b 05 0f 1b 00 00    	mov    0x1b0f(%rip),%eax        # 10241c <rand_seed>
  10090d:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100912:	5d                   	pop    %rbp
  100913:	c3                   	ret    

0000000000100914 <srand>:

void srand(unsigned seed) {
  100914:	55                   	push   %rbp
  100915:	48 89 e5             	mov    %rsp,%rbp
  100918:	48 83 ec 08          	sub    $0x8,%rsp
  10091c:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  10091f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100922:	89 05 f4 1a 00 00    	mov    %eax,0x1af4(%rip)        # 10241c <rand_seed>
    rand_seed_set = 1;
  100928:	c7 05 e6 1a 00 00 01 	movl   $0x1,0x1ae6(%rip)        # 102418 <rand_seed_set>
  10092f:	00 00 00 
}
  100932:	90                   	nop
  100933:	c9                   	leave  
  100934:	c3                   	ret    

0000000000100935 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100935:	55                   	push   %rbp
  100936:	48 89 e5             	mov    %rsp,%rbp
  100939:	48 83 ec 28          	sub    $0x28,%rsp
  10093d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100941:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100945:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100948:	48 c7 45 f8 f0 18 10 	movq   $0x1018f0,-0x8(%rbp)
  10094f:	00 
    if (base < 0) {
  100950:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100954:	79 0b                	jns    100961 <fill_numbuf+0x2c>
        digits = lower_digits;
  100956:	48 c7 45 f8 10 19 10 	movq   $0x101910,-0x8(%rbp)
  10095d:	00 
        base = -base;
  10095e:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100961:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100966:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10096a:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  10096d:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100970:	48 63 c8             	movslq %eax,%rcx
  100973:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100977:	ba 00 00 00 00       	mov    $0x0,%edx
  10097c:	48 f7 f1             	div    %rcx
  10097f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100983:	48 01 d0             	add    %rdx,%rax
  100986:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10098b:	0f b6 10             	movzbl (%rax),%edx
  10098e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100992:	88 10                	mov    %dl,(%rax)
        val /= base;
  100994:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100997:	48 63 f0             	movslq %eax,%rsi
  10099a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10099e:	ba 00 00 00 00       	mov    $0x0,%edx
  1009a3:	48 f7 f6             	div    %rsi
  1009a6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  1009aa:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  1009af:	75 bc                	jne    10096d <fill_numbuf+0x38>
    return numbuf_end;
  1009b1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1009b5:	c9                   	leave  
  1009b6:	c3                   	ret    

00000000001009b7 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1009b7:	55                   	push   %rbp
  1009b8:	48 89 e5             	mov    %rsp,%rbp
  1009bb:	53                   	push   %rbx
  1009bc:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  1009c3:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1009ca:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1009d0:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1009d7:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1009de:	e9 8a 09 00 00       	jmp    10136d <printer_vprintf+0x9b6>
        if (*format != '%') {
  1009e3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009ea:	0f b6 00             	movzbl (%rax),%eax
  1009ed:	3c 25                	cmp    $0x25,%al
  1009ef:	74 31                	je     100a22 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  1009f1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1009f8:	4c 8b 00             	mov    (%rax),%r8
  1009fb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a02:	0f b6 00             	movzbl (%rax),%eax
  100a05:	0f b6 c8             	movzbl %al,%ecx
  100a08:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100a0e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100a15:	89 ce                	mov    %ecx,%esi
  100a17:	48 89 c7             	mov    %rax,%rdi
  100a1a:	41 ff d0             	call   *%r8
            continue;
  100a1d:	e9 43 09 00 00       	jmp    101365 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100a22:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100a29:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100a30:	01 
  100a31:	eb 44                	jmp    100a77 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  100a33:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a3a:	0f b6 00             	movzbl (%rax),%eax
  100a3d:	0f be c0             	movsbl %al,%eax
  100a40:	89 c6                	mov    %eax,%esi
  100a42:	bf 10 17 10 00       	mov    $0x101710,%edi
  100a47:	e8 42 fe ff ff       	call   10088e <strchr>
  100a4c:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100a50:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100a55:	74 30                	je     100a87 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  100a57:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100a5b:	48 2d 10 17 10 00    	sub    $0x101710,%rax
  100a61:	ba 01 00 00 00       	mov    $0x1,%edx
  100a66:	89 c1                	mov    %eax,%ecx
  100a68:	d3 e2                	shl    %cl,%edx
  100a6a:	89 d0                	mov    %edx,%eax
  100a6c:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100a6f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100a76:	01 
  100a77:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a7e:	0f b6 00             	movzbl (%rax),%eax
  100a81:	84 c0                	test   %al,%al
  100a83:	75 ae                	jne    100a33 <printer_vprintf+0x7c>
  100a85:	eb 01                	jmp    100a88 <printer_vprintf+0xd1>
            } else {
                break;
  100a87:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100a88:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100a8f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a96:	0f b6 00             	movzbl (%rax),%eax
  100a99:	3c 30                	cmp    $0x30,%al
  100a9b:	7e 67                	jle    100b04 <printer_vprintf+0x14d>
  100a9d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100aa4:	0f b6 00             	movzbl (%rax),%eax
  100aa7:	3c 39                	cmp    $0x39,%al
  100aa9:	7f 59                	jg     100b04 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100aab:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100ab2:	eb 2e                	jmp    100ae2 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100ab4:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100ab7:	89 d0                	mov    %edx,%eax
  100ab9:	c1 e0 02             	shl    $0x2,%eax
  100abc:	01 d0                	add    %edx,%eax
  100abe:	01 c0                	add    %eax,%eax
  100ac0:	89 c1                	mov    %eax,%ecx
  100ac2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ac9:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100acd:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100ad4:	0f b6 00             	movzbl (%rax),%eax
  100ad7:	0f be c0             	movsbl %al,%eax
  100ada:	01 c8                	add    %ecx,%eax
  100adc:	83 e8 30             	sub    $0x30,%eax
  100adf:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100ae2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ae9:	0f b6 00             	movzbl (%rax),%eax
  100aec:	3c 2f                	cmp    $0x2f,%al
  100aee:	0f 8e 85 00 00 00    	jle    100b79 <printer_vprintf+0x1c2>
  100af4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100afb:	0f b6 00             	movzbl (%rax),%eax
  100afe:	3c 39                	cmp    $0x39,%al
  100b00:	7e b2                	jle    100ab4 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100b02:	eb 75                	jmp    100b79 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100b04:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b0b:	0f b6 00             	movzbl (%rax),%eax
  100b0e:	3c 2a                	cmp    $0x2a,%al
  100b10:	75 68                	jne    100b7a <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100b12:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b19:	8b 00                	mov    (%rax),%eax
  100b1b:	83 f8 2f             	cmp    $0x2f,%eax
  100b1e:	77 30                	ja     100b50 <printer_vprintf+0x199>
  100b20:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b27:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b2b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b32:	8b 00                	mov    (%rax),%eax
  100b34:	89 c0                	mov    %eax,%eax
  100b36:	48 01 d0             	add    %rdx,%rax
  100b39:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b40:	8b 12                	mov    (%rdx),%edx
  100b42:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b45:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b4c:	89 0a                	mov    %ecx,(%rdx)
  100b4e:	eb 1a                	jmp    100b6a <printer_vprintf+0x1b3>
  100b50:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b57:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b5b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b5f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b66:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b6a:	8b 00                	mov    (%rax),%eax
  100b6c:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100b6f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100b76:	01 
  100b77:	eb 01                	jmp    100b7a <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100b79:	90                   	nop
        }

        // process precision
        int precision = -1;
  100b7a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100b81:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b88:	0f b6 00             	movzbl (%rax),%eax
  100b8b:	3c 2e                	cmp    $0x2e,%al
  100b8d:	0f 85 00 01 00 00    	jne    100c93 <printer_vprintf+0x2dc>
            ++format;
  100b93:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100b9a:	01 
            if (*format >= '0' && *format <= '9') {
  100b9b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ba2:	0f b6 00             	movzbl (%rax),%eax
  100ba5:	3c 2f                	cmp    $0x2f,%al
  100ba7:	7e 67                	jle    100c10 <printer_vprintf+0x259>
  100ba9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bb0:	0f b6 00             	movzbl (%rax),%eax
  100bb3:	3c 39                	cmp    $0x39,%al
  100bb5:	7f 59                	jg     100c10 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100bb7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100bbe:	eb 2e                	jmp    100bee <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100bc0:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100bc3:	89 d0                	mov    %edx,%eax
  100bc5:	c1 e0 02             	shl    $0x2,%eax
  100bc8:	01 d0                	add    %edx,%eax
  100bca:	01 c0                	add    %eax,%eax
  100bcc:	89 c1                	mov    %eax,%ecx
  100bce:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bd5:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100bd9:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100be0:	0f b6 00             	movzbl (%rax),%eax
  100be3:	0f be c0             	movsbl %al,%eax
  100be6:	01 c8                	add    %ecx,%eax
  100be8:	83 e8 30             	sub    $0x30,%eax
  100beb:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100bee:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bf5:	0f b6 00             	movzbl (%rax),%eax
  100bf8:	3c 2f                	cmp    $0x2f,%al
  100bfa:	0f 8e 85 00 00 00    	jle    100c85 <printer_vprintf+0x2ce>
  100c00:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c07:	0f b6 00             	movzbl (%rax),%eax
  100c0a:	3c 39                	cmp    $0x39,%al
  100c0c:	7e b2                	jle    100bc0 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100c0e:	eb 75                	jmp    100c85 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100c10:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c17:	0f b6 00             	movzbl (%rax),%eax
  100c1a:	3c 2a                	cmp    $0x2a,%al
  100c1c:	75 68                	jne    100c86 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100c1e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c25:	8b 00                	mov    (%rax),%eax
  100c27:	83 f8 2f             	cmp    $0x2f,%eax
  100c2a:	77 30                	ja     100c5c <printer_vprintf+0x2a5>
  100c2c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c33:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c37:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c3e:	8b 00                	mov    (%rax),%eax
  100c40:	89 c0                	mov    %eax,%eax
  100c42:	48 01 d0             	add    %rdx,%rax
  100c45:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c4c:	8b 12                	mov    (%rdx),%edx
  100c4e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c51:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c58:	89 0a                	mov    %ecx,(%rdx)
  100c5a:	eb 1a                	jmp    100c76 <printer_vprintf+0x2bf>
  100c5c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c63:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c67:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c6b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c72:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c76:	8b 00                	mov    (%rax),%eax
  100c78:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100c7b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100c82:	01 
  100c83:	eb 01                	jmp    100c86 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100c85:	90                   	nop
            }
            if (precision < 0) {
  100c86:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100c8a:	79 07                	jns    100c93 <printer_vprintf+0x2dc>
                precision = 0;
  100c8c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100c93:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100c9a:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100ca1:	00 
        int length = 0;
  100ca2:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100ca9:	48 c7 45 c8 16 17 10 	movq   $0x101716,-0x38(%rbp)
  100cb0:	00 
    again:
        switch (*format) {
  100cb1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100cb8:	0f b6 00             	movzbl (%rax),%eax
  100cbb:	0f be c0             	movsbl %al,%eax
  100cbe:	83 e8 43             	sub    $0x43,%eax
  100cc1:	83 f8 37             	cmp    $0x37,%eax
  100cc4:	0f 87 9f 03 00 00    	ja     101069 <printer_vprintf+0x6b2>
  100cca:	89 c0                	mov    %eax,%eax
  100ccc:	48 8b 04 c5 28 17 10 	mov    0x101728(,%rax,8),%rax
  100cd3:	00 
  100cd4:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100cd6:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100cdd:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ce4:	01 
            goto again;
  100ce5:	eb ca                	jmp    100cb1 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100ce7:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100ceb:	74 5d                	je     100d4a <printer_vprintf+0x393>
  100ced:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cf4:	8b 00                	mov    (%rax),%eax
  100cf6:	83 f8 2f             	cmp    $0x2f,%eax
  100cf9:	77 30                	ja     100d2b <printer_vprintf+0x374>
  100cfb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d02:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d06:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d0d:	8b 00                	mov    (%rax),%eax
  100d0f:	89 c0                	mov    %eax,%eax
  100d11:	48 01 d0             	add    %rdx,%rax
  100d14:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d1b:	8b 12                	mov    (%rdx),%edx
  100d1d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d20:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d27:	89 0a                	mov    %ecx,(%rdx)
  100d29:	eb 1a                	jmp    100d45 <printer_vprintf+0x38e>
  100d2b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d32:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d36:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d3a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d41:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d45:	48 8b 00             	mov    (%rax),%rax
  100d48:	eb 5c                	jmp    100da6 <printer_vprintf+0x3ef>
  100d4a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d51:	8b 00                	mov    (%rax),%eax
  100d53:	83 f8 2f             	cmp    $0x2f,%eax
  100d56:	77 30                	ja     100d88 <printer_vprintf+0x3d1>
  100d58:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d5f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d63:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d6a:	8b 00                	mov    (%rax),%eax
  100d6c:	89 c0                	mov    %eax,%eax
  100d6e:	48 01 d0             	add    %rdx,%rax
  100d71:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d78:	8b 12                	mov    (%rdx),%edx
  100d7a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d7d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d84:	89 0a                	mov    %ecx,(%rdx)
  100d86:	eb 1a                	jmp    100da2 <printer_vprintf+0x3eb>
  100d88:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d8f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d93:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d97:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d9e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100da2:	8b 00                	mov    (%rax),%eax
  100da4:	48 98                	cltq   
  100da6:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100daa:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100dae:	48 c1 f8 38          	sar    $0x38,%rax
  100db2:	25 80 00 00 00       	and    $0x80,%eax
  100db7:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100dba:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100dbe:	74 09                	je     100dc9 <printer_vprintf+0x412>
  100dc0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100dc4:	48 f7 d8             	neg    %rax
  100dc7:	eb 04                	jmp    100dcd <printer_vprintf+0x416>
  100dc9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100dcd:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100dd1:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100dd4:	83 c8 60             	or     $0x60,%eax
  100dd7:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100dda:	e9 cf 02 00 00       	jmp    1010ae <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100ddf:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100de3:	74 5d                	je     100e42 <printer_vprintf+0x48b>
  100de5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dec:	8b 00                	mov    (%rax),%eax
  100dee:	83 f8 2f             	cmp    $0x2f,%eax
  100df1:	77 30                	ja     100e23 <printer_vprintf+0x46c>
  100df3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dfa:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100dfe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e05:	8b 00                	mov    (%rax),%eax
  100e07:	89 c0                	mov    %eax,%eax
  100e09:	48 01 d0             	add    %rdx,%rax
  100e0c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e13:	8b 12                	mov    (%rdx),%edx
  100e15:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e18:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e1f:	89 0a                	mov    %ecx,(%rdx)
  100e21:	eb 1a                	jmp    100e3d <printer_vprintf+0x486>
  100e23:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e2a:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e2e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e32:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e39:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e3d:	48 8b 00             	mov    (%rax),%rax
  100e40:	eb 5c                	jmp    100e9e <printer_vprintf+0x4e7>
  100e42:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e49:	8b 00                	mov    (%rax),%eax
  100e4b:	83 f8 2f             	cmp    $0x2f,%eax
  100e4e:	77 30                	ja     100e80 <printer_vprintf+0x4c9>
  100e50:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e57:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e5b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e62:	8b 00                	mov    (%rax),%eax
  100e64:	89 c0                	mov    %eax,%eax
  100e66:	48 01 d0             	add    %rdx,%rax
  100e69:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e70:	8b 12                	mov    (%rdx),%edx
  100e72:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e75:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e7c:	89 0a                	mov    %ecx,(%rdx)
  100e7e:	eb 1a                	jmp    100e9a <printer_vprintf+0x4e3>
  100e80:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e87:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e8b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e8f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e96:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e9a:	8b 00                	mov    (%rax),%eax
  100e9c:	89 c0                	mov    %eax,%eax
  100e9e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100ea2:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100ea6:	e9 03 02 00 00       	jmp    1010ae <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100eab:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100eb2:	e9 28 ff ff ff       	jmp    100ddf <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100eb7:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100ebe:	e9 1c ff ff ff       	jmp    100ddf <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100ec3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100eca:	8b 00                	mov    (%rax),%eax
  100ecc:	83 f8 2f             	cmp    $0x2f,%eax
  100ecf:	77 30                	ja     100f01 <printer_vprintf+0x54a>
  100ed1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ed8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100edc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ee3:	8b 00                	mov    (%rax),%eax
  100ee5:	89 c0                	mov    %eax,%eax
  100ee7:	48 01 d0             	add    %rdx,%rax
  100eea:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ef1:	8b 12                	mov    (%rdx),%edx
  100ef3:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ef6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100efd:	89 0a                	mov    %ecx,(%rdx)
  100eff:	eb 1a                	jmp    100f1b <printer_vprintf+0x564>
  100f01:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f08:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f0c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f10:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f17:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f1b:	48 8b 00             	mov    (%rax),%rax
  100f1e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100f22:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100f29:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100f30:	e9 79 01 00 00       	jmp    1010ae <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100f35:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f3c:	8b 00                	mov    (%rax),%eax
  100f3e:	83 f8 2f             	cmp    $0x2f,%eax
  100f41:	77 30                	ja     100f73 <printer_vprintf+0x5bc>
  100f43:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f4a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100f4e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f55:	8b 00                	mov    (%rax),%eax
  100f57:	89 c0                	mov    %eax,%eax
  100f59:	48 01 d0             	add    %rdx,%rax
  100f5c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f63:	8b 12                	mov    (%rdx),%edx
  100f65:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100f68:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f6f:	89 0a                	mov    %ecx,(%rdx)
  100f71:	eb 1a                	jmp    100f8d <printer_vprintf+0x5d6>
  100f73:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f7a:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f7e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f82:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f89:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f8d:	48 8b 00             	mov    (%rax),%rax
  100f90:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100f94:	e9 15 01 00 00       	jmp    1010ae <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100f99:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fa0:	8b 00                	mov    (%rax),%eax
  100fa2:	83 f8 2f             	cmp    $0x2f,%eax
  100fa5:	77 30                	ja     100fd7 <printer_vprintf+0x620>
  100fa7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fae:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100fb2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fb9:	8b 00                	mov    (%rax),%eax
  100fbb:	89 c0                	mov    %eax,%eax
  100fbd:	48 01 d0             	add    %rdx,%rax
  100fc0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fc7:	8b 12                	mov    (%rdx),%edx
  100fc9:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100fcc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fd3:	89 0a                	mov    %ecx,(%rdx)
  100fd5:	eb 1a                	jmp    100ff1 <printer_vprintf+0x63a>
  100fd7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fde:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fe2:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100fe6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fed:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ff1:	8b 00                	mov    (%rax),%eax
  100ff3:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100ff9:	e9 67 03 00 00       	jmp    101365 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  100ffe:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101002:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  101006:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10100d:	8b 00                	mov    (%rax),%eax
  10100f:	83 f8 2f             	cmp    $0x2f,%eax
  101012:	77 30                	ja     101044 <printer_vprintf+0x68d>
  101014:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10101b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10101f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101026:	8b 00                	mov    (%rax),%eax
  101028:	89 c0                	mov    %eax,%eax
  10102a:	48 01 d0             	add    %rdx,%rax
  10102d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101034:	8b 12                	mov    (%rdx),%edx
  101036:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101039:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101040:	89 0a                	mov    %ecx,(%rdx)
  101042:	eb 1a                	jmp    10105e <printer_vprintf+0x6a7>
  101044:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10104b:	48 8b 40 08          	mov    0x8(%rax),%rax
  10104f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101053:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10105a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10105e:	8b 00                	mov    (%rax),%eax
  101060:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  101063:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  101067:	eb 45                	jmp    1010ae <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  101069:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  10106d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  101071:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101078:	0f b6 00             	movzbl (%rax),%eax
  10107b:	84 c0                	test   %al,%al
  10107d:	74 0c                	je     10108b <printer_vprintf+0x6d4>
  10107f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101086:	0f b6 00             	movzbl (%rax),%eax
  101089:	eb 05                	jmp    101090 <printer_vprintf+0x6d9>
  10108b:	b8 25 00 00 00       	mov    $0x25,%eax
  101090:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  101093:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  101097:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10109e:	0f b6 00             	movzbl (%rax),%eax
  1010a1:	84 c0                	test   %al,%al
  1010a3:	75 08                	jne    1010ad <printer_vprintf+0x6f6>
                format--;
  1010a5:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  1010ac:	01 
            }
            break;
  1010ad:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  1010ae:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010b1:	83 e0 20             	and    $0x20,%eax
  1010b4:	85 c0                	test   %eax,%eax
  1010b6:	74 1e                	je     1010d6 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  1010b8:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1010bc:	48 83 c0 18          	add    $0x18,%rax
  1010c0:	8b 55 e0             	mov    -0x20(%rbp),%edx
  1010c3:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1010c7:	48 89 ce             	mov    %rcx,%rsi
  1010ca:	48 89 c7             	mov    %rax,%rdi
  1010cd:	e8 63 f8 ff ff       	call   100935 <fill_numbuf>
  1010d2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  1010d6:	48 c7 45 c0 16 17 10 	movq   $0x101716,-0x40(%rbp)
  1010dd:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1010de:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010e1:	83 e0 20             	and    $0x20,%eax
  1010e4:	85 c0                	test   %eax,%eax
  1010e6:	74 48                	je     101130 <printer_vprintf+0x779>
  1010e8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010eb:	83 e0 40             	and    $0x40,%eax
  1010ee:	85 c0                	test   %eax,%eax
  1010f0:	74 3e                	je     101130 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  1010f2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010f5:	25 80 00 00 00       	and    $0x80,%eax
  1010fa:	85 c0                	test   %eax,%eax
  1010fc:	74 0a                	je     101108 <printer_vprintf+0x751>
                prefix = "-";
  1010fe:	48 c7 45 c0 17 17 10 	movq   $0x101717,-0x40(%rbp)
  101105:	00 
            if (flags & FLAG_NEGATIVE) {
  101106:	eb 73                	jmp    10117b <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  101108:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10110b:	83 e0 10             	and    $0x10,%eax
  10110e:	85 c0                	test   %eax,%eax
  101110:	74 0a                	je     10111c <printer_vprintf+0x765>
                prefix = "+";
  101112:	48 c7 45 c0 19 17 10 	movq   $0x101719,-0x40(%rbp)
  101119:	00 
            if (flags & FLAG_NEGATIVE) {
  10111a:	eb 5f                	jmp    10117b <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  10111c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10111f:	83 e0 08             	and    $0x8,%eax
  101122:	85 c0                	test   %eax,%eax
  101124:	74 55                	je     10117b <printer_vprintf+0x7c4>
                prefix = " ";
  101126:	48 c7 45 c0 1b 17 10 	movq   $0x10171b,-0x40(%rbp)
  10112d:	00 
            if (flags & FLAG_NEGATIVE) {
  10112e:	eb 4b                	jmp    10117b <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  101130:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101133:	83 e0 20             	and    $0x20,%eax
  101136:	85 c0                	test   %eax,%eax
  101138:	74 42                	je     10117c <printer_vprintf+0x7c5>
  10113a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10113d:	83 e0 01             	and    $0x1,%eax
  101140:	85 c0                	test   %eax,%eax
  101142:	74 38                	je     10117c <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  101144:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  101148:	74 06                	je     101150 <printer_vprintf+0x799>
  10114a:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  10114e:	75 2c                	jne    10117c <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  101150:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  101155:	75 0c                	jne    101163 <printer_vprintf+0x7ac>
  101157:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10115a:	25 00 01 00 00       	and    $0x100,%eax
  10115f:	85 c0                	test   %eax,%eax
  101161:	74 19                	je     10117c <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  101163:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  101167:	75 07                	jne    101170 <printer_vprintf+0x7b9>
  101169:	b8 1d 17 10 00       	mov    $0x10171d,%eax
  10116e:	eb 05                	jmp    101175 <printer_vprintf+0x7be>
  101170:	b8 20 17 10 00       	mov    $0x101720,%eax
  101175:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101179:	eb 01                	jmp    10117c <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  10117b:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  10117c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101180:	78 24                	js     1011a6 <printer_vprintf+0x7ef>
  101182:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101185:	83 e0 20             	and    $0x20,%eax
  101188:	85 c0                	test   %eax,%eax
  10118a:	75 1a                	jne    1011a6 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  10118c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10118f:	48 63 d0             	movslq %eax,%rdx
  101192:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101196:	48 89 d6             	mov    %rdx,%rsi
  101199:	48 89 c7             	mov    %rax,%rdi
  10119c:	e8 ea f5 ff ff       	call   10078b <strnlen>
  1011a1:	89 45 bc             	mov    %eax,-0x44(%rbp)
  1011a4:	eb 0f                	jmp    1011b5 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  1011a6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1011aa:	48 89 c7             	mov    %rax,%rdi
  1011ad:	e8 a8 f5 ff ff       	call   10075a <strlen>
  1011b2:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  1011b5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011b8:	83 e0 20             	and    $0x20,%eax
  1011bb:	85 c0                	test   %eax,%eax
  1011bd:	74 20                	je     1011df <printer_vprintf+0x828>
  1011bf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1011c3:	78 1a                	js     1011df <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  1011c5:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1011c8:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  1011cb:	7e 08                	jle    1011d5 <printer_vprintf+0x81e>
  1011cd:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1011d0:	2b 45 bc             	sub    -0x44(%rbp),%eax
  1011d3:	eb 05                	jmp    1011da <printer_vprintf+0x823>
  1011d5:	b8 00 00 00 00       	mov    $0x0,%eax
  1011da:	89 45 b8             	mov    %eax,-0x48(%rbp)
  1011dd:	eb 5c                	jmp    10123b <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  1011df:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011e2:	83 e0 20             	and    $0x20,%eax
  1011e5:	85 c0                	test   %eax,%eax
  1011e7:	74 4b                	je     101234 <printer_vprintf+0x87d>
  1011e9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011ec:	83 e0 02             	and    $0x2,%eax
  1011ef:	85 c0                	test   %eax,%eax
  1011f1:	74 41                	je     101234 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  1011f3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011f6:	83 e0 04             	and    $0x4,%eax
  1011f9:	85 c0                	test   %eax,%eax
  1011fb:	75 37                	jne    101234 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  1011fd:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101201:	48 89 c7             	mov    %rax,%rdi
  101204:	e8 51 f5 ff ff       	call   10075a <strlen>
  101209:	89 c2                	mov    %eax,%edx
  10120b:	8b 45 bc             	mov    -0x44(%rbp),%eax
  10120e:	01 d0                	add    %edx,%eax
  101210:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  101213:	7e 1f                	jle    101234 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  101215:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101218:	2b 45 bc             	sub    -0x44(%rbp),%eax
  10121b:	89 c3                	mov    %eax,%ebx
  10121d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101221:	48 89 c7             	mov    %rax,%rdi
  101224:	e8 31 f5 ff ff       	call   10075a <strlen>
  101229:	89 c2                	mov    %eax,%edx
  10122b:	89 d8                	mov    %ebx,%eax
  10122d:	29 d0                	sub    %edx,%eax
  10122f:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101232:	eb 07                	jmp    10123b <printer_vprintf+0x884>
        } else {
            zeros = 0;
  101234:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  10123b:	8b 55 bc             	mov    -0x44(%rbp),%edx
  10123e:	8b 45 b8             	mov    -0x48(%rbp),%eax
  101241:	01 d0                	add    %edx,%eax
  101243:	48 63 d8             	movslq %eax,%rbx
  101246:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10124a:	48 89 c7             	mov    %rax,%rdi
  10124d:	e8 08 f5 ff ff       	call   10075a <strlen>
  101252:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  101256:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101259:	29 d0                	sub    %edx,%eax
  10125b:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10125e:	eb 25                	jmp    101285 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  101260:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101267:	48 8b 08             	mov    (%rax),%rcx
  10126a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101270:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101277:	be 20 00 00 00       	mov    $0x20,%esi
  10127c:	48 89 c7             	mov    %rax,%rdi
  10127f:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101281:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101285:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101288:	83 e0 04             	and    $0x4,%eax
  10128b:	85 c0                	test   %eax,%eax
  10128d:	75 36                	jne    1012c5 <printer_vprintf+0x90e>
  10128f:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101293:	7f cb                	jg     101260 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  101295:	eb 2e                	jmp    1012c5 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  101297:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10129e:	4c 8b 00             	mov    (%rax),%r8
  1012a1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1012a5:	0f b6 00             	movzbl (%rax),%eax
  1012a8:	0f b6 c8             	movzbl %al,%ecx
  1012ab:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1012b1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012b8:	89 ce                	mov    %ecx,%esi
  1012ba:	48 89 c7             	mov    %rax,%rdi
  1012bd:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  1012c0:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  1012c5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1012c9:	0f b6 00             	movzbl (%rax),%eax
  1012cc:	84 c0                	test   %al,%al
  1012ce:	75 c7                	jne    101297 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  1012d0:	eb 25                	jmp    1012f7 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  1012d2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012d9:	48 8b 08             	mov    (%rax),%rcx
  1012dc:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1012e2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012e9:	be 30 00 00 00       	mov    $0x30,%esi
  1012ee:	48 89 c7             	mov    %rax,%rdi
  1012f1:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  1012f3:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  1012f7:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  1012fb:	7f d5                	jg     1012d2 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  1012fd:	eb 32                	jmp    101331 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  1012ff:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101306:	4c 8b 00             	mov    (%rax),%r8
  101309:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  10130d:	0f b6 00             	movzbl (%rax),%eax
  101310:	0f b6 c8             	movzbl %al,%ecx
  101313:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101319:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101320:	89 ce                	mov    %ecx,%esi
  101322:	48 89 c7             	mov    %rax,%rdi
  101325:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  101328:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  10132d:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  101331:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  101335:	7f c8                	jg     1012ff <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  101337:	eb 25                	jmp    10135e <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  101339:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101340:	48 8b 08             	mov    (%rax),%rcx
  101343:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101349:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101350:	be 20 00 00 00       	mov    $0x20,%esi
  101355:	48 89 c7             	mov    %rax,%rdi
  101358:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  10135a:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  10135e:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101362:	7f d5                	jg     101339 <printer_vprintf+0x982>
        }
    done: ;
  101364:	90                   	nop
    for (; *format; ++format) {
  101365:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10136c:	01 
  10136d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101374:	0f b6 00             	movzbl (%rax),%eax
  101377:	84 c0                	test   %al,%al
  101379:	0f 85 64 f6 ff ff    	jne    1009e3 <printer_vprintf+0x2c>
    }
}
  10137f:	90                   	nop
  101380:	90                   	nop
  101381:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  101385:	c9                   	leave  
  101386:	c3                   	ret    

0000000000101387 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  101387:	55                   	push   %rbp
  101388:	48 89 e5             	mov    %rsp,%rbp
  10138b:	48 83 ec 20          	sub    $0x20,%rsp
  10138f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101393:	89 f0                	mov    %esi,%eax
  101395:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101398:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  10139b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10139f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1013a3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013a7:	48 8b 40 08          	mov    0x8(%rax),%rax
  1013ab:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  1013b0:	48 39 d0             	cmp    %rdx,%rax
  1013b3:	72 0c                	jb     1013c1 <console_putc+0x3a>
        cp->cursor = console;
  1013b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013b9:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  1013c0:	00 
    }
    if (c == '\n') {
  1013c1:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  1013c5:	75 78                	jne    10143f <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  1013c7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013cb:	48 8b 40 08          	mov    0x8(%rax),%rax
  1013cf:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1013d5:	48 d1 f8             	sar    %rax
  1013d8:	48 89 c1             	mov    %rax,%rcx
  1013db:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1013e2:	66 66 66 
  1013e5:	48 89 c8             	mov    %rcx,%rax
  1013e8:	48 f7 ea             	imul   %rdx
  1013eb:	48 c1 fa 05          	sar    $0x5,%rdx
  1013ef:	48 89 c8             	mov    %rcx,%rax
  1013f2:	48 c1 f8 3f          	sar    $0x3f,%rax
  1013f6:	48 29 c2             	sub    %rax,%rdx
  1013f9:	48 89 d0             	mov    %rdx,%rax
  1013fc:	48 c1 e0 02          	shl    $0x2,%rax
  101400:	48 01 d0             	add    %rdx,%rax
  101403:	48 c1 e0 04          	shl    $0x4,%rax
  101407:	48 29 c1             	sub    %rax,%rcx
  10140a:	48 89 ca             	mov    %rcx,%rdx
  10140d:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101410:	eb 25                	jmp    101437 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  101412:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101415:	83 c8 20             	or     $0x20,%eax
  101418:	89 c6                	mov    %eax,%esi
  10141a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10141e:	48 8b 40 08          	mov    0x8(%rax),%rax
  101422:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101426:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  10142a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10142e:	89 f2                	mov    %esi,%edx
  101430:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  101433:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101437:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  10143b:	75 d5                	jne    101412 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  10143d:	eb 24                	jmp    101463 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  10143f:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  101443:	8b 55 e0             	mov    -0x20(%rbp),%edx
  101446:	09 d0                	or     %edx,%eax
  101448:	89 c6                	mov    %eax,%esi
  10144a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10144e:	48 8b 40 08          	mov    0x8(%rax),%rax
  101452:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101456:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  10145a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10145e:	89 f2                	mov    %esi,%edx
  101460:	66 89 10             	mov    %dx,(%rax)
}
  101463:	90                   	nop
  101464:	c9                   	leave  
  101465:	c3                   	ret    

0000000000101466 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  101466:	55                   	push   %rbp
  101467:	48 89 e5             	mov    %rsp,%rbp
  10146a:	48 83 ec 30          	sub    $0x30,%rsp
  10146e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  101471:	89 75 e8             	mov    %esi,-0x18(%rbp)
  101474:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101478:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  10147c:	48 c7 45 f0 87 13 10 	movq   $0x101387,-0x10(%rbp)
  101483:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101484:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  101488:	78 09                	js     101493 <console_vprintf+0x2d>
  10148a:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101491:	7e 07                	jle    10149a <console_vprintf+0x34>
        cpos = 0;
  101493:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  10149a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10149d:	48 98                	cltq   
  10149f:	48 01 c0             	add    %rax,%rax
  1014a2:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  1014a8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1014ac:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1014b0:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1014b4:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1014b7:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  1014bb:	48 89 c7             	mov    %rax,%rdi
  1014be:	e8 f4 f4 ff ff       	call   1009b7 <printer_vprintf>
    return cp.cursor - console;
  1014c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1014c7:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1014cd:	48 d1 f8             	sar    %rax
}
  1014d0:	c9                   	leave  
  1014d1:	c3                   	ret    

00000000001014d2 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  1014d2:	55                   	push   %rbp
  1014d3:	48 89 e5             	mov    %rsp,%rbp
  1014d6:	48 83 ec 60          	sub    $0x60,%rsp
  1014da:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1014dd:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1014e0:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1014e4:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1014e8:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1014ec:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1014f0:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1014f7:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1014fb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1014ff:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101503:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101507:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  10150b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  10150f:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101512:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101515:	89 c7                	mov    %eax,%edi
  101517:	e8 4a ff ff ff       	call   101466 <console_vprintf>
  10151c:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  10151f:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101522:	c9                   	leave  
  101523:	c3                   	ret    

0000000000101524 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101524:	55                   	push   %rbp
  101525:	48 89 e5             	mov    %rsp,%rbp
  101528:	48 83 ec 20          	sub    $0x20,%rsp
  10152c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101530:	89 f0                	mov    %esi,%eax
  101532:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101535:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101538:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10153c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101540:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101544:	48 8b 50 08          	mov    0x8(%rax),%rdx
  101548:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10154c:	48 8b 40 10          	mov    0x10(%rax),%rax
  101550:	48 39 c2             	cmp    %rax,%rdx
  101553:	73 1a                	jae    10156f <string_putc+0x4b>
        *sp->s++ = c;
  101555:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101559:	48 8b 40 08          	mov    0x8(%rax),%rax
  10155d:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101561:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101565:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101569:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  10156d:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  10156f:	90                   	nop
  101570:	c9                   	leave  
  101571:	c3                   	ret    

0000000000101572 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101572:	55                   	push   %rbp
  101573:	48 89 e5             	mov    %rsp,%rbp
  101576:	48 83 ec 40          	sub    $0x40,%rsp
  10157a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  10157e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101582:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  101586:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  10158a:	48 c7 45 e8 24 15 10 	movq   $0x101524,-0x18(%rbp)
  101591:	00 
    sp.s = s;
  101592:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101596:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  10159a:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  10159f:	74 33                	je     1015d4 <vsnprintf+0x62>
        sp.end = s + size - 1;
  1015a1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1015a5:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1015a9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1015ad:	48 01 d0             	add    %rdx,%rax
  1015b0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1015b4:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1015b8:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1015bc:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1015c0:	be 00 00 00 00       	mov    $0x0,%esi
  1015c5:	48 89 c7             	mov    %rax,%rdi
  1015c8:	e8 ea f3 ff ff       	call   1009b7 <printer_vprintf>
        *sp.s = 0;
  1015cd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1015d1:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1015d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1015d8:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1015dc:	c9                   	leave  
  1015dd:	c3                   	ret    

00000000001015de <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1015de:	55                   	push   %rbp
  1015df:	48 89 e5             	mov    %rsp,%rbp
  1015e2:	48 83 ec 70          	sub    $0x70,%rsp
  1015e6:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1015ea:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1015ee:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1015f2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1015f6:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1015fa:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1015fe:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101605:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101609:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  10160d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101611:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101615:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101619:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  10161d:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101621:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101625:	48 89 c7             	mov    %rax,%rdi
  101628:	e8 45 ff ff ff       	call   101572 <vsnprintf>
  10162d:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101630:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101633:	c9                   	leave  
  101634:	c3                   	ret    

0000000000101635 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101635:	55                   	push   %rbp
  101636:	48 89 e5             	mov    %rsp,%rbp
  101639:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10163d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101644:	eb 13                	jmp    101659 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  101646:	8b 45 fc             	mov    -0x4(%rbp),%eax
  101649:	48 98                	cltq   
  10164b:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  101652:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101655:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101659:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101660:	7e e4                	jle    101646 <console_clear+0x11>
    }
    cursorpos = 0;
  101662:	c7 05 90 79 fb ff 00 	movl   $0x0,-0x48670(%rip)        # b8ffc <cursorpos>
  101669:	00 00 00 
}
  10166c:	90                   	nop
  10166d:	c9                   	leave  
  10166e:	c3                   	ret    
