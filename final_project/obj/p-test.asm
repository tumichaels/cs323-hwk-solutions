
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
  100008:	e8 eb 05 00 00       	call   1005f8 <srand>
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

    void *ptr = malloc(10);
  10003a:	bf 0a 00 00 00       	mov    $0xa,%edi
  10003f:	e8 5f 02 00 00       	call   1002a3 <malloc>
    if (*((size_t *)(0x103010)) == 32)
  100044:	48 83 3c 25 10 30 10 	cmpq   $0x20,0x103010
  10004b:	00 20 
  10004d:	74 0f                	je     10005e <process_main+0x5e>
	    panic("success!");

    TEST_PASS();
  10004f:	bf 69 13 10 00       	mov    $0x101369,%edi
  100054:	b8 00 00 00 00       	mov    $0x0,%eax
  100059:	e8 99 00 00 00       	call   1000f7 <kernel_panic>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  10005e:	bf 60 13 10 00       	mov    $0x101360,%edi
  100063:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  100065:	eb fe                	jmp    100065 <process_main+0x65>

0000000000100067 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100067:	55                   	push   %rbp
  100068:	48 89 e5             	mov    %rsp,%rbp
  10006b:	48 83 ec 50          	sub    $0x50,%rsp
  10006f:	49 89 f2             	mov    %rsi,%r10
  100072:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100076:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10007a:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10007e:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  100082:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100087:	85 ff                	test   %edi,%edi
  100089:	78 2e                	js     1000b9 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  10008b:	48 63 ff             	movslq %edi,%rdi
  10008e:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  100095:	cc cc cc 
  100098:	48 89 f8             	mov    %rdi,%rax
  10009b:	48 f7 e2             	mul    %rdx
  10009e:	48 89 d0             	mov    %rdx,%rax
  1000a1:	48 c1 e8 02          	shr    $0x2,%rax
  1000a5:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  1000a9:	48 01 c2             	add    %rax,%rdx
  1000ac:	48 29 d7             	sub    %rdx,%rdi
  1000af:	0f b6 b7 bd 13 10 00 	movzbl 0x1013bd(%rdi),%esi
  1000b6:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  1000b9:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  1000c0:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1000c4:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1000c8:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1000cc:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  1000d0:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1000d4:	4c 89 d2             	mov    %r10,%rdx
  1000d7:	8b 3d 1f 8f fb ff    	mov    -0x470e1(%rip),%edi        # b8ffc <cursorpos>
  1000dd:	e8 68 10 00 00       	call   10114a <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  1000e2:	3d 30 07 00 00       	cmp    $0x730,%eax
  1000e7:	ba 00 00 00 00       	mov    $0x0,%edx
  1000ec:	0f 4d c2             	cmovge %edx,%eax
  1000ef:	89 05 07 8f fb ff    	mov    %eax,-0x470f9(%rip)        # b8ffc <cursorpos>
    }
}
  1000f5:	c9                   	leave  
  1000f6:	c3                   	ret    

00000000001000f7 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  1000f7:	55                   	push   %rbp
  1000f8:	48 89 e5             	mov    %rsp,%rbp
  1000fb:	53                   	push   %rbx
  1000fc:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100103:	48 89 fb             	mov    %rdi,%rbx
  100106:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  10010a:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  10010e:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100112:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100116:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  10011a:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  100121:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100125:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100129:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  10012d:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  100131:	ba 07 00 00 00       	mov    $0x7,%edx
  100136:	be 84 13 10 00       	mov    $0x101384,%esi
  10013b:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100142:	e8 ba 01 00 00       	call   100301 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100147:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  10014b:	48 89 da             	mov    %rbx,%rdx
  10014e:	be 99 00 00 00       	mov    $0x99,%esi
  100153:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  10015a:	e8 f7 10 00 00       	call   101256 <vsnprintf>
  10015f:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100162:	85 d2                	test   %edx,%edx
  100164:	7e 0f                	jle    100175 <kernel_panic+0x7e>
  100166:	83 c0 06             	add    $0x6,%eax
  100169:	48 98                	cltq   
  10016b:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  100172:	0a 
  100173:	75 2a                	jne    10019f <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  100175:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  10017c:	48 89 d9             	mov    %rbx,%rcx
  10017f:	ba 8e 13 10 00       	mov    $0x10138e,%edx
  100184:	be 00 c0 00 00       	mov    $0xc000,%esi
  100189:	bf 30 07 00 00       	mov    $0x730,%edi
  10018e:	b8 00 00 00 00       	mov    $0x0,%eax
  100193:	e8 1e 10 00 00       	call   1011b6 <console_printf>
    asm volatile ("int %0" : /* no result */
  100198:	48 89 df             	mov    %rbx,%rdi
  10019b:	cd 30                	int    $0x30
 loop: goto loop;
  10019d:	eb fe                	jmp    10019d <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  10019f:	48 63 c2             	movslq %edx,%rax
  1001a2:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  1001a8:	0f 94 c2             	sete   %dl
  1001ab:	0f b6 d2             	movzbl %dl,%edx
  1001ae:	48 29 d0             	sub    %rdx,%rax
  1001b1:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  1001b8:	ff 
  1001b9:	be 8c 13 10 00       	mov    $0x10138c,%esi
  1001be:	e8 eb 02 00 00       	call   1004ae <strcpy>
  1001c3:	eb b0                	jmp    100175 <kernel_panic+0x7e>

00000000001001c5 <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  1001c5:	55                   	push   %rbp
  1001c6:	48 89 e5             	mov    %rsp,%rbp
  1001c9:	48 89 f9             	mov    %rdi,%rcx
  1001cc:	41 89 f0             	mov    %esi,%r8d
  1001cf:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  1001d2:	ba 98 13 10 00       	mov    $0x101398,%edx
  1001d7:	be 00 c0 00 00       	mov    $0xc000,%esi
  1001dc:	bf 30 07 00 00       	mov    $0x730,%edi
  1001e1:	b8 00 00 00 00       	mov    $0x0,%eax
  1001e6:	e8 cb 0f 00 00       	call   1011b6 <console_printf>
    asm volatile ("int %0" : /* no result */
  1001eb:	bf 00 00 00 00       	mov    $0x0,%edi
  1001f0:	cd 30                	int    $0x30
 loop: goto loop;
  1001f2:	eb fe                	jmp    1001f2 <assert_fail+0x2d>

00000000001001f4 <heap_init>:
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  1001f4:	bf 10 00 00 00       	mov    $0x10,%edi
  1001f9:	cd 3a                	int    $0x3a
  1001fb:	48 89 05 16 22 00 00 	mov    %rax,0x2216(%rip)        # 102418 <result.0>
  100202:	cd 3a                	int    $0x3a
  100204:	48 89 05 0d 22 00 00 	mov    %rax,0x220d(%rip)        # 102418 <result.0>
// want to try and optimize this 
void heap_init(void) {

	// prologue block
	sbrk(sizeof(block_header));
	first_block_payload = sbrk(sizeof(block_footer));
  10020b:	48 89 05 f6 21 00 00 	mov    %rax,0x21f6(%rip)        # 102408 <first_block_payload>

	GET_SIZE(HDRP(first_block_payload)) = sizeof(block_header) + sizeof(block_footer);
  100212:	48 c7 40 f0 20 00 00 	movq   $0x20,-0x10(%rax)
  100219:	00 
	GET_ALLOC(HDRP(first_block_payload)) = 1;
  10021a:	48 8b 05 e7 21 00 00 	mov    0x21e7(%rip),%rax        # 102408 <first_block_payload>
  100221:	c7 40 f8 01 00 00 00 	movl   $0x1,-0x8(%rax)
	GET_SIZE(FTRP(first_block_payload)) = sizeof(block_header) + sizeof(block_footer);
  100228:	48 8b 05 d9 21 00 00 	mov    0x21d9(%rip),%rax        # 102408 <first_block_payload>
  10022f:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  100233:	48 c7 44 10 e0 20 00 	movq   $0x20,-0x20(%rax,%rdx,1)
  10023a:	00 00 
  10023c:	cd 3a                	int    $0x3a
  10023e:	48 89 05 d3 21 00 00 	mov    %rax,0x21d3(%rip)        # 102418 <result.0>

	// terminal block
	sbrk(sizeof(block_header));
	GET_SIZE(HDRP(NEXT_BLKP(first_block_payload))) = 0;
  100245:	48 8b 05 bc 21 00 00 	mov    0x21bc(%rip),%rax        # 102408 <first_block_payload>
  10024c:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  100250:	48 c7 44 10 f0 00 00 	movq   $0x0,-0x10(%rax,%rdx,1)
  100257:	00 00 
	GET_ALLOC(HDRP(NEXT_BLKP(first_block_payload))) = 1;
  100259:	48 8b 05 a8 21 00 00 	mov    0x21a8(%rip),%rax        # 102408 <first_block_payload>
  100260:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  100264:	c7 44 10 f8 01 00 00 	movl   $0x1,-0x8(%rax,%rdx,1)
  10026b:	00 

	initialized_heap = 1;
  10026c:	c7 05 9a 21 00 00 01 	movl   $0x1,0x219a(%rip)        # 102410 <initialized_heap>
  100273:	00 00 00 
}
  100276:	c3                   	ret    

0000000000100277 <free>:

void free(void *firstbyte) {
	return;
}
  100277:	c3                   	ret    

0000000000100278 <extend>:

// extend is called when you don't have a free block big enough
//	we call extend inside malloc, so it should only ever be
//	called with new_size >= MIN_PAYLOAD_SIZE 
void extend(size_t new_size) {
}
  100278:	c3                   	ret    

0000000000100279 <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  100279:	48 8b 47 f0          	mov    -0x10(%rdi),%rax
  10027d:	48 29 f0             	sub    %rsi,%rax

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  100280:	48 83 f8 30          	cmp    $0x30,%rax
  100284:	76 15                	jbe    10029b <set_allocated+0x22>
		GET_SIZE(HDRP(bp)) = size;
  100286:	48 89 77 f0          	mov    %rsi,-0x10(%rdi)
		GET_SIZE(HDRP(NEXT_BLKP(bp))) = extra_size;
  10028a:	48 89 44 37 f0       	mov    %rax,-0x10(%rdi,%rsi,1)
		GET_ALLOC(HDRP(NEXT_BLKP(bp))) = 0;
  10028f:	48 8b 47 f0          	mov    -0x10(%rdi),%rax
  100293:	c7 44 07 f8 00 00 00 	movl   $0x0,-0x8(%rdi,%rax,1)
  10029a:	00 
		// NEXT_FPTR(NEXT_BLKP(bp)) = NEXT_FPTR(bp);
		// PREV_FPTR(NEXT_BLKP(bp)) = PREV_FPTR(bp);
		// GET_SIZE(FTRP(NEXT_BLKP(bp))) = extra_size;
	}

	GET_ALLOC(HDRP(bp)) = 1;
  10029b:	c7 47 f8 01 00 00 00 	movl   $0x1,-0x8(%rdi)
}
  1002a2:	c3                   	ret    

