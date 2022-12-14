
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
  2c0016:	e8 91 09 00 00       	call   2c09ac <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001b:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0020:	e8 91 04 00 00       	call   2c04b6 <malloc>
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
  2c003f:	e8 4f 05 00 00       	call   2c0593 <realloc>
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
  2c0067:	e8 f9 04 00 00       	call   2c0565 <calloc>
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
  2c0086:	e8 24 06 00 00       	call   2c06af <heap_info>
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
  2c00b7:	ba 10 17 2c 00       	mov    $0x2c1710,%edx
  2c00bc:	be 1a 00 00 00       	mov    $0x1a,%esi
  2c00c1:	bf 1e 17 2c 00       	mov    $0x2c171e,%edi
  2c00c6:	e8 13 02 00 00       	call   2c02de <assert_fail>
	assert(array2[i] == 0);
  2c00cb:	ba 34 17 2c 00       	mov    $0x2c1734,%edx
  2c00d0:	be 22 00 00 00       	mov    $0x22,%esi
  2c00d5:	bf 1e 17 2c 00       	mov    $0x2c171e,%edi
  2c00da:	e8 ff 01 00 00       	call   2c02de <assert_fail>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00df:	ba 58 17 2c 00       	mov    $0x2c1758,%edx
  2c00e4:	be 29 00 00 00       	mov    $0x29,%esi
  2c00e9:	bf 1e 17 2c 00       	mov    $0x2c171e,%edi
  2c00ee:	e8 eb 01 00 00       	call   2c02de <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c00f3:	be 43 17 2c 00       	mov    $0x2c1743,%esi
  2c00f8:	bf 00 00 00 00       	mov    $0x0,%edi
  2c00fd:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0102:	e8 79 00 00 00       	call   2c0180 <app_printf>
    }
    
    // free array, array2
    free(array);
  2c0107:	4c 89 ef             	mov    %r13,%rdi
  2c010a:	e8 66 02 00 00       	call   2c0375 <free>
    free(array2);
  2c010f:	4c 89 f7             	mov    %r14,%rdi
  2c0112:	e8 5e 02 00 00       	call   2c0375 <free>

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
  2c0130:	e8 81 03 00 00       	call   2c04b6 <malloc>
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
  2c016a:	be 88 17 2c 00       	mov    $0x2c1788,%esi
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
  2c01c8:	0f b6 b7 ed 17 2c 00 	movzbl 0x2c17ed(%rdi),%esi
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
  2c01f6:	e8 03 13 00 00       	call   2c14fe <console_vprintf>
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
  2c024f:	be b8 17 2c 00       	mov    $0x2c17b8,%esi
  2c0254:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  2c025b:	e8 55 04 00 00       	call   2c06b5 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0260:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0264:	48 89 da             	mov    %rbx,%rdx
  2c0267:	be 99 00 00 00       	mov    $0x99,%esi
  2c026c:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c0273:	e8 92 13 00 00       	call   2c160a <vsnprintf>
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
  2c0298:	ba c0 17 2c 00       	mov    $0x2c17c0,%edx
  2c029d:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02a2:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02a7:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ac:	e8 b9 12 00 00       	call   2c156a <console_printf>
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
  2c02d2:	be 53 17 2c 00       	mov    $0x2c1753,%esi
  2c02d7:	e8 86 05 00 00       	call   2c0862 <strcpy>
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
  2c02eb:	ba c8 17 2c 00       	mov    $0x2c17c8,%edx
  2c02f0:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02f5:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02fa:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ff:	e8 66 12 00 00       	call   2c156a <console_printf>
    asm volatile ("int %0" : /* no result */
  2c0304:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0309:	cd 30                	int    $0x30
 loop: goto loop;
  2c030b:	eb fe                	jmp    2c030b <assert_fail+0x2d>

00000000002c030d <heap_init>:
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  2c030d:	bf 10 00 00 00       	mov    $0x10,%edi
  2c0312:	cd 3a                	int    $0x3a
  2c0314:	48 89 05 f5 1c 00 00 	mov    %rax,0x1cf5(%rip)        # 2c2010 <result.0>
  2c031b:	cd 3a                	int    $0x3a
  2c031d:	48 89 c2             	mov    %rax,%rdx
  2c0320:	48 89 05 e9 1c 00 00 	mov    %rax,0x1ce9(%rip)        # 2c2010 <result.0>
	// prologue block
	void *prologue_block;
	sbrk(sizeof(block_header));
	prologue_block = sbrk(sizeof(block_footer));

	GET_SIZE(HDRP(prologue_block)) = sizeof(block_header) + sizeof(block_footer);
  2c0327:	48 c7 40 f0 20 00 00 	movq   $0x20,-0x10(%rax)
  2c032e:	00 
	GET_ALLOC(HDRP(prologue_block)) = 1;
  2c032f:	c7 40 f8 01 00 00 00 	movl   $0x1,-0x8(%rax)
	GET_SIZE(FTRP(prologue_block)) = sizeof(block_header) + sizeof(block_footer);
  2c0336:	48 c7 00 20 00 00 00 	movq   $0x20,(%rax)
  2c033d:	cd 3a                	int    $0x3a
  2c033f:	48 89 05 ca 1c 00 00 	mov    %rax,0x1cca(%rip)        # 2c2010 <result.0>

	// terminal block
	sbrk(sizeof(block_header));
	GET_SIZE(HDRP(NEXT_BLKP(prologue_block))) = 0;
  2c0346:	48 8b 42 f0          	mov    -0x10(%rdx),%rax
  2c034a:	48 c7 44 02 f0 00 00 	movq   $0x0,-0x10(%rdx,%rax,1)
  2c0351:	00 00 
	GET_ALLOC(HDRP(NEXT_BLKP(prologue_block))) = 0;
  2c0353:	48 8b 42 f0          	mov    -0x10(%rdx),%rax
  2c0357:	c7 44 02 f8 00 00 00 	movl   $0x0,-0x8(%rdx,%rax,1)
  2c035e:	00 

	free_list = NULL;
  2c035f:	48 c7 05 96 1c 00 00 	movq   $0x0,0x1c96(%rip)        # 2c2000 <free_list>
  2c0366:	00 00 00 00 

	initialized_heap = 1;
  2c036a:	c7 05 94 1c 00 00 01 	movl   $0x1,0x1c94(%rip)        # 2c2008 <initialized_heap>
  2c0371:	00 00 00 
}
  2c0374:	c3                   	ret    

00000000002c0375 <free>:

void free(void *firstbyte) {
	if (firstbyte == NULL)
  2c0375:	48 85 ff             	test   %rdi,%rdi
  2c0378:	74 34                	je     2c03ae <free+0x39>
		return;

	// setup free things: alloc, list ptrs, footer
	GET_ALLOC(HDRP(firstbyte)) = 0;
  2c037a:	c7 47 f8 00 00 00 00 	movl   $0x0,-0x8(%rdi)
	NEXT_FPTR(firstbyte) = free_list;
  2c0381:	48 8b 05 78 1c 00 00 	mov    0x1c78(%rip),%rax        # 2c2000 <free_list>
  2c0388:	48 89 07             	mov    %rax,(%rdi)
	PREV_FPTR(firstbyte) = NULL;
  2c038b:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  2c0392:	00 
	GET_SIZE(FTRP(firstbyte)) = GET_SIZE(HDRP(firstbyte));
  2c0393:	48 8b 47 f0          	mov    -0x10(%rdi),%rax
  2c0397:	48 89 44 07 e0       	mov    %rax,-0x20(%rdi,%rax,1)

	// add to free_list
	PREV_FPTR(free_list) = firstbyte;
  2c039c:	48 8b 05 5d 1c 00 00 	mov    0x1c5d(%rip),%rax        # 2c2000 <free_list>
  2c03a3:	48 89 78 08          	mov    %rdi,0x8(%rax)
	free_list = firstbyte;
  2c03a7:	48 89 3d 52 1c 00 00 	mov    %rdi,0x1c52(%rip)        # 2c2000 <free_list>

	return;
}
  2c03ae:	c3                   	ret    

00000000002c03af <extend>:
//
//	the reason alloating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
void extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  2c03af:	48 81 c7 ff 3f 00 00 	add    $0x3fff,%rdi
  2c03b6:	48 81 e7 00 c0 ff ff 	and    $0xffffffffffffc000,%rdi
  2c03bd:	cd 3a                	int    $0x3a
  2c03bf:	48 89 05 4a 1c 00 00 	mov    %rax,0x1c4a(%rip)        # 2c2010 <result.0>
	void *bp = sbrk(chunk_aligned_size);

	// setup pointer
	GET_SIZE(HDRP(bp)) = chunk_aligned_size;
  2c03c6:	48 89 78 f0          	mov    %rdi,-0x10(%rax)
	GET_ALLOC(HDRP(bp)) = 0;
  2c03ca:	c7 40 f8 00 00 00 00 	movl   $0x0,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  2c03d1:	48 8b 15 28 1c 00 00 	mov    0x1c28(%rip),%rdx        # 2c2000 <free_list>
  2c03d8:	48 89 10             	mov    %rdx,(%rax)
	PREV_FPTR(bp) = NULL;
  2c03db:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  2c03e2:	00 
	GET_SIZE(FTRP(bp)) = GET_SIZE(HDRP(bp));
  2c03e3:	48 89 7c 07 e0       	mov    %rdi,-0x20(%rdi,%rax,1)

	// add to head of free_list
	if (free_list)
  2c03e8:	48 8b 15 11 1c 00 00 	mov    0x1c11(%rip),%rdx        # 2c2000 <free_list>
  2c03ef:	48 85 d2             	test   %rdx,%rdx
  2c03f2:	74 04                	je     2c03f8 <extend+0x49>
		PREV_FPTR(free_list) = bp;
  2c03f4:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  2c03f8:	48 89 05 01 1c 00 00 	mov    %rax,0x1c01(%rip)        # 2c2000 <free_list>

	// update terminal block
	GET_SIZE(HDRP(NEXT_BLKP(bp))) = 0;
  2c03ff:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  2c0403:	48 c7 44 10 f0 00 00 	movq   $0x0,-0x10(%rax,%rdx,1)
  2c040a:	00 00 
	GET_ALLOC(HDRP(NEXT_BLKP(bp))) = 1;
  2c040c:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  2c0410:	c7 44 10 f8 01 00 00 	movl   $0x1,-0x8(%rax,%rdx,1)
  2c0417:	00 
}
  2c0418:	c3                   	ret    

