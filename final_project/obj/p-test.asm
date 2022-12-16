
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:

uint8_t *heap_top;
uint8_t *heap_bottom;
uint8_t *stack_bottom;

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	41 54                	push   %r12
  100006:	53                   	push   %rbx
  100007:	48 83 ec 60          	sub    $0x60,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  10000b:	cd 31                	int    $0x31
  10000d:	89 c7                	mov    %eax,%edi
    pid_t p = getpid();
    srand(p);
  10000f:	e8 56 0c 00 00       	call   100c6a <srand>
    heap_bottom = heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100014:	b8 3f 30 10 00       	mov    $0x10303f,%eax
  100019:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10001f:	48 89 05 ea 1f 00 00 	mov    %rax,0x1fea(%rip)        # 102010 <heap_top>
  100026:	48 89 05 db 1f 00 00 	mov    %rax,0x1fdb(%rip)        # 102008 <heap_bottom>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10002d:	48 89 e0             	mov    %rsp,%rax
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100030:	48 83 e8 01          	sub    $0x1,%rax
  100034:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10003a:	48 89 05 bf 1f 00 00 	mov    %rax,0x1fbf(%rip)        # 102000 <stack_bottom>

    malloc(10);
  100041:	bf 0a 00 00 00       	mov    $0xa,%edi
  100046:	e8 a2 04 00 00       	call   1004ed <malloc>
    void* ptr2 = malloc(200);
  10004b:	bf c8 00 00 00       	mov    $0xc8,%edi
  100050:	e8 98 04 00 00       	call   1004ed <malloc>
  100055:	49 89 c4             	mov    %rax,%r12


    heap_info_struct h1, h2, h3;
    heap_info(&h1);
  100058:	48 8d 7d d0          	lea    -0x30(%rbp),%rdi
  10005c:	e8 8d 07 00 00       	call   1007ee <heap_info>


    void* ptr = malloc(16384);
  100061:	bf 00 40 00 00       	mov    $0x4000,%edi
  100066:	e8 82 04 00 00       	call   1004ed <malloc>
  10006b:	48 89 c3             	mov    %rax,%rbx
    malloc(10);
  10006e:	bf 0a 00 00 00       	mov    $0xa,%edi
  100073:	e8 75 04 00 00       	call   1004ed <malloc>
    malloc(10);
  100078:	bf 0a 00 00 00       	mov    $0xa,%edi
  10007d:	e8 6b 04 00 00       	call   1004ed <malloc>

    heap_info(&h2);
  100082:	48 8d 7d b0          	lea    -0x50(%rbp),%rdi
  100086:	e8 63 07 00 00       	call   1007ee <heap_info>

    free(ptr2);
  10008b:	4c 89 e7             	mov    %r12,%rdi
  10008e:	e8 02 03 00 00       	call   100395 <free>
    free(ptr);
  100093:	48 89 df             	mov    %rbx,%rdi
  100096:	e8 fa 02 00 00       	call   100395 <free>

    heap_info(&h3);
  10009b:	48 8d 7d 90          	lea    -0x70(%rbp),%rdi
  10009f:	e8 4a 07 00 00       	call   1007ee <heap_info>

    assert(h1.size_array != NULL);
  1000a4:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
  1000a8:	48 85 ff             	test   %rdi,%rdi
  1000ab:	74 3a                	je     1000e7 <process_main+0xe7>
    assert(h2.size_array != NULL);
  1000ad:	48 83 7d b8 00       	cmpq   $0x0,-0x48(%rbp)
  1000b2:	74 47                	je     1000fb <process_main+0xfb>
    assert(h1.ptr_array != NULL);
  1000b4:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  1000b9:	74 54                	je     10010f <process_main+0x10f>
    assert(h2.ptr_array != NULL);
  1000bb:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
  1000c0:	74 61                	je     100123 <process_main+0x123>


    assert(h3.free_space > h2.free_space);
  1000c2:	8b 45 c8             	mov    -0x38(%rbp),%eax
  1000c5:	39 45 a8             	cmp    %eax,-0x58(%rbp)
  1000c8:	7e 6d                	jle    100137 <process_main+0x137>
    assert(h3.largest_free_chunk >= 16384);
  1000ca:	81 7d ac ff 3f 00 00 	cmpl   $0x3fff,-0x54(%rbp)
  1000d1:	7f 78                	jg     10014b <process_main+0x14b>
  1000d3:	ba 88 1a 10 00       	mov    $0x101a88,%edx
  1000d8:	be 2b 00 00 00       	mov    $0x2b,%esi
  1000dd:	bf e6 19 10 00       	mov    $0x1019e6,%edi
  1000e2:	e8 05 02 00 00       	call   1002ec <assert_fail>
    assert(h1.size_array != NULL);
  1000e7:	ba d0 19 10 00       	mov    $0x1019d0,%edx
  1000ec:	be 24 00 00 00       	mov    $0x24,%esi
  1000f1:	bf e6 19 10 00       	mov    $0x1019e6,%edi
  1000f6:	e8 f1 01 00 00       	call   1002ec <assert_fail>
    assert(h2.size_array != NULL);
  1000fb:	ba f6 19 10 00       	mov    $0x1019f6,%edx
  100100:	be 25 00 00 00       	mov    $0x25,%esi
  100105:	bf e6 19 10 00       	mov    $0x1019e6,%edi
  10010a:	e8 dd 01 00 00       	call   1002ec <assert_fail>
    assert(h1.ptr_array != NULL);
  10010f:	ba 0c 1a 10 00       	mov    $0x101a0c,%edx
  100114:	be 26 00 00 00       	mov    $0x26,%esi
  100119:	bf e6 19 10 00       	mov    $0x1019e6,%edi
  10011e:	e8 c9 01 00 00       	call   1002ec <assert_fail>
    assert(h2.ptr_array != NULL);
  100123:	ba 21 1a 10 00       	mov    $0x101a21,%edx
  100128:	be 27 00 00 00       	mov    $0x27,%esi
  10012d:	bf e6 19 10 00       	mov    $0x1019e6,%edi
  100132:	e8 b5 01 00 00       	call   1002ec <assert_fail>
    assert(h3.free_space > h2.free_space);
  100137:	ba 36 1a 10 00       	mov    $0x101a36,%edx
  10013c:	be 2a 00 00 00       	mov    $0x2a,%esi
  100141:	bf e6 19 10 00       	mov    $0x1019e6,%edi
  100146:	e8 a1 01 00 00       	call   1002ec <assert_fail>


    free(h1.size_array);
  10014b:	e8 45 02 00 00       	call   100395 <free>
    free(h2.size_array);
  100150:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  100154:	e8 3c 02 00 00       	call   100395 <free>

    free(h1.ptr_array);
  100159:	48 8b 7d e0          	mov    -0x20(%rbp),%rdi
  10015d:	e8 33 02 00 00       	call   100395 <free>
    free(h2.ptr_array);
  100162:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
  100166:	e8 2a 02 00 00       	call   100395 <free>

    app_printf(0, "HEAP FREE SPACE PASS\n");
  10016b:	be 54 1a 10 00       	mov    $0x101a54,%esi
  100170:	bf 00 00 00 00       	mov    $0x0,%edi
  100175:	b8 00 00 00 00       	mov    $0x0,%eax
  10017a:	e8 0f 00 00 00       	call   10018e <app_printf>
    TEST_PASS();
  10017f:	bf 6a 1a 10 00       	mov    $0x101a6a,%edi
  100184:	b8 00 00 00 00       	mov    $0x0,%eax
  100189:	e8 90 00 00 00       	call   10021e <kernel_panic>

000000000010018e <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  10018e:	55                   	push   %rbp
  10018f:	48 89 e5             	mov    %rsp,%rbp
  100192:	48 83 ec 50          	sub    $0x50,%rsp
  100196:	49 89 f2             	mov    %rsi,%r10
  100199:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  10019d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1001a1:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1001a5:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  1001a9:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  1001ae:	85 ff                	test   %edi,%edi
  1001b0:	78 2e                	js     1001e0 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  1001b2:	48 63 ff             	movslq %edi,%rdi
  1001b5:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  1001bc:	cc cc cc 
  1001bf:	48 89 f8             	mov    %rdi,%rax
  1001c2:	48 f7 e2             	mul    %rdx
  1001c5:	48 89 d0             	mov    %rdx,%rax
  1001c8:	48 c1 e8 02          	shr    $0x2,%rax
  1001cc:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  1001d0:	48 01 c2             	add    %rax,%rdx
  1001d3:	48 29 d7             	sub    %rdx,%rdi
  1001d6:	0f b6 b7 dd 1a 10 00 	movzbl 0x101add(%rdi),%esi
  1001dd:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  1001e0:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  1001e7:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1001eb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1001ef:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1001f3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  1001f7:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1001fb:	4c 89 d2             	mov    %r10,%rdx
  1001fe:	8b 3d f8 8d fb ff    	mov    -0x47208(%rip),%edi        # b8ffc <cursorpos>
  100204:	e8 b3 15 00 00       	call   1017bc <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100209:	3d 30 07 00 00       	cmp    $0x730,%eax
  10020e:	ba 00 00 00 00       	mov    $0x0,%edx
  100213:	0f 4d c2             	cmovge %edx,%eax
  100216:	89 05 e0 8d fb ff    	mov    %eax,-0x47220(%rip)        # b8ffc <cursorpos>
    }
}
  10021c:	c9                   	leave  
  10021d:	c3                   	ret    

000000000010021e <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  10021e:	55                   	push   %rbp
  10021f:	48 89 e5             	mov    %rsp,%rbp
  100222:	53                   	push   %rbx
  100223:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  10022a:	48 89 fb             	mov    %rdi,%rbx
  10022d:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100231:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  100235:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100239:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  10023d:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  100241:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  100248:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10024c:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100250:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  100254:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  100258:	ba 07 00 00 00       	mov    $0x7,%edx
  10025d:	be a7 1a 10 00       	mov    $0x101aa7,%esi
  100262:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100269:	e8 05 07 00 00       	call   100973 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  10026e:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100272:	48 89 da             	mov    %rbx,%rdx
  100275:	be 99 00 00 00       	mov    $0x99,%esi
  10027a:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100281:	e8 42 16 00 00       	call   1018c8 <vsnprintf>
  100286:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100289:	85 d2                	test   %edx,%edx
  10028b:	7e 0f                	jle    10029c <kernel_panic+0x7e>
  10028d:	83 c0 06             	add    $0x6,%eax
  100290:	48 98                	cltq   
  100292:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  100299:	0a 
  10029a:	75 2a                	jne    1002c6 <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  10029c:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  1002a3:	48 89 d9             	mov    %rbx,%rcx
  1002a6:	ba af 1a 10 00       	mov    $0x101aaf,%edx
  1002ab:	be 00 c0 00 00       	mov    $0xc000,%esi
  1002b0:	bf 30 07 00 00       	mov    $0x730,%edi
  1002b5:	b8 00 00 00 00       	mov    $0x0,%eax
  1002ba:	e8 69 15 00 00       	call   101828 <console_printf>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  1002bf:	48 89 df             	mov    %rbx,%rdi
  1002c2:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  1002c4:	eb fe                	jmp    1002c4 <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  1002c6:	48 63 c2             	movslq %edx,%rax
  1002c9:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  1002cf:	0f 94 c2             	sete   %dl
  1002d2:	0f b6 d2             	movzbl %dl,%edx
  1002d5:	48 29 d0             	sub    %rdx,%rax
  1002d8:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  1002df:	ff 
  1002e0:	be 68 1a 10 00       	mov    $0x101a68,%esi
  1002e5:	e8 36 08 00 00       	call   100b20 <strcpy>
  1002ea:	eb b0                	jmp    10029c <kernel_panic+0x7e>

