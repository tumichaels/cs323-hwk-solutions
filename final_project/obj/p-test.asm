
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
  100008:	e8 df 06 00 00       	call   1006ec <srand>
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
  10003f:	e8 21 03 00 00       	call   100365 <malloc>
    if (ptr == (void*)0x103060)
  100044:	48 3d 60 30 10 00    	cmp    $0x103060,%rax
  10004a:	74 0f                	je     10005b <process_main+0x5b>
	    panic("success!");

    TEST_PASS();
  10004c:	bf 59 14 10 00       	mov    $0x101459,%edi
  100051:	b8 00 00 00 00       	mov    $0x0,%eax
  100056:	e8 99 00 00 00       	call   1000f4 <kernel_panic>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  10005b:	bf 50 14 10 00       	mov    $0x101450,%edi
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
  1000ac:	0f b6 b7 ad 14 10 00 	movzbl 0x1014ad(%rdi),%esi
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
  1000da:	e8 5f 11 00 00       	call   10123e <console_vprintf>
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
  100133:	be 74 14 10 00       	mov    $0x101474,%esi
  100138:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  10013f:	e8 b1 02 00 00       	call   1003f5 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100144:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100148:	48 89 da             	mov    %rbx,%rdx
  10014b:	be 99 00 00 00       	mov    $0x99,%esi
  100150:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100157:	e8 ee 11 00 00       	call   10134a <vsnprintf>
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
  10017c:	ba 7e 14 10 00       	mov    $0x10147e,%edx
  100181:	be 00 c0 00 00       	mov    $0xc000,%esi
  100186:	bf 30 07 00 00       	mov    $0x730,%edi
  10018b:	b8 00 00 00 00       	mov    $0x0,%eax
  100190:	e8 15 11 00 00       	call   1012aa <console_printf>
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
  1001b6:	be 7c 14 10 00       	mov    $0x10147c,%esi
  1001bb:	e8 e2 03 00 00       	call   1005a2 <strcpy>
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
  1001cf:	ba 88 14 10 00       	mov    $0x101488,%edx
  1001d4:	be 00 c0 00 00       	mov    $0xc000,%esi
  1001d9:	bf 30 07 00 00       	mov    $0x730,%edi
  1001de:	b8 00 00 00 00       	mov    $0x0,%eax
  1001e3:	e8 c2 10 00 00       	call   1012aa <console_printf>
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
	return;
}
  10027f:	c3                   	ret    

0000000000100280 <extend>:
//
//	the reason alloating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
void extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  100280:	48 81 c7 ff 3f 00 00 	add    $0x3fff,%rdi
  100287:	48 81 e7 00 c0 ff ff 	and    $0xffffffffffffc000,%rdi
  10028e:	cd 3a                	int    $0x3a
  100290:	48 89 05 81 21 00 00 	mov    %rax,0x2181(%rip)        # 102418 <result.0>
	void *bp = sbrk(chunk_aligned_size);

	// setup pointer
	GET_SIZE(HDRP(bp)) = chunk_aligned_size;
  100297:	48 89 78 f0          	mov    %rdi,-0x10(%rax)
	GET_ALLOC(HDRP(bp)) = 0;
  10029b:	c7 40 f8 00 00 00 00 	movl   $0x0,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  1002a2:	48 8b 15 57 21 00 00 	mov    0x2157(%rip),%rdx        # 102400 <free_list>
  1002a9:	48 89 10             	mov    %rdx,(%rax)
	PREV_FPTR(bp) = NULL;
  1002ac:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  1002b3:	00 
	GET_SIZE(FTRP(bp)) = chunk_aligned_size;
  1002b4:	48 89 7c 07 e0       	mov    %rdi,-0x20(%rdi,%rax,1)

	// add to head of free_list
	if (free_list)
  1002b9:	48 8b 15 40 21 00 00 	mov    0x2140(%rip),%rdx        # 102400 <free_list>
  1002c0:	48 85 d2             	test   %rdx,%rdx
  1002c3:	74 04                	je     1002c9 <extend+0x49>
		PREV_FPTR(free_list) = bp;
  1002c5:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  1002c9:	48 89 05 30 21 00 00 	mov    %rax,0x2130(%rip)        # 102400 <free_list>

	// update terminal block
	GET_SIZE(HDRP(NEXT_BLKP(bp))) = 0;
  1002d0:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  1002d4:	48 c7 44 10 f0 00 00 	movq   $0x0,-0x10(%rax,%rdx,1)
  1002db:	00 00 
	GET_ALLOC(HDRP(NEXT_BLKP(bp))) = 1;
  1002dd:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  1002e1:	c7 44 10 f8 01 00 00 	movl   $0x1,-0x8(%rax,%rdx,1)
  1002e8:	00 
    asm volatile ("int %0" : /* no result */
  1002e9:	bf b2 14 10 00       	mov    $0x1014b2,%edi
  1002ee:	cd 30                	int    $0x30
 loop: goto loop;
  1002f0:	eb fe                	jmp    1002f0 <extend+0x70>

00000000001002f2 <set_allocated>:
}

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  1002f2:	48 8b 47 f0          	mov    -0x10(%rdi),%rax
  1002f6:	48 29 f0             	sub    %rsi,%rax

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  1002f9:	48 83 f8 30          	cmp    $0x30,%rax
  1002fd:	76 45                	jbe    100344 <set_allocated+0x52>
		GET_SIZE(HDRP(bp)) = size;
  1002ff:	48 89 77 f0          	mov    %rsi,-0x10(%rdi)
		void *leftover_mem_ptr = NEXT_BLKP(bp);
  100303:	48 01 fe             	add    %rdi,%rsi

		GET_SIZE(HDRP(leftover_mem_ptr)) = extra_size;
  100306:	48 89 46 f0          	mov    %rax,-0x10(%rsi)
		GET_ALLOC(HDRP(leftover_mem_ptr)) = 0;
  10030a:	c7 46 f8 00 00 00 00 	movl   $0x0,-0x8(%rsi)

		// add pointers to previous and next free block
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp);
  100311:	48 8b 17             	mov    (%rdi),%rdx
  100314:	48 89 16             	mov    %rdx,(%rsi)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  100317:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10031b:	48 89 56 08          	mov    %rdx,0x8(%rsi)
	
		GET_SIZE(FTRP(leftover_mem_ptr)) = extra_size;
  10031f:	48 89 44 06 e0       	mov    %rax,-0x20(%rsi,%rax,1)

		// update the pointers in previous and next free block to the leftover, as long as they aren't null
		if (PREV_FPTR(bp))
  100324:	48 8b 47 08          	mov    0x8(%rdi),%rax
  100328:	48 85 c0             	test   %rax,%rax
  10032b:	74 03                	je     100330 <set_allocated+0x3e>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  10032d:	48 89 30             	mov    %rsi,(%rax)
		if (NEXT_FPTR(bp))
  100330:	48 8b 07             	mov    (%rdi),%rax
  100333:	48 85 c0             	test   %rax,%rax
  100336:	74 04                	je     10033c <set_allocated+0x4a>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  100338:	48 89 70 08          	mov    %rsi,0x8(%rax)
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
		if (NEXT_FPTR(bp))
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
	}
	
	GET_ALLOC(HDRP(bp)) = 1;
  10033c:	c7 47 f8 01 00 00 00 	movl   $0x1,-0x8(%rdi)
}
  100343:	c3                   	ret    
		if (PREV_FPTR(bp))
  100344:	48 8b 47 08          	mov    0x8(%rdi),%rax
  100348:	48 85 c0             	test   %rax,%rax
  10034b:	74 06                	je     100353 <set_allocated+0x61>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  10034d:	48 8b 17             	mov    (%rdi),%rdx
  100350:	48 89 10             	mov    %rdx,(%rax)
		if (NEXT_FPTR(bp))
  100353:	48 8b 07             	mov    (%rdi),%rax
  100356:	48 85 c0             	test   %rax,%rax
  100359:	74 e1                	je     10033c <set_allocated+0x4a>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  10035b:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10035f:	48 89 50 08          	mov    %rdx,0x8(%rax)
  100363:	eb d7                	jmp    10033c <set_allocated+0x4a>

