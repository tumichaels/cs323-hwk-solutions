
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
  10000f:	e8 80 0c 00 00       	call   100c94 <srand>
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
  10004d:	e8 80 04 00 00       	call   1004d2 <malloc>
	void *ptr2 = malloc(16);
  100052:	bf 10 00 00 00       	mov    $0x10,%edi
  100057:	e8 76 04 00 00       	call   1004d2 <malloc>
	void *ptr3 = malloc(24);
  10005c:	bf 18 00 00 00       	mov    $0x18,%edi
  100061:	e8 6c 04 00 00       	call   1004d2 <malloc>
	void *ptr4 = malloc(32);
  100066:	bf 20 00 00 00       	mov    $0x20,%edi
  10006b:	e8 62 04 00 00       	call   1004d2 <malloc>
  100070:	48 89 c7             	mov    %rax,%rdi
	free(ptr4);
  100073:	e8 f7 02 00 00       	call   10036f <free>
	defrag();
  100078:	b8 00 00 00 00       	mov    $0x0,%eax
  10007d:	e8 92 05 00 00       	call   100614 <defrag>

	struct heap_info_struct s1;
	heap_info(&s1);
  100082:	48 8d 7d d0          	lea    -0x30(%rbp),%rdi
  100086:	e8 1b 07 00 00       	call   1007a6 <heap_info>

	app_printf(0x700, "number of allocs: %d\n", s1.num_allocs);
  10008b:	8b 55 d0             	mov    -0x30(%rbp),%edx
  10008e:	be f0 19 10 00       	mov    $0x1019f0,%esi
  100093:	bf 00 07 00 00       	mov    $0x700,%edi
  100098:	b8 00 00 00 00       	mov    $0x0,%eax
  10009d:	e8 c6 00 00 00       	call   100168 <app_printf>
	app_printf(0x700, "alloc list: \n");
  1000a2:	be 06 1a 10 00       	mov    $0x101a06,%esi
  1000a7:	bf 00 07 00 00       	mov    $0x700,%edi
  1000ac:	b8 00 00 00 00       	mov    $0x0,%eax
  1000b1:	e8 b2 00 00 00       	call   100168 <app_printf>
	for (int i = 0; i < s1.num_allocs; i++) {
  1000b6:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
  1000ba:	7e 3d                	jle    1000f9 <process_main+0xf9>
  1000bc:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  1000c2:	bb 00 00 00 00       	mov    $0x0,%ebx
		app_printf(0x700, "    alloc'd region %d: %p    size: 0x%lx\n", i+1, s1.ptr_array[i], s1.size_array[i]);
  1000c7:	83 c3 01             	add    $0x1,%ebx
  1000ca:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1000ce:	4a 8b 0c 20          	mov    (%rax,%r12,1),%rcx
  1000d2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1000d6:	4e 8b 04 20          	mov    (%rax,%r12,1),%r8
  1000da:	89 da                	mov    %ebx,%edx
  1000dc:	be 78 1a 10 00       	mov    $0x101a78,%esi
  1000e1:	bf 00 07 00 00       	mov    $0x700,%edi
  1000e6:	b8 00 00 00 00       	mov    $0x0,%eax
  1000eb:	e8 78 00 00 00       	call   100168 <app_printf>
	for (int i = 0; i < s1.num_allocs; i++) {
  1000f0:	49 83 c4 08          	add    $0x8,%r12
  1000f4:	3b 5d d0             	cmp    -0x30(%rbp),%ebx
  1000f7:	7c ce                	jl     1000c7 <process_main+0xc7>
	}
	app_printf(0x700, "free space: 0x%x\n", s1.free_space);
  1000f9:	8b 55 e8             	mov    -0x18(%rbp),%edx
  1000fc:	be 14 1a 10 00       	mov    $0x101a14,%esi
  100101:	bf 00 07 00 00       	mov    $0x700,%edi
  100106:	b8 00 00 00 00       	mov    $0x0,%eax
  10010b:	e8 58 00 00 00       	call   100168 <app_printf>
	app_printf(0x700, "largest free chunk: 0x%x\n", s1.largest_free_chunk);
  100110:	8b 55 ec             	mov    -0x14(%rbp),%edx
  100113:	be 26 1a 10 00       	mov    $0x101a26,%esi
  100118:	bf 00 07 00 00       	mov    $0x700,%edi
  10011d:	b8 00 00 00 00       	mov    $0x0,%eax
  100122:	e8 41 00 00 00       	call   100168 <app_printf>
	app_printf(0x700, "extend chunk size: 0x%x\n", (1<<14));
  100127:	ba 00 40 00 00       	mov    $0x4000,%edx
  10012c:	be 40 1a 10 00       	mov    $0x101a40,%esi
  100131:	bf 00 07 00 00       	mov    $0x700,%edi
  100136:	b8 00 00 00 00       	mov    $0x0,%eax
  10013b:	e8 28 00 00 00       	call   100168 <app_printf>
	app_printf(0x700, "extend chunk size minus allocs: 0x%x\n", (1<<14) -0x30 - 0x20 - 0x20 - 0x20);
  100140:	ba 70 3f 00 00       	mov    $0x3f70,%edx
  100145:	be a8 1a 10 00       	mov    $0x101aa8,%esi
  10014a:	bf 00 07 00 00       	mov    $0x700,%edi
  10014f:	b8 00 00 00 00       	mov    $0x0,%eax
  100154:	e8 0f 00 00 00       	call   100168 <app_printf>
	

    TEST_PASS();
  100159:	bf 59 1a 10 00       	mov    $0x101a59,%edi
  10015e:	b8 00 00 00 00       	mov    $0x0,%eax
  100163:	e8 90 00 00 00       	call   1001f8 <kernel_panic>

0000000000100168 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100168:	55                   	push   %rbp
  100169:	48 89 e5             	mov    %rsp,%rbp
  10016c:	48 83 ec 50          	sub    $0x50,%rsp
  100170:	49 89 f2             	mov    %rsi,%r10
  100173:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100177:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10017b:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10017f:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  100183:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100188:	85 ff                	test   %edi,%edi
  10018a:	78 2e                	js     1001ba <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  10018c:	48 63 ff             	movslq %edi,%rdi
  10018f:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  100196:	cc cc cc 
  100199:	48 89 f8             	mov    %rdi,%rax
  10019c:	48 f7 e2             	mul    %rdx
  10019f:	48 89 d0             	mov    %rdx,%rax
  1001a2:	48 c1 e8 02          	shr    $0x2,%rax
  1001a6:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  1001aa:	48 01 c2             	add    %rax,%rdx
  1001ad:	48 29 d7             	sub    %rdx,%rdi
  1001b0:	0f b6 b7 05 1b 10 00 	movzbl 0x101b05(%rdi),%esi
  1001b7:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  1001ba:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  1001c1:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1001c5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1001c9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1001cd:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  1001d1:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1001d5:	4c 89 d2             	mov    %r10,%rdx
  1001d8:	8b 3d 1e 8e fb ff    	mov    -0x471e2(%rip),%edi        # b8ffc <cursorpos>
  1001de:	e8 03 16 00 00       	call   1017e6 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  1001e3:	3d 30 07 00 00       	cmp    $0x730,%eax
  1001e8:	ba 00 00 00 00       	mov    $0x0,%edx
  1001ed:	0f 4d c2             	cmovge %edx,%eax
  1001f0:	89 05 06 8e fb ff    	mov    %eax,-0x471fa(%rip)        # b8ffc <cursorpos>
    }
}
  1001f6:	c9                   	leave  
  1001f7:	c3                   	ret    

