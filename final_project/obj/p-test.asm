
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
  100008:	e8 64 09 00 00       	call   100971 <srand>
    heap_bottom = heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10000d:	b8 1f 34 10 00       	mov    $0x10341f,%eax
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
//        }
//        defrag();
//    }
    

    void *ptr = malloc(PAGESIZE);
  10003a:	bf 00 10 00 00       	mov    $0x1000,%edi
  10003f:	e8 d9 03 00 00       	call   10041d <malloc>
    malloc(PAGESIZE);
  100044:	bf 00 10 00 00       	mov    $0x1000,%edi
  100049:	e8 cf 03 00 00       	call   10041d <malloc>
    malloc(PAGESIZE);
  10004e:	bf 00 10 00 00       	mov    $0x1000,%edi
  100053:	e8 c5 03 00 00       	call   10041d <malloc>
    ptr = malloc(PAGESIZE);
  100058:	bf 00 10 00 00       	mov    $0x1000,%edi
  10005d:	e8 bb 03 00 00       	call   10041d <malloc>
    *((int*)ptr) = 1;
  100062:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
	
    if ((*((size_t *)((uintptr_t)ptr - 8)) & ~0xF ) == (0x50))
  100068:	48 8b 40 f8          	mov    -0x8(%rax),%rax
  10006c:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100070:	48 83 f8 50          	cmp    $0x50,%rax
  100074:	74 0f                	je     100085 <process_main+0x85>
	    panic("success!");

    TEST_PASS();
  100076:	bf d9 16 10 00       	mov    $0x1016d9,%edi
  10007b:	b8 00 00 00 00       	mov    $0x0,%eax
  100080:	e8 99 00 00 00       	call   10011e <kernel_panic>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  100085:	bf d0 16 10 00       	mov    $0x1016d0,%edi
  10008a:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  10008c:	eb fe                	jmp    10008c <process_main+0x8c>

000000000010008e <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  10008e:	55                   	push   %rbp
  10008f:	48 89 e5             	mov    %rsp,%rbp
  100092:	48 83 ec 50          	sub    $0x50,%rsp
  100096:	49 89 f2             	mov    %rsi,%r10
  100099:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  10009d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1000a1:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1000a5:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  1000a9:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  1000ae:	85 ff                	test   %edi,%edi
  1000b0:	78 2e                	js     1000e0 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  1000b2:	48 63 ff             	movslq %edi,%rdi
  1000b5:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  1000bc:	cc cc cc 
  1000bf:	48 89 f8             	mov    %rdi,%rax
  1000c2:	48 f7 e2             	mul    %rdx
  1000c5:	48 89 d0             	mov    %rdx,%rax
  1000c8:	48 c1 e8 02          	shr    $0x2,%rax
  1000cc:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  1000d0:	48 01 c2             	add    %rax,%rdx
  1000d3:	48 29 d7             	sub    %rdx,%rdi
  1000d6:	0f b6 b7 2d 17 10 00 	movzbl 0x10172d(%rdi),%esi
  1000dd:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  1000e0:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  1000e7:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1000eb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1000ef:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1000f3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  1000f7:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1000fb:	4c 89 d2             	mov    %r10,%rdx
  1000fe:	8b 3d f8 8e fb ff    	mov    -0x47108(%rip),%edi        # b8ffc <cursorpos>
  100104:	e8 ba 13 00 00       	call   1014c3 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100109:	3d 30 07 00 00       	cmp    $0x730,%eax
  10010e:	ba 00 00 00 00       	mov    $0x0,%edx
  100113:	0f 4d c2             	cmovge %edx,%eax
  100116:	89 05 e0 8e fb ff    	mov    %eax,-0x47120(%rip)        # b8ffc <cursorpos>
    }
}
  10011c:	c9                   	leave  
  10011d:	c3                   	ret    

