
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
uint8_t* stack_bottom;

// Program that checks if pages are shared between parent and child
// It also checks if code pages are allocated one-to-one va->pa or not

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	48 83 ec 30          	sub    $0x30,%rsp

    uint8_t * code_page = ROUNDDOWN(end - PAGESIZE - 1, PAGESIZE);
  100008:	be 07 10 10 00       	mov    $0x101007,%esi
  10000d:	48 81 e6 00 f0 ff ff 	and    $0xfffffffffffff000,%rsi
// looks up the virtual memory mapping for addr for the current process 
// and stores it inside map. [map, sizeof(vampping)) address should be 
// allocated, writable addresses to the process, otherwise syscall will 
// not write anything to the variable
static inline void sys_mapping(uintptr_t addr, void * map){
    asm volatile ("int %0" : /* no result */
  100014:	48 8d 7d e8          	lea    -0x18(%rbp),%rdi
  100018:	cd 36                	int    $0x36
    asm volatile ("int %1" 
  10001a:	cd 34                	int    $0x34
    sys_mapping((uintptr_t)code_page, &map);

    // Fork a total of three new copies.

    pid_t p1 = sys_fork();
    assert(p1 >= 0);
  10001c:	85 c0                	test   %eax,%eax
  10001e:	78 57                	js     100077 <process_main+0x77>
  100020:	89 c2                	mov    %eax,%edx
  100022:	cd 34                	int    $0x34
  100024:	89 c1                	mov    %eax,%ecx
    pid_t p2 = sys_fork();
    assert(p2 >= 0);
  100026:	85 c0                	test   %eax,%eax
  100028:	78 61                	js     10008b <process_main+0x8b>
    asm volatile ("int %1" : "=a" (result)
  10002a:	cd 31                	int    $0x31

    // Check fork return values: fork should return 0 to child.
    if (sys_getpid() == 1) {
  10002c:	83 f8 01             	cmp    $0x1,%eax
  10002f:	74 6e                	je     10009f <process_main+0x9f>
        assert(p1 != 0 && p2 != 0 && p1 != p2);
    } else {
        assert(p1 == 0 || p2 == 0);
  100031:	85 d2                	test   %edx,%edx
  100033:	74 08                	je     10003d <process_main+0x3d>
  100035:	85 c9                	test   %ecx,%ecx
  100037:	0f 85 88 00 00 00    	jne    1000c5 <process_main+0xc5>
    asm volatile ("int %0" : /* no result */
  10003d:	48 8d 7d d0          	lea    -0x30(%rbp),%rdi
  100041:	cd 36                	int    $0x36

    // Now, lets check code page mapping
    vamapping child_cmap;
    sys_mapping((uintptr_t) code_page, &child_cmap);

    if(child_cmap.pa != map.pa){
  100043:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100047:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  10004b:	48 39 d1             	cmp    %rdx,%rcx
  10004e:	0f 85 85 00 00 00    	jne    1000d9 <process_main+0xd9>
    asm volatile ("int %0" : /* no result */
  100054:	cd 32                	int    $0x32
  100056:	cd 32                	int    $0x32
    }

    sys_yield();
    sys_yield();

    if(child_cmap.pa == (uintptr_t)code_page || map.pa == (uintptr_t)code_page)
  100058:	48 3b 75 d8          	cmp    -0x28(%rbp),%rsi
  10005c:	74 0a                	je     100068 <process_main+0x68>
  10005e:	48 3b 75 f0          	cmp    -0x10(%rbp),%rsi
  100062:	0f 85 80 00 00 00    	jne    1000e8 <process_main+0xe8>
        panic("Error, code pages are not virtually mapped!");
  100068:	bf 90 13 10 00       	mov    $0x101390,%edi
  10006d:	b8 00 00 00 00       	mov    $0x0,%eax
  100072:	e8 12 01 00 00       	call   100189 <panic>
    assert(p1 >= 0);
  100077:	ba e0 12 10 00       	mov    $0x1012e0,%edx
  10007c:	be 15 00 00 00       	mov    $0x15,%esi
  100081:	bf e8 12 10 00       	mov    $0x1012e8,%edi
  100086:	e8 cb 01 00 00       	call   100256 <assert_fail>
    assert(p2 >= 0);
  10008b:	ba f8 12 10 00       	mov    $0x1012f8,%edx
  100090:	be 17 00 00 00       	mov    $0x17,%esi
  100095:	bf e8 12 10 00       	mov    $0x1012e8,%edi
  10009a:	e8 b7 01 00 00       	call   100256 <assert_fail>
        assert(p1 != 0 && p2 != 0 && p1 != p2);
  10009f:	85 c9                	test   %ecx,%ecx
  1000a1:	0f 94 c0             	sete   %al
  1000a4:	39 ca                	cmp    %ecx,%edx
  1000a6:	0f 94 c1             	sete   %cl
  1000a9:	08 c8                	or     %cl,%al
  1000ab:	75 04                	jne    1000b1 <process_main+0xb1>
  1000ad:	85 d2                	test   %edx,%edx
  1000af:	75 8c                	jne    10003d <process_main+0x3d>
  1000b1:	ba 30 13 10 00       	mov    $0x101330,%edx
  1000b6:	be 1b 00 00 00       	mov    $0x1b,%esi
  1000bb:	bf e8 12 10 00       	mov    $0x1012e8,%edi
  1000c0:	e8 91 01 00 00       	call   100256 <assert_fail>
        assert(p1 == 0 || p2 == 0);
  1000c5:	ba 00 13 10 00       	mov    $0x101300,%edx
  1000ca:	be 1d 00 00 00       	mov    $0x1d,%esi
  1000cf:	bf e8 12 10 00       	mov    $0x1012e8,%edi
  1000d4:	e8 7d 01 00 00       	call   100256 <assert_fail>
	panic("code page va: %p \t code page pa: %p \t child code page pa: %p\n", code_page, map.pa, child_cmap.pa);
  1000d9:	bf 50 13 10 00       	mov    $0x101350,%edi
  1000de:	b8 00 00 00 00       	mov    $0x0,%eax
  1000e3:	e8 a1 00 00 00       	call   100189 <panic>
  1000e8:	cd 32                	int    $0x32

    sys_yield();
    TEST_PASS();
  1000ea:	bf 13 13 10 00       	mov    $0x101313,%edi
  1000ef:	b8 00 00 00 00       	mov    $0x0,%eax
  1000f4:	e8 90 00 00 00       	call   100189 <panic>

00000000001000f9 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  1000f9:	55                   	push   %rbp
  1000fa:	48 89 e5             	mov    %rsp,%rbp
  1000fd:	48 83 ec 50          	sub    $0x50,%rsp
  100101:	49 89 f2             	mov    %rsi,%r10
  100104:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100108:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10010c:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100110:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  100114:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100119:	85 ff                	test   %edi,%edi
  10011b:	78 2e                	js     10014b <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  10011d:	48 63 ff             	movslq %edi,%rdi
  100120:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  100127:	cc cc cc 
  10012a:	48 89 f8             	mov    %rdi,%rax
  10012d:	48 f7 e2             	mul    %rdx
  100130:	48 89 d0             	mov    %rdx,%rax
  100133:	48 c1 e8 02          	shr    $0x2,%rax
  100137:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  10013b:	48 01 c2             	add    %rax,%rdx
  10013e:	48 29 d7             	sub    %rdx,%rdi
  100141:	0f b6 b7 f5 13 10 00 	movzbl 0x1013f5(%rdi),%esi
  100148:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  10014b:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  100152:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100156:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  10015a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10015e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  100162:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100166:	4c 89 d2             	mov    %r10,%rdx
  100169:	8b 3d 8d 8e fb ff    	mov    -0x47173(%rip),%edi        # b8ffc <cursorpos>
  10016f:	e8 5a 0f 00 00       	call   1010ce <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100174:	3d 30 07 00 00       	cmp    $0x730,%eax
  100179:	ba 00 00 00 00       	mov    $0x0,%edx
  10017e:	0f 4d c2             	cmovge %edx,%eax
  100181:	89 05 75 8e fb ff    	mov    %eax,-0x4718b(%rip)        # b8ffc <cursorpos>
    }
}
  100187:	c9                   	leave  
  100188:	c3                   	ret    

0000000000100189 <panic>:


// panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
  100189:	55                   	push   %rbp
  10018a:	48 89 e5             	mov    %rsp,%rbp
  10018d:	53                   	push   %rbx
  10018e:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100195:	48 89 fb             	mov    %rdi,%rbx
  100198:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  10019c:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  1001a0:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  1001a4:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  1001a8:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  1001ac:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  1001b3:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1001b7:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  1001bb:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  1001bf:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  1001c3:	ba 07 00 00 00       	mov    $0x7,%edx
  1001c8:	be bc 13 10 00       	mov    $0x1013bc,%esi
  1001cd:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  1001d4:	e8 ac 00 00 00       	call   100285 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  1001d9:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  1001dd:	48 89 da             	mov    %rbx,%rdx
  1001e0:	be 99 00 00 00       	mov    $0x99,%esi
  1001e5:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  1001ec:	e8 e9 0f 00 00       	call   1011da <vsnprintf>
  1001f1:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  1001f4:	85 d2                	test   %edx,%edx
  1001f6:	7e 0f                	jle    100207 <panic+0x7e>
  1001f8:	83 c0 06             	add    $0x6,%eax
  1001fb:	48 98                	cltq   
  1001fd:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  100204:	0a 
  100205:	75 29                	jne    100230 <panic+0xa7>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  100207:	48 8d 8d 08 ff ff ff 	lea    -0xf8(%rbp),%rcx
  10020e:	ba c6 13 10 00       	mov    $0x1013c6,%edx
  100213:	be 00 c0 00 00       	mov    $0xc000,%esi
  100218:	bf 30 07 00 00       	mov    $0x730,%edi
  10021d:	b8 00 00 00 00       	mov    $0x0,%eax
  100222:	e8 13 0f 00 00       	call   10113a <console_printf>
    asm volatile ("int %0" : /* no result */
  100227:	bf 00 00 00 00       	mov    $0x0,%edi
  10022c:	cd 30                	int    $0x30
 loop: goto loop;
  10022e:	eb fe                	jmp    10022e <panic+0xa5>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  100230:	48 63 c2             	movslq %edx,%rax
  100233:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  100239:	0f 94 c2             	sete   %dl
  10023c:	0f b6 d2             	movzbl %dl,%edx
  10023f:	48 29 d0             	sub    %rdx,%rax
  100242:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  100249:	ff 
  10024a:	be c4 13 10 00       	mov    $0x1013c4,%esi
  10024f:	e8 de 01 00 00       	call   100432 <strcpy>
  100254:	eb b1                	jmp    100207 <panic+0x7e>

0000000000100256 <assert_fail>:
    sys_panic(NULL);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  100256:	55                   	push   %rbp
  100257:	48 89 e5             	mov    %rsp,%rbp
  10025a:	48 89 f9             	mov    %rdi,%rcx
  10025d:	41 89 f0             	mov    %esi,%r8d
  100260:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100263:	ba d0 13 10 00       	mov    $0x1013d0,%edx
  100268:	be 00 c0 00 00       	mov    $0xc000,%esi
  10026d:	bf 30 07 00 00       	mov    $0x730,%edi
  100272:	b8 00 00 00 00       	mov    $0x0,%eax
  100277:	e8 be 0e 00 00       	call   10113a <console_printf>
    asm volatile ("int %0" : /* no result */
  10027c:	bf 00 00 00 00       	mov    $0x0,%edi
  100281:	cd 30                	int    $0x30
 loop: goto loop;
  100283:	eb fe                	jmp    100283 <assert_fail+0x2d>

0000000000100285 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100285:	55                   	push   %rbp
  100286:	48 89 e5             	mov    %rsp,%rbp
  100289:	48 83 ec 28          	sub    $0x28,%rsp
  10028d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100291:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100295:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100299:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10029d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1002a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1002a5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  1002a9:	eb 1c                	jmp    1002c7 <memcpy+0x42>
        *d = *s;
  1002ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002af:	0f b6 10             	movzbl (%rax),%edx
  1002b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1002b6:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1002b8:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1002bd:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1002c2:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1002c7:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1002cc:	75 dd                	jne    1002ab <memcpy+0x26>
    }
    return dst;
  1002ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1002d2:	c9                   	leave  
  1002d3:	c3                   	ret    

00000000001002d4 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1002d4:	55                   	push   %rbp
  1002d5:	48 89 e5             	mov    %rsp,%rbp
  1002d8:	48 83 ec 28          	sub    $0x28,%rsp
  1002dc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1002e0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1002e4:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1002e8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1002ec:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  1002f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1002f4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  1002f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002fc:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  100300:	73 6a                	jae    10036c <memmove+0x98>
  100302:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100306:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10030a:	48 01 d0             	add    %rdx,%rax
  10030d:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100311:	73 59                	jae    10036c <memmove+0x98>
        s += n, d += n;
  100313:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100317:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  10031b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10031f:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  100323:	eb 17                	jmp    10033c <memmove+0x68>
            *--d = *--s;
  100325:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  10032a:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  10032f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100333:	0f b6 10             	movzbl (%rax),%edx
  100336:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10033a:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  10033c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100340:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100344:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100348:	48 85 c0             	test   %rax,%rax
  10034b:	75 d8                	jne    100325 <memmove+0x51>
    if (s < d && s + n > d) {
  10034d:	eb 2e                	jmp    10037d <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  10034f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100353:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100357:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10035b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10035f:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100363:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100367:	0f b6 12             	movzbl (%rdx),%edx
  10036a:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  10036c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100370:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100374:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100378:	48 85 c0             	test   %rax,%rax
  10037b:	75 d2                	jne    10034f <memmove+0x7b>
        }
    }
    return dst;
  10037d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100381:	c9                   	leave  
  100382:	c3                   	ret    

0000000000100383 <memset>:

void* memset(void* v, int c, size_t n) {
  100383:	55                   	push   %rbp
  100384:	48 89 e5             	mov    %rsp,%rbp
  100387:	48 83 ec 28          	sub    $0x28,%rsp
  10038b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10038f:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100392:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100396:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10039a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10039e:	eb 15                	jmp    1003b5 <memset+0x32>
        *p = c;
  1003a0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1003a3:	89 c2                	mov    %eax,%edx
  1003a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003a9:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1003ab:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1003b0:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1003b5:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1003ba:	75 e4                	jne    1003a0 <memset+0x1d>
    }
    return v;
  1003bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1003c0:	c9                   	leave  
  1003c1:	c3                   	ret    

00000000001003c2 <strlen>:

size_t strlen(const char* s) {
  1003c2:	55                   	push   %rbp
  1003c3:	48 89 e5             	mov    %rsp,%rbp
  1003c6:	48 83 ec 18          	sub    $0x18,%rsp
  1003ca:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  1003ce:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1003d5:	00 
  1003d6:	eb 0a                	jmp    1003e2 <strlen+0x20>
        ++n;
  1003d8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  1003dd:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1003e2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1003e6:	0f b6 00             	movzbl (%rax),%eax
  1003e9:	84 c0                	test   %al,%al
  1003eb:	75 eb                	jne    1003d8 <strlen+0x16>
    }
    return n;
  1003ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1003f1:	c9                   	leave  
  1003f2:	c3                   	ret    

00000000001003f3 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  1003f3:	55                   	push   %rbp
  1003f4:	48 89 e5             	mov    %rsp,%rbp
  1003f7:	48 83 ec 20          	sub    $0x20,%rsp
  1003fb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1003ff:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100403:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  10040a:	00 
  10040b:	eb 0a                	jmp    100417 <strnlen+0x24>
        ++n;
  10040d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100412:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100417:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10041b:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  10041f:	74 0b                	je     10042c <strnlen+0x39>
  100421:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100425:	0f b6 00             	movzbl (%rax),%eax
  100428:	84 c0                	test   %al,%al
  10042a:	75 e1                	jne    10040d <strnlen+0x1a>
    }
    return n;
  10042c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100430:	c9                   	leave  
  100431:	c3                   	ret    

0000000000100432 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100432:	55                   	push   %rbp
  100433:	48 89 e5             	mov    %rsp,%rbp
  100436:	48 83 ec 20          	sub    $0x20,%rsp
  10043a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10043e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  100442:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100446:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  10044a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  10044e:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100452:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100456:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10045a:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10045e:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100462:	0f b6 12             	movzbl (%rdx),%edx
  100465:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100467:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10046b:	48 83 e8 01          	sub    $0x1,%rax
  10046f:	0f b6 00             	movzbl (%rax),%eax
  100472:	84 c0                	test   %al,%al
  100474:	75 d4                	jne    10044a <strcpy+0x18>
    return dst;
  100476:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10047a:	c9                   	leave  
  10047b:	c3                   	ret    

000000000010047c <strcmp>:

int strcmp(const char* a, const char* b) {
  10047c:	55                   	push   %rbp
  10047d:	48 89 e5             	mov    %rsp,%rbp
  100480:	48 83 ec 10          	sub    $0x10,%rsp
  100484:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100488:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10048c:	eb 0a                	jmp    100498 <strcmp+0x1c>
        ++a, ++b;
  10048e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100493:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100498:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10049c:	0f b6 00             	movzbl (%rax),%eax
  10049f:	84 c0                	test   %al,%al
  1004a1:	74 1d                	je     1004c0 <strcmp+0x44>
  1004a3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004a7:	0f b6 00             	movzbl (%rax),%eax
  1004aa:	84 c0                	test   %al,%al
  1004ac:	74 12                	je     1004c0 <strcmp+0x44>
  1004ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004b2:	0f b6 10             	movzbl (%rax),%edx
  1004b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004b9:	0f b6 00             	movzbl (%rax),%eax
  1004bc:	38 c2                	cmp    %al,%dl
  1004be:	74 ce                	je     10048e <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  1004c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004c4:	0f b6 00             	movzbl (%rax),%eax
  1004c7:	89 c2                	mov    %eax,%edx
  1004c9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004cd:	0f b6 00             	movzbl (%rax),%eax
  1004d0:	38 d0                	cmp    %dl,%al
  1004d2:	0f 92 c0             	setb   %al
  1004d5:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  1004d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004dc:	0f b6 00             	movzbl (%rax),%eax
  1004df:	89 c1                	mov    %eax,%ecx
  1004e1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004e5:	0f b6 00             	movzbl (%rax),%eax
  1004e8:	38 c1                	cmp    %al,%cl
  1004ea:	0f 92 c0             	setb   %al
  1004ed:	0f b6 c0             	movzbl %al,%eax
  1004f0:	29 c2                	sub    %eax,%edx
  1004f2:	89 d0                	mov    %edx,%eax
}
  1004f4:	c9                   	leave  
  1004f5:	c3                   	ret    

00000000001004f6 <strchr>:

char* strchr(const char* s, int c) {
  1004f6:	55                   	push   %rbp
  1004f7:	48 89 e5             	mov    %rsp,%rbp
  1004fa:	48 83 ec 10          	sub    $0x10,%rsp
  1004fe:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100502:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100505:	eb 05                	jmp    10050c <strchr+0x16>
        ++s;
  100507:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  10050c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100510:	0f b6 00             	movzbl (%rax),%eax
  100513:	84 c0                	test   %al,%al
  100515:	74 0e                	je     100525 <strchr+0x2f>
  100517:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10051b:	0f b6 00             	movzbl (%rax),%eax
  10051e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100521:	38 d0                	cmp    %dl,%al
  100523:	75 e2                	jne    100507 <strchr+0x11>
    }
    if (*s == (char) c) {
  100525:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100529:	0f b6 00             	movzbl (%rax),%eax
  10052c:	8b 55 f4             	mov    -0xc(%rbp),%edx
  10052f:	38 d0                	cmp    %dl,%al
  100531:	75 06                	jne    100539 <strchr+0x43>
        return (char*) s;
  100533:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100537:	eb 05                	jmp    10053e <strchr+0x48>
    } else {
        return NULL;
  100539:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  10053e:	c9                   	leave  
  10053f:	c3                   	ret    

0000000000100540 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100540:	55                   	push   %rbp
  100541:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  100544:	8b 05 b6 1a 00 00    	mov    0x1ab6(%rip),%eax        # 102000 <rand_seed_set>
  10054a:	85 c0                	test   %eax,%eax
  10054c:	75 0a                	jne    100558 <rand+0x18>
        srand(819234718U);
  10054e:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100553:	e8 24 00 00 00       	call   10057c <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100558:	8b 05 a6 1a 00 00    	mov    0x1aa6(%rip),%eax        # 102004 <rand_seed>
  10055e:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100564:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100569:	89 05 95 1a 00 00    	mov    %eax,0x1a95(%rip)        # 102004 <rand_seed>
    return rand_seed & RAND_MAX;
  10056f:	8b 05 8f 1a 00 00    	mov    0x1a8f(%rip),%eax        # 102004 <rand_seed>
  100575:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  10057a:	5d                   	pop    %rbp
  10057b:	c3                   	ret    

000000000010057c <srand>:

void srand(unsigned seed) {
  10057c:	55                   	push   %rbp
  10057d:	48 89 e5             	mov    %rsp,%rbp
  100580:	48 83 ec 08          	sub    $0x8,%rsp
  100584:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100587:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10058a:	89 05 74 1a 00 00    	mov    %eax,0x1a74(%rip)        # 102004 <rand_seed>
    rand_seed_set = 1;
  100590:	c7 05 66 1a 00 00 01 	movl   $0x1,0x1a66(%rip)        # 102000 <rand_seed_set>
  100597:	00 00 00 
}
  10059a:	90                   	nop
  10059b:	c9                   	leave  
  10059c:	c3                   	ret    

000000000010059d <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  10059d:	55                   	push   %rbp
  10059e:	48 89 e5             	mov    %rsp,%rbp
  1005a1:	48 83 ec 28          	sub    $0x28,%rsp
  1005a5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1005a9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1005ad:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  1005b0:	48 c7 45 f8 e0 15 10 	movq   $0x1015e0,-0x8(%rbp)
  1005b7:	00 
    if (base < 0) {
  1005b8:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  1005bc:	79 0b                	jns    1005c9 <fill_numbuf+0x2c>
        digits = lower_digits;
  1005be:	48 c7 45 f8 00 16 10 	movq   $0x101600,-0x8(%rbp)
  1005c5:	00 
        base = -base;
  1005c6:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  1005c9:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1005ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1005d2:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  1005d5:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1005d8:	48 63 c8             	movslq %eax,%rcx
  1005db:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1005df:	ba 00 00 00 00       	mov    $0x0,%edx
  1005e4:	48 f7 f1             	div    %rcx
  1005e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005eb:	48 01 d0             	add    %rdx,%rax
  1005ee:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1005f3:	0f b6 10             	movzbl (%rax),%edx
  1005f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1005fa:	88 10                	mov    %dl,(%rax)
        val /= base;
  1005fc:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1005ff:	48 63 f0             	movslq %eax,%rsi
  100602:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100606:	ba 00 00 00 00       	mov    $0x0,%edx
  10060b:	48 f7 f6             	div    %rsi
  10060e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100612:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100617:	75 bc                	jne    1005d5 <fill_numbuf+0x38>
    return numbuf_end;
  100619:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10061d:	c9                   	leave  
  10061e:	c3                   	ret    

000000000010061f <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  10061f:	55                   	push   %rbp
  100620:	48 89 e5             	mov    %rsp,%rbp
  100623:	53                   	push   %rbx
  100624:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  10062b:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100632:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100638:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10063f:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100646:	e9 8a 09 00 00       	jmp    100fd5 <printer_vprintf+0x9b6>
        if (*format != '%') {
  10064b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100652:	0f b6 00             	movzbl (%rax),%eax
  100655:	3c 25                	cmp    $0x25,%al
  100657:	74 31                	je     10068a <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  100659:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100660:	4c 8b 00             	mov    (%rax),%r8
  100663:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10066a:	0f b6 00             	movzbl (%rax),%eax
  10066d:	0f b6 c8             	movzbl %al,%ecx
  100670:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100676:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10067d:	89 ce                	mov    %ecx,%esi
  10067f:	48 89 c7             	mov    %rax,%rdi
  100682:	41 ff d0             	call   *%r8
            continue;
  100685:	e9 43 09 00 00       	jmp    100fcd <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  10068a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100691:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100698:	01 
  100699:	eb 44                	jmp    1006df <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  10069b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006a2:	0f b6 00             	movzbl (%rax),%eax
  1006a5:	0f be c0             	movsbl %al,%eax
  1006a8:	89 c6                	mov    %eax,%esi
  1006aa:	bf 00 14 10 00       	mov    $0x101400,%edi
  1006af:	e8 42 fe ff ff       	call   1004f6 <strchr>
  1006b4:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  1006b8:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  1006bd:	74 30                	je     1006ef <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  1006bf:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  1006c3:	48 2d 00 14 10 00    	sub    $0x101400,%rax
  1006c9:	ba 01 00 00 00       	mov    $0x1,%edx
  1006ce:	89 c1                	mov    %eax,%ecx
  1006d0:	d3 e2                	shl    %cl,%edx
  1006d2:	89 d0                	mov    %edx,%eax
  1006d4:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  1006d7:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1006de:	01 
  1006df:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006e6:	0f b6 00             	movzbl (%rax),%eax
  1006e9:	84 c0                	test   %al,%al
  1006eb:	75 ae                	jne    10069b <printer_vprintf+0x7c>
  1006ed:	eb 01                	jmp    1006f0 <printer_vprintf+0xd1>
            } else {
                break;
  1006ef:	90                   	nop
            }
        }

        // process width
        int width = -1;
  1006f0:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  1006f7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006fe:	0f b6 00             	movzbl (%rax),%eax
  100701:	3c 30                	cmp    $0x30,%al
  100703:	7e 67                	jle    10076c <printer_vprintf+0x14d>
  100705:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10070c:	0f b6 00             	movzbl (%rax),%eax
  10070f:	3c 39                	cmp    $0x39,%al
  100711:	7f 59                	jg     10076c <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100713:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  10071a:	eb 2e                	jmp    10074a <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  10071c:	8b 55 e8             	mov    -0x18(%rbp),%edx
  10071f:	89 d0                	mov    %edx,%eax
  100721:	c1 e0 02             	shl    $0x2,%eax
  100724:	01 d0                	add    %edx,%eax
  100726:	01 c0                	add    %eax,%eax
  100728:	89 c1                	mov    %eax,%ecx
  10072a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100731:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100735:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10073c:	0f b6 00             	movzbl (%rax),%eax
  10073f:	0f be c0             	movsbl %al,%eax
  100742:	01 c8                	add    %ecx,%eax
  100744:	83 e8 30             	sub    $0x30,%eax
  100747:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10074a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100751:	0f b6 00             	movzbl (%rax),%eax
  100754:	3c 2f                	cmp    $0x2f,%al
  100756:	0f 8e 85 00 00 00    	jle    1007e1 <printer_vprintf+0x1c2>
  10075c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100763:	0f b6 00             	movzbl (%rax),%eax
  100766:	3c 39                	cmp    $0x39,%al
  100768:	7e b2                	jle    10071c <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  10076a:	eb 75                	jmp    1007e1 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  10076c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100773:	0f b6 00             	movzbl (%rax),%eax
  100776:	3c 2a                	cmp    $0x2a,%al
  100778:	75 68                	jne    1007e2 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  10077a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100781:	8b 00                	mov    (%rax),%eax
  100783:	83 f8 2f             	cmp    $0x2f,%eax
  100786:	77 30                	ja     1007b8 <printer_vprintf+0x199>
  100788:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10078f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100793:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10079a:	8b 00                	mov    (%rax),%eax
  10079c:	89 c0                	mov    %eax,%eax
  10079e:	48 01 d0             	add    %rdx,%rax
  1007a1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007a8:	8b 12                	mov    (%rdx),%edx
  1007aa:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1007ad:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007b4:	89 0a                	mov    %ecx,(%rdx)
  1007b6:	eb 1a                	jmp    1007d2 <printer_vprintf+0x1b3>
  1007b8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007bf:	48 8b 40 08          	mov    0x8(%rax),%rax
  1007c3:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1007c7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007ce:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1007d2:	8b 00                	mov    (%rax),%eax
  1007d4:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  1007d7:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1007de:	01 
  1007df:	eb 01                	jmp    1007e2 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  1007e1:	90                   	nop
        }

        // process precision
        int precision = -1;
  1007e2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  1007e9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007f0:	0f b6 00             	movzbl (%rax),%eax
  1007f3:	3c 2e                	cmp    $0x2e,%al
  1007f5:	0f 85 00 01 00 00    	jne    1008fb <printer_vprintf+0x2dc>
            ++format;
  1007fb:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100802:	01 
            if (*format >= '0' && *format <= '9') {
  100803:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10080a:	0f b6 00             	movzbl (%rax),%eax
  10080d:	3c 2f                	cmp    $0x2f,%al
  10080f:	7e 67                	jle    100878 <printer_vprintf+0x259>
  100811:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100818:	0f b6 00             	movzbl (%rax),%eax
  10081b:	3c 39                	cmp    $0x39,%al
  10081d:	7f 59                	jg     100878 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10081f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100826:	eb 2e                	jmp    100856 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100828:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  10082b:	89 d0                	mov    %edx,%eax
  10082d:	c1 e0 02             	shl    $0x2,%eax
  100830:	01 d0                	add    %edx,%eax
  100832:	01 c0                	add    %eax,%eax
  100834:	89 c1                	mov    %eax,%ecx
  100836:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10083d:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100841:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100848:	0f b6 00             	movzbl (%rax),%eax
  10084b:	0f be c0             	movsbl %al,%eax
  10084e:	01 c8                	add    %ecx,%eax
  100850:	83 e8 30             	sub    $0x30,%eax
  100853:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100856:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10085d:	0f b6 00             	movzbl (%rax),%eax
  100860:	3c 2f                	cmp    $0x2f,%al
  100862:	0f 8e 85 00 00 00    	jle    1008ed <printer_vprintf+0x2ce>
  100868:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10086f:	0f b6 00             	movzbl (%rax),%eax
  100872:	3c 39                	cmp    $0x39,%al
  100874:	7e b2                	jle    100828 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100876:	eb 75                	jmp    1008ed <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100878:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10087f:	0f b6 00             	movzbl (%rax),%eax
  100882:	3c 2a                	cmp    $0x2a,%al
  100884:	75 68                	jne    1008ee <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100886:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10088d:	8b 00                	mov    (%rax),%eax
  10088f:	83 f8 2f             	cmp    $0x2f,%eax
  100892:	77 30                	ja     1008c4 <printer_vprintf+0x2a5>
  100894:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10089b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10089f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008a6:	8b 00                	mov    (%rax),%eax
  1008a8:	89 c0                	mov    %eax,%eax
  1008aa:	48 01 d0             	add    %rdx,%rax
  1008ad:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008b4:	8b 12                	mov    (%rdx),%edx
  1008b6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1008b9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008c0:	89 0a                	mov    %ecx,(%rdx)
  1008c2:	eb 1a                	jmp    1008de <printer_vprintf+0x2bf>
  1008c4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008cb:	48 8b 40 08          	mov    0x8(%rax),%rax
  1008cf:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1008d3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008da:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1008de:	8b 00                	mov    (%rax),%eax
  1008e0:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  1008e3:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1008ea:	01 
  1008eb:	eb 01                	jmp    1008ee <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  1008ed:	90                   	nop
            }
            if (precision < 0) {
  1008ee:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1008f2:	79 07                	jns    1008fb <printer_vprintf+0x2dc>
                precision = 0;
  1008f4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  1008fb:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100902:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100909:	00 
        int length = 0;
  10090a:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100911:	48 c7 45 c8 06 14 10 	movq   $0x101406,-0x38(%rbp)
  100918:	00 
    again:
        switch (*format) {
  100919:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100920:	0f b6 00             	movzbl (%rax),%eax
  100923:	0f be c0             	movsbl %al,%eax
  100926:	83 e8 43             	sub    $0x43,%eax
  100929:	83 f8 37             	cmp    $0x37,%eax
  10092c:	0f 87 9f 03 00 00    	ja     100cd1 <printer_vprintf+0x6b2>
  100932:	89 c0                	mov    %eax,%eax
  100934:	48 8b 04 c5 18 14 10 	mov    0x101418(,%rax,8),%rax
  10093b:	00 
  10093c:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  10093e:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100945:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10094c:	01 
            goto again;
  10094d:	eb ca                	jmp    100919 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  10094f:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100953:	74 5d                	je     1009b2 <printer_vprintf+0x393>
  100955:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10095c:	8b 00                	mov    (%rax),%eax
  10095e:	83 f8 2f             	cmp    $0x2f,%eax
  100961:	77 30                	ja     100993 <printer_vprintf+0x374>
  100963:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10096a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10096e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100975:	8b 00                	mov    (%rax),%eax
  100977:	89 c0                	mov    %eax,%eax
  100979:	48 01 d0             	add    %rdx,%rax
  10097c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100983:	8b 12                	mov    (%rdx),%edx
  100985:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100988:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10098f:	89 0a                	mov    %ecx,(%rdx)
  100991:	eb 1a                	jmp    1009ad <printer_vprintf+0x38e>
  100993:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10099a:	48 8b 40 08          	mov    0x8(%rax),%rax
  10099e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1009a2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009a9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1009ad:	48 8b 00             	mov    (%rax),%rax
  1009b0:	eb 5c                	jmp    100a0e <printer_vprintf+0x3ef>
  1009b2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009b9:	8b 00                	mov    (%rax),%eax
  1009bb:	83 f8 2f             	cmp    $0x2f,%eax
  1009be:	77 30                	ja     1009f0 <printer_vprintf+0x3d1>
  1009c0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009c7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1009cb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009d2:	8b 00                	mov    (%rax),%eax
  1009d4:	89 c0                	mov    %eax,%eax
  1009d6:	48 01 d0             	add    %rdx,%rax
  1009d9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009e0:	8b 12                	mov    (%rdx),%edx
  1009e2:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1009e5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009ec:	89 0a                	mov    %ecx,(%rdx)
  1009ee:	eb 1a                	jmp    100a0a <printer_vprintf+0x3eb>
  1009f0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009f7:	48 8b 40 08          	mov    0x8(%rax),%rax
  1009fb:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1009ff:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a06:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a0a:	8b 00                	mov    (%rax),%eax
  100a0c:	48 98                	cltq   
  100a0e:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100a12:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a16:	48 c1 f8 38          	sar    $0x38,%rax
  100a1a:	25 80 00 00 00       	and    $0x80,%eax
  100a1f:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100a22:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100a26:	74 09                	je     100a31 <printer_vprintf+0x412>
  100a28:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a2c:	48 f7 d8             	neg    %rax
  100a2f:	eb 04                	jmp    100a35 <printer_vprintf+0x416>
  100a31:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a35:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100a39:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100a3c:	83 c8 60             	or     $0x60,%eax
  100a3f:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100a42:	e9 cf 02 00 00       	jmp    100d16 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100a47:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100a4b:	74 5d                	je     100aaa <printer_vprintf+0x48b>
  100a4d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a54:	8b 00                	mov    (%rax),%eax
  100a56:	83 f8 2f             	cmp    $0x2f,%eax
  100a59:	77 30                	ja     100a8b <printer_vprintf+0x46c>
  100a5b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a62:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a66:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a6d:	8b 00                	mov    (%rax),%eax
  100a6f:	89 c0                	mov    %eax,%eax
  100a71:	48 01 d0             	add    %rdx,%rax
  100a74:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a7b:	8b 12                	mov    (%rdx),%edx
  100a7d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a80:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a87:	89 0a                	mov    %ecx,(%rdx)
  100a89:	eb 1a                	jmp    100aa5 <printer_vprintf+0x486>
  100a8b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a92:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a96:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a9a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aa1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100aa5:	48 8b 00             	mov    (%rax),%rax
  100aa8:	eb 5c                	jmp    100b06 <printer_vprintf+0x4e7>
  100aaa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ab1:	8b 00                	mov    (%rax),%eax
  100ab3:	83 f8 2f             	cmp    $0x2f,%eax
  100ab6:	77 30                	ja     100ae8 <printer_vprintf+0x4c9>
  100ab8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100abf:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ac3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100aca:	8b 00                	mov    (%rax),%eax
  100acc:	89 c0                	mov    %eax,%eax
  100ace:	48 01 d0             	add    %rdx,%rax
  100ad1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ad8:	8b 12                	mov    (%rdx),%edx
  100ada:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100add:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ae4:	89 0a                	mov    %ecx,(%rdx)
  100ae6:	eb 1a                	jmp    100b02 <printer_vprintf+0x4e3>
  100ae8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100aef:	48 8b 40 08          	mov    0x8(%rax),%rax
  100af3:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100af7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100afe:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b02:	8b 00                	mov    (%rax),%eax
  100b04:	89 c0                	mov    %eax,%eax
  100b06:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100b0a:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100b0e:	e9 03 02 00 00       	jmp    100d16 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100b13:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100b1a:	e9 28 ff ff ff       	jmp    100a47 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100b1f:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100b26:	e9 1c ff ff ff       	jmp    100a47 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100b2b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b32:	8b 00                	mov    (%rax),%eax
  100b34:	83 f8 2f             	cmp    $0x2f,%eax
  100b37:	77 30                	ja     100b69 <printer_vprintf+0x54a>
  100b39:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b40:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b44:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b4b:	8b 00                	mov    (%rax),%eax
  100b4d:	89 c0                	mov    %eax,%eax
  100b4f:	48 01 d0             	add    %rdx,%rax
  100b52:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b59:	8b 12                	mov    (%rdx),%edx
  100b5b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b5e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b65:	89 0a                	mov    %ecx,(%rdx)
  100b67:	eb 1a                	jmp    100b83 <printer_vprintf+0x564>
  100b69:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b70:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b74:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b78:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b7f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b83:	48 8b 00             	mov    (%rax),%rax
  100b86:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100b8a:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100b91:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100b98:	e9 79 01 00 00       	jmp    100d16 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100b9d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ba4:	8b 00                	mov    (%rax),%eax
  100ba6:	83 f8 2f             	cmp    $0x2f,%eax
  100ba9:	77 30                	ja     100bdb <printer_vprintf+0x5bc>
  100bab:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bb2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100bb6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bbd:	8b 00                	mov    (%rax),%eax
  100bbf:	89 c0                	mov    %eax,%eax
  100bc1:	48 01 d0             	add    %rdx,%rax
  100bc4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bcb:	8b 12                	mov    (%rdx),%edx
  100bcd:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bd0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bd7:	89 0a                	mov    %ecx,(%rdx)
  100bd9:	eb 1a                	jmp    100bf5 <printer_vprintf+0x5d6>
  100bdb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100be2:	48 8b 40 08          	mov    0x8(%rax),%rax
  100be6:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100bea:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bf1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100bf5:	48 8b 00             	mov    (%rax),%rax
  100bf8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100bfc:	e9 15 01 00 00       	jmp    100d16 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100c01:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c08:	8b 00                	mov    (%rax),%eax
  100c0a:	83 f8 2f             	cmp    $0x2f,%eax
  100c0d:	77 30                	ja     100c3f <printer_vprintf+0x620>
  100c0f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c16:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c1a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c21:	8b 00                	mov    (%rax),%eax
  100c23:	89 c0                	mov    %eax,%eax
  100c25:	48 01 d0             	add    %rdx,%rax
  100c28:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c2f:	8b 12                	mov    (%rdx),%edx
  100c31:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c34:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c3b:	89 0a                	mov    %ecx,(%rdx)
  100c3d:	eb 1a                	jmp    100c59 <printer_vprintf+0x63a>
  100c3f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c46:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c4a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c4e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c55:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c59:	8b 00                	mov    (%rax),%eax
  100c5b:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100c61:	e9 67 03 00 00       	jmp    100fcd <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  100c66:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100c6a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100c6e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c75:	8b 00                	mov    (%rax),%eax
  100c77:	83 f8 2f             	cmp    $0x2f,%eax
  100c7a:	77 30                	ja     100cac <printer_vprintf+0x68d>
  100c7c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c83:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c87:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c8e:	8b 00                	mov    (%rax),%eax
  100c90:	89 c0                	mov    %eax,%eax
  100c92:	48 01 d0             	add    %rdx,%rax
  100c95:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c9c:	8b 12                	mov    (%rdx),%edx
  100c9e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ca1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ca8:	89 0a                	mov    %ecx,(%rdx)
  100caa:	eb 1a                	jmp    100cc6 <printer_vprintf+0x6a7>
  100cac:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cb3:	48 8b 40 08          	mov    0x8(%rax),%rax
  100cb7:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100cbb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cc2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100cc6:	8b 00                	mov    (%rax),%eax
  100cc8:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100ccb:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100ccf:	eb 45                	jmp    100d16 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  100cd1:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100cd5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100cd9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ce0:	0f b6 00             	movzbl (%rax),%eax
  100ce3:	84 c0                	test   %al,%al
  100ce5:	74 0c                	je     100cf3 <printer_vprintf+0x6d4>
  100ce7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100cee:	0f b6 00             	movzbl (%rax),%eax
  100cf1:	eb 05                	jmp    100cf8 <printer_vprintf+0x6d9>
  100cf3:	b8 25 00 00 00       	mov    $0x25,%eax
  100cf8:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100cfb:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100cff:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d06:	0f b6 00             	movzbl (%rax),%eax
  100d09:	84 c0                	test   %al,%al
  100d0b:	75 08                	jne    100d15 <printer_vprintf+0x6f6>
                format--;
  100d0d:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100d14:	01 
            }
            break;
  100d15:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100d16:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d19:	83 e0 20             	and    $0x20,%eax
  100d1c:	85 c0                	test   %eax,%eax
  100d1e:	74 1e                	je     100d3e <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100d20:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d24:	48 83 c0 18          	add    $0x18,%rax
  100d28:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100d2b:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100d2f:	48 89 ce             	mov    %rcx,%rsi
  100d32:	48 89 c7             	mov    %rax,%rdi
  100d35:	e8 63 f8 ff ff       	call   10059d <fill_numbuf>
  100d3a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100d3e:	48 c7 45 c0 06 14 10 	movq   $0x101406,-0x40(%rbp)
  100d45:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100d46:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d49:	83 e0 20             	and    $0x20,%eax
  100d4c:	85 c0                	test   %eax,%eax
  100d4e:	74 48                	je     100d98 <printer_vprintf+0x779>
  100d50:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d53:	83 e0 40             	and    $0x40,%eax
  100d56:	85 c0                	test   %eax,%eax
  100d58:	74 3e                	je     100d98 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  100d5a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d5d:	25 80 00 00 00       	and    $0x80,%eax
  100d62:	85 c0                	test   %eax,%eax
  100d64:	74 0a                	je     100d70 <printer_vprintf+0x751>
                prefix = "-";
  100d66:	48 c7 45 c0 07 14 10 	movq   $0x101407,-0x40(%rbp)
  100d6d:	00 
            if (flags & FLAG_NEGATIVE) {
  100d6e:	eb 73                	jmp    100de3 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100d70:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d73:	83 e0 10             	and    $0x10,%eax
  100d76:	85 c0                	test   %eax,%eax
  100d78:	74 0a                	je     100d84 <printer_vprintf+0x765>
                prefix = "+";
  100d7a:	48 c7 45 c0 09 14 10 	movq   $0x101409,-0x40(%rbp)
  100d81:	00 
            if (flags & FLAG_NEGATIVE) {
  100d82:	eb 5f                	jmp    100de3 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100d84:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d87:	83 e0 08             	and    $0x8,%eax
  100d8a:	85 c0                	test   %eax,%eax
  100d8c:	74 55                	je     100de3 <printer_vprintf+0x7c4>
                prefix = " ";
  100d8e:	48 c7 45 c0 0b 14 10 	movq   $0x10140b,-0x40(%rbp)
  100d95:	00 
            if (flags & FLAG_NEGATIVE) {
  100d96:	eb 4b                	jmp    100de3 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100d98:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d9b:	83 e0 20             	and    $0x20,%eax
  100d9e:	85 c0                	test   %eax,%eax
  100da0:	74 42                	je     100de4 <printer_vprintf+0x7c5>
  100da2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100da5:	83 e0 01             	and    $0x1,%eax
  100da8:	85 c0                	test   %eax,%eax
  100daa:	74 38                	je     100de4 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  100dac:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100db0:	74 06                	je     100db8 <printer_vprintf+0x799>
  100db2:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100db6:	75 2c                	jne    100de4 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  100db8:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100dbd:	75 0c                	jne    100dcb <printer_vprintf+0x7ac>
  100dbf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dc2:	25 00 01 00 00       	and    $0x100,%eax
  100dc7:	85 c0                	test   %eax,%eax
  100dc9:	74 19                	je     100de4 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  100dcb:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100dcf:	75 07                	jne    100dd8 <printer_vprintf+0x7b9>
  100dd1:	b8 0d 14 10 00       	mov    $0x10140d,%eax
  100dd6:	eb 05                	jmp    100ddd <printer_vprintf+0x7be>
  100dd8:	b8 10 14 10 00       	mov    $0x101410,%eax
  100ddd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100de1:	eb 01                	jmp    100de4 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  100de3:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100de4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100de8:	78 24                	js     100e0e <printer_vprintf+0x7ef>
  100dea:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ded:	83 e0 20             	and    $0x20,%eax
  100df0:	85 c0                	test   %eax,%eax
  100df2:	75 1a                	jne    100e0e <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  100df4:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100df7:	48 63 d0             	movslq %eax,%rdx
  100dfa:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100dfe:	48 89 d6             	mov    %rdx,%rsi
  100e01:	48 89 c7             	mov    %rax,%rdi
  100e04:	e8 ea f5 ff ff       	call   1003f3 <strnlen>
  100e09:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100e0c:	eb 0f                	jmp    100e1d <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  100e0e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100e12:	48 89 c7             	mov    %rax,%rdi
  100e15:	e8 a8 f5 ff ff       	call   1003c2 <strlen>
  100e1a:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100e1d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e20:	83 e0 20             	and    $0x20,%eax
  100e23:	85 c0                	test   %eax,%eax
  100e25:	74 20                	je     100e47 <printer_vprintf+0x828>
  100e27:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100e2b:	78 1a                	js     100e47 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  100e2d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100e30:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100e33:	7e 08                	jle    100e3d <printer_vprintf+0x81e>
  100e35:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100e38:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100e3b:	eb 05                	jmp    100e42 <printer_vprintf+0x823>
  100e3d:	b8 00 00 00 00       	mov    $0x0,%eax
  100e42:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100e45:	eb 5c                	jmp    100ea3 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100e47:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e4a:	83 e0 20             	and    $0x20,%eax
  100e4d:	85 c0                	test   %eax,%eax
  100e4f:	74 4b                	je     100e9c <printer_vprintf+0x87d>
  100e51:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e54:	83 e0 02             	and    $0x2,%eax
  100e57:	85 c0                	test   %eax,%eax
  100e59:	74 41                	je     100e9c <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100e5b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e5e:	83 e0 04             	and    $0x4,%eax
  100e61:	85 c0                	test   %eax,%eax
  100e63:	75 37                	jne    100e9c <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  100e65:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e69:	48 89 c7             	mov    %rax,%rdi
  100e6c:	e8 51 f5 ff ff       	call   1003c2 <strlen>
  100e71:	89 c2                	mov    %eax,%edx
  100e73:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100e76:	01 d0                	add    %edx,%eax
  100e78:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100e7b:	7e 1f                	jle    100e9c <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  100e7d:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100e80:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100e83:	89 c3                	mov    %eax,%ebx
  100e85:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e89:	48 89 c7             	mov    %rax,%rdi
  100e8c:	e8 31 f5 ff ff       	call   1003c2 <strlen>
  100e91:	89 c2                	mov    %eax,%edx
  100e93:	89 d8                	mov    %ebx,%eax
  100e95:	29 d0                	sub    %edx,%eax
  100e97:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100e9a:	eb 07                	jmp    100ea3 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  100e9c:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100ea3:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100ea6:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100ea9:	01 d0                	add    %edx,%eax
  100eab:	48 63 d8             	movslq %eax,%rbx
  100eae:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100eb2:	48 89 c7             	mov    %rax,%rdi
  100eb5:	e8 08 f5 ff ff       	call   1003c2 <strlen>
  100eba:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100ebe:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100ec1:	29 d0                	sub    %edx,%eax
  100ec3:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100ec6:	eb 25                	jmp    100eed <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  100ec8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ecf:	48 8b 08             	mov    (%rax),%rcx
  100ed2:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100ed8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100edf:	be 20 00 00 00       	mov    $0x20,%esi
  100ee4:	48 89 c7             	mov    %rax,%rdi
  100ee7:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100ee9:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100eed:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ef0:	83 e0 04             	and    $0x4,%eax
  100ef3:	85 c0                	test   %eax,%eax
  100ef5:	75 36                	jne    100f2d <printer_vprintf+0x90e>
  100ef7:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100efb:	7f cb                	jg     100ec8 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  100efd:	eb 2e                	jmp    100f2d <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  100eff:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f06:	4c 8b 00             	mov    (%rax),%r8
  100f09:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f0d:	0f b6 00             	movzbl (%rax),%eax
  100f10:	0f b6 c8             	movzbl %al,%ecx
  100f13:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f19:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f20:	89 ce                	mov    %ecx,%esi
  100f22:	48 89 c7             	mov    %rax,%rdi
  100f25:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  100f28:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  100f2d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f31:	0f b6 00             	movzbl (%rax),%eax
  100f34:	84 c0                	test   %al,%al
  100f36:	75 c7                	jne    100eff <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  100f38:	eb 25                	jmp    100f5f <printer_vprintf+0x940>
            p->putc(p, '0', color);
  100f3a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f41:	48 8b 08             	mov    (%rax),%rcx
  100f44:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f4a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f51:	be 30 00 00 00       	mov    $0x30,%esi
  100f56:	48 89 c7             	mov    %rax,%rdi
  100f59:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  100f5b:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  100f5f:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  100f63:	7f d5                	jg     100f3a <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  100f65:	eb 32                	jmp    100f99 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  100f67:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f6e:	4c 8b 00             	mov    (%rax),%r8
  100f71:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100f75:	0f b6 00             	movzbl (%rax),%eax
  100f78:	0f b6 c8             	movzbl %al,%ecx
  100f7b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f81:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f88:	89 ce                	mov    %ecx,%esi
  100f8a:	48 89 c7             	mov    %rax,%rdi
  100f8d:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  100f90:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  100f95:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  100f99:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  100f9d:	7f c8                	jg     100f67 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  100f9f:	eb 25                	jmp    100fc6 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  100fa1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fa8:	48 8b 08             	mov    (%rax),%rcx
  100fab:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100fb1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fb8:	be 20 00 00 00       	mov    $0x20,%esi
  100fbd:	48 89 c7             	mov    %rax,%rdi
  100fc0:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  100fc2:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100fc6:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100fca:	7f d5                	jg     100fa1 <printer_vprintf+0x982>
        }
    done: ;
  100fcc:	90                   	nop
    for (; *format; ++format) {
  100fcd:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100fd4:	01 
  100fd5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100fdc:	0f b6 00             	movzbl (%rax),%eax
  100fdf:	84 c0                	test   %al,%al
  100fe1:	0f 85 64 f6 ff ff    	jne    10064b <printer_vprintf+0x2c>
    }
}
  100fe7:	90                   	nop
  100fe8:	90                   	nop
  100fe9:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100fed:	c9                   	leave  
  100fee:	c3                   	ret    

0000000000100fef <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100fef:	55                   	push   %rbp
  100ff0:	48 89 e5             	mov    %rsp,%rbp
  100ff3:	48 83 ec 20          	sub    $0x20,%rsp
  100ff7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100ffb:	89 f0                	mov    %esi,%eax
  100ffd:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101000:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  101003:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101007:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10100b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10100f:	48 8b 40 08          	mov    0x8(%rax),%rax
  101013:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  101018:	48 39 d0             	cmp    %rdx,%rax
  10101b:	72 0c                	jb     101029 <console_putc+0x3a>
        cp->cursor = console;
  10101d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101021:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  101028:	00 
    }
    if (c == '\n') {
  101029:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  10102d:	75 78                	jne    1010a7 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  10102f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101033:	48 8b 40 08          	mov    0x8(%rax),%rax
  101037:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  10103d:	48 d1 f8             	sar    %rax
  101040:	48 89 c1             	mov    %rax,%rcx
  101043:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  10104a:	66 66 66 
  10104d:	48 89 c8             	mov    %rcx,%rax
  101050:	48 f7 ea             	imul   %rdx
  101053:	48 c1 fa 05          	sar    $0x5,%rdx
  101057:	48 89 c8             	mov    %rcx,%rax
  10105a:	48 c1 f8 3f          	sar    $0x3f,%rax
  10105e:	48 29 c2             	sub    %rax,%rdx
  101061:	48 89 d0             	mov    %rdx,%rax
  101064:	48 c1 e0 02          	shl    $0x2,%rax
  101068:	48 01 d0             	add    %rdx,%rax
  10106b:	48 c1 e0 04          	shl    $0x4,%rax
  10106f:	48 29 c1             	sub    %rax,%rcx
  101072:	48 89 ca             	mov    %rcx,%rdx
  101075:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101078:	eb 25                	jmp    10109f <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  10107a:	8b 45 e0             	mov    -0x20(%rbp),%eax
  10107d:	83 c8 20             	or     $0x20,%eax
  101080:	89 c6                	mov    %eax,%esi
  101082:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101086:	48 8b 40 08          	mov    0x8(%rax),%rax
  10108a:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10108e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101092:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101096:	89 f2                	mov    %esi,%edx
  101098:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  10109b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10109f:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  1010a3:	75 d5                	jne    10107a <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  1010a5:	eb 24                	jmp    1010cb <console_putc+0xdc>
        *cp->cursor++ = c | color;
  1010a7:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  1010ab:	8b 55 e0             	mov    -0x20(%rbp),%edx
  1010ae:	09 d0                	or     %edx,%eax
  1010b0:	89 c6                	mov    %eax,%esi
  1010b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010b6:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010ba:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1010be:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1010c2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1010c6:	89 f2                	mov    %esi,%edx
  1010c8:	66 89 10             	mov    %dx,(%rax)
}
  1010cb:	90                   	nop
  1010cc:	c9                   	leave  
  1010cd:	c3                   	ret    

00000000001010ce <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1010ce:	55                   	push   %rbp
  1010cf:	48 89 e5             	mov    %rsp,%rbp
  1010d2:	48 83 ec 30          	sub    $0x30,%rsp
  1010d6:	89 7d ec             	mov    %edi,-0x14(%rbp)
  1010d9:	89 75 e8             	mov    %esi,-0x18(%rbp)
  1010dc:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1010e0:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  1010e4:	48 c7 45 f0 ef 0f 10 	movq   $0x100fef,-0x10(%rbp)
  1010eb:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1010ec:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  1010f0:	78 09                	js     1010fb <console_vprintf+0x2d>
  1010f2:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  1010f9:	7e 07                	jle    101102 <console_vprintf+0x34>
        cpos = 0;
  1010fb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  101102:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101105:	48 98                	cltq   
  101107:	48 01 c0             	add    %rax,%rax
  10110a:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  101110:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101114:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101118:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  10111c:	8b 75 e8             	mov    -0x18(%rbp),%esi
  10111f:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101123:	48 89 c7             	mov    %rax,%rdi
  101126:	e8 f4 f4 ff ff       	call   10061f <printer_vprintf>
    return cp.cursor - console;
  10112b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10112f:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  101135:	48 d1 f8             	sar    %rax
}
  101138:	c9                   	leave  
  101139:	c3                   	ret    

000000000010113a <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  10113a:	55                   	push   %rbp
  10113b:	48 89 e5             	mov    %rsp,%rbp
  10113e:	48 83 ec 60          	sub    $0x60,%rsp
  101142:	89 7d ac             	mov    %edi,-0x54(%rbp)
  101145:	89 75 a8             	mov    %esi,-0x58(%rbp)
  101148:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  10114c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101150:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101154:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101158:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  10115f:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101163:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101167:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10116b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  10116f:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101173:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101177:	8b 75 a8             	mov    -0x58(%rbp),%esi
  10117a:	8b 45 ac             	mov    -0x54(%rbp),%eax
  10117d:	89 c7                	mov    %eax,%edi
  10117f:	e8 4a ff ff ff       	call   1010ce <console_vprintf>
  101184:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101187:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  10118a:	c9                   	leave  
  10118b:	c3                   	ret    

000000000010118c <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  10118c:	55                   	push   %rbp
  10118d:	48 89 e5             	mov    %rsp,%rbp
  101190:	48 83 ec 20          	sub    $0x20,%rsp
  101194:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101198:	89 f0                	mov    %esi,%eax
  10119a:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10119d:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  1011a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1011a4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  1011a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1011ac:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1011b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1011b4:	48 8b 40 10          	mov    0x10(%rax),%rax
  1011b8:	48 39 c2             	cmp    %rax,%rdx
  1011bb:	73 1a                	jae    1011d7 <string_putc+0x4b>
        *sp->s++ = c;
  1011bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1011c1:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011c5:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1011c9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1011cd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1011d1:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1011d5:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1011d7:	90                   	nop
  1011d8:	c9                   	leave  
  1011d9:	c3                   	ret    

00000000001011da <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1011da:	55                   	push   %rbp
  1011db:	48 89 e5             	mov    %rsp,%rbp
  1011de:	48 83 ec 40          	sub    $0x40,%rsp
  1011e2:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  1011e6:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  1011ea:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  1011ee:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1011f2:	48 c7 45 e8 8c 11 10 	movq   $0x10118c,-0x18(%rbp)
  1011f9:	00 
    sp.s = s;
  1011fa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1011fe:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  101202:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  101207:	74 33                	je     10123c <vsnprintf+0x62>
        sp.end = s + size - 1;
  101209:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  10120d:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101211:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101215:	48 01 d0             	add    %rdx,%rax
  101218:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  10121c:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101220:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101224:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101228:	be 00 00 00 00       	mov    $0x0,%esi
  10122d:	48 89 c7             	mov    %rax,%rdi
  101230:	e8 ea f3 ff ff       	call   10061f <printer_vprintf>
        *sp.s = 0;
  101235:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101239:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  10123c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101240:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  101244:	c9                   	leave  
  101245:	c3                   	ret    

0000000000101246 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  101246:	55                   	push   %rbp
  101247:	48 89 e5             	mov    %rsp,%rbp
  10124a:	48 83 ec 70          	sub    $0x70,%rsp
  10124e:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101252:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  101256:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  10125a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10125e:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101262:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101266:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  10126d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101271:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101275:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101279:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  10127d:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101281:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101285:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101289:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10128d:	48 89 c7             	mov    %rax,%rdi
  101290:	e8 45 ff ff ff       	call   1011da <vsnprintf>
  101295:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101298:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  10129b:	c9                   	leave  
  10129c:	c3                   	ret    

000000000010129d <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  10129d:	55                   	push   %rbp
  10129e:	48 89 e5             	mov    %rsp,%rbp
  1012a1:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1012a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  1012ac:	eb 13                	jmp    1012c1 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  1012ae:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1012b1:	48 98                	cltq   
  1012b3:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  1012ba:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1012bd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1012c1:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1012c8:	7e e4                	jle    1012ae <console_clear+0x11>
    }
    cursorpos = 0;
  1012ca:	c7 05 28 7d fb ff 00 	movl   $0x0,-0x482d8(%rip)        # b8ffc <cursorpos>
  1012d1:	00 00 00 
}
  1012d4:	90                   	nop
  1012d5:	c9                   	leave  
  1012d6:	c3                   	ret    
