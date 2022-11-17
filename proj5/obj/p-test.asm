
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
"Leia Organa of Aldernaan, Senator"
"--  George Lucas, Prologue to Star Wars";

// similar to p-fork but with large global memory 

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	41 56                	push   %r14
  100006:	41 55                	push   %r13
  100008:	41 54                	push   %r12
  10000a:	53                   	push   %rbx
// sys_fork()
//    Fork the current process. On success, return the child's process ID to
//    the parent, and return 0 to the child. On failure, return -1.
static inline pid_t sys_fork(void) {
    pid_t result;
    asm volatile ("int %1" 
  10000b:	cd 34                	int    $0x34
    // Fork a total of three new copies.
    pid_t p1 = sys_fork();
    assert(p1 >= 0);
  10000d:	85 c0                	test   %eax,%eax
  10000f:	78 58                	js     100069 <process_main+0x69>
  100011:	41 89 c4             	mov    %eax,%r12d
  100014:	cd 34                	int    $0x34
  100016:	41 89 c6             	mov    %eax,%r14d
    pid_t p2 = sys_fork();
    assert(p2 >= 0);
  100019:	85 c0                	test   %eax,%eax
  10001b:	78 60                	js     10007d <process_main+0x7d>
    asm volatile ("int %1" : "=a" (result)
  10001d:	cd 31                	int    $0x31

    // Check fork return values: fork should return 0 to child.
    if (sys_getpid() == 1) {
  10001f:	83 f8 01             	cmp    $0x1,%eax
  100022:	74 6d                	je     100091 <process_main+0x91>
        assert(p1 != 0 && p2 != 0 && p1 != p2);
    } else {
        assert(p1 == 0 || p2 == 0);
  100024:	45 85 e4             	test   %r12d,%r12d
  100027:	74 09                	je     100032 <process_main+0x32>
  100029:	45 85 f6             	test   %r14d,%r14d
  10002c:	0f 85 88 00 00 00    	jne    1000ba <process_main+0xba>
  100032:	cd 31                	int    $0x31
  100034:	89 c3                	mov    %eax,%ebx
    }

    // The rest of this code is like p-allocator.c.

    pid_t p = sys_getpid();
    srand(p);
  100036:	89 c7                	mov    %eax,%edi
  100038:	e8 9b 05 00 00       	call   1005d8 <srand>

    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10003d:	b8 37 40 10 00       	mov    $0x104037,%eax
  100042:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100048:	48 89 05 d9 2f 00 00 	mov    %rax,0x2fd9(%rip)        # 103028 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10004f:	48 89 e0             	mov    %rsp,%rax
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100052:	48 83 e8 01          	sub    $0x1,%rax
  100056:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10005c:	48 89 05 bd 2f 00 00 	mov    %rax,0x2fbd(%rip)        # 103020 <stack_bottom>
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
                break;
            }
            *heap_top = p;      /* check we have write access to new page */
            heap_top += PAGESIZE;
            padding_page[0] = p1 + preamble[(uint8_t)p1];
  100063:	45 0f b6 ec          	movzbl %r12b,%r13d
  100067:	eb 67                	jmp    1000d0 <process_main+0xd0>
    assert(p1 >= 0);
  100069:	ba 40 13 10 00       	mov    $0x101340,%edx
  10006e:	be 3a 00 00 00       	mov    $0x3a,%esi
  100073:	bf 48 13 10 00       	mov    $0x101348,%edi
  100078:	e8 35 02 00 00       	call   1002b2 <assert_fail>
    assert(p2 >= 0);
  10007d:	ba 58 13 10 00       	mov    $0x101358,%edx
  100082:	be 3c 00 00 00       	mov    $0x3c,%esi
  100087:	bf 48 13 10 00       	mov    $0x101348,%edi
  10008c:	e8 21 02 00 00       	call   1002b2 <assert_fail>
        assert(p1 != 0 && p2 != 0 && p1 != p2);
  100091:	45 85 f6             	test   %r14d,%r14d
  100094:	0f 94 c0             	sete   %al
  100097:	45 39 f4             	cmp    %r14d,%r12d
  10009a:	0f 94 c2             	sete   %dl
  10009d:	08 d0                	or     %dl,%al
  10009f:	75 05                	jne    1000a6 <process_main+0xa6>
  1000a1:	45 85 e4             	test   %r12d,%r12d
  1000a4:	75 8c                	jne    100032 <process_main+0x32>
  1000a6:	ba 90 13 10 00       	mov    $0x101390,%edx
  1000ab:	be 40 00 00 00       	mov    $0x40,%esi
  1000b0:	bf 48 13 10 00       	mov    $0x101348,%edi
  1000b5:	e8 f8 01 00 00       	call   1002b2 <assert_fail>
        assert(p1 == 0 || p2 == 0);
  1000ba:	ba 60 13 10 00       	mov    $0x101360,%edx
  1000bf:	be 42 00 00 00       	mov    $0x42,%esi
  1000c4:	bf 48 13 10 00       	mov    $0x101348,%edi
  1000c9:	e8 e4 01 00 00       	call   1002b2 <assert_fail>
    asm volatile ("int %0" : /* no result */
  1000ce:	cd 32                	int    $0x32
        if ((rand() % ALLOC_SLOWDOWN) < p) {
  1000d0:	e8 c7 04 00 00       	call   10059c <rand>
  1000d5:	48 63 d0             	movslq %eax,%rdx
  1000d8:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  1000df:	48 c1 fa 25          	sar    $0x25,%rdx
  1000e3:	89 c1                	mov    %eax,%ecx
  1000e5:	c1 f9 1f             	sar    $0x1f,%ecx
  1000e8:	29 ca                	sub    %ecx,%edx
  1000ea:	6b d2 64             	imul   $0x64,%edx,%edx
  1000ed:	29 d0                	sub    %edx,%eax
  1000ef:	39 d8                	cmp    %ebx,%eax
  1000f1:	7d db                	jge    1000ce <process_main+0xce>
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
  1000f3:	48 8b 3d 2e 2f 00 00 	mov    0x2f2e(%rip),%rdi        # 103028 <heap_top>
  1000fa:	48 3b 3d 1f 2f 00 00 	cmp    0x2f1f(%rip),%rdi        # 103020 <stack_bottom>
  100101:	74 31                	je     100134 <process_main+0x134>
    asm volatile ("int %1"		// generates a "INT_SYS_PAGE_ALLOC" type interrupt 
  100103:	cd 33                	int    $0x33
  100105:	85 c0                	test   %eax,%eax
  100107:	78 2b                	js     100134 <process_main+0x134>
            *heap_top = p;      /* check we have write access to new page */
  100109:	48 8b 05 18 2f 00 00 	mov    0x2f18(%rip),%rax        # 103028 <heap_top>
  100110:	88 18                	mov    %bl,(%rax)
            heap_top += PAGESIZE;
  100112:	48 81 05 0b 2f 00 00 	addq   $0x1000,0x2f0b(%rip)        # 103028 <heap_top>
  100119:	00 10 00 00 
            padding_page[0] = p1 + preamble[(uint8_t)p1];
  10011d:	48 8b 05 dc 1e 00 00 	mov    0x1edc(%rip),%rax        # 102000 <preamble>
  100124:	44 89 e6             	mov    %r12d,%esi
  100127:	42 02 34 28          	add    (%rax,%r13,1),%sil
  10012b:	40 88 35 ee 1e 00 00 	mov    %sil,0x1eee(%rip)        # 102020 <padding_page>
  100132:	eb 9a                	jmp    1000ce <process_main+0xce>
    asm volatile ("int %0" : /* no result */
  100134:	cd 32                	int    $0x32
  100136:	cd 32                	int    $0x32
        sys_yield();
    }

    sys_yield();
    sys_yield();
    if(p1 != 0 && p2 != 0) // parent
  100138:	45 85 e4             	test   %r12d,%r12d
  10013b:	74 05                	je     100142 <process_main+0x142>
  10013d:	45 85 f6             	test   %r14d,%r14d
  100140:	75 04                	jne    100146 <process_main+0x146>
  100142:	cd 32                	int    $0x32
  100144:	eb fc                	jmp    100142 <process_main+0x142>
        TEST_PASS();
  100146:	bf 73 13 10 00       	mov    $0x101373,%edi
  10014b:	b8 00 00 00 00       	mov    $0x0,%eax
  100150:	e8 90 00 00 00       	call   1001e5 <panic>

0000000000100155 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100155:	55                   	push   %rbp
  100156:	48 89 e5             	mov    %rsp,%rbp
  100159:	48 83 ec 50          	sub    $0x50,%rsp
  10015d:	49 89 f2             	mov    %rsi,%r10
  100160:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100164:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100168:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10016c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  100170:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100175:	85 ff                	test   %edi,%edi
  100177:	78 2e                	js     1001a7 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  100179:	48 63 ff             	movslq %edi,%rdi
  10017c:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  100183:	cc cc cc 
  100186:	48 89 f8             	mov    %rdi,%rax
  100189:	48 f7 e2             	mul    %rdx
  10018c:	48 89 d0             	mov    %rdx,%rax
  10018f:	48 c1 e8 02          	shr    $0x2,%rax
  100193:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  100197:	48 01 c2             	add    %rax,%rdx
  10019a:	48 29 d7             	sub    %rdx,%rdi
  10019d:	0f b6 b7 5d 1c 10 00 	movzbl 0x101c5d(%rdi),%esi
  1001a4:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  1001a7:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  1001ae:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1001b2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1001b6:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1001ba:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  1001be:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1001c2:	4c 89 d2             	mov    %r10,%rdx
  1001c5:	8b 3d 31 8e fb ff    	mov    -0x471cf(%rip),%edi        # b8ffc <cursorpos>
  1001cb:	e8 5a 0f 00 00       	call   10112a <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  1001d0:	3d 30 07 00 00       	cmp    $0x730,%eax
  1001d5:	ba 00 00 00 00       	mov    $0x0,%edx
  1001da:	0f 4d c2             	cmovge %edx,%eax
  1001dd:	89 05 19 8e fb ff    	mov    %eax,-0x471e7(%rip)        # b8ffc <cursorpos>
    }
}
  1001e3:	c9                   	leave  
  1001e4:	c3                   	ret    

00000000001001e5 <panic>:


// panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
  1001e5:	55                   	push   %rbp
  1001e6:	48 89 e5             	mov    %rsp,%rbp
  1001e9:	53                   	push   %rbx
  1001ea:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  1001f1:	48 89 fb             	mov    %rdi,%rbx
  1001f4:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  1001f8:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  1001fc:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100200:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100204:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  100208:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  10020f:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100213:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100217:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  10021b:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  10021f:	ba 07 00 00 00       	mov    $0x7,%edx
  100224:	be 29 1c 10 00       	mov    $0x101c29,%esi
  100229:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100230:	e8 ac 00 00 00       	call   1002e1 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100235:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100239:	48 89 da             	mov    %rbx,%rdx
  10023c:	be 99 00 00 00       	mov    $0x99,%esi
  100241:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100248:	e8 e9 0f 00 00       	call   101236 <vsnprintf>
  10024d:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100250:	85 d2                	test   %edx,%edx
  100252:	7e 0f                	jle    100263 <panic+0x7e>
  100254:	83 c0 06             	add    $0x6,%eax
  100257:	48 98                	cltq   
  100259:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  100260:	0a 
  100261:	75 29                	jne    10028c <panic+0xa7>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  100263:	48 8d 8d 08 ff ff ff 	lea    -0xf8(%rbp),%rcx
  10026a:	ba 33 1c 10 00       	mov    $0x101c33,%edx
  10026f:	be 00 c0 00 00       	mov    $0xc000,%esi
  100274:	bf 30 07 00 00       	mov    $0x730,%edi
  100279:	b8 00 00 00 00       	mov    $0x0,%eax
  10027e:	e8 13 0f 00 00       	call   101196 <console_printf>
}

// sys_panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) sys_panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  100283:	bf 00 00 00 00       	mov    $0x0,%edi
  100288:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  10028a:	eb fe                	jmp    10028a <panic+0xa5>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  10028c:	48 63 c2             	movslq %edx,%rax
  10028f:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  100295:	0f 94 c2             	sete   %dl
  100298:	0f b6 d2             	movzbl %dl,%edx
  10029b:	48 29 d0             	sub    %rdx,%rax
  10029e:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  1002a5:	ff 
  1002a6:	be 31 1c 10 00       	mov    $0x101c31,%esi
  1002ab:	e8 de 01 00 00       	call   10048e <strcpy>
  1002b0:	eb b1                	jmp    100263 <panic+0x7e>

00000000001002b2 <assert_fail>:
    sys_panic(NULL);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  1002b2:	55                   	push   %rbp
  1002b3:	48 89 e5             	mov    %rsp,%rbp
  1002b6:	48 89 f9             	mov    %rdi,%rcx
  1002b9:	41 89 f0             	mov    %esi,%r8d
  1002bc:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  1002bf:	ba 38 1c 10 00       	mov    $0x101c38,%edx
  1002c4:	be 00 c0 00 00       	mov    $0xc000,%esi
  1002c9:	bf 30 07 00 00       	mov    $0x730,%edi
  1002ce:	b8 00 00 00 00       	mov    $0x0,%eax
  1002d3:	e8 be 0e 00 00       	call   101196 <console_printf>
    asm volatile ("int %0" : /* no result */
  1002d8:	bf 00 00 00 00       	mov    $0x0,%edi
  1002dd:	cd 30                	int    $0x30
 loop: goto loop;
  1002df:	eb fe                	jmp    1002df <assert_fail+0x2d>

00000000001002e1 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  1002e1:	55                   	push   %rbp
  1002e2:	48 89 e5             	mov    %rsp,%rbp
  1002e5:	48 83 ec 28          	sub    $0x28,%rsp
  1002e9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1002ed:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1002f1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1002f5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1002f9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1002fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100301:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100305:	eb 1c                	jmp    100323 <memcpy+0x42>
        *d = *s;
  100307:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10030b:	0f b6 10             	movzbl (%rax),%edx
  10030e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100312:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100314:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100319:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10031e:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100323:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100328:	75 dd                	jne    100307 <memcpy+0x26>
    }
    return dst;
  10032a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10032e:	c9                   	leave  
  10032f:	c3                   	ret    

0000000000100330 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100330:	55                   	push   %rbp
  100331:	48 89 e5             	mov    %rsp,%rbp
  100334:	48 83 ec 28          	sub    $0x28,%rsp
  100338:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10033c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100340:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100344:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100348:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  10034c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100350:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100354:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100358:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  10035c:	73 6a                	jae    1003c8 <memmove+0x98>
  10035e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100362:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100366:	48 01 d0             	add    %rdx,%rax
  100369:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  10036d:	73 59                	jae    1003c8 <memmove+0x98>
        s += n, d += n;
  10036f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100373:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100377:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10037b:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  10037f:	eb 17                	jmp    100398 <memmove+0x68>
            *--d = *--s;
  100381:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100386:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  10038b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10038f:	0f b6 10             	movzbl (%rax),%edx
  100392:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100396:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100398:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10039c:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1003a0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1003a4:	48 85 c0             	test   %rax,%rax
  1003a7:	75 d8                	jne    100381 <memmove+0x51>
    if (s < d && s + n > d) {
  1003a9:	eb 2e                	jmp    1003d9 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1003ab:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1003af:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1003b3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1003b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003bb:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1003bf:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  1003c3:	0f b6 12             	movzbl (%rdx),%edx
  1003c6:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1003c8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1003cc:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1003d0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1003d4:	48 85 c0             	test   %rax,%rax
  1003d7:	75 d2                	jne    1003ab <memmove+0x7b>
        }
    }
    return dst;
  1003d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1003dd:	c9                   	leave  
  1003de:	c3                   	ret    

00000000001003df <memset>:

void* memset(void* v, int c, size_t n) {
  1003df:	55                   	push   %rbp
  1003e0:	48 89 e5             	mov    %rsp,%rbp
  1003e3:	48 83 ec 28          	sub    $0x28,%rsp
  1003e7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1003eb:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  1003ee:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1003f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1003f6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1003fa:	eb 15                	jmp    100411 <memset+0x32>
        *p = c;
  1003fc:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1003ff:	89 c2                	mov    %eax,%edx
  100401:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100405:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100407:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10040c:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100411:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100416:	75 e4                	jne    1003fc <memset+0x1d>
    }
    return v;
  100418:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10041c:	c9                   	leave  
  10041d:	c3                   	ret    

000000000010041e <strlen>:

size_t strlen(const char* s) {
  10041e:	55                   	push   %rbp
  10041f:	48 89 e5             	mov    %rsp,%rbp
  100422:	48 83 ec 18          	sub    $0x18,%rsp
  100426:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  10042a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100431:	00 
  100432:	eb 0a                	jmp    10043e <strlen+0x20>
        ++n;
  100434:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100439:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  10043e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100442:	0f b6 00             	movzbl (%rax),%eax
  100445:	84 c0                	test   %al,%al
  100447:	75 eb                	jne    100434 <strlen+0x16>
    }
    return n;
  100449:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  10044d:	c9                   	leave  
  10044e:	c3                   	ret    

000000000010044f <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  10044f:	55                   	push   %rbp
  100450:	48 89 e5             	mov    %rsp,%rbp
  100453:	48 83 ec 20          	sub    $0x20,%rsp
  100457:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10045b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  10045f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100466:	00 
  100467:	eb 0a                	jmp    100473 <strnlen+0x24>
        ++n;
  100469:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  10046e:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100473:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100477:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  10047b:	74 0b                	je     100488 <strnlen+0x39>
  10047d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100481:	0f b6 00             	movzbl (%rax),%eax
  100484:	84 c0                	test   %al,%al
  100486:	75 e1                	jne    100469 <strnlen+0x1a>
    }
    return n;
  100488:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  10048c:	c9                   	leave  
  10048d:	c3                   	ret    