00000000001002ec <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  1002ec:	55                   	push   %rbp
  1002ed:	48 89 e5             	mov    %rsp,%rbp
  1002f0:	48 89 f9             	mov    %rdi,%rcx
  1002f3:	41 89 f0             	mov    %esi,%r8d
  1002f6:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  1002f9:	ba b8 1a 10 00       	mov    $0x101ab8,%edx
  1002fe:	be 00 c0 00 00       	mov    $0xc000,%esi
  100303:	bf 30 07 00 00       	mov    $0x730,%edi
  100308:	b8 00 00 00 00       	mov    $0x0,%eax
  10030d:	e8 16 15 00 00       	call   101828 <console_printf>
    asm volatile ("int %0" : /* no result */
  100312:	bf 00 00 00 00       	mov    $0x0,%edi
  100317:	cd 30                	int    $0x30
 loop: goto loop;
  100319:	eb fe                	jmp    100319 <assert_fail+0x2d>

000000000010031b <heap_init>:
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  10031b:	bf 10 00 00 00       	mov    $0x10,%edi
  100320:	cd 3a                	int    $0x3a
  100322:	48 89 05 07 1d 00 00 	mov    %rax,0x1d07(%rip)        # 102030 <result.0>
  100329:	bf 08 00 00 00       	mov    $0x8,%edi
  10032e:	cd 3a                	int    $0x3a
  100330:	48 89 05 f9 1c 00 00 	mov    %rax,0x1cf9(%rip)        # 102030 <result.0>
// want to try and optimize this 
void heap_init(void) {

	// prologue block
	sbrk(sizeof(block_header) + sizeof(block_header));
	prologue_block = sbrk(sizeof(block_footer));
  100337:	48 89 05 e2 1c 00 00 	mov    %rax,0x1ce2(%rip)        # 102020 <prologue_block>
	PUT(HDRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  10033e:	48 c7 40 f8 11 00 00 	movq   $0x11,-0x8(%rax)
  100345:	00 
	PUT(FTRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  100346:	48 8b 15 d3 1c 00 00 	mov    0x1cd3(%rip),%rdx        # 102020 <prologue_block>
  10034d:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  100351:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100355:	48 c7 44 02 f0 11 00 	movq   $0x11,-0x10(%rdx,%rax,1)
  10035c:	00 00 
  10035e:	cd 3a                	int    $0x3a
  100360:	48 89 05 c9 1c 00 00 	mov    %rax,0x1cc9(%rip)        # 102030 <result.0>

	// terminal block
	sbrk(sizeof(block_header));
	PUT(HDRP(NEXT_BLKP(prologue_block)), PACK(0, 1));	
  100367:	48 8b 15 b2 1c 00 00 	mov    0x1cb2(%rip),%rdx        # 102020 <prologue_block>
  10036e:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  100372:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100376:	48 c7 44 02 f8 01 00 	movq   $0x1,-0x8(%rdx,%rax,1)
  10037d:	00 00 

	free_list = NULL;
  10037f:	48 c7 05 8e 1c 00 00 	movq   $0x0,0x1c8e(%rip)        # 102018 <free_list>
  100386:	00 00 00 00 

	initialized_heap = 1;
  10038a:	c7 05 94 1c 00 00 01 	movl   $0x1,0x1c94(%rip)        # 102028 <initialized_heap>
  100391:	00 00 00 
}
  100394:	c3                   	ret    

0000000000100395 <free>:

void free(void *firstbyte) {
	if (firstbyte == NULL)
  100395:	48 85 ff             	test   %rdi,%rdi
  100398:	74 35                	je     1003cf <free+0x3a>
		return;

	// setup free things: alloc, list ptrs, footer
	PUT(HDRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  10039a:	48 8b 47 f8          	mov    -0x8(%rdi),%rax
  10039e:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  1003a2:	48 89 47 f8          	mov    %rax,-0x8(%rdi)
	NEXT_FPTR(firstbyte) = free_list;
  1003a6:	48 8b 15 6b 1c 00 00 	mov    0x1c6b(%rip),%rdx        # 102018 <free_list>
  1003ad:	48 89 17             	mov    %rdx,(%rdi)
	PREV_FPTR(firstbyte) = NULL;
  1003b0:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  1003b7:	00 
	PUT(FTRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  1003b8:	48 89 44 07 f0       	mov    %rax,-0x10(%rdi,%rax,1)

	// add to free_list
	PREV_FPTR(free_list) = firstbyte;
  1003bd:	48 8b 05 54 1c 00 00 	mov    0x1c54(%rip),%rax        # 102018 <free_list>
  1003c4:	48 89 78 08          	mov    %rdi,0x8(%rax)
	free_list = firstbyte;
  1003c8:	48 89 3d 49 1c 00 00 	mov    %rdi,0x1c49(%rip)        # 102018 <free_list>

	return;
}
  1003cf:	c3                   	ret    

00000000001003d0 <extend>:
//
//	the reason allocating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
int extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  1003d0:	48 81 c7 ff ff 00 00 	add    $0xffff,%rdi
  1003d7:	66 bf 00 00          	mov    $0x0,%di
  1003db:	cd 3a                	int    $0x3a
  1003dd:	48 89 05 4c 1c 00 00 	mov    %rax,0x1c4c(%rip)        # 102030 <result.0>
	void *bp = sbrk(chunk_aligned_size);
	if (bp == (void *)-1)
  1003e4:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  1003e8:	74 49                	je     100433 <extend+0x63>
		return -1;

	// setup pointer
	PUT(HDRP(bp), PACK(chunk_aligned_size, 0));	
  1003ea:	48 89 78 f8          	mov    %rdi,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  1003ee:	48 8b 15 23 1c 00 00 	mov    0x1c23(%rip),%rdx        # 102018 <free_list>
  1003f5:	48 89 10             	mov    %rdx,(%rax)
	PREV_FPTR(bp) = NULL;
  1003f8:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  1003ff:	00 
	PUT(FTRP(bp), PACK(chunk_aligned_size, 0));	
  100400:	48 89 7c 07 f0       	mov    %rdi,-0x10(%rdi,%rax,1)
	
	// add to head of free_list
	if (free_list)
  100405:	48 8b 15 0c 1c 00 00 	mov    0x1c0c(%rip),%rdx        # 102018 <free_list>
  10040c:	48 85 d2             	test   %rdx,%rdx
  10040f:	74 04                	je     100415 <extend+0x45>
		PREV_FPTR(free_list) = bp;
  100411:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  100415:	48 89 05 fc 1b 00 00 	mov    %rax,0x1bfc(%rip)        # 102018 <free_list>

	// update terminal block
	PUT(HDRP(NEXT_BLKP(bp)), PACK(0, 1));	
  10041c:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  100420:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100424:	48 c7 44 10 f8 01 00 	movq   $0x1,-0x8(%rax,%rdx,1)
  10042b:	00 00 

	return 0;
  10042d:	b8 00 00 00 00       	mov    $0x0,%eax
  100432:	c3                   	ret    
		return -1;
  100433:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  100438:	c3                   	ret    

0000000000100439 <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
  100439:	48 89 f8             	mov    %rdi,%rax
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  10043c:	48 8b 57 f8          	mov    -0x8(%rdi),%rdx
  100440:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100444:	48 29 f2             	sub    %rsi,%rdx

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  100447:	48 83 fa 20          	cmp    $0x20,%rdx
  10044b:	76 5b                	jbe    1004a8 <set_allocated+0x6f>
		PUT(HDRP(bp), PACK(size, 1));
  10044d:	48 89 f1             	mov    %rsi,%rcx
  100450:	48 83 c9 01          	or     $0x1,%rcx
  100454:	48 89 4f f8          	mov    %rcx,-0x8(%rdi)

		void *leftover_mem_ptr = NEXT_BLKP(bp);
  100458:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  10045c:	48 01 fe             	add    %rdi,%rsi

		PUT(HDRP(leftover_mem_ptr), PACK(extra_size, 0));	
  10045f:	48 89 56 f8          	mov    %rdx,-0x8(%rsi)
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp); // pointers to the next free blocks
  100463:	48 8b 0f             	mov    (%rdi),%rcx
  100466:	48 89 0e             	mov    %rcx,(%rsi)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  100469:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  10046d:	48 89 4e 08          	mov    %rcx,0x8(%rsi)
		PUT(FTRP(leftover_mem_ptr), PACK(extra_size, 0));	
  100471:	48 89 d1             	mov    %rdx,%rcx
  100474:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  100478:	48 89 54 0e f0       	mov    %rdx,-0x10(%rsi,%rcx,1)

		// update the free list
		if (free_list == bp)
  10047d:	48 39 3d 94 1b 00 00 	cmp    %rdi,0x1b94(%rip)        # 102018 <free_list>
  100484:	74 19                	je     10049f <set_allocated+0x66>
			free_list = leftover_mem_ptr;

		if (PREV_FPTR(bp))
  100486:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10048a:	48 85 d2             	test   %rdx,%rdx
  10048d:	74 03                	je     100492 <set_allocated+0x59>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  10048f:	48 89 32             	mov    %rsi,(%rdx)

		if (NEXT_FPTR(bp))
  100492:	48 8b 00             	mov    (%rax),%rax
  100495:	48 85 c0             	test   %rax,%rax
  100498:	74 46                	je     1004e0 <set_allocated+0xa7>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  10049a:	48 89 70 08          	mov    %rsi,0x8(%rax)
  10049e:	c3                   	ret    
			free_list = leftover_mem_ptr;
  10049f:	48 89 35 72 1b 00 00 	mov    %rsi,0x1b72(%rip)        # 102018 <free_list>
  1004a6:	eb de                	jmp    100486 <set_allocated+0x4d>
								    
	}
	else {
		// update the free list
		if (free_list == bp)
  1004a8:	48 39 3d 69 1b 00 00 	cmp    %rdi,0x1b69(%rip)        # 102018 <free_list>
  1004af:	74 30                	je     1004e1 <set_allocated+0xa8>
			free_list = NEXT_FPTR(bp);

		if (PREV_FPTR(bp))
  1004b1:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1004b5:	48 85 d2             	test   %rdx,%rdx
  1004b8:	74 06                	je     1004c0 <set_allocated+0x87>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  1004ba:	48 8b 08             	mov    (%rax),%rcx
  1004bd:	48 89 0a             	mov    %rcx,(%rdx)
		if (NEXT_FPTR(bp))
  1004c0:	48 8b 10             	mov    (%rax),%rdx
  1004c3:	48 85 d2             	test   %rdx,%rdx
  1004c6:	74 08                	je     1004d0 <set_allocated+0x97>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  1004c8:	48 8b 48 08          	mov    0x8(%rax),%rcx
  1004cc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)

		PUT(HDRP(bp), PACK(GET_SIZE(HDRP(bp)), 1));	
  1004d0:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1004d4:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1004d8:	48 83 ca 01          	or     $0x1,%rdx
  1004dc:	48 89 50 f8          	mov    %rdx,-0x8(%rax)
	}
}
  1004e0:	c3                   	ret    
			free_list = NEXT_FPTR(bp);
  1004e1:	48 8b 17             	mov    (%rdi),%rdx
  1004e4:	48 89 15 2d 1b 00 00 	mov    %rdx,0x1b2d(%rip)        # 102018 <free_list>
  1004eb:	eb c4                	jmp    1004b1 <set_allocated+0x78>

00000000001004ed <malloc>:

void *malloc(uint64_t numbytes) {
  1004ed:	55                   	push   %rbp
  1004ee:	48 89 e5             	mov    %rsp,%rbp
  1004f1:	41 55                	push   %r13
  1004f3:	41 54                	push   %r12
  1004f5:	53                   	push   %rbx
  1004f6:	48 83 ec 08          	sub    $0x8,%rsp
  1004fa:	49 89 fc             	mov    %rdi,%r12
	if (!initialized_heap)
  1004fd:	83 3d 24 1b 00 00 00 	cmpl   $0x0,0x1b24(%rip)        # 102028 <initialized_heap>
  100504:	74 6b                	je     100571 <malloc+0x84>
		heap_init();

	if (numbytes == 0)
  100506:	4d 85 e4             	test   %r12,%r12
  100509:	0f 84 82 00 00 00    	je     100591 <malloc+0xa4>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  10050f:	49 83 c4 17          	add    $0x17,%r12
  100513:	49 83 e4 f0          	and    $0xfffffffffffffff0,%r12
  100517:	b8 20 00 00 00       	mov    $0x20,%eax
  10051c:	49 39 c4             	cmp    %rax,%r12
  10051f:	4c 0f 42 e0          	cmovb  %rax,%r12
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);
	
	void *bp = free_list;
  100523:	48 8b 1d ee 1a 00 00 	mov    0x1aee(%rip),%rbx        # 102018 <free_list>
	while (bp) {
  10052a:	48 85 db             	test   %rbx,%rbx
  10052d:	74 15                	je     100544 <malloc+0x57>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  10052f:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  100533:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100537:	4c 39 e0             	cmp    %r12,%rax
  10053a:	73 3c                	jae    100578 <malloc+0x8b>
			set_allocated(bp, aligned_size);
			return bp;
		}

		bp = NEXT_FPTR(bp);
  10053c:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  10053f:	48 85 db             	test   %rbx,%rbx
  100542:	75 eb                	jne    10052f <malloc+0x42>
  100544:	bf 00 00 00 00       	mov    $0x0,%edi
  100549:	cd 3a                	int    $0x3a
  10054b:	49 89 c5             	mov    %rax,%r13
  10054e:	48 89 05 db 1a 00 00 	mov    %rax,0x1adb(%rip)        # 102030 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  100555:	48 89 c3             	mov    %rax,%rbx
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	if (extend(aligned_size)) {
  100558:	4c 89 e7             	mov    %r12,%rdi
  10055b:	e8 70 fe ff ff       	call   1003d0 <extend>
  100560:	85 c0                	test   %eax,%eax
  100562:	75 34                	jne    100598 <malloc+0xab>
		return NULL;
	}
	set_allocated(bp, aligned_size);
  100564:	4c 89 e6             	mov    %r12,%rsi
  100567:	4c 89 ef             	mov    %r13,%rdi
  10056a:	e8 ca fe ff ff       	call   100439 <set_allocated>
    return bp;
  10056f:	eb 12                	jmp    100583 <malloc+0x96>
		heap_init();
  100571:	e8 a5 fd ff ff       	call   10031b <heap_init>
  100576:	eb 8e                	jmp    100506 <malloc+0x19>
			set_allocated(bp, aligned_size);
  100578:	4c 89 e6             	mov    %r12,%rsi
  10057b:	48 89 df             	mov    %rbx,%rdi
  10057e:	e8 b6 fe ff ff       	call   100439 <set_allocated>
}
  100583:	48 89 d8             	mov    %rbx,%rax
  100586:	48 83 c4 08          	add    $0x8,%rsp
  10058a:	5b                   	pop    %rbx
  10058b:	41 5c                	pop    %r12
  10058d:	41 5d                	pop    %r13
  10058f:	5d                   	pop    %rbp
  100590:	c3                   	ret    
		return NULL;
  100591:	bb 00 00 00 00       	mov    $0x0,%ebx
  100596:	eb eb                	jmp    100583 <malloc+0x96>
		return NULL;
  100598:	bb 00 00 00 00       	mov    $0x0,%ebx
  10059d:	eb e4                	jmp    100583 <malloc+0x96>