00000000001001f8 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  1001f8:	55                   	push   %rbp
  1001f9:	48 89 e5             	mov    %rsp,%rbp
  1001fc:	53                   	push   %rbx
  1001fd:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100204:	48 89 fb             	mov    %rdi,%rbx
  100207:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  10020b:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  10020f:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100213:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100217:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  10021b:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  100222:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100226:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  10022a:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  10022e:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  100232:	ba 07 00 00 00       	mov    $0x7,%edx
  100237:	be ce 1a 10 00       	mov    $0x101ace,%esi
  10023c:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100243:	e8 55 07 00 00       	call   10099d <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100248:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  10024c:	48 89 da             	mov    %rbx,%rdx
  10024f:	be 99 00 00 00       	mov    $0x99,%esi
  100254:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  10025b:	e8 92 16 00 00       	call   1018f2 <vsnprintf>
  100260:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100263:	85 d2                	test   %edx,%edx
  100265:	7e 0f                	jle    100276 <kernel_panic+0x7e>
  100267:	83 c0 06             	add    $0x6,%eax
  10026a:	48 98                	cltq   
  10026c:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  100273:	0a 
  100274:	75 2a                	jne    1002a0 <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  100276:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  10027d:	48 89 d9             	mov    %rbx,%rcx
  100280:	ba d6 1a 10 00       	mov    $0x101ad6,%edx
  100285:	be 00 c0 00 00       	mov    $0xc000,%esi
  10028a:	bf 30 07 00 00       	mov    $0x730,%edi
  10028f:	b8 00 00 00 00       	mov    $0x0,%eax
  100294:	e8 b9 15 00 00       	call   101852 <console_printf>
    asm volatile ("int %0" : /* no result */
  100299:	48 89 df             	mov    %rbx,%rdi
  10029c:	cd 30                	int    $0x30
 loop: goto loop;
  10029e:	eb fe                	jmp    10029e <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  1002a0:	48 63 c2             	movslq %edx,%rax
  1002a3:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  1002a9:	0f 94 c2             	sete   %dl
  1002ac:	0f b6 d2             	movzbl %dl,%edx
  1002af:	48 29 d0             	sub    %rdx,%rax
  1002b2:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  1002b9:	ff 
  1002ba:	be 12 1a 10 00       	mov    $0x101a12,%esi
  1002bf:	e8 86 08 00 00       	call   100b4a <strcpy>
  1002c4:	eb b0                	jmp    100276 <kernel_panic+0x7e>

00000000001002c6 <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  1002c6:	55                   	push   %rbp
  1002c7:	48 89 e5             	mov    %rsp,%rbp
  1002ca:	48 89 f9             	mov    %rdi,%rcx
  1002cd:	41 89 f0             	mov    %esi,%r8d
  1002d0:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  1002d3:	ba e0 1a 10 00       	mov    $0x101ae0,%edx
  1002d8:	be 00 c0 00 00       	mov    $0xc000,%esi
  1002dd:	bf 30 07 00 00       	mov    $0x730,%edi
  1002e2:	b8 00 00 00 00       	mov    $0x0,%eax
  1002e7:	e8 66 15 00 00       	call   101852 <console_printf>
    asm volatile ("int %0" : /* no result */
  1002ec:	bf 00 00 00 00       	mov    $0x0,%edi
  1002f1:	cd 30                	int    $0x30
 loop: goto loop;
  1002f3:	eb fe                	jmp    1002f3 <assert_fail+0x2d>

00000000001002f5 <heap_init>:
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  1002f5:	bf 10 00 00 00       	mov    $0x10,%edi
  1002fa:	cd 3a                	int    $0x3a
  1002fc:	48 89 05 1d 21 00 00 	mov    %rax,0x211d(%rip)        # 102420 <result.0>
  100303:	bf 08 00 00 00       	mov    $0x8,%edi
  100308:	cd 3a                	int    $0x3a
  10030a:	48 89 05 0f 21 00 00 	mov    %rax,0x210f(%rip)        # 102420 <result.0>
// want to try and optimize this 
void heap_init(void) {

	// prologue block
	sbrk(sizeof(block_header) + sizeof(block_header));
	prologue_block = sbrk(sizeof(block_footer));
  100311:	48 89 05 f8 20 00 00 	mov    %rax,0x20f8(%rip)        # 102410 <prologue_block>
	PUT(HDRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  100318:	48 c7 40 f8 11 00 00 	movq   $0x11,-0x8(%rax)
  10031f:	00 
	PUT(FTRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  100320:	48 8b 15 e9 20 00 00 	mov    0x20e9(%rip),%rdx        # 102410 <prologue_block>
  100327:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  10032b:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  10032f:	48 c7 44 02 f0 11 00 	movq   $0x11,-0x10(%rdx,%rax,1)
  100336:	00 00 
  100338:	cd 3a                	int    $0x3a
  10033a:	48 89 05 df 20 00 00 	mov    %rax,0x20df(%rip)        # 102420 <result.0>

	// terminal block
	sbrk(sizeof(block_header));
	PUT(HDRP(NEXT_BLKP(prologue_block)), PACK(0, 1));	
  100341:	48 8b 15 c8 20 00 00 	mov    0x20c8(%rip),%rdx        # 102410 <prologue_block>
  100348:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  10034c:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100350:	48 c7 44 02 f8 01 00 	movq   $0x1,-0x8(%rdx,%rax,1)
  100357:	00 00 

	free_list = NULL;
  100359:	48 c7 05 a4 20 00 00 	movq   $0x0,0x20a4(%rip)        # 102408 <free_list>
  100360:	00 00 00 00 

	initialized_heap = 1;
  100364:	c7 05 aa 20 00 00 01 	movl   $0x1,0x20aa(%rip)        # 102418 <initialized_heap>
  10036b:	00 00 00 
}
  10036e:	c3                   	ret    

000000000010036f <free>:

void free(void *firstbyte) {
	if (firstbyte == NULL)
  10036f:	48 85 ff             	test   %rdi,%rdi
  100372:	74 3d                	je     1003b1 <free+0x42>
		return;

	// setup free things: alloc, list ptrs, footer
	PUT(HDRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  100374:	48 8b 47 f8          	mov    -0x8(%rdi),%rax
  100378:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  10037c:	48 89 47 f8          	mov    %rax,-0x8(%rdi)
	NEXT_FPTR(firstbyte) = free_list;
  100380:	48 8b 15 81 20 00 00 	mov    0x2081(%rip),%rdx        # 102408 <free_list>
  100387:	48 89 17             	mov    %rdx,(%rdi)
	PREV_FPTR(firstbyte) = NULL;
  10038a:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  100391:	00 
	PUT(FTRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  100392:	48 89 44 07 f0       	mov    %rax,-0x10(%rdi,%rax,1)

	// add to free_list
	PREV_FPTR(free_list) = firstbyte;
  100397:	48 8b 05 6a 20 00 00 	mov    0x206a(%rip),%rax        # 102408 <free_list>
  10039e:	48 89 78 08          	mov    %rdi,0x8(%rax)
	free_list = firstbyte;
  1003a2:	48 89 3d 5f 20 00 00 	mov    %rdi,0x205f(%rip)        # 102408 <free_list>

	num_allocs--;
  1003a9:	48 83 2d 4f 20 00 00 	subq   $0x1,0x204f(%rip)        # 102400 <num_allocs>
  1003b0:	01 

	return;
}
  1003b1:	c3                   	ret    

00000000001003b2 <extend>:
//
//	the reason allocating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
int extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  1003b2:	48 81 c7 ff 3f 00 00 	add    $0x3fff,%rdi
  1003b9:	48 81 e7 00 c0 ff ff 	and    $0xffffffffffffc000,%rdi
  1003c0:	cd 3a                	int    $0x3a
  1003c2:	48 89 05 57 20 00 00 	mov    %rax,0x2057(%rip)        # 102420 <result.0>
	void *bp = sbrk(chunk_aligned_size);
	if (bp == (void *)-1)
  1003c9:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  1003cd:	74 49                	je     100418 <extend+0x66>
		return -1;

	// setup pointer
	PUT(HDRP(bp), PACK(chunk_aligned_size, 0));	
  1003cf:	48 89 78 f8          	mov    %rdi,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  1003d3:	48 8b 15 2e 20 00 00 	mov    0x202e(%rip),%rdx        # 102408 <free_list>
  1003da:	48 89 10             	mov    %rdx,(%rax)
	PREV_FPTR(bp) = NULL;
  1003dd:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  1003e4:	00 
	PUT(FTRP(bp), PACK(chunk_aligned_size, 0));	
  1003e5:	48 89 7c 07 f0       	mov    %rdi,-0x10(%rdi,%rax,1)
	
	// add to head of free_list
	if (free_list)
  1003ea:	48 8b 15 17 20 00 00 	mov    0x2017(%rip),%rdx        # 102408 <free_list>
  1003f1:	48 85 d2             	test   %rdx,%rdx
  1003f4:	74 04                	je     1003fa <extend+0x48>
		PREV_FPTR(free_list) = bp;
  1003f6:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  1003fa:	48 89 05 07 20 00 00 	mov    %rax,0x2007(%rip)        # 102408 <free_list>

	// update terminal block
	PUT(HDRP(NEXT_BLKP(bp)), PACK(0, 1));	
  100401:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  100405:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100409:	48 c7 44 10 f8 01 00 	movq   $0x1,-0x8(%rax,%rdx,1)
  100410:	00 00 

	return 0;
  100412:	b8 00 00 00 00       	mov    $0x0,%eax
  100417:	c3                   	ret    
		return -1;
  100418:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10041d:	c3                   	ret    

000000000010041e <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
  10041e:	48 89 f8             	mov    %rdi,%rax
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  100421:	48 8b 57 f8          	mov    -0x8(%rdi),%rdx
  100425:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100429:	48 29 f2             	sub    %rsi,%rdx

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  10042c:	48 83 fa 20          	cmp    $0x20,%rdx
  100430:	76 5b                	jbe    10048d <set_allocated+0x6f>
		PUT(HDRP(bp), PACK(size, 1));
  100432:	48 89 f1             	mov    %rsi,%rcx
  100435:	48 83 c9 01          	or     $0x1,%rcx
  100439:	48 89 4f f8          	mov    %rcx,-0x8(%rdi)

		void *leftover_mem_ptr = NEXT_BLKP(bp);
  10043d:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  100441:	48 01 fe             	add    %rdi,%rsi

		PUT(HDRP(leftover_mem_ptr), PACK(extra_size, 0));	
  100444:	48 89 56 f8          	mov    %rdx,-0x8(%rsi)
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp); // pointers to the next free blocks
  100448:	48 8b 0f             	mov    (%rdi),%rcx
  10044b:	48 89 0e             	mov    %rcx,(%rsi)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  10044e:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  100452:	48 89 4e 08          	mov    %rcx,0x8(%rsi)
		PUT(FTRP(leftover_mem_ptr), PACK(extra_size, 0));	
  100456:	48 89 d1             	mov    %rdx,%rcx
  100459:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  10045d:	48 89 54 0e f0       	mov    %rdx,-0x10(%rsi,%rcx,1)

		// update the free list
		if (free_list == bp)
  100462:	48 39 3d 9f 1f 00 00 	cmp    %rdi,0x1f9f(%rip)        # 102408 <free_list>
  100469:	74 19                	je     100484 <set_allocated+0x66>
			free_list = leftover_mem_ptr;

		if (PREV_FPTR(bp))
  10046b:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10046f:	48 85 d2             	test   %rdx,%rdx
  100472:	74 03                	je     100477 <set_allocated+0x59>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  100474:	48 89 32             	mov    %rsi,(%rdx)

		if (NEXT_FPTR(bp))
  100477:	48 8b 00             	mov    (%rax),%rax
  10047a:	48 85 c0             	test   %rax,%rax
  10047d:	74 46                	je     1004c5 <set_allocated+0xa7>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  10047f:	48 89 70 08          	mov    %rsi,0x8(%rax)
  100483:	c3                   	ret    
			free_list = leftover_mem_ptr;
  100484:	48 89 35 7d 1f 00 00 	mov    %rsi,0x1f7d(%rip)        # 102408 <free_list>
  10048b:	eb de                	jmp    10046b <set_allocated+0x4d>
								    
	}
	else {
		// update the free list
		if (free_list == bp)
  10048d:	48 39 3d 74 1f 00 00 	cmp    %rdi,0x1f74(%rip)        # 102408 <free_list>
  100494:	74 30                	je     1004c6 <set_allocated+0xa8>
			free_list = NEXT_FPTR(bp);

		if (PREV_FPTR(bp))
  100496:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10049a:	48 85 d2             	test   %rdx,%rdx
  10049d:	74 06                	je     1004a5 <set_allocated+0x87>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  10049f:	48 8b 08             	mov    (%rax),%rcx
  1004a2:	48 89 0a             	mov    %rcx,(%rdx)
		if (NEXT_FPTR(bp))
  1004a5:	48 8b 10             	mov    (%rax),%rdx
  1004a8:	48 85 d2             	test   %rdx,%rdx
  1004ab:	74 08                	je     1004b5 <set_allocated+0x97>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  1004ad:	48 8b 48 08          	mov    0x8(%rax),%rcx
  1004b1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)

		PUT(HDRP(bp), PACK(GET_SIZE(HDRP(bp)), 1));	
  1004b5:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1004b9:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1004bd:	48 83 ca 01          	or     $0x1,%rdx
  1004c1:	48 89 50 f8          	mov    %rdx,-0x8(%rax)
	}
}
  1004c5:	c3                   	ret    
			free_list = NEXT_FPTR(bp);
  1004c6:	48 8b 17             	mov    (%rdi),%rdx
  1004c9:	48 89 15 38 1f 00 00 	mov    %rdx,0x1f38(%rip)        # 102408 <free_list>
  1004d0:	eb c4                	jmp    100496 <set_allocated+0x78>

00000000001004d2 <malloc>:

void *malloc(uint64_t numbytes) {
  1004d2:	55                   	push   %rbp
  1004d3:	48 89 e5             	mov    %rsp,%rbp
  1004d6:	41 55                	push   %r13
  1004d8:	41 54                	push   %r12
  1004da:	53                   	push   %rbx
  1004db:	48 83 ec 08          	sub    $0x8,%rsp
  1004df:	49 89 fc             	mov    %rdi,%r12
	if (!initialized_heap)
  1004e2:	83 3d 2f 1f 00 00 00 	cmpl   $0x0,0x1f2f(%rip)        # 102418 <initialized_heap>
  1004e9:	74 73                	je     10055e <malloc+0x8c>
		heap_init();

	if (numbytes == 0)
  1004eb:	4d 85 e4             	test   %r12,%r12
  1004ee:	0f 84 92 00 00 00    	je     100586 <malloc+0xb4>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  1004f4:	49 83 c4 17          	add    $0x17,%r12
  1004f8:	49 83 e4 f0          	and    $0xfffffffffffffff0,%r12
  1004fc:	b8 20 00 00 00       	mov    $0x20,%eax
  100501:	49 39 c4             	cmp    %rax,%r12
  100504:	4c 0f 42 e0          	cmovb  %rax,%r12
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);
	
	void *bp = free_list;
  100508:	48 8b 1d f9 1e 00 00 	mov    0x1ef9(%rip),%rbx        # 102408 <free_list>
	while (bp) {
  10050f:	48 85 db             	test   %rbx,%rbx
  100512:	74 15                	je     100529 <malloc+0x57>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  100514:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  100518:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  10051c:	4c 39 e0             	cmp    %r12,%rax
  10051f:	73 44                	jae    100565 <malloc+0x93>
			set_allocated(bp, aligned_size);
			num_allocs++;
			return bp;
		}

		bp = NEXT_FPTR(bp);
  100521:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  100524:	48 85 db             	test   %rbx,%rbx
  100527:	75 eb                	jne    100514 <malloc+0x42>
  100529:	bf 00 00 00 00       	mov    $0x0,%edi
  10052e:	cd 3a                	int    $0x3a
  100530:	49 89 c5             	mov    %rax,%r13
  100533:	48 89 05 e6 1e 00 00 	mov    %rax,0x1ee6(%rip)        # 102420 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  10053a:	48 89 c3             	mov    %rax,%rbx
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	if (extend(aligned_size)) {
  10053d:	4c 89 e7             	mov    %r12,%rdi
  100540:	e8 6d fe ff ff       	call   1003b2 <extend>
  100545:	85 c0                	test   %eax,%eax
  100547:	75 44                	jne    10058d <malloc+0xbb>
		return NULL;
	}
	set_allocated(bp, aligned_size);
  100549:	4c 89 e6             	mov    %r12,%rsi
  10054c:	4c 89 ef             	mov    %r13,%rdi
  10054f:	e8 ca fe ff ff       	call   10041e <set_allocated>
	num_allocs++;
  100554:	48 83 05 a4 1e 00 00 	addq   $0x1,0x1ea4(%rip)        # 102400 <num_allocs>
  10055b:	01 
    return bp;
  10055c:	eb 1a                	jmp    100578 <malloc+0xa6>
		heap_init();
  10055e:	e8 92 fd ff ff       	call   1002f5 <heap_init>
  100563:	eb 86                	jmp    1004eb <malloc+0x19>
			set_allocated(bp, aligned_size);
  100565:	4c 89 e6             	mov    %r12,%rsi
  100568:	48 89 df             	mov    %rbx,%rdi
  10056b:	e8 ae fe ff ff       	call   10041e <set_allocated>
			num_allocs++;
  100570:	48 83 05 88 1e 00 00 	addq   $0x1,0x1e88(%rip)        # 102400 <num_allocs>
  100577:	01 
}
  100578:	48 89 d8             	mov    %rbx,%rax
  10057b:	48 83 c4 08          	add    $0x8,%rsp
  10057f:	5b                   	pop    %rbx
  100580:	41 5c                	pop    %r12
  100582:	41 5d                	pop    %r13
  100584:	5d                   	pop    %rbp
  100585:	c3                   	ret    
		return NULL;
  100586:	bb 00 00 00 00       	mov    $0x0,%ebx
  10058b:	eb eb                	jmp    100578 <malloc+0xa6>
		return NULL;
  10058d:	bb 00 00 00 00       	mov    $0x0,%ebx
  100592:	eb e4                	jmp    100578 <malloc+0xa6>

0000000000100594 <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  100594:	55                   	push   %rbp
  100595:	48 89 e5             	mov    %rsp,%rbp
  100598:	41 54                	push   %r12
  10059a:	53                   	push   %rbx
	void *bp = malloc(num * sz);
  10059b:	48 0f af fe          	imul   %rsi,%rdi
  10059f:	49 89 fc             	mov    %rdi,%r12
  1005a2:	e8 2b ff ff ff       	call   1004d2 <malloc>
  1005a7:	48 89 c3             	mov    %rax,%rbx
	if (bp)							// protect against num=0 or size=0
  1005aa:	48 85 c0             	test   %rax,%rax
  1005ad:	74 10                	je     1005bf <calloc+0x2b>
		memset(bp, 0, num * sz);
  1005af:	4c 89 e2             	mov    %r12,%rdx
  1005b2:	be 00 00 00 00       	mov    $0x0,%esi
  1005b7:	48 89 c7             	mov    %rax,%rdi
  1005ba:	e8 dc 04 00 00       	call   100a9b <memset>
	return bp;
}
  1005bf:	48 89 d8             	mov    %rbx,%rax
  1005c2:	5b                   	pop    %rbx
  1005c3:	41 5c                	pop    %r12
  1005c5:	5d                   	pop    %rbp
  1005c6:	c3                   	ret    

