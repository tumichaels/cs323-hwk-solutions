
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
uint8_t* stack_bottom;

// checks if multiple processes can allocate at the same Virtual Memory Address
// (run at least two instances)

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	53                   	push   %rbx
  100005:	48 83 ec 08          	sub    $0x8,%rsp

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100009:	cd 31                	int    $0x31
  10000b:	89 c3                	mov    %eax,%ebx
    pid_t p = sys_getpid();
    srand(p);
  10000d:	89 c7                	mov    %eax,%edi
  10000f:	e8 07 05 00 00       	call   10051b <srand>
    // The heap starts on the page right after the 'end' symbol,
    // whose address is the first address not allocated to process code
    // or data.
    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100014:	b8 17 30 10 00       	mov    $0x103017,%eax
  100019:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10001f:	48 89 05 e2 1f 00 00 	mov    %rax,0x1fe2(%rip)        # 102008 <heap_top>

    app_printf(p, "Make sure you are running this test with at least 2 processes running by hitting 2!\n");
  100026:	be 80 12 10 00       	mov    $0x101280,%esi
  10002b:	89 df                	mov    %ebx,%edi
  10002d:	b8 00 00 00 00       	mov    $0x0,%eax
  100032:	e8 61 00 00 00       	call   100098 <app_printf>
//    PAGESIZE == 4096). Returns 0 on success and -1 on failure.
//
//    inline assembly explained here: https://www.ibiblio.org/gferg/ldp/GCC-Inline-Assembly-HOWTO.html
static inline int sys_page_alloc(void* addr) {
    int result;
    asm volatile ("int %1"		// generates a "INT_SYS_PAGE_ALLOC" type interrupt 
  100037:	48 8b 3d ca 1f 00 00 	mov    0x1fca(%rip),%rdi        # 102008 <heap_top>
  10003e:	cd 33                	int    $0x33

    // check if process can access each others memory

    int x = sys_page_alloc((void *) (heap_top));

    if(x != 0)
  100040:	85 c0                	test   %eax,%eax
  100042:	75 36                	jne    10007a <process_main+0x7a>
    asm volatile ("int %0" : /* no result */
  100044:	cd 32                	int    $0x32

    // yield to make sure other process also runs before continuing
    sys_yield();

    // write to allocd page
    *heap_top = p;
  100046:	48 8b 05 bb 1f 00 00 	mov    0x1fbb(%rip),%rax        # 102008 <heap_top>
  10004d:	88 18                	mov    %bl,(%rax)
  10004f:	cd 32                	int    $0x32
  100051:	b8 64 00 00 00       	mov    $0x64,%eax

    sys_yield();

    // Now, test at least 100 times to see if values will ever change
    for(int i = 0 ; i < 100 ; i++){
        if(*heap_top != p)
  100056:	48 8b 15 ab 1f 00 00 	mov    0x1fab(%rip),%rdx        # 102008 <heap_top>
  10005d:	0f b6 12             	movzbl (%rdx),%edx
  100060:	39 da                	cmp    %ebx,%edx
  100062:	75 25                	jne    100089 <process_main+0x89>
  100064:	cd 32                	int    $0x32
    for(int i = 0 ; i < 100 ; i++){
  100066:	83 e8 01             	sub    $0x1,%eax
  100069:	75 eb                	jne    100056 <process_main+0x56>
            panic("Error, value changed! process memory not isolated!\n");
        sys_yield();
    }

    TEST_PASS();
  10006b:	bf 3c 13 10 00       	mov    $0x10133c,%edi
  100070:	b8 00 00 00 00       	mov    $0x0,%eax
  100075:	e8 ae 00 00 00       	call   100128 <panic>
        panic("Error, couldn't allocate same memory location!\n");
  10007a:	bf d8 12 10 00       	mov    $0x1012d8,%edi
  10007f:	b8 00 00 00 00       	mov    $0x0,%eax
  100084:	e8 9f 00 00 00       	call   100128 <panic>
            panic("Error, value changed! process memory not isolated!\n");
  100089:	bf 08 13 10 00       	mov    $0x101308,%edi
  10008e:	b8 00 00 00 00       	mov    $0x0,%eax
  100093:	e8 90 00 00 00       	call   100128 <panic>

0000000000100098 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100098:	55                   	push   %rbp
  100099:	48 89 e5             	mov    %rsp,%rbp
  10009c:	48 83 ec 50          	sub    $0x50,%rsp
  1000a0:	49 89 f2             	mov    %rsi,%r10
  1000a3:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1000a7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1000ab:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1000af:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  1000b3:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  1000b8:	85 ff                	test   %edi,%edi
  1000ba:	78 2e                	js     1000ea <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  1000bc:	48 63 ff             	movslq %edi,%rdi
  1000bf:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  1000c6:	cc cc cc 
  1000c9:	48 89 f8             	mov    %rdi,%rax
  1000cc:	48 f7 e2             	mul    %rdx
  1000cf:	48 89 d0             	mov    %rdx,%rax
  1000d2:	48 c1 e8 02          	shr    $0x2,%rax
  1000d6:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  1000da:	48 01 c2             	add    %rax,%rdx
  1000dd:	48 29 d7             	sub    %rdx,%rdi
  1000e0:	0f b6 b7 8d 13 10 00 	movzbl 0x10138d(%rdi),%esi
  1000e7:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  1000ea:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  1000f1:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1000f5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1000f9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1000fd:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  100101:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100105:	4c 89 d2             	mov    %r10,%rdx
  100108:	8b 3d ee 8e fb ff    	mov    -0x47112(%rip),%edi        # b8ffc <cursorpos>
  10010e:	e8 5a 0f 00 00       	call   10106d <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100113:	3d 30 07 00 00       	cmp    $0x730,%eax
  100118:	ba 00 00 00 00       	mov    $0x0,%edx
  10011d:	0f 4d c2             	cmovge %edx,%eax
  100120:	89 05 d6 8e fb ff    	mov    %eax,-0x4712a(%rip)        # b8ffc <cursorpos>
    }
}
  100126:	c9                   	leave  
  100127:	c3                   	ret    

0000000000100128 <panic>:


// panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
  100128:	55                   	push   %rbp
  100129:	48 89 e5             	mov    %rsp,%rbp
  10012c:	53                   	push   %rbx
  10012d:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100134:	48 89 fb             	mov    %rdi,%rbx
  100137:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  10013b:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  10013f:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100143:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100147:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  10014b:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  100152:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100156:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  10015a:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  10015e:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  100162:	ba 07 00 00 00       	mov    $0x7,%edx
  100167:	be 57 13 10 00       	mov    $0x101357,%esi
  10016c:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100173:	e8 ac 00 00 00       	call   100224 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100178:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  10017c:	48 89 da             	mov    %rbx,%rdx
  10017f:	be 99 00 00 00       	mov    $0x99,%esi
  100184:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  10018b:	e8 e9 0f 00 00       	call   101179 <vsnprintf>
  100190:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100193:	85 d2                	test   %edx,%edx
  100195:	7e 0f                	jle    1001a6 <panic+0x7e>
  100197:	83 c0 06             	add    $0x6,%eax
  10019a:	48 98                	cltq   
  10019c:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  1001a3:	0a 
  1001a4:	75 29                	jne    1001cf <panic+0xa7>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  1001a6:	48 8d 8d 08 ff ff ff 	lea    -0xf8(%rbp),%rcx
  1001ad:	ba 61 13 10 00       	mov    $0x101361,%edx
  1001b2:	be 00 c0 00 00       	mov    $0xc000,%esi
  1001b7:	bf 30 07 00 00       	mov    $0x730,%edi
  1001bc:	b8 00 00 00 00       	mov    $0x0,%eax
  1001c1:	e8 13 0f 00 00       	call   1010d9 <console_printf>
}

// sys_panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) sys_panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  1001c6:	bf 00 00 00 00       	mov    $0x0,%edi
  1001cb:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  1001cd:	eb fe                	jmp    1001cd <panic+0xa5>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  1001cf:	48 63 c2             	movslq %edx,%rax
  1001d2:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  1001d8:	0f 94 c2             	sete   %dl
  1001db:	0f b6 d2             	movzbl %dl,%edx
  1001de:	48 29 d0             	sub    %rdx,%rax
  1001e1:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  1001e8:	ff 
  1001e9:	be 5f 13 10 00       	mov    $0x10135f,%esi
  1001ee:	e8 de 01 00 00       	call   1003d1 <strcpy>
  1001f3:	eb b1                	jmp    1001a6 <panic+0x7e>

00000000001001f5 <assert_fail>:
    sys_panic(NULL);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  1001f5:	55                   	push   %rbp
  1001f6:	48 89 e5             	mov    %rsp,%rbp
  1001f9:	48 89 f9             	mov    %rdi,%rcx
  1001fc:	41 89 f0             	mov    %esi,%r8d
  1001ff:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100202:	ba 68 13 10 00       	mov    $0x101368,%edx
  100207:	be 00 c0 00 00       	mov    $0xc000,%esi
  10020c:	bf 30 07 00 00       	mov    $0x730,%edi
  100211:	b8 00 00 00 00       	mov    $0x0,%eax
  100216:	e8 be 0e 00 00       	call   1010d9 <console_printf>
    asm volatile ("int %0" : /* no result */
  10021b:	bf 00 00 00 00       	mov    $0x0,%edi
  100220:	cd 30                	int    $0x30
 loop: goto loop;
  100222:	eb fe                	jmp    100222 <assert_fail+0x2d>

0000000000100224 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100224:	55                   	push   %rbp
  100225:	48 89 e5             	mov    %rsp,%rbp
  100228:	48 83 ec 28          	sub    $0x28,%rsp
  10022c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100230:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100234:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100238:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10023c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100240:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100244:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100248:	eb 1c                	jmp    100266 <memcpy+0x42>
        *d = *s;
  10024a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10024e:	0f b6 10             	movzbl (%rax),%edx
  100251:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100255:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100257:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10025c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100261:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100266:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10026b:	75 dd                	jne    10024a <memcpy+0x26>
    }
    return dst;
  10026d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100271:	c9                   	leave  
  100272:	c3                   	ret    

0000000000100273 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100273:	55                   	push   %rbp
  100274:	48 89 e5             	mov    %rsp,%rbp
  100277:	48 83 ec 28          	sub    $0x28,%rsp
  10027b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10027f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100283:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100287:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10028b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  10028f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100293:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100297:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10029b:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  10029f:	73 6a                	jae    10030b <memmove+0x98>
  1002a1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1002a5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1002a9:	48 01 d0             	add    %rdx,%rax
  1002ac:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1002b0:	73 59                	jae    10030b <memmove+0x98>
        s += n, d += n;
  1002b2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1002b6:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1002ba:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1002be:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1002c2:	eb 17                	jmp    1002db <memmove+0x68>
            *--d = *--s;
  1002c4:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1002c9:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1002ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002d2:	0f b6 10             	movzbl (%rax),%edx
  1002d5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1002d9:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1002db:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1002df:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1002e3:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1002e7:	48 85 c0             	test   %rax,%rax
  1002ea:	75 d8                	jne    1002c4 <memmove+0x51>
    if (s < d && s + n > d) {
  1002ec:	eb 2e                	jmp    10031c <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1002ee:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1002f2:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1002f6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1002fa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1002fe:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100302:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100306:	0f b6 12             	movzbl (%rdx),%edx
  100309:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  10030b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10030f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100313:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100317:	48 85 c0             	test   %rax,%rax
  10031a:	75 d2                	jne    1002ee <memmove+0x7b>
        }
    }
    return dst;
  10031c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100320:	c9                   	leave  
  100321:	c3                   	ret    

