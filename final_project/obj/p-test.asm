
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
  100004:	41 54                	push   %r12
  100006:	53                   	push   %rbx
  100007:	48 83 ec 20          	sub    $0x20,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  10000b:	cd 31                	int    $0x31
  10000d:	89 c7                	mov    %eax,%edi
    pid_t p = getpid();
    srand(p);
  10000f:	e8 5e 0c 00 00       	call   100c72 <srand>
    heap_bottom = heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100014:	b8 2f 34 10 00       	mov    $0x10342f,%eax
  100019:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10001f:	48 89 05 d2 23 00 00 	mov    %rax,0x23d2(%rip)        # 1023f8 <heap_top>
  100026:	48 89 05 c3 23 00 00 	mov    %rax,0x23c3(%rip)        # 1023f0 <heap_bottom>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10002d:	48 89 e0             	mov    %rsp,%rax
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100030:	48 83 e8 01          	sub    $0x1,%rax
  100034:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10003a:	48 89 05 a7 23 00 00 	mov    %rax,0x23a7(%rip)        # 1023e8 <stack_bottom>

// mem_tog
// toggles kernels printing of memory space for process if pid is its processID
// if pid == 0, toggles state globally (preference to global over local)
static inline void mem_tog(pid_t p) {
    asm volatile ("int %0" : /* no result */
  100041:	bf 00 00 00 00       	mov    $0x0,%edi
  100046:	cd 38                	int    $0x38
//    if ((*((size_t *)((uintptr_t)ptr - 8)) & ~0xF ) == (0x50))
//	    panic("success!");
//

	mem_tog(0);
	void *ptr1 = malloc(8);
  100048:	bf 08 00 00 00       	mov    $0x8,%edi
  10004d:	e8 04 04 00 00       	call   100456 <malloc>
	void *ptr2 = malloc(16);
  100052:	bf 10 00 00 00       	mov    $0x10,%edi
  100057:	e8 fa 03 00 00       	call   100456 <malloc>
	void *ptr3 = malloc(24);
  10005c:	bf 18 00 00 00       	mov    $0x18,%edi
  100061:	e8 f0 03 00 00       	call   100456 <malloc>

	struct heap_info_struct s1;
	heap_info(&s1);
  100066:	48 8d 7d d0          	lea    -0x30(%rbp),%rdi
  10006a:	e8 61 07 00 00       	call   1007d0 <heap_info>

	app_printf(0x700, "number of allocs: %d\n", s1.num_allocs);
  10006f:	8b 55 d0             	mov    -0x30(%rbp),%edx
  100072:	be d0 19 10 00       	mov    $0x1019d0,%esi
  100077:	bf 00 07 00 00       	mov    $0x700,%edi
  10007c:	b8 00 00 00 00       	mov    $0x0,%eax
  100081:	e8 66 00 00 00       	call   1000ec <app_printf>
	app_printf(0x700, "alloc list: \n");
  100086:	be e6 19 10 00       	mov    $0x1019e6,%esi
  10008b:	bf 00 07 00 00       	mov    $0x700,%edi
  100090:	b8 00 00 00 00       	mov    $0x0,%eax
  100095:	e8 52 00 00 00       	call   1000ec <app_printf>
	for (int i = 0; i < s1.num_allocs; i++) {
  10009a:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  10009e:	7e 3d                	jle    1000dd <process_main+0xdd>
  1000a0:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  1000a6:	bb 00 00 00 00       	mov    $0x0,%ebx
		app_printf(0x700, "    alloc'd region %d: %p    size: 0x%lx\n", i+1, s1.ptr_array[i], s1.size_array[i]);
  1000ab:	83 c3 01             	add    $0x1,%ebx
  1000ae:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1000b2:	4a 8b 0c 20          	mov    (%rax,%r12,1),%rcx
  1000b6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1000ba:	4e 8b 04 20          	mov    (%rax,%r12,1),%r8
  1000be:	89 da                	mov    %ebx,%edx
  1000c0:	be 10 1a 10 00       	mov    $0x101a10,%esi
  1000c5:	bf 00 07 00 00       	mov    $0x700,%edi
  1000ca:	b8 00 00 00 00       	mov    $0x0,%eax
  1000cf:	e8 18 00 00 00       	call   1000ec <app_printf>
	for (int i = 0; i < s1.num_allocs; i++) {
  1000d4:	49 83 c4 08          	add    $0x8,%r12
  1000d8:	3b 5d d0             	cmp    -0x30(%rbp),%ebx
  1000db:	7c ce                	jl     1000ab <process_main+0xab>
	}
	

    TEST_PASS();
  1000dd:	bf f4 19 10 00       	mov    $0x1019f4,%edi
  1000e2:	b8 00 00 00 00       	mov    $0x0,%eax
  1000e7:	e8 90 00 00 00       	call   10017c <kernel_panic>

00000000001000ec <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  1000ec:	55                   	push   %rbp
  1000ed:	48 89 e5             	mov    %rsp,%rbp
  1000f0:	48 83 ec 50          	sub    $0x50,%rsp
  1000f4:	49 89 f2             	mov    %rsi,%r10
  1000f7:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1000fb:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1000ff:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100103:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  100107:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  10010c:	85 ff                	test   %edi,%edi
  10010e:	78 2e                	js     10013e <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  100110:	48 63 ff             	movslq %edi,%rdi
  100113:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  10011a:	cc cc cc 
  10011d:	48 89 f8             	mov    %rdi,%rax
  100120:	48 f7 e2             	mul    %rdx
  100123:	48 89 d0             	mov    %rdx,%rax
  100126:	48 c1 e8 02          	shr    $0x2,%rax
  10012a:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  10012e:	48 01 c2             	add    %rax,%rdx
  100131:	48 29 d7             	sub    %rdx,%rdi
  100134:	0f b6 b7 6d 1a 10 00 	movzbl 0x101a6d(%rdi),%esi
  10013b:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  10013e:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  100145:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100149:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  10014d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100151:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  100155:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100159:	4c 89 d2             	mov    %r10,%rdx
  10015c:	8b 3d 9a 8e fb ff    	mov    -0x47166(%rip),%edi        # b8ffc <cursorpos>
  100162:	e8 5d 16 00 00       	call   1017c4 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100167:	3d 30 07 00 00       	cmp    $0x730,%eax
  10016c:	ba 00 00 00 00       	mov    $0x0,%edx
  100171:	0f 4d c2             	cmovge %edx,%eax
  100174:	89 05 82 8e fb ff    	mov    %eax,-0x4717e(%rip)        # b8ffc <cursorpos>
    }
}
  10017a:	c9                   	leave  
  10017b:	c3                   	ret    

000000000010017c <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  10017c:	55                   	push   %rbp
  10017d:	48 89 e5             	mov    %rsp,%rbp
  100180:	53                   	push   %rbx
  100181:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100188:	48 89 fb             	mov    %rdi,%rbx
  10018b:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  10018f:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  100193:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100197:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  10019b:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  10019f:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  1001a6:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1001aa:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  1001ae:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  1001b2:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  1001b6:	ba 07 00 00 00       	mov    $0x7,%edx
  1001bb:	be 3a 1a 10 00       	mov    $0x101a3a,%esi
  1001c0:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  1001c7:	e8 af 07 00 00       	call   10097b <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  1001cc:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  1001d0:	48 89 da             	mov    %rbx,%rdx
  1001d3:	be 99 00 00 00       	mov    $0x99,%esi
  1001d8:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  1001df:	e8 ec 16 00 00       	call   1018d0 <vsnprintf>
  1001e4:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  1001e7:	85 d2                	test   %edx,%edx
  1001e9:	7e 0f                	jle    1001fa <kernel_panic+0x7e>
  1001eb:	83 c0 06             	add    $0x6,%eax
  1001ee:	48 98                	cltq   
  1001f0:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  1001f7:	0a 
  1001f8:	75 2a                	jne    100224 <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  1001fa:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  100201:	48 89 d9             	mov    %rbx,%rcx
  100204:	ba 42 1a 10 00       	mov    $0x101a42,%edx
  100209:	be 00 c0 00 00       	mov    $0xc000,%esi
  10020e:	bf 30 07 00 00       	mov    $0x730,%edi
  100213:	b8 00 00 00 00       	mov    $0x0,%eax
  100218:	e8 13 16 00 00       	call   101830 <console_printf>
    asm volatile ("int %0" : /* no result */
  10021d:	48 89 df             	mov    %rbx,%rdi
  100220:	cd 30                	int    $0x30
 loop: goto loop;
  100222:	eb fe                	jmp    100222 <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  100224:	48 63 c2             	movslq %edx,%rax
  100227:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  10022d:	0f 94 c2             	sete   %dl
  100230:	0f b6 d2             	movzbl %dl,%edx
  100233:	48 29 d0             	sub    %rdx,%rax
  100236:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  10023d:	ff 
  10023e:	be f2 19 10 00       	mov    $0x1019f2,%esi
  100243:	e8 e0 08 00 00       	call   100b28 <strcpy>
  100248:	eb b0                	jmp    1001fa <kernel_panic+0x7e>

000000000010024a <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  10024a:	55                   	push   %rbp
  10024b:	48 89 e5             	mov    %rsp,%rbp
  10024e:	48 89 f9             	mov    %rdi,%rcx
  100251:	41 89 f0             	mov    %esi,%r8d
  100254:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100257:	ba 48 1a 10 00       	mov    $0x101a48,%edx
  10025c:	be 00 c0 00 00       	mov    $0xc000,%esi
  100261:	bf 30 07 00 00       	mov    $0x730,%edi
  100266:	b8 00 00 00 00       	mov    $0x0,%eax
  10026b:	e8 c0 15 00 00       	call   101830 <console_printf>
    asm volatile ("int %0" : /* no result */
  100270:	bf 00 00 00 00       	mov    $0x0,%edi
  100275:	cd 30                	int    $0x30
 loop: goto loop;
  100277:	eb fe                	jmp    100277 <assert_fail+0x2d>

0000000000100279 <heap_init>:
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  100279:	bf 10 00 00 00       	mov    $0x10,%edi
  10027e:	cd 3a                	int    $0x3a
  100280:	48 89 05 99 21 00 00 	mov    %rax,0x2199(%rip)        # 102420 <result.0>
  100287:	bf 08 00 00 00       	mov    $0x8,%edi
  10028c:	cd 3a                	int    $0x3a
  10028e:	48 89 05 8b 21 00 00 	mov    %rax,0x218b(%rip)        # 102420 <result.0>
// want to try and optimize this 
void heap_init(void) {

	// prologue block
	sbrk(sizeof(block_header) + sizeof(block_header));
	prologue_block = sbrk(sizeof(block_footer));
  100295:	48 89 05 74 21 00 00 	mov    %rax,0x2174(%rip)        # 102410 <prologue_block>
	PUT(HDRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  10029c:	48 c7 40 f8 11 00 00 	movq   $0x11,-0x8(%rax)
  1002a3:	00 
	PUT(FTRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  1002a4:	48 8b 15 65 21 00 00 	mov    0x2165(%rip),%rdx        # 102410 <prologue_block>
  1002ab:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  1002af:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  1002b3:	48 c7 44 02 f0 11 00 	movq   $0x11,-0x10(%rdx,%rax,1)
  1002ba:	00 00 
  1002bc:	cd 3a                	int    $0x3a
  1002be:	48 89 05 5b 21 00 00 	mov    %rax,0x215b(%rip)        # 102420 <result.0>

	// terminal block
	sbrk(sizeof(block_header));
	PUT(HDRP(NEXT_BLKP(prologue_block)), PACK(0, 1));	
  1002c5:	48 8b 15 44 21 00 00 	mov    0x2144(%rip),%rdx        # 102410 <prologue_block>
  1002cc:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  1002d0:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  1002d4:	48 c7 44 02 f8 01 00 	movq   $0x1,-0x8(%rdx,%rax,1)
  1002db:	00 00 

	free_list = NULL;
  1002dd:	48 c7 05 20 21 00 00 	movq   $0x0,0x2120(%rip)        # 102408 <free_list>
  1002e4:	00 00 00 00 

	initialized_heap = 1;
  1002e8:	c7 05 26 21 00 00 01 	movl   $0x1,0x2126(%rip)        # 102418 <initialized_heap>
  1002ef:	00 00 00 
}
  1002f2:	c3                   	ret    

00000000001002f3 <free>:

void free(void *firstbyte) {
	if (firstbyte == NULL)
  1002f3:	48 85 ff             	test   %rdi,%rdi
  1002f6:	74 3d                	je     100335 <free+0x42>
		return;

	// setup free things: alloc, list ptrs, footer
	PUT(HDRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  1002f8:	48 8b 47 f8          	mov    -0x8(%rdi),%rax
  1002fc:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100300:	48 89 47 f8          	mov    %rax,-0x8(%rdi)
	NEXT_FPTR(firstbyte) = free_list;
  100304:	48 8b 15 fd 20 00 00 	mov    0x20fd(%rip),%rdx        # 102408 <free_list>
  10030b:	48 89 17             	mov    %rdx,(%rdi)
	PREV_FPTR(firstbyte) = NULL;
  10030e:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  100315:	00 
	PUT(FTRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  100316:	48 89 44 07 f0       	mov    %rax,-0x10(%rdi,%rax,1)

	// add to free_list
	PREV_FPTR(free_list) = firstbyte;
  10031b:	48 8b 05 e6 20 00 00 	mov    0x20e6(%rip),%rax        # 102408 <free_list>
  100322:	48 89 78 08          	mov    %rdi,0x8(%rax)
	free_list = firstbyte;
  100326:	48 89 3d db 20 00 00 	mov    %rdi,0x20db(%rip)        # 102408 <free_list>

	num_allocs--;
  10032d:	48 83 2d cb 20 00 00 	subq   $0x1,0x20cb(%rip)        # 102400 <num_allocs>
  100334:	01 

	return;
}
  100335:	c3                   	ret    

0000000000100336 <extend>:
//
//	the reason allocating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
int extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  100336:	48 81 c7 ff 3f 00 00 	add    $0x3fff,%rdi
  10033d:	48 81 e7 00 c0 ff ff 	and    $0xffffffffffffc000,%rdi
  100344:	cd 3a                	int    $0x3a
  100346:	48 89 05 d3 20 00 00 	mov    %rax,0x20d3(%rip)        # 102420 <result.0>
	void *bp = sbrk(chunk_aligned_size);
	if (bp == (void *)-1)
  10034d:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  100351:	74 49                	je     10039c <extend+0x66>
		return -1;

	// setup pointer
	PUT(HDRP(bp), PACK(chunk_aligned_size, 0));	
  100353:	48 89 78 f8          	mov    %rdi,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  100357:	48 8b 15 aa 20 00 00 	mov    0x20aa(%rip),%rdx        # 102408 <free_list>
  10035e:	48 89 10             	mov    %rdx,(%rax)
	PREV_FPTR(bp) = NULL;
  100361:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  100368:	00 
	PUT(FTRP(bp), PACK(chunk_aligned_size, 0));	
  100369:	48 89 7c 07 f0       	mov    %rdi,-0x10(%rdi,%rax,1)
	
	// add to head of free_list
	if (free_list)
  10036e:	48 8b 15 93 20 00 00 	mov    0x2093(%rip),%rdx        # 102408 <free_list>
  100375:	48 85 d2             	test   %rdx,%rdx
  100378:	74 04                	je     10037e <extend+0x48>
		PREV_FPTR(free_list) = bp;
  10037a:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  10037e:	48 89 05 83 20 00 00 	mov    %rax,0x2083(%rip)        # 102408 <free_list>

	// update terminal block
	PUT(HDRP(NEXT_BLKP(bp)), PACK(0, 1));	
  100385:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  100389:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  10038d:	48 c7 44 10 f8 01 00 	movq   $0x1,-0x8(%rax,%rdx,1)
  100394:	00 00 

	return 0;
  100396:	b8 00 00 00 00       	mov    $0x0,%eax
  10039b:	c3                   	ret    
		return -1;
  10039c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1003a1:	c3                   	ret    

00000000001003a2 <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
  1003a2:	48 89 f8             	mov    %rdi,%rax
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  1003a5:	48 8b 57 f8          	mov    -0x8(%rdi),%rdx
  1003a9:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1003ad:	48 29 f2             	sub    %rsi,%rdx

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  1003b0:	48 83 fa 20          	cmp    $0x20,%rdx
  1003b4:	76 5b                	jbe    100411 <set_allocated+0x6f>
		PUT(HDRP(bp), PACK(size, 1));
  1003b6:	48 89 f1             	mov    %rsi,%rcx
  1003b9:	48 83 c9 01          	or     $0x1,%rcx
  1003bd:	48 89 4f f8          	mov    %rcx,-0x8(%rdi)

		void *leftover_mem_ptr = NEXT_BLKP(bp);
  1003c1:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  1003c5:	48 01 fe             	add    %rdi,%rsi

		PUT(HDRP(leftover_mem_ptr), PACK(extra_size, 0));	
  1003c8:	48 89 56 f8          	mov    %rdx,-0x8(%rsi)
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp); // pointers to the next free blocks
  1003cc:	48 8b 0f             	mov    (%rdi),%rcx
  1003cf:	48 89 0e             	mov    %rcx,(%rsi)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  1003d2:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  1003d6:	48 89 4e 08          	mov    %rcx,0x8(%rsi)
		PUT(FTRP(leftover_mem_ptr), PACK(extra_size, 0));	
  1003da:	48 89 d1             	mov    %rdx,%rcx
  1003dd:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  1003e1:	48 89 54 0e f0       	mov    %rdx,-0x10(%rsi,%rcx,1)

		// update the free list
		if (free_list == bp)
  1003e6:	48 39 3d 1b 20 00 00 	cmp    %rdi,0x201b(%rip)        # 102408 <free_list>
  1003ed:	74 19                	je     100408 <set_allocated+0x66>
			free_list = leftover_mem_ptr;

		if (PREV_FPTR(bp))
  1003ef:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1003f3:	48 85 d2             	test   %rdx,%rdx
  1003f6:	74 03                	je     1003fb <set_allocated+0x59>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  1003f8:	48 89 32             	mov    %rsi,(%rdx)

		if (NEXT_FPTR(bp))
  1003fb:	48 8b 00             	mov    (%rax),%rax
  1003fe:	48 85 c0             	test   %rax,%rax
  100401:	74 46                	je     100449 <set_allocated+0xa7>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  100403:	48 89 70 08          	mov    %rsi,0x8(%rax)
  100407:	c3                   	ret    
			free_list = leftover_mem_ptr;
  100408:	48 89 35 f9 1f 00 00 	mov    %rsi,0x1ff9(%rip)        # 102408 <free_list>
  10040f:	eb de                	jmp    1003ef <set_allocated+0x4d>
								    
	}
	else {
		// update the free list
		if (free_list == bp)
  100411:	48 39 3d f0 1f 00 00 	cmp    %rdi,0x1ff0(%rip)        # 102408 <free_list>
  100418:	74 30                	je     10044a <set_allocated+0xa8>
			free_list = NEXT_FPTR(bp);

		if (PREV_FPTR(bp))
  10041a:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10041e:	48 85 d2             	test   %rdx,%rdx
  100421:	74 06                	je     100429 <set_allocated+0x87>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  100423:	48 8b 08             	mov    (%rax),%rcx
  100426:	48 89 0a             	mov    %rcx,(%rdx)
		if (NEXT_FPTR(bp))
  100429:	48 8b 10             	mov    (%rax),%rdx
  10042c:	48 85 d2             	test   %rdx,%rdx
  10042f:	74 08                	je     100439 <set_allocated+0x97>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  100431:	48 8b 48 08          	mov    0x8(%rax),%rcx
  100435:	48 89 4a 08          	mov    %rcx,0x8(%rdx)

		PUT(HDRP(bp), PACK(GET_SIZE(HDRP(bp)), 1));	
  100439:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  10043d:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100441:	48 83 ca 01          	or     $0x1,%rdx
  100445:	48 89 50 f8          	mov    %rdx,-0x8(%rax)
	}
}
  100449:	c3                   	ret    
			free_list = NEXT_FPTR(bp);
  10044a:	48 8b 17             	mov    (%rdi),%rdx
  10044d:	48 89 15 b4 1f 00 00 	mov    %rdx,0x1fb4(%rip)        # 102408 <free_list>
  100454:	eb c4                	jmp    10041a <set_allocated+0x78>

0000000000100456 <malloc>:

void *malloc(uint64_t numbytes) {
  100456:	55                   	push   %rbp
  100457:	48 89 e5             	mov    %rsp,%rbp
  10045a:	41 55                	push   %r13
  10045c:	41 54                	push   %r12
  10045e:	53                   	push   %rbx
  10045f:	48 83 ec 08          	sub    $0x8,%rsp
  100463:	49 89 fc             	mov    %rdi,%r12
	if (!initialized_heap)
  100466:	83 3d ab 1f 00 00 00 	cmpl   $0x0,0x1fab(%rip)        # 102418 <initialized_heap>
  10046d:	74 73                	je     1004e2 <malloc+0x8c>
		heap_init();

	if (numbytes == 0)
  10046f:	4d 85 e4             	test   %r12,%r12
  100472:	0f 84 92 00 00 00    	je     10050a <malloc+0xb4>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  100478:	49 83 c4 17          	add    $0x17,%r12
  10047c:	49 83 e4 f0          	and    $0xfffffffffffffff0,%r12
  100480:	b8 20 00 00 00       	mov    $0x20,%eax
  100485:	49 39 c4             	cmp    %rax,%r12
  100488:	4c 0f 42 e0          	cmovb  %rax,%r12
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);
	
	void *bp = free_list;
  10048c:	48 8b 1d 75 1f 00 00 	mov    0x1f75(%rip),%rbx        # 102408 <free_list>
	while (bp) {
  100493:	48 85 db             	test   %rbx,%rbx
  100496:	74 15                	je     1004ad <malloc+0x57>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  100498:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  10049c:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  1004a0:	4c 39 e0             	cmp    %r12,%rax
  1004a3:	73 44                	jae    1004e9 <malloc+0x93>
			set_allocated(bp, aligned_size);
			num_allocs++;
			return bp;
		}

		bp = NEXT_FPTR(bp);
  1004a5:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  1004a8:	48 85 db             	test   %rbx,%rbx
  1004ab:	75 eb                	jne    100498 <malloc+0x42>
  1004ad:	bf 00 00 00 00       	mov    $0x0,%edi
  1004b2:	cd 3a                	int    $0x3a
  1004b4:	49 89 c5             	mov    %rax,%r13
  1004b7:	48 89 05 62 1f 00 00 	mov    %rax,0x1f62(%rip)        # 102420 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  1004be:	48 89 c3             	mov    %rax,%rbx
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	if (extend(aligned_size)) {
  1004c1:	4c 89 e7             	mov    %r12,%rdi
  1004c4:	e8 6d fe ff ff       	call   100336 <extend>
  1004c9:	85 c0                	test   %eax,%eax
  1004cb:	75 44                	jne    100511 <malloc+0xbb>
		return NULL;
	}
	set_allocated(bp, aligned_size);
  1004cd:	4c 89 e6             	mov    %r12,%rsi
  1004d0:	4c 89 ef             	mov    %r13,%rdi
  1004d3:	e8 ca fe ff ff       	call   1003a2 <set_allocated>
	num_allocs++;
  1004d8:	48 83 05 20 1f 00 00 	addq   $0x1,0x1f20(%rip)        # 102400 <num_allocs>
  1004df:	01 
    return bp;
  1004e0:	eb 1a                	jmp    1004fc <malloc+0xa6>
		heap_init();
  1004e2:	e8 92 fd ff ff       	call   100279 <heap_init>
  1004e7:	eb 86                	jmp    10046f <malloc+0x19>
			set_allocated(bp, aligned_size);
  1004e9:	4c 89 e6             	mov    %r12,%rsi
  1004ec:	48 89 df             	mov    %rbx,%rdi
  1004ef:	e8 ae fe ff ff       	call   1003a2 <set_allocated>
			num_allocs++;
  1004f4:	48 83 05 04 1f 00 00 	addq   $0x1,0x1f04(%rip)        # 102400 <num_allocs>
  1004fb:	01 
}
  1004fc:	48 89 d8             	mov    %rbx,%rax
  1004ff:	48 83 c4 08          	add    $0x8,%rsp
  100503:	5b                   	pop    %rbx
  100504:	41 5c                	pop    %r12
  100506:	41 5d                	pop    %r13
  100508:	5d                   	pop    %rbp
  100509:	c3                   	ret    
		return NULL;
  10050a:	bb 00 00 00 00       	mov    $0x0,%ebx
  10050f:	eb eb                	jmp    1004fc <malloc+0xa6>
		return NULL;
  100511:	bb 00 00 00 00       	mov    $0x0,%ebx
  100516:	eb e4                	jmp    1004fc <malloc+0xa6>

0000000000100518 <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  100518:	55                   	push   %rbp
  100519:	48 89 e5             	mov    %rsp,%rbp
  10051c:	41 54                	push   %r12
  10051e:	53                   	push   %rbx
	void *bp = malloc(num * sz);
  10051f:	48 0f af fe          	imul   %rsi,%rdi
  100523:	49 89 fc             	mov    %rdi,%r12
  100526:	e8 2b ff ff ff       	call   100456 <malloc>
  10052b:	48 89 c3             	mov    %rax,%rbx
	if (bp)							// protect against num=0 or size=0
  10052e:	48 85 c0             	test   %rax,%rax
  100531:	74 10                	je     100543 <calloc+0x2b>
		memset(bp, 0, num * sz);
  100533:	4c 89 e2             	mov    %r12,%rdx
  100536:	be 00 00 00 00       	mov    $0x0,%esi
  10053b:	48 89 c7             	mov    %rax,%rdi
  10053e:	e8 36 05 00 00       	call   100a79 <memset>
	return bp;
}
  100543:	48 89 d8             	mov    %rbx,%rax
  100546:	5b                   	pop    %rbx
  100547:	41 5c                	pop    %r12
  100549:	5d                   	pop    %rbp
  10054a:	c3                   	ret    

000000000010054b <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  10054b:	55                   	push   %rbp
  10054c:	48 89 e5             	mov    %rsp,%rbp
  10054f:	41 54                	push   %r12
  100551:	53                   	push   %rbx
  100552:	48 89 fb             	mov    %rdi,%rbx
  100555:	48 89 f7             	mov    %rsi,%rdi
	// first check if there's enough space in the block already (and that it's actually valid ptr)
	if (ptr && GET_SIZE(HDRP(ptr)) >= sz)
  100558:	48 85 db             	test   %rbx,%rbx
  10055b:	74 10                	je     10056d <realloc+0x22>
  10055d:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  100561:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
		return ptr;
  100565:	49 89 dc             	mov    %rbx,%r12
	if (ptr && GET_SIZE(HDRP(ptr)) >= sz)
  100568:	48 39 f0             	cmp    %rsi,%rax
  10056b:	73 23                	jae    100590 <realloc+0x45>

	// else find or add a big enough block, which is what malloc does
	void *bigger_ptr = malloc(sz);
  10056d:	e8 e4 fe ff ff       	call   100456 <malloc>
  100572:	49 89 c4             	mov    %rax,%r12
	memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
  100575:	48 8b 53 f8          	mov    -0x8(%rbx),%rdx
  100579:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  10057d:	48 89 de             	mov    %rbx,%rsi
  100580:	48 89 c7             	mov    %rax,%rdi
  100583:	e8 f3 03 00 00       	call   10097b <memcpy>
	free(ptr);
  100588:	48 89 df             	mov    %rbx,%rdi
  10058b:	e8 63 fd ff ff       	call   1002f3 <free>

    return bigger_ptr;
}
  100590:	4c 89 e0             	mov    %r12,%rax
  100593:	5b                   	pop    %rbx
  100594:	41 5c                	pop    %r12
  100596:	5d                   	pop    %rbp
  100597:	c3                   	ret    

0000000000100598 <defrag>:

void defrag() {
	void *fp = free_list;
  100598:	48 8b 05 69 1e 00 00 	mov    0x1e69(%rip),%rax        # 102408 <free_list>
	while (fp != NULL) {
  10059f:	48 85 c0             	test   %rax,%rax
  1005a2:	75 50                	jne    1005f4 <defrag+0x5c>
			PUT(FTRP(prev_block), PACK(GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp)), 0));	
		}

		fp = NEXT_FPTR(fp);
	}
}
  1005a4:	c3                   	ret    
				free_list = NEXT_FPTR(next_block);
  1005a5:	48 8b 0a             	mov    (%rdx),%rcx
  1005a8:	48 89 0d 59 1e 00 00 	mov    %rcx,0x1e59(%rip)        # 102408 <free_list>
  1005af:	eb 5d                	jmp    10060e <defrag+0x76>
			fp = NEXT_FPTR(fp);
  1005b1:	48 8b 00             	mov    (%rax),%rax
			continue;
  1005b4:	eb 39                	jmp    1005ef <defrag+0x57>
				free_list = NEXT_FPTR(fp);
  1005b6:	48 8b 08             	mov    (%rax),%rcx
  1005b9:	48 89 0d 48 1e 00 00 	mov    %rcx,0x1e48(%rip)        # 102408 <free_list>
  1005c0:	e9 d0 00 00 00       	jmp    100695 <defrag+0xfd>
			PUT(HDRP(prev_block), PACK(GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp)), 0));	
  1005c5:	48 8b 4a f8          	mov    -0x8(%rdx),%rcx
  1005c9:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  1005cd:	48 8b 70 f8          	mov    -0x8(%rax),%rsi
  1005d1:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  1005d5:	48 01 f1             	add    %rsi,%rcx
  1005d8:	48 89 4a f8          	mov    %rcx,-0x8(%rdx)
			PUT(FTRP(prev_block), PACK(GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp)), 0));	
  1005dc:	48 8b 70 f8          	mov    -0x8(%rax),%rsi
  1005e0:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  1005e4:	48 01 ce             	add    %rcx,%rsi
  1005e7:	48 89 74 0a f0       	mov    %rsi,-0x10(%rdx,%rcx,1)
		fp = NEXT_FPTR(fp);
  1005ec:	48 8b 00             	mov    (%rax),%rax
	while (fp != NULL) {
  1005ef:	48 85 c0             	test   %rax,%rax
  1005f2:	74 b0                	je     1005a4 <defrag+0xc>
		void *next_block = NEXT_BLKP(fp);
  1005f4:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1005f8:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1005fc:	48 01 c2             	add    %rax,%rdx
		if (!GET_ALLOC(HDRP(next_block))) {
  1005ff:	f6 42 f8 01          	testb  $0x1,-0x8(%rdx)
  100603:	75 4f                	jne    100654 <defrag+0xbc>
			if (free_list == next_block)
  100605:	48 39 15 fc 1d 00 00 	cmp    %rdx,0x1dfc(%rip)        # 102408 <free_list>
  10060c:	74 97                	je     1005a5 <defrag+0xd>
			if (PREV_FPTR(next_block)) 
  10060e:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  100612:	48 85 c9             	test   %rcx,%rcx
  100615:	74 06                	je     10061d <defrag+0x85>
				NEXT_FPTR(PREV_FPTR(next_block)) = NEXT_FPTR(next_block);
  100617:	48 8b 32             	mov    (%rdx),%rsi
  10061a:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(next_block)) 
  10061d:	48 8b 0a             	mov    (%rdx),%rcx
  100620:	48 85 c9             	test   %rcx,%rcx
  100623:	74 08                	je     10062d <defrag+0x95>
				PREV_FPTR(NEXT_FPTR(next_block)) = PREV_FPTR(next_block);
  100625:	48 8b 72 08          	mov    0x8(%rdx),%rsi
  100629:	48 89 71 08          	mov    %rsi,0x8(%rcx)
			PUT(HDRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  10062d:	48 8b 48 f8          	mov    -0x8(%rax),%rcx
  100631:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  100635:	48 8b 72 f8          	mov    -0x8(%rdx),%rsi
  100639:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  10063d:	48 01 f1             	add    %rsi,%rcx
  100640:	48 89 48 f8          	mov    %rcx,-0x8(%rax)
			PUT(FTRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  100644:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  100648:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  10064c:	48 01 ca             	add    %rcx,%rdx
  10064f:	48 89 54 08 f0       	mov    %rdx,-0x10(%rax,%rcx,1)
		void *prev_block = PREV_BLKP(fp);
  100654:	48 8b 48 f0          	mov    -0x10(%rax),%rcx
  100658:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  10065c:	48 89 c2             	mov    %rax,%rdx
  10065f:	48 29 ca             	sub    %rcx,%rdx
		if (GET_SIZE(HDRP(prev_block)) != GET_SIZE(FTRP(prev_block))){
  100662:	48 8b 4a f8          	mov    -0x8(%rdx),%rcx
  100666:	48 89 ce             	mov    %rcx,%rsi
  100669:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  10066d:	48 89 cf             	mov    %rcx,%rdi
  100670:	48 33 7c 32 f0       	xor    -0x10(%rdx,%rsi,1),%rdi
  100675:	48 83 ff 0f          	cmp    $0xf,%rdi
  100679:	0f 87 32 ff ff ff    	ja     1005b1 <defrag+0x19>
		if (!GET_ALLOC(HDRP(prev_block))) {
  10067f:	f6 c1 01             	test   $0x1,%cl
  100682:	0f 85 64 ff ff ff    	jne    1005ec <defrag+0x54>
			if (free_list == fp)
  100688:	48 39 05 79 1d 00 00 	cmp    %rax,0x1d79(%rip)        # 102408 <free_list>
  10068f:	0f 84 21 ff ff ff    	je     1005b6 <defrag+0x1e>
			if (PREV_FPTR(fp)) 
  100695:	48 8b 48 08          	mov    0x8(%rax),%rcx
  100699:	48 85 c9             	test   %rcx,%rcx
  10069c:	74 06                	je     1006a4 <defrag+0x10c>
				NEXT_FPTR(PREV_FPTR(fp)) = NEXT_FPTR(fp);
  10069e:	48 8b 30             	mov    (%rax),%rsi
  1006a1:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(fp)) 
  1006a4:	48 8b 08             	mov    (%rax),%rcx
  1006a7:	48 85 c9             	test   %rcx,%rcx
  1006aa:	0f 84 15 ff ff ff    	je     1005c5 <defrag+0x2d>
				PREV_FPTR(NEXT_FPTR(fp)) = PREV_FPTR(fp);
  1006b0:	48 8b 70 08          	mov    0x8(%rax),%rsi
  1006b4:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  1006b8:	e9 08 ff ff ff       	jmp    1005c5 <defrag+0x2d>

00000000001006bd <sift_down>:
// heap sort stuff that operates on the pointer array
#define LEFT_CHILD(x) (2*x + 1)
#define RIGHT_CHILD(x) (2*x + 2)
#define PARENT(x) ((x-1)/2)

void sift_down(void **arr, size_t pos, size_t arr_len) {
  1006bd:	48 89 f1             	mov    %rsi,%rcx
  1006c0:	49 89 d3             	mov    %rdx,%r11
	while(LEFT_CHILD(pos) < arr_len) {
  1006c3:	48 8d 74 36 01       	lea    0x1(%rsi,%rsi,1),%rsi
  1006c8:	48 39 d6             	cmp    %rdx,%rsi
  1006cb:	72 3a                	jb     100707 <sift_down+0x4a>
  1006cd:	c3                   	ret    
  1006ce:	48 89 f0             	mov    %rsi,%rax
		size_t smaller = LEFT_CHILD(pos);
		if (RIGHT_CHILD(pos) < arr_len && GET_SIZE(HDRP(arr[RIGHT_CHILD(pos)])) < GET_SIZE(HDRP(arr[LEFT_CHILD(pos)]))) 
			smaller = RIGHT_CHILD(pos);

		if (GET_SIZE(HDRP(arr[pos])) > GET_SIZE(HDRP(arr[smaller]))) {
  1006d1:	4c 8d 0c cf          	lea    (%rdi,%rcx,8),%r9
  1006d5:	4d 8b 01             	mov    (%r9),%r8
  1006d8:	48 8d 34 c7          	lea    (%rdi,%rax,8),%rsi
  1006dc:	4c 8b 16             	mov    (%rsi),%r10
  1006df:	49 8b 50 f8          	mov    -0x8(%r8),%rdx
  1006e3:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1006e7:	49 8b 4a f8          	mov    -0x8(%r10),%rcx
  1006eb:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  1006ef:	48 39 d1             	cmp    %rdx,%rcx
  1006f2:	73 46                	jae    10073a <sift_down+0x7d>
			void *temp = arr[pos];
			arr[pos] = arr[smaller];
  1006f4:	4d 89 11             	mov    %r10,(%r9)
			arr[smaller] = temp;
  1006f7:	4c 89 06             	mov    %r8,(%rsi)
	while(LEFT_CHILD(pos) < arr_len) {
  1006fa:	48 8d 74 00 01       	lea    0x1(%rax,%rax,1),%rsi
  1006ff:	4c 39 de             	cmp    %r11,%rsi
  100702:	73 36                	jae    10073a <sift_down+0x7d>
			pos = smaller;
  100704:	48 89 c1             	mov    %rax,%rcx
		if (RIGHT_CHILD(pos) < arr_len && GET_SIZE(HDRP(arr[RIGHT_CHILD(pos)])) < GET_SIZE(HDRP(arr[LEFT_CHILD(pos)]))) 
  100707:	48 8d 51 01          	lea    0x1(%rcx),%rdx
  10070b:	48 8d 04 12          	lea    (%rdx,%rdx,1),%rax
  10070f:	4c 39 d8             	cmp    %r11,%rax
  100712:	73 ba                	jae    1006ce <sift_down+0x11>
  100714:	48 c1 e2 04          	shl    $0x4,%rdx
  100718:	4c 8b 04 17          	mov    (%rdi,%rdx,1),%r8
  10071c:	4d 8b 40 f8          	mov    -0x8(%r8),%r8
  100720:	49 83 e0 f0          	and    $0xfffffffffffffff0,%r8
  100724:	48 8b 54 17 f8       	mov    -0x8(%rdi,%rdx,1),%rdx
  100729:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  10072d:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100731:	49 39 d0             	cmp    %rdx,%r8
  100734:	48 0f 43 c6          	cmovae %rsi,%rax
  100738:	eb 97                	jmp    1006d1 <sift_down+0x14>
		}
		else{
			break;
		}
	}	
}
  10073a:	c3                   	ret    

000000000010073b <heapify>:

void heapify(void **arr, size_t arr_len) {
  10073b:	55                   	push   %rbp
  10073c:	48 89 e5             	mov    %rsp,%rbp
  10073f:	41 56                	push   %r14
  100741:	41 55                	push   %r13
  100743:	41 54                	push   %r12
  100745:	53                   	push   %rbx
	int index = arr_len - 1;
	while(index >= 0) {
  100746:	41 89 f5             	mov    %esi,%r13d
  100749:	41 83 ed 01          	sub    $0x1,%r13d
  10074d:	78 28                	js     100777 <heapify+0x3c>
  10074f:	49 89 fe             	mov    %rdi,%r14
  100752:	49 89 f4             	mov    %rsi,%r12
  100755:	49 63 c5             	movslq %r13d,%rax
  100758:	48 89 c3             	mov    %rax,%rbx
  10075b:	41 29 c5             	sub    %eax,%r13d
		sift_down(arr, index, arr_len);	
  10075e:	4c 89 e2             	mov    %r12,%rdx
  100761:	48 89 de             	mov    %rbx,%rsi
  100764:	4c 89 f7             	mov    %r14,%rdi
  100767:	e8 51 ff ff ff       	call   1006bd <sift_down>
	while(index >= 0) {
  10076c:	48 83 eb 01          	sub    $0x1,%rbx
  100770:	44 89 e8             	mov    %r13d,%eax
  100773:	01 d8                	add    %ebx,%eax
  100775:	79 e7                	jns    10075e <heapify+0x23>
		index--;
	}
}
  100777:	5b                   	pop    %rbx
  100778:	41 5c                	pop    %r12
  10077a:	41 5d                	pop    %r13
  10077c:	41 5e                	pop    %r14
  10077e:	5d                   	pop    %rbp
  10077f:	c3                   	ret    

0000000000100780 <heapsort>:

void heapsort(void **arr, size_t arr_len) {
  100780:	55                   	push   %rbp
  100781:	48 89 e5             	mov    %rsp,%rbp
  100784:	41 54                	push   %r12
  100786:	53                   	push   %rbx
  100787:	49 89 fc             	mov    %rdi,%r12
  10078a:	48 89 f3             	mov    %rsi,%rbx
	heapify(arr, arr_len);
  10078d:	e8 a9 ff ff ff       	call   10073b <heapify>
	if (arr_len == 0)
  100792:	48 85 db             	test   %rbx,%rbx
  100795:	74 34                	je     1007cb <heapsort+0x4b>
		return;
	for (size_t i = arr_len - 1; i > 1; i--) {
  100797:	48 83 eb 01          	sub    $0x1,%rbx
  10079b:	48 83 fb 01          	cmp    $0x1,%rbx
  10079f:	76 2a                	jbe    1007cb <heapsort+0x4b>
		void *temp = arr[0];
  1007a1:	49 8b 04 24          	mov    (%r12),%rax
		arr[0] = arr[i];
  1007a5:	49 8b 14 dc          	mov    (%r12,%rbx,8),%rdx
  1007a9:	49 89 14 24          	mov    %rdx,(%r12)
		arr[i] = temp;
  1007ad:	49 89 04 dc          	mov    %rax,(%r12,%rbx,8)
		sift_down(arr, 0, i);
  1007b1:	48 89 da             	mov    %rbx,%rdx
  1007b4:	be 00 00 00 00       	mov    $0x0,%esi
  1007b9:	4c 89 e7             	mov    %r12,%rdi
  1007bc:	e8 fc fe ff ff       	call   1006bd <sift_down>
	for (size_t i = arr_len - 1; i > 1; i--) {
  1007c1:	48 83 eb 01          	sub    $0x1,%rbx
  1007c5:	48 83 fb 01          	cmp    $0x1,%rbx
  1007c9:	75 d6                	jne    1007a1 <heapsort+0x21>
	}
}
  1007cb:	5b                   	pop    %rbx
  1007cc:	41 5c                	pop    %r12
  1007ce:	5d                   	pop    %rbp
  1007cf:	c3                   	ret    

00000000001007d0 <heap_info>:

int heap_info(heap_info_struct *info) {
  1007d0:	55                   	push   %rbp
  1007d1:	48 89 e5             	mov    %rsp,%rbp
  1007d4:	53                   	push   %rbx
  1007d5:	48 83 ec 08          	sub    $0x8,%rsp
  1007d9:	48 89 fb             	mov    %rdi,%rbx
	info->num_allocs = num_allocs+2;		// +2 for the two arrays we need
  1007dc:	8b 05 1e 1c 00 00    	mov    0x1c1e(%rip),%eax        # 102400 <num_allocs>
  1007e2:	83 c0 02             	add    $0x2,%eax
  1007e5:	89 07                	mov    %eax,(%rdi)
	info->free_space = 0;
  1007e7:	c7 47 18 00 00 00 00 	movl   $0x0,0x18(%rdi)
	info->largest_free_chunk = 0;
  1007ee:	c7 47 1c 00 00 00 00 	movl   $0x0,0x1c(%rdi)

	info->size_array = sbrk(ALIGN(info->num_allocs * sizeof(long) + OVERHEAD));
  1007f5:	48 98                	cltq   
  1007f7:	48 8d 3c c5 17 00 00 	lea    0x17(,%rax,8),%rdi
  1007fe:	00 
  1007ff:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
    asm volatile ("int %1" :  "=a" (result)
  100803:	cd 3a                	int    $0x3a
  100805:	48 89 05 14 1c 00 00 	mov    %rax,0x1c14(%rip)        # 102420 <result.0>
  10080c:	48 89 43 08          	mov    %rax,0x8(%rbx)
	if (info->ptr_array == (void *)-1) { // nothing happens on failure
  100810:	48 83 7b 10 ff       	cmpq   $0xffffffffffffffff,0x10(%rbx)
  100815:	0f 84 52 01 00 00    	je     10096d <heap_info+0x19d>
		return -1;
	}
	info->ptr_array = sbrk(ALIGN(info->num_allocs * sizeof(void *) + OVERHEAD));
  10081b:	48 63 03             	movslq (%rbx),%rax
  10081e:	48 8d 3c c5 17 00 00 	lea    0x17(,%rax,8),%rdi
  100825:	00 
  100826:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
  10082a:	cd 3a                	int    $0x3a
  10082c:	48 89 05 ed 1b 00 00 	mov    %rax,0x1bed(%rip)        # 102420 <result.0>
  100833:	48 89 43 10          	mov    %rax,0x10(%rbx)
	if (info->ptr_array == (void *)-1) {
  100837:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  10083b:	74 72                	je     1008af <heap_info+0xdf>
		sbrk(-ALIGN(info->num_allocs * sizeof(long) + OVERHEAD));
		return -1;
	}

	// we manually fill in array metadata
	PUT(HDRP(info->size_array), PACK(ALIGN(info->num_allocs * sizeof(long) + OVERHEAD), 1));
  10083d:	48 8b 53 08          	mov    0x8(%rbx),%rdx
  100841:	48 63 03             	movslq (%rbx),%rax
  100844:	48 8d 04 c5 17 00 00 	lea    0x17(,%rax,8),%rax
  10084b:	00 
  10084c:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100850:	48 83 c8 01          	or     $0x1,%rax
  100854:	48 89 42 f8          	mov    %rax,-0x8(%rdx)
	PUT(HDRP(info->ptr_array), PACK(ALIGN(info->num_allocs * sizeof(void *) + OVERHEAD), 1));
  100858:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  10085c:	48 63 03             	movslq (%rbx),%rax
  10085f:	48 8d 04 c5 17 00 00 	lea    0x17(,%rax,8),%rax
  100866:	00 
  100867:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  10086b:	48 83 c8 01          	or     $0x1,%rax
  10086f:	48 89 42 f8          	mov    %rax,-0x8(%rdx)

	// terminal block
	PUT(HDRP(NEXT_BLKP(info->ptr_array)), PACK(0, 1));
  100873:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  100877:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  10087b:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  10087f:	48 c7 44 02 f8 01 00 	movq   $0x1,-0x8(%rdx,%rax,1)
  100886:	00 00 

	// collect all the information by traversing through the heap
	void *bp = NEXT_BLKP(prologue_block); // because the prologue isn't actually allocated
  100888:	48 8b 05 81 1b 00 00 	mov    0x1b81(%rip),%rax        # 102410 <prologue_block>
  10088f:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  100893:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100897:	48 01 d0             	add    %rdx,%rax
	size_t arr_index = 0;
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  10089a:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  10089e:	48 83 fa 0f          	cmp    $0xf,%rdx
  1008a2:	0f 86 84 00 00 00    	jbe    10092c <heap_info+0x15c>
	size_t arr_index = 0;
  1008a8:	b9 00 00 00 00       	mov    $0x0,%ecx
  1008ad:	eb 5a                	jmp    100909 <heap_info+0x139>
		sbrk(-ALIGN(info->num_allocs * sizeof(long) + OVERHEAD));
  1008af:	48 63 03             	movslq (%rbx),%rax
  1008b2:	48 8d 3c c5 17 00 00 	lea    0x17(,%rax,8),%rdi
  1008b9:	00 
  1008ba:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
  1008be:	48 f7 df             	neg    %rdi
  1008c1:	cd 3a                	int    $0x3a
  1008c3:	48 89 05 56 1b 00 00 	mov    %rax,0x1b56(%rip)        # 102420 <result.0>
		return -1;
  1008ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1008cf:	e9 93 00 00 00       	jmp    100967 <heap_info+0x197>
			info->ptr_array[arr_index] = bp;
			info->size_array[arr_index] = GET_SIZE(HDRP(bp));
			arr_index++;
		}
		else {
			info->free_space += GET_SIZE(HDRP(bp));
  1008d4:	83 e2 f0             	and    $0xfffffff0,%edx
  1008d7:	01 53 18             	add    %edx,0x18(%rbx)
			if(GET_SIZE(HDRP(bp)) > (size_t) (info->largest_free_chunk)) {
  1008da:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1008de:	48 89 d6             	mov    %rdx,%rsi
  1008e1:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  1008e5:	48 63 7b 1c          	movslq 0x1c(%rbx),%rdi
  1008e9:	48 39 f7             	cmp    %rsi,%rdi
  1008ec:	73 06                	jae    1008f4 <heap_info+0x124>
				info->largest_free_chunk = GET_SIZE(HDRP(bp));
  1008ee:	83 e2 f0             	and    $0xfffffff0,%edx
  1008f1:	89 53 1c             	mov    %edx,0x1c(%rbx)
			}
		}

		bp = NEXT_BLKP(bp);
  1008f4:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1008f8:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1008fc:	48 01 d0             	add    %rdx,%rax
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  1008ff:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  100903:	48 83 fa 0f          	cmp    $0xf,%rdx
  100907:	76 23                	jbe    10092c <heap_info+0x15c>
		if (GET_ALLOC(HDRP(bp))) {
  100909:	f6 c2 01             	test   $0x1,%dl
  10090c:	74 c6                	je     1008d4 <heap_info+0x104>
			info->ptr_array[arr_index] = bp;
  10090e:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  100912:	48 89 04 ca          	mov    %rax,(%rdx,%rcx,8)
			info->size_array[arr_index] = GET_SIZE(HDRP(bp));
  100916:	48 8b 73 08          	mov    0x8(%rbx),%rsi
  10091a:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  10091e:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100922:	48 89 14 ce          	mov    %rdx,(%rsi,%rcx,8)
			arr_index++;
  100926:	48 83 c1 01          	add    $0x1,%rcx
  10092a:	eb c8                	jmp    1008f4 <heap_info+0x124>
	}

	// we just need to sort the arrays...
	// we'll use heapsort
	heapsort(info->ptr_array, info->num_allocs);
  10092c:	48 63 33             	movslq (%rbx),%rsi
  10092f:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
  100933:	e8 48 fe ff ff       	call   100780 <heapsort>
	for (int i = 0; i < info->num_allocs; i++)
  100938:	83 3b 00             	cmpl   $0x0,(%rbx)
  10093b:	7e 37                	jle    100974 <heap_info+0x1a4>
  10093d:	b8 00 00 00 00       	mov    $0x0,%eax
		info->size_array[i] = GET_SIZE(HDRP(info->ptr_array[i]));
  100942:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
  100946:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  10094a:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
  10094e:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  100952:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100956:	48 89 14 c1          	mov    %rdx,(%rcx,%rax,8)
	for (int i = 0; i < info->num_allocs; i++)
  10095a:	48 83 c0 01          	add    $0x1,%rax
  10095e:	39 03                	cmp    %eax,(%rbx)
  100960:	7f e0                	jg     100942 <heap_info+0x172>

    return 0;
  100962:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100967:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  10096b:	c9                   	leave  
  10096c:	c3                   	ret    
		return -1;
  10096d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100972:	eb f3                	jmp    100967 <heap_info+0x197>
    return 0;
  100974:	b8 00 00 00 00       	mov    $0x0,%eax
  100979:	eb ec                	jmp    100967 <heap_info+0x197>

000000000010097b <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  10097b:	55                   	push   %rbp
  10097c:	48 89 e5             	mov    %rsp,%rbp
  10097f:	48 83 ec 28          	sub    $0x28,%rsp
  100983:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100987:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10098b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10098f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100993:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100997:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10099b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  10099f:	eb 1c                	jmp    1009bd <memcpy+0x42>
        *d = *s;
  1009a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009a5:	0f b6 10             	movzbl (%rax),%edx
  1009a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1009ac:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1009ae:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1009b3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1009b8:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1009bd:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1009c2:	75 dd                	jne    1009a1 <memcpy+0x26>
    }
    return dst;
  1009c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1009c8:	c9                   	leave  
  1009c9:	c3                   	ret    

00000000001009ca <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1009ca:	55                   	push   %rbp
  1009cb:	48 89 e5             	mov    %rsp,%rbp
  1009ce:	48 83 ec 28          	sub    $0x28,%rsp
  1009d2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1009d6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1009da:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1009de:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1009e2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  1009e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1009ea:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  1009ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009f2:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  1009f6:	73 6a                	jae    100a62 <memmove+0x98>
  1009f8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1009fc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100a00:	48 01 d0             	add    %rdx,%rax
  100a03:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100a07:	73 59                	jae    100a62 <memmove+0x98>
        s += n, d += n;
  100a09:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100a0d:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100a11:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100a15:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  100a19:	eb 17                	jmp    100a32 <memmove+0x68>
            *--d = *--s;
  100a1b:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100a20:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100a25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a29:	0f b6 10             	movzbl (%rax),%edx
  100a2c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100a30:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100a32:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100a36:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100a3a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100a3e:	48 85 c0             	test   %rax,%rax
  100a41:	75 d8                	jne    100a1b <memmove+0x51>
    if (s < d && s + n > d) {
  100a43:	eb 2e                	jmp    100a73 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100a45:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100a49:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100a4d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100a51:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100a55:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100a59:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100a5d:	0f b6 12             	movzbl (%rdx),%edx
  100a60:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100a62:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100a66:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100a6a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100a6e:	48 85 c0             	test   %rax,%rax
  100a71:	75 d2                	jne    100a45 <memmove+0x7b>
        }
    }
    return dst;
  100a73:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100a77:	c9                   	leave  
  100a78:	c3                   	ret    

0000000000100a79 <memset>:

void* memset(void* v, int c, size_t n) {
  100a79:	55                   	push   %rbp
  100a7a:	48 89 e5             	mov    %rsp,%rbp
  100a7d:	48 83 ec 28          	sub    $0x28,%rsp
  100a81:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100a85:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100a88:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100a8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100a90:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100a94:	eb 15                	jmp    100aab <memset+0x32>
        *p = c;
  100a96:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100a99:	89 c2                	mov    %eax,%edx
  100a9b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a9f:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100aa1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100aa6:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100aab:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100ab0:	75 e4                	jne    100a96 <memset+0x1d>
    }
    return v;
  100ab2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100ab6:	c9                   	leave  
  100ab7:	c3                   	ret    

0000000000100ab8 <strlen>:

size_t strlen(const char* s) {
  100ab8:	55                   	push   %rbp
  100ab9:	48 89 e5             	mov    %rsp,%rbp
  100abc:	48 83 ec 18          	sub    $0x18,%rsp
  100ac0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100ac4:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100acb:	00 
  100acc:	eb 0a                	jmp    100ad8 <strlen+0x20>
        ++n;
  100ace:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100ad3:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100ad8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100adc:	0f b6 00             	movzbl (%rax),%eax
  100adf:	84 c0                	test   %al,%al
  100ae1:	75 eb                	jne    100ace <strlen+0x16>
    }
    return n;
  100ae3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100ae7:	c9                   	leave  
  100ae8:	c3                   	ret    

0000000000100ae9 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100ae9:	55                   	push   %rbp
  100aea:	48 89 e5             	mov    %rsp,%rbp
  100aed:	48 83 ec 20          	sub    $0x20,%rsp
  100af1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100af5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100af9:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100b00:	00 
  100b01:	eb 0a                	jmp    100b0d <strnlen+0x24>
        ++n;
  100b03:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100b08:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100b0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b11:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100b15:	74 0b                	je     100b22 <strnlen+0x39>
  100b17:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100b1b:	0f b6 00             	movzbl (%rax),%eax
  100b1e:	84 c0                	test   %al,%al
  100b20:	75 e1                	jne    100b03 <strnlen+0x1a>
    }
    return n;
  100b22:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100b26:	c9                   	leave  
  100b27:	c3                   	ret    

0000000000100b28 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100b28:	55                   	push   %rbp
  100b29:	48 89 e5             	mov    %rsp,%rbp
  100b2c:	48 83 ec 20          	sub    $0x20,%rsp
  100b30:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100b34:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  100b38:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100b3c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100b40:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100b44:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100b48:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100b4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b50:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100b54:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100b58:	0f b6 12             	movzbl (%rdx),%edx
  100b5b:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100b5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b61:	48 83 e8 01          	sub    $0x1,%rax
  100b65:	0f b6 00             	movzbl (%rax),%eax
  100b68:	84 c0                	test   %al,%al
  100b6a:	75 d4                	jne    100b40 <strcpy+0x18>
    return dst;
  100b6c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100b70:	c9                   	leave  
  100b71:	c3                   	ret    

0000000000100b72 <strcmp>:

int strcmp(const char* a, const char* b) {
  100b72:	55                   	push   %rbp
  100b73:	48 89 e5             	mov    %rsp,%rbp
  100b76:	48 83 ec 10          	sub    $0x10,%rsp
  100b7a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100b7e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100b82:	eb 0a                	jmp    100b8e <strcmp+0x1c>
        ++a, ++b;
  100b84:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100b89:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100b8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b92:	0f b6 00             	movzbl (%rax),%eax
  100b95:	84 c0                	test   %al,%al
  100b97:	74 1d                	je     100bb6 <strcmp+0x44>
  100b99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100b9d:	0f b6 00             	movzbl (%rax),%eax
  100ba0:	84 c0                	test   %al,%al
  100ba2:	74 12                	je     100bb6 <strcmp+0x44>
  100ba4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100ba8:	0f b6 10             	movzbl (%rax),%edx
  100bab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100baf:	0f b6 00             	movzbl (%rax),%eax
  100bb2:	38 c2                	cmp    %al,%dl
  100bb4:	74 ce                	je     100b84 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100bb6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100bba:	0f b6 00             	movzbl (%rax),%eax
  100bbd:	89 c2                	mov    %eax,%edx
  100bbf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100bc3:	0f b6 00             	movzbl (%rax),%eax
  100bc6:	38 d0                	cmp    %dl,%al
  100bc8:	0f 92 c0             	setb   %al
  100bcb:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100bce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100bd2:	0f b6 00             	movzbl (%rax),%eax
  100bd5:	89 c1                	mov    %eax,%ecx
  100bd7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100bdb:	0f b6 00             	movzbl (%rax),%eax
  100bde:	38 c1                	cmp    %al,%cl
  100be0:	0f 92 c0             	setb   %al
  100be3:	0f b6 c0             	movzbl %al,%eax
  100be6:	29 c2                	sub    %eax,%edx
  100be8:	89 d0                	mov    %edx,%eax
}
  100bea:	c9                   	leave  
  100beb:	c3                   	ret    

0000000000100bec <strchr>:

char* strchr(const char* s, int c) {
  100bec:	55                   	push   %rbp
  100bed:	48 89 e5             	mov    %rsp,%rbp
  100bf0:	48 83 ec 10          	sub    $0x10,%rsp
  100bf4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100bf8:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100bfb:	eb 05                	jmp    100c02 <strchr+0x16>
        ++s;
  100bfd:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100c02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c06:	0f b6 00             	movzbl (%rax),%eax
  100c09:	84 c0                	test   %al,%al
  100c0b:	74 0e                	je     100c1b <strchr+0x2f>
  100c0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c11:	0f b6 00             	movzbl (%rax),%eax
  100c14:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100c17:	38 d0                	cmp    %dl,%al
  100c19:	75 e2                	jne    100bfd <strchr+0x11>
    }
    if (*s == (char) c) {
  100c1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c1f:	0f b6 00             	movzbl (%rax),%eax
  100c22:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100c25:	38 d0                	cmp    %dl,%al
  100c27:	75 06                	jne    100c2f <strchr+0x43>
        return (char*) s;
  100c29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c2d:	eb 05                	jmp    100c34 <strchr+0x48>
    } else {
        return NULL;
  100c2f:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100c34:	c9                   	leave  
  100c35:	c3                   	ret    

0000000000100c36 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100c36:	55                   	push   %rbp
  100c37:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  100c3a:	8b 05 e8 17 00 00    	mov    0x17e8(%rip),%eax        # 102428 <rand_seed_set>
  100c40:	85 c0                	test   %eax,%eax
  100c42:	75 0a                	jne    100c4e <rand+0x18>
        srand(819234718U);
  100c44:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100c49:	e8 24 00 00 00       	call   100c72 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100c4e:	8b 05 d8 17 00 00    	mov    0x17d8(%rip),%eax        # 10242c <rand_seed>
  100c54:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100c5a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100c5f:	89 05 c7 17 00 00    	mov    %eax,0x17c7(%rip)        # 10242c <rand_seed>
    return rand_seed & RAND_MAX;
  100c65:	8b 05 c1 17 00 00    	mov    0x17c1(%rip),%eax        # 10242c <rand_seed>
  100c6b:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100c70:	5d                   	pop    %rbp
  100c71:	c3                   	ret    

0000000000100c72 <srand>:

void srand(unsigned seed) {
  100c72:	55                   	push   %rbp
  100c73:	48 89 e5             	mov    %rsp,%rbp
  100c76:	48 83 ec 08          	sub    $0x8,%rsp
  100c7a:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100c7d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100c80:	89 05 a6 17 00 00    	mov    %eax,0x17a6(%rip)        # 10242c <rand_seed>
    rand_seed_set = 1;
  100c86:	c7 05 98 17 00 00 01 	movl   $0x1,0x1798(%rip)        # 102428 <rand_seed_set>
  100c8d:	00 00 00 
}
  100c90:	90                   	nop
  100c91:	c9                   	leave  
  100c92:	c3                   	ret    

0000000000100c93 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100c93:	55                   	push   %rbp
  100c94:	48 89 e5             	mov    %rsp,%rbp
  100c97:	48 83 ec 28          	sub    $0x28,%rsp
  100c9b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100c9f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100ca3:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100ca6:	48 c7 45 f8 60 1c 10 	movq   $0x101c60,-0x8(%rbp)
  100cad:	00 
    if (base < 0) {
  100cae:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100cb2:	79 0b                	jns    100cbf <fill_numbuf+0x2c>
        digits = lower_digits;
  100cb4:	48 c7 45 f8 80 1c 10 	movq   $0x101c80,-0x8(%rbp)
  100cbb:	00 
        base = -base;
  100cbc:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100cbf:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100cc4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100cc8:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100ccb:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100cce:	48 63 c8             	movslq %eax,%rcx
  100cd1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100cd5:	ba 00 00 00 00       	mov    $0x0,%edx
  100cda:	48 f7 f1             	div    %rcx
  100cdd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100ce1:	48 01 d0             	add    %rdx,%rax
  100ce4:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100ce9:	0f b6 10             	movzbl (%rax),%edx
  100cec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100cf0:	88 10                	mov    %dl,(%rax)
        val /= base;
  100cf2:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100cf5:	48 63 f0             	movslq %eax,%rsi
  100cf8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100cfc:	ba 00 00 00 00       	mov    $0x0,%edx
  100d01:	48 f7 f6             	div    %rsi
  100d04:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100d08:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100d0d:	75 bc                	jne    100ccb <fill_numbuf+0x38>
    return numbuf_end;
  100d0f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100d13:	c9                   	leave  
  100d14:	c3                   	ret    

0000000000100d15 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100d15:	55                   	push   %rbp
  100d16:	48 89 e5             	mov    %rsp,%rbp
  100d19:	53                   	push   %rbx
  100d1a:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100d21:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100d28:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100d2e:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100d35:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100d3c:	e9 8a 09 00 00       	jmp    1016cb <printer_vprintf+0x9b6>
        if (*format != '%') {
  100d41:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d48:	0f b6 00             	movzbl (%rax),%eax
  100d4b:	3c 25                	cmp    $0x25,%al
  100d4d:	74 31                	je     100d80 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  100d4f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d56:	4c 8b 00             	mov    (%rax),%r8
  100d59:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d60:	0f b6 00             	movzbl (%rax),%eax
  100d63:	0f b6 c8             	movzbl %al,%ecx
  100d66:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100d6c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d73:	89 ce                	mov    %ecx,%esi
  100d75:	48 89 c7             	mov    %rax,%rdi
  100d78:	41 ff d0             	call   *%r8
            continue;
  100d7b:	e9 43 09 00 00       	jmp    1016c3 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100d80:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100d87:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100d8e:	01 
  100d8f:	eb 44                	jmp    100dd5 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  100d91:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d98:	0f b6 00             	movzbl (%rax),%eax
  100d9b:	0f be c0             	movsbl %al,%eax
  100d9e:	89 c6                	mov    %eax,%esi
  100da0:	bf 80 1a 10 00       	mov    $0x101a80,%edi
  100da5:	e8 42 fe ff ff       	call   100bec <strchr>
  100daa:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100dae:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100db3:	74 30                	je     100de5 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  100db5:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100db9:	48 2d 80 1a 10 00    	sub    $0x101a80,%rax
  100dbf:	ba 01 00 00 00       	mov    $0x1,%edx
  100dc4:	89 c1                	mov    %eax,%ecx
  100dc6:	d3 e2                	shl    %cl,%edx
  100dc8:	89 d0                	mov    %edx,%eax
  100dca:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100dcd:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100dd4:	01 
  100dd5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ddc:	0f b6 00             	movzbl (%rax),%eax
  100ddf:	84 c0                	test   %al,%al
  100de1:	75 ae                	jne    100d91 <printer_vprintf+0x7c>
  100de3:	eb 01                	jmp    100de6 <printer_vprintf+0xd1>
            } else {
                break;
  100de5:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100de6:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100ded:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100df4:	0f b6 00             	movzbl (%rax),%eax
  100df7:	3c 30                	cmp    $0x30,%al
  100df9:	7e 67                	jle    100e62 <printer_vprintf+0x14d>
  100dfb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e02:	0f b6 00             	movzbl (%rax),%eax
  100e05:	3c 39                	cmp    $0x39,%al
  100e07:	7f 59                	jg     100e62 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100e09:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100e10:	eb 2e                	jmp    100e40 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100e12:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100e15:	89 d0                	mov    %edx,%eax
  100e17:	c1 e0 02             	shl    $0x2,%eax
  100e1a:	01 d0                	add    %edx,%eax
  100e1c:	01 c0                	add    %eax,%eax
  100e1e:	89 c1                	mov    %eax,%ecx
  100e20:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e27:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100e2b:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100e32:	0f b6 00             	movzbl (%rax),%eax
  100e35:	0f be c0             	movsbl %al,%eax
  100e38:	01 c8                	add    %ecx,%eax
  100e3a:	83 e8 30             	sub    $0x30,%eax
  100e3d:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100e40:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e47:	0f b6 00             	movzbl (%rax),%eax
  100e4a:	3c 2f                	cmp    $0x2f,%al
  100e4c:	0f 8e 85 00 00 00    	jle    100ed7 <printer_vprintf+0x1c2>
  100e52:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e59:	0f b6 00             	movzbl (%rax),%eax
  100e5c:	3c 39                	cmp    $0x39,%al
  100e5e:	7e b2                	jle    100e12 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100e60:	eb 75                	jmp    100ed7 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100e62:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e69:	0f b6 00             	movzbl (%rax),%eax
  100e6c:	3c 2a                	cmp    $0x2a,%al
  100e6e:	75 68                	jne    100ed8 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100e70:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e77:	8b 00                	mov    (%rax),%eax
  100e79:	83 f8 2f             	cmp    $0x2f,%eax
  100e7c:	77 30                	ja     100eae <printer_vprintf+0x199>
  100e7e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e85:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e89:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e90:	8b 00                	mov    (%rax),%eax
  100e92:	89 c0                	mov    %eax,%eax
  100e94:	48 01 d0             	add    %rdx,%rax
  100e97:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e9e:	8b 12                	mov    (%rdx),%edx
  100ea0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ea3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100eaa:	89 0a                	mov    %ecx,(%rdx)
  100eac:	eb 1a                	jmp    100ec8 <printer_vprintf+0x1b3>
  100eae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100eb5:	48 8b 40 08          	mov    0x8(%rax),%rax
  100eb9:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ebd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ec4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ec8:	8b 00                	mov    (%rax),%eax
  100eca:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100ecd:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ed4:	01 
  100ed5:	eb 01                	jmp    100ed8 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100ed7:	90                   	nop
        }

        // process precision
        int precision = -1;
  100ed8:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100edf:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ee6:	0f b6 00             	movzbl (%rax),%eax
  100ee9:	3c 2e                	cmp    $0x2e,%al
  100eeb:	0f 85 00 01 00 00    	jne    100ff1 <printer_vprintf+0x2dc>
            ++format;
  100ef1:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ef8:	01 
            if (*format >= '0' && *format <= '9') {
  100ef9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f00:	0f b6 00             	movzbl (%rax),%eax
  100f03:	3c 2f                	cmp    $0x2f,%al
  100f05:	7e 67                	jle    100f6e <printer_vprintf+0x259>
  100f07:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f0e:	0f b6 00             	movzbl (%rax),%eax
  100f11:	3c 39                	cmp    $0x39,%al
  100f13:	7f 59                	jg     100f6e <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100f15:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100f1c:	eb 2e                	jmp    100f4c <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100f1e:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100f21:	89 d0                	mov    %edx,%eax
  100f23:	c1 e0 02             	shl    $0x2,%eax
  100f26:	01 d0                	add    %edx,%eax
  100f28:	01 c0                	add    %eax,%eax
  100f2a:	89 c1                	mov    %eax,%ecx
  100f2c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f33:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100f37:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100f3e:	0f b6 00             	movzbl (%rax),%eax
  100f41:	0f be c0             	movsbl %al,%eax
  100f44:	01 c8                	add    %ecx,%eax
  100f46:	83 e8 30             	sub    $0x30,%eax
  100f49:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100f4c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f53:	0f b6 00             	movzbl (%rax),%eax
  100f56:	3c 2f                	cmp    $0x2f,%al
  100f58:	0f 8e 85 00 00 00    	jle    100fe3 <printer_vprintf+0x2ce>
  100f5e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f65:	0f b6 00             	movzbl (%rax),%eax
  100f68:	3c 39                	cmp    $0x39,%al
  100f6a:	7e b2                	jle    100f1e <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100f6c:	eb 75                	jmp    100fe3 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100f6e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f75:	0f b6 00             	movzbl (%rax),%eax
  100f78:	3c 2a                	cmp    $0x2a,%al
  100f7a:	75 68                	jne    100fe4 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100f7c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f83:	8b 00                	mov    (%rax),%eax
  100f85:	83 f8 2f             	cmp    $0x2f,%eax
  100f88:	77 30                	ja     100fba <printer_vprintf+0x2a5>
  100f8a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f91:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100f95:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f9c:	8b 00                	mov    (%rax),%eax
  100f9e:	89 c0                	mov    %eax,%eax
  100fa0:	48 01 d0             	add    %rdx,%rax
  100fa3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100faa:	8b 12                	mov    (%rdx),%edx
  100fac:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100faf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fb6:	89 0a                	mov    %ecx,(%rdx)
  100fb8:	eb 1a                	jmp    100fd4 <printer_vprintf+0x2bf>
  100fba:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fc1:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fc5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100fc9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fd0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100fd4:	8b 00                	mov    (%rax),%eax
  100fd6:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100fd9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100fe0:	01 
  100fe1:	eb 01                	jmp    100fe4 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100fe3:	90                   	nop
            }
            if (precision < 0) {
  100fe4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100fe8:	79 07                	jns    100ff1 <printer_vprintf+0x2dc>
                precision = 0;
  100fea:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100ff1:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100ff8:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100fff:	00 
        int length = 0;
  101000:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  101007:	48 c7 45 c8 86 1a 10 	movq   $0x101a86,-0x38(%rbp)
  10100e:	00 
    again:
        switch (*format) {
  10100f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101016:	0f b6 00             	movzbl (%rax),%eax
  101019:	0f be c0             	movsbl %al,%eax
  10101c:	83 e8 43             	sub    $0x43,%eax
  10101f:	83 f8 37             	cmp    $0x37,%eax
  101022:	0f 87 9f 03 00 00    	ja     1013c7 <printer_vprintf+0x6b2>
  101028:	89 c0                	mov    %eax,%eax
  10102a:	48 8b 04 c5 98 1a 10 	mov    0x101a98(,%rax,8),%rax
  101031:	00 
  101032:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  101034:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  10103b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101042:	01 
            goto again;
  101043:	eb ca                	jmp    10100f <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  101045:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  101049:	74 5d                	je     1010a8 <printer_vprintf+0x393>
  10104b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101052:	8b 00                	mov    (%rax),%eax
  101054:	83 f8 2f             	cmp    $0x2f,%eax
  101057:	77 30                	ja     101089 <printer_vprintf+0x374>
  101059:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101060:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101064:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10106b:	8b 00                	mov    (%rax),%eax
  10106d:	89 c0                	mov    %eax,%eax
  10106f:	48 01 d0             	add    %rdx,%rax
  101072:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101079:	8b 12                	mov    (%rdx),%edx
  10107b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10107e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101085:	89 0a                	mov    %ecx,(%rdx)
  101087:	eb 1a                	jmp    1010a3 <printer_vprintf+0x38e>
  101089:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101090:	48 8b 40 08          	mov    0x8(%rax),%rax
  101094:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101098:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10109f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1010a3:	48 8b 00             	mov    (%rax),%rax
  1010a6:	eb 5c                	jmp    101104 <printer_vprintf+0x3ef>
  1010a8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010af:	8b 00                	mov    (%rax),%eax
  1010b1:	83 f8 2f             	cmp    $0x2f,%eax
  1010b4:	77 30                	ja     1010e6 <printer_vprintf+0x3d1>
  1010b6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010bd:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1010c1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010c8:	8b 00                	mov    (%rax),%eax
  1010ca:	89 c0                	mov    %eax,%eax
  1010cc:	48 01 d0             	add    %rdx,%rax
  1010cf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010d6:	8b 12                	mov    (%rdx),%edx
  1010d8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1010db:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010e2:	89 0a                	mov    %ecx,(%rdx)
  1010e4:	eb 1a                	jmp    101100 <printer_vprintf+0x3eb>
  1010e6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010ed:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010f1:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1010f5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010fc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101100:	8b 00                	mov    (%rax),%eax
  101102:	48 98                	cltq   
  101104:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  101108:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10110c:	48 c1 f8 38          	sar    $0x38,%rax
  101110:	25 80 00 00 00       	and    $0x80,%eax
  101115:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  101118:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  10111c:	74 09                	je     101127 <printer_vprintf+0x412>
  10111e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101122:	48 f7 d8             	neg    %rax
  101125:	eb 04                	jmp    10112b <printer_vprintf+0x416>
  101127:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10112b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  10112f:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  101132:	83 c8 60             	or     $0x60,%eax
  101135:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  101138:	e9 cf 02 00 00       	jmp    10140c <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  10113d:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  101141:	74 5d                	je     1011a0 <printer_vprintf+0x48b>
  101143:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10114a:	8b 00                	mov    (%rax),%eax
  10114c:	83 f8 2f             	cmp    $0x2f,%eax
  10114f:	77 30                	ja     101181 <printer_vprintf+0x46c>
  101151:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101158:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10115c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101163:	8b 00                	mov    (%rax),%eax
  101165:	89 c0                	mov    %eax,%eax
  101167:	48 01 d0             	add    %rdx,%rax
  10116a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101171:	8b 12                	mov    (%rdx),%edx
  101173:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101176:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10117d:	89 0a                	mov    %ecx,(%rdx)
  10117f:	eb 1a                	jmp    10119b <printer_vprintf+0x486>
  101181:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101188:	48 8b 40 08          	mov    0x8(%rax),%rax
  10118c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101190:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101197:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10119b:	48 8b 00             	mov    (%rax),%rax
  10119e:	eb 5c                	jmp    1011fc <printer_vprintf+0x4e7>
  1011a0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011a7:	8b 00                	mov    (%rax),%eax
  1011a9:	83 f8 2f             	cmp    $0x2f,%eax
  1011ac:	77 30                	ja     1011de <printer_vprintf+0x4c9>
  1011ae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011b5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1011b9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011c0:	8b 00                	mov    (%rax),%eax
  1011c2:	89 c0                	mov    %eax,%eax
  1011c4:	48 01 d0             	add    %rdx,%rax
  1011c7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011ce:	8b 12                	mov    (%rdx),%edx
  1011d0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1011d3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011da:	89 0a                	mov    %ecx,(%rdx)
  1011dc:	eb 1a                	jmp    1011f8 <printer_vprintf+0x4e3>
  1011de:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011e5:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011e9:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1011ed:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011f4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1011f8:	8b 00                	mov    (%rax),%eax
  1011fa:	89 c0                	mov    %eax,%eax
  1011fc:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  101200:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  101204:	e9 03 02 00 00       	jmp    10140c <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  101209:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  101210:	e9 28 ff ff ff       	jmp    10113d <printer_vprintf+0x428>
        case 'X':
            base = 16;
  101215:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  10121c:	e9 1c ff ff ff       	jmp    10113d <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  101221:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101228:	8b 00                	mov    (%rax),%eax
  10122a:	83 f8 2f             	cmp    $0x2f,%eax
  10122d:	77 30                	ja     10125f <printer_vprintf+0x54a>
  10122f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101236:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10123a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101241:	8b 00                	mov    (%rax),%eax
  101243:	89 c0                	mov    %eax,%eax
  101245:	48 01 d0             	add    %rdx,%rax
  101248:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10124f:	8b 12                	mov    (%rdx),%edx
  101251:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101254:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10125b:	89 0a                	mov    %ecx,(%rdx)
  10125d:	eb 1a                	jmp    101279 <printer_vprintf+0x564>
  10125f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101266:	48 8b 40 08          	mov    0x8(%rax),%rax
  10126a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10126e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101275:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101279:	48 8b 00             	mov    (%rax),%rax
  10127c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  101280:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  101287:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  10128e:	e9 79 01 00 00       	jmp    10140c <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  101293:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10129a:	8b 00                	mov    (%rax),%eax
  10129c:	83 f8 2f             	cmp    $0x2f,%eax
  10129f:	77 30                	ja     1012d1 <printer_vprintf+0x5bc>
  1012a1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012a8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1012ac:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012b3:	8b 00                	mov    (%rax),%eax
  1012b5:	89 c0                	mov    %eax,%eax
  1012b7:	48 01 d0             	add    %rdx,%rax
  1012ba:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012c1:	8b 12                	mov    (%rdx),%edx
  1012c3:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1012c6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012cd:	89 0a                	mov    %ecx,(%rdx)
  1012cf:	eb 1a                	jmp    1012eb <printer_vprintf+0x5d6>
  1012d1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012d8:	48 8b 40 08          	mov    0x8(%rax),%rax
  1012dc:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1012e0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012e7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1012eb:	48 8b 00             	mov    (%rax),%rax
  1012ee:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  1012f2:	e9 15 01 00 00       	jmp    10140c <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  1012f7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012fe:	8b 00                	mov    (%rax),%eax
  101300:	83 f8 2f             	cmp    $0x2f,%eax
  101303:	77 30                	ja     101335 <printer_vprintf+0x620>
  101305:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10130c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101310:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101317:	8b 00                	mov    (%rax),%eax
  101319:	89 c0                	mov    %eax,%eax
  10131b:	48 01 d0             	add    %rdx,%rax
  10131e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101325:	8b 12                	mov    (%rdx),%edx
  101327:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10132a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101331:	89 0a                	mov    %ecx,(%rdx)
  101333:	eb 1a                	jmp    10134f <printer_vprintf+0x63a>
  101335:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10133c:	48 8b 40 08          	mov    0x8(%rax),%rax
  101340:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101344:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10134b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10134f:	8b 00                	mov    (%rax),%eax
  101351:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  101357:	e9 67 03 00 00       	jmp    1016c3 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  10135c:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101360:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  101364:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10136b:	8b 00                	mov    (%rax),%eax
  10136d:	83 f8 2f             	cmp    $0x2f,%eax
  101370:	77 30                	ja     1013a2 <printer_vprintf+0x68d>
  101372:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101379:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10137d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101384:	8b 00                	mov    (%rax),%eax
  101386:	89 c0                	mov    %eax,%eax
  101388:	48 01 d0             	add    %rdx,%rax
  10138b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101392:	8b 12                	mov    (%rdx),%edx
  101394:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101397:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10139e:	89 0a                	mov    %ecx,(%rdx)
  1013a0:	eb 1a                	jmp    1013bc <printer_vprintf+0x6a7>
  1013a2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013a9:	48 8b 40 08          	mov    0x8(%rax),%rax
  1013ad:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1013b1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1013b8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1013bc:	8b 00                	mov    (%rax),%eax
  1013be:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  1013c1:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  1013c5:	eb 45                	jmp    10140c <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  1013c7:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1013cb:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  1013cf:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1013d6:	0f b6 00             	movzbl (%rax),%eax
  1013d9:	84 c0                	test   %al,%al
  1013db:	74 0c                	je     1013e9 <printer_vprintf+0x6d4>
  1013dd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1013e4:	0f b6 00             	movzbl (%rax),%eax
  1013e7:	eb 05                	jmp    1013ee <printer_vprintf+0x6d9>
  1013e9:	b8 25 00 00 00       	mov    $0x25,%eax
  1013ee:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  1013f1:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  1013f5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1013fc:	0f b6 00             	movzbl (%rax),%eax
  1013ff:	84 c0                	test   %al,%al
  101401:	75 08                	jne    10140b <printer_vprintf+0x6f6>
                format--;
  101403:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  10140a:	01 
            }
            break;
  10140b:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  10140c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10140f:	83 e0 20             	and    $0x20,%eax
  101412:	85 c0                	test   %eax,%eax
  101414:	74 1e                	je     101434 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  101416:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  10141a:	48 83 c0 18          	add    $0x18,%rax
  10141e:	8b 55 e0             	mov    -0x20(%rbp),%edx
  101421:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101425:	48 89 ce             	mov    %rcx,%rsi
  101428:	48 89 c7             	mov    %rax,%rdi
  10142b:	e8 63 f8 ff ff       	call   100c93 <fill_numbuf>
  101430:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  101434:	48 c7 45 c0 86 1a 10 	movq   $0x101a86,-0x40(%rbp)
  10143b:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  10143c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10143f:	83 e0 20             	and    $0x20,%eax
  101442:	85 c0                	test   %eax,%eax
  101444:	74 48                	je     10148e <printer_vprintf+0x779>
  101446:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101449:	83 e0 40             	and    $0x40,%eax
  10144c:	85 c0                	test   %eax,%eax
  10144e:	74 3e                	je     10148e <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  101450:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101453:	25 80 00 00 00       	and    $0x80,%eax
  101458:	85 c0                	test   %eax,%eax
  10145a:	74 0a                	je     101466 <printer_vprintf+0x751>
                prefix = "-";
  10145c:	48 c7 45 c0 87 1a 10 	movq   $0x101a87,-0x40(%rbp)
  101463:	00 
            if (flags & FLAG_NEGATIVE) {
  101464:	eb 73                	jmp    1014d9 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  101466:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101469:	83 e0 10             	and    $0x10,%eax
  10146c:	85 c0                	test   %eax,%eax
  10146e:	74 0a                	je     10147a <printer_vprintf+0x765>
                prefix = "+";
  101470:	48 c7 45 c0 89 1a 10 	movq   $0x101a89,-0x40(%rbp)
  101477:	00 
            if (flags & FLAG_NEGATIVE) {
  101478:	eb 5f                	jmp    1014d9 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  10147a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10147d:	83 e0 08             	and    $0x8,%eax
  101480:	85 c0                	test   %eax,%eax
  101482:	74 55                	je     1014d9 <printer_vprintf+0x7c4>
                prefix = " ";
  101484:	48 c7 45 c0 8b 1a 10 	movq   $0x101a8b,-0x40(%rbp)
  10148b:	00 
            if (flags & FLAG_NEGATIVE) {
  10148c:	eb 4b                	jmp    1014d9 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  10148e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101491:	83 e0 20             	and    $0x20,%eax
  101494:	85 c0                	test   %eax,%eax
  101496:	74 42                	je     1014da <printer_vprintf+0x7c5>
  101498:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10149b:	83 e0 01             	and    $0x1,%eax
  10149e:	85 c0                	test   %eax,%eax
  1014a0:	74 38                	je     1014da <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  1014a2:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  1014a6:	74 06                	je     1014ae <printer_vprintf+0x799>
  1014a8:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1014ac:	75 2c                	jne    1014da <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  1014ae:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1014b3:	75 0c                	jne    1014c1 <printer_vprintf+0x7ac>
  1014b5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1014b8:	25 00 01 00 00       	and    $0x100,%eax
  1014bd:	85 c0                	test   %eax,%eax
  1014bf:	74 19                	je     1014da <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  1014c1:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1014c5:	75 07                	jne    1014ce <printer_vprintf+0x7b9>
  1014c7:	b8 8d 1a 10 00       	mov    $0x101a8d,%eax
  1014cc:	eb 05                	jmp    1014d3 <printer_vprintf+0x7be>
  1014ce:	b8 90 1a 10 00       	mov    $0x101a90,%eax
  1014d3:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1014d7:	eb 01                	jmp    1014da <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  1014d9:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  1014da:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1014de:	78 24                	js     101504 <printer_vprintf+0x7ef>
  1014e0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1014e3:	83 e0 20             	and    $0x20,%eax
  1014e6:	85 c0                	test   %eax,%eax
  1014e8:	75 1a                	jne    101504 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  1014ea:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1014ed:	48 63 d0             	movslq %eax,%rdx
  1014f0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1014f4:	48 89 d6             	mov    %rdx,%rsi
  1014f7:	48 89 c7             	mov    %rax,%rdi
  1014fa:	e8 ea f5 ff ff       	call   100ae9 <strnlen>
  1014ff:	89 45 bc             	mov    %eax,-0x44(%rbp)
  101502:	eb 0f                	jmp    101513 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  101504:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101508:	48 89 c7             	mov    %rax,%rdi
  10150b:	e8 a8 f5 ff ff       	call   100ab8 <strlen>
  101510:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  101513:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101516:	83 e0 20             	and    $0x20,%eax
  101519:	85 c0                	test   %eax,%eax
  10151b:	74 20                	je     10153d <printer_vprintf+0x828>
  10151d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101521:	78 1a                	js     10153d <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  101523:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101526:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  101529:	7e 08                	jle    101533 <printer_vprintf+0x81e>
  10152b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10152e:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101531:	eb 05                	jmp    101538 <printer_vprintf+0x823>
  101533:	b8 00 00 00 00       	mov    $0x0,%eax
  101538:	89 45 b8             	mov    %eax,-0x48(%rbp)
  10153b:	eb 5c                	jmp    101599 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  10153d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101540:	83 e0 20             	and    $0x20,%eax
  101543:	85 c0                	test   %eax,%eax
  101545:	74 4b                	je     101592 <printer_vprintf+0x87d>
  101547:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10154a:	83 e0 02             	and    $0x2,%eax
  10154d:	85 c0                	test   %eax,%eax
  10154f:	74 41                	je     101592 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  101551:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101554:	83 e0 04             	and    $0x4,%eax
  101557:	85 c0                	test   %eax,%eax
  101559:	75 37                	jne    101592 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  10155b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10155f:	48 89 c7             	mov    %rax,%rdi
  101562:	e8 51 f5 ff ff       	call   100ab8 <strlen>
  101567:	89 c2                	mov    %eax,%edx
  101569:	8b 45 bc             	mov    -0x44(%rbp),%eax
  10156c:	01 d0                	add    %edx,%eax
  10156e:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  101571:	7e 1f                	jle    101592 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  101573:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101576:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101579:	89 c3                	mov    %eax,%ebx
  10157b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10157f:	48 89 c7             	mov    %rax,%rdi
  101582:	e8 31 f5 ff ff       	call   100ab8 <strlen>
  101587:	89 c2                	mov    %eax,%edx
  101589:	89 d8                	mov    %ebx,%eax
  10158b:	29 d0                	sub    %edx,%eax
  10158d:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101590:	eb 07                	jmp    101599 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  101592:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  101599:	8b 55 bc             	mov    -0x44(%rbp),%edx
  10159c:	8b 45 b8             	mov    -0x48(%rbp),%eax
  10159f:	01 d0                	add    %edx,%eax
  1015a1:	48 63 d8             	movslq %eax,%rbx
  1015a4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1015a8:	48 89 c7             	mov    %rax,%rdi
  1015ab:	e8 08 f5 ff ff       	call   100ab8 <strlen>
  1015b0:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  1015b4:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1015b7:	29 d0                	sub    %edx,%eax
  1015b9:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1015bc:	eb 25                	jmp    1015e3 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  1015be:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1015c5:	48 8b 08             	mov    (%rax),%rcx
  1015c8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1015ce:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1015d5:	be 20 00 00 00       	mov    $0x20,%esi
  1015da:	48 89 c7             	mov    %rax,%rdi
  1015dd:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1015df:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1015e3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015e6:	83 e0 04             	and    $0x4,%eax
  1015e9:	85 c0                	test   %eax,%eax
  1015eb:	75 36                	jne    101623 <printer_vprintf+0x90e>
  1015ed:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1015f1:	7f cb                	jg     1015be <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  1015f3:	eb 2e                	jmp    101623 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  1015f5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1015fc:	4c 8b 00             	mov    (%rax),%r8
  1015ff:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101603:	0f b6 00             	movzbl (%rax),%eax
  101606:	0f b6 c8             	movzbl %al,%ecx
  101609:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10160f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101616:	89 ce                	mov    %ecx,%esi
  101618:	48 89 c7             	mov    %rax,%rdi
  10161b:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  10161e:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  101623:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101627:	0f b6 00             	movzbl (%rax),%eax
  10162a:	84 c0                	test   %al,%al
  10162c:	75 c7                	jne    1015f5 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  10162e:	eb 25                	jmp    101655 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  101630:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101637:	48 8b 08             	mov    (%rax),%rcx
  10163a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101640:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101647:	be 30 00 00 00       	mov    $0x30,%esi
  10164c:	48 89 c7             	mov    %rax,%rdi
  10164f:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  101651:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  101655:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  101659:	7f d5                	jg     101630 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  10165b:	eb 32                	jmp    10168f <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  10165d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101664:	4c 8b 00             	mov    (%rax),%r8
  101667:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  10166b:	0f b6 00             	movzbl (%rax),%eax
  10166e:	0f b6 c8             	movzbl %al,%ecx
  101671:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101677:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10167e:	89 ce                	mov    %ecx,%esi
  101680:	48 89 c7             	mov    %rax,%rdi
  101683:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  101686:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  10168b:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  10168f:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  101693:	7f c8                	jg     10165d <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  101695:	eb 25                	jmp    1016bc <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  101697:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10169e:	48 8b 08             	mov    (%rax),%rcx
  1016a1:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1016a7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1016ae:	be 20 00 00 00       	mov    $0x20,%esi
  1016b3:	48 89 c7             	mov    %rax,%rdi
  1016b6:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  1016b8:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1016bc:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1016c0:	7f d5                	jg     101697 <printer_vprintf+0x982>
        }
    done: ;
  1016c2:	90                   	nop
    for (; *format; ++format) {
  1016c3:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1016ca:	01 
  1016cb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1016d2:	0f b6 00             	movzbl (%rax),%eax
  1016d5:	84 c0                	test   %al,%al
  1016d7:	0f 85 64 f6 ff ff    	jne    100d41 <printer_vprintf+0x2c>
    }
}
  1016dd:	90                   	nop
  1016de:	90                   	nop
  1016df:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1016e3:	c9                   	leave  
  1016e4:	c3                   	ret    

00000000001016e5 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1016e5:	55                   	push   %rbp
  1016e6:	48 89 e5             	mov    %rsp,%rbp
  1016e9:	48 83 ec 20          	sub    $0x20,%rsp
  1016ed:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1016f1:	89 f0                	mov    %esi,%eax
  1016f3:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1016f6:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  1016f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1016fd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101701:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101705:	48 8b 40 08          	mov    0x8(%rax),%rax
  101709:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  10170e:	48 39 d0             	cmp    %rdx,%rax
  101711:	72 0c                	jb     10171f <console_putc+0x3a>
        cp->cursor = console;
  101713:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101717:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  10171e:	00 
    }
    if (c == '\n') {
  10171f:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  101723:	75 78                	jne    10179d <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  101725:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101729:	48 8b 40 08          	mov    0x8(%rax),%rax
  10172d:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  101733:	48 d1 f8             	sar    %rax
  101736:	48 89 c1             	mov    %rax,%rcx
  101739:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  101740:	66 66 66 
  101743:	48 89 c8             	mov    %rcx,%rax
  101746:	48 f7 ea             	imul   %rdx
  101749:	48 c1 fa 05          	sar    $0x5,%rdx
  10174d:	48 89 c8             	mov    %rcx,%rax
  101750:	48 c1 f8 3f          	sar    $0x3f,%rax
  101754:	48 29 c2             	sub    %rax,%rdx
  101757:	48 89 d0             	mov    %rdx,%rax
  10175a:	48 c1 e0 02          	shl    $0x2,%rax
  10175e:	48 01 d0             	add    %rdx,%rax
  101761:	48 c1 e0 04          	shl    $0x4,%rax
  101765:	48 29 c1             	sub    %rax,%rcx
  101768:	48 89 ca             	mov    %rcx,%rdx
  10176b:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  10176e:	eb 25                	jmp    101795 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  101770:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101773:	83 c8 20             	or     $0x20,%eax
  101776:	89 c6                	mov    %eax,%esi
  101778:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10177c:	48 8b 40 08          	mov    0x8(%rax),%rax
  101780:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101784:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101788:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10178c:	89 f2                	mov    %esi,%edx
  10178e:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  101791:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101795:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101799:	75 d5                	jne    101770 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  10179b:	eb 24                	jmp    1017c1 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  10179d:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  1017a1:	8b 55 e0             	mov    -0x20(%rbp),%edx
  1017a4:	09 d0                	or     %edx,%eax
  1017a6:	89 c6                	mov    %eax,%esi
  1017a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1017ac:	48 8b 40 08          	mov    0x8(%rax),%rax
  1017b0:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1017b4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1017b8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1017bc:	89 f2                	mov    %esi,%edx
  1017be:	66 89 10             	mov    %dx,(%rax)
}
  1017c1:	90                   	nop
  1017c2:	c9                   	leave  
  1017c3:	c3                   	ret    

00000000001017c4 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1017c4:	55                   	push   %rbp
  1017c5:	48 89 e5             	mov    %rsp,%rbp
  1017c8:	48 83 ec 30          	sub    $0x30,%rsp
  1017cc:	89 7d ec             	mov    %edi,-0x14(%rbp)
  1017cf:	89 75 e8             	mov    %esi,-0x18(%rbp)
  1017d2:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1017d6:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  1017da:	48 c7 45 f0 e5 16 10 	movq   $0x1016e5,-0x10(%rbp)
  1017e1:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1017e2:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  1017e6:	78 09                	js     1017f1 <console_vprintf+0x2d>
  1017e8:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  1017ef:	7e 07                	jle    1017f8 <console_vprintf+0x34>
        cpos = 0;
  1017f1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  1017f8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1017fb:	48 98                	cltq   
  1017fd:	48 01 c0             	add    %rax,%rax
  101800:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  101806:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  10180a:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  10180e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  101812:	8b 75 e8             	mov    -0x18(%rbp),%esi
  101815:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101819:	48 89 c7             	mov    %rax,%rdi
  10181c:	e8 f4 f4 ff ff       	call   100d15 <printer_vprintf>
    return cp.cursor - console;
  101821:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101825:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  10182b:	48 d1 f8             	sar    %rax
}
  10182e:	c9                   	leave  
  10182f:	c3                   	ret    

0000000000101830 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  101830:	55                   	push   %rbp
  101831:	48 89 e5             	mov    %rsp,%rbp
  101834:	48 83 ec 60          	sub    $0x60,%rsp
  101838:	89 7d ac             	mov    %edi,-0x54(%rbp)
  10183b:	89 75 a8             	mov    %esi,-0x58(%rbp)
  10183e:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  101842:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101846:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10184a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  10184e:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101855:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101859:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  10185d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101861:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101865:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101869:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  10186d:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101870:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101873:	89 c7                	mov    %eax,%edi
  101875:	e8 4a ff ff ff       	call   1017c4 <console_vprintf>
  10187a:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  10187d:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101880:	c9                   	leave  
  101881:	c3                   	ret    

0000000000101882 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101882:	55                   	push   %rbp
  101883:	48 89 e5             	mov    %rsp,%rbp
  101886:	48 83 ec 20          	sub    $0x20,%rsp
  10188a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10188e:	89 f0                	mov    %esi,%eax
  101890:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101893:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101896:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10189a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  10189e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1018a2:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1018a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1018aa:	48 8b 40 10          	mov    0x10(%rax),%rax
  1018ae:	48 39 c2             	cmp    %rax,%rdx
  1018b1:	73 1a                	jae    1018cd <string_putc+0x4b>
        *sp->s++ = c;
  1018b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1018b7:	48 8b 40 08          	mov    0x8(%rax),%rax
  1018bb:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1018bf:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1018c3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1018c7:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1018cb:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1018cd:	90                   	nop
  1018ce:	c9                   	leave  
  1018cf:	c3                   	ret    

00000000001018d0 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1018d0:	55                   	push   %rbp
  1018d1:	48 89 e5             	mov    %rsp,%rbp
  1018d4:	48 83 ec 40          	sub    $0x40,%rsp
  1018d8:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  1018dc:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  1018e0:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  1018e4:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1018e8:	48 c7 45 e8 82 18 10 	movq   $0x101882,-0x18(%rbp)
  1018ef:	00 
    sp.s = s;
  1018f0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1018f4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1018f8:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1018fd:	74 33                	je     101932 <vsnprintf+0x62>
        sp.end = s + size - 1;
  1018ff:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101903:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101907:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10190b:	48 01 d0             	add    %rdx,%rax
  10190e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101912:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101916:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  10191a:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  10191e:	be 00 00 00 00       	mov    $0x0,%esi
  101923:	48 89 c7             	mov    %rax,%rdi
  101926:	e8 ea f3 ff ff       	call   100d15 <printer_vprintf>
        *sp.s = 0;
  10192b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10192f:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  101932:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101936:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  10193a:	c9                   	leave  
  10193b:	c3                   	ret    

000000000010193c <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  10193c:	55                   	push   %rbp
  10193d:	48 89 e5             	mov    %rsp,%rbp
  101940:	48 83 ec 70          	sub    $0x70,%rsp
  101944:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101948:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  10194c:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101950:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101954:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101958:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  10195c:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101963:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101967:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  10196b:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10196f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101973:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101977:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  10197b:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  10197f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101983:	48 89 c7             	mov    %rax,%rdi
  101986:	e8 45 ff ff ff       	call   1018d0 <vsnprintf>
  10198b:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  10198e:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101991:	c9                   	leave  
  101992:	c3                   	ret    

0000000000101993 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101993:	55                   	push   %rbp
  101994:	48 89 e5             	mov    %rsp,%rbp
  101997:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10199b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  1019a2:	eb 13                	jmp    1019b7 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  1019a4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1019a7:	48 98                	cltq   
  1019a9:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  1019b0:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1019b3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1019b7:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1019be:	7e e4                	jle    1019a4 <console_clear+0x11>
    }
    cursorpos = 0;
  1019c0:	c7 05 32 76 fb ff 00 	movl   $0x0,-0x489ce(%rip)        # b8ffc <cursorpos>
  1019c7:	00 00 00 
}
  1019ca:	90                   	nop
  1019cb:	c9                   	leave  
  1019cc:	c3                   	ret    
