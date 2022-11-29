
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <write_page>:
#define MULT   0x000B0000

// write to entire page with `value`
void write_page(uint8_t *addr, uint32_t value){
    uint32_t * int_addr = (uint32_t *) addr;
    for(unsigned long i = 0 ; i < PAGESIZE/sizeof(uint32_t) ; i++){
  100000:	48 89 f8             	mov    %rdi,%rax
  100003:	48 8d 97 00 10 00 00 	lea    0x1000(%rdi),%rdx
        int_addr[i] = value;
  10000a:	89 30                	mov    %esi,(%rax)
    for(unsigned long i = 0 ; i < PAGESIZE/sizeof(uint32_t) ; i++){
  10000c:	48 83 c0 04          	add    $0x4,%rax
  100010:	48 39 d0             	cmp    %rdx,%rax
  100013:	75 f5                	jne    10000a <write_page+0xa>
    }
}
  100015:	c3                   	ret    

0000000000100016 <assert_page>:

// check if enter page contains `value`
void assert_page(uint8_t * addr, uint32_t value){
    uint32_t * int_addr = (uint32_t *) addr;
    for(unsigned long i = 0 ; i < PAGESIZE/sizeof(uint32_t) ; i++){
  100016:	48 89 f8             	mov    %rdi,%rax
  100019:	48 8d 97 00 10 00 00 	lea    0x1000(%rdi),%rdx
        assert(int_addr[i] == value && "Error: page was corrupted!");
  100020:	39 30                	cmp    %esi,(%rax)
  100022:	75 0a                	jne    10002e <assert_page+0x18>
    for(unsigned long i = 0 ; i < PAGESIZE/sizeof(uint32_t) ; i++){
  100024:	48 83 c0 04          	add    $0x4,%rax
  100028:	48 39 d0             	cmp    %rdx,%rax
  10002b:	75 f3                	jne    100020 <assert_page+0xa>
  10002d:	c3                   	ret    
void assert_page(uint8_t * addr, uint32_t value){
  10002e:	55                   	push   %rbp
  10002f:	48 89 e5             	mov    %rsp,%rbp
        assert(int_addr[i] == value && "Error: page was corrupted!");
  100032:	ba 10 13 10 00       	mov    $0x101310,%edx
  100037:	be 1a 00 00 00       	mov    $0x1a,%esi
  10003c:	bf 45 13 10 00       	mov    $0x101345,%edi
  100041:	e8 3a 02 00 00       	call   100280 <assert_fail>

0000000000100046 <process_main>:
}

// Behaves similar to p-allocator.c, except it writes to the entire page
// and checks if the memory was untouched

void process_main(void) {
  100046:	55                   	push   %rbp
  100047:	48 89 e5             	mov    %rsp,%rbp
  10004a:	41 55                	push   %r13
  10004c:	41 54                	push   %r12
  10004e:	53                   	push   %rbx
  10004f:	48 83 ec 08          	sub    $0x8,%rsp

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100053:	cd 31                	int    $0x31
  100055:	41 89 c4             	mov    %eax,%r12d
    pid_t p = sys_getpid();
    srand(p);
  100058:	89 c7                	mov    %eax,%edi
  10005a:	e8 47 05 00 00       	call   1005a6 <srand>

    // The heap starts on the page right after the 'end' symbol,
    // whose address is the first address not allocated to process code
    // or data.
    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10005f:	bb 17 30 10 00       	mov    $0x103017,%ebx
  100064:	48 81 e3 00 f0 ff ff 	and    $0xfffffffffffff000,%rbx
  10006b:	48 89 1d 96 1f 00 00 	mov    %rbx,0x1f96(%rip)        # 102008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100072:	48 89 e0             	mov    %rsp,%rax
    uint8_t * heap_end = heap_top;

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100075:	48 83 e8 01          	sub    $0x1,%rax
  100079:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10007f:	48 89 05 7a 1f 00 00 	mov    %rax,0x1f7a(%rip)        # 102000 <stack_bottom>
        if ((rand() % ALLOC_SLOWDOWN) < p) {
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
                break;
            }
            // write with random canary and process ID based unique value to check later
            write_page(heap_top, CANARY + p * MULT); 
  100086:	45 69 ec 00 00 0b 00 	imul   $0xb0000,%r12d,%r13d
  10008d:	41 81 ed 11 41 52 21 	sub    $0x21524111,%r13d
  100094:	eb 37                	jmp    1000cd <process_main+0x87>
            heap_top += PAGESIZE;
        }
        sys_yield();
    }
    //check all addresses so far
    while(heap_end < heap_top){
  100096:	4c 8b 2d 6b 1f 00 00 	mov    0x1f6b(%rip),%r13        # 102008 <heap_top>
  10009d:	4c 39 eb             	cmp    %r13,%rbx
  1000a0:	73 25                	jae    1000c7 <process_main+0x81>
        // for all alloc'd pages, check if page still contains same value
        assert_page(heap_end, CANARY + p * MULT);
  1000a2:	45 69 e4 00 00 0b 00 	imul   $0xb0000,%r12d,%r12d
  1000a9:	41 81 ec 11 41 52 21 	sub    $0x21524111,%r12d
  1000b0:	44 89 e6             	mov    %r12d,%esi
  1000b3:	48 89 df             	mov    %rbx,%rdi
  1000b6:	e8 5b ff ff ff       	call   100016 <assert_page>
        heap_end += PAGESIZE;
  1000bb:	48 81 c3 00 10 00 00 	add    $0x1000,%rbx
    while(heap_end < heap_top){
  1000c2:	4c 39 eb             	cmp    %r13,%rbx
  1000c5:	72 e9                	jb     1000b0 <process_main+0x6a>

// sys_yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void sys_yield(void) {
    asm volatile ("int %0" : /* no result */
  1000c7:	cd 32                	int    $0x32
  1000c9:	eb fc                	jmp    1000c7 <process_main+0x81>
  1000cb:	cd 32                	int    $0x32
        if ((rand() % ALLOC_SLOWDOWN) < p) {
  1000cd:	e8 98 04 00 00       	call   10056a <rand>
  1000d2:	48 63 d0             	movslq %eax,%rdx
  1000d5:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  1000dc:	48 c1 fa 25          	sar    $0x25,%rdx
  1000e0:	89 c1                	mov    %eax,%ecx
  1000e2:	c1 f9 1f             	sar    $0x1f,%ecx
  1000e5:	29 ca                	sub    %ecx,%edx
  1000e7:	6b d2 64             	imul   $0x64,%edx,%edx
  1000ea:	29 d0                	sub    %edx,%eax
  1000ec:	44 39 e0             	cmp    %r12d,%eax
  1000ef:	7d da                	jge    1000cb <process_main+0x85>
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
  1000f1:	48 8b 3d 10 1f 00 00 	mov    0x1f10(%rip),%rdi        # 102008 <heap_top>
  1000f8:	48 3b 3d 01 1f 00 00 	cmp    0x1f01(%rip),%rdi        # 102000 <stack_bottom>
  1000ff:	74 95                	je     100096 <process_main+0x50>
//    PAGESIZE == 4096). Returns 0 on success and -1 on failure.
//
//    inline assembly explained here: https://www.ibiblio.org/gferg/ldp/GCC-Inline-Assembly-HOWTO.html
static inline int sys_page_alloc(void* addr) {
    int result;
    asm volatile ("int %1"		// generates a "INT_SYS_PAGE_ALLOC" type interrupt 
  100101:	cd 33                	int    $0x33
  100103:	85 c0                	test   %eax,%eax
  100105:	78 8f                	js     100096 <process_main+0x50>
            write_page(heap_top, CANARY + p * MULT); 
  100107:	44 89 ee             	mov    %r13d,%esi
  10010a:	48 8b 3d f7 1e 00 00 	mov    0x1ef7(%rip),%rdi        # 102008 <heap_top>
  100111:	e8 ea fe ff ff       	call   100000 <write_page>
            heap_top += PAGESIZE;
  100116:	48 81 05 e7 1e 00 00 	addq   $0x1000,0x1ee7(%rip)        # 102008 <heap_top>
  10011d:	00 10 00 00 
  100121:	eb a8                	jmp    1000cb <process_main+0x85>

0000000000100123 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100123:	55                   	push   %rbp
  100124:	48 89 e5             	mov    %rsp,%rbp
  100127:	48 83 ec 50          	sub    $0x50,%rsp
  10012b:	49 89 f2             	mov    %rsi,%r10
  10012e:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100132:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100136:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10013a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  10013e:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100143:	85 ff                	test   %edi,%edi
  100145:	78 2e                	js     100175 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  100147:	48 63 ff             	movslq %edi,%rdi
  10014a:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  100151:	cc cc cc 
  100154:	48 89 f8             	mov    %rdi,%rax
  100157:	48 f7 e2             	mul    %rdx
  10015a:	48 89 d0             	mov    %rdx,%rax
  10015d:	48 c1 e8 02          	shr    $0x2,%rax
  100161:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  100165:	48 01 c2             	add    %rax,%rdx
  100168:	48 29 d7             	sub    %rdx,%rdi
  10016b:	0f b6 b7 8d 13 10 00 	movzbl 0x10138d(%rdi),%esi
  100172:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  100175:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  10017c:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100180:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100184:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100188:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  10018c:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100190:	4c 89 d2             	mov    %r10,%rdx
  100193:	8b 3d 63 8e fb ff    	mov    -0x4719d(%rip),%edi        # b8ffc <cursorpos>
  100199:	e8 5a 0f 00 00       	call   1010f8 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  10019e:	3d 30 07 00 00       	cmp    $0x730,%eax
  1001a3:	ba 00 00 00 00       	mov    $0x0,%edx
  1001a8:	0f 4d c2             	cmovge %edx,%eax
  1001ab:	89 05 4b 8e fb ff    	mov    %eax,-0x471b5(%rip)        # b8ffc <cursorpos>
    }
}
  1001b1:	c9                   	leave  
  1001b2:	c3                   	ret    

00000000001001b3 <panic>:


// panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
  1001b3:	55                   	push   %rbp
  1001b4:	48 89 e5             	mov    %rsp,%rbp
  1001b7:	53                   	push   %rbx
  1001b8:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  1001bf:	48 89 fb             	mov    %rdi,%rbx
  1001c2:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  1001c6:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  1001ca:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  1001ce:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  1001d2:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  1001d6:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  1001dd:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1001e1:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  1001e5:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  1001e9:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  1001ed:	ba 07 00 00 00       	mov    $0x7,%edx
  1001f2:	be 55 13 10 00       	mov    $0x101355,%esi
  1001f7:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  1001fe:	e8 ac 00 00 00       	call   1002af <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100203:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100207:	48 89 da             	mov    %rbx,%rdx
  10020a:	be 99 00 00 00       	mov    $0x99,%esi
  10020f:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100216:	e8 e9 0f 00 00       	call   101204 <vsnprintf>
  10021b:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  10021e:	85 d2                	test   %edx,%edx
  100220:	7e 0f                	jle    100231 <panic+0x7e>
  100222:	83 c0 06             	add    $0x6,%eax
  100225:	48 98                	cltq   
  100227:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  10022e:	0a 
  10022f:	75 29                	jne    10025a <panic+0xa7>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  100231:	48 8d 8d 08 ff ff ff 	lea    -0xf8(%rbp),%rcx
  100238:	ba 5f 13 10 00       	mov    $0x10135f,%edx
  10023d:	be 00 c0 00 00       	mov    $0xc000,%esi
  100242:	bf 30 07 00 00       	mov    $0x730,%edi
  100247:	b8 00 00 00 00       	mov    $0x0,%eax
  10024c:	e8 13 0f 00 00       	call   101164 <console_printf>
}

// sys_panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) sys_panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  100251:	bf 00 00 00 00       	mov    $0x0,%edi
  100256:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  100258:	eb fe                	jmp    100258 <panic+0xa5>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  10025a:	48 63 c2             	movslq %edx,%rax
  10025d:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  100263:	0f 94 c2             	sete   %dl
  100266:	0f b6 d2             	movzbl %dl,%edx
  100269:	48 29 d0             	sub    %rdx,%rax
  10026c:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  100273:	ff 
  100274:	be 5d 13 10 00       	mov    $0x10135d,%esi
  100279:	e8 de 01 00 00       	call   10045c <strcpy>
  10027e:	eb b1                	jmp    100231 <panic+0x7e>

0000000000100280 <assert_fail>:
    sys_panic(NULL);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  100280:	55                   	push   %rbp
  100281:	48 89 e5             	mov    %rsp,%rbp
  100284:	48 89 f9             	mov    %rdi,%rcx
  100287:	41 89 f0             	mov    %esi,%r8d
  10028a:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  10028d:	ba 68 13 10 00       	mov    $0x101368,%edx
  100292:	be 00 c0 00 00       	mov    $0xc000,%esi
  100297:	bf 30 07 00 00       	mov    $0x730,%edi
  10029c:	b8 00 00 00 00       	mov    $0x0,%eax
  1002a1:	e8 be 0e 00 00       	call   101164 <console_printf>
    asm volatile ("int %0" : /* no result */
  1002a6:	bf 00 00 00 00       	mov    $0x0,%edi
  1002ab:	cd 30                	int    $0x30
 loop: goto loop;
  1002ad:	eb fe                	jmp    1002ad <assert_fail+0x2d>

00000000001002af <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  1002af:	55                   	push   %rbp
  1002b0:	48 89 e5             	mov    %rsp,%rbp
  1002b3:	48 83 ec 28          	sub    $0x28,%rsp
  1002b7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1002bb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1002bf:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1002c3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1002c7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1002cb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1002cf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  1002d3:	eb 1c                	jmp    1002f1 <memcpy+0x42>
        *d = *s;
  1002d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002d9:	0f b6 10             	movzbl (%rax),%edx
  1002dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1002e0:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1002e2:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1002e7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1002ec:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1002f1:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1002f6:	75 dd                	jne    1002d5 <memcpy+0x26>
    }
    return dst;
  1002f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1002fc:	c9                   	leave  
  1002fd:	c3                   	ret    

00000000001002fe <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1002fe:	55                   	push   %rbp
  1002ff:	48 89 e5             	mov    %rsp,%rbp
  100302:	48 83 ec 28          	sub    $0x28,%rsp
  100306:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10030a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10030e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100312:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100316:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  10031a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10031e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100322:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100326:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  10032a:	73 6a                	jae    100396 <memmove+0x98>
  10032c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100330:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100334:	48 01 d0             	add    %rdx,%rax
  100337:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  10033b:	73 59                	jae    100396 <memmove+0x98>
        s += n, d += n;
  10033d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100341:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100345:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100349:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  10034d:	eb 17                	jmp    100366 <memmove+0x68>
            *--d = *--s;
  10034f:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100354:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100359:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10035d:	0f b6 10             	movzbl (%rax),%edx
  100360:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100364:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100366:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10036a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10036e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100372:	48 85 c0             	test   %rax,%rax
  100375:	75 d8                	jne    10034f <memmove+0x51>
    if (s < d && s + n > d) {
  100377:	eb 2e                	jmp    1003a7 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100379:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10037d:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100381:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100385:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100389:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10038d:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100391:	0f b6 12             	movzbl (%rdx),%edx
  100394:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100396:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10039a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10039e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1003a2:	48 85 c0             	test   %rax,%rax
  1003a5:	75 d2                	jne    100379 <memmove+0x7b>
        }
    }
    return dst;
  1003a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1003ab:	c9                   	leave  
  1003ac:	c3                   	ret    

00000000001003ad <memset>:

void* memset(void* v, int c, size_t n) {
  1003ad:	55                   	push   %rbp
  1003ae:	48 89 e5             	mov    %rsp,%rbp
  1003b1:	48 83 ec 28          	sub    $0x28,%rsp
  1003b5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1003b9:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  1003bc:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1003c0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1003c4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1003c8:	eb 15                	jmp    1003df <memset+0x32>
        *p = c;
  1003ca:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1003cd:	89 c2                	mov    %eax,%edx
  1003cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003d3:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1003d5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1003da:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1003df:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1003e4:	75 e4                	jne    1003ca <memset+0x1d>
    }
    return v;
  1003e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1003ea:	c9                   	leave  
  1003eb:	c3                   	ret    

00000000001003ec <strlen>:

size_t strlen(const char* s) {
  1003ec:	55                   	push   %rbp
  1003ed:	48 89 e5             	mov    %rsp,%rbp
  1003f0:	48 83 ec 18          	sub    $0x18,%rsp
  1003f4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  1003f8:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1003ff:	00 
  100400:	eb 0a                	jmp    10040c <strlen+0x20>
        ++n;
  100402:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100407:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  10040c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100410:	0f b6 00             	movzbl (%rax),%eax
  100413:	84 c0                	test   %al,%al
  100415:	75 eb                	jne    100402 <strlen+0x16>
    }
    return n;
  100417:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  10041b:	c9                   	leave  
  10041c:	c3                   	ret    

000000000010041d <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  10041d:	55                   	push   %rbp
  10041e:	48 89 e5             	mov    %rsp,%rbp
  100421:	48 83 ec 20          	sub    $0x20,%rsp
  100425:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100429:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  10042d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100434:	00 
  100435:	eb 0a                	jmp    100441 <strnlen+0x24>
        ++n;
  100437:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  10043c:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100441:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100445:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100449:	74 0b                	je     100456 <strnlen+0x39>
  10044b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10044f:	0f b6 00             	movzbl (%rax),%eax
  100452:	84 c0                	test   %al,%al
  100454:	75 e1                	jne    100437 <strnlen+0x1a>
    }
    return n;
  100456:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  10045a:	c9                   	leave  
  10045b:	c3                   	ret    

000000000010045c <strcpy>:

char* strcpy(char* dst, const char* src) {
  10045c:	55                   	push   %rbp
  10045d:	48 89 e5             	mov    %rsp,%rbp
  100460:	48 83 ec 20          	sub    $0x20,%rsp
  100464:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100468:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  10046c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100470:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100474:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100478:	48 8d 42 01          	lea    0x1(%rdx),%rax
  10047c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100480:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100484:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100488:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  10048c:	0f b6 12             	movzbl (%rdx),%edx
  10048f:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100491:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100495:	48 83 e8 01          	sub    $0x1,%rax
  100499:	0f b6 00             	movzbl (%rax),%eax
  10049c:	84 c0                	test   %al,%al
  10049e:	75 d4                	jne    100474 <strcpy+0x18>
    return dst;
  1004a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1004a4:	c9                   	leave  
  1004a5:	c3                   	ret    

00000000001004a6 <strcmp>:

int strcmp(const char* a, const char* b) {
  1004a6:	55                   	push   %rbp
  1004a7:	48 89 e5             	mov    %rsp,%rbp
  1004aa:	48 83 ec 10          	sub    $0x10,%rsp
  1004ae:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1004b2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1004b6:	eb 0a                	jmp    1004c2 <strcmp+0x1c>
        ++a, ++b;
  1004b8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1004bd:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1004c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004c6:	0f b6 00             	movzbl (%rax),%eax
  1004c9:	84 c0                	test   %al,%al
  1004cb:	74 1d                	je     1004ea <strcmp+0x44>
  1004cd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004d1:	0f b6 00             	movzbl (%rax),%eax
  1004d4:	84 c0                	test   %al,%al
  1004d6:	74 12                	je     1004ea <strcmp+0x44>
  1004d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004dc:	0f b6 10             	movzbl (%rax),%edx
  1004df:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004e3:	0f b6 00             	movzbl (%rax),%eax
  1004e6:	38 c2                	cmp    %al,%dl
  1004e8:	74 ce                	je     1004b8 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  1004ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004ee:	0f b6 00             	movzbl (%rax),%eax
  1004f1:	89 c2                	mov    %eax,%edx
  1004f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004f7:	0f b6 00             	movzbl (%rax),%eax
  1004fa:	38 d0                	cmp    %dl,%al
  1004fc:	0f 92 c0             	setb   %al
  1004ff:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100502:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100506:	0f b6 00             	movzbl (%rax),%eax
  100509:	89 c1                	mov    %eax,%ecx
  10050b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10050f:	0f b6 00             	movzbl (%rax),%eax
  100512:	38 c1                	cmp    %al,%cl
  100514:	0f 92 c0             	setb   %al
  100517:	0f b6 c0             	movzbl %al,%eax
  10051a:	29 c2                	sub    %eax,%edx
  10051c:	89 d0                	mov    %edx,%eax
}
  10051e:	c9                   	leave  
  10051f:	c3                   	ret    

0000000000100520 <strchr>:

char* strchr(const char* s, int c) {
  100520:	55                   	push   %rbp
  100521:	48 89 e5             	mov    %rsp,%rbp
  100524:	48 83 ec 10          	sub    $0x10,%rsp
  100528:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  10052c:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  10052f:	eb 05                	jmp    100536 <strchr+0x16>
        ++s;
  100531:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100536:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10053a:	0f b6 00             	movzbl (%rax),%eax
  10053d:	84 c0                	test   %al,%al
  10053f:	74 0e                	je     10054f <strchr+0x2f>
  100541:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100545:	0f b6 00             	movzbl (%rax),%eax
  100548:	8b 55 f4             	mov    -0xc(%rbp),%edx
  10054b:	38 d0                	cmp    %dl,%al
  10054d:	75 e2                	jne    100531 <strchr+0x11>
    }
    if (*s == (char) c) {
  10054f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100553:	0f b6 00             	movzbl (%rax),%eax
  100556:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100559:	38 d0                	cmp    %dl,%al
  10055b:	75 06                	jne    100563 <strchr+0x43>
        return (char*) s;
  10055d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100561:	eb 05                	jmp    100568 <strchr+0x48>
    } else {
        return NULL;
  100563:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100568:	c9                   	leave  
  100569:	c3                   	ret    

000000000010056a <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  10056a:	55                   	push   %rbp
  10056b:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  10056e:	8b 05 9c 1a 00 00    	mov    0x1a9c(%rip),%eax        # 102010 <rand_seed_set>
  100574:	85 c0                	test   %eax,%eax
  100576:	75 0a                	jne    100582 <rand+0x18>
        srand(819234718U);
  100578:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  10057d:	e8 24 00 00 00       	call   1005a6 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100582:	8b 05 8c 1a 00 00    	mov    0x1a8c(%rip),%eax        # 102014 <rand_seed>
  100588:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  10058e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100593:	89 05 7b 1a 00 00    	mov    %eax,0x1a7b(%rip)        # 102014 <rand_seed>
    return rand_seed & RAND_MAX;
  100599:	8b 05 75 1a 00 00    	mov    0x1a75(%rip),%eax        # 102014 <rand_seed>
  10059f:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1005a4:	5d                   	pop    %rbp
  1005a5:	c3                   	ret    

00000000001005a6 <srand>:

void srand(unsigned seed) {
  1005a6:	55                   	push   %rbp
  1005a7:	48 89 e5             	mov    %rsp,%rbp
  1005aa:	48 83 ec 08          	sub    $0x8,%rsp
  1005ae:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  1005b1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1005b4:	89 05 5a 1a 00 00    	mov    %eax,0x1a5a(%rip)        # 102014 <rand_seed>
    rand_seed_set = 1;
  1005ba:	c7 05 4c 1a 00 00 01 	movl   $0x1,0x1a4c(%rip)        # 102010 <rand_seed_set>
  1005c1:	00 00 00 
}
  1005c4:	90                   	nop
  1005c5:	c9                   	leave  
  1005c6:	c3                   	ret    

00000000001005c7 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  1005c7:	55                   	push   %rbp
  1005c8:	48 89 e5             	mov    %rsp,%rbp
  1005cb:	48 83 ec 28          	sub    $0x28,%rsp
  1005cf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1005d3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1005d7:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  1005da:	48 c7 45 f8 80 15 10 	movq   $0x101580,-0x8(%rbp)
  1005e1:	00 
    if (base < 0) {
  1005e2:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  1005e6:	79 0b                	jns    1005f3 <fill_numbuf+0x2c>
        digits = lower_digits;
  1005e8:	48 c7 45 f8 a0 15 10 	movq   $0x1015a0,-0x8(%rbp)
  1005ef:	00 
        base = -base;
  1005f0:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  1005f3:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1005f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1005fc:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  1005ff:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100602:	48 63 c8             	movslq %eax,%rcx
  100605:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100609:	ba 00 00 00 00       	mov    $0x0,%edx
  10060e:	48 f7 f1             	div    %rcx
  100611:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100615:	48 01 d0             	add    %rdx,%rax
  100618:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10061d:	0f b6 10             	movzbl (%rax),%edx
  100620:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100624:	88 10                	mov    %dl,(%rax)
        val /= base;
  100626:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100629:	48 63 f0             	movslq %eax,%rsi
  10062c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100630:	ba 00 00 00 00       	mov    $0x0,%edx
  100635:	48 f7 f6             	div    %rsi
  100638:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  10063c:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100641:	75 bc                	jne    1005ff <fill_numbuf+0x38>
    return numbuf_end;
  100643:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100647:	c9                   	leave  
  100648:	c3                   	ret    

0000000000100649 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100649:	55                   	push   %rbp
  10064a:	48 89 e5             	mov    %rsp,%rbp
  10064d:	53                   	push   %rbx
  10064e:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100655:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  10065c:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100662:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100669:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100670:	e9 8a 09 00 00       	jmp    100fff <printer_vprintf+0x9b6>
        if (*format != '%') {
  100675:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10067c:	0f b6 00             	movzbl (%rax),%eax
  10067f:	3c 25                	cmp    $0x25,%al
  100681:	74 31                	je     1006b4 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  100683:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10068a:	4c 8b 00             	mov    (%rax),%r8
  10068d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100694:	0f b6 00             	movzbl (%rax),%eax
  100697:	0f b6 c8             	movzbl %al,%ecx
  10069a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1006a0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1006a7:	89 ce                	mov    %ecx,%esi
  1006a9:	48 89 c7             	mov    %rax,%rdi
  1006ac:	41 ff d0             	call   *%r8
            continue;
  1006af:	e9 43 09 00 00       	jmp    100ff7 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  1006b4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  1006bb:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1006c2:	01 
  1006c3:	eb 44                	jmp    100709 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  1006c5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006cc:	0f b6 00             	movzbl (%rax),%eax
  1006cf:	0f be c0             	movsbl %al,%eax
  1006d2:	89 c6                	mov    %eax,%esi
  1006d4:	bf a0 13 10 00       	mov    $0x1013a0,%edi
  1006d9:	e8 42 fe ff ff       	call   100520 <strchr>
  1006de:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  1006e2:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  1006e7:	74 30                	je     100719 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  1006e9:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  1006ed:	48 2d a0 13 10 00    	sub    $0x1013a0,%rax
  1006f3:	ba 01 00 00 00       	mov    $0x1,%edx
  1006f8:	89 c1                	mov    %eax,%ecx
  1006fa:	d3 e2                	shl    %cl,%edx
  1006fc:	89 d0                	mov    %edx,%eax
  1006fe:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100701:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100708:	01 
  100709:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100710:	0f b6 00             	movzbl (%rax),%eax
  100713:	84 c0                	test   %al,%al
  100715:	75 ae                	jne    1006c5 <printer_vprintf+0x7c>
  100717:	eb 01                	jmp    10071a <printer_vprintf+0xd1>
            } else {
                break;
  100719:	90                   	nop
            }
        }

        // process width
        int width = -1;
  10071a:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100721:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100728:	0f b6 00             	movzbl (%rax),%eax
  10072b:	3c 30                	cmp    $0x30,%al
  10072d:	7e 67                	jle    100796 <printer_vprintf+0x14d>
  10072f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100736:	0f b6 00             	movzbl (%rax),%eax
  100739:	3c 39                	cmp    $0x39,%al
  10073b:	7f 59                	jg     100796 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10073d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100744:	eb 2e                	jmp    100774 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100746:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100749:	89 d0                	mov    %edx,%eax
  10074b:	c1 e0 02             	shl    $0x2,%eax
  10074e:	01 d0                	add    %edx,%eax
  100750:	01 c0                	add    %eax,%eax
  100752:	89 c1                	mov    %eax,%ecx
  100754:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10075b:	48 8d 50 01          	lea    0x1(%rax),%rdx
  10075f:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100766:	0f b6 00             	movzbl (%rax),%eax
  100769:	0f be c0             	movsbl %al,%eax
  10076c:	01 c8                	add    %ecx,%eax
  10076e:	83 e8 30             	sub    $0x30,%eax
  100771:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100774:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10077b:	0f b6 00             	movzbl (%rax),%eax
  10077e:	3c 2f                	cmp    $0x2f,%al
  100780:	0f 8e 85 00 00 00    	jle    10080b <printer_vprintf+0x1c2>
  100786:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10078d:	0f b6 00             	movzbl (%rax),%eax
  100790:	3c 39                	cmp    $0x39,%al
  100792:	7e b2                	jle    100746 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100794:	eb 75                	jmp    10080b <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100796:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10079d:	0f b6 00             	movzbl (%rax),%eax
  1007a0:	3c 2a                	cmp    $0x2a,%al
  1007a2:	75 68                	jne    10080c <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  1007a4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007ab:	8b 00                	mov    (%rax),%eax
  1007ad:	83 f8 2f             	cmp    $0x2f,%eax
  1007b0:	77 30                	ja     1007e2 <printer_vprintf+0x199>
  1007b2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007b9:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1007bd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007c4:	8b 00                	mov    (%rax),%eax
  1007c6:	89 c0                	mov    %eax,%eax
  1007c8:	48 01 d0             	add    %rdx,%rax
  1007cb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007d2:	8b 12                	mov    (%rdx),%edx
  1007d4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1007d7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007de:	89 0a                	mov    %ecx,(%rdx)
  1007e0:	eb 1a                	jmp    1007fc <printer_vprintf+0x1b3>
  1007e2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007e9:	48 8b 40 08          	mov    0x8(%rax),%rax
  1007ed:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1007f1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007f8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1007fc:	8b 00                	mov    (%rax),%eax
  1007fe:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100801:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100808:	01 
  100809:	eb 01                	jmp    10080c <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  10080b:	90                   	nop
        }

        // process precision
        int precision = -1;
  10080c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100813:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10081a:	0f b6 00             	movzbl (%rax),%eax
  10081d:	3c 2e                	cmp    $0x2e,%al
  10081f:	0f 85 00 01 00 00    	jne    100925 <printer_vprintf+0x2dc>
            ++format;
  100825:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10082c:	01 
            if (*format >= '0' && *format <= '9') {
  10082d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100834:	0f b6 00             	movzbl (%rax),%eax
  100837:	3c 2f                	cmp    $0x2f,%al
  100839:	7e 67                	jle    1008a2 <printer_vprintf+0x259>
  10083b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100842:	0f b6 00             	movzbl (%rax),%eax
  100845:	3c 39                	cmp    $0x39,%al
  100847:	7f 59                	jg     1008a2 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100849:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100850:	eb 2e                	jmp    100880 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100852:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100855:	89 d0                	mov    %edx,%eax
  100857:	c1 e0 02             	shl    $0x2,%eax
  10085a:	01 d0                	add    %edx,%eax
  10085c:	01 c0                	add    %eax,%eax
  10085e:	89 c1                	mov    %eax,%ecx
  100860:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100867:	48 8d 50 01          	lea    0x1(%rax),%rdx
  10086b:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100872:	0f b6 00             	movzbl (%rax),%eax
  100875:	0f be c0             	movsbl %al,%eax
  100878:	01 c8                	add    %ecx,%eax
  10087a:	83 e8 30             	sub    $0x30,%eax
  10087d:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100880:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100887:	0f b6 00             	movzbl (%rax),%eax
  10088a:	3c 2f                	cmp    $0x2f,%al
  10088c:	0f 8e 85 00 00 00    	jle    100917 <printer_vprintf+0x2ce>
  100892:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100899:	0f b6 00             	movzbl (%rax),%eax
  10089c:	3c 39                	cmp    $0x39,%al
  10089e:	7e b2                	jle    100852 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  1008a0:	eb 75                	jmp    100917 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  1008a2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008a9:	0f b6 00             	movzbl (%rax),%eax
  1008ac:	3c 2a                	cmp    $0x2a,%al
  1008ae:	75 68                	jne    100918 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  1008b0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008b7:	8b 00                	mov    (%rax),%eax
  1008b9:	83 f8 2f             	cmp    $0x2f,%eax
  1008bc:	77 30                	ja     1008ee <printer_vprintf+0x2a5>
  1008be:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008c5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1008c9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008d0:	8b 00                	mov    (%rax),%eax
  1008d2:	89 c0                	mov    %eax,%eax
  1008d4:	48 01 d0             	add    %rdx,%rax
  1008d7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008de:	8b 12                	mov    (%rdx),%edx
  1008e0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1008e3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008ea:	89 0a                	mov    %ecx,(%rdx)
  1008ec:	eb 1a                	jmp    100908 <printer_vprintf+0x2bf>
  1008ee:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008f5:	48 8b 40 08          	mov    0x8(%rax),%rax
  1008f9:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1008fd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100904:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100908:	8b 00                	mov    (%rax),%eax
  10090a:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  10090d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100914:	01 
  100915:	eb 01                	jmp    100918 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100917:	90                   	nop
            }
            if (precision < 0) {
  100918:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  10091c:	79 07                	jns    100925 <printer_vprintf+0x2dc>
                precision = 0;
  10091e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100925:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  10092c:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100933:	00 
        int length = 0;
  100934:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  10093b:	48 c7 45 c8 a6 13 10 	movq   $0x1013a6,-0x38(%rbp)
  100942:	00 
    again:
        switch (*format) {
  100943:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10094a:	0f b6 00             	movzbl (%rax),%eax
  10094d:	0f be c0             	movsbl %al,%eax
  100950:	83 e8 43             	sub    $0x43,%eax
  100953:	83 f8 37             	cmp    $0x37,%eax
  100956:	0f 87 9f 03 00 00    	ja     100cfb <printer_vprintf+0x6b2>
  10095c:	89 c0                	mov    %eax,%eax
  10095e:	48 8b 04 c5 b8 13 10 	mov    0x1013b8(,%rax,8),%rax
  100965:	00 
  100966:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100968:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  10096f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100976:	01 
            goto again;
  100977:	eb ca                	jmp    100943 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100979:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  10097d:	74 5d                	je     1009dc <printer_vprintf+0x393>
  10097f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100986:	8b 00                	mov    (%rax),%eax
  100988:	83 f8 2f             	cmp    $0x2f,%eax
  10098b:	77 30                	ja     1009bd <printer_vprintf+0x374>
  10098d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100994:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100998:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10099f:	8b 00                	mov    (%rax),%eax
  1009a1:	89 c0                	mov    %eax,%eax
  1009a3:	48 01 d0             	add    %rdx,%rax
  1009a6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009ad:	8b 12                	mov    (%rdx),%edx
  1009af:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1009b2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009b9:	89 0a                	mov    %ecx,(%rdx)
  1009bb:	eb 1a                	jmp    1009d7 <printer_vprintf+0x38e>
  1009bd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009c4:	48 8b 40 08          	mov    0x8(%rax),%rax
  1009c8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1009cc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009d3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1009d7:	48 8b 00             	mov    (%rax),%rax
  1009da:	eb 5c                	jmp    100a38 <printer_vprintf+0x3ef>
  1009dc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009e3:	8b 00                	mov    (%rax),%eax
  1009e5:	83 f8 2f             	cmp    $0x2f,%eax
  1009e8:	77 30                	ja     100a1a <printer_vprintf+0x3d1>
  1009ea:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009f1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1009f5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009fc:	8b 00                	mov    (%rax),%eax
  1009fe:	89 c0                	mov    %eax,%eax
  100a00:	48 01 d0             	add    %rdx,%rax
  100a03:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a0a:	8b 12                	mov    (%rdx),%edx
  100a0c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a0f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a16:	89 0a                	mov    %ecx,(%rdx)
  100a18:	eb 1a                	jmp    100a34 <printer_vprintf+0x3eb>
  100a1a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a21:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a25:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a29:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a30:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a34:	8b 00                	mov    (%rax),%eax
  100a36:	48 98                	cltq   
  100a38:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100a3c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a40:	48 c1 f8 38          	sar    $0x38,%rax
  100a44:	25 80 00 00 00       	and    $0x80,%eax
  100a49:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100a4c:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100a50:	74 09                	je     100a5b <printer_vprintf+0x412>
  100a52:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a56:	48 f7 d8             	neg    %rax
  100a59:	eb 04                	jmp    100a5f <printer_vprintf+0x416>
  100a5b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a5f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100a63:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100a66:	83 c8 60             	or     $0x60,%eax
  100a69:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100a6c:	e9 cf 02 00 00       	jmp    100d40 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100a71:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100a75:	74 5d                	je     100ad4 <printer_vprintf+0x48b>
  100a77:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a7e:	8b 00                	mov    (%rax),%eax
  100a80:	83 f8 2f             	cmp    $0x2f,%eax
  100a83:	77 30                	ja     100ab5 <printer_vprintf+0x46c>
  100a85:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a8c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a90:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a97:	8b 00                	mov    (%rax),%eax
  100a99:	89 c0                	mov    %eax,%eax
  100a9b:	48 01 d0             	add    %rdx,%rax
  100a9e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aa5:	8b 12                	mov    (%rdx),%edx
  100aa7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100aaa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ab1:	89 0a                	mov    %ecx,(%rdx)
  100ab3:	eb 1a                	jmp    100acf <printer_vprintf+0x486>
  100ab5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100abc:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ac0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ac4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100acb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100acf:	48 8b 00             	mov    (%rax),%rax
  100ad2:	eb 5c                	jmp    100b30 <printer_vprintf+0x4e7>
  100ad4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100adb:	8b 00                	mov    (%rax),%eax
  100add:	83 f8 2f             	cmp    $0x2f,%eax
  100ae0:	77 30                	ja     100b12 <printer_vprintf+0x4c9>
  100ae2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ae9:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100aed:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100af4:	8b 00                	mov    (%rax),%eax
  100af6:	89 c0                	mov    %eax,%eax
  100af8:	48 01 d0             	add    %rdx,%rax
  100afb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b02:	8b 12                	mov    (%rdx),%edx
  100b04:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b07:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b0e:	89 0a                	mov    %ecx,(%rdx)
  100b10:	eb 1a                	jmp    100b2c <printer_vprintf+0x4e3>
  100b12:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b19:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b1d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b21:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b28:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b2c:	8b 00                	mov    (%rax),%eax
  100b2e:	89 c0                	mov    %eax,%eax
  100b30:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100b34:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100b38:	e9 03 02 00 00       	jmp    100d40 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100b3d:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100b44:	e9 28 ff ff ff       	jmp    100a71 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100b49:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100b50:	e9 1c ff ff ff       	jmp    100a71 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100b55:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b5c:	8b 00                	mov    (%rax),%eax
  100b5e:	83 f8 2f             	cmp    $0x2f,%eax
  100b61:	77 30                	ja     100b93 <printer_vprintf+0x54a>
  100b63:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b6a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b6e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b75:	8b 00                	mov    (%rax),%eax
  100b77:	89 c0                	mov    %eax,%eax
  100b79:	48 01 d0             	add    %rdx,%rax
  100b7c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b83:	8b 12                	mov    (%rdx),%edx
  100b85:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b88:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b8f:	89 0a                	mov    %ecx,(%rdx)
  100b91:	eb 1a                	jmp    100bad <printer_vprintf+0x564>
  100b93:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b9a:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b9e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ba2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ba9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100bad:	48 8b 00             	mov    (%rax),%rax
  100bb0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100bb4:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100bbb:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100bc2:	e9 79 01 00 00       	jmp    100d40 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100bc7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bce:	8b 00                	mov    (%rax),%eax
  100bd0:	83 f8 2f             	cmp    $0x2f,%eax
  100bd3:	77 30                	ja     100c05 <printer_vprintf+0x5bc>
  100bd5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bdc:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100be0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100be7:	8b 00                	mov    (%rax),%eax
  100be9:	89 c0                	mov    %eax,%eax
  100beb:	48 01 d0             	add    %rdx,%rax
  100bee:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bf5:	8b 12                	mov    (%rdx),%edx
  100bf7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bfa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c01:	89 0a                	mov    %ecx,(%rdx)
  100c03:	eb 1a                	jmp    100c1f <printer_vprintf+0x5d6>
  100c05:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c0c:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c10:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c14:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c1b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c1f:	48 8b 00             	mov    (%rax),%rax
  100c22:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100c26:	e9 15 01 00 00       	jmp    100d40 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100c2b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c32:	8b 00                	mov    (%rax),%eax
  100c34:	83 f8 2f             	cmp    $0x2f,%eax
  100c37:	77 30                	ja     100c69 <printer_vprintf+0x620>
  100c39:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c40:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c44:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c4b:	8b 00                	mov    (%rax),%eax
  100c4d:	89 c0                	mov    %eax,%eax
  100c4f:	48 01 d0             	add    %rdx,%rax
  100c52:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c59:	8b 12                	mov    (%rdx),%edx
  100c5b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c5e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c65:	89 0a                	mov    %ecx,(%rdx)
  100c67:	eb 1a                	jmp    100c83 <printer_vprintf+0x63a>
  100c69:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c70:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c74:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c78:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c7f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c83:	8b 00                	mov    (%rax),%eax
  100c85:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100c8b:	e9 67 03 00 00       	jmp    100ff7 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  100c90:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100c94:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100c98:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c9f:	8b 00                	mov    (%rax),%eax
  100ca1:	83 f8 2f             	cmp    $0x2f,%eax
  100ca4:	77 30                	ja     100cd6 <printer_vprintf+0x68d>
  100ca6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cad:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100cb1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cb8:	8b 00                	mov    (%rax),%eax
  100cba:	89 c0                	mov    %eax,%eax
  100cbc:	48 01 d0             	add    %rdx,%rax
  100cbf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cc6:	8b 12                	mov    (%rdx),%edx
  100cc8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ccb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cd2:	89 0a                	mov    %ecx,(%rdx)
  100cd4:	eb 1a                	jmp    100cf0 <printer_vprintf+0x6a7>
  100cd6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cdd:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ce1:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ce5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cec:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100cf0:	8b 00                	mov    (%rax),%eax
  100cf2:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100cf5:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100cf9:	eb 45                	jmp    100d40 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  100cfb:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100cff:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100d03:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d0a:	0f b6 00             	movzbl (%rax),%eax
  100d0d:	84 c0                	test   %al,%al
  100d0f:	74 0c                	je     100d1d <printer_vprintf+0x6d4>
  100d11:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d18:	0f b6 00             	movzbl (%rax),%eax
  100d1b:	eb 05                	jmp    100d22 <printer_vprintf+0x6d9>
  100d1d:	b8 25 00 00 00       	mov    $0x25,%eax
  100d22:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100d25:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100d29:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d30:	0f b6 00             	movzbl (%rax),%eax
  100d33:	84 c0                	test   %al,%al
  100d35:	75 08                	jne    100d3f <printer_vprintf+0x6f6>
                format--;
  100d37:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100d3e:	01 
            }
            break;
  100d3f:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100d40:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d43:	83 e0 20             	and    $0x20,%eax
  100d46:	85 c0                	test   %eax,%eax
  100d48:	74 1e                	je     100d68 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100d4a:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d4e:	48 83 c0 18          	add    $0x18,%rax
  100d52:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100d55:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100d59:	48 89 ce             	mov    %rcx,%rsi
  100d5c:	48 89 c7             	mov    %rax,%rdi
  100d5f:	e8 63 f8 ff ff       	call   1005c7 <fill_numbuf>
  100d64:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100d68:	48 c7 45 c0 a6 13 10 	movq   $0x1013a6,-0x40(%rbp)
  100d6f:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100d70:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d73:	83 e0 20             	and    $0x20,%eax
  100d76:	85 c0                	test   %eax,%eax
  100d78:	74 48                	je     100dc2 <printer_vprintf+0x779>
  100d7a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d7d:	83 e0 40             	and    $0x40,%eax
  100d80:	85 c0                	test   %eax,%eax
  100d82:	74 3e                	je     100dc2 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  100d84:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d87:	25 80 00 00 00       	and    $0x80,%eax
  100d8c:	85 c0                	test   %eax,%eax
  100d8e:	74 0a                	je     100d9a <printer_vprintf+0x751>
                prefix = "-";
  100d90:	48 c7 45 c0 a7 13 10 	movq   $0x1013a7,-0x40(%rbp)
  100d97:	00 
            if (flags & FLAG_NEGATIVE) {
  100d98:	eb 73                	jmp    100e0d <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100d9a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d9d:	83 e0 10             	and    $0x10,%eax
  100da0:	85 c0                	test   %eax,%eax
  100da2:	74 0a                	je     100dae <printer_vprintf+0x765>
                prefix = "+";
  100da4:	48 c7 45 c0 a9 13 10 	movq   $0x1013a9,-0x40(%rbp)
  100dab:	00 
            if (flags & FLAG_NEGATIVE) {
  100dac:	eb 5f                	jmp    100e0d <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100dae:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100db1:	83 e0 08             	and    $0x8,%eax
  100db4:	85 c0                	test   %eax,%eax
  100db6:	74 55                	je     100e0d <printer_vprintf+0x7c4>
                prefix = " ";
  100db8:	48 c7 45 c0 ab 13 10 	movq   $0x1013ab,-0x40(%rbp)
  100dbf:	00 
            if (flags & FLAG_NEGATIVE) {
  100dc0:	eb 4b                	jmp    100e0d <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100dc2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dc5:	83 e0 20             	and    $0x20,%eax
  100dc8:	85 c0                	test   %eax,%eax
  100dca:	74 42                	je     100e0e <printer_vprintf+0x7c5>
  100dcc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dcf:	83 e0 01             	and    $0x1,%eax
  100dd2:	85 c0                	test   %eax,%eax
  100dd4:	74 38                	je     100e0e <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  100dd6:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100dda:	74 06                	je     100de2 <printer_vprintf+0x799>
  100ddc:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100de0:	75 2c                	jne    100e0e <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  100de2:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100de7:	75 0c                	jne    100df5 <printer_vprintf+0x7ac>
  100de9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dec:	25 00 01 00 00       	and    $0x100,%eax
  100df1:	85 c0                	test   %eax,%eax
  100df3:	74 19                	je     100e0e <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  100df5:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100df9:	75 07                	jne    100e02 <printer_vprintf+0x7b9>
  100dfb:	b8 ad 13 10 00       	mov    $0x1013ad,%eax
  100e00:	eb 05                	jmp    100e07 <printer_vprintf+0x7be>
  100e02:	b8 b0 13 10 00       	mov    $0x1013b0,%eax
  100e07:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100e0b:	eb 01                	jmp    100e0e <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  100e0d:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100e0e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100e12:	78 24                	js     100e38 <printer_vprintf+0x7ef>
  100e14:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e17:	83 e0 20             	and    $0x20,%eax
  100e1a:	85 c0                	test   %eax,%eax
  100e1c:	75 1a                	jne    100e38 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  100e1e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100e21:	48 63 d0             	movslq %eax,%rdx
  100e24:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100e28:	48 89 d6             	mov    %rdx,%rsi
  100e2b:	48 89 c7             	mov    %rax,%rdi
  100e2e:	e8 ea f5 ff ff       	call   10041d <strnlen>
  100e33:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100e36:	eb 0f                	jmp    100e47 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  100e38:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100e3c:	48 89 c7             	mov    %rax,%rdi
  100e3f:	e8 a8 f5 ff ff       	call   1003ec <strlen>
  100e44:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100e47:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e4a:	83 e0 20             	and    $0x20,%eax
  100e4d:	85 c0                	test   %eax,%eax
  100e4f:	74 20                	je     100e71 <printer_vprintf+0x828>
  100e51:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100e55:	78 1a                	js     100e71 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  100e57:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100e5a:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100e5d:	7e 08                	jle    100e67 <printer_vprintf+0x81e>
  100e5f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100e62:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100e65:	eb 05                	jmp    100e6c <printer_vprintf+0x823>
  100e67:	b8 00 00 00 00       	mov    $0x0,%eax
  100e6c:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100e6f:	eb 5c                	jmp    100ecd <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100e71:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e74:	83 e0 20             	and    $0x20,%eax
  100e77:	85 c0                	test   %eax,%eax
  100e79:	74 4b                	je     100ec6 <printer_vprintf+0x87d>
  100e7b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e7e:	83 e0 02             	and    $0x2,%eax
  100e81:	85 c0                	test   %eax,%eax
  100e83:	74 41                	je     100ec6 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100e85:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e88:	83 e0 04             	and    $0x4,%eax
  100e8b:	85 c0                	test   %eax,%eax
  100e8d:	75 37                	jne    100ec6 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  100e8f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e93:	48 89 c7             	mov    %rax,%rdi
  100e96:	e8 51 f5 ff ff       	call   1003ec <strlen>
  100e9b:	89 c2                	mov    %eax,%edx
  100e9d:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100ea0:	01 d0                	add    %edx,%eax
  100ea2:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100ea5:	7e 1f                	jle    100ec6 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  100ea7:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100eaa:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100ead:	89 c3                	mov    %eax,%ebx
  100eaf:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100eb3:	48 89 c7             	mov    %rax,%rdi
  100eb6:	e8 31 f5 ff ff       	call   1003ec <strlen>
  100ebb:	89 c2                	mov    %eax,%edx
  100ebd:	89 d8                	mov    %ebx,%eax
  100ebf:	29 d0                	sub    %edx,%eax
  100ec1:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100ec4:	eb 07                	jmp    100ecd <printer_vprintf+0x884>
        } else {
            zeros = 0;
  100ec6:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100ecd:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100ed0:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100ed3:	01 d0                	add    %edx,%eax
  100ed5:	48 63 d8             	movslq %eax,%rbx
  100ed8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100edc:	48 89 c7             	mov    %rax,%rdi
  100edf:	e8 08 f5 ff ff       	call   1003ec <strlen>
  100ee4:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100ee8:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100eeb:	29 d0                	sub    %edx,%eax
  100eed:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100ef0:	eb 25                	jmp    100f17 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  100ef2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ef9:	48 8b 08             	mov    (%rax),%rcx
  100efc:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f02:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f09:	be 20 00 00 00       	mov    $0x20,%esi
  100f0e:	48 89 c7             	mov    %rax,%rdi
  100f11:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100f13:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100f17:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f1a:	83 e0 04             	and    $0x4,%eax
  100f1d:	85 c0                	test   %eax,%eax
  100f1f:	75 36                	jne    100f57 <printer_vprintf+0x90e>
  100f21:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100f25:	7f cb                	jg     100ef2 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  100f27:	eb 2e                	jmp    100f57 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  100f29:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f30:	4c 8b 00             	mov    (%rax),%r8
  100f33:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f37:	0f b6 00             	movzbl (%rax),%eax
  100f3a:	0f b6 c8             	movzbl %al,%ecx
  100f3d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f43:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f4a:	89 ce                	mov    %ecx,%esi
  100f4c:	48 89 c7             	mov    %rax,%rdi
  100f4f:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  100f52:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  100f57:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f5b:	0f b6 00             	movzbl (%rax),%eax
  100f5e:	84 c0                	test   %al,%al
  100f60:	75 c7                	jne    100f29 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  100f62:	eb 25                	jmp    100f89 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  100f64:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f6b:	48 8b 08             	mov    (%rax),%rcx
  100f6e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f74:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f7b:	be 30 00 00 00       	mov    $0x30,%esi
  100f80:	48 89 c7             	mov    %rax,%rdi
  100f83:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  100f85:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  100f89:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  100f8d:	7f d5                	jg     100f64 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  100f8f:	eb 32                	jmp    100fc3 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  100f91:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f98:	4c 8b 00             	mov    (%rax),%r8
  100f9b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100f9f:	0f b6 00             	movzbl (%rax),%eax
  100fa2:	0f b6 c8             	movzbl %al,%ecx
  100fa5:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100fab:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fb2:	89 ce                	mov    %ecx,%esi
  100fb4:	48 89 c7             	mov    %rax,%rdi
  100fb7:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  100fba:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  100fbf:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  100fc3:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  100fc7:	7f c8                	jg     100f91 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  100fc9:	eb 25                	jmp    100ff0 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  100fcb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fd2:	48 8b 08             	mov    (%rax),%rcx
  100fd5:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100fdb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fe2:	be 20 00 00 00       	mov    $0x20,%esi
  100fe7:	48 89 c7             	mov    %rax,%rdi
  100fea:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  100fec:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100ff0:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100ff4:	7f d5                	jg     100fcb <printer_vprintf+0x982>
        }
    done: ;
  100ff6:	90                   	nop
    for (; *format; ++format) {
  100ff7:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ffe:	01 
  100fff:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101006:	0f b6 00             	movzbl (%rax),%eax
  101009:	84 c0                	test   %al,%al
  10100b:	0f 85 64 f6 ff ff    	jne    100675 <printer_vprintf+0x2c>
    }
}
  101011:	90                   	nop
  101012:	90                   	nop
  101013:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  101017:	c9                   	leave  
  101018:	c3                   	ret    

0000000000101019 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  101019:	55                   	push   %rbp
  10101a:	48 89 e5             	mov    %rsp,%rbp
  10101d:	48 83 ec 20          	sub    $0x20,%rsp
  101021:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101025:	89 f0                	mov    %esi,%eax
  101027:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10102a:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  10102d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101031:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101035:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101039:	48 8b 40 08          	mov    0x8(%rax),%rax
  10103d:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  101042:	48 39 d0             	cmp    %rdx,%rax
  101045:	72 0c                	jb     101053 <console_putc+0x3a>
        cp->cursor = console;
  101047:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10104b:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  101052:	00 
    }
    if (c == '\n') {
  101053:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  101057:	75 78                	jne    1010d1 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  101059:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10105d:	48 8b 40 08          	mov    0x8(%rax),%rax
  101061:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  101067:	48 d1 f8             	sar    %rax
  10106a:	48 89 c1             	mov    %rax,%rcx
  10106d:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  101074:	66 66 66 
  101077:	48 89 c8             	mov    %rcx,%rax
  10107a:	48 f7 ea             	imul   %rdx
  10107d:	48 c1 fa 05          	sar    $0x5,%rdx
  101081:	48 89 c8             	mov    %rcx,%rax
  101084:	48 c1 f8 3f          	sar    $0x3f,%rax
  101088:	48 29 c2             	sub    %rax,%rdx
  10108b:	48 89 d0             	mov    %rdx,%rax
  10108e:	48 c1 e0 02          	shl    $0x2,%rax
  101092:	48 01 d0             	add    %rdx,%rax
  101095:	48 c1 e0 04          	shl    $0x4,%rax
  101099:	48 29 c1             	sub    %rax,%rcx
  10109c:	48 89 ca             	mov    %rcx,%rdx
  10109f:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  1010a2:	eb 25                	jmp    1010c9 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  1010a4:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1010a7:	83 c8 20             	or     $0x20,%eax
  1010aa:	89 c6                	mov    %eax,%esi
  1010ac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010b0:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010b4:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1010b8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1010bc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1010c0:	89 f2                	mov    %esi,%edx
  1010c2:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  1010c5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1010c9:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  1010cd:	75 d5                	jne    1010a4 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  1010cf:	eb 24                	jmp    1010f5 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  1010d1:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  1010d5:	8b 55 e0             	mov    -0x20(%rbp),%edx
  1010d8:	09 d0                	or     %edx,%eax
  1010da:	89 c6                	mov    %eax,%esi
  1010dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010e0:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010e4:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1010e8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1010ec:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1010f0:	89 f2                	mov    %esi,%edx
  1010f2:	66 89 10             	mov    %dx,(%rax)
}
  1010f5:	90                   	nop
  1010f6:	c9                   	leave  
  1010f7:	c3                   	ret    

00000000001010f8 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1010f8:	55                   	push   %rbp
  1010f9:	48 89 e5             	mov    %rsp,%rbp
  1010fc:	48 83 ec 30          	sub    $0x30,%rsp
  101100:	89 7d ec             	mov    %edi,-0x14(%rbp)
  101103:	89 75 e8             	mov    %esi,-0x18(%rbp)
  101106:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  10110a:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  10110e:	48 c7 45 f0 19 10 10 	movq   $0x101019,-0x10(%rbp)
  101115:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101116:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  10111a:	78 09                	js     101125 <console_vprintf+0x2d>
  10111c:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101123:	7e 07                	jle    10112c <console_vprintf+0x34>
        cpos = 0;
  101125:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  10112c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10112f:	48 98                	cltq   
  101131:	48 01 c0             	add    %rax,%rax
  101134:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  10113a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  10113e:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101142:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  101146:	8b 75 e8             	mov    -0x18(%rbp),%esi
  101149:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  10114d:	48 89 c7             	mov    %rax,%rdi
  101150:	e8 f4 f4 ff ff       	call   100649 <printer_vprintf>
    return cp.cursor - console;
  101155:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101159:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  10115f:	48 d1 f8             	sar    %rax
}
  101162:	c9                   	leave  
  101163:	c3                   	ret    

0000000000101164 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  101164:	55                   	push   %rbp
  101165:	48 89 e5             	mov    %rsp,%rbp
  101168:	48 83 ec 60          	sub    $0x60,%rsp
  10116c:	89 7d ac             	mov    %edi,-0x54(%rbp)
  10116f:	89 75 a8             	mov    %esi,-0x58(%rbp)
  101172:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  101176:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10117a:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10117e:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101182:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101189:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10118d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101191:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101195:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101199:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  10119d:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  1011a1:	8b 75 a8             	mov    -0x58(%rbp),%esi
  1011a4:	8b 45 ac             	mov    -0x54(%rbp),%eax
  1011a7:	89 c7                	mov    %eax,%edi
  1011a9:	e8 4a ff ff ff       	call   1010f8 <console_vprintf>
  1011ae:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  1011b1:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  1011b4:	c9                   	leave  
  1011b5:	c3                   	ret    

00000000001011b6 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  1011b6:	55                   	push   %rbp
  1011b7:	48 89 e5             	mov    %rsp,%rbp
  1011ba:	48 83 ec 20          	sub    $0x20,%rsp
  1011be:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1011c2:	89 f0                	mov    %esi,%eax
  1011c4:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1011c7:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  1011ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1011ce:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  1011d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1011d6:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1011da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1011de:	48 8b 40 10          	mov    0x10(%rax),%rax
  1011e2:	48 39 c2             	cmp    %rax,%rdx
  1011e5:	73 1a                	jae    101201 <string_putc+0x4b>
        *sp->s++ = c;
  1011e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1011eb:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011ef:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1011f3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1011f7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1011fb:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1011ff:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101201:	90                   	nop
  101202:	c9                   	leave  
  101203:	c3                   	ret    

0000000000101204 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101204:	55                   	push   %rbp
  101205:	48 89 e5             	mov    %rsp,%rbp
  101208:	48 83 ec 40          	sub    $0x40,%rsp
  10120c:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101210:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101214:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  101218:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  10121c:	48 c7 45 e8 b6 11 10 	movq   $0x1011b6,-0x18(%rbp)
  101223:	00 
    sp.s = s;
  101224:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101228:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  10122c:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  101231:	74 33                	je     101266 <vsnprintf+0x62>
        sp.end = s + size - 1;
  101233:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101237:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10123b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10123f:	48 01 d0             	add    %rdx,%rax
  101242:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101246:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  10124a:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  10124e:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101252:	be 00 00 00 00       	mov    $0x0,%esi
  101257:	48 89 c7             	mov    %rax,%rdi
  10125a:	e8 ea f3 ff ff       	call   100649 <printer_vprintf>
        *sp.s = 0;
  10125f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101263:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  101266:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10126a:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  10126e:	c9                   	leave  
  10126f:	c3                   	ret    

0000000000101270 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  101270:	55                   	push   %rbp
  101271:	48 89 e5             	mov    %rsp,%rbp
  101274:	48 83 ec 70          	sub    $0x70,%rsp
  101278:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  10127c:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  101280:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101284:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101288:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10128c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101290:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101297:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10129b:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  10129f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1012a3:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  1012a7:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  1012ab:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  1012af:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  1012b3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1012b7:	48 89 c7             	mov    %rax,%rdi
  1012ba:	e8 45 ff ff ff       	call   101204 <vsnprintf>
  1012bf:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  1012c2:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  1012c5:	c9                   	leave  
  1012c6:	c3                   	ret    

00000000001012c7 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  1012c7:	55                   	push   %rbp
  1012c8:	48 89 e5             	mov    %rsp,%rbp
  1012cb:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1012cf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  1012d6:	eb 13                	jmp    1012eb <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  1012d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1012db:	48 98                	cltq   
  1012dd:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  1012e4:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1012e7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1012eb:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1012f2:	7e e4                	jle    1012d8 <console_clear+0x11>
    }
    cursorpos = 0;
  1012f4:	c7 05 fe 7c fb ff 00 	movl   $0x0,-0x48302(%rip)        # b8ffc <cursorpos>
  1012fb:	00 00 00 
}
  1012fe:	90                   	nop
  1012ff:	c9                   	leave  
  101300:	c3                   	ret    