000000000010011e <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  10011e:	55                   	push   %rbp
  10011f:	48 89 e5             	mov    %rsp,%rbp
  100122:	53                   	push   %rbx
  100123:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  10012a:	48 89 fb             	mov    %rdi,%rbx
  10012d:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100131:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  100135:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100139:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  10013d:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  100141:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  100148:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10014c:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100150:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  100154:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  100158:	ba 07 00 00 00       	mov    $0x7,%edx
  10015d:	be f4 16 10 00       	mov    $0x1016f4,%esi
  100162:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100169:	e8 0c 05 00 00       	call   10067a <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  10016e:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100172:	48 89 da             	mov    %rbx,%rdx
  100175:	be 99 00 00 00       	mov    $0x99,%esi
  10017a:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100181:	e8 49 14 00 00       	call   1015cf <vsnprintf>
  100186:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100189:	85 d2                	test   %edx,%edx
  10018b:	7e 0f                	jle    10019c <kernel_panic+0x7e>
  10018d:	83 c0 06             	add    $0x6,%eax
  100190:	48 98                	cltq   
  100192:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  100199:	0a 
  10019a:	75 2a                	jne    1001c6 <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  10019c:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  1001a3:	48 89 d9             	mov    %rbx,%rcx
  1001a6:	ba fe 16 10 00       	mov    $0x1016fe,%edx
  1001ab:	be 00 c0 00 00       	mov    $0xc000,%esi
  1001b0:	bf 30 07 00 00       	mov    $0x730,%edi
  1001b5:	b8 00 00 00 00       	mov    $0x0,%eax
  1001ba:	e8 70 13 00 00       	call   10152f <console_printf>
    asm volatile ("int %0" : /* no result */
  1001bf:	48 89 df             	mov    %rbx,%rdi
  1001c2:	cd 30                	int    $0x30
 loop: goto loop;
  1001c4:	eb fe                	jmp    1001c4 <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  1001c6:	48 63 c2             	movslq %edx,%rax
  1001c9:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  1001cf:	0f 94 c2             	sete   %dl
  1001d2:	0f b6 d2             	movzbl %dl,%edx
  1001d5:	48 29 d0             	sub    %rdx,%rax
  1001d8:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  1001df:	ff 
  1001e0:	be fc 16 10 00       	mov    $0x1016fc,%esi
  1001e5:	e8 3d 06 00 00       	call   100827 <strcpy>
  1001ea:	eb b0                	jmp    10019c <kernel_panic+0x7e>

00000000001001ec <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  1001ec:	55                   	push   %rbp
  1001ed:	48 89 e5             	mov    %rsp,%rbp
  1001f0:	48 89 f9             	mov    %rdi,%rcx
  1001f3:	41 89 f0             	mov    %esi,%r8d
  1001f6:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  1001f9:	ba 08 17 10 00       	mov    $0x101708,%edx
  1001fe:	be 00 c0 00 00       	mov    $0xc000,%esi
  100203:	bf 30 07 00 00       	mov    $0x730,%edi
  100208:	b8 00 00 00 00       	mov    $0x0,%eax
  10020d:	e8 1d 13 00 00       	call   10152f <console_printf>
    asm volatile ("int %0" : /* no result */
  100212:	bf 00 00 00 00       	mov    $0x0,%edi
  100217:	cd 30                	int    $0x30
 loop: goto loop;
  100219:	eb fe                	jmp    100219 <assert_fail+0x2d>

000000000010021b <heap_init>:
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  10021b:	bf 10 00 00 00       	mov    $0x10,%edi
  100220:	cd 3a                	int    $0x3a
  100222:	48 89 05 e7 21 00 00 	mov    %rax,0x21e7(%rip)        # 102410 <result.0>
  100229:	bf 08 00 00 00       	mov    $0x8,%edi
  10022e:	cd 3a                	int    $0x3a
  100230:	48 89 c2             	mov    %rax,%rdx
  100233:	48 89 05 d6 21 00 00 	mov    %rax,0x21d6(%rip)        # 102410 <result.0>

	// prologue block
	void *prologue_block;
	sbrk(sizeof(block_header) + sizeof(block_header));
	prologue_block = sbrk(sizeof(block_footer));
	PUT(HDRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  10023a:	48 c7 40 f8 11 00 00 	movq   $0x11,-0x8(%rax)
  100241:	00 
	PUT(FTRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  100242:	48 c7 00 11 00 00 00 	movq   $0x11,(%rax)
  100249:	cd 3a                	int    $0x3a
  10024b:	48 89 05 be 21 00 00 	mov    %rax,0x21be(%rip)        # 102410 <result.0>

	// terminal block
	sbrk(sizeof(block_header));
	PUT(HDRP(NEXT_BLKP(prologue_block)), PACK(0, 1));	
  100252:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  100256:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  10025a:	48 c7 44 02 f8 01 00 	movq   $0x1,-0x8(%rdx,%rax,1)
  100261:	00 00 

	free_list = NULL;
  100263:	48 c7 05 92 21 00 00 	movq   $0x0,0x2192(%rip)        # 102400 <free_list>
  10026a:	00 00 00 00 

	initialized_heap = 1;
  10026e:	c7 05 90 21 00 00 01 	movl   $0x1,0x2190(%rip)        # 102408 <initialized_heap>
  100275:	00 00 00 
}
  100278:	c3                   	ret    

0000000000100279 <free>:

void free(void *firstbyte) {
	if (firstbyte == NULL)
  100279:	48 85 ff             	test   %rdi,%rdi
  10027c:	74 35                	je     1002b3 <free+0x3a>
		return;

	// setup free things: alloc, list ptrs, footer
	PUT(HDRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  10027e:	48 8b 47 f8          	mov    -0x8(%rdi),%rax
  100282:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100286:	48 89 47 f8          	mov    %rax,-0x8(%rdi)
	NEXT_FPTR(firstbyte) = free_list;
  10028a:	48 8b 15 6f 21 00 00 	mov    0x216f(%rip),%rdx        # 102400 <free_list>
  100291:	48 89 17             	mov    %rdx,(%rdi)
	PREV_FPTR(firstbyte) = NULL;
  100294:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  10029b:	00 
	PUT(FTRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  10029c:	48 89 44 07 f0       	mov    %rax,-0x10(%rdi,%rax,1)

	// add to free_list
	PREV_FPTR(free_list) = firstbyte;
  1002a1:	48 8b 05 58 21 00 00 	mov    0x2158(%rip),%rax        # 102400 <free_list>
  1002a8:	48 89 78 08          	mov    %rdi,0x8(%rax)
	free_list = firstbyte;
  1002ac:	48 89 3d 4d 21 00 00 	mov    %rdi,0x214d(%rip)        # 102400 <free_list>

	return;
}
  1002b3:	c3                   	ret    

00000000001002b4 <extend>:
//
//	the reason alloating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
int extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  1002b4:	48 81 c7 ff 3f 00 00 	add    $0x3fff,%rdi
  1002bb:	48 81 e7 00 c0 ff ff 	and    $0xffffffffffffc000,%rdi
  1002c2:	cd 3a                	int    $0x3a
  1002c4:	48 89 05 45 21 00 00 	mov    %rax,0x2145(%rip)        # 102410 <result.0>
	void *bp = sbrk(chunk_aligned_size);
	if (bp == (void *)-1)
  1002cb:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  1002cf:	74 51                	je     100322 <extend+0x6e>
		return -1;

	// setup pointer
	PUT(HDRP(bp), PACK(GET_SIZE(HDRP(bp)), 0));	
  1002d1:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1002d5:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1002d9:	48 89 50 f8          	mov    %rdx,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  1002dd:	48 8b 0d 1c 21 00 00 	mov    0x211c(%rip),%rcx        # 102400 <free_list>
  1002e4:	48 89 08             	mov    %rcx,(%rax)
	PREV_FPTR(bp) = NULL;
  1002e7:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  1002ee:	00 
	PUT(FTRP(bp), PACK(GET_SIZE(HDRP(bp)), 0));	
  1002ef:	48 89 54 02 f0       	mov    %rdx,-0x10(%rdx,%rax,1)
	
	// add to head of free_list
	if (free_list)
  1002f4:	48 8b 15 05 21 00 00 	mov    0x2105(%rip),%rdx        # 102400 <free_list>
  1002fb:	48 85 d2             	test   %rdx,%rdx
  1002fe:	74 04                	je     100304 <extend+0x50>
		PREV_FPTR(free_list) = bp;
  100300:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  100304:	48 89 05 f5 20 00 00 	mov    %rax,0x20f5(%rip)        # 102400 <free_list>

	// update terminal block
	PUT(HDRP(NEXT_BLKP(bp)), PACK(0, 1));	
  10030b:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  10030f:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100313:	48 c7 44 10 f8 01 00 	movq   $0x1,-0x8(%rax,%rdx,1)
  10031a:	00 00 

	return 0;
  10031c:	b8 00 00 00 00       	mov    $0x0,%eax
  100321:	c3                   	ret    
		return -1;
  100322:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  100327:	c3                   	ret    

0000000000100328 <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
  100328:	55                   	push   %rbp
  100329:	48 89 e5             	mov    %rsp,%rbp
  10032c:	41 55                	push   %r13
  10032e:	41 54                	push   %r12
  100330:	53                   	push   %rbx
  100331:	48 83 ec 08          	sub    $0x8,%rsp
  100335:	48 89 fb             	mov    %rdi,%rbx
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  100338:	4c 8b 6f f8          	mov    -0x8(%rdi),%r13
  10033c:	49 83 e5 f0          	and    $0xfffffffffffffff0,%r13
  100340:	49 29 f5             	sub    %rsi,%r13

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  100343:	49 83 fd 20          	cmp    $0x20,%r13
  100347:	77 47                	ja     100390 <set_allocated+0x68>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
								    
	}
	else {
		// update the free list
		if (free_list == bp)
  100349:	48 39 3d b0 20 00 00 	cmp    %rdi,0x20b0(%rip)        # 102400 <free_list>
  100350:	0f 84 b8 00 00 00    	je     10040e <set_allocated+0xe6>
			free_list = NEXT_FPTR(bp);

		if (PREV_FPTR(bp))
  100356:	48 8b 43 08          	mov    0x8(%rbx),%rax
  10035a:	48 85 c0             	test   %rax,%rax
  10035d:	74 06                	je     100365 <set_allocated+0x3d>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  10035f:	48 8b 13             	mov    (%rbx),%rdx
  100362:	48 89 10             	mov    %rdx,(%rax)
		if (NEXT_FPTR(bp))
  100365:	48 8b 03             	mov    (%rbx),%rax
  100368:	48 85 c0             	test   %rax,%rax
  10036b:	74 08                	je     100375 <set_allocated+0x4d>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  10036d:	48 8b 53 08          	mov    0x8(%rbx),%rdx
  100371:	48 89 50 08          	mov    %rdx,0x8(%rax)

		PUT(HDRP(bp), PACK(GET_SIZE(HDRP(bp)), 1));	
  100375:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  100379:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  10037d:	48 83 c8 01          	or     $0x1,%rax
  100381:	48 89 43 f8          	mov    %rax,-0x8(%rbx)
	}
}
  100385:	48 83 c4 08          	add    $0x8,%rsp
  100389:	5b                   	pop    %rbx
  10038a:	41 5c                	pop    %r12
  10038c:	41 5d                	pop    %r13
  10038e:	5d                   	pop    %rbp
  10038f:	c3                   	ret    
		PUT(HDRP(bp), PACK(size, 1));
  100390:	48 89 f0             	mov    %rsi,%rax
  100393:	48 83 c8 01          	or     $0x1,%rax
  100397:	48 89 47 f8          	mov    %rax,-0x8(%rdi)
		void *leftover_mem_ptr = NEXT_BLKP(bp);
  10039b:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  10039f:	4c 8d 24 37          	lea    (%rdi,%rsi,1),%r12
    asm volatile ("int %0" : /* no result */
  1003a3:	bf 01 00 00 00       	mov    $0x1,%edi
  1003a8:	cd 38                	int    $0x38
			app_printf(0x700,"%p ", bp);	
  1003aa:	48 89 da             	mov    %rbx,%rdx
  1003ad:	be 32 17 10 00       	mov    $0x101732,%esi
  1003b2:	bf 00 07 00 00       	mov    $0x700,%edi
  1003b7:	b8 00 00 00 00       	mov    $0x0,%eax
  1003bc:	e8 cd fc ff ff       	call   10008e <app_printf>
		PUT(HDRP(leftover_mem_ptr), PACK(extra_size, 0));	
  1003c1:	4d 89 6c 24 f8       	mov    %r13,-0x8(%r12)
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp); // pointers to the next free blocks
  1003c6:	48 8b 03             	mov    (%rbx),%rax
  1003c9:	49 89 04 24          	mov    %rax,(%r12)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  1003cd:	48 8b 43 08          	mov    0x8(%rbx),%rax
  1003d1:	49 89 44 24 08       	mov    %rax,0x8(%r12)
		PUT(FTRP(leftover_mem_ptr), PACK(extra_size, 0));	
  1003d6:	4c 89 e8             	mov    %r13,%rax
  1003d9:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  1003dd:	4d 89 6c 04 f0       	mov    %r13,-0x10(%r12,%rax,1)
		if (free_list == bp)
  1003e2:	48 39 1d 17 20 00 00 	cmp    %rbx,0x2017(%rip)        # 102400 <free_list>
  1003e9:	74 1a                	je     100405 <set_allocated+0xdd>
		if (PREV_FPTR(bp))
  1003eb:	48 8b 43 08          	mov    0x8(%rbx),%rax
  1003ef:	48 85 c0             	test   %rax,%rax
  1003f2:	74 03                	je     1003f7 <set_allocated+0xcf>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  1003f4:	4c 89 20             	mov    %r12,(%rax)
		if (NEXT_FPTR(bp))
  1003f7:	48 8b 03             	mov    (%rbx),%rax
  1003fa:	48 85 c0             	test   %rax,%rax
  1003fd:	74 86                	je     100385 <set_allocated+0x5d>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  1003ff:	4c 89 60 08          	mov    %r12,0x8(%rax)
  100403:	eb 80                	jmp    100385 <set_allocated+0x5d>
			free_list = leftover_mem_ptr;
  100405:	4c 89 25 f4 1f 00 00 	mov    %r12,0x1ff4(%rip)        # 102400 <free_list>
  10040c:	eb dd                	jmp    1003eb <set_allocated+0xc3>
			free_list = NEXT_FPTR(bp);
  10040e:	48 8b 07             	mov    (%rdi),%rax
  100411:	48 89 05 e8 1f 00 00 	mov    %rax,0x1fe8(%rip)        # 102400 <free_list>
  100418:	e9 39 ff ff ff       	jmp    100356 <set_allocated+0x2e>

000000000010041d <malloc>:

void *malloc(uint64_t numbytes) {
  10041d:	55                   	push   %rbp
  10041e:	48 89 e5             	mov    %rsp,%rbp
  100421:	41 55                	push   %r13
  100423:	41 54                	push   %r12
  100425:	53                   	push   %rbx
  100426:	48 83 ec 08          	sub    $0x8,%rsp
  10042a:	49 89 fc             	mov    %rdi,%r12
	if (!initialized_heap)
  10042d:	83 3d d4 1f 00 00 00 	cmpl   $0x0,0x1fd4(%rip)        # 102408 <initialized_heap>
  100434:	74 6b                	je     1004a1 <malloc+0x84>
		heap_init();

	if (numbytes == 0)
  100436:	4d 85 e4             	test   %r12,%r12
  100439:	0f 84 82 00 00 00    	je     1004c1 <malloc+0xa4>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  10043f:	49 83 c4 17          	add    $0x17,%r12
  100443:	49 83 e4 f0          	and    $0xfffffffffffffff0,%r12
  100447:	b8 20 00 00 00       	mov    $0x20,%eax
  10044c:	49 39 c4             	cmp    %rax,%r12
  10044f:	4c 0f 42 e0          	cmovb  %rax,%r12
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);


	void *bp = free_list;
  100453:	48 8b 1d a6 1f 00 00 	mov    0x1fa6(%rip),%rbx        # 102400 <free_list>
	while (bp) {
  10045a:	48 85 db             	test   %rbx,%rbx
  10045d:	74 15                	je     100474 <malloc+0x57>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  10045f:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  100463:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100467:	4c 39 e0             	cmp    %r12,%rax
  10046a:	73 3c                	jae    1004a8 <malloc+0x8b>
			set_allocated(bp, aligned_size);
			return bp;
		}

		bp = NEXT_FPTR(bp);
  10046c:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  10046f:	48 85 db             	test   %rbx,%rbx
  100472:	75 eb                	jne    10045f <malloc+0x42>
    asm volatile ("int %1" :  "=a" (result)
  100474:	bf 00 00 00 00       	mov    $0x0,%edi
  100479:	cd 3a                	int    $0x3a
  10047b:	49 89 c5             	mov    %rax,%r13
  10047e:	48 89 05 8b 1f 00 00 	mov    %rax,0x1f8b(%rip)        # 102410 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  100485:	48 89 c3             	mov    %rax,%rbx
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	if (extend(aligned_size)) {
  100488:	4c 89 e7             	mov    %r12,%rdi
  10048b:	e8 24 fe ff ff       	call   1002b4 <extend>
  100490:	85 c0                	test   %eax,%eax
  100492:	75 34                	jne    1004c8 <malloc+0xab>
		return NULL;
	}
	set_allocated(bp, aligned_size);
  100494:	4c 89 e6             	mov    %r12,%rsi
  100497:	4c 89 ef             	mov    %r13,%rdi
  10049a:	e8 89 fe ff ff       	call   100328 <set_allocated>
    return bp;
  10049f:	eb 12                	jmp    1004b3 <malloc+0x96>
		heap_init();
  1004a1:	e8 75 fd ff ff       	call   10021b <heap_init>
  1004a6:	eb 8e                	jmp    100436 <malloc+0x19>
			set_allocated(bp, aligned_size);
  1004a8:	4c 89 e6             	mov    %r12,%rsi
  1004ab:	48 89 df             	mov    %rbx,%rdi
  1004ae:	e8 75 fe ff ff       	call   100328 <set_allocated>
}
  1004b3:	48 89 d8             	mov    %rbx,%rax
  1004b6:	48 83 c4 08          	add    $0x8,%rsp
  1004ba:	5b                   	pop    %rbx
  1004bb:	41 5c                	pop    %r12
  1004bd:	41 5d                	pop    %r13
  1004bf:	5d                   	pop    %rbp
  1004c0:	c3                   	ret    
		return NULL;
  1004c1:	bb 00 00 00 00       	mov    $0x0,%ebx
  1004c6:	eb eb                	jmp    1004b3 <malloc+0x96>
		return NULL;
  1004c8:	bb 00 00 00 00       	mov    $0x0,%ebx
  1004cd:	eb e4                	jmp    1004b3 <malloc+0x96>

00000000001004cf <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  1004cf:	55                   	push   %rbp
  1004d0:	48 89 e5             	mov    %rsp,%rbp
  1004d3:	41 54                	push   %r12
  1004d5:	53                   	push   %rbx
	void *bp = malloc(num * sz);
  1004d6:	48 0f af fe          	imul   %rsi,%rdi
  1004da:	49 89 fc             	mov    %rdi,%r12
  1004dd:	e8 3b ff ff ff       	call   10041d <malloc>
  1004e2:	48 89 c3             	mov    %rax,%rbx
	if (bp)							// protect against num=0 or size=0
  1004e5:	48 85 c0             	test   %rax,%rax
  1004e8:	74 10                	je     1004fa <calloc+0x2b>
		memset(bp, 0, num * sz);
  1004ea:	4c 89 e2             	mov    %r12,%rdx
  1004ed:	be 00 00 00 00       	mov    $0x0,%esi
  1004f2:	48 89 c7             	mov    %rax,%rdi
  1004f5:	e8 7e 02 00 00       	call   100778 <memset>
	return bp;
}
  1004fa:	48 89 d8             	mov    %rbx,%rax
  1004fd:	5b                   	pop    %rbx
  1004fe:	41 5c                	pop    %r12
  100500:	5d                   	pop    %rbp
  100501:	c3                   	ret    

0000000000100502 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  100502:	55                   	push   %rbp
  100503:	48 89 e5             	mov    %rsp,%rbp
  100506:	41 54                	push   %r12
  100508:	53                   	push   %rbx
  100509:	48 89 fb             	mov    %rdi,%rbx
  10050c:	48 89 f7             	mov    %rsi,%rdi
	// first check if there's enough space in the block already (and that it's actually valid ptr)
	if (ptr && GET_SIZE(HDRP(ptr)) >= sz)
  10050f:	48 85 db             	test   %rbx,%rbx
  100512:	74 10                	je     100524 <realloc+0x22>
  100514:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  100518:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
		return ptr;
  10051c:	49 89 dc             	mov    %rbx,%r12
	if (ptr && GET_SIZE(HDRP(ptr)) >= sz)
  10051f:	48 39 f0             	cmp    %rsi,%rax
  100522:	73 23                	jae    100547 <realloc+0x45>

	// else find or add a big enough block, which is what malloc does
	void *bigger_ptr = malloc(sz);
  100524:	e8 f4 fe ff ff       	call   10041d <malloc>
  100529:	49 89 c4             	mov    %rax,%r12
	memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
  10052c:	48 8b 53 f8          	mov    -0x8(%rbx),%rdx
  100530:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100534:	48 89 de             	mov    %rbx,%rsi
  100537:	48 89 c7             	mov    %rax,%rdi
  10053a:	e8 3b 01 00 00       	call   10067a <memcpy>
	free(ptr);
  10053f:	48 89 df             	mov    %rbx,%rdi
  100542:	e8 32 fd ff ff       	call   100279 <free>

    return bigger_ptr;
}
  100547:	4c 89 e0             	mov    %r12,%rax
  10054a:	5b                   	pop    %rbx
  10054b:	41 5c                	pop    %r12
  10054d:	5d                   	pop    %rbp
  10054e:	c3                   	ret    

000000000010054f <defrag>:

void defrag() {
	void *fp = free_list;
  10054f:	48 8b 05 aa 1e 00 00 	mov    0x1eaa(%rip),%rax        # 102400 <free_list>
	while (fp != NULL) {
  100556:	48 85 c0             	test   %rax,%rax
  100559:	75 50                	jne    1005ab <defrag+0x5c>
			PUT(FTRP(prev_block), PACK(GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp)), 0));	
		}

		fp = NEXT_FPTR(fp);
	}
}
  10055b:	c3                   	ret    
				free_list = NEXT_FPTR(next_block);
  10055c:	48 8b 0a             	mov    (%rdx),%rcx
  10055f:	48 89 0d 9a 1e 00 00 	mov    %rcx,0x1e9a(%rip)        # 102400 <free_list>
  100566:	eb 5d                	jmp    1005c5 <defrag+0x76>
			fp = NEXT_FPTR(fp);
  100568:	48 8b 00             	mov    (%rax),%rax
			continue;
  10056b:	eb 39                	jmp    1005a6 <defrag+0x57>
				free_list = NEXT_FPTR(fp);
  10056d:	48 8b 08             	mov    (%rax),%rcx
  100570:	48 89 0d 89 1e 00 00 	mov    %rcx,0x1e89(%rip)        # 102400 <free_list>
  100577:	e9 d0 00 00 00       	jmp    10064c <defrag+0xfd>
			PUT(HDRP(prev_block), PACK(GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp)), 0));	
  10057c:	48 8b 4a f8          	mov    -0x8(%rdx),%rcx
  100580:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  100584:	48 8b 70 f8          	mov    -0x8(%rax),%rsi
  100588:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  10058c:	48 01 f1             	add    %rsi,%rcx
  10058f:	48 89 4a f8          	mov    %rcx,-0x8(%rdx)
			PUT(FTRP(prev_block), PACK(GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp)), 0));	
  100593:	48 8b 70 f8          	mov    -0x8(%rax),%rsi
  100597:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  10059b:	48 01 ce             	add    %rcx,%rsi
  10059e:	48 89 74 0a f0       	mov    %rsi,-0x10(%rdx,%rcx,1)
		fp = NEXT_FPTR(fp);
  1005a3:	48 8b 00             	mov    (%rax),%rax
	while (fp != NULL) {
  1005a6:	48 85 c0             	test   %rax,%rax
  1005a9:	74 b0                	je     10055b <defrag+0xc>
		void *next_block = NEXT_BLKP(fp);
  1005ab:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1005af:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1005b3:	48 01 c2             	add    %rax,%rdx
		if (!GET_ALLOC(HDRP(next_block))) {
  1005b6:	f6 42 f8 01          	testb  $0x1,-0x8(%rdx)
  1005ba:	75 4f                	jne    10060b <defrag+0xbc>
			if (free_list == next_block)
  1005bc:	48 39 15 3d 1e 00 00 	cmp    %rdx,0x1e3d(%rip)        # 102400 <free_list>
  1005c3:	74 97                	je     10055c <defrag+0xd>
			if (PREV_FPTR(next_block)) 
  1005c5:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  1005c9:	48 85 c9             	test   %rcx,%rcx
  1005cc:	74 06                	je     1005d4 <defrag+0x85>
				NEXT_FPTR(PREV_FPTR(next_block)) = NEXT_FPTR(next_block);
  1005ce:	48 8b 32             	mov    (%rdx),%rsi
  1005d1:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(next_block)) 
  1005d4:	48 8b 0a             	mov    (%rdx),%rcx
  1005d7:	48 85 c9             	test   %rcx,%rcx
  1005da:	74 08                	je     1005e4 <defrag+0x95>
				PREV_FPTR(NEXT_FPTR(next_block)) = PREV_FPTR(next_block);
  1005dc:	48 8b 72 08          	mov    0x8(%rdx),%rsi
  1005e0:	48 89 71 08          	mov    %rsi,0x8(%rcx)
			PUT(HDRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  1005e4:	48 8b 48 f8          	mov    -0x8(%rax),%rcx
  1005e8:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  1005ec:	48 8b 72 f8          	mov    -0x8(%rdx),%rsi
  1005f0:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  1005f4:	48 01 f1             	add    %rsi,%rcx
  1005f7:	48 89 48 f8          	mov    %rcx,-0x8(%rax)
			PUT(FTRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  1005fb:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  1005ff:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100603:	48 01 ca             	add    %rcx,%rdx
  100606:	48 89 54 08 f0       	mov    %rdx,-0x10(%rax,%rcx,1)
		void *prev_block = PREV_BLKP(fp);
  10060b:	48 8b 48 f0          	mov    -0x10(%rax),%rcx
  10060f:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  100613:	48 89 c2             	mov    %rax,%rdx
  100616:	48 29 ca             	sub    %rcx,%rdx
		if (GET_SIZE(HDRP(prev_block)) != GET_SIZE(FTRP(prev_block))){
  100619:	48 8b 4a f8          	mov    -0x8(%rdx),%rcx
  10061d:	48 89 ce             	mov    %rcx,%rsi
  100620:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  100624:	48 89 cf             	mov    %rcx,%rdi
  100627:	48 33 7c 32 f0       	xor    -0x10(%rdx,%rsi,1),%rdi
  10062c:	48 83 ff 0f          	cmp    $0xf,%rdi
  100630:	0f 87 32 ff ff ff    	ja     100568 <defrag+0x19>
		if (!GET_ALLOC(HDRP(prev_block))) {
  100636:	f6 c1 01             	test   $0x1,%cl
  100639:	0f 85 64 ff ff ff    	jne    1005a3 <defrag+0x54>
			if (free_list == fp)
  10063f:	48 39 05 ba 1d 00 00 	cmp    %rax,0x1dba(%rip)        # 102400 <free_list>
  100646:	0f 84 21 ff ff ff    	je     10056d <defrag+0x1e>
			if (PREV_FPTR(fp)) 
  10064c:	48 8b 48 08          	mov    0x8(%rax),%rcx
  100650:	48 85 c9             	test   %rcx,%rcx
  100653:	74 06                	je     10065b <defrag+0x10c>
				NEXT_FPTR(PREV_FPTR(fp)) = NEXT_FPTR(fp);
  100655:	48 8b 30             	mov    (%rax),%rsi
  100658:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(fp)) 
  10065b:	48 8b 08             	mov    (%rax),%rcx
  10065e:	48 85 c9             	test   %rcx,%rcx
  100661:	0f 84 15 ff ff ff    	je     10057c <defrag+0x2d>
				PREV_FPTR(NEXT_FPTR(fp)) = PREV_FPTR(fp);
  100667:	48 8b 70 08          	mov    0x8(%rax),%rsi
  10066b:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  10066f:	e9 08 ff ff ff       	jmp    10057c <defrag+0x2d>

0000000000100674 <heap_info>:

int heap_info(heap_info_struct *info) {
    return 0;
}
  100674:	b8 00 00 00 00       	mov    $0x0,%eax
  100679:	c3                   	ret    

000000000010067a <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  10067a:	55                   	push   %rbp
  10067b:	48 89 e5             	mov    %rsp,%rbp
  10067e:	48 83 ec 28          	sub    $0x28,%rsp
  100682:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100686:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10068a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10068e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100692:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100696:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10069a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  10069e:	eb 1c                	jmp    1006bc <memcpy+0x42>
        *d = *s;
  1006a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006a4:	0f b6 10             	movzbl (%rax),%edx
  1006a7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1006ab:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1006ad:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1006b2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1006b7:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1006bc:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1006c1:	75 dd                	jne    1006a0 <memcpy+0x26>
    }
    return dst;
  1006c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1006c7:	c9                   	leave  
  1006c8:	c3                   	ret    

00000000001006c9 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1006c9:	55                   	push   %rbp
  1006ca:	48 89 e5             	mov    %rsp,%rbp
  1006cd:	48 83 ec 28          	sub    $0x28,%rsp
  1006d1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1006d5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1006d9:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1006dd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1006e1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  1006e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1006e9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  1006ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006f1:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  1006f5:	73 6a                	jae    100761 <memmove+0x98>
  1006f7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1006fb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1006ff:	48 01 d0             	add    %rdx,%rax
  100702:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100706:	73 59                	jae    100761 <memmove+0x98>
        s += n, d += n;
  100708:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10070c:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100710:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100714:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  100718:	eb 17                	jmp    100731 <memmove+0x68>
            *--d = *--s;
  10071a:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  10071f:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100724:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100728:	0f b6 10             	movzbl (%rax),%edx
  10072b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10072f:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100731:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100735:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100739:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  10073d:	48 85 c0             	test   %rax,%rax
  100740:	75 d8                	jne    10071a <memmove+0x51>
    if (s < d && s + n > d) {
  100742:	eb 2e                	jmp    100772 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100744:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100748:	48 8d 42 01          	lea    0x1(%rdx),%rax
  10074c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100750:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100754:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100758:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  10075c:	0f b6 12             	movzbl (%rdx),%edx
  10075f:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100761:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100765:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100769:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  10076d:	48 85 c0             	test   %rax,%rax
  100770:	75 d2                	jne    100744 <memmove+0x7b>
        }
    }
    return dst;
  100772:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100776:	c9                   	leave  
  100777:	c3                   	ret    

0000000000100778 <memset>:

void* memset(void* v, int c, size_t n) {
  100778:	55                   	push   %rbp
  100779:	48 89 e5             	mov    %rsp,%rbp
  10077c:	48 83 ec 28          	sub    $0x28,%rsp
  100780:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100784:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100787:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10078b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10078f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100793:	eb 15                	jmp    1007aa <memset+0x32>
        *p = c;
  100795:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100798:	89 c2                	mov    %eax,%edx
  10079a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10079e:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1007a0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1007a5:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1007aa:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1007af:	75 e4                	jne    100795 <memset+0x1d>
    }
    return v;
  1007b1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1007b5:	c9                   	leave  
  1007b6:	c3                   	ret    

00000000001007b7 <strlen>:

size_t strlen(const char* s) {
  1007b7:	55                   	push   %rbp
  1007b8:	48 89 e5             	mov    %rsp,%rbp
  1007bb:	48 83 ec 18          	sub    $0x18,%rsp
  1007bf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  1007c3:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1007ca:	00 
  1007cb:	eb 0a                	jmp    1007d7 <strlen+0x20>
        ++n;
  1007cd:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  1007d2:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1007d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1007db:	0f b6 00             	movzbl (%rax),%eax
  1007de:	84 c0                	test   %al,%al
  1007e0:	75 eb                	jne    1007cd <strlen+0x16>
    }
    return n;
  1007e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1007e6:	c9                   	leave  
  1007e7:	c3                   	ret    

00000000001007e8 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  1007e8:	55                   	push   %rbp
  1007e9:	48 89 e5             	mov    %rsp,%rbp
  1007ec:	48 83 ec 20          	sub    $0x20,%rsp
  1007f0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1007f4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1007f8:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1007ff:	00 
  100800:	eb 0a                	jmp    10080c <strnlen+0x24>
        ++n;
  100802:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100807:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  10080c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100810:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100814:	74 0b                	je     100821 <strnlen+0x39>
  100816:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10081a:	0f b6 00             	movzbl (%rax),%eax
  10081d:	84 c0                	test   %al,%al
  10081f:	75 e1                	jne    100802 <strnlen+0x1a>
    }
    return n;
  100821:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100825:	c9                   	leave  
  100826:	c3                   	ret    

0000000000100827 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100827:	55                   	push   %rbp
  100828:	48 89 e5             	mov    %rsp,%rbp
  10082b:	48 83 ec 20          	sub    $0x20,%rsp
  10082f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100833:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  100837:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10083b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  10083f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100843:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100847:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  10084b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10084f:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100853:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100857:	0f b6 12             	movzbl (%rdx),%edx
  10085a:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  10085c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100860:	48 83 e8 01          	sub    $0x1,%rax
  100864:	0f b6 00             	movzbl (%rax),%eax
  100867:	84 c0                	test   %al,%al
  100869:	75 d4                	jne    10083f <strcpy+0x18>
    return dst;
  10086b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10086f:	c9                   	leave  
  100870:	c3                   	ret    

0000000000100871 <strcmp>:

int strcmp(const char* a, const char* b) {
  100871:	55                   	push   %rbp
  100872:	48 89 e5             	mov    %rsp,%rbp
  100875:	48 83 ec 10          	sub    $0x10,%rsp
  100879:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  10087d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100881:	eb 0a                	jmp    10088d <strcmp+0x1c>
        ++a, ++b;
  100883:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100888:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10088d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100891:	0f b6 00             	movzbl (%rax),%eax
  100894:	84 c0                	test   %al,%al
  100896:	74 1d                	je     1008b5 <strcmp+0x44>
  100898:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10089c:	0f b6 00             	movzbl (%rax),%eax
  10089f:	84 c0                	test   %al,%al
  1008a1:	74 12                	je     1008b5 <strcmp+0x44>
  1008a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008a7:	0f b6 10             	movzbl (%rax),%edx
  1008aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1008ae:	0f b6 00             	movzbl (%rax),%eax
  1008b1:	38 c2                	cmp    %al,%dl
  1008b3:	74 ce                	je     100883 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  1008b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008b9:	0f b6 00             	movzbl (%rax),%eax
  1008bc:	89 c2                	mov    %eax,%edx
  1008be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1008c2:	0f b6 00             	movzbl (%rax),%eax
  1008c5:	38 d0                	cmp    %dl,%al
  1008c7:	0f 92 c0             	setb   %al
  1008ca:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  1008cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008d1:	0f b6 00             	movzbl (%rax),%eax
  1008d4:	89 c1                	mov    %eax,%ecx
  1008d6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1008da:	0f b6 00             	movzbl (%rax),%eax
  1008dd:	38 c1                	cmp    %al,%cl
  1008df:	0f 92 c0             	setb   %al
  1008e2:	0f b6 c0             	movzbl %al,%eax
  1008e5:	29 c2                	sub    %eax,%edx
  1008e7:	89 d0                	mov    %edx,%eax
}
  1008e9:	c9                   	leave  
  1008ea:	c3                   	ret    

00000000001008eb <strchr>:

char* strchr(const char* s, int c) {
  1008eb:	55                   	push   %rbp
  1008ec:	48 89 e5             	mov    %rsp,%rbp
  1008ef:	48 83 ec 10          	sub    $0x10,%rsp
  1008f3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1008f7:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1008fa:	eb 05                	jmp    100901 <strchr+0x16>
        ++s;
  1008fc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100901:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100905:	0f b6 00             	movzbl (%rax),%eax
  100908:	84 c0                	test   %al,%al
  10090a:	74 0e                	je     10091a <strchr+0x2f>
  10090c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100910:	0f b6 00             	movzbl (%rax),%eax
  100913:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100916:	38 d0                	cmp    %dl,%al
  100918:	75 e2                	jne    1008fc <strchr+0x11>
    }
    if (*s == (char) c) {
  10091a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10091e:	0f b6 00             	movzbl (%rax),%eax
  100921:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100924:	38 d0                	cmp    %dl,%al
  100926:	75 06                	jne    10092e <strchr+0x43>
        return (char*) s;
  100928:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10092c:	eb 05                	jmp    100933 <strchr+0x48>
    } else {
        return NULL;
  10092e:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100933:	c9                   	leave  
  100934:	c3                   	ret    

0000000000100935 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100935:	55                   	push   %rbp
  100936:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  100939:	8b 05 d9 1a 00 00    	mov    0x1ad9(%rip),%eax        # 102418 <rand_seed_set>
  10093f:	85 c0                	test   %eax,%eax
  100941:	75 0a                	jne    10094d <rand+0x18>
        srand(819234718U);
  100943:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100948:	e8 24 00 00 00       	call   100971 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  10094d:	8b 05 c9 1a 00 00    	mov    0x1ac9(%rip),%eax        # 10241c <rand_seed>
  100953:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100959:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  10095e:	89 05 b8 1a 00 00    	mov    %eax,0x1ab8(%rip)        # 10241c <rand_seed>
    return rand_seed & RAND_MAX;
  100964:	8b 05 b2 1a 00 00    	mov    0x1ab2(%rip),%eax        # 10241c <rand_seed>
  10096a:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  10096f:	5d                   	pop    %rbp
  100970:	c3                   	ret    

0000000000100971 <srand>:

void srand(unsigned seed) {
  100971:	55                   	push   %rbp
  100972:	48 89 e5             	mov    %rsp,%rbp
  100975:	48 83 ec 08          	sub    $0x8,%rsp
  100979:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  10097c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10097f:	89 05 97 1a 00 00    	mov    %eax,0x1a97(%rip)        # 10241c <rand_seed>
    rand_seed_set = 1;
  100985:	c7 05 89 1a 00 00 01 	movl   $0x1,0x1a89(%rip)        # 102418 <rand_seed_set>
  10098c:	00 00 00 
}
  10098f:	90                   	nop
  100990:	c9                   	leave  
  100991:	c3                   	ret    

0000000000100992 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100992:	55                   	push   %rbp
  100993:	48 89 e5             	mov    %rsp,%rbp
  100996:	48 83 ec 28          	sub    $0x28,%rsp
  10099a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10099e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1009a2:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  1009a5:	48 c7 45 f8 20 19 10 	movq   $0x101920,-0x8(%rbp)
  1009ac:	00 
    if (base < 0) {
  1009ad:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  1009b1:	79 0b                	jns    1009be <fill_numbuf+0x2c>
        digits = lower_digits;
  1009b3:	48 c7 45 f8 40 19 10 	movq   $0x101940,-0x8(%rbp)
  1009ba:	00 
        base = -base;
  1009bb:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  1009be:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1009c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1009c7:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  1009ca:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1009cd:	48 63 c8             	movslq %eax,%rcx
  1009d0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1009d4:	ba 00 00 00 00       	mov    $0x0,%edx
  1009d9:	48 f7 f1             	div    %rcx
  1009dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009e0:	48 01 d0             	add    %rdx,%rax
  1009e3:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1009e8:	0f b6 10             	movzbl (%rax),%edx
  1009eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1009ef:	88 10                	mov    %dl,(%rax)
        val /= base;
  1009f1:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1009f4:	48 63 f0             	movslq %eax,%rsi
  1009f7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1009fb:	ba 00 00 00 00       	mov    $0x0,%edx
  100a00:	48 f7 f6             	div    %rsi
  100a03:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100a07:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100a0c:	75 bc                	jne    1009ca <fill_numbuf+0x38>
    return numbuf_end;
  100a0e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100a12:	c9                   	leave  
  100a13:	c3                   	ret    

0000000000100a14 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100a14:	55                   	push   %rbp
  100a15:	48 89 e5             	mov    %rsp,%rbp
  100a18:	53                   	push   %rbx
  100a19:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100a20:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100a27:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100a2d:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100a34:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100a3b:	e9 8a 09 00 00       	jmp    1013ca <printer_vprintf+0x9b6>
        if (*format != '%') {
  100a40:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a47:	0f b6 00             	movzbl (%rax),%eax
  100a4a:	3c 25                	cmp    $0x25,%al
  100a4c:	74 31                	je     100a7f <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  100a4e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100a55:	4c 8b 00             	mov    (%rax),%r8
  100a58:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a5f:	0f b6 00             	movzbl (%rax),%eax
  100a62:	0f b6 c8             	movzbl %al,%ecx
  100a65:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100a6b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100a72:	89 ce                	mov    %ecx,%esi
  100a74:	48 89 c7             	mov    %rax,%rdi
  100a77:	41 ff d0             	call   *%r8
            continue;
  100a7a:	e9 43 09 00 00       	jmp    1013c2 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100a7f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100a86:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100a8d:	01 
  100a8e:	eb 44                	jmp    100ad4 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  100a90:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a97:	0f b6 00             	movzbl (%rax),%eax
  100a9a:	0f be c0             	movsbl %al,%eax
  100a9d:	89 c6                	mov    %eax,%esi
  100a9f:	bf 40 17 10 00       	mov    $0x101740,%edi
  100aa4:	e8 42 fe ff ff       	call   1008eb <strchr>
  100aa9:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100aad:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100ab2:	74 30                	je     100ae4 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  100ab4:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100ab8:	48 2d 40 17 10 00    	sub    $0x101740,%rax
  100abe:	ba 01 00 00 00       	mov    $0x1,%edx
  100ac3:	89 c1                	mov    %eax,%ecx
  100ac5:	d3 e2                	shl    %cl,%edx
  100ac7:	89 d0                	mov    %edx,%eax
  100ac9:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100acc:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ad3:	01 
  100ad4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100adb:	0f b6 00             	movzbl (%rax),%eax
  100ade:	84 c0                	test   %al,%al
  100ae0:	75 ae                	jne    100a90 <printer_vprintf+0x7c>
  100ae2:	eb 01                	jmp    100ae5 <printer_vprintf+0xd1>
            } else {
                break;
  100ae4:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100ae5:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100aec:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100af3:	0f b6 00             	movzbl (%rax),%eax
  100af6:	3c 30                	cmp    $0x30,%al
  100af8:	7e 67                	jle    100b61 <printer_vprintf+0x14d>
  100afa:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b01:	0f b6 00             	movzbl (%rax),%eax
  100b04:	3c 39                	cmp    $0x39,%al
  100b06:	7f 59                	jg     100b61 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100b08:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100b0f:	eb 2e                	jmp    100b3f <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100b11:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100b14:	89 d0                	mov    %edx,%eax
  100b16:	c1 e0 02             	shl    $0x2,%eax
  100b19:	01 d0                	add    %edx,%eax
  100b1b:	01 c0                	add    %eax,%eax
  100b1d:	89 c1                	mov    %eax,%ecx
  100b1f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b26:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100b2a:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100b31:	0f b6 00             	movzbl (%rax),%eax
  100b34:	0f be c0             	movsbl %al,%eax
  100b37:	01 c8                	add    %ecx,%eax
  100b39:	83 e8 30             	sub    $0x30,%eax
  100b3c:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100b3f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b46:	0f b6 00             	movzbl (%rax),%eax
  100b49:	3c 2f                	cmp    $0x2f,%al
  100b4b:	0f 8e 85 00 00 00    	jle    100bd6 <printer_vprintf+0x1c2>
  100b51:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b58:	0f b6 00             	movzbl (%rax),%eax
  100b5b:	3c 39                	cmp    $0x39,%al
  100b5d:	7e b2                	jle    100b11 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100b5f:	eb 75                	jmp    100bd6 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100b61:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b68:	0f b6 00             	movzbl (%rax),%eax
  100b6b:	3c 2a                	cmp    $0x2a,%al
  100b6d:	75 68                	jne    100bd7 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100b6f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b76:	8b 00                	mov    (%rax),%eax
  100b78:	83 f8 2f             	cmp    $0x2f,%eax
  100b7b:	77 30                	ja     100bad <printer_vprintf+0x199>
  100b7d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b84:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b88:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b8f:	8b 00                	mov    (%rax),%eax
  100b91:	89 c0                	mov    %eax,%eax
  100b93:	48 01 d0             	add    %rdx,%rax
  100b96:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b9d:	8b 12                	mov    (%rdx),%edx
  100b9f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ba2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ba9:	89 0a                	mov    %ecx,(%rdx)
  100bab:	eb 1a                	jmp    100bc7 <printer_vprintf+0x1b3>
  100bad:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bb4:	48 8b 40 08          	mov    0x8(%rax),%rax
  100bb8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100bbc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bc3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100bc7:	8b 00                	mov    (%rax),%eax
  100bc9:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100bcc:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100bd3:	01 
  100bd4:	eb 01                	jmp    100bd7 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100bd6:	90                   	nop
        }

        // process precision
        int precision = -1;
  100bd7:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100bde:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100be5:	0f b6 00             	movzbl (%rax),%eax
  100be8:	3c 2e                	cmp    $0x2e,%al
  100bea:	0f 85 00 01 00 00    	jne    100cf0 <printer_vprintf+0x2dc>
            ++format;
  100bf0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100bf7:	01 
            if (*format >= '0' && *format <= '9') {
  100bf8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bff:	0f b6 00             	movzbl (%rax),%eax
  100c02:	3c 2f                	cmp    $0x2f,%al
  100c04:	7e 67                	jle    100c6d <printer_vprintf+0x259>
  100c06:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c0d:	0f b6 00             	movzbl (%rax),%eax
  100c10:	3c 39                	cmp    $0x39,%al
  100c12:	7f 59                	jg     100c6d <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100c14:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100c1b:	eb 2e                	jmp    100c4b <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100c1d:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100c20:	89 d0                	mov    %edx,%eax
  100c22:	c1 e0 02             	shl    $0x2,%eax
  100c25:	01 d0                	add    %edx,%eax
  100c27:	01 c0                	add    %eax,%eax
  100c29:	89 c1                	mov    %eax,%ecx
  100c2b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c32:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100c36:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100c3d:	0f b6 00             	movzbl (%rax),%eax
  100c40:	0f be c0             	movsbl %al,%eax
  100c43:	01 c8                	add    %ecx,%eax
  100c45:	83 e8 30             	sub    $0x30,%eax
  100c48:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100c4b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c52:	0f b6 00             	movzbl (%rax),%eax
  100c55:	3c 2f                	cmp    $0x2f,%al
  100c57:	0f 8e 85 00 00 00    	jle    100ce2 <printer_vprintf+0x2ce>
  100c5d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c64:	0f b6 00             	movzbl (%rax),%eax
  100c67:	3c 39                	cmp    $0x39,%al
  100c69:	7e b2                	jle    100c1d <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100c6b:	eb 75                	jmp    100ce2 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100c6d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c74:	0f b6 00             	movzbl (%rax),%eax
  100c77:	3c 2a                	cmp    $0x2a,%al
  100c79:	75 68                	jne    100ce3 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100c7b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c82:	8b 00                	mov    (%rax),%eax
  100c84:	83 f8 2f             	cmp    $0x2f,%eax
  100c87:	77 30                	ja     100cb9 <printer_vprintf+0x2a5>
  100c89:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c90:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c94:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c9b:	8b 00                	mov    (%rax),%eax
  100c9d:	89 c0                	mov    %eax,%eax
  100c9f:	48 01 d0             	add    %rdx,%rax
  100ca2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ca9:	8b 12                	mov    (%rdx),%edx
  100cab:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100cae:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cb5:	89 0a                	mov    %ecx,(%rdx)
  100cb7:	eb 1a                	jmp    100cd3 <printer_vprintf+0x2bf>
  100cb9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cc0:	48 8b 40 08          	mov    0x8(%rax),%rax
  100cc4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100cc8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ccf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100cd3:	8b 00                	mov    (%rax),%eax
  100cd5:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100cd8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100cdf:	01 
  100ce0:	eb 01                	jmp    100ce3 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100ce2:	90                   	nop
            }
            if (precision < 0) {
  100ce3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100ce7:	79 07                	jns    100cf0 <printer_vprintf+0x2dc>
                precision = 0;
  100ce9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100cf0:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100cf7:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100cfe:	00 
        int length = 0;
  100cff:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100d06:	48 c7 45 c8 46 17 10 	movq   $0x101746,-0x38(%rbp)
  100d0d:	00 
    again:
        switch (*format) {
  100d0e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d15:	0f b6 00             	movzbl (%rax),%eax
  100d18:	0f be c0             	movsbl %al,%eax
  100d1b:	83 e8 43             	sub    $0x43,%eax
  100d1e:	83 f8 37             	cmp    $0x37,%eax
  100d21:	0f 87 9f 03 00 00    	ja     1010c6 <printer_vprintf+0x6b2>
  100d27:	89 c0                	mov    %eax,%eax
  100d29:	48 8b 04 c5 58 17 10 	mov    0x101758(,%rax,8),%rax
  100d30:	00 
  100d31:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100d33:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100d3a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100d41:	01 
            goto again;
  100d42:	eb ca                	jmp    100d0e <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100d44:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100d48:	74 5d                	je     100da7 <printer_vprintf+0x393>
  100d4a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d51:	8b 00                	mov    (%rax),%eax
  100d53:	83 f8 2f             	cmp    $0x2f,%eax
  100d56:	77 30                	ja     100d88 <printer_vprintf+0x374>
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
  100d86:	eb 1a                	jmp    100da2 <printer_vprintf+0x38e>
  100d88:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d8f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d93:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d97:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d9e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100da2:	48 8b 00             	mov    (%rax),%rax
  100da5:	eb 5c                	jmp    100e03 <printer_vprintf+0x3ef>
  100da7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dae:	8b 00                	mov    (%rax),%eax
  100db0:	83 f8 2f             	cmp    $0x2f,%eax
  100db3:	77 30                	ja     100de5 <printer_vprintf+0x3d1>
  100db5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dbc:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100dc0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dc7:	8b 00                	mov    (%rax),%eax
  100dc9:	89 c0                	mov    %eax,%eax
  100dcb:	48 01 d0             	add    %rdx,%rax
  100dce:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dd5:	8b 12                	mov    (%rdx),%edx
  100dd7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100dda:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100de1:	89 0a                	mov    %ecx,(%rdx)
  100de3:	eb 1a                	jmp    100dff <printer_vprintf+0x3eb>
  100de5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dec:	48 8b 40 08          	mov    0x8(%rax),%rax
  100df0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100df4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dfb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100dff:	8b 00                	mov    (%rax),%eax
  100e01:	48 98                	cltq   
  100e03:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100e07:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100e0b:	48 c1 f8 38          	sar    $0x38,%rax
  100e0f:	25 80 00 00 00       	and    $0x80,%eax
  100e14:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100e17:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100e1b:	74 09                	je     100e26 <printer_vprintf+0x412>
  100e1d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100e21:	48 f7 d8             	neg    %rax
  100e24:	eb 04                	jmp    100e2a <printer_vprintf+0x416>
  100e26:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100e2a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100e2e:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100e31:	83 c8 60             	or     $0x60,%eax
  100e34:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100e37:	e9 cf 02 00 00       	jmp    10110b <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100e3c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100e40:	74 5d                	je     100e9f <printer_vprintf+0x48b>
  100e42:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e49:	8b 00                	mov    (%rax),%eax
  100e4b:	83 f8 2f             	cmp    $0x2f,%eax
  100e4e:	77 30                	ja     100e80 <printer_vprintf+0x46c>
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
  100e7e:	eb 1a                	jmp    100e9a <printer_vprintf+0x486>
  100e80:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e87:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e8b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e8f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e96:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e9a:	48 8b 00             	mov    (%rax),%rax
  100e9d:	eb 5c                	jmp    100efb <printer_vprintf+0x4e7>
  100e9f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ea6:	8b 00                	mov    (%rax),%eax
  100ea8:	83 f8 2f             	cmp    $0x2f,%eax
  100eab:	77 30                	ja     100edd <printer_vprintf+0x4c9>
  100ead:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100eb4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100eb8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ebf:	8b 00                	mov    (%rax),%eax
  100ec1:	89 c0                	mov    %eax,%eax
  100ec3:	48 01 d0             	add    %rdx,%rax
  100ec6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ecd:	8b 12                	mov    (%rdx),%edx
  100ecf:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ed2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ed9:	89 0a                	mov    %ecx,(%rdx)
  100edb:	eb 1a                	jmp    100ef7 <printer_vprintf+0x4e3>
  100edd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ee4:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ee8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100eec:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ef3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ef7:	8b 00                	mov    (%rax),%eax
  100ef9:	89 c0                	mov    %eax,%eax
  100efb:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100eff:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100f03:	e9 03 02 00 00       	jmp    10110b <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100f08:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100f0f:	e9 28 ff ff ff       	jmp    100e3c <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100f14:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100f1b:	e9 1c ff ff ff       	jmp    100e3c <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100f20:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f27:	8b 00                	mov    (%rax),%eax
  100f29:	83 f8 2f             	cmp    $0x2f,%eax
  100f2c:	77 30                	ja     100f5e <printer_vprintf+0x54a>
  100f2e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f35:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100f39:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f40:	8b 00                	mov    (%rax),%eax
  100f42:	89 c0                	mov    %eax,%eax
  100f44:	48 01 d0             	add    %rdx,%rax
  100f47:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f4e:	8b 12                	mov    (%rdx),%edx
  100f50:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100f53:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f5a:	89 0a                	mov    %ecx,(%rdx)
  100f5c:	eb 1a                	jmp    100f78 <printer_vprintf+0x564>
  100f5e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f65:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f69:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f6d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f74:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f78:	48 8b 00             	mov    (%rax),%rax
  100f7b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100f7f:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100f86:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100f8d:	e9 79 01 00 00       	jmp    10110b <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100f92:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f99:	8b 00                	mov    (%rax),%eax
  100f9b:	83 f8 2f             	cmp    $0x2f,%eax
  100f9e:	77 30                	ja     100fd0 <printer_vprintf+0x5bc>
  100fa0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fa7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100fab:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fb2:	8b 00                	mov    (%rax),%eax
  100fb4:	89 c0                	mov    %eax,%eax
  100fb6:	48 01 d0             	add    %rdx,%rax
  100fb9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fc0:	8b 12                	mov    (%rdx),%edx
  100fc2:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100fc5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fcc:	89 0a                	mov    %ecx,(%rdx)
  100fce:	eb 1a                	jmp    100fea <printer_vprintf+0x5d6>
  100fd0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fd7:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fdb:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100fdf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fe6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100fea:	48 8b 00             	mov    (%rax),%rax
  100fed:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100ff1:	e9 15 01 00 00       	jmp    10110b <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100ff6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ffd:	8b 00                	mov    (%rax),%eax
  100fff:	83 f8 2f             	cmp    $0x2f,%eax
  101002:	77 30                	ja     101034 <printer_vprintf+0x620>
  101004:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10100b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10100f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101016:	8b 00                	mov    (%rax),%eax
  101018:	89 c0                	mov    %eax,%eax
  10101a:	48 01 d0             	add    %rdx,%rax
  10101d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101024:	8b 12                	mov    (%rdx),%edx
  101026:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101029:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101030:	89 0a                	mov    %ecx,(%rdx)
  101032:	eb 1a                	jmp    10104e <printer_vprintf+0x63a>
  101034:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10103b:	48 8b 40 08          	mov    0x8(%rax),%rax
  10103f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101043:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10104a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10104e:	8b 00                	mov    (%rax),%eax
  101050:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  101056:	e9 67 03 00 00       	jmp    1013c2 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  10105b:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  10105f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  101063:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10106a:	8b 00                	mov    (%rax),%eax
  10106c:	83 f8 2f             	cmp    $0x2f,%eax
  10106f:	77 30                	ja     1010a1 <printer_vprintf+0x68d>
  101071:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101078:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10107c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101083:	8b 00                	mov    (%rax),%eax
  101085:	89 c0                	mov    %eax,%eax
  101087:	48 01 d0             	add    %rdx,%rax
  10108a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101091:	8b 12                	mov    (%rdx),%edx
  101093:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101096:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10109d:	89 0a                	mov    %ecx,(%rdx)
  10109f:	eb 1a                	jmp    1010bb <printer_vprintf+0x6a7>
  1010a1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010a8:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010ac:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1010b0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010b7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1010bb:	8b 00                	mov    (%rax),%eax
  1010bd:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  1010c0:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  1010c4:	eb 45                	jmp    10110b <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  1010c6:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1010ca:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  1010ce:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1010d5:	0f b6 00             	movzbl (%rax),%eax
  1010d8:	84 c0                	test   %al,%al
  1010da:	74 0c                	je     1010e8 <printer_vprintf+0x6d4>
  1010dc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1010e3:	0f b6 00             	movzbl (%rax),%eax
  1010e6:	eb 05                	jmp    1010ed <printer_vprintf+0x6d9>
  1010e8:	b8 25 00 00 00       	mov    $0x25,%eax
  1010ed:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  1010f0:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  1010f4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1010fb:	0f b6 00             	movzbl (%rax),%eax
  1010fe:	84 c0                	test   %al,%al
  101100:	75 08                	jne    10110a <printer_vprintf+0x6f6>
                format--;
  101102:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  101109:	01 
            }
            break;
  10110a:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  10110b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10110e:	83 e0 20             	and    $0x20,%eax
  101111:	85 c0                	test   %eax,%eax
  101113:	74 1e                	je     101133 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  101115:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101119:	48 83 c0 18          	add    $0x18,%rax
  10111d:	8b 55 e0             	mov    -0x20(%rbp),%edx
  101120:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101124:	48 89 ce             	mov    %rcx,%rsi
  101127:	48 89 c7             	mov    %rax,%rdi
  10112a:	e8 63 f8 ff ff       	call   100992 <fill_numbuf>
  10112f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  101133:	48 c7 45 c0 46 17 10 	movq   $0x101746,-0x40(%rbp)
  10113a:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  10113b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10113e:	83 e0 20             	and    $0x20,%eax
  101141:	85 c0                	test   %eax,%eax
  101143:	74 48                	je     10118d <printer_vprintf+0x779>
  101145:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101148:	83 e0 40             	and    $0x40,%eax
  10114b:	85 c0                	test   %eax,%eax
  10114d:	74 3e                	je     10118d <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  10114f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101152:	25 80 00 00 00       	and    $0x80,%eax
  101157:	85 c0                	test   %eax,%eax
  101159:	74 0a                	je     101165 <printer_vprintf+0x751>
                prefix = "-";
  10115b:	48 c7 45 c0 47 17 10 	movq   $0x101747,-0x40(%rbp)
  101162:	00 
            if (flags & FLAG_NEGATIVE) {
  101163:	eb 73                	jmp    1011d8 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  101165:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101168:	83 e0 10             	and    $0x10,%eax
  10116b:	85 c0                	test   %eax,%eax
  10116d:	74 0a                	je     101179 <printer_vprintf+0x765>
                prefix = "+";
  10116f:	48 c7 45 c0 49 17 10 	movq   $0x101749,-0x40(%rbp)
  101176:	00 
            if (flags & FLAG_NEGATIVE) {
  101177:	eb 5f                	jmp    1011d8 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  101179:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10117c:	83 e0 08             	and    $0x8,%eax
  10117f:	85 c0                	test   %eax,%eax
  101181:	74 55                	je     1011d8 <printer_vprintf+0x7c4>
                prefix = " ";
  101183:	48 c7 45 c0 4b 17 10 	movq   $0x10174b,-0x40(%rbp)
  10118a:	00 
            if (flags & FLAG_NEGATIVE) {
  10118b:	eb 4b                	jmp    1011d8 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  10118d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101190:	83 e0 20             	and    $0x20,%eax
  101193:	85 c0                	test   %eax,%eax
  101195:	74 42                	je     1011d9 <printer_vprintf+0x7c5>
  101197:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10119a:	83 e0 01             	and    $0x1,%eax
  10119d:	85 c0                	test   %eax,%eax
  10119f:	74 38                	je     1011d9 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  1011a1:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  1011a5:	74 06                	je     1011ad <printer_vprintf+0x799>
  1011a7:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1011ab:	75 2c                	jne    1011d9 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  1011ad:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1011b2:	75 0c                	jne    1011c0 <printer_vprintf+0x7ac>
  1011b4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011b7:	25 00 01 00 00       	and    $0x100,%eax
  1011bc:	85 c0                	test   %eax,%eax
  1011be:	74 19                	je     1011d9 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  1011c0:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1011c4:	75 07                	jne    1011cd <printer_vprintf+0x7b9>
  1011c6:	b8 4d 17 10 00       	mov    $0x10174d,%eax
  1011cb:	eb 05                	jmp    1011d2 <printer_vprintf+0x7be>
  1011cd:	b8 50 17 10 00       	mov    $0x101750,%eax
  1011d2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1011d6:	eb 01                	jmp    1011d9 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  1011d8:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  1011d9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1011dd:	78 24                	js     101203 <printer_vprintf+0x7ef>
  1011df:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011e2:	83 e0 20             	and    $0x20,%eax
  1011e5:	85 c0                	test   %eax,%eax
  1011e7:	75 1a                	jne    101203 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  1011e9:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1011ec:	48 63 d0             	movslq %eax,%rdx
  1011ef:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1011f3:	48 89 d6             	mov    %rdx,%rsi
  1011f6:	48 89 c7             	mov    %rax,%rdi
  1011f9:	e8 ea f5 ff ff       	call   1007e8 <strnlen>
  1011fe:	89 45 bc             	mov    %eax,-0x44(%rbp)
  101201:	eb 0f                	jmp    101212 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  101203:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101207:	48 89 c7             	mov    %rax,%rdi
  10120a:	e8 a8 f5 ff ff       	call   1007b7 <strlen>
  10120f:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  101212:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101215:	83 e0 20             	and    $0x20,%eax
  101218:	85 c0                	test   %eax,%eax
  10121a:	74 20                	je     10123c <printer_vprintf+0x828>
  10121c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101220:	78 1a                	js     10123c <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  101222:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101225:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  101228:	7e 08                	jle    101232 <printer_vprintf+0x81e>
  10122a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10122d:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101230:	eb 05                	jmp    101237 <printer_vprintf+0x823>
  101232:	b8 00 00 00 00       	mov    $0x0,%eax
  101237:	89 45 b8             	mov    %eax,-0x48(%rbp)
  10123a:	eb 5c                	jmp    101298 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  10123c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10123f:	83 e0 20             	and    $0x20,%eax
  101242:	85 c0                	test   %eax,%eax
  101244:	74 4b                	je     101291 <printer_vprintf+0x87d>
  101246:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101249:	83 e0 02             	and    $0x2,%eax
  10124c:	85 c0                	test   %eax,%eax
  10124e:	74 41                	je     101291 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  101250:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101253:	83 e0 04             	and    $0x4,%eax
  101256:	85 c0                	test   %eax,%eax
  101258:	75 37                	jne    101291 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  10125a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10125e:	48 89 c7             	mov    %rax,%rdi
  101261:	e8 51 f5 ff ff       	call   1007b7 <strlen>
  101266:	89 c2                	mov    %eax,%edx
  101268:	8b 45 bc             	mov    -0x44(%rbp),%eax
  10126b:	01 d0                	add    %edx,%eax
  10126d:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  101270:	7e 1f                	jle    101291 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  101272:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101275:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101278:	89 c3                	mov    %eax,%ebx
  10127a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10127e:	48 89 c7             	mov    %rax,%rdi
  101281:	e8 31 f5 ff ff       	call   1007b7 <strlen>
  101286:	89 c2                	mov    %eax,%edx
  101288:	89 d8                	mov    %ebx,%eax
  10128a:	29 d0                	sub    %edx,%eax
  10128c:	89 45 b8             	mov    %eax,-0x48(%rbp)
  10128f:	eb 07                	jmp    101298 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  101291:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  101298:	8b 55 bc             	mov    -0x44(%rbp),%edx
  10129b:	8b 45 b8             	mov    -0x48(%rbp),%eax
  10129e:	01 d0                	add    %edx,%eax
  1012a0:	48 63 d8             	movslq %eax,%rbx
  1012a3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1012a7:	48 89 c7             	mov    %rax,%rdi
  1012aa:	e8 08 f5 ff ff       	call   1007b7 <strlen>
  1012af:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  1012b3:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1012b6:	29 d0                	sub    %edx,%eax
  1012b8:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1012bb:	eb 25                	jmp    1012e2 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  1012bd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012c4:	48 8b 08             	mov    (%rax),%rcx
  1012c7:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1012cd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012d4:	be 20 00 00 00       	mov    $0x20,%esi
  1012d9:	48 89 c7             	mov    %rax,%rdi
  1012dc:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1012de:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1012e2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1012e5:	83 e0 04             	and    $0x4,%eax
  1012e8:	85 c0                	test   %eax,%eax
  1012ea:	75 36                	jne    101322 <printer_vprintf+0x90e>
  1012ec:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1012f0:	7f cb                	jg     1012bd <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  1012f2:	eb 2e                	jmp    101322 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  1012f4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012fb:	4c 8b 00             	mov    (%rax),%r8
  1012fe:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101302:	0f b6 00             	movzbl (%rax),%eax
  101305:	0f b6 c8             	movzbl %al,%ecx
  101308:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10130e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101315:	89 ce                	mov    %ecx,%esi
  101317:	48 89 c7             	mov    %rax,%rdi
  10131a:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  10131d:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  101322:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101326:	0f b6 00             	movzbl (%rax),%eax
  101329:	84 c0                	test   %al,%al
  10132b:	75 c7                	jne    1012f4 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  10132d:	eb 25                	jmp    101354 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  10132f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101336:	48 8b 08             	mov    (%rax),%rcx
  101339:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10133f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101346:	be 30 00 00 00       	mov    $0x30,%esi
  10134b:	48 89 c7             	mov    %rax,%rdi
  10134e:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  101350:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  101354:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  101358:	7f d5                	jg     10132f <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  10135a:	eb 32                	jmp    10138e <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  10135c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101363:	4c 8b 00             	mov    (%rax),%r8
  101366:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  10136a:	0f b6 00             	movzbl (%rax),%eax
  10136d:	0f b6 c8             	movzbl %al,%ecx
  101370:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101376:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10137d:	89 ce                	mov    %ecx,%esi
  10137f:	48 89 c7             	mov    %rax,%rdi
  101382:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  101385:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  10138a:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  10138e:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  101392:	7f c8                	jg     10135c <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  101394:	eb 25                	jmp    1013bb <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  101396:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10139d:	48 8b 08             	mov    (%rax),%rcx
  1013a0:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1013a6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1013ad:	be 20 00 00 00       	mov    $0x20,%esi
  1013b2:	48 89 c7             	mov    %rax,%rdi
  1013b5:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  1013b7:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1013bb:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1013bf:	7f d5                	jg     101396 <printer_vprintf+0x982>
        }
    done: ;
  1013c1:	90                   	nop
    for (; *format; ++format) {
  1013c2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1013c9:	01 
  1013ca:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1013d1:	0f b6 00             	movzbl (%rax),%eax
  1013d4:	84 c0                	test   %al,%al
  1013d6:	0f 85 64 f6 ff ff    	jne    100a40 <printer_vprintf+0x2c>
    }
}
  1013dc:	90                   	nop
  1013dd:	90                   	nop
  1013de:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1013e2:	c9                   	leave  
  1013e3:	c3                   	ret    

00000000001013e4 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1013e4:	55                   	push   %rbp
  1013e5:	48 89 e5             	mov    %rsp,%rbp
  1013e8:	48 83 ec 20          	sub    $0x20,%rsp
  1013ec:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1013f0:	89 f0                	mov    %esi,%eax
  1013f2:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1013f5:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  1013f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1013fc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101400:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101404:	48 8b 40 08          	mov    0x8(%rax),%rax
  101408:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  10140d:	48 39 d0             	cmp    %rdx,%rax
  101410:	72 0c                	jb     10141e <console_putc+0x3a>
        cp->cursor = console;
  101412:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101416:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  10141d:	00 
    }
    if (c == '\n') {
  10141e:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  101422:	75 78                	jne    10149c <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  101424:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101428:	48 8b 40 08          	mov    0x8(%rax),%rax
  10142c:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  101432:	48 d1 f8             	sar    %rax
  101435:	48 89 c1             	mov    %rax,%rcx
  101438:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  10143f:	66 66 66 
  101442:	48 89 c8             	mov    %rcx,%rax
  101445:	48 f7 ea             	imul   %rdx
  101448:	48 c1 fa 05          	sar    $0x5,%rdx
  10144c:	48 89 c8             	mov    %rcx,%rax
  10144f:	48 c1 f8 3f          	sar    $0x3f,%rax
  101453:	48 29 c2             	sub    %rax,%rdx
  101456:	48 89 d0             	mov    %rdx,%rax
  101459:	48 c1 e0 02          	shl    $0x2,%rax
  10145d:	48 01 d0             	add    %rdx,%rax
  101460:	48 c1 e0 04          	shl    $0x4,%rax
  101464:	48 29 c1             	sub    %rax,%rcx
  101467:	48 89 ca             	mov    %rcx,%rdx
  10146a:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  10146d:	eb 25                	jmp    101494 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  10146f:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101472:	83 c8 20             	or     $0x20,%eax
  101475:	89 c6                	mov    %eax,%esi
  101477:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10147b:	48 8b 40 08          	mov    0x8(%rax),%rax
  10147f:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101483:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101487:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10148b:	89 f2                	mov    %esi,%edx
  10148d:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  101490:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101494:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101498:	75 d5                	jne    10146f <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  10149a:	eb 24                	jmp    1014c0 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  10149c:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  1014a0:	8b 55 e0             	mov    -0x20(%rbp),%edx
  1014a3:	09 d0                	or     %edx,%eax
  1014a5:	89 c6                	mov    %eax,%esi
  1014a7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1014ab:	48 8b 40 08          	mov    0x8(%rax),%rax
  1014af:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1014b3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1014b7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1014bb:	89 f2                	mov    %esi,%edx
  1014bd:	66 89 10             	mov    %dx,(%rax)
}
  1014c0:	90                   	nop
  1014c1:	c9                   	leave  
  1014c2:	c3                   	ret    

00000000001014c3 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1014c3:	55                   	push   %rbp
  1014c4:	48 89 e5             	mov    %rsp,%rbp
  1014c7:	48 83 ec 30          	sub    $0x30,%rsp
  1014cb:	89 7d ec             	mov    %edi,-0x14(%rbp)
  1014ce:	89 75 e8             	mov    %esi,-0x18(%rbp)
  1014d1:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1014d5:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  1014d9:	48 c7 45 f0 e4 13 10 	movq   $0x1013e4,-0x10(%rbp)
  1014e0:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1014e1:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  1014e5:	78 09                	js     1014f0 <console_vprintf+0x2d>
  1014e7:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  1014ee:	7e 07                	jle    1014f7 <console_vprintf+0x34>
        cpos = 0;
  1014f0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  1014f7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1014fa:	48 98                	cltq   
  1014fc:	48 01 c0             	add    %rax,%rax
  1014ff:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  101505:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101509:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  10150d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  101511:	8b 75 e8             	mov    -0x18(%rbp),%esi
  101514:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101518:	48 89 c7             	mov    %rax,%rdi
  10151b:	e8 f4 f4 ff ff       	call   100a14 <printer_vprintf>
    return cp.cursor - console;
  101520:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101524:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  10152a:	48 d1 f8             	sar    %rax
}
  10152d:	c9                   	leave  
  10152e:	c3                   	ret    

000000000010152f <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  10152f:	55                   	push   %rbp
  101530:	48 89 e5             	mov    %rsp,%rbp
  101533:	48 83 ec 60          	sub    $0x60,%rsp
  101537:	89 7d ac             	mov    %edi,-0x54(%rbp)
  10153a:	89 75 a8             	mov    %esi,-0x58(%rbp)
  10153d:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  101541:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101545:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101549:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  10154d:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101554:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101558:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  10155c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101560:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101564:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101568:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  10156c:	8b 75 a8             	mov    -0x58(%rbp),%esi
  10156f:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101572:	89 c7                	mov    %eax,%edi
  101574:	e8 4a ff ff ff       	call   1014c3 <console_vprintf>
  101579:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  10157c:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  10157f:	c9                   	leave  
  101580:	c3                   	ret    

0000000000101581 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101581:	55                   	push   %rbp
  101582:	48 89 e5             	mov    %rsp,%rbp
  101585:	48 83 ec 20          	sub    $0x20,%rsp
  101589:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10158d:	89 f0                	mov    %esi,%eax
  10158f:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101592:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101595:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101599:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  10159d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1015a1:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1015a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1015a9:	48 8b 40 10          	mov    0x10(%rax),%rax
  1015ad:	48 39 c2             	cmp    %rax,%rdx
  1015b0:	73 1a                	jae    1015cc <string_putc+0x4b>
        *sp->s++ = c;
  1015b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1015b6:	48 8b 40 08          	mov    0x8(%rax),%rax
  1015ba:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1015be:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1015c2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1015c6:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1015ca:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1015cc:	90                   	nop
  1015cd:	c9                   	leave  
  1015ce:	c3                   	ret    

00000000001015cf <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1015cf:	55                   	push   %rbp
  1015d0:	48 89 e5             	mov    %rsp,%rbp
  1015d3:	48 83 ec 40          	sub    $0x40,%rsp
  1015d7:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  1015db:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  1015df:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  1015e3:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1015e7:	48 c7 45 e8 81 15 10 	movq   $0x101581,-0x18(%rbp)
  1015ee:	00 
    sp.s = s;
  1015ef:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1015f3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1015f7:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1015fc:	74 33                	je     101631 <vsnprintf+0x62>
        sp.end = s + size - 1;
  1015fe:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101602:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101606:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10160a:	48 01 d0             	add    %rdx,%rax
  10160d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101611:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101615:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101619:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  10161d:	be 00 00 00 00       	mov    $0x0,%esi
  101622:	48 89 c7             	mov    %rax,%rdi
  101625:	e8 ea f3 ff ff       	call   100a14 <printer_vprintf>
        *sp.s = 0;
  10162a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10162e:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  101631:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101635:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  101639:	c9                   	leave  
  10163a:	c3                   	ret    

000000000010163b <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  10163b:	55                   	push   %rbp
  10163c:	48 89 e5             	mov    %rsp,%rbp
  10163f:	48 83 ec 70          	sub    $0x70,%rsp
  101643:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101647:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  10164b:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  10164f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101653:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101657:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  10165b:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101662:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101666:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  10166a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10166e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101672:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101676:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  10167a:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  10167e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101682:	48 89 c7             	mov    %rax,%rdi
  101685:	e8 45 ff ff ff       	call   1015cf <vsnprintf>
  10168a:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  10168d:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101690:	c9                   	leave  
  101691:	c3                   	ret    

0000000000101692 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101692:	55                   	push   %rbp
  101693:	48 89 e5             	mov    %rsp,%rbp
  101696:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10169a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  1016a1:	eb 13                	jmp    1016b6 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  1016a3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1016a6:	48 98                	cltq   
  1016a8:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  1016af:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1016b2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1016b6:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1016bd:	7e e4                	jle    1016a3 <console_clear+0x11>
    }
    cursorpos = 0;
  1016bf:	c7 05 33 79 fb ff 00 	movl   $0x0,-0x486cd(%rip)        # b8ffc <cursorpos>
  1016c6:	00 00 00 
}
  1016c9:	90                   	nop
  1016ca:	c9                   	leave  
  1016cb:	c3                   	ret    