00000000002c0419 <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
  2c0419:	48 89 f8             	mov    %rdi,%rax
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  2c041c:	48 8b 57 f0          	mov    -0x10(%rdi),%rdx
  2c0420:	48 29 f2             	sub    %rsi,%rdx

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  2c0423:	48 83 fa 30          	cmp    $0x30,%rdx
  2c0427:	76 57                	jbe    2c0480 <set_allocated+0x67>
		GET_SIZE(HDRP(bp)) = size;
  2c0429:	48 89 77 f0          	mov    %rsi,-0x10(%rdi)
		void *leftover_mem_ptr = NEXT_BLKP(bp);
  2c042d:	48 01 fe             	add    %rdi,%rsi

		GET_SIZE(HDRP(leftover_mem_ptr)) = extra_size;
  2c0430:	48 89 56 f0          	mov    %rdx,-0x10(%rsi)
		GET_ALLOC(HDRP(leftover_mem_ptr)) = 0;
  2c0434:	c7 46 f8 00 00 00 00 	movl   $0x0,-0x8(%rsi)
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp); // pointers to the nearby free blocks
  2c043b:	48 8b 0f             	mov    (%rdi),%rcx
  2c043e:	48 89 0e             	mov    %rcx,(%rsi)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  2c0441:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  2c0445:	48 89 4e 08          	mov    %rcx,0x8(%rsi)
		GET_SIZE(FTRP(leftover_mem_ptr)) = GET_SIZE(HDRP(leftover_mem_ptr));
  2c0449:	48 89 54 16 e0       	mov    %rdx,-0x20(%rsi,%rdx,1)

		// update the free list
		if (free_list == bp)
  2c044e:	48 39 3d ab 1b 00 00 	cmp    %rdi,0x1bab(%rip)        # 2c2000 <free_list>
  2c0455:	74 20                	je     2c0477 <set_allocated+0x5e>
			free_list = leftover_mem_ptr;

		if (PREV_FPTR(bp))
  2c0457:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c045b:	48 85 d2             	test   %rdx,%rdx
  2c045e:	74 03                	je     2c0463 <set_allocated+0x4a>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  2c0460:	48 89 32             	mov    %rsi,(%rdx)
		if (NEXT_FPTR(bp))
  2c0463:	48 8b 10             	mov    (%rax),%rdx
  2c0466:	48 85 d2             	test   %rdx,%rdx
  2c0469:	74 04                	je     2c046f <set_allocated+0x56>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  2c046b:	48 89 72 08          	mov    %rsi,0x8(%rdx)
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
		if (NEXT_FPTR(bp))
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
	}
	
	GET_ALLOC(HDRP(bp)) = 1;
  2c046f:	c7 40 f8 01 00 00 00 	movl   $0x1,-0x8(%rax)
}
  2c0476:	c3                   	ret    
			free_list = leftover_mem_ptr;
  2c0477:	48 89 35 82 1b 00 00 	mov    %rsi,0x1b82(%rip)        # 2c2000 <free_list>
  2c047e:	eb d7                	jmp    2c0457 <set_allocated+0x3e>
		if (free_list == bp)
  2c0480:	48 39 3d 79 1b 00 00 	cmp    %rdi,0x1b79(%rip)        # 2c2000 <free_list>
  2c0487:	74 21                	je     2c04aa <set_allocated+0x91>
		if (PREV_FPTR(bp))
  2c0489:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c048d:	48 85 d2             	test   %rdx,%rdx
  2c0490:	74 06                	je     2c0498 <set_allocated+0x7f>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  2c0492:	48 8b 08             	mov    (%rax),%rcx
  2c0495:	48 89 0a             	mov    %rcx,(%rdx)
		if (NEXT_FPTR(bp))
  2c0498:	48 8b 10             	mov    (%rax),%rdx
  2c049b:	48 85 d2             	test   %rdx,%rdx
  2c049e:	74 cf                	je     2c046f <set_allocated+0x56>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  2c04a0:	48 8b 48 08          	mov    0x8(%rax),%rcx
  2c04a4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c04a8:	eb c5                	jmp    2c046f <set_allocated+0x56>
			free_list = NEXT_FPTR(bp);
  2c04aa:	48 8b 17             	mov    (%rdi),%rdx
  2c04ad:	48 89 15 4c 1b 00 00 	mov    %rdx,0x1b4c(%rip)        # 2c2000 <free_list>
  2c04b4:	eb d3                	jmp    2c0489 <set_allocated+0x70>

00000000002c04b6 <malloc>:

void *malloc(uint64_t numbytes) {
  2c04b6:	55                   	push   %rbp
  2c04b7:	48 89 e5             	mov    %rsp,%rbp
  2c04ba:	41 55                	push   %r13
  2c04bc:	41 54                	push   %r12
  2c04be:	53                   	push   %rbx
  2c04bf:	48 83 ec 08          	sub    $0x8,%rsp
  2c04c3:	49 89 fc             	mov    %rdi,%r12
	if (!initialized_heap)
  2c04c6:	83 3d 3b 1b 00 00 00 	cmpl   $0x0,0x1b3b(%rip)        # 2c2008 <initialized_heap>
  2c04cd:	74 66                	je     2c0535 <malloc+0x7f>
		heap_init();

	if (numbytes == 0)
  2c04cf:	4d 85 e4             	test   %r12,%r12
  2c04d2:	0f 84 86 00 00 00    	je     2c055e <malloc+0xa8>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  2c04d8:	49 83 c4 1f          	add    $0x1f,%r12
  2c04dc:	49 83 e4 f0          	and    $0xfffffffffffffff0,%r12
  2c04e0:	b8 30 00 00 00       	mov    $0x30,%eax
  2c04e5:	49 39 c4             	cmp    %rax,%r12
  2c04e8:	4c 0f 42 e0          	cmovb  %rax,%r12
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);

	void *bp = free_list;
  2c04ec:	48 8b 1d 0d 1b 00 00 	mov    0x1b0d(%rip),%rbx        # 2c2000 <free_list>
	while (bp) {
  2c04f3:	48 85 db             	test   %rbx,%rbx
  2c04f6:	74 0e                	je     2c0506 <malloc+0x50>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  2c04f8:	4c 39 63 f0          	cmp    %r12,-0x10(%rbx)
  2c04fc:	73 3e                	jae    2c053c <malloc+0x86>
			set_allocated(bp, aligned_size);
			return bp;
		}

		bp = NEXT_FPTR(bp);
  2c04fe:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  2c0501:	48 85 db             	test   %rbx,%rbx
  2c0504:	75 f2                	jne    2c04f8 <malloc+0x42>
  2c0506:	bf 00 00 00 00       	mov    $0x0,%edi
  2c050b:	cd 3a                	int    $0x3a
  2c050d:	49 89 c5             	mov    %rax,%r13
  2c0510:	48 89 05 f9 1a 00 00 	mov    %rax,0x1af9(%rip)        # 2c2010 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  2c0517:	48 89 c3             	mov    %rax,%rbx
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	if (bp == (void *)0xffffffffffffffef){
  2c051a:	48 83 f8 ef          	cmp    $0xffffffffffffffef,%rax
  2c051e:	74 35                	je     2c0555 <malloc+0x9f>
		panic("I'm panicking");
		return NULL;}
	extend(aligned_size);
  2c0520:	4c 89 e7             	mov    %r12,%rdi
  2c0523:	e8 87 fe ff ff       	call   2c03af <extend>
	set_allocated(bp, aligned_size);
  2c0528:	4c 89 e6             	mov    %r12,%rsi
  2c052b:	4c 89 ef             	mov    %r13,%rdi
  2c052e:	e8 e6 fe ff ff       	call   2c0419 <set_allocated>
    return bp;
  2c0533:	eb 12                	jmp    2c0547 <malloc+0x91>
		heap_init();
  2c0535:	e8 d3 fd ff ff       	call   2c030d <heap_init>
  2c053a:	eb 93                	jmp    2c04cf <malloc+0x19>
			set_allocated(bp, aligned_size);
  2c053c:	4c 89 e6             	mov    %r12,%rsi
  2c053f:	48 89 df             	mov    %rbx,%rdi
  2c0542:	e8 d2 fe ff ff       	call   2c0419 <set_allocated>
}
  2c0547:	48 89 d8             	mov    %rbx,%rax
  2c054a:	48 83 c4 08          	add    $0x8,%rsp
  2c054e:	5b                   	pop    %rbx
  2c054f:	41 5c                	pop    %r12
  2c0551:	41 5d                	pop    %r13
  2c0553:	5d                   	pop    %rbp
  2c0554:	c3                   	ret    
    asm volatile ("int %0" : /* no result */
  2c0555:	bf f2 17 2c 00       	mov    $0x2c17f2,%edi
  2c055a:	cd 30                	int    $0x30
 loop: goto loop;
  2c055c:	eb fe                	jmp    2c055c <malloc+0xa6>
		return NULL;
  2c055e:	bb 00 00 00 00       	mov    $0x0,%ebx
  2c0563:	eb e2                	jmp    2c0547 <malloc+0x91>

00000000002c0565 <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  2c0565:	55                   	push   %rbp
  2c0566:	48 89 e5             	mov    %rsp,%rbp
  2c0569:	41 54                	push   %r12
  2c056b:	53                   	push   %rbx
	void *bp = malloc(num * sz);
  2c056c:	48 0f af fe          	imul   %rsi,%rdi
  2c0570:	49 89 fc             	mov    %rdi,%r12
  2c0573:	e8 3e ff ff ff       	call   2c04b6 <malloc>
  2c0578:	48 89 c3             	mov    %rax,%rbx
	memset(bp, 0, num * sz);
  2c057b:	4c 89 e2             	mov    %r12,%rdx
  2c057e:	be 00 00 00 00       	mov    $0x0,%esi
  2c0583:	48 89 c7             	mov    %rax,%rdi
  2c0586:	e8 28 02 00 00       	call   2c07b3 <memset>
	return bp;
}
  2c058b:	48 89 d8             	mov    %rbx,%rax
  2c058e:	5b                   	pop    %rbx
  2c058f:	41 5c                	pop    %r12
  2c0591:	5d                   	pop    %rbp
  2c0592:	c3                   	ret    

