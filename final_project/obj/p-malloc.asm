
obj/p-malloc.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	53                   	push   %rbx
  100005:	48 83 ec 08          	sub    $0x8,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100009:	cd 31                	int    $0x31
  10000b:	89 c3                	mov    %eax,%ebx
    pid_t p = getpid();

    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10000d:	b8 17 30 10 00       	mov    $0x103017,%eax
  100012:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100018:	48 89 05 e9 1f 00 00 	mov    %rax,0x1fe9(%rip)        # 102008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10001f:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100022:	48 83 e8 01          	sub    $0x1,%rax
  100026:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10002c:	48 89 05 cd 1f 00 00 	mov    %rax,0x1fcd(%rip)        # 102000 <stack_bottom>
  100033:	eb 02                	jmp    100037 <process_main+0x37>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  100035:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
	if ((rand() % ALLOC_SLOWDOWN) < p) {
  100037:	e8 0a 03 00 00       	call   100346 <rand>
  10003c:	48 63 d0             	movslq %eax,%rdx
  10003f:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  100046:	48 c1 fa 25          	sar    $0x25,%rdx
  10004a:	89 c1                	mov    %eax,%ecx
  10004c:	c1 f9 1f             	sar    $0x1f,%ecx
  10004f:	29 ca                	sub    %ecx,%edx
  100051:	6b d2 64             	imul   $0x64,%edx,%edx
  100054:	29 d0                	sub    %edx,%eax
  100056:	39 d8                	cmp    %ebx,%eax
  100058:	7d db                	jge    100035 <process_main+0x35>
	    void * ret = malloc(PAGESIZE);
  10005a:	bf 00 10 00 00       	mov    $0x1000,%edi
  10005f:	e8 0e 00 00 00       	call   100072 <malloc>
	    if(ret == NULL)
  100064:	48 85 c0             	test   %rax,%rax
  100067:	74 04                	je     10006d <process_main+0x6d>
		break;
	    *((int*)ret) = p;       // check we have write access
  100069:	89 18                	mov    %ebx,(%rax)
  10006b:	eb c8                	jmp    100035 <process_main+0x35>
  10006d:	cd 32                	int    $0x32
  10006f:	eb fc                	jmp    10006d <process_main+0x6d>

0000000000100071 <free>:
#include "malloc.h"

void free(void *firstbyte) {
    return;
}
  100071:	c3                   	ret    

0000000000100072 <malloc>:

void *malloc(uint64_t numbytes) {
    return 0 ;
}
  100072:	b8 00 00 00 00       	mov    $0x0,%eax
  100077:	c3                   	ret    

0000000000100078 <calloc>:


void * calloc(uint64_t num, uint64_t sz) {
    return 0;
}
  100078:	b8 00 00 00 00       	mov    $0x0,%eax
  10007d:	c3                   	ret    

000000000010007e <realloc>:

void * realloc(void * ptr, uint64_t sz) {
    return 0;
}
  10007e:	b8 00 00 00 00       	mov    $0x0,%eax
  100083:	c3                   	ret    

0000000000100084 <defrag>:

void defrag() {
}
  100084:	c3                   	ret    

0000000000100085 <heap_info>:

int heap_info(heap_info_struct * info) {
    return 0;
}
  100085:	b8 00 00 00 00       	mov    $0x0,%eax
  10008a:	c3                   	ret    

000000000010008b <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  10008b:	55                   	push   %rbp
  10008c:	48 89 e5             	mov    %rsp,%rbp
  10008f:	48 83 ec 28          	sub    $0x28,%rsp
  100093:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100097:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10009b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10009f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1000a3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1000a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1000ab:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  1000af:	eb 1c                	jmp    1000cd <memcpy+0x42>
        *d = *s;
  1000b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1000b5:	0f b6 10             	movzbl (%rax),%edx
  1000b8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1000bc:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1000be:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1000c3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1000c8:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1000cd:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1000d2:	75 dd                	jne    1000b1 <memcpy+0x26>
    }
    return dst;
  1000d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1000d8:	c9                   	leave  
  1000d9:	c3                   	ret    

00000000001000da <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1000da:	55                   	push   %rbp
  1000db:	48 89 e5             	mov    %rsp,%rbp
  1000de:	48 83 ec 28          	sub    $0x28,%rsp
  1000e2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1000e6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1000ea:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1000ee:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1000f2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  1000f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1000fa:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  1000fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100102:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  100106:	73 6a                	jae    100172 <memmove+0x98>
  100108:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10010c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100110:	48 01 d0             	add    %rdx,%rax
  100113:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100117:	73 59                	jae    100172 <memmove+0x98>
        s += n, d += n;
  100119:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10011d:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100121:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100125:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  100129:	eb 17                	jmp    100142 <memmove+0x68>
            *--d = *--s;
  10012b:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100130:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100135:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100139:	0f b6 10             	movzbl (%rax),%edx
  10013c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100140:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100142:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100146:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10014a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  10014e:	48 85 c0             	test   %rax,%rax
  100151:	75 d8                	jne    10012b <memmove+0x51>
    if (s < d && s + n > d) {
  100153:	eb 2e                	jmp    100183 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100155:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100159:	48 8d 42 01          	lea    0x1(%rdx),%rax
  10015d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100161:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100165:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100169:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  10016d:	0f b6 12             	movzbl (%rdx),%edx
  100170:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100172:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100176:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10017a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  10017e:	48 85 c0             	test   %rax,%rax
  100181:	75 d2                	jne    100155 <memmove+0x7b>
        }
    }
    return dst;
  100183:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100187:	c9                   	leave  
  100188:	c3                   	ret    

0000000000100189 <memset>:

void* memset(void* v, int c, size_t n) {
  100189:	55                   	push   %rbp
  10018a:	48 89 e5             	mov    %rsp,%rbp
  10018d:	48 83 ec 28          	sub    $0x28,%rsp
  100191:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100195:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100198:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10019c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1001a0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1001a4:	eb 15                	jmp    1001bb <memset+0x32>
        *p = c;
  1001a6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1001a9:	89 c2                	mov    %eax,%edx
  1001ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1001af:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1001b1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1001b6:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1001bb:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1001c0:	75 e4                	jne    1001a6 <memset+0x1d>
    }
    return v;
  1001c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1001c6:	c9                   	leave  
  1001c7:	c3                   	ret    

00000000001001c8 <strlen>:

size_t strlen(const char* s) {
  1001c8:	55                   	push   %rbp
  1001c9:	48 89 e5             	mov    %rsp,%rbp
  1001cc:	48 83 ec 18          	sub    $0x18,%rsp
  1001d0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  1001d4:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1001db:	00 
  1001dc:	eb 0a                	jmp    1001e8 <strlen+0x20>
        ++n;
  1001de:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  1001e3:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1001e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1001ec:	0f b6 00             	movzbl (%rax),%eax
  1001ef:	84 c0                	test   %al,%al
  1001f1:	75 eb                	jne    1001de <strlen+0x16>
    }
    return n;
  1001f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1001f7:	c9                   	leave  
  1001f8:	c3                   	ret    

00000000001001f9 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  1001f9:	55                   	push   %rbp
  1001fa:	48 89 e5             	mov    %rsp,%rbp
  1001fd:	48 83 ec 20          	sub    $0x20,%rsp
  100201:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100205:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100209:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100210:	00 
  100211:	eb 0a                	jmp    10021d <strnlen+0x24>
        ++n;
  100213:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100218:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  10021d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100221:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100225:	74 0b                	je     100232 <strnlen+0x39>
  100227:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10022b:	0f b6 00             	movzbl (%rax),%eax
  10022e:	84 c0                	test   %al,%al
  100230:	75 e1                	jne    100213 <strnlen+0x1a>
    }
    return n;
  100232:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100236:	c9                   	leave  
  100237:	c3                   	ret    

0000000000100238 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100238:	55                   	push   %rbp
  100239:	48 89 e5             	mov    %rsp,%rbp
  10023c:	48 83 ec 20          	sub    $0x20,%rsp
  100240:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100244:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  100248:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10024c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100250:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100254:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100258:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  10025c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100260:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100264:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100268:	0f b6 12             	movzbl (%rdx),%edx
  10026b:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  10026d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100271:	48 83 e8 01          	sub    $0x1,%rax
  100275:	0f b6 00             	movzbl (%rax),%eax
  100278:	84 c0                	test   %al,%al
  10027a:	75 d4                	jne    100250 <strcpy+0x18>
    return dst;
  10027c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100280:	c9                   	leave  
  100281:	c3                   	ret    

0000000000100282 <strcmp>:

int strcmp(const char* a, const char* b) {
  100282:	55                   	push   %rbp
  100283:	48 89 e5             	mov    %rsp,%rbp
  100286:	48 83 ec 10          	sub    $0x10,%rsp
  10028a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  10028e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100292:	eb 0a                	jmp    10029e <strcmp+0x1c>
        ++a, ++b;
  100294:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100299:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10029e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002a2:	0f b6 00             	movzbl (%rax),%eax
  1002a5:	84 c0                	test   %al,%al
  1002a7:	74 1d                	je     1002c6 <strcmp+0x44>
  1002a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1002ad:	0f b6 00             	movzbl (%rax),%eax
  1002b0:	84 c0                	test   %al,%al
  1002b2:	74 12                	je     1002c6 <strcmp+0x44>
  1002b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002b8:	0f b6 10             	movzbl (%rax),%edx
  1002bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1002bf:	0f b6 00             	movzbl (%rax),%eax
  1002c2:	38 c2                	cmp    %al,%dl
  1002c4:	74 ce                	je     100294 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  1002c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002ca:	0f b6 00             	movzbl (%rax),%eax
  1002cd:	89 c2                	mov    %eax,%edx
  1002cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1002d3:	0f b6 00             	movzbl (%rax),%eax
  1002d6:	38 d0                	cmp    %dl,%al
  1002d8:	0f 92 c0             	setb   %al
  1002db:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  1002de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002e2:	0f b6 00             	movzbl (%rax),%eax
  1002e5:	89 c1                	mov    %eax,%ecx
  1002e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1002eb:	0f b6 00             	movzbl (%rax),%eax
  1002ee:	38 c1                	cmp    %al,%cl
  1002f0:	0f 92 c0             	setb   %al
  1002f3:	0f b6 c0             	movzbl %al,%eax
  1002f6:	29 c2                	sub    %eax,%edx
  1002f8:	89 d0                	mov    %edx,%eax
}
  1002fa:	c9                   	leave  
  1002fb:	c3                   	ret    

00000000001002fc <strchr>:

char* strchr(const char* s, int c) {
  1002fc:	55                   	push   %rbp
  1002fd:	48 89 e5             	mov    %rsp,%rbp
  100300:	48 83 ec 10          	sub    $0x10,%rsp
  100304:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100308:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  10030b:	eb 05                	jmp    100312 <strchr+0x16>
        ++s;
  10030d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100312:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100316:	0f b6 00             	movzbl (%rax),%eax
  100319:	84 c0                	test   %al,%al
  10031b:	74 0e                	je     10032b <strchr+0x2f>
  10031d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100321:	0f b6 00             	movzbl (%rax),%eax
  100324:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100327:	38 d0                	cmp    %dl,%al
  100329:	75 e2                	jne    10030d <strchr+0x11>
    }
    if (*s == (char) c) {
  10032b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10032f:	0f b6 00             	movzbl (%rax),%eax
  100332:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100335:	38 d0                	cmp    %dl,%al
  100337:	75 06                	jne    10033f <strchr+0x43>
        return (char*) s;
  100339:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10033d:	eb 05                	jmp    100344 <strchr+0x48>
    } else {
        return NULL;
  10033f:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100344:	c9                   	leave  
  100345:	c3                   	ret    

0000000000100346 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100346:	55                   	push   %rbp
  100347:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  10034a:	8b 05 c0 1c 00 00    	mov    0x1cc0(%rip),%eax        # 102010 <rand_seed_set>
  100350:	85 c0                	test   %eax,%eax
  100352:	75 0a                	jne    10035e <rand+0x18>
        srand(819234718U);
  100354:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100359:	e8 24 00 00 00       	call   100382 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  10035e:	8b 05 b0 1c 00 00    	mov    0x1cb0(%rip),%eax        # 102014 <rand_seed>
  100364:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  10036a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  10036f:	89 05 9f 1c 00 00    	mov    %eax,0x1c9f(%rip)        # 102014 <rand_seed>
    return rand_seed & RAND_MAX;
  100375:	8b 05 99 1c 00 00    	mov    0x1c99(%rip),%eax        # 102014 <rand_seed>
  10037b:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100380:	5d                   	pop    %rbp
  100381:	c3                   	ret    

0000000000100382 <srand>:

void srand(unsigned seed) {
  100382:	55                   	push   %rbp
  100383:	48 89 e5             	mov    %rsp,%rbp
  100386:	48 83 ec 08          	sub    $0x8,%rsp
  10038a:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  10038d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100390:	89 05 7e 1c 00 00    	mov    %eax,0x1c7e(%rip)        # 102014 <rand_seed>
    rand_seed_set = 1;
  100396:	c7 05 70 1c 00 00 01 	movl   $0x1,0x1c70(%rip)        # 102010 <rand_seed_set>
  10039d:	00 00 00 
}
  1003a0:	90                   	nop
  1003a1:	c9                   	leave  
  1003a2:	c3                   	ret    

00000000001003a3 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  1003a3:	55                   	push   %rbp
  1003a4:	48 89 e5             	mov    %rsp,%rbp
  1003a7:	48 83 ec 28          	sub    $0x28,%rsp
  1003ab:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1003af:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1003b3:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  1003b6:	48 c7 45 f8 c0 12 10 	movq   $0x1012c0,-0x8(%rbp)
  1003bd:	00 
    if (base < 0) {
  1003be:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  1003c2:	79 0b                	jns    1003cf <fill_numbuf+0x2c>
        digits = lower_digits;
  1003c4:	48 c7 45 f8 e0 12 10 	movq   $0x1012e0,-0x8(%rbp)
  1003cb:	00 
        base = -base;
  1003cc:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  1003cf:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1003d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1003d8:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  1003db:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1003de:	48 63 c8             	movslq %eax,%rcx
  1003e1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1003e5:	ba 00 00 00 00       	mov    $0x0,%edx
  1003ea:	48 f7 f1             	div    %rcx
  1003ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003f1:	48 01 d0             	add    %rdx,%rax
  1003f4:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1003f9:	0f b6 10             	movzbl (%rax),%edx
  1003fc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100400:	88 10                	mov    %dl,(%rax)
        val /= base;
  100402:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100405:	48 63 f0             	movslq %eax,%rsi
  100408:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10040c:	ba 00 00 00 00       	mov    $0x0,%edx
  100411:	48 f7 f6             	div    %rsi
  100414:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100418:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  10041d:	75 bc                	jne    1003db <fill_numbuf+0x38>
    return numbuf_end;
  10041f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100423:	c9                   	leave  
  100424:	c3                   	ret    

0000000000100425 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100425:	55                   	push   %rbp
  100426:	48 89 e5             	mov    %rsp,%rbp
  100429:	53                   	push   %rbx
  10042a:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100431:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100438:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  10043e:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100445:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  10044c:	e9 8a 09 00 00       	jmp    100ddb <printer_vprintf+0x9b6>
        if (*format != '%') {
  100451:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100458:	0f b6 00             	movzbl (%rax),%eax
  10045b:	3c 25                	cmp    $0x25,%al
  10045d:	74 31                	je     100490 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  10045f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100466:	4c 8b 00             	mov    (%rax),%r8
  100469:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100470:	0f b6 00             	movzbl (%rax),%eax
  100473:	0f b6 c8             	movzbl %al,%ecx
  100476:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10047c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100483:	89 ce                	mov    %ecx,%esi
  100485:	48 89 c7             	mov    %rax,%rdi
  100488:	41 ff d0             	call   *%r8
            continue;
  10048b:	e9 43 09 00 00       	jmp    100dd3 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100490:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100497:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10049e:	01 
  10049f:	eb 44                	jmp    1004e5 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  1004a1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1004a8:	0f b6 00             	movzbl (%rax),%eax
  1004ab:	0f be c0             	movsbl %al,%eax
  1004ae:	89 c6                	mov    %eax,%esi
  1004b0:	bf e0 10 10 00       	mov    $0x1010e0,%edi
  1004b5:	e8 42 fe ff ff       	call   1002fc <strchr>
  1004ba:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  1004be:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  1004c3:	74 30                	je     1004f5 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  1004c5:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  1004c9:	48 2d e0 10 10 00    	sub    $0x1010e0,%rax
  1004cf:	ba 01 00 00 00       	mov    $0x1,%edx
  1004d4:	89 c1                	mov    %eax,%ecx
  1004d6:	d3 e2                	shl    %cl,%edx
  1004d8:	89 d0                	mov    %edx,%eax
  1004da:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  1004dd:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1004e4:	01 
  1004e5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1004ec:	0f b6 00             	movzbl (%rax),%eax
  1004ef:	84 c0                	test   %al,%al
  1004f1:	75 ae                	jne    1004a1 <printer_vprintf+0x7c>
  1004f3:	eb 01                	jmp    1004f6 <printer_vprintf+0xd1>
            } else {
                break;
  1004f5:	90                   	nop
            }
        }

        // process width
        int width = -1;
  1004f6:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  1004fd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100504:	0f b6 00             	movzbl (%rax),%eax
  100507:	3c 30                	cmp    $0x30,%al
  100509:	7e 67                	jle    100572 <printer_vprintf+0x14d>
  10050b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100512:	0f b6 00             	movzbl (%rax),%eax
  100515:	3c 39                	cmp    $0x39,%al
  100517:	7f 59                	jg     100572 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100519:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100520:	eb 2e                	jmp    100550 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100522:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100525:	89 d0                	mov    %edx,%eax
  100527:	c1 e0 02             	shl    $0x2,%eax
  10052a:	01 d0                	add    %edx,%eax
  10052c:	01 c0                	add    %eax,%eax
  10052e:	89 c1                	mov    %eax,%ecx
  100530:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100537:	48 8d 50 01          	lea    0x1(%rax),%rdx
  10053b:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100542:	0f b6 00             	movzbl (%rax),%eax
  100545:	0f be c0             	movsbl %al,%eax
  100548:	01 c8                	add    %ecx,%eax
  10054a:	83 e8 30             	sub    $0x30,%eax
  10054d:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100550:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100557:	0f b6 00             	movzbl (%rax),%eax
  10055a:	3c 2f                	cmp    $0x2f,%al
  10055c:	0f 8e 85 00 00 00    	jle    1005e7 <printer_vprintf+0x1c2>
  100562:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100569:	0f b6 00             	movzbl (%rax),%eax
  10056c:	3c 39                	cmp    $0x39,%al
  10056e:	7e b2                	jle    100522 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100570:	eb 75                	jmp    1005e7 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100572:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100579:	0f b6 00             	movzbl (%rax),%eax
  10057c:	3c 2a                	cmp    $0x2a,%al
  10057e:	75 68                	jne    1005e8 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100580:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100587:	8b 00                	mov    (%rax),%eax
  100589:	83 f8 2f             	cmp    $0x2f,%eax
  10058c:	77 30                	ja     1005be <printer_vprintf+0x199>
  10058e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100595:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100599:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1005a0:	8b 00                	mov    (%rax),%eax
  1005a2:	89 c0                	mov    %eax,%eax
  1005a4:	48 01 d0             	add    %rdx,%rax
  1005a7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1005ae:	8b 12                	mov    (%rdx),%edx
  1005b0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1005b3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1005ba:	89 0a                	mov    %ecx,(%rdx)
  1005bc:	eb 1a                	jmp    1005d8 <printer_vprintf+0x1b3>
  1005be:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1005c5:	48 8b 40 08          	mov    0x8(%rax),%rax
  1005c9:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1005cd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1005d4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1005d8:	8b 00                	mov    (%rax),%eax
  1005da:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  1005dd:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1005e4:	01 
  1005e5:	eb 01                	jmp    1005e8 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  1005e7:	90                   	nop
        }

        // process precision
        int precision = -1;
  1005e8:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  1005ef:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1005f6:	0f b6 00             	movzbl (%rax),%eax
  1005f9:	3c 2e                	cmp    $0x2e,%al
  1005fb:	0f 85 00 01 00 00    	jne    100701 <printer_vprintf+0x2dc>
            ++format;
  100601:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100608:	01 
            if (*format >= '0' && *format <= '9') {
  100609:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100610:	0f b6 00             	movzbl (%rax),%eax
  100613:	3c 2f                	cmp    $0x2f,%al
  100615:	7e 67                	jle    10067e <printer_vprintf+0x259>
  100617:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10061e:	0f b6 00             	movzbl (%rax),%eax
  100621:	3c 39                	cmp    $0x39,%al
  100623:	7f 59                	jg     10067e <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100625:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  10062c:	eb 2e                	jmp    10065c <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  10062e:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100631:	89 d0                	mov    %edx,%eax
  100633:	c1 e0 02             	shl    $0x2,%eax
  100636:	01 d0                	add    %edx,%eax
  100638:	01 c0                	add    %eax,%eax
  10063a:	89 c1                	mov    %eax,%ecx
  10063c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100643:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100647:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10064e:	0f b6 00             	movzbl (%rax),%eax
  100651:	0f be c0             	movsbl %al,%eax
  100654:	01 c8                	add    %ecx,%eax
  100656:	83 e8 30             	sub    $0x30,%eax
  100659:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10065c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100663:	0f b6 00             	movzbl (%rax),%eax
  100666:	3c 2f                	cmp    $0x2f,%al
  100668:	0f 8e 85 00 00 00    	jle    1006f3 <printer_vprintf+0x2ce>
  10066e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100675:	0f b6 00             	movzbl (%rax),%eax
  100678:	3c 39                	cmp    $0x39,%al
  10067a:	7e b2                	jle    10062e <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  10067c:	eb 75                	jmp    1006f3 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  10067e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100685:	0f b6 00             	movzbl (%rax),%eax
  100688:	3c 2a                	cmp    $0x2a,%al
  10068a:	75 68                	jne    1006f4 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  10068c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100693:	8b 00                	mov    (%rax),%eax
  100695:	83 f8 2f             	cmp    $0x2f,%eax
  100698:	77 30                	ja     1006ca <printer_vprintf+0x2a5>
  10069a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1006a1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1006a5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1006ac:	8b 00                	mov    (%rax),%eax
  1006ae:	89 c0                	mov    %eax,%eax
  1006b0:	48 01 d0             	add    %rdx,%rax
  1006b3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1006ba:	8b 12                	mov    (%rdx),%edx
  1006bc:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1006bf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1006c6:	89 0a                	mov    %ecx,(%rdx)
  1006c8:	eb 1a                	jmp    1006e4 <printer_vprintf+0x2bf>
  1006ca:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1006d1:	48 8b 40 08          	mov    0x8(%rax),%rax
  1006d5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1006d9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1006e0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1006e4:	8b 00                	mov    (%rax),%eax
  1006e6:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  1006e9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1006f0:	01 
  1006f1:	eb 01                	jmp    1006f4 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  1006f3:	90                   	nop
            }
            if (precision < 0) {
  1006f4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1006f8:	79 07                	jns    100701 <printer_vprintf+0x2dc>
                precision = 0;
  1006fa:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100701:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100708:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  10070f:	00 
        int length = 0;
  100710:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100717:	48 c7 45 c8 e6 10 10 	movq   $0x1010e6,-0x38(%rbp)
  10071e:	00 
    again:
        switch (*format) {
  10071f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100726:	0f b6 00             	movzbl (%rax),%eax
  100729:	0f be c0             	movsbl %al,%eax
  10072c:	83 e8 43             	sub    $0x43,%eax
  10072f:	83 f8 37             	cmp    $0x37,%eax
  100732:	0f 87 9f 03 00 00    	ja     100ad7 <printer_vprintf+0x6b2>
  100738:	89 c0                	mov    %eax,%eax
  10073a:	48 8b 04 c5 f8 10 10 	mov    0x1010f8(,%rax,8),%rax
  100741:	00 
  100742:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100744:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  10074b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100752:	01 
            goto again;
  100753:	eb ca                	jmp    10071f <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100755:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100759:	74 5d                	je     1007b8 <printer_vprintf+0x393>
  10075b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100762:	8b 00                	mov    (%rax),%eax
  100764:	83 f8 2f             	cmp    $0x2f,%eax
  100767:	77 30                	ja     100799 <printer_vprintf+0x374>
  100769:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100770:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100774:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10077b:	8b 00                	mov    (%rax),%eax
  10077d:	89 c0                	mov    %eax,%eax
  10077f:	48 01 d0             	add    %rdx,%rax
  100782:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100789:	8b 12                	mov    (%rdx),%edx
  10078b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10078e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100795:	89 0a                	mov    %ecx,(%rdx)
  100797:	eb 1a                	jmp    1007b3 <printer_vprintf+0x38e>
  100799:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007a0:	48 8b 40 08          	mov    0x8(%rax),%rax
  1007a4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1007a8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007af:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1007b3:	48 8b 00             	mov    (%rax),%rax
  1007b6:	eb 5c                	jmp    100814 <printer_vprintf+0x3ef>
  1007b8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007bf:	8b 00                	mov    (%rax),%eax
  1007c1:	83 f8 2f             	cmp    $0x2f,%eax
  1007c4:	77 30                	ja     1007f6 <printer_vprintf+0x3d1>
  1007c6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007cd:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1007d1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007d8:	8b 00                	mov    (%rax),%eax
  1007da:	89 c0                	mov    %eax,%eax
  1007dc:	48 01 d0             	add    %rdx,%rax
  1007df:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007e6:	8b 12                	mov    (%rdx),%edx
  1007e8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1007eb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007f2:	89 0a                	mov    %ecx,(%rdx)
  1007f4:	eb 1a                	jmp    100810 <printer_vprintf+0x3eb>
  1007f6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007fd:	48 8b 40 08          	mov    0x8(%rax),%rax
  100801:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100805:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10080c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100810:	8b 00                	mov    (%rax),%eax
  100812:	48 98                	cltq   
  100814:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100818:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10081c:	48 c1 f8 38          	sar    $0x38,%rax
  100820:	25 80 00 00 00       	and    $0x80,%eax
  100825:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100828:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  10082c:	74 09                	je     100837 <printer_vprintf+0x412>
  10082e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100832:	48 f7 d8             	neg    %rax
  100835:	eb 04                	jmp    10083b <printer_vprintf+0x416>
  100837:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10083b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  10083f:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100842:	83 c8 60             	or     $0x60,%eax
  100845:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100848:	e9 cf 02 00 00       	jmp    100b1c <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  10084d:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100851:	74 5d                	je     1008b0 <printer_vprintf+0x48b>
  100853:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10085a:	8b 00                	mov    (%rax),%eax
  10085c:	83 f8 2f             	cmp    $0x2f,%eax
  10085f:	77 30                	ja     100891 <printer_vprintf+0x46c>
  100861:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100868:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10086c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100873:	8b 00                	mov    (%rax),%eax
  100875:	89 c0                	mov    %eax,%eax
  100877:	48 01 d0             	add    %rdx,%rax
  10087a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100881:	8b 12                	mov    (%rdx),%edx
  100883:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100886:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10088d:	89 0a                	mov    %ecx,(%rdx)
  10088f:	eb 1a                	jmp    1008ab <printer_vprintf+0x486>
  100891:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100898:	48 8b 40 08          	mov    0x8(%rax),%rax
  10089c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1008a0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008a7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1008ab:	48 8b 00             	mov    (%rax),%rax
  1008ae:	eb 5c                	jmp    10090c <printer_vprintf+0x4e7>
  1008b0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008b7:	8b 00                	mov    (%rax),%eax
  1008b9:	83 f8 2f             	cmp    $0x2f,%eax
  1008bc:	77 30                	ja     1008ee <printer_vprintf+0x4c9>
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
  1008ec:	eb 1a                	jmp    100908 <printer_vprintf+0x4e3>
  1008ee:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008f5:	48 8b 40 08          	mov    0x8(%rax),%rax
  1008f9:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1008fd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100904:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100908:	8b 00                	mov    (%rax),%eax
  10090a:	89 c0                	mov    %eax,%eax
  10090c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100910:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100914:	e9 03 02 00 00       	jmp    100b1c <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100919:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100920:	e9 28 ff ff ff       	jmp    10084d <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100925:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  10092c:	e9 1c ff ff ff       	jmp    10084d <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100931:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100938:	8b 00                	mov    (%rax),%eax
  10093a:	83 f8 2f             	cmp    $0x2f,%eax
  10093d:	77 30                	ja     10096f <printer_vprintf+0x54a>
  10093f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100946:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10094a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100951:	8b 00                	mov    (%rax),%eax
  100953:	89 c0                	mov    %eax,%eax
  100955:	48 01 d0             	add    %rdx,%rax
  100958:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10095f:	8b 12                	mov    (%rdx),%edx
  100961:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100964:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10096b:	89 0a                	mov    %ecx,(%rdx)
  10096d:	eb 1a                	jmp    100989 <printer_vprintf+0x564>
  10096f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100976:	48 8b 40 08          	mov    0x8(%rax),%rax
  10097a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10097e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100985:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100989:	48 8b 00             	mov    (%rax),%rax
  10098c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100990:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100997:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  10099e:	e9 79 01 00 00       	jmp    100b1c <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  1009a3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009aa:	8b 00                	mov    (%rax),%eax
  1009ac:	83 f8 2f             	cmp    $0x2f,%eax
  1009af:	77 30                	ja     1009e1 <printer_vprintf+0x5bc>
  1009b1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009b8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1009bc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009c3:	8b 00                	mov    (%rax),%eax
  1009c5:	89 c0                	mov    %eax,%eax
  1009c7:	48 01 d0             	add    %rdx,%rax
  1009ca:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009d1:	8b 12                	mov    (%rdx),%edx
  1009d3:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1009d6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009dd:	89 0a                	mov    %ecx,(%rdx)
  1009df:	eb 1a                	jmp    1009fb <printer_vprintf+0x5d6>
  1009e1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009e8:	48 8b 40 08          	mov    0x8(%rax),%rax
  1009ec:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1009f0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009f7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1009fb:	48 8b 00             	mov    (%rax),%rax
  1009fe:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100a02:	e9 15 01 00 00       	jmp    100b1c <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100a07:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a0e:	8b 00                	mov    (%rax),%eax
  100a10:	83 f8 2f             	cmp    $0x2f,%eax
  100a13:	77 30                	ja     100a45 <printer_vprintf+0x620>
  100a15:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a1c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a20:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a27:	8b 00                	mov    (%rax),%eax
  100a29:	89 c0                	mov    %eax,%eax
  100a2b:	48 01 d0             	add    %rdx,%rax
  100a2e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a35:	8b 12                	mov    (%rdx),%edx
  100a37:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a3a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a41:	89 0a                	mov    %ecx,(%rdx)
  100a43:	eb 1a                	jmp    100a5f <printer_vprintf+0x63a>
  100a45:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a4c:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a50:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a54:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a5b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a5f:	8b 00                	mov    (%rax),%eax
  100a61:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100a67:	e9 67 03 00 00       	jmp    100dd3 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  100a6c:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100a70:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100a74:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a7b:	8b 00                	mov    (%rax),%eax
  100a7d:	83 f8 2f             	cmp    $0x2f,%eax
  100a80:	77 30                	ja     100ab2 <printer_vprintf+0x68d>
  100a82:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a89:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a8d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a94:	8b 00                	mov    (%rax),%eax
  100a96:	89 c0                	mov    %eax,%eax
  100a98:	48 01 d0             	add    %rdx,%rax
  100a9b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aa2:	8b 12                	mov    (%rdx),%edx
  100aa4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100aa7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aae:	89 0a                	mov    %ecx,(%rdx)
  100ab0:	eb 1a                	jmp    100acc <printer_vprintf+0x6a7>
  100ab2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ab9:	48 8b 40 08          	mov    0x8(%rax),%rax
  100abd:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ac1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ac8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100acc:	8b 00                	mov    (%rax),%eax
  100ace:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100ad1:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100ad5:	eb 45                	jmp    100b1c <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  100ad7:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100adb:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100adf:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ae6:	0f b6 00             	movzbl (%rax),%eax
  100ae9:	84 c0                	test   %al,%al
  100aeb:	74 0c                	je     100af9 <printer_vprintf+0x6d4>
  100aed:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100af4:	0f b6 00             	movzbl (%rax),%eax
  100af7:	eb 05                	jmp    100afe <printer_vprintf+0x6d9>
  100af9:	b8 25 00 00 00       	mov    $0x25,%eax
  100afe:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100b01:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100b05:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b0c:	0f b6 00             	movzbl (%rax),%eax
  100b0f:	84 c0                	test   %al,%al
  100b11:	75 08                	jne    100b1b <printer_vprintf+0x6f6>
                format--;
  100b13:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100b1a:	01 
            }
            break;
  100b1b:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100b1c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100b1f:	83 e0 20             	and    $0x20,%eax
  100b22:	85 c0                	test   %eax,%eax
  100b24:	74 1e                	je     100b44 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100b26:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100b2a:	48 83 c0 18          	add    $0x18,%rax
  100b2e:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100b31:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100b35:	48 89 ce             	mov    %rcx,%rsi
  100b38:	48 89 c7             	mov    %rax,%rdi
  100b3b:	e8 63 f8 ff ff       	call   1003a3 <fill_numbuf>
  100b40:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100b44:	48 c7 45 c0 e6 10 10 	movq   $0x1010e6,-0x40(%rbp)
  100b4b:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100b4c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100b4f:	83 e0 20             	and    $0x20,%eax
  100b52:	85 c0                	test   %eax,%eax
  100b54:	74 48                	je     100b9e <printer_vprintf+0x779>
  100b56:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100b59:	83 e0 40             	and    $0x40,%eax
  100b5c:	85 c0                	test   %eax,%eax
  100b5e:	74 3e                	je     100b9e <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  100b60:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100b63:	25 80 00 00 00       	and    $0x80,%eax
  100b68:	85 c0                	test   %eax,%eax
  100b6a:	74 0a                	je     100b76 <printer_vprintf+0x751>
                prefix = "-";
  100b6c:	48 c7 45 c0 e7 10 10 	movq   $0x1010e7,-0x40(%rbp)
  100b73:	00 
            if (flags & FLAG_NEGATIVE) {
  100b74:	eb 73                	jmp    100be9 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100b76:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100b79:	83 e0 10             	and    $0x10,%eax
  100b7c:	85 c0                	test   %eax,%eax
  100b7e:	74 0a                	je     100b8a <printer_vprintf+0x765>
                prefix = "+";
  100b80:	48 c7 45 c0 e9 10 10 	movq   $0x1010e9,-0x40(%rbp)
  100b87:	00 
            if (flags & FLAG_NEGATIVE) {
  100b88:	eb 5f                	jmp    100be9 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100b8a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100b8d:	83 e0 08             	and    $0x8,%eax
  100b90:	85 c0                	test   %eax,%eax
  100b92:	74 55                	je     100be9 <printer_vprintf+0x7c4>
                prefix = " ";
  100b94:	48 c7 45 c0 eb 10 10 	movq   $0x1010eb,-0x40(%rbp)
  100b9b:	00 
            if (flags & FLAG_NEGATIVE) {
  100b9c:	eb 4b                	jmp    100be9 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100b9e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ba1:	83 e0 20             	and    $0x20,%eax
  100ba4:	85 c0                	test   %eax,%eax
  100ba6:	74 42                	je     100bea <printer_vprintf+0x7c5>
  100ba8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100bab:	83 e0 01             	and    $0x1,%eax
  100bae:	85 c0                	test   %eax,%eax
  100bb0:	74 38                	je     100bea <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  100bb2:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100bb6:	74 06                	je     100bbe <printer_vprintf+0x799>
  100bb8:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100bbc:	75 2c                	jne    100bea <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  100bbe:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100bc3:	75 0c                	jne    100bd1 <printer_vprintf+0x7ac>
  100bc5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100bc8:	25 00 01 00 00       	and    $0x100,%eax
  100bcd:	85 c0                	test   %eax,%eax
  100bcf:	74 19                	je     100bea <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  100bd1:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100bd5:	75 07                	jne    100bde <printer_vprintf+0x7b9>
  100bd7:	b8 ed 10 10 00       	mov    $0x1010ed,%eax
  100bdc:	eb 05                	jmp    100be3 <printer_vprintf+0x7be>
  100bde:	b8 f0 10 10 00       	mov    $0x1010f0,%eax
  100be3:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100be7:	eb 01                	jmp    100bea <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  100be9:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100bea:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100bee:	78 24                	js     100c14 <printer_vprintf+0x7ef>
  100bf0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100bf3:	83 e0 20             	and    $0x20,%eax
  100bf6:	85 c0                	test   %eax,%eax
  100bf8:	75 1a                	jne    100c14 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  100bfa:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100bfd:	48 63 d0             	movslq %eax,%rdx
  100c00:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100c04:	48 89 d6             	mov    %rdx,%rsi
  100c07:	48 89 c7             	mov    %rax,%rdi
  100c0a:	e8 ea f5 ff ff       	call   1001f9 <strnlen>
  100c0f:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100c12:	eb 0f                	jmp    100c23 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  100c14:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100c18:	48 89 c7             	mov    %rax,%rdi
  100c1b:	e8 a8 f5 ff ff       	call   1001c8 <strlen>
  100c20:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100c23:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c26:	83 e0 20             	and    $0x20,%eax
  100c29:	85 c0                	test   %eax,%eax
  100c2b:	74 20                	je     100c4d <printer_vprintf+0x828>
  100c2d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100c31:	78 1a                	js     100c4d <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  100c33:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100c36:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100c39:	7e 08                	jle    100c43 <printer_vprintf+0x81e>
  100c3b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100c3e:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100c41:	eb 05                	jmp    100c48 <printer_vprintf+0x823>
  100c43:	b8 00 00 00 00       	mov    $0x0,%eax
  100c48:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100c4b:	eb 5c                	jmp    100ca9 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100c4d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c50:	83 e0 20             	and    $0x20,%eax
  100c53:	85 c0                	test   %eax,%eax
  100c55:	74 4b                	je     100ca2 <printer_vprintf+0x87d>
  100c57:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c5a:	83 e0 02             	and    $0x2,%eax
  100c5d:	85 c0                	test   %eax,%eax
  100c5f:	74 41                	je     100ca2 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100c61:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c64:	83 e0 04             	and    $0x4,%eax
  100c67:	85 c0                	test   %eax,%eax
  100c69:	75 37                	jne    100ca2 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  100c6b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100c6f:	48 89 c7             	mov    %rax,%rdi
  100c72:	e8 51 f5 ff ff       	call   1001c8 <strlen>
  100c77:	89 c2                	mov    %eax,%edx
  100c79:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100c7c:	01 d0                	add    %edx,%eax
  100c7e:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100c81:	7e 1f                	jle    100ca2 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  100c83:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100c86:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100c89:	89 c3                	mov    %eax,%ebx
  100c8b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100c8f:	48 89 c7             	mov    %rax,%rdi
  100c92:	e8 31 f5 ff ff       	call   1001c8 <strlen>
  100c97:	89 c2                	mov    %eax,%edx
  100c99:	89 d8                	mov    %ebx,%eax
  100c9b:	29 d0                	sub    %edx,%eax
  100c9d:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100ca0:	eb 07                	jmp    100ca9 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  100ca2:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100ca9:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100cac:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100caf:	01 d0                	add    %edx,%eax
  100cb1:	48 63 d8             	movslq %eax,%rbx
  100cb4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100cb8:	48 89 c7             	mov    %rax,%rdi
  100cbb:	e8 08 f5 ff ff       	call   1001c8 <strlen>
  100cc0:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100cc4:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100cc7:	29 d0                	sub    %edx,%eax
  100cc9:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100ccc:	eb 25                	jmp    100cf3 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  100cce:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100cd5:	48 8b 08             	mov    (%rax),%rcx
  100cd8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100cde:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ce5:	be 20 00 00 00       	mov    $0x20,%esi
  100cea:	48 89 c7             	mov    %rax,%rdi
  100ced:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100cef:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100cf3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cf6:	83 e0 04             	and    $0x4,%eax
  100cf9:	85 c0                	test   %eax,%eax
  100cfb:	75 36                	jne    100d33 <printer_vprintf+0x90e>
  100cfd:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100d01:	7f cb                	jg     100cce <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  100d03:	eb 2e                	jmp    100d33 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  100d05:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d0c:	4c 8b 00             	mov    (%rax),%r8
  100d0f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100d13:	0f b6 00             	movzbl (%rax),%eax
  100d16:	0f b6 c8             	movzbl %al,%ecx
  100d19:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100d1f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d26:	89 ce                	mov    %ecx,%esi
  100d28:	48 89 c7             	mov    %rax,%rdi
  100d2b:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  100d2e:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  100d33:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100d37:	0f b6 00             	movzbl (%rax),%eax
  100d3a:	84 c0                	test   %al,%al
  100d3c:	75 c7                	jne    100d05 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  100d3e:	eb 25                	jmp    100d65 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  100d40:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d47:	48 8b 08             	mov    (%rax),%rcx
  100d4a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100d50:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d57:	be 30 00 00 00       	mov    $0x30,%esi
  100d5c:	48 89 c7             	mov    %rax,%rdi
  100d5f:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  100d61:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  100d65:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  100d69:	7f d5                	jg     100d40 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  100d6b:	eb 32                	jmp    100d9f <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  100d6d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d74:	4c 8b 00             	mov    (%rax),%r8
  100d77:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100d7b:	0f b6 00             	movzbl (%rax),%eax
  100d7e:	0f b6 c8             	movzbl %al,%ecx
  100d81:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100d87:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d8e:	89 ce                	mov    %ecx,%esi
  100d90:	48 89 c7             	mov    %rax,%rdi
  100d93:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  100d96:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  100d9b:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  100d9f:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  100da3:	7f c8                	jg     100d6d <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  100da5:	eb 25                	jmp    100dcc <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  100da7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100dae:	48 8b 08             	mov    (%rax),%rcx
  100db1:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100db7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100dbe:	be 20 00 00 00       	mov    $0x20,%esi
  100dc3:	48 89 c7             	mov    %rax,%rdi
  100dc6:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  100dc8:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100dcc:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100dd0:	7f d5                	jg     100da7 <printer_vprintf+0x982>
        }
    done: ;
  100dd2:	90                   	nop
    for (; *format; ++format) {
  100dd3:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100dda:	01 
  100ddb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100de2:	0f b6 00             	movzbl (%rax),%eax
  100de5:	84 c0                	test   %al,%al
  100de7:	0f 85 64 f6 ff ff    	jne    100451 <printer_vprintf+0x2c>
    }
}
  100ded:	90                   	nop
  100dee:	90                   	nop
  100def:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100df3:	c9                   	leave  
  100df4:	c3                   	ret    

0000000000100df5 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100df5:	55                   	push   %rbp
  100df6:	48 89 e5             	mov    %rsp,%rbp
  100df9:	48 83 ec 20          	sub    $0x20,%rsp
  100dfd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100e01:	89 f0                	mov    %esi,%eax
  100e03:	89 55 e0             	mov    %edx,-0x20(%rbp)
  100e06:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  100e09:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100e0d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100e11:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100e15:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e19:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  100e1e:	48 39 d0             	cmp    %rdx,%rax
  100e21:	72 0c                	jb     100e2f <console_putc+0x3a>
        cp->cursor = console;
  100e23:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100e27:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  100e2e:	00 
    }
    if (c == '\n') {
  100e2f:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  100e33:	75 78                	jne    100ead <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  100e35:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100e39:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e3d:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  100e43:	48 d1 f8             	sar    %rax
  100e46:	48 89 c1             	mov    %rax,%rcx
  100e49:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  100e50:	66 66 66 
  100e53:	48 89 c8             	mov    %rcx,%rax
  100e56:	48 f7 ea             	imul   %rdx
  100e59:	48 c1 fa 05          	sar    $0x5,%rdx
  100e5d:	48 89 c8             	mov    %rcx,%rax
  100e60:	48 c1 f8 3f          	sar    $0x3f,%rax
  100e64:	48 29 c2             	sub    %rax,%rdx
  100e67:	48 89 d0             	mov    %rdx,%rax
  100e6a:	48 c1 e0 02          	shl    $0x2,%rax
  100e6e:	48 01 d0             	add    %rdx,%rax
  100e71:	48 c1 e0 04          	shl    $0x4,%rax
  100e75:	48 29 c1             	sub    %rax,%rcx
  100e78:	48 89 ca             	mov    %rcx,%rdx
  100e7b:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  100e7e:	eb 25                	jmp    100ea5 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  100e80:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100e83:	83 c8 20             	or     $0x20,%eax
  100e86:	89 c6                	mov    %eax,%esi
  100e88:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100e8c:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e90:	48 8d 48 02          	lea    0x2(%rax),%rcx
  100e94:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  100e98:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e9c:	89 f2                	mov    %esi,%edx
  100e9e:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  100ea1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  100ea5:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  100ea9:	75 d5                	jne    100e80 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  100eab:	eb 24                	jmp    100ed1 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  100ead:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  100eb1:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100eb4:	09 d0                	or     %edx,%eax
  100eb6:	89 c6                	mov    %eax,%esi
  100eb8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100ebc:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ec0:	48 8d 48 02          	lea    0x2(%rax),%rcx
  100ec4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  100ec8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ecc:	89 f2                	mov    %esi,%edx
  100ece:	66 89 10             	mov    %dx,(%rax)
}
  100ed1:	90                   	nop
  100ed2:	c9                   	leave  
  100ed3:	c3                   	ret    

0000000000100ed4 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  100ed4:	55                   	push   %rbp
  100ed5:	48 89 e5             	mov    %rsp,%rbp
  100ed8:	48 83 ec 30          	sub    $0x30,%rsp
  100edc:	89 7d ec             	mov    %edi,-0x14(%rbp)
  100edf:	89 75 e8             	mov    %esi,-0x18(%rbp)
  100ee2:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100ee6:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  100eea:	48 c7 45 f0 f5 0d 10 	movq   $0x100df5,-0x10(%rbp)
  100ef1:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100ef2:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  100ef6:	78 09                	js     100f01 <console_vprintf+0x2d>
  100ef8:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  100eff:	7e 07                	jle    100f08 <console_vprintf+0x34>
        cpos = 0;
  100f01:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  100f08:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f0b:	48 98                	cltq   
  100f0d:	48 01 c0             	add    %rax,%rax
  100f10:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  100f16:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  100f1a:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100f1e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100f22:	8b 75 e8             	mov    -0x18(%rbp),%esi
  100f25:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  100f29:	48 89 c7             	mov    %rax,%rdi
  100f2c:	e8 f4 f4 ff ff       	call   100425 <printer_vprintf>
    return cp.cursor - console;
  100f31:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100f35:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  100f3b:	48 d1 f8             	sar    %rax
}
  100f3e:	c9                   	leave  
  100f3f:	c3                   	ret    