000000000010059f <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  10059f:	55                   	push   %rbp
  1005a0:	48 89 e5             	mov    %rsp,%rbp
  1005a3:	41 54                	push   %r12
  1005a5:	53                   	push   %rbx
	void *bp = malloc(num * sz);
  1005a6:	48 0f af fe          	imul   %rsi,%rdi
  1005aa:	49 89 fc             	mov    %rdi,%r12
  1005ad:	e8 3b ff ff ff       	call   1004ed <malloc>
  1005b2:	48 89 c3             	mov    %rax,%rbx
	if (bp)							// protect against num=0 or size=0 or just no memory
  1005b5:	48 85 c0             	test   %rax,%rax
  1005b8:	74 10                	je     1005ca <calloc+0x2b>
		memset(bp, 0, num * sz);
  1005ba:	4c 89 e2             	mov    %r12,%rdx
  1005bd:	be 00 00 00 00       	mov    $0x0,%esi
  1005c2:	48 89 c7             	mov    %rax,%rdi
  1005c5:	e8 a7 04 00 00       	call   100a71 <memset>
	return bp;
}
  1005ca:	48 89 d8             	mov    %rbx,%rax
  1005cd:	5b                   	pop    %rbx
  1005ce:	41 5c                	pop    %r12
  1005d0:	5d                   	pop    %rbp
  1005d1:	c3                   	ret    