00000000002c0593 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  2c0593:	55                   	push   %rbp
  2c0594:	48 89 e5             	mov    %rsp,%rbp
  2c0597:	41 54                	push   %r12
  2c0599:	53                   	push   %rbx
  2c059a:	48 89 fb             	mov    %rdi,%rbx
	// first check if there's enough space in the block already
	if (GET_SIZE(HDRP(ptr)) >= sz)
  2c059d:	48 39 77 f0          	cmp    %rsi,-0x10(%rdi)
  2c05a1:	72 08                	jb     2c05ab <realloc+0x18>
	void *bigger_ptr = malloc(sz);
	memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
	free(ptr);

    return bigger_ptr;
}
  2c05a3:	48 89 d8             	mov    %rbx,%rax
  2c05a6:	5b                   	pop    %rbx
  2c05a7:	41 5c                	pop    %r12
  2c05a9:	5d                   	pop    %rbp
  2c05aa:	c3                   	ret    
	void *bigger_ptr = malloc(sz);
  2c05ab:	48 89 f7             	mov    %rsi,%rdi
  2c05ae:	e8 03 ff ff ff       	call   2c04b6 <malloc>
  2c05b3:	49 89 c4             	mov    %rax,%r12
	memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
  2c05b6:	48 8b 53 f0          	mov    -0x10(%rbx),%rdx
  2c05ba:	48 89 de             	mov    %rbx,%rsi
  2c05bd:	48 89 c7             	mov    %rax,%rdi
  2c05c0:	e8 f0 00 00 00       	call   2c06b5 <memcpy>
	free(ptr);
  2c05c5:	48 89 df             	mov    %rbx,%rdi
  2c05c8:	e8 a8 fd ff ff       	call   2c0375 <free>
    return bigger_ptr;
  2c05cd:	4c 89 e3             	mov    %r12,%rbx
  2c05d0:	eb d1                	jmp    2c05a3 <realloc+0x10>

00000000002c05d2 <defrag>:

void defrag() {
	void *fp = free_list;
  2c05d2:	48 8b 05 27 1a 00 00 	mov    0x1a27(%rip),%rax        # 2c2000 <free_list>
	while (fp != NULL) {
  2c05d9:	48 85 c0             	test   %rax,%rax
  2c05dc:	75 3a                	jne    2c0618 <defrag+0x46>
			GET_SIZE(FTRP(prev_block)) = GET_SIZE(HDRP(prev_block));
		}

		fp = NEXT_FPTR(fp);
	}
}
  2c05de:	c3                   	ret    
				free_list = NEXT_FPTR(next_block);
  2c05df:	48 8b 0a             	mov    (%rdx),%rcx
  2c05e2:	48 89 0d 17 1a 00 00 	mov    %rcx,0x1a17(%rip)        # 2c2000 <free_list>
  2c05e9:	eb 43                	jmp    2c062e <defrag+0x5c>
			fp = NEXT_FPTR(fp);
  2c05eb:	48 8b 00             	mov    (%rax),%rax
			continue;
  2c05ee:	eb 23                	jmp    2c0613 <defrag+0x41>
				free_list = NEXT_FPTR(fp);
  2c05f0:	48 8b 08             	mov    (%rax),%rcx
  2c05f3:	48 89 0d 06 1a 00 00 	mov    %rcx,0x1a06(%rip)        # 2c2000 <free_list>
  2c05fa:	e9 88 00 00 00       	jmp    2c0687 <defrag+0xb5>
			GET_SIZE(HDRP(prev_block)) = GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp));
  2c05ff:	48 8b 48 f0          	mov    -0x10(%rax),%rcx
  2c0603:	48 03 4a f0          	add    -0x10(%rdx),%rcx
  2c0607:	48 89 4a f0          	mov    %rcx,-0x10(%rdx)
			GET_SIZE(FTRP(prev_block)) = GET_SIZE(HDRP(prev_block));
  2c060b:	48 89 4c 0a e0       	mov    %rcx,-0x20(%rdx,%rcx,1)
		fp = NEXT_FPTR(fp);
  2c0610:	48 8b 00             	mov    (%rax),%rax
	while (fp != NULL) {
  2c0613:	48 85 c0             	test   %rax,%rax
  2c0616:	74 c6                	je     2c05de <defrag+0xc>
		void *next_block = NEXT_BLKP(fp);
  2c0618:	48 89 c2             	mov    %rax,%rdx
  2c061b:	48 03 50 f0          	add    -0x10(%rax),%rdx
		if (!GET_ALLOC(HDRP(next_block))) {
  2c061f:	83 7a f8 00          	cmpl   $0x0,-0x8(%rdx)
  2c0623:	75 39                	jne    2c065e <defrag+0x8c>
			if (free_list == next_block)
  2c0625:	48 39 15 d4 19 00 00 	cmp    %rdx,0x19d4(%rip)        # 2c2000 <free_list>
  2c062c:	74 b1                	je     2c05df <defrag+0xd>
			if (PREV_FPTR(next_block)) 
  2c062e:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  2c0632:	48 85 c9             	test   %rcx,%rcx
  2c0635:	74 06                	je     2c063d <defrag+0x6b>
				NEXT_FPTR(PREV_FPTR(next_block)) = NEXT_FPTR(next_block);
  2c0637:	48 8b 32             	mov    (%rdx),%rsi
  2c063a:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(next_block)) 
  2c063d:	48 8b 0a             	mov    (%rdx),%rcx
  2c0640:	48 85 c9             	test   %rcx,%rcx
  2c0643:	74 08                	je     2c064d <defrag+0x7b>
				PREV_FPTR(NEXT_FPTR(next_block)) = PREV_FPTR(next_block);
  2c0645:	48 8b 72 08          	mov    0x8(%rdx),%rsi
  2c0649:	48 89 71 08          	mov    %rsi,0x8(%rcx)
			GET_SIZE(HDRP(fp)) = GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block));
  2c064d:	48 8b 52 f0          	mov    -0x10(%rdx),%rdx
  2c0651:	48 03 50 f0          	add    -0x10(%rax),%rdx
  2c0655:	48 89 50 f0          	mov    %rdx,-0x10(%rax)
			GET_SIZE(FTRP(fp)) = GET_SIZE(HDRP(fp));
  2c0659:	48 89 54 10 e0       	mov    %rdx,-0x20(%rax,%rdx,1)
		void *prev_block = PREV_BLKP(fp);
  2c065e:	48 89 c2             	mov    %rax,%rdx
  2c0661:	48 2b 50 e0          	sub    -0x20(%rax),%rdx
		if (GET_SIZE(HDRP(prev_block)) != GET_SIZE(FTRP(prev_block))){
  2c0665:	48 8b 4a f0          	mov    -0x10(%rdx),%rcx
  2c0669:	48 3b 4c 0a e0       	cmp    -0x20(%rdx,%rcx,1),%rcx
  2c066e:	0f 85 77 ff ff ff    	jne    2c05eb <defrag+0x19>
		if (!GET_ALLOC(HDRP(prev_block))) {
  2c0674:	83 7a f8 00          	cmpl   $0x0,-0x8(%rdx)
  2c0678:	75 96                	jne    2c0610 <defrag+0x3e>
			if (free_list == fp)
  2c067a:	48 39 05 7f 19 00 00 	cmp    %rax,0x197f(%rip)        # 2c2000 <free_list>
  2c0681:	0f 84 69 ff ff ff    	je     2c05f0 <defrag+0x1e>
			if (PREV_FPTR(fp)) 
  2c0687:	48 8b 48 08          	mov    0x8(%rax),%rcx
  2c068b:	48 85 c9             	test   %rcx,%rcx
  2c068e:	74 06                	je     2c0696 <defrag+0xc4>
				NEXT_FPTR(PREV_FPTR(fp)) = NEXT_FPTR(fp);
  2c0690:	48 8b 30             	mov    (%rax),%rsi
  2c0693:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(fp)) 
  2c0696:	48 8b 08             	mov    (%rax),%rcx
  2c0699:	48 85 c9             	test   %rcx,%rcx
  2c069c:	0f 84 5d ff ff ff    	je     2c05ff <defrag+0x2d>
				PREV_FPTR(NEXT_FPTR(fp)) = PREV_FPTR(fp);
  2c06a2:	48 8b 70 08          	mov    0x8(%rax),%rsi
  2c06a6:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  2c06aa:	e9 50 ff ff ff       	jmp    2c05ff <defrag+0x2d>

00000000002c06af <heap_info>:

int heap_info(heap_info_struct *info) {
    return 0;
}
  2c06af:	b8 00 00 00 00       	mov    $0x0,%eax
  2c06b4:	c3                   	ret    

00000000002c06b5 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c06b5:	55                   	push   %rbp
  2c06b6:	48 89 e5             	mov    %rsp,%rbp
  2c06b9:	48 83 ec 28          	sub    $0x28,%rsp
  2c06bd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c06c1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c06c5:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c06c9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c06cd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c06d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c06d5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c06d9:	eb 1c                	jmp    2c06f7 <memcpy+0x42>
        *d = *s;
  2c06db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c06df:	0f b6 10             	movzbl (%rax),%edx
  2c06e2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c06e6:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c06e8:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c06ed:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c06f2:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c06f7:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c06fc:	75 dd                	jne    2c06db <memcpy+0x26>
    }
    return dst;
  2c06fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0702:	c9                   	leave  
  2c0703:	c3                   	ret    

