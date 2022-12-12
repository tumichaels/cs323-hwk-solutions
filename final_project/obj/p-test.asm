
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
uint8_t *heap_bottom;
uint8_t *stack_bottom;



void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	41 57                	push   %r15
  100006:	41 56                	push   %r14
  100008:	41 55                	push   %r13
  10000a:	41 54                	push   %r12
  10000c:	53                   	push   %rbx
  10000d:	48 83 ec 08          	sub    $0x8,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100011:	cd 31                	int    $0x31
  100013:	89 c7                	mov    %eax,%edi
    pid_t p = getpid();
    srand(p);
  100015:	e8 6c 05 00 00       	call   100586 <srand>
    heap_bottom = heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10001a:	b8 1f 30 10 00       	mov    $0x10301f,%eax
  10001f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100025:	48 89 05 e4 1f 00 00 	mov    %rax,0x1fe4(%rip)        # 102010 <heap_top>
  10002c:	48 89 05 d5 1f 00 00 	mov    %rax,0x1fd5(%rip)        # 102008 <heap_bottom>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100033:	48 89 e0             	mov    %rsp,%rax
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100036:	48 83 e8 01          	sub    $0x1,%rax
  10003a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100040:	48 89 05 b9 1f 00 00 	mov    %rax,0x1fb9(%rip)        # 102000 <stack_bottom>
  100047:	bb 01 00 00 00       	mov    $0x1,%ebx
  10004c:	41 89 df             	mov    %ebx,%r15d