0000000000100322 <memset>:

void* memset(void* v, int c, size_t n) {
  100322:	55                   	push   %rbp
  100323:	48 89 e5             	mov    %rsp,%rbp
  100326:	48 83 ec 28          	sub    $0x28,%rsp
  10032a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10032e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100331:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100335:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100339:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10033d:	eb 15                	jmp    100354 <memset+0x32>
        *p = c;
  10033f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100342:	89 c2                	mov    %eax,%edx
  100344:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100348:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10034a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10034f:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100354:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100359:	75 e4                	jne    10033f <memset+0x1d>
    }
    return v;
  10035b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10035f:	c9                   	leave  
  100360:	c3                   	ret    

0000000000100361 <strlen>:

size_t strlen(const char* s) {
  100361:	55                   	push   %rbp
  100362:	48 89 e5             	mov    %rsp,%rbp
  100365:	48 83 ec 18          	sub    $0x18,%rsp
  100369:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  10036d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100374:	00 
  100375:	eb 0a                	jmp    100381 <strlen+0x20>
        ++n;
  100377:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  10037c:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100381:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100385:	0f b6 00             	movzbl (%rax),%eax
  100388:	84 c0                	test   %al,%al
  10038a:	75 eb                	jne    100377 <strlen+0x16>
    }
    return n;
  10038c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100390:	c9                   	leave  
  100391:	c3                   	ret    

0000000000100392 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100392:	55                   	push   %rbp
  100393:	48 89 e5             	mov    %rsp,%rbp
  100396:	48 83 ec 20          	sub    $0x20,%rsp
  10039a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10039e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1003a2:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1003a9:	00 
  1003aa:	eb 0a                	jmp    1003b6 <strnlen+0x24>
        ++n;
  1003ac:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1003b1:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1003b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003ba:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  1003be:	74 0b                	je     1003cb <strnlen+0x39>
  1003c0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1003c4:	0f b6 00             	movzbl (%rax),%eax
  1003c7:	84 c0                	test   %al,%al
  1003c9:	75 e1                	jne    1003ac <strnlen+0x1a>
    }
    return n;
  1003cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1003cf:	c9                   	leave  
  1003d0:	c3                   	ret    

00000000001003d1 <strcpy>:

char* strcpy(char* dst, const char* src) {
  1003d1:	55                   	push   %rbp
  1003d2:	48 89 e5             	mov    %rsp,%rbp
  1003d5:	48 83 ec 20          	sub    $0x20,%rsp
  1003d9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1003dd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1003e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1003e5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1003e9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1003ed:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1003f1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1003f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003f9:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1003fd:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100401:	0f b6 12             	movzbl (%rdx),%edx
  100404:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100406:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10040a:	48 83 e8 01          	sub    $0x1,%rax
  10040e:	0f b6 00             	movzbl (%rax),%eax
  100411:	84 c0                	test   %al,%al
  100413:	75 d4                	jne    1003e9 <strcpy+0x18>
    return dst;
  100415:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100419:	c9                   	leave  
  10041a:	c3                   	ret    

000000000010041b <strcmp>:

int strcmp(const char* a, const char* b) {
  10041b:	55                   	push   %rbp
  10041c:	48 89 e5             	mov    %rsp,%rbp
  10041f:	48 83 ec 10          	sub    $0x10,%rsp
  100423:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100427:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10042b:	eb 0a                	jmp    100437 <strcmp+0x1c>
        ++a, ++b;
  10042d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100432:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100437:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10043b:	0f b6 00             	movzbl (%rax),%eax
  10043e:	84 c0                	test   %al,%al
  100440:	74 1d                	je     10045f <strcmp+0x44>
  100442:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100446:	0f b6 00             	movzbl (%rax),%eax
  100449:	84 c0                	test   %al,%al
  10044b:	74 12                	je     10045f <strcmp+0x44>
  10044d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100451:	0f b6 10             	movzbl (%rax),%edx
  100454:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100458:	0f b6 00             	movzbl (%rax),%eax
  10045b:	38 c2                	cmp    %al,%dl
  10045d:	74 ce                	je     10042d <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  10045f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100463:	0f b6 00             	movzbl (%rax),%eax
  100466:	89 c2                	mov    %eax,%edx
  100468:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10046c:	0f b6 00             	movzbl (%rax),%eax
  10046f:	38 d0                	cmp    %dl,%al
  100471:	0f 92 c0             	setb   %al
  100474:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100477:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10047b:	0f b6 00             	movzbl (%rax),%eax
  10047e:	89 c1                	mov    %eax,%ecx
  100480:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100484:	0f b6 00             	movzbl (%rax),%eax
  100487:	38 c1                	cmp    %al,%cl
  100489:	0f 92 c0             	setb   %al
  10048c:	0f b6 c0             	movzbl %al,%eax
  10048f:	29 c2                	sub    %eax,%edx
  100491:	89 d0                	mov    %edx,%eax
}
  100493:	c9                   	leave  
  100494:	c3                   	ret    

0000000000100495 <strchr>:

char* strchr(const char* s, int c) {
  100495:	55                   	push   %rbp
  100496:	48 89 e5             	mov    %rsp,%rbp
  100499:	48 83 ec 10          	sub    $0x10,%rsp
  10049d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1004a1:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1004a4:	eb 05                	jmp    1004ab <strchr+0x16>
        ++s;
  1004a6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1004ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004af:	0f b6 00             	movzbl (%rax),%eax
  1004b2:	84 c0                	test   %al,%al
  1004b4:	74 0e                	je     1004c4 <strchr+0x2f>
  1004b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004ba:	0f b6 00             	movzbl (%rax),%eax
  1004bd:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1004c0:	38 d0                	cmp    %dl,%al
  1004c2:	75 e2                	jne    1004a6 <strchr+0x11>
    }
    if (*s == (char) c) {
  1004c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004c8:	0f b6 00             	movzbl (%rax),%eax
  1004cb:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1004ce:	38 d0                	cmp    %dl,%al
  1004d0:	75 06                	jne    1004d8 <strchr+0x43>
        return (char*) s;
  1004d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004d6:	eb 05                	jmp    1004dd <strchr+0x48>
    } else {
        return NULL;
  1004d8:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1004dd:	c9                   	leave  
  1004de:	c3                   	ret    

00000000001004df <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1004df:	55                   	push   %rbp
  1004e0:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1004e3:	8b 05 27 1b 00 00    	mov    0x1b27(%rip),%eax        # 102010 <rand_seed_set>
  1004e9:	85 c0                	test   %eax,%eax
  1004eb:	75 0a                	jne    1004f7 <rand+0x18>
        srand(819234718U);
  1004ed:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1004f2:	e8 24 00 00 00       	call   10051b <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1004f7:	8b 05 17 1b 00 00    	mov    0x1b17(%rip),%eax        # 102014 <rand_seed>
  1004fd:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100503:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100508:	89 05 06 1b 00 00    	mov    %eax,0x1b06(%rip)        # 102014 <rand_seed>
    return rand_seed & RAND_MAX;
  10050e:	8b 05 00 1b 00 00    	mov    0x1b00(%rip),%eax        # 102014 <rand_seed>
  100514:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100519:	5d                   	pop    %rbp
  10051a:	c3                   	ret    

000000000010051b <srand>:

void srand(unsigned seed) {
  10051b:	55                   	push   %rbp
  10051c:	48 89 e5             	mov    %rsp,%rbp
  10051f:	48 83 ec 08          	sub    $0x8,%rsp
  100523:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100526:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100529:	89 05 e5 1a 00 00    	mov    %eax,0x1ae5(%rip)        # 102014 <rand_seed>
    rand_seed_set = 1;
  10052f:	c7 05 d7 1a 00 00 01 	movl   $0x1,0x1ad7(%rip)        # 102010 <rand_seed_set>
  100536:	00 00 00 
}
  100539:	90                   	nop
  10053a:	c9                   	leave  
  10053b:	c3                   	ret    

000000000010053c <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  10053c:	55                   	push   %rbp
  10053d:	48 89 e5             	mov    %rsp,%rbp
  100540:	48 83 ec 28          	sub    $0x28,%rsp
  100544:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100548:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10054c:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  10054f:	48 c7 45 f8 80 15 10 	movq   $0x101580,-0x8(%rbp)
  100556:	00 
    if (base < 0) {
  100557:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  10055b:	79 0b                	jns    100568 <fill_numbuf+0x2c>
        digits = lower_digits;
  10055d:	48 c7 45 f8 a0 15 10 	movq   $0x1015a0,-0x8(%rbp)
  100564:	00 
        base = -base;
  100565:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100568:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10056d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100571:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100574:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100577:	48 63 c8             	movslq %eax,%rcx
  10057a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10057e:	ba 00 00 00 00       	mov    $0x0,%edx
  100583:	48 f7 f1             	div    %rcx
  100586:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10058a:	48 01 d0             	add    %rdx,%rax
  10058d:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100592:	0f b6 10             	movzbl (%rax),%edx
  100595:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100599:	88 10                	mov    %dl,(%rax)
        val /= base;
  10059b:	8b 45 dc             	mov    -0x24(%rbp),%eax
  10059e:	48 63 f0             	movslq %eax,%rsi
  1005a1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1005a5:	ba 00 00 00 00       	mov    $0x0,%edx
  1005aa:	48 f7 f6             	div    %rsi
  1005ad:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  1005b1:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  1005b6:	75 bc                	jne    100574 <fill_numbuf+0x38>
    return numbuf_end;
  1005b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1005bc:	c9                   	leave  
  1005bd:	c3                   	ret    

00000000001005be <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1005be:	55                   	push   %rbp
  1005bf:	48 89 e5             	mov    %rsp,%rbp
  1005c2:	53                   	push   %rbx
  1005c3:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  1005ca:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1005d1:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1005d7:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1005de:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1005e5:	e9 8a 09 00 00       	jmp    100f74 <printer_vprintf+0x9b6>
        if (*format != '%') {
  1005ea:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1005f1:	0f b6 00             	movzbl (%rax),%eax
  1005f4:	3c 25                	cmp    $0x25,%al
  1005f6:	74 31                	je     100629 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  1005f8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1005ff:	4c 8b 00             	mov    (%rax),%r8
  100602:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100609:	0f b6 00             	movzbl (%rax),%eax
  10060c:	0f b6 c8             	movzbl %al,%ecx
  10060f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100615:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10061c:	89 ce                	mov    %ecx,%esi
  10061e:	48 89 c7             	mov    %rax,%rdi
  100621:	41 ff d0             	call   *%r8
            continue;
  100624:	e9 43 09 00 00       	jmp    100f6c <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100629:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100630:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100637:	01 
  100638:	eb 44                	jmp    10067e <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  10063a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100641:	0f b6 00             	movzbl (%rax),%eax
  100644:	0f be c0             	movsbl %al,%eax
  100647:	89 c6                	mov    %eax,%esi
  100649:	bf a0 13 10 00       	mov    $0x1013a0,%edi
  10064e:	e8 42 fe ff ff       	call   100495 <strchr>
  100653:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100657:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  10065c:	74 30                	je     10068e <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  10065e:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100662:	48 2d a0 13 10 00    	sub    $0x1013a0,%rax
  100668:	ba 01 00 00 00       	mov    $0x1,%edx
  10066d:	89 c1                	mov    %eax,%ecx
  10066f:	d3 e2                	shl    %cl,%edx
  100671:	89 d0                	mov    %edx,%eax
  100673:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100676:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10067d:	01 
  10067e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100685:	0f b6 00             	movzbl (%rax),%eax
  100688:	84 c0                	test   %al,%al
  10068a:	75 ae                	jne    10063a <printer_vprintf+0x7c>
  10068c:	eb 01                	jmp    10068f <printer_vprintf+0xd1>
            } else {
                break;
  10068e:	90                   	nop
            }
        }

        // process width
        int width = -1;
  10068f:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100696:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10069d:	0f b6 00             	movzbl (%rax),%eax
  1006a0:	3c 30                	cmp    $0x30,%al
  1006a2:	7e 67                	jle    10070b <printer_vprintf+0x14d>
  1006a4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006ab:	0f b6 00             	movzbl (%rax),%eax
  1006ae:	3c 39                	cmp    $0x39,%al
  1006b0:	7f 59                	jg     10070b <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1006b2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  1006b9:	eb 2e                	jmp    1006e9 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  1006bb:	8b 55 e8             	mov    -0x18(%rbp),%edx
  1006be:	89 d0                	mov    %edx,%eax
  1006c0:	c1 e0 02             	shl    $0x2,%eax
  1006c3:	01 d0                	add    %edx,%eax
  1006c5:	01 c0                	add    %eax,%eax
  1006c7:	89 c1                	mov    %eax,%ecx
  1006c9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006d0:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1006d4:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1006db:	0f b6 00             	movzbl (%rax),%eax
  1006de:	0f be c0             	movsbl %al,%eax
  1006e1:	01 c8                	add    %ecx,%eax
  1006e3:	83 e8 30             	sub    $0x30,%eax
  1006e6:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1006e9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006f0:	0f b6 00             	movzbl (%rax),%eax
  1006f3:	3c 2f                	cmp    $0x2f,%al
  1006f5:	0f 8e 85 00 00 00    	jle    100780 <printer_vprintf+0x1c2>
  1006fb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100702:	0f b6 00             	movzbl (%rax),%eax
  100705:	3c 39                	cmp    $0x39,%al
  100707:	7e b2                	jle    1006bb <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100709:	eb 75                	jmp    100780 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  10070b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100712:	0f b6 00             	movzbl (%rax),%eax
  100715:	3c 2a                	cmp    $0x2a,%al
  100717:	75 68                	jne    100781 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100719:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100720:	8b 00                	mov    (%rax),%eax
  100722:	83 f8 2f             	cmp    $0x2f,%eax
  100725:	77 30                	ja     100757 <printer_vprintf+0x199>
  100727:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10072e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100732:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100739:	8b 00                	mov    (%rax),%eax
  10073b:	89 c0                	mov    %eax,%eax
  10073d:	48 01 d0             	add    %rdx,%rax
  100740:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100747:	8b 12                	mov    (%rdx),%edx
  100749:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10074c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100753:	89 0a                	mov    %ecx,(%rdx)
  100755:	eb 1a                	jmp    100771 <printer_vprintf+0x1b3>
  100757:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10075e:	48 8b 40 08          	mov    0x8(%rax),%rax
  100762:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100766:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10076d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100771:	8b 00                	mov    (%rax),%eax
  100773:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100776:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10077d:	01 
  10077e:	eb 01                	jmp    100781 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100780:	90                   	nop
        }

        // process precision
        int precision = -1;
  100781:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100788:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10078f:	0f b6 00             	movzbl (%rax),%eax
  100792:	3c 2e                	cmp    $0x2e,%al
  100794:	0f 85 00 01 00 00    	jne    10089a <printer_vprintf+0x2dc>
            ++format;
  10079a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1007a1:	01 
            if (*format >= '0' && *format <= '9') {
  1007a2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007a9:	0f b6 00             	movzbl (%rax),%eax
  1007ac:	3c 2f                	cmp    $0x2f,%al
  1007ae:	7e 67                	jle    100817 <printer_vprintf+0x259>
  1007b0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007b7:	0f b6 00             	movzbl (%rax),%eax
  1007ba:	3c 39                	cmp    $0x39,%al
  1007bc:	7f 59                	jg     100817 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1007be:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  1007c5:	eb 2e                	jmp    1007f5 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  1007c7:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  1007ca:	89 d0                	mov    %edx,%eax
  1007cc:	c1 e0 02             	shl    $0x2,%eax
  1007cf:	01 d0                	add    %edx,%eax
  1007d1:	01 c0                	add    %eax,%eax
  1007d3:	89 c1                	mov    %eax,%ecx
  1007d5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007dc:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1007e0:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1007e7:	0f b6 00             	movzbl (%rax),%eax
  1007ea:	0f be c0             	movsbl %al,%eax
  1007ed:	01 c8                	add    %ecx,%eax
  1007ef:	83 e8 30             	sub    $0x30,%eax
  1007f2:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1007f5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007fc:	0f b6 00             	movzbl (%rax),%eax
  1007ff:	3c 2f                	cmp    $0x2f,%al
  100801:	0f 8e 85 00 00 00    	jle    10088c <printer_vprintf+0x2ce>
  100807:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10080e:	0f b6 00             	movzbl (%rax),%eax
  100811:	3c 39                	cmp    $0x39,%al
  100813:	7e b2                	jle    1007c7 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100815:	eb 75                	jmp    10088c <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100817:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10081e:	0f b6 00             	movzbl (%rax),%eax
  100821:	3c 2a                	cmp    $0x2a,%al
  100823:	75 68                	jne    10088d <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100825:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10082c:	8b 00                	mov    (%rax),%eax
  10082e:	83 f8 2f             	cmp    $0x2f,%eax
  100831:	77 30                	ja     100863 <printer_vprintf+0x2a5>
  100833:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10083a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10083e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100845:	8b 00                	mov    (%rax),%eax
  100847:	89 c0                	mov    %eax,%eax
  100849:	48 01 d0             	add    %rdx,%rax
  10084c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100853:	8b 12                	mov    (%rdx),%edx
  100855:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100858:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10085f:	89 0a                	mov    %ecx,(%rdx)
  100861:	eb 1a                	jmp    10087d <printer_vprintf+0x2bf>
  100863:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10086a:	48 8b 40 08          	mov    0x8(%rax),%rax
  10086e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100872:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100879:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10087d:	8b 00                	mov    (%rax),%eax
  10087f:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100882:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100889:	01 
  10088a:	eb 01                	jmp    10088d <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  10088c:	90                   	nop
            }
            if (precision < 0) {
  10088d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100891:	79 07                	jns    10089a <printer_vprintf+0x2dc>
                precision = 0;
  100893:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  10089a:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  1008a1:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  1008a8:	00 
        int length = 0;
  1008a9:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  1008b0:	48 c7 45 c8 a6 13 10 	movq   $0x1013a6,-0x38(%rbp)
  1008b7:	00 
    again:
        switch (*format) {
  1008b8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008bf:	0f b6 00             	movzbl (%rax),%eax
  1008c2:	0f be c0             	movsbl %al,%eax
  1008c5:	83 e8 43             	sub    $0x43,%eax
  1008c8:	83 f8 37             	cmp    $0x37,%eax
  1008cb:	0f 87 9f 03 00 00    	ja     100c70 <printer_vprintf+0x6b2>
  1008d1:	89 c0                	mov    %eax,%eax
  1008d3:	48 8b 04 c5 b8 13 10 	mov    0x1013b8(,%rax,8),%rax
  1008da:	00 
  1008db:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  1008dd:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  1008e4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1008eb:	01 
            goto again;
  1008ec:	eb ca                	jmp    1008b8 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1008ee:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1008f2:	74 5d                	je     100951 <printer_vprintf+0x393>
  1008f4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008fb:	8b 00                	mov    (%rax),%eax
  1008fd:	83 f8 2f             	cmp    $0x2f,%eax
  100900:	77 30                	ja     100932 <printer_vprintf+0x374>
  100902:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100909:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10090d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100914:	8b 00                	mov    (%rax),%eax
  100916:	89 c0                	mov    %eax,%eax
  100918:	48 01 d0             	add    %rdx,%rax
  10091b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100922:	8b 12                	mov    (%rdx),%edx
  100924:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100927:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10092e:	89 0a                	mov    %ecx,(%rdx)
  100930:	eb 1a                	jmp    10094c <printer_vprintf+0x38e>
  100932:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100939:	48 8b 40 08          	mov    0x8(%rax),%rax
  10093d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100941:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100948:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10094c:	48 8b 00             	mov    (%rax),%rax
  10094f:	eb 5c                	jmp    1009ad <printer_vprintf+0x3ef>
  100951:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100958:	8b 00                	mov    (%rax),%eax
  10095a:	83 f8 2f             	cmp    $0x2f,%eax
  10095d:	77 30                	ja     10098f <printer_vprintf+0x3d1>
  10095f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100966:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10096a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100971:	8b 00                	mov    (%rax),%eax
  100973:	89 c0                	mov    %eax,%eax
  100975:	48 01 d0             	add    %rdx,%rax
  100978:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10097f:	8b 12                	mov    (%rdx),%edx
  100981:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100984:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10098b:	89 0a                	mov    %ecx,(%rdx)
  10098d:	eb 1a                	jmp    1009a9 <printer_vprintf+0x3eb>
  10098f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100996:	48 8b 40 08          	mov    0x8(%rax),%rax
  10099a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10099e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009a5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1009a9:	8b 00                	mov    (%rax),%eax
  1009ab:	48 98                	cltq   
  1009ad:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  1009b1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1009b5:	48 c1 f8 38          	sar    $0x38,%rax
  1009b9:	25 80 00 00 00       	and    $0x80,%eax
  1009be:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  1009c1:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  1009c5:	74 09                	je     1009d0 <printer_vprintf+0x412>
  1009c7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1009cb:	48 f7 d8             	neg    %rax
  1009ce:	eb 04                	jmp    1009d4 <printer_vprintf+0x416>
  1009d0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1009d4:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  1009d8:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  1009db:	83 c8 60             	or     $0x60,%eax
  1009de:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  1009e1:	e9 cf 02 00 00       	jmp    100cb5 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1009e6:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1009ea:	74 5d                	je     100a49 <printer_vprintf+0x48b>
  1009ec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009f3:	8b 00                	mov    (%rax),%eax
  1009f5:	83 f8 2f             	cmp    $0x2f,%eax
  1009f8:	77 30                	ja     100a2a <printer_vprintf+0x46c>
  1009fa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a01:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a05:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a0c:	8b 00                	mov    (%rax),%eax
  100a0e:	89 c0                	mov    %eax,%eax
  100a10:	48 01 d0             	add    %rdx,%rax
  100a13:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a1a:	8b 12                	mov    (%rdx),%edx
  100a1c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a1f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a26:	89 0a                	mov    %ecx,(%rdx)
  100a28:	eb 1a                	jmp    100a44 <printer_vprintf+0x486>
  100a2a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a31:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a35:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a39:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a40:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a44:	48 8b 00             	mov    (%rax),%rax
  100a47:	eb 5c                	jmp    100aa5 <printer_vprintf+0x4e7>
  100a49:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a50:	8b 00                	mov    (%rax),%eax
  100a52:	83 f8 2f             	cmp    $0x2f,%eax
  100a55:	77 30                	ja     100a87 <printer_vprintf+0x4c9>
  100a57:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a5e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a62:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a69:	8b 00                	mov    (%rax),%eax
  100a6b:	89 c0                	mov    %eax,%eax
  100a6d:	48 01 d0             	add    %rdx,%rax
  100a70:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a77:	8b 12                	mov    (%rdx),%edx
  100a79:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a7c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a83:	89 0a                	mov    %ecx,(%rdx)
  100a85:	eb 1a                	jmp    100aa1 <printer_vprintf+0x4e3>
  100a87:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a8e:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a92:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a96:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a9d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100aa1:	8b 00                	mov    (%rax),%eax
  100aa3:	89 c0                	mov    %eax,%eax
  100aa5:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100aa9:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100aad:	e9 03 02 00 00       	jmp    100cb5 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100ab2:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100ab9:	e9 28 ff ff ff       	jmp    1009e6 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100abe:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100ac5:	e9 1c ff ff ff       	jmp    1009e6 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100aca:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ad1:	8b 00                	mov    (%rax),%eax
  100ad3:	83 f8 2f             	cmp    $0x2f,%eax
  100ad6:	77 30                	ja     100b08 <printer_vprintf+0x54a>
  100ad8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100adf:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ae3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100aea:	8b 00                	mov    (%rax),%eax
  100aec:	89 c0                	mov    %eax,%eax
  100aee:	48 01 d0             	add    %rdx,%rax
  100af1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100af8:	8b 12                	mov    (%rdx),%edx
  100afa:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100afd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b04:	89 0a                	mov    %ecx,(%rdx)
  100b06:	eb 1a                	jmp    100b22 <printer_vprintf+0x564>
  100b08:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b0f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b13:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b17:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b1e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b22:	48 8b 00             	mov    (%rax),%rax
  100b25:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100b29:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100b30:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100b37:	e9 79 01 00 00       	jmp    100cb5 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100b3c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b43:	8b 00                	mov    (%rax),%eax
  100b45:	83 f8 2f             	cmp    $0x2f,%eax
  100b48:	77 30                	ja     100b7a <printer_vprintf+0x5bc>
  100b4a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b51:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b55:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b5c:	8b 00                	mov    (%rax),%eax
  100b5e:	89 c0                	mov    %eax,%eax
  100b60:	48 01 d0             	add    %rdx,%rax
  100b63:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b6a:	8b 12                	mov    (%rdx),%edx
  100b6c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b6f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b76:	89 0a                	mov    %ecx,(%rdx)
  100b78:	eb 1a                	jmp    100b94 <printer_vprintf+0x5d6>
  100b7a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b81:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b85:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b89:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b90:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b94:	48 8b 00             	mov    (%rax),%rax
  100b97:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100b9b:	e9 15 01 00 00       	jmp    100cb5 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100ba0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ba7:	8b 00                	mov    (%rax),%eax
  100ba9:	83 f8 2f             	cmp    $0x2f,%eax
  100bac:	77 30                	ja     100bde <printer_vprintf+0x620>
  100bae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bb5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100bb9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bc0:	8b 00                	mov    (%rax),%eax
  100bc2:	89 c0                	mov    %eax,%eax
  100bc4:	48 01 d0             	add    %rdx,%rax
  100bc7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bce:	8b 12                	mov    (%rdx),%edx
  100bd0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bd3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bda:	89 0a                	mov    %ecx,(%rdx)
  100bdc:	eb 1a                	jmp    100bf8 <printer_vprintf+0x63a>
  100bde:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100be5:	48 8b 40 08          	mov    0x8(%rax),%rax
  100be9:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100bed:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bf4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100bf8:	8b 00                	mov    (%rax),%eax
  100bfa:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100c00:	e9 67 03 00 00       	jmp    100f6c <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  100c05:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100c09:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100c0d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c14:	8b 00                	mov    (%rax),%eax
  100c16:	83 f8 2f             	cmp    $0x2f,%eax
  100c19:	77 30                	ja     100c4b <printer_vprintf+0x68d>
  100c1b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c22:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c26:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c2d:	8b 00                	mov    (%rax),%eax
  100c2f:	89 c0                	mov    %eax,%eax
  100c31:	48 01 d0             	add    %rdx,%rax
  100c34:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c3b:	8b 12                	mov    (%rdx),%edx
  100c3d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c40:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c47:	89 0a                	mov    %ecx,(%rdx)
  100c49:	eb 1a                	jmp    100c65 <printer_vprintf+0x6a7>
  100c4b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c52:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c56:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c5a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c61:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c65:	8b 00                	mov    (%rax),%eax
  100c67:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100c6a:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100c6e:	eb 45                	jmp    100cb5 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  100c70:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100c74:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100c78:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c7f:	0f b6 00             	movzbl (%rax),%eax
  100c82:	84 c0                	test   %al,%al
  100c84:	74 0c                	je     100c92 <printer_vprintf+0x6d4>
  100c86:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c8d:	0f b6 00             	movzbl (%rax),%eax
  100c90:	eb 05                	jmp    100c97 <printer_vprintf+0x6d9>
  100c92:	b8 25 00 00 00       	mov    $0x25,%eax
  100c97:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100c9a:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100c9e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ca5:	0f b6 00             	movzbl (%rax),%eax
  100ca8:	84 c0                	test   %al,%al
  100caa:	75 08                	jne    100cb4 <printer_vprintf+0x6f6>
                format--;
  100cac:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100cb3:	01 
            }
            break;
  100cb4:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100cb5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cb8:	83 e0 20             	and    $0x20,%eax
  100cbb:	85 c0                	test   %eax,%eax
  100cbd:	74 1e                	je     100cdd <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100cbf:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100cc3:	48 83 c0 18          	add    $0x18,%rax
  100cc7:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100cca:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100cce:	48 89 ce             	mov    %rcx,%rsi
  100cd1:	48 89 c7             	mov    %rax,%rdi
  100cd4:	e8 63 f8 ff ff       	call   10053c <fill_numbuf>
  100cd9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100cdd:	48 c7 45 c0 a6 13 10 	movq   $0x1013a6,-0x40(%rbp)
  100ce4:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100ce5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ce8:	83 e0 20             	and    $0x20,%eax
  100ceb:	85 c0                	test   %eax,%eax
  100ced:	74 48                	je     100d37 <printer_vprintf+0x779>
  100cef:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cf2:	83 e0 40             	and    $0x40,%eax
  100cf5:	85 c0                	test   %eax,%eax
  100cf7:	74 3e                	je     100d37 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  100cf9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cfc:	25 80 00 00 00       	and    $0x80,%eax
  100d01:	85 c0                	test   %eax,%eax
  100d03:	74 0a                	je     100d0f <printer_vprintf+0x751>
                prefix = "-";
  100d05:	48 c7 45 c0 a7 13 10 	movq   $0x1013a7,-0x40(%rbp)
  100d0c:	00 
            if (flags & FLAG_NEGATIVE) {
  100d0d:	eb 73                	jmp    100d82 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100d0f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d12:	83 e0 10             	and    $0x10,%eax
  100d15:	85 c0                	test   %eax,%eax
  100d17:	74 0a                	je     100d23 <printer_vprintf+0x765>
                prefix = "+";
  100d19:	48 c7 45 c0 a9 13 10 	movq   $0x1013a9,-0x40(%rbp)
  100d20:	00 
            if (flags & FLAG_NEGATIVE) {
  100d21:	eb 5f                	jmp    100d82 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100d23:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d26:	83 e0 08             	and    $0x8,%eax
  100d29:	85 c0                	test   %eax,%eax
  100d2b:	74 55                	je     100d82 <printer_vprintf+0x7c4>
                prefix = " ";
  100d2d:	48 c7 45 c0 ab 13 10 	movq   $0x1013ab,-0x40(%rbp)
  100d34:	00 
            if (flags & FLAG_NEGATIVE) {
  100d35:	eb 4b                	jmp    100d82 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100d37:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d3a:	83 e0 20             	and    $0x20,%eax
  100d3d:	85 c0                	test   %eax,%eax
  100d3f:	74 42                	je     100d83 <printer_vprintf+0x7c5>
  100d41:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d44:	83 e0 01             	and    $0x1,%eax
  100d47:	85 c0                	test   %eax,%eax
  100d49:	74 38                	je     100d83 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  100d4b:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100d4f:	74 06                	je     100d57 <printer_vprintf+0x799>
  100d51:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100d55:	75 2c                	jne    100d83 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  100d57:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100d5c:	75 0c                	jne    100d6a <printer_vprintf+0x7ac>
  100d5e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d61:	25 00 01 00 00       	and    $0x100,%eax
  100d66:	85 c0                	test   %eax,%eax
  100d68:	74 19                	je     100d83 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  100d6a:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100d6e:	75 07                	jne    100d77 <printer_vprintf+0x7b9>
  100d70:	b8 ad 13 10 00       	mov    $0x1013ad,%eax
  100d75:	eb 05                	jmp    100d7c <printer_vprintf+0x7be>
  100d77:	b8 b0 13 10 00       	mov    $0x1013b0,%eax
  100d7c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100d80:	eb 01                	jmp    100d83 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  100d82:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100d83:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100d87:	78 24                	js     100dad <printer_vprintf+0x7ef>
  100d89:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d8c:	83 e0 20             	and    $0x20,%eax
  100d8f:	85 c0                	test   %eax,%eax
  100d91:	75 1a                	jne    100dad <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  100d93:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100d96:	48 63 d0             	movslq %eax,%rdx
  100d99:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100d9d:	48 89 d6             	mov    %rdx,%rsi
  100da0:	48 89 c7             	mov    %rax,%rdi
  100da3:	e8 ea f5 ff ff       	call   100392 <strnlen>
  100da8:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100dab:	eb 0f                	jmp    100dbc <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  100dad:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100db1:	48 89 c7             	mov    %rax,%rdi
  100db4:	e8 a8 f5 ff ff       	call   100361 <strlen>
  100db9:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100dbc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dbf:	83 e0 20             	and    $0x20,%eax
  100dc2:	85 c0                	test   %eax,%eax
  100dc4:	74 20                	je     100de6 <printer_vprintf+0x828>
  100dc6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100dca:	78 1a                	js     100de6 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  100dcc:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100dcf:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100dd2:	7e 08                	jle    100ddc <printer_vprintf+0x81e>
  100dd4:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100dd7:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100dda:	eb 05                	jmp    100de1 <printer_vprintf+0x823>
  100ddc:	b8 00 00 00 00       	mov    $0x0,%eax
  100de1:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100de4:	eb 5c                	jmp    100e42 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100de6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100de9:	83 e0 20             	and    $0x20,%eax
  100dec:	85 c0                	test   %eax,%eax
  100dee:	74 4b                	je     100e3b <printer_vprintf+0x87d>
  100df0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100df3:	83 e0 02             	and    $0x2,%eax
  100df6:	85 c0                	test   %eax,%eax
  100df8:	74 41                	je     100e3b <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100dfa:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dfd:	83 e0 04             	and    $0x4,%eax
  100e00:	85 c0                	test   %eax,%eax
  100e02:	75 37                	jne    100e3b <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  100e04:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e08:	48 89 c7             	mov    %rax,%rdi
  100e0b:	e8 51 f5 ff ff       	call   100361 <strlen>
  100e10:	89 c2                	mov    %eax,%edx
  100e12:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100e15:	01 d0                	add    %edx,%eax
  100e17:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100e1a:	7e 1f                	jle    100e3b <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  100e1c:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100e1f:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100e22:	89 c3                	mov    %eax,%ebx
  100e24:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e28:	48 89 c7             	mov    %rax,%rdi
  100e2b:	e8 31 f5 ff ff       	call   100361 <strlen>
  100e30:	89 c2                	mov    %eax,%edx
  100e32:	89 d8                	mov    %ebx,%eax
  100e34:	29 d0                	sub    %edx,%eax
  100e36:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100e39:	eb 07                	jmp    100e42 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  100e3b:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100e42:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100e45:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100e48:	01 d0                	add    %edx,%eax
  100e4a:	48 63 d8             	movslq %eax,%rbx
  100e4d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e51:	48 89 c7             	mov    %rax,%rdi
  100e54:	e8 08 f5 ff ff       	call   100361 <strlen>
  100e59:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100e5d:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100e60:	29 d0                	sub    %edx,%eax
  100e62:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100e65:	eb 25                	jmp    100e8c <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  100e67:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e6e:	48 8b 08             	mov    (%rax),%rcx
  100e71:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100e77:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e7e:	be 20 00 00 00       	mov    $0x20,%esi
  100e83:	48 89 c7             	mov    %rax,%rdi
  100e86:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100e88:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100e8c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e8f:	83 e0 04             	and    $0x4,%eax
  100e92:	85 c0                	test   %eax,%eax
  100e94:	75 36                	jne    100ecc <printer_vprintf+0x90e>
  100e96:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100e9a:	7f cb                	jg     100e67 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  100e9c:	eb 2e                	jmp    100ecc <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  100e9e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ea5:	4c 8b 00             	mov    (%rax),%r8
  100ea8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100eac:	0f b6 00             	movzbl (%rax),%eax
  100eaf:	0f b6 c8             	movzbl %al,%ecx
  100eb2:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100eb8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ebf:	89 ce                	mov    %ecx,%esi
  100ec1:	48 89 c7             	mov    %rax,%rdi
  100ec4:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  100ec7:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  100ecc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100ed0:	0f b6 00             	movzbl (%rax),%eax
  100ed3:	84 c0                	test   %al,%al
  100ed5:	75 c7                	jne    100e9e <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  100ed7:	eb 25                	jmp    100efe <printer_vprintf+0x940>
            p->putc(p, '0', color);
  100ed9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ee0:	48 8b 08             	mov    (%rax),%rcx
  100ee3:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100ee9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ef0:	be 30 00 00 00       	mov    $0x30,%esi
  100ef5:	48 89 c7             	mov    %rax,%rdi
  100ef8:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  100efa:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  100efe:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  100f02:	7f d5                	jg     100ed9 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  100f04:	eb 32                	jmp    100f38 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  100f06:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f0d:	4c 8b 00             	mov    (%rax),%r8
  100f10:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100f14:	0f b6 00             	movzbl (%rax),%eax
  100f17:	0f b6 c8             	movzbl %al,%ecx
  100f1a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f20:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f27:	89 ce                	mov    %ecx,%esi
  100f29:	48 89 c7             	mov    %rax,%rdi
  100f2c:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  100f2f:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  100f34:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  100f38:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  100f3c:	7f c8                	jg     100f06 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  100f3e:	eb 25                	jmp    100f65 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  100f40:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f47:	48 8b 08             	mov    (%rax),%rcx
  100f4a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f50:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f57:	be 20 00 00 00       	mov    $0x20,%esi
  100f5c:	48 89 c7             	mov    %rax,%rdi
  100f5f:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  100f61:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100f65:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100f69:	7f d5                	jg     100f40 <printer_vprintf+0x982>
        }
    done: ;
  100f6b:	90                   	nop
    for (; *format; ++format) {
  100f6c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100f73:	01 
  100f74:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f7b:	0f b6 00             	movzbl (%rax),%eax
  100f7e:	84 c0                	test   %al,%al
  100f80:	0f 85 64 f6 ff ff    	jne    1005ea <printer_vprintf+0x2c>
    }
}
  100f86:	90                   	nop
  100f87:	90                   	nop
  100f88:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100f8c:	c9                   	leave  
  100f8d:	c3                   	ret    

0000000000100f8e <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100f8e:	55                   	push   %rbp
  100f8f:	48 89 e5             	mov    %rsp,%rbp
  100f92:	48 83 ec 20          	sub    $0x20,%rsp
  100f96:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100f9a:	89 f0                	mov    %esi,%eax
  100f9c:	89 55 e0             	mov    %edx,-0x20(%rbp)
  100f9f:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  100fa2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100fa6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100faa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100fae:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fb2:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  100fb7:	48 39 d0             	cmp    %rdx,%rax
  100fba:	72 0c                	jb     100fc8 <console_putc+0x3a>
        cp->cursor = console;
  100fbc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100fc0:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  100fc7:	00 
    }
    if (c == '\n') {
  100fc8:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  100fcc:	75 78                	jne    101046 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  100fce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100fd2:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fd6:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  100fdc:	48 d1 f8             	sar    %rax
  100fdf:	48 89 c1             	mov    %rax,%rcx
  100fe2:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  100fe9:	66 66 66 
  100fec:	48 89 c8             	mov    %rcx,%rax
  100fef:	48 f7 ea             	imul   %rdx
  100ff2:	48 c1 fa 05          	sar    $0x5,%rdx
  100ff6:	48 89 c8             	mov    %rcx,%rax
  100ff9:	48 c1 f8 3f          	sar    $0x3f,%rax
  100ffd:	48 29 c2             	sub    %rax,%rdx
  101000:	48 89 d0             	mov    %rdx,%rax
  101003:	48 c1 e0 02          	shl    $0x2,%rax
  101007:	48 01 d0             	add    %rdx,%rax
  10100a:	48 c1 e0 04          	shl    $0x4,%rax
  10100e:	48 29 c1             	sub    %rax,%rcx
  101011:	48 89 ca             	mov    %rcx,%rdx
  101014:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101017:	eb 25                	jmp    10103e <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  101019:	8b 45 e0             	mov    -0x20(%rbp),%eax
  10101c:	83 c8 20             	or     $0x20,%eax
  10101f:	89 c6                	mov    %eax,%esi
  101021:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101025:	48 8b 40 08          	mov    0x8(%rax),%rax
  101029:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10102d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101031:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101035:	89 f2                	mov    %esi,%edx
  101037:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  10103a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10103e:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101042:	75 d5                	jne    101019 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101044:	eb 24                	jmp    10106a <console_putc+0xdc>
        *cp->cursor++ = c | color;
  101046:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  10104a:	8b 55 e0             	mov    -0x20(%rbp),%edx
  10104d:	09 d0                	or     %edx,%eax
  10104f:	89 c6                	mov    %eax,%esi
  101051:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101055:	48 8b 40 08          	mov    0x8(%rax),%rax
  101059:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10105d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101061:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101065:	89 f2                	mov    %esi,%edx
  101067:	66 89 10             	mov    %dx,(%rax)
}
  10106a:	90                   	nop
  10106b:	c9                   	leave  
  10106c:	c3                   	ret    

000000000010106d <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  10106d:	55                   	push   %rbp
  10106e:	48 89 e5             	mov    %rsp,%rbp
  101071:	48 83 ec 30          	sub    $0x30,%rsp
  101075:	89 7d ec             	mov    %edi,-0x14(%rbp)
  101078:	89 75 e8             	mov    %esi,-0x18(%rbp)
  10107b:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  10107f:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  101083:	48 c7 45 f0 8e 0f 10 	movq   $0x100f8e,-0x10(%rbp)
  10108a:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10108b:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  10108f:	78 09                	js     10109a <console_vprintf+0x2d>
  101091:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101098:	7e 07                	jle    1010a1 <console_vprintf+0x34>
        cpos = 0;
  10109a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  1010a1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010a4:	48 98                	cltq   
  1010a6:	48 01 c0             	add    %rax,%rax
  1010a9:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  1010af:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1010b3:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1010b7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1010bb:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1010be:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  1010c2:	48 89 c7             	mov    %rax,%rdi
  1010c5:	e8 f4 f4 ff ff       	call   1005be <printer_vprintf>
    return cp.cursor - console;
  1010ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1010ce:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1010d4:	48 d1 f8             	sar    %rax
}
  1010d7:	c9                   	leave  
  1010d8:	c3                   	ret    

00000000001010d9 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  1010d9:	55                   	push   %rbp
  1010da:	48 89 e5             	mov    %rsp,%rbp
  1010dd:	48 83 ec 60          	sub    $0x60,%rsp
  1010e1:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1010e4:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1010e7:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1010eb:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1010ef:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1010f3:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1010f7:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1010fe:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101102:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101106:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10110a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  10110e:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101112:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101116:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101119:	8b 45 ac             	mov    -0x54(%rbp),%eax
  10111c:	89 c7                	mov    %eax,%edi
  10111e:	e8 4a ff ff ff       	call   10106d <console_vprintf>
  101123:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101126:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101129:	c9                   	leave  
  10112a:	c3                   	ret    

000000000010112b <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  10112b:	55                   	push   %rbp
  10112c:	48 89 e5             	mov    %rsp,%rbp
  10112f:	48 83 ec 20          	sub    $0x20,%rsp
  101133:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101137:	89 f0                	mov    %esi,%eax
  101139:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10113c:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  10113f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101143:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101147:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10114b:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10114f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101153:	48 8b 40 10          	mov    0x10(%rax),%rax
  101157:	48 39 c2             	cmp    %rax,%rdx
  10115a:	73 1a                	jae    101176 <string_putc+0x4b>
        *sp->s++ = c;
  10115c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101160:	48 8b 40 08          	mov    0x8(%rax),%rax
  101164:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101168:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10116c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101170:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101174:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101176:	90                   	nop
  101177:	c9                   	leave  
  101178:	c3                   	ret    

0000000000101179 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101179:	55                   	push   %rbp
  10117a:	48 89 e5             	mov    %rsp,%rbp
  10117d:	48 83 ec 40          	sub    $0x40,%rsp
  101181:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101185:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101189:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  10118d:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101191:	48 c7 45 e8 2b 11 10 	movq   $0x10112b,-0x18(%rbp)
  101198:	00 
    sp.s = s;
  101199:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10119d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1011a1:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1011a6:	74 33                	je     1011db <vsnprintf+0x62>
        sp.end = s + size - 1;
  1011a8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1011ac:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1011b0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1011b4:	48 01 d0             	add    %rdx,%rax
  1011b7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1011bb:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1011bf:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1011c3:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1011c7:	be 00 00 00 00       	mov    $0x0,%esi
  1011cc:	48 89 c7             	mov    %rax,%rdi
  1011cf:	e8 ea f3 ff ff       	call   1005be <printer_vprintf>
        *sp.s = 0;
  1011d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011d8:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1011db:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011df:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1011e3:	c9                   	leave  
  1011e4:	c3                   	ret    

00000000001011e5 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1011e5:	55                   	push   %rbp
  1011e6:	48 89 e5             	mov    %rsp,%rbp
  1011e9:	48 83 ec 70          	sub    $0x70,%rsp
  1011ed:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1011f1:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1011f5:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1011f9:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1011fd:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101201:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101205:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  10120c:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101210:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101214:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101218:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  10121c:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101220:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101224:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101228:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10122c:	48 89 c7             	mov    %rax,%rdi
  10122f:	e8 45 ff ff ff       	call   101179 <vsnprintf>
  101234:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101237:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  10123a:	c9                   	leave  
  10123b:	c3                   	ret    

000000000010123c <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  10123c:	55                   	push   %rbp
  10123d:	48 89 e5             	mov    %rsp,%rbp
  101240:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101244:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  10124b:	eb 13                	jmp    101260 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  10124d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  101250:	48 98                	cltq   
  101252:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  101259:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10125c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101260:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101267:	7e e4                	jle    10124d <console_clear+0x11>
    }
    cursorpos = 0;
  101269:	c7 05 89 7d fb ff 00 	movl   $0x0,-0x48277(%rip)        # b8ffc <cursorpos>
  101270:	00 00 00 
}
  101273:	90                   	nop
  101274:	c9                   	leave  
  101275:	c3                   	ret    