00000000002c0704 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c0704:	55                   	push   %rbp
  2c0705:	48 89 e5             	mov    %rsp,%rbp
  2c0708:	48 83 ec 28          	sub    $0x28,%rsp
  2c070c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0710:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0714:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0718:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c071c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c0720:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0724:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c0728:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c072c:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c0730:	73 6a                	jae    2c079c <memmove+0x98>
  2c0732:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0736:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c073a:	48 01 d0             	add    %rdx,%rax
  2c073d:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c0741:	73 59                	jae    2c079c <memmove+0x98>
        s += n, d += n;
  2c0743:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0747:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c074b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c074f:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c0753:	eb 17                	jmp    2c076c <memmove+0x68>
            *--d = *--s;
  2c0755:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c075a:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c075f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0763:	0f b6 10             	movzbl (%rax),%edx
  2c0766:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c076a:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c076c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0770:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0774:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0778:	48 85 c0             	test   %rax,%rax
  2c077b:	75 d8                	jne    2c0755 <memmove+0x51>
    if (s < d && s + n > d) {
  2c077d:	eb 2e                	jmp    2c07ad <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c077f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0783:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0787:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c078b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c078f:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0793:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c0797:	0f b6 12             	movzbl (%rdx),%edx
  2c079a:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c079c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c07a0:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c07a4:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c07a8:	48 85 c0             	test   %rax,%rax
  2c07ab:	75 d2                	jne    2c077f <memmove+0x7b>
        }
    }
    return dst;
  2c07ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c07b1:	c9                   	leave  
  2c07b2:	c3                   	ret    

00000000002c07b3 <memset>:

void* memset(void* v, int c, size_t n) {
  2c07b3:	55                   	push   %rbp
  2c07b4:	48 89 e5             	mov    %rsp,%rbp
  2c07b7:	48 83 ec 28          	sub    $0x28,%rsp
  2c07bb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c07bf:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c07c2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c07c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c07ca:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c07ce:	eb 15                	jmp    2c07e5 <memset+0x32>
        *p = c;
  2c07d0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c07d3:	89 c2                	mov    %eax,%edx
  2c07d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c07d9:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c07db:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c07e0:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c07e5:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c07ea:	75 e4                	jne    2c07d0 <memset+0x1d>
    }
    return v;
  2c07ec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c07f0:	c9                   	leave  
  2c07f1:	c3                   	ret    

00000000002c07f2 <strlen>:

size_t strlen(const char* s) {
  2c07f2:	55                   	push   %rbp
  2c07f3:	48 89 e5             	mov    %rsp,%rbp
  2c07f6:	48 83 ec 18          	sub    $0x18,%rsp
  2c07fa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c07fe:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0805:	00 
  2c0806:	eb 0a                	jmp    2c0812 <strlen+0x20>
        ++n;
  2c0808:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c080d:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0812:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0816:	0f b6 00             	movzbl (%rax),%eax
  2c0819:	84 c0                	test   %al,%al
  2c081b:	75 eb                	jne    2c0808 <strlen+0x16>
    }
    return n;
  2c081d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0821:	c9                   	leave  
  2c0822:	c3                   	ret    

00000000002c0823 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c0823:	55                   	push   %rbp
  2c0824:	48 89 e5             	mov    %rsp,%rbp
  2c0827:	48 83 ec 20          	sub    $0x20,%rsp
  2c082b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c082f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0833:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c083a:	00 
  2c083b:	eb 0a                	jmp    2c0847 <strnlen+0x24>
        ++n;
  2c083d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0842:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0847:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c084b:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c084f:	74 0b                	je     2c085c <strnlen+0x39>
  2c0851:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0855:	0f b6 00             	movzbl (%rax),%eax
  2c0858:	84 c0                	test   %al,%al
  2c085a:	75 e1                	jne    2c083d <strnlen+0x1a>
    }
    return n;
  2c085c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0860:	c9                   	leave  
  2c0861:	c3                   	ret    

00000000002c0862 <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c0862:	55                   	push   %rbp
  2c0863:	48 89 e5             	mov    %rsp,%rbp
  2c0866:	48 83 ec 20          	sub    $0x20,%rsp
  2c086a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c086e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c0872:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0876:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c087a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c087e:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0882:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c0886:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c088a:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c088e:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c0892:	0f b6 12             	movzbl (%rdx),%edx
  2c0895:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c0897:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c089b:	48 83 e8 01          	sub    $0x1,%rax
  2c089f:	0f b6 00             	movzbl (%rax),%eax
  2c08a2:	84 c0                	test   %al,%al
  2c08a4:	75 d4                	jne    2c087a <strcpy+0x18>
    return dst;
  2c08a6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c08aa:	c9                   	leave  
  2c08ab:	c3                   	ret    

00000000002c08ac <strcmp>:

int strcmp(const char* a, const char* b) {
  2c08ac:	55                   	push   %rbp
  2c08ad:	48 89 e5             	mov    %rsp,%rbp
  2c08b0:	48 83 ec 10          	sub    $0x10,%rsp
  2c08b4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c08b8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c08bc:	eb 0a                	jmp    2c08c8 <strcmp+0x1c>
        ++a, ++b;
  2c08be:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c08c3:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c08c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c08cc:	0f b6 00             	movzbl (%rax),%eax
  2c08cf:	84 c0                	test   %al,%al
  2c08d1:	74 1d                	je     2c08f0 <strcmp+0x44>
  2c08d3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c08d7:	0f b6 00             	movzbl (%rax),%eax
  2c08da:	84 c0                	test   %al,%al
  2c08dc:	74 12                	je     2c08f0 <strcmp+0x44>
  2c08de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c08e2:	0f b6 10             	movzbl (%rax),%edx
  2c08e5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c08e9:	0f b6 00             	movzbl (%rax),%eax
  2c08ec:	38 c2                	cmp    %al,%dl
  2c08ee:	74 ce                	je     2c08be <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c08f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c08f4:	0f b6 00             	movzbl (%rax),%eax
  2c08f7:	89 c2                	mov    %eax,%edx
  2c08f9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c08fd:	0f b6 00             	movzbl (%rax),%eax
  2c0900:	38 d0                	cmp    %dl,%al
  2c0902:	0f 92 c0             	setb   %al
  2c0905:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c0908:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c090c:	0f b6 00             	movzbl (%rax),%eax
  2c090f:	89 c1                	mov    %eax,%ecx
  2c0911:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0915:	0f b6 00             	movzbl (%rax),%eax
  2c0918:	38 c1                	cmp    %al,%cl
  2c091a:	0f 92 c0             	setb   %al
  2c091d:	0f b6 c0             	movzbl %al,%eax
  2c0920:	29 c2                	sub    %eax,%edx
  2c0922:	89 d0                	mov    %edx,%eax
}
  2c0924:	c9                   	leave  
  2c0925:	c3                   	ret    

00000000002c0926 <strchr>:

char* strchr(const char* s, int c) {
  2c0926:	55                   	push   %rbp
  2c0927:	48 89 e5             	mov    %rsp,%rbp
  2c092a:	48 83 ec 10          	sub    $0x10,%rsp
  2c092e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0932:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c0935:	eb 05                	jmp    2c093c <strchr+0x16>
        ++s;
  2c0937:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c093c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0940:	0f b6 00             	movzbl (%rax),%eax
  2c0943:	84 c0                	test   %al,%al
  2c0945:	74 0e                	je     2c0955 <strchr+0x2f>
  2c0947:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c094b:	0f b6 00             	movzbl (%rax),%eax
  2c094e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0951:	38 d0                	cmp    %dl,%al
  2c0953:	75 e2                	jne    2c0937 <strchr+0x11>
    }
    if (*s == (char) c) {
  2c0955:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0959:	0f b6 00             	movzbl (%rax),%eax
  2c095c:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c095f:	38 d0                	cmp    %dl,%al
  2c0961:	75 06                	jne    2c0969 <strchr+0x43>
        return (char*) s;
  2c0963:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0967:	eb 05                	jmp    2c096e <strchr+0x48>
    } else {
        return NULL;
  2c0969:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c096e:	c9                   	leave  
  2c096f:	c3                   	ret    

00000000002c0970 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c0970:	55                   	push   %rbp
  2c0971:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c0974:	8b 05 9e 16 00 00    	mov    0x169e(%rip),%eax        # 2c2018 <rand_seed_set>
  2c097a:	85 c0                	test   %eax,%eax
  2c097c:	75 0a                	jne    2c0988 <rand+0x18>
        srand(819234718U);
  2c097e:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c0983:	e8 24 00 00 00       	call   2c09ac <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c0988:	8b 05 8e 16 00 00    	mov    0x168e(%rip),%eax        # 2c201c <rand_seed>
  2c098e:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c0994:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c0999:	89 05 7d 16 00 00    	mov    %eax,0x167d(%rip)        # 2c201c <rand_seed>
    return rand_seed & RAND_MAX;
  2c099f:	8b 05 77 16 00 00    	mov    0x1677(%rip),%eax        # 2c201c <rand_seed>
  2c09a5:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c09aa:	5d                   	pop    %rbp
  2c09ab:	c3                   	ret    

00000000002c09ac <srand>:

void srand(unsigned seed) {
  2c09ac:	55                   	push   %rbp
  2c09ad:	48 89 e5             	mov    %rsp,%rbp
  2c09b0:	48 83 ec 08          	sub    $0x8,%rsp
  2c09b4:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c09b7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c09ba:	89 05 5c 16 00 00    	mov    %eax,0x165c(%rip)        # 2c201c <rand_seed>
    rand_seed_set = 1;
  2c09c0:	c7 05 4e 16 00 00 01 	movl   $0x1,0x164e(%rip)        # 2c2018 <rand_seed_set>
  2c09c7:	00 00 00 
}
  2c09ca:	90                   	nop
  2c09cb:	c9                   	leave  
  2c09cc:	c3                   	ret    

00000000002c09cd <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c09cd:	55                   	push   %rbp
  2c09ce:	48 89 e5             	mov    %rsp,%rbp
  2c09d1:	48 83 ec 28          	sub    $0x28,%rsp
  2c09d5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c09d9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c09dd:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c09e0:	48 c7 45 f8 e0 19 2c 	movq   $0x2c19e0,-0x8(%rbp)
  2c09e7:	00 
    if (base < 0) {
  2c09e8:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c09ec:	79 0b                	jns    2c09f9 <fill_numbuf+0x2c>
        digits = lower_digits;
  2c09ee:	48 c7 45 f8 00 1a 2c 	movq   $0x2c1a00,-0x8(%rbp)
  2c09f5:	00 
        base = -base;
  2c09f6:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c09f9:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c09fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0a02:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c0a05:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0a08:	48 63 c8             	movslq %eax,%rcx
  2c0a0b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0a0f:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0a14:	48 f7 f1             	div    %rcx
  2c0a17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a1b:	48 01 d0             	add    %rdx,%rax
  2c0a1e:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0a23:	0f b6 10             	movzbl (%rax),%edx
  2c0a26:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0a2a:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c0a2c:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0a2f:	48 63 f0             	movslq %eax,%rsi
  2c0a32:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0a36:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0a3b:	48 f7 f6             	div    %rsi
  2c0a3e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c0a42:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c0a47:	75 bc                	jne    2c0a05 <fill_numbuf+0x38>
    return numbuf_end;
  2c0a49:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0a4d:	c9                   	leave  
  2c0a4e:	c3                   	ret    

00000000002c0a4f <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c0a4f:	55                   	push   %rbp
  2c0a50:	48 89 e5             	mov    %rsp,%rbp
  2c0a53:	53                   	push   %rbx
  2c0a54:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c0a5b:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c0a62:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c0a68:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0a6f:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c0a76:	e9 8a 09 00 00       	jmp    2c1405 <printer_vprintf+0x9b6>
        if (*format != '%') {
  2c0a7b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a82:	0f b6 00             	movzbl (%rax),%eax
  2c0a85:	3c 25                	cmp    $0x25,%al
  2c0a87:	74 31                	je     2c0aba <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  2c0a89:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0a90:	4c 8b 00             	mov    (%rax),%r8
  2c0a93:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a9a:	0f b6 00             	movzbl (%rax),%eax
  2c0a9d:	0f b6 c8             	movzbl %al,%ecx
  2c0aa0:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c0aa6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0aad:	89 ce                	mov    %ecx,%esi
  2c0aaf:	48 89 c7             	mov    %rax,%rdi
  2c0ab2:	41 ff d0             	call   *%r8
            continue;
  2c0ab5:	e9 43 09 00 00       	jmp    2c13fd <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  2c0aba:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0ac1:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0ac8:	01 
  2c0ac9:	eb 44                	jmp    2c0b0f <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  2c0acb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ad2:	0f b6 00             	movzbl (%rax),%eax
  2c0ad5:	0f be c0             	movsbl %al,%eax
  2c0ad8:	89 c6                	mov    %eax,%esi
  2c0ada:	bf 00 18 2c 00       	mov    $0x2c1800,%edi
  2c0adf:	e8 42 fe ff ff       	call   2c0926 <strchr>
  2c0ae4:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c0ae8:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c0aed:	74 30                	je     2c0b1f <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  2c0aef:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c0af3:	48 2d 00 18 2c 00    	sub    $0x2c1800,%rax
  2c0af9:	ba 01 00 00 00       	mov    $0x1,%edx
  2c0afe:	89 c1                	mov    %eax,%ecx
  2c0b00:	d3 e2                	shl    %cl,%edx
  2c0b02:	89 d0                	mov    %edx,%eax
  2c0b04:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0b07:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0b0e:	01 
  2c0b0f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b16:	0f b6 00             	movzbl (%rax),%eax
  2c0b19:	84 c0                	test   %al,%al
  2c0b1b:	75 ae                	jne    2c0acb <printer_vprintf+0x7c>
  2c0b1d:	eb 01                	jmp    2c0b20 <printer_vprintf+0xd1>
            } else {
                break;
  2c0b1f:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c0b20:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c0b27:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b2e:	0f b6 00             	movzbl (%rax),%eax
  2c0b31:	3c 30                	cmp    $0x30,%al
  2c0b33:	7e 67                	jle    2c0b9c <printer_vprintf+0x14d>
  2c0b35:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b3c:	0f b6 00             	movzbl (%rax),%eax
  2c0b3f:	3c 39                	cmp    $0x39,%al
  2c0b41:	7f 59                	jg     2c0b9c <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0b43:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c0b4a:	eb 2e                	jmp    2c0b7a <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  2c0b4c:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c0b4f:	89 d0                	mov    %edx,%eax
  2c0b51:	c1 e0 02             	shl    $0x2,%eax
  2c0b54:	01 d0                	add    %edx,%eax
  2c0b56:	01 c0                	add    %eax,%eax
  2c0b58:	89 c1                	mov    %eax,%ecx
  2c0b5a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b61:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0b65:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0b6c:	0f b6 00             	movzbl (%rax),%eax
  2c0b6f:	0f be c0             	movsbl %al,%eax
  2c0b72:	01 c8                	add    %ecx,%eax
  2c0b74:	83 e8 30             	sub    $0x30,%eax
  2c0b77:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0b7a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b81:	0f b6 00             	movzbl (%rax),%eax
  2c0b84:	3c 2f                	cmp    $0x2f,%al
  2c0b86:	0f 8e 85 00 00 00    	jle    2c0c11 <printer_vprintf+0x1c2>
  2c0b8c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b93:	0f b6 00             	movzbl (%rax),%eax
  2c0b96:	3c 39                	cmp    $0x39,%al
  2c0b98:	7e b2                	jle    2c0b4c <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  2c0b9a:	eb 75                	jmp    2c0c11 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  2c0b9c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ba3:	0f b6 00             	movzbl (%rax),%eax
  2c0ba6:	3c 2a                	cmp    $0x2a,%al
  2c0ba8:	75 68                	jne    2c0c12 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  2c0baa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bb1:	8b 00                	mov    (%rax),%eax
  2c0bb3:	83 f8 2f             	cmp    $0x2f,%eax
  2c0bb6:	77 30                	ja     2c0be8 <printer_vprintf+0x199>
  2c0bb8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bbf:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0bc3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bca:	8b 00                	mov    (%rax),%eax
  2c0bcc:	89 c0                	mov    %eax,%eax
  2c0bce:	48 01 d0             	add    %rdx,%rax
  2c0bd1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0bd8:	8b 12                	mov    (%rdx),%edx
  2c0bda:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0bdd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0be4:	89 0a                	mov    %ecx,(%rdx)
  2c0be6:	eb 1a                	jmp    2c0c02 <printer_vprintf+0x1b3>
  2c0be8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bef:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0bf3:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0bf7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0bfe:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0c02:	8b 00                	mov    (%rax),%eax
  2c0c04:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c0c07:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0c0e:	01 
  2c0c0f:	eb 01                	jmp    2c0c12 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  2c0c11:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c0c12:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c0c19:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c20:	0f b6 00             	movzbl (%rax),%eax
  2c0c23:	3c 2e                	cmp    $0x2e,%al
  2c0c25:	0f 85 00 01 00 00    	jne    2c0d2b <printer_vprintf+0x2dc>
            ++format;
  2c0c2b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0c32:	01 
            if (*format >= '0' && *format <= '9') {
  2c0c33:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c3a:	0f b6 00             	movzbl (%rax),%eax
  2c0c3d:	3c 2f                	cmp    $0x2f,%al
  2c0c3f:	7e 67                	jle    2c0ca8 <printer_vprintf+0x259>
  2c0c41:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c48:	0f b6 00             	movzbl (%rax),%eax
  2c0c4b:	3c 39                	cmp    $0x39,%al
  2c0c4d:	7f 59                	jg     2c0ca8 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0c4f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c0c56:	eb 2e                	jmp    2c0c86 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  2c0c58:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c0c5b:	89 d0                	mov    %edx,%eax
  2c0c5d:	c1 e0 02             	shl    $0x2,%eax
  2c0c60:	01 d0                	add    %edx,%eax
  2c0c62:	01 c0                	add    %eax,%eax
  2c0c64:	89 c1                	mov    %eax,%ecx
  2c0c66:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c6d:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0c71:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0c78:	0f b6 00             	movzbl (%rax),%eax
  2c0c7b:	0f be c0             	movsbl %al,%eax
  2c0c7e:	01 c8                	add    %ecx,%eax
  2c0c80:	83 e8 30             	sub    $0x30,%eax
  2c0c83:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0c86:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c8d:	0f b6 00             	movzbl (%rax),%eax
  2c0c90:	3c 2f                	cmp    $0x2f,%al
  2c0c92:	0f 8e 85 00 00 00    	jle    2c0d1d <printer_vprintf+0x2ce>
  2c0c98:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c9f:	0f b6 00             	movzbl (%rax),%eax
  2c0ca2:	3c 39                	cmp    $0x39,%al
  2c0ca4:	7e b2                	jle    2c0c58 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  2c0ca6:	eb 75                	jmp    2c0d1d <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  2c0ca8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0caf:	0f b6 00             	movzbl (%rax),%eax
  2c0cb2:	3c 2a                	cmp    $0x2a,%al
  2c0cb4:	75 68                	jne    2c0d1e <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  2c0cb6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cbd:	8b 00                	mov    (%rax),%eax
  2c0cbf:	83 f8 2f             	cmp    $0x2f,%eax
  2c0cc2:	77 30                	ja     2c0cf4 <printer_vprintf+0x2a5>
  2c0cc4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ccb:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0ccf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cd6:	8b 00                	mov    (%rax),%eax
  2c0cd8:	89 c0                	mov    %eax,%eax
  2c0cda:	48 01 d0             	add    %rdx,%rax
  2c0cdd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ce4:	8b 12                	mov    (%rdx),%edx
  2c0ce6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0ce9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0cf0:	89 0a                	mov    %ecx,(%rdx)
  2c0cf2:	eb 1a                	jmp    2c0d0e <printer_vprintf+0x2bf>
  2c0cf4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cfb:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0cff:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0d03:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d0a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0d0e:	8b 00                	mov    (%rax),%eax
  2c0d10:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c0d13:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0d1a:	01 
  2c0d1b:	eb 01                	jmp    2c0d1e <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  2c0d1d:	90                   	nop
            }
            if (precision < 0) {
  2c0d1e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c0d22:	79 07                	jns    2c0d2b <printer_vprintf+0x2dc>
                precision = 0;
  2c0d24:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c0d2b:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c0d32:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c0d39:	00 
        int length = 0;
  2c0d3a:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c0d41:	48 c7 45 c8 06 18 2c 	movq   $0x2c1806,-0x38(%rbp)
  2c0d48:	00 
    again:
        switch (*format) {
  2c0d49:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d50:	0f b6 00             	movzbl (%rax),%eax
  2c0d53:	0f be c0             	movsbl %al,%eax
  2c0d56:	83 e8 43             	sub    $0x43,%eax
  2c0d59:	83 f8 37             	cmp    $0x37,%eax
  2c0d5c:	0f 87 9f 03 00 00    	ja     2c1101 <printer_vprintf+0x6b2>
  2c0d62:	89 c0                	mov    %eax,%eax
  2c0d64:	48 8b 04 c5 18 18 2c 	mov    0x2c1818(,%rax,8),%rax
  2c0d6b:	00 
  2c0d6c:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  2c0d6e:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c0d75:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0d7c:	01 
            goto again;
  2c0d7d:	eb ca                	jmp    2c0d49 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c0d7f:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0d83:	74 5d                	je     2c0de2 <printer_vprintf+0x393>
  2c0d85:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d8c:	8b 00                	mov    (%rax),%eax
  2c0d8e:	83 f8 2f             	cmp    $0x2f,%eax
  2c0d91:	77 30                	ja     2c0dc3 <printer_vprintf+0x374>
  2c0d93:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d9a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0d9e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0da5:	8b 00                	mov    (%rax),%eax
  2c0da7:	89 c0                	mov    %eax,%eax
  2c0da9:	48 01 d0             	add    %rdx,%rax
  2c0dac:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0db3:	8b 12                	mov    (%rdx),%edx
  2c0db5:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0db8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0dbf:	89 0a                	mov    %ecx,(%rdx)
  2c0dc1:	eb 1a                	jmp    2c0ddd <printer_vprintf+0x38e>
  2c0dc3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dca:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0dce:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0dd2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0dd9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0ddd:	48 8b 00             	mov    (%rax),%rax
  2c0de0:	eb 5c                	jmp    2c0e3e <printer_vprintf+0x3ef>
  2c0de2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0de9:	8b 00                	mov    (%rax),%eax
  2c0deb:	83 f8 2f             	cmp    $0x2f,%eax
  2c0dee:	77 30                	ja     2c0e20 <printer_vprintf+0x3d1>
  2c0df0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0df7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0dfb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e02:	8b 00                	mov    (%rax),%eax
  2c0e04:	89 c0                	mov    %eax,%eax
  2c0e06:	48 01 d0             	add    %rdx,%rax
  2c0e09:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e10:	8b 12                	mov    (%rdx),%edx
  2c0e12:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0e15:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e1c:	89 0a                	mov    %ecx,(%rdx)
  2c0e1e:	eb 1a                	jmp    2c0e3a <printer_vprintf+0x3eb>
  2c0e20:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e27:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0e2b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0e2f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e36:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0e3a:	8b 00                	mov    (%rax),%eax
  2c0e3c:	48 98                	cltq   
  2c0e3e:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c0e42:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0e46:	48 c1 f8 38          	sar    $0x38,%rax
  2c0e4a:	25 80 00 00 00       	and    $0x80,%eax
  2c0e4f:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c0e52:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c0e56:	74 09                	je     2c0e61 <printer_vprintf+0x412>
  2c0e58:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0e5c:	48 f7 d8             	neg    %rax
  2c0e5f:	eb 04                	jmp    2c0e65 <printer_vprintf+0x416>
  2c0e61:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0e65:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c0e69:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c0e6c:	83 c8 60             	or     $0x60,%eax
  2c0e6f:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c0e72:	e9 cf 02 00 00       	jmp    2c1146 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c0e77:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0e7b:	74 5d                	je     2c0eda <printer_vprintf+0x48b>
  2c0e7d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e84:	8b 00                	mov    (%rax),%eax
  2c0e86:	83 f8 2f             	cmp    $0x2f,%eax
  2c0e89:	77 30                	ja     2c0ebb <printer_vprintf+0x46c>
  2c0e8b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e92:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0e96:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e9d:	8b 00                	mov    (%rax),%eax
  2c0e9f:	89 c0                	mov    %eax,%eax
  2c0ea1:	48 01 d0             	add    %rdx,%rax
  2c0ea4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0eab:	8b 12                	mov    (%rdx),%edx
  2c0ead:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0eb0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0eb7:	89 0a                	mov    %ecx,(%rdx)
  2c0eb9:	eb 1a                	jmp    2c0ed5 <printer_vprintf+0x486>
  2c0ebb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ec2:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0ec6:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0eca:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ed1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0ed5:	48 8b 00             	mov    (%rax),%rax
  2c0ed8:	eb 5c                	jmp    2c0f36 <printer_vprintf+0x4e7>
  2c0eda:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ee1:	8b 00                	mov    (%rax),%eax
  2c0ee3:	83 f8 2f             	cmp    $0x2f,%eax
  2c0ee6:	77 30                	ja     2c0f18 <printer_vprintf+0x4c9>
  2c0ee8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0eef:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0ef3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0efa:	8b 00                	mov    (%rax),%eax
  2c0efc:	89 c0                	mov    %eax,%eax
  2c0efe:	48 01 d0             	add    %rdx,%rax
  2c0f01:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f08:	8b 12                	mov    (%rdx),%edx
  2c0f0a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0f0d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f14:	89 0a                	mov    %ecx,(%rdx)
  2c0f16:	eb 1a                	jmp    2c0f32 <printer_vprintf+0x4e3>
  2c0f18:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f1f:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0f23:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0f27:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f2e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0f32:	8b 00                	mov    (%rax),%eax
  2c0f34:	89 c0                	mov    %eax,%eax
  2c0f36:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c0f3a:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c0f3e:	e9 03 02 00 00       	jmp    2c1146 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  2c0f43:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c0f4a:	e9 28 ff ff ff       	jmp    2c0e77 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  2c0f4f:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c0f56:	e9 1c ff ff ff       	jmp    2c0e77 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c0f5b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f62:	8b 00                	mov    (%rax),%eax
  2c0f64:	83 f8 2f             	cmp    $0x2f,%eax
  2c0f67:	77 30                	ja     2c0f99 <printer_vprintf+0x54a>
  2c0f69:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f70:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0f74:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f7b:	8b 00                	mov    (%rax),%eax
  2c0f7d:	89 c0                	mov    %eax,%eax
  2c0f7f:	48 01 d0             	add    %rdx,%rax
  2c0f82:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f89:	8b 12                	mov    (%rdx),%edx
  2c0f8b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0f8e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f95:	89 0a                	mov    %ecx,(%rdx)
  2c0f97:	eb 1a                	jmp    2c0fb3 <printer_vprintf+0x564>
  2c0f99:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fa0:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0fa4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0fa8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0faf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0fb3:	48 8b 00             	mov    (%rax),%rax
  2c0fb6:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c0fba:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c0fc1:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c0fc8:	e9 79 01 00 00       	jmp    2c1146 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  2c0fcd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fd4:	8b 00                	mov    (%rax),%eax
  2c0fd6:	83 f8 2f             	cmp    $0x2f,%eax
  2c0fd9:	77 30                	ja     2c100b <printer_vprintf+0x5bc>
  2c0fdb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fe2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0fe6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fed:	8b 00                	mov    (%rax),%eax
  2c0fef:	89 c0                	mov    %eax,%eax
  2c0ff1:	48 01 d0             	add    %rdx,%rax
  2c0ff4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ffb:	8b 12                	mov    (%rdx),%edx
  2c0ffd:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1000:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1007:	89 0a                	mov    %ecx,(%rdx)
  2c1009:	eb 1a                	jmp    2c1025 <printer_vprintf+0x5d6>
  2c100b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1012:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1016:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c101a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1021:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1025:	48 8b 00             	mov    (%rax),%rax
  2c1028:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c102c:	e9 15 01 00 00       	jmp    2c1146 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  2c1031:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1038:	8b 00                	mov    (%rax),%eax
  2c103a:	83 f8 2f             	cmp    $0x2f,%eax
  2c103d:	77 30                	ja     2c106f <printer_vprintf+0x620>
  2c103f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1046:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c104a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1051:	8b 00                	mov    (%rax),%eax
  2c1053:	89 c0                	mov    %eax,%eax
  2c1055:	48 01 d0             	add    %rdx,%rax
  2c1058:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c105f:	8b 12                	mov    (%rdx),%edx
  2c1061:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1064:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c106b:	89 0a                	mov    %ecx,(%rdx)
  2c106d:	eb 1a                	jmp    2c1089 <printer_vprintf+0x63a>
  2c106f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1076:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c107a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c107e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1085:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1089:	8b 00                	mov    (%rax),%eax
  2c108b:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c1091:	e9 67 03 00 00       	jmp    2c13fd <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  2c1096:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c109a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c109e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10a5:	8b 00                	mov    (%rax),%eax
  2c10a7:	83 f8 2f             	cmp    $0x2f,%eax
  2c10aa:	77 30                	ja     2c10dc <printer_vprintf+0x68d>
  2c10ac:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10b3:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c10b7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10be:	8b 00                	mov    (%rax),%eax
  2c10c0:	89 c0                	mov    %eax,%eax
  2c10c2:	48 01 d0             	add    %rdx,%rax
  2c10c5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10cc:	8b 12                	mov    (%rdx),%edx
  2c10ce:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c10d1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10d8:	89 0a                	mov    %ecx,(%rdx)
  2c10da:	eb 1a                	jmp    2c10f6 <printer_vprintf+0x6a7>
  2c10dc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10e3:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c10e7:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c10eb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10f2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c10f6:	8b 00                	mov    (%rax),%eax
  2c10f8:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c10fb:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c10ff:	eb 45                	jmp    2c1146 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  2c1101:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c1105:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c1109:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1110:	0f b6 00             	movzbl (%rax),%eax
  2c1113:	84 c0                	test   %al,%al
  2c1115:	74 0c                	je     2c1123 <printer_vprintf+0x6d4>
  2c1117:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c111e:	0f b6 00             	movzbl (%rax),%eax
  2c1121:	eb 05                	jmp    2c1128 <printer_vprintf+0x6d9>
  2c1123:	b8 25 00 00 00       	mov    $0x25,%eax
  2c1128:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c112b:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c112f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1136:	0f b6 00             	movzbl (%rax),%eax
  2c1139:	84 c0                	test   %al,%al
  2c113b:	75 08                	jne    2c1145 <printer_vprintf+0x6f6>
                format--;
  2c113d:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c1144:	01 
            }
            break;
  2c1145:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c1146:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1149:	83 e0 20             	and    $0x20,%eax
  2c114c:	85 c0                	test   %eax,%eax
  2c114e:	74 1e                	je     2c116e <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c1150:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c1154:	48 83 c0 18          	add    $0x18,%rax
  2c1158:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c115b:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c115f:	48 89 ce             	mov    %rcx,%rsi
  2c1162:	48 89 c7             	mov    %rax,%rdi
  2c1165:	e8 63 f8 ff ff       	call   2c09cd <fill_numbuf>
  2c116a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c116e:	48 c7 45 c0 06 18 2c 	movq   $0x2c1806,-0x40(%rbp)
  2c1175:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c1176:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1179:	83 e0 20             	and    $0x20,%eax
  2c117c:	85 c0                	test   %eax,%eax
  2c117e:	74 48                	je     2c11c8 <printer_vprintf+0x779>
  2c1180:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1183:	83 e0 40             	and    $0x40,%eax
  2c1186:	85 c0                	test   %eax,%eax
  2c1188:	74 3e                	je     2c11c8 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  2c118a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c118d:	25 80 00 00 00       	and    $0x80,%eax
  2c1192:	85 c0                	test   %eax,%eax
  2c1194:	74 0a                	je     2c11a0 <printer_vprintf+0x751>
                prefix = "-";
  2c1196:	48 c7 45 c0 07 18 2c 	movq   $0x2c1807,-0x40(%rbp)
  2c119d:	00 
            if (flags & FLAG_NEGATIVE) {
  2c119e:	eb 73                	jmp    2c1213 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c11a0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11a3:	83 e0 10             	and    $0x10,%eax
  2c11a6:	85 c0                	test   %eax,%eax
  2c11a8:	74 0a                	je     2c11b4 <printer_vprintf+0x765>
                prefix = "+";
  2c11aa:	48 c7 45 c0 09 18 2c 	movq   $0x2c1809,-0x40(%rbp)
  2c11b1:	00 
            if (flags & FLAG_NEGATIVE) {
  2c11b2:	eb 5f                	jmp    2c1213 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c11b4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11b7:	83 e0 08             	and    $0x8,%eax
  2c11ba:	85 c0                	test   %eax,%eax
  2c11bc:	74 55                	je     2c1213 <printer_vprintf+0x7c4>
                prefix = " ";
  2c11be:	48 c7 45 c0 0b 18 2c 	movq   $0x2c180b,-0x40(%rbp)
  2c11c5:	00 
            if (flags & FLAG_NEGATIVE) {
  2c11c6:	eb 4b                	jmp    2c1213 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c11c8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11cb:	83 e0 20             	and    $0x20,%eax
  2c11ce:	85 c0                	test   %eax,%eax
  2c11d0:	74 42                	je     2c1214 <printer_vprintf+0x7c5>
  2c11d2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11d5:	83 e0 01             	and    $0x1,%eax
  2c11d8:	85 c0                	test   %eax,%eax
  2c11da:	74 38                	je     2c1214 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  2c11dc:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c11e0:	74 06                	je     2c11e8 <printer_vprintf+0x799>
  2c11e2:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c11e6:	75 2c                	jne    2c1214 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  2c11e8:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c11ed:	75 0c                	jne    2c11fb <printer_vprintf+0x7ac>
  2c11ef:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11f2:	25 00 01 00 00       	and    $0x100,%eax
  2c11f7:	85 c0                	test   %eax,%eax
  2c11f9:	74 19                	je     2c1214 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  2c11fb:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c11ff:	75 07                	jne    2c1208 <printer_vprintf+0x7b9>
  2c1201:	b8 0d 18 2c 00       	mov    $0x2c180d,%eax
  2c1206:	eb 05                	jmp    2c120d <printer_vprintf+0x7be>
  2c1208:	b8 10 18 2c 00       	mov    $0x2c1810,%eax
  2c120d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c1211:	eb 01                	jmp    2c1214 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  2c1213:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c1214:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c1218:	78 24                	js     2c123e <printer_vprintf+0x7ef>
  2c121a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c121d:	83 e0 20             	and    $0x20,%eax
  2c1220:	85 c0                	test   %eax,%eax
  2c1222:	75 1a                	jne    2c123e <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  2c1224:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1227:	48 63 d0             	movslq %eax,%rdx
  2c122a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c122e:	48 89 d6             	mov    %rdx,%rsi
  2c1231:	48 89 c7             	mov    %rax,%rdi
  2c1234:	e8 ea f5 ff ff       	call   2c0823 <strnlen>
  2c1239:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c123c:	eb 0f                	jmp    2c124d <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  2c123e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1242:	48 89 c7             	mov    %rax,%rdi
  2c1245:	e8 a8 f5 ff ff       	call   2c07f2 <strlen>
  2c124a:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c124d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1250:	83 e0 20             	and    $0x20,%eax
  2c1253:	85 c0                	test   %eax,%eax
  2c1255:	74 20                	je     2c1277 <printer_vprintf+0x828>
  2c1257:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c125b:	78 1a                	js     2c1277 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  2c125d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1260:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c1263:	7e 08                	jle    2c126d <printer_vprintf+0x81e>
  2c1265:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1268:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c126b:	eb 05                	jmp    2c1272 <printer_vprintf+0x823>
  2c126d:	b8 00 00 00 00       	mov    $0x0,%eax
  2c1272:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c1275:	eb 5c                	jmp    2c12d3 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c1277:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c127a:	83 e0 20             	and    $0x20,%eax
  2c127d:	85 c0                	test   %eax,%eax
  2c127f:	74 4b                	je     2c12cc <printer_vprintf+0x87d>
  2c1281:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1284:	83 e0 02             	and    $0x2,%eax
  2c1287:	85 c0                	test   %eax,%eax
  2c1289:	74 41                	je     2c12cc <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c128b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c128e:	83 e0 04             	and    $0x4,%eax
  2c1291:	85 c0                	test   %eax,%eax
  2c1293:	75 37                	jne    2c12cc <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  2c1295:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1299:	48 89 c7             	mov    %rax,%rdi
  2c129c:	e8 51 f5 ff ff       	call   2c07f2 <strlen>
  2c12a1:	89 c2                	mov    %eax,%edx
  2c12a3:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c12a6:	01 d0                	add    %edx,%eax
  2c12a8:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c12ab:	7e 1f                	jle    2c12cc <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  2c12ad:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c12b0:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c12b3:	89 c3                	mov    %eax,%ebx
  2c12b5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c12b9:	48 89 c7             	mov    %rax,%rdi
  2c12bc:	e8 31 f5 ff ff       	call   2c07f2 <strlen>
  2c12c1:	89 c2                	mov    %eax,%edx
  2c12c3:	89 d8                	mov    %ebx,%eax
  2c12c5:	29 d0                	sub    %edx,%eax
  2c12c7:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c12ca:	eb 07                	jmp    2c12d3 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  2c12cc:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c12d3:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c12d6:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c12d9:	01 d0                	add    %edx,%eax
  2c12db:	48 63 d8             	movslq %eax,%rbx
  2c12de:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c12e2:	48 89 c7             	mov    %rax,%rdi
  2c12e5:	e8 08 f5 ff ff       	call   2c07f2 <strlen>
  2c12ea:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c12ee:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c12f1:	29 d0                	sub    %edx,%eax
  2c12f3:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c12f6:	eb 25                	jmp    2c131d <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  2c12f8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c12ff:	48 8b 08             	mov    (%rax),%rcx
  2c1302:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1308:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c130f:	be 20 00 00 00       	mov    $0x20,%esi
  2c1314:	48 89 c7             	mov    %rax,%rdi
  2c1317:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c1319:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c131d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1320:	83 e0 04             	and    $0x4,%eax
  2c1323:	85 c0                	test   %eax,%eax
  2c1325:	75 36                	jne    2c135d <printer_vprintf+0x90e>
  2c1327:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c132b:	7f cb                	jg     2c12f8 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  2c132d:	eb 2e                	jmp    2c135d <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  2c132f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1336:	4c 8b 00             	mov    (%rax),%r8
  2c1339:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c133d:	0f b6 00             	movzbl (%rax),%eax
  2c1340:	0f b6 c8             	movzbl %al,%ecx
  2c1343:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1349:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1350:	89 ce                	mov    %ecx,%esi
  2c1352:	48 89 c7             	mov    %rax,%rdi
  2c1355:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c1358:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c135d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1361:	0f b6 00             	movzbl (%rax),%eax
  2c1364:	84 c0                	test   %al,%al
  2c1366:	75 c7                	jne    2c132f <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  2c1368:	eb 25                	jmp    2c138f <printer_vprintf+0x940>
            p->putc(p, '0', color);
  2c136a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1371:	48 8b 08             	mov    (%rax),%rcx
  2c1374:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c137a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1381:	be 30 00 00 00       	mov    $0x30,%esi
  2c1386:	48 89 c7             	mov    %rax,%rdi
  2c1389:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c138b:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c138f:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c1393:	7f d5                	jg     2c136a <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  2c1395:	eb 32                	jmp    2c13c9 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  2c1397:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c139e:	4c 8b 00             	mov    (%rax),%r8
  2c13a1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c13a5:	0f b6 00             	movzbl (%rax),%eax
  2c13a8:	0f b6 c8             	movzbl %al,%ecx
  2c13ab:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c13b1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c13b8:	89 ce                	mov    %ecx,%esi
  2c13ba:	48 89 c7             	mov    %rax,%rdi
  2c13bd:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c13c0:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c13c5:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c13c9:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c13cd:	7f c8                	jg     2c1397 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  2c13cf:	eb 25                	jmp    2c13f6 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  2c13d1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c13d8:	48 8b 08             	mov    (%rax),%rcx
  2c13db:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c13e1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c13e8:	be 20 00 00 00       	mov    $0x20,%esi
  2c13ed:	48 89 c7             	mov    %rax,%rdi
  2c13f0:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c13f2:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c13f6:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c13fa:	7f d5                	jg     2c13d1 <printer_vprintf+0x982>
        }
    done: ;
  2c13fc:	90                   	nop
    for (; *format; ++format) {
  2c13fd:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c1404:	01 
  2c1405:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c140c:	0f b6 00             	movzbl (%rax),%eax
  2c140f:	84 c0                	test   %al,%al
  2c1411:	0f 85 64 f6 ff ff    	jne    2c0a7b <printer_vprintf+0x2c>
    }
}
  2c1417:	90                   	nop
  2c1418:	90                   	nop
  2c1419:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c141d:	c9                   	leave  
  2c141e:	c3                   	ret    

00000000002c141f <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c141f:	55                   	push   %rbp
  2c1420:	48 89 e5             	mov    %rsp,%rbp
  2c1423:	48 83 ec 20          	sub    $0x20,%rsp
  2c1427:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c142b:	89 f0                	mov    %esi,%eax
  2c142d:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1430:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c1433:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1437:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c143b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c143f:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1443:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  2c1448:	48 39 d0             	cmp    %rdx,%rax
  2c144b:	72 0c                	jb     2c1459 <console_putc+0x3a>
        cp->cursor = console;
  2c144d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1451:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  2c1458:	00 
    }
    if (c == '\n') {
  2c1459:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c145d:	75 78                	jne    2c14d7 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  2c145f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1463:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1467:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c146d:	48 d1 f8             	sar    %rax
  2c1470:	48 89 c1             	mov    %rax,%rcx
  2c1473:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c147a:	66 66 66 
  2c147d:	48 89 c8             	mov    %rcx,%rax
  2c1480:	48 f7 ea             	imul   %rdx
  2c1483:	48 c1 fa 05          	sar    $0x5,%rdx
  2c1487:	48 89 c8             	mov    %rcx,%rax
  2c148a:	48 c1 f8 3f          	sar    $0x3f,%rax
  2c148e:	48 29 c2             	sub    %rax,%rdx
  2c1491:	48 89 d0             	mov    %rdx,%rax
  2c1494:	48 c1 e0 02          	shl    $0x2,%rax
  2c1498:	48 01 d0             	add    %rdx,%rax
  2c149b:	48 c1 e0 04          	shl    $0x4,%rax
  2c149f:	48 29 c1             	sub    %rax,%rcx
  2c14a2:	48 89 ca             	mov    %rcx,%rdx
  2c14a5:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c14a8:	eb 25                	jmp    2c14cf <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  2c14aa:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c14ad:	83 c8 20             	or     $0x20,%eax
  2c14b0:	89 c6                	mov    %eax,%esi
  2c14b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c14b6:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c14ba:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c14be:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c14c2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c14c6:	89 f2                	mov    %esi,%edx
  2c14c8:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c14cb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c14cf:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c14d3:	75 d5                	jne    2c14aa <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c14d5:	eb 24                	jmp    2c14fb <console_putc+0xdc>
        *cp->cursor++ = c | color;
  2c14d7:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  2c14db:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c14de:	09 d0                	or     %edx,%eax
  2c14e0:	89 c6                	mov    %eax,%esi
  2c14e2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c14e6:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c14ea:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c14ee:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c14f2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c14f6:	89 f2                	mov    %esi,%edx
  2c14f8:	66 89 10             	mov    %dx,(%rax)
}
  2c14fb:	90                   	nop
  2c14fc:	c9                   	leave  
  2c14fd:	c3                   	ret    

00000000002c14fe <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c14fe:	55                   	push   %rbp
  2c14ff:	48 89 e5             	mov    %rsp,%rbp
  2c1502:	48 83 ec 30          	sub    $0x30,%rsp
  2c1506:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c1509:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c150c:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c1510:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c1514:	48 c7 45 f0 1f 14 2c 	movq   $0x2c141f,-0x10(%rbp)
  2c151b:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c151c:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c1520:	78 09                	js     2c152b <console_vprintf+0x2d>
  2c1522:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c1529:	7e 07                	jle    2c1532 <console_vprintf+0x34>
        cpos = 0;
  2c152b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c1532:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1535:	48 98                	cltq   
  2c1537:	48 01 c0             	add    %rax,%rax
  2c153a:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  2c1540:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c1544:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c1548:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c154c:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c154f:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c1553:	48 89 c7             	mov    %rax,%rdi
  2c1556:	e8 f4 f4 ff ff       	call   2c0a4f <printer_vprintf>
    return cp.cursor - console;
  2c155b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c155f:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c1565:	48 d1 f8             	sar    %rax
}
  2c1568:	c9                   	leave  
  2c1569:	c3                   	ret    

00000000002c156a <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c156a:	55                   	push   %rbp
  2c156b:	48 89 e5             	mov    %rsp,%rbp
  2c156e:	48 83 ec 60          	sub    $0x60,%rsp
  2c1572:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c1575:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c1578:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c157c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1580:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c1584:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c1588:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c158f:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1593:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c1597:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c159b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c159f:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c15a3:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c15a7:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c15aa:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c15ad:	89 c7                	mov    %eax,%edi
  2c15af:	e8 4a ff ff ff       	call   2c14fe <console_vprintf>
  2c15b4:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c15b7:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c15ba:	c9                   	leave  
  2c15bb:	c3                   	ret    

00000000002c15bc <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c15bc:	55                   	push   %rbp
  2c15bd:	48 89 e5             	mov    %rsp,%rbp
  2c15c0:	48 83 ec 20          	sub    $0x20,%rsp
  2c15c4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c15c8:	89 f0                	mov    %esi,%eax
  2c15ca:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c15cd:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c15d0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c15d4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c15d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c15dc:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c15e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c15e4:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c15e8:	48 39 c2             	cmp    %rax,%rdx
  2c15eb:	73 1a                	jae    2c1607 <string_putc+0x4b>
        *sp->s++ = c;
  2c15ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c15f1:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c15f5:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c15f9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c15fd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1601:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c1605:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c1607:	90                   	nop
  2c1608:	c9                   	leave  
  2c1609:	c3                   	ret    

00000000002c160a <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c160a:	55                   	push   %rbp
  2c160b:	48 89 e5             	mov    %rsp,%rbp
  2c160e:	48 83 ec 40          	sub    $0x40,%rsp
  2c1612:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c1616:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c161a:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c161e:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c1622:	48 c7 45 e8 bc 15 2c 	movq   $0x2c15bc,-0x18(%rbp)
  2c1629:	00 
    sp.s = s;
  2c162a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c162e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c1632:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c1637:	74 33                	je     2c166c <vsnprintf+0x62>
        sp.end = s + size - 1;
  2c1639:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c163d:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c1641:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1645:	48 01 d0             	add    %rdx,%rax
  2c1648:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c164c:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c1650:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c1654:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c1658:	be 00 00 00 00       	mov    $0x0,%esi
  2c165d:	48 89 c7             	mov    %rax,%rdi
  2c1660:	e8 ea f3 ff ff       	call   2c0a4f <printer_vprintf>
        *sp.s = 0;
  2c1665:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1669:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c166c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1670:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c1674:	c9                   	leave  
  2c1675:	c3                   	ret    

00000000002c1676 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c1676:	55                   	push   %rbp
  2c1677:	48 89 e5             	mov    %rsp,%rbp
  2c167a:	48 83 ec 70          	sub    $0x70,%rsp
  2c167e:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c1682:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c1686:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c168a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c168e:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c1692:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c1696:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c169d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c16a1:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c16a5:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c16a9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c16ad:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c16b1:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c16b5:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c16b9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c16bd:	48 89 c7             	mov    %rax,%rdi
  2c16c0:	e8 45 ff ff ff       	call   2c160a <vsnprintf>
  2c16c5:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c16c8:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c16cb:	c9                   	leave  
  2c16cc:	c3                   	ret    

00000000002c16cd <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c16cd:	55                   	push   %rbp
  2c16ce:	48 89 e5             	mov    %rsp,%rbp
  2c16d1:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c16d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c16dc:	eb 13                	jmp    2c16f1 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  2c16de:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c16e1:	48 98                	cltq   
  2c16e3:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  2c16ea:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c16ed:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c16f1:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c16f8:	7e e4                	jle    2c16de <console_clear+0x11>
    }
    cursorpos = 0;
  2c16fa:	c7 05 f8 78 df ff 00 	movl   $0x0,-0x208708(%rip)        # b8ffc <cursorpos>
  2c1701:	00 00 00 
}
  2c1704:	90                   	nop
  2c1705:	c9                   	leave  
  2c1706:	c3                   	ret    