void process_main(void) {
  10004f:	49 89 de             	mov    %rbx,%r14
  100052:	41 89 dd             	mov    %ebx,%r13d
  100055:	41 bc 01 00 00 00    	mov    $0x1,%r12d

    /* Single elements on heap of varying sizes */
    for(int i = 1; i < 64; ++i) {
        for(int j = 1; j < 64; ++j) {
            void *ptr = calloc(i,j);
  10005b:	4c 89 e6             	mov    %r12,%rsi
  10005e:	48 89 df             	mov    %rbx,%rdi
  100061:	e8 16 02 00 00       	call   10027c <calloc>
            assert(ptr != NULL);
  100066:	48 85 c0             	test   %rax,%rax
  100069:	74 55                	je     1000c0 <process_main+0xc0>

            for(int k = 0; k < i*j; ++k) {
  10006b:	48 89 c2             	mov    %rax,%rdx
  10006e:	4a 8d 0c 30          	lea    (%rax,%r14,1),%rcx
  100072:	45 85 ed             	test   %r13d,%r13d
  100075:	7e 0e                	jle    100085 <process_main+0x85>
                assert(((char *)ptr)[k] == 0);
  100077:	80 3a 00             	cmpb   $0x0,(%rdx)
  10007a:	75 58                	jne    1000d4 <process_main+0xd4>
            for(int k = 0; k < i*j; ++k) {
  10007c:	48 83 c2 01          	add    $0x1,%rdx
  100080:	48 39 ca             	cmp    %rcx,%rdx
  100083:	75 f2                	jne    100077 <process_main+0x77>
            }

            free(ptr);
  100085:	48 89 c7             	mov    %rax,%rdi
  100088:	e8 e8 01 00 00       	call   100275 <free>
        for(int j = 1; j < 64; ++j) {
  10008d:	49 83 c4 01          	add    $0x1,%r12
  100091:	45 01 fd             	add    %r15d,%r13d
  100094:	49 01 de             	add    %rbx,%r14
  100097:	49 83 fc 40          	cmp    $0x40,%r12
  10009b:	75 be                	jne    10005b <process_main+0x5b>
        }
	defrag();
  10009d:	b8 00 00 00 00       	mov    $0x0,%eax
  1000a2:	e8 e1 01 00 00       	call   100288 <defrag>
    for(int i = 1; i < 64; ++i) {
  1000a7:	48 83 c3 01          	add    $0x1,%rbx
  1000ab:	48 83 fb 40          	cmp    $0x40,%rbx
  1000af:	75 9b                	jne    10004c <process_main+0x4c>
    }

    TEST_PASS();
  1000b1:	bf 22 13 10 00       	mov    $0x101322,%edi
  1000b6:	b8 00 00 00 00       	mov    $0x0,%eax
  1000bb:	e8 b8 00 00 00       	call   100178 <kernel_panic>
            assert(ptr != NULL);
  1000c0:	ba f0 12 10 00       	mov    $0x1012f0,%edx
  1000c5:	be 19 00 00 00       	mov    $0x19,%esi
  1000ca:	bf fc 12 10 00       	mov    $0x1012fc,%edi
  1000cf:	e8 72 01 00 00       	call   100246 <assert_fail>
                assert(((char *)ptr)[k] == 0);
  1000d4:	ba 0c 13 10 00       	mov    $0x10130c,%edx
  1000d9:	be 1c 00 00 00       	mov    $0x1c,%esi
  1000de:	bf fc 12 10 00       	mov    $0x1012fc,%edi
  1000e3:	e8 5e 01 00 00       	call   100246 <assert_fail>

00000000001000e8 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  1000e8:	55                   	push   %rbp
  1000e9:	48 89 e5             	mov    %rsp,%rbp
  1000ec:	48 83 ec 50          	sub    $0x50,%rsp
  1000f0:	49 89 f2             	mov    %rsi,%r10
  1000f3:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1000f7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1000fb:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1000ff:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  100103:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100108:	85 ff                	test   %edi,%edi
  10010a:	78 2e                	js     10013a <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  10010c:	48 63 ff             	movslq %edi,%rdi
  10010f:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  100116:	cc cc cc 
  100119:	48 89 f8             	mov    %rdi,%rax
  10011c:	48 f7 e2             	mul    %rdx
  10011f:	48 89 d0             	mov    %rdx,%rax
  100122:	48 c1 e8 02          	shr    $0x2,%rax
  100126:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  10012a:	48 01 c2             	add    %rax,%rdx
  10012d:	48 29 d7             	sub    %rdx,%rdi
  100130:	0f b6 b7 75 13 10 00 	movzbl 0x101375(%rdi),%esi
  100137:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  10013a:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  100141:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100145:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100149:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10014d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  100151:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100155:	4c 89 d2             	mov    %r10,%rdx
  100158:	8b 3d 9e 8e fb ff    	mov    -0x47162(%rip),%edi        # b8ffc <cursorpos>
  10015e:	e8 75 0f 00 00       	call   1010d8 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100163:	3d 30 07 00 00       	cmp    $0x730,%eax
  100168:	ba 00 00 00 00       	mov    $0x0,%edx
  10016d:	0f 4d c2             	cmovge %edx,%eax
  100170:	89 05 86 8e fb ff    	mov    %eax,-0x4717a(%rip)        # b8ffc <cursorpos>
    }
}
  100176:	c9                   	leave  
  100177:	c3                   	ret    

0000000000100178 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  100178:	55                   	push   %rbp
  100179:	48 89 e5             	mov    %rsp,%rbp
  10017c:	53                   	push   %rbx
  10017d:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100184:	48 89 fb             	mov    %rdi,%rbx
  100187:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  10018b:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  10018f:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100193:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100197:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  10019b:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  1001a2:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1001a6:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  1001aa:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  1001ae:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  1001b2:	ba 07 00 00 00       	mov    $0x7,%edx
  1001b7:	be 3d 13 10 00       	mov    $0x10133d,%esi
  1001bc:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  1001c3:	e8 c7 00 00 00       	call   10028f <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  1001c8:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  1001cc:	48 89 da             	mov    %rbx,%rdx
  1001cf:	be 99 00 00 00       	mov    $0x99,%esi
  1001d4:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  1001db:	e8 04 10 00 00       	call   1011e4 <vsnprintf>
  1001e0:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  1001e3:	85 d2                	test   %edx,%edx
  1001e5:	7e 0f                	jle    1001f6 <kernel_panic+0x7e>
  1001e7:	83 c0 06             	add    $0x6,%eax
  1001ea:	48 98                	cltq   
  1001ec:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  1001f3:	0a 
  1001f4:	75 2a                	jne    100220 <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  1001f6:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  1001fd:	48 89 d9             	mov    %rbx,%rcx
  100200:	ba 47 13 10 00       	mov    $0x101347,%edx
  100205:	be 00 c0 00 00       	mov    $0xc000,%esi
  10020a:	bf 30 07 00 00       	mov    $0x730,%edi
  10020f:	b8 00 00 00 00       	mov    $0x0,%eax
  100214:	e8 2b 0f 00 00       	call   101144 <console_printf>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  100219:	48 89 df             	mov    %rbx,%rdi
  10021c:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  10021e:	eb fe                	jmp    10021e <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  100220:	48 63 c2             	movslq %edx,%rax
  100223:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  100229:	0f 94 c2             	sete   %dl
  10022c:	0f b6 d2             	movzbl %dl,%edx
  10022f:	48 29 d0             	sub    %rdx,%rax
  100232:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  100239:	ff 
  10023a:	be 45 13 10 00       	mov    $0x101345,%esi
  10023f:	e8 f8 01 00 00       	call   10043c <strcpy>
  100244:	eb b0                	jmp    1001f6 <kernel_panic+0x7e>

0000000000100246 <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  100246:	55                   	push   %rbp
  100247:	48 89 e5             	mov    %rsp,%rbp
  10024a:	48 89 f9             	mov    %rdi,%rcx
  10024d:	41 89 f0             	mov    %esi,%r8d
  100250:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100253:	ba 50 13 10 00       	mov    $0x101350,%edx
  100258:	be 00 c0 00 00       	mov    $0xc000,%esi
  10025d:	bf 30 07 00 00       	mov    $0x730,%edi
  100262:	b8 00 00 00 00       	mov    $0x0,%eax
  100267:	e8 d8 0e 00 00       	call   101144 <console_printf>
    asm volatile ("int %0" : /* no result */
  10026c:	bf 00 00 00 00       	mov    $0x0,%edi
  100271:	cd 30                	int    $0x30
 loop: goto loop;
  100273:	eb fe                	jmp    100273 <assert_fail+0x2d>

0000000000100275 <free>:
#include "malloc.h"

void free(void *firstbyte) {
    return;
}
  100275:	c3                   	ret    

0000000000100276 <malloc>:

void *malloc(uint64_t numbytes) {
    return 0 ;
}
  100276:	b8 00 00 00 00       	mov    $0x0,%eax
  10027b:	c3                   	ret    

000000000010027c <calloc>:


void * calloc(uint64_t num, uint64_t sz) {
    return 0;
}
  10027c:	b8 00 00 00 00       	mov    $0x0,%eax
  100281:	c3                   	ret    

0000000000100282 <realloc>:

void * realloc(void * ptr, uint64_t sz) {
    return 0;
}
  100282:	b8 00 00 00 00       	mov    $0x0,%eax
  100287:	c3                   	ret    

0000000000100288 <defrag>:

void defrag() {
}
  100288:	c3                   	ret    

0000000000100289 <heap_info>:

int heap_info(heap_info_struct * info) {
    return 0;
}
  100289:	b8 00 00 00 00       	mov    $0x0,%eax
  10028e:	c3                   	ret    

000000000010028f <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  10028f:	55                   	push   %rbp
  100290:	48 89 e5             	mov    %rsp,%rbp
  100293:	48 83 ec 28          	sub    $0x28,%rsp
  100297:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10029b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10029f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1002a3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1002a7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1002ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1002af:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  1002b3:	eb 1c                	jmp    1002d1 <memcpy+0x42>
        *d = *s;
  1002b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002b9:	0f b6 10             	movzbl (%rax),%edx
  1002bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1002c0:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1002c2:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1002c7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1002cc:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1002d1:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1002d6:	75 dd                	jne    1002b5 <memcpy+0x26>
    }
    return dst;
  1002d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1002dc:	c9                   	leave  
  1002dd:	c3                   	ret    

00000000001002de <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1002de:	55                   	push   %rbp
  1002df:	48 89 e5             	mov    %rsp,%rbp
  1002e2:	48 83 ec 28          	sub    $0x28,%rsp
  1002e6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1002ea:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1002ee:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1002f2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1002f6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  1002fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1002fe:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100302:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100306:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  10030a:	73 6a                	jae    100376 <memmove+0x98>
  10030c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100310:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100314:	48 01 d0             	add    %rdx,%rax
  100317:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  10031b:	73 59                	jae    100376 <memmove+0x98>
        s += n, d += n;
  10031d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100321:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100325:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100329:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  10032d:	eb 17                	jmp    100346 <memmove+0x68>
            *--d = *--s;
  10032f:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100334:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100339:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10033d:	0f b6 10             	movzbl (%rax),%edx
  100340:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100344:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100346:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10034a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10034e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100352:	48 85 c0             	test   %rax,%rax
  100355:	75 d8                	jne    10032f <memmove+0x51>
    if (s < d && s + n > d) {
  100357:	eb 2e                	jmp    100387 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100359:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10035d:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100361:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100365:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100369:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10036d:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100371:	0f b6 12             	movzbl (%rdx),%edx
  100374:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100376:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10037a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10037e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100382:	48 85 c0             	test   %rax,%rax
  100385:	75 d2                	jne    100359 <memmove+0x7b>
        }
    }
    return dst;
  100387:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10038b:	c9                   	leave  
  10038c:	c3                   	ret    

000000000010038d <memset>:

void* memset(void* v, int c, size_t n) {
  10038d:	55                   	push   %rbp
  10038e:	48 89 e5             	mov    %rsp,%rbp
  100391:	48 83 ec 28          	sub    $0x28,%rsp
  100395:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100399:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  10039c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1003a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1003a4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1003a8:	eb 15                	jmp    1003bf <memset+0x32>
        *p = c;
  1003aa:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1003ad:	89 c2                	mov    %eax,%edx
  1003af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003b3:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1003b5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1003ba:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1003bf:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1003c4:	75 e4                	jne    1003aa <memset+0x1d>
    }
    return v;
  1003c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1003ca:	c9                   	leave  
  1003cb:	c3                   	ret    

00000000001003cc <strlen>:

size_t strlen(const char* s) {
  1003cc:	55                   	push   %rbp
  1003cd:	48 89 e5             	mov    %rsp,%rbp
  1003d0:	48 83 ec 18          	sub    $0x18,%rsp
  1003d4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  1003d8:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1003df:	00 
  1003e0:	eb 0a                	jmp    1003ec <strlen+0x20>
        ++n;
  1003e2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  1003e7:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1003ec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1003f0:	0f b6 00             	movzbl (%rax),%eax
  1003f3:	84 c0                	test   %al,%al
  1003f5:	75 eb                	jne    1003e2 <strlen+0x16>
    }
    return n;
  1003f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1003fb:	c9                   	leave  
  1003fc:	c3                   	ret    

00000000001003fd <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  1003fd:	55                   	push   %rbp
  1003fe:	48 89 e5             	mov    %rsp,%rbp
  100401:	48 83 ec 20          	sub    $0x20,%rsp
  100405:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100409:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  10040d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100414:	00 
  100415:	eb 0a                	jmp    100421 <strnlen+0x24>
        ++n;
  100417:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  10041c:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100421:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100425:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100429:	74 0b                	je     100436 <strnlen+0x39>
  10042b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10042f:	0f b6 00             	movzbl (%rax),%eax
  100432:	84 c0                	test   %al,%al
  100434:	75 e1                	jne    100417 <strnlen+0x1a>
    }
    return n;
  100436:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  10043a:	c9                   	leave  
  10043b:	c3                   	ret    