00000000001002a3 <malloc>:

void *malloc(uint64_t numbytes) {
  1002a3:	55                   	push   %rbp
  1002a4:	48 89 e5             	mov    %rsp,%rbp
  1002a7:	53                   	push   %rbx
  1002a8:	48 83 ec 08          	sub    $0x8,%rsp
  1002ac:	48 89 fb             	mov    %rdi,%rbx
	if (!initialized_heap)
  1002af:	83 3d 5a 21 00 00 00 	cmpl   $0x0,0x215a(%rip)        # 102410 <initialized_heap>
  1002b6:	74 28                	je     1002e0 <malloc+0x3d>
		heap_init();

	if (numbytes == 0)
  1002b8:	48 85 db             	test   %rbx,%rbx
  1002bb:	74 2a                	je     1002e7 <malloc+0x44>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  1002bd:	48 8d 7b 1f          	lea    0x1f(%rbx),%rdi
  1002c1:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
  1002c5:	b8 30 00 00 00       	mov    $0x30,%eax
  1002ca:	48 39 c7             	cmp    %rax,%rdi
  1002cd:	48 0f 42 f8          	cmovb  %rax,%rdi
  1002d1:	cd 3a                	int    $0x3a
  1002d3:	48 89 05 3e 21 00 00 	mov    %rax,0x213e(%rip)        # 102418 <result.0>
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);

	void *bp = sbrk(aligned_size);
    return bp;
}
  1002da:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1002de:	c9                   	leave  
  1002df:	c3                   	ret    
		heap_init();
  1002e0:	e8 0f ff ff ff       	call   1001f4 <heap_init>
  1002e5:	eb d1                	jmp    1002b8 <malloc+0x15>
		return NULL;
  1002e7:	b8 00 00 00 00       	mov    $0x0,%eax
  1002ec:	eb ec                	jmp    1002da <malloc+0x37>

00000000001002ee <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
    return 0;
}
  1002ee:	b8 00 00 00 00       	mov    $0x0,%eax
  1002f3:	c3                   	ret    

00000000001002f4 <realloc>:

void *realloc(void * ptr, uint64_t sz) {
    return 0;
}
  1002f4:	b8 00 00 00 00       	mov    $0x0,%eax
  1002f9:	c3                   	ret    

00000000001002fa <defrag>:

void defrag() {
}
  1002fa:	c3                   	ret    

00000000001002fb <heap_info>:

int heap_info(heap_info_struct * info) {
    return 0;
}
  1002fb:	b8 00 00 00 00       	mov    $0x0,%eax
  100300:	c3                   	ret    

0000000000100301 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100301:	55                   	push   %rbp
  100302:	48 89 e5             	mov    %rsp,%rbp
  100305:	48 83 ec 28          	sub    $0x28,%rsp
  100309:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10030d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100311:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100315:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100319:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  10031d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100321:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100325:	eb 1c                	jmp    100343 <memcpy+0x42>
        *d = *s;
  100327:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10032b:	0f b6 10             	movzbl (%rax),%edx
  10032e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100332:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100334:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100339:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10033e:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100343:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100348:	75 dd                	jne    100327 <memcpy+0x26>
    }
    return dst;
  10034a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10034e:	c9                   	leave  
  10034f:	c3                   	ret    

0000000000100350 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100350:	55                   	push   %rbp
  100351:	48 89 e5             	mov    %rsp,%rbp
  100354:	48 83 ec 28          	sub    $0x28,%rsp
  100358:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10035c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100360:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100364:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100368:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  10036c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100370:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100374:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100378:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  10037c:	73 6a                	jae    1003e8 <memmove+0x98>
  10037e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100382:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100386:	48 01 d0             	add    %rdx,%rax
  100389:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  10038d:	73 59                	jae    1003e8 <memmove+0x98>
        s += n, d += n;
  10038f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100393:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100397:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10039b:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  10039f:	eb 17                	jmp    1003b8 <memmove+0x68>
            *--d = *--s;
  1003a1:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1003a6:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1003ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003af:	0f b6 10             	movzbl (%rax),%edx
  1003b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003b6:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1003b8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1003bc:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1003c0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1003c4:	48 85 c0             	test   %rax,%rax
  1003c7:	75 d8                	jne    1003a1 <memmove+0x51>
    if (s < d && s + n > d) {
  1003c9:	eb 2e                	jmp    1003f9 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1003cb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1003cf:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1003d3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1003d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003db:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1003df:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  1003e3:	0f b6 12             	movzbl (%rdx),%edx
  1003e6:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1003e8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1003ec:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1003f0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1003f4:	48 85 c0             	test   %rax,%rax
  1003f7:	75 d2                	jne    1003cb <memmove+0x7b>
        }
    }
    return dst;
  1003f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1003fd:	c9                   	leave  
  1003fe:	c3                   	ret    

