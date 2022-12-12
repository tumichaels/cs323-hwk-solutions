
obj/p-alloctests.full:     file format elf64-x86-64


Disassembly of section .text:

00000000002c0000 <process_main>:
#include "time.h"
#include "malloc.h"

extern uint8_t end[];

void process_main(void) {
  2c0000:	55                   	push   %rbp
  2c0001:	48 89 e5             	mov    %rsp,%rbp
  2c0004:	41 56                	push   %r14
  2c0006:	41 55                	push   %r13
  2c0008:	41 54                	push   %r12
  2c000a:	53                   	push   %rbx
  2c000b:	48 83 ec 20          	sub    $0x20,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  2c000f:	cd 31                	int    $0x31
  2c0011:	41 89 c4             	mov    %eax,%r12d
    
    pid_t p = getpid();
    srand(p);
  2c0014:	89 c7                	mov    %eax,%edi
  2c0016:	e8 03 06 00 00       	call   2c061e <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001b:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0020:	e8 e9 02 00 00       	call   2c030e <malloc>
  2c0025:	48 89 c7             	mov    %rax,%rdi
  2c0028:	ba 00 00 00 00       	mov    $0x0,%edx
    
    // set array elements
    for(int  i = 0 ; i < 10; i++){
	array[i] = i;
  2c002d:	89 14 97             	mov    %edx,(%rdi,%rdx,4)
    for(int  i = 0 ; i < 10; i++){
  2c0030:	48 83 c2 01          	add    $0x1,%rdx
  2c0034:	48 83 fa 0a          	cmp    $0xa,%rdx
  2c0038:	75 f3                	jne    2c002d <process_main+0x2d>
    }

    // realloc array to size 20
    array = (int*)realloc(array, sizeof(int) * 20);
  2c003a:	be 50 00 00 00       	mov    $0x50,%esi
  2c003f:	e8 d6 02 00 00       	call   2c031a <realloc>
  2c0044:	49 89 c5             	mov    %rax,%r13
  2c0047:	b8 00 00 00 00       	mov    $0x0,%eax

    // check if contents are same
    for(int i = 0 ; i < 10 ; i++){
	assert(array[i] == i);
  2c004c:	41 39 44 85 00       	cmp    %eax,0x0(%r13,%rax,4)
  2c0051:	75 64                	jne    2c00b7 <process_main+0xb7>
    for(int i = 0 ; i < 10 ; i++){
  2c0053:	48 83 c0 01          	add    $0x1,%rax
  2c0057:	48 83 f8 0a          	cmp    $0xa,%rax
  2c005b:	75 ef                	jne    2c004c <process_main+0x4c>
    }

    // alloc int array of size 30 using calloc
    int * array2 = (int *)calloc(30, sizeof(int));
  2c005d:	be 04 00 00 00       	mov    $0x4,%esi
  2c0062:	bf 1e 00 00 00       	mov    $0x1e,%edi
  2c0067:	e8 a8 02 00 00       	call   2c0314 <calloc>
  2c006c:	49 89 c6             	mov    %rax,%r14

    // assert array[i] == 0
    for(int i = 0 ; i < 30; i++){
  2c006f:	48 8d 50 78          	lea    0x78(%rax),%rdx
	assert(array2[i] == 0);
  2c0073:	8b 18                	mov    (%rax),%ebx
  2c0075:	85 db                	test   %ebx,%ebx
  2c0077:	75 52                	jne    2c00cb <process_main+0xcb>
    for(int i = 0 ; i < 30; i++){
  2c0079:	48 83 c0 04          	add    $0x4,%rax
  2c007d:	48 39 d0             	cmp    %rdx,%rax
  2c0080:	75 f1                	jne    2c0073 <process_main+0x73>
    }
    
    heap_info_struct info;
    if(heap_info(&info) == 0){
  2c0082:	48 8d 7d c0          	lea    -0x40(%rbp),%rdi
  2c0086:	e8 96 02 00 00       	call   2c0321 <heap_info>
  2c008b:	85 c0                	test   %eax,%eax
  2c008d:	75 64                	jne    2c00f3 <process_main+0xf3>
	// check if allocations are in sorted order
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c008f:	8b 55 c0             	mov    -0x40(%rbp),%edx
  2c0092:	83 fa 01             	cmp    $0x1,%edx
  2c0095:	7e 70                	jle    2c0107 <process_main+0x107>
  2c0097:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c009b:	8d 52 fe             	lea    -0x2(%rdx),%edx
  2c009e:	48 8d 54 d0 08       	lea    0x8(%rax,%rdx,8),%rdx
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00a3:	48 8b 30             	mov    (%rax),%rsi
  2c00a6:	48 39 70 08          	cmp    %rsi,0x8(%rax)
  2c00aa:	7d 33                	jge    2c00df <process_main+0xdf>
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c00ac:	48 83 c0 08          	add    $0x8,%rax
  2c00b0:	48 39 d0             	cmp    %rdx,%rax
  2c00b3:	75 ee                	jne    2c00a3 <process_main+0xa3>
  2c00b5:	eb 50                	jmp    2c0107 <process_main+0x107>
	assert(array[i] == i);
  2c00b7:	ba 80 13 2c 00       	mov    $0x2c1380,%edx
  2c00bc:	be 19 00 00 00       	mov    $0x19,%esi
  2c00c1:	bf 8e 13 2c 00       	mov    $0x2c138e,%edi
  2c00c6:	e8 13 02 00 00       	call   2c02de <assert_fail>
	assert(array2[i] == 0);
  2c00cb:	ba a4 13 2c 00       	mov    $0x2c13a4,%edx
  2c00d0:	be 21 00 00 00       	mov    $0x21,%esi
  2c00d5:	bf 8e 13 2c 00       	mov    $0x2c138e,%edi
  2c00da:	e8 ff 01 00 00       	call   2c02de <assert_fail>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00df:	ba c8 13 2c 00       	mov    $0x2c13c8,%edx
  2c00e4:	be 28 00 00 00       	mov    $0x28,%esi
  2c00e9:	bf 8e 13 2c 00       	mov    $0x2c138e,%edi
  2c00ee:	e8 eb 01 00 00       	call   2c02de <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c00f3:	be b3 13 2c 00       	mov    $0x2c13b3,%esi
  2c00f8:	bf 00 00 00 00       	mov    $0x0,%edi
  2c00fd:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0102:	e8 79 00 00 00       	call   2c0180 <app_printf>
    }
    
    // free array, array2
    free(array);
  2c0107:	4c 89 ef             	mov    %r13,%rdi
  2c010a:	e8 fe 01 00 00       	call   2c030d <free>
    free(array2);
  2c010f:	4c 89 f7             	mov    %r14,%rdi
  2c0112:	e8 f6 01 00 00       	call   2c030d <free>

    uint64_t total_time = 0;
  2c0117:	41 bd 00 00 00 00    	mov    $0x0,%r13d
/* rdtscp */
static uint64_t rdtsc(void) {
	uint64_t var;
	uint32_t hi, lo;

	__asm volatile
  2c011d:	0f 31                	rdtsc  
	    ("rdtsc" : "=a" (lo), "=d" (hi));

	var = ((uint64_t)hi << 32) | lo;
  2c011f:	48 c1 e2 20          	shl    $0x20,%rdx
  2c0123:	89 c0                	mov    %eax,%eax
  2c0125:	48 09 c2             	or     %rax,%rdx
  2c0128:	49 89 d6             	mov    %rdx,%r14
    int total_pages = 0;
    
    // allocate pages till no more memory
    while (1) {
	uint64_t time = rdtsc();
	void * ptr = malloc(PAGESIZE);
  2c012b:	bf 00 10 00 00       	mov    $0x1000,%edi
  2c0130:	e8 d9 01 00 00       	call   2c030e <malloc>
  2c0135:	48 89 c1             	mov    %rax,%rcx
	__asm volatile
  2c0138:	0f 31                	rdtsc  
	var = ((uint64_t)hi << 32) | lo;
  2c013a:	48 c1 e2 20          	shl    $0x20,%rdx
  2c013e:	89 c0                	mov    %eax,%eax
  2c0140:	48 09 c2             	or     %rax,%rdx
	total_time += (rdtsc() - time);
  2c0143:	4c 29 f2             	sub    %r14,%rdx
  2c0146:	49 01 d5             	add    %rdx,%r13
	if(ptr == NULL)
  2c0149:	48 85 c9             	test   %rcx,%rcx
  2c014c:	74 08                	je     2c0156 <process_main+0x156>
	    break;
	total_pages++;
  2c014e:	83 c3 01             	add    $0x1,%ebx
	*((int *)ptr) = p; // check write access
  2c0151:	44 89 21             	mov    %r12d,(%rcx)
    while (1) {
  2c0154:	eb c7                	jmp    2c011d <process_main+0x11d>
    }

    app_printf(p, "Total_time taken to alloc: %d Average time: %d\n", total_time, total_time/total_pages);
  2c0156:	48 63 db             	movslq %ebx,%rbx
  2c0159:	4c 89 e8             	mov    %r13,%rax
  2c015c:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0161:	48 f7 f3             	div    %rbx
  2c0164:	48 89 c1             	mov    %rax,%rcx
  2c0167:	4c 89 ea             	mov    %r13,%rdx
  2c016a:	be f8 13 2c 00       	mov    $0x2c13f8,%esi
  2c016f:	44 89 e7             	mov    %r12d,%edi
  2c0172:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0177:	e8 04 00 00 00       	call   2c0180 <app_printf>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  2c017c:	cd 32                	int    $0x32
  2c017e:	eb fc                	jmp    2c017c <process_main+0x17c>

00000000002c0180 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  2c0180:	55                   	push   %rbp
  2c0181:	48 89 e5             	mov    %rsp,%rbp
  2c0184:	48 83 ec 50          	sub    $0x50,%rsp
  2c0188:	49 89 f2             	mov    %rsi,%r10
  2c018b:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c018f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c0193:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c0197:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  2c019b:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  2c01a0:	85 ff                	test   %edi,%edi
  2c01a2:	78 2e                	js     2c01d2 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  2c01a4:	48 63 ff             	movslq %edi,%rdi
  2c01a7:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  2c01ae:	cc cc cc 
  2c01b1:	48 89 f8             	mov    %rdi,%rax
  2c01b4:	48 f7 e2             	mul    %rdx
  2c01b7:	48 89 d0             	mov    %rdx,%rax
  2c01ba:	48 c1 e8 02          	shr    $0x2,%rax
  2c01be:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  2c01c2:	48 01 c2             	add    %rax,%rdx
  2c01c5:	48 29 d7             	sub    %rdx,%rdi
  2c01c8:	0f b6 b7 5d 14 2c 00 	movzbl 0x2c145d(%rdi),%esi
  2c01cf:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  2c01d2:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  2c01d9:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c01dd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c01e1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c01e5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  2c01e9:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c01ed:	4c 89 d2             	mov    %r10,%rdx
  2c01f0:	8b 3d 06 8e df ff    	mov    -0x2071fa(%rip),%edi        # b8ffc <cursorpos>
  2c01f6:	e8 75 0f 00 00       	call   2c1170 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  2c01fb:	3d 30 07 00 00       	cmp    $0x730,%eax
  2c0200:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0205:	0f 4d c2             	cmovge %edx,%eax
  2c0208:	89 05 ee 8d df ff    	mov    %eax,-0x207212(%rip)        # b8ffc <cursorpos>
    }
}
  2c020e:	c9                   	leave  
  2c020f:	c3                   	ret    

00000000002c0210 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  2c0210:	55                   	push   %rbp
  2c0211:	48 89 e5             	mov    %rsp,%rbp
  2c0214:	53                   	push   %rbx
  2c0215:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  2c021c:	48 89 fb             	mov    %rdi,%rbx
  2c021f:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  2c0223:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  2c0227:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  2c022b:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  2c022f:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  2c0233:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  2c023a:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c023e:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  2c0242:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  2c0246:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  2c024a:	ba 07 00 00 00       	mov    $0x7,%edx
  2c024f:	be 28 14 2c 00       	mov    $0x2c1428,%esi
  2c0254:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  2c025b:	e8 c7 00 00 00       	call   2c0327 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0260:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0264:	48 89 da             	mov    %rbx,%rdx
  2c0267:	be 99 00 00 00       	mov    $0x99,%esi
  2c026c:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c0273:	e8 04 10 00 00       	call   2c127c <vsnprintf>
  2c0278:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  2c027b:	85 d2                	test   %edx,%edx
  2c027d:	7e 0f                	jle    2c028e <kernel_panic+0x7e>
  2c027f:	83 c0 06             	add    $0x6,%eax
  2c0282:	48 98                	cltq   
  2c0284:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  2c028b:	0a 
  2c028c:	75 2a                	jne    2c02b8 <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  2c028e:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  2c0295:	48 89 d9             	mov    %rbx,%rcx
  2c0298:	ba 30 14 2c 00       	mov    $0x2c1430,%edx
  2c029d:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02a2:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02a7:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ac:	e8 2b 0f 00 00       	call   2c11dc <console_printf>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  2c02b1:	48 89 df             	mov    %rbx,%rdi
  2c02b4:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  2c02b6:	eb fe                	jmp    2c02b6 <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  2c02b8:	48 63 c2             	movslq %edx,%rax
  2c02bb:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  2c02c1:	0f 94 c2             	sete   %dl
  2c02c4:	0f b6 d2             	movzbl %dl,%edx
  2c02c7:	48 29 d0             	sub    %rdx,%rax
  2c02ca:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  2c02d1:	ff 
  2c02d2:	be c3 13 2c 00       	mov    $0x2c13c3,%esi
  2c02d7:	e8 f8 01 00 00       	call   2c04d4 <strcpy>
  2c02dc:	eb b0                	jmp    2c028e <kernel_panic+0x7e>

00000000002c02de <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  2c02de:	55                   	push   %rbp
  2c02df:	48 89 e5             	mov    %rsp,%rbp
  2c02e2:	48 89 f9             	mov    %rdi,%rcx
  2c02e5:	41 89 f0             	mov    %esi,%r8d
  2c02e8:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  2c02eb:	ba 38 14 2c 00       	mov    $0x2c1438,%edx
  2c02f0:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02f5:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02fa:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ff:	e8 d8 0e 00 00       	call   2c11dc <console_printf>
    asm volatile ("int %0" : /* no result */
  2c0304:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0309:	cd 30                	int    $0x30
 loop: goto loop;
  2c030b:	eb fe                	jmp    2c030b <assert_fail+0x2d>

00000000002c030d <free>:
#include "malloc.h"

void free(void *firstbyte) {
    return;
}
  2c030d:	c3                   	ret    

00000000002c030e <malloc>:

void *malloc(uint64_t numbytes) {
    return 0 ;
}
  2c030e:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0313:	c3                   	ret    

00000000002c0314 <calloc>:


void * calloc(uint64_t num, uint64_t sz) {
    return 0;
}
  2c0314:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0319:	c3                   	ret    

00000000002c031a <realloc>:

void * realloc(void * ptr, uint64_t sz) {
    return 0;
}
  2c031a:	b8 00 00 00 00       	mov    $0x0,%eax
  2c031f:	c3                   	ret    

00000000002c0320 <defrag>:

void defrag() {
}
  2c0320:	c3                   	ret    

00000000002c0321 <heap_info>:

int heap_info(heap_info_struct * info) {
    return 0;
}
  2c0321:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0326:	c3                   	ret    

00000000002c0327 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c0327:	55                   	push   %rbp
  2c0328:	48 89 e5             	mov    %rsp,%rbp
  2c032b:	48 83 ec 28          	sub    $0x28,%rsp
  2c032f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0333:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0337:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c033b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c033f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0343:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0347:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c034b:	eb 1c                	jmp    2c0369 <memcpy+0x42>
        *d = *s;
  2c034d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0351:	0f b6 10             	movzbl (%rax),%edx
  2c0354:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0358:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c035a:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c035f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0364:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c0369:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c036e:	75 dd                	jne    2c034d <memcpy+0x26>
    }
    return dst;
  2c0370:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0374:	c9                   	leave  
  2c0375:	c3                   	ret    

00000000002c0376 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c0376:	55                   	push   %rbp
  2c0377:	48 89 e5             	mov    %rsp,%rbp
  2c037a:	48 83 ec 28          	sub    $0x28,%rsp
  2c037e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0382:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0386:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c038a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c038e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c0392:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0396:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c039a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c039e:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c03a2:	73 6a                	jae    2c040e <memmove+0x98>
  2c03a4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c03a8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c03ac:	48 01 d0             	add    %rdx,%rax
  2c03af:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c03b3:	73 59                	jae    2c040e <memmove+0x98>
        s += n, d += n;
  2c03b5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c03b9:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c03bd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c03c1:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c03c5:	eb 17                	jmp    2c03de <memmove+0x68>
            *--d = *--s;
  2c03c7:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c03cc:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c03d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c03d5:	0f b6 10             	movzbl (%rax),%edx
  2c03d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c03dc:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c03de:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c03e2:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c03e6:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c03ea:	48 85 c0             	test   %rax,%rax
  2c03ed:	75 d8                	jne    2c03c7 <memmove+0x51>
    if (s < d && s + n > d) {
  2c03ef:	eb 2e                	jmp    2c041f <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c03f1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c03f5:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c03f9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c03fd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0401:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0405:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c0409:	0f b6 12             	movzbl (%rdx),%edx
  2c040c:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c040e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0412:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0416:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c041a:	48 85 c0             	test   %rax,%rax
  2c041d:	75 d2                	jne    2c03f1 <memmove+0x7b>
        }
    }
    return dst;
  2c041f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0423:	c9                   	leave  
  2c0424:	c3                   	ret    

00000000002c0425 <memset>:

void* memset(void* v, int c, size_t n) {
  2c0425:	55                   	push   %rbp
  2c0426:	48 89 e5             	mov    %rsp,%rbp
  2c0429:	48 83 ec 28          	sub    $0x28,%rsp
  2c042d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0431:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c0434:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0438:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c043c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0440:	eb 15                	jmp    2c0457 <memset+0x32>
        *p = c;
  2c0442:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0445:	89 c2                	mov    %eax,%edx
  2c0447:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c044b:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c044d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0452:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0457:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c045c:	75 e4                	jne    2c0442 <memset+0x1d>
    }
    return v;
  2c045e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0462:	c9                   	leave  
  2c0463:	c3                   	ret    

00000000002c0464 <strlen>:

size_t strlen(const char* s) {
  2c0464:	55                   	push   %rbp
  2c0465:	48 89 e5             	mov    %rsp,%rbp
  2c0468:	48 83 ec 18          	sub    $0x18,%rsp
  2c046c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c0470:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0477:	00 
  2c0478:	eb 0a                	jmp    2c0484 <strlen+0x20>
        ++n;
  2c047a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c047f:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0484:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0488:	0f b6 00             	movzbl (%rax),%eax
  2c048b:	84 c0                	test   %al,%al
  2c048d:	75 eb                	jne    2c047a <strlen+0x16>
    }
    return n;
  2c048f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0493:	c9                   	leave  
  2c0494:	c3                   	ret    

00000000002c0495 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c0495:	55                   	push   %rbp
  2c0496:	48 89 e5             	mov    %rsp,%rbp
  2c0499:	48 83 ec 20          	sub    $0x20,%rsp
  2c049d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c04a1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c04a5:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c04ac:	00 
  2c04ad:	eb 0a                	jmp    2c04b9 <strnlen+0x24>
        ++n;
  2c04af:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c04b4:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c04b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c04bd:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c04c1:	74 0b                	je     2c04ce <strnlen+0x39>
  2c04c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c04c7:	0f b6 00             	movzbl (%rax),%eax
  2c04ca:	84 c0                	test   %al,%al
  2c04cc:	75 e1                	jne    2c04af <strnlen+0x1a>
    }
    return n;
  2c04ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c04d2:	c9                   	leave  
  2c04d3:	c3                   	ret    

00000000002c04d4 <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c04d4:	55                   	push   %rbp
  2c04d5:	48 89 e5             	mov    %rsp,%rbp
  2c04d8:	48 83 ec 20          	sub    $0x20,%rsp
  2c04dc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c04e0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c04e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c04e8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c04ec:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c04f0:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c04f4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c04f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c04fc:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0500:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c0504:	0f b6 12             	movzbl (%rdx),%edx
  2c0507:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c0509:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c050d:	48 83 e8 01          	sub    $0x1,%rax
  2c0511:	0f b6 00             	movzbl (%rax),%eax
  2c0514:	84 c0                	test   %al,%al
  2c0516:	75 d4                	jne    2c04ec <strcpy+0x18>
    return dst;
  2c0518:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c051c:	c9                   	leave  
  2c051d:	c3                   	ret    

00000000002c051e <strcmp>:

int strcmp(const char* a, const char* b) {
  2c051e:	55                   	push   %rbp
  2c051f:	48 89 e5             	mov    %rsp,%rbp
  2c0522:	48 83 ec 10          	sub    $0x10,%rsp
  2c0526:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c052a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c052e:	eb 0a                	jmp    2c053a <strcmp+0x1c>
        ++a, ++b;
  2c0530:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0535:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c053a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c053e:	0f b6 00             	movzbl (%rax),%eax
  2c0541:	84 c0                	test   %al,%al
  2c0543:	74 1d                	je     2c0562 <strcmp+0x44>
  2c0545:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0549:	0f b6 00             	movzbl (%rax),%eax
  2c054c:	84 c0                	test   %al,%al
  2c054e:	74 12                	je     2c0562 <strcmp+0x44>
  2c0550:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0554:	0f b6 10             	movzbl (%rax),%edx
  2c0557:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c055b:	0f b6 00             	movzbl (%rax),%eax
  2c055e:	38 c2                	cmp    %al,%dl
  2c0560:	74 ce                	je     2c0530 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c0562:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0566:	0f b6 00             	movzbl (%rax),%eax
  2c0569:	89 c2                	mov    %eax,%edx
  2c056b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c056f:	0f b6 00             	movzbl (%rax),%eax
  2c0572:	38 d0                	cmp    %dl,%al
  2c0574:	0f 92 c0             	setb   %al
  2c0577:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c057a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c057e:	0f b6 00             	movzbl (%rax),%eax
  2c0581:	89 c1                	mov    %eax,%ecx
  2c0583:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0587:	0f b6 00             	movzbl (%rax),%eax
  2c058a:	38 c1                	cmp    %al,%cl
  2c058c:	0f 92 c0             	setb   %al
  2c058f:	0f b6 c0             	movzbl %al,%eax
  2c0592:	29 c2                	sub    %eax,%edx
  2c0594:	89 d0                	mov    %edx,%eax
}
  2c0596:	c9                   	leave  
  2c0597:	c3                   	ret    

00000000002c0598 <strchr>:

char* strchr(const char* s, int c) {
  2c0598:	55                   	push   %rbp
  2c0599:	48 89 e5             	mov    %rsp,%rbp
  2c059c:	48 83 ec 10          	sub    $0x10,%rsp
  2c05a0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c05a4:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c05a7:	eb 05                	jmp    2c05ae <strchr+0x16>
        ++s;
  2c05a9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c05ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c05b2:	0f b6 00             	movzbl (%rax),%eax
  2c05b5:	84 c0                	test   %al,%al
  2c05b7:	74 0e                	je     2c05c7 <strchr+0x2f>
  2c05b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c05bd:	0f b6 00             	movzbl (%rax),%eax
  2c05c0:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c05c3:	38 d0                	cmp    %dl,%al
  2c05c5:	75 e2                	jne    2c05a9 <strchr+0x11>
    }
    if (*s == (char) c) {
  2c05c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c05cb:	0f b6 00             	movzbl (%rax),%eax
  2c05ce:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c05d1:	38 d0                	cmp    %dl,%al
  2c05d3:	75 06                	jne    2c05db <strchr+0x43>
        return (char*) s;
  2c05d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c05d9:	eb 05                	jmp    2c05e0 <strchr+0x48>
    } else {
        return NULL;
  2c05db:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c05e0:	c9                   	leave  
  2c05e1:	c3                   	ret    

00000000002c05e2 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c05e2:	55                   	push   %rbp
  2c05e3:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c05e6:	8b 05 14 1a 00 00    	mov    0x1a14(%rip),%eax        # 2c2000 <rand_seed_set>
  2c05ec:	85 c0                	test   %eax,%eax
  2c05ee:	75 0a                	jne    2c05fa <rand+0x18>
        srand(819234718U);
  2c05f0:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c05f5:	e8 24 00 00 00       	call   2c061e <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c05fa:	8b 05 04 1a 00 00    	mov    0x1a04(%rip),%eax        # 2c2004 <rand_seed>
  2c0600:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c0606:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c060b:	89 05 f3 19 00 00    	mov    %eax,0x19f3(%rip)        # 2c2004 <rand_seed>
    return rand_seed & RAND_MAX;
  2c0611:	8b 05 ed 19 00 00    	mov    0x19ed(%rip),%eax        # 2c2004 <rand_seed>
  2c0617:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c061c:	5d                   	pop    %rbp
  2c061d:	c3                   	ret    

00000000002c061e <srand>:

void srand(unsigned seed) {
  2c061e:	55                   	push   %rbp
  2c061f:	48 89 e5             	mov    %rsp,%rbp
  2c0622:	48 83 ec 08          	sub    $0x8,%rsp
  2c0626:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c0629:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c062c:	89 05 d2 19 00 00    	mov    %eax,0x19d2(%rip)        # 2c2004 <rand_seed>
    rand_seed_set = 1;
  2c0632:	c7 05 c4 19 00 00 01 	movl   $0x1,0x19c4(%rip)        # 2c2000 <rand_seed_set>
  2c0639:	00 00 00 
}
  2c063c:	90                   	nop
  2c063d:	c9                   	leave  
  2c063e:	c3                   	ret    

00000000002c063f <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c063f:	55                   	push   %rbp
  2c0640:	48 89 e5             	mov    %rsp,%rbp
  2c0643:	48 83 ec 28          	sub    $0x28,%rsp
  2c0647:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c064b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c064f:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c0652:	48 c7 45 f8 50 16 2c 	movq   $0x2c1650,-0x8(%rbp)
  2c0659:	00 
    if (base < 0) {
  2c065a:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c065e:	79 0b                	jns    2c066b <fill_numbuf+0x2c>
        digits = lower_digits;
  2c0660:	48 c7 45 f8 70 16 2c 	movq   $0x2c1670,-0x8(%rbp)
  2c0667:	00 
        base = -base;
  2c0668:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c066b:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0670:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0674:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c0677:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c067a:	48 63 c8             	movslq %eax,%rcx
  2c067d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0681:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0686:	48 f7 f1             	div    %rcx
  2c0689:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c068d:	48 01 d0             	add    %rdx,%rax
  2c0690:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0695:	0f b6 10             	movzbl (%rax),%edx
  2c0698:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c069c:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c069e:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c06a1:	48 63 f0             	movslq %eax,%rsi
  2c06a4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c06a8:	ba 00 00 00 00       	mov    $0x0,%edx
  2c06ad:	48 f7 f6             	div    %rsi
  2c06b0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c06b4:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c06b9:	75 bc                	jne    2c0677 <fill_numbuf+0x38>
    return numbuf_end;
  2c06bb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c06bf:	c9                   	leave  
  2c06c0:	c3                   	ret    

00000000002c06c1 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c06c1:	55                   	push   %rbp
  2c06c2:	48 89 e5             	mov    %rsp,%rbp
  2c06c5:	53                   	push   %rbx
  2c06c6:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c06cd:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c06d4:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c06da:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c06e1:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c06e8:	e9 8a 09 00 00       	jmp    2c1077 <printer_vprintf+0x9b6>
        if (*format != '%') {
  2c06ed:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c06f4:	0f b6 00             	movzbl (%rax),%eax
  2c06f7:	3c 25                	cmp    $0x25,%al
  2c06f9:	74 31                	je     2c072c <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  2c06fb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0702:	4c 8b 00             	mov    (%rax),%r8
  2c0705:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c070c:	0f b6 00             	movzbl (%rax),%eax
  2c070f:	0f b6 c8             	movzbl %al,%ecx
  2c0712:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c0718:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c071f:	89 ce                	mov    %ecx,%esi
  2c0721:	48 89 c7             	mov    %rax,%rdi
  2c0724:	41 ff d0             	call   *%r8
            continue;
  2c0727:	e9 43 09 00 00       	jmp    2c106f <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  2c072c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0733:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c073a:	01 
  2c073b:	eb 44                	jmp    2c0781 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  2c073d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0744:	0f b6 00             	movzbl (%rax),%eax
  2c0747:	0f be c0             	movsbl %al,%eax
  2c074a:	89 c6                	mov    %eax,%esi
  2c074c:	bf 70 14 2c 00       	mov    $0x2c1470,%edi
  2c0751:	e8 42 fe ff ff       	call   2c0598 <strchr>
  2c0756:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c075a:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c075f:	74 30                	je     2c0791 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  2c0761:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c0765:	48 2d 70 14 2c 00    	sub    $0x2c1470,%rax
  2c076b:	ba 01 00 00 00       	mov    $0x1,%edx
  2c0770:	89 c1                	mov    %eax,%ecx
  2c0772:	d3 e2                	shl    %cl,%edx
  2c0774:	89 d0                	mov    %edx,%eax
  2c0776:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0779:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0780:	01 
  2c0781:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0788:	0f b6 00             	movzbl (%rax),%eax
  2c078b:	84 c0                	test   %al,%al
  2c078d:	75 ae                	jne    2c073d <printer_vprintf+0x7c>
  2c078f:	eb 01                	jmp    2c0792 <printer_vprintf+0xd1>
            } else {
                break;
  2c0791:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c0792:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c0799:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c07a0:	0f b6 00             	movzbl (%rax),%eax
  2c07a3:	3c 30                	cmp    $0x30,%al
  2c07a5:	7e 67                	jle    2c080e <printer_vprintf+0x14d>
  2c07a7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c07ae:	0f b6 00             	movzbl (%rax),%eax
  2c07b1:	3c 39                	cmp    $0x39,%al
  2c07b3:	7f 59                	jg     2c080e <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c07b5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c07bc:	eb 2e                	jmp    2c07ec <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  2c07be:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c07c1:	89 d0                	mov    %edx,%eax
  2c07c3:	c1 e0 02             	shl    $0x2,%eax
  2c07c6:	01 d0                	add    %edx,%eax
  2c07c8:	01 c0                	add    %eax,%eax
  2c07ca:	89 c1                	mov    %eax,%ecx
  2c07cc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c07d3:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c07d7:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c07de:	0f b6 00             	movzbl (%rax),%eax
  2c07e1:	0f be c0             	movsbl %al,%eax
  2c07e4:	01 c8                	add    %ecx,%eax
  2c07e6:	83 e8 30             	sub    $0x30,%eax
  2c07e9:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c07ec:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c07f3:	0f b6 00             	movzbl (%rax),%eax
  2c07f6:	3c 2f                	cmp    $0x2f,%al
  2c07f8:	0f 8e 85 00 00 00    	jle    2c0883 <printer_vprintf+0x1c2>
  2c07fe:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0805:	0f b6 00             	movzbl (%rax),%eax
  2c0808:	3c 39                	cmp    $0x39,%al
  2c080a:	7e b2                	jle    2c07be <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  2c080c:	eb 75                	jmp    2c0883 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  2c080e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0815:	0f b6 00             	movzbl (%rax),%eax
  2c0818:	3c 2a                	cmp    $0x2a,%al
  2c081a:	75 68                	jne    2c0884 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  2c081c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0823:	8b 00                	mov    (%rax),%eax
  2c0825:	83 f8 2f             	cmp    $0x2f,%eax
  2c0828:	77 30                	ja     2c085a <printer_vprintf+0x199>
  2c082a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0831:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0835:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c083c:	8b 00                	mov    (%rax),%eax
  2c083e:	89 c0                	mov    %eax,%eax
  2c0840:	48 01 d0             	add    %rdx,%rax
  2c0843:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c084a:	8b 12                	mov    (%rdx),%edx
  2c084c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c084f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0856:	89 0a                	mov    %ecx,(%rdx)
  2c0858:	eb 1a                	jmp    2c0874 <printer_vprintf+0x1b3>
  2c085a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0861:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0865:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0869:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0870:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0874:	8b 00                	mov    (%rax),%eax
  2c0876:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c0879:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0880:	01 
  2c0881:	eb 01                	jmp    2c0884 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  2c0883:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c0884:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c088b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0892:	0f b6 00             	movzbl (%rax),%eax
  2c0895:	3c 2e                	cmp    $0x2e,%al
  2c0897:	0f 85 00 01 00 00    	jne    2c099d <printer_vprintf+0x2dc>
            ++format;
  2c089d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c08a4:	01 
            if (*format >= '0' && *format <= '9') {
  2c08a5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c08ac:	0f b6 00             	movzbl (%rax),%eax
  2c08af:	3c 2f                	cmp    $0x2f,%al
  2c08b1:	7e 67                	jle    2c091a <printer_vprintf+0x259>
  2c08b3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c08ba:	0f b6 00             	movzbl (%rax),%eax
  2c08bd:	3c 39                	cmp    $0x39,%al
  2c08bf:	7f 59                	jg     2c091a <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c08c1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c08c8:	eb 2e                	jmp    2c08f8 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  2c08ca:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c08cd:	89 d0                	mov    %edx,%eax
  2c08cf:	c1 e0 02             	shl    $0x2,%eax
  2c08d2:	01 d0                	add    %edx,%eax
  2c08d4:	01 c0                	add    %eax,%eax
  2c08d6:	89 c1                	mov    %eax,%ecx
  2c08d8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c08df:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c08e3:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c08ea:	0f b6 00             	movzbl (%rax),%eax
  2c08ed:	0f be c0             	movsbl %al,%eax
  2c08f0:	01 c8                	add    %ecx,%eax
  2c08f2:	83 e8 30             	sub    $0x30,%eax
  2c08f5:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c08f8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c08ff:	0f b6 00             	movzbl (%rax),%eax
  2c0902:	3c 2f                	cmp    $0x2f,%al
  2c0904:	0f 8e 85 00 00 00    	jle    2c098f <printer_vprintf+0x2ce>
  2c090a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0911:	0f b6 00             	movzbl (%rax),%eax
  2c0914:	3c 39                	cmp    $0x39,%al
  2c0916:	7e b2                	jle    2c08ca <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  2c0918:	eb 75                	jmp    2c098f <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  2c091a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0921:	0f b6 00             	movzbl (%rax),%eax
  2c0924:	3c 2a                	cmp    $0x2a,%al
  2c0926:	75 68                	jne    2c0990 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  2c0928:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c092f:	8b 00                	mov    (%rax),%eax
  2c0931:	83 f8 2f             	cmp    $0x2f,%eax
  2c0934:	77 30                	ja     2c0966 <printer_vprintf+0x2a5>
  2c0936:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c093d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0941:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0948:	8b 00                	mov    (%rax),%eax
  2c094a:	89 c0                	mov    %eax,%eax
  2c094c:	48 01 d0             	add    %rdx,%rax
  2c094f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0956:	8b 12                	mov    (%rdx),%edx
  2c0958:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c095b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0962:	89 0a                	mov    %ecx,(%rdx)
  2c0964:	eb 1a                	jmp    2c0980 <printer_vprintf+0x2bf>
  2c0966:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c096d:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0971:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0975:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c097c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0980:	8b 00                	mov    (%rax),%eax
  2c0982:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c0985:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c098c:	01 
  2c098d:	eb 01                	jmp    2c0990 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  2c098f:	90                   	nop
            }
            if (precision < 0) {
  2c0990:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c0994:	79 07                	jns    2c099d <printer_vprintf+0x2dc>
                precision = 0;
  2c0996:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c099d:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c09a4:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c09ab:	00 
        int length = 0;
  2c09ac:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c09b3:	48 c7 45 c8 76 14 2c 	movq   $0x2c1476,-0x38(%rbp)
  2c09ba:	00 
    again:
        switch (*format) {
  2c09bb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c09c2:	0f b6 00             	movzbl (%rax),%eax
  2c09c5:	0f be c0             	movsbl %al,%eax
  2c09c8:	83 e8 43             	sub    $0x43,%eax
  2c09cb:	83 f8 37             	cmp    $0x37,%eax
  2c09ce:	0f 87 9f 03 00 00    	ja     2c0d73 <printer_vprintf+0x6b2>
  2c09d4:	89 c0                	mov    %eax,%eax
  2c09d6:	48 8b 04 c5 88 14 2c 	mov    0x2c1488(,%rax,8),%rax
  2c09dd:	00 
  2c09de:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  2c09e0:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c09e7:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c09ee:	01 
            goto again;
  2c09ef:	eb ca                	jmp    2c09bb <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c09f1:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c09f5:	74 5d                	je     2c0a54 <printer_vprintf+0x393>
  2c09f7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c09fe:	8b 00                	mov    (%rax),%eax
  2c0a00:	83 f8 2f             	cmp    $0x2f,%eax
  2c0a03:	77 30                	ja     2c0a35 <printer_vprintf+0x374>
  2c0a05:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0a0c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0a10:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0a17:	8b 00                	mov    (%rax),%eax
  2c0a19:	89 c0                	mov    %eax,%eax
  2c0a1b:	48 01 d0             	add    %rdx,%rax
  2c0a1e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0a25:	8b 12                	mov    (%rdx),%edx
  2c0a27:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0a2a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0a31:	89 0a                	mov    %ecx,(%rdx)
  2c0a33:	eb 1a                	jmp    2c0a4f <printer_vprintf+0x38e>
  2c0a35:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0a3c:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0a40:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0a44:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0a4b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0a4f:	48 8b 00             	mov    (%rax),%rax
  2c0a52:	eb 5c                	jmp    2c0ab0 <printer_vprintf+0x3ef>
  2c0a54:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0a5b:	8b 00                	mov    (%rax),%eax
  2c0a5d:	83 f8 2f             	cmp    $0x2f,%eax
  2c0a60:	77 30                	ja     2c0a92 <printer_vprintf+0x3d1>
  2c0a62:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0a69:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0a6d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0a74:	8b 00                	mov    (%rax),%eax
  2c0a76:	89 c0                	mov    %eax,%eax
  2c0a78:	48 01 d0             	add    %rdx,%rax
  2c0a7b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0a82:	8b 12                	mov    (%rdx),%edx
  2c0a84:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0a87:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0a8e:	89 0a                	mov    %ecx,(%rdx)
  2c0a90:	eb 1a                	jmp    2c0aac <printer_vprintf+0x3eb>
  2c0a92:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0a99:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0a9d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0aa1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0aa8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0aac:	8b 00                	mov    (%rax),%eax
  2c0aae:	48 98                	cltq   
  2c0ab0:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c0ab4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0ab8:	48 c1 f8 38          	sar    $0x38,%rax
  2c0abc:	25 80 00 00 00       	and    $0x80,%eax
  2c0ac1:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c0ac4:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c0ac8:	74 09                	je     2c0ad3 <printer_vprintf+0x412>
  2c0aca:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0ace:	48 f7 d8             	neg    %rax
  2c0ad1:	eb 04                	jmp    2c0ad7 <printer_vprintf+0x416>
  2c0ad3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0ad7:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c0adb:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c0ade:	83 c8 60             	or     $0x60,%eax
  2c0ae1:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c0ae4:	e9 cf 02 00 00       	jmp    2c0db8 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c0ae9:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0aed:	74 5d                	je     2c0b4c <printer_vprintf+0x48b>
  2c0aef:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0af6:	8b 00                	mov    (%rax),%eax
  2c0af8:	83 f8 2f             	cmp    $0x2f,%eax
  2c0afb:	77 30                	ja     2c0b2d <printer_vprintf+0x46c>
  2c0afd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b04:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0b08:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b0f:	8b 00                	mov    (%rax),%eax
  2c0b11:	89 c0                	mov    %eax,%eax
  2c0b13:	48 01 d0             	add    %rdx,%rax
  2c0b16:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0b1d:	8b 12                	mov    (%rdx),%edx
  2c0b1f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0b22:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0b29:	89 0a                	mov    %ecx,(%rdx)
  2c0b2b:	eb 1a                	jmp    2c0b47 <printer_vprintf+0x486>
  2c0b2d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b34:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0b38:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0b3c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0b43:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0b47:	48 8b 00             	mov    (%rax),%rax
  2c0b4a:	eb 5c                	jmp    2c0ba8 <printer_vprintf+0x4e7>
  2c0b4c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b53:	8b 00                	mov    (%rax),%eax
  2c0b55:	83 f8 2f             	cmp    $0x2f,%eax
  2c0b58:	77 30                	ja     2c0b8a <printer_vprintf+0x4c9>
  2c0b5a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b61:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0b65:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b6c:	8b 00                	mov    (%rax),%eax
  2c0b6e:	89 c0                	mov    %eax,%eax
  2c0b70:	48 01 d0             	add    %rdx,%rax
  2c0b73:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0b7a:	8b 12                	mov    (%rdx),%edx
  2c0b7c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0b7f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0b86:	89 0a                	mov    %ecx,(%rdx)
  2c0b88:	eb 1a                	jmp    2c0ba4 <printer_vprintf+0x4e3>
  2c0b8a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b91:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0b95:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0b99:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ba0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0ba4:	8b 00                	mov    (%rax),%eax
  2c0ba6:	89 c0                	mov    %eax,%eax
  2c0ba8:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c0bac:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c0bb0:	e9 03 02 00 00       	jmp    2c0db8 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  2c0bb5:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c0bbc:	e9 28 ff ff ff       	jmp    2c0ae9 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  2c0bc1:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c0bc8:	e9 1c ff ff ff       	jmp    2c0ae9 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c0bcd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bd4:	8b 00                	mov    (%rax),%eax
  2c0bd6:	83 f8 2f             	cmp    $0x2f,%eax
  2c0bd9:	77 30                	ja     2c0c0b <printer_vprintf+0x54a>
  2c0bdb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0be2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0be6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bed:	8b 00                	mov    (%rax),%eax
  2c0bef:	89 c0                	mov    %eax,%eax
  2c0bf1:	48 01 d0             	add    %rdx,%rax
  2c0bf4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0bfb:	8b 12                	mov    (%rdx),%edx
  2c0bfd:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0c00:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c07:	89 0a                	mov    %ecx,(%rdx)
  2c0c09:	eb 1a                	jmp    2c0c25 <printer_vprintf+0x564>
  2c0c0b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c12:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0c16:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0c1a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c21:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0c25:	48 8b 00             	mov    (%rax),%rax
  2c0c28:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c0c2c:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c0c33:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c0c3a:	e9 79 01 00 00       	jmp    2c0db8 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  2c0c3f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c46:	8b 00                	mov    (%rax),%eax
  2c0c48:	83 f8 2f             	cmp    $0x2f,%eax
  2c0c4b:	77 30                	ja     2c0c7d <printer_vprintf+0x5bc>
  2c0c4d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c54:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0c58:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c5f:	8b 00                	mov    (%rax),%eax
  2c0c61:	89 c0                	mov    %eax,%eax
  2c0c63:	48 01 d0             	add    %rdx,%rax
  2c0c66:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c6d:	8b 12                	mov    (%rdx),%edx
  2c0c6f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0c72:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c79:	89 0a                	mov    %ecx,(%rdx)
  2c0c7b:	eb 1a                	jmp    2c0c97 <printer_vprintf+0x5d6>
  2c0c7d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c84:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0c88:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0c8c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c93:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0c97:	48 8b 00             	mov    (%rax),%rax
  2c0c9a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c0c9e:	e9 15 01 00 00       	jmp    2c0db8 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  2c0ca3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0caa:	8b 00                	mov    (%rax),%eax
  2c0cac:	83 f8 2f             	cmp    $0x2f,%eax
  2c0caf:	77 30                	ja     2c0ce1 <printer_vprintf+0x620>
  2c0cb1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cb8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0cbc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cc3:	8b 00                	mov    (%rax),%eax
  2c0cc5:	89 c0                	mov    %eax,%eax
  2c0cc7:	48 01 d0             	add    %rdx,%rax
  2c0cca:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0cd1:	8b 12                	mov    (%rdx),%edx
  2c0cd3:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0cd6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0cdd:	89 0a                	mov    %ecx,(%rdx)
  2c0cdf:	eb 1a                	jmp    2c0cfb <printer_vprintf+0x63a>
  2c0ce1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ce8:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0cec:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0cf0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0cf7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0cfb:	8b 00                	mov    (%rax),%eax
  2c0cfd:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c0d03:	e9 67 03 00 00       	jmp    2c106f <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  2c0d08:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c0d0c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c0d10:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d17:	8b 00                	mov    (%rax),%eax
  2c0d19:	83 f8 2f             	cmp    $0x2f,%eax
  2c0d1c:	77 30                	ja     2c0d4e <printer_vprintf+0x68d>
  2c0d1e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d25:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0d29:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d30:	8b 00                	mov    (%rax),%eax
  2c0d32:	89 c0                	mov    %eax,%eax
  2c0d34:	48 01 d0             	add    %rdx,%rax
  2c0d37:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d3e:	8b 12                	mov    (%rdx),%edx
  2c0d40:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0d43:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d4a:	89 0a                	mov    %ecx,(%rdx)
  2c0d4c:	eb 1a                	jmp    2c0d68 <printer_vprintf+0x6a7>
  2c0d4e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d55:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0d59:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0d5d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d64:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0d68:	8b 00                	mov    (%rax),%eax
  2c0d6a:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c0d6d:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c0d71:	eb 45                	jmp    2c0db8 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  2c0d73:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c0d77:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c0d7b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d82:	0f b6 00             	movzbl (%rax),%eax
  2c0d85:	84 c0                	test   %al,%al
  2c0d87:	74 0c                	je     2c0d95 <printer_vprintf+0x6d4>
  2c0d89:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d90:	0f b6 00             	movzbl (%rax),%eax
  2c0d93:	eb 05                	jmp    2c0d9a <printer_vprintf+0x6d9>
  2c0d95:	b8 25 00 00 00       	mov    $0x25,%eax
  2c0d9a:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c0d9d:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c0da1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0da8:	0f b6 00             	movzbl (%rax),%eax
  2c0dab:	84 c0                	test   %al,%al
  2c0dad:	75 08                	jne    2c0db7 <printer_vprintf+0x6f6>
                format--;
  2c0daf:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c0db6:	01 
            }
            break;
  2c0db7:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c0db8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0dbb:	83 e0 20             	and    $0x20,%eax
  2c0dbe:	85 c0                	test   %eax,%eax
  2c0dc0:	74 1e                	je     2c0de0 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c0dc2:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c0dc6:	48 83 c0 18          	add    $0x18,%rax
  2c0dca:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c0dcd:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c0dd1:	48 89 ce             	mov    %rcx,%rsi
  2c0dd4:	48 89 c7             	mov    %rax,%rdi
  2c0dd7:	e8 63 f8 ff ff       	call   2c063f <fill_numbuf>
  2c0ddc:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c0de0:	48 c7 45 c0 76 14 2c 	movq   $0x2c1476,-0x40(%rbp)
  2c0de7:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c0de8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0deb:	83 e0 20             	and    $0x20,%eax
  2c0dee:	85 c0                	test   %eax,%eax
  2c0df0:	74 48                	je     2c0e3a <printer_vprintf+0x779>
  2c0df2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0df5:	83 e0 40             	and    $0x40,%eax
  2c0df8:	85 c0                	test   %eax,%eax
  2c0dfa:	74 3e                	je     2c0e3a <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  2c0dfc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0dff:	25 80 00 00 00       	and    $0x80,%eax
  2c0e04:	85 c0                	test   %eax,%eax
  2c0e06:	74 0a                	je     2c0e12 <printer_vprintf+0x751>
                prefix = "-";
  2c0e08:	48 c7 45 c0 77 14 2c 	movq   $0x2c1477,-0x40(%rbp)
  2c0e0f:	00 
            if (flags & FLAG_NEGATIVE) {
  2c0e10:	eb 73                	jmp    2c0e85 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c0e12:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0e15:	83 e0 10             	and    $0x10,%eax
  2c0e18:	85 c0                	test   %eax,%eax
  2c0e1a:	74 0a                	je     2c0e26 <printer_vprintf+0x765>
                prefix = "+";
  2c0e1c:	48 c7 45 c0 79 14 2c 	movq   $0x2c1479,-0x40(%rbp)
  2c0e23:	00 
            if (flags & FLAG_NEGATIVE) {
  2c0e24:	eb 5f                	jmp    2c0e85 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c0e26:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0e29:	83 e0 08             	and    $0x8,%eax
  2c0e2c:	85 c0                	test   %eax,%eax
  2c0e2e:	74 55                	je     2c0e85 <printer_vprintf+0x7c4>
                prefix = " ";
  2c0e30:	48 c7 45 c0 7b 14 2c 	movq   $0x2c147b,-0x40(%rbp)
  2c0e37:	00 
            if (flags & FLAG_NEGATIVE) {
  2c0e38:	eb 4b                	jmp    2c0e85 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c0e3a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0e3d:	83 e0 20             	and    $0x20,%eax
  2c0e40:	85 c0                	test   %eax,%eax
  2c0e42:	74 42                	je     2c0e86 <printer_vprintf+0x7c5>
  2c0e44:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0e47:	83 e0 01             	and    $0x1,%eax
  2c0e4a:	85 c0                	test   %eax,%eax
  2c0e4c:	74 38                	je     2c0e86 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  2c0e4e:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c0e52:	74 06                	je     2c0e5a <printer_vprintf+0x799>
  2c0e54:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c0e58:	75 2c                	jne    2c0e86 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  2c0e5a:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0e5f:	75 0c                	jne    2c0e6d <printer_vprintf+0x7ac>
  2c0e61:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0e64:	25 00 01 00 00       	and    $0x100,%eax
  2c0e69:	85 c0                	test   %eax,%eax
  2c0e6b:	74 19                	je     2c0e86 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  2c0e6d:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c0e71:	75 07                	jne    2c0e7a <printer_vprintf+0x7b9>
  2c0e73:	b8 7d 14 2c 00       	mov    $0x2c147d,%eax
  2c0e78:	eb 05                	jmp    2c0e7f <printer_vprintf+0x7be>
  2c0e7a:	b8 80 14 2c 00       	mov    $0x2c1480,%eax
  2c0e7f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c0e83:	eb 01                	jmp    2c0e86 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  2c0e85:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c0e86:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c0e8a:	78 24                	js     2c0eb0 <printer_vprintf+0x7ef>
  2c0e8c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0e8f:	83 e0 20             	and    $0x20,%eax
  2c0e92:	85 c0                	test   %eax,%eax
  2c0e94:	75 1a                	jne    2c0eb0 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  2c0e96:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0e99:	48 63 d0             	movslq %eax,%rdx
  2c0e9c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c0ea0:	48 89 d6             	mov    %rdx,%rsi
  2c0ea3:	48 89 c7             	mov    %rax,%rdi
  2c0ea6:	e8 ea f5 ff ff       	call   2c0495 <strnlen>
  2c0eab:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c0eae:	eb 0f                	jmp    2c0ebf <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  2c0eb0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c0eb4:	48 89 c7             	mov    %rax,%rdi
  2c0eb7:	e8 a8 f5 ff ff       	call   2c0464 <strlen>
  2c0ebc:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c0ebf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0ec2:	83 e0 20             	and    $0x20,%eax
  2c0ec5:	85 c0                	test   %eax,%eax
  2c0ec7:	74 20                	je     2c0ee9 <printer_vprintf+0x828>
  2c0ec9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c0ecd:	78 1a                	js     2c0ee9 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  2c0ecf:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0ed2:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c0ed5:	7e 08                	jle    2c0edf <printer_vprintf+0x81e>
  2c0ed7:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0eda:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c0edd:	eb 05                	jmp    2c0ee4 <printer_vprintf+0x823>
  2c0edf:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0ee4:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c0ee7:	eb 5c                	jmp    2c0f45 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c0ee9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0eec:	83 e0 20             	and    $0x20,%eax
  2c0eef:	85 c0                	test   %eax,%eax
  2c0ef1:	74 4b                	je     2c0f3e <printer_vprintf+0x87d>
  2c0ef3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0ef6:	83 e0 02             	and    $0x2,%eax
  2c0ef9:	85 c0                	test   %eax,%eax
  2c0efb:	74 41                	je     2c0f3e <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c0efd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0f00:	83 e0 04             	and    $0x4,%eax
  2c0f03:	85 c0                	test   %eax,%eax
  2c0f05:	75 37                	jne    2c0f3e <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  2c0f07:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c0f0b:	48 89 c7             	mov    %rax,%rdi
  2c0f0e:	e8 51 f5 ff ff       	call   2c0464 <strlen>
  2c0f13:	89 c2                	mov    %eax,%edx
  2c0f15:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c0f18:	01 d0                	add    %edx,%eax
  2c0f1a:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c0f1d:	7e 1f                	jle    2c0f3e <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  2c0f1f:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c0f22:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c0f25:	89 c3                	mov    %eax,%ebx
  2c0f27:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c0f2b:	48 89 c7             	mov    %rax,%rdi
  2c0f2e:	e8 31 f5 ff ff       	call   2c0464 <strlen>
  2c0f33:	89 c2                	mov    %eax,%edx
  2c0f35:	89 d8                	mov    %ebx,%eax
  2c0f37:	29 d0                	sub    %edx,%eax
  2c0f39:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c0f3c:	eb 07                	jmp    2c0f45 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  2c0f3e:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c0f45:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c0f48:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c0f4b:	01 d0                	add    %edx,%eax
  2c0f4d:	48 63 d8             	movslq %eax,%rbx
  2c0f50:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c0f54:	48 89 c7             	mov    %rax,%rdi
  2c0f57:	e8 08 f5 ff ff       	call   2c0464 <strlen>
  2c0f5c:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c0f60:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c0f63:	29 d0                	sub    %edx,%eax
  2c0f65:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c0f68:	eb 25                	jmp    2c0f8f <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  2c0f6a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0f71:	48 8b 08             	mov    (%rax),%rcx
  2c0f74:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c0f7a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0f81:	be 20 00 00 00       	mov    $0x20,%esi
  2c0f86:	48 89 c7             	mov    %rax,%rdi
  2c0f89:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c0f8b:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c0f8f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0f92:	83 e0 04             	and    $0x4,%eax
  2c0f95:	85 c0                	test   %eax,%eax
  2c0f97:	75 36                	jne    2c0fcf <printer_vprintf+0x90e>
  2c0f99:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c0f9d:	7f cb                	jg     2c0f6a <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  2c0f9f:	eb 2e                	jmp    2c0fcf <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  2c0fa1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0fa8:	4c 8b 00             	mov    (%rax),%r8
  2c0fab:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c0faf:	0f b6 00             	movzbl (%rax),%eax
  2c0fb2:	0f b6 c8             	movzbl %al,%ecx
  2c0fb5:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c0fbb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0fc2:	89 ce                	mov    %ecx,%esi
  2c0fc4:	48 89 c7             	mov    %rax,%rdi
  2c0fc7:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c0fca:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c0fcf:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c0fd3:	0f b6 00             	movzbl (%rax),%eax
  2c0fd6:	84 c0                	test   %al,%al
  2c0fd8:	75 c7                	jne    2c0fa1 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  2c0fda:	eb 25                	jmp    2c1001 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  2c0fdc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0fe3:	48 8b 08             	mov    (%rax),%rcx
  2c0fe6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c0fec:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0ff3:	be 30 00 00 00       	mov    $0x30,%esi
  2c0ff8:	48 89 c7             	mov    %rax,%rdi
  2c0ffb:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c0ffd:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c1001:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c1005:	7f d5                	jg     2c0fdc <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  2c1007:	eb 32                	jmp    2c103b <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  2c1009:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1010:	4c 8b 00             	mov    (%rax),%r8
  2c1013:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1017:	0f b6 00             	movzbl (%rax),%eax
  2c101a:	0f b6 c8             	movzbl %al,%ecx
  2c101d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1023:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c102a:	89 ce                	mov    %ecx,%esi
  2c102c:	48 89 c7             	mov    %rax,%rdi
  2c102f:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c1032:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c1037:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c103b:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c103f:	7f c8                	jg     2c1009 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  2c1041:	eb 25                	jmp    2c1068 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  2c1043:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c104a:	48 8b 08             	mov    (%rax),%rcx
  2c104d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1053:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c105a:	be 20 00 00 00       	mov    $0x20,%esi
  2c105f:	48 89 c7             	mov    %rax,%rdi
  2c1062:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c1064:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c1068:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c106c:	7f d5                	jg     2c1043 <printer_vprintf+0x982>
        }
    done: ;
  2c106e:	90                   	nop
    for (; *format; ++format) {
  2c106f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c1076:	01 
  2c1077:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c107e:	0f b6 00             	movzbl (%rax),%eax
  2c1081:	84 c0                	test   %al,%al
  2c1083:	0f 85 64 f6 ff ff    	jne    2c06ed <printer_vprintf+0x2c>
    }
}
  2c1089:	90                   	nop
  2c108a:	90                   	nop
  2c108b:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c108f:	c9                   	leave  
  2c1090:	c3                   	ret    

00000000002c1091 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c1091:	55                   	push   %rbp
  2c1092:	48 89 e5             	mov    %rsp,%rbp
  2c1095:	48 83 ec 20          	sub    $0x20,%rsp
  2c1099:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c109d:	89 f0                	mov    %esi,%eax
  2c109f:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c10a2:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c10a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c10a9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c10ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c10b1:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c10b5:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  2c10ba:	48 39 d0             	cmp    %rdx,%rax
  2c10bd:	72 0c                	jb     2c10cb <console_putc+0x3a>
        cp->cursor = console;
  2c10bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c10c3:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  2c10ca:	00 
    }
    if (c == '\n') {
  2c10cb:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c10cf:	75 78                	jne    2c1149 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  2c10d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c10d5:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c10d9:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c10df:	48 d1 f8             	sar    %rax
  2c10e2:	48 89 c1             	mov    %rax,%rcx
  2c10e5:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c10ec:	66 66 66 
  2c10ef:	48 89 c8             	mov    %rcx,%rax
  2c10f2:	48 f7 ea             	imul   %rdx
  2c10f5:	48 c1 fa 05          	sar    $0x5,%rdx
  2c10f9:	48 89 c8             	mov    %rcx,%rax
  2c10fc:	48 c1 f8 3f          	sar    $0x3f,%rax
  2c1100:	48 29 c2             	sub    %rax,%rdx
  2c1103:	48 89 d0             	mov    %rdx,%rax
  2c1106:	48 c1 e0 02          	shl    $0x2,%rax
  2c110a:	48 01 d0             	add    %rdx,%rax
  2c110d:	48 c1 e0 04          	shl    $0x4,%rax
  2c1111:	48 29 c1             	sub    %rax,%rcx
  2c1114:	48 89 ca             	mov    %rcx,%rdx
  2c1117:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c111a:	eb 25                	jmp    2c1141 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  2c111c:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c111f:	83 c8 20             	or     $0x20,%eax
  2c1122:	89 c6                	mov    %eax,%esi
  2c1124:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1128:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c112c:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1130:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c1134:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1138:	89 f2                	mov    %esi,%edx
  2c113a:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c113d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1141:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c1145:	75 d5                	jne    2c111c <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c1147:	eb 24                	jmp    2c116d <console_putc+0xdc>
        *cp->cursor++ = c | color;
  2c1149:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  2c114d:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c1150:	09 d0                	or     %edx,%eax
  2c1152:	89 c6                	mov    %eax,%esi
  2c1154:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1158:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c115c:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1160:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c1164:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1168:	89 f2                	mov    %esi,%edx
  2c116a:	66 89 10             	mov    %dx,(%rax)
}
  2c116d:	90                   	nop
  2c116e:	c9                   	leave  
  2c116f:	c3                   	ret    

00000000002c1170 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c1170:	55                   	push   %rbp
  2c1171:	48 89 e5             	mov    %rsp,%rbp
  2c1174:	48 83 ec 30          	sub    $0x30,%rsp
  2c1178:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c117b:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c117e:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c1182:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c1186:	48 c7 45 f0 91 10 2c 	movq   $0x2c1091,-0x10(%rbp)
  2c118d:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c118e:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c1192:	78 09                	js     2c119d <console_vprintf+0x2d>
  2c1194:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c119b:	7e 07                	jle    2c11a4 <console_vprintf+0x34>
        cpos = 0;
  2c119d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c11a4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11a7:	48 98                	cltq   
  2c11a9:	48 01 c0             	add    %rax,%rax
  2c11ac:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  2c11b2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c11b6:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c11ba:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c11be:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c11c1:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c11c5:	48 89 c7             	mov    %rax,%rdi
  2c11c8:	e8 f4 f4 ff ff       	call   2c06c1 <printer_vprintf>
    return cp.cursor - console;
  2c11cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c11d1:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c11d7:	48 d1 f8             	sar    %rax
}
  2c11da:	c9                   	leave  
  2c11db:	c3                   	ret    

00000000002c11dc <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c11dc:	55                   	push   %rbp
  2c11dd:	48 89 e5             	mov    %rsp,%rbp
  2c11e0:	48 83 ec 60          	sub    $0x60,%rsp
  2c11e4:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c11e7:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c11ea:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c11ee:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c11f2:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c11f6:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c11fa:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c1201:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1205:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c1209:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c120d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c1211:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c1215:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c1219:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c121c:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c121f:	89 c7                	mov    %eax,%edi
  2c1221:	e8 4a ff ff ff       	call   2c1170 <console_vprintf>
  2c1226:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c1229:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c122c:	c9                   	leave  
  2c122d:	c3                   	ret    

00000000002c122e <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c122e:	55                   	push   %rbp
  2c122f:	48 89 e5             	mov    %rsp,%rbp
  2c1232:	48 83 ec 20          	sub    $0x20,%rsp
  2c1236:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c123a:	89 f0                	mov    %esi,%eax
  2c123c:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c123f:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c1242:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1246:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c124a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c124e:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c1252:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1256:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c125a:	48 39 c2             	cmp    %rax,%rdx
  2c125d:	73 1a                	jae    2c1279 <string_putc+0x4b>
        *sp->s++ = c;
  2c125f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1263:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1267:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c126b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c126f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1273:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c1277:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c1279:	90                   	nop
  2c127a:	c9                   	leave  
  2c127b:	c3                   	ret    

00000000002c127c <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c127c:	55                   	push   %rbp
  2c127d:	48 89 e5             	mov    %rsp,%rbp
  2c1280:	48 83 ec 40          	sub    $0x40,%rsp
  2c1284:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c1288:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c128c:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c1290:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c1294:	48 c7 45 e8 2e 12 2c 	movq   $0x2c122e,-0x18(%rbp)
  2c129b:	00 
    sp.s = s;
  2c129c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c12a0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c12a4:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c12a9:	74 33                	je     2c12de <vsnprintf+0x62>
        sp.end = s + size - 1;
  2c12ab:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c12af:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c12b3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c12b7:	48 01 d0             	add    %rdx,%rax
  2c12ba:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c12be:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c12c2:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c12c6:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c12ca:	be 00 00 00 00       	mov    $0x0,%esi
  2c12cf:	48 89 c7             	mov    %rax,%rdi
  2c12d2:	e8 ea f3 ff ff       	call   2c06c1 <printer_vprintf>
        *sp.s = 0;
  2c12d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c12db:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c12de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c12e2:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c12e6:	c9                   	leave  
  2c12e7:	c3                   	ret    

00000000002c12e8 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c12e8:	55                   	push   %rbp
  2c12e9:	48 89 e5             	mov    %rsp,%rbp
  2c12ec:	48 83 ec 70          	sub    $0x70,%rsp
  2c12f0:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c12f4:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c12f8:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c12fc:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1300:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c1304:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c1308:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c130f:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1313:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c1317:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c131b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c131f:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c1323:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c1327:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c132b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c132f:	48 89 c7             	mov    %rax,%rdi
  2c1332:	e8 45 ff ff ff       	call   2c127c <vsnprintf>
  2c1337:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c133a:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c133d:	c9                   	leave  
  2c133e:	c3                   	ret    

00000000002c133f <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c133f:	55                   	push   %rbp
  2c1340:	48 89 e5             	mov    %rsp,%rbp
  2c1343:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c1347:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c134e:	eb 13                	jmp    2c1363 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  2c1350:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c1353:	48 98                	cltq   
  2c1355:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  2c135c:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c135f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1363:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c136a:	7e e4                	jle    2c1350 <console_clear+0x11>
    }
    cursorpos = 0;
  2c136c:	c7 05 86 7c df ff 00 	movl   $0x0,-0x20837a(%rip)        # b8ffc <cursorpos>
  2c1373:	00 00 00 
}
  2c1376:	90                   	nop
  2c1377:	c9                   	leave  
  2c1378:	c3                   	ret    