00000000001005d2 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  1005d2:	55                   	push   %rbp
  1005d3:	48 89 e5             	mov    %rsp,%rbp
  1005d6:	41 54                	push   %r12
  1005d8:	53                   	push   %rbx
	if (ptr == NULL && sz == 0) {
  1005d9:	48 85 f6             	test   %rsi,%rsi
  1005dc:	0f 94 c0             	sete   %al
  1005df:	49 89 fc             	mov    %rdi,%r12
  1005e2:	49 09 f4             	or     %rsi,%r12
  1005e5:	74 26                	je     10060d <realloc+0x3b>
  1005e7:	48 89 fb             	mov    %rdi,%rbx
		return NULL;
	}
	else if (ptr != NULL && sz == 0) {
  1005ea:	48 85 ff             	test   %rdi,%rdi
  1005ed:	74 04                	je     1005f3 <realloc+0x21>
  1005ef:	84 c0                	test   %al,%al
  1005f1:	75 22                	jne    100615 <realloc+0x43>
		free(ptr);
		return NULL;
	}
	else if (ptr == NULL && sz != 0) {
  1005f3:	48 85 db             	test   %rbx,%rbx
  1005f6:	75 05                	jne    1005fd <realloc+0x2b>
  1005f8:	48 85 f6             	test   %rsi,%rsi
  1005fb:	75 25                	jne    100622 <realloc+0x50>
		return malloc(sz);
	}
	else if (GET_SIZE(HDRP(ptr)) >= sz) {
  1005fd:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  100601:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
		return ptr;
  100605:	49 89 dc             	mov    %rbx,%r12
	else if (GET_SIZE(HDRP(ptr)) >= sz) {
  100608:	48 39 f0             	cmp    %rsi,%rax
  10060b:	72 22                	jb     10062f <realloc+0x5d>
	else {
		memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
		free(ptr);
		return bigger_ptr;
	}
}
  10060d:	4c 89 e0             	mov    %r12,%rax
  100610:	5b                   	pop    %rbx
  100611:	41 5c                	pop    %r12
  100613:	5d                   	pop    %rbp
  100614:	c3                   	ret    
		free(ptr);
  100615:	e8 7b fd ff ff       	call   100395 <free>
		return NULL;
  10061a:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100620:	eb eb                	jmp    10060d <realloc+0x3b>
		return malloc(sz);
  100622:	48 89 f7             	mov    %rsi,%rdi
  100625:	e8 c3 fe ff ff       	call   1004ed <malloc>
  10062a:	49 89 c4             	mov    %rax,%r12
  10062d:	eb de                	jmp    10060d <realloc+0x3b>
	void *bigger_ptr = malloc(sz);
  10062f:	48 89 f7             	mov    %rsi,%rdi
  100632:	e8 b6 fe ff ff       	call   1004ed <malloc>
  100637:	49 89 c4             	mov    %rax,%r12
	if (bigger_ptr == NULL) {
  10063a:	48 85 c0             	test   %rax,%rax
  10063d:	74 1d                	je     10065c <realloc+0x8a>
		memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
  10063f:	48 8b 53 f8          	mov    -0x8(%rbx),%rdx
  100643:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100647:	48 89 de             	mov    %rbx,%rsi
  10064a:	48 89 c7             	mov    %rax,%rdi
  10064d:	e8 21 03 00 00       	call   100973 <memcpy>
		free(ptr);
  100652:	48 89 df             	mov    %rbx,%rdi
  100655:	e8 3b fd ff ff       	call   100395 <free>
		return bigger_ptr;
  10065a:	eb b1                	jmp    10060d <realloc+0x3b>
		return ptr;
  10065c:	49 89 dc             	mov    %rbx,%r12
  10065f:	eb ac                	jmp    10060d <realloc+0x3b>

0000000000100661 <defrag>:

void defrag() {
	void *fp = free_list;
  100661:	48 8b 15 b0 19 00 00 	mov    0x19b0(%rip),%rdx        # 102018 <free_list>
	while (fp != NULL) {
  100668:	48 85 d2             	test   %rdx,%rdx
  10066b:	75 3c                	jne    1006a9 <defrag+0x48>
		// you only need to check the block after, because if the block before is free, you'll
		// bet there by traversing the free list

		fp = NEXT_FPTR(fp);
	}
}
  10066d:	c3                   	ret    
				free_list = NEXT_FPTR(next_block);
  10066e:	48 8b 08             	mov    (%rax),%rcx
  100671:	48 89 0d a0 19 00 00 	mov    %rcx,0x19a0(%rip)        # 102018 <free_list>
  100678:	eb 49                	jmp    1006c3 <defrag+0x62>
			PUT(HDRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  10067a:	48 8b 4a f8          	mov    -0x8(%rdx),%rcx
  10067e:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  100682:	48 8b 70 f8          	mov    -0x8(%rax),%rsi
  100686:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  10068a:	48 01 f1             	add    %rsi,%rcx
  10068d:	48 89 4a f8          	mov    %rcx,-0x8(%rdx)
			PUT(FTRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  100691:	48 8b 40 f8          	mov    -0x8(%rax),%rax
  100695:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100699:	48 01 c8             	add    %rcx,%rax
  10069c:	48 89 44 0a f0       	mov    %rax,-0x10(%rdx,%rcx,1)
		fp = NEXT_FPTR(fp);
  1006a1:	48 8b 12             	mov    (%rdx),%rdx
	while (fp != NULL) {
  1006a4:	48 85 d2             	test   %rdx,%rdx
  1006a7:	74 c4                	je     10066d <defrag+0xc>
		void *next_block = NEXT_BLKP(fp);
  1006a9:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  1006ad:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  1006b1:	48 01 d0             	add    %rdx,%rax
		if (!GET_ALLOC(HDRP(next_block))) {
  1006b4:	f6 40 f8 01          	testb  $0x1,-0x8(%rax)
  1006b8:	75 e7                	jne    1006a1 <defrag+0x40>
			if (free_list == next_block)
  1006ba:	48 39 05 57 19 00 00 	cmp    %rax,0x1957(%rip)        # 102018 <free_list>
  1006c1:	74 ab                	je     10066e <defrag+0xd>
			if (PREV_FPTR(next_block)) 
  1006c3:	48 8b 48 08          	mov    0x8(%rax),%rcx
  1006c7:	48 85 c9             	test   %rcx,%rcx
  1006ca:	74 06                	je     1006d2 <defrag+0x71>
				NEXT_FPTR(PREV_FPTR(next_block)) = NEXT_FPTR(next_block);
  1006cc:	48 8b 30             	mov    (%rax),%rsi
  1006cf:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(next_block)) 
  1006d2:	48 8b 08             	mov    (%rax),%rcx
  1006d5:	48 85 c9             	test   %rcx,%rcx
  1006d8:	74 a0                	je     10067a <defrag+0x19>
				PREV_FPTR(NEXT_FPTR(next_block)) = PREV_FPTR(next_block);
  1006da:	48 8b 70 08          	mov    0x8(%rax),%rsi
  1006de:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  1006e2:	eb 96                	jmp    10067a <defrag+0x19>

00000000001006e4 <sift_down>:
// heap sort stuff that operates on the pointer array
#define LEFT_CHILD(x) (2*x + 1)
#define RIGHT_CHILD(x) (2*x + 2)
#define PARENT(x) ((x-1)/2)

void sift_down(void **arr, size_t pos, size_t arr_len) {
  1006e4:	48 89 f1             	mov    %rsi,%rcx
  1006e7:	49 89 d3             	mov    %rdx,%r11
	while (LEFT_CHILD(pos) < arr_len) {
  1006ea:	48 8d 74 36 01       	lea    0x1(%rsi,%rsi,1),%rsi
  1006ef:	48 39 d6             	cmp    %rdx,%rsi
  1006f2:	72 3a                	jb     10072e <sift_down+0x4a>
  1006f4:	c3                   	ret    
  1006f5:	48 89 f0             	mov    %rsi,%rax
		size_t smaller = LEFT_CHILD(pos);
		if (RIGHT_CHILD(pos) < arr_len && GET_SIZE(HDRP(arr[RIGHT_CHILD(pos)])) < GET_SIZE(HDRP(arr[LEFT_CHILD(pos)]))){
			smaller = RIGHT_CHILD(pos);
		}

		if (GET_SIZE(HDRP(arr[pos])) > GET_SIZE(HDRP(arr[smaller]))) {
  1006f8:	4c 8d 0c cf          	lea    (%rdi,%rcx,8),%r9
  1006fc:	4d 8b 01             	mov    (%r9),%r8
  1006ff:	48 8d 34 c7          	lea    (%rdi,%rax,8),%rsi
  100703:	4c 8b 16             	mov    (%rsi),%r10
  100706:	49 8b 50 f8          	mov    -0x8(%r8),%rdx
  10070a:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  10070e:	49 8b 4a f8          	mov    -0x8(%r10),%rcx
  100712:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  100716:	48 39 d1             	cmp    %rdx,%rcx
  100719:	73 46                	jae    100761 <sift_down+0x7d>
			void *temp = arr[pos];
			arr[pos] = arr[smaller];
  10071b:	4d 89 11             	mov    %r10,(%r9)
			arr[smaller] = temp;
  10071e:	4c 89 06             	mov    %r8,(%rsi)
	while (LEFT_CHILD(pos) < arr_len) {
  100721:	48 8d 74 00 01       	lea    0x1(%rax,%rax,1),%rsi
  100726:	4c 39 de             	cmp    %r11,%rsi
  100729:	73 36                	jae    100761 <sift_down+0x7d>
			pos = smaller;
  10072b:	48 89 c1             	mov    %rax,%rcx
		if (RIGHT_CHILD(pos) < arr_len && GET_SIZE(HDRP(arr[RIGHT_CHILD(pos)])) < GET_SIZE(HDRP(arr[LEFT_CHILD(pos)]))){
  10072e:	48 8d 51 01          	lea    0x1(%rcx),%rdx
  100732:	48 8d 04 12          	lea    (%rdx,%rdx,1),%rax
  100736:	4c 39 d8             	cmp    %r11,%rax
  100739:	73 ba                	jae    1006f5 <sift_down+0x11>
  10073b:	48 c1 e2 04          	shl    $0x4,%rdx
  10073f:	4c 8b 04 17          	mov    (%rdi,%rdx,1),%r8
  100743:	4d 8b 40 f8          	mov    -0x8(%r8),%r8
  100747:	49 83 e0 f0          	and    $0xfffffffffffffff0,%r8
  10074b:	48 8b 54 17 f8       	mov    -0x8(%rdi,%rdx,1),%rdx
  100750:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  100754:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100758:	49 39 d0             	cmp    %rdx,%r8
  10075b:	48 0f 43 c6          	cmovae %rsi,%rax
  10075f:	eb 97                	jmp    1006f8 <sift_down+0x14>
		}
		else {
			break;
		}
	}
}
  100761:	c3                   	ret    

0000000000100762 <heapify>:

void heapify(void **arr, size_t arr_len) {
  100762:	55                   	push   %rbp
  100763:	48 89 e5             	mov    %rsp,%rbp
  100766:	41 56                	push   %r14
  100768:	41 55                	push   %r13
  10076a:	41 54                	push   %r12
  10076c:	53                   	push   %rbx
	for (int i = arr_len - 1; i >= 0; i--) {
  10076d:	41 89 f5             	mov    %esi,%r13d
  100770:	41 83 ed 01          	sub    $0x1,%r13d
  100774:	78 28                	js     10079e <heapify+0x3c>
  100776:	49 89 fe             	mov    %rdi,%r14
  100779:	49 89 f4             	mov    %rsi,%r12
  10077c:	49 63 c5             	movslq %r13d,%rax
  10077f:	48 89 c3             	mov    %rax,%rbx
  100782:	41 29 c5             	sub    %eax,%r13d
		sift_down(arr, i, arr_len);
  100785:	4c 89 e2             	mov    %r12,%rdx
  100788:	48 89 de             	mov    %rbx,%rsi
  10078b:	4c 89 f7             	mov    %r14,%rdi
  10078e:	e8 51 ff ff ff       	call   1006e4 <sift_down>
	for (int i = arr_len - 1; i >= 0; i--) {
  100793:	48 83 eb 01          	sub    $0x1,%rbx
  100797:	44 89 e8             	mov    %r13d,%eax
  10079a:	01 d8                	add    %ebx,%eax
  10079c:	79 e7                	jns    100785 <heapify+0x23>
	}
}
  10079e:	5b                   	pop    %rbx
  10079f:	41 5c                	pop    %r12
  1007a1:	41 5d                	pop    %r13
  1007a3:	41 5e                	pop    %r14
  1007a5:	5d                   	pop    %rbp
  1007a6:	c3                   	ret    

00000000001007a7 <heapsort>:

void heapsort(void **arr, size_t arr_len) {
  1007a7:	55                   	push   %rbp
  1007a8:	48 89 e5             	mov    %rsp,%rbp
  1007ab:	41 54                	push   %r12
  1007ad:	53                   	push   %rbx
  1007ae:	49 89 fc             	mov    %rdi,%r12
  1007b1:	48 89 f3             	mov    %rsi,%rbx
	heapify(arr, arr_len);
  1007b4:	e8 a9 ff ff ff       	call   100762 <heapify>
	for (int i = arr_len - 1; i >= 0; i--) {
  1007b9:	83 eb 01             	sub    $0x1,%ebx
  1007bc:	78 2b                	js     1007e9 <heapsort+0x42>
  1007be:	48 63 db             	movslq %ebx,%rbx
		void *temp = arr[0];
  1007c1:	49 8b 04 24          	mov    (%r12),%rax
		arr[0] = arr[i];
  1007c5:	49 8b 14 dc          	mov    (%r12,%rbx,8),%rdx
  1007c9:	49 89 14 24          	mov    %rdx,(%r12)
		arr[i] = temp;
  1007cd:	49 89 04 dc          	mov    %rax,(%r12,%rbx,8)
		sift_down(arr, 0, i);
  1007d1:	48 89 da             	mov    %rbx,%rdx
  1007d4:	be 00 00 00 00       	mov    $0x0,%esi
  1007d9:	4c 89 e7             	mov    %r12,%rdi
  1007dc:	e8 03 ff ff ff       	call   1006e4 <sift_down>
	for (int i = arr_len - 1; i >= 0; i--) {
  1007e1:	48 83 eb 01          	sub    $0x1,%rbx
  1007e5:	85 db                	test   %ebx,%ebx
  1007e7:	79 d8                	jns    1007c1 <heapsort+0x1a>
	}
}
  1007e9:	5b                   	pop    %rbx
  1007ea:	41 5c                	pop    %r12
  1007ec:	5d                   	pop    %rbp
  1007ed:	c3                   	ret    

00000000001007ee <heap_info>:

int heap_info(heap_info_struct *info) {
  1007ee:	55                   	push   %rbp
  1007ef:	48 89 e5             	mov    %rsp,%rbp
  1007f2:	53                   	push   %rbx
  1007f3:	48 83 ec 08          	sub    $0x8,%rsp
  1007f7:	48 89 fb             	mov    %rdi,%rbx
	info->num_allocs = 0;
  1007fa:	c7 07 00 00 00 00    	movl   $0x0,(%rdi)

	// collect the number of allocs :(
	void *bp = NEXT_BLKP(prologue_block); // because the prologue isn't actually allocated
  100800:	48 8b 05 19 18 00 00 	mov    0x1819(%rip),%rax        # 102020 <prologue_block>
  100807:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  10080b:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  10080f:	48 01 d0             	add    %rdx,%rax
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  100812:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  100816:	48 83 fa 0f          	cmp    $0xf,%rdx
  10081a:	77 17                	ja     100833 <heap_info+0x45>
  10081c:	eb 25                	jmp    100843 <heap_info+0x55>
		if (GET_ALLOC(HDRP(bp)))
			info->num_allocs++;
		bp = NEXT_BLKP(bp);
  10081e:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  100822:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100826:	48 01 d0             	add    %rdx,%rax
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  100829:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  10082d:	48 83 fa 0f          	cmp    $0xf,%rdx
  100831:	76 0a                	jbe    10083d <heap_info+0x4f>
		if (GET_ALLOC(HDRP(bp)))
  100833:	f6 c2 01             	test   $0x1,%dl
  100836:	74 e6                	je     10081e <heap_info+0x30>
			info->num_allocs++;
  100838:	83 03 01             	addl   $0x1,(%rbx)
  10083b:	eb e1                	jmp    10081e <heap_info+0x30>
	}

	if (info->num_allocs == 0) {
  10083d:	8b 03                	mov    (%rbx),%eax
  10083f:	85 c0                	test   %eax,%eax
  100841:	75 45                	jne    100888 <heap_info+0x9a>
		info->size_array = NULL;
  100843:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  10084a:	00 
		info->ptr_array = NULL;
  10084b:	48 c7 43 10 00 00 00 	movq   $0x0,0x10(%rbx)
  100852:	00 
			free(info->ptr_array);
			return -1;
		}
	}

	info->free_space = 0;
  100853:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%rbx)
	info->largest_free_chunk = 0;
  10085a:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%rbx)

	// iterate through list for free space
	bp = NEXT_BLKP(prologue_block); // because the prologue isn't actually allocated
  100861:	48 8b 05 b8 17 00 00 	mov    0x17b8(%rip),%rax        # 102020 <prologue_block>
  100868:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  10086c:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100870:	48 01 d0             	add    %rdx,%rax
	size_t arr_index = 0;
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  100873:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  100877:	48 83 fa 0f          	cmp    $0xf,%rdx
  10087b:	0f 86 a3 00 00 00    	jbe    100924 <heap_info+0x136>
	size_t arr_index = 0;
  100881:	be 00 00 00 00       	mov    $0x0,%esi
  100886:	eb 72                	jmp    1008fa <heap_info+0x10c>
		info->size_array = malloc(info->num_allocs * sizeof(long));
  100888:	48 98                	cltq   
  10088a:	48 8d 3c c5 00 00 00 	lea    0x0(,%rax,8),%rdi
  100891:	00 
  100892:	e8 56 fc ff ff       	call   1004ed <malloc>
  100897:	48 89 43 08          	mov    %rax,0x8(%rbx)
		if (info->size_array == (void *) -1){
  10089b:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  10089f:	0f 84 c0 00 00 00    	je     100965 <heap_info+0x177>
		info->ptr_array = malloc(info->num_allocs * sizeof(void *));
  1008a5:	48 63 3b             	movslq (%rbx),%rdi
  1008a8:	48 c1 e7 03          	shl    $0x3,%rdi
  1008ac:	e8 3c fc ff ff       	call   1004ed <malloc>
  1008b1:	48 89 43 10          	mov    %rax,0x10(%rbx)
		if (info->ptr_array == (void *) -1){
  1008b5:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  1008b9:	75 98                	jne    100853 <heap_info+0x65>
			free(info->ptr_array);
  1008bb:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
  1008c2:	e8 ce fa ff ff       	call   100395 <free>
			return -1;
  1008c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1008cc:	e9 8e 00 00 00       	jmp    10095f <heap_info+0x171>
			info->size_array[arr_index] = GET_SIZE(HDRP(bp));
			info->ptr_array[arr_index] = bp;
			arr_index++;
		}
		else if (!GET_ALLOC(HDRP(bp))) {
			info->free_space += GET_SIZE(HDRP(bp));
  1008d1:	83 e2 f0             	and    $0xfffffff0,%edx
  1008d4:	01 53 18             	add    %edx,0x18(%rbx)
			if ((int)GET_SIZE(HDRP(bp)) > info->largest_free_chunk){
  1008d7:	8b 50 f8             	mov    -0x8(%rax),%edx
  1008da:	83 e2 f0             	and    $0xfffffff0,%edx
  1008dd:	3b 53 1c             	cmp    0x1c(%rbx),%edx
  1008e0:	7e 03                	jle    1008e5 <heap_info+0xf7>
				info->largest_free_chunk = GET_SIZE(HDRP(bp));
  1008e2:	89 53 1c             	mov    %edx,0x1c(%rbx)
			}
		}
		bp = NEXT_BLKP(bp);
  1008e5:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1008e9:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1008ed:	48 01 d0             	add    %rdx,%rax
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  1008f0:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1008f4:	48 83 fa 0f          	cmp    $0xf,%rdx
  1008f8:	76 2a                	jbe    100924 <heap_info+0x136>
		if (GET_ALLOC(HDRP(bp)) && bp != info->size_array && bp != info->ptr_array){
  1008fa:	f6 c2 01             	test   $0x1,%dl
  1008fd:	74 d2                	je     1008d1 <heap_info+0xe3>
  1008ff:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
  100903:	48 39 c1             	cmp    %rax,%rcx
  100906:	74 dd                	je     1008e5 <heap_info+0xf7>
  100908:	48 39 43 10          	cmp    %rax,0x10(%rbx)
  10090c:	74 d7                	je     1008e5 <heap_info+0xf7>
			info->size_array[arr_index] = GET_SIZE(HDRP(bp));
  10090e:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100912:	48 89 14 f1          	mov    %rdx,(%rcx,%rsi,8)
			info->ptr_array[arr_index] = bp;
  100916:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  10091a:	48 89 04 f2          	mov    %rax,(%rdx,%rsi,8)
			arr_index++;
  10091e:	48 83 c6 01          	add    $0x1,%rsi
  100922:	eb c1                	jmp    1008e5 <heap_info+0xf7>
	}

	// sort the damn arrays
	heapsort(info->ptr_array, info->num_allocs);
  100924:	48 63 33             	movslq (%rbx),%rsi
  100927:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
  10092b:	e8 77 fe ff ff       	call   1007a7 <heapsort>
	for (int i = 0; i < info->num_allocs; i++)
  100930:	83 3b 00             	cmpl   $0x0,(%rbx)
  100933:	7e 37                	jle    10096c <heap_info+0x17e>
  100935:	b8 00 00 00 00       	mov    $0x0,%eax
		info->size_array[i] = GET_SIZE(HDRP(info->ptr_array[i]));
  10093a:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
  10093e:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  100942:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
  100946:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  10094a:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  10094e:	48 89 14 c1          	mov    %rdx,(%rcx,%rax,8)
	for (int i = 0; i < info->num_allocs; i++)
  100952:	48 83 c0 01          	add    $0x1,%rax
  100956:	39 03                	cmp    %eax,(%rbx)
  100958:	7f e0                	jg     10093a <heap_info+0x14c>

    return 0;
  10095a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10095f:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100963:	c9                   	leave  
  100964:	c3                   	ret    
			return -1;
  100965:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10096a:	eb f3                	jmp    10095f <heap_info+0x171>
    return 0;
  10096c:	b8 00 00 00 00       	mov    $0x0,%eax
  100971:	eb ec                	jmp    10095f <heap_info+0x171>

0000000000100973 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100973:	55                   	push   %rbp
  100974:	48 89 e5             	mov    %rsp,%rbp
  100977:	48 83 ec 28          	sub    $0x28,%rsp
  10097b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10097f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100983:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100987:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10098b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  10098f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100993:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100997:	eb 1c                	jmp    1009b5 <memcpy+0x42>
        *d = *s;
  100999:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10099d:	0f b6 10             	movzbl (%rax),%edx
  1009a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1009a4:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1009a6:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1009ab:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1009b0:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1009b5:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1009ba:	75 dd                	jne    100999 <memcpy+0x26>
    }
    return dst;
  1009bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1009c0:	c9                   	leave  
  1009c1:	c3                   	ret    

00000000001009c2 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1009c2:	55                   	push   %rbp
  1009c3:	48 89 e5             	mov    %rsp,%rbp
  1009c6:	48 83 ec 28          	sub    $0x28,%rsp
  1009ca:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1009ce:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1009d2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1009d6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1009da:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  1009de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1009e2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  1009e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009ea:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  1009ee:	73 6a                	jae    100a5a <memmove+0x98>
  1009f0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1009f4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1009f8:	48 01 d0             	add    %rdx,%rax
  1009fb:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1009ff:	73 59                	jae    100a5a <memmove+0x98>
        s += n, d += n;
  100a01:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100a05:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100a09:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100a0d:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  100a11:	eb 17                	jmp    100a2a <memmove+0x68>
            *--d = *--s;
  100a13:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100a18:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100a1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a21:	0f b6 10             	movzbl (%rax),%edx
  100a24:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100a28:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100a2a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100a2e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100a32:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100a36:	48 85 c0             	test   %rax,%rax
  100a39:	75 d8                	jne    100a13 <memmove+0x51>
    if (s < d && s + n > d) {
  100a3b:	eb 2e                	jmp    100a6b <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100a3d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100a41:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100a45:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100a49:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100a4d:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100a51:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100a55:	0f b6 12             	movzbl (%rdx),%edx
  100a58:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100a5a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100a5e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100a62:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100a66:	48 85 c0             	test   %rax,%rax
  100a69:	75 d2                	jne    100a3d <memmove+0x7b>
        }
    }
    return dst;
  100a6b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100a6f:	c9                   	leave  
  100a70:	c3                   	ret    

0000000000100a71 <memset>:

void* memset(void* v, int c, size_t n) {
  100a71:	55                   	push   %rbp
  100a72:	48 89 e5             	mov    %rsp,%rbp
  100a75:	48 83 ec 28          	sub    $0x28,%rsp
  100a79:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100a7d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100a80:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100a84:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100a88:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100a8c:	eb 15                	jmp    100aa3 <memset+0x32>
        *p = c;
  100a8e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100a91:	89 c2                	mov    %eax,%edx
  100a93:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a97:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100a99:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100a9e:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100aa3:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100aa8:	75 e4                	jne    100a8e <memset+0x1d>
    }
    return v;
  100aaa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100aae:	c9                   	leave  
  100aaf:	c3                   	ret    

0000000000100ab0 <strlen>:

size_t strlen(const char* s) {
  100ab0:	55                   	push   %rbp
  100ab1:	48 89 e5             	mov    %rsp,%rbp
  100ab4:	48 83 ec 18          	sub    $0x18,%rsp
  100ab8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100abc:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100ac3:	00 
  100ac4:	eb 0a                	jmp    100ad0 <strlen+0x20>
        ++n;
  100ac6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100acb:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100ad0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100ad4:	0f b6 00             	movzbl (%rax),%eax
  100ad7:	84 c0                	test   %al,%al
  100ad9:	75 eb                	jne    100ac6 <strlen+0x16>
    }
    return n;
  100adb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100adf:	c9                   	leave  
  100ae0:	c3                   	ret    

0000000000100ae1 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100ae1:	55                   	push   %rbp
  100ae2:	48 89 e5             	mov    %rsp,%rbp
  100ae5:	48 83 ec 20          	sub    $0x20,%rsp
  100ae9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100aed:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100af1:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100af8:	00 
  100af9:	eb 0a                	jmp    100b05 <strnlen+0x24>
        ++n;
  100afb:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100b00:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100b05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b09:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100b0d:	74 0b                	je     100b1a <strnlen+0x39>
  100b0f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100b13:	0f b6 00             	movzbl (%rax),%eax
  100b16:	84 c0                	test   %al,%al
  100b18:	75 e1                	jne    100afb <strnlen+0x1a>
    }
    return n;
  100b1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100b1e:	c9                   	leave  
  100b1f:	c3                   	ret    

0000000000100b20 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100b20:	55                   	push   %rbp
  100b21:	48 89 e5             	mov    %rsp,%rbp
  100b24:	48 83 ec 20          	sub    $0x20,%rsp
  100b28:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100b2c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  100b30:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100b34:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100b38:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100b3c:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100b40:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100b44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b48:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100b4c:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100b50:	0f b6 12             	movzbl (%rdx),%edx
  100b53:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100b55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b59:	48 83 e8 01          	sub    $0x1,%rax
  100b5d:	0f b6 00             	movzbl (%rax),%eax
  100b60:	84 c0                	test   %al,%al
  100b62:	75 d4                	jne    100b38 <strcpy+0x18>
    return dst;
  100b64:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100b68:	c9                   	leave  
  100b69:	c3                   	ret    

0000000000100b6a <strcmp>:

int strcmp(const char* a, const char* b) {
  100b6a:	55                   	push   %rbp
  100b6b:	48 89 e5             	mov    %rsp,%rbp
  100b6e:	48 83 ec 10          	sub    $0x10,%rsp
  100b72:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100b76:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100b7a:	eb 0a                	jmp    100b86 <strcmp+0x1c>
        ++a, ++b;
  100b7c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100b81:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100b86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b8a:	0f b6 00             	movzbl (%rax),%eax
  100b8d:	84 c0                	test   %al,%al
  100b8f:	74 1d                	je     100bae <strcmp+0x44>
  100b91:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100b95:	0f b6 00             	movzbl (%rax),%eax
  100b98:	84 c0                	test   %al,%al
  100b9a:	74 12                	je     100bae <strcmp+0x44>
  100b9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100ba0:	0f b6 10             	movzbl (%rax),%edx
  100ba3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100ba7:	0f b6 00             	movzbl (%rax),%eax
  100baa:	38 c2                	cmp    %al,%dl
  100bac:	74 ce                	je     100b7c <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100bae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100bb2:	0f b6 00             	movzbl (%rax),%eax
  100bb5:	89 c2                	mov    %eax,%edx
  100bb7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100bbb:	0f b6 00             	movzbl (%rax),%eax
  100bbe:	38 d0                	cmp    %dl,%al
  100bc0:	0f 92 c0             	setb   %al
  100bc3:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100bc6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100bca:	0f b6 00             	movzbl (%rax),%eax
  100bcd:	89 c1                	mov    %eax,%ecx
  100bcf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100bd3:	0f b6 00             	movzbl (%rax),%eax
  100bd6:	38 c1                	cmp    %al,%cl
  100bd8:	0f 92 c0             	setb   %al
  100bdb:	0f b6 c0             	movzbl %al,%eax
  100bde:	29 c2                	sub    %eax,%edx
  100be0:	89 d0                	mov    %edx,%eax
}
  100be2:	c9                   	leave  
  100be3:	c3                   	ret    

0000000000100be4 <strchr>:

char* strchr(const char* s, int c) {
  100be4:	55                   	push   %rbp
  100be5:	48 89 e5             	mov    %rsp,%rbp
  100be8:	48 83 ec 10          	sub    $0x10,%rsp
  100bec:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100bf0:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100bf3:	eb 05                	jmp    100bfa <strchr+0x16>
        ++s;
  100bf5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100bfa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100bfe:	0f b6 00             	movzbl (%rax),%eax
  100c01:	84 c0                	test   %al,%al
  100c03:	74 0e                	je     100c13 <strchr+0x2f>
  100c05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c09:	0f b6 00             	movzbl (%rax),%eax
  100c0c:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100c0f:	38 d0                	cmp    %dl,%al
  100c11:	75 e2                	jne    100bf5 <strchr+0x11>
    }
    if (*s == (char) c) {
  100c13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c17:	0f b6 00             	movzbl (%rax),%eax
  100c1a:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100c1d:	38 d0                	cmp    %dl,%al
  100c1f:	75 06                	jne    100c27 <strchr+0x43>
        return (char*) s;
  100c21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c25:	eb 05                	jmp    100c2c <strchr+0x48>
    } else {
        return NULL;
  100c27:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100c2c:	c9                   	leave  
  100c2d:	c3                   	ret    

0000000000100c2e <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100c2e:	55                   	push   %rbp
  100c2f:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  100c32:	8b 05 00 14 00 00    	mov    0x1400(%rip),%eax        # 102038 <rand_seed_set>
  100c38:	85 c0                	test   %eax,%eax
  100c3a:	75 0a                	jne    100c46 <rand+0x18>
        srand(819234718U);
  100c3c:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100c41:	e8 24 00 00 00       	call   100c6a <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100c46:	8b 05 f0 13 00 00    	mov    0x13f0(%rip),%eax        # 10203c <rand_seed>
  100c4c:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100c52:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100c57:	89 05 df 13 00 00    	mov    %eax,0x13df(%rip)        # 10203c <rand_seed>
    return rand_seed & RAND_MAX;
  100c5d:	8b 05 d9 13 00 00    	mov    0x13d9(%rip),%eax        # 10203c <rand_seed>
  100c63:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100c68:	5d                   	pop    %rbp
  100c69:	c3                   	ret    

0000000000100c6a <srand>:

void srand(unsigned seed) {
  100c6a:	55                   	push   %rbp
  100c6b:	48 89 e5             	mov    %rsp,%rbp
  100c6e:	48 83 ec 08          	sub    $0x8,%rsp
  100c72:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100c75:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100c78:	89 05 be 13 00 00    	mov    %eax,0x13be(%rip)        # 10203c <rand_seed>
    rand_seed_set = 1;
  100c7e:	c7 05 b0 13 00 00 01 	movl   $0x1,0x13b0(%rip)        # 102038 <rand_seed_set>
  100c85:	00 00 00 
}
  100c88:	90                   	nop
  100c89:	c9                   	leave  
  100c8a:	c3                   	ret    

0000000000100c8b <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100c8b:	55                   	push   %rbp
  100c8c:	48 89 e5             	mov    %rsp,%rbp
  100c8f:	48 83 ec 28          	sub    $0x28,%rsp
  100c93:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100c97:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100c9b:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100c9e:	48 c7 45 f8 d0 1c 10 	movq   $0x101cd0,-0x8(%rbp)
  100ca5:	00 
    if (base < 0) {
  100ca6:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100caa:	79 0b                	jns    100cb7 <fill_numbuf+0x2c>
        digits = lower_digits;
  100cac:	48 c7 45 f8 f0 1c 10 	movq   $0x101cf0,-0x8(%rbp)
  100cb3:	00 
        base = -base;
  100cb4:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100cb7:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100cbc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100cc0:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100cc3:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100cc6:	48 63 c8             	movslq %eax,%rcx
  100cc9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100ccd:	ba 00 00 00 00       	mov    $0x0,%edx
  100cd2:	48 f7 f1             	div    %rcx
  100cd5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100cd9:	48 01 d0             	add    %rdx,%rax
  100cdc:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100ce1:	0f b6 10             	movzbl (%rax),%edx
  100ce4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100ce8:	88 10                	mov    %dl,(%rax)
        val /= base;
  100cea:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100ced:	48 63 f0             	movslq %eax,%rsi
  100cf0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100cf4:	ba 00 00 00 00       	mov    $0x0,%edx
  100cf9:	48 f7 f6             	div    %rsi
  100cfc:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100d00:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100d05:	75 bc                	jne    100cc3 <fill_numbuf+0x38>
    return numbuf_end;
  100d07:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100d0b:	c9                   	leave  
  100d0c:	c3                   	ret    

0000000000100d0d <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100d0d:	55                   	push   %rbp
  100d0e:	48 89 e5             	mov    %rsp,%rbp
  100d11:	53                   	push   %rbx
  100d12:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100d19:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100d20:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100d26:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100d2d:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100d34:	e9 8a 09 00 00       	jmp    1016c3 <printer_vprintf+0x9b6>
        if (*format != '%') {
  100d39:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d40:	0f b6 00             	movzbl (%rax),%eax
  100d43:	3c 25                	cmp    $0x25,%al
  100d45:	74 31                	je     100d78 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  100d47:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d4e:	4c 8b 00             	mov    (%rax),%r8
  100d51:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d58:	0f b6 00             	movzbl (%rax),%eax
  100d5b:	0f b6 c8             	movzbl %al,%ecx
  100d5e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100d64:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d6b:	89 ce                	mov    %ecx,%esi
  100d6d:	48 89 c7             	mov    %rax,%rdi
  100d70:	41 ff d0             	call   *%r8
            continue;
  100d73:	e9 43 09 00 00       	jmp    1016bb <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100d78:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100d7f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100d86:	01 
  100d87:	eb 44                	jmp    100dcd <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  100d89:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d90:	0f b6 00             	movzbl (%rax),%eax
  100d93:	0f be c0             	movsbl %al,%eax
  100d96:	89 c6                	mov    %eax,%esi
  100d98:	bf f0 1a 10 00       	mov    $0x101af0,%edi
  100d9d:	e8 42 fe ff ff       	call   100be4 <strchr>
  100da2:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100da6:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100dab:	74 30                	je     100ddd <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  100dad:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100db1:	48 2d f0 1a 10 00    	sub    $0x101af0,%rax
  100db7:	ba 01 00 00 00       	mov    $0x1,%edx
  100dbc:	89 c1                	mov    %eax,%ecx
  100dbe:	d3 e2                	shl    %cl,%edx
  100dc0:	89 d0                	mov    %edx,%eax
  100dc2:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100dc5:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100dcc:	01 
  100dcd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100dd4:	0f b6 00             	movzbl (%rax),%eax
  100dd7:	84 c0                	test   %al,%al
  100dd9:	75 ae                	jne    100d89 <printer_vprintf+0x7c>
  100ddb:	eb 01                	jmp    100dde <printer_vprintf+0xd1>
            } else {
                break;
  100ddd:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100dde:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100de5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100dec:	0f b6 00             	movzbl (%rax),%eax
  100def:	3c 30                	cmp    $0x30,%al
  100df1:	7e 67                	jle    100e5a <printer_vprintf+0x14d>
  100df3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100dfa:	0f b6 00             	movzbl (%rax),%eax
  100dfd:	3c 39                	cmp    $0x39,%al
  100dff:	7f 59                	jg     100e5a <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100e01:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100e08:	eb 2e                	jmp    100e38 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100e0a:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100e0d:	89 d0                	mov    %edx,%eax
  100e0f:	c1 e0 02             	shl    $0x2,%eax
  100e12:	01 d0                	add    %edx,%eax
  100e14:	01 c0                	add    %eax,%eax
  100e16:	89 c1                	mov    %eax,%ecx
  100e18:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e1f:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100e23:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100e2a:	0f b6 00             	movzbl (%rax),%eax
  100e2d:	0f be c0             	movsbl %al,%eax
  100e30:	01 c8                	add    %ecx,%eax
  100e32:	83 e8 30             	sub    $0x30,%eax
  100e35:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100e38:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e3f:	0f b6 00             	movzbl (%rax),%eax
  100e42:	3c 2f                	cmp    $0x2f,%al
  100e44:	0f 8e 85 00 00 00    	jle    100ecf <printer_vprintf+0x1c2>
  100e4a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e51:	0f b6 00             	movzbl (%rax),%eax
  100e54:	3c 39                	cmp    $0x39,%al
  100e56:	7e b2                	jle    100e0a <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100e58:	eb 75                	jmp    100ecf <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100e5a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e61:	0f b6 00             	movzbl (%rax),%eax
  100e64:	3c 2a                	cmp    $0x2a,%al
  100e66:	75 68                	jne    100ed0 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100e68:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e6f:	8b 00                	mov    (%rax),%eax
  100e71:	83 f8 2f             	cmp    $0x2f,%eax
  100e74:	77 30                	ja     100ea6 <printer_vprintf+0x199>
  100e76:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e7d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e81:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e88:	8b 00                	mov    (%rax),%eax
  100e8a:	89 c0                	mov    %eax,%eax
  100e8c:	48 01 d0             	add    %rdx,%rax
  100e8f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e96:	8b 12                	mov    (%rdx),%edx
  100e98:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e9b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ea2:	89 0a                	mov    %ecx,(%rdx)
  100ea4:	eb 1a                	jmp    100ec0 <printer_vprintf+0x1b3>
  100ea6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ead:	48 8b 40 08          	mov    0x8(%rax),%rax
  100eb1:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100eb5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ebc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ec0:	8b 00                	mov    (%rax),%eax
  100ec2:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100ec5:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ecc:	01 
  100ecd:	eb 01                	jmp    100ed0 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100ecf:	90                   	nop
        }

        // process precision
        int precision = -1;
  100ed0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100ed7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ede:	0f b6 00             	movzbl (%rax),%eax
  100ee1:	3c 2e                	cmp    $0x2e,%al
  100ee3:	0f 85 00 01 00 00    	jne    100fe9 <printer_vprintf+0x2dc>
            ++format;
  100ee9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ef0:	01 
            if (*format >= '0' && *format <= '9') {
  100ef1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ef8:	0f b6 00             	movzbl (%rax),%eax
  100efb:	3c 2f                	cmp    $0x2f,%al
  100efd:	7e 67                	jle    100f66 <printer_vprintf+0x259>
  100eff:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f06:	0f b6 00             	movzbl (%rax),%eax
  100f09:	3c 39                	cmp    $0x39,%al
  100f0b:	7f 59                	jg     100f66 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100f0d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100f14:	eb 2e                	jmp    100f44 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100f16:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100f19:	89 d0                	mov    %edx,%eax
  100f1b:	c1 e0 02             	shl    $0x2,%eax
  100f1e:	01 d0                	add    %edx,%eax
  100f20:	01 c0                	add    %eax,%eax
  100f22:	89 c1                	mov    %eax,%ecx
  100f24:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f2b:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100f2f:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100f36:	0f b6 00             	movzbl (%rax),%eax
  100f39:	0f be c0             	movsbl %al,%eax
  100f3c:	01 c8                	add    %ecx,%eax
  100f3e:	83 e8 30             	sub    $0x30,%eax
  100f41:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100f44:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f4b:	0f b6 00             	movzbl (%rax),%eax
  100f4e:	3c 2f                	cmp    $0x2f,%al
  100f50:	0f 8e 85 00 00 00    	jle    100fdb <printer_vprintf+0x2ce>
  100f56:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f5d:	0f b6 00             	movzbl (%rax),%eax
  100f60:	3c 39                	cmp    $0x39,%al
  100f62:	7e b2                	jle    100f16 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100f64:	eb 75                	jmp    100fdb <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100f66:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f6d:	0f b6 00             	movzbl (%rax),%eax
  100f70:	3c 2a                	cmp    $0x2a,%al
  100f72:	75 68                	jne    100fdc <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100f74:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f7b:	8b 00                	mov    (%rax),%eax
  100f7d:	83 f8 2f             	cmp    $0x2f,%eax
  100f80:	77 30                	ja     100fb2 <printer_vprintf+0x2a5>
  100f82:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f89:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100f8d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f94:	8b 00                	mov    (%rax),%eax
  100f96:	89 c0                	mov    %eax,%eax
  100f98:	48 01 d0             	add    %rdx,%rax
  100f9b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fa2:	8b 12                	mov    (%rdx),%edx
  100fa4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100fa7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fae:	89 0a                	mov    %ecx,(%rdx)
  100fb0:	eb 1a                	jmp    100fcc <printer_vprintf+0x2bf>
  100fb2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fb9:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fbd:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100fc1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fc8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100fcc:	8b 00                	mov    (%rax),%eax
  100fce:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100fd1:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100fd8:	01 
  100fd9:	eb 01                	jmp    100fdc <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100fdb:	90                   	nop
            }
            if (precision < 0) {
  100fdc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100fe0:	79 07                	jns    100fe9 <printer_vprintf+0x2dc>
                precision = 0;
  100fe2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100fe9:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100ff0:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100ff7:	00 
        int length = 0;
  100ff8:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100fff:	48 c7 45 c8 f6 1a 10 	movq   $0x101af6,-0x38(%rbp)
  101006:	00 
    again:
        switch (*format) {
  101007:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10100e:	0f b6 00             	movzbl (%rax),%eax
  101011:	0f be c0             	movsbl %al,%eax
  101014:	83 e8 43             	sub    $0x43,%eax
  101017:	83 f8 37             	cmp    $0x37,%eax
  10101a:	0f 87 9f 03 00 00    	ja     1013bf <printer_vprintf+0x6b2>
  101020:	89 c0                	mov    %eax,%eax
  101022:	48 8b 04 c5 08 1b 10 	mov    0x101b08(,%rax,8),%rax
  101029:	00 
  10102a:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  10102c:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  101033:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10103a:	01 
            goto again;
  10103b:	eb ca                	jmp    101007 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  10103d:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  101041:	74 5d                	je     1010a0 <printer_vprintf+0x393>
  101043:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10104a:	8b 00                	mov    (%rax),%eax
  10104c:	83 f8 2f             	cmp    $0x2f,%eax
  10104f:	77 30                	ja     101081 <printer_vprintf+0x374>
  101051:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101058:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10105c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101063:	8b 00                	mov    (%rax),%eax
  101065:	89 c0                	mov    %eax,%eax
  101067:	48 01 d0             	add    %rdx,%rax
  10106a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101071:	8b 12                	mov    (%rdx),%edx
  101073:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101076:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10107d:	89 0a                	mov    %ecx,(%rdx)
  10107f:	eb 1a                	jmp    10109b <printer_vprintf+0x38e>
  101081:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101088:	48 8b 40 08          	mov    0x8(%rax),%rax
  10108c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101090:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101097:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10109b:	48 8b 00             	mov    (%rax),%rax
  10109e:	eb 5c                	jmp    1010fc <printer_vprintf+0x3ef>
  1010a0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010a7:	8b 00                	mov    (%rax),%eax
  1010a9:	83 f8 2f             	cmp    $0x2f,%eax
  1010ac:	77 30                	ja     1010de <printer_vprintf+0x3d1>
  1010ae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010b5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1010b9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010c0:	8b 00                	mov    (%rax),%eax
  1010c2:	89 c0                	mov    %eax,%eax
  1010c4:	48 01 d0             	add    %rdx,%rax
  1010c7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010ce:	8b 12                	mov    (%rdx),%edx
  1010d0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1010d3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010da:	89 0a                	mov    %ecx,(%rdx)
  1010dc:	eb 1a                	jmp    1010f8 <printer_vprintf+0x3eb>
  1010de:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010e5:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010e9:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1010ed:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010f4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1010f8:	8b 00                	mov    (%rax),%eax
  1010fa:	48 98                	cltq   
  1010fc:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  101100:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101104:	48 c1 f8 38          	sar    $0x38,%rax
  101108:	25 80 00 00 00       	and    $0x80,%eax
  10110d:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  101110:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  101114:	74 09                	je     10111f <printer_vprintf+0x412>
  101116:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10111a:	48 f7 d8             	neg    %rax
  10111d:	eb 04                	jmp    101123 <printer_vprintf+0x416>
  10111f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101123:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  101127:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  10112a:	83 c8 60             	or     $0x60,%eax
  10112d:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  101130:	e9 cf 02 00 00       	jmp    101404 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  101135:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  101139:	74 5d                	je     101198 <printer_vprintf+0x48b>
  10113b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101142:	8b 00                	mov    (%rax),%eax
  101144:	83 f8 2f             	cmp    $0x2f,%eax
  101147:	77 30                	ja     101179 <printer_vprintf+0x46c>
  101149:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101150:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101154:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10115b:	8b 00                	mov    (%rax),%eax
  10115d:	89 c0                	mov    %eax,%eax
  10115f:	48 01 d0             	add    %rdx,%rax
  101162:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101169:	8b 12                	mov    (%rdx),%edx
  10116b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10116e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101175:	89 0a                	mov    %ecx,(%rdx)
  101177:	eb 1a                	jmp    101193 <printer_vprintf+0x486>
  101179:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101180:	48 8b 40 08          	mov    0x8(%rax),%rax
  101184:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101188:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10118f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101193:	48 8b 00             	mov    (%rax),%rax
  101196:	eb 5c                	jmp    1011f4 <printer_vprintf+0x4e7>
  101198:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10119f:	8b 00                	mov    (%rax),%eax
  1011a1:	83 f8 2f             	cmp    $0x2f,%eax
  1011a4:	77 30                	ja     1011d6 <printer_vprintf+0x4c9>
  1011a6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011ad:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1011b1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011b8:	8b 00                	mov    (%rax),%eax
  1011ba:	89 c0                	mov    %eax,%eax
  1011bc:	48 01 d0             	add    %rdx,%rax
  1011bf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011c6:	8b 12                	mov    (%rdx),%edx
  1011c8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1011cb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011d2:	89 0a                	mov    %ecx,(%rdx)
  1011d4:	eb 1a                	jmp    1011f0 <printer_vprintf+0x4e3>
  1011d6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011dd:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011e1:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1011e5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011ec:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1011f0:	8b 00                	mov    (%rax),%eax
  1011f2:	89 c0                	mov    %eax,%eax
  1011f4:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  1011f8:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  1011fc:	e9 03 02 00 00       	jmp    101404 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  101201:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  101208:	e9 28 ff ff ff       	jmp    101135 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  10120d:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  101214:	e9 1c ff ff ff       	jmp    101135 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  101219:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101220:	8b 00                	mov    (%rax),%eax
  101222:	83 f8 2f             	cmp    $0x2f,%eax
  101225:	77 30                	ja     101257 <printer_vprintf+0x54a>
  101227:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10122e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101232:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101239:	8b 00                	mov    (%rax),%eax
  10123b:	89 c0                	mov    %eax,%eax
  10123d:	48 01 d0             	add    %rdx,%rax
  101240:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101247:	8b 12                	mov    (%rdx),%edx
  101249:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10124c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101253:	89 0a                	mov    %ecx,(%rdx)
  101255:	eb 1a                	jmp    101271 <printer_vprintf+0x564>
  101257:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10125e:	48 8b 40 08          	mov    0x8(%rax),%rax
  101262:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101266:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10126d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101271:	48 8b 00             	mov    (%rax),%rax
  101274:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  101278:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  10127f:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  101286:	e9 79 01 00 00       	jmp    101404 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  10128b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101292:	8b 00                	mov    (%rax),%eax
  101294:	83 f8 2f             	cmp    $0x2f,%eax
  101297:	77 30                	ja     1012c9 <printer_vprintf+0x5bc>
  101299:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012a0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1012a4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012ab:	8b 00                	mov    (%rax),%eax
  1012ad:	89 c0                	mov    %eax,%eax
  1012af:	48 01 d0             	add    %rdx,%rax
  1012b2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012b9:	8b 12                	mov    (%rdx),%edx
  1012bb:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1012be:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012c5:	89 0a                	mov    %ecx,(%rdx)
  1012c7:	eb 1a                	jmp    1012e3 <printer_vprintf+0x5d6>
  1012c9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012d0:	48 8b 40 08          	mov    0x8(%rax),%rax
  1012d4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1012d8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012df:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1012e3:	48 8b 00             	mov    (%rax),%rax
  1012e6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  1012ea:	e9 15 01 00 00       	jmp    101404 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  1012ef:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012f6:	8b 00                	mov    (%rax),%eax
  1012f8:	83 f8 2f             	cmp    $0x2f,%eax
  1012fb:	77 30                	ja     10132d <printer_vprintf+0x620>
  1012fd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101304:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101308:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10130f:	8b 00                	mov    (%rax),%eax
  101311:	89 c0                	mov    %eax,%eax
  101313:	48 01 d0             	add    %rdx,%rax
  101316:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10131d:	8b 12                	mov    (%rdx),%edx
  10131f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101322:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101329:	89 0a                	mov    %ecx,(%rdx)
  10132b:	eb 1a                	jmp    101347 <printer_vprintf+0x63a>
  10132d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101334:	48 8b 40 08          	mov    0x8(%rax),%rax
  101338:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10133c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101343:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101347:	8b 00                	mov    (%rax),%eax
  101349:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  10134f:	e9 67 03 00 00       	jmp    1016bb <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  101354:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101358:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  10135c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101363:	8b 00                	mov    (%rax),%eax
  101365:	83 f8 2f             	cmp    $0x2f,%eax
  101368:	77 30                	ja     10139a <printer_vprintf+0x68d>
  10136a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101371:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101375:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10137c:	8b 00                	mov    (%rax),%eax
  10137e:	89 c0                	mov    %eax,%eax
  101380:	48 01 d0             	add    %rdx,%rax
  101383:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10138a:	8b 12                	mov    (%rdx),%edx
  10138c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10138f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101396:	89 0a                	mov    %ecx,(%rdx)
  101398:	eb 1a                	jmp    1013b4 <printer_vprintf+0x6a7>
  10139a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013a1:	48 8b 40 08          	mov    0x8(%rax),%rax
  1013a5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1013a9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1013b0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1013b4:	8b 00                	mov    (%rax),%eax
  1013b6:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  1013b9:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  1013bd:	eb 45                	jmp    101404 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  1013bf:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1013c3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  1013c7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1013ce:	0f b6 00             	movzbl (%rax),%eax
  1013d1:	84 c0                	test   %al,%al
  1013d3:	74 0c                	je     1013e1 <printer_vprintf+0x6d4>
  1013d5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1013dc:	0f b6 00             	movzbl (%rax),%eax
  1013df:	eb 05                	jmp    1013e6 <printer_vprintf+0x6d9>
  1013e1:	b8 25 00 00 00       	mov    $0x25,%eax
  1013e6:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  1013e9:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  1013ed:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1013f4:	0f b6 00             	movzbl (%rax),%eax
  1013f7:	84 c0                	test   %al,%al
  1013f9:	75 08                	jne    101403 <printer_vprintf+0x6f6>
                format--;
  1013fb:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  101402:	01 
            }
            break;
  101403:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  101404:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101407:	83 e0 20             	and    $0x20,%eax
  10140a:	85 c0                	test   %eax,%eax
  10140c:	74 1e                	je     10142c <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  10140e:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101412:	48 83 c0 18          	add    $0x18,%rax
  101416:	8b 55 e0             	mov    -0x20(%rbp),%edx
  101419:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  10141d:	48 89 ce             	mov    %rcx,%rsi
  101420:	48 89 c7             	mov    %rax,%rdi
  101423:	e8 63 f8 ff ff       	call   100c8b <fill_numbuf>
  101428:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  10142c:	48 c7 45 c0 f6 1a 10 	movq   $0x101af6,-0x40(%rbp)
  101433:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  101434:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101437:	83 e0 20             	and    $0x20,%eax
  10143a:	85 c0                	test   %eax,%eax
  10143c:	74 48                	je     101486 <printer_vprintf+0x779>
  10143e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101441:	83 e0 40             	and    $0x40,%eax
  101444:	85 c0                	test   %eax,%eax
  101446:	74 3e                	je     101486 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  101448:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10144b:	25 80 00 00 00       	and    $0x80,%eax
  101450:	85 c0                	test   %eax,%eax
  101452:	74 0a                	je     10145e <printer_vprintf+0x751>
                prefix = "-";
  101454:	48 c7 45 c0 f7 1a 10 	movq   $0x101af7,-0x40(%rbp)
  10145b:	00 
            if (flags & FLAG_NEGATIVE) {
  10145c:	eb 73                	jmp    1014d1 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  10145e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101461:	83 e0 10             	and    $0x10,%eax
  101464:	85 c0                	test   %eax,%eax
  101466:	74 0a                	je     101472 <printer_vprintf+0x765>
                prefix = "+";
  101468:	48 c7 45 c0 f9 1a 10 	movq   $0x101af9,-0x40(%rbp)
  10146f:	00 
            if (flags & FLAG_NEGATIVE) {
  101470:	eb 5f                	jmp    1014d1 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  101472:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101475:	83 e0 08             	and    $0x8,%eax
  101478:	85 c0                	test   %eax,%eax
  10147a:	74 55                	je     1014d1 <printer_vprintf+0x7c4>
                prefix = " ";
  10147c:	48 c7 45 c0 fb 1a 10 	movq   $0x101afb,-0x40(%rbp)
  101483:	00 
            if (flags & FLAG_NEGATIVE) {
  101484:	eb 4b                	jmp    1014d1 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  101486:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101489:	83 e0 20             	and    $0x20,%eax
  10148c:	85 c0                	test   %eax,%eax
  10148e:	74 42                	je     1014d2 <printer_vprintf+0x7c5>
  101490:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101493:	83 e0 01             	and    $0x1,%eax
  101496:	85 c0                	test   %eax,%eax
  101498:	74 38                	je     1014d2 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  10149a:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  10149e:	74 06                	je     1014a6 <printer_vprintf+0x799>
  1014a0:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1014a4:	75 2c                	jne    1014d2 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  1014a6:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1014ab:	75 0c                	jne    1014b9 <printer_vprintf+0x7ac>
  1014ad:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1014b0:	25 00 01 00 00       	and    $0x100,%eax
  1014b5:	85 c0                	test   %eax,%eax
  1014b7:	74 19                	je     1014d2 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  1014b9:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1014bd:	75 07                	jne    1014c6 <printer_vprintf+0x7b9>
  1014bf:	b8 fd 1a 10 00       	mov    $0x101afd,%eax
  1014c4:	eb 05                	jmp    1014cb <printer_vprintf+0x7be>
  1014c6:	b8 00 1b 10 00       	mov    $0x101b00,%eax
  1014cb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1014cf:	eb 01                	jmp    1014d2 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  1014d1:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  1014d2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1014d6:	78 24                	js     1014fc <printer_vprintf+0x7ef>
  1014d8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1014db:	83 e0 20             	and    $0x20,%eax
  1014de:	85 c0                	test   %eax,%eax
  1014e0:	75 1a                	jne    1014fc <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  1014e2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1014e5:	48 63 d0             	movslq %eax,%rdx
  1014e8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1014ec:	48 89 d6             	mov    %rdx,%rsi
  1014ef:	48 89 c7             	mov    %rax,%rdi
  1014f2:	e8 ea f5 ff ff       	call   100ae1 <strnlen>
  1014f7:	89 45 bc             	mov    %eax,-0x44(%rbp)
  1014fa:	eb 0f                	jmp    10150b <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  1014fc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101500:	48 89 c7             	mov    %rax,%rdi
  101503:	e8 a8 f5 ff ff       	call   100ab0 <strlen>
  101508:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  10150b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10150e:	83 e0 20             	and    $0x20,%eax
  101511:	85 c0                	test   %eax,%eax
  101513:	74 20                	je     101535 <printer_vprintf+0x828>
  101515:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101519:	78 1a                	js     101535 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  10151b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10151e:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  101521:	7e 08                	jle    10152b <printer_vprintf+0x81e>
  101523:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101526:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101529:	eb 05                	jmp    101530 <printer_vprintf+0x823>
  10152b:	b8 00 00 00 00       	mov    $0x0,%eax
  101530:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101533:	eb 5c                	jmp    101591 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  101535:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101538:	83 e0 20             	and    $0x20,%eax
  10153b:	85 c0                	test   %eax,%eax
  10153d:	74 4b                	je     10158a <printer_vprintf+0x87d>
  10153f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101542:	83 e0 02             	and    $0x2,%eax
  101545:	85 c0                	test   %eax,%eax
  101547:	74 41                	je     10158a <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  101549:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10154c:	83 e0 04             	and    $0x4,%eax
  10154f:	85 c0                	test   %eax,%eax
  101551:	75 37                	jne    10158a <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  101553:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101557:	48 89 c7             	mov    %rax,%rdi
  10155a:	e8 51 f5 ff ff       	call   100ab0 <strlen>
  10155f:	89 c2                	mov    %eax,%edx
  101561:	8b 45 bc             	mov    -0x44(%rbp),%eax
  101564:	01 d0                	add    %edx,%eax
  101566:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  101569:	7e 1f                	jle    10158a <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  10156b:	8b 45 e8             	mov    -0x18(%rbp),%eax
  10156e:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101571:	89 c3                	mov    %eax,%ebx
  101573:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101577:	48 89 c7             	mov    %rax,%rdi
  10157a:	e8 31 f5 ff ff       	call   100ab0 <strlen>
  10157f:	89 c2                	mov    %eax,%edx
  101581:	89 d8                	mov    %ebx,%eax
  101583:	29 d0                	sub    %edx,%eax
  101585:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101588:	eb 07                	jmp    101591 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  10158a:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  101591:	8b 55 bc             	mov    -0x44(%rbp),%edx
  101594:	8b 45 b8             	mov    -0x48(%rbp),%eax
  101597:	01 d0                	add    %edx,%eax
  101599:	48 63 d8             	movslq %eax,%rbx
  10159c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1015a0:	48 89 c7             	mov    %rax,%rdi
  1015a3:	e8 08 f5 ff ff       	call   100ab0 <strlen>
  1015a8:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  1015ac:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1015af:	29 d0                	sub    %edx,%eax
  1015b1:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1015b4:	eb 25                	jmp    1015db <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  1015b6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1015bd:	48 8b 08             	mov    (%rax),%rcx
  1015c0:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1015c6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1015cd:	be 20 00 00 00       	mov    $0x20,%esi
  1015d2:	48 89 c7             	mov    %rax,%rdi
  1015d5:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1015d7:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1015db:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015de:	83 e0 04             	and    $0x4,%eax
  1015e1:	85 c0                	test   %eax,%eax
  1015e3:	75 36                	jne    10161b <printer_vprintf+0x90e>
  1015e5:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1015e9:	7f cb                	jg     1015b6 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  1015eb:	eb 2e                	jmp    10161b <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  1015ed:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1015f4:	4c 8b 00             	mov    (%rax),%r8
  1015f7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1015fb:	0f b6 00             	movzbl (%rax),%eax
  1015fe:	0f b6 c8             	movzbl %al,%ecx
  101601:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101607:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10160e:	89 ce                	mov    %ecx,%esi
  101610:	48 89 c7             	mov    %rax,%rdi
  101613:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  101616:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  10161b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10161f:	0f b6 00             	movzbl (%rax),%eax
  101622:	84 c0                	test   %al,%al
  101624:	75 c7                	jne    1015ed <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  101626:	eb 25                	jmp    10164d <printer_vprintf+0x940>
            p->putc(p, '0', color);
  101628:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10162f:	48 8b 08             	mov    (%rax),%rcx
  101632:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101638:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10163f:	be 30 00 00 00       	mov    $0x30,%esi
  101644:	48 89 c7             	mov    %rax,%rdi
  101647:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  101649:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  10164d:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  101651:	7f d5                	jg     101628 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  101653:	eb 32                	jmp    101687 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  101655:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10165c:	4c 8b 00             	mov    (%rax),%r8
  10165f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101663:	0f b6 00             	movzbl (%rax),%eax
  101666:	0f b6 c8             	movzbl %al,%ecx
  101669:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10166f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101676:	89 ce                	mov    %ecx,%esi
  101678:	48 89 c7             	mov    %rax,%rdi
  10167b:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  10167e:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  101683:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  101687:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  10168b:	7f c8                	jg     101655 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  10168d:	eb 25                	jmp    1016b4 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  10168f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101696:	48 8b 08             	mov    (%rax),%rcx
  101699:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10169f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1016a6:	be 20 00 00 00       	mov    $0x20,%esi
  1016ab:	48 89 c7             	mov    %rax,%rdi
  1016ae:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  1016b0:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1016b4:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1016b8:	7f d5                	jg     10168f <printer_vprintf+0x982>
        }
    done: ;
  1016ba:	90                   	nop
    for (; *format; ++format) {
  1016bb:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1016c2:	01 
  1016c3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1016ca:	0f b6 00             	movzbl (%rax),%eax
  1016cd:	84 c0                	test   %al,%al
  1016cf:	0f 85 64 f6 ff ff    	jne    100d39 <printer_vprintf+0x2c>
    }
}
  1016d5:	90                   	nop
  1016d6:	90                   	nop
  1016d7:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1016db:	c9                   	leave  
  1016dc:	c3                   	ret    

00000000001016dd <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1016dd:	55                   	push   %rbp
  1016de:	48 89 e5             	mov    %rsp,%rbp
  1016e1:	48 83 ec 20          	sub    $0x20,%rsp
  1016e5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1016e9:	89 f0                	mov    %esi,%eax
  1016eb:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1016ee:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  1016f1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1016f5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1016f9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1016fd:	48 8b 40 08          	mov    0x8(%rax),%rax
  101701:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  101706:	48 39 d0             	cmp    %rdx,%rax
  101709:	72 0c                	jb     101717 <console_putc+0x3a>
        cp->cursor = console;
  10170b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10170f:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  101716:	00 
    }
    if (c == '\n') {
  101717:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  10171b:	75 78                	jne    101795 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  10171d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101721:	48 8b 40 08          	mov    0x8(%rax),%rax
  101725:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  10172b:	48 d1 f8             	sar    %rax
  10172e:	48 89 c1             	mov    %rax,%rcx
  101731:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  101738:	66 66 66 
  10173b:	48 89 c8             	mov    %rcx,%rax
  10173e:	48 f7 ea             	imul   %rdx
  101741:	48 c1 fa 05          	sar    $0x5,%rdx
  101745:	48 89 c8             	mov    %rcx,%rax
  101748:	48 c1 f8 3f          	sar    $0x3f,%rax
  10174c:	48 29 c2             	sub    %rax,%rdx
  10174f:	48 89 d0             	mov    %rdx,%rax
  101752:	48 c1 e0 02          	shl    $0x2,%rax
  101756:	48 01 d0             	add    %rdx,%rax
  101759:	48 c1 e0 04          	shl    $0x4,%rax
  10175d:	48 29 c1             	sub    %rax,%rcx
  101760:	48 89 ca             	mov    %rcx,%rdx
  101763:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101766:	eb 25                	jmp    10178d <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  101768:	8b 45 e0             	mov    -0x20(%rbp),%eax
  10176b:	83 c8 20             	or     $0x20,%eax
  10176e:	89 c6                	mov    %eax,%esi
  101770:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101774:	48 8b 40 08          	mov    0x8(%rax),%rax
  101778:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10177c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101780:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101784:	89 f2                	mov    %esi,%edx
  101786:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  101789:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10178d:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101791:	75 d5                	jne    101768 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101793:	eb 24                	jmp    1017b9 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  101795:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  101799:	8b 55 e0             	mov    -0x20(%rbp),%edx
  10179c:	09 d0                	or     %edx,%eax
  10179e:	89 c6                	mov    %eax,%esi
  1017a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1017a4:	48 8b 40 08          	mov    0x8(%rax),%rax
  1017a8:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1017ac:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1017b0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1017b4:	89 f2                	mov    %esi,%edx
  1017b6:	66 89 10             	mov    %dx,(%rax)
}
  1017b9:	90                   	nop
  1017ba:	c9                   	leave  
  1017bb:	c3                   	ret    

00000000001017bc <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1017bc:	55                   	push   %rbp
  1017bd:	48 89 e5             	mov    %rsp,%rbp
  1017c0:	48 83 ec 30          	sub    $0x30,%rsp
  1017c4:	89 7d ec             	mov    %edi,-0x14(%rbp)
  1017c7:	89 75 e8             	mov    %esi,-0x18(%rbp)
  1017ca:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1017ce:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  1017d2:	48 c7 45 f0 dd 16 10 	movq   $0x1016dd,-0x10(%rbp)
  1017d9:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1017da:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  1017de:	78 09                	js     1017e9 <console_vprintf+0x2d>
  1017e0:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  1017e7:	7e 07                	jle    1017f0 <console_vprintf+0x34>
        cpos = 0;
  1017e9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  1017f0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1017f3:	48 98                	cltq   
  1017f5:	48 01 c0             	add    %rax,%rax
  1017f8:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  1017fe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101802:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101806:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  10180a:	8b 75 e8             	mov    -0x18(%rbp),%esi
  10180d:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101811:	48 89 c7             	mov    %rax,%rdi
  101814:	e8 f4 f4 ff ff       	call   100d0d <printer_vprintf>
    return cp.cursor - console;
  101819:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10181d:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  101823:	48 d1 f8             	sar    %rax
}
  101826:	c9                   	leave  
  101827:	c3                   	ret    

0000000000101828 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  101828:	55                   	push   %rbp
  101829:	48 89 e5             	mov    %rsp,%rbp
  10182c:	48 83 ec 60          	sub    $0x60,%rsp
  101830:	89 7d ac             	mov    %edi,-0x54(%rbp)
  101833:	89 75 a8             	mov    %esi,-0x58(%rbp)
  101836:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  10183a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10183e:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101842:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101846:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  10184d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101851:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101855:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101859:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  10185d:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101861:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101865:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101868:	8b 45 ac             	mov    -0x54(%rbp),%eax
  10186b:	89 c7                	mov    %eax,%edi
  10186d:	e8 4a ff ff ff       	call   1017bc <console_vprintf>
  101872:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101875:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101878:	c9                   	leave  
  101879:	c3                   	ret    

000000000010187a <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  10187a:	55                   	push   %rbp
  10187b:	48 89 e5             	mov    %rsp,%rbp
  10187e:	48 83 ec 20          	sub    $0x20,%rsp
  101882:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101886:	89 f0                	mov    %esi,%eax
  101888:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10188b:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  10188e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101892:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101896:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10189a:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10189e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1018a2:	48 8b 40 10          	mov    0x10(%rax),%rax
  1018a6:	48 39 c2             	cmp    %rax,%rdx
  1018a9:	73 1a                	jae    1018c5 <string_putc+0x4b>
        *sp->s++ = c;
  1018ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1018af:	48 8b 40 08          	mov    0x8(%rax),%rax
  1018b3:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1018b7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1018bb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1018bf:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1018c3:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1018c5:	90                   	nop
  1018c6:	c9                   	leave  
  1018c7:	c3                   	ret    

00000000001018c8 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1018c8:	55                   	push   %rbp
  1018c9:	48 89 e5             	mov    %rsp,%rbp
  1018cc:	48 83 ec 40          	sub    $0x40,%rsp
  1018d0:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  1018d4:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  1018d8:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  1018dc:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1018e0:	48 c7 45 e8 7a 18 10 	movq   $0x10187a,-0x18(%rbp)
  1018e7:	00 
    sp.s = s;
  1018e8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1018ec:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1018f0:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1018f5:	74 33                	je     10192a <vsnprintf+0x62>
        sp.end = s + size - 1;
  1018f7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1018fb:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1018ff:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101903:	48 01 d0             	add    %rdx,%rax
  101906:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  10190a:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  10190e:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101912:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101916:	be 00 00 00 00       	mov    $0x0,%esi
  10191b:	48 89 c7             	mov    %rax,%rdi
  10191e:	e8 ea f3 ff ff       	call   100d0d <printer_vprintf>
        *sp.s = 0;
  101923:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101927:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  10192a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10192e:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  101932:	c9                   	leave  
  101933:	c3                   	ret    

0000000000101934 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  101934:	55                   	push   %rbp
  101935:	48 89 e5             	mov    %rsp,%rbp
  101938:	48 83 ec 70          	sub    $0x70,%rsp
  10193c:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101940:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  101944:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101948:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10194c:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101950:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101954:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  10195b:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10195f:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101963:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101967:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  10196b:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  10196f:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101973:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101977:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10197b:	48 89 c7             	mov    %rax,%rdi
  10197e:	e8 45 ff ff ff       	call   1018c8 <vsnprintf>
  101983:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101986:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101989:	c9                   	leave  
  10198a:	c3                   	ret    

000000000010198b <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  10198b:	55                   	push   %rbp
  10198c:	48 89 e5             	mov    %rsp,%rbp
  10198f:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101993:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  10199a:	eb 13                	jmp    1019af <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  10199c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10199f:	48 98                	cltq   
  1019a1:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  1019a8:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1019ab:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1019af:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1019b6:	7e e4                	jle    10199c <console_clear+0x11>
    }
    cursorpos = 0;
  1019b8:	c7 05 3a 76 fb ff 00 	movl   $0x0,-0x489c6(%rip)        # b8ffc <cursorpos>
  1019bf:	00 00 00 
}
  1019c2:	90                   	nop
  1019c3:	c9                   	leave  
  1019c4:	c3                   	ret    