000000000010048e <strcpy>:

char* strcpy(char* dst, const char* src) {
  10048e:	55                   	push   %rbp
  10048f:	48 89 e5             	mov    %rsp,%rbp
  100492:	48 83 ec 20          	sub    $0x20,%rsp
  100496:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10049a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  10049e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1004a2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1004a6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1004aa:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1004ae:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1004b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004b6:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1004ba:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  1004be:	0f b6 12             	movzbl (%rdx),%edx
  1004c1:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  1004c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004c7:	48 83 e8 01          	sub    $0x1,%rax
  1004cb:	0f b6 00             	movzbl (%rax),%eax
  1004ce:	84 c0                	test   %al,%al
  1004d0:	75 d4                	jne    1004a6 <strcpy+0x18>
    return dst;
  1004d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1004d6:	c9                   	leave  
  1004d7:	c3                   	ret    

00000000001004d8 <strcmp>:

int strcmp(const char* a, const char* b) {
  1004d8:	55                   	push   %rbp
  1004d9:	48 89 e5             	mov    %rsp,%rbp
  1004dc:	48 83 ec 10          	sub    $0x10,%rsp
  1004e0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1004e4:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1004e8:	eb 0a                	jmp    1004f4 <strcmp+0x1c>
        ++a, ++b;
  1004ea:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1004ef:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1004f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004f8:	0f b6 00             	movzbl (%rax),%eax
  1004fb:	84 c0                	test   %al,%al
  1004fd:	74 1d                	je     10051c <strcmp+0x44>
  1004ff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100503:	0f b6 00             	movzbl (%rax),%eax
  100506:	84 c0                	test   %al,%al
  100508:	74 12                	je     10051c <strcmp+0x44>
  10050a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10050e:	0f b6 10             	movzbl (%rax),%edx
  100511:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100515:	0f b6 00             	movzbl (%rax),%eax
  100518:	38 c2                	cmp    %al,%dl
  10051a:	74 ce                	je     1004ea <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  10051c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100520:	0f b6 00             	movzbl (%rax),%eax
  100523:	89 c2                	mov    %eax,%edx
  100525:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100529:	0f b6 00             	movzbl (%rax),%eax
  10052c:	38 d0                	cmp    %dl,%al
  10052e:	0f 92 c0             	setb   %al
  100531:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100534:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100538:	0f b6 00             	movzbl (%rax),%eax
  10053b:	89 c1                	mov    %eax,%ecx
  10053d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100541:	0f b6 00             	movzbl (%rax),%eax
  100544:	38 c1                	cmp    %al,%cl
  100546:	0f 92 c0             	setb   %al
  100549:	0f b6 c0             	movzbl %al,%eax
  10054c:	29 c2                	sub    %eax,%edx
  10054e:	89 d0                	mov    %edx,%eax
}
  100550:	c9                   	leave  
  100551:	c3                   	ret    

0000000000100552 <strchr>:

char* strchr(const char* s, int c) {
  100552:	55                   	push   %rbp
  100553:	48 89 e5             	mov    %rsp,%rbp
  100556:	48 83 ec 10          	sub    $0x10,%rsp
  10055a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  10055e:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100561:	eb 05                	jmp    100568 <strchr+0x16>
        ++s;
  100563:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100568:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10056c:	0f b6 00             	movzbl (%rax),%eax
  10056f:	84 c0                	test   %al,%al
  100571:	74 0e                	je     100581 <strchr+0x2f>
  100573:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100577:	0f b6 00             	movzbl (%rax),%eax
  10057a:	8b 55 f4             	mov    -0xc(%rbp),%edx
  10057d:	38 d0                	cmp    %dl,%al
  10057f:	75 e2                	jne    100563 <strchr+0x11>
    }
    if (*s == (char) c) {
  100581:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100585:	0f b6 00             	movzbl (%rax),%eax
  100588:	8b 55 f4             	mov    -0xc(%rbp),%edx
  10058b:	38 d0                	cmp    %dl,%al
  10058d:	75 06                	jne    100595 <strchr+0x43>
        return (char*) s;
  10058f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100593:	eb 05                	jmp    10059a <strchr+0x48>
    } else {
        return NULL;
  100595:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  10059a:	c9                   	leave  
  10059b:	c3                   	ret    

000000000010059c <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  10059c:	55                   	push   %rbp
  10059d:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1005a0:	8b 05 8a 2a 00 00    	mov    0x2a8a(%rip),%eax        # 103030 <rand_seed_set>
  1005a6:	85 c0                	test   %eax,%eax
  1005a8:	75 0a                	jne    1005b4 <rand+0x18>
        srand(819234718U);
  1005aa:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1005af:	e8 24 00 00 00       	call   1005d8 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1005b4:	8b 05 7a 2a 00 00    	mov    0x2a7a(%rip),%eax        # 103034 <rand_seed>
  1005ba:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  1005c0:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1005c5:	89 05 69 2a 00 00    	mov    %eax,0x2a69(%rip)        # 103034 <rand_seed>
    return rand_seed & RAND_MAX;
  1005cb:	8b 05 63 2a 00 00    	mov    0x2a63(%rip),%eax        # 103034 <rand_seed>
  1005d1:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1005d6:	5d                   	pop    %rbp
  1005d7:	c3                   	ret    

00000000001005d8 <srand>:

void srand(unsigned seed) {
  1005d8:	55                   	push   %rbp
  1005d9:	48 89 e5             	mov    %rsp,%rbp
  1005dc:	48 83 ec 08          	sub    $0x8,%rsp
  1005e0:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  1005e3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1005e6:	89 05 48 2a 00 00    	mov    %eax,0x2a48(%rip)        # 103034 <rand_seed>
    rand_seed_set = 1;
  1005ec:	c7 05 3a 2a 00 00 01 	movl   $0x1,0x2a3a(%rip)        # 103030 <rand_seed_set>
  1005f3:	00 00 00 
}
  1005f6:	90                   	nop
  1005f7:	c9                   	leave  
  1005f8:	c3                   	ret    

00000000001005f9 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  1005f9:	55                   	push   %rbp
  1005fa:	48 89 e5             	mov    %rsp,%rbp
  1005fd:	48 83 ec 28          	sub    $0x28,%rsp
  100601:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100605:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100609:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  10060c:	48 c7 45 f8 50 1e 10 	movq   $0x101e50,-0x8(%rbp)
  100613:	00 
    if (base < 0) {
  100614:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100618:	79 0b                	jns    100625 <fill_numbuf+0x2c>
        digits = lower_digits;
  10061a:	48 c7 45 f8 70 1e 10 	movq   $0x101e70,-0x8(%rbp)
  100621:	00 
        base = -base;
  100622:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100625:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10062a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10062e:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100631:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100634:	48 63 c8             	movslq %eax,%rcx
  100637:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10063b:	ba 00 00 00 00       	mov    $0x0,%edx
  100640:	48 f7 f1             	div    %rcx
  100643:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100647:	48 01 d0             	add    %rdx,%rax
  10064a:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10064f:	0f b6 10             	movzbl (%rax),%edx
  100652:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100656:	88 10                	mov    %dl,(%rax)
        val /= base;
  100658:	8b 45 dc             	mov    -0x24(%rbp),%eax
  10065b:	48 63 f0             	movslq %eax,%rsi
  10065e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100662:	ba 00 00 00 00       	mov    $0x0,%edx
  100667:	48 f7 f6             	div    %rsi
  10066a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  10066e:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100673:	75 bc                	jne    100631 <fill_numbuf+0x38>
    return numbuf_end;
  100675:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100679:	c9                   	leave  
  10067a:	c3                   	ret    

000000000010067b <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  10067b:	55                   	push   %rbp
  10067c:	48 89 e5             	mov    %rsp,%rbp
  10067f:	53                   	push   %rbx
  100680:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100687:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  10068e:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100694:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10069b:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1006a2:	e9 8a 09 00 00       	jmp    101031 <printer_vprintf+0x9b6>
        if (*format != '%') {
  1006a7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006ae:	0f b6 00             	movzbl (%rax),%eax
  1006b1:	3c 25                	cmp    $0x25,%al
  1006b3:	74 31                	je     1006e6 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  1006b5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1006bc:	4c 8b 00             	mov    (%rax),%r8
  1006bf:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006c6:	0f b6 00             	movzbl (%rax),%eax
  1006c9:	0f b6 c8             	movzbl %al,%ecx
  1006cc:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1006d2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1006d9:	89 ce                	mov    %ecx,%esi
  1006db:	48 89 c7             	mov    %rax,%rdi
  1006de:	41 ff d0             	call   *%r8
            continue;
  1006e1:	e9 43 09 00 00       	jmp    101029 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  1006e6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  1006ed:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1006f4:	01 
  1006f5:	eb 44                	jmp    10073b <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  1006f7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006fe:	0f b6 00             	movzbl (%rax),%eax
  100701:	0f be c0             	movsbl %al,%eax
  100704:	89 c6                	mov    %eax,%esi
  100706:	bf 70 1c 10 00       	mov    $0x101c70,%edi
  10070b:	e8 42 fe ff ff       	call   100552 <strchr>
  100710:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100714:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100719:	74 30                	je     10074b <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  10071b:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  10071f:	48 2d 70 1c 10 00    	sub    $0x101c70,%rax
  100725:	ba 01 00 00 00       	mov    $0x1,%edx
  10072a:	89 c1                	mov    %eax,%ecx
  10072c:	d3 e2                	shl    %cl,%edx
  10072e:	89 d0                	mov    %edx,%eax
  100730:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100733:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10073a:	01 
  10073b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100742:	0f b6 00             	movzbl (%rax),%eax
  100745:	84 c0                	test   %al,%al
  100747:	75 ae                	jne    1006f7 <printer_vprintf+0x7c>
  100749:	eb 01                	jmp    10074c <printer_vprintf+0xd1>
            } else {
                break;
  10074b:	90                   	nop
            }
        }

        // process width
        int width = -1;
  10074c:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100753:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10075a:	0f b6 00             	movzbl (%rax),%eax
  10075d:	3c 30                	cmp    $0x30,%al
  10075f:	7e 67                	jle    1007c8 <printer_vprintf+0x14d>
  100761:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100768:	0f b6 00             	movzbl (%rax),%eax
  10076b:	3c 39                	cmp    $0x39,%al
  10076d:	7f 59                	jg     1007c8 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10076f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100776:	eb 2e                	jmp    1007a6 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100778:	8b 55 e8             	mov    -0x18(%rbp),%edx
  10077b:	89 d0                	mov    %edx,%eax
  10077d:	c1 e0 02             	shl    $0x2,%eax
  100780:	01 d0                	add    %edx,%eax
  100782:	01 c0                	add    %eax,%eax
  100784:	89 c1                	mov    %eax,%ecx
  100786:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10078d:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100791:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100798:	0f b6 00             	movzbl (%rax),%eax
  10079b:	0f be c0             	movsbl %al,%eax
  10079e:	01 c8                	add    %ecx,%eax
  1007a0:	83 e8 30             	sub    $0x30,%eax
  1007a3:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1007a6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007ad:	0f b6 00             	movzbl (%rax),%eax
  1007b0:	3c 2f                	cmp    $0x2f,%al
  1007b2:	0f 8e 85 00 00 00    	jle    10083d <printer_vprintf+0x1c2>
  1007b8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007bf:	0f b6 00             	movzbl (%rax),%eax
  1007c2:	3c 39                	cmp    $0x39,%al
  1007c4:	7e b2                	jle    100778 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  1007c6:	eb 75                	jmp    10083d <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  1007c8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007cf:	0f b6 00             	movzbl (%rax),%eax
  1007d2:	3c 2a                	cmp    $0x2a,%al
  1007d4:	75 68                	jne    10083e <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  1007d6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007dd:	8b 00                	mov    (%rax),%eax
  1007df:	83 f8 2f             	cmp    $0x2f,%eax
  1007e2:	77 30                	ja     100814 <printer_vprintf+0x199>
  1007e4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007eb:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1007ef:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007f6:	8b 00                	mov    (%rax),%eax
  1007f8:	89 c0                	mov    %eax,%eax
  1007fa:	48 01 d0             	add    %rdx,%rax
  1007fd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100804:	8b 12                	mov    (%rdx),%edx
  100806:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100809:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100810:	89 0a                	mov    %ecx,(%rdx)
  100812:	eb 1a                	jmp    10082e <printer_vprintf+0x1b3>
  100814:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10081b:	48 8b 40 08          	mov    0x8(%rax),%rax
  10081f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100823:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10082a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10082e:	8b 00                	mov    (%rax),%eax
  100830:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100833:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10083a:	01 
  10083b:	eb 01                	jmp    10083e <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  10083d:	90                   	nop
        }

        // process precision
        int precision = -1;
  10083e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100845:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10084c:	0f b6 00             	movzbl (%rax),%eax
  10084f:	3c 2e                	cmp    $0x2e,%al
  100851:	0f 85 00 01 00 00    	jne    100957 <printer_vprintf+0x2dc>
            ++format;
  100857:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10085e:	01 
            if (*format >= '0' && *format <= '9') {
  10085f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100866:	0f b6 00             	movzbl (%rax),%eax
  100869:	3c 2f                	cmp    $0x2f,%al
  10086b:	7e 67                	jle    1008d4 <printer_vprintf+0x259>
  10086d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100874:	0f b6 00             	movzbl (%rax),%eax
  100877:	3c 39                	cmp    $0x39,%al
  100879:	7f 59                	jg     1008d4 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10087b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100882:	eb 2e                	jmp    1008b2 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100884:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100887:	89 d0                	mov    %edx,%eax
  100889:	c1 e0 02             	shl    $0x2,%eax
  10088c:	01 d0                	add    %edx,%eax
  10088e:	01 c0                	add    %eax,%eax
  100890:	89 c1                	mov    %eax,%ecx
  100892:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100899:	48 8d 50 01          	lea    0x1(%rax),%rdx
  10089d:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1008a4:	0f b6 00             	movzbl (%rax),%eax
  1008a7:	0f be c0             	movsbl %al,%eax
  1008aa:	01 c8                	add    %ecx,%eax
  1008ac:	83 e8 30             	sub    $0x30,%eax
  1008af:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1008b2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008b9:	0f b6 00             	movzbl (%rax),%eax
  1008bc:	3c 2f                	cmp    $0x2f,%al
  1008be:	0f 8e 85 00 00 00    	jle    100949 <printer_vprintf+0x2ce>
  1008c4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008cb:	0f b6 00             	movzbl (%rax),%eax
  1008ce:	3c 39                	cmp    $0x39,%al
  1008d0:	7e b2                	jle    100884 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  1008d2:	eb 75                	jmp    100949 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  1008d4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008db:	0f b6 00             	movzbl (%rax),%eax
  1008de:	3c 2a                	cmp    $0x2a,%al
  1008e0:	75 68                	jne    10094a <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  1008e2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008e9:	8b 00                	mov    (%rax),%eax
  1008eb:	83 f8 2f             	cmp    $0x2f,%eax
  1008ee:	77 30                	ja     100920 <printer_vprintf+0x2a5>
  1008f0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008f7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1008fb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100902:	8b 00                	mov    (%rax),%eax
  100904:	89 c0                	mov    %eax,%eax
  100906:	48 01 d0             	add    %rdx,%rax
  100909:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100910:	8b 12                	mov    (%rdx),%edx
  100912:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100915:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10091c:	89 0a                	mov    %ecx,(%rdx)
  10091e:	eb 1a                	jmp    10093a <printer_vprintf+0x2bf>
  100920:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100927:	48 8b 40 08          	mov    0x8(%rax),%rax
  10092b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10092f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100936:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10093a:	8b 00                	mov    (%rax),%eax
  10093c:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  10093f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100946:	01 
  100947:	eb 01                	jmp    10094a <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100949:	90                   	nop
            }
            if (precision < 0) {
  10094a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  10094e:	79 07                	jns    100957 <printer_vprintf+0x2dc>
                precision = 0;
  100950:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100957:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  10095e:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100965:	00 
        int length = 0;
  100966:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  10096d:	48 c7 45 c8 76 1c 10 	movq   $0x101c76,-0x38(%rbp)
  100974:	00 
    again:
        switch (*format) {
  100975:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10097c:	0f b6 00             	movzbl (%rax),%eax
  10097f:	0f be c0             	movsbl %al,%eax
  100982:	83 e8 43             	sub    $0x43,%eax
  100985:	83 f8 37             	cmp    $0x37,%eax
  100988:	0f 87 9f 03 00 00    	ja     100d2d <printer_vprintf+0x6b2>
  10098e:	89 c0                	mov    %eax,%eax
  100990:	48 8b 04 c5 88 1c 10 	mov    0x101c88(,%rax,8),%rax
  100997:	00 
  100998:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  10099a:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  1009a1:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1009a8:	01 
            goto again;
  1009a9:	eb ca                	jmp    100975 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1009ab:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1009af:	74 5d                	je     100a0e <printer_vprintf+0x393>
  1009b1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009b8:	8b 00                	mov    (%rax),%eax
  1009ba:	83 f8 2f             	cmp    $0x2f,%eax
  1009bd:	77 30                	ja     1009ef <printer_vprintf+0x374>
  1009bf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009c6:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1009ca:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009d1:	8b 00                	mov    (%rax),%eax
  1009d3:	89 c0                	mov    %eax,%eax
  1009d5:	48 01 d0             	add    %rdx,%rax
  1009d8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009df:	8b 12                	mov    (%rdx),%edx
  1009e1:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1009e4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009eb:	89 0a                	mov    %ecx,(%rdx)
  1009ed:	eb 1a                	jmp    100a09 <printer_vprintf+0x38e>
  1009ef:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009f6:	48 8b 40 08          	mov    0x8(%rax),%rax
  1009fa:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1009fe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a05:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a09:	48 8b 00             	mov    (%rax),%rax
  100a0c:	eb 5c                	jmp    100a6a <printer_vprintf+0x3ef>
  100a0e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a15:	8b 00                	mov    (%rax),%eax
  100a17:	83 f8 2f             	cmp    $0x2f,%eax
  100a1a:	77 30                	ja     100a4c <printer_vprintf+0x3d1>
  100a1c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a23:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a27:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a2e:	8b 00                	mov    (%rax),%eax
  100a30:	89 c0                	mov    %eax,%eax
  100a32:	48 01 d0             	add    %rdx,%rax
  100a35:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a3c:	8b 12                	mov    (%rdx),%edx
  100a3e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a41:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a48:	89 0a                	mov    %ecx,(%rdx)
  100a4a:	eb 1a                	jmp    100a66 <printer_vprintf+0x3eb>
  100a4c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a53:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a57:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a5b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a62:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a66:	8b 00                	mov    (%rax),%eax
  100a68:	48 98                	cltq   
  100a6a:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100a6e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a72:	48 c1 f8 38          	sar    $0x38,%rax
  100a76:	25 80 00 00 00       	and    $0x80,%eax
  100a7b:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100a7e:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100a82:	74 09                	je     100a8d <printer_vprintf+0x412>
  100a84:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a88:	48 f7 d8             	neg    %rax
  100a8b:	eb 04                	jmp    100a91 <printer_vprintf+0x416>
  100a8d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a91:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100a95:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100a98:	83 c8 60             	or     $0x60,%eax
  100a9b:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100a9e:	e9 cf 02 00 00       	jmp    100d72 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100aa3:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100aa7:	74 5d                	je     100b06 <printer_vprintf+0x48b>
  100aa9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ab0:	8b 00                	mov    (%rax),%eax
  100ab2:	83 f8 2f             	cmp    $0x2f,%eax
  100ab5:	77 30                	ja     100ae7 <printer_vprintf+0x46c>
  100ab7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100abe:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ac2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ac9:	8b 00                	mov    (%rax),%eax
  100acb:	89 c0                	mov    %eax,%eax
  100acd:	48 01 d0             	add    %rdx,%rax
  100ad0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ad7:	8b 12                	mov    (%rdx),%edx
  100ad9:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100adc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ae3:	89 0a                	mov    %ecx,(%rdx)
  100ae5:	eb 1a                	jmp    100b01 <printer_vprintf+0x486>
  100ae7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100aee:	48 8b 40 08          	mov    0x8(%rax),%rax
  100af2:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100af6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100afd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b01:	48 8b 00             	mov    (%rax),%rax
  100b04:	eb 5c                	jmp    100b62 <printer_vprintf+0x4e7>
  100b06:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b0d:	8b 00                	mov    (%rax),%eax
  100b0f:	83 f8 2f             	cmp    $0x2f,%eax
  100b12:	77 30                	ja     100b44 <printer_vprintf+0x4c9>
  100b14:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b1b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b1f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b26:	8b 00                	mov    (%rax),%eax
  100b28:	89 c0                	mov    %eax,%eax
  100b2a:	48 01 d0             	add    %rdx,%rax
  100b2d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b34:	8b 12                	mov    (%rdx),%edx
  100b36:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b39:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b40:	89 0a                	mov    %ecx,(%rdx)
  100b42:	eb 1a                	jmp    100b5e <printer_vprintf+0x4e3>
  100b44:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b4b:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b4f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b53:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b5a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b5e:	8b 00                	mov    (%rax),%eax
  100b60:	89 c0                	mov    %eax,%eax
  100b62:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100b66:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100b6a:	e9 03 02 00 00       	jmp    100d72 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100b6f:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100b76:	e9 28 ff ff ff       	jmp    100aa3 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100b7b:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100b82:	e9 1c ff ff ff       	jmp    100aa3 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100b87:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b8e:	8b 00                	mov    (%rax),%eax
  100b90:	83 f8 2f             	cmp    $0x2f,%eax
  100b93:	77 30                	ja     100bc5 <printer_vprintf+0x54a>
  100b95:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b9c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ba0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ba7:	8b 00                	mov    (%rax),%eax
  100ba9:	89 c0                	mov    %eax,%eax
  100bab:	48 01 d0             	add    %rdx,%rax
  100bae:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bb5:	8b 12                	mov    (%rdx),%edx
  100bb7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bba:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bc1:	89 0a                	mov    %ecx,(%rdx)
  100bc3:	eb 1a                	jmp    100bdf <printer_vprintf+0x564>
  100bc5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bcc:	48 8b 40 08          	mov    0x8(%rax),%rax
  100bd0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100bd4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bdb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100bdf:	48 8b 00             	mov    (%rax),%rax
  100be2:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100be6:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100bed:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100bf4:	e9 79 01 00 00       	jmp    100d72 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100bf9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c00:	8b 00                	mov    (%rax),%eax
  100c02:	83 f8 2f             	cmp    $0x2f,%eax
  100c05:	77 30                	ja     100c37 <printer_vprintf+0x5bc>
  100c07:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c0e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c12:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c19:	8b 00                	mov    (%rax),%eax
  100c1b:	89 c0                	mov    %eax,%eax
  100c1d:	48 01 d0             	add    %rdx,%rax
  100c20:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c27:	8b 12                	mov    (%rdx),%edx
  100c29:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c2c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c33:	89 0a                	mov    %ecx,(%rdx)
  100c35:	eb 1a                	jmp    100c51 <printer_vprintf+0x5d6>
  100c37:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c3e:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c42:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c46:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c4d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c51:	48 8b 00             	mov    (%rax),%rax
  100c54:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100c58:	e9 15 01 00 00       	jmp    100d72 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100c5d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c64:	8b 00                	mov    (%rax),%eax
  100c66:	83 f8 2f             	cmp    $0x2f,%eax
  100c69:	77 30                	ja     100c9b <printer_vprintf+0x620>
  100c6b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c72:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c76:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c7d:	8b 00                	mov    (%rax),%eax
  100c7f:	89 c0                	mov    %eax,%eax
  100c81:	48 01 d0             	add    %rdx,%rax
  100c84:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c8b:	8b 12                	mov    (%rdx),%edx
  100c8d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c90:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c97:	89 0a                	mov    %ecx,(%rdx)
  100c99:	eb 1a                	jmp    100cb5 <printer_vprintf+0x63a>
  100c9b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ca2:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ca6:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100caa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cb1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100cb5:	8b 00                	mov    (%rax),%eax
  100cb7:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100cbd:	e9 67 03 00 00       	jmp    101029 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  100cc2:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100cc6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100cca:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cd1:	8b 00                	mov    (%rax),%eax
  100cd3:	83 f8 2f             	cmp    $0x2f,%eax
  100cd6:	77 30                	ja     100d08 <printer_vprintf+0x68d>
  100cd8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cdf:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ce3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cea:	8b 00                	mov    (%rax),%eax
  100cec:	89 c0                	mov    %eax,%eax
  100cee:	48 01 d0             	add    %rdx,%rax
  100cf1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cf8:	8b 12                	mov    (%rdx),%edx
  100cfa:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100cfd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d04:	89 0a                	mov    %ecx,(%rdx)
  100d06:	eb 1a                	jmp    100d22 <printer_vprintf+0x6a7>
  100d08:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d0f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d13:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d17:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d1e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d22:	8b 00                	mov    (%rax),%eax
  100d24:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100d27:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100d2b:	eb 45                	jmp    100d72 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  100d2d:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d31:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100d35:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d3c:	0f b6 00             	movzbl (%rax),%eax
  100d3f:	84 c0                	test   %al,%al
  100d41:	74 0c                	je     100d4f <printer_vprintf+0x6d4>
  100d43:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d4a:	0f b6 00             	movzbl (%rax),%eax
  100d4d:	eb 05                	jmp    100d54 <printer_vprintf+0x6d9>
  100d4f:	b8 25 00 00 00       	mov    $0x25,%eax
  100d54:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100d57:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100d5b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d62:	0f b6 00             	movzbl (%rax),%eax
  100d65:	84 c0                	test   %al,%al
  100d67:	75 08                	jne    100d71 <printer_vprintf+0x6f6>
                format--;
  100d69:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100d70:	01 
            }
            break;
  100d71:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100d72:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d75:	83 e0 20             	and    $0x20,%eax
  100d78:	85 c0                	test   %eax,%eax
  100d7a:	74 1e                	je     100d9a <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100d7c:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d80:	48 83 c0 18          	add    $0x18,%rax
  100d84:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100d87:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100d8b:	48 89 ce             	mov    %rcx,%rsi
  100d8e:	48 89 c7             	mov    %rax,%rdi
  100d91:	e8 63 f8 ff ff       	call   1005f9 <fill_numbuf>
  100d96:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100d9a:	48 c7 45 c0 76 1c 10 	movq   $0x101c76,-0x40(%rbp)
  100da1:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100da2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100da5:	83 e0 20             	and    $0x20,%eax
  100da8:	85 c0                	test   %eax,%eax
  100daa:	74 48                	je     100df4 <printer_vprintf+0x779>
  100dac:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100daf:	83 e0 40             	and    $0x40,%eax
  100db2:	85 c0                	test   %eax,%eax
  100db4:	74 3e                	je     100df4 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  100db6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100db9:	25 80 00 00 00       	and    $0x80,%eax
  100dbe:	85 c0                	test   %eax,%eax
  100dc0:	74 0a                	je     100dcc <printer_vprintf+0x751>
                prefix = "-";
  100dc2:	48 c7 45 c0 77 1c 10 	movq   $0x101c77,-0x40(%rbp)
  100dc9:	00 
            if (flags & FLAG_NEGATIVE) {
  100dca:	eb 73                	jmp    100e3f <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100dcc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dcf:	83 e0 10             	and    $0x10,%eax
  100dd2:	85 c0                	test   %eax,%eax
  100dd4:	74 0a                	je     100de0 <printer_vprintf+0x765>
                prefix = "+";
  100dd6:	48 c7 45 c0 79 1c 10 	movq   $0x101c79,-0x40(%rbp)
  100ddd:	00 
            if (flags & FLAG_NEGATIVE) {
  100dde:	eb 5f                	jmp    100e3f <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100de0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100de3:	83 e0 08             	and    $0x8,%eax
  100de6:	85 c0                	test   %eax,%eax
  100de8:	74 55                	je     100e3f <printer_vprintf+0x7c4>
                prefix = " ";
  100dea:	48 c7 45 c0 7b 1c 10 	movq   $0x101c7b,-0x40(%rbp)
  100df1:	00 
            if (flags & FLAG_NEGATIVE) {
  100df2:	eb 4b                	jmp    100e3f <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100df4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100df7:	83 e0 20             	and    $0x20,%eax
  100dfa:	85 c0                	test   %eax,%eax
  100dfc:	74 42                	je     100e40 <printer_vprintf+0x7c5>
  100dfe:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e01:	83 e0 01             	and    $0x1,%eax
  100e04:	85 c0                	test   %eax,%eax
  100e06:	74 38                	je     100e40 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  100e08:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100e0c:	74 06                	je     100e14 <printer_vprintf+0x799>
  100e0e:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100e12:	75 2c                	jne    100e40 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  100e14:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100e19:	75 0c                	jne    100e27 <printer_vprintf+0x7ac>
  100e1b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e1e:	25 00 01 00 00       	and    $0x100,%eax
  100e23:	85 c0                	test   %eax,%eax
  100e25:	74 19                	je     100e40 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  100e27:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100e2b:	75 07                	jne    100e34 <printer_vprintf+0x7b9>
  100e2d:	b8 7d 1c 10 00       	mov    $0x101c7d,%eax
  100e32:	eb 05                	jmp    100e39 <printer_vprintf+0x7be>
  100e34:	b8 80 1c 10 00       	mov    $0x101c80,%eax
  100e39:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100e3d:	eb 01                	jmp    100e40 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  100e3f:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100e40:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100e44:	78 24                	js     100e6a <printer_vprintf+0x7ef>
  100e46:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e49:	83 e0 20             	and    $0x20,%eax
  100e4c:	85 c0                	test   %eax,%eax
  100e4e:	75 1a                	jne    100e6a <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  100e50:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100e53:	48 63 d0             	movslq %eax,%rdx
  100e56:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100e5a:	48 89 d6             	mov    %rdx,%rsi
  100e5d:	48 89 c7             	mov    %rax,%rdi
  100e60:	e8 ea f5 ff ff       	call   10044f <strnlen>
  100e65:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100e68:	eb 0f                	jmp    100e79 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  100e6a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100e6e:	48 89 c7             	mov    %rax,%rdi
  100e71:	e8 a8 f5 ff ff       	call   10041e <strlen>
  100e76:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100e79:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e7c:	83 e0 20             	and    $0x20,%eax
  100e7f:	85 c0                	test   %eax,%eax
  100e81:	74 20                	je     100ea3 <printer_vprintf+0x828>
  100e83:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100e87:	78 1a                	js     100ea3 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  100e89:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100e8c:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100e8f:	7e 08                	jle    100e99 <printer_vprintf+0x81e>
  100e91:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100e94:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100e97:	eb 05                	jmp    100e9e <printer_vprintf+0x823>
  100e99:	b8 00 00 00 00       	mov    $0x0,%eax
  100e9e:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100ea1:	eb 5c                	jmp    100eff <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100ea3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ea6:	83 e0 20             	and    $0x20,%eax
  100ea9:	85 c0                	test   %eax,%eax
  100eab:	74 4b                	je     100ef8 <printer_vprintf+0x87d>
  100ead:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100eb0:	83 e0 02             	and    $0x2,%eax
  100eb3:	85 c0                	test   %eax,%eax
  100eb5:	74 41                	je     100ef8 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100eb7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100eba:	83 e0 04             	and    $0x4,%eax
  100ebd:	85 c0                	test   %eax,%eax
  100ebf:	75 37                	jne    100ef8 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  100ec1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100ec5:	48 89 c7             	mov    %rax,%rdi
  100ec8:	e8 51 f5 ff ff       	call   10041e <strlen>
  100ecd:	89 c2                	mov    %eax,%edx
  100ecf:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100ed2:	01 d0                	add    %edx,%eax
  100ed4:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100ed7:	7e 1f                	jle    100ef8 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  100ed9:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100edc:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100edf:	89 c3                	mov    %eax,%ebx
  100ee1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100ee5:	48 89 c7             	mov    %rax,%rdi
  100ee8:	e8 31 f5 ff ff       	call   10041e <strlen>
  100eed:	89 c2                	mov    %eax,%edx
  100eef:	89 d8                	mov    %ebx,%eax
  100ef1:	29 d0                	sub    %edx,%eax
  100ef3:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100ef6:	eb 07                	jmp    100eff <printer_vprintf+0x884>
        } else {
            zeros = 0;
  100ef8:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100eff:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100f02:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100f05:	01 d0                	add    %edx,%eax
  100f07:	48 63 d8             	movslq %eax,%rbx
  100f0a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f0e:	48 89 c7             	mov    %rax,%rdi
  100f11:	e8 08 f5 ff ff       	call   10041e <strlen>
  100f16:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100f1a:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100f1d:	29 d0                	sub    %edx,%eax
  100f1f:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100f22:	eb 25                	jmp    100f49 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  100f24:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f2b:	48 8b 08             	mov    (%rax),%rcx
  100f2e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f34:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f3b:	be 20 00 00 00       	mov    $0x20,%esi
  100f40:	48 89 c7             	mov    %rax,%rdi
  100f43:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100f45:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100f49:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f4c:	83 e0 04             	and    $0x4,%eax
  100f4f:	85 c0                	test   %eax,%eax
  100f51:	75 36                	jne    100f89 <printer_vprintf+0x90e>
  100f53:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100f57:	7f cb                	jg     100f24 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  100f59:	eb 2e                	jmp    100f89 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  100f5b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f62:	4c 8b 00             	mov    (%rax),%r8
  100f65:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f69:	0f b6 00             	movzbl (%rax),%eax
  100f6c:	0f b6 c8             	movzbl %al,%ecx
  100f6f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f75:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f7c:	89 ce                	mov    %ecx,%esi
  100f7e:	48 89 c7             	mov    %rax,%rdi
  100f81:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  100f84:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  100f89:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f8d:	0f b6 00             	movzbl (%rax),%eax
  100f90:	84 c0                	test   %al,%al
  100f92:	75 c7                	jne    100f5b <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  100f94:	eb 25                	jmp    100fbb <printer_vprintf+0x940>
            p->putc(p, '0', color);
  100f96:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f9d:	48 8b 08             	mov    (%rax),%rcx
  100fa0:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100fa6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fad:	be 30 00 00 00       	mov    $0x30,%esi
  100fb2:	48 89 c7             	mov    %rax,%rdi
  100fb5:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  100fb7:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  100fbb:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  100fbf:	7f d5                	jg     100f96 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  100fc1:	eb 32                	jmp    100ff5 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  100fc3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fca:	4c 8b 00             	mov    (%rax),%r8
  100fcd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100fd1:	0f b6 00             	movzbl (%rax),%eax
  100fd4:	0f b6 c8             	movzbl %al,%ecx
  100fd7:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100fdd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fe4:	89 ce                	mov    %ecx,%esi
  100fe6:	48 89 c7             	mov    %rax,%rdi
  100fe9:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  100fec:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  100ff1:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  100ff5:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  100ff9:	7f c8                	jg     100fc3 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  100ffb:	eb 25                	jmp    101022 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  100ffd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101004:	48 8b 08             	mov    (%rax),%rcx
  101007:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10100d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101014:	be 20 00 00 00       	mov    $0x20,%esi
  101019:	48 89 c7             	mov    %rax,%rdi
  10101c:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  10101e:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101022:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101026:	7f d5                	jg     100ffd <printer_vprintf+0x982>
        }
    done: ;
  101028:	90                   	nop
    for (; *format; ++format) {
  101029:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101030:	01 
  101031:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101038:	0f b6 00             	movzbl (%rax),%eax
  10103b:	84 c0                	test   %al,%al
  10103d:	0f 85 64 f6 ff ff    	jne    1006a7 <printer_vprintf+0x2c>
    }
}
  101043:	90                   	nop
  101044:	90                   	nop
  101045:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  101049:	c9                   	leave  
  10104a:	c3                   	ret    

000000000010104b <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  10104b:	55                   	push   %rbp
  10104c:	48 89 e5             	mov    %rsp,%rbp
  10104f:	48 83 ec 20          	sub    $0x20,%rsp
  101053:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101057:	89 f0                	mov    %esi,%eax
  101059:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10105c:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  10105f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101063:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101067:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10106b:	48 8b 40 08          	mov    0x8(%rax),%rax
  10106f:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  101074:	48 39 d0             	cmp    %rdx,%rax
  101077:	72 0c                	jb     101085 <console_putc+0x3a>
        cp->cursor = console;
  101079:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10107d:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  101084:	00 
    }
    if (c == '\n') {
  101085:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  101089:	75 78                	jne    101103 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  10108b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10108f:	48 8b 40 08          	mov    0x8(%rax),%rax
  101093:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  101099:	48 d1 f8             	sar    %rax
  10109c:	48 89 c1             	mov    %rax,%rcx
  10109f:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1010a6:	66 66 66 
  1010a9:	48 89 c8             	mov    %rcx,%rax
  1010ac:	48 f7 ea             	imul   %rdx
  1010af:	48 c1 fa 05          	sar    $0x5,%rdx
  1010b3:	48 89 c8             	mov    %rcx,%rax
  1010b6:	48 c1 f8 3f          	sar    $0x3f,%rax
  1010ba:	48 29 c2             	sub    %rax,%rdx
  1010bd:	48 89 d0             	mov    %rdx,%rax
  1010c0:	48 c1 e0 02          	shl    $0x2,%rax
  1010c4:	48 01 d0             	add    %rdx,%rax
  1010c7:	48 c1 e0 04          	shl    $0x4,%rax
  1010cb:	48 29 c1             	sub    %rax,%rcx
  1010ce:	48 89 ca             	mov    %rcx,%rdx
  1010d1:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  1010d4:	eb 25                	jmp    1010fb <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  1010d6:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1010d9:	83 c8 20             	or     $0x20,%eax
  1010dc:	89 c6                	mov    %eax,%esi
  1010de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010e2:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010e6:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1010ea:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1010ee:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1010f2:	89 f2                	mov    %esi,%edx
  1010f4:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  1010f7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1010fb:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  1010ff:	75 d5                	jne    1010d6 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101101:	eb 24                	jmp    101127 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  101103:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  101107:	8b 55 e0             	mov    -0x20(%rbp),%edx
  10110a:	09 d0                	or     %edx,%eax
  10110c:	89 c6                	mov    %eax,%esi
  10110e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101112:	48 8b 40 08          	mov    0x8(%rax),%rax
  101116:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10111a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  10111e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101122:	89 f2                	mov    %esi,%edx
  101124:	66 89 10             	mov    %dx,(%rax)
}
  101127:	90                   	nop
  101128:	c9                   	leave  
  101129:	c3                   	ret    

000000000010112a <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  10112a:	55                   	push   %rbp
  10112b:	48 89 e5             	mov    %rsp,%rbp
  10112e:	48 83 ec 30          	sub    $0x30,%rsp
  101132:	89 7d ec             	mov    %edi,-0x14(%rbp)
  101135:	89 75 e8             	mov    %esi,-0x18(%rbp)
  101138:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  10113c:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  101140:	48 c7 45 f0 4b 10 10 	movq   $0x10104b,-0x10(%rbp)
  101147:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101148:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  10114c:	78 09                	js     101157 <console_vprintf+0x2d>
  10114e:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101155:	7e 07                	jle    10115e <console_vprintf+0x34>
        cpos = 0;
  101157:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  10115e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101161:	48 98                	cltq   
  101163:	48 01 c0             	add    %rax,%rax
  101166:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  10116c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101170:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101174:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  101178:	8b 75 e8             	mov    -0x18(%rbp),%esi
  10117b:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  10117f:	48 89 c7             	mov    %rax,%rdi
  101182:	e8 f4 f4 ff ff       	call   10067b <printer_vprintf>
    return cp.cursor - console;
  101187:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10118b:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  101191:	48 d1 f8             	sar    %rax
}
  101194:	c9                   	leave  
  101195:	c3                   	ret    

0000000000101196 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  101196:	55                   	push   %rbp
  101197:	48 89 e5             	mov    %rsp,%rbp
  10119a:	48 83 ec 60          	sub    $0x60,%rsp
  10119e:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1011a1:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1011a4:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1011a8:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1011ac:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1011b0:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1011b4:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1011bb:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1011bf:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1011c3:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1011c7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1011cb:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1011cf:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  1011d3:	8b 75 a8             	mov    -0x58(%rbp),%esi
  1011d6:	8b 45 ac             	mov    -0x54(%rbp),%eax
  1011d9:	89 c7                	mov    %eax,%edi
  1011db:	e8 4a ff ff ff       	call   10112a <console_vprintf>
  1011e0:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  1011e3:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  1011e6:	c9                   	leave  
  1011e7:	c3                   	ret    

00000000001011e8 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  1011e8:	55                   	push   %rbp
  1011e9:	48 89 e5             	mov    %rsp,%rbp
  1011ec:	48 83 ec 20          	sub    $0x20,%rsp
  1011f0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1011f4:	89 f0                	mov    %esi,%eax
  1011f6:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1011f9:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  1011fc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101200:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101204:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101208:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10120c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101210:	48 8b 40 10          	mov    0x10(%rax),%rax
  101214:	48 39 c2             	cmp    %rax,%rdx
  101217:	73 1a                	jae    101233 <string_putc+0x4b>
        *sp->s++ = c;
  101219:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10121d:	48 8b 40 08          	mov    0x8(%rax),%rax
  101221:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101225:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101229:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10122d:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101231:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101233:	90                   	nop
  101234:	c9                   	leave  
  101235:	c3                   	ret    

0000000000101236 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101236:	55                   	push   %rbp
  101237:	48 89 e5             	mov    %rsp,%rbp
  10123a:	48 83 ec 40          	sub    $0x40,%rsp
  10123e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101242:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101246:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  10124a:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  10124e:	48 c7 45 e8 e8 11 10 	movq   $0x1011e8,-0x18(%rbp)
  101255:	00 
    sp.s = s;
  101256:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10125a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  10125e:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  101263:	74 33                	je     101298 <vsnprintf+0x62>
        sp.end = s + size - 1;
  101265:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101269:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10126d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101271:	48 01 d0             	add    %rdx,%rax
  101274:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101278:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  10127c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101280:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101284:	be 00 00 00 00       	mov    $0x0,%esi
  101289:	48 89 c7             	mov    %rax,%rdi
  10128c:	e8 ea f3 ff ff       	call   10067b <printer_vprintf>
        *sp.s = 0;
  101291:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101295:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  101298:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10129c:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1012a0:	c9                   	leave  
  1012a1:	c3                   	ret    

00000000001012a2 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1012a2:	55                   	push   %rbp
  1012a3:	48 89 e5             	mov    %rsp,%rbp
  1012a6:	48 83 ec 70          	sub    $0x70,%rsp
  1012aa:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1012ae:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1012b2:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1012b6:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1012ba:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1012be:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1012c2:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  1012c9:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1012cd:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  1012d1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1012d5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  1012d9:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  1012dd:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  1012e1:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  1012e5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1012e9:	48 89 c7             	mov    %rax,%rdi
  1012ec:	e8 45 ff ff ff       	call   101236 <vsnprintf>
  1012f1:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  1012f4:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  1012f7:	c9                   	leave  
  1012f8:	c3                   	ret    

00000000001012f9 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  1012f9:	55                   	push   %rbp
  1012fa:	48 89 e5             	mov    %rsp,%rbp
  1012fd:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101301:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101308:	eb 13                	jmp    10131d <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  10130a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10130d:	48 98                	cltq   
  10130f:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  101316:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101319:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10131d:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101324:	7e e4                	jle    10130a <console_clear+0x11>
    }
    cursorpos = 0;
  101326:	c7 05 cc 7c fb ff 00 	movl   $0x0,-0x48334(%rip)        # b8ffc <cursorpos>
  10132d:	00 00 00 
}
  101330:	90                   	nop
  101331:	c9                   	leave  
  101332:	c3                   	ret    
