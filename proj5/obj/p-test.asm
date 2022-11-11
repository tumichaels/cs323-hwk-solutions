
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
extern uint8_t end[];

// program that checks if a kernel address is accessible to user
// (except CONSOLE_ADDR)

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	48 83 ec 20          	sub    $0x20,%rsp

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100008:	cd 31                	int    $0x31
  10000a:	89 c7                	mov    %eax,%edi
    pid_t p = sys_getpid();
    srand(p);
  10000c:	e8 b2 04 00 00       	call   1004c3 <srand>
// looks up the virtual memory mapping for addr for the current process 
// and stores it inside map. [map, sizeof(vampping)) address should be 
// allocated, writable addresses to the process, otherwise syscall will 
// not write anything to the variable
static inline void sys_mapping(uintptr_t addr, void * map){
    asm volatile ("int %0" : /* no result */
  100011:	48 8d 7d e8          	lea    -0x18(%rbp),%rdi
  100015:	be 00 00 01 00       	mov    $0x10000,%esi
  10001a:	cd 36                	int    $0x36

    vamapping kmap;
    sys_mapping(KERNEL_ADDR, &kmap);

    if(kmap.perm &(PTE_U))
  10001c:	f6 45 f8 04          	testb  $0x4,-0x8(%rbp)
  100020:	74 0f                	je     100031 <process_main+0x31>
        panic("Kernel accessible by process!");
  100022:	bf 20 12 10 00       	mov    $0x101220,%edi
  100027:	b8 00 00 00 00       	mov    $0x0,%eax
  10002c:	e8 9f 00 00 00       	call   1000d0 <panic>

    TEST_PASS();
  100031:	bf 3e 12 10 00       	mov    $0x10123e,%edi
  100036:	b8 00 00 00 00       	mov    $0x0,%eax
  10003b:	e8 90 00 00 00       	call   1000d0 <panic>

0000000000100040 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100040:	55                   	push   %rbp
  100041:	48 89 e5             	mov    %rsp,%rbp
  100044:	48 83 ec 50          	sub    $0x50,%rsp
  100048:	49 89 f2             	mov    %rsi,%r10
  10004b:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  10004f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100053:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100057:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  10005b:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100060:	85 ff                	test   %edi,%edi
  100062:	78 2e                	js     100092 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  100064:	48 63 ff             	movslq %edi,%rdi
  100067:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  10006e:	cc cc cc 
  100071:	48 89 f8             	mov    %rdi,%rax
  100074:	48 f7 e2             	mul    %rdx
  100077:	48 89 d0             	mov    %rdx,%rax
  10007a:	48 c1 e8 02          	shr    $0x2,%rax
  10007e:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  100082:	48 01 c2             	add    %rax,%rdx
  100085:	48 29 d7             	sub    %rdx,%rdi
  100088:	0f b6 b7 8d 12 10 00 	movzbl 0x10128d(%rdi),%esi
  10008f:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  100092:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  100099:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10009d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1000a1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1000a5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  1000a9:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1000ad:	4c 89 d2             	mov    %r10,%rdx
  1000b0:	8b 3d 46 8f fb ff    	mov    -0x470ba(%rip),%edi        # b8ffc <cursorpos>
  1000b6:	e8 5a 0f 00 00       	call   101015 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  1000bb:	3d 30 07 00 00       	cmp    $0x730,%eax
  1000c0:	ba 00 00 00 00       	mov    $0x0,%edx
  1000c5:	0f 4d c2             	cmovge %edx,%eax
  1000c8:	89 05 2e 8f fb ff    	mov    %eax,-0x470d2(%rip)        # b8ffc <cursorpos>
    }
}
  1000ce:	c9                   	leave  
  1000cf:	c3                   	ret    

00000000001000d0 <panic>:


// panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
  1000d0:	55                   	push   %rbp
  1000d1:	48 89 e5             	mov    %rsp,%rbp
  1000d4:	53                   	push   %rbx
  1000d5:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  1000dc:	48 89 fb             	mov    %rdi,%rbx
  1000df:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  1000e3:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  1000e7:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  1000eb:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  1000ef:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  1000f3:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  1000fa:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1000fe:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100102:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  100106:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  10010a:	ba 07 00 00 00       	mov    $0x7,%edx
  10010f:	be 59 12 10 00       	mov    $0x101259,%esi
  100114:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  10011b:	e8 ac 00 00 00       	call   1001cc <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100120:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100124:	48 89 da             	mov    %rbx,%rdx
  100127:	be 99 00 00 00       	mov    $0x99,%esi
  10012c:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100133:	e8 e9 0f 00 00       	call   101121 <vsnprintf>
  100138:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  10013b:	85 d2                	test   %edx,%edx
  10013d:	7e 0f                	jle    10014e <panic+0x7e>
  10013f:	83 c0 06             	add    $0x6,%eax
  100142:	48 98                	cltq   
  100144:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  10014b:	0a 
  10014c:	75 29                	jne    100177 <panic+0xa7>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  10014e:	48 8d 8d 08 ff ff ff 	lea    -0xf8(%rbp),%rcx
  100155:	ba 63 12 10 00       	mov    $0x101263,%edx
  10015a:	be 00 c0 00 00       	mov    $0xc000,%esi
  10015f:	bf 30 07 00 00       	mov    $0x730,%edi
  100164:	b8 00 00 00 00       	mov    $0x0,%eax
  100169:	e8 13 0f 00 00       	call   101081 <console_printf>
    asm volatile ("int %0" : /* no result */
  10016e:	bf 00 00 00 00       	mov    $0x0,%edi
  100173:	cd 30                	int    $0x30
 loop: goto loop;
  100175:	eb fe                	jmp    100175 <panic+0xa5>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  100177:	48 63 c2             	movslq %edx,%rax
  10017a:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  100180:	0f 94 c2             	sete   %dl
  100183:	0f b6 d2             	movzbl %dl,%edx
  100186:	48 29 d0             	sub    %rdx,%rax
  100189:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  100190:	ff 
  100191:	be 61 12 10 00       	mov    $0x101261,%esi
  100196:	e8 de 01 00 00       	call   100379 <strcpy>
  10019b:	eb b1                	jmp    10014e <panic+0x7e>

000000000010019d <assert_fail>:
    sys_panic(NULL);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  10019d:	55                   	push   %rbp
  10019e:	48 89 e5             	mov    %rsp,%rbp
  1001a1:	48 89 f9             	mov    %rdi,%rcx
  1001a4:	41 89 f0             	mov    %esi,%r8d
  1001a7:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  1001aa:	ba 68 12 10 00       	mov    $0x101268,%edx
  1001af:	be 00 c0 00 00       	mov    $0xc000,%esi
  1001b4:	bf 30 07 00 00       	mov    $0x730,%edi
  1001b9:	b8 00 00 00 00       	mov    $0x0,%eax
  1001be:	e8 be 0e 00 00       	call   101081 <console_printf>
    asm volatile ("int %0" : /* no result */
  1001c3:	bf 00 00 00 00       	mov    $0x0,%edi
  1001c8:	cd 30                	int    $0x30
 loop: goto loop;
  1001ca:	eb fe                	jmp    1001ca <assert_fail+0x2d>

00000000001001cc <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  1001cc:	55                   	push   %rbp
  1001cd:	48 89 e5             	mov    %rsp,%rbp
  1001d0:	48 83 ec 28          	sub    $0x28,%rsp
  1001d4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1001d8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1001dc:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1001e0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1001e4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1001e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1001ec:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  1001f0:	eb 1c                	jmp    10020e <memcpy+0x42>
        *d = *s;
  1001f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1001f6:	0f b6 10             	movzbl (%rax),%edx
  1001f9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1001fd:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1001ff:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100204:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100209:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  10020e:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100213:	75 dd                	jne    1001f2 <memcpy+0x26>
    }
    return dst;
  100215:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100219:	c9                   	leave  
  10021a:	c3                   	ret    

000000000010021b <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  10021b:	55                   	push   %rbp
  10021c:	48 89 e5             	mov    %rsp,%rbp
  10021f:	48 83 ec 28          	sub    $0x28,%rsp
  100223:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100227:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10022b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10022f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100233:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  100237:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10023b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  10023f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100243:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  100247:	73 6a                	jae    1002b3 <memmove+0x98>
  100249:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10024d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100251:	48 01 d0             	add    %rdx,%rax
  100254:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100258:	73 59                	jae    1002b3 <memmove+0x98>
        s += n, d += n;
  10025a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10025e:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100262:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100266:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  10026a:	eb 17                	jmp    100283 <memmove+0x68>
            *--d = *--s;
  10026c:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100271:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100276:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10027a:	0f b6 10             	movzbl (%rax),%edx
  10027d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100281:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100283:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100287:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10028b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  10028f:	48 85 c0             	test   %rax,%rax
  100292:	75 d8                	jne    10026c <memmove+0x51>
    if (s < d && s + n > d) {
  100294:	eb 2e                	jmp    1002c4 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100296:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10029a:	48 8d 42 01          	lea    0x1(%rdx),%rax
  10029e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1002a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1002a6:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1002aa:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  1002ae:	0f b6 12             	movzbl (%rdx),%edx
  1002b1:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1002b3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1002b7:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1002bb:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1002bf:	48 85 c0             	test   %rax,%rax
  1002c2:	75 d2                	jne    100296 <memmove+0x7b>
        }
    }
    return dst;
  1002c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1002c8:	c9                   	leave  
  1002c9:	c3                   	ret    

