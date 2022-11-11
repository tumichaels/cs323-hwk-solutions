
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
extern uint8_t end[];

// program that checks if pages on the heap are allocated without one-to-one
// va->pa mapping

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	53                   	push   %rbx
  100005:	48 83 ec 28          	sub    $0x28,%rsp

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
  10000f:	e8 08 05 00 00       	call   10051c <srand>

    vamapping pmap;
    uint8_t * heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100014:	ba 07 30 10 00       	mov    $0x103007,%edx
  100019:	48 81 e2 00 f0 ff ff 	and    $0xfffffffffffff000,%rdx
  100020:	48 89 d6             	mov    %rdx,%rsi

    // test N times
    for(int i = 0 ; i < N ; i++){
  100023:	48 81 c2 00 e0 01 00 	add    $0x1e000,%rdx
// looks up the virtual memory mapping for addr for the current process 
// and stores it inside map. [map, sizeof(vampping)) address should be 
// allocated, writable addresses to the process, otherwise syscall will 
// not write anything to the variable
static inline void sys_mapping(uintptr_t addr, void * map){
    asm volatile ("int %0" : /* no result */
  10002a:	48 8d 4d d8          	lea    -0x28(%rbp),%rcx
    asm volatile ("int %1"		// generates a "INT_SYS_PAGE_ALLOC" type interrupt 
  10002e:	48 89 f7             	mov    %rsi,%rdi
  100031:	cd 33                	int    $0x33
        int x = sys_page_alloc(heap_top);
        if(x != 0)
  100033:	85 c0                	test   %eax,%eax
  100035:	75 30                	jne    100067 <process_main+0x67>
            panic("Error, sys_page_alloc failed!");
        // lets make sure we write to the page and are able to read from it
        *heap_top = p;
  100037:	88 1e                	mov    %bl,(%rsi)
        assert(*heap_top == p);
  100039:	81 fb ff 00 00 00    	cmp    $0xff,%ebx
  10003f:	77 35                	ja     100076 <process_main+0x76>
    asm volatile ("int %0" : /* no result */
  100041:	48 89 cf             	mov    %rcx,%rdi
  100044:	cd 36                	int    $0x36
        sys_mapping((uintptr_t)heap_top, &pmap);

        if(pmap.pa == (uintptr_t)heap_top)
  100046:	48 39 75 e0          	cmp    %rsi,-0x20(%rbp)
  10004a:	74 3e                	je     10008a <process_main+0x8a>
            panic("Error, sys page alloc not virtualized!");

        heap_top += PAGESIZE;
  10004c:	48 81 c6 00 10 00 00 	add    $0x1000,%rsi
    for(int i = 0 ; i < N ; i++){
  100053:	48 39 f2             	cmp    %rsi,%rdx
  100056:	75 d6                	jne    10002e <process_main+0x2e>
    }

    TEST_PASS();
  100058:	bf bd 12 10 00       	mov    $0x1012bd,%edi
  10005d:	b8 00 00 00 00       	mov    $0x0,%eax
  100062:	e8 c2 00 00 00       	call   100129 <panic>
            panic("Error, sys_page_alloc failed!");
  100067:	bf 80 12 10 00       	mov    $0x101280,%edi
  10006c:	b8 00 00 00 00       	mov    $0x0,%eax
  100071:	e8 b3 00 00 00       	call   100129 <panic>
        assert(*heap_top == p);
  100076:	ba 9e 12 10 00       	mov    $0x10129e,%edx
  10007b:	be 18 00 00 00       	mov    $0x18,%esi
  100080:	bf ad 12 10 00       	mov    $0x1012ad,%edi
  100085:	e8 6c 01 00 00       	call   1001f6 <assert_fail>
            panic("Error, sys page alloc not virtualized!");
  10008a:	bf d8 12 10 00       	mov    $0x1012d8,%edi
  10008f:	b8 00 00 00 00       	mov    $0x0,%eax
  100094:	e8 90 00 00 00       	call   100129 <panic>

0000000000100099 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100099:	55                   	push   %rbp
  10009a:	48 89 e5             	mov    %rsp,%rbp
  10009d:	48 83 ec 50          	sub    $0x50,%rsp
  1000a1:	49 89 f2             	mov    %rsi,%r10
  1000a4:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1000a8:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1000ac:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1000b0:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  1000b4:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  1000b9:	85 ff                	test   %edi,%edi
  1000bb:	78 2e                	js     1000eb <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  1000bd:	48 63 ff             	movslq %edi,%rdi
  1000c0:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  1000c7:	cc cc cc 
  1000ca:	48 89 f8             	mov    %rdi,%rax
  1000cd:	48 f7 e2             	mul    %rdx
  1000d0:	48 89 d0             	mov    %rdx,%rax
  1000d3:	48 c1 e8 02          	shr    $0x2,%rax
  1000d7:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  1000db:	48 01 c2             	add    %rax,%rdx
  1000de:	48 29 d7             	sub    %rdx,%rdi
  1000e1:	0f b6 b7 35 13 10 00 	movzbl 0x101335(%rdi),%esi
  1000e8:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  1000eb:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  1000f2:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1000f6:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1000fa:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1000fe:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  100102:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100106:	4c 89 d2             	mov    %r10,%rdx
  100109:	8b 3d ed 8e fb ff    	mov    -0x47113(%rip),%edi        # b8ffc <cursorpos>
  10010f:	e8 5a 0f 00 00       	call   10106e <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100114:	3d 30 07 00 00       	cmp    $0x730,%eax
  100119:	ba 00 00 00 00       	mov    $0x0,%edx
  10011e:	0f 4d c2             	cmovge %edx,%eax
  100121:	89 05 d5 8e fb ff    	mov    %eax,-0x4712b(%rip)        # b8ffc <cursorpos>
    }
}
  100127:	c9                   	leave  
  100128:	c3                   	ret    

0000000000100129 <panic>:


// panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
  100129:	55                   	push   %rbp
  10012a:	48 89 e5             	mov    %rsp,%rbp
  10012d:	53                   	push   %rbx
  10012e:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100135:	48 89 fb             	mov    %rdi,%rbx
  100138:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  10013c:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  100140:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100144:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100148:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  10014c:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  100153:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100157:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  10015b:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  10015f:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  100163:	ba 07 00 00 00       	mov    $0x7,%edx
  100168:	be ff 12 10 00       	mov    $0x1012ff,%esi
  10016d:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100174:	e8 ac 00 00 00       	call   100225 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100179:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  10017d:	48 89 da             	mov    %rbx,%rdx
  100180:	be 99 00 00 00       	mov    $0x99,%esi
  100185:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  10018c:	e8 e9 0f 00 00       	call   10117a <vsnprintf>
  100191:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100194:	85 d2                	test   %edx,%edx
  100196:	7e 0f                	jle    1001a7 <panic+0x7e>
  100198:	83 c0 06             	add    $0x6,%eax
  10019b:	48 98                	cltq   
  10019d:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  1001a4:	0a 
  1001a5:	75 29                	jne    1001d0 <panic+0xa7>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  1001a7:	48 8d 8d 08 ff ff ff 	lea    -0xf8(%rbp),%rcx
  1001ae:	ba 09 13 10 00       	mov    $0x101309,%edx
  1001b3:	be 00 c0 00 00       	mov    $0xc000,%esi
  1001b8:	bf 30 07 00 00       	mov    $0x730,%edi
  1001bd:	b8 00 00 00 00       	mov    $0x0,%eax
  1001c2:	e8 13 0f 00 00       	call   1010da <console_printf>
    asm volatile ("int %0" : /* no result */
  1001c7:	bf 00 00 00 00       	mov    $0x0,%edi
  1001cc:	cd 30                	int    $0x30
 loop: goto loop;
  1001ce:	eb fe                	jmp    1001ce <panic+0xa5>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  1001d0:	48 63 c2             	movslq %edx,%rax
  1001d3:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  1001d9:	0f 94 c2             	sete   %dl
  1001dc:	0f b6 d2             	movzbl %dl,%edx
  1001df:	48 29 d0             	sub    %rdx,%rax
  1001e2:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  1001e9:	ff 
  1001ea:	be 07 13 10 00       	mov    $0x101307,%esi
  1001ef:	e8 de 01 00 00       	call   1003d2 <strcpy>
  1001f4:	eb b1                	jmp    1001a7 <panic+0x7e>

00000000001001f6 <assert_fail>:
    sys_panic(NULL);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  1001f6:	55                   	push   %rbp
  1001f7:	48 89 e5             	mov    %rsp,%rbp
  1001fa:	48 89 f9             	mov    %rdi,%rcx
  1001fd:	41 89 f0             	mov    %esi,%r8d
  100200:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100203:	ba 10 13 10 00       	mov    $0x101310,%edx
  100208:	be 00 c0 00 00       	mov    $0xc000,%esi
  10020d:	bf 30 07 00 00       	mov    $0x730,%edi
  100212:	b8 00 00 00 00       	mov    $0x0,%eax
  100217:	e8 be 0e 00 00       	call   1010da <console_printf>
    asm volatile ("int %0" : /* no result */
  10021c:	bf 00 00 00 00       	mov    $0x0,%edi
  100221:	cd 30                	int    $0x30
 loop: goto loop;
  100223:	eb fe                	jmp    100223 <assert_fail+0x2d>

0000000000100225 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100225:	55                   	push   %rbp
  100226:	48 89 e5             	mov    %rsp,%rbp
  100229:	48 83 ec 28          	sub    $0x28,%rsp
  10022d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100231:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100235:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100239:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10023d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100241:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100245:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100249:	eb 1c                	jmp    100267 <memcpy+0x42>
        *d = *s;
  10024b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10024f:	0f b6 10             	movzbl (%rax),%edx
  100252:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100256:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100258:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10025d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100262:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100267:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10026c:	75 dd                	jne    10024b <memcpy+0x26>
    }
    return dst;
  10026e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100272:	c9                   	leave  
  100273:	c3                   	ret    

0000000000100274 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100274:	55                   	push   %rbp
  100275:	48 89 e5             	mov    %rsp,%rbp
  100278:	48 83 ec 28          	sub    $0x28,%rsp
  10027c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100280:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100284:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100288:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10028c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  100290:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100294:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100298:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10029c:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  1002a0:	73 6a                	jae    10030c <memmove+0x98>
  1002a2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1002a6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1002aa:	48 01 d0             	add    %rdx,%rax
  1002ad:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1002b1:	73 59                	jae    10030c <memmove+0x98>
        s += n, d += n;
  1002b3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1002b7:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1002bb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1002bf:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1002c3:	eb 17                	jmp    1002dc <memmove+0x68>
            *--d = *--s;
  1002c5:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1002ca:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1002cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002d3:	0f b6 10             	movzbl (%rax),%edx
  1002d6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1002da:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1002dc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1002e0:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1002e4:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1002e8:	48 85 c0             	test   %rax,%rax
  1002eb:	75 d8                	jne    1002c5 <memmove+0x51>
    if (s < d && s + n > d) {
  1002ed:	eb 2e                	jmp    10031d <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1002ef:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1002f3:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1002f7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1002fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1002ff:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100303:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100307:	0f b6 12             	movzbl (%rdx),%edx
  10030a:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  10030c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100310:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100314:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100318:	48 85 c0             	test   %rax,%rax
  10031b:	75 d2                	jne    1002ef <memmove+0x7b>
        }
    }
    return dst;
  10031d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100321:	c9                   	leave  
  100322:	c3                   	ret    

0000000000100323 <memset>:

void* memset(void* v, int c, size_t n) {
  100323:	55                   	push   %rbp
  100324:	48 89 e5             	mov    %rsp,%rbp
  100327:	48 83 ec 28          	sub    $0x28,%rsp
  10032b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10032f:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100332:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100336:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10033a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10033e:	eb 15                	jmp    100355 <memset+0x32>
        *p = c;
  100340:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100343:	89 c2                	mov    %eax,%edx
  100345:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100349:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10034b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100350:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100355:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10035a:	75 e4                	jne    100340 <memset+0x1d>
    }
    return v;
  10035c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100360:	c9                   	leave  
  100361:	c3                   	ret    

0000000000100362 <strlen>:

size_t strlen(const char* s) {
  100362:	55                   	push   %rbp
  100363:	48 89 e5             	mov    %rsp,%rbp
  100366:	48 83 ec 18          	sub    $0x18,%rsp
  10036a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  10036e:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100375:	00 
  100376:	eb 0a                	jmp    100382 <strlen+0x20>
        ++n;
  100378:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  10037d:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100382:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100386:	0f b6 00             	movzbl (%rax),%eax
  100389:	84 c0                	test   %al,%al
  10038b:	75 eb                	jne    100378 <strlen+0x16>
    }
    return n;
  10038d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100391:	c9                   	leave  
  100392:	c3                   	ret    

0000000000100393 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100393:	55                   	push   %rbp
  100394:	48 89 e5             	mov    %rsp,%rbp
  100397:	48 83 ec 20          	sub    $0x20,%rsp
  10039b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10039f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1003a3:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1003aa:	00 
  1003ab:	eb 0a                	jmp    1003b7 <strnlen+0x24>
        ++n;
  1003ad:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1003b2:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1003b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003bb:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  1003bf:	74 0b                	je     1003cc <strnlen+0x39>
  1003c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1003c5:	0f b6 00             	movzbl (%rax),%eax
  1003c8:	84 c0                	test   %al,%al
  1003ca:	75 e1                	jne    1003ad <strnlen+0x1a>
    }
    return n;
  1003cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1003d0:	c9                   	leave  
  1003d1:	c3                   	ret    

00000000001003d2 <strcpy>:

char* strcpy(char* dst, const char* src) {
  1003d2:	55                   	push   %rbp
  1003d3:	48 89 e5             	mov    %rsp,%rbp
  1003d6:	48 83 ec 20          	sub    $0x20,%rsp
  1003da:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1003de:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1003e2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1003e6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1003ea:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1003ee:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1003f2:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1003f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003fa:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1003fe:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100402:	0f b6 12             	movzbl (%rdx),%edx
  100405:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100407:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10040b:	48 83 e8 01          	sub    $0x1,%rax
  10040f:	0f b6 00             	movzbl (%rax),%eax
  100412:	84 c0                	test   %al,%al
  100414:	75 d4                	jne    1003ea <strcpy+0x18>
    return dst;
  100416:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10041a:	c9                   	leave  
  10041b:	c3                   	ret    

000000000010041c <strcmp>:

int strcmp(const char* a, const char* b) {
  10041c:	55                   	push   %rbp
  10041d:	48 89 e5             	mov    %rsp,%rbp
  100420:	48 83 ec 10          	sub    $0x10,%rsp
  100424:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100428:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10042c:	eb 0a                	jmp    100438 <strcmp+0x1c>
        ++a, ++b;
  10042e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100433:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100438:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10043c:	0f b6 00             	movzbl (%rax),%eax
  10043f:	84 c0                	test   %al,%al
  100441:	74 1d                	je     100460 <strcmp+0x44>
  100443:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100447:	0f b6 00             	movzbl (%rax),%eax
  10044a:	84 c0                	test   %al,%al
  10044c:	74 12                	je     100460 <strcmp+0x44>
  10044e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100452:	0f b6 10             	movzbl (%rax),%edx
  100455:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100459:	0f b6 00             	movzbl (%rax),%eax
  10045c:	38 c2                	cmp    %al,%dl
  10045e:	74 ce                	je     10042e <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100460:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100464:	0f b6 00             	movzbl (%rax),%eax
  100467:	89 c2                	mov    %eax,%edx
  100469:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10046d:	0f b6 00             	movzbl (%rax),%eax
  100470:	38 d0                	cmp    %dl,%al
  100472:	0f 92 c0             	setb   %al
  100475:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100478:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10047c:	0f b6 00             	movzbl (%rax),%eax
  10047f:	89 c1                	mov    %eax,%ecx
  100481:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100485:	0f b6 00             	movzbl (%rax),%eax
  100488:	38 c1                	cmp    %al,%cl
  10048a:	0f 92 c0             	setb   %al
  10048d:	0f b6 c0             	movzbl %al,%eax
  100490:	29 c2                	sub    %eax,%edx
  100492:	89 d0                	mov    %edx,%eax
}
  100494:	c9                   	leave  
  100495:	c3                   	ret    

0000000000100496 <strchr>:

char* strchr(const char* s, int c) {
  100496:	55                   	push   %rbp
  100497:	48 89 e5             	mov    %rsp,%rbp
  10049a:	48 83 ec 10          	sub    $0x10,%rsp
  10049e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1004a2:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1004a5:	eb 05                	jmp    1004ac <strchr+0x16>
        ++s;
  1004a7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1004ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004b0:	0f b6 00             	movzbl (%rax),%eax
  1004b3:	84 c0                	test   %al,%al
  1004b5:	74 0e                	je     1004c5 <strchr+0x2f>
  1004b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004bb:	0f b6 00             	movzbl (%rax),%eax
  1004be:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1004c1:	38 d0                	cmp    %dl,%al
  1004c3:	75 e2                	jne    1004a7 <strchr+0x11>
    }
    if (*s == (char) c) {
  1004c5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004c9:	0f b6 00             	movzbl (%rax),%eax
  1004cc:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1004cf:	38 d0                	cmp    %dl,%al
  1004d1:	75 06                	jne    1004d9 <strchr+0x43>
        return (char*) s;
  1004d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004d7:	eb 05                	jmp    1004de <strchr+0x48>
    } else {
        return NULL;
  1004d9:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1004de:	c9                   	leave  
  1004df:	c3                   	ret    

00000000001004e0 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1004e0:	55                   	push   %rbp
  1004e1:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1004e4:	8b 05 16 1b 00 00    	mov    0x1b16(%rip),%eax        # 102000 <rand_seed_set>
  1004ea:	85 c0                	test   %eax,%eax
  1004ec:	75 0a                	jne    1004f8 <rand+0x18>
        srand(819234718U);
  1004ee:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1004f3:	e8 24 00 00 00       	call   10051c <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1004f8:	8b 05 06 1b 00 00    	mov    0x1b06(%rip),%eax        # 102004 <rand_seed>
  1004fe:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100504:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100509:	89 05 f5 1a 00 00    	mov    %eax,0x1af5(%rip)        # 102004 <rand_seed>
    return rand_seed & RAND_MAX;
  10050f:	8b 05 ef 1a 00 00    	mov    0x1aef(%rip),%eax        # 102004 <rand_seed>
  100515:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  10051a:	5d                   	pop    %rbp
  10051b:	c3                   	ret    

000000000010051c <srand>:

void srand(unsigned seed) {
  10051c:	55                   	push   %rbp
  10051d:	48 89 e5             	mov    %rsp,%rbp
  100520:	48 83 ec 08          	sub    $0x8,%rsp
  100524:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100527:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10052a:	89 05 d4 1a 00 00    	mov    %eax,0x1ad4(%rip)        # 102004 <rand_seed>
    rand_seed_set = 1;
  100530:	c7 05 c6 1a 00 00 01 	movl   $0x1,0x1ac6(%rip)        # 102000 <rand_seed_set>
  100537:	00 00 00 
}
  10053a:	90                   	nop
  10053b:	c9                   	leave  
  10053c:	c3                   	ret    

000000000010053d <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  10053d:	55                   	push   %rbp
  10053e:	48 89 e5             	mov    %rsp,%rbp
  100541:	48 83 ec 28          	sub    $0x28,%rsp
  100545:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100549:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10054d:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100550:	48 c7 45 f8 20 15 10 	movq   $0x101520,-0x8(%rbp)
  100557:	00 
    if (base < 0) {
  100558:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  10055c:	79 0b                	jns    100569 <fill_numbuf+0x2c>
        digits = lower_digits;
  10055e:	48 c7 45 f8 40 15 10 	movq   $0x101540,-0x8(%rbp)
  100565:	00 
        base = -base;
  100566:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100569:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10056e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100572:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100575:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100578:	48 63 c8             	movslq %eax,%rcx
  10057b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10057f:	ba 00 00 00 00       	mov    $0x0,%edx
  100584:	48 f7 f1             	div    %rcx
  100587:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10058b:	48 01 d0             	add    %rdx,%rax
  10058e:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100593:	0f b6 10             	movzbl (%rax),%edx
  100596:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10059a:	88 10                	mov    %dl,(%rax)
        val /= base;
  10059c:	8b 45 dc             	mov    -0x24(%rbp),%eax
  10059f:	48 63 f0             	movslq %eax,%rsi
  1005a2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1005a6:	ba 00 00 00 00       	mov    $0x0,%edx
  1005ab:	48 f7 f6             	div    %rsi
  1005ae:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  1005b2:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  1005b7:	75 bc                	jne    100575 <fill_numbuf+0x38>
    return numbuf_end;
  1005b9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1005bd:	c9                   	leave  
  1005be:	c3                   	ret    

00000000001005bf <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1005bf:	55                   	push   %rbp
  1005c0:	48 89 e5             	mov    %rsp,%rbp
  1005c3:	53                   	push   %rbx
  1005c4:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  1005cb:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1005d2:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1005d8:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1005df:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1005e6:	e9 8a 09 00 00       	jmp    100f75 <printer_vprintf+0x9b6>
        if (*format != '%') {
  1005eb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1005f2:	0f b6 00             	movzbl (%rax),%eax
  1005f5:	3c 25                	cmp    $0x25,%al
  1005f7:	74 31                	je     10062a <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  1005f9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100600:	4c 8b 00             	mov    (%rax),%r8
  100603:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10060a:	0f b6 00             	movzbl (%rax),%eax
  10060d:	0f b6 c8             	movzbl %al,%ecx
  100610:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100616:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10061d:	89 ce                	mov    %ecx,%esi
  10061f:	48 89 c7             	mov    %rax,%rdi
  100622:	41 ff d0             	call   *%r8
            continue;
  100625:	e9 43 09 00 00       	jmp    100f6d <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  10062a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100631:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100638:	01 
  100639:	eb 44                	jmp    10067f <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  10063b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100642:	0f b6 00             	movzbl (%rax),%eax
  100645:	0f be c0             	movsbl %al,%eax
  100648:	89 c6                	mov    %eax,%esi
  10064a:	bf 40 13 10 00       	mov    $0x101340,%edi
  10064f:	e8 42 fe ff ff       	call   100496 <strchr>
  100654:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100658:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  10065d:	74 30                	je     10068f <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  10065f:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100663:	48 2d 40 13 10 00    	sub    $0x101340,%rax
  100669:	ba 01 00 00 00       	mov    $0x1,%edx
  10066e:	89 c1                	mov    %eax,%ecx
  100670:	d3 e2                	shl    %cl,%edx
  100672:	89 d0                	mov    %edx,%eax
  100674:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100677:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10067e:	01 
  10067f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100686:	0f b6 00             	movzbl (%rax),%eax
  100689:	84 c0                	test   %al,%al
  10068b:	75 ae                	jne    10063b <printer_vprintf+0x7c>
  10068d:	eb 01                	jmp    100690 <printer_vprintf+0xd1>
            } else {
                break;
  10068f:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100690:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100697:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10069e:	0f b6 00             	movzbl (%rax),%eax
  1006a1:	3c 30                	cmp    $0x30,%al
  1006a3:	7e 67                	jle    10070c <printer_vprintf+0x14d>
  1006a5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006ac:	0f b6 00             	movzbl (%rax),%eax
  1006af:	3c 39                	cmp    $0x39,%al
  1006b1:	7f 59                	jg     10070c <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1006b3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  1006ba:	eb 2e                	jmp    1006ea <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  1006bc:	8b 55 e8             	mov    -0x18(%rbp),%edx
  1006bf:	89 d0                	mov    %edx,%eax
  1006c1:	c1 e0 02             	shl    $0x2,%eax
  1006c4:	01 d0                	add    %edx,%eax
  1006c6:	01 c0                	add    %eax,%eax
  1006c8:	89 c1                	mov    %eax,%ecx
  1006ca:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006d1:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1006d5:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1006dc:	0f b6 00             	movzbl (%rax),%eax
  1006df:	0f be c0             	movsbl %al,%eax
  1006e2:	01 c8                	add    %ecx,%eax
  1006e4:	83 e8 30             	sub    $0x30,%eax
  1006e7:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1006ea:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006f1:	0f b6 00             	movzbl (%rax),%eax
  1006f4:	3c 2f                	cmp    $0x2f,%al
  1006f6:	0f 8e 85 00 00 00    	jle    100781 <printer_vprintf+0x1c2>
  1006fc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100703:	0f b6 00             	movzbl (%rax),%eax
  100706:	3c 39                	cmp    $0x39,%al
  100708:	7e b2                	jle    1006bc <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  10070a:	eb 75                	jmp    100781 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  10070c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100713:	0f b6 00             	movzbl (%rax),%eax
  100716:	3c 2a                	cmp    $0x2a,%al
  100718:	75 68                	jne    100782 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  10071a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100721:	8b 00                	mov    (%rax),%eax
  100723:	83 f8 2f             	cmp    $0x2f,%eax
  100726:	77 30                	ja     100758 <printer_vprintf+0x199>
  100728:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10072f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100733:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10073a:	8b 00                	mov    (%rax),%eax
  10073c:	89 c0                	mov    %eax,%eax
  10073e:	48 01 d0             	add    %rdx,%rax
  100741:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100748:	8b 12                	mov    (%rdx),%edx
  10074a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10074d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100754:	89 0a                	mov    %ecx,(%rdx)
  100756:	eb 1a                	jmp    100772 <printer_vprintf+0x1b3>
  100758:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10075f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100763:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100767:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10076e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100772:	8b 00                	mov    (%rax),%eax
  100774:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100777:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10077e:	01 
  10077f:	eb 01                	jmp    100782 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100781:	90                   	nop
        }

        // process precision
        int precision = -1;
  100782:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100789:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100790:	0f b6 00             	movzbl (%rax),%eax
  100793:	3c 2e                	cmp    $0x2e,%al
  100795:	0f 85 00 01 00 00    	jne    10089b <printer_vprintf+0x2dc>
            ++format;
  10079b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1007a2:	01 
            if (*format >= '0' && *format <= '9') {
  1007a3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007aa:	0f b6 00             	movzbl (%rax),%eax
  1007ad:	3c 2f                	cmp    $0x2f,%al
  1007af:	7e 67                	jle    100818 <printer_vprintf+0x259>
  1007b1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007b8:	0f b6 00             	movzbl (%rax),%eax
  1007bb:	3c 39                	cmp    $0x39,%al
  1007bd:	7f 59                	jg     100818 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1007bf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  1007c6:	eb 2e                	jmp    1007f6 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  1007c8:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  1007cb:	89 d0                	mov    %edx,%eax
  1007cd:	c1 e0 02             	shl    $0x2,%eax
  1007d0:	01 d0                	add    %edx,%eax
  1007d2:	01 c0                	add    %eax,%eax
  1007d4:	89 c1                	mov    %eax,%ecx
  1007d6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007dd:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1007e1:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1007e8:	0f b6 00             	movzbl (%rax),%eax
  1007eb:	0f be c0             	movsbl %al,%eax
  1007ee:	01 c8                	add    %ecx,%eax
  1007f0:	83 e8 30             	sub    $0x30,%eax
  1007f3:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1007f6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007fd:	0f b6 00             	movzbl (%rax),%eax
  100800:	3c 2f                	cmp    $0x2f,%al
  100802:	0f 8e 85 00 00 00    	jle    10088d <printer_vprintf+0x2ce>
  100808:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10080f:	0f b6 00             	movzbl (%rax),%eax
  100812:	3c 39                	cmp    $0x39,%al
  100814:	7e b2                	jle    1007c8 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100816:	eb 75                	jmp    10088d <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100818:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10081f:	0f b6 00             	movzbl (%rax),%eax
  100822:	3c 2a                	cmp    $0x2a,%al
  100824:	75 68                	jne    10088e <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100826:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10082d:	8b 00                	mov    (%rax),%eax
  10082f:	83 f8 2f             	cmp    $0x2f,%eax
  100832:	77 30                	ja     100864 <printer_vprintf+0x2a5>
  100834:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10083b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10083f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100846:	8b 00                	mov    (%rax),%eax
  100848:	89 c0                	mov    %eax,%eax
  10084a:	48 01 d0             	add    %rdx,%rax
  10084d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100854:	8b 12                	mov    (%rdx),%edx
  100856:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100859:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100860:	89 0a                	mov    %ecx,(%rdx)
  100862:	eb 1a                	jmp    10087e <printer_vprintf+0x2bf>
  100864:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10086b:	48 8b 40 08          	mov    0x8(%rax),%rax
  10086f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100873:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10087a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10087e:	8b 00                	mov    (%rax),%eax
  100880:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100883:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10088a:	01 
  10088b:	eb 01                	jmp    10088e <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  10088d:	90                   	nop
            }
            if (precision < 0) {
  10088e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100892:	79 07                	jns    10089b <printer_vprintf+0x2dc>
                precision = 0;
  100894:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  10089b:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  1008a2:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  1008a9:	00 
        int length = 0;
  1008aa:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  1008b1:	48 c7 45 c8 46 13 10 	movq   $0x101346,-0x38(%rbp)
  1008b8:	00 
    again:
        switch (*format) {
  1008b9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008c0:	0f b6 00             	movzbl (%rax),%eax
  1008c3:	0f be c0             	movsbl %al,%eax
  1008c6:	83 e8 43             	sub    $0x43,%eax
  1008c9:	83 f8 37             	cmp    $0x37,%eax
  1008cc:	0f 87 9f 03 00 00    	ja     100c71 <printer_vprintf+0x6b2>
  1008d2:	89 c0                	mov    %eax,%eax
  1008d4:	48 8b 04 c5 58 13 10 	mov    0x101358(,%rax,8),%rax
  1008db:	00 
  1008dc:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  1008de:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  1008e5:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1008ec:	01 
            goto again;
  1008ed:	eb ca                	jmp    1008b9 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1008ef:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1008f3:	74 5d                	je     100952 <printer_vprintf+0x393>
  1008f5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008fc:	8b 00                	mov    (%rax),%eax
  1008fe:	83 f8 2f             	cmp    $0x2f,%eax
  100901:	77 30                	ja     100933 <printer_vprintf+0x374>
  100903:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10090a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10090e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100915:	8b 00                	mov    (%rax),%eax
  100917:	89 c0                	mov    %eax,%eax
  100919:	48 01 d0             	add    %rdx,%rax
  10091c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100923:	8b 12                	mov    (%rdx),%edx
  100925:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100928:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10092f:	89 0a                	mov    %ecx,(%rdx)
  100931:	eb 1a                	jmp    10094d <printer_vprintf+0x38e>
  100933:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10093a:	48 8b 40 08          	mov    0x8(%rax),%rax
  10093e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100942:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100949:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10094d:	48 8b 00             	mov    (%rax),%rax
  100950:	eb 5c                	jmp    1009ae <printer_vprintf+0x3ef>
  100952:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100959:	8b 00                	mov    (%rax),%eax
  10095b:	83 f8 2f             	cmp    $0x2f,%eax
  10095e:	77 30                	ja     100990 <printer_vprintf+0x3d1>
  100960:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100967:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10096b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100972:	8b 00                	mov    (%rax),%eax
  100974:	89 c0                	mov    %eax,%eax
  100976:	48 01 d0             	add    %rdx,%rax
  100979:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100980:	8b 12                	mov    (%rdx),%edx
  100982:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100985:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10098c:	89 0a                	mov    %ecx,(%rdx)
  10098e:	eb 1a                	jmp    1009aa <printer_vprintf+0x3eb>
  100990:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100997:	48 8b 40 08          	mov    0x8(%rax),%rax
  10099b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10099f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009a6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1009aa:	8b 00                	mov    (%rax),%eax
  1009ac:	48 98                	cltq   
  1009ae:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  1009b2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1009b6:	48 c1 f8 38          	sar    $0x38,%rax
  1009ba:	25 80 00 00 00       	and    $0x80,%eax
  1009bf:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  1009c2:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  1009c6:	74 09                	je     1009d1 <printer_vprintf+0x412>
  1009c8:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1009cc:	48 f7 d8             	neg    %rax
  1009cf:	eb 04                	jmp    1009d5 <printer_vprintf+0x416>
  1009d1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1009d5:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  1009d9:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  1009dc:	83 c8 60             	or     $0x60,%eax
  1009df:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  1009e2:	e9 cf 02 00 00       	jmp    100cb6 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1009e7:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1009eb:	74 5d                	je     100a4a <printer_vprintf+0x48b>
  1009ed:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009f4:	8b 00                	mov    (%rax),%eax
  1009f6:	83 f8 2f             	cmp    $0x2f,%eax
  1009f9:	77 30                	ja     100a2b <printer_vprintf+0x46c>
  1009fb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a02:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a06:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a0d:	8b 00                	mov    (%rax),%eax
  100a0f:	89 c0                	mov    %eax,%eax
  100a11:	48 01 d0             	add    %rdx,%rax
  100a14:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a1b:	8b 12                	mov    (%rdx),%edx
  100a1d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a20:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a27:	89 0a                	mov    %ecx,(%rdx)
  100a29:	eb 1a                	jmp    100a45 <printer_vprintf+0x486>
  100a2b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a32:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a36:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a3a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a41:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a45:	48 8b 00             	mov    (%rax),%rax
  100a48:	eb 5c                	jmp    100aa6 <printer_vprintf+0x4e7>
  100a4a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a51:	8b 00                	mov    (%rax),%eax
  100a53:	83 f8 2f             	cmp    $0x2f,%eax
  100a56:	77 30                	ja     100a88 <printer_vprintf+0x4c9>
  100a58:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a5f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a63:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a6a:	8b 00                	mov    (%rax),%eax
  100a6c:	89 c0                	mov    %eax,%eax
  100a6e:	48 01 d0             	add    %rdx,%rax
  100a71:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a78:	8b 12                	mov    (%rdx),%edx
  100a7a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a7d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a84:	89 0a                	mov    %ecx,(%rdx)
  100a86:	eb 1a                	jmp    100aa2 <printer_vprintf+0x4e3>
  100a88:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a8f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a93:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a97:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a9e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100aa2:	8b 00                	mov    (%rax),%eax
  100aa4:	89 c0                	mov    %eax,%eax
  100aa6:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100aaa:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100aae:	e9 03 02 00 00       	jmp    100cb6 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100ab3:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100aba:	e9 28 ff ff ff       	jmp    1009e7 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100abf:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100ac6:	e9 1c ff ff ff       	jmp    1009e7 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100acb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ad2:	8b 00                	mov    (%rax),%eax
  100ad4:	83 f8 2f             	cmp    $0x2f,%eax
  100ad7:	77 30                	ja     100b09 <printer_vprintf+0x54a>
  100ad9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ae0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ae4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100aeb:	8b 00                	mov    (%rax),%eax
  100aed:	89 c0                	mov    %eax,%eax
  100aef:	48 01 d0             	add    %rdx,%rax
  100af2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100af9:	8b 12                	mov    (%rdx),%edx
  100afb:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100afe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b05:	89 0a                	mov    %ecx,(%rdx)
  100b07:	eb 1a                	jmp    100b23 <printer_vprintf+0x564>
  100b09:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b10:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b14:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b18:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b1f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b23:	48 8b 00             	mov    (%rax),%rax
  100b26:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100b2a:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100b31:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100b38:	e9 79 01 00 00       	jmp    100cb6 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100b3d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b44:	8b 00                	mov    (%rax),%eax
  100b46:	83 f8 2f             	cmp    $0x2f,%eax
  100b49:	77 30                	ja     100b7b <printer_vprintf+0x5bc>
  100b4b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b52:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b56:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b5d:	8b 00                	mov    (%rax),%eax
  100b5f:	89 c0                	mov    %eax,%eax
  100b61:	48 01 d0             	add    %rdx,%rax
  100b64:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b6b:	8b 12                	mov    (%rdx),%edx
  100b6d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b70:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b77:	89 0a                	mov    %ecx,(%rdx)
  100b79:	eb 1a                	jmp    100b95 <printer_vprintf+0x5d6>
  100b7b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b82:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b86:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b8a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b91:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b95:	48 8b 00             	mov    (%rax),%rax
  100b98:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100b9c:	e9 15 01 00 00       	jmp    100cb6 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100ba1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ba8:	8b 00                	mov    (%rax),%eax
  100baa:	83 f8 2f             	cmp    $0x2f,%eax
  100bad:	77 30                	ja     100bdf <printer_vprintf+0x620>
  100baf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bb6:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100bba:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bc1:	8b 00                	mov    (%rax),%eax
  100bc3:	89 c0                	mov    %eax,%eax
  100bc5:	48 01 d0             	add    %rdx,%rax
  100bc8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bcf:	8b 12                	mov    (%rdx),%edx
  100bd1:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bd4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bdb:	89 0a                	mov    %ecx,(%rdx)
  100bdd:	eb 1a                	jmp    100bf9 <printer_vprintf+0x63a>
  100bdf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100be6:	48 8b 40 08          	mov    0x8(%rax),%rax
  100bea:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100bee:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bf5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100bf9:	8b 00                	mov    (%rax),%eax
  100bfb:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100c01:	e9 67 03 00 00       	jmp    100f6d <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  100c06:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100c0a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100c0e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c15:	8b 00                	mov    (%rax),%eax
  100c17:	83 f8 2f             	cmp    $0x2f,%eax
  100c1a:	77 30                	ja     100c4c <printer_vprintf+0x68d>
  100c1c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c23:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c27:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c2e:	8b 00                	mov    (%rax),%eax
  100c30:	89 c0                	mov    %eax,%eax
  100c32:	48 01 d0             	add    %rdx,%rax
  100c35:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c3c:	8b 12                	mov    (%rdx),%edx
  100c3e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c41:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c48:	89 0a                	mov    %ecx,(%rdx)
  100c4a:	eb 1a                	jmp    100c66 <printer_vprintf+0x6a7>
  100c4c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c53:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c57:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c5b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c62:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c66:	8b 00                	mov    (%rax),%eax
  100c68:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100c6b:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100c6f:	eb 45                	jmp    100cb6 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  100c71:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100c75:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100c79:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c80:	0f b6 00             	movzbl (%rax),%eax
  100c83:	84 c0                	test   %al,%al
  100c85:	74 0c                	je     100c93 <printer_vprintf+0x6d4>
  100c87:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c8e:	0f b6 00             	movzbl (%rax),%eax
  100c91:	eb 05                	jmp    100c98 <printer_vprintf+0x6d9>
  100c93:	b8 25 00 00 00       	mov    $0x25,%eax
  100c98:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100c9b:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100c9f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ca6:	0f b6 00             	movzbl (%rax),%eax
  100ca9:	84 c0                	test   %al,%al
  100cab:	75 08                	jne    100cb5 <printer_vprintf+0x6f6>
                format--;
  100cad:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100cb4:	01 
            }
            break;
  100cb5:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100cb6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cb9:	83 e0 20             	and    $0x20,%eax
  100cbc:	85 c0                	test   %eax,%eax
  100cbe:	74 1e                	je     100cde <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100cc0:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100cc4:	48 83 c0 18          	add    $0x18,%rax
  100cc8:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100ccb:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100ccf:	48 89 ce             	mov    %rcx,%rsi
  100cd2:	48 89 c7             	mov    %rax,%rdi
  100cd5:	e8 63 f8 ff ff       	call   10053d <fill_numbuf>
  100cda:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100cde:	48 c7 45 c0 46 13 10 	movq   $0x101346,-0x40(%rbp)
  100ce5:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100ce6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ce9:	83 e0 20             	and    $0x20,%eax
  100cec:	85 c0                	test   %eax,%eax
  100cee:	74 48                	je     100d38 <printer_vprintf+0x779>
  100cf0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cf3:	83 e0 40             	and    $0x40,%eax
  100cf6:	85 c0                	test   %eax,%eax
  100cf8:	74 3e                	je     100d38 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  100cfa:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cfd:	25 80 00 00 00       	and    $0x80,%eax
  100d02:	85 c0                	test   %eax,%eax
  100d04:	74 0a                	je     100d10 <printer_vprintf+0x751>
                prefix = "-";
  100d06:	48 c7 45 c0 47 13 10 	movq   $0x101347,-0x40(%rbp)
  100d0d:	00 
            if (flags & FLAG_NEGATIVE) {
  100d0e:	eb 73                	jmp    100d83 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100d10:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d13:	83 e0 10             	and    $0x10,%eax
  100d16:	85 c0                	test   %eax,%eax
  100d18:	74 0a                	je     100d24 <printer_vprintf+0x765>
                prefix = "+";
  100d1a:	48 c7 45 c0 49 13 10 	movq   $0x101349,-0x40(%rbp)
  100d21:	00 
            if (flags & FLAG_NEGATIVE) {
  100d22:	eb 5f                	jmp    100d83 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100d24:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d27:	83 e0 08             	and    $0x8,%eax
  100d2a:	85 c0                	test   %eax,%eax
  100d2c:	74 55                	je     100d83 <printer_vprintf+0x7c4>
                prefix = " ";
  100d2e:	48 c7 45 c0 4b 13 10 	movq   $0x10134b,-0x40(%rbp)
  100d35:	00 
            if (flags & FLAG_NEGATIVE) {
  100d36:	eb 4b                	jmp    100d83 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100d38:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d3b:	83 e0 20             	and    $0x20,%eax
  100d3e:	85 c0                	test   %eax,%eax
  100d40:	74 42                	je     100d84 <printer_vprintf+0x7c5>
  100d42:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d45:	83 e0 01             	and    $0x1,%eax
  100d48:	85 c0                	test   %eax,%eax
  100d4a:	74 38                	je     100d84 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  100d4c:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100d50:	74 06                	je     100d58 <printer_vprintf+0x799>
  100d52:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100d56:	75 2c                	jne    100d84 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  100d58:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100d5d:	75 0c                	jne    100d6b <printer_vprintf+0x7ac>
  100d5f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d62:	25 00 01 00 00       	and    $0x100,%eax
  100d67:	85 c0                	test   %eax,%eax
  100d69:	74 19                	je     100d84 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  100d6b:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100d6f:	75 07                	jne    100d78 <printer_vprintf+0x7b9>
  100d71:	b8 4d 13 10 00       	mov    $0x10134d,%eax
  100d76:	eb 05                	jmp    100d7d <printer_vprintf+0x7be>
  100d78:	b8 50 13 10 00       	mov    $0x101350,%eax
  100d7d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100d81:	eb 01                	jmp    100d84 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  100d83:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100d84:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100d88:	78 24                	js     100dae <printer_vprintf+0x7ef>
  100d8a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d8d:	83 e0 20             	and    $0x20,%eax
  100d90:	85 c0                	test   %eax,%eax
  100d92:	75 1a                	jne    100dae <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  100d94:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100d97:	48 63 d0             	movslq %eax,%rdx
  100d9a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100d9e:	48 89 d6             	mov    %rdx,%rsi
  100da1:	48 89 c7             	mov    %rax,%rdi
  100da4:	e8 ea f5 ff ff       	call   100393 <strnlen>
  100da9:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100dac:	eb 0f                	jmp    100dbd <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  100dae:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100db2:	48 89 c7             	mov    %rax,%rdi
  100db5:	e8 a8 f5 ff ff       	call   100362 <strlen>
  100dba:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100dbd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dc0:	83 e0 20             	and    $0x20,%eax
  100dc3:	85 c0                	test   %eax,%eax
  100dc5:	74 20                	je     100de7 <printer_vprintf+0x828>
  100dc7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100dcb:	78 1a                	js     100de7 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  100dcd:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100dd0:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100dd3:	7e 08                	jle    100ddd <printer_vprintf+0x81e>
  100dd5:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100dd8:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100ddb:	eb 05                	jmp    100de2 <printer_vprintf+0x823>
  100ddd:	b8 00 00 00 00       	mov    $0x0,%eax
  100de2:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100de5:	eb 5c                	jmp    100e43 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100de7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dea:	83 e0 20             	and    $0x20,%eax
  100ded:	85 c0                	test   %eax,%eax
  100def:	74 4b                	je     100e3c <printer_vprintf+0x87d>
  100df1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100df4:	83 e0 02             	and    $0x2,%eax
  100df7:	85 c0                	test   %eax,%eax
  100df9:	74 41                	je     100e3c <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100dfb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dfe:	83 e0 04             	and    $0x4,%eax
  100e01:	85 c0                	test   %eax,%eax
  100e03:	75 37                	jne    100e3c <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  100e05:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e09:	48 89 c7             	mov    %rax,%rdi
  100e0c:	e8 51 f5 ff ff       	call   100362 <strlen>
  100e11:	89 c2                	mov    %eax,%edx
  100e13:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100e16:	01 d0                	add    %edx,%eax
  100e18:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100e1b:	7e 1f                	jle    100e3c <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  100e1d:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100e20:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100e23:	89 c3                	mov    %eax,%ebx
  100e25:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e29:	48 89 c7             	mov    %rax,%rdi
  100e2c:	e8 31 f5 ff ff       	call   100362 <strlen>
  100e31:	89 c2                	mov    %eax,%edx
  100e33:	89 d8                	mov    %ebx,%eax
  100e35:	29 d0                	sub    %edx,%eax
  100e37:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100e3a:	eb 07                	jmp    100e43 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  100e3c:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100e43:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100e46:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100e49:	01 d0                	add    %edx,%eax
  100e4b:	48 63 d8             	movslq %eax,%rbx
  100e4e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e52:	48 89 c7             	mov    %rax,%rdi
  100e55:	e8 08 f5 ff ff       	call   100362 <strlen>
  100e5a:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100e5e:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100e61:	29 d0                	sub    %edx,%eax
  100e63:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100e66:	eb 25                	jmp    100e8d <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  100e68:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e6f:	48 8b 08             	mov    (%rax),%rcx
  100e72:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100e78:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e7f:	be 20 00 00 00       	mov    $0x20,%esi
  100e84:	48 89 c7             	mov    %rax,%rdi
  100e87:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100e89:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100e8d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e90:	83 e0 04             	and    $0x4,%eax
  100e93:	85 c0                	test   %eax,%eax
  100e95:	75 36                	jne    100ecd <printer_vprintf+0x90e>
  100e97:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100e9b:	7f cb                	jg     100e68 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  100e9d:	eb 2e                	jmp    100ecd <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  100e9f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ea6:	4c 8b 00             	mov    (%rax),%r8
  100ea9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100ead:	0f b6 00             	movzbl (%rax),%eax
  100eb0:	0f b6 c8             	movzbl %al,%ecx
  100eb3:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100eb9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ec0:	89 ce                	mov    %ecx,%esi
  100ec2:	48 89 c7             	mov    %rax,%rdi
  100ec5:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  100ec8:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  100ecd:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100ed1:	0f b6 00             	movzbl (%rax),%eax
  100ed4:	84 c0                	test   %al,%al
  100ed6:	75 c7                	jne    100e9f <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  100ed8:	eb 25                	jmp    100eff <printer_vprintf+0x940>
            p->putc(p, '0', color);
  100eda:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ee1:	48 8b 08             	mov    (%rax),%rcx
  100ee4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100eea:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ef1:	be 30 00 00 00       	mov    $0x30,%esi
  100ef6:	48 89 c7             	mov    %rax,%rdi
  100ef9:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  100efb:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  100eff:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  100f03:	7f d5                	jg     100eda <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  100f05:	eb 32                	jmp    100f39 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  100f07:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f0e:	4c 8b 00             	mov    (%rax),%r8
  100f11:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100f15:	0f b6 00             	movzbl (%rax),%eax
  100f18:	0f b6 c8             	movzbl %al,%ecx
  100f1b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f21:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f28:	89 ce                	mov    %ecx,%esi
  100f2a:	48 89 c7             	mov    %rax,%rdi
  100f2d:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  100f30:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  100f35:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  100f39:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  100f3d:	7f c8                	jg     100f07 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  100f3f:	eb 25                	jmp    100f66 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  100f41:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f48:	48 8b 08             	mov    (%rax),%rcx
  100f4b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f51:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f58:	be 20 00 00 00       	mov    $0x20,%esi
  100f5d:	48 89 c7             	mov    %rax,%rdi
  100f60:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  100f62:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100f66:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100f6a:	7f d5                	jg     100f41 <printer_vprintf+0x982>
        }
    done: ;
  100f6c:	90                   	nop
    for (; *format; ++format) {
  100f6d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100f74:	01 
  100f75:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f7c:	0f b6 00             	movzbl (%rax),%eax
  100f7f:	84 c0                	test   %al,%al
  100f81:	0f 85 64 f6 ff ff    	jne    1005eb <printer_vprintf+0x2c>
    }
}
  100f87:	90                   	nop
  100f88:	90                   	nop
  100f89:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100f8d:	c9                   	leave  
  100f8e:	c3                   	ret    

0000000000100f8f <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100f8f:	55                   	push   %rbp
  100f90:	48 89 e5             	mov    %rsp,%rbp
  100f93:	48 83 ec 20          	sub    $0x20,%rsp
  100f97:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100f9b:	89 f0                	mov    %esi,%eax
  100f9d:	89 55 e0             	mov    %edx,-0x20(%rbp)
  100fa0:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  100fa3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100fa7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100fab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100faf:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fb3:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  100fb8:	48 39 d0             	cmp    %rdx,%rax
  100fbb:	72 0c                	jb     100fc9 <console_putc+0x3a>
        cp->cursor = console;
  100fbd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100fc1:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  100fc8:	00 
    }
    if (c == '\n') {
  100fc9:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  100fcd:	75 78                	jne    101047 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  100fcf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100fd3:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fd7:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  100fdd:	48 d1 f8             	sar    %rax
  100fe0:	48 89 c1             	mov    %rax,%rcx
  100fe3:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  100fea:	66 66 66 
  100fed:	48 89 c8             	mov    %rcx,%rax
  100ff0:	48 f7 ea             	imul   %rdx
  100ff3:	48 c1 fa 05          	sar    $0x5,%rdx
  100ff7:	48 89 c8             	mov    %rcx,%rax
  100ffa:	48 c1 f8 3f          	sar    $0x3f,%rax
  100ffe:	48 29 c2             	sub    %rax,%rdx
  101001:	48 89 d0             	mov    %rdx,%rax
  101004:	48 c1 e0 02          	shl    $0x2,%rax
  101008:	48 01 d0             	add    %rdx,%rax
  10100b:	48 c1 e0 04          	shl    $0x4,%rax
  10100f:	48 29 c1             	sub    %rax,%rcx
  101012:	48 89 ca             	mov    %rcx,%rdx
  101015:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101018:	eb 25                	jmp    10103f <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  10101a:	8b 45 e0             	mov    -0x20(%rbp),%eax
  10101d:	83 c8 20             	or     $0x20,%eax
  101020:	89 c6                	mov    %eax,%esi
  101022:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101026:	48 8b 40 08          	mov    0x8(%rax),%rax
  10102a:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10102e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101032:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101036:	89 f2                	mov    %esi,%edx
  101038:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  10103b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10103f:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101043:	75 d5                	jne    10101a <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101045:	eb 24                	jmp    10106b <console_putc+0xdc>
        *cp->cursor++ = c | color;
  101047:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  10104b:	8b 55 e0             	mov    -0x20(%rbp),%edx
  10104e:	09 d0                	or     %edx,%eax
  101050:	89 c6                	mov    %eax,%esi
  101052:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101056:	48 8b 40 08          	mov    0x8(%rax),%rax
  10105a:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10105e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101062:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101066:	89 f2                	mov    %esi,%edx
  101068:	66 89 10             	mov    %dx,(%rax)
}
  10106b:	90                   	nop
  10106c:	c9                   	leave  
  10106d:	c3                   	ret    

000000000010106e <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  10106e:	55                   	push   %rbp
  10106f:	48 89 e5             	mov    %rsp,%rbp
  101072:	48 83 ec 30          	sub    $0x30,%rsp
  101076:	89 7d ec             	mov    %edi,-0x14(%rbp)
  101079:	89 75 e8             	mov    %esi,-0x18(%rbp)
  10107c:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101080:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  101084:	48 c7 45 f0 8f 0f 10 	movq   $0x100f8f,-0x10(%rbp)
  10108b:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10108c:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  101090:	78 09                	js     10109b <console_vprintf+0x2d>
  101092:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101099:	7e 07                	jle    1010a2 <console_vprintf+0x34>
        cpos = 0;
  10109b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  1010a2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010a5:	48 98                	cltq   
  1010a7:	48 01 c0             	add    %rax,%rax
  1010aa:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  1010b0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1010b4:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1010b8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1010bc:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1010bf:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  1010c3:	48 89 c7             	mov    %rax,%rdi
  1010c6:	e8 f4 f4 ff ff       	call   1005bf <printer_vprintf>
    return cp.cursor - console;
  1010cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1010cf:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1010d5:	48 d1 f8             	sar    %rax
}
  1010d8:	c9                   	leave  
  1010d9:	c3                   	ret    

00000000001010da <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  1010da:	55                   	push   %rbp
  1010db:	48 89 e5             	mov    %rsp,%rbp
  1010de:	48 83 ec 60          	sub    $0x60,%rsp
  1010e2:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1010e5:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1010e8:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1010ec:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1010f0:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1010f4:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1010f8:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1010ff:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101103:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101107:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10110b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  10110f:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101113:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101117:	8b 75 a8             	mov    -0x58(%rbp),%esi
  10111a:	8b 45 ac             	mov    -0x54(%rbp),%eax
  10111d:	89 c7                	mov    %eax,%edi
  10111f:	e8 4a ff ff ff       	call   10106e <console_vprintf>
  101124:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101127:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  10112a:	c9                   	leave  
  10112b:	c3                   	ret    

000000000010112c <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  10112c:	55                   	push   %rbp
  10112d:	48 89 e5             	mov    %rsp,%rbp
  101130:	48 83 ec 20          	sub    $0x20,%rsp
  101134:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101138:	89 f0                	mov    %esi,%eax
  10113a:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10113d:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101140:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101144:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101148:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10114c:	48 8b 50 08          	mov    0x8(%rax),%rdx
  101150:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101154:	48 8b 40 10          	mov    0x10(%rax),%rax
  101158:	48 39 c2             	cmp    %rax,%rdx
  10115b:	73 1a                	jae    101177 <string_putc+0x4b>
        *sp->s++ = c;
  10115d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101161:	48 8b 40 08          	mov    0x8(%rax),%rax
  101165:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101169:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10116d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101171:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101175:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101177:	90                   	nop
  101178:	c9                   	leave  
  101179:	c3                   	ret    

000000000010117a <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  10117a:	55                   	push   %rbp
  10117b:	48 89 e5             	mov    %rsp,%rbp
  10117e:	48 83 ec 40          	sub    $0x40,%rsp
  101182:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101186:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  10118a:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  10118e:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101192:	48 c7 45 e8 2c 11 10 	movq   $0x10112c,-0x18(%rbp)
  101199:	00 
    sp.s = s;
  10119a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10119e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1011a2:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1011a7:	74 33                	je     1011dc <vsnprintf+0x62>
        sp.end = s + size - 1;
  1011a9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1011ad:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1011b1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1011b5:	48 01 d0             	add    %rdx,%rax
  1011b8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1011bc:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1011c0:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1011c4:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1011c8:	be 00 00 00 00       	mov    $0x0,%esi
  1011cd:	48 89 c7             	mov    %rax,%rdi
  1011d0:	e8 ea f3 ff ff       	call   1005bf <printer_vprintf>
        *sp.s = 0;
  1011d5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011d9:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1011dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011e0:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1011e4:	c9                   	leave  
  1011e5:	c3                   	ret    

00000000001011e6 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1011e6:	55                   	push   %rbp
  1011e7:	48 89 e5             	mov    %rsp,%rbp
  1011ea:	48 83 ec 70          	sub    $0x70,%rsp
  1011ee:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1011f2:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1011f6:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1011fa:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1011fe:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101202:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101206:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  10120d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101211:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101215:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101219:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  10121d:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101221:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101225:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101229:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10122d:	48 89 c7             	mov    %rax,%rdi
  101230:	e8 45 ff ff ff       	call   10117a <vsnprintf>
  101235:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101238:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  10123b:	c9                   	leave  
  10123c:	c3                   	ret    

000000000010123d <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  10123d:	55                   	push   %rbp
  10123e:	48 89 e5             	mov    %rsp,%rbp
  101241:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101245:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  10124c:	eb 13                	jmp    101261 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  10124e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  101251:	48 98                	cltq   
  101253:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  10125a:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10125d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101261:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101268:	7e e4                	jle    10124e <console_clear+0x11>
    }
    cursorpos = 0;
  10126a:	c7 05 88 7d fb ff 00 	movl   $0x0,-0x48278(%rip)        # b8ffc <cursorpos>
  101271:	00 00 00 
}
  101274:	90                   	nop
  101275:	c9                   	leave  
  101276:	c3                   	ret    