0000000000100365 <malloc>:

void *malloc(uint64_t numbytes) {
  100365:	55                   	push   %rbp
  100366:	48 89 e5             	mov    %rsp,%rbp
  100369:	53                   	push   %rbx
  10036a:	48 83 ec 08          	sub    $0x8,%rsp
  10036e:	48 89 fb             	mov    %rdi,%rbx
	if (!initialized_heap)
  100371:	83 3d 98 20 00 00 00 	cmpl   $0x0,0x2098(%rip)        # 102410 <initialized_heap>
  100378:	74 49                	je     1003c3 <malloc+0x5e>
		heap_init();

	if (numbytes == 0)
  10037a:	48 85 db             	test   %rbx,%rbx
  10037d:	74 5c                	je     1003db <malloc+0x76>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  10037f:	48 8d 73 1f          	lea    0x1f(%rbx),%rsi
  100383:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  100387:	b8 30 00 00 00       	mov    $0x30,%eax
  10038c:	48 39 c6             	cmp    %rax,%rsi
  10038f:	48 0f 42 f0          	cmovb  %rax,%rsi
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);

	void *bp = free_list;
  100393:	48 8b 1d 66 20 00 00 	mov    0x2066(%rip),%rbx        # 102400 <free_list>
	while (bp) {
  10039a:	48 85 db             	test   %rbx,%rbx
  10039d:	74 0e                	je     1003ad <malloc+0x48>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  10039f:	48 39 73 f0          	cmp    %rsi,-0x10(%rbx)
  1003a3:	73 25                	jae    1003ca <malloc+0x65>
			set_allocated(bp, aligned_size);
			return bp;
		}

		bp = NEXT_FPTR(bp);
  1003a5:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  1003a8:	48 85 db             	test   %rbx,%rbx
  1003ab:	75 f2                	jne    10039f <malloc+0x3a>
    asm volatile ("int %1" :  "=a" (result)
  1003ad:	bf 00 00 00 00       	mov    $0x0,%edi
  1003b2:	cd 3a                	int    $0x3a
  1003b4:	48 89 05 5d 20 00 00 	mov    %rax,0x205d(%rip)        # 102418 <result.0>
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0) - OVERHEAD;
	extend(aligned_size);
  1003bb:	48 89 f7             	mov    %rsi,%rdi
  1003be:	e8 bd fe ff ff       	call   100280 <extend>
		heap_init();
  1003c3:	e8 29 fe ff ff       	call   1001f1 <heap_init>
  1003c8:	eb b0                	jmp    10037a <malloc+0x15>
			set_allocated(bp, aligned_size);
  1003ca:	48 89 df             	mov    %rbx,%rdi
  1003cd:	e8 20 ff ff ff       	call   1002f2 <set_allocated>
	set_allocated(bp, aligned_size);
    return bp;
}
  1003d2:	48 89 d8             	mov    %rbx,%rax
  1003d5:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1003d9:	c9                   	leave  
  1003da:	c3                   	ret    
		return NULL;
  1003db:	bb 00 00 00 00       	mov    $0x0,%ebx
  1003e0:	eb f0                	jmp    1003d2 <malloc+0x6d>

00000000001003e2 <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
    return 0;
}
  1003e2:	b8 00 00 00 00       	mov    $0x0,%eax
  1003e7:	c3                   	ret    

00000000001003e8 <realloc>:

void *realloc(void * ptr, uint64_t sz) {
    return 0;
}
  1003e8:	b8 00 00 00 00       	mov    $0x0,%eax
  1003ed:	c3                   	ret    

00000000001003ee <defrag>:

void defrag() {
}
  1003ee:	c3                   	ret    

00000000001003ef <heap_info>:

int heap_info(heap_info_struct * info) {
    return 0;
}
  1003ef:	b8 00 00 00 00       	mov    $0x0,%eax
  1003f4:	c3                   	ret    

00000000001003f5 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  1003f5:	55                   	push   %rbp
  1003f6:	48 89 e5             	mov    %rsp,%rbp
  1003f9:	48 83 ec 28          	sub    $0x28,%rsp
  1003fd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100401:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100405:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100409:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10040d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100411:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100415:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100419:	eb 1c                	jmp    100437 <memcpy+0x42>
        *d = *s;
  10041b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10041f:	0f b6 10             	movzbl (%rax),%edx
  100422:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100426:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100428:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10042d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100432:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100437:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10043c:	75 dd                	jne    10041b <memcpy+0x26>
    }
    return dst;
  10043e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100442:	c9                   	leave  
  100443:	c3                   	ret    

0000000000100444 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100444:	55                   	push   %rbp
  100445:	48 89 e5             	mov    %rsp,%rbp
  100448:	48 83 ec 28          	sub    $0x28,%rsp
  10044c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100450:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100454:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100458:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10045c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  100460:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100464:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100468:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10046c:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  100470:	73 6a                	jae    1004dc <memmove+0x98>
  100472:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100476:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10047a:	48 01 d0             	add    %rdx,%rax
  10047d:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100481:	73 59                	jae    1004dc <memmove+0x98>
        s += n, d += n;
  100483:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100487:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  10048b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10048f:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  100493:	eb 17                	jmp    1004ac <memmove+0x68>
            *--d = *--s;
  100495:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  10049a:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  10049f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004a3:	0f b6 10             	movzbl (%rax),%edx
  1004a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004aa:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1004ac:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1004b0:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1004b4:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1004b8:	48 85 c0             	test   %rax,%rax
  1004bb:	75 d8                	jne    100495 <memmove+0x51>
    if (s < d && s + n > d) {
  1004bd:	eb 2e                	jmp    1004ed <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1004bf:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1004c3:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1004c7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1004cb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004cf:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1004d3:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  1004d7:	0f b6 12             	movzbl (%rdx),%edx
  1004da:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1004dc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1004e0:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1004e4:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1004e8:	48 85 c0             	test   %rax,%rax
  1004eb:	75 d2                	jne    1004bf <memmove+0x7b>
        }
    }
    return dst;
  1004ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1004f1:	c9                   	leave  
  1004f2:	c3                   	ret    

00000000001004f3 <memset>:

void* memset(void* v, int c, size_t n) {
  1004f3:	55                   	push   %rbp
  1004f4:	48 89 e5             	mov    %rsp,%rbp
  1004f7:	48 83 ec 28          	sub    $0x28,%rsp
  1004fb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1004ff:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100502:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100506:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10050a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10050e:	eb 15                	jmp    100525 <memset+0x32>
        *p = c;
  100510:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100513:	89 c2                	mov    %eax,%edx
  100515:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100519:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10051b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100520:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100525:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10052a:	75 e4                	jne    100510 <memset+0x1d>
    }
    return v;
  10052c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100530:	c9                   	leave  
  100531:	c3                   	ret    

0000000000100532 <strlen>:

size_t strlen(const char* s) {
  100532:	55                   	push   %rbp
  100533:	48 89 e5             	mov    %rsp,%rbp
  100536:	48 83 ec 18          	sub    $0x18,%rsp
  10053a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  10053e:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100545:	00 
  100546:	eb 0a                	jmp    100552 <strlen+0x20>
        ++n;
  100548:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  10054d:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100552:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100556:	0f b6 00             	movzbl (%rax),%eax
  100559:	84 c0                	test   %al,%al
  10055b:	75 eb                	jne    100548 <strlen+0x16>
    }
    return n;
  10055d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100561:	c9                   	leave  
  100562:	c3                   	ret    

0000000000100563 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100563:	55                   	push   %rbp
  100564:	48 89 e5             	mov    %rsp,%rbp
  100567:	48 83 ec 20          	sub    $0x20,%rsp
  10056b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10056f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100573:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  10057a:	00 
  10057b:	eb 0a                	jmp    100587 <strnlen+0x24>
        ++n;
  10057d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100582:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100587:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10058b:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  10058f:	74 0b                	je     10059c <strnlen+0x39>
  100591:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100595:	0f b6 00             	movzbl (%rax),%eax
  100598:	84 c0                	test   %al,%al
  10059a:	75 e1                	jne    10057d <strnlen+0x1a>
    }
    return n;
  10059c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1005a0:	c9                   	leave  
  1005a1:	c3                   	ret    

00000000001005a2 <strcpy>:

char* strcpy(char* dst, const char* src) {
  1005a2:	55                   	push   %rbp
  1005a3:	48 89 e5             	mov    %rsp,%rbp
  1005a6:	48 83 ec 20          	sub    $0x20,%rsp
  1005aa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1005ae:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1005b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1005b6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1005ba:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1005be:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1005c2:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1005c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005ca:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1005ce:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  1005d2:	0f b6 12             	movzbl (%rdx),%edx
  1005d5:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  1005d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005db:	48 83 e8 01          	sub    $0x1,%rax
  1005df:	0f b6 00             	movzbl (%rax),%eax
  1005e2:	84 c0                	test   %al,%al
  1005e4:	75 d4                	jne    1005ba <strcpy+0x18>
    return dst;
  1005e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1005ea:	c9                   	leave  
  1005eb:	c3                   	ret    

00000000001005ec <strcmp>:

int strcmp(const char* a, const char* b) {
  1005ec:	55                   	push   %rbp
  1005ed:	48 89 e5             	mov    %rsp,%rbp
  1005f0:	48 83 ec 10          	sub    $0x10,%rsp
  1005f4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1005f8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1005fc:	eb 0a                	jmp    100608 <strcmp+0x1c>
        ++a, ++b;
  1005fe:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100603:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100608:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10060c:	0f b6 00             	movzbl (%rax),%eax
  10060f:	84 c0                	test   %al,%al
  100611:	74 1d                	je     100630 <strcmp+0x44>
  100613:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100617:	0f b6 00             	movzbl (%rax),%eax
  10061a:	84 c0                	test   %al,%al
  10061c:	74 12                	je     100630 <strcmp+0x44>
  10061e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100622:	0f b6 10             	movzbl (%rax),%edx
  100625:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100629:	0f b6 00             	movzbl (%rax),%eax
  10062c:	38 c2                	cmp    %al,%dl
  10062e:	74 ce                	je     1005fe <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100630:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100634:	0f b6 00             	movzbl (%rax),%eax
  100637:	89 c2                	mov    %eax,%edx
  100639:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10063d:	0f b6 00             	movzbl (%rax),%eax
  100640:	38 d0                	cmp    %dl,%al
  100642:	0f 92 c0             	setb   %al
  100645:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100648:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10064c:	0f b6 00             	movzbl (%rax),%eax
  10064f:	89 c1                	mov    %eax,%ecx
  100651:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100655:	0f b6 00             	movzbl (%rax),%eax
  100658:	38 c1                	cmp    %al,%cl
  10065a:	0f 92 c0             	setb   %al
  10065d:	0f b6 c0             	movzbl %al,%eax
  100660:	29 c2                	sub    %eax,%edx
  100662:	89 d0                	mov    %edx,%eax
}
  100664:	c9                   	leave  
  100665:	c3                   	ret    

0000000000100666 <strchr>:

char* strchr(const char* s, int c) {
  100666:	55                   	push   %rbp
  100667:	48 89 e5             	mov    %rsp,%rbp
  10066a:	48 83 ec 10          	sub    $0x10,%rsp
  10066e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100672:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100675:	eb 05                	jmp    10067c <strchr+0x16>
        ++s;
  100677:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  10067c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100680:	0f b6 00             	movzbl (%rax),%eax
  100683:	84 c0                	test   %al,%al
  100685:	74 0e                	je     100695 <strchr+0x2f>
  100687:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10068b:	0f b6 00             	movzbl (%rax),%eax
  10068e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100691:	38 d0                	cmp    %dl,%al
  100693:	75 e2                	jne    100677 <strchr+0x11>
    }
    if (*s == (char) c) {
  100695:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100699:	0f b6 00             	movzbl (%rax),%eax
  10069c:	8b 55 f4             	mov    -0xc(%rbp),%edx
  10069f:	38 d0                	cmp    %dl,%al
  1006a1:	75 06                	jne    1006a9 <strchr+0x43>
        return (char*) s;
  1006a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006a7:	eb 05                	jmp    1006ae <strchr+0x48>
    } else {
        return NULL;
  1006a9:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1006ae:	c9                   	leave  
  1006af:	c3                   	ret    

00000000001006b0 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1006b0:	55                   	push   %rbp
  1006b1:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1006b4:	8b 05 66 1d 00 00    	mov    0x1d66(%rip),%eax        # 102420 <rand_seed_set>
  1006ba:	85 c0                	test   %eax,%eax
  1006bc:	75 0a                	jne    1006c8 <rand+0x18>
        srand(819234718U);
  1006be:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1006c3:	e8 24 00 00 00       	call   1006ec <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1006c8:	8b 05 56 1d 00 00    	mov    0x1d56(%rip),%eax        # 102424 <rand_seed>
  1006ce:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  1006d4:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1006d9:	89 05 45 1d 00 00    	mov    %eax,0x1d45(%rip)        # 102424 <rand_seed>
    return rand_seed & RAND_MAX;
  1006df:	8b 05 3f 1d 00 00    	mov    0x1d3f(%rip),%eax        # 102424 <rand_seed>
  1006e5:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1006ea:	5d                   	pop    %rbp
  1006eb:	c3                   	ret    

00000000001006ec <srand>:

void srand(unsigned seed) {
  1006ec:	55                   	push   %rbp
  1006ed:	48 89 e5             	mov    %rsp,%rbp
  1006f0:	48 83 ec 08          	sub    $0x8,%rsp
  1006f4:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  1006f7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1006fa:	89 05 24 1d 00 00    	mov    %eax,0x1d24(%rip)        # 102424 <rand_seed>
    rand_seed_set = 1;
  100700:	c7 05 16 1d 00 00 01 	movl   $0x1,0x1d16(%rip)        # 102420 <rand_seed_set>
  100707:	00 00 00 
}
  10070a:	90                   	nop
  10070b:	c9                   	leave  
  10070c:	c3                   	ret    

000000000010070d <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  10070d:	55                   	push   %rbp
  10070e:	48 89 e5             	mov    %rsp,%rbp
  100711:	48 83 ec 28          	sub    $0x28,%rsp
  100715:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100719:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10071d:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100720:	48 c7 45 f8 a0 16 10 	movq   $0x1016a0,-0x8(%rbp)
  100727:	00 
    if (base < 0) {
  100728:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  10072c:	79 0b                	jns    100739 <fill_numbuf+0x2c>
        digits = lower_digits;
  10072e:	48 c7 45 f8 c0 16 10 	movq   $0x1016c0,-0x8(%rbp)
  100735:	00 
        base = -base;
  100736:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100739:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10073e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100742:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100745:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100748:	48 63 c8             	movslq %eax,%rcx
  10074b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10074f:	ba 00 00 00 00       	mov    $0x0,%edx
  100754:	48 f7 f1             	div    %rcx
  100757:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10075b:	48 01 d0             	add    %rdx,%rax
  10075e:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100763:	0f b6 10             	movzbl (%rax),%edx
  100766:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10076a:	88 10                	mov    %dl,(%rax)
        val /= base;
  10076c:	8b 45 dc             	mov    -0x24(%rbp),%eax
  10076f:	48 63 f0             	movslq %eax,%rsi
  100772:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100776:	ba 00 00 00 00       	mov    $0x0,%edx
  10077b:	48 f7 f6             	div    %rsi
  10077e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100782:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100787:	75 bc                	jne    100745 <fill_numbuf+0x38>
    return numbuf_end;
  100789:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10078d:	c9                   	leave  
  10078e:	c3                   	ret    

000000000010078f <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  10078f:	55                   	push   %rbp
  100790:	48 89 e5             	mov    %rsp,%rbp
  100793:	53                   	push   %rbx
  100794:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  10079b:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1007a2:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1007a8:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1007af:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1007b6:	e9 8a 09 00 00       	jmp    101145 <printer_vprintf+0x9b6>
        if (*format != '%') {
  1007bb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007c2:	0f b6 00             	movzbl (%rax),%eax
  1007c5:	3c 25                	cmp    $0x25,%al
  1007c7:	74 31                	je     1007fa <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  1007c9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1007d0:	4c 8b 00             	mov    (%rax),%r8
  1007d3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007da:	0f b6 00             	movzbl (%rax),%eax
  1007dd:	0f b6 c8             	movzbl %al,%ecx
  1007e0:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1007e6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1007ed:	89 ce                	mov    %ecx,%esi
  1007ef:	48 89 c7             	mov    %rax,%rdi
  1007f2:	41 ff d0             	call   *%r8
            continue;
  1007f5:	e9 43 09 00 00       	jmp    10113d <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  1007fa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100801:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100808:	01 
  100809:	eb 44                	jmp    10084f <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  10080b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100812:	0f b6 00             	movzbl (%rax),%eax
  100815:	0f be c0             	movsbl %al,%eax
  100818:	89 c6                	mov    %eax,%esi
  10081a:	bf c0 14 10 00       	mov    $0x1014c0,%edi
  10081f:	e8 42 fe ff ff       	call   100666 <strchr>
  100824:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100828:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  10082d:	74 30                	je     10085f <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  10082f:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100833:	48 2d c0 14 10 00    	sub    $0x1014c0,%rax
  100839:	ba 01 00 00 00       	mov    $0x1,%edx
  10083e:	89 c1                	mov    %eax,%ecx
  100840:	d3 e2                	shl    %cl,%edx
  100842:	89 d0                	mov    %edx,%eax
  100844:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100847:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10084e:	01 
  10084f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100856:	0f b6 00             	movzbl (%rax),%eax
  100859:	84 c0                	test   %al,%al
  10085b:	75 ae                	jne    10080b <printer_vprintf+0x7c>
  10085d:	eb 01                	jmp    100860 <printer_vprintf+0xd1>
            } else {
                break;
  10085f:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100860:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100867:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10086e:	0f b6 00             	movzbl (%rax),%eax
  100871:	3c 30                	cmp    $0x30,%al
  100873:	7e 67                	jle    1008dc <printer_vprintf+0x14d>
  100875:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10087c:	0f b6 00             	movzbl (%rax),%eax
  10087f:	3c 39                	cmp    $0x39,%al
  100881:	7f 59                	jg     1008dc <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100883:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  10088a:	eb 2e                	jmp    1008ba <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  10088c:	8b 55 e8             	mov    -0x18(%rbp),%edx
  10088f:	89 d0                	mov    %edx,%eax
  100891:	c1 e0 02             	shl    $0x2,%eax
  100894:	01 d0                	add    %edx,%eax
  100896:	01 c0                	add    %eax,%eax
  100898:	89 c1                	mov    %eax,%ecx
  10089a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008a1:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1008a5:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1008ac:	0f b6 00             	movzbl (%rax),%eax
  1008af:	0f be c0             	movsbl %al,%eax
  1008b2:	01 c8                	add    %ecx,%eax
  1008b4:	83 e8 30             	sub    $0x30,%eax
  1008b7:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1008ba:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008c1:	0f b6 00             	movzbl (%rax),%eax
  1008c4:	3c 2f                	cmp    $0x2f,%al
  1008c6:	0f 8e 85 00 00 00    	jle    100951 <printer_vprintf+0x1c2>
  1008cc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008d3:	0f b6 00             	movzbl (%rax),%eax
  1008d6:	3c 39                	cmp    $0x39,%al
  1008d8:	7e b2                	jle    10088c <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  1008da:	eb 75                	jmp    100951 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  1008dc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008e3:	0f b6 00             	movzbl (%rax),%eax
  1008e6:	3c 2a                	cmp    $0x2a,%al
  1008e8:	75 68                	jne    100952 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  1008ea:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008f1:	8b 00                	mov    (%rax),%eax
  1008f3:	83 f8 2f             	cmp    $0x2f,%eax
  1008f6:	77 30                	ja     100928 <printer_vprintf+0x199>
  1008f8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008ff:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100903:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10090a:	8b 00                	mov    (%rax),%eax
  10090c:	89 c0                	mov    %eax,%eax
  10090e:	48 01 d0             	add    %rdx,%rax
  100911:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100918:	8b 12                	mov    (%rdx),%edx
  10091a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10091d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100924:	89 0a                	mov    %ecx,(%rdx)
  100926:	eb 1a                	jmp    100942 <printer_vprintf+0x1b3>
  100928:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10092f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100933:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100937:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10093e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100942:	8b 00                	mov    (%rax),%eax
  100944:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100947:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10094e:	01 
  10094f:	eb 01                	jmp    100952 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100951:	90                   	nop
        }

        // process precision
        int precision = -1;
  100952:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100959:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100960:	0f b6 00             	movzbl (%rax),%eax
  100963:	3c 2e                	cmp    $0x2e,%al
  100965:	0f 85 00 01 00 00    	jne    100a6b <printer_vprintf+0x2dc>
            ++format;
  10096b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100972:	01 
            if (*format >= '0' && *format <= '9') {
  100973:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10097a:	0f b6 00             	movzbl (%rax),%eax
  10097d:	3c 2f                	cmp    $0x2f,%al
  10097f:	7e 67                	jle    1009e8 <printer_vprintf+0x259>
  100981:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100988:	0f b6 00             	movzbl (%rax),%eax
  10098b:	3c 39                	cmp    $0x39,%al
  10098d:	7f 59                	jg     1009e8 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10098f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100996:	eb 2e                	jmp    1009c6 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100998:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  10099b:	89 d0                	mov    %edx,%eax
  10099d:	c1 e0 02             	shl    $0x2,%eax
  1009a0:	01 d0                	add    %edx,%eax
  1009a2:	01 c0                	add    %eax,%eax
  1009a4:	89 c1                	mov    %eax,%ecx
  1009a6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009ad:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1009b1:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1009b8:	0f b6 00             	movzbl (%rax),%eax
  1009bb:	0f be c0             	movsbl %al,%eax
  1009be:	01 c8                	add    %ecx,%eax
  1009c0:	83 e8 30             	sub    $0x30,%eax
  1009c3:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1009c6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009cd:	0f b6 00             	movzbl (%rax),%eax
  1009d0:	3c 2f                	cmp    $0x2f,%al
  1009d2:	0f 8e 85 00 00 00    	jle    100a5d <printer_vprintf+0x2ce>
  1009d8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009df:	0f b6 00             	movzbl (%rax),%eax
  1009e2:	3c 39                	cmp    $0x39,%al
  1009e4:	7e b2                	jle    100998 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  1009e6:	eb 75                	jmp    100a5d <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  1009e8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009ef:	0f b6 00             	movzbl (%rax),%eax
  1009f2:	3c 2a                	cmp    $0x2a,%al
  1009f4:	75 68                	jne    100a5e <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  1009f6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009fd:	8b 00                	mov    (%rax),%eax
  1009ff:	83 f8 2f             	cmp    $0x2f,%eax
  100a02:	77 30                	ja     100a34 <printer_vprintf+0x2a5>
  100a04:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a0b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a0f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a16:	8b 00                	mov    (%rax),%eax
  100a18:	89 c0                	mov    %eax,%eax
  100a1a:	48 01 d0             	add    %rdx,%rax
  100a1d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a24:	8b 12                	mov    (%rdx),%edx
  100a26:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a29:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a30:	89 0a                	mov    %ecx,(%rdx)
  100a32:	eb 1a                	jmp    100a4e <printer_vprintf+0x2bf>
  100a34:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a3b:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a3f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a43:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a4a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a4e:	8b 00                	mov    (%rax),%eax
  100a50:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100a53:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100a5a:	01 
  100a5b:	eb 01                	jmp    100a5e <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100a5d:	90                   	nop
            }
            if (precision < 0) {
  100a5e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100a62:	79 07                	jns    100a6b <printer_vprintf+0x2dc>
                precision = 0;
  100a64:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100a6b:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100a72:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100a79:	00 
        int length = 0;
  100a7a:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100a81:	48 c7 45 c8 c6 14 10 	movq   $0x1014c6,-0x38(%rbp)
  100a88:	00 
    again:
        switch (*format) {
  100a89:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a90:	0f b6 00             	movzbl (%rax),%eax
  100a93:	0f be c0             	movsbl %al,%eax
  100a96:	83 e8 43             	sub    $0x43,%eax
  100a99:	83 f8 37             	cmp    $0x37,%eax
  100a9c:	0f 87 9f 03 00 00    	ja     100e41 <printer_vprintf+0x6b2>
  100aa2:	89 c0                	mov    %eax,%eax
  100aa4:	48 8b 04 c5 d8 14 10 	mov    0x1014d8(,%rax,8),%rax
  100aab:	00 
  100aac:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100aae:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100ab5:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100abc:	01 
            goto again;
  100abd:	eb ca                	jmp    100a89 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100abf:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100ac3:	74 5d                	je     100b22 <printer_vprintf+0x393>
  100ac5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100acc:	8b 00                	mov    (%rax),%eax
  100ace:	83 f8 2f             	cmp    $0x2f,%eax
  100ad1:	77 30                	ja     100b03 <printer_vprintf+0x374>
  100ad3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ada:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ade:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ae5:	8b 00                	mov    (%rax),%eax
  100ae7:	89 c0                	mov    %eax,%eax
  100ae9:	48 01 d0             	add    %rdx,%rax
  100aec:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100af3:	8b 12                	mov    (%rdx),%edx
  100af5:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100af8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aff:	89 0a                	mov    %ecx,(%rdx)
  100b01:	eb 1a                	jmp    100b1d <printer_vprintf+0x38e>
  100b03:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b0a:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b0e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b12:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b19:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b1d:	48 8b 00             	mov    (%rax),%rax
  100b20:	eb 5c                	jmp    100b7e <printer_vprintf+0x3ef>
  100b22:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b29:	8b 00                	mov    (%rax),%eax
  100b2b:	83 f8 2f             	cmp    $0x2f,%eax
  100b2e:	77 30                	ja     100b60 <printer_vprintf+0x3d1>
  100b30:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b37:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b3b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b42:	8b 00                	mov    (%rax),%eax
  100b44:	89 c0                	mov    %eax,%eax
  100b46:	48 01 d0             	add    %rdx,%rax
  100b49:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b50:	8b 12                	mov    (%rdx),%edx
  100b52:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b55:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b5c:	89 0a                	mov    %ecx,(%rdx)
  100b5e:	eb 1a                	jmp    100b7a <printer_vprintf+0x3eb>
  100b60:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b67:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b6b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b6f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b76:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b7a:	8b 00                	mov    (%rax),%eax
  100b7c:	48 98                	cltq   
  100b7e:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100b82:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100b86:	48 c1 f8 38          	sar    $0x38,%rax
  100b8a:	25 80 00 00 00       	and    $0x80,%eax
  100b8f:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100b92:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100b96:	74 09                	je     100ba1 <printer_vprintf+0x412>
  100b98:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100b9c:	48 f7 d8             	neg    %rax
  100b9f:	eb 04                	jmp    100ba5 <printer_vprintf+0x416>
  100ba1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100ba5:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100ba9:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100bac:	83 c8 60             	or     $0x60,%eax
  100baf:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100bb2:	e9 cf 02 00 00       	jmp    100e86 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100bb7:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100bbb:	74 5d                	je     100c1a <printer_vprintf+0x48b>
  100bbd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bc4:	8b 00                	mov    (%rax),%eax
  100bc6:	83 f8 2f             	cmp    $0x2f,%eax
  100bc9:	77 30                	ja     100bfb <printer_vprintf+0x46c>
  100bcb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bd2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100bd6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bdd:	8b 00                	mov    (%rax),%eax
  100bdf:	89 c0                	mov    %eax,%eax
  100be1:	48 01 d0             	add    %rdx,%rax
  100be4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100beb:	8b 12                	mov    (%rdx),%edx
  100bed:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bf0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bf7:	89 0a                	mov    %ecx,(%rdx)
  100bf9:	eb 1a                	jmp    100c15 <printer_vprintf+0x486>
  100bfb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c02:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c06:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c0a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c11:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c15:	48 8b 00             	mov    (%rax),%rax
  100c18:	eb 5c                	jmp    100c76 <printer_vprintf+0x4e7>
  100c1a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c21:	8b 00                	mov    (%rax),%eax
  100c23:	83 f8 2f             	cmp    $0x2f,%eax
  100c26:	77 30                	ja     100c58 <printer_vprintf+0x4c9>
  100c28:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c2f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c33:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c3a:	8b 00                	mov    (%rax),%eax
  100c3c:	89 c0                	mov    %eax,%eax
  100c3e:	48 01 d0             	add    %rdx,%rax
  100c41:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c48:	8b 12                	mov    (%rdx),%edx
  100c4a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c4d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c54:	89 0a                	mov    %ecx,(%rdx)
  100c56:	eb 1a                	jmp    100c72 <printer_vprintf+0x4e3>
  100c58:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c5f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c63:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c67:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c6e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c72:	8b 00                	mov    (%rax),%eax
  100c74:	89 c0                	mov    %eax,%eax
  100c76:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100c7a:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100c7e:	e9 03 02 00 00       	jmp    100e86 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100c83:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100c8a:	e9 28 ff ff ff       	jmp    100bb7 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100c8f:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100c96:	e9 1c ff ff ff       	jmp    100bb7 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100c9b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ca2:	8b 00                	mov    (%rax),%eax
  100ca4:	83 f8 2f             	cmp    $0x2f,%eax
  100ca7:	77 30                	ja     100cd9 <printer_vprintf+0x54a>
  100ca9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cb0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100cb4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cbb:	8b 00                	mov    (%rax),%eax
  100cbd:	89 c0                	mov    %eax,%eax
  100cbf:	48 01 d0             	add    %rdx,%rax
  100cc2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cc9:	8b 12                	mov    (%rdx),%edx
  100ccb:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100cce:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cd5:	89 0a                	mov    %ecx,(%rdx)
  100cd7:	eb 1a                	jmp    100cf3 <printer_vprintf+0x564>
  100cd9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ce0:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ce4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ce8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cef:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100cf3:	48 8b 00             	mov    (%rax),%rax
  100cf6:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100cfa:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100d01:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100d08:	e9 79 01 00 00       	jmp    100e86 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100d0d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d14:	8b 00                	mov    (%rax),%eax
  100d16:	83 f8 2f             	cmp    $0x2f,%eax
  100d19:	77 30                	ja     100d4b <printer_vprintf+0x5bc>
  100d1b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d22:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d26:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d2d:	8b 00                	mov    (%rax),%eax
  100d2f:	89 c0                	mov    %eax,%eax
  100d31:	48 01 d0             	add    %rdx,%rax
  100d34:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d3b:	8b 12                	mov    (%rdx),%edx
  100d3d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d40:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d47:	89 0a                	mov    %ecx,(%rdx)
  100d49:	eb 1a                	jmp    100d65 <printer_vprintf+0x5d6>
  100d4b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d52:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d56:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d5a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d61:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d65:	48 8b 00             	mov    (%rax),%rax
  100d68:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100d6c:	e9 15 01 00 00       	jmp    100e86 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100d71:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d78:	8b 00                	mov    (%rax),%eax
  100d7a:	83 f8 2f             	cmp    $0x2f,%eax
  100d7d:	77 30                	ja     100daf <printer_vprintf+0x620>
  100d7f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d86:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d8a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d91:	8b 00                	mov    (%rax),%eax
  100d93:	89 c0                	mov    %eax,%eax
  100d95:	48 01 d0             	add    %rdx,%rax
  100d98:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d9f:	8b 12                	mov    (%rdx),%edx
  100da1:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100da4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dab:	89 0a                	mov    %ecx,(%rdx)
  100dad:	eb 1a                	jmp    100dc9 <printer_vprintf+0x63a>
  100daf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100db6:	48 8b 40 08          	mov    0x8(%rax),%rax
  100dba:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100dbe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dc5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100dc9:	8b 00                	mov    (%rax),%eax
  100dcb:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100dd1:	e9 67 03 00 00       	jmp    10113d <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  100dd6:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100dda:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100dde:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100de5:	8b 00                	mov    (%rax),%eax
  100de7:	83 f8 2f             	cmp    $0x2f,%eax
  100dea:	77 30                	ja     100e1c <printer_vprintf+0x68d>
  100dec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100df3:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100df7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dfe:	8b 00                	mov    (%rax),%eax
  100e00:	89 c0                	mov    %eax,%eax
  100e02:	48 01 d0             	add    %rdx,%rax
  100e05:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e0c:	8b 12                	mov    (%rdx),%edx
  100e0e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e11:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e18:	89 0a                	mov    %ecx,(%rdx)
  100e1a:	eb 1a                	jmp    100e36 <printer_vprintf+0x6a7>
  100e1c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e23:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e27:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e2b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e32:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e36:	8b 00                	mov    (%rax),%eax
  100e38:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100e3b:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100e3f:	eb 45                	jmp    100e86 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  100e41:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100e45:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100e49:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e50:	0f b6 00             	movzbl (%rax),%eax
  100e53:	84 c0                	test   %al,%al
  100e55:	74 0c                	je     100e63 <printer_vprintf+0x6d4>
  100e57:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e5e:	0f b6 00             	movzbl (%rax),%eax
  100e61:	eb 05                	jmp    100e68 <printer_vprintf+0x6d9>
  100e63:	b8 25 00 00 00       	mov    $0x25,%eax
  100e68:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100e6b:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100e6f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e76:	0f b6 00             	movzbl (%rax),%eax
  100e79:	84 c0                	test   %al,%al
  100e7b:	75 08                	jne    100e85 <printer_vprintf+0x6f6>
                format--;
  100e7d:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100e84:	01 
            }
            break;
  100e85:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100e86:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e89:	83 e0 20             	and    $0x20,%eax
  100e8c:	85 c0                	test   %eax,%eax
  100e8e:	74 1e                	je     100eae <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100e90:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100e94:	48 83 c0 18          	add    $0x18,%rax
  100e98:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100e9b:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100e9f:	48 89 ce             	mov    %rcx,%rsi
  100ea2:	48 89 c7             	mov    %rax,%rdi
  100ea5:	e8 63 f8 ff ff       	call   10070d <fill_numbuf>
  100eaa:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100eae:	48 c7 45 c0 c6 14 10 	movq   $0x1014c6,-0x40(%rbp)
  100eb5:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100eb6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100eb9:	83 e0 20             	and    $0x20,%eax
  100ebc:	85 c0                	test   %eax,%eax
  100ebe:	74 48                	je     100f08 <printer_vprintf+0x779>
  100ec0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ec3:	83 e0 40             	and    $0x40,%eax
  100ec6:	85 c0                	test   %eax,%eax
  100ec8:	74 3e                	je     100f08 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  100eca:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ecd:	25 80 00 00 00       	and    $0x80,%eax
  100ed2:	85 c0                	test   %eax,%eax
  100ed4:	74 0a                	je     100ee0 <printer_vprintf+0x751>
                prefix = "-";
  100ed6:	48 c7 45 c0 c7 14 10 	movq   $0x1014c7,-0x40(%rbp)
  100edd:	00 
            if (flags & FLAG_NEGATIVE) {
  100ede:	eb 73                	jmp    100f53 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100ee0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ee3:	83 e0 10             	and    $0x10,%eax
  100ee6:	85 c0                	test   %eax,%eax
  100ee8:	74 0a                	je     100ef4 <printer_vprintf+0x765>
                prefix = "+";
  100eea:	48 c7 45 c0 c9 14 10 	movq   $0x1014c9,-0x40(%rbp)
  100ef1:	00 
            if (flags & FLAG_NEGATIVE) {
  100ef2:	eb 5f                	jmp    100f53 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100ef4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ef7:	83 e0 08             	and    $0x8,%eax
  100efa:	85 c0                	test   %eax,%eax
  100efc:	74 55                	je     100f53 <printer_vprintf+0x7c4>
                prefix = " ";
  100efe:	48 c7 45 c0 cb 14 10 	movq   $0x1014cb,-0x40(%rbp)
  100f05:	00 
            if (flags & FLAG_NEGATIVE) {
  100f06:	eb 4b                	jmp    100f53 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100f08:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f0b:	83 e0 20             	and    $0x20,%eax
  100f0e:	85 c0                	test   %eax,%eax
  100f10:	74 42                	je     100f54 <printer_vprintf+0x7c5>
  100f12:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f15:	83 e0 01             	and    $0x1,%eax
  100f18:	85 c0                	test   %eax,%eax
  100f1a:	74 38                	je     100f54 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  100f1c:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100f20:	74 06                	je     100f28 <printer_vprintf+0x799>
  100f22:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100f26:	75 2c                	jne    100f54 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  100f28:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100f2d:	75 0c                	jne    100f3b <printer_vprintf+0x7ac>
  100f2f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f32:	25 00 01 00 00       	and    $0x100,%eax
  100f37:	85 c0                	test   %eax,%eax
  100f39:	74 19                	je     100f54 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  100f3b:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100f3f:	75 07                	jne    100f48 <printer_vprintf+0x7b9>
  100f41:	b8 cd 14 10 00       	mov    $0x1014cd,%eax
  100f46:	eb 05                	jmp    100f4d <printer_vprintf+0x7be>
  100f48:	b8 d0 14 10 00       	mov    $0x1014d0,%eax
  100f4d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100f51:	eb 01                	jmp    100f54 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  100f53:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100f54:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100f58:	78 24                	js     100f7e <printer_vprintf+0x7ef>
  100f5a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f5d:	83 e0 20             	and    $0x20,%eax
  100f60:	85 c0                	test   %eax,%eax
  100f62:	75 1a                	jne    100f7e <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  100f64:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100f67:	48 63 d0             	movslq %eax,%rdx
  100f6a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100f6e:	48 89 d6             	mov    %rdx,%rsi
  100f71:	48 89 c7             	mov    %rax,%rdi
  100f74:	e8 ea f5 ff ff       	call   100563 <strnlen>
  100f79:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100f7c:	eb 0f                	jmp    100f8d <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  100f7e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100f82:	48 89 c7             	mov    %rax,%rdi
  100f85:	e8 a8 f5 ff ff       	call   100532 <strlen>
  100f8a:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100f8d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f90:	83 e0 20             	and    $0x20,%eax
  100f93:	85 c0                	test   %eax,%eax
  100f95:	74 20                	je     100fb7 <printer_vprintf+0x828>
  100f97:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100f9b:	78 1a                	js     100fb7 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  100f9d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100fa0:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100fa3:	7e 08                	jle    100fad <printer_vprintf+0x81e>
  100fa5:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100fa8:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100fab:	eb 05                	jmp    100fb2 <printer_vprintf+0x823>
  100fad:	b8 00 00 00 00       	mov    $0x0,%eax
  100fb2:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100fb5:	eb 5c                	jmp    101013 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100fb7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fba:	83 e0 20             	and    $0x20,%eax
  100fbd:	85 c0                	test   %eax,%eax
  100fbf:	74 4b                	je     10100c <printer_vprintf+0x87d>
  100fc1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fc4:	83 e0 02             	and    $0x2,%eax
  100fc7:	85 c0                	test   %eax,%eax
  100fc9:	74 41                	je     10100c <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100fcb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fce:	83 e0 04             	and    $0x4,%eax
  100fd1:	85 c0                	test   %eax,%eax
  100fd3:	75 37                	jne    10100c <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  100fd5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100fd9:	48 89 c7             	mov    %rax,%rdi
  100fdc:	e8 51 f5 ff ff       	call   100532 <strlen>
  100fe1:	89 c2                	mov    %eax,%edx
  100fe3:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100fe6:	01 d0                	add    %edx,%eax
  100fe8:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100feb:	7e 1f                	jle    10100c <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  100fed:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100ff0:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100ff3:	89 c3                	mov    %eax,%ebx
  100ff5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100ff9:	48 89 c7             	mov    %rax,%rdi
  100ffc:	e8 31 f5 ff ff       	call   100532 <strlen>
  101001:	89 c2                	mov    %eax,%edx
  101003:	89 d8                	mov    %ebx,%eax
  101005:	29 d0                	sub    %edx,%eax
  101007:	89 45 b8             	mov    %eax,-0x48(%rbp)
  10100a:	eb 07                	jmp    101013 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  10100c:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  101013:	8b 55 bc             	mov    -0x44(%rbp),%edx
  101016:	8b 45 b8             	mov    -0x48(%rbp),%eax
  101019:	01 d0                	add    %edx,%eax
  10101b:	48 63 d8             	movslq %eax,%rbx
  10101e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101022:	48 89 c7             	mov    %rax,%rdi
  101025:	e8 08 f5 ff ff       	call   100532 <strlen>
  10102a:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  10102e:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101031:	29 d0                	sub    %edx,%eax
  101033:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101036:	eb 25                	jmp    10105d <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  101038:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10103f:	48 8b 08             	mov    (%rax),%rcx
  101042:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101048:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10104f:	be 20 00 00 00       	mov    $0x20,%esi
  101054:	48 89 c7             	mov    %rax,%rdi
  101057:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101059:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  10105d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101060:	83 e0 04             	and    $0x4,%eax
  101063:	85 c0                	test   %eax,%eax
  101065:	75 36                	jne    10109d <printer_vprintf+0x90e>
  101067:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  10106b:	7f cb                	jg     101038 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  10106d:	eb 2e                	jmp    10109d <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  10106f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101076:	4c 8b 00             	mov    (%rax),%r8
  101079:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10107d:	0f b6 00             	movzbl (%rax),%eax
  101080:	0f b6 c8             	movzbl %al,%ecx
  101083:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101089:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101090:	89 ce                	mov    %ecx,%esi
  101092:	48 89 c7             	mov    %rax,%rdi
  101095:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  101098:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  10109d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1010a1:	0f b6 00             	movzbl (%rax),%eax
  1010a4:	84 c0                	test   %al,%al
  1010a6:	75 c7                	jne    10106f <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  1010a8:	eb 25                	jmp    1010cf <printer_vprintf+0x940>
            p->putc(p, '0', color);
  1010aa:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010b1:	48 8b 08             	mov    (%rax),%rcx
  1010b4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1010ba:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010c1:	be 30 00 00 00       	mov    $0x30,%esi
  1010c6:	48 89 c7             	mov    %rax,%rdi
  1010c9:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  1010cb:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  1010cf:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  1010d3:	7f d5                	jg     1010aa <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  1010d5:	eb 32                	jmp    101109 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  1010d7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010de:	4c 8b 00             	mov    (%rax),%r8
  1010e1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1010e5:	0f b6 00             	movzbl (%rax),%eax
  1010e8:	0f b6 c8             	movzbl %al,%ecx
  1010eb:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1010f1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010f8:	89 ce                	mov    %ecx,%esi
  1010fa:	48 89 c7             	mov    %rax,%rdi
  1010fd:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  101100:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  101105:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  101109:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  10110d:	7f c8                	jg     1010d7 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  10110f:	eb 25                	jmp    101136 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  101111:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101118:	48 8b 08             	mov    (%rax),%rcx
  10111b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101121:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101128:	be 20 00 00 00       	mov    $0x20,%esi
  10112d:	48 89 c7             	mov    %rax,%rdi
  101130:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  101132:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101136:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  10113a:	7f d5                	jg     101111 <printer_vprintf+0x982>
        }
    done: ;
  10113c:	90                   	nop
    for (; *format; ++format) {
  10113d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101144:	01 
  101145:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10114c:	0f b6 00             	movzbl (%rax),%eax
  10114f:	84 c0                	test   %al,%al
  101151:	0f 85 64 f6 ff ff    	jne    1007bb <printer_vprintf+0x2c>
    }
}
  101157:	90                   	nop
  101158:	90                   	nop
  101159:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  10115d:	c9                   	leave  
  10115e:	c3                   	ret    

000000000010115f <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  10115f:	55                   	push   %rbp
  101160:	48 89 e5             	mov    %rsp,%rbp
  101163:	48 83 ec 20          	sub    $0x20,%rsp
  101167:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10116b:	89 f0                	mov    %esi,%eax
  10116d:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101170:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  101173:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101177:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10117b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10117f:	48 8b 40 08          	mov    0x8(%rax),%rax
  101183:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  101188:	48 39 d0             	cmp    %rdx,%rax
  10118b:	72 0c                	jb     101199 <console_putc+0x3a>
        cp->cursor = console;
  10118d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101191:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  101198:	00 
    }
    if (c == '\n') {
  101199:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  10119d:	75 78                	jne    101217 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  10119f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011a3:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011a7:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1011ad:	48 d1 f8             	sar    %rax
  1011b0:	48 89 c1             	mov    %rax,%rcx
  1011b3:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1011ba:	66 66 66 
  1011bd:	48 89 c8             	mov    %rcx,%rax
  1011c0:	48 f7 ea             	imul   %rdx
  1011c3:	48 c1 fa 05          	sar    $0x5,%rdx
  1011c7:	48 89 c8             	mov    %rcx,%rax
  1011ca:	48 c1 f8 3f          	sar    $0x3f,%rax
  1011ce:	48 29 c2             	sub    %rax,%rdx
  1011d1:	48 89 d0             	mov    %rdx,%rax
  1011d4:	48 c1 e0 02          	shl    $0x2,%rax
  1011d8:	48 01 d0             	add    %rdx,%rax
  1011db:	48 c1 e0 04          	shl    $0x4,%rax
  1011df:	48 29 c1             	sub    %rax,%rcx
  1011e2:	48 89 ca             	mov    %rcx,%rdx
  1011e5:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  1011e8:	eb 25                	jmp    10120f <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  1011ea:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1011ed:	83 c8 20             	or     $0x20,%eax
  1011f0:	89 c6                	mov    %eax,%esi
  1011f2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011f6:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011fa:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1011fe:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101202:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101206:	89 f2                	mov    %esi,%edx
  101208:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  10120b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10120f:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101213:	75 d5                	jne    1011ea <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101215:	eb 24                	jmp    10123b <console_putc+0xdc>
        *cp->cursor++ = c | color;
  101217:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  10121b:	8b 55 e0             	mov    -0x20(%rbp),%edx
  10121e:	09 d0                	or     %edx,%eax
  101220:	89 c6                	mov    %eax,%esi
  101222:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101226:	48 8b 40 08          	mov    0x8(%rax),%rax
  10122a:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10122e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101232:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101236:	89 f2                	mov    %esi,%edx
  101238:	66 89 10             	mov    %dx,(%rax)
}
  10123b:	90                   	nop
  10123c:	c9                   	leave  
  10123d:	c3                   	ret    

000000000010123e <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  10123e:	55                   	push   %rbp
  10123f:	48 89 e5             	mov    %rsp,%rbp
  101242:	48 83 ec 30          	sub    $0x30,%rsp
  101246:	89 7d ec             	mov    %edi,-0x14(%rbp)
  101249:	89 75 e8             	mov    %esi,-0x18(%rbp)
  10124c:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101250:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  101254:	48 c7 45 f0 5f 11 10 	movq   $0x10115f,-0x10(%rbp)
  10125b:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10125c:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  101260:	78 09                	js     10126b <console_vprintf+0x2d>
  101262:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101269:	7e 07                	jle    101272 <console_vprintf+0x34>
        cpos = 0;
  10126b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  101272:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101275:	48 98                	cltq   
  101277:	48 01 c0             	add    %rax,%rax
  10127a:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  101280:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101284:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101288:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  10128c:	8b 75 e8             	mov    -0x18(%rbp),%esi
  10128f:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101293:	48 89 c7             	mov    %rax,%rdi
  101296:	e8 f4 f4 ff ff       	call   10078f <printer_vprintf>
    return cp.cursor - console;
  10129b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10129f:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1012a5:	48 d1 f8             	sar    %rax
}
  1012a8:	c9                   	leave  
  1012a9:	c3                   	ret    

00000000001012aa <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  1012aa:	55                   	push   %rbp
  1012ab:	48 89 e5             	mov    %rsp,%rbp
  1012ae:	48 83 ec 60          	sub    $0x60,%rsp
  1012b2:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1012b5:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1012b8:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1012bc:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1012c0:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1012c4:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1012c8:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1012cf:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1012d3:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1012d7:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1012db:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1012df:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1012e3:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  1012e7:	8b 75 a8             	mov    -0x58(%rbp),%esi
  1012ea:	8b 45 ac             	mov    -0x54(%rbp),%eax
  1012ed:	89 c7                	mov    %eax,%edi
  1012ef:	e8 4a ff ff ff       	call   10123e <console_vprintf>
  1012f4:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  1012f7:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  1012fa:	c9                   	leave  
  1012fb:	c3                   	ret    

00000000001012fc <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  1012fc:	55                   	push   %rbp
  1012fd:	48 89 e5             	mov    %rsp,%rbp
  101300:	48 83 ec 20          	sub    $0x20,%rsp
  101304:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101308:	89 f0                	mov    %esi,%eax
  10130a:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10130d:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101310:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101314:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101318:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10131c:	48 8b 50 08          	mov    0x8(%rax),%rdx
  101320:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101324:	48 8b 40 10          	mov    0x10(%rax),%rax
  101328:	48 39 c2             	cmp    %rax,%rdx
  10132b:	73 1a                	jae    101347 <string_putc+0x4b>
        *sp->s++ = c;
  10132d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101331:	48 8b 40 08          	mov    0x8(%rax),%rax
  101335:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101339:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10133d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101341:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101345:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101347:	90                   	nop
  101348:	c9                   	leave  
  101349:	c3                   	ret    

000000000010134a <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  10134a:	55                   	push   %rbp
  10134b:	48 89 e5             	mov    %rsp,%rbp
  10134e:	48 83 ec 40          	sub    $0x40,%rsp
  101352:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101356:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  10135a:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  10135e:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101362:	48 c7 45 e8 fc 12 10 	movq   $0x1012fc,-0x18(%rbp)
  101369:	00 
    sp.s = s;
  10136a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10136e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  101372:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  101377:	74 33                	je     1013ac <vsnprintf+0x62>
        sp.end = s + size - 1;
  101379:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  10137d:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101381:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101385:	48 01 d0             	add    %rdx,%rax
  101388:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  10138c:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101390:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101394:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101398:	be 00 00 00 00       	mov    $0x0,%esi
  10139d:	48 89 c7             	mov    %rax,%rdi
  1013a0:	e8 ea f3 ff ff       	call   10078f <printer_vprintf>
        *sp.s = 0;
  1013a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013a9:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1013ac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013b0:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1013b4:	c9                   	leave  
  1013b5:	c3                   	ret    

00000000001013b6 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1013b6:	55                   	push   %rbp
  1013b7:	48 89 e5             	mov    %rsp,%rbp
  1013ba:	48 83 ec 70          	sub    $0x70,%rsp
  1013be:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1013c2:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1013c6:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1013ca:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1013ce:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1013d2:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1013d6:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  1013dd:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1013e1:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  1013e5:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1013e9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  1013ed:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  1013f1:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  1013f5:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  1013f9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1013fd:	48 89 c7             	mov    %rax,%rdi
  101400:	e8 45 ff ff ff       	call   10134a <vsnprintf>
  101405:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101408:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  10140b:	c9                   	leave  
  10140c:	c3                   	ret    

000000000010140d <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  10140d:	55                   	push   %rbp
  10140e:	48 89 e5             	mov    %rsp,%rbp
  101411:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101415:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  10141c:	eb 13                	jmp    101431 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  10141e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  101421:	48 98                	cltq   
  101423:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  10142a:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10142d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101431:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101438:	7e e4                	jle    10141e <console_clear+0x11>
    }
    cursorpos = 0;
  10143a:	c7 05 b8 7b fb ff 00 	movl   $0x0,-0x48448(%rip)        # b8ffc <cursorpos>
  101441:	00 00 00 
}
  101444:	90                   	nop
  101445:	c9                   	leave  
  101446:	c3                   	ret    