00000000001003ff <memset>:

void* memset(void* v, int c, size_t n) {
  1003ff:	55                   	push   %rbp
  100400:	48 89 e5             	mov    %rsp,%rbp
  100403:	48 83 ec 28          	sub    $0x28,%rsp
  100407:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10040b:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  10040e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100412:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100416:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10041a:	eb 15                	jmp    100431 <memset+0x32>
        *p = c;
  10041c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10041f:	89 c2                	mov    %eax,%edx
  100421:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100425:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100427:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10042c:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100431:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100436:	75 e4                	jne    10041c <memset+0x1d>
    }
    return v;
  100438:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10043c:	c9                   	leave  
  10043d:	c3                   	ret    

000000000010043e <strlen>:

size_t strlen(const char* s) {
  10043e:	55                   	push   %rbp
  10043f:	48 89 e5             	mov    %rsp,%rbp
  100442:	48 83 ec 18          	sub    $0x18,%rsp
  100446:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  10044a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100451:	00 
  100452:	eb 0a                	jmp    10045e <strlen+0x20>
        ++n;
  100454:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100459:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  10045e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100462:	0f b6 00             	movzbl (%rax),%eax
  100465:	84 c0                	test   %al,%al
  100467:	75 eb                	jne    100454 <strlen+0x16>
    }
    return n;
  100469:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  10046d:	c9                   	leave  
  10046e:	c3                   	ret    

000000000010046f <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  10046f:	55                   	push   %rbp
  100470:	48 89 e5             	mov    %rsp,%rbp
  100473:	48 83 ec 20          	sub    $0x20,%rsp
  100477:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10047b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  10047f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100486:	00 
  100487:	eb 0a                	jmp    100493 <strnlen+0x24>
        ++n;
  100489:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  10048e:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100493:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100497:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  10049b:	74 0b                	je     1004a8 <strnlen+0x39>
  10049d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1004a1:	0f b6 00             	movzbl (%rax),%eax
  1004a4:	84 c0                	test   %al,%al
  1004a6:	75 e1                	jne    100489 <strnlen+0x1a>
    }
    return n;
  1004a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1004ac:	c9                   	leave  
  1004ad:	c3                   	ret    

00000000001004ae <strcpy>:

char* strcpy(char* dst, const char* src) {
  1004ae:	55                   	push   %rbp
  1004af:	48 89 e5             	mov    %rsp,%rbp
  1004b2:	48 83 ec 20          	sub    $0x20,%rsp
  1004b6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1004ba:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1004be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1004c2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1004c6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1004ca:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1004ce:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1004d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004d6:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1004da:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  1004de:	0f b6 12             	movzbl (%rdx),%edx
  1004e1:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  1004e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004e7:	48 83 e8 01          	sub    $0x1,%rax
  1004eb:	0f b6 00             	movzbl (%rax),%eax
  1004ee:	84 c0                	test   %al,%al
  1004f0:	75 d4                	jne    1004c6 <strcpy+0x18>
    return dst;
  1004f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1004f6:	c9                   	leave  
  1004f7:	c3                   	ret    

00000000001004f8 <strcmp>:

int strcmp(const char* a, const char* b) {
  1004f8:	55                   	push   %rbp
  1004f9:	48 89 e5             	mov    %rsp,%rbp
  1004fc:	48 83 ec 10          	sub    $0x10,%rsp
  100500:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100504:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100508:	eb 0a                	jmp    100514 <strcmp+0x1c>
        ++a, ++b;
  10050a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10050f:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100514:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100518:	0f b6 00             	movzbl (%rax),%eax
  10051b:	84 c0                	test   %al,%al
  10051d:	74 1d                	je     10053c <strcmp+0x44>
  10051f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100523:	0f b6 00             	movzbl (%rax),%eax
  100526:	84 c0                	test   %al,%al
  100528:	74 12                	je     10053c <strcmp+0x44>
  10052a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10052e:	0f b6 10             	movzbl (%rax),%edx
  100531:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100535:	0f b6 00             	movzbl (%rax),%eax
  100538:	38 c2                	cmp    %al,%dl
  10053a:	74 ce                	je     10050a <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  10053c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100540:	0f b6 00             	movzbl (%rax),%eax
  100543:	89 c2                	mov    %eax,%edx
  100545:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100549:	0f b6 00             	movzbl (%rax),%eax
  10054c:	38 d0                	cmp    %dl,%al
  10054e:	0f 92 c0             	setb   %al
  100551:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100554:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100558:	0f b6 00             	movzbl (%rax),%eax
  10055b:	89 c1                	mov    %eax,%ecx
  10055d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100561:	0f b6 00             	movzbl (%rax),%eax
  100564:	38 c1                	cmp    %al,%cl
  100566:	0f 92 c0             	setb   %al
  100569:	0f b6 c0             	movzbl %al,%eax
  10056c:	29 c2                	sub    %eax,%edx
  10056e:	89 d0                	mov    %edx,%eax
}
  100570:	c9                   	leave  
  100571:	c3                   	ret    

0000000000100572 <strchr>:

char* strchr(const char* s, int c) {
  100572:	55                   	push   %rbp
  100573:	48 89 e5             	mov    %rsp,%rbp
  100576:	48 83 ec 10          	sub    $0x10,%rsp
  10057a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  10057e:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100581:	eb 05                	jmp    100588 <strchr+0x16>
        ++s;
  100583:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100588:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10058c:	0f b6 00             	movzbl (%rax),%eax
  10058f:	84 c0                	test   %al,%al
  100591:	74 0e                	je     1005a1 <strchr+0x2f>
  100593:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100597:	0f b6 00             	movzbl (%rax),%eax
  10059a:	8b 55 f4             	mov    -0xc(%rbp),%edx
  10059d:	38 d0                	cmp    %dl,%al
  10059f:	75 e2                	jne    100583 <strchr+0x11>
    }
    if (*s == (char) c) {
  1005a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005a5:	0f b6 00             	movzbl (%rax),%eax
  1005a8:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1005ab:	38 d0                	cmp    %dl,%al
  1005ad:	75 06                	jne    1005b5 <strchr+0x43>
        return (char*) s;
  1005af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005b3:	eb 05                	jmp    1005ba <strchr+0x48>
    } else {
        return NULL;
  1005b5:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1005ba:	c9                   	leave  
  1005bb:	c3                   	ret    

00000000001005bc <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1005bc:	55                   	push   %rbp
  1005bd:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1005c0:	8b 05 5a 1e 00 00    	mov    0x1e5a(%rip),%eax        # 102420 <rand_seed_set>
  1005c6:	85 c0                	test   %eax,%eax
  1005c8:	75 0a                	jne    1005d4 <rand+0x18>
        srand(819234718U);
  1005ca:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1005cf:	e8 24 00 00 00       	call   1005f8 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1005d4:	8b 05 4a 1e 00 00    	mov    0x1e4a(%rip),%eax        # 102424 <rand_seed>
  1005da:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  1005e0:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1005e5:	89 05 39 1e 00 00    	mov    %eax,0x1e39(%rip)        # 102424 <rand_seed>
    return rand_seed & RAND_MAX;
  1005eb:	8b 05 33 1e 00 00    	mov    0x1e33(%rip),%eax        # 102424 <rand_seed>
  1005f1:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1005f6:	5d                   	pop    %rbp
  1005f7:	c3                   	ret    

00000000001005f8 <srand>:

void srand(unsigned seed) {
  1005f8:	55                   	push   %rbp
  1005f9:	48 89 e5             	mov    %rsp,%rbp
  1005fc:	48 83 ec 08          	sub    $0x8,%rsp
  100600:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100603:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100606:	89 05 18 1e 00 00    	mov    %eax,0x1e18(%rip)        # 102424 <rand_seed>
    rand_seed_set = 1;
  10060c:	c7 05 0a 1e 00 00 01 	movl   $0x1,0x1e0a(%rip)        # 102420 <rand_seed_set>
  100613:	00 00 00 
}
  100616:	90                   	nop
  100617:	c9                   	leave  
  100618:	c3                   	ret    

0000000000100619 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100619:	55                   	push   %rbp
  10061a:	48 89 e5             	mov    %rsp,%rbp
  10061d:	48 83 ec 28          	sub    $0x28,%rsp
  100621:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100625:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100629:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  10062c:	48 c7 45 f8 b0 15 10 	movq   $0x1015b0,-0x8(%rbp)
  100633:	00 
    if (base < 0) {
  100634:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100638:	79 0b                	jns    100645 <fill_numbuf+0x2c>
        digits = lower_digits;
  10063a:	48 c7 45 f8 d0 15 10 	movq   $0x1015d0,-0x8(%rbp)
  100641:	00 
        base = -base;
  100642:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100645:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10064a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10064e:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100651:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100654:	48 63 c8             	movslq %eax,%rcx
  100657:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10065b:	ba 00 00 00 00       	mov    $0x0,%edx
  100660:	48 f7 f1             	div    %rcx
  100663:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100667:	48 01 d0             	add    %rdx,%rax
  10066a:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10066f:	0f b6 10             	movzbl (%rax),%edx
  100672:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100676:	88 10                	mov    %dl,(%rax)
        val /= base;
  100678:	8b 45 dc             	mov    -0x24(%rbp),%eax
  10067b:	48 63 f0             	movslq %eax,%rsi
  10067e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100682:	ba 00 00 00 00       	mov    $0x0,%edx
  100687:	48 f7 f6             	div    %rsi
  10068a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  10068e:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100693:	75 bc                	jne    100651 <fill_numbuf+0x38>
    return numbuf_end;
  100695:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100699:	c9                   	leave  
  10069a:	c3                   	ret    

000000000010069b <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  10069b:	55                   	push   %rbp
  10069c:	48 89 e5             	mov    %rsp,%rbp
  10069f:	53                   	push   %rbx
  1006a0:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  1006a7:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1006ae:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1006b4:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1006bb:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1006c2:	e9 8a 09 00 00       	jmp    101051 <printer_vprintf+0x9b6>
        if (*format != '%') {
  1006c7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006ce:	0f b6 00             	movzbl (%rax),%eax
  1006d1:	3c 25                	cmp    $0x25,%al
  1006d3:	74 31                	je     100706 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  1006d5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1006dc:	4c 8b 00             	mov    (%rax),%r8
  1006df:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006e6:	0f b6 00             	movzbl (%rax),%eax
  1006e9:	0f b6 c8             	movzbl %al,%ecx
  1006ec:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1006f2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1006f9:	89 ce                	mov    %ecx,%esi
  1006fb:	48 89 c7             	mov    %rax,%rdi
  1006fe:	41 ff d0             	call   *%r8
            continue;
  100701:	e9 43 09 00 00       	jmp    101049 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100706:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  10070d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100714:	01 
  100715:	eb 44                	jmp    10075b <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  100717:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10071e:	0f b6 00             	movzbl (%rax),%eax
  100721:	0f be c0             	movsbl %al,%eax
  100724:	89 c6                	mov    %eax,%esi
  100726:	bf d0 13 10 00       	mov    $0x1013d0,%edi
  10072b:	e8 42 fe ff ff       	call   100572 <strchr>
  100730:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100734:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100739:	74 30                	je     10076b <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  10073b:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  10073f:	48 2d d0 13 10 00    	sub    $0x1013d0,%rax
  100745:	ba 01 00 00 00       	mov    $0x1,%edx
  10074a:	89 c1                	mov    %eax,%ecx
  10074c:	d3 e2                	shl    %cl,%edx
  10074e:	89 d0                	mov    %edx,%eax
  100750:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100753:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10075a:	01 
  10075b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100762:	0f b6 00             	movzbl (%rax),%eax
  100765:	84 c0                	test   %al,%al
  100767:	75 ae                	jne    100717 <printer_vprintf+0x7c>
  100769:	eb 01                	jmp    10076c <printer_vprintf+0xd1>
            } else {
                break;
  10076b:	90                   	nop
            }
        }

        // process width
        int width = -1;
  10076c:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100773:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10077a:	0f b6 00             	movzbl (%rax),%eax
  10077d:	3c 30                	cmp    $0x30,%al
  10077f:	7e 67                	jle    1007e8 <printer_vprintf+0x14d>
  100781:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100788:	0f b6 00             	movzbl (%rax),%eax
  10078b:	3c 39                	cmp    $0x39,%al
  10078d:	7f 59                	jg     1007e8 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10078f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100796:	eb 2e                	jmp    1007c6 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100798:	8b 55 e8             	mov    -0x18(%rbp),%edx
  10079b:	89 d0                	mov    %edx,%eax
  10079d:	c1 e0 02             	shl    $0x2,%eax
  1007a0:	01 d0                	add    %edx,%eax
  1007a2:	01 c0                	add    %eax,%eax
  1007a4:	89 c1                	mov    %eax,%ecx
  1007a6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007ad:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1007b1:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1007b8:	0f b6 00             	movzbl (%rax),%eax
  1007bb:	0f be c0             	movsbl %al,%eax
  1007be:	01 c8                	add    %ecx,%eax
  1007c0:	83 e8 30             	sub    $0x30,%eax
  1007c3:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1007c6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007cd:	0f b6 00             	movzbl (%rax),%eax
  1007d0:	3c 2f                	cmp    $0x2f,%al
  1007d2:	0f 8e 85 00 00 00    	jle    10085d <printer_vprintf+0x1c2>
  1007d8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007df:	0f b6 00             	movzbl (%rax),%eax
  1007e2:	3c 39                	cmp    $0x39,%al
  1007e4:	7e b2                	jle    100798 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  1007e6:	eb 75                	jmp    10085d <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  1007e8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007ef:	0f b6 00             	movzbl (%rax),%eax
  1007f2:	3c 2a                	cmp    $0x2a,%al
  1007f4:	75 68                	jne    10085e <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  1007f6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007fd:	8b 00                	mov    (%rax),%eax
  1007ff:	83 f8 2f             	cmp    $0x2f,%eax
  100802:	77 30                	ja     100834 <printer_vprintf+0x199>
  100804:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10080b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10080f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100816:	8b 00                	mov    (%rax),%eax
  100818:	89 c0                	mov    %eax,%eax
  10081a:	48 01 d0             	add    %rdx,%rax
  10081d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100824:	8b 12                	mov    (%rdx),%edx
  100826:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100829:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100830:	89 0a                	mov    %ecx,(%rdx)
  100832:	eb 1a                	jmp    10084e <printer_vprintf+0x1b3>
  100834:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10083b:	48 8b 40 08          	mov    0x8(%rax),%rax
  10083f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100843:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10084a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10084e:	8b 00                	mov    (%rax),%eax
  100850:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100853:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10085a:	01 
  10085b:	eb 01                	jmp    10085e <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  10085d:	90                   	nop
        }

        // process precision
        int precision = -1;
  10085e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100865:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10086c:	0f b6 00             	movzbl (%rax),%eax
  10086f:	3c 2e                	cmp    $0x2e,%al
  100871:	0f 85 00 01 00 00    	jne    100977 <printer_vprintf+0x2dc>
            ++format;
  100877:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10087e:	01 
            if (*format >= '0' && *format <= '9') {
  10087f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100886:	0f b6 00             	movzbl (%rax),%eax
  100889:	3c 2f                	cmp    $0x2f,%al
  10088b:	7e 67                	jle    1008f4 <printer_vprintf+0x259>
  10088d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100894:	0f b6 00             	movzbl (%rax),%eax
  100897:	3c 39                	cmp    $0x39,%al
  100899:	7f 59                	jg     1008f4 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10089b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  1008a2:	eb 2e                	jmp    1008d2 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  1008a4:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  1008a7:	89 d0                	mov    %edx,%eax
  1008a9:	c1 e0 02             	shl    $0x2,%eax
  1008ac:	01 d0                	add    %edx,%eax
  1008ae:	01 c0                	add    %eax,%eax
  1008b0:	89 c1                	mov    %eax,%ecx
  1008b2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008b9:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1008bd:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1008c4:	0f b6 00             	movzbl (%rax),%eax
  1008c7:	0f be c0             	movsbl %al,%eax
  1008ca:	01 c8                	add    %ecx,%eax
  1008cc:	83 e8 30             	sub    $0x30,%eax
  1008cf:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1008d2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008d9:	0f b6 00             	movzbl (%rax),%eax
  1008dc:	3c 2f                	cmp    $0x2f,%al
  1008de:	0f 8e 85 00 00 00    	jle    100969 <printer_vprintf+0x2ce>
  1008e4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008eb:	0f b6 00             	movzbl (%rax),%eax
  1008ee:	3c 39                	cmp    $0x39,%al
  1008f0:	7e b2                	jle    1008a4 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  1008f2:	eb 75                	jmp    100969 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  1008f4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008fb:	0f b6 00             	movzbl (%rax),%eax
  1008fe:	3c 2a                	cmp    $0x2a,%al
  100900:	75 68                	jne    10096a <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100902:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100909:	8b 00                	mov    (%rax),%eax
  10090b:	83 f8 2f             	cmp    $0x2f,%eax
  10090e:	77 30                	ja     100940 <printer_vprintf+0x2a5>
  100910:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100917:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10091b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100922:	8b 00                	mov    (%rax),%eax
  100924:	89 c0                	mov    %eax,%eax
  100926:	48 01 d0             	add    %rdx,%rax
  100929:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100930:	8b 12                	mov    (%rdx),%edx
  100932:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100935:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10093c:	89 0a                	mov    %ecx,(%rdx)
  10093e:	eb 1a                	jmp    10095a <printer_vprintf+0x2bf>
  100940:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100947:	48 8b 40 08          	mov    0x8(%rax),%rax
  10094b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10094f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100956:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10095a:	8b 00                	mov    (%rax),%eax
  10095c:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  10095f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100966:	01 
  100967:	eb 01                	jmp    10096a <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100969:	90                   	nop
            }
            if (precision < 0) {
  10096a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  10096e:	79 07                	jns    100977 <printer_vprintf+0x2dc>
                precision = 0;
  100970:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100977:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  10097e:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100985:	00 
        int length = 0;
  100986:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  10098d:	48 c7 45 c8 d6 13 10 	movq   $0x1013d6,-0x38(%rbp)
  100994:	00 
    again:
        switch (*format) {
  100995:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10099c:	0f b6 00             	movzbl (%rax),%eax
  10099f:	0f be c0             	movsbl %al,%eax
  1009a2:	83 e8 43             	sub    $0x43,%eax
  1009a5:	83 f8 37             	cmp    $0x37,%eax
  1009a8:	0f 87 9f 03 00 00    	ja     100d4d <printer_vprintf+0x6b2>
  1009ae:	89 c0                	mov    %eax,%eax
  1009b0:	48 8b 04 c5 e8 13 10 	mov    0x1013e8(,%rax,8),%rax
  1009b7:	00 
  1009b8:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  1009ba:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  1009c1:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1009c8:	01 
            goto again;
  1009c9:	eb ca                	jmp    100995 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1009cb:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1009cf:	74 5d                	je     100a2e <printer_vprintf+0x393>
  1009d1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009d8:	8b 00                	mov    (%rax),%eax
  1009da:	83 f8 2f             	cmp    $0x2f,%eax
  1009dd:	77 30                	ja     100a0f <printer_vprintf+0x374>
  1009df:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009e6:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1009ea:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009f1:	8b 00                	mov    (%rax),%eax
  1009f3:	89 c0                	mov    %eax,%eax
  1009f5:	48 01 d0             	add    %rdx,%rax
  1009f8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009ff:	8b 12                	mov    (%rdx),%edx
  100a01:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a04:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a0b:	89 0a                	mov    %ecx,(%rdx)
  100a0d:	eb 1a                	jmp    100a29 <printer_vprintf+0x38e>
  100a0f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a16:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a1a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a1e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a25:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a29:	48 8b 00             	mov    (%rax),%rax
  100a2c:	eb 5c                	jmp    100a8a <printer_vprintf+0x3ef>
  100a2e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a35:	8b 00                	mov    (%rax),%eax
  100a37:	83 f8 2f             	cmp    $0x2f,%eax
  100a3a:	77 30                	ja     100a6c <printer_vprintf+0x3d1>
  100a3c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a43:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a47:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a4e:	8b 00                	mov    (%rax),%eax
  100a50:	89 c0                	mov    %eax,%eax
  100a52:	48 01 d0             	add    %rdx,%rax
  100a55:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a5c:	8b 12                	mov    (%rdx),%edx
  100a5e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a61:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a68:	89 0a                	mov    %ecx,(%rdx)
  100a6a:	eb 1a                	jmp    100a86 <printer_vprintf+0x3eb>
  100a6c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a73:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a77:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a7b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a82:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a86:	8b 00                	mov    (%rax),%eax
  100a88:	48 98                	cltq   
  100a8a:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100a8e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a92:	48 c1 f8 38          	sar    $0x38,%rax
  100a96:	25 80 00 00 00       	and    $0x80,%eax
  100a9b:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100a9e:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100aa2:	74 09                	je     100aad <printer_vprintf+0x412>
  100aa4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100aa8:	48 f7 d8             	neg    %rax
  100aab:	eb 04                	jmp    100ab1 <printer_vprintf+0x416>
  100aad:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100ab1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100ab5:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100ab8:	83 c8 60             	or     $0x60,%eax
  100abb:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100abe:	e9 cf 02 00 00       	jmp    100d92 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100ac3:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100ac7:	74 5d                	je     100b26 <printer_vprintf+0x48b>
  100ac9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ad0:	8b 00                	mov    (%rax),%eax
  100ad2:	83 f8 2f             	cmp    $0x2f,%eax
  100ad5:	77 30                	ja     100b07 <printer_vprintf+0x46c>
  100ad7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ade:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ae2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ae9:	8b 00                	mov    (%rax),%eax
  100aeb:	89 c0                	mov    %eax,%eax
  100aed:	48 01 d0             	add    %rdx,%rax
  100af0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100af7:	8b 12                	mov    (%rdx),%edx
  100af9:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100afc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b03:	89 0a                	mov    %ecx,(%rdx)
  100b05:	eb 1a                	jmp    100b21 <printer_vprintf+0x486>
  100b07:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b0e:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b12:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b16:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b1d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b21:	48 8b 00             	mov    (%rax),%rax
  100b24:	eb 5c                	jmp    100b82 <printer_vprintf+0x4e7>
  100b26:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b2d:	8b 00                	mov    (%rax),%eax
  100b2f:	83 f8 2f             	cmp    $0x2f,%eax
  100b32:	77 30                	ja     100b64 <printer_vprintf+0x4c9>
  100b34:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b3b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b3f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b46:	8b 00                	mov    (%rax),%eax
  100b48:	89 c0                	mov    %eax,%eax
  100b4a:	48 01 d0             	add    %rdx,%rax
  100b4d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b54:	8b 12                	mov    (%rdx),%edx
  100b56:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b59:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b60:	89 0a                	mov    %ecx,(%rdx)
  100b62:	eb 1a                	jmp    100b7e <printer_vprintf+0x4e3>
  100b64:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b6b:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b6f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b73:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b7a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b7e:	8b 00                	mov    (%rax),%eax
  100b80:	89 c0                	mov    %eax,%eax
  100b82:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100b86:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100b8a:	e9 03 02 00 00       	jmp    100d92 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100b8f:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100b96:	e9 28 ff ff ff       	jmp    100ac3 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100b9b:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100ba2:	e9 1c ff ff ff       	jmp    100ac3 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100ba7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bae:	8b 00                	mov    (%rax),%eax
  100bb0:	83 f8 2f             	cmp    $0x2f,%eax
  100bb3:	77 30                	ja     100be5 <printer_vprintf+0x54a>
  100bb5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bbc:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100bc0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bc7:	8b 00                	mov    (%rax),%eax
  100bc9:	89 c0                	mov    %eax,%eax
  100bcb:	48 01 d0             	add    %rdx,%rax
  100bce:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bd5:	8b 12                	mov    (%rdx),%edx
  100bd7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bda:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100be1:	89 0a                	mov    %ecx,(%rdx)
  100be3:	eb 1a                	jmp    100bff <printer_vprintf+0x564>
  100be5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bec:	48 8b 40 08          	mov    0x8(%rax),%rax
  100bf0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100bf4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bfb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100bff:	48 8b 00             	mov    (%rax),%rax
  100c02:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100c06:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100c0d:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100c14:	e9 79 01 00 00       	jmp    100d92 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100c19:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c20:	8b 00                	mov    (%rax),%eax
  100c22:	83 f8 2f             	cmp    $0x2f,%eax
  100c25:	77 30                	ja     100c57 <printer_vprintf+0x5bc>
  100c27:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c2e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c32:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c39:	8b 00                	mov    (%rax),%eax
  100c3b:	89 c0                	mov    %eax,%eax
  100c3d:	48 01 d0             	add    %rdx,%rax
  100c40:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c47:	8b 12                	mov    (%rdx),%edx
  100c49:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c4c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c53:	89 0a                	mov    %ecx,(%rdx)
  100c55:	eb 1a                	jmp    100c71 <printer_vprintf+0x5d6>
  100c57:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c5e:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c62:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c66:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c6d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c71:	48 8b 00             	mov    (%rax),%rax
  100c74:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100c78:	e9 15 01 00 00       	jmp    100d92 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100c7d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c84:	8b 00                	mov    (%rax),%eax
  100c86:	83 f8 2f             	cmp    $0x2f,%eax
  100c89:	77 30                	ja     100cbb <printer_vprintf+0x620>
  100c8b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c92:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c96:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c9d:	8b 00                	mov    (%rax),%eax
  100c9f:	89 c0                	mov    %eax,%eax
  100ca1:	48 01 d0             	add    %rdx,%rax
  100ca4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cab:	8b 12                	mov    (%rdx),%edx
  100cad:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100cb0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cb7:	89 0a                	mov    %ecx,(%rdx)
  100cb9:	eb 1a                	jmp    100cd5 <printer_vprintf+0x63a>
  100cbb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cc2:	48 8b 40 08          	mov    0x8(%rax),%rax
  100cc6:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100cca:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cd1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100cd5:	8b 00                	mov    (%rax),%eax
  100cd7:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100cdd:	e9 67 03 00 00       	jmp    101049 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  100ce2:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100ce6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100cea:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cf1:	8b 00                	mov    (%rax),%eax
  100cf3:	83 f8 2f             	cmp    $0x2f,%eax
  100cf6:	77 30                	ja     100d28 <printer_vprintf+0x68d>
  100cf8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cff:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d03:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d0a:	8b 00                	mov    (%rax),%eax
  100d0c:	89 c0                	mov    %eax,%eax
  100d0e:	48 01 d0             	add    %rdx,%rax
  100d11:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d18:	8b 12                	mov    (%rdx),%edx
  100d1a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d1d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d24:	89 0a                	mov    %ecx,(%rdx)
  100d26:	eb 1a                	jmp    100d42 <printer_vprintf+0x6a7>
  100d28:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d2f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d33:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d37:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d3e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d42:	8b 00                	mov    (%rax),%eax
  100d44:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100d47:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100d4b:	eb 45                	jmp    100d92 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  100d4d:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d51:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100d55:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d5c:	0f b6 00             	movzbl (%rax),%eax
  100d5f:	84 c0                	test   %al,%al
  100d61:	74 0c                	je     100d6f <printer_vprintf+0x6d4>
  100d63:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d6a:	0f b6 00             	movzbl (%rax),%eax
  100d6d:	eb 05                	jmp    100d74 <printer_vprintf+0x6d9>
  100d6f:	b8 25 00 00 00       	mov    $0x25,%eax
  100d74:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100d77:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100d7b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d82:	0f b6 00             	movzbl (%rax),%eax
  100d85:	84 c0                	test   %al,%al
  100d87:	75 08                	jne    100d91 <printer_vprintf+0x6f6>
                format--;
  100d89:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100d90:	01 
            }
            break;
  100d91:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100d92:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d95:	83 e0 20             	and    $0x20,%eax
  100d98:	85 c0                	test   %eax,%eax
  100d9a:	74 1e                	je     100dba <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100d9c:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100da0:	48 83 c0 18          	add    $0x18,%rax
  100da4:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100da7:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100dab:	48 89 ce             	mov    %rcx,%rsi
  100dae:	48 89 c7             	mov    %rax,%rdi
  100db1:	e8 63 f8 ff ff       	call   100619 <fill_numbuf>
  100db6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100dba:	48 c7 45 c0 d6 13 10 	movq   $0x1013d6,-0x40(%rbp)
  100dc1:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100dc2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dc5:	83 e0 20             	and    $0x20,%eax
  100dc8:	85 c0                	test   %eax,%eax
  100dca:	74 48                	je     100e14 <printer_vprintf+0x779>
  100dcc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dcf:	83 e0 40             	and    $0x40,%eax
  100dd2:	85 c0                	test   %eax,%eax
  100dd4:	74 3e                	je     100e14 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  100dd6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dd9:	25 80 00 00 00       	and    $0x80,%eax
  100dde:	85 c0                	test   %eax,%eax
  100de0:	74 0a                	je     100dec <printer_vprintf+0x751>
                prefix = "-";
  100de2:	48 c7 45 c0 d7 13 10 	movq   $0x1013d7,-0x40(%rbp)
  100de9:	00 
            if (flags & FLAG_NEGATIVE) {
  100dea:	eb 73                	jmp    100e5f <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100dec:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100def:	83 e0 10             	and    $0x10,%eax
  100df2:	85 c0                	test   %eax,%eax
  100df4:	74 0a                	je     100e00 <printer_vprintf+0x765>
                prefix = "+";
  100df6:	48 c7 45 c0 d9 13 10 	movq   $0x1013d9,-0x40(%rbp)
  100dfd:	00 
            if (flags & FLAG_NEGATIVE) {
  100dfe:	eb 5f                	jmp    100e5f <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100e00:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e03:	83 e0 08             	and    $0x8,%eax
  100e06:	85 c0                	test   %eax,%eax
  100e08:	74 55                	je     100e5f <printer_vprintf+0x7c4>
                prefix = " ";
  100e0a:	48 c7 45 c0 db 13 10 	movq   $0x1013db,-0x40(%rbp)
  100e11:	00 
            if (flags & FLAG_NEGATIVE) {
  100e12:	eb 4b                	jmp    100e5f <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100e14:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e17:	83 e0 20             	and    $0x20,%eax
  100e1a:	85 c0                	test   %eax,%eax
  100e1c:	74 42                	je     100e60 <printer_vprintf+0x7c5>
  100e1e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e21:	83 e0 01             	and    $0x1,%eax
  100e24:	85 c0                	test   %eax,%eax
  100e26:	74 38                	je     100e60 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  100e28:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100e2c:	74 06                	je     100e34 <printer_vprintf+0x799>
  100e2e:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100e32:	75 2c                	jne    100e60 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  100e34:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100e39:	75 0c                	jne    100e47 <printer_vprintf+0x7ac>
  100e3b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e3e:	25 00 01 00 00       	and    $0x100,%eax
  100e43:	85 c0                	test   %eax,%eax
  100e45:	74 19                	je     100e60 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  100e47:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100e4b:	75 07                	jne    100e54 <printer_vprintf+0x7b9>
  100e4d:	b8 dd 13 10 00       	mov    $0x1013dd,%eax
  100e52:	eb 05                	jmp    100e59 <printer_vprintf+0x7be>
  100e54:	b8 e0 13 10 00       	mov    $0x1013e0,%eax
  100e59:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100e5d:	eb 01                	jmp    100e60 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  100e5f:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100e60:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100e64:	78 24                	js     100e8a <printer_vprintf+0x7ef>
  100e66:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e69:	83 e0 20             	and    $0x20,%eax
  100e6c:	85 c0                	test   %eax,%eax
  100e6e:	75 1a                	jne    100e8a <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  100e70:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100e73:	48 63 d0             	movslq %eax,%rdx
  100e76:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100e7a:	48 89 d6             	mov    %rdx,%rsi
  100e7d:	48 89 c7             	mov    %rax,%rdi
  100e80:	e8 ea f5 ff ff       	call   10046f <strnlen>
  100e85:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100e88:	eb 0f                	jmp    100e99 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  100e8a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100e8e:	48 89 c7             	mov    %rax,%rdi
  100e91:	e8 a8 f5 ff ff       	call   10043e <strlen>
  100e96:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100e99:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e9c:	83 e0 20             	and    $0x20,%eax
  100e9f:	85 c0                	test   %eax,%eax
  100ea1:	74 20                	je     100ec3 <printer_vprintf+0x828>
  100ea3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100ea7:	78 1a                	js     100ec3 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  100ea9:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100eac:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100eaf:	7e 08                	jle    100eb9 <printer_vprintf+0x81e>
  100eb1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100eb4:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100eb7:	eb 05                	jmp    100ebe <printer_vprintf+0x823>
  100eb9:	b8 00 00 00 00       	mov    $0x0,%eax
  100ebe:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100ec1:	eb 5c                	jmp    100f1f <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100ec3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ec6:	83 e0 20             	and    $0x20,%eax
  100ec9:	85 c0                	test   %eax,%eax
  100ecb:	74 4b                	je     100f18 <printer_vprintf+0x87d>
  100ecd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ed0:	83 e0 02             	and    $0x2,%eax
  100ed3:	85 c0                	test   %eax,%eax
  100ed5:	74 41                	je     100f18 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100ed7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100eda:	83 e0 04             	and    $0x4,%eax
  100edd:	85 c0                	test   %eax,%eax
  100edf:	75 37                	jne    100f18 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  100ee1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100ee5:	48 89 c7             	mov    %rax,%rdi
  100ee8:	e8 51 f5 ff ff       	call   10043e <strlen>
  100eed:	89 c2                	mov    %eax,%edx
  100eef:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100ef2:	01 d0                	add    %edx,%eax
  100ef4:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100ef7:	7e 1f                	jle    100f18 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  100ef9:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100efc:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100eff:	89 c3                	mov    %eax,%ebx
  100f01:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f05:	48 89 c7             	mov    %rax,%rdi
  100f08:	e8 31 f5 ff ff       	call   10043e <strlen>
  100f0d:	89 c2                	mov    %eax,%edx
  100f0f:	89 d8                	mov    %ebx,%eax
  100f11:	29 d0                	sub    %edx,%eax
  100f13:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100f16:	eb 07                	jmp    100f1f <printer_vprintf+0x884>
        } else {
            zeros = 0;
  100f18:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100f1f:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100f22:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100f25:	01 d0                	add    %edx,%eax
  100f27:	48 63 d8             	movslq %eax,%rbx
  100f2a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f2e:	48 89 c7             	mov    %rax,%rdi
  100f31:	e8 08 f5 ff ff       	call   10043e <strlen>
  100f36:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100f3a:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100f3d:	29 d0                	sub    %edx,%eax
  100f3f:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100f42:	eb 25                	jmp    100f69 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  100f44:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f4b:	48 8b 08             	mov    (%rax),%rcx
  100f4e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f54:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f5b:	be 20 00 00 00       	mov    $0x20,%esi
  100f60:	48 89 c7             	mov    %rax,%rdi
  100f63:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100f65:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100f69:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f6c:	83 e0 04             	and    $0x4,%eax
  100f6f:	85 c0                	test   %eax,%eax
  100f71:	75 36                	jne    100fa9 <printer_vprintf+0x90e>
  100f73:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100f77:	7f cb                	jg     100f44 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  100f79:	eb 2e                	jmp    100fa9 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  100f7b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f82:	4c 8b 00             	mov    (%rax),%r8
  100f85:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f89:	0f b6 00             	movzbl (%rax),%eax
  100f8c:	0f b6 c8             	movzbl %al,%ecx
  100f8f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f95:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f9c:	89 ce                	mov    %ecx,%esi
  100f9e:	48 89 c7             	mov    %rax,%rdi
  100fa1:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  100fa4:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  100fa9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100fad:	0f b6 00             	movzbl (%rax),%eax
  100fb0:	84 c0                	test   %al,%al
  100fb2:	75 c7                	jne    100f7b <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  100fb4:	eb 25                	jmp    100fdb <printer_vprintf+0x940>
            p->putc(p, '0', color);
  100fb6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fbd:	48 8b 08             	mov    (%rax),%rcx
  100fc0:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100fc6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fcd:	be 30 00 00 00       	mov    $0x30,%esi
  100fd2:	48 89 c7             	mov    %rax,%rdi
  100fd5:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  100fd7:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  100fdb:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  100fdf:	7f d5                	jg     100fb6 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  100fe1:	eb 32                	jmp    101015 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  100fe3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fea:	4c 8b 00             	mov    (%rax),%r8
  100fed:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100ff1:	0f b6 00             	movzbl (%rax),%eax
  100ff4:	0f b6 c8             	movzbl %al,%ecx
  100ff7:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100ffd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101004:	89 ce                	mov    %ecx,%esi
  101006:	48 89 c7             	mov    %rax,%rdi
  101009:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  10100c:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  101011:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  101015:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  101019:	7f c8                	jg     100fe3 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  10101b:	eb 25                	jmp    101042 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  10101d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101024:	48 8b 08             	mov    (%rax),%rcx
  101027:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10102d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101034:	be 20 00 00 00       	mov    $0x20,%esi
  101039:	48 89 c7             	mov    %rax,%rdi
  10103c:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  10103e:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101042:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101046:	7f d5                	jg     10101d <printer_vprintf+0x982>
        }
    done: ;
  101048:	90                   	nop
    for (; *format; ++format) {
  101049:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101050:	01 
  101051:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101058:	0f b6 00             	movzbl (%rax),%eax
  10105b:	84 c0                	test   %al,%al
  10105d:	0f 85 64 f6 ff ff    	jne    1006c7 <printer_vprintf+0x2c>
    }
}
  101063:	90                   	nop
  101064:	90                   	nop
  101065:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  101069:	c9                   	leave  
  10106a:	c3                   	ret    

000000000010106b <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  10106b:	55                   	push   %rbp
  10106c:	48 89 e5             	mov    %rsp,%rbp
  10106f:	48 83 ec 20          	sub    $0x20,%rsp
  101073:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101077:	89 f0                	mov    %esi,%eax
  101079:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10107c:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  10107f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101083:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101087:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10108b:	48 8b 40 08          	mov    0x8(%rax),%rax
  10108f:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  101094:	48 39 d0             	cmp    %rdx,%rax
  101097:	72 0c                	jb     1010a5 <console_putc+0x3a>
        cp->cursor = console;
  101099:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10109d:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  1010a4:	00 
    }
    if (c == '\n') {
  1010a5:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  1010a9:	75 78                	jne    101123 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  1010ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010af:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010b3:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1010b9:	48 d1 f8             	sar    %rax
  1010bc:	48 89 c1             	mov    %rax,%rcx
  1010bf:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1010c6:	66 66 66 
  1010c9:	48 89 c8             	mov    %rcx,%rax
  1010cc:	48 f7 ea             	imul   %rdx
  1010cf:	48 c1 fa 05          	sar    $0x5,%rdx
  1010d3:	48 89 c8             	mov    %rcx,%rax
  1010d6:	48 c1 f8 3f          	sar    $0x3f,%rax
  1010da:	48 29 c2             	sub    %rax,%rdx
  1010dd:	48 89 d0             	mov    %rdx,%rax
  1010e0:	48 c1 e0 02          	shl    $0x2,%rax
  1010e4:	48 01 d0             	add    %rdx,%rax
  1010e7:	48 c1 e0 04          	shl    $0x4,%rax
  1010eb:	48 29 c1             	sub    %rax,%rcx
  1010ee:	48 89 ca             	mov    %rcx,%rdx
  1010f1:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  1010f4:	eb 25                	jmp    10111b <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  1010f6:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1010f9:	83 c8 20             	or     $0x20,%eax
  1010fc:	89 c6                	mov    %eax,%esi
  1010fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101102:	48 8b 40 08          	mov    0x8(%rax),%rax
  101106:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10110a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  10110e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101112:	89 f2                	mov    %esi,%edx
  101114:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  101117:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10111b:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  10111f:	75 d5                	jne    1010f6 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101121:	eb 24                	jmp    101147 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  101123:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  101127:	8b 55 e0             	mov    -0x20(%rbp),%edx
  10112a:	09 d0                	or     %edx,%eax
  10112c:	89 c6                	mov    %eax,%esi
  10112e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101132:	48 8b 40 08          	mov    0x8(%rax),%rax
  101136:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10113a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  10113e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101142:	89 f2                	mov    %esi,%edx
  101144:	66 89 10             	mov    %dx,(%rax)
}
  101147:	90                   	nop
  101148:	c9                   	leave  
  101149:	c3                   	ret    

000000000010114a <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  10114a:	55                   	push   %rbp
  10114b:	48 89 e5             	mov    %rsp,%rbp
  10114e:	48 83 ec 30          	sub    $0x30,%rsp
  101152:	89 7d ec             	mov    %edi,-0x14(%rbp)
  101155:	89 75 e8             	mov    %esi,-0x18(%rbp)
  101158:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  10115c:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  101160:	48 c7 45 f0 6b 10 10 	movq   $0x10106b,-0x10(%rbp)
  101167:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101168:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  10116c:	78 09                	js     101177 <console_vprintf+0x2d>
  10116e:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101175:	7e 07                	jle    10117e <console_vprintf+0x34>
        cpos = 0;
  101177:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  10117e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101181:	48 98                	cltq   
  101183:	48 01 c0             	add    %rax,%rax
  101186:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  10118c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101190:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101194:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  101198:	8b 75 e8             	mov    -0x18(%rbp),%esi
  10119b:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  10119f:	48 89 c7             	mov    %rax,%rdi
  1011a2:	e8 f4 f4 ff ff       	call   10069b <printer_vprintf>
    return cp.cursor - console;
  1011a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1011ab:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1011b1:	48 d1 f8             	sar    %rax
}
  1011b4:	c9                   	leave  
  1011b5:	c3                   	ret    

00000000001011b6 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  1011b6:	55                   	push   %rbp
  1011b7:	48 89 e5             	mov    %rsp,%rbp
  1011ba:	48 83 ec 60          	sub    $0x60,%rsp
  1011be:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1011c1:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1011c4:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1011c8:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1011cc:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1011d0:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1011d4:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1011db:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1011df:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1011e3:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1011e7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1011eb:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1011ef:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  1011f3:	8b 75 a8             	mov    -0x58(%rbp),%esi
  1011f6:	8b 45 ac             	mov    -0x54(%rbp),%eax
  1011f9:	89 c7                	mov    %eax,%edi
  1011fb:	e8 4a ff ff ff       	call   10114a <console_vprintf>
  101200:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101203:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101206:	c9                   	leave  
  101207:	c3                   	ret    

0000000000101208 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101208:	55                   	push   %rbp
  101209:	48 89 e5             	mov    %rsp,%rbp
  10120c:	48 83 ec 20          	sub    $0x20,%rsp
  101210:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101214:	89 f0                	mov    %esi,%eax
  101216:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101219:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  10121c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101220:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101224:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101228:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10122c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101230:	48 8b 40 10          	mov    0x10(%rax),%rax
  101234:	48 39 c2             	cmp    %rax,%rdx
  101237:	73 1a                	jae    101253 <string_putc+0x4b>
        *sp->s++ = c;
  101239:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10123d:	48 8b 40 08          	mov    0x8(%rax),%rax
  101241:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101245:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101249:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10124d:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101251:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101253:	90                   	nop
  101254:	c9                   	leave  
  101255:	c3                   	ret    

0000000000101256 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101256:	55                   	push   %rbp
  101257:	48 89 e5             	mov    %rsp,%rbp
  10125a:	48 83 ec 40          	sub    $0x40,%rsp
  10125e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101262:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101266:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  10126a:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  10126e:	48 c7 45 e8 08 12 10 	movq   $0x101208,-0x18(%rbp)
  101275:	00 
    sp.s = s;
  101276:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10127a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  10127e:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  101283:	74 33                	je     1012b8 <vsnprintf+0x62>
        sp.end = s + size - 1;
  101285:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101289:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10128d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101291:	48 01 d0             	add    %rdx,%rax
  101294:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101298:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  10129c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1012a0:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1012a4:	be 00 00 00 00       	mov    $0x0,%esi
  1012a9:	48 89 c7             	mov    %rax,%rdi
  1012ac:	e8 ea f3 ff ff       	call   10069b <printer_vprintf>
        *sp.s = 0;
  1012b1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1012b5:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1012b8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1012bc:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1012c0:	c9                   	leave  
  1012c1:	c3                   	ret    

00000000001012c2 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1012c2:	55                   	push   %rbp
  1012c3:	48 89 e5             	mov    %rsp,%rbp
  1012c6:	48 83 ec 70          	sub    $0x70,%rsp
  1012ca:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1012ce:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1012d2:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1012d6:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1012da:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1012de:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1012e2:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  1012e9:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1012ed:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  1012f1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1012f5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  1012f9:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  1012fd:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101301:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101305:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101309:	48 89 c7             	mov    %rax,%rdi
  10130c:	e8 45 ff ff ff       	call   101256 <vsnprintf>
  101311:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101314:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101317:	c9                   	leave  
  101318:	c3                   	ret    

0000000000101319 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101319:	55                   	push   %rbp
  10131a:	48 89 e5             	mov    %rsp,%rbp
  10131d:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101321:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101328:	eb 13                	jmp    10133d <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  10132a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10132d:	48 98                	cltq   
  10132f:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  101336:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101339:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10133d:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101344:	7e e4                	jle    10132a <console_clear+0x11>
    }
    cursorpos = 0;
  101346:	c7 05 ac 7c fb ff 00 	movl   $0x0,-0x48354(%rip)        # b8ffc <cursorpos>
  10134d:	00 00 00 
}
  101350:	90                   	nop
  101351:	c9                   	leave  
  101352:	c3                   	ret    
