
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
  2c0016:	e8 9a 09 00 00       	call   2c09b5 <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001b:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0020:	e8 a2 04 00 00       	call   2c04c7 <malloc>
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
  2c003f:	e8 58 05 00 00       	call   2c059c <realloc>
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
  2c0067:	e8 02 05 00 00       	call   2c056e <calloc>
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
  2c0086:	e8 2d 06 00 00       	call   2c06b8 <heap_info>
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
  2c0130:	e8 92 03 00 00       	call   2c04c7 <malloc>
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
  2c01f6:	e8 0c 13 00 00       	call   2c1507 <console_vprintf>
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
  2c025b:	e8 5e 04 00 00       	call   2c06be <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0260:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0264:	48 89 da             	mov    %rbx,%rdx
  2c0267:	be 99 00 00 00       	mov    $0x99,%esi
  2c026c:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c0273:	e8 9b 13 00 00       	call   2c1613 <vsnprintf>
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
  2c02ac:	e8 c2 12 00 00       	call   2c1573 <console_printf>
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
  2c02d7:	e8 8f 05 00 00       	call   2c086b <strcpy>
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
  2c02ff:	e8 6f 12 00 00       	call   2c1573 <console_printf>
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
int extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  2c03af:	48 81 c7 ff 3f 00 00 	add    $0x3fff,%rdi
  2c03b6:	48 81 e7 00 c0 ff ff 	and    $0xffffffffffffc000,%rdi
  2c03bd:	cd 3a                	int    $0x3a
  2c03bf:	48 89 05 4a 1c 00 00 	mov    %rax,0x1c4a(%rip)        # 2c2010 <result.0>
	void *bp = sbrk(chunk_aligned_size);
	if (bp == (void *)-1)
  2c03c6:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c03ca:	74 58                	je     2c0424 <extend+0x75>
		return -1;

	// setup pointer
	GET_SIZE(HDRP(bp)) = chunk_aligned_size;
  2c03cc:	48 89 78 f0          	mov    %rdi,-0x10(%rax)
	GET_ALLOC(HDRP(bp)) = 0;
  2c03d0:	c7 40 f8 00 00 00 00 	movl   $0x0,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  2c03d7:	48 8b 15 22 1c 00 00 	mov    0x1c22(%rip),%rdx        # 2c2000 <free_list>
  2c03de:	48 89 10             	mov    %rdx,(%rax)
	PREV_FPTR(bp) = NULL;
  2c03e1:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  2c03e8:	00 
	GET_SIZE(FTRP(bp)) = GET_SIZE(HDRP(bp));
  2c03e9:	48 89 7c 07 e0       	mov    %rdi,-0x20(%rdi,%rax,1)

	// add to head of free_list
	if (free_list)
  2c03ee:	48 8b 15 0b 1c 00 00 	mov    0x1c0b(%rip),%rdx        # 2c2000 <free_list>
  2c03f5:	48 85 d2             	test   %rdx,%rdx
  2c03f8:	74 04                	je     2c03fe <extend+0x4f>
		PREV_FPTR(free_list) = bp;
  2c03fa:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  2c03fe:	48 89 05 fb 1b 00 00 	mov    %rax,0x1bfb(%rip)        # 2c2000 <free_list>

	// update terminal block
	GET_SIZE(HDRP(NEXT_BLKP(bp))) = 0;
  2c0405:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  2c0409:	48 c7 44 10 f0 00 00 	movq   $0x0,-0x10(%rax,%rdx,1)
  2c0410:	00 00 
	GET_ALLOC(HDRP(NEXT_BLKP(bp))) = 1;
  2c0412:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  2c0416:	c7 44 10 f8 01 00 00 	movl   $0x1,-0x8(%rax,%rdx,1)
  2c041d:	00 
	return 0;
  2c041e:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0423:	c3                   	ret    
		return -1;
  2c0424:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  2c0429:	c3                   	ret    

00000000002c042a <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
  2c042a:	48 89 f8             	mov    %rdi,%rax
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  2c042d:	48 8b 57 f0          	mov    -0x10(%rdi),%rdx
  2c0431:	48 29 f2             	sub    %rsi,%rdx

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  2c0434:	48 83 fa 30          	cmp    $0x30,%rdx
  2c0438:	76 57                	jbe    2c0491 <set_allocated+0x67>
		GET_SIZE(HDRP(bp)) = size;
  2c043a:	48 89 77 f0          	mov    %rsi,-0x10(%rdi)
		void *leftover_mem_ptr = NEXT_BLKP(bp);
  2c043e:	48 01 fe             	add    %rdi,%rsi

		GET_SIZE(HDRP(leftover_mem_ptr)) = extra_size;
  2c0441:	48 89 56 f0          	mov    %rdx,-0x10(%rsi)
		GET_ALLOC(HDRP(leftover_mem_ptr)) = 0;
  2c0445:	c7 46 f8 00 00 00 00 	movl   $0x0,-0x8(%rsi)
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp); // pointers to the nearby free blocks
  2c044c:	48 8b 0f             	mov    (%rdi),%rcx
  2c044f:	48 89 0e             	mov    %rcx,(%rsi)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  2c0452:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  2c0456:	48 89 4e 08          	mov    %rcx,0x8(%rsi)
		GET_SIZE(FTRP(leftover_mem_ptr)) = GET_SIZE(HDRP(leftover_mem_ptr));
  2c045a:	48 89 54 16 e0       	mov    %rdx,-0x20(%rsi,%rdx,1)

		// update the free list
		if (free_list == bp)
  2c045f:	48 39 3d 9a 1b 00 00 	cmp    %rdi,0x1b9a(%rip)        # 2c2000 <free_list>
  2c0466:	74 20                	je     2c0488 <set_allocated+0x5e>
			free_list = leftover_mem_ptr;

		if (PREV_FPTR(bp))
  2c0468:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c046c:	48 85 d2             	test   %rdx,%rdx
  2c046f:	74 03                	je     2c0474 <set_allocated+0x4a>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  2c0471:	48 89 32             	mov    %rsi,(%rdx)
		if (NEXT_FPTR(bp))
  2c0474:	48 8b 10             	mov    (%rax),%rdx
  2c0477:	48 85 d2             	test   %rdx,%rdx
  2c047a:	74 04                	je     2c0480 <set_allocated+0x56>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  2c047c:	48 89 72 08          	mov    %rsi,0x8(%rdx)
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
		if (NEXT_FPTR(bp))
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
	}
	
	GET_ALLOC(HDRP(bp)) = 1;
  2c0480:	c7 40 f8 01 00 00 00 	movl   $0x1,-0x8(%rax)
}
  2c0487:	c3                   	ret    
			free_list = leftover_mem_ptr;
  2c0488:	48 89 35 71 1b 00 00 	mov    %rsi,0x1b71(%rip)        # 2c2000 <free_list>
  2c048f:	eb d7                	jmp    2c0468 <set_allocated+0x3e>
		if (free_list == bp)
  2c0491:	48 39 3d 68 1b 00 00 	cmp    %rdi,0x1b68(%rip)        # 2c2000 <free_list>
  2c0498:	74 21                	je     2c04bb <set_allocated+0x91>
		if (PREV_FPTR(bp))
  2c049a:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c049e:	48 85 d2             	test   %rdx,%rdx
  2c04a1:	74 06                	je     2c04a9 <set_allocated+0x7f>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  2c04a3:	48 8b 08             	mov    (%rax),%rcx
  2c04a6:	48 89 0a             	mov    %rcx,(%rdx)
		if (NEXT_FPTR(bp))
  2c04a9:	48 8b 10             	mov    (%rax),%rdx
  2c04ac:	48 85 d2             	test   %rdx,%rdx
  2c04af:	74 cf                	je     2c0480 <set_allocated+0x56>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  2c04b1:	48 8b 48 08          	mov    0x8(%rax),%rcx
  2c04b5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c04b9:	eb c5                	jmp    2c0480 <set_allocated+0x56>
			free_list = NEXT_FPTR(bp);
  2c04bb:	48 8b 17             	mov    (%rdi),%rdx
  2c04be:	48 89 15 3b 1b 00 00 	mov    %rdx,0x1b3b(%rip)        # 2c2000 <free_list>
  2c04c5:	eb d3                	jmp    2c049a <set_allocated+0x70>

00000000002c04c7 <malloc>:

void *malloc(uint64_t numbytes) {
  2c04c7:	55                   	push   %rbp
  2c04c8:	48 89 e5             	mov    %rsp,%rbp
  2c04cb:	41 55                	push   %r13
  2c04cd:	41 54                	push   %r12
  2c04cf:	53                   	push   %rbx
  2c04d0:	48 83 ec 08          	sub    $0x8,%rsp
  2c04d4:	49 89 fc             	mov    %rdi,%r12
	if (!initialized_heap)
  2c04d7:	83 3d 2a 1b 00 00 00 	cmpl   $0x0,0x1b2a(%rip)        # 2c2008 <initialized_heap>
  2c04de:	74 60                	je     2c0540 <malloc+0x79>
		heap_init();

	if (numbytes == 0)
  2c04e0:	4d 85 e4             	test   %r12,%r12
  2c04e3:	74 7b                	je     2c0560 <malloc+0x99>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  2c04e5:	49 83 c4 1f          	add    $0x1f,%r12
  2c04e9:	49 83 e4 f0          	and    $0xfffffffffffffff0,%r12
  2c04ed:	b8 30 00 00 00       	mov    $0x30,%eax
  2c04f2:	49 39 c4             	cmp    %rax,%r12
  2c04f5:	4c 0f 42 e0          	cmovb  %rax,%r12
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);

	void *bp = free_list;
  2c04f9:	48 8b 1d 00 1b 00 00 	mov    0x1b00(%rip),%rbx        # 2c2000 <free_list>
	while (bp) {
  2c0500:	48 85 db             	test   %rbx,%rbx
  2c0503:	74 0e                	je     2c0513 <malloc+0x4c>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  2c0505:	4c 39 63 f0          	cmp    %r12,-0x10(%rbx)
  2c0509:	73 3c                	jae    2c0547 <malloc+0x80>
			set_allocated(bp, aligned_size);
			return bp;
		}

		bp = NEXT_FPTR(bp);
  2c050b:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  2c050e:	48 85 db             	test   %rbx,%rbx
  2c0511:	75 f2                	jne    2c0505 <malloc+0x3e>
  2c0513:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0518:	cd 3a                	int    $0x3a
  2c051a:	49 89 c5             	mov    %rax,%r13
  2c051d:	48 89 05 ec 1a 00 00 	mov    %rax,0x1aec(%rip)        # 2c2010 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  2c0524:	48 89 c3             	mov    %rax,%rbx
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	if (extend(aligned_size)) {
  2c0527:	4c 89 e7             	mov    %r12,%rdi
  2c052a:	e8 80 fe ff ff       	call   2c03af <extend>
  2c052f:	85 c0                	test   %eax,%eax
  2c0531:	75 34                	jne    2c0567 <malloc+0xa0>
		return NULL;
	}
	set_allocated(bp, aligned_size);
  2c0533:	4c 89 e6             	mov    %r12,%rsi
  2c0536:	4c 89 ef             	mov    %r13,%rdi
  2c0539:	e8 ec fe ff ff       	call   2c042a <set_allocated>
    return bp;
  2c053e:	eb 12                	jmp    2c0552 <malloc+0x8b>
		heap_init();
  2c0540:	e8 c8 fd ff ff       	call   2c030d <heap_init>
  2c0545:	eb 99                	jmp    2c04e0 <malloc+0x19>
			set_allocated(bp, aligned_size);
  2c0547:	4c 89 e6             	mov    %r12,%rsi
  2c054a:	48 89 df             	mov    %rbx,%rdi
  2c054d:	e8 d8 fe ff ff       	call   2c042a <set_allocated>
}
  2c0552:	48 89 d8             	mov    %rbx,%rax
  2c0555:	48 83 c4 08          	add    $0x8,%rsp
  2c0559:	5b                   	pop    %rbx
  2c055a:	41 5c                	pop    %r12
  2c055c:	41 5d                	pop    %r13
  2c055e:	5d                   	pop    %rbp
  2c055f:	c3                   	ret    
		return NULL;
  2c0560:	bb 00 00 00 00       	mov    $0x0,%ebx
  2c0565:	eb eb                	jmp    2c0552 <malloc+0x8b>
		return NULL;
  2c0567:	bb 00 00 00 00       	mov    $0x0,%ebx
  2c056c:	eb e4                	jmp    2c0552 <malloc+0x8b>

00000000002c056e <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  2c056e:	55                   	push   %rbp
  2c056f:	48 89 e5             	mov    %rsp,%rbp
  2c0572:	41 54                	push   %r12
  2c0574:	53                   	push   %rbx
	void *bp = malloc(num * sz);
  2c0575:	48 0f af fe          	imul   %rsi,%rdi
  2c0579:	49 89 fc             	mov    %rdi,%r12
  2c057c:	e8 46 ff ff ff       	call   2c04c7 <malloc>
  2c0581:	48 89 c3             	mov    %rax,%rbx
	memset(bp, 0, num * sz);
  2c0584:	4c 89 e2             	mov    %r12,%rdx
  2c0587:	be 00 00 00 00       	mov    $0x0,%esi
  2c058c:	48 89 c7             	mov    %rax,%rdi
  2c058f:	e8 28 02 00 00       	call   2c07bc <memset>
	return bp;
}
  2c0594:	48 89 d8             	mov    %rbx,%rax
  2c0597:	5b                   	pop    %rbx
  2c0598:	41 5c                	pop    %r12
  2c059a:	5d                   	pop    %rbp
  2c059b:	c3                   	ret    

00000000002c059c <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  2c059c:	55                   	push   %rbp
  2c059d:	48 89 e5             	mov    %rsp,%rbp
  2c05a0:	41 54                	push   %r12
  2c05a2:	53                   	push   %rbx
  2c05a3:	48 89 fb             	mov    %rdi,%rbx
	// first check if there's enough space in the block already
	if (GET_SIZE(HDRP(ptr)) >= sz)
  2c05a6:	48 39 77 f0          	cmp    %rsi,-0x10(%rdi)
  2c05aa:	72 08                	jb     2c05b4 <realloc+0x18>
	void *bigger_ptr = malloc(sz);
	memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
	free(ptr);

    return bigger_ptr;
}
  2c05ac:	48 89 d8             	mov    %rbx,%rax
  2c05af:	5b                   	pop    %rbx
  2c05b0:	41 5c                	pop    %r12
  2c05b2:	5d                   	pop    %rbp
  2c05b3:	c3                   	ret    
	void *bigger_ptr = malloc(sz);
  2c05b4:	48 89 f7             	mov    %rsi,%rdi
  2c05b7:	e8 0b ff ff ff       	call   2c04c7 <malloc>
  2c05bc:	49 89 c4             	mov    %rax,%r12
	memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
  2c05bf:	48 8b 53 f0          	mov    -0x10(%rbx),%rdx
  2c05c3:	48 89 de             	mov    %rbx,%rsi
  2c05c6:	48 89 c7             	mov    %rax,%rdi
  2c05c9:	e8 f0 00 00 00       	call   2c06be <memcpy>
	free(ptr);
  2c05ce:	48 89 df             	mov    %rbx,%rdi
  2c05d1:	e8 9f fd ff ff       	call   2c0375 <free>
    return bigger_ptr;
  2c05d6:	4c 89 e3             	mov    %r12,%rbx
  2c05d9:	eb d1                	jmp    2c05ac <realloc+0x10>

00000000002c05db <defrag>:

void defrag() {
	void *fp = free_list;
  2c05db:	48 8b 05 1e 1a 00 00 	mov    0x1a1e(%rip),%rax        # 2c2000 <free_list>
	while (fp != NULL) {
  2c05e2:	48 85 c0             	test   %rax,%rax
  2c05e5:	75 3a                	jne    2c0621 <defrag+0x46>
			GET_SIZE(FTRP(prev_block)) = GET_SIZE(HDRP(prev_block));
		}

		fp = NEXT_FPTR(fp);
	}
}
  2c05e7:	c3                   	ret    
				free_list = NEXT_FPTR(next_block);
  2c05e8:	48 8b 0a             	mov    (%rdx),%rcx
  2c05eb:	48 89 0d 0e 1a 00 00 	mov    %rcx,0x1a0e(%rip)        # 2c2000 <free_list>
  2c05f2:	eb 43                	jmp    2c0637 <defrag+0x5c>
			fp = NEXT_FPTR(fp);
  2c05f4:	48 8b 00             	mov    (%rax),%rax
			continue;
  2c05f7:	eb 23                	jmp    2c061c <defrag+0x41>
				free_list = NEXT_FPTR(fp);
  2c05f9:	48 8b 08             	mov    (%rax),%rcx
  2c05fc:	48 89 0d fd 19 00 00 	mov    %rcx,0x19fd(%rip)        # 2c2000 <free_list>
  2c0603:	e9 88 00 00 00       	jmp    2c0690 <defrag+0xb5>
			GET_SIZE(HDRP(prev_block)) = GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp));
  2c0608:	48 8b 48 f0          	mov    -0x10(%rax),%rcx
  2c060c:	48 03 4a f0          	add    -0x10(%rdx),%rcx
  2c0610:	48 89 4a f0          	mov    %rcx,-0x10(%rdx)
			GET_SIZE(FTRP(prev_block)) = GET_SIZE(HDRP(prev_block));
  2c0614:	48 89 4c 0a e0       	mov    %rcx,-0x20(%rdx,%rcx,1)
		fp = NEXT_FPTR(fp);
  2c0619:	48 8b 00             	mov    (%rax),%rax
	while (fp != NULL) {
  2c061c:	48 85 c0             	test   %rax,%rax
  2c061f:	74 c6                	je     2c05e7 <defrag+0xc>
		void *next_block = NEXT_BLKP(fp);
  2c0621:	48 89 c2             	mov    %rax,%rdx
  2c0624:	48 03 50 f0          	add    -0x10(%rax),%rdx
		if (!GET_ALLOC(HDRP(next_block))) {
  2c0628:	83 7a f8 00          	cmpl   $0x0,-0x8(%rdx)
  2c062c:	75 39                	jne    2c0667 <defrag+0x8c>
			if (free_list == next_block)
  2c062e:	48 39 15 cb 19 00 00 	cmp    %rdx,0x19cb(%rip)        # 2c2000 <free_list>
  2c0635:	74 b1                	je     2c05e8 <defrag+0xd>
			if (PREV_FPTR(next_block)) 
  2c0637:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  2c063b:	48 85 c9             	test   %rcx,%rcx
  2c063e:	74 06                	je     2c0646 <defrag+0x6b>
				NEXT_FPTR(PREV_FPTR(next_block)) = NEXT_FPTR(next_block);
  2c0640:	48 8b 32             	mov    (%rdx),%rsi
  2c0643:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(next_block)) 
  2c0646:	48 8b 0a             	mov    (%rdx),%rcx
  2c0649:	48 85 c9             	test   %rcx,%rcx
  2c064c:	74 08                	je     2c0656 <defrag+0x7b>
				PREV_FPTR(NEXT_FPTR(next_block)) = PREV_FPTR(next_block);
  2c064e:	48 8b 72 08          	mov    0x8(%rdx),%rsi
  2c0652:	48 89 71 08          	mov    %rsi,0x8(%rcx)
			GET_SIZE(HDRP(fp)) = GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block));
  2c0656:	48 8b 52 f0          	mov    -0x10(%rdx),%rdx
  2c065a:	48 03 50 f0          	add    -0x10(%rax),%rdx
  2c065e:	48 89 50 f0          	mov    %rdx,-0x10(%rax)
			GET_SIZE(FTRP(fp)) = GET_SIZE(HDRP(fp));
  2c0662:	48 89 54 10 e0       	mov    %rdx,-0x20(%rax,%rdx,1)
		void *prev_block = PREV_BLKP(fp);
  2c0667:	48 89 c2             	mov    %rax,%rdx
  2c066a:	48 2b 50 e0          	sub    -0x20(%rax),%rdx
		if (GET_SIZE(HDRP(prev_block)) != GET_SIZE(FTRP(prev_block))){
  2c066e:	48 8b 4a f0          	mov    -0x10(%rdx),%rcx
  2c0672:	48 3b 4c 0a e0       	cmp    -0x20(%rdx,%rcx,1),%rcx
  2c0677:	0f 85 77 ff ff ff    	jne    2c05f4 <defrag+0x19>
		if (!GET_ALLOC(HDRP(prev_block))) {
  2c067d:	83 7a f8 00          	cmpl   $0x0,-0x8(%rdx)
  2c0681:	75 96                	jne    2c0619 <defrag+0x3e>
			if (free_list == fp)
  2c0683:	48 39 05 76 19 00 00 	cmp    %rax,0x1976(%rip)        # 2c2000 <free_list>
  2c068a:	0f 84 69 ff ff ff    	je     2c05f9 <defrag+0x1e>
			if (PREV_FPTR(fp)) 
  2c0690:	48 8b 48 08          	mov    0x8(%rax),%rcx
  2c0694:	48 85 c9             	test   %rcx,%rcx
  2c0697:	74 06                	je     2c069f <defrag+0xc4>
				NEXT_FPTR(PREV_FPTR(fp)) = NEXT_FPTR(fp);
  2c0699:	48 8b 30             	mov    (%rax),%rsi
  2c069c:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(fp)) 
  2c069f:	48 8b 08             	mov    (%rax),%rcx
  2c06a2:	48 85 c9             	test   %rcx,%rcx
  2c06a5:	0f 84 5d ff ff ff    	je     2c0608 <defrag+0x2d>
				PREV_FPTR(NEXT_FPTR(fp)) = PREV_FPTR(fp);
  2c06ab:	48 8b 70 08          	mov    0x8(%rax),%rsi
  2c06af:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  2c06b3:	e9 50 ff ff ff       	jmp    2c0608 <defrag+0x2d>

00000000002c06b8 <heap_info>:

int heap_info(heap_info_struct *info) {
    return 0;
}
  2c06b8:	b8 00 00 00 00       	mov    $0x0,%eax
  2c06bd:	c3                   	ret    

00000000002c06be <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c06be:	55                   	push   %rbp
  2c06bf:	48 89 e5             	mov    %rsp,%rbp
  2c06c2:	48 83 ec 28          	sub    $0x28,%rsp
  2c06c6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c06ca:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c06ce:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c06d2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c06d6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c06da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c06de:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c06e2:	eb 1c                	jmp    2c0700 <memcpy+0x42>
        *d = *s;
  2c06e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c06e8:	0f b6 10             	movzbl (%rax),%edx
  2c06eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c06ef:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c06f1:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c06f6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c06fb:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c0700:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0705:	75 dd                	jne    2c06e4 <memcpy+0x26>
    }
    return dst;
  2c0707:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c070b:	c9                   	leave  
  2c070c:	c3                   	ret    

00000000002c070d <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c070d:	55                   	push   %rbp
  2c070e:	48 89 e5             	mov    %rsp,%rbp
  2c0711:	48 83 ec 28          	sub    $0x28,%rsp
  2c0715:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0719:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c071d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0721:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0725:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c0729:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c072d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c0731:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0735:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c0739:	73 6a                	jae    2c07a5 <memmove+0x98>
  2c073b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c073f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0743:	48 01 d0             	add    %rdx,%rax
  2c0746:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c074a:	73 59                	jae    2c07a5 <memmove+0x98>
        s += n, d += n;
  2c074c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0750:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c0754:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0758:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c075c:	eb 17                	jmp    2c0775 <memmove+0x68>
            *--d = *--s;
  2c075e:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c0763:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c0768:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c076c:	0f b6 10             	movzbl (%rax),%edx
  2c076f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0773:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0775:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0779:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c077d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0781:	48 85 c0             	test   %rax,%rax
  2c0784:	75 d8                	jne    2c075e <memmove+0x51>
    if (s < d && s + n > d) {
  2c0786:	eb 2e                	jmp    2c07b6 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c0788:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c078c:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0790:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0794:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0798:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c079c:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c07a0:	0f b6 12             	movzbl (%rdx),%edx
  2c07a3:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c07a5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c07a9:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c07ad:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c07b1:	48 85 c0             	test   %rax,%rax
  2c07b4:	75 d2                	jne    2c0788 <memmove+0x7b>
        }
    }
    return dst;
  2c07b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c07ba:	c9                   	leave  
  2c07bb:	c3                   	ret    

00000000002c07bc <memset>:

void* memset(void* v, int c, size_t n) {
  2c07bc:	55                   	push   %rbp
  2c07bd:	48 89 e5             	mov    %rsp,%rbp
  2c07c0:	48 83 ec 28          	sub    $0x28,%rsp
  2c07c4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c07c8:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c07cb:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c07cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c07d3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c07d7:	eb 15                	jmp    2c07ee <memset+0x32>
        *p = c;
  2c07d9:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c07dc:	89 c2                	mov    %eax,%edx
  2c07de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c07e2:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c07e4:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c07e9:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c07ee:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c07f3:	75 e4                	jne    2c07d9 <memset+0x1d>
    }
    return v;
  2c07f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c07f9:	c9                   	leave  
  2c07fa:	c3                   	ret    

00000000002c07fb <strlen>:

size_t strlen(const char* s) {
  2c07fb:	55                   	push   %rbp
  2c07fc:	48 89 e5             	mov    %rsp,%rbp
  2c07ff:	48 83 ec 18          	sub    $0x18,%rsp
  2c0803:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c0807:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c080e:	00 
  2c080f:	eb 0a                	jmp    2c081b <strlen+0x20>
        ++n;
  2c0811:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c0816:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c081b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c081f:	0f b6 00             	movzbl (%rax),%eax
  2c0822:	84 c0                	test   %al,%al
  2c0824:	75 eb                	jne    2c0811 <strlen+0x16>
    }
    return n;
  2c0826:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c082a:	c9                   	leave  
  2c082b:	c3                   	ret    

00000000002c082c <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c082c:	55                   	push   %rbp
  2c082d:	48 89 e5             	mov    %rsp,%rbp
  2c0830:	48 83 ec 20          	sub    $0x20,%rsp
  2c0834:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0838:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c083c:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0843:	00 
  2c0844:	eb 0a                	jmp    2c0850 <strnlen+0x24>
        ++n;
  2c0846:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c084b:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0850:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0854:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c0858:	74 0b                	je     2c0865 <strnlen+0x39>
  2c085a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c085e:	0f b6 00             	movzbl (%rax),%eax
  2c0861:	84 c0                	test   %al,%al
  2c0863:	75 e1                	jne    2c0846 <strnlen+0x1a>
    }
    return n;
  2c0865:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0869:	c9                   	leave  
  2c086a:	c3                   	ret    