00000000001002ca <memset>:

void* memset(void* v, int c, size_t n) {
  1002ca:	55                   	push   %rbp
  1002cb:	48 89 e5             	mov    %rsp,%rbp
  1002ce:	48 83 ec 28          	sub    $0x28,%rsp
  1002d2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1002d6:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  1002d9:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1002dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1002e1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1002e5:	eb 15                	jmp    1002fc <memset+0x32>
        *p = c;
  1002e7:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1002ea:	89 c2                	mov    %eax,%edx
  1002ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002f0:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1002f2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1002f7:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1002fc:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100301:	75 e4                	jne    1002e7 <memset+0x1d>
    }
    return v;
  100303:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100307:	c9                   	leave  
  100308:	c3                   	ret    

0000000000100309 <strlen>:

size_t strlen(const char* s) {
  100309:	55                   	push   %rbp
  10030a:	48 89 e5             	mov    %rsp,%rbp
  10030d:	48 83 ec 18          	sub    $0x18,%rsp
  100311:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100315:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  10031c:	00 
  10031d:	eb 0a                	jmp    100329 <strlen+0x20>
        ++n;
  10031f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100324:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100329:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10032d:	0f b6 00             	movzbl (%rax),%eax
  100330:	84 c0                	test   %al,%al
  100332:	75 eb                	jne    10031f <strlen+0x16>
    }
    return n;
  100334:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100338:	c9                   	leave  
  100339:	c3                   	ret    

000000000010033a <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  10033a:	55                   	push   %rbp
  10033b:	48 89 e5             	mov    %rsp,%rbp
  10033e:	48 83 ec 20          	sub    $0x20,%rsp
  100342:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100346:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  10034a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100351:	00 
  100352:	eb 0a                	jmp    10035e <strnlen+0x24>
        ++n;
  100354:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100359:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  10035e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100362:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100366:	74 0b                	je     100373 <strnlen+0x39>
  100368:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10036c:	0f b6 00             	movzbl (%rax),%eax
  10036f:	84 c0                	test   %al,%al
  100371:	75 e1                	jne    100354 <strnlen+0x1a>
    }
    return n;
  100373:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100377:	c9                   	leave  
  100378:	c3                   	ret    

0000000000100379 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100379:	55                   	push   %rbp
  10037a:	48 89 e5             	mov    %rsp,%rbp
  10037d:	48 83 ec 20          	sub    $0x20,%rsp
  100381:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100385:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  100389:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10038d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100391:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100395:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100399:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  10039d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003a1:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1003a5:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  1003a9:	0f b6 12             	movzbl (%rdx),%edx
  1003ac:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  1003ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003b2:	48 83 e8 01          	sub    $0x1,%rax
  1003b6:	0f b6 00             	movzbl (%rax),%eax
  1003b9:	84 c0                	test   %al,%al
  1003bb:	75 d4                	jne    100391 <strcpy+0x18>
    return dst;
  1003bd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1003c1:	c9                   	leave  
  1003c2:	c3                   	ret    

00000000001003c3 <strcmp>:

int strcmp(const char* a, const char* b) {
  1003c3:	55                   	push   %rbp
  1003c4:	48 89 e5             	mov    %rsp,%rbp
  1003c7:	48 83 ec 10          	sub    $0x10,%rsp
  1003cb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1003cf:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1003d3:	eb 0a                	jmp    1003df <strcmp+0x1c>
        ++a, ++b;
  1003d5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1003da:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1003df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003e3:	0f b6 00             	movzbl (%rax),%eax
  1003e6:	84 c0                	test   %al,%al
  1003e8:	74 1d                	je     100407 <strcmp+0x44>
  1003ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003ee:	0f b6 00             	movzbl (%rax),%eax
  1003f1:	84 c0                	test   %al,%al
  1003f3:	74 12                	je     100407 <strcmp+0x44>
  1003f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003f9:	0f b6 10             	movzbl (%rax),%edx
  1003fc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100400:	0f b6 00             	movzbl (%rax),%eax
  100403:	38 c2                	cmp    %al,%dl
  100405:	74 ce                	je     1003d5 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100407:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10040b:	0f b6 00             	movzbl (%rax),%eax
  10040e:	89 c2                	mov    %eax,%edx
  100410:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100414:	0f b6 00             	movzbl (%rax),%eax
  100417:	38 d0                	cmp    %dl,%al
  100419:	0f 92 c0             	setb   %al
  10041c:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  10041f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100423:	0f b6 00             	movzbl (%rax),%eax
  100426:	89 c1                	mov    %eax,%ecx
  100428:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10042c:	0f b6 00             	movzbl (%rax),%eax
  10042f:	38 c1                	cmp    %al,%cl
  100431:	0f 92 c0             	setb   %al
  100434:	0f b6 c0             	movzbl %al,%eax
  100437:	29 c2                	sub    %eax,%edx
  100439:	89 d0                	mov    %edx,%eax
}
  10043b:	c9                   	leave  
  10043c:	c3                   	ret    