000000000010043c <strcpy>:

char* strcpy(char* dst, const char* src) {
  10043c:	55                   	push   %rbp
  10043d:	48 89 e5             	mov    %rsp,%rbp
  100440:	48 83 ec 20          	sub    $0x20,%rsp
  100444:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100448:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  10044c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100450:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100454:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100458:	48 8d 42 01          	lea    0x1(%rdx),%rax
  10045c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100460:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100464:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100468:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  10046c:	0f b6 12             	movzbl (%rdx),%edx
  10046f:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100471:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100475:	48 83 e8 01          	sub    $0x1,%rax
  100479:	0f b6 00             	movzbl (%rax),%eax
  10047c:	84 c0                	test   %al,%al
  10047e:	75 d4                	jne    100454 <strcpy+0x18>
    return dst;
  100480:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100484:	c9                   	leave  
  100485:	c3                   	ret    

0000000000100486 <strcmp>:

int strcmp(const char* a, const char* b) {
  100486:	55                   	push   %rbp
  100487:	48 89 e5             	mov    %rsp,%rbp
  10048a:	48 83 ec 10          	sub    $0x10,%rsp
  10048e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100492:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100496:	eb 0a                	jmp    1004a2 <strcmp+0x1c>
        ++a, ++b;
  100498:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10049d:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1004a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004a6:	0f b6 00             	movzbl (%rax),%eax
  1004a9:	84 c0                	test   %al,%al
  1004ab:	74 1d                	je     1004ca <strcmp+0x44>
  1004ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004b1:	0f b6 00             	movzbl (%rax),%eax
  1004b4:	84 c0                	test   %al,%al
  1004b6:	74 12                	je     1004ca <strcmp+0x44>
  1004b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004bc:	0f b6 10             	movzbl (%rax),%edx
  1004bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004c3:	0f b6 00             	movzbl (%rax),%eax
  1004c6:	38 c2                	cmp    %al,%dl
  1004c8:	74 ce                	je     100498 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  1004ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004ce:	0f b6 00             	movzbl (%rax),%eax
  1004d1:	89 c2                	mov    %eax,%edx
  1004d3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004d7:	0f b6 00             	movzbl (%rax),%eax
  1004da:	38 d0                	cmp    %dl,%al
  1004dc:	0f 92 c0             	setb   %al
  1004df:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  1004e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004e6:	0f b6 00             	movzbl (%rax),%eax
  1004e9:	89 c1                	mov    %eax,%ecx
  1004eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004ef:	0f b6 00             	movzbl (%rax),%eax
  1004f2:	38 c1                	cmp    %al,%cl
  1004f4:	0f 92 c0             	setb   %al
  1004f7:	0f b6 c0             	movzbl %al,%eax
  1004fa:	29 c2                	sub    %eax,%edx
  1004fc:	89 d0                	mov    %edx,%eax
}
  1004fe:	c9                   	leave  
  1004ff:	c3                   	ret    

0000000000100500 <strchr>:

char* strchr(const char* s, int c) {
  100500:	55                   	push   %rbp
  100501:	48 89 e5             	mov    %rsp,%rbp
  100504:	48 83 ec 10          	sub    $0x10,%rsp
  100508:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  10050c:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  10050f:	eb 05                	jmp    100516 <strchr+0x16>
        ++s;
  100511:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100516:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10051a:	0f b6 00             	movzbl (%rax),%eax
  10051d:	84 c0                	test   %al,%al
  10051f:	74 0e                	je     10052f <strchr+0x2f>
  100521:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100525:	0f b6 00             	movzbl (%rax),%eax
  100528:	8b 55 f4             	mov    -0xc(%rbp),%edx
  10052b:	38 d0                	cmp    %dl,%al
  10052d:	75 e2                	jne    100511 <strchr+0x11>
    }
    if (*s == (char) c) {
  10052f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100533:	0f b6 00             	movzbl (%rax),%eax
  100536:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100539:	38 d0                	cmp    %dl,%al
  10053b:	75 06                	jne    100543 <strchr+0x43>
        return (char*) s;
  10053d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100541:	eb 05                	jmp    100548 <strchr+0x48>
    } else {
        return NULL;
  100543:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100548:	c9                   	leave  
  100549:	c3                   	ret    

000000000010054a <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  10054a:	55                   	push   %rbp
  10054b:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  10054e:	8b 05 c4 1a 00 00    	mov    0x1ac4(%rip),%eax        # 102018 <rand_seed_set>
  100554:	85 c0                	test   %eax,%eax
  100556:	75 0a                	jne    100562 <rand+0x18>
        srand(819234718U);
  100558:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  10055d:	e8 24 00 00 00       	call   100586 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100562:	8b 05 b4 1a 00 00    	mov    0x1ab4(%rip),%eax        # 10201c <rand_seed>
  100568:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  10056e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100573:	89 05 a3 1a 00 00    	mov    %eax,0x1aa3(%rip)        # 10201c <rand_seed>
    return rand_seed & RAND_MAX;
  100579:	8b 05 9d 1a 00 00    	mov    0x1a9d(%rip),%eax        # 10201c <rand_seed>
  10057f:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100584:	5d                   	pop    %rbp
  100585:	c3                   	ret    

0000000000100586 <srand>:

void srand(unsigned seed) {
  100586:	55                   	push   %rbp
  100587:	48 89 e5             	mov    %rsp,%rbp
  10058a:	48 83 ec 08          	sub    $0x8,%rsp
  10058e:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100591:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100594:	89 05 82 1a 00 00    	mov    %eax,0x1a82(%rip)        # 10201c <rand_seed>
    rand_seed_set = 1;
  10059a:	c7 05 74 1a 00 00 01 	movl   $0x1,0x1a74(%rip)        # 102018 <rand_seed_set>
  1005a1:	00 00 00 
}
  1005a4:	90                   	nop
  1005a5:	c9                   	leave  
  1005a6:	c3                   	ret    

00000000001005a7 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  1005a7:	55                   	push   %rbp
  1005a8:	48 89 e5             	mov    %rsp,%rbp
  1005ab:	48 83 ec 28          	sub    $0x28,%rsp
  1005af:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1005b3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1005b7:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  1005ba:	48 c7 45 f8 60 15 10 	movq   $0x101560,-0x8(%rbp)
  1005c1:	00 
    if (base < 0) {
  1005c2:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  1005c6:	79 0b                	jns    1005d3 <fill_numbuf+0x2c>
        digits = lower_digits;
  1005c8:	48 c7 45 f8 80 15 10 	movq   $0x101580,-0x8(%rbp)
  1005cf:	00 
        base = -base;
  1005d0:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  1005d3:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1005d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1005dc:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  1005df:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1005e2:	48 63 c8             	movslq %eax,%rcx
  1005e5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1005e9:	ba 00 00 00 00       	mov    $0x0,%edx
  1005ee:	48 f7 f1             	div    %rcx
  1005f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005f5:	48 01 d0             	add    %rdx,%rax
  1005f8:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1005fd:	0f b6 10             	movzbl (%rax),%edx
  100600:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100604:	88 10                	mov    %dl,(%rax)
        val /= base;
  100606:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100609:	48 63 f0             	movslq %eax,%rsi
  10060c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100610:	ba 00 00 00 00       	mov    $0x0,%edx
  100615:	48 f7 f6             	div    %rsi
  100618:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  10061c:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100621:	75 bc                	jne    1005df <fill_numbuf+0x38>
    return numbuf_end;
  100623:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100627:	c9                   	leave  
  100628:	c3                   	ret    

0000000000100629 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100629:	55                   	push   %rbp
  10062a:	48 89 e5             	mov    %rsp,%rbp
  10062d:	53                   	push   %rbx
  10062e:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100635:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  10063c:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100642:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100649:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100650:	e9 8a 09 00 00       	jmp    100fdf <printer_vprintf+0x9b6>
        if (*format != '%') {
  100655:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10065c:	0f b6 00             	movzbl (%rax),%eax
  10065f:	3c 25                	cmp    $0x25,%al
  100661:	74 31                	je     100694 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  100663:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10066a:	4c 8b 00             	mov    (%rax),%r8
  10066d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100674:	0f b6 00             	movzbl (%rax),%eax
  100677:	0f b6 c8             	movzbl %al,%ecx
  10067a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100680:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100687:	89 ce                	mov    %ecx,%esi
  100689:	48 89 c7             	mov    %rax,%rdi
  10068c:	41 ff d0             	call   *%r8
            continue;
  10068f:	e9 43 09 00 00       	jmp    100fd7 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100694:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  10069b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1006a2:	01 
  1006a3:	eb 44                	jmp    1006e9 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  1006a5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006ac:	0f b6 00             	movzbl (%rax),%eax
  1006af:	0f be c0             	movsbl %al,%eax
  1006b2:	89 c6                	mov    %eax,%esi
  1006b4:	bf 80 13 10 00       	mov    $0x101380,%edi
  1006b9:	e8 42 fe ff ff       	call   100500 <strchr>
  1006be:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  1006c2:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  1006c7:	74 30                	je     1006f9 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  1006c9:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  1006cd:	48 2d 80 13 10 00    	sub    $0x101380,%rax
  1006d3:	ba 01 00 00 00       	mov    $0x1,%edx
  1006d8:	89 c1                	mov    %eax,%ecx
  1006da:	d3 e2                	shl    %cl,%edx
  1006dc:	89 d0                	mov    %edx,%eax
  1006de:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  1006e1:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1006e8:	01 
  1006e9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006f0:	0f b6 00             	movzbl (%rax),%eax
  1006f3:	84 c0                	test   %al,%al
  1006f5:	75 ae                	jne    1006a5 <printer_vprintf+0x7c>
  1006f7:	eb 01                	jmp    1006fa <printer_vprintf+0xd1>
            } else {
                break;
  1006f9:	90                   	nop
            }
        }

        // process width
        int width = -1;
  1006fa:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100701:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100708:	0f b6 00             	movzbl (%rax),%eax
  10070b:	3c 30                	cmp    $0x30,%al
  10070d:	7e 67                	jle    100776 <printer_vprintf+0x14d>
  10070f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100716:	0f b6 00             	movzbl (%rax),%eax
  100719:	3c 39                	cmp    $0x39,%al
  10071b:	7f 59                	jg     100776 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10071d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100724:	eb 2e                	jmp    100754 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100726:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100729:	89 d0                	mov    %edx,%eax
  10072b:	c1 e0 02             	shl    $0x2,%eax
  10072e:	01 d0                	add    %edx,%eax
  100730:	01 c0                	add    %eax,%eax
  100732:	89 c1                	mov    %eax,%ecx
  100734:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10073b:	48 8d 50 01          	lea    0x1(%rax),%rdx
  10073f:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100746:	0f b6 00             	movzbl (%rax),%eax
  100749:	0f be c0             	movsbl %al,%eax
  10074c:	01 c8                	add    %ecx,%eax
  10074e:	83 e8 30             	sub    $0x30,%eax
  100751:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100754:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10075b:	0f b6 00             	movzbl (%rax),%eax
  10075e:	3c 2f                	cmp    $0x2f,%al
  100760:	0f 8e 85 00 00 00    	jle    1007eb <printer_vprintf+0x1c2>
  100766:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10076d:	0f b6 00             	movzbl (%rax),%eax
  100770:	3c 39                	cmp    $0x39,%al
  100772:	7e b2                	jle    100726 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100774:	eb 75                	jmp    1007eb <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100776:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10077d:	0f b6 00             	movzbl (%rax),%eax
  100780:	3c 2a                	cmp    $0x2a,%al
  100782:	75 68                	jne    1007ec <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100784:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10078b:	8b 00                	mov    (%rax),%eax
  10078d:	83 f8 2f             	cmp    $0x2f,%eax
  100790:	77 30                	ja     1007c2 <printer_vprintf+0x199>
  100792:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100799:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10079d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007a4:	8b 00                	mov    (%rax),%eax
  1007a6:	89 c0                	mov    %eax,%eax
  1007a8:	48 01 d0             	add    %rdx,%rax
  1007ab:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007b2:	8b 12                	mov    (%rdx),%edx
  1007b4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1007b7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007be:	89 0a                	mov    %ecx,(%rdx)
  1007c0:	eb 1a                	jmp    1007dc <printer_vprintf+0x1b3>
  1007c2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007c9:	48 8b 40 08          	mov    0x8(%rax),%rax
  1007cd:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1007d1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007d8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1007dc:	8b 00                	mov    (%rax),%eax
  1007de:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  1007e1:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1007e8:	01 
  1007e9:	eb 01                	jmp    1007ec <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  1007eb:	90                   	nop
        }

        // process precision
        int precision = -1;
  1007ec:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  1007f3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007fa:	0f b6 00             	movzbl (%rax),%eax
  1007fd:	3c 2e                	cmp    $0x2e,%al
  1007ff:	0f 85 00 01 00 00    	jne    100905 <printer_vprintf+0x2dc>
            ++format;
  100805:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10080c:	01 
            if (*format >= '0' && *format <= '9') {
  10080d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100814:	0f b6 00             	movzbl (%rax),%eax
  100817:	3c 2f                	cmp    $0x2f,%al
  100819:	7e 67                	jle    100882 <printer_vprintf+0x259>
  10081b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100822:	0f b6 00             	movzbl (%rax),%eax
  100825:	3c 39                	cmp    $0x39,%al
  100827:	7f 59                	jg     100882 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100829:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100830:	eb 2e                	jmp    100860 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100832:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100835:	89 d0                	mov    %edx,%eax
  100837:	c1 e0 02             	shl    $0x2,%eax
  10083a:	01 d0                	add    %edx,%eax
  10083c:	01 c0                	add    %eax,%eax
  10083e:	89 c1                	mov    %eax,%ecx
  100840:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100847:	48 8d 50 01          	lea    0x1(%rax),%rdx
  10084b:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100852:	0f b6 00             	movzbl (%rax),%eax
  100855:	0f be c0             	movsbl %al,%eax
  100858:	01 c8                	add    %ecx,%eax
  10085a:	83 e8 30             	sub    $0x30,%eax
  10085d:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100860:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100867:	0f b6 00             	movzbl (%rax),%eax
  10086a:	3c 2f                	cmp    $0x2f,%al
  10086c:	0f 8e 85 00 00 00    	jle    1008f7 <printer_vprintf+0x2ce>
  100872:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100879:	0f b6 00             	movzbl (%rax),%eax
  10087c:	3c 39                	cmp    $0x39,%al
  10087e:	7e b2                	jle    100832 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100880:	eb 75                	jmp    1008f7 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100882:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100889:	0f b6 00             	movzbl (%rax),%eax
  10088c:	3c 2a                	cmp    $0x2a,%al
  10088e:	75 68                	jne    1008f8 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100890:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100897:	8b 00                	mov    (%rax),%eax
  100899:	83 f8 2f             	cmp    $0x2f,%eax
  10089c:	77 30                	ja     1008ce <printer_vprintf+0x2a5>
  10089e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008a5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1008a9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008b0:	8b 00                	mov    (%rax),%eax
  1008b2:	89 c0                	mov    %eax,%eax
  1008b4:	48 01 d0             	add    %rdx,%rax
  1008b7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008be:	8b 12                	mov    (%rdx),%edx
  1008c0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1008c3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008ca:	89 0a                	mov    %ecx,(%rdx)
  1008cc:	eb 1a                	jmp    1008e8 <printer_vprintf+0x2bf>
  1008ce:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008d5:	48 8b 40 08          	mov    0x8(%rax),%rax
  1008d9:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1008dd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008e4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1008e8:	8b 00                	mov    (%rax),%eax
  1008ea:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  1008ed:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1008f4:	01 
  1008f5:	eb 01                	jmp    1008f8 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  1008f7:	90                   	nop
            }
            if (precision < 0) {
  1008f8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1008fc:	79 07                	jns    100905 <printer_vprintf+0x2dc>
                precision = 0;
  1008fe:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100905:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  10090c:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100913:	00 
        int length = 0;
  100914:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  10091b:	48 c7 45 c8 86 13 10 	movq   $0x101386,-0x38(%rbp)
  100922:	00 
    again:
        switch (*format) {
  100923:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10092a:	0f b6 00             	movzbl (%rax),%eax
  10092d:	0f be c0             	movsbl %al,%eax
  100930:	83 e8 43             	sub    $0x43,%eax
  100933:	83 f8 37             	cmp    $0x37,%eax
  100936:	0f 87 9f 03 00 00    	ja     100cdb <printer_vprintf+0x6b2>
  10093c:	89 c0                	mov    %eax,%eax
  10093e:	48 8b 04 c5 98 13 10 	mov    0x101398(,%rax,8),%rax
  100945:	00 
  100946:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100948:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  10094f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100956:	01 
            goto again;
  100957:	eb ca                	jmp    100923 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100959:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  10095d:	74 5d                	je     1009bc <printer_vprintf+0x393>
  10095f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100966:	8b 00                	mov    (%rax),%eax
  100968:	83 f8 2f             	cmp    $0x2f,%eax
  10096b:	77 30                	ja     10099d <printer_vprintf+0x374>
  10096d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100974:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100978:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10097f:	8b 00                	mov    (%rax),%eax
  100981:	89 c0                	mov    %eax,%eax
  100983:	48 01 d0             	add    %rdx,%rax
  100986:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10098d:	8b 12                	mov    (%rdx),%edx
  10098f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100992:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100999:	89 0a                	mov    %ecx,(%rdx)
  10099b:	eb 1a                	jmp    1009b7 <printer_vprintf+0x38e>
  10099d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009a4:	48 8b 40 08          	mov    0x8(%rax),%rax
  1009a8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1009ac:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009b3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1009b7:	48 8b 00             	mov    (%rax),%rax
  1009ba:	eb 5c                	jmp    100a18 <printer_vprintf+0x3ef>
  1009bc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009c3:	8b 00                	mov    (%rax),%eax
  1009c5:	83 f8 2f             	cmp    $0x2f,%eax
  1009c8:	77 30                	ja     1009fa <printer_vprintf+0x3d1>
  1009ca:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009d1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1009d5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009dc:	8b 00                	mov    (%rax),%eax
  1009de:	89 c0                	mov    %eax,%eax
  1009e0:	48 01 d0             	add    %rdx,%rax
  1009e3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009ea:	8b 12                	mov    (%rdx),%edx
  1009ec:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1009ef:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009f6:	89 0a                	mov    %ecx,(%rdx)
  1009f8:	eb 1a                	jmp    100a14 <printer_vprintf+0x3eb>
  1009fa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a01:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a05:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a09:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a10:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a14:	8b 00                	mov    (%rax),%eax
  100a16:	48 98                	cltq   
  100a18:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100a1c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a20:	48 c1 f8 38          	sar    $0x38,%rax
  100a24:	25 80 00 00 00       	and    $0x80,%eax
  100a29:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100a2c:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100a30:	74 09                	je     100a3b <printer_vprintf+0x412>
  100a32:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a36:	48 f7 d8             	neg    %rax
  100a39:	eb 04                	jmp    100a3f <printer_vprintf+0x416>
  100a3b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a3f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100a43:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100a46:	83 c8 60             	or     $0x60,%eax
  100a49:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100a4c:	e9 cf 02 00 00       	jmp    100d20 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100a51:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100a55:	74 5d                	je     100ab4 <printer_vprintf+0x48b>
  100a57:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a5e:	8b 00                	mov    (%rax),%eax
  100a60:	83 f8 2f             	cmp    $0x2f,%eax
  100a63:	77 30                	ja     100a95 <printer_vprintf+0x46c>
  100a65:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a6c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a70:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a77:	8b 00                	mov    (%rax),%eax
  100a79:	89 c0                	mov    %eax,%eax
  100a7b:	48 01 d0             	add    %rdx,%rax
  100a7e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a85:	8b 12                	mov    (%rdx),%edx
  100a87:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a8a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a91:	89 0a                	mov    %ecx,(%rdx)
  100a93:	eb 1a                	jmp    100aaf <printer_vprintf+0x486>
  100a95:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a9c:	48 8b 40 08          	mov    0x8(%rax),%rax
  100aa0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100aa4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aab:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100aaf:	48 8b 00             	mov    (%rax),%rax
  100ab2:	eb 5c                	jmp    100b10 <printer_vprintf+0x4e7>
  100ab4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100abb:	8b 00                	mov    (%rax),%eax
  100abd:	83 f8 2f             	cmp    $0x2f,%eax
  100ac0:	77 30                	ja     100af2 <printer_vprintf+0x4c9>
  100ac2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ac9:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100acd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ad4:	8b 00                	mov    (%rax),%eax
  100ad6:	89 c0                	mov    %eax,%eax
  100ad8:	48 01 d0             	add    %rdx,%rax
  100adb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ae2:	8b 12                	mov    (%rdx),%edx
  100ae4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ae7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aee:	89 0a                	mov    %ecx,(%rdx)
  100af0:	eb 1a                	jmp    100b0c <printer_vprintf+0x4e3>
  100af2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100af9:	48 8b 40 08          	mov    0x8(%rax),%rax
  100afd:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b01:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b08:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b0c:	8b 00                	mov    (%rax),%eax
  100b0e:	89 c0                	mov    %eax,%eax
  100b10:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100b14:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100b18:	e9 03 02 00 00       	jmp    100d20 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100b1d:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100b24:	e9 28 ff ff ff       	jmp    100a51 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100b29:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100b30:	e9 1c ff ff ff       	jmp    100a51 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100b35:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b3c:	8b 00                	mov    (%rax),%eax
  100b3e:	83 f8 2f             	cmp    $0x2f,%eax
  100b41:	77 30                	ja     100b73 <printer_vprintf+0x54a>
  100b43:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b4a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b4e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b55:	8b 00                	mov    (%rax),%eax
  100b57:	89 c0                	mov    %eax,%eax
  100b59:	48 01 d0             	add    %rdx,%rax
  100b5c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b63:	8b 12                	mov    (%rdx),%edx
  100b65:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b68:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b6f:	89 0a                	mov    %ecx,(%rdx)
  100b71:	eb 1a                	jmp    100b8d <printer_vprintf+0x564>
  100b73:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b7a:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b7e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b82:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b89:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b8d:	48 8b 00             	mov    (%rax),%rax
  100b90:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100b94:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100b9b:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100ba2:	e9 79 01 00 00       	jmp    100d20 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100ba7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bae:	8b 00                	mov    (%rax),%eax
  100bb0:	83 f8 2f             	cmp    $0x2f,%eax
  100bb3:	77 30                	ja     100be5 <printer_vprintf+0x5bc>
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
  100be3:	eb 1a                	jmp    100bff <printer_vprintf+0x5d6>
  100be5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bec:	48 8b 40 08          	mov    0x8(%rax),%rax
  100bf0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100bf4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bfb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100bff:	48 8b 00             	mov    (%rax),%rax
  100c02:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100c06:	e9 15 01 00 00       	jmp    100d20 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100c0b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c12:	8b 00                	mov    (%rax),%eax
  100c14:	83 f8 2f             	cmp    $0x2f,%eax
  100c17:	77 30                	ja     100c49 <printer_vprintf+0x620>
  100c19:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c20:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c24:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c2b:	8b 00                	mov    (%rax),%eax
  100c2d:	89 c0                	mov    %eax,%eax
  100c2f:	48 01 d0             	add    %rdx,%rax
  100c32:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c39:	8b 12                	mov    (%rdx),%edx
  100c3b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c3e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c45:	89 0a                	mov    %ecx,(%rdx)
  100c47:	eb 1a                	jmp    100c63 <printer_vprintf+0x63a>
  100c49:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c50:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c54:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c58:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c5f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c63:	8b 00                	mov    (%rax),%eax
  100c65:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100c6b:	e9 67 03 00 00       	jmp    100fd7 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  100c70:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100c74:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100c78:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c7f:	8b 00                	mov    (%rax),%eax
  100c81:	83 f8 2f             	cmp    $0x2f,%eax
  100c84:	77 30                	ja     100cb6 <printer_vprintf+0x68d>
  100c86:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c8d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c91:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c98:	8b 00                	mov    (%rax),%eax
  100c9a:	89 c0                	mov    %eax,%eax
  100c9c:	48 01 d0             	add    %rdx,%rax
  100c9f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ca6:	8b 12                	mov    (%rdx),%edx
  100ca8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100cab:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cb2:	89 0a                	mov    %ecx,(%rdx)
  100cb4:	eb 1a                	jmp    100cd0 <printer_vprintf+0x6a7>
  100cb6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cbd:	48 8b 40 08          	mov    0x8(%rax),%rax
  100cc1:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100cc5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ccc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100cd0:	8b 00                	mov    (%rax),%eax
  100cd2:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100cd5:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100cd9:	eb 45                	jmp    100d20 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  100cdb:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100cdf:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100ce3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100cea:	0f b6 00             	movzbl (%rax),%eax
  100ced:	84 c0                	test   %al,%al
  100cef:	74 0c                	je     100cfd <printer_vprintf+0x6d4>
  100cf1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100cf8:	0f b6 00             	movzbl (%rax),%eax
  100cfb:	eb 05                	jmp    100d02 <printer_vprintf+0x6d9>
  100cfd:	b8 25 00 00 00       	mov    $0x25,%eax
  100d02:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100d05:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100d09:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d10:	0f b6 00             	movzbl (%rax),%eax
  100d13:	84 c0                	test   %al,%al
  100d15:	75 08                	jne    100d1f <printer_vprintf+0x6f6>
                format--;
  100d17:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100d1e:	01 
            }
            break;
  100d1f:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100d20:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d23:	83 e0 20             	and    $0x20,%eax
  100d26:	85 c0                	test   %eax,%eax
  100d28:	74 1e                	je     100d48 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100d2a:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d2e:	48 83 c0 18          	add    $0x18,%rax
  100d32:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100d35:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100d39:	48 89 ce             	mov    %rcx,%rsi
  100d3c:	48 89 c7             	mov    %rax,%rdi
  100d3f:	e8 63 f8 ff ff       	call   1005a7 <fill_numbuf>
  100d44:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100d48:	48 c7 45 c0 86 13 10 	movq   $0x101386,-0x40(%rbp)
  100d4f:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100d50:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d53:	83 e0 20             	and    $0x20,%eax
  100d56:	85 c0                	test   %eax,%eax
  100d58:	74 48                	je     100da2 <printer_vprintf+0x779>
  100d5a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d5d:	83 e0 40             	and    $0x40,%eax
  100d60:	85 c0                	test   %eax,%eax
  100d62:	74 3e                	je     100da2 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  100d64:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d67:	25 80 00 00 00       	and    $0x80,%eax
  100d6c:	85 c0                	test   %eax,%eax
  100d6e:	74 0a                	je     100d7a <printer_vprintf+0x751>
                prefix = "-";
  100d70:	48 c7 45 c0 87 13 10 	movq   $0x101387,-0x40(%rbp)
  100d77:	00 
            if (flags & FLAG_NEGATIVE) {
  100d78:	eb 73                	jmp    100ded <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100d7a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d7d:	83 e0 10             	and    $0x10,%eax
  100d80:	85 c0                	test   %eax,%eax
  100d82:	74 0a                	je     100d8e <printer_vprintf+0x765>
                prefix = "+";
  100d84:	48 c7 45 c0 89 13 10 	movq   $0x101389,-0x40(%rbp)
  100d8b:	00 
            if (flags & FLAG_NEGATIVE) {
  100d8c:	eb 5f                	jmp    100ded <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100d8e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d91:	83 e0 08             	and    $0x8,%eax
  100d94:	85 c0                	test   %eax,%eax
  100d96:	74 55                	je     100ded <printer_vprintf+0x7c4>
                prefix = " ";
  100d98:	48 c7 45 c0 8b 13 10 	movq   $0x10138b,-0x40(%rbp)
  100d9f:	00 
            if (flags & FLAG_NEGATIVE) {
  100da0:	eb 4b                	jmp    100ded <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100da2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100da5:	83 e0 20             	and    $0x20,%eax
  100da8:	85 c0                	test   %eax,%eax
  100daa:	74 42                	je     100dee <printer_vprintf+0x7c5>
  100dac:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100daf:	83 e0 01             	and    $0x1,%eax
  100db2:	85 c0                	test   %eax,%eax
  100db4:	74 38                	je     100dee <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  100db6:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100dba:	74 06                	je     100dc2 <printer_vprintf+0x799>
  100dbc:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100dc0:	75 2c                	jne    100dee <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  100dc2:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100dc7:	75 0c                	jne    100dd5 <printer_vprintf+0x7ac>
  100dc9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dcc:	25 00 01 00 00       	and    $0x100,%eax
  100dd1:	85 c0                	test   %eax,%eax
  100dd3:	74 19                	je     100dee <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  100dd5:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100dd9:	75 07                	jne    100de2 <printer_vprintf+0x7b9>
  100ddb:	b8 8d 13 10 00       	mov    $0x10138d,%eax
  100de0:	eb 05                	jmp    100de7 <printer_vprintf+0x7be>
  100de2:	b8 90 13 10 00       	mov    $0x101390,%eax
  100de7:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100deb:	eb 01                	jmp    100dee <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  100ded:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100dee:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100df2:	78 24                	js     100e18 <printer_vprintf+0x7ef>
  100df4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100df7:	83 e0 20             	and    $0x20,%eax
  100dfa:	85 c0                	test   %eax,%eax
  100dfc:	75 1a                	jne    100e18 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  100dfe:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100e01:	48 63 d0             	movslq %eax,%rdx
  100e04:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100e08:	48 89 d6             	mov    %rdx,%rsi
  100e0b:	48 89 c7             	mov    %rax,%rdi
  100e0e:	e8 ea f5 ff ff       	call   1003fd <strnlen>
  100e13:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100e16:	eb 0f                	jmp    100e27 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  100e18:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100e1c:	48 89 c7             	mov    %rax,%rdi
  100e1f:	e8 a8 f5 ff ff       	call   1003cc <strlen>
  100e24:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100e27:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e2a:	83 e0 20             	and    $0x20,%eax
  100e2d:	85 c0                	test   %eax,%eax
  100e2f:	74 20                	je     100e51 <printer_vprintf+0x828>
  100e31:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100e35:	78 1a                	js     100e51 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  100e37:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100e3a:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100e3d:	7e 08                	jle    100e47 <printer_vprintf+0x81e>
  100e3f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100e42:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100e45:	eb 05                	jmp    100e4c <printer_vprintf+0x823>
  100e47:	b8 00 00 00 00       	mov    $0x0,%eax
  100e4c:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100e4f:	eb 5c                	jmp    100ead <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100e51:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e54:	83 e0 20             	and    $0x20,%eax
  100e57:	85 c0                	test   %eax,%eax
  100e59:	74 4b                	je     100ea6 <printer_vprintf+0x87d>
  100e5b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e5e:	83 e0 02             	and    $0x2,%eax
  100e61:	85 c0                	test   %eax,%eax
  100e63:	74 41                	je     100ea6 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100e65:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e68:	83 e0 04             	and    $0x4,%eax
  100e6b:	85 c0                	test   %eax,%eax
  100e6d:	75 37                	jne    100ea6 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  100e6f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e73:	48 89 c7             	mov    %rax,%rdi
  100e76:	e8 51 f5 ff ff       	call   1003cc <strlen>
  100e7b:	89 c2                	mov    %eax,%edx
  100e7d:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100e80:	01 d0                	add    %edx,%eax
  100e82:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100e85:	7e 1f                	jle    100ea6 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  100e87:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100e8a:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100e8d:	89 c3                	mov    %eax,%ebx
  100e8f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e93:	48 89 c7             	mov    %rax,%rdi
  100e96:	e8 31 f5 ff ff       	call   1003cc <strlen>
  100e9b:	89 c2                	mov    %eax,%edx
  100e9d:	89 d8                	mov    %ebx,%eax
  100e9f:	29 d0                	sub    %edx,%eax
  100ea1:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100ea4:	eb 07                	jmp    100ead <printer_vprintf+0x884>
        } else {
            zeros = 0;
  100ea6:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100ead:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100eb0:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100eb3:	01 d0                	add    %edx,%eax
  100eb5:	48 63 d8             	movslq %eax,%rbx
  100eb8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100ebc:	48 89 c7             	mov    %rax,%rdi
  100ebf:	e8 08 f5 ff ff       	call   1003cc <strlen>
  100ec4:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100ec8:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100ecb:	29 d0                	sub    %edx,%eax
  100ecd:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100ed0:	eb 25                	jmp    100ef7 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  100ed2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ed9:	48 8b 08             	mov    (%rax),%rcx
  100edc:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100ee2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ee9:	be 20 00 00 00       	mov    $0x20,%esi
  100eee:	48 89 c7             	mov    %rax,%rdi
  100ef1:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100ef3:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100ef7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100efa:	83 e0 04             	and    $0x4,%eax
  100efd:	85 c0                	test   %eax,%eax
  100eff:	75 36                	jne    100f37 <printer_vprintf+0x90e>
  100f01:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100f05:	7f cb                	jg     100ed2 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  100f07:	eb 2e                	jmp    100f37 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  100f09:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f10:	4c 8b 00             	mov    (%rax),%r8
  100f13:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f17:	0f b6 00             	movzbl (%rax),%eax
  100f1a:	0f b6 c8             	movzbl %al,%ecx
  100f1d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f23:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f2a:	89 ce                	mov    %ecx,%esi
  100f2c:	48 89 c7             	mov    %rax,%rdi
  100f2f:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  100f32:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  100f37:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f3b:	0f b6 00             	movzbl (%rax),%eax
  100f3e:	84 c0                	test   %al,%al
  100f40:	75 c7                	jne    100f09 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  100f42:	eb 25                	jmp    100f69 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  100f44:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f4b:	48 8b 08             	mov    (%rax),%rcx
  100f4e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f54:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f5b:	be 30 00 00 00       	mov    $0x30,%esi
  100f60:	48 89 c7             	mov    %rax,%rdi
  100f63:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  100f65:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  100f69:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  100f6d:	7f d5                	jg     100f44 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  100f6f:	eb 32                	jmp    100fa3 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  100f71:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f78:	4c 8b 00             	mov    (%rax),%r8
  100f7b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100f7f:	0f b6 00             	movzbl (%rax),%eax
  100f82:	0f b6 c8             	movzbl %al,%ecx
  100f85:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f8b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f92:	89 ce                	mov    %ecx,%esi
  100f94:	48 89 c7             	mov    %rax,%rdi
  100f97:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  100f9a:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  100f9f:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  100fa3:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  100fa7:	7f c8                	jg     100f71 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  100fa9:	eb 25                	jmp    100fd0 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  100fab:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fb2:	48 8b 08             	mov    (%rax),%rcx
  100fb5:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100fbb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fc2:	be 20 00 00 00       	mov    $0x20,%esi
  100fc7:	48 89 c7             	mov    %rax,%rdi
  100fca:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  100fcc:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100fd0:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100fd4:	7f d5                	jg     100fab <printer_vprintf+0x982>
        }
    done: ;
  100fd6:	90                   	nop
    for (; *format; ++format) {
  100fd7:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100fde:	01 
  100fdf:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100fe6:	0f b6 00             	movzbl (%rax),%eax
  100fe9:	84 c0                	test   %al,%al
  100feb:	0f 85 64 f6 ff ff    	jne    100655 <printer_vprintf+0x2c>
    }
}
  100ff1:	90                   	nop
  100ff2:	90                   	nop
  100ff3:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100ff7:	c9                   	leave  
  100ff8:	c3                   	ret    

0000000000100ff9 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100ff9:	55                   	push   %rbp
  100ffa:	48 89 e5             	mov    %rsp,%rbp
  100ffd:	48 83 ec 20          	sub    $0x20,%rsp
  101001:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101005:	89 f0                	mov    %esi,%eax
  101007:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10100a:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  10100d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101011:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101015:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101019:	48 8b 40 08          	mov    0x8(%rax),%rax
  10101d:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  101022:	48 39 d0             	cmp    %rdx,%rax
  101025:	72 0c                	jb     101033 <console_putc+0x3a>
        cp->cursor = console;
  101027:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10102b:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  101032:	00 
    }
    if (c == '\n') {
  101033:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  101037:	75 78                	jne    1010b1 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  101039:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10103d:	48 8b 40 08          	mov    0x8(%rax),%rax
  101041:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  101047:	48 d1 f8             	sar    %rax
  10104a:	48 89 c1             	mov    %rax,%rcx
  10104d:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  101054:	66 66 66 
  101057:	48 89 c8             	mov    %rcx,%rax
  10105a:	48 f7 ea             	imul   %rdx
  10105d:	48 c1 fa 05          	sar    $0x5,%rdx
  101061:	48 89 c8             	mov    %rcx,%rax
  101064:	48 c1 f8 3f          	sar    $0x3f,%rax
  101068:	48 29 c2             	sub    %rax,%rdx
  10106b:	48 89 d0             	mov    %rdx,%rax
  10106e:	48 c1 e0 02          	shl    $0x2,%rax
  101072:	48 01 d0             	add    %rdx,%rax
  101075:	48 c1 e0 04          	shl    $0x4,%rax
  101079:	48 29 c1             	sub    %rax,%rcx
  10107c:	48 89 ca             	mov    %rcx,%rdx
  10107f:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101082:	eb 25                	jmp    1010a9 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  101084:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101087:	83 c8 20             	or     $0x20,%eax
  10108a:	89 c6                	mov    %eax,%esi
  10108c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101090:	48 8b 40 08          	mov    0x8(%rax),%rax
  101094:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101098:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  10109c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1010a0:	89 f2                	mov    %esi,%edx
  1010a2:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  1010a5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1010a9:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  1010ad:	75 d5                	jne    101084 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  1010af:	eb 24                	jmp    1010d5 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  1010b1:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  1010b5:	8b 55 e0             	mov    -0x20(%rbp),%edx
  1010b8:	09 d0                	or     %edx,%eax
  1010ba:	89 c6                	mov    %eax,%esi
  1010bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010c0:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010c4:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1010c8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1010cc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1010d0:	89 f2                	mov    %esi,%edx
  1010d2:	66 89 10             	mov    %dx,(%rax)
}
  1010d5:	90                   	nop
  1010d6:	c9                   	leave  
  1010d7:	c3                   	ret    

00000000001010d8 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1010d8:	55                   	push   %rbp
  1010d9:	48 89 e5             	mov    %rsp,%rbp
  1010dc:	48 83 ec 30          	sub    $0x30,%rsp
  1010e0:	89 7d ec             	mov    %edi,-0x14(%rbp)
  1010e3:	89 75 e8             	mov    %esi,-0x18(%rbp)
  1010e6:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1010ea:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  1010ee:	48 c7 45 f0 f9 0f 10 	movq   $0x100ff9,-0x10(%rbp)
  1010f5:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1010f6:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  1010fa:	78 09                	js     101105 <console_vprintf+0x2d>
  1010fc:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101103:	7e 07                	jle    10110c <console_vprintf+0x34>
        cpos = 0;
  101105:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  10110c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10110f:	48 98                	cltq   
  101111:	48 01 c0             	add    %rax,%rax
  101114:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  10111a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  10111e:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101122:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  101126:	8b 75 e8             	mov    -0x18(%rbp),%esi
  101129:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  10112d:	48 89 c7             	mov    %rax,%rdi
  101130:	e8 f4 f4 ff ff       	call   100629 <printer_vprintf>
    return cp.cursor - console;
  101135:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101139:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  10113f:	48 d1 f8             	sar    %rax
}
  101142:	c9                   	leave  
  101143:	c3                   	ret    

0000000000101144 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  101144:	55                   	push   %rbp
  101145:	48 89 e5             	mov    %rsp,%rbp
  101148:	48 83 ec 60          	sub    $0x60,%rsp
  10114c:	89 7d ac             	mov    %edi,-0x54(%rbp)
  10114f:	89 75 a8             	mov    %esi,-0x58(%rbp)
  101152:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  101156:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10115a:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10115e:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101162:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101169:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10116d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101171:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101175:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101179:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  10117d:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101181:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101184:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101187:	89 c7                	mov    %eax,%edi
  101189:	e8 4a ff ff ff       	call   1010d8 <console_vprintf>
  10118e:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101191:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101194:	c9                   	leave  
  101195:	c3                   	ret    

0000000000101196 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101196:	55                   	push   %rbp
  101197:	48 89 e5             	mov    %rsp,%rbp
  10119a:	48 83 ec 20          	sub    $0x20,%rsp
  10119e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1011a2:	89 f0                	mov    %esi,%eax
  1011a4:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1011a7:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  1011aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1011ae:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  1011b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1011b6:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1011ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1011be:	48 8b 40 10          	mov    0x10(%rax),%rax
  1011c2:	48 39 c2             	cmp    %rax,%rdx
  1011c5:	73 1a                	jae    1011e1 <string_putc+0x4b>
        *sp->s++ = c;
  1011c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1011cb:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011cf:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1011d3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1011d7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1011db:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1011df:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1011e1:	90                   	nop
  1011e2:	c9                   	leave  
  1011e3:	c3                   	ret    

00000000001011e4 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1011e4:	55                   	push   %rbp
  1011e5:	48 89 e5             	mov    %rsp,%rbp
  1011e8:	48 83 ec 40          	sub    $0x40,%rsp
  1011ec:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  1011f0:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  1011f4:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  1011f8:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1011fc:	48 c7 45 e8 96 11 10 	movq   $0x101196,-0x18(%rbp)
  101203:	00 
    sp.s = s;
  101204:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101208:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  10120c:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  101211:	74 33                	je     101246 <vsnprintf+0x62>
        sp.end = s + size - 1;
  101213:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101217:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10121b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10121f:	48 01 d0             	add    %rdx,%rax
  101222:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101226:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  10122a:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  10122e:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101232:	be 00 00 00 00       	mov    $0x0,%esi
  101237:	48 89 c7             	mov    %rax,%rdi
  10123a:	e8 ea f3 ff ff       	call   100629 <printer_vprintf>
        *sp.s = 0;
  10123f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101243:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  101246:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10124a:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  10124e:	c9                   	leave  
  10124f:	c3                   	ret    

0000000000101250 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  101250:	55                   	push   %rbp
  101251:	48 89 e5             	mov    %rsp,%rbp
  101254:	48 83 ec 70          	sub    $0x70,%rsp
  101258:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  10125c:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  101260:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101264:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101268:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10126c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101270:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101277:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10127b:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  10127f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101283:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101287:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  10128b:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  10128f:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101293:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101297:	48 89 c7             	mov    %rax,%rdi
  10129a:	e8 45 ff ff ff       	call   1011e4 <vsnprintf>
  10129f:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  1012a2:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  1012a5:	c9                   	leave  
  1012a6:	c3                   	ret    

00000000001012a7 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  1012a7:	55                   	push   %rbp
  1012a8:	48 89 e5             	mov    %rsp,%rbp
  1012ab:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1012af:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  1012b6:	eb 13                	jmp    1012cb <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  1012b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1012bb:	48 98                	cltq   
  1012bd:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  1012c4:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1012c7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1012cb:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1012d2:	7e e4                	jle    1012b8 <console_clear+0x11>
    }
    cursorpos = 0;
  1012d4:	c7 05 1e 7d fb ff 00 	movl   $0x0,-0x482e2(%rip)        # b8ffc <cursorpos>
  1012db:	00 00 00 
}
  1012de:	90                   	nop
  1012df:	c9                   	leave  
  1012e0:	c3                   	ret    