00000000002c086b <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c086b:	55                   	push   %rbp
  2c086c:	48 89 e5             	mov    %rsp,%rbp
  2c086f:	48 83 ec 20          	sub    $0x20,%rsp
  2c0873:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0877:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c087b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c087f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c0883:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c0887:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c088b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c088f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0893:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0897:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c089b:	0f b6 12             	movzbl (%rdx),%edx
  2c089e:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c08a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c08a4:	48 83 e8 01          	sub    $0x1,%rax
  2c08a8:	0f b6 00             	movzbl (%rax),%eax
  2c08ab:	84 c0                	test   %al,%al
  2c08ad:	75 d4                	jne    2c0883 <strcpy+0x18>
    return dst;
  2c08af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c08b3:	c9                   	leave  
  2c08b4:	c3                   	ret    

00000000002c08b5 <strcmp>:

int strcmp(const char* a, const char* b) {
  2c08b5:	55                   	push   %rbp
  2c08b6:	48 89 e5             	mov    %rsp,%rbp
  2c08b9:	48 83 ec 10          	sub    $0x10,%rsp
  2c08bd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c08c1:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c08c5:	eb 0a                	jmp    2c08d1 <strcmp+0x1c>
        ++a, ++b;
  2c08c7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c08cc:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c08d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c08d5:	0f b6 00             	movzbl (%rax),%eax
  2c08d8:	84 c0                	test   %al,%al
  2c08da:	74 1d                	je     2c08f9 <strcmp+0x44>
  2c08dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c08e0:	0f b6 00             	movzbl (%rax),%eax
  2c08e3:	84 c0                	test   %al,%al
  2c08e5:	74 12                	je     2c08f9 <strcmp+0x44>
  2c08e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c08eb:	0f b6 10             	movzbl (%rax),%edx
  2c08ee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c08f2:	0f b6 00             	movzbl (%rax),%eax
  2c08f5:	38 c2                	cmp    %al,%dl
  2c08f7:	74 ce                	je     2c08c7 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c08f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c08fd:	0f b6 00             	movzbl (%rax),%eax
  2c0900:	89 c2                	mov    %eax,%edx
  2c0902:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0906:	0f b6 00             	movzbl (%rax),%eax
  2c0909:	38 d0                	cmp    %dl,%al
  2c090b:	0f 92 c0             	setb   %al
  2c090e:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c0911:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0915:	0f b6 00             	movzbl (%rax),%eax
  2c0918:	89 c1                	mov    %eax,%ecx
  2c091a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c091e:	0f b6 00             	movzbl (%rax),%eax
  2c0921:	38 c1                	cmp    %al,%cl
  2c0923:	0f 92 c0             	setb   %al
  2c0926:	0f b6 c0             	movzbl %al,%eax
  2c0929:	29 c2                	sub    %eax,%edx
  2c092b:	89 d0                	mov    %edx,%eax
}
  2c092d:	c9                   	leave  
  2c092e:	c3                   	ret    

00000000002c092f <strchr>:

char* strchr(const char* s, int c) {
  2c092f:	55                   	push   %rbp
  2c0930:	48 89 e5             	mov    %rsp,%rbp
  2c0933:	48 83 ec 10          	sub    $0x10,%rsp
  2c0937:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c093b:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c093e:	eb 05                	jmp    2c0945 <strchr+0x16>
        ++s;
  2c0940:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c0945:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0949:	0f b6 00             	movzbl (%rax),%eax
  2c094c:	84 c0                	test   %al,%al
  2c094e:	74 0e                	je     2c095e <strchr+0x2f>
  2c0950:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0954:	0f b6 00             	movzbl (%rax),%eax
  2c0957:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c095a:	38 d0                	cmp    %dl,%al
  2c095c:	75 e2                	jne    2c0940 <strchr+0x11>
    }
    if (*s == (char) c) {
  2c095e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0962:	0f b6 00             	movzbl (%rax),%eax
  2c0965:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0968:	38 d0                	cmp    %dl,%al
  2c096a:	75 06                	jne    2c0972 <strchr+0x43>
        return (char*) s;
  2c096c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0970:	eb 05                	jmp    2c0977 <strchr+0x48>
    } else {
        return NULL;
  2c0972:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c0977:	c9                   	leave  
  2c0978:	c3                   	ret    

00000000002c0979 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c0979:	55                   	push   %rbp
  2c097a:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c097d:	8b 05 95 16 00 00    	mov    0x1695(%rip),%eax        # 2c2018 <rand_seed_set>
  2c0983:	85 c0                	test   %eax,%eax
  2c0985:	75 0a                	jne    2c0991 <rand+0x18>
        srand(819234718U);
  2c0987:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c098c:	e8 24 00 00 00       	call   2c09b5 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c0991:	8b 05 85 16 00 00    	mov    0x1685(%rip),%eax        # 2c201c <rand_seed>
  2c0997:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c099d:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c09a2:	89 05 74 16 00 00    	mov    %eax,0x1674(%rip)        # 2c201c <rand_seed>
    return rand_seed & RAND_MAX;
  2c09a8:	8b 05 6e 16 00 00    	mov    0x166e(%rip),%eax        # 2c201c <rand_seed>
  2c09ae:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c09b3:	5d                   	pop    %rbp
  2c09b4:	c3                   	ret    

00000000002c09b5 <srand>:

void srand(unsigned seed) {
  2c09b5:	55                   	push   %rbp
  2c09b6:	48 89 e5             	mov    %rsp,%rbp
  2c09b9:	48 83 ec 08          	sub    $0x8,%rsp
  2c09bd:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c09c0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c09c3:	89 05 53 16 00 00    	mov    %eax,0x1653(%rip)        # 2c201c <rand_seed>
    rand_seed_set = 1;
  2c09c9:	c7 05 45 16 00 00 01 	movl   $0x1,0x1645(%rip)        # 2c2018 <rand_seed_set>
  2c09d0:	00 00 00 
}
  2c09d3:	90                   	nop
  2c09d4:	c9                   	leave  
  2c09d5:	c3                   	ret    

00000000002c09d6 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c09d6:	55                   	push   %rbp
  2c09d7:	48 89 e5             	mov    %rsp,%rbp
  2c09da:	48 83 ec 28          	sub    $0x28,%rsp
  2c09de:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c09e2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c09e6:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c09e9:	48 c7 45 f8 e0 19 2c 	movq   $0x2c19e0,-0x8(%rbp)
  2c09f0:	00 
    if (base < 0) {
  2c09f1:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c09f5:	79 0b                	jns    2c0a02 <fill_numbuf+0x2c>
        digits = lower_digits;
  2c09f7:	48 c7 45 f8 00 1a 2c 	movq   $0x2c1a00,-0x8(%rbp)
  2c09fe:	00 
        base = -base;
  2c09ff:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c0a02:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0a07:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0a0b:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c0a0e:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0a11:	48 63 c8             	movslq %eax,%rcx
  2c0a14:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0a18:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0a1d:	48 f7 f1             	div    %rcx
  2c0a20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a24:	48 01 d0             	add    %rdx,%rax
  2c0a27:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0a2c:	0f b6 10             	movzbl (%rax),%edx
  2c0a2f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0a33:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c0a35:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0a38:	48 63 f0             	movslq %eax,%rsi
  2c0a3b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0a3f:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0a44:	48 f7 f6             	div    %rsi
  2c0a47:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c0a4b:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c0a50:	75 bc                	jne    2c0a0e <fill_numbuf+0x38>
    return numbuf_end;
  2c0a52:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0a56:	c9                   	leave  
  2c0a57:	c3                   	ret    

00000000002c0a58 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c0a58:	55                   	push   %rbp
  2c0a59:	48 89 e5             	mov    %rsp,%rbp
  2c0a5c:	53                   	push   %rbx
  2c0a5d:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c0a64:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c0a6b:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c0a71:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0a78:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c0a7f:	e9 8a 09 00 00       	jmp    2c140e <printer_vprintf+0x9b6>
        if (*format != '%') {
  2c0a84:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a8b:	0f b6 00             	movzbl (%rax),%eax
  2c0a8e:	3c 25                	cmp    $0x25,%al
  2c0a90:	74 31                	je     2c0ac3 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  2c0a92:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0a99:	4c 8b 00             	mov    (%rax),%r8
  2c0a9c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0aa3:	0f b6 00             	movzbl (%rax),%eax
  2c0aa6:	0f b6 c8             	movzbl %al,%ecx
  2c0aa9:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c0aaf:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0ab6:	89 ce                	mov    %ecx,%esi
  2c0ab8:	48 89 c7             	mov    %rax,%rdi
  2c0abb:	41 ff d0             	call   *%r8
            continue;
  2c0abe:	e9 43 09 00 00       	jmp    2c1406 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  2c0ac3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0aca:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0ad1:	01 
  2c0ad2:	eb 44                	jmp    2c0b18 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  2c0ad4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0adb:	0f b6 00             	movzbl (%rax),%eax
  2c0ade:	0f be c0             	movsbl %al,%eax
  2c0ae1:	89 c6                	mov    %eax,%esi
  2c0ae3:	bf 00 18 2c 00       	mov    $0x2c1800,%edi
  2c0ae8:	e8 42 fe ff ff       	call   2c092f <strchr>
  2c0aed:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c0af1:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c0af6:	74 30                	je     2c0b28 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  2c0af8:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c0afc:	48 2d 00 18 2c 00    	sub    $0x2c1800,%rax
  2c0b02:	ba 01 00 00 00       	mov    $0x1,%edx
  2c0b07:	89 c1                	mov    %eax,%ecx
  2c0b09:	d3 e2                	shl    %cl,%edx
  2c0b0b:	89 d0                	mov    %edx,%eax
  2c0b0d:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0b10:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0b17:	01 
  2c0b18:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b1f:	0f b6 00             	movzbl (%rax),%eax
  2c0b22:	84 c0                	test   %al,%al
  2c0b24:	75 ae                	jne    2c0ad4 <printer_vprintf+0x7c>
  2c0b26:	eb 01                	jmp    2c0b29 <printer_vprintf+0xd1>
            } else {
                break;
  2c0b28:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c0b29:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c0b30:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b37:	0f b6 00             	movzbl (%rax),%eax
  2c0b3a:	3c 30                	cmp    $0x30,%al
  2c0b3c:	7e 67                	jle    2c0ba5 <printer_vprintf+0x14d>
  2c0b3e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b45:	0f b6 00             	movzbl (%rax),%eax
  2c0b48:	3c 39                	cmp    $0x39,%al
  2c0b4a:	7f 59                	jg     2c0ba5 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0b4c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c0b53:	eb 2e                	jmp    2c0b83 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  2c0b55:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c0b58:	89 d0                	mov    %edx,%eax
  2c0b5a:	c1 e0 02             	shl    $0x2,%eax
  2c0b5d:	01 d0                	add    %edx,%eax
  2c0b5f:	01 c0                	add    %eax,%eax
  2c0b61:	89 c1                	mov    %eax,%ecx
  2c0b63:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b6a:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0b6e:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0b75:	0f b6 00             	movzbl (%rax),%eax
  2c0b78:	0f be c0             	movsbl %al,%eax
  2c0b7b:	01 c8                	add    %ecx,%eax
  2c0b7d:	83 e8 30             	sub    $0x30,%eax
  2c0b80:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0b83:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b8a:	0f b6 00             	movzbl (%rax),%eax
  2c0b8d:	3c 2f                	cmp    $0x2f,%al
  2c0b8f:	0f 8e 85 00 00 00    	jle    2c0c1a <printer_vprintf+0x1c2>
  2c0b95:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b9c:	0f b6 00             	movzbl (%rax),%eax
  2c0b9f:	3c 39                	cmp    $0x39,%al
  2c0ba1:	7e b2                	jle    2c0b55 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  2c0ba3:	eb 75                	jmp    2c0c1a <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  2c0ba5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0bac:	0f b6 00             	movzbl (%rax),%eax
  2c0baf:	3c 2a                	cmp    $0x2a,%al
  2c0bb1:	75 68                	jne    2c0c1b <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  2c0bb3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bba:	8b 00                	mov    (%rax),%eax
  2c0bbc:	83 f8 2f             	cmp    $0x2f,%eax
  2c0bbf:	77 30                	ja     2c0bf1 <printer_vprintf+0x199>
  2c0bc1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bc8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0bcc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bd3:	8b 00                	mov    (%rax),%eax
  2c0bd5:	89 c0                	mov    %eax,%eax
  2c0bd7:	48 01 d0             	add    %rdx,%rax
  2c0bda:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0be1:	8b 12                	mov    (%rdx),%edx
  2c0be3:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0be6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0bed:	89 0a                	mov    %ecx,(%rdx)
  2c0bef:	eb 1a                	jmp    2c0c0b <printer_vprintf+0x1b3>
  2c0bf1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bf8:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0bfc:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0c00:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c07:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0c0b:	8b 00                	mov    (%rax),%eax
  2c0c0d:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c0c10:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0c17:	01 
  2c0c18:	eb 01                	jmp    2c0c1b <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  2c0c1a:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c0c1b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c0c22:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c29:	0f b6 00             	movzbl (%rax),%eax
  2c0c2c:	3c 2e                	cmp    $0x2e,%al
  2c0c2e:	0f 85 00 01 00 00    	jne    2c0d34 <printer_vprintf+0x2dc>
            ++format;
  2c0c34:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0c3b:	01 
            if (*format >= '0' && *format <= '9') {
  2c0c3c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c43:	0f b6 00             	movzbl (%rax),%eax
  2c0c46:	3c 2f                	cmp    $0x2f,%al
  2c0c48:	7e 67                	jle    2c0cb1 <printer_vprintf+0x259>
  2c0c4a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c51:	0f b6 00             	movzbl (%rax),%eax
  2c0c54:	3c 39                	cmp    $0x39,%al
  2c0c56:	7f 59                	jg     2c0cb1 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0c58:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c0c5f:	eb 2e                	jmp    2c0c8f <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  2c0c61:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c0c64:	89 d0                	mov    %edx,%eax
  2c0c66:	c1 e0 02             	shl    $0x2,%eax
  2c0c69:	01 d0                	add    %edx,%eax
  2c0c6b:	01 c0                	add    %eax,%eax
  2c0c6d:	89 c1                	mov    %eax,%ecx
  2c0c6f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c76:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0c7a:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0c81:	0f b6 00             	movzbl (%rax),%eax
  2c0c84:	0f be c0             	movsbl %al,%eax
  2c0c87:	01 c8                	add    %ecx,%eax
  2c0c89:	83 e8 30             	sub    $0x30,%eax
  2c0c8c:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0c8f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c96:	0f b6 00             	movzbl (%rax),%eax
  2c0c99:	3c 2f                	cmp    $0x2f,%al
  2c0c9b:	0f 8e 85 00 00 00    	jle    2c0d26 <printer_vprintf+0x2ce>
  2c0ca1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ca8:	0f b6 00             	movzbl (%rax),%eax
  2c0cab:	3c 39                	cmp    $0x39,%al
  2c0cad:	7e b2                	jle    2c0c61 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  2c0caf:	eb 75                	jmp    2c0d26 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  2c0cb1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0cb8:	0f b6 00             	movzbl (%rax),%eax
  2c0cbb:	3c 2a                	cmp    $0x2a,%al
  2c0cbd:	75 68                	jne    2c0d27 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  2c0cbf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cc6:	8b 00                	mov    (%rax),%eax
  2c0cc8:	83 f8 2f             	cmp    $0x2f,%eax
  2c0ccb:	77 30                	ja     2c0cfd <printer_vprintf+0x2a5>
  2c0ccd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cd4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0cd8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cdf:	8b 00                	mov    (%rax),%eax
  2c0ce1:	89 c0                	mov    %eax,%eax
  2c0ce3:	48 01 d0             	add    %rdx,%rax
  2c0ce6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ced:	8b 12                	mov    (%rdx),%edx
  2c0cef:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0cf2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0cf9:	89 0a                	mov    %ecx,(%rdx)
  2c0cfb:	eb 1a                	jmp    2c0d17 <printer_vprintf+0x2bf>
  2c0cfd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d04:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0d08:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0d0c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d13:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0d17:	8b 00                	mov    (%rax),%eax
  2c0d19:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c0d1c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0d23:	01 
  2c0d24:	eb 01                	jmp    2c0d27 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  2c0d26:	90                   	nop
            }
            if (precision < 0) {
  2c0d27:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c0d2b:	79 07                	jns    2c0d34 <printer_vprintf+0x2dc>
                precision = 0;
  2c0d2d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c0d34:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c0d3b:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c0d42:	00 
        int length = 0;
  2c0d43:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c0d4a:	48 c7 45 c8 06 18 2c 	movq   $0x2c1806,-0x38(%rbp)
  2c0d51:	00 
    again:
        switch (*format) {
  2c0d52:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d59:	0f b6 00             	movzbl (%rax),%eax
  2c0d5c:	0f be c0             	movsbl %al,%eax
  2c0d5f:	83 e8 43             	sub    $0x43,%eax
  2c0d62:	83 f8 37             	cmp    $0x37,%eax
  2c0d65:	0f 87 9f 03 00 00    	ja     2c110a <printer_vprintf+0x6b2>
  2c0d6b:	89 c0                	mov    %eax,%eax
  2c0d6d:	48 8b 04 c5 18 18 2c 	mov    0x2c1818(,%rax,8),%rax
  2c0d74:	00 
  2c0d75:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  2c0d77:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c0d7e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0d85:	01 
            goto again;
  2c0d86:	eb ca                	jmp    2c0d52 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c0d88:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0d8c:	74 5d                	je     2c0deb <printer_vprintf+0x393>
  2c0d8e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d95:	8b 00                	mov    (%rax),%eax
  2c0d97:	83 f8 2f             	cmp    $0x2f,%eax
  2c0d9a:	77 30                	ja     2c0dcc <printer_vprintf+0x374>
  2c0d9c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0da3:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0da7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dae:	8b 00                	mov    (%rax),%eax
  2c0db0:	89 c0                	mov    %eax,%eax
  2c0db2:	48 01 d0             	add    %rdx,%rax
  2c0db5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0dbc:	8b 12                	mov    (%rdx),%edx
  2c0dbe:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0dc1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0dc8:	89 0a                	mov    %ecx,(%rdx)
  2c0dca:	eb 1a                	jmp    2c0de6 <printer_vprintf+0x38e>
  2c0dcc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dd3:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0dd7:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0ddb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0de2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0de6:	48 8b 00             	mov    (%rax),%rax
  2c0de9:	eb 5c                	jmp    2c0e47 <printer_vprintf+0x3ef>
  2c0deb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0df2:	8b 00                	mov    (%rax),%eax
  2c0df4:	83 f8 2f             	cmp    $0x2f,%eax
  2c0df7:	77 30                	ja     2c0e29 <printer_vprintf+0x3d1>
  2c0df9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e00:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0e04:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e0b:	8b 00                	mov    (%rax),%eax
  2c0e0d:	89 c0                	mov    %eax,%eax
  2c0e0f:	48 01 d0             	add    %rdx,%rax
  2c0e12:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e19:	8b 12                	mov    (%rdx),%edx
  2c0e1b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0e1e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e25:	89 0a                	mov    %ecx,(%rdx)
  2c0e27:	eb 1a                	jmp    2c0e43 <printer_vprintf+0x3eb>
  2c0e29:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e30:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0e34:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0e38:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e3f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0e43:	8b 00                	mov    (%rax),%eax
  2c0e45:	48 98                	cltq   
  2c0e47:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c0e4b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0e4f:	48 c1 f8 38          	sar    $0x38,%rax
  2c0e53:	25 80 00 00 00       	and    $0x80,%eax
  2c0e58:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c0e5b:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c0e5f:	74 09                	je     2c0e6a <printer_vprintf+0x412>
  2c0e61:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0e65:	48 f7 d8             	neg    %rax
  2c0e68:	eb 04                	jmp    2c0e6e <printer_vprintf+0x416>
  2c0e6a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0e6e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c0e72:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c0e75:	83 c8 60             	or     $0x60,%eax
  2c0e78:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c0e7b:	e9 cf 02 00 00       	jmp    2c114f <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c0e80:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0e84:	74 5d                	je     2c0ee3 <printer_vprintf+0x48b>
  2c0e86:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e8d:	8b 00                	mov    (%rax),%eax
  2c0e8f:	83 f8 2f             	cmp    $0x2f,%eax
  2c0e92:	77 30                	ja     2c0ec4 <printer_vprintf+0x46c>
  2c0e94:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e9b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0e9f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ea6:	8b 00                	mov    (%rax),%eax
  2c0ea8:	89 c0                	mov    %eax,%eax
  2c0eaa:	48 01 d0             	add    %rdx,%rax
  2c0ead:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0eb4:	8b 12                	mov    (%rdx),%edx
  2c0eb6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0eb9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ec0:	89 0a                	mov    %ecx,(%rdx)
  2c0ec2:	eb 1a                	jmp    2c0ede <printer_vprintf+0x486>
  2c0ec4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ecb:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0ecf:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0ed3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0eda:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0ede:	48 8b 00             	mov    (%rax),%rax
  2c0ee1:	eb 5c                	jmp    2c0f3f <printer_vprintf+0x4e7>
  2c0ee3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0eea:	8b 00                	mov    (%rax),%eax
  2c0eec:	83 f8 2f             	cmp    $0x2f,%eax
  2c0eef:	77 30                	ja     2c0f21 <printer_vprintf+0x4c9>
  2c0ef1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ef8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0efc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f03:	8b 00                	mov    (%rax),%eax
  2c0f05:	89 c0                	mov    %eax,%eax
  2c0f07:	48 01 d0             	add    %rdx,%rax
  2c0f0a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f11:	8b 12                	mov    (%rdx),%edx
  2c0f13:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0f16:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f1d:	89 0a                	mov    %ecx,(%rdx)
  2c0f1f:	eb 1a                	jmp    2c0f3b <printer_vprintf+0x4e3>
  2c0f21:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f28:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0f2c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0f30:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f37:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0f3b:	8b 00                	mov    (%rax),%eax
  2c0f3d:	89 c0                	mov    %eax,%eax
  2c0f3f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c0f43:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c0f47:	e9 03 02 00 00       	jmp    2c114f <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  2c0f4c:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c0f53:	e9 28 ff ff ff       	jmp    2c0e80 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  2c0f58:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c0f5f:	e9 1c ff ff ff       	jmp    2c0e80 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c0f64:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f6b:	8b 00                	mov    (%rax),%eax
  2c0f6d:	83 f8 2f             	cmp    $0x2f,%eax
  2c0f70:	77 30                	ja     2c0fa2 <printer_vprintf+0x54a>
  2c0f72:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f79:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0f7d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f84:	8b 00                	mov    (%rax),%eax
  2c0f86:	89 c0                	mov    %eax,%eax
  2c0f88:	48 01 d0             	add    %rdx,%rax
  2c0f8b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f92:	8b 12                	mov    (%rdx),%edx
  2c0f94:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0f97:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f9e:	89 0a                	mov    %ecx,(%rdx)
  2c0fa0:	eb 1a                	jmp    2c0fbc <printer_vprintf+0x564>
  2c0fa2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fa9:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0fad:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0fb1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0fb8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0fbc:	48 8b 00             	mov    (%rax),%rax
  2c0fbf:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c0fc3:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c0fca:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c0fd1:	e9 79 01 00 00       	jmp    2c114f <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  2c0fd6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fdd:	8b 00                	mov    (%rax),%eax
  2c0fdf:	83 f8 2f             	cmp    $0x2f,%eax
  2c0fe2:	77 30                	ja     2c1014 <printer_vprintf+0x5bc>
  2c0fe4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0feb:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0fef:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ff6:	8b 00                	mov    (%rax),%eax
  2c0ff8:	89 c0                	mov    %eax,%eax
  2c0ffa:	48 01 d0             	add    %rdx,%rax
  2c0ffd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1004:	8b 12                	mov    (%rdx),%edx
  2c1006:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1009:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1010:	89 0a                	mov    %ecx,(%rdx)
  2c1012:	eb 1a                	jmp    2c102e <printer_vprintf+0x5d6>
  2c1014:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c101b:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c101f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1023:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c102a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c102e:	48 8b 00             	mov    (%rax),%rax
  2c1031:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c1035:	e9 15 01 00 00       	jmp    2c114f <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  2c103a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1041:	8b 00                	mov    (%rax),%eax
  2c1043:	83 f8 2f             	cmp    $0x2f,%eax
  2c1046:	77 30                	ja     2c1078 <printer_vprintf+0x620>
  2c1048:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c104f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1053:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c105a:	8b 00                	mov    (%rax),%eax
  2c105c:	89 c0                	mov    %eax,%eax
  2c105e:	48 01 d0             	add    %rdx,%rax
  2c1061:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1068:	8b 12                	mov    (%rdx),%edx
  2c106a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c106d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1074:	89 0a                	mov    %ecx,(%rdx)
  2c1076:	eb 1a                	jmp    2c1092 <printer_vprintf+0x63a>
  2c1078:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c107f:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1083:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1087:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c108e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1092:	8b 00                	mov    (%rax),%eax
  2c1094:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c109a:	e9 67 03 00 00       	jmp    2c1406 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  2c109f:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c10a3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c10a7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10ae:	8b 00                	mov    (%rax),%eax
  2c10b0:	83 f8 2f             	cmp    $0x2f,%eax
  2c10b3:	77 30                	ja     2c10e5 <printer_vprintf+0x68d>
  2c10b5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10bc:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c10c0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10c7:	8b 00                	mov    (%rax),%eax
  2c10c9:	89 c0                	mov    %eax,%eax
  2c10cb:	48 01 d0             	add    %rdx,%rax
  2c10ce:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10d5:	8b 12                	mov    (%rdx),%edx
  2c10d7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c10da:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10e1:	89 0a                	mov    %ecx,(%rdx)
  2c10e3:	eb 1a                	jmp    2c10ff <printer_vprintf+0x6a7>
  2c10e5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10ec:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c10f0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c10f4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10fb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c10ff:	8b 00                	mov    (%rax),%eax
  2c1101:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c1104:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c1108:	eb 45                	jmp    2c114f <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  2c110a:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c110e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c1112:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1119:	0f b6 00             	movzbl (%rax),%eax
  2c111c:	84 c0                	test   %al,%al
  2c111e:	74 0c                	je     2c112c <printer_vprintf+0x6d4>
  2c1120:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1127:	0f b6 00             	movzbl (%rax),%eax
  2c112a:	eb 05                	jmp    2c1131 <printer_vprintf+0x6d9>
  2c112c:	b8 25 00 00 00       	mov    $0x25,%eax
  2c1131:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c1134:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c1138:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c113f:	0f b6 00             	movzbl (%rax),%eax
  2c1142:	84 c0                	test   %al,%al
  2c1144:	75 08                	jne    2c114e <printer_vprintf+0x6f6>
                format--;
  2c1146:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c114d:	01 
            }
            break;
  2c114e:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c114f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1152:	83 e0 20             	and    $0x20,%eax
  2c1155:	85 c0                	test   %eax,%eax
  2c1157:	74 1e                	je     2c1177 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c1159:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c115d:	48 83 c0 18          	add    $0x18,%rax
  2c1161:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c1164:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c1168:	48 89 ce             	mov    %rcx,%rsi
  2c116b:	48 89 c7             	mov    %rax,%rdi
  2c116e:	e8 63 f8 ff ff       	call   2c09d6 <fill_numbuf>
  2c1173:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c1177:	48 c7 45 c0 06 18 2c 	movq   $0x2c1806,-0x40(%rbp)
  2c117e:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c117f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1182:	83 e0 20             	and    $0x20,%eax
  2c1185:	85 c0                	test   %eax,%eax
  2c1187:	74 48                	je     2c11d1 <printer_vprintf+0x779>
  2c1189:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c118c:	83 e0 40             	and    $0x40,%eax
  2c118f:	85 c0                	test   %eax,%eax
  2c1191:	74 3e                	je     2c11d1 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  2c1193:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1196:	25 80 00 00 00       	and    $0x80,%eax
  2c119b:	85 c0                	test   %eax,%eax
  2c119d:	74 0a                	je     2c11a9 <printer_vprintf+0x751>
                prefix = "-";
  2c119f:	48 c7 45 c0 07 18 2c 	movq   $0x2c1807,-0x40(%rbp)
  2c11a6:	00 
            if (flags & FLAG_NEGATIVE) {
  2c11a7:	eb 73                	jmp    2c121c <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c11a9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11ac:	83 e0 10             	and    $0x10,%eax
  2c11af:	85 c0                	test   %eax,%eax
  2c11b1:	74 0a                	je     2c11bd <printer_vprintf+0x765>
                prefix = "+";
  2c11b3:	48 c7 45 c0 09 18 2c 	movq   $0x2c1809,-0x40(%rbp)
  2c11ba:	00 
            if (flags & FLAG_NEGATIVE) {
  2c11bb:	eb 5f                	jmp    2c121c <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c11bd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11c0:	83 e0 08             	and    $0x8,%eax
  2c11c3:	85 c0                	test   %eax,%eax
  2c11c5:	74 55                	je     2c121c <printer_vprintf+0x7c4>
                prefix = " ";
  2c11c7:	48 c7 45 c0 0b 18 2c 	movq   $0x2c180b,-0x40(%rbp)
  2c11ce:	00 
            if (flags & FLAG_NEGATIVE) {
  2c11cf:	eb 4b                	jmp    2c121c <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c11d1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11d4:	83 e0 20             	and    $0x20,%eax
  2c11d7:	85 c0                	test   %eax,%eax
  2c11d9:	74 42                	je     2c121d <printer_vprintf+0x7c5>
  2c11db:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11de:	83 e0 01             	and    $0x1,%eax
  2c11e1:	85 c0                	test   %eax,%eax
  2c11e3:	74 38                	je     2c121d <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  2c11e5:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c11e9:	74 06                	je     2c11f1 <printer_vprintf+0x799>
  2c11eb:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c11ef:	75 2c                	jne    2c121d <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  2c11f1:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c11f6:	75 0c                	jne    2c1204 <printer_vprintf+0x7ac>
  2c11f8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11fb:	25 00 01 00 00       	and    $0x100,%eax
  2c1200:	85 c0                	test   %eax,%eax
  2c1202:	74 19                	je     2c121d <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  2c1204:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c1208:	75 07                	jne    2c1211 <printer_vprintf+0x7b9>
  2c120a:	b8 0d 18 2c 00       	mov    $0x2c180d,%eax
  2c120f:	eb 05                	jmp    2c1216 <printer_vprintf+0x7be>
  2c1211:	b8 10 18 2c 00       	mov    $0x2c1810,%eax
  2c1216:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c121a:	eb 01                	jmp    2c121d <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  2c121c:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c121d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c1221:	78 24                	js     2c1247 <printer_vprintf+0x7ef>
  2c1223:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1226:	83 e0 20             	and    $0x20,%eax
  2c1229:	85 c0                	test   %eax,%eax
  2c122b:	75 1a                	jne    2c1247 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  2c122d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1230:	48 63 d0             	movslq %eax,%rdx
  2c1233:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1237:	48 89 d6             	mov    %rdx,%rsi
  2c123a:	48 89 c7             	mov    %rax,%rdi
  2c123d:	e8 ea f5 ff ff       	call   2c082c <strnlen>
  2c1242:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c1245:	eb 0f                	jmp    2c1256 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  2c1247:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c124b:	48 89 c7             	mov    %rax,%rdi
  2c124e:	e8 a8 f5 ff ff       	call   2c07fb <strlen>
  2c1253:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c1256:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1259:	83 e0 20             	and    $0x20,%eax
  2c125c:	85 c0                	test   %eax,%eax
  2c125e:	74 20                	je     2c1280 <printer_vprintf+0x828>
  2c1260:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c1264:	78 1a                	js     2c1280 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  2c1266:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1269:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c126c:	7e 08                	jle    2c1276 <printer_vprintf+0x81e>
  2c126e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1271:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c1274:	eb 05                	jmp    2c127b <printer_vprintf+0x823>
  2c1276:	b8 00 00 00 00       	mov    $0x0,%eax
  2c127b:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c127e:	eb 5c                	jmp    2c12dc <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c1280:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1283:	83 e0 20             	and    $0x20,%eax
  2c1286:	85 c0                	test   %eax,%eax
  2c1288:	74 4b                	je     2c12d5 <printer_vprintf+0x87d>
  2c128a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c128d:	83 e0 02             	and    $0x2,%eax
  2c1290:	85 c0                	test   %eax,%eax
  2c1292:	74 41                	je     2c12d5 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c1294:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1297:	83 e0 04             	and    $0x4,%eax
  2c129a:	85 c0                	test   %eax,%eax
  2c129c:	75 37                	jne    2c12d5 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  2c129e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c12a2:	48 89 c7             	mov    %rax,%rdi
  2c12a5:	e8 51 f5 ff ff       	call   2c07fb <strlen>
  2c12aa:	89 c2                	mov    %eax,%edx
  2c12ac:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c12af:	01 d0                	add    %edx,%eax
  2c12b1:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c12b4:	7e 1f                	jle    2c12d5 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  2c12b6:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c12b9:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c12bc:	89 c3                	mov    %eax,%ebx
  2c12be:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c12c2:	48 89 c7             	mov    %rax,%rdi
  2c12c5:	e8 31 f5 ff ff       	call   2c07fb <strlen>
  2c12ca:	89 c2                	mov    %eax,%edx
  2c12cc:	89 d8                	mov    %ebx,%eax
  2c12ce:	29 d0                	sub    %edx,%eax
  2c12d0:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c12d3:	eb 07                	jmp    2c12dc <printer_vprintf+0x884>
        } else {
            zeros = 0;
  2c12d5:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c12dc:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c12df:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c12e2:	01 d0                	add    %edx,%eax
  2c12e4:	48 63 d8             	movslq %eax,%rbx
  2c12e7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c12eb:	48 89 c7             	mov    %rax,%rdi
  2c12ee:	e8 08 f5 ff ff       	call   2c07fb <strlen>
  2c12f3:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c12f7:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c12fa:	29 d0                	sub    %edx,%eax
  2c12fc:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c12ff:	eb 25                	jmp    2c1326 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  2c1301:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1308:	48 8b 08             	mov    (%rax),%rcx
  2c130b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1311:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1318:	be 20 00 00 00       	mov    $0x20,%esi
  2c131d:	48 89 c7             	mov    %rax,%rdi
  2c1320:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c1322:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c1326:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1329:	83 e0 04             	and    $0x4,%eax
  2c132c:	85 c0                	test   %eax,%eax
  2c132e:	75 36                	jne    2c1366 <printer_vprintf+0x90e>
  2c1330:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1334:	7f cb                	jg     2c1301 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  2c1336:	eb 2e                	jmp    2c1366 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  2c1338:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c133f:	4c 8b 00             	mov    (%rax),%r8
  2c1342:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1346:	0f b6 00             	movzbl (%rax),%eax
  2c1349:	0f b6 c8             	movzbl %al,%ecx
  2c134c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1352:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1359:	89 ce                	mov    %ecx,%esi
  2c135b:	48 89 c7             	mov    %rax,%rdi
  2c135e:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c1361:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c1366:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c136a:	0f b6 00             	movzbl (%rax),%eax
  2c136d:	84 c0                	test   %al,%al
  2c136f:	75 c7                	jne    2c1338 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  2c1371:	eb 25                	jmp    2c1398 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  2c1373:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c137a:	48 8b 08             	mov    (%rax),%rcx
  2c137d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1383:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c138a:	be 30 00 00 00       	mov    $0x30,%esi
  2c138f:	48 89 c7             	mov    %rax,%rdi
  2c1392:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c1394:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c1398:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c139c:	7f d5                	jg     2c1373 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  2c139e:	eb 32                	jmp    2c13d2 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  2c13a0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c13a7:	4c 8b 00             	mov    (%rax),%r8
  2c13aa:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c13ae:	0f b6 00             	movzbl (%rax),%eax
  2c13b1:	0f b6 c8             	movzbl %al,%ecx
  2c13b4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c13ba:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c13c1:	89 ce                	mov    %ecx,%esi
  2c13c3:	48 89 c7             	mov    %rax,%rdi
  2c13c6:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c13c9:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c13ce:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c13d2:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c13d6:	7f c8                	jg     2c13a0 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  2c13d8:	eb 25                	jmp    2c13ff <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  2c13da:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c13e1:	48 8b 08             	mov    (%rax),%rcx
  2c13e4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c13ea:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c13f1:	be 20 00 00 00       	mov    $0x20,%esi
  2c13f6:	48 89 c7             	mov    %rax,%rdi
  2c13f9:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c13fb:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c13ff:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1403:	7f d5                	jg     2c13da <printer_vprintf+0x982>
        }
    done: ;
  2c1405:	90                   	nop
    for (; *format; ++format) {
  2c1406:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c140d:	01 
  2c140e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1415:	0f b6 00             	movzbl (%rax),%eax
  2c1418:	84 c0                	test   %al,%al
  2c141a:	0f 85 64 f6 ff ff    	jne    2c0a84 <printer_vprintf+0x2c>
    }
}
  2c1420:	90                   	nop
  2c1421:	90                   	nop
  2c1422:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c1426:	c9                   	leave  
  2c1427:	c3                   	ret    

00000000002c1428 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c1428:	55                   	push   %rbp
  2c1429:	48 89 e5             	mov    %rsp,%rbp
  2c142c:	48 83 ec 20          	sub    $0x20,%rsp
  2c1430:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c1434:	89 f0                	mov    %esi,%eax
  2c1436:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1439:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c143c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1440:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1444:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1448:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c144c:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  2c1451:	48 39 d0             	cmp    %rdx,%rax
  2c1454:	72 0c                	jb     2c1462 <console_putc+0x3a>
        cp->cursor = console;
  2c1456:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c145a:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  2c1461:	00 
    }
    if (c == '\n') {
  2c1462:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c1466:	75 78                	jne    2c14e0 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  2c1468:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c146c:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1470:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c1476:	48 d1 f8             	sar    %rax
  2c1479:	48 89 c1             	mov    %rax,%rcx
  2c147c:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c1483:	66 66 66 
  2c1486:	48 89 c8             	mov    %rcx,%rax
  2c1489:	48 f7 ea             	imul   %rdx
  2c148c:	48 c1 fa 05          	sar    $0x5,%rdx
  2c1490:	48 89 c8             	mov    %rcx,%rax
  2c1493:	48 c1 f8 3f          	sar    $0x3f,%rax
  2c1497:	48 29 c2             	sub    %rax,%rdx
  2c149a:	48 89 d0             	mov    %rdx,%rax
  2c149d:	48 c1 e0 02          	shl    $0x2,%rax
  2c14a1:	48 01 d0             	add    %rdx,%rax
  2c14a4:	48 c1 e0 04          	shl    $0x4,%rax
  2c14a8:	48 29 c1             	sub    %rax,%rcx
  2c14ab:	48 89 ca             	mov    %rcx,%rdx
  2c14ae:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c14b1:	eb 25                	jmp    2c14d8 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  2c14b3:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c14b6:	83 c8 20             	or     $0x20,%eax
  2c14b9:	89 c6                	mov    %eax,%esi
  2c14bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c14bf:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c14c3:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c14c7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c14cb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c14cf:	89 f2                	mov    %esi,%edx
  2c14d1:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c14d4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c14d8:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c14dc:	75 d5                	jne    2c14b3 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c14de:	eb 24                	jmp    2c1504 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  2c14e0:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  2c14e4:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c14e7:	09 d0                	or     %edx,%eax
  2c14e9:	89 c6                	mov    %eax,%esi
  2c14eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c14ef:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c14f3:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c14f7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c14fb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c14ff:	89 f2                	mov    %esi,%edx
  2c1501:	66 89 10             	mov    %dx,(%rax)
}
  2c1504:	90                   	nop
  2c1505:	c9                   	leave  
  2c1506:	c3                   	ret    

00000000002c1507 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c1507:	55                   	push   %rbp
  2c1508:	48 89 e5             	mov    %rsp,%rbp
  2c150b:	48 83 ec 30          	sub    $0x30,%rsp
  2c150f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c1512:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c1515:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c1519:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c151d:	48 c7 45 f0 28 14 2c 	movq   $0x2c1428,-0x10(%rbp)
  2c1524:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1525:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c1529:	78 09                	js     2c1534 <console_vprintf+0x2d>
  2c152b:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c1532:	7e 07                	jle    2c153b <console_vprintf+0x34>
        cpos = 0;
  2c1534:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c153b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c153e:	48 98                	cltq   
  2c1540:	48 01 c0             	add    %rax,%rax
  2c1543:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  2c1549:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c154d:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c1551:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c1555:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c1558:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c155c:	48 89 c7             	mov    %rax,%rdi
  2c155f:	e8 f4 f4 ff ff       	call   2c0a58 <printer_vprintf>
    return cp.cursor - console;
  2c1564:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1568:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c156e:	48 d1 f8             	sar    %rax
}
  2c1571:	c9                   	leave  
  2c1572:	c3                   	ret    

00000000002c1573 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c1573:	55                   	push   %rbp
  2c1574:	48 89 e5             	mov    %rsp,%rbp
  2c1577:	48 83 ec 60          	sub    $0x60,%rsp
  2c157b:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c157e:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c1581:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c1585:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1589:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c158d:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c1591:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c1598:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c159c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c15a0:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c15a4:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c15a8:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c15ac:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c15b0:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c15b3:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c15b6:	89 c7                	mov    %eax,%edi
  2c15b8:	e8 4a ff ff ff       	call   2c1507 <console_vprintf>
  2c15bd:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c15c0:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c15c3:	c9                   	leave  
  2c15c4:	c3                   	ret    

00000000002c15c5 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c15c5:	55                   	push   %rbp
  2c15c6:	48 89 e5             	mov    %rsp,%rbp
  2c15c9:	48 83 ec 20          	sub    $0x20,%rsp
  2c15cd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c15d1:	89 f0                	mov    %esi,%eax
  2c15d3:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c15d6:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c15d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c15dd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c15e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c15e5:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c15e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c15ed:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c15f1:	48 39 c2             	cmp    %rax,%rdx
  2c15f4:	73 1a                	jae    2c1610 <string_putc+0x4b>
        *sp->s++ = c;
  2c15f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c15fa:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c15fe:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c1602:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c1606:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c160a:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c160e:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c1610:	90                   	nop
  2c1611:	c9                   	leave  
  2c1612:	c3                   	ret    

00000000002c1613 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c1613:	55                   	push   %rbp
  2c1614:	48 89 e5             	mov    %rsp,%rbp
  2c1617:	48 83 ec 40          	sub    $0x40,%rsp
  2c161b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c161f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c1623:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c1627:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c162b:	48 c7 45 e8 c5 15 2c 	movq   $0x2c15c5,-0x18(%rbp)
  2c1632:	00 
    sp.s = s;
  2c1633:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1637:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c163b:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c1640:	74 33                	je     2c1675 <vsnprintf+0x62>
        sp.end = s + size - 1;
  2c1642:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c1646:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c164a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c164e:	48 01 d0             	add    %rdx,%rax
  2c1651:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c1655:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c1659:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c165d:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c1661:	be 00 00 00 00       	mov    $0x0,%esi
  2c1666:	48 89 c7             	mov    %rax,%rdi
  2c1669:	e8 ea f3 ff ff       	call   2c0a58 <printer_vprintf>
        *sp.s = 0;
  2c166e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1672:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c1675:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1679:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c167d:	c9                   	leave  
  2c167e:	c3                   	ret    

00000000002c167f <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c167f:	55                   	push   %rbp
  2c1680:	48 89 e5             	mov    %rsp,%rbp
  2c1683:	48 83 ec 70          	sub    $0x70,%rsp
  2c1687:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c168b:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c168f:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c1693:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1697:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c169b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c169f:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c16a6:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c16aa:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c16ae:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c16b2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c16b6:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c16ba:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c16be:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c16c2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c16c6:	48 89 c7             	mov    %rax,%rdi
  2c16c9:	e8 45 ff ff ff       	call   2c1613 <vsnprintf>
  2c16ce:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c16d1:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c16d4:	c9                   	leave  
  2c16d5:	c3                   	ret    

00000000002c16d6 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c16d6:	55                   	push   %rbp
  2c16d7:	48 89 e5             	mov    %rsp,%rbp
  2c16da:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c16de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c16e5:	eb 13                	jmp    2c16fa <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  2c16e7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c16ea:	48 98                	cltq   
  2c16ec:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  2c16f3:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c16f6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c16fa:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c1701:	7e e4                	jle    2c16e7 <console_clear+0x11>
    }
    cursorpos = 0;
  2c1703:	c7 05 ef 78 df ff 00 	movl   $0x0,-0x208711(%rip)        # b8ffc <cursorpos>
  2c170a:	00 00 00 
}
  2c170d:	90                   	nop
  2c170e:	c9                   	leave  
  2c170f:	c3                   	ret    