0000000000100f40 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  100f40:	55                   	push   %rbp
  100f41:	48 89 e5             	mov    %rsp,%rbp
  100f44:	48 83 ec 60          	sub    $0x60,%rsp
  100f48:	89 7d ac             	mov    %edi,-0x54(%rbp)
  100f4b:	89 75 a8             	mov    %esi,-0x58(%rbp)
  100f4e:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  100f52:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100f56:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100f5a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  100f5e:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100f65:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100f69:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100f6d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100f71:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  100f75:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100f79:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  100f7d:	8b 75 a8             	mov    -0x58(%rbp),%esi
  100f80:	8b 45 ac             	mov    -0x54(%rbp),%eax
  100f83:	89 c7                	mov    %eax,%edi
  100f85:	e8 4a ff ff ff       	call   100ed4 <console_vprintf>
  100f8a:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  100f8d:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  100f90:	c9                   	leave  
  100f91:	c3                   	ret    

0000000000100f92 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  100f92:	55                   	push   %rbp
  100f93:	48 89 e5             	mov    %rsp,%rbp
  100f96:	48 83 ec 20          	sub    $0x20,%rsp
  100f9a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100f9e:	89 f0                	mov    %esi,%eax
  100fa0:	89 55 e0             	mov    %edx,-0x20(%rbp)
  100fa3:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  100fa6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100faa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  100fae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100fb2:	48 8b 50 08          	mov    0x8(%rax),%rdx
  100fb6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100fba:	48 8b 40 10          	mov    0x10(%rax),%rax
  100fbe:	48 39 c2             	cmp    %rax,%rdx
  100fc1:	73 1a                	jae    100fdd <string_putc+0x4b>
        *sp->s++ = c;
  100fc3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100fc7:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fcb:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100fcf:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100fd3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100fd7:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  100fdb:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  100fdd:	90                   	nop
  100fde:	c9                   	leave  
  100fdf:	c3                   	ret    