00000000001005c7 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  1005c7:	55                   	push   %rbp
  1005c8:	48 89 e5             	mov    %rsp,%rbp
  1005cb:	41 54                	push   %r12
  1005cd:	53                   	push   %rbx
  1005ce:	48 89 fb             	mov    %rdi,%rbx
  1005d1:	48 89 f7             	mov    %rsi,%rdi
	// first check if there's enough space in the block already (and that it's actually valid ptr)
	if (ptr && GET_SIZE(HDRP(ptr)) >= sz)
  1005d4:	48 85 db             	test   %rbx,%rbx
  1005d7:	74 10                	je     1005e9 <realloc+0x22>
  1005d9:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  1005dd:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
		return ptr;
  1005e1:	49 89 dc             	mov    %rbx,%r12
	if (ptr && GET_SIZE(HDRP(ptr)) >= sz)
  1005e4:	48 39 f0             	cmp    %rsi,%rax
  1005e7:	73 23                	jae    10060c <realloc+0x45>

	// else find or add a big enough block, which is what malloc does
	void *bigger_ptr = malloc(sz);
  1005e9:	e8 e4 fe ff ff       	call   1004d2 <malloc>
  1005ee:	49 89 c4             	mov    %rax,%r12
	memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
  1005f1:	48 8b 53 f8          	mov    -0x8(%rbx),%rdx
  1005f5:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1005f9:	48 89 de             	mov    %rbx,%rsi
  1005fc:	48 89 c7             	mov    %rax,%rdi
  1005ff:	e8 99 03 00 00       	call   10099d <memcpy>
	free(ptr);
  100604:	48 89 df             	mov    %rbx,%rdi
  100607:	e8 63 fd ff ff       	call   10036f <free>

    return bigger_ptr;
}
  10060c:	4c 89 e0             	mov    %r12,%rax
  10060f:	5b                   	pop    %rbx
  100610:	41 5c                	pop    %r12
  100612:	5d                   	pop    %rbp
  100613:	c3                   	ret    

0000000000100614 <defrag>:

void defrag() {
	void *fp = free_list;
  100614:	48 8b 15 ed 1d 00 00 	mov    0x1ded(%rip),%rdx        # 102408 <free_list>
	while (fp != NULL) {
  10061b:	48 85 d2             	test   %rdx,%rdx
  10061e:	75 3c                	jne    10065c <defrag+0x48>
		// you only need to check the block after, because if the block before is free, you'll
		// bet there by traversing the free list

		fp = NEXT_FPTR(fp);
	}
}
  100620:	c3                   	ret    
				free_list = NEXT_FPTR(next_block);
  100621:	48 8b 08             	mov    (%rax),%rcx
  100624:	48 89 0d dd 1d 00 00 	mov    %rcx,0x1ddd(%rip)        # 102408 <free_list>
  10062b:	eb 49                	jmp    100676 <defrag+0x62>
			PUT(HDRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  10062d:	48 8b 4a f8          	mov    -0x8(%rdx),%rcx
  100631:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  100635:	48 8b 70 f8          	mov    -0x8(%rax),%rsi
  100639:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  10063d:	48 01 f1             	add    %rsi,%rcx
  100640:	48 89 4a f8          	mov    %rcx,-0x8(%rdx)
			PUT(FTRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  100644:	48 8b 40 f8          	mov    -0x8(%rax),%rax
  100648:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  10064c:	48 01 c8             	add    %rcx,%rax
  10064f:	48 89 44 0a f0       	mov    %rax,-0x10(%rdx,%rcx,1)
		fp = NEXT_FPTR(fp);
  100654:	48 8b 12             	mov    (%rdx),%rdx
	while (fp != NULL) {
  100657:	48 85 d2             	test   %rdx,%rdx
  10065a:	74 c4                	je     100620 <defrag+0xc>
		void *next_block = NEXT_BLKP(fp);
  10065c:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  100660:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100664:	48 01 d0             	add    %rdx,%rax
		if (!GET_ALLOC(HDRP(next_block))) {
  100667:	f6 40 f8 01          	testb  $0x1,-0x8(%rax)
  10066b:	75 e7                	jne    100654 <defrag+0x40>
			if (free_list == next_block)
  10066d:	48 39 05 94 1d 00 00 	cmp    %rax,0x1d94(%rip)        # 102408 <free_list>
  100674:	74 ab                	je     100621 <defrag+0xd>
			if (PREV_FPTR(next_block)) 
  100676:	48 8b 48 08          	mov    0x8(%rax),%rcx
  10067a:	48 85 c9             	test   %rcx,%rcx
  10067d:	74 06                	je     100685 <defrag+0x71>
				NEXT_FPTR(PREV_FPTR(next_block)) = NEXT_FPTR(next_block);
  10067f:	48 8b 30             	mov    (%rax),%rsi
  100682:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(next_block)) 
  100685:	48 8b 08             	mov    (%rax),%rcx
  100688:	48 85 c9             	test   %rcx,%rcx
  10068b:	74 a0                	je     10062d <defrag+0x19>
				PREV_FPTR(NEXT_FPTR(next_block)) = PREV_FPTR(next_block);
  10068d:	48 8b 70 08          	mov    0x8(%rax),%rsi
  100691:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  100695:	eb 96                	jmp    10062d <defrag+0x19>

0000000000100697 <sift_down>:
// heap sort stuff that operates on the pointer array
#define LEFT_CHILD(x) (2*x + 1)
#define RIGHT_CHILD(x) (2*x + 2)
#define PARENT(x) ((x-1)/2)

void sift_down(void **arr, size_t pos, size_t arr_len) {
  100697:	48 89 f1             	mov    %rsi,%rcx
  10069a:	49 89 d3             	mov    %rdx,%r11
	while (LEFT_CHILD(pos) < arr_len) {
  10069d:	48 8d 74 36 01       	lea    0x1(%rsi,%rsi,1),%rsi
  1006a2:	48 39 d6             	cmp    %rdx,%rsi
  1006a5:	72 3a                	jb     1006e1 <sift_down+0x4a>
  1006a7:	c3                   	ret    
  1006a8:	48 89 f0             	mov    %rsi,%rax
		size_t smaller = LEFT_CHILD(pos);
		if (RIGHT_CHILD(pos) < arr_len && GET_SIZE(HDRP(arr[RIGHT_CHILD(pos)])) < GET_SIZE(HDRP(arr[LEFT_CHILD(pos)]))){
			smaller = RIGHT_CHILD(pos);
		}

		if (GET_SIZE(HDRP(arr[pos])) > GET_SIZE(HDRP(arr[smaller]))) {
  1006ab:	4c 8d 0c cf          	lea    (%rdi,%rcx,8),%r9
  1006af:	4d 8b 01             	mov    (%r9),%r8
  1006b2:	48 8d 34 c7          	lea    (%rdi,%rax,8),%rsi
  1006b6:	4c 8b 16             	mov    (%rsi),%r10
  1006b9:	49 8b 50 f8          	mov    -0x8(%r8),%rdx
  1006bd:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1006c1:	49 8b 4a f8          	mov    -0x8(%r10),%rcx
  1006c5:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  1006c9:	48 39 d1             	cmp    %rdx,%rcx
  1006cc:	73 46                	jae    100714 <sift_down+0x7d>
			void *temp = arr[pos];
			arr[pos] = arr[smaller];
  1006ce:	4d 89 11             	mov    %r10,(%r9)
			arr[smaller] = temp;
  1006d1:	4c 89 06             	mov    %r8,(%rsi)
	while (LEFT_CHILD(pos) < arr_len) {
  1006d4:	48 8d 74 00 01       	lea    0x1(%rax,%rax,1),%rsi
  1006d9:	4c 39 de             	cmp    %r11,%rsi
  1006dc:	73 36                	jae    100714 <sift_down+0x7d>
			pos = smaller;
  1006de:	48 89 c1             	mov    %rax,%rcx
		if (RIGHT_CHILD(pos) < arr_len && GET_SIZE(HDRP(arr[RIGHT_CHILD(pos)])) < GET_SIZE(HDRP(arr[LEFT_CHILD(pos)]))){
  1006e1:	48 8d 51 01          	lea    0x1(%rcx),%rdx
  1006e5:	48 8d 04 12          	lea    (%rdx,%rdx,1),%rax
  1006e9:	4c 39 d8             	cmp    %r11,%rax
  1006ec:	73 ba                	jae    1006a8 <sift_down+0x11>
  1006ee:	48 c1 e2 04          	shl    $0x4,%rdx
  1006f2:	4c 8b 04 17          	mov    (%rdi,%rdx,1),%r8
  1006f6:	4d 8b 40 f8          	mov    -0x8(%r8),%r8
  1006fa:	49 83 e0 f0          	and    $0xfffffffffffffff0,%r8
  1006fe:	48 8b 54 17 f8       	mov    -0x8(%rdi,%rdx,1),%rdx
  100703:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  100707:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  10070b:	49 39 d0             	cmp    %rdx,%r8
  10070e:	48 0f 43 c6          	cmovae %rsi,%rax
  100712:	eb 97                	jmp    1006ab <sift_down+0x14>
		}
		else {
			break;
		}
	}
}
  100714:	c3                   	ret    

0000000000100715 <heapify>:

void heapify(void **arr, size_t arr_len) {
  100715:	55                   	push   %rbp
  100716:	48 89 e5             	mov    %rsp,%rbp
  100719:	41 56                	push   %r14
  10071b:	41 55                	push   %r13
  10071d:	41 54                	push   %r12
  10071f:	53                   	push   %rbx
	for (int i = arr_len - 1; i >= 0; i--) {
  100720:	41 89 f5             	mov    %esi,%r13d
  100723:	41 83 ed 01          	sub    $0x1,%r13d
  100727:	78 28                	js     100751 <heapify+0x3c>
  100729:	49 89 fe             	mov    %rdi,%r14
  10072c:	49 89 f4             	mov    %rsi,%r12
  10072f:	49 63 c5             	movslq %r13d,%rax
  100732:	48 89 c3             	mov    %rax,%rbx
  100735:	41 29 c5             	sub    %eax,%r13d
		sift_down(arr, i, arr_len);
  100738:	4c 89 e2             	mov    %r12,%rdx
  10073b:	48 89 de             	mov    %rbx,%rsi
  10073e:	4c 89 f7             	mov    %r14,%rdi
  100741:	e8 51 ff ff ff       	call   100697 <sift_down>
	for (int i = arr_len - 1; i >= 0; i--) {
  100746:	48 83 eb 01          	sub    $0x1,%rbx
  10074a:	44 89 e8             	mov    %r13d,%eax
  10074d:	01 d8                	add    %ebx,%eax
  10074f:	79 e7                	jns    100738 <heapify+0x23>
	}
}
  100751:	5b                   	pop    %rbx
  100752:	41 5c                	pop    %r12
  100754:	41 5d                	pop    %r13
  100756:	41 5e                	pop    %r14
  100758:	5d                   	pop    %rbp
  100759:	c3                   	ret    

000000000010075a <heapsort>:

void heapsort(void **arr, size_t arr_len) {
  10075a:	55                   	push   %rbp
  10075b:	48 89 e5             	mov    %rsp,%rbp
  10075e:	41 54                	push   %r12
  100760:	53                   	push   %rbx
  100761:	49 89 fc             	mov    %rdi,%r12
  100764:	48 89 f3             	mov    %rsi,%rbx
	heapify(arr, arr_len);
  100767:	e8 a9 ff ff ff       	call   100715 <heapify>
	if (arr_len == 0)
  10076c:	48 85 db             	test   %rbx,%rbx
  10076f:	74 30                	je     1007a1 <heapsort+0x47>
		return;
	for (int i = arr_len - 1; i >= 0; i--) {
  100771:	83 eb 01             	sub    $0x1,%ebx
  100774:	78 2b                	js     1007a1 <heapsort+0x47>
  100776:	48 63 db             	movslq %ebx,%rbx
		void *temp = arr[0];
  100779:	49 8b 04 24          	mov    (%r12),%rax
		arr[0] = arr[i];
  10077d:	49 8b 14 dc          	mov    (%r12,%rbx,8),%rdx
  100781:	49 89 14 24          	mov    %rdx,(%r12)
		arr[i] = temp;
  100785:	49 89 04 dc          	mov    %rax,(%r12,%rbx,8)
		sift_down(arr, 0, i);
  100789:	48 89 da             	mov    %rbx,%rdx
  10078c:	be 00 00 00 00       	mov    $0x0,%esi
  100791:	4c 89 e7             	mov    %r12,%rdi
  100794:	e8 fe fe ff ff       	call   100697 <sift_down>
	for (int i = arr_len - 1; i >= 0; i--) {
  100799:	48 83 eb 01          	sub    $0x1,%rbx
  10079d:	85 db                	test   %ebx,%ebx
  10079f:	79 d8                	jns    100779 <heapsort+0x1f>
	}
}
  1007a1:	5b                   	pop    %rbx
  1007a2:	41 5c                	pop    %r12
  1007a4:	5d                   	pop    %rbp
  1007a5:	c3                   	ret    

00000000001007a6 <heap_info>:

int heap_info(heap_info_struct *info) {
  1007a6:	55                   	push   %rbp
  1007a7:	48 89 e5             	mov    %rsp,%rbp
  1007aa:	41 54                	push   %r12
  1007ac:	53                   	push   %rbx
  1007ad:	48 89 fb             	mov    %rdi,%rbx
	info->num_allocs = num_allocs+2;		// +2 for the two arrays we need
  1007b0:	8b 05 4a 1c 00 00    	mov    0x1c4a(%rip),%eax        # 102400 <num_allocs>
  1007b6:	83 c0 02             	add    $0x2,%eax
  1007b9:	89 07                	mov    %eax,(%rdi)
	info->free_space = 0;
  1007bb:	c7 47 18 00 00 00 00 	movl   $0x0,0x18(%rdi)
	info->largest_free_chunk = 0;
  1007c2:	c7 47 1c 00 00 00 00 	movl   $0x0,0x1c(%rdi)

	info->size_array = sbrk(ALIGN(info->num_allocs * sizeof(long) + OVERHEAD));
  1007c9:	48 98                	cltq   
  1007cb:	48 8d 3c c5 17 00 00 	lea    0x17(,%rax,8),%rdi
  1007d2:	00 
  1007d3:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
    asm volatile ("int %1" :  "=a" (result)
  1007d7:	cd 3a                	int    $0x3a
  1007d9:	48 89 05 40 1c 00 00 	mov    %rax,0x1c40(%rip)        # 102420 <result.0>
  1007e0:	48 89 43 08          	mov    %rax,0x8(%rbx)
	if (info->ptr_array == (void *)-1) { // nothing happens on failure
  1007e4:	48 83 7b 10 ff       	cmpq   $0xffffffffffffffff,0x10(%rbx)
  1007e9:	0f 84 a0 01 00 00    	je     10098f <heap_info+0x1e9>
		return -1;
	}
	info->ptr_array = sbrk(ALIGN(info->num_allocs * sizeof(void *) + OVERHEAD));
  1007ef:	48 63 03             	movslq (%rbx),%rax
  1007f2:	48 8d 3c c5 17 00 00 	lea    0x17(,%rax,8),%rdi
  1007f9:	00 
  1007fa:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
  1007fe:	cd 3a                	int    $0x3a
  100800:	48 89 05 19 1c 00 00 	mov    %rax,0x1c19(%rip)        # 102420 <result.0>
  100807:	48 89 43 10          	mov    %rax,0x10(%rbx)
	if (info->ptr_array == (void *)-1) {
  10080b:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  10080f:	74 72                	je     100883 <heap_info+0xdd>
		sbrk(-ALIGN(info->num_allocs * sizeof(long) + OVERHEAD));
		return -1;
	}

	// we manually fill in array metadata
	PUT(HDRP(info->size_array), PACK(ALIGN(info->num_allocs * sizeof(long) + OVERHEAD), 1));
  100811:	48 8b 53 08          	mov    0x8(%rbx),%rdx
  100815:	48 63 03             	movslq (%rbx),%rax
  100818:	48 8d 04 c5 17 00 00 	lea    0x17(,%rax,8),%rax
  10081f:	00 
  100820:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100824:	48 83 c8 01          	or     $0x1,%rax
  100828:	48 89 42 f8          	mov    %rax,-0x8(%rdx)
	PUT(HDRP(info->ptr_array), PACK(ALIGN(info->num_allocs * sizeof(void *) + OVERHEAD), 1));
  10082c:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  100830:	48 63 03             	movslq (%rbx),%rax
  100833:	48 8d 04 c5 17 00 00 	lea    0x17(,%rax,8),%rax
  10083a:	00 
  10083b:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  10083f:	48 83 c8 01          	or     $0x1,%rax
  100843:	48 89 42 f8          	mov    %rax,-0x8(%rdx)

	// terminal block
	PUT(HDRP(NEXT_BLKP(info->ptr_array)), PACK(0, 1));
  100847:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  10084b:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  10084f:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100853:	48 c7 44 02 f8 01 00 	movq   $0x1,-0x8(%rdx,%rax,1)
  10085a:	00 00 

	// collect all the information by traversing through the heap
	void *bp = NEXT_BLKP(prologue_block); // because the prologue isn't actually allocated
  10085c:	48 8b 05 ad 1b 00 00 	mov    0x1bad(%rip),%rax        # 102410 <prologue_block>
  100863:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  100867:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  10086b:	48 01 d0             	add    %rdx,%rax
	size_t arr_index = 0;
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  10086e:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  100872:	48 83 fa 0f          	cmp    $0xf,%rdx
  100876:	0f 86 84 00 00 00    	jbe    100900 <heap_info+0x15a>
	size_t arr_index = 0;
  10087c:	b9 00 00 00 00       	mov    $0x0,%ecx
  100881:	eb 5a                	jmp    1008dd <heap_info+0x137>
		sbrk(-ALIGN(info->num_allocs * sizeof(long) + OVERHEAD));
  100883:	48 63 03             	movslq (%rbx),%rax
  100886:	48 8d 3c c5 17 00 00 	lea    0x17(,%rax,8),%rdi
  10088d:	00 
  10088e:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
  100892:	48 f7 df             	neg    %rdi
  100895:	cd 3a                	int    $0x3a
  100897:	48 89 05 82 1b 00 00 	mov    %rax,0x1b82(%rip)        # 102420 <result.0>
		return -1;
  10089e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1008a3:	e9 e2 00 00 00       	jmp    10098a <heap_info+0x1e4>
			info->ptr_array[arr_index] = bp;
			info->size_array[arr_index] = GET_SIZE(HDRP(bp));
			arr_index++;
		}
		else {
			info->free_space += GET_SIZE(HDRP(bp));
  1008a8:	83 e2 f0             	and    $0xfffffff0,%edx
  1008ab:	01 53 18             	add    %edx,0x18(%rbx)
			if(GET_SIZE(HDRP(bp)) > (size_t) (info->largest_free_chunk)) {
  1008ae:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1008b2:	48 89 d6             	mov    %rdx,%rsi
  1008b5:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  1008b9:	48 63 7b 1c          	movslq 0x1c(%rbx),%rdi
  1008bd:	48 39 f7             	cmp    %rsi,%rdi
  1008c0:	73 06                	jae    1008c8 <heap_info+0x122>
				info->largest_free_chunk = GET_SIZE(HDRP(bp));
  1008c2:	83 e2 f0             	and    $0xfffffff0,%edx
  1008c5:	89 53 1c             	mov    %edx,0x1c(%rbx)
			}
		}

		bp = NEXT_BLKP(bp);
  1008c8:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1008cc:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1008d0:	48 01 d0             	add    %rdx,%rax
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  1008d3:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1008d7:	48 83 fa 0f          	cmp    $0xf,%rdx
  1008db:	76 23                	jbe    100900 <heap_info+0x15a>
		if (GET_ALLOC(HDRP(bp))) {
  1008dd:	f6 c2 01             	test   $0x1,%dl
  1008e0:	74 c6                	je     1008a8 <heap_info+0x102>
			info->ptr_array[arr_index] = bp;
  1008e2:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  1008e6:	48 89 04 ca          	mov    %rax,(%rdx,%rcx,8)
			info->size_array[arr_index] = GET_SIZE(HDRP(bp));
  1008ea:	48 8b 73 08          	mov    0x8(%rbx),%rsi
  1008ee:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1008f2:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1008f6:	48 89 14 ce          	mov    %rdx,(%rsi,%rcx,8)
			arr_index++;
  1008fa:	48 83 c1 01          	add    $0x1,%rcx
  1008fe:	eb c8                	jmp    1008c8 <heap_info+0x122>
	}

	app_printf(0xa00, "heap_info print:\n");
  100900:	be 0a 1b 10 00       	mov    $0x101b0a,%esi
  100905:	bf 00 0a 00 00       	mov    $0xa00,%edi
  10090a:	b8 00 00 00 00       	mov    $0x0,%eax
  10090f:	e8 54 f8 ff ff       	call   100168 <app_printf>
	for(int  i = 0 ; i < info->num_allocs; i++){
  100914:	8b 33                	mov    (%rbx),%esi
  100916:	85 f6                	test   %esi,%esi
  100918:	7e 35                	jle    10094f <heap_info+0x1a9>
  10091a:	41 bc 00 00 00 00    	mov    $0x0,%r12d
		app_printf(0x700, "    ptr: %p, size: 0x%lx\n", info->ptr_array[i], info->size_array[i]);;
  100920:	48 8b 43 08          	mov    0x8(%rbx),%rax
  100924:	4a 8b 0c e0          	mov    (%rax,%r12,8),%rcx
  100928:	48 8b 43 10          	mov    0x10(%rbx),%rax
  10092c:	4a 8b 14 e0          	mov    (%rax,%r12,8),%rdx
  100930:	be 1c 1b 10 00       	mov    $0x101b1c,%esi
  100935:	bf 00 07 00 00       	mov    $0x700,%edi
  10093a:	b8 00 00 00 00       	mov    $0x0,%eax
  10093f:	e8 24 f8 ff ff       	call   100168 <app_printf>
	for(int  i = 0 ; i < info->num_allocs; i++){
  100944:	8b 33                	mov    (%rbx),%esi
  100946:	49 83 c4 01          	add    $0x1,%r12
  10094a:	44 39 e6             	cmp    %r12d,%esi
  10094d:	7f d1                	jg     100920 <heap_info+0x17a>
	}
	// we just need to sort the arrays...
	// we'll use heapsort
	heapsort(info->ptr_array, info->num_allocs);
  10094f:	48 63 f6             	movslq %esi,%rsi
  100952:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
  100956:	e8 ff fd ff ff       	call   10075a <heapsort>
	for (int i = 0; i < info->num_allocs; i++)
  10095b:	83 3b 00             	cmpl   $0x0,(%rbx)
  10095e:	7e 36                	jle    100996 <heap_info+0x1f0>
  100960:	b8 00 00 00 00       	mov    $0x0,%eax
		info->size_array[i] = GET_SIZE(HDRP(info->ptr_array[i]));
  100965:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
  100969:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  10096d:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
  100971:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  100975:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100979:	48 89 14 c1          	mov    %rdx,(%rcx,%rax,8)
	for (int i = 0; i < info->num_allocs; i++)
  10097d:	48 83 c0 01          	add    $0x1,%rax
  100981:	39 03                	cmp    %eax,(%rbx)
  100983:	7f e0                	jg     100965 <heap_info+0x1bf>

    return 0;
  100985:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10098a:	5b                   	pop    %rbx
  10098b:	41 5c                	pop    %r12
  10098d:	5d                   	pop    %rbp
  10098e:	c3                   	ret    
		return -1;
  10098f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100994:	eb f4                	jmp    10098a <heap_info+0x1e4>
    return 0;
  100996:	b8 00 00 00 00       	mov    $0x0,%eax
  10099b:	eb ed                	jmp    10098a <heap_info+0x1e4>

000000000010099d <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  10099d:	55                   	push   %rbp
  10099e:	48 89 e5             	mov    %rsp,%rbp
  1009a1:	48 83 ec 28          	sub    $0x28,%rsp
  1009a5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1009a9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1009ad:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1009b1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1009b5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1009b9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1009bd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  1009c1:	eb 1c                	jmp    1009df <memcpy+0x42>
        *d = *s;
  1009c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009c7:	0f b6 10             	movzbl (%rax),%edx
  1009ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1009ce:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1009d0:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1009d5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1009da:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1009df:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1009e4:	75 dd                	jne    1009c3 <memcpy+0x26>
    }
    return dst;
  1009e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1009ea:	c9                   	leave  
  1009eb:	c3                   	ret    

00000000001009ec <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1009ec:	55                   	push   %rbp
  1009ed:	48 89 e5             	mov    %rsp,%rbp
  1009f0:	48 83 ec 28          	sub    $0x28,%rsp
  1009f4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1009f8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1009fc:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100a00:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100a04:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  100a08:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100a0c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100a10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a14:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  100a18:	73 6a                	jae    100a84 <memmove+0x98>
  100a1a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100a1e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100a22:	48 01 d0             	add    %rdx,%rax
  100a25:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100a29:	73 59                	jae    100a84 <memmove+0x98>
        s += n, d += n;
  100a2b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100a2f:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100a33:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100a37:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  100a3b:	eb 17                	jmp    100a54 <memmove+0x68>
            *--d = *--s;
  100a3d:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100a42:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100a47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a4b:	0f b6 10             	movzbl (%rax),%edx
  100a4e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100a52:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100a54:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100a58:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100a5c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100a60:	48 85 c0             	test   %rax,%rax
  100a63:	75 d8                	jne    100a3d <memmove+0x51>
    if (s < d && s + n > d) {
  100a65:	eb 2e                	jmp    100a95 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100a67:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100a6b:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100a6f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100a73:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100a77:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100a7b:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100a7f:	0f b6 12             	movzbl (%rdx),%edx
  100a82:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100a84:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100a88:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100a8c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100a90:	48 85 c0             	test   %rax,%rax
  100a93:	75 d2                	jne    100a67 <memmove+0x7b>
        }
    }
    return dst;
  100a95:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100a99:	c9                   	leave  
  100a9a:	c3                   	ret    

0000000000100a9b <memset>:

void* memset(void* v, int c, size_t n) {
  100a9b:	55                   	push   %rbp
  100a9c:	48 89 e5             	mov    %rsp,%rbp
  100a9f:	48 83 ec 28          	sub    $0x28,%rsp
  100aa3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100aa7:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100aaa:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100aae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100ab2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100ab6:	eb 15                	jmp    100acd <memset+0x32>
        *p = c;
  100ab8:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100abb:	89 c2                	mov    %eax,%edx
  100abd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100ac1:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100ac3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100ac8:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100acd:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100ad2:	75 e4                	jne    100ab8 <memset+0x1d>
    }
    return v;
  100ad4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100ad8:	c9                   	leave  
  100ad9:	c3                   	ret    

0000000000100ada <strlen>:

size_t strlen(const char* s) {
  100ada:	55                   	push   %rbp
  100adb:	48 89 e5             	mov    %rsp,%rbp
  100ade:	48 83 ec 18          	sub    $0x18,%rsp
  100ae2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100ae6:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100aed:	00 
  100aee:	eb 0a                	jmp    100afa <strlen+0x20>
        ++n;
  100af0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100af5:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100afa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100afe:	0f b6 00             	movzbl (%rax),%eax
  100b01:	84 c0                	test   %al,%al
  100b03:	75 eb                	jne    100af0 <strlen+0x16>
    }
    return n;
  100b05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100b09:	c9                   	leave  
  100b0a:	c3                   	ret    

0000000000100b0b <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100b0b:	55                   	push   %rbp
  100b0c:	48 89 e5             	mov    %rsp,%rbp
  100b0f:	48 83 ec 20          	sub    $0x20,%rsp
  100b13:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100b17:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100b1b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100b22:	00 
  100b23:	eb 0a                	jmp    100b2f <strnlen+0x24>
        ++n;
  100b25:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100b2a:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100b2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b33:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100b37:	74 0b                	je     100b44 <strnlen+0x39>
  100b39:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100b3d:	0f b6 00             	movzbl (%rax),%eax
  100b40:	84 c0                	test   %al,%al
  100b42:	75 e1                	jne    100b25 <strnlen+0x1a>
    }
    return n;
  100b44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100b48:	c9                   	leave  
  100b49:	c3                   	ret    

0000000000100b4a <strcpy>:

char* strcpy(char* dst, const char* src) {
  100b4a:	55                   	push   %rbp
  100b4b:	48 89 e5             	mov    %rsp,%rbp
  100b4e:	48 83 ec 20          	sub    $0x20,%rsp
  100b52:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100b56:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  100b5a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100b5e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100b62:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100b66:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100b6a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100b6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b72:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100b76:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100b7a:	0f b6 12             	movzbl (%rdx),%edx
  100b7d:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100b7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b83:	48 83 e8 01          	sub    $0x1,%rax
  100b87:	0f b6 00             	movzbl (%rax),%eax
  100b8a:	84 c0                	test   %al,%al
  100b8c:	75 d4                	jne    100b62 <strcpy+0x18>
    return dst;
  100b8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100b92:	c9                   	leave  
  100b93:	c3                   	ret    

0000000000100b94 <strcmp>:

int strcmp(const char* a, const char* b) {
  100b94:	55                   	push   %rbp
  100b95:	48 89 e5             	mov    %rsp,%rbp
  100b98:	48 83 ec 10          	sub    $0x10,%rsp
  100b9c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100ba0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100ba4:	eb 0a                	jmp    100bb0 <strcmp+0x1c>
        ++a, ++b;
  100ba6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100bab:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100bb0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100bb4:	0f b6 00             	movzbl (%rax),%eax
  100bb7:	84 c0                	test   %al,%al
  100bb9:	74 1d                	je     100bd8 <strcmp+0x44>
  100bbb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100bbf:	0f b6 00             	movzbl (%rax),%eax
  100bc2:	84 c0                	test   %al,%al
  100bc4:	74 12                	je     100bd8 <strcmp+0x44>
  100bc6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100bca:	0f b6 10             	movzbl (%rax),%edx
  100bcd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100bd1:	0f b6 00             	movzbl (%rax),%eax
  100bd4:	38 c2                	cmp    %al,%dl
  100bd6:	74 ce                	je     100ba6 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100bd8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100bdc:	0f b6 00             	movzbl (%rax),%eax
  100bdf:	89 c2                	mov    %eax,%edx
  100be1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100be5:	0f b6 00             	movzbl (%rax),%eax
  100be8:	38 d0                	cmp    %dl,%al
  100bea:	0f 92 c0             	setb   %al
  100bed:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100bf0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100bf4:	0f b6 00             	movzbl (%rax),%eax
  100bf7:	89 c1                	mov    %eax,%ecx
  100bf9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100bfd:	0f b6 00             	movzbl (%rax),%eax
  100c00:	38 c1                	cmp    %al,%cl
  100c02:	0f 92 c0             	setb   %al
  100c05:	0f b6 c0             	movzbl %al,%eax
  100c08:	29 c2                	sub    %eax,%edx
  100c0a:	89 d0                	mov    %edx,%eax
}
  100c0c:	c9                   	leave  
  100c0d:	c3                   	ret    

0000000000100c0e <strchr>:

char* strchr(const char* s, int c) {
  100c0e:	55                   	push   %rbp
  100c0f:	48 89 e5             	mov    %rsp,%rbp
  100c12:	48 83 ec 10          	sub    $0x10,%rsp
  100c16:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100c1a:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100c1d:	eb 05                	jmp    100c24 <strchr+0x16>
        ++s;
  100c1f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100c24:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c28:	0f b6 00             	movzbl (%rax),%eax
  100c2b:	84 c0                	test   %al,%al
  100c2d:	74 0e                	je     100c3d <strchr+0x2f>
  100c2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c33:	0f b6 00             	movzbl (%rax),%eax
  100c36:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100c39:	38 d0                	cmp    %dl,%al
  100c3b:	75 e2                	jne    100c1f <strchr+0x11>
    }
    if (*s == (char) c) {
  100c3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c41:	0f b6 00             	movzbl (%rax),%eax
  100c44:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100c47:	38 d0                	cmp    %dl,%al
  100c49:	75 06                	jne    100c51 <strchr+0x43>
        return (char*) s;
  100c4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c4f:	eb 05                	jmp    100c56 <strchr+0x48>
    } else {
        return NULL;
  100c51:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100c56:	c9                   	leave  
  100c57:	c3                   	ret    

0000000000100c58 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100c58:	55                   	push   %rbp
  100c59:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  100c5c:	8b 05 c6 17 00 00    	mov    0x17c6(%rip),%eax        # 102428 <rand_seed_set>
  100c62:	85 c0                	test   %eax,%eax
  100c64:	75 0a                	jne    100c70 <rand+0x18>
        srand(819234718U);
  100c66:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100c6b:	e8 24 00 00 00       	call   100c94 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100c70:	8b 05 b6 17 00 00    	mov    0x17b6(%rip),%eax        # 10242c <rand_seed>
  100c76:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100c7c:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100c81:	89 05 a5 17 00 00    	mov    %eax,0x17a5(%rip)        # 10242c <rand_seed>
    return rand_seed & RAND_MAX;
  100c87:	8b 05 9f 17 00 00    	mov    0x179f(%rip),%eax        # 10242c <rand_seed>
  100c8d:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100c92:	5d                   	pop    %rbp
  100c93:	c3                   	ret    

0000000000100c94 <srand>:

void srand(unsigned seed) {
  100c94:	55                   	push   %rbp
  100c95:	48 89 e5             	mov    %rsp,%rbp
  100c98:	48 83 ec 08          	sub    $0x8,%rsp
  100c9c:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100c9f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100ca2:	89 05 84 17 00 00    	mov    %eax,0x1784(%rip)        # 10242c <rand_seed>
    rand_seed_set = 1;
  100ca8:	c7 05 76 17 00 00 01 	movl   $0x1,0x1776(%rip)        # 102428 <rand_seed_set>
  100caf:	00 00 00 
}
  100cb2:	90                   	nop
  100cb3:	c9                   	leave  
  100cb4:	c3                   	ret    

0000000000100cb5 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100cb5:	55                   	push   %rbp
  100cb6:	48 89 e5             	mov    %rsp,%rbp
  100cb9:	48 83 ec 28          	sub    $0x28,%rsp
  100cbd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100cc1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100cc5:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100cc8:	48 c7 45 f8 20 1d 10 	movq   $0x101d20,-0x8(%rbp)
  100ccf:	00 
    if (base < 0) {
  100cd0:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100cd4:	79 0b                	jns    100ce1 <fill_numbuf+0x2c>
        digits = lower_digits;
  100cd6:	48 c7 45 f8 40 1d 10 	movq   $0x101d40,-0x8(%rbp)
  100cdd:	00 
        base = -base;
  100cde:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100ce1:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100ce6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100cea:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100ced:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100cf0:	48 63 c8             	movslq %eax,%rcx
  100cf3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100cf7:	ba 00 00 00 00       	mov    $0x0,%edx
  100cfc:	48 f7 f1             	div    %rcx
  100cff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100d03:	48 01 d0             	add    %rdx,%rax
  100d06:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100d0b:	0f b6 10             	movzbl (%rax),%edx
  100d0e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100d12:	88 10                	mov    %dl,(%rax)
        val /= base;
  100d14:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100d17:	48 63 f0             	movslq %eax,%rsi
  100d1a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100d1e:	ba 00 00 00 00       	mov    $0x0,%edx
  100d23:	48 f7 f6             	div    %rsi
  100d26:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100d2a:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100d2f:	75 bc                	jne    100ced <fill_numbuf+0x38>
    return numbuf_end;
  100d31:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100d35:	c9                   	leave  
  100d36:	c3                   	ret    

0000000000100d37 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100d37:	55                   	push   %rbp
  100d38:	48 89 e5             	mov    %rsp,%rbp
  100d3b:	53                   	push   %rbx
  100d3c:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100d43:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100d4a:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100d50:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100d57:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100d5e:	e9 8a 09 00 00       	jmp    1016ed <printer_vprintf+0x9b6>
        if (*format != '%') {
  100d63:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d6a:	0f b6 00             	movzbl (%rax),%eax
  100d6d:	3c 25                	cmp    $0x25,%al
  100d6f:	74 31                	je     100da2 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  100d71:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d78:	4c 8b 00             	mov    (%rax),%r8
  100d7b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d82:	0f b6 00             	movzbl (%rax),%eax
  100d85:	0f b6 c8             	movzbl %al,%ecx
  100d88:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100d8e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d95:	89 ce                	mov    %ecx,%esi
  100d97:	48 89 c7             	mov    %rax,%rdi
  100d9a:	41 ff d0             	call   *%r8
            continue;
  100d9d:	e9 43 09 00 00       	jmp    1016e5 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100da2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100da9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100db0:	01 
  100db1:	eb 44                	jmp    100df7 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  100db3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100dba:	0f b6 00             	movzbl (%rax),%eax
  100dbd:	0f be c0             	movsbl %al,%eax
  100dc0:	89 c6                	mov    %eax,%esi
  100dc2:	bf 40 1b 10 00       	mov    $0x101b40,%edi
  100dc7:	e8 42 fe ff ff       	call   100c0e <strchr>
  100dcc:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100dd0:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100dd5:	74 30                	je     100e07 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  100dd7:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100ddb:	48 2d 40 1b 10 00    	sub    $0x101b40,%rax
  100de1:	ba 01 00 00 00       	mov    $0x1,%edx
  100de6:	89 c1                	mov    %eax,%ecx
  100de8:	d3 e2                	shl    %cl,%edx
  100dea:	89 d0                	mov    %edx,%eax
  100dec:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100def:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100df6:	01 
  100df7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100dfe:	0f b6 00             	movzbl (%rax),%eax
  100e01:	84 c0                	test   %al,%al
  100e03:	75 ae                	jne    100db3 <printer_vprintf+0x7c>
  100e05:	eb 01                	jmp    100e08 <printer_vprintf+0xd1>
            } else {
                break;
  100e07:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100e08:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100e0f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e16:	0f b6 00             	movzbl (%rax),%eax
  100e19:	3c 30                	cmp    $0x30,%al
  100e1b:	7e 67                	jle    100e84 <printer_vprintf+0x14d>
  100e1d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e24:	0f b6 00             	movzbl (%rax),%eax
  100e27:	3c 39                	cmp    $0x39,%al
  100e29:	7f 59                	jg     100e84 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100e2b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100e32:	eb 2e                	jmp    100e62 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100e34:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100e37:	89 d0                	mov    %edx,%eax
  100e39:	c1 e0 02             	shl    $0x2,%eax
  100e3c:	01 d0                	add    %edx,%eax
  100e3e:	01 c0                	add    %eax,%eax
  100e40:	89 c1                	mov    %eax,%ecx
  100e42:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e49:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100e4d:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100e54:	0f b6 00             	movzbl (%rax),%eax
  100e57:	0f be c0             	movsbl %al,%eax
  100e5a:	01 c8                	add    %ecx,%eax
  100e5c:	83 e8 30             	sub    $0x30,%eax
  100e5f:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100e62:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e69:	0f b6 00             	movzbl (%rax),%eax
  100e6c:	3c 2f                	cmp    $0x2f,%al
  100e6e:	0f 8e 85 00 00 00    	jle    100ef9 <printer_vprintf+0x1c2>
  100e74:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e7b:	0f b6 00             	movzbl (%rax),%eax
  100e7e:	3c 39                	cmp    $0x39,%al
  100e80:	7e b2                	jle    100e34 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100e82:	eb 75                	jmp    100ef9 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100e84:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e8b:	0f b6 00             	movzbl (%rax),%eax
  100e8e:	3c 2a                	cmp    $0x2a,%al
  100e90:	75 68                	jne    100efa <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100e92:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e99:	8b 00                	mov    (%rax),%eax
  100e9b:	83 f8 2f             	cmp    $0x2f,%eax
  100e9e:	77 30                	ja     100ed0 <printer_vprintf+0x199>
  100ea0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ea7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100eab:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100eb2:	8b 00                	mov    (%rax),%eax
  100eb4:	89 c0                	mov    %eax,%eax
  100eb6:	48 01 d0             	add    %rdx,%rax
  100eb9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ec0:	8b 12                	mov    (%rdx),%edx
  100ec2:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ec5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ecc:	89 0a                	mov    %ecx,(%rdx)
  100ece:	eb 1a                	jmp    100eea <printer_vprintf+0x1b3>
  100ed0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ed7:	48 8b 40 08          	mov    0x8(%rax),%rax
  100edb:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100edf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ee6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100eea:	8b 00                	mov    (%rax),%eax
  100eec:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100eef:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ef6:	01 
  100ef7:	eb 01                	jmp    100efa <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100ef9:	90                   	nop
        }

        // process precision
        int precision = -1;
  100efa:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100f01:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f08:	0f b6 00             	movzbl (%rax),%eax
  100f0b:	3c 2e                	cmp    $0x2e,%al
  100f0d:	0f 85 00 01 00 00    	jne    101013 <printer_vprintf+0x2dc>
            ++format;
  100f13:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100f1a:	01 
            if (*format >= '0' && *format <= '9') {
  100f1b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f22:	0f b6 00             	movzbl (%rax),%eax
  100f25:	3c 2f                	cmp    $0x2f,%al
  100f27:	7e 67                	jle    100f90 <printer_vprintf+0x259>
  100f29:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f30:	0f b6 00             	movzbl (%rax),%eax
  100f33:	3c 39                	cmp    $0x39,%al
  100f35:	7f 59                	jg     100f90 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100f37:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100f3e:	eb 2e                	jmp    100f6e <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100f40:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100f43:	89 d0                	mov    %edx,%eax
  100f45:	c1 e0 02             	shl    $0x2,%eax
  100f48:	01 d0                	add    %edx,%eax
  100f4a:	01 c0                	add    %eax,%eax
  100f4c:	89 c1                	mov    %eax,%ecx
  100f4e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f55:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100f59:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100f60:	0f b6 00             	movzbl (%rax),%eax
  100f63:	0f be c0             	movsbl %al,%eax
  100f66:	01 c8                	add    %ecx,%eax
  100f68:	83 e8 30             	sub    $0x30,%eax
  100f6b:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100f6e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f75:	0f b6 00             	movzbl (%rax),%eax
  100f78:	3c 2f                	cmp    $0x2f,%al
  100f7a:	0f 8e 85 00 00 00    	jle    101005 <printer_vprintf+0x2ce>
  100f80:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f87:	0f b6 00             	movzbl (%rax),%eax
  100f8a:	3c 39                	cmp    $0x39,%al
  100f8c:	7e b2                	jle    100f40 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100f8e:	eb 75                	jmp    101005 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100f90:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f97:	0f b6 00             	movzbl (%rax),%eax
  100f9a:	3c 2a                	cmp    $0x2a,%al
  100f9c:	75 68                	jne    101006 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100f9e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fa5:	8b 00                	mov    (%rax),%eax
  100fa7:	83 f8 2f             	cmp    $0x2f,%eax
  100faa:	77 30                	ja     100fdc <printer_vprintf+0x2a5>
  100fac:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fb3:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100fb7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fbe:	8b 00                	mov    (%rax),%eax
  100fc0:	89 c0                	mov    %eax,%eax
  100fc2:	48 01 d0             	add    %rdx,%rax
  100fc5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fcc:	8b 12                	mov    (%rdx),%edx
  100fce:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100fd1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fd8:	89 0a                	mov    %ecx,(%rdx)
  100fda:	eb 1a                	jmp    100ff6 <printer_vprintf+0x2bf>
  100fdc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fe3:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fe7:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100feb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ff2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ff6:	8b 00                	mov    (%rax),%eax
  100ff8:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100ffb:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101002:	01 
  101003:	eb 01                	jmp    101006 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  101005:	90                   	nop
            }
            if (precision < 0) {
  101006:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  10100a:	79 07                	jns    101013 <printer_vprintf+0x2dc>
                precision = 0;
  10100c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  101013:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  10101a:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  101021:	00 
        int length = 0;
  101022:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  101029:	48 c7 45 c8 46 1b 10 	movq   $0x101b46,-0x38(%rbp)
  101030:	00 
    again:
        switch (*format) {
  101031:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101038:	0f b6 00             	movzbl (%rax),%eax
  10103b:	0f be c0             	movsbl %al,%eax
  10103e:	83 e8 43             	sub    $0x43,%eax
  101041:	83 f8 37             	cmp    $0x37,%eax
  101044:	0f 87 9f 03 00 00    	ja     1013e9 <printer_vprintf+0x6b2>
  10104a:	89 c0                	mov    %eax,%eax
  10104c:	48 8b 04 c5 58 1b 10 	mov    0x101b58(,%rax,8),%rax
  101053:	00 
  101054:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  101056:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  10105d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101064:	01 
            goto again;
  101065:	eb ca                	jmp    101031 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  101067:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  10106b:	74 5d                	je     1010ca <printer_vprintf+0x393>
  10106d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101074:	8b 00                	mov    (%rax),%eax
  101076:	83 f8 2f             	cmp    $0x2f,%eax
  101079:	77 30                	ja     1010ab <printer_vprintf+0x374>
  10107b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101082:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101086:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10108d:	8b 00                	mov    (%rax),%eax
  10108f:	89 c0                	mov    %eax,%eax
  101091:	48 01 d0             	add    %rdx,%rax
  101094:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10109b:	8b 12                	mov    (%rdx),%edx
  10109d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1010a0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010a7:	89 0a                	mov    %ecx,(%rdx)
  1010a9:	eb 1a                	jmp    1010c5 <printer_vprintf+0x38e>
  1010ab:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010b2:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010b6:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1010ba:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010c1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1010c5:	48 8b 00             	mov    (%rax),%rax
  1010c8:	eb 5c                	jmp    101126 <printer_vprintf+0x3ef>
  1010ca:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010d1:	8b 00                	mov    (%rax),%eax
  1010d3:	83 f8 2f             	cmp    $0x2f,%eax
  1010d6:	77 30                	ja     101108 <printer_vprintf+0x3d1>
  1010d8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010df:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1010e3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010ea:	8b 00                	mov    (%rax),%eax
  1010ec:	89 c0                	mov    %eax,%eax
  1010ee:	48 01 d0             	add    %rdx,%rax
  1010f1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010f8:	8b 12                	mov    (%rdx),%edx
  1010fa:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1010fd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101104:	89 0a                	mov    %ecx,(%rdx)
  101106:	eb 1a                	jmp    101122 <printer_vprintf+0x3eb>
  101108:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10110f:	48 8b 40 08          	mov    0x8(%rax),%rax
  101113:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101117:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10111e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101122:	8b 00                	mov    (%rax),%eax
  101124:	48 98                	cltq   
  101126:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  10112a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10112e:	48 c1 f8 38          	sar    $0x38,%rax
  101132:	25 80 00 00 00       	and    $0x80,%eax
  101137:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  10113a:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  10113e:	74 09                	je     101149 <printer_vprintf+0x412>
  101140:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101144:	48 f7 d8             	neg    %rax
  101147:	eb 04                	jmp    10114d <printer_vprintf+0x416>
  101149:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10114d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  101151:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  101154:	83 c8 60             	or     $0x60,%eax
  101157:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  10115a:	e9 cf 02 00 00       	jmp    10142e <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  10115f:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  101163:	74 5d                	je     1011c2 <printer_vprintf+0x48b>
  101165:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10116c:	8b 00                	mov    (%rax),%eax
  10116e:	83 f8 2f             	cmp    $0x2f,%eax
  101171:	77 30                	ja     1011a3 <printer_vprintf+0x46c>
  101173:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10117a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10117e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101185:	8b 00                	mov    (%rax),%eax
  101187:	89 c0                	mov    %eax,%eax
  101189:	48 01 d0             	add    %rdx,%rax
  10118c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101193:	8b 12                	mov    (%rdx),%edx
  101195:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101198:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10119f:	89 0a                	mov    %ecx,(%rdx)
  1011a1:	eb 1a                	jmp    1011bd <printer_vprintf+0x486>
  1011a3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011aa:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011ae:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1011b2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011b9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1011bd:	48 8b 00             	mov    (%rax),%rax
  1011c0:	eb 5c                	jmp    10121e <printer_vprintf+0x4e7>
  1011c2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011c9:	8b 00                	mov    (%rax),%eax
  1011cb:	83 f8 2f             	cmp    $0x2f,%eax
  1011ce:	77 30                	ja     101200 <printer_vprintf+0x4c9>
  1011d0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011d7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1011db:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011e2:	8b 00                	mov    (%rax),%eax
  1011e4:	89 c0                	mov    %eax,%eax
  1011e6:	48 01 d0             	add    %rdx,%rax
  1011e9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011f0:	8b 12                	mov    (%rdx),%edx
  1011f2:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1011f5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011fc:	89 0a                	mov    %ecx,(%rdx)
  1011fe:	eb 1a                	jmp    10121a <printer_vprintf+0x4e3>
  101200:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101207:	48 8b 40 08          	mov    0x8(%rax),%rax
  10120b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10120f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101216:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10121a:	8b 00                	mov    (%rax),%eax
  10121c:	89 c0                	mov    %eax,%eax
  10121e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  101222:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  101226:	e9 03 02 00 00       	jmp    10142e <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  10122b:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  101232:	e9 28 ff ff ff       	jmp    10115f <printer_vprintf+0x428>
        case 'X':
            base = 16;
  101237:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  10123e:	e9 1c ff ff ff       	jmp    10115f <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  101243:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10124a:	8b 00                	mov    (%rax),%eax
  10124c:	83 f8 2f             	cmp    $0x2f,%eax
  10124f:	77 30                	ja     101281 <printer_vprintf+0x54a>
  101251:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101258:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10125c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101263:	8b 00                	mov    (%rax),%eax
  101265:	89 c0                	mov    %eax,%eax
  101267:	48 01 d0             	add    %rdx,%rax
  10126a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101271:	8b 12                	mov    (%rdx),%edx
  101273:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101276:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10127d:	89 0a                	mov    %ecx,(%rdx)
  10127f:	eb 1a                	jmp    10129b <printer_vprintf+0x564>
  101281:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101288:	48 8b 40 08          	mov    0x8(%rax),%rax
  10128c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101290:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101297:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10129b:	48 8b 00             	mov    (%rax),%rax
  10129e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  1012a2:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  1012a9:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  1012b0:	e9 79 01 00 00       	jmp    10142e <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  1012b5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012bc:	8b 00                	mov    (%rax),%eax
  1012be:	83 f8 2f             	cmp    $0x2f,%eax
  1012c1:	77 30                	ja     1012f3 <printer_vprintf+0x5bc>
  1012c3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012ca:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1012ce:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012d5:	8b 00                	mov    (%rax),%eax
  1012d7:	89 c0                	mov    %eax,%eax
  1012d9:	48 01 d0             	add    %rdx,%rax
  1012dc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012e3:	8b 12                	mov    (%rdx),%edx
  1012e5:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1012e8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012ef:	89 0a                	mov    %ecx,(%rdx)
  1012f1:	eb 1a                	jmp    10130d <printer_vprintf+0x5d6>
  1012f3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012fa:	48 8b 40 08          	mov    0x8(%rax),%rax
  1012fe:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101302:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101309:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10130d:	48 8b 00             	mov    (%rax),%rax
  101310:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  101314:	e9 15 01 00 00       	jmp    10142e <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  101319:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101320:	8b 00                	mov    (%rax),%eax
  101322:	83 f8 2f             	cmp    $0x2f,%eax
  101325:	77 30                	ja     101357 <printer_vprintf+0x620>
  101327:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10132e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101332:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101339:	8b 00                	mov    (%rax),%eax
  10133b:	89 c0                	mov    %eax,%eax
  10133d:	48 01 d0             	add    %rdx,%rax
  101340:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101347:	8b 12                	mov    (%rdx),%edx
  101349:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10134c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101353:	89 0a                	mov    %ecx,(%rdx)
  101355:	eb 1a                	jmp    101371 <printer_vprintf+0x63a>
  101357:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10135e:	48 8b 40 08          	mov    0x8(%rax),%rax
  101362:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101366:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10136d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101371:	8b 00                	mov    (%rax),%eax
  101373:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  101379:	e9 67 03 00 00       	jmp    1016e5 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  10137e:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101382:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  101386:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10138d:	8b 00                	mov    (%rax),%eax
  10138f:	83 f8 2f             	cmp    $0x2f,%eax
  101392:	77 30                	ja     1013c4 <printer_vprintf+0x68d>
  101394:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10139b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10139f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013a6:	8b 00                	mov    (%rax),%eax
  1013a8:	89 c0                	mov    %eax,%eax
  1013aa:	48 01 d0             	add    %rdx,%rax
  1013ad:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1013b4:	8b 12                	mov    (%rdx),%edx
  1013b6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1013b9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1013c0:	89 0a                	mov    %ecx,(%rdx)
  1013c2:	eb 1a                	jmp    1013de <printer_vprintf+0x6a7>
  1013c4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013cb:	48 8b 40 08          	mov    0x8(%rax),%rax
  1013cf:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1013d3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1013da:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1013de:	8b 00                	mov    (%rax),%eax
  1013e0:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  1013e3:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  1013e7:	eb 45                	jmp    10142e <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  1013e9:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1013ed:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  1013f1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1013f8:	0f b6 00             	movzbl (%rax),%eax
  1013fb:	84 c0                	test   %al,%al
  1013fd:	74 0c                	je     10140b <printer_vprintf+0x6d4>
  1013ff:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101406:	0f b6 00             	movzbl (%rax),%eax
  101409:	eb 05                	jmp    101410 <printer_vprintf+0x6d9>
  10140b:	b8 25 00 00 00       	mov    $0x25,%eax
  101410:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  101413:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  101417:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10141e:	0f b6 00             	movzbl (%rax),%eax
  101421:	84 c0                	test   %al,%al
  101423:	75 08                	jne    10142d <printer_vprintf+0x6f6>
                format--;
  101425:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  10142c:	01 
            }
            break;
  10142d:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  10142e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101431:	83 e0 20             	and    $0x20,%eax
  101434:	85 c0                	test   %eax,%eax
  101436:	74 1e                	je     101456 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  101438:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  10143c:	48 83 c0 18          	add    $0x18,%rax
  101440:	8b 55 e0             	mov    -0x20(%rbp),%edx
  101443:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101447:	48 89 ce             	mov    %rcx,%rsi
  10144a:	48 89 c7             	mov    %rax,%rdi
  10144d:	e8 63 f8 ff ff       	call   100cb5 <fill_numbuf>
  101452:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  101456:	48 c7 45 c0 46 1b 10 	movq   $0x101b46,-0x40(%rbp)
  10145d:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  10145e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101461:	83 e0 20             	and    $0x20,%eax
  101464:	85 c0                	test   %eax,%eax
  101466:	74 48                	je     1014b0 <printer_vprintf+0x779>
  101468:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10146b:	83 e0 40             	and    $0x40,%eax
  10146e:	85 c0                	test   %eax,%eax
  101470:	74 3e                	je     1014b0 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  101472:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101475:	25 80 00 00 00       	and    $0x80,%eax
  10147a:	85 c0                	test   %eax,%eax
  10147c:	74 0a                	je     101488 <printer_vprintf+0x751>
                prefix = "-";
  10147e:	48 c7 45 c0 47 1b 10 	movq   $0x101b47,-0x40(%rbp)
  101485:	00 
            if (flags & FLAG_NEGATIVE) {
  101486:	eb 73                	jmp    1014fb <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  101488:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10148b:	83 e0 10             	and    $0x10,%eax
  10148e:	85 c0                	test   %eax,%eax
  101490:	74 0a                	je     10149c <printer_vprintf+0x765>
                prefix = "+";
  101492:	48 c7 45 c0 49 1b 10 	movq   $0x101b49,-0x40(%rbp)
  101499:	00 
            if (flags & FLAG_NEGATIVE) {
  10149a:	eb 5f                	jmp    1014fb <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  10149c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10149f:	83 e0 08             	and    $0x8,%eax
  1014a2:	85 c0                	test   %eax,%eax
  1014a4:	74 55                	je     1014fb <printer_vprintf+0x7c4>
                prefix = " ";
  1014a6:	48 c7 45 c0 4b 1b 10 	movq   $0x101b4b,-0x40(%rbp)
  1014ad:	00 
            if (flags & FLAG_NEGATIVE) {
  1014ae:	eb 4b                	jmp    1014fb <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1014b0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1014b3:	83 e0 20             	and    $0x20,%eax
  1014b6:	85 c0                	test   %eax,%eax
  1014b8:	74 42                	je     1014fc <printer_vprintf+0x7c5>
  1014ba:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1014bd:	83 e0 01             	and    $0x1,%eax
  1014c0:	85 c0                	test   %eax,%eax
  1014c2:	74 38                	je     1014fc <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  1014c4:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  1014c8:	74 06                	je     1014d0 <printer_vprintf+0x799>
  1014ca:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1014ce:	75 2c                	jne    1014fc <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  1014d0:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1014d5:	75 0c                	jne    1014e3 <printer_vprintf+0x7ac>
  1014d7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1014da:	25 00 01 00 00       	and    $0x100,%eax
  1014df:	85 c0                	test   %eax,%eax
  1014e1:	74 19                	je     1014fc <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  1014e3:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1014e7:	75 07                	jne    1014f0 <printer_vprintf+0x7b9>
  1014e9:	b8 4d 1b 10 00       	mov    $0x101b4d,%eax
  1014ee:	eb 05                	jmp    1014f5 <printer_vprintf+0x7be>
  1014f0:	b8 50 1b 10 00       	mov    $0x101b50,%eax
  1014f5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1014f9:	eb 01                	jmp    1014fc <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  1014fb:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  1014fc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101500:	78 24                	js     101526 <printer_vprintf+0x7ef>
  101502:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101505:	83 e0 20             	and    $0x20,%eax
  101508:	85 c0                	test   %eax,%eax
  10150a:	75 1a                	jne    101526 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  10150c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10150f:	48 63 d0             	movslq %eax,%rdx
  101512:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101516:	48 89 d6             	mov    %rdx,%rsi
  101519:	48 89 c7             	mov    %rax,%rdi
  10151c:	e8 ea f5 ff ff       	call   100b0b <strnlen>
  101521:	89 45 bc             	mov    %eax,-0x44(%rbp)
  101524:	eb 0f                	jmp    101535 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  101526:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  10152a:	48 89 c7             	mov    %rax,%rdi
  10152d:	e8 a8 f5 ff ff       	call   100ada <strlen>
  101532:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  101535:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101538:	83 e0 20             	and    $0x20,%eax
  10153b:	85 c0                	test   %eax,%eax
  10153d:	74 20                	je     10155f <printer_vprintf+0x828>
  10153f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101543:	78 1a                	js     10155f <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  101545:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101548:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  10154b:	7e 08                	jle    101555 <printer_vprintf+0x81e>
  10154d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101550:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101553:	eb 05                	jmp    10155a <printer_vprintf+0x823>
  101555:	b8 00 00 00 00       	mov    $0x0,%eax
  10155a:	89 45 b8             	mov    %eax,-0x48(%rbp)
  10155d:	eb 5c                	jmp    1015bb <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  10155f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101562:	83 e0 20             	and    $0x20,%eax
  101565:	85 c0                	test   %eax,%eax
  101567:	74 4b                	je     1015b4 <printer_vprintf+0x87d>
  101569:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10156c:	83 e0 02             	and    $0x2,%eax
  10156f:	85 c0                	test   %eax,%eax
  101571:	74 41                	je     1015b4 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  101573:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101576:	83 e0 04             	and    $0x4,%eax
  101579:	85 c0                	test   %eax,%eax
  10157b:	75 37                	jne    1015b4 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  10157d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101581:	48 89 c7             	mov    %rax,%rdi
  101584:	e8 51 f5 ff ff       	call   100ada <strlen>
  101589:	89 c2                	mov    %eax,%edx
  10158b:	8b 45 bc             	mov    -0x44(%rbp),%eax
  10158e:	01 d0                	add    %edx,%eax
  101590:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  101593:	7e 1f                	jle    1015b4 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  101595:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101598:	2b 45 bc             	sub    -0x44(%rbp),%eax
  10159b:	89 c3                	mov    %eax,%ebx
  10159d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1015a1:	48 89 c7             	mov    %rax,%rdi
  1015a4:	e8 31 f5 ff ff       	call   100ada <strlen>
  1015a9:	89 c2                	mov    %eax,%edx
  1015ab:	89 d8                	mov    %ebx,%eax
  1015ad:	29 d0                	sub    %edx,%eax
  1015af:	89 45 b8             	mov    %eax,-0x48(%rbp)
  1015b2:	eb 07                	jmp    1015bb <printer_vprintf+0x884>
        } else {
            zeros = 0;
  1015b4:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  1015bb:	8b 55 bc             	mov    -0x44(%rbp),%edx
  1015be:	8b 45 b8             	mov    -0x48(%rbp),%eax
  1015c1:	01 d0                	add    %edx,%eax
  1015c3:	48 63 d8             	movslq %eax,%rbx
  1015c6:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1015ca:	48 89 c7             	mov    %rax,%rdi
  1015cd:	e8 08 f5 ff ff       	call   100ada <strlen>
  1015d2:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  1015d6:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1015d9:	29 d0                	sub    %edx,%eax
  1015db:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1015de:	eb 25                	jmp    101605 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  1015e0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1015e7:	48 8b 08             	mov    (%rax),%rcx
  1015ea:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1015f0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1015f7:	be 20 00 00 00       	mov    $0x20,%esi
  1015fc:	48 89 c7             	mov    %rax,%rdi
  1015ff:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101601:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101605:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101608:	83 e0 04             	and    $0x4,%eax
  10160b:	85 c0                	test   %eax,%eax
  10160d:	75 36                	jne    101645 <printer_vprintf+0x90e>
  10160f:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101613:	7f cb                	jg     1015e0 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  101615:	eb 2e                	jmp    101645 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  101617:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10161e:	4c 8b 00             	mov    (%rax),%r8
  101621:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101625:	0f b6 00             	movzbl (%rax),%eax
  101628:	0f b6 c8             	movzbl %al,%ecx
  10162b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101631:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101638:	89 ce                	mov    %ecx,%esi
  10163a:	48 89 c7             	mov    %rax,%rdi
  10163d:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  101640:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  101645:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101649:	0f b6 00             	movzbl (%rax),%eax
  10164c:	84 c0                	test   %al,%al
  10164e:	75 c7                	jne    101617 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  101650:	eb 25                	jmp    101677 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  101652:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101659:	48 8b 08             	mov    (%rax),%rcx
  10165c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101662:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101669:	be 30 00 00 00       	mov    $0x30,%esi
  10166e:	48 89 c7             	mov    %rax,%rdi
  101671:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  101673:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  101677:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  10167b:	7f d5                	jg     101652 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  10167d:	eb 32                	jmp    1016b1 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  10167f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101686:	4c 8b 00             	mov    (%rax),%r8
  101689:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  10168d:	0f b6 00             	movzbl (%rax),%eax
  101690:	0f b6 c8             	movzbl %al,%ecx
  101693:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101699:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1016a0:	89 ce                	mov    %ecx,%esi
  1016a2:	48 89 c7             	mov    %rax,%rdi
  1016a5:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  1016a8:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  1016ad:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  1016b1:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  1016b5:	7f c8                	jg     10167f <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  1016b7:	eb 25                	jmp    1016de <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  1016b9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1016c0:	48 8b 08             	mov    (%rax),%rcx
  1016c3:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1016c9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1016d0:	be 20 00 00 00       	mov    $0x20,%esi
  1016d5:	48 89 c7             	mov    %rax,%rdi
  1016d8:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  1016da:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1016de:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1016e2:	7f d5                	jg     1016b9 <printer_vprintf+0x982>
        }
    done: ;
  1016e4:	90                   	nop
    for (; *format; ++format) {
  1016e5:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1016ec:	01 
  1016ed:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1016f4:	0f b6 00             	movzbl (%rax),%eax
  1016f7:	84 c0                	test   %al,%al
  1016f9:	0f 85 64 f6 ff ff    	jne    100d63 <printer_vprintf+0x2c>
    }
}
  1016ff:	90                   	nop
  101700:	90                   	nop
  101701:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  101705:	c9                   	leave  
  101706:	c3                   	ret    

0000000000101707 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  101707:	55                   	push   %rbp
  101708:	48 89 e5             	mov    %rsp,%rbp
  10170b:	48 83 ec 20          	sub    $0x20,%rsp
  10170f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101713:	89 f0                	mov    %esi,%eax
  101715:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101718:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  10171b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10171f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101723:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101727:	48 8b 40 08          	mov    0x8(%rax),%rax
  10172b:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  101730:	48 39 d0             	cmp    %rdx,%rax
  101733:	72 0c                	jb     101741 <console_putc+0x3a>
        cp->cursor = console;
  101735:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101739:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  101740:	00 
    }
    if (c == '\n') {
  101741:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  101745:	75 78                	jne    1017bf <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  101747:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10174b:	48 8b 40 08          	mov    0x8(%rax),%rax
  10174f:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  101755:	48 d1 f8             	sar    %rax
  101758:	48 89 c1             	mov    %rax,%rcx
  10175b:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  101762:	66 66 66 
  101765:	48 89 c8             	mov    %rcx,%rax
  101768:	48 f7 ea             	imul   %rdx
  10176b:	48 c1 fa 05          	sar    $0x5,%rdx
  10176f:	48 89 c8             	mov    %rcx,%rax
  101772:	48 c1 f8 3f          	sar    $0x3f,%rax
  101776:	48 29 c2             	sub    %rax,%rdx
  101779:	48 89 d0             	mov    %rdx,%rax
  10177c:	48 c1 e0 02          	shl    $0x2,%rax
  101780:	48 01 d0             	add    %rdx,%rax
  101783:	48 c1 e0 04          	shl    $0x4,%rax
  101787:	48 29 c1             	sub    %rax,%rcx
  10178a:	48 89 ca             	mov    %rcx,%rdx
  10178d:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101790:	eb 25                	jmp    1017b7 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  101792:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101795:	83 c8 20             	or     $0x20,%eax
  101798:	89 c6                	mov    %eax,%esi
  10179a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10179e:	48 8b 40 08          	mov    0x8(%rax),%rax
  1017a2:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1017a6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1017aa:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1017ae:	89 f2                	mov    %esi,%edx
  1017b0:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  1017b3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1017b7:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  1017bb:	75 d5                	jne    101792 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  1017bd:	eb 24                	jmp    1017e3 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  1017bf:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  1017c3:	8b 55 e0             	mov    -0x20(%rbp),%edx
  1017c6:	09 d0                	or     %edx,%eax
  1017c8:	89 c6                	mov    %eax,%esi
  1017ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1017ce:	48 8b 40 08          	mov    0x8(%rax),%rax
  1017d2:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1017d6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1017da:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1017de:	89 f2                	mov    %esi,%edx
  1017e0:	66 89 10             	mov    %dx,(%rax)
}
  1017e3:	90                   	nop
  1017e4:	c9                   	leave  
  1017e5:	c3                   	ret    

00000000001017e6 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1017e6:	55                   	push   %rbp
  1017e7:	48 89 e5             	mov    %rsp,%rbp
  1017ea:	48 83 ec 30          	sub    $0x30,%rsp
  1017ee:	89 7d ec             	mov    %edi,-0x14(%rbp)
  1017f1:	89 75 e8             	mov    %esi,-0x18(%rbp)
  1017f4:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1017f8:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  1017fc:	48 c7 45 f0 07 17 10 	movq   $0x101707,-0x10(%rbp)
  101803:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101804:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  101808:	78 09                	js     101813 <console_vprintf+0x2d>
  10180a:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101811:	7e 07                	jle    10181a <console_vprintf+0x34>
        cpos = 0;
  101813:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  10181a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10181d:	48 98                	cltq   
  10181f:	48 01 c0             	add    %rax,%rax
  101822:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  101828:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  10182c:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101830:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  101834:	8b 75 e8             	mov    -0x18(%rbp),%esi
  101837:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  10183b:	48 89 c7             	mov    %rax,%rdi
  10183e:	e8 f4 f4 ff ff       	call   100d37 <printer_vprintf>
    return cp.cursor - console;
  101843:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101847:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  10184d:	48 d1 f8             	sar    %rax
}
  101850:	c9                   	leave  
  101851:	c3                   	ret    

0000000000101852 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  101852:	55                   	push   %rbp
  101853:	48 89 e5             	mov    %rsp,%rbp
  101856:	48 83 ec 60          	sub    $0x60,%rsp
  10185a:	89 7d ac             	mov    %edi,-0x54(%rbp)
  10185d:	89 75 a8             	mov    %esi,-0x58(%rbp)
  101860:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  101864:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101868:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10186c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101870:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101877:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10187b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  10187f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101883:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101887:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  10188b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  10188f:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101892:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101895:	89 c7                	mov    %eax,%edi
  101897:	e8 4a ff ff ff       	call   1017e6 <console_vprintf>
  10189c:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  10189f:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  1018a2:	c9                   	leave  
  1018a3:	c3                   	ret    

00000000001018a4 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  1018a4:	55                   	push   %rbp
  1018a5:	48 89 e5             	mov    %rsp,%rbp
  1018a8:	48 83 ec 20          	sub    $0x20,%rsp
  1018ac:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1018b0:	89 f0                	mov    %esi,%eax
  1018b2:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1018b5:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  1018b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1018bc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  1018c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1018c4:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1018c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1018cc:	48 8b 40 10          	mov    0x10(%rax),%rax
  1018d0:	48 39 c2             	cmp    %rax,%rdx
  1018d3:	73 1a                	jae    1018ef <string_putc+0x4b>
        *sp->s++ = c;
  1018d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1018d9:	48 8b 40 08          	mov    0x8(%rax),%rax
  1018dd:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1018e1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1018e5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1018e9:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1018ed:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1018ef:	90                   	nop
  1018f0:	c9                   	leave  
  1018f1:	c3                   	ret    

00000000001018f2 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1018f2:	55                   	push   %rbp
  1018f3:	48 89 e5             	mov    %rsp,%rbp
  1018f6:	48 83 ec 40          	sub    $0x40,%rsp
  1018fa:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  1018fe:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101902:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  101906:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  10190a:	48 c7 45 e8 a4 18 10 	movq   $0x1018a4,-0x18(%rbp)
  101911:	00 
    sp.s = s;
  101912:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101916:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  10191a:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  10191f:	74 33                	je     101954 <vsnprintf+0x62>
        sp.end = s + size - 1;
  101921:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101925:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101929:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10192d:	48 01 d0             	add    %rdx,%rax
  101930:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101934:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101938:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  10193c:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101940:	be 00 00 00 00       	mov    $0x0,%esi
  101945:	48 89 c7             	mov    %rax,%rdi
  101948:	e8 ea f3 ff ff       	call   100d37 <printer_vprintf>
        *sp.s = 0;
  10194d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101951:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  101954:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101958:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  10195c:	c9                   	leave  
  10195d:	c3                   	ret    

000000000010195e <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  10195e:	55                   	push   %rbp
  10195f:	48 89 e5             	mov    %rsp,%rbp
  101962:	48 83 ec 70          	sub    $0x70,%rsp
  101966:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  10196a:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  10196e:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101972:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101976:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10197a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  10197e:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101985:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101989:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  10198d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101991:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101995:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101999:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  10199d:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  1019a1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1019a5:	48 89 c7             	mov    %rax,%rdi
  1019a8:	e8 45 ff ff ff       	call   1018f2 <vsnprintf>
  1019ad:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  1019b0:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  1019b3:	c9                   	leave  
  1019b4:	c3                   	ret    

00000000001019b5 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  1019b5:	55                   	push   %rbp
  1019b6:	48 89 e5             	mov    %rsp,%rbp
  1019b9:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1019bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  1019c4:	eb 13                	jmp    1019d9 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  1019c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1019c9:	48 98                	cltq   
  1019cb:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  1019d2:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1019d5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1019d9:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1019e0:	7e e4                	jle    1019c6 <console_clear+0x11>
    }
    cursorpos = 0;
  1019e2:	c7 05 10 76 fb ff 00 	movl   $0x0,-0x489f0(%rip)        # b8ffc <cursorpos>
  1019e9:	00 00 00 
}
  1019ec:	90                   	nop
  1019ed:	c9                   	leave  
  1019ee:	c3                   	ret    