000000000010043d <strchr>:

char* strchr(const char* s, int c) {
  10043d:	55                   	push   %rbp
  10043e:	48 89 e5             	mov    %rsp,%rbp
  100441:	48 83 ec 10          	sub    $0x10,%rsp
  100445:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100449:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  10044c:	eb 05                	jmp    100453 <strchr+0x16>
        ++s;
  10044e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100453:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100457:	0f b6 00             	movzbl (%rax),%eax
  10045a:	84 c0                	test   %al,%al
  10045c:	74 0e                	je     10046c <strchr+0x2f>
  10045e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100462:	0f b6 00             	movzbl (%rax),%eax
  100465:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100468:	38 d0                	cmp    %dl,%al
  10046a:	75 e2                	jne    10044e <strchr+0x11>
    }
    if (*s == (char) c) {
  10046c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100470:	0f b6 00             	movzbl (%rax),%eax
  100473:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100476:	38 d0                	cmp    %dl,%al
  100478:	75 06                	jne    100480 <strchr+0x43>
        return (char*) s;
  10047a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10047e:	eb 05                	jmp    100485 <strchr+0x48>
    } else {
        return NULL;
  100480:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100485:	c9                   	leave  
  100486:	c3                   	ret    

0000000000100487 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100487:	55                   	push   %rbp
  100488:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  10048b:	8b 05 6f 1b 00 00    	mov    0x1b6f(%rip),%eax        # 102000 <rand_seed_set>
  100491:	85 c0                	test   %eax,%eax
  100493:	75 0a                	jne    10049f <rand+0x18>
        srand(819234718U);
  100495:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  10049a:	e8 24 00 00 00       	call   1004c3 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  10049f:	8b 05 5f 1b 00 00    	mov    0x1b5f(%rip),%eax        # 102004 <rand_seed>
  1004a5:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  1004ab:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1004b0:	89 05 4e 1b 00 00    	mov    %eax,0x1b4e(%rip)        # 102004 <rand_seed>
    return rand_seed & RAND_MAX;
  1004b6:	8b 05 48 1b 00 00    	mov    0x1b48(%rip),%eax        # 102004 <rand_seed>
  1004bc:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1004c1:	5d                   	pop    %rbp
  1004c2:	c3                   	ret    

00000000001004c3 <srand>:

void srand(unsigned seed) {
  1004c3:	55                   	push   %rbp
  1004c4:	48 89 e5             	mov    %rsp,%rbp
  1004c7:	48 83 ec 08          	sub    $0x8,%rsp
  1004cb:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  1004ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1004d1:	89 05 2d 1b 00 00    	mov    %eax,0x1b2d(%rip)        # 102004 <rand_seed>
    rand_seed_set = 1;
  1004d7:	c7 05 1f 1b 00 00 01 	movl   $0x1,0x1b1f(%rip)        # 102000 <rand_seed_set>
  1004de:	00 00 00 
}
  1004e1:	90                   	nop
  1004e2:	c9                   	leave  
  1004e3:	c3                   	ret    

00000000001004e4 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  1004e4:	55                   	push   %rbp
  1004e5:	48 89 e5             	mov    %rsp,%rbp
  1004e8:	48 83 ec 28          	sub    $0x28,%rsp
  1004ec:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1004f0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1004f4:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  1004f7:	48 c7 45 f8 80 14 10 	movq   $0x101480,-0x8(%rbp)
  1004fe:	00 
    if (base < 0) {
  1004ff:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100503:	79 0b                	jns    100510 <fill_numbuf+0x2c>
        digits = lower_digits;
  100505:	48 c7 45 f8 a0 14 10 	movq   $0x1014a0,-0x8(%rbp)
  10050c:	00 
        base = -base;
  10050d:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100510:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100515:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100519:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  10051c:	8b 45 dc             	mov    -0x24(%rbp),%eax
  10051f:	48 63 c8             	movslq %eax,%rcx
  100522:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100526:	ba 00 00 00 00       	mov    $0x0,%edx
  10052b:	48 f7 f1             	div    %rcx
  10052e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100532:	48 01 d0             	add    %rdx,%rax
  100535:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10053a:	0f b6 10             	movzbl (%rax),%edx
  10053d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100541:	88 10                	mov    %dl,(%rax)
        val /= base;
  100543:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100546:	48 63 f0             	movslq %eax,%rsi
  100549:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10054d:	ba 00 00 00 00       	mov    $0x0,%edx
  100552:	48 f7 f6             	div    %rsi
  100555:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100559:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  10055e:	75 bc                	jne    10051c <fill_numbuf+0x38>
    return numbuf_end;
  100560:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100564:	c9                   	leave  
  100565:	c3                   	ret    

0000000000100566 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100566:	55                   	push   %rbp
  100567:	48 89 e5             	mov    %rsp,%rbp
  10056a:	53                   	push   %rbx
  10056b:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100572:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100579:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  10057f:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100586:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  10058d:	e9 8a 09 00 00       	jmp    100f1c <printer_vprintf+0x9b6>
        if (*format != '%') {
  100592:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100599:	0f b6 00             	movzbl (%rax),%eax
  10059c:	3c 25                	cmp    $0x25,%al
  10059e:	74 31                	je     1005d1 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  1005a0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1005a7:	4c 8b 00             	mov    (%rax),%r8
  1005aa:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1005b1:	0f b6 00             	movzbl (%rax),%eax
  1005b4:	0f b6 c8             	movzbl %al,%ecx
  1005b7:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1005bd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1005c4:	89 ce                	mov    %ecx,%esi
  1005c6:	48 89 c7             	mov    %rax,%rdi
  1005c9:	41 ff d0             	call   *%r8
            continue;
  1005cc:	e9 43 09 00 00       	jmp    100f14 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  1005d1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  1005d8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1005df:	01 
  1005e0:	eb 44                	jmp    100626 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  1005e2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1005e9:	0f b6 00             	movzbl (%rax),%eax
  1005ec:	0f be c0             	movsbl %al,%eax
  1005ef:	89 c6                	mov    %eax,%esi
  1005f1:	bf a0 12 10 00       	mov    $0x1012a0,%edi
  1005f6:	e8 42 fe ff ff       	call   10043d <strchr>
  1005fb:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  1005ff:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100604:	74 30                	je     100636 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  100606:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  10060a:	48 2d a0 12 10 00    	sub    $0x1012a0,%rax
  100610:	ba 01 00 00 00       	mov    $0x1,%edx
  100615:	89 c1                	mov    %eax,%ecx
  100617:	d3 e2                	shl    %cl,%edx
  100619:	89 d0                	mov    %edx,%eax
  10061b:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  10061e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100625:	01 
  100626:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10062d:	0f b6 00             	movzbl (%rax),%eax
  100630:	84 c0                	test   %al,%al
  100632:	75 ae                	jne    1005e2 <printer_vprintf+0x7c>
  100634:	eb 01                	jmp    100637 <printer_vprintf+0xd1>
            } else {
                break;
  100636:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100637:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  10063e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100645:	0f b6 00             	movzbl (%rax),%eax
  100648:	3c 30                	cmp    $0x30,%al
  10064a:	7e 67                	jle    1006b3 <printer_vprintf+0x14d>
  10064c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100653:	0f b6 00             	movzbl (%rax),%eax
  100656:	3c 39                	cmp    $0x39,%al
  100658:	7f 59                	jg     1006b3 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10065a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100661:	eb 2e                	jmp    100691 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100663:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100666:	89 d0                	mov    %edx,%eax
  100668:	c1 e0 02             	shl    $0x2,%eax
  10066b:	01 d0                	add    %edx,%eax
  10066d:	01 c0                	add    %eax,%eax
  10066f:	89 c1                	mov    %eax,%ecx
  100671:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100678:	48 8d 50 01          	lea    0x1(%rax),%rdx
  10067c:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100683:	0f b6 00             	movzbl (%rax),%eax
  100686:	0f be c0             	movsbl %al,%eax
  100689:	01 c8                	add    %ecx,%eax
  10068b:	83 e8 30             	sub    $0x30,%eax
  10068e:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100691:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100698:	0f b6 00             	movzbl (%rax),%eax
  10069b:	3c 2f                	cmp    $0x2f,%al
  10069d:	0f 8e 85 00 00 00    	jle    100728 <printer_vprintf+0x1c2>
  1006a3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006aa:	0f b6 00             	movzbl (%rax),%eax
  1006ad:	3c 39                	cmp    $0x39,%al
  1006af:	7e b2                	jle    100663 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  1006b1:	eb 75                	jmp    100728 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  1006b3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006ba:	0f b6 00             	movzbl (%rax),%eax
  1006bd:	3c 2a                	cmp    $0x2a,%al
  1006bf:	75 68                	jne    100729 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  1006c1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1006c8:	8b 00                	mov    (%rax),%eax
  1006ca:	83 f8 2f             	cmp    $0x2f,%eax
  1006cd:	77 30                	ja     1006ff <printer_vprintf+0x199>
  1006cf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1006d6:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1006da:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1006e1:	8b 00                	mov    (%rax),%eax
  1006e3:	89 c0                	mov    %eax,%eax
  1006e5:	48 01 d0             	add    %rdx,%rax
  1006e8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1006ef:	8b 12                	mov    (%rdx),%edx
  1006f1:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1006f4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1006fb:	89 0a                	mov    %ecx,(%rdx)
  1006fd:	eb 1a                	jmp    100719 <printer_vprintf+0x1b3>
  1006ff:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100706:	48 8b 40 08          	mov    0x8(%rax),%rax
  10070a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10070e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100715:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100719:	8b 00                	mov    (%rax),%eax
  10071b:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  10071e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100725:	01 
  100726:	eb 01                	jmp    100729 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100728:	90                   	nop
        }

        // process precision
        int precision = -1;
  100729:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100730:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100737:	0f b6 00             	movzbl (%rax),%eax
  10073a:	3c 2e                	cmp    $0x2e,%al
  10073c:	0f 85 00 01 00 00    	jne    100842 <printer_vprintf+0x2dc>
            ++format;
  100742:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100749:	01 
            if (*format >= '0' && *format <= '9') {
  10074a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100751:	0f b6 00             	movzbl (%rax),%eax
  100754:	3c 2f                	cmp    $0x2f,%al
  100756:	7e 67                	jle    1007bf <printer_vprintf+0x259>
  100758:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10075f:	0f b6 00             	movzbl (%rax),%eax
  100762:	3c 39                	cmp    $0x39,%al
  100764:	7f 59                	jg     1007bf <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100766:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  10076d:	eb 2e                	jmp    10079d <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  10076f:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100772:	89 d0                	mov    %edx,%eax
  100774:	c1 e0 02             	shl    $0x2,%eax
  100777:	01 d0                	add    %edx,%eax
  100779:	01 c0                	add    %eax,%eax
  10077b:	89 c1                	mov    %eax,%ecx
  10077d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100784:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100788:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10078f:	0f b6 00             	movzbl (%rax),%eax
  100792:	0f be c0             	movsbl %al,%eax
  100795:	01 c8                	add    %ecx,%eax
  100797:	83 e8 30             	sub    $0x30,%eax
  10079a:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10079d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007a4:	0f b6 00             	movzbl (%rax),%eax
  1007a7:	3c 2f                	cmp    $0x2f,%al
  1007a9:	0f 8e 85 00 00 00    	jle    100834 <printer_vprintf+0x2ce>
  1007af:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007b6:	0f b6 00             	movzbl (%rax),%eax
  1007b9:	3c 39                	cmp    $0x39,%al
  1007bb:	7e b2                	jle    10076f <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  1007bd:	eb 75                	jmp    100834 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  1007bf:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007c6:	0f b6 00             	movzbl (%rax),%eax
  1007c9:	3c 2a                	cmp    $0x2a,%al
  1007cb:	75 68                	jne    100835 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  1007cd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007d4:	8b 00                	mov    (%rax),%eax
  1007d6:	83 f8 2f             	cmp    $0x2f,%eax
  1007d9:	77 30                	ja     10080b <printer_vprintf+0x2a5>
  1007db:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007e2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1007e6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007ed:	8b 00                	mov    (%rax),%eax
  1007ef:	89 c0                	mov    %eax,%eax
  1007f1:	48 01 d0             	add    %rdx,%rax
  1007f4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007fb:	8b 12                	mov    (%rdx),%edx
  1007fd:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100800:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100807:	89 0a                	mov    %ecx,(%rdx)
  100809:	eb 1a                	jmp    100825 <printer_vprintf+0x2bf>
  10080b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100812:	48 8b 40 08          	mov    0x8(%rax),%rax
  100816:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10081a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100821:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100825:	8b 00                	mov    (%rax),%eax
  100827:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  10082a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100831:	01 
  100832:	eb 01                	jmp    100835 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100834:	90                   	nop
            }
            if (precision < 0) {
  100835:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100839:	79 07                	jns    100842 <printer_vprintf+0x2dc>
                precision = 0;
  10083b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100842:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100849:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100850:	00 
        int length = 0;
  100851:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100858:	48 c7 45 c8 a6 12 10 	movq   $0x1012a6,-0x38(%rbp)
  10085f:	00 
    again:
        switch (*format) {
  100860:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100867:	0f b6 00             	movzbl (%rax),%eax
  10086a:	0f be c0             	movsbl %al,%eax
  10086d:	83 e8 43             	sub    $0x43,%eax
  100870:	83 f8 37             	cmp    $0x37,%eax
  100873:	0f 87 9f 03 00 00    	ja     100c18 <printer_vprintf+0x6b2>
  100879:	89 c0                	mov    %eax,%eax
  10087b:	48 8b 04 c5 b8 12 10 	mov    0x1012b8(,%rax,8),%rax
  100882:	00 
  100883:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100885:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  10088c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100893:	01 
            goto again;
  100894:	eb ca                	jmp    100860 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100896:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  10089a:	74 5d                	je     1008f9 <printer_vprintf+0x393>
  10089c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008a3:	8b 00                	mov    (%rax),%eax
  1008a5:	83 f8 2f             	cmp    $0x2f,%eax
  1008a8:	77 30                	ja     1008da <printer_vprintf+0x374>
  1008aa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008b1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1008b5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008bc:	8b 00                	mov    (%rax),%eax
  1008be:	89 c0                	mov    %eax,%eax
  1008c0:	48 01 d0             	add    %rdx,%rax
  1008c3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008ca:	8b 12                	mov    (%rdx),%edx
  1008cc:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1008cf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008d6:	89 0a                	mov    %ecx,(%rdx)
  1008d8:	eb 1a                	jmp    1008f4 <printer_vprintf+0x38e>
  1008da:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008e1:	48 8b 40 08          	mov    0x8(%rax),%rax
  1008e5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1008e9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008f0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1008f4:	48 8b 00             	mov    (%rax),%rax
  1008f7:	eb 5c                	jmp    100955 <printer_vprintf+0x3ef>
  1008f9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100900:	8b 00                	mov    (%rax),%eax
  100902:	83 f8 2f             	cmp    $0x2f,%eax
  100905:	77 30                	ja     100937 <printer_vprintf+0x3d1>
  100907:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10090e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100912:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100919:	8b 00                	mov    (%rax),%eax
  10091b:	89 c0                	mov    %eax,%eax
  10091d:	48 01 d0             	add    %rdx,%rax
  100920:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100927:	8b 12                	mov    (%rdx),%edx
  100929:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10092c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100933:	89 0a                	mov    %ecx,(%rdx)
  100935:	eb 1a                	jmp    100951 <printer_vprintf+0x3eb>
  100937:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10093e:	48 8b 40 08          	mov    0x8(%rax),%rax
  100942:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100946:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10094d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100951:	8b 00                	mov    (%rax),%eax
  100953:	48 98                	cltq   
  100955:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100959:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10095d:	48 c1 f8 38          	sar    $0x38,%rax
  100961:	25 80 00 00 00       	and    $0x80,%eax
  100966:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100969:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  10096d:	74 09                	je     100978 <printer_vprintf+0x412>
  10096f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100973:	48 f7 d8             	neg    %rax
  100976:	eb 04                	jmp    10097c <printer_vprintf+0x416>
  100978:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10097c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100980:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100983:	83 c8 60             	or     $0x60,%eax
  100986:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100989:	e9 cf 02 00 00       	jmp    100c5d <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  10098e:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100992:	74 5d                	je     1009f1 <printer_vprintf+0x48b>
  100994:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10099b:	8b 00                	mov    (%rax),%eax
  10099d:	83 f8 2f             	cmp    $0x2f,%eax
  1009a0:	77 30                	ja     1009d2 <printer_vprintf+0x46c>
  1009a2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009a9:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1009ad:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009b4:	8b 00                	mov    (%rax),%eax
  1009b6:	89 c0                	mov    %eax,%eax
  1009b8:	48 01 d0             	add    %rdx,%rax
  1009bb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009c2:	8b 12                	mov    (%rdx),%edx
  1009c4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1009c7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009ce:	89 0a                	mov    %ecx,(%rdx)
  1009d0:	eb 1a                	jmp    1009ec <printer_vprintf+0x486>
  1009d2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009d9:	48 8b 40 08          	mov    0x8(%rax),%rax
  1009dd:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1009e1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009e8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1009ec:	48 8b 00             	mov    (%rax),%rax
  1009ef:	eb 5c                	jmp    100a4d <printer_vprintf+0x4e7>
  1009f1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009f8:	8b 00                	mov    (%rax),%eax
  1009fa:	83 f8 2f             	cmp    $0x2f,%eax
  1009fd:	77 30                	ja     100a2f <printer_vprintf+0x4c9>
  1009ff:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a06:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a0a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a11:	8b 00                	mov    (%rax),%eax
  100a13:	89 c0                	mov    %eax,%eax
  100a15:	48 01 d0             	add    %rdx,%rax
  100a18:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a1f:	8b 12                	mov    (%rdx),%edx
  100a21:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a24:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a2b:	89 0a                	mov    %ecx,(%rdx)
  100a2d:	eb 1a                	jmp    100a49 <printer_vprintf+0x4e3>
  100a2f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a36:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a3a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a3e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a45:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a49:	8b 00                	mov    (%rax),%eax
  100a4b:	89 c0                	mov    %eax,%eax
  100a4d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100a51:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100a55:	e9 03 02 00 00       	jmp    100c5d <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100a5a:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100a61:	e9 28 ff ff ff       	jmp    10098e <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100a66:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100a6d:	e9 1c ff ff ff       	jmp    10098e <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100a72:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a79:	8b 00                	mov    (%rax),%eax
  100a7b:	83 f8 2f             	cmp    $0x2f,%eax
  100a7e:	77 30                	ja     100ab0 <printer_vprintf+0x54a>
  100a80:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a87:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a8b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a92:	8b 00                	mov    (%rax),%eax
  100a94:	89 c0                	mov    %eax,%eax
  100a96:	48 01 d0             	add    %rdx,%rax
  100a99:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aa0:	8b 12                	mov    (%rdx),%edx
  100aa2:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100aa5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aac:	89 0a                	mov    %ecx,(%rdx)
  100aae:	eb 1a                	jmp    100aca <printer_vprintf+0x564>
  100ab0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ab7:	48 8b 40 08          	mov    0x8(%rax),%rax
  100abb:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100abf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ac6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100aca:	48 8b 00             	mov    (%rax),%rax
  100acd:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100ad1:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100ad8:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100adf:	e9 79 01 00 00       	jmp    100c5d <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100ae4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100aeb:	8b 00                	mov    (%rax),%eax
  100aed:	83 f8 2f             	cmp    $0x2f,%eax
  100af0:	77 30                	ja     100b22 <printer_vprintf+0x5bc>
  100af2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100af9:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100afd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b04:	8b 00                	mov    (%rax),%eax
  100b06:	89 c0                	mov    %eax,%eax
  100b08:	48 01 d0             	add    %rdx,%rax
  100b0b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b12:	8b 12                	mov    (%rdx),%edx
  100b14:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b17:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b1e:	89 0a                	mov    %ecx,(%rdx)
  100b20:	eb 1a                	jmp    100b3c <printer_vprintf+0x5d6>
  100b22:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b29:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b2d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b31:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b38:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b3c:	48 8b 00             	mov    (%rax),%rax
  100b3f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100b43:	e9 15 01 00 00       	jmp    100c5d <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100b48:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b4f:	8b 00                	mov    (%rax),%eax
  100b51:	83 f8 2f             	cmp    $0x2f,%eax
  100b54:	77 30                	ja     100b86 <printer_vprintf+0x620>
  100b56:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b5d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b61:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b68:	8b 00                	mov    (%rax),%eax
  100b6a:	89 c0                	mov    %eax,%eax
  100b6c:	48 01 d0             	add    %rdx,%rax
  100b6f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b76:	8b 12                	mov    (%rdx),%edx
  100b78:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b7b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b82:	89 0a                	mov    %ecx,(%rdx)
  100b84:	eb 1a                	jmp    100ba0 <printer_vprintf+0x63a>
  100b86:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b8d:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b91:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b95:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b9c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ba0:	8b 00                	mov    (%rax),%eax
  100ba2:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100ba8:	e9 67 03 00 00       	jmp    100f14 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  100bad:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100bb1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100bb5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bbc:	8b 00                	mov    (%rax),%eax
  100bbe:	83 f8 2f             	cmp    $0x2f,%eax
  100bc1:	77 30                	ja     100bf3 <printer_vprintf+0x68d>
  100bc3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bca:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100bce:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bd5:	8b 00                	mov    (%rax),%eax
  100bd7:	89 c0                	mov    %eax,%eax
  100bd9:	48 01 d0             	add    %rdx,%rax
  100bdc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100be3:	8b 12                	mov    (%rdx),%edx
  100be5:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100be8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bef:	89 0a                	mov    %ecx,(%rdx)
  100bf1:	eb 1a                	jmp    100c0d <printer_vprintf+0x6a7>
  100bf3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bfa:	48 8b 40 08          	mov    0x8(%rax),%rax
  100bfe:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c02:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c09:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c0d:	8b 00                	mov    (%rax),%eax
  100c0f:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100c12:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100c16:	eb 45                	jmp    100c5d <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  100c18:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100c1c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100c20:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c27:	0f b6 00             	movzbl (%rax),%eax
  100c2a:	84 c0                	test   %al,%al
  100c2c:	74 0c                	je     100c3a <printer_vprintf+0x6d4>
  100c2e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c35:	0f b6 00             	movzbl (%rax),%eax
  100c38:	eb 05                	jmp    100c3f <printer_vprintf+0x6d9>
  100c3a:	b8 25 00 00 00       	mov    $0x25,%eax
  100c3f:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100c42:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100c46:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c4d:	0f b6 00             	movzbl (%rax),%eax
  100c50:	84 c0                	test   %al,%al
  100c52:	75 08                	jne    100c5c <printer_vprintf+0x6f6>
                format--;
  100c54:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100c5b:	01 
            }
            break;
  100c5c:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100c5d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c60:	83 e0 20             	and    $0x20,%eax
  100c63:	85 c0                	test   %eax,%eax
  100c65:	74 1e                	je     100c85 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100c67:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100c6b:	48 83 c0 18          	add    $0x18,%rax
  100c6f:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100c72:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100c76:	48 89 ce             	mov    %rcx,%rsi
  100c79:	48 89 c7             	mov    %rax,%rdi
  100c7c:	e8 63 f8 ff ff       	call   1004e4 <fill_numbuf>
  100c81:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100c85:	48 c7 45 c0 a6 12 10 	movq   $0x1012a6,-0x40(%rbp)
  100c8c:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100c8d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c90:	83 e0 20             	and    $0x20,%eax
  100c93:	85 c0                	test   %eax,%eax
  100c95:	74 48                	je     100cdf <printer_vprintf+0x779>
  100c97:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c9a:	83 e0 40             	and    $0x40,%eax
  100c9d:	85 c0                	test   %eax,%eax
  100c9f:	74 3e                	je     100cdf <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  100ca1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ca4:	25 80 00 00 00       	and    $0x80,%eax
  100ca9:	85 c0                	test   %eax,%eax
  100cab:	74 0a                	je     100cb7 <printer_vprintf+0x751>
                prefix = "-";
  100cad:	48 c7 45 c0 a7 12 10 	movq   $0x1012a7,-0x40(%rbp)
  100cb4:	00 
            if (flags & FLAG_NEGATIVE) {
  100cb5:	eb 73                	jmp    100d2a <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100cb7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cba:	83 e0 10             	and    $0x10,%eax
  100cbd:	85 c0                	test   %eax,%eax
  100cbf:	74 0a                	je     100ccb <printer_vprintf+0x765>
                prefix = "+";
  100cc1:	48 c7 45 c0 a9 12 10 	movq   $0x1012a9,-0x40(%rbp)
  100cc8:	00 
            if (flags & FLAG_NEGATIVE) {
  100cc9:	eb 5f                	jmp    100d2a <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100ccb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cce:	83 e0 08             	and    $0x8,%eax
  100cd1:	85 c0                	test   %eax,%eax
  100cd3:	74 55                	je     100d2a <printer_vprintf+0x7c4>
                prefix = " ";
  100cd5:	48 c7 45 c0 ab 12 10 	movq   $0x1012ab,-0x40(%rbp)
  100cdc:	00 
            if (flags & FLAG_NEGATIVE) {
  100cdd:	eb 4b                	jmp    100d2a <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100cdf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ce2:	83 e0 20             	and    $0x20,%eax
  100ce5:	85 c0                	test   %eax,%eax
  100ce7:	74 42                	je     100d2b <printer_vprintf+0x7c5>
  100ce9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cec:	83 e0 01             	and    $0x1,%eax
  100cef:	85 c0                	test   %eax,%eax
  100cf1:	74 38                	je     100d2b <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  100cf3:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100cf7:	74 06                	je     100cff <printer_vprintf+0x799>
  100cf9:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100cfd:	75 2c                	jne    100d2b <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  100cff:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100d04:	75 0c                	jne    100d12 <printer_vprintf+0x7ac>
  100d06:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d09:	25 00 01 00 00       	and    $0x100,%eax
  100d0e:	85 c0                	test   %eax,%eax
  100d10:	74 19                	je     100d2b <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  100d12:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100d16:	75 07                	jne    100d1f <printer_vprintf+0x7b9>
  100d18:	b8 ad 12 10 00       	mov    $0x1012ad,%eax
  100d1d:	eb 05                	jmp    100d24 <printer_vprintf+0x7be>
  100d1f:	b8 b0 12 10 00       	mov    $0x1012b0,%eax
  100d24:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100d28:	eb 01                	jmp    100d2b <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  100d2a:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100d2b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100d2f:	78 24                	js     100d55 <printer_vprintf+0x7ef>
  100d31:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d34:	83 e0 20             	and    $0x20,%eax
  100d37:	85 c0                	test   %eax,%eax
  100d39:	75 1a                	jne    100d55 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  100d3b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100d3e:	48 63 d0             	movslq %eax,%rdx
  100d41:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100d45:	48 89 d6             	mov    %rdx,%rsi
  100d48:	48 89 c7             	mov    %rax,%rdi
  100d4b:	e8 ea f5 ff ff       	call   10033a <strnlen>
  100d50:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100d53:	eb 0f                	jmp    100d64 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  100d55:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100d59:	48 89 c7             	mov    %rax,%rdi
  100d5c:	e8 a8 f5 ff ff       	call   100309 <strlen>
  100d61:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100d64:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d67:	83 e0 20             	and    $0x20,%eax
  100d6a:	85 c0                	test   %eax,%eax
  100d6c:	74 20                	je     100d8e <printer_vprintf+0x828>
  100d6e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100d72:	78 1a                	js     100d8e <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  100d74:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100d77:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100d7a:	7e 08                	jle    100d84 <printer_vprintf+0x81e>
  100d7c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100d7f:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100d82:	eb 05                	jmp    100d89 <printer_vprintf+0x823>
  100d84:	b8 00 00 00 00       	mov    $0x0,%eax
  100d89:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100d8c:	eb 5c                	jmp    100dea <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100d8e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d91:	83 e0 20             	and    $0x20,%eax
  100d94:	85 c0                	test   %eax,%eax
  100d96:	74 4b                	je     100de3 <printer_vprintf+0x87d>
  100d98:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d9b:	83 e0 02             	and    $0x2,%eax
  100d9e:	85 c0                	test   %eax,%eax
  100da0:	74 41                	je     100de3 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100da2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100da5:	83 e0 04             	and    $0x4,%eax
  100da8:	85 c0                	test   %eax,%eax
  100daa:	75 37                	jne    100de3 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  100dac:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100db0:	48 89 c7             	mov    %rax,%rdi
  100db3:	e8 51 f5 ff ff       	call   100309 <strlen>
  100db8:	89 c2                	mov    %eax,%edx
  100dba:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100dbd:	01 d0                	add    %edx,%eax
  100dbf:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100dc2:	7e 1f                	jle    100de3 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  100dc4:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100dc7:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100dca:	89 c3                	mov    %eax,%ebx
  100dcc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100dd0:	48 89 c7             	mov    %rax,%rdi
  100dd3:	e8 31 f5 ff ff       	call   100309 <strlen>
  100dd8:	89 c2                	mov    %eax,%edx
  100dda:	89 d8                	mov    %ebx,%eax
  100ddc:	29 d0                	sub    %edx,%eax
  100dde:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100de1:	eb 07                	jmp    100dea <printer_vprintf+0x884>
        } else {
            zeros = 0;
  100de3:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100dea:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100ded:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100df0:	01 d0                	add    %edx,%eax
  100df2:	48 63 d8             	movslq %eax,%rbx
  100df5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100df9:	48 89 c7             	mov    %rax,%rdi
  100dfc:	e8 08 f5 ff ff       	call   100309 <strlen>
  100e01:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100e05:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100e08:	29 d0                	sub    %edx,%eax
  100e0a:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100e0d:	eb 25                	jmp    100e34 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  100e0f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e16:	48 8b 08             	mov    (%rax),%rcx
  100e19:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100e1f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e26:	be 20 00 00 00       	mov    $0x20,%esi
  100e2b:	48 89 c7             	mov    %rax,%rdi
  100e2e:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100e30:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100e34:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e37:	83 e0 04             	and    $0x4,%eax
  100e3a:	85 c0                	test   %eax,%eax
  100e3c:	75 36                	jne    100e74 <printer_vprintf+0x90e>
  100e3e:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100e42:	7f cb                	jg     100e0f <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  100e44:	eb 2e                	jmp    100e74 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  100e46:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e4d:	4c 8b 00             	mov    (%rax),%r8
  100e50:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e54:	0f b6 00             	movzbl (%rax),%eax
  100e57:	0f b6 c8             	movzbl %al,%ecx
  100e5a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100e60:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e67:	89 ce                	mov    %ecx,%esi
  100e69:	48 89 c7             	mov    %rax,%rdi
  100e6c:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  100e6f:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  100e74:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e78:	0f b6 00             	movzbl (%rax),%eax
  100e7b:	84 c0                	test   %al,%al
  100e7d:	75 c7                	jne    100e46 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  100e7f:	eb 25                	jmp    100ea6 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  100e81:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e88:	48 8b 08             	mov    (%rax),%rcx
  100e8b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100e91:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e98:	be 30 00 00 00       	mov    $0x30,%esi
  100e9d:	48 89 c7             	mov    %rax,%rdi
  100ea0:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  100ea2:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  100ea6:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  100eaa:	7f d5                	jg     100e81 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  100eac:	eb 32                	jmp    100ee0 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  100eae:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100eb5:	4c 8b 00             	mov    (%rax),%r8
  100eb8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100ebc:	0f b6 00             	movzbl (%rax),%eax
  100ebf:	0f b6 c8             	movzbl %al,%ecx
  100ec2:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100ec8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ecf:	89 ce                	mov    %ecx,%esi
  100ed1:	48 89 c7             	mov    %rax,%rdi
  100ed4:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  100ed7:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  100edc:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  100ee0:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  100ee4:	7f c8                	jg     100eae <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  100ee6:	eb 25                	jmp    100f0d <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  100ee8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100eef:	48 8b 08             	mov    (%rax),%rcx
  100ef2:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100ef8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100eff:	be 20 00 00 00       	mov    $0x20,%esi
  100f04:	48 89 c7             	mov    %rax,%rdi
  100f07:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  100f09:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100f0d:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100f11:	7f d5                	jg     100ee8 <printer_vprintf+0x982>
        }
    done: ;
  100f13:	90                   	nop
    for (; *format; ++format) {
  100f14:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100f1b:	01 
  100f1c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f23:	0f b6 00             	movzbl (%rax),%eax
  100f26:	84 c0                	test   %al,%al
  100f28:	0f 85 64 f6 ff ff    	jne    100592 <printer_vprintf+0x2c>
    }
}
  100f2e:	90                   	nop
  100f2f:	90                   	nop
  100f30:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100f34:	c9                   	leave  
  100f35:	c3                   	ret    

0000000000100f36 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100f36:	55                   	push   %rbp
  100f37:	48 89 e5             	mov    %rsp,%rbp
  100f3a:	48 83 ec 20          	sub    $0x20,%rsp
  100f3e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100f42:	89 f0                	mov    %esi,%eax
  100f44:	89 55 e0             	mov    %edx,-0x20(%rbp)
  100f47:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  100f4a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100f4e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100f52:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100f56:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f5a:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  100f5f:	48 39 d0             	cmp    %rdx,%rax
  100f62:	72 0c                	jb     100f70 <console_putc+0x3a>
        cp->cursor = console;
  100f64:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100f68:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  100f6f:	00 
    }
    if (c == '\n') {
  100f70:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  100f74:	75 78                	jne    100fee <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  100f76:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100f7a:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f7e:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  100f84:	48 d1 f8             	sar    %rax
  100f87:	48 89 c1             	mov    %rax,%rcx
  100f8a:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  100f91:	66 66 66 
  100f94:	48 89 c8             	mov    %rcx,%rax
  100f97:	48 f7 ea             	imul   %rdx
  100f9a:	48 c1 fa 05          	sar    $0x5,%rdx
  100f9e:	48 89 c8             	mov    %rcx,%rax
  100fa1:	48 c1 f8 3f          	sar    $0x3f,%rax
  100fa5:	48 29 c2             	sub    %rax,%rdx
  100fa8:	48 89 d0             	mov    %rdx,%rax
  100fab:	48 c1 e0 02          	shl    $0x2,%rax
  100faf:	48 01 d0             	add    %rdx,%rax
  100fb2:	48 c1 e0 04          	shl    $0x4,%rax
  100fb6:	48 29 c1             	sub    %rax,%rcx
  100fb9:	48 89 ca             	mov    %rcx,%rdx
  100fbc:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  100fbf:	eb 25                	jmp    100fe6 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  100fc1:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100fc4:	83 c8 20             	or     $0x20,%eax
  100fc7:	89 c6                	mov    %eax,%esi
  100fc9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100fcd:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fd1:	48 8d 48 02          	lea    0x2(%rax),%rcx
  100fd5:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  100fd9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100fdd:	89 f2                	mov    %esi,%edx
  100fdf:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  100fe2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  100fe6:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  100fea:	75 d5                	jne    100fc1 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  100fec:	eb 24                	jmp    101012 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  100fee:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  100ff2:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100ff5:	09 d0                	or     %edx,%eax
  100ff7:	89 c6                	mov    %eax,%esi
  100ff9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100ffd:	48 8b 40 08          	mov    0x8(%rax),%rax
  101001:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101005:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101009:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10100d:	89 f2                	mov    %esi,%edx
  10100f:	66 89 10             	mov    %dx,(%rax)
}
  101012:	90                   	nop
  101013:	c9                   	leave  
  101014:	c3                   	ret    

0000000000101015 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  101015:	55                   	push   %rbp
  101016:	48 89 e5             	mov    %rsp,%rbp
  101019:	48 83 ec 30          	sub    $0x30,%rsp
  10101d:	89 7d ec             	mov    %edi,-0x14(%rbp)
  101020:	89 75 e8             	mov    %esi,-0x18(%rbp)
  101023:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101027:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  10102b:	48 c7 45 f0 36 0f 10 	movq   $0x100f36,-0x10(%rbp)
  101032:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101033:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  101037:	78 09                	js     101042 <console_vprintf+0x2d>
  101039:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101040:	7e 07                	jle    101049 <console_vprintf+0x34>
        cpos = 0;
  101042:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  101049:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10104c:	48 98                	cltq   
  10104e:	48 01 c0             	add    %rax,%rax
  101051:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  101057:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  10105b:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  10105f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  101063:	8b 75 e8             	mov    -0x18(%rbp),%esi
  101066:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  10106a:	48 89 c7             	mov    %rax,%rdi
  10106d:	e8 f4 f4 ff ff       	call   100566 <printer_vprintf>
    return cp.cursor - console;
  101072:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101076:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  10107c:	48 d1 f8             	sar    %rax
}
  10107f:	c9                   	leave  
  101080:	c3                   	ret    

0000000000101081 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  101081:	55                   	push   %rbp
  101082:	48 89 e5             	mov    %rsp,%rbp
  101085:	48 83 ec 60          	sub    $0x60,%rsp
  101089:	89 7d ac             	mov    %edi,-0x54(%rbp)
  10108c:	89 75 a8             	mov    %esi,-0x58(%rbp)
  10108f:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  101093:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101097:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10109b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  10109f:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1010a6:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1010aa:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1010ae:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1010b2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1010b6:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1010ba:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  1010be:	8b 75 a8             	mov    -0x58(%rbp),%esi
  1010c1:	8b 45 ac             	mov    -0x54(%rbp),%eax
  1010c4:	89 c7                	mov    %eax,%edi
  1010c6:	e8 4a ff ff ff       	call   101015 <console_vprintf>
  1010cb:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  1010ce:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  1010d1:	c9                   	leave  
  1010d2:	c3                   	ret    

00000000001010d3 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  1010d3:	55                   	push   %rbp
  1010d4:	48 89 e5             	mov    %rsp,%rbp
  1010d7:	48 83 ec 20          	sub    $0x20,%rsp
  1010db:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1010df:	89 f0                	mov    %esi,%eax
  1010e1:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1010e4:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  1010e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1010eb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  1010ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1010f3:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1010f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1010fb:	48 8b 40 10          	mov    0x10(%rax),%rax
  1010ff:	48 39 c2             	cmp    %rax,%rdx
  101102:	73 1a                	jae    10111e <string_putc+0x4b>
        *sp->s++ = c;
  101104:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101108:	48 8b 40 08          	mov    0x8(%rax),%rax
  10110c:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101110:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101114:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101118:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  10111c:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  10111e:	90                   	nop
  10111f:	c9                   	leave  
  101120:	c3                   	ret    

0000000000101121 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101121:	55                   	push   %rbp
  101122:	48 89 e5             	mov    %rsp,%rbp
  101125:	48 83 ec 40          	sub    $0x40,%rsp
  101129:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  10112d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101131:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  101135:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101139:	48 c7 45 e8 d3 10 10 	movq   $0x1010d3,-0x18(%rbp)
  101140:	00 
    sp.s = s;
  101141:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101145:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  101149:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  10114e:	74 33                	je     101183 <vsnprintf+0x62>
        sp.end = s + size - 1;
  101150:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101154:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101158:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10115c:	48 01 d0             	add    %rdx,%rax
  10115f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101163:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101167:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  10116b:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  10116f:	be 00 00 00 00       	mov    $0x0,%esi
  101174:	48 89 c7             	mov    %rax,%rdi
  101177:	e8 ea f3 ff ff       	call   100566 <printer_vprintf>
        *sp.s = 0;
  10117c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101180:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  101183:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101187:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  10118b:	c9                   	leave  
  10118c:	c3                   	ret    

000000000010118d <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  10118d:	55                   	push   %rbp
  10118e:	48 89 e5             	mov    %rsp,%rbp
  101191:	48 83 ec 70          	sub    $0x70,%rsp
  101195:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101199:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  10119d:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1011a1:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1011a5:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1011a9:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1011ad:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  1011b4:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1011b8:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  1011bc:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1011c0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  1011c4:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  1011c8:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  1011cc:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  1011d0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1011d4:	48 89 c7             	mov    %rax,%rdi
  1011d7:	e8 45 ff ff ff       	call   101121 <vsnprintf>
  1011dc:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  1011df:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  1011e2:	c9                   	leave  
  1011e3:	c3                   	ret    

00000000001011e4 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  1011e4:	55                   	push   %rbp
  1011e5:	48 89 e5             	mov    %rsp,%rbp
  1011e8:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1011ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  1011f3:	eb 13                	jmp    101208 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  1011f5:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1011f8:	48 98                	cltq   
  1011fa:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  101201:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101204:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101208:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  10120f:	7e e4                	jle    1011f5 <console_clear+0x11>
    }
    cursorpos = 0;
  101211:	c7 05 e1 7d fb ff 00 	movl   $0x0,-0x4821f(%rip)        # b8ffc <cursorpos>
  101218:	00 00 00 
}
  10121b:	90                   	nop
  10121c:	c9                   	leave  
  10121d:	c3                   	ret    