0000000000100fe0 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  100fe0:	55                   	push   %rbp
  100fe1:	48 89 e5             	mov    %rsp,%rbp
  100fe4:	48 83 ec 40          	sub    $0x40,%rsp
  100fe8:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  100fec:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  100ff0:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  100ff4:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  100ff8:	48 c7 45 e8 92 0f 10 	movq   $0x100f92,-0x18(%rbp)
  100fff:	00 
    sp.s = s;
  101000:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101004:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  101008:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  10100d:	74 33                	je     101042 <vsnprintf+0x62>
        sp.end = s + size - 1;
  10100f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101013:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101017:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10101b:	48 01 d0             	add    %rdx,%rax
  10101e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101022:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101026:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  10102a:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  10102e:	be 00 00 00 00       	mov    $0x0,%esi
  101033:	48 89 c7             	mov    %rax,%rdi
  101036:	e8 ea f3 ff ff       	call   100425 <printer_vprintf>
        *sp.s = 0;
  10103b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10103f:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  101042:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101046:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  10104a:	c9                   	leave  
  10104b:	c3                   	ret    

000000000010104c <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  10104c:	55                   	push   %rbp
  10104d:	48 89 e5             	mov    %rsp,%rbp
  101050:	48 83 ec 70          	sub    $0x70,%rsp
  101054:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101058:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  10105c:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101060:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101064:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101068:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  10106c:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101073:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101077:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  10107b:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10107f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101083:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101087:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  10108b:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  10108f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101093:	48 89 c7             	mov    %rax,%rdi
  101096:	e8 45 ff ff ff       	call   100fe0 <vsnprintf>
  10109b:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  10109e:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  1010a1:	c9                   	leave  
  1010a2:	c3                   	ret    

00000000001010a3 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  1010a3:	55                   	push   %rbp
  1010a4:	48 89 e5             	mov    %rsp,%rbp
  1010a7:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1010ab:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  1010b2:	eb 13                	jmp    1010c7 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  1010b4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1010b7:	48 98                	cltq   
  1010b9:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  1010c0:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1010c3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1010c7:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1010ce:	7e e4                	jle    1010b4 <console_clear+0x11>
    }
    cursorpos = 0;
  1010d0:	c7 05 22 7f fb ff 00 	movl   $0x0,-0x480de(%rip)        # b8ffc <cursorpos>
  1010d7:	00 00 00 
}
  1010da:	90                   	nop
  1010db:	c9                   	leave  
  1010dc:	c3                   	ret    
