
obj/p-alloctests.full:     file format elf64-x86-64


Disassembly of section .text:

00000000002c0000 <process_main>:
#include "time.h"
#include "malloc.h"

extern uint8_t end[];

void process_main(void) {
  2c0000:	55                   	push   %rbp
  2c0001:	48 89 e5             	mov    %rsp,%rbp
  2c0004:	41 57                	push   %r15
  2c0006:	41 56                	push   %r14
  2c0008:	41 55                	push   %r13
  2c000a:	41 54                	push   %r12
  2c000c:	53                   	push   %rbx
  2c000d:	48 83 ec 28          	sub    $0x28,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  2c0011:	cd 31                	int    $0x31
  2c0013:	41 89 c4             	mov    %eax,%r12d
    
    pid_t p = getpid();
    srand(p);
  2c0016:	89 c7                	mov    %eax,%edi
  2c0018:	e8 e1 0c 00 00       	call   2c0cfe <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001d:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0022:	e8 5a 05 00 00       	call   2c0581 <malloc>
  2c0027:	48 89 c3             	mov    %rax,%rbx
    app_printf(0x800, "array 1: %p\n", array);
  2c002a:	48 89 c2             	mov    %rax,%rdx
  2c002d:	be 6a 1a 2c 00       	mov    $0x2c1a6a,%esi
  2c0032:	bf 00 08 00 00       	mov    $0x800,%edi
  2c0037:	b8 00 00 00 00       	mov    $0x0,%eax
  2c003c:	e8 e1 01 00 00       	call   2c0222 <app_printf>
  2c0041:	b8 00 00 00 00       	mov    $0x0,%eax
    
    // set array elements
    for(int  i = 0 ; i < 10; i++){
	array[i] = i;
  2c0046:	89 04 83             	mov    %eax,(%rbx,%rax,4)
    for(int  i = 0 ; i < 10; i++){
  2c0049:	48 83 c0 01          	add    $0x1,%rax
  2c004d:	48 83 f8 0a          	cmp    $0xa,%rax
  2c0051:	75 f3                	jne    2c0046 <process_main+0x46>
    }

    // realloc array to size 20
    array = (int*)realloc(array, sizeof(int) * 20);
  2c0053:	be 50 00 00 00       	mov    $0x50,%esi
  2c0058:	48 89 df             	mov    %rbx,%rdi
  2c005b:	e8 06 06 00 00       	call   2c0666 <realloc>
  2c0060:	49 89 c5             	mov    %rax,%r13
    app_printf(0x800, "realloc'd array 1: %p\n", array);
  2c0063:	48 89 c2             	mov    %rax,%rdx
  2c0066:	be 60 1a 2c 00       	mov    $0x2c1a60,%esi
  2c006b:	bf 00 08 00 00       	mov    $0x800,%edi
  2c0070:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0075:	e8 a8 01 00 00       	call   2c0222 <app_printf>
  2c007a:	b8 00 00 00 00       	mov    $0x0,%eax


    // check if contents are same
    for(int i = 0 ; i < 10 ; i++){
	assert(array[i] == i);
  2c007f:	41 39 44 85 00       	cmp    %eax,0x0(%r13,%rax,4)
  2c0084:	0f 85 cf 00 00 00    	jne    2c0159 <process_main+0x159>
    for(int i = 0 ; i < 10 ; i++){
  2c008a:	48 83 c0 01          	add    $0x1,%rax
  2c008e:	48 83 f8 0a          	cmp    $0xa,%rax
  2c0092:	75 eb                	jne    2c007f <process_main+0x7f>
    }

    // alloc int array of size 30 using calloc
    int * array2 = (int *)calloc(30, sizeof(int));
  2c0094:	be 04 00 00 00       	mov    $0x4,%esi
  2c0099:	bf 1e 00 00 00       	mov    $0x1e,%edi
  2c009e:	e8 90 05 00 00       	call   2c0633 <calloc>
  2c00a3:	49 89 c6             	mov    %rax,%r14
    app_printf(0x900, "array 2: %p\n", array2);
  2c00a6:	48 89 c2             	mov    %rax,%rdx
  2c00a9:	be 9b 1a 2c 00       	mov    $0x2c1a9b,%esi
  2c00ae:	bf 00 09 00 00       	mov    $0x900,%edi
  2c00b3:	b8 00 00 00 00       	mov    $0x0,%eax
  2c00b8:	e8 65 01 00 00       	call   2c0222 <app_printf>

    // assert array[i] == 0
    for(int i = 0 ; i < 30; i++){
  2c00bd:	4c 89 f0             	mov    %r14,%rax
  2c00c0:	49 8d 56 78          	lea    0x78(%r14),%rdx
	assert(array2[i] == 0);
  2c00c4:	8b 18                	mov    (%rax),%ebx
  2c00c6:	85 db                	test   %ebx,%ebx
  2c00c8:	0f 85 9f 00 00 00    	jne    2c016d <process_main+0x16d>
    for(int i = 0 ; i < 30; i++){
  2c00ce:	48 83 c0 04          	add    $0x4,%rax
  2c00d2:	48 39 d0             	cmp    %rdx,%rax
  2c00d5:	75 ed                	jne    2c00c4 <process_main+0xc4>
    }
    
    heap_info_struct info;
    if(heap_info(&info) == 0){
  2c00d7:	48 8d 7d b0          	lea    -0x50(%rbp),%rdi
  2c00db:	e8 a2 07 00 00       	call   2c0882 <heap_info>
  2c00e0:	85 c0                	test   %eax,%eax
  2c00e2:	0f 85 ad 00 00 00    	jne    2c0195 <process_main+0x195>
	// check if allocations are in sorted order
	app_printf(0x700, "alloc'd regions:\n");
  2c00e8:	be b7 1a 2c 00       	mov    $0x2c1ab7,%esi
  2c00ed:	bf 00 07 00 00       	mov    $0x700,%edi
  2c00f2:	e8 2b 01 00 00       	call   2c0222 <app_printf>
	for(int  i = 0 ; i < info.num_allocs; i++){
  2c00f7:	8b 55 b0             	mov    -0x50(%rbp),%edx
  2c00fa:	85 d2                	test   %edx,%edx
  2c00fc:	7e 36                	jle    2c0134 <process_main+0x134>
  2c00fe:	41 bf 00 00 00 00    	mov    $0x0,%r15d
		app_printf(0x700, "    ptr: %p, size: 0x%lx\n", info.ptr_array[i], info.size_array[i]);;
  2c0104:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  2c0108:	4a 8b 0c f8          	mov    (%rax,%r15,8),%rcx
  2c010c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c0110:	4a 8b 14 f8          	mov    (%rax,%r15,8),%rdx
  2c0114:	be c9 1a 2c 00       	mov    $0x2c1ac9,%esi
  2c0119:	bf 00 07 00 00       	mov    $0x700,%edi
  2c011e:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0123:	e8 fa 00 00 00       	call   2c0222 <app_printf>
	for(int  i = 0 ; i < info.num_allocs; i++){
  2c0128:	8b 55 b0             	mov    -0x50(%rbp),%edx
  2c012b:	49 83 c7 01          	add    $0x1,%r15
  2c012f:	44 39 fa             	cmp    %r15d,%edx
  2c0132:	7f d0                	jg     2c0104 <process_main+0x104>
	}
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c0134:	83 fa 01             	cmp    $0x1,%edx
  2c0137:	7e 70                	jle    2c01a9 <process_main+0x1a9>
  2c0139:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  2c013d:	8d 52 fe             	lea    -0x2(%rdx),%edx
  2c0140:	48 8d 54 d0 08       	lea    0x8(%rax,%rdx,8),%rdx
	    assert(info.size_array[i] <= info.size_array[i-1]);
  2c0145:	48 8b 30             	mov    (%rax),%rsi
  2c0148:	48 39 70 08          	cmp    %rsi,0x8(%rax)
  2c014c:	7f 33                	jg     2c0181 <process_main+0x181>
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c014e:	48 83 c0 08          	add    $0x8,%rax
  2c0152:	48 39 d0             	cmp    %rdx,%rax
  2c0155:	75 ee                	jne    2c0145 <process_main+0x145>
  2c0157:	eb 50                	jmp    2c01a9 <process_main+0x1a9>
	assert(array[i] == i);
  2c0159:	ba 77 1a 2c 00       	mov    $0x2c1a77,%edx
  2c015e:	be 1c 00 00 00       	mov    $0x1c,%esi
  2c0163:	bf 85 1a 2c 00       	mov    $0x2c1a85,%edi
  2c0168:	e8 13 02 00 00       	call   2c0380 <assert_fail>
	assert(array2[i] == 0);
  2c016d:	ba a8 1a 2c 00       	mov    $0x2c1aa8,%edx
  2c0172:	be 25 00 00 00       	mov    $0x25,%esi
  2c0177:	bf 85 1a 2c 00       	mov    $0x2c1a85,%edi
  2c017c:	e8 ff 01 00 00       	call   2c0380 <assert_fail>
	    assert(info.size_array[i] <= info.size_array[i-1]);
  2c0181:	ba f8 1a 2c 00       	mov    $0x2c1af8,%edx
  2c0186:	be 30 00 00 00       	mov    $0x30,%esi
  2c018b:	bf 85 1a 2c 00       	mov    $0x2c1a85,%edi
  2c0190:	e8 eb 01 00 00       	call   2c0380 <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c0195:	be e3 1a 2c 00       	mov    $0x2c1ae3,%esi
  2c019a:	bf 00 00 00 00       	mov    $0x0,%edi
  2c019f:	b8 00 00 00 00       	mov    $0x0,%eax
  2c01a4:	e8 79 00 00 00       	call   2c0222 <app_printf>
    }
    
    // free array, array2
    free(array);
  2c01a9:	4c 89 ef             	mov    %r13,%rdi
  2c01ac:	e8 78 02 00 00       	call   2c0429 <free>
    free(array2);
  2c01b1:	4c 89 f7             	mov    %r14,%rdi
  2c01b4:	e8 70 02 00 00       	call   2c0429 <free>

    uint64_t total_time = 0;
  2c01b9:	41 bd 00 00 00 00    	mov    $0x0,%r13d
/* rdtscp */
static uint64_t rdtsc(void) {
	uint64_t var;
	uint32_t hi, lo;

	__asm volatile
  2c01bf:	0f 31                	rdtsc  
	    ("rdtsc" : "=a" (lo), "=d" (hi));

	var = ((uint64_t)hi << 32) | lo;
  2c01c1:	48 c1 e2 20          	shl    $0x20,%rdx
  2c01c5:	89 c0                	mov    %eax,%eax
  2c01c7:	48 09 c2             	or     %rax,%rdx
  2c01ca:	49 89 d6             	mov    %rdx,%r14
    int total_pages = 0;
    
    // allocate pages till no more memory
    while (1) {
	uint64_t time = rdtsc();
	void * ptr = malloc(PAGESIZE);
  2c01cd:	bf 00 10 00 00       	mov    $0x1000,%edi
  2c01d2:	e8 aa 03 00 00       	call   2c0581 <malloc>
  2c01d7:	48 89 c1             	mov    %rax,%rcx
	__asm volatile
  2c01da:	0f 31                	rdtsc  
	var = ((uint64_t)hi << 32) | lo;
  2c01dc:	48 c1 e2 20          	shl    $0x20,%rdx
  2c01e0:	89 c0                	mov    %eax,%eax
  2c01e2:	48 09 c2             	or     %rax,%rdx
	total_time += (rdtsc() - time);
  2c01e5:	4c 29 f2             	sub    %r14,%rdx
  2c01e8:	49 01 d5             	add    %rdx,%r13
	if(ptr == NULL)
  2c01eb:	48 85 c9             	test   %rcx,%rcx
  2c01ee:	74 08                	je     2c01f8 <process_main+0x1f8>
	    break;
	total_pages++;
  2c01f0:	83 c3 01             	add    $0x1,%ebx
	*((int *)ptr) = p; // check write access
  2c01f3:	44 89 21             	mov    %r12d,(%rcx)
    while (1) {
  2c01f6:	eb c7                	jmp    2c01bf <process_main+0x1bf>
    }

    app_printf(p, "Total_time taken to alloc: %d Average time: %d\n", total_time, total_time/total_pages);
  2c01f8:	48 63 db             	movslq %ebx,%rbx
  2c01fb:	4c 89 e8             	mov    %r13,%rax
  2c01fe:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0203:	48 f7 f3             	div    %rbx
  2c0206:	48 89 c1             	mov    %rax,%rcx
  2c0209:	4c 89 ea             	mov    %r13,%rdx
  2c020c:	be 28 1b 2c 00       	mov    $0x2c1b28,%esi
  2c0211:	44 89 e7             	mov    %r12d,%edi
  2c0214:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0219:	e8 04 00 00 00       	call   2c0222 <app_printf>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  2c021e:	cd 32                	int    $0x32
  2c0220:	eb fc                	jmp    2c021e <process_main+0x21e>

00000000002c0222 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  2c0222:	55                   	push   %rbp
  2c0223:	48 89 e5             	mov    %rsp,%rbp
  2c0226:	48 83 ec 50          	sub    $0x50,%rsp
  2c022a:	49 89 f2             	mov    %rsi,%r10
  2c022d:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c0231:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c0235:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c0239:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  2c023d:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  2c0242:	85 ff                	test   %edi,%edi
  2c0244:	78 2e                	js     2c0274 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  2c0246:	48 63 ff             	movslq %edi,%rdi
  2c0249:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  2c0250:	cc cc cc 
  2c0253:	48 89 f8             	mov    %rdi,%rax
  2c0256:	48 f7 e2             	mul    %rdx
  2c0259:	48 89 d0             	mov    %rdx,%rax
  2c025c:	48 c1 e8 02          	shr    $0x2,%rax
  2c0260:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  2c0264:	48 01 c2             	add    %rax,%rdx
  2c0267:	48 29 d7             	sub    %rdx,%rdi
  2c026a:	0f b6 b7 8d 1b 2c 00 	movzbl 0x2c1b8d(%rdi),%esi
  2c0271:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  2c0274:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  2c027b:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c027f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c0283:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c0287:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  2c028b:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c028f:	4c 89 d2             	mov    %r10,%rdx
  2c0292:	8b 3d 64 8d df ff    	mov    -0x20729c(%rip),%edi        # b8ffc <cursorpos>
  2c0298:	e8 b3 15 00 00       	call   2c1850 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  2c029d:	3d 30 07 00 00       	cmp    $0x730,%eax
  2c02a2:	ba 00 00 00 00       	mov    $0x0,%edx
  2c02a7:	0f 4d c2             	cmovge %edx,%eax
  2c02aa:	89 05 4c 8d df ff    	mov    %eax,-0x2072b4(%rip)        # b8ffc <cursorpos>
    }
}
  2c02b0:	c9                   	leave  
  2c02b1:	c3                   	ret    

00000000002c02b2 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  2c02b2:	55                   	push   %rbp
  2c02b3:	48 89 e5             	mov    %rsp,%rbp
  2c02b6:	53                   	push   %rbx
  2c02b7:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  2c02be:	48 89 fb             	mov    %rdi,%rbx
  2c02c1:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  2c02c5:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  2c02c9:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  2c02cd:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  2c02d1:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  2c02d5:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  2c02dc:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c02e0:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  2c02e4:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  2c02e8:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  2c02ec:	ba 07 00 00 00       	mov    $0x7,%edx
  2c02f1:	be 58 1b 2c 00       	mov    $0x2c1b58,%esi
  2c02f6:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  2c02fd:	e8 05 07 00 00       	call   2c0a07 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0302:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0306:	48 89 da             	mov    %rbx,%rdx
  2c0309:	be 99 00 00 00       	mov    $0x99,%esi
  2c030e:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c0315:	e8 42 16 00 00       	call   2c195c <vsnprintf>
  2c031a:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  2c031d:	85 d2                	test   %edx,%edx
  2c031f:	7e 0f                	jle    2c0330 <kernel_panic+0x7e>
  2c0321:	83 c0 06             	add    $0x6,%eax
  2c0324:	48 98                	cltq   
  2c0326:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  2c032d:	0a 
  2c032e:	75 2a                	jne    2c035a <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  2c0330:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  2c0337:	48 89 d9             	mov    %rbx,%rcx
  2c033a:	ba 60 1b 2c 00       	mov    $0x2c1b60,%edx
  2c033f:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c0344:	bf 30 07 00 00       	mov    $0x730,%edi
  2c0349:	b8 00 00 00 00       	mov    $0x0,%eax
  2c034e:	e8 69 15 00 00       	call   2c18bc <console_printf>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  2c0353:	48 89 df             	mov    %rbx,%rdi
  2c0356:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  2c0358:	eb fe                	jmp    2c0358 <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  2c035a:	48 63 c2             	movslq %edx,%rax
  2c035d:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  2c0363:	0f 94 c2             	sete   %dl
  2c0366:	0f b6 d2             	movzbl %dl,%edx
  2c0369:	48 29 d0             	sub    %rdx,%rax
  2c036c:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  2c0373:	ff 
  2c0374:	be c7 1a 2c 00       	mov    $0x2c1ac7,%esi
  2c0379:	e8 36 08 00 00       	call   2c0bb4 <strcpy>
  2c037e:	eb b0                	jmp    2c0330 <kernel_panic+0x7e>

00000000002c0380 <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  2c0380:	55                   	push   %rbp
  2c0381:	48 89 e5             	mov    %rsp,%rbp
  2c0384:	48 89 f9             	mov    %rdi,%rcx
  2c0387:	41 89 f0             	mov    %esi,%r8d
  2c038a:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  2c038d:	ba 68 1b 2c 00       	mov    $0x2c1b68,%edx
  2c0392:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c0397:	bf 30 07 00 00       	mov    $0x730,%edi
  2c039c:	b8 00 00 00 00       	mov    $0x0,%eax
  2c03a1:	e8 16 15 00 00       	call   2c18bc <console_printf>
    asm volatile ("int %0" : /* no result */
  2c03a6:	bf 00 00 00 00       	mov    $0x0,%edi
  2c03ab:	cd 30                	int    $0x30
 loop: goto loop;
  2c03ad:	eb fe                	jmp    2c03ad <assert_fail+0x2d>

00000000002c03af <heap_init>:
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  2c03af:	bf 10 00 00 00       	mov    $0x10,%edi
  2c03b4:	cd 3a                	int    $0x3a
  2c03b6:	48 89 05 5b 1c 00 00 	mov    %rax,0x1c5b(%rip)        # 2c2018 <result.0>
  2c03bd:	bf 08 00 00 00       	mov    $0x8,%edi
  2c03c2:	cd 3a                	int    $0x3a
  2c03c4:	48 89 05 4d 1c 00 00 	mov    %rax,0x1c4d(%rip)        # 2c2018 <result.0>
// want to try and optimize this 
void heap_init(void) {

	// prologue block
	sbrk(sizeof(block_header) + sizeof(block_header));
	prologue_block = sbrk(sizeof(block_footer));
  2c03cb:	48 89 05 36 1c 00 00 	mov    %rax,0x1c36(%rip)        # 2c2008 <prologue_block>
	PUT(HDRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  2c03d2:	48 c7 40 f8 11 00 00 	movq   $0x11,-0x8(%rax)
  2c03d9:	00 
	PUT(FTRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  2c03da:	48 8b 15 27 1c 00 00 	mov    0x1c27(%rip),%rdx        # 2c2008 <prologue_block>
  2c03e1:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  2c03e5:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c03e9:	48 c7 44 02 f0 11 00 	movq   $0x11,-0x10(%rdx,%rax,1)
  2c03f0:	00 00 
  2c03f2:	cd 3a                	int    $0x3a
  2c03f4:	48 89 05 1d 1c 00 00 	mov    %rax,0x1c1d(%rip)        # 2c2018 <result.0>

	// terminal block
	sbrk(sizeof(block_header));
	PUT(HDRP(NEXT_BLKP(prologue_block)), PACK(0, 1));	
  2c03fb:	48 8b 15 06 1c 00 00 	mov    0x1c06(%rip),%rdx        # 2c2008 <prologue_block>
  2c0402:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  2c0406:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c040a:	48 c7 44 02 f8 01 00 	movq   $0x1,-0x8(%rdx,%rax,1)
  2c0411:	00 00 

	free_list = NULL;
  2c0413:	48 c7 05 e2 1b 00 00 	movq   $0x0,0x1be2(%rip)        # 2c2000 <free_list>
  2c041a:	00 00 00 00 

	initialized_heap = 1;
  2c041e:	c7 05 e8 1b 00 00 01 	movl   $0x1,0x1be8(%rip)        # 2c2010 <initialized_heap>
  2c0425:	00 00 00 
}
  2c0428:	c3                   	ret    

00000000002c0429 <free>:

void free(void *firstbyte) {
	if (firstbyte == NULL)
  2c0429:	48 85 ff             	test   %rdi,%rdi
  2c042c:	74 35                	je     2c0463 <free+0x3a>
		return;

	// setup free things: alloc, list ptrs, footer
	PUT(HDRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  2c042e:	48 8b 47 f8          	mov    -0x8(%rdi),%rax
  2c0432:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c0436:	48 89 47 f8          	mov    %rax,-0x8(%rdi)
	NEXT_FPTR(firstbyte) = free_list;
  2c043a:	48 8b 15 bf 1b 00 00 	mov    0x1bbf(%rip),%rdx        # 2c2000 <free_list>
  2c0441:	48 89 17             	mov    %rdx,(%rdi)
	PREV_FPTR(firstbyte) = NULL;
  2c0444:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  2c044b:	00 
	PUT(FTRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  2c044c:	48 89 44 07 f0       	mov    %rax,-0x10(%rdi,%rax,1)

	// add to free_list
	PREV_FPTR(free_list) = firstbyte;
  2c0451:	48 8b 05 a8 1b 00 00 	mov    0x1ba8(%rip),%rax        # 2c2000 <free_list>
  2c0458:	48 89 78 08          	mov    %rdi,0x8(%rax)
	free_list = firstbyte;
  2c045c:	48 89 3d 9d 1b 00 00 	mov    %rdi,0x1b9d(%rip)        # 2c2000 <free_list>

	return;
}
  2c0463:	c3                   	ret    

00000000002c0464 <extend>:
//
//	the reason allocating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
int extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  2c0464:	48 81 c7 ff ff 00 00 	add    $0xffff,%rdi
  2c046b:	66 bf 00 00          	mov    $0x0,%di
  2c046f:	cd 3a                	int    $0x3a
  2c0471:	48 89 05 a0 1b 00 00 	mov    %rax,0x1ba0(%rip)        # 2c2018 <result.0>
	void *bp = sbrk(chunk_aligned_size);
	if (bp == (void *)-1)
  2c0478:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c047c:	74 49                	je     2c04c7 <extend+0x63>
		return -1;

	// setup pointer
	PUT(HDRP(bp), PACK(chunk_aligned_size, 0));	
  2c047e:	48 89 78 f8          	mov    %rdi,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  2c0482:	48 8b 15 77 1b 00 00 	mov    0x1b77(%rip),%rdx        # 2c2000 <free_list>
  2c0489:	48 89 10             	mov    %rdx,(%rax)
	PREV_FPTR(bp) = NULL;
  2c048c:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  2c0493:	00 
	PUT(FTRP(bp), PACK(chunk_aligned_size, 0));	
  2c0494:	48 89 7c 07 f0       	mov    %rdi,-0x10(%rdi,%rax,1)
	
	// add to head of free_list
	if (free_list)
  2c0499:	48 8b 15 60 1b 00 00 	mov    0x1b60(%rip),%rdx        # 2c2000 <free_list>
  2c04a0:	48 85 d2             	test   %rdx,%rdx
  2c04a3:	74 04                	je     2c04a9 <extend+0x45>
		PREV_FPTR(free_list) = bp;
  2c04a5:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  2c04a9:	48 89 05 50 1b 00 00 	mov    %rax,0x1b50(%rip)        # 2c2000 <free_list>

	// update terminal block
	PUT(HDRP(NEXT_BLKP(bp)), PACK(0, 1));	
  2c04b0:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c04b4:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c04b8:	48 c7 44 10 f8 01 00 	movq   $0x1,-0x8(%rax,%rdx,1)
  2c04bf:	00 00 

	return 0;
  2c04c1:	b8 00 00 00 00       	mov    $0x0,%eax
  2c04c6:	c3                   	ret    
		return -1;
  2c04c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  2c04cc:	c3                   	ret    

00000000002c04cd <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
  2c04cd:	48 89 f8             	mov    %rdi,%rax
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  2c04d0:	48 8b 57 f8          	mov    -0x8(%rdi),%rdx
  2c04d4:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c04d8:	48 29 f2             	sub    %rsi,%rdx

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  2c04db:	48 83 fa 20          	cmp    $0x20,%rdx
  2c04df:	76 5b                	jbe    2c053c <set_allocated+0x6f>
		PUT(HDRP(bp), PACK(size, 1));
  2c04e1:	48 89 f1             	mov    %rsi,%rcx
  2c04e4:	48 83 c9 01          	or     $0x1,%rcx
  2c04e8:	48 89 4f f8          	mov    %rcx,-0x8(%rdi)

		void *leftover_mem_ptr = NEXT_BLKP(bp);
  2c04ec:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  2c04f0:	48 01 fe             	add    %rdi,%rsi

		PUT(HDRP(leftover_mem_ptr), PACK(extra_size, 0));	
  2c04f3:	48 89 56 f8          	mov    %rdx,-0x8(%rsi)
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp); // pointers to the next free blocks
  2c04f7:	48 8b 0f             	mov    (%rdi),%rcx
  2c04fa:	48 89 0e             	mov    %rcx,(%rsi)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  2c04fd:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  2c0501:	48 89 4e 08          	mov    %rcx,0x8(%rsi)
		PUT(FTRP(leftover_mem_ptr), PACK(extra_size, 0));	
  2c0505:	48 89 d1             	mov    %rdx,%rcx
  2c0508:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  2c050c:	48 89 54 0e f0       	mov    %rdx,-0x10(%rsi,%rcx,1)

		// update the free list
		if (free_list == bp)
  2c0511:	48 39 3d e8 1a 00 00 	cmp    %rdi,0x1ae8(%rip)        # 2c2000 <free_list>
  2c0518:	74 19                	je     2c0533 <set_allocated+0x66>
			free_list = leftover_mem_ptr;

		if (PREV_FPTR(bp))
  2c051a:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c051e:	48 85 d2             	test   %rdx,%rdx
  2c0521:	74 03                	je     2c0526 <set_allocated+0x59>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  2c0523:	48 89 32             	mov    %rsi,(%rdx)

		if (NEXT_FPTR(bp))
  2c0526:	48 8b 00             	mov    (%rax),%rax
  2c0529:	48 85 c0             	test   %rax,%rax
  2c052c:	74 46                	je     2c0574 <set_allocated+0xa7>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  2c052e:	48 89 70 08          	mov    %rsi,0x8(%rax)
  2c0532:	c3                   	ret    
			free_list = leftover_mem_ptr;
  2c0533:	48 89 35 c6 1a 00 00 	mov    %rsi,0x1ac6(%rip)        # 2c2000 <free_list>
  2c053a:	eb de                	jmp    2c051a <set_allocated+0x4d>
								    
	}
	else {
		// update the free list
		if (free_list == bp)
  2c053c:	48 39 3d bd 1a 00 00 	cmp    %rdi,0x1abd(%rip)        # 2c2000 <free_list>
  2c0543:	74 30                	je     2c0575 <set_allocated+0xa8>
			free_list = NEXT_FPTR(bp);

		if (PREV_FPTR(bp))
  2c0545:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c0549:	48 85 d2             	test   %rdx,%rdx
  2c054c:	74 06                	je     2c0554 <set_allocated+0x87>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  2c054e:	48 8b 08             	mov    (%rax),%rcx
  2c0551:	48 89 0a             	mov    %rcx,(%rdx)
		if (NEXT_FPTR(bp))
  2c0554:	48 8b 10             	mov    (%rax),%rdx
  2c0557:	48 85 d2             	test   %rdx,%rdx
  2c055a:	74 08                	je     2c0564 <set_allocated+0x97>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  2c055c:	48 8b 48 08          	mov    0x8(%rax),%rcx
  2c0560:	48 89 4a 08          	mov    %rcx,0x8(%rdx)

		PUT(HDRP(bp), PACK(GET_SIZE(HDRP(bp)), 1));	
  2c0564:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c0568:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c056c:	48 83 ca 01          	or     $0x1,%rdx
  2c0570:	48 89 50 f8          	mov    %rdx,-0x8(%rax)
	}
}
  2c0574:	c3                   	ret    
			free_list = NEXT_FPTR(bp);
  2c0575:	48 8b 17             	mov    (%rdi),%rdx
  2c0578:	48 89 15 81 1a 00 00 	mov    %rdx,0x1a81(%rip)        # 2c2000 <free_list>
  2c057f:	eb c4                	jmp    2c0545 <set_allocated+0x78>

00000000002c0581 <malloc>:

void *malloc(uint64_t numbytes) {
  2c0581:	55                   	push   %rbp
  2c0582:	48 89 e5             	mov    %rsp,%rbp
  2c0585:	41 55                	push   %r13
  2c0587:	41 54                	push   %r12
  2c0589:	53                   	push   %rbx
  2c058a:	48 83 ec 08          	sub    $0x8,%rsp
  2c058e:	49 89 fc             	mov    %rdi,%r12
	if (!initialized_heap)
  2c0591:	83 3d 78 1a 00 00 00 	cmpl   $0x0,0x1a78(%rip)        # 2c2010 <initialized_heap>
  2c0598:	74 6b                	je     2c0605 <malloc+0x84>
		heap_init();

	if (numbytes == 0)
  2c059a:	4d 85 e4             	test   %r12,%r12
  2c059d:	0f 84 82 00 00 00    	je     2c0625 <malloc+0xa4>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  2c05a3:	49 83 c4 17          	add    $0x17,%r12
  2c05a7:	49 83 e4 f0          	and    $0xfffffffffffffff0,%r12
  2c05ab:	b8 20 00 00 00       	mov    $0x20,%eax
  2c05b0:	49 39 c4             	cmp    %rax,%r12
  2c05b3:	4c 0f 42 e0          	cmovb  %rax,%r12
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);
	
	void *bp = free_list;
  2c05b7:	48 8b 1d 42 1a 00 00 	mov    0x1a42(%rip),%rbx        # 2c2000 <free_list>
	while (bp) {
  2c05be:	48 85 db             	test   %rbx,%rbx
  2c05c1:	74 15                	je     2c05d8 <malloc+0x57>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  2c05c3:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  2c05c7:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c05cb:	4c 39 e0             	cmp    %r12,%rax
  2c05ce:	73 3c                	jae    2c060c <malloc+0x8b>
			set_allocated(bp, aligned_size);
			return bp;
		}

		bp = NEXT_FPTR(bp);
  2c05d0:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  2c05d3:	48 85 db             	test   %rbx,%rbx
  2c05d6:	75 eb                	jne    2c05c3 <malloc+0x42>
  2c05d8:	bf 00 00 00 00       	mov    $0x0,%edi
  2c05dd:	cd 3a                	int    $0x3a
  2c05df:	49 89 c5             	mov    %rax,%r13
  2c05e2:	48 89 05 2f 1a 00 00 	mov    %rax,0x1a2f(%rip)        # 2c2018 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  2c05e9:	48 89 c3             	mov    %rax,%rbx
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	if (extend(aligned_size)) {
  2c05ec:	4c 89 e7             	mov    %r12,%rdi
  2c05ef:	e8 70 fe ff ff       	call   2c0464 <extend>
  2c05f4:	85 c0                	test   %eax,%eax
  2c05f6:	75 34                	jne    2c062c <malloc+0xab>
		return NULL;
	}
	set_allocated(bp, aligned_size);
  2c05f8:	4c 89 e6             	mov    %r12,%rsi
  2c05fb:	4c 89 ef             	mov    %r13,%rdi
  2c05fe:	e8 ca fe ff ff       	call   2c04cd <set_allocated>
    return bp;
  2c0603:	eb 12                	jmp    2c0617 <malloc+0x96>
		heap_init();
  2c0605:	e8 a5 fd ff ff       	call   2c03af <heap_init>
  2c060a:	eb 8e                	jmp    2c059a <malloc+0x19>
			set_allocated(bp, aligned_size);
  2c060c:	4c 89 e6             	mov    %r12,%rsi
  2c060f:	48 89 df             	mov    %rbx,%rdi
  2c0612:	e8 b6 fe ff ff       	call   2c04cd <set_allocated>
}
  2c0617:	48 89 d8             	mov    %rbx,%rax
  2c061a:	48 83 c4 08          	add    $0x8,%rsp
  2c061e:	5b                   	pop    %rbx
  2c061f:	41 5c                	pop    %r12
  2c0621:	41 5d                	pop    %r13
  2c0623:	5d                   	pop    %rbp
  2c0624:	c3                   	ret    
		return NULL;
  2c0625:	bb 00 00 00 00       	mov    $0x0,%ebx
  2c062a:	eb eb                	jmp    2c0617 <malloc+0x96>
		return NULL;
  2c062c:	bb 00 00 00 00       	mov    $0x0,%ebx
  2c0631:	eb e4                	jmp    2c0617 <malloc+0x96>

00000000002c0633 <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  2c0633:	55                   	push   %rbp
  2c0634:	48 89 e5             	mov    %rsp,%rbp
  2c0637:	41 54                	push   %r12
  2c0639:	53                   	push   %rbx
	void *bp = malloc(num * sz);
  2c063a:	48 0f af fe          	imul   %rsi,%rdi
  2c063e:	49 89 fc             	mov    %rdi,%r12
  2c0641:	e8 3b ff ff ff       	call   2c0581 <malloc>
  2c0646:	48 89 c3             	mov    %rax,%rbx
	if (bp)							// protect against num=0 or size=0 or just no memory
  2c0649:	48 85 c0             	test   %rax,%rax
  2c064c:	74 10                	je     2c065e <calloc+0x2b>
		memset(bp, 0, num * sz);
  2c064e:	4c 89 e2             	mov    %r12,%rdx
  2c0651:	be 00 00 00 00       	mov    $0x0,%esi
  2c0656:	48 89 c7             	mov    %rax,%rdi
  2c0659:	e8 a7 04 00 00       	call   2c0b05 <memset>
	return bp;
}
  2c065e:	48 89 d8             	mov    %rbx,%rax
  2c0661:	5b                   	pop    %rbx
  2c0662:	41 5c                	pop    %r12
  2c0664:	5d                   	pop    %rbp
  2c0665:	c3                   	ret    

00000000002c0666 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  2c0666:	55                   	push   %rbp
  2c0667:	48 89 e5             	mov    %rsp,%rbp
  2c066a:	41 54                	push   %r12
  2c066c:	53                   	push   %rbx
	if (ptr == NULL && sz == 0) {
  2c066d:	48 85 f6             	test   %rsi,%rsi
  2c0670:	0f 94 c0             	sete   %al
  2c0673:	49 89 fc             	mov    %rdi,%r12
  2c0676:	49 09 f4             	or     %rsi,%r12
  2c0679:	74 26                	je     2c06a1 <realloc+0x3b>
  2c067b:	48 89 fb             	mov    %rdi,%rbx
		return NULL;
	}
	else if (ptr != NULL && sz == 0) {
  2c067e:	48 85 ff             	test   %rdi,%rdi
  2c0681:	74 04                	je     2c0687 <realloc+0x21>
  2c0683:	84 c0                	test   %al,%al
  2c0685:	75 22                	jne    2c06a9 <realloc+0x43>
		free(ptr);
		return NULL;
	}
	else if (ptr == NULL && sz != 0) {
  2c0687:	48 85 db             	test   %rbx,%rbx
  2c068a:	75 05                	jne    2c0691 <realloc+0x2b>
  2c068c:	48 85 f6             	test   %rsi,%rsi
  2c068f:	75 25                	jne    2c06b6 <realloc+0x50>
		return malloc(sz);
	}
	else if (GET_SIZE(HDRP(ptr)) >= sz) {
  2c0691:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  2c0695:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
		return ptr;
  2c0699:	49 89 dc             	mov    %rbx,%r12
	else if (GET_SIZE(HDRP(ptr)) >= sz) {
  2c069c:	48 39 f0             	cmp    %rsi,%rax
  2c069f:	72 22                	jb     2c06c3 <realloc+0x5d>
	else {
		memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
		free(ptr);
		return bigger_ptr;
	}
}
  2c06a1:	4c 89 e0             	mov    %r12,%rax
  2c06a4:	5b                   	pop    %rbx
  2c06a5:	41 5c                	pop    %r12
  2c06a7:	5d                   	pop    %rbp
  2c06a8:	c3                   	ret    
		free(ptr);
  2c06a9:	e8 7b fd ff ff       	call   2c0429 <free>
		return NULL;
  2c06ae:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c06b4:	eb eb                	jmp    2c06a1 <realloc+0x3b>
		return malloc(sz);
  2c06b6:	48 89 f7             	mov    %rsi,%rdi
  2c06b9:	e8 c3 fe ff ff       	call   2c0581 <malloc>
  2c06be:	49 89 c4             	mov    %rax,%r12
  2c06c1:	eb de                	jmp    2c06a1 <realloc+0x3b>
	void *bigger_ptr = malloc(sz);
  2c06c3:	48 89 f7             	mov    %rsi,%rdi
  2c06c6:	e8 b6 fe ff ff       	call   2c0581 <malloc>
  2c06cb:	49 89 c4             	mov    %rax,%r12
	if (bigger_ptr == NULL) {
  2c06ce:	48 85 c0             	test   %rax,%rax
  2c06d1:	74 1d                	je     2c06f0 <realloc+0x8a>
		memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
  2c06d3:	48 8b 53 f8          	mov    -0x8(%rbx),%rdx
  2c06d7:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c06db:	48 89 de             	mov    %rbx,%rsi
  2c06de:	48 89 c7             	mov    %rax,%rdi
  2c06e1:	e8 21 03 00 00       	call   2c0a07 <memcpy>
		free(ptr);
  2c06e6:	48 89 df             	mov    %rbx,%rdi
  2c06e9:	e8 3b fd ff ff       	call   2c0429 <free>
		return bigger_ptr;
  2c06ee:	eb b1                	jmp    2c06a1 <realloc+0x3b>
		return ptr;
  2c06f0:	49 89 dc             	mov    %rbx,%r12
  2c06f3:	eb ac                	jmp    2c06a1 <realloc+0x3b>

00000000002c06f5 <defrag>:

void defrag() {
	void *fp = free_list;
  2c06f5:	48 8b 15 04 19 00 00 	mov    0x1904(%rip),%rdx        # 2c2000 <free_list>
	while (fp != NULL) {
  2c06fc:	48 85 d2             	test   %rdx,%rdx
  2c06ff:	75 3c                	jne    2c073d <defrag+0x48>
		// you only need to check the block after, because if the block before is free, you'll
		// bet there by traversing the free list

		fp = NEXT_FPTR(fp);
	}
}
  2c0701:	c3                   	ret    
				free_list = NEXT_FPTR(next_block);
  2c0702:	48 8b 08             	mov    (%rax),%rcx
  2c0705:	48 89 0d f4 18 00 00 	mov    %rcx,0x18f4(%rip)        # 2c2000 <free_list>
  2c070c:	eb 49                	jmp    2c0757 <defrag+0x62>
			PUT(HDRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  2c070e:	48 8b 4a f8          	mov    -0x8(%rdx),%rcx
  2c0712:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  2c0716:	48 8b 70 f8          	mov    -0x8(%rax),%rsi
  2c071a:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  2c071e:	48 01 f1             	add    %rsi,%rcx
  2c0721:	48 89 4a f8          	mov    %rcx,-0x8(%rdx)
			PUT(FTRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  2c0725:	48 8b 40 f8          	mov    -0x8(%rax),%rax
  2c0729:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c072d:	48 01 c8             	add    %rcx,%rax
  2c0730:	48 89 44 0a f0       	mov    %rax,-0x10(%rdx,%rcx,1)
		fp = NEXT_FPTR(fp);
  2c0735:	48 8b 12             	mov    (%rdx),%rdx
	while (fp != NULL) {
  2c0738:	48 85 d2             	test   %rdx,%rdx
  2c073b:	74 c4                	je     2c0701 <defrag+0xc>
		void *next_block = NEXT_BLKP(fp);
  2c073d:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  2c0741:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c0745:	48 01 d0             	add    %rdx,%rax
		if (!GET_ALLOC(HDRP(next_block))) {
  2c0748:	f6 40 f8 01          	testb  $0x1,-0x8(%rax)
  2c074c:	75 e7                	jne    2c0735 <defrag+0x40>
			if (free_list == next_block)
  2c074e:	48 39 05 ab 18 00 00 	cmp    %rax,0x18ab(%rip)        # 2c2000 <free_list>
  2c0755:	74 ab                	je     2c0702 <defrag+0xd>
			if (PREV_FPTR(next_block)) 
  2c0757:	48 8b 48 08          	mov    0x8(%rax),%rcx
  2c075b:	48 85 c9             	test   %rcx,%rcx
  2c075e:	74 06                	je     2c0766 <defrag+0x71>
				NEXT_FPTR(PREV_FPTR(next_block)) = NEXT_FPTR(next_block);
  2c0760:	48 8b 30             	mov    (%rax),%rsi
  2c0763:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(next_block)) 
  2c0766:	48 8b 08             	mov    (%rax),%rcx
  2c0769:	48 85 c9             	test   %rcx,%rcx
  2c076c:	74 a0                	je     2c070e <defrag+0x19>
				PREV_FPTR(NEXT_FPTR(next_block)) = PREV_FPTR(next_block);
  2c076e:	48 8b 70 08          	mov    0x8(%rax),%rsi
  2c0772:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  2c0776:	eb 96                	jmp    2c070e <defrag+0x19>

00000000002c0778 <sift_down>:
// heap sort stuff that operates on the pointer array
#define LEFT_CHILD(x) (2*x + 1)
#define RIGHT_CHILD(x) (2*x + 2)
#define PARENT(x) ((x-1)/2)

void sift_down(void **arr, size_t pos, size_t arr_len) {
  2c0778:	48 89 f1             	mov    %rsi,%rcx
  2c077b:	49 89 d3             	mov    %rdx,%r11
	while (LEFT_CHILD(pos) < arr_len) {
  2c077e:	48 8d 74 36 01       	lea    0x1(%rsi,%rsi,1),%rsi
  2c0783:	48 39 d6             	cmp    %rdx,%rsi
  2c0786:	72 3a                	jb     2c07c2 <sift_down+0x4a>
  2c0788:	c3                   	ret    
  2c0789:	48 89 f0             	mov    %rsi,%rax
		size_t smaller = LEFT_CHILD(pos);
		if (RIGHT_CHILD(pos) < arr_len && GET_SIZE(HDRP(arr[RIGHT_CHILD(pos)])) < GET_SIZE(HDRP(arr[LEFT_CHILD(pos)]))){
			smaller = RIGHT_CHILD(pos);
		}

		if (GET_SIZE(HDRP(arr[pos])) > GET_SIZE(HDRP(arr[smaller]))) {
  2c078c:	4c 8d 0c cf          	lea    (%rdi,%rcx,8),%r9
  2c0790:	4d 8b 01             	mov    (%r9),%r8
  2c0793:	48 8d 34 c7          	lea    (%rdi,%rax,8),%rsi
  2c0797:	4c 8b 16             	mov    (%rsi),%r10
  2c079a:	49 8b 50 f8          	mov    -0x8(%r8),%rdx
  2c079e:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c07a2:	49 8b 4a f8          	mov    -0x8(%r10),%rcx
  2c07a6:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  2c07aa:	48 39 d1             	cmp    %rdx,%rcx
  2c07ad:	73 46                	jae    2c07f5 <sift_down+0x7d>
			void *temp = arr[pos];
			arr[pos] = arr[smaller];
  2c07af:	4d 89 11             	mov    %r10,(%r9)
			arr[smaller] = temp;
  2c07b2:	4c 89 06             	mov    %r8,(%rsi)
	while (LEFT_CHILD(pos) < arr_len) {
  2c07b5:	48 8d 74 00 01       	lea    0x1(%rax,%rax,1),%rsi
  2c07ba:	4c 39 de             	cmp    %r11,%rsi
  2c07bd:	73 36                	jae    2c07f5 <sift_down+0x7d>
			pos = smaller;
  2c07bf:	48 89 c1             	mov    %rax,%rcx
		if (RIGHT_CHILD(pos) < arr_len && GET_SIZE(HDRP(arr[RIGHT_CHILD(pos)])) < GET_SIZE(HDRP(arr[LEFT_CHILD(pos)]))){
  2c07c2:	48 8d 51 01          	lea    0x1(%rcx),%rdx
  2c07c6:	48 8d 04 12          	lea    (%rdx,%rdx,1),%rax
  2c07ca:	4c 39 d8             	cmp    %r11,%rax
  2c07cd:	73 ba                	jae    2c0789 <sift_down+0x11>
  2c07cf:	48 c1 e2 04          	shl    $0x4,%rdx
  2c07d3:	4c 8b 04 17          	mov    (%rdi,%rdx,1),%r8
  2c07d7:	4d 8b 40 f8          	mov    -0x8(%r8),%r8
  2c07db:	49 83 e0 f0          	and    $0xfffffffffffffff0,%r8
  2c07df:	48 8b 54 17 f8       	mov    -0x8(%rdi,%rdx,1),%rdx
  2c07e4:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  2c07e8:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c07ec:	49 39 d0             	cmp    %rdx,%r8
  2c07ef:	48 0f 43 c6          	cmovae %rsi,%rax
  2c07f3:	eb 97                	jmp    2c078c <sift_down+0x14>
		}
		else {
			break;
		}
	}
}
  2c07f5:	c3                   	ret    

00000000002c07f6 <heapify>:

void heapify(void **arr, size_t arr_len) {
  2c07f6:	55                   	push   %rbp
  2c07f7:	48 89 e5             	mov    %rsp,%rbp
  2c07fa:	41 56                	push   %r14
  2c07fc:	41 55                	push   %r13
  2c07fe:	41 54                	push   %r12
  2c0800:	53                   	push   %rbx
	for (int i = arr_len - 1; i >= 0; i--) {
  2c0801:	41 89 f5             	mov    %esi,%r13d
  2c0804:	41 83 ed 01          	sub    $0x1,%r13d
  2c0808:	78 28                	js     2c0832 <heapify+0x3c>
  2c080a:	49 89 fe             	mov    %rdi,%r14
  2c080d:	49 89 f4             	mov    %rsi,%r12
  2c0810:	49 63 c5             	movslq %r13d,%rax
  2c0813:	48 89 c3             	mov    %rax,%rbx
  2c0816:	41 29 c5             	sub    %eax,%r13d
		sift_down(arr, i, arr_len);
  2c0819:	4c 89 e2             	mov    %r12,%rdx
  2c081c:	48 89 de             	mov    %rbx,%rsi
  2c081f:	4c 89 f7             	mov    %r14,%rdi
  2c0822:	e8 51 ff ff ff       	call   2c0778 <sift_down>
	for (int i = arr_len - 1; i >= 0; i--) {
  2c0827:	48 83 eb 01          	sub    $0x1,%rbx
  2c082b:	44 89 e8             	mov    %r13d,%eax
  2c082e:	01 d8                	add    %ebx,%eax
  2c0830:	79 e7                	jns    2c0819 <heapify+0x23>
	}
}
  2c0832:	5b                   	pop    %rbx
  2c0833:	41 5c                	pop    %r12
  2c0835:	41 5d                	pop    %r13
  2c0837:	41 5e                	pop    %r14
  2c0839:	5d                   	pop    %rbp
  2c083a:	c3                   	ret    

00000000002c083b <heapsort>:

void heapsort(void **arr, size_t arr_len) {
  2c083b:	55                   	push   %rbp
  2c083c:	48 89 e5             	mov    %rsp,%rbp
  2c083f:	41 54                	push   %r12
  2c0841:	53                   	push   %rbx
  2c0842:	49 89 fc             	mov    %rdi,%r12
  2c0845:	48 89 f3             	mov    %rsi,%rbx
	heapify(arr, arr_len);
  2c0848:	e8 a9 ff ff ff       	call   2c07f6 <heapify>
	for (int i = arr_len - 1; i >= 0; i--) {
  2c084d:	83 eb 01             	sub    $0x1,%ebx
  2c0850:	78 2b                	js     2c087d <heapsort+0x42>
  2c0852:	48 63 db             	movslq %ebx,%rbx
		void *temp = arr[0];
  2c0855:	49 8b 04 24          	mov    (%r12),%rax
		arr[0] = arr[i];
  2c0859:	49 8b 14 dc          	mov    (%r12,%rbx,8),%rdx
  2c085d:	49 89 14 24          	mov    %rdx,(%r12)
		arr[i] = temp;
  2c0861:	49 89 04 dc          	mov    %rax,(%r12,%rbx,8)
		sift_down(arr, 0, i);
  2c0865:	48 89 da             	mov    %rbx,%rdx
  2c0868:	be 00 00 00 00       	mov    $0x0,%esi
  2c086d:	4c 89 e7             	mov    %r12,%rdi
  2c0870:	e8 03 ff ff ff       	call   2c0778 <sift_down>
	for (int i = arr_len - 1; i >= 0; i--) {
  2c0875:	48 83 eb 01          	sub    $0x1,%rbx
  2c0879:	85 db                	test   %ebx,%ebx
  2c087b:	79 d8                	jns    2c0855 <heapsort+0x1a>
	}
}
  2c087d:	5b                   	pop    %rbx
  2c087e:	41 5c                	pop    %r12
  2c0880:	5d                   	pop    %rbp
  2c0881:	c3                   	ret    

00000000002c0882 <heap_info>:

int heap_info(heap_info_struct *info) {
  2c0882:	55                   	push   %rbp
  2c0883:	48 89 e5             	mov    %rsp,%rbp
  2c0886:	53                   	push   %rbx
  2c0887:	48 83 ec 08          	sub    $0x8,%rsp
  2c088b:	48 89 fb             	mov    %rdi,%rbx
	info->num_allocs = 0;
  2c088e:	c7 07 00 00 00 00    	movl   $0x0,(%rdi)

	// collect the number of allocs :(
	void *bp = NEXT_BLKP(prologue_block); // because the prologue isn't actually allocated
  2c0894:	48 8b 05 6d 17 00 00 	mov    0x176d(%rip),%rax        # 2c2008 <prologue_block>
  2c089b:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c089f:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c08a3:	48 01 d0             	add    %rdx,%rax
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  2c08a6:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c08aa:	48 83 fa 0f          	cmp    $0xf,%rdx
  2c08ae:	77 17                	ja     2c08c7 <heap_info+0x45>
  2c08b0:	eb 25                	jmp    2c08d7 <heap_info+0x55>
		if (GET_ALLOC(HDRP(bp)))
			info->num_allocs++;
		bp = NEXT_BLKP(bp);
  2c08b2:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c08b6:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c08ba:	48 01 d0             	add    %rdx,%rax
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  2c08bd:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c08c1:	48 83 fa 0f          	cmp    $0xf,%rdx
  2c08c5:	76 0a                	jbe    2c08d1 <heap_info+0x4f>
		if (GET_ALLOC(HDRP(bp)))
  2c08c7:	f6 c2 01             	test   $0x1,%dl
  2c08ca:	74 e6                	je     2c08b2 <heap_info+0x30>
			info->num_allocs++;
  2c08cc:	83 03 01             	addl   $0x1,(%rbx)
  2c08cf:	eb e1                	jmp    2c08b2 <heap_info+0x30>
	}

	if (info->num_allocs == 0) {
  2c08d1:	8b 03                	mov    (%rbx),%eax
  2c08d3:	85 c0                	test   %eax,%eax
  2c08d5:	75 45                	jne    2c091c <heap_info+0x9a>
		info->size_array = NULL;
  2c08d7:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  2c08de:	00 
		info->ptr_array = NULL;
  2c08df:	48 c7 43 10 00 00 00 	movq   $0x0,0x10(%rbx)
  2c08e6:	00 
			free(info->ptr_array);
			return -1;
		}
	}

	info->free_space = 0;
  2c08e7:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%rbx)
	info->largest_free_chunk = 0;
  2c08ee:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%rbx)

	// iterate through list for free space
	bp = NEXT_BLKP(prologue_block); // because the prologue isn't actually allocated
  2c08f5:	48 8b 05 0c 17 00 00 	mov    0x170c(%rip),%rax        # 2c2008 <prologue_block>
  2c08fc:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c0900:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c0904:	48 01 d0             	add    %rdx,%rax
	size_t arr_index = 0;
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  2c0907:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c090b:	48 83 fa 0f          	cmp    $0xf,%rdx
  2c090f:	0f 86 a3 00 00 00    	jbe    2c09b8 <heap_info+0x136>
	size_t arr_index = 0;
  2c0915:	be 00 00 00 00       	mov    $0x0,%esi
  2c091a:	eb 72                	jmp    2c098e <heap_info+0x10c>
		info->size_array = malloc(info->num_allocs * sizeof(long));
  2c091c:	48 98                	cltq   
  2c091e:	48 8d 3c c5 00 00 00 	lea    0x0(,%rax,8),%rdi
  2c0925:	00 
  2c0926:	e8 56 fc ff ff       	call   2c0581 <malloc>
  2c092b:	48 89 43 08          	mov    %rax,0x8(%rbx)
		if (info->size_array == (void *) -1){
  2c092f:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c0933:	0f 84 c0 00 00 00    	je     2c09f9 <heap_info+0x177>
		info->ptr_array = malloc(info->num_allocs * sizeof(void *));
  2c0939:	48 63 3b             	movslq (%rbx),%rdi
  2c093c:	48 c1 e7 03          	shl    $0x3,%rdi
  2c0940:	e8 3c fc ff ff       	call   2c0581 <malloc>
  2c0945:	48 89 43 10          	mov    %rax,0x10(%rbx)
		if (info->ptr_array == (void *) -1){
  2c0949:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c094d:	75 98                	jne    2c08e7 <heap_info+0x65>
			free(info->ptr_array);
  2c094f:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
  2c0956:	e8 ce fa ff ff       	call   2c0429 <free>
			return -1;
  2c095b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2c0960:	e9 8e 00 00 00       	jmp    2c09f3 <heap_info+0x171>
			info->size_array[arr_index] = GET_SIZE(HDRP(bp));
			info->ptr_array[arr_index] = bp;
			arr_index++;
		}
		else if (!GET_ALLOC(HDRP(bp))) {
			info->free_space += GET_SIZE(HDRP(bp));
  2c0965:	83 e2 f0             	and    $0xfffffff0,%edx
  2c0968:	01 53 18             	add    %edx,0x18(%rbx)
			if ((int)GET_SIZE(HDRP(bp)) > info->largest_free_chunk){
  2c096b:	8b 50 f8             	mov    -0x8(%rax),%edx
  2c096e:	83 e2 f0             	and    $0xfffffff0,%edx
  2c0971:	3b 53 1c             	cmp    0x1c(%rbx),%edx
  2c0974:	7e 03                	jle    2c0979 <heap_info+0xf7>
				info->largest_free_chunk = GET_SIZE(HDRP(bp));
  2c0976:	89 53 1c             	mov    %edx,0x1c(%rbx)
			}
		}
		bp = NEXT_BLKP(bp);
  2c0979:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c097d:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c0981:	48 01 d0             	add    %rdx,%rax
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  2c0984:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c0988:	48 83 fa 0f          	cmp    $0xf,%rdx
  2c098c:	76 2a                	jbe    2c09b8 <heap_info+0x136>
		if (GET_ALLOC(HDRP(bp)) && bp != info->size_array && bp != info->ptr_array){
  2c098e:	f6 c2 01             	test   $0x1,%dl
  2c0991:	74 d2                	je     2c0965 <heap_info+0xe3>
  2c0993:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
  2c0997:	48 39 c1             	cmp    %rax,%rcx
  2c099a:	74 dd                	je     2c0979 <heap_info+0xf7>
  2c099c:	48 39 43 10          	cmp    %rax,0x10(%rbx)
  2c09a0:	74 d7                	je     2c0979 <heap_info+0xf7>
			info->size_array[arr_index] = GET_SIZE(HDRP(bp));
  2c09a2:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c09a6:	48 89 14 f1          	mov    %rdx,(%rcx,%rsi,8)
			info->ptr_array[arr_index] = bp;
  2c09aa:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  2c09ae:	48 89 04 f2          	mov    %rax,(%rdx,%rsi,8)
			arr_index++;
  2c09b2:	48 83 c6 01          	add    $0x1,%rsi
  2c09b6:	eb c1                	jmp    2c0979 <heap_info+0xf7>
	}

	// sort the damn arrays
	heapsort(info->ptr_array, info->num_allocs);
  2c09b8:	48 63 33             	movslq (%rbx),%rsi
  2c09bb:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
  2c09bf:	e8 77 fe ff ff       	call   2c083b <heapsort>
	for (int i = 0; i < info->num_allocs; i++)
  2c09c4:	83 3b 00             	cmpl   $0x0,(%rbx)
  2c09c7:	7e 37                	jle    2c0a00 <heap_info+0x17e>
  2c09c9:	b8 00 00 00 00       	mov    $0x0,%eax
		info->size_array[i] = GET_SIZE(HDRP(info->ptr_array[i]));
  2c09ce:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
  2c09d2:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  2c09d6:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
  2c09da:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  2c09de:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c09e2:	48 89 14 c1          	mov    %rdx,(%rcx,%rax,8)
	for (int i = 0; i < info->num_allocs; i++)
  2c09e6:	48 83 c0 01          	add    $0x1,%rax
  2c09ea:	39 03                	cmp    %eax,(%rbx)
  2c09ec:	7f e0                	jg     2c09ce <heap_info+0x14c>

    return 0;
  2c09ee:	b8 00 00 00 00       	mov    $0x0,%eax
}
  2c09f3:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c09f7:	c9                   	leave  
  2c09f8:	c3                   	ret    
			return -1;
  2c09f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2c09fe:	eb f3                	jmp    2c09f3 <heap_info+0x171>
    return 0;
  2c0a00:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0a05:	eb ec                	jmp    2c09f3 <heap_info+0x171>

00000000002c0a07 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c0a07:	55                   	push   %rbp
  2c0a08:	48 89 e5             	mov    %rsp,%rbp
  2c0a0b:	48 83 ec 28          	sub    $0x28,%rsp
  2c0a0f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0a13:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0a17:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0a1b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0a1f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0a23:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0a27:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c0a2b:	eb 1c                	jmp    2c0a49 <memcpy+0x42>
        *d = *s;
  2c0a2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a31:	0f b6 10             	movzbl (%rax),%edx
  2c0a34:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0a38:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0a3a:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0a3f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0a44:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c0a49:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0a4e:	75 dd                	jne    2c0a2d <memcpy+0x26>
    }
    return dst;
  2c0a50:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0a54:	c9                   	leave  
  2c0a55:	c3                   	ret    

00000000002c0a56 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c0a56:	55                   	push   %rbp
  2c0a57:	48 89 e5             	mov    %rsp,%rbp
  2c0a5a:	48 83 ec 28          	sub    $0x28,%rsp
  2c0a5e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0a62:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0a66:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0a6a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0a6e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c0a72:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0a76:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c0a7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a7e:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c0a82:	73 6a                	jae    2c0aee <memmove+0x98>
  2c0a84:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0a88:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0a8c:	48 01 d0             	add    %rdx,%rax
  2c0a8f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c0a93:	73 59                	jae    2c0aee <memmove+0x98>
        s += n, d += n;
  2c0a95:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0a99:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c0a9d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0aa1:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c0aa5:	eb 17                	jmp    2c0abe <memmove+0x68>
            *--d = *--s;
  2c0aa7:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c0aac:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c0ab1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0ab5:	0f b6 10             	movzbl (%rax),%edx
  2c0ab8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0abc:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0abe:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0ac2:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0ac6:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0aca:	48 85 c0             	test   %rax,%rax
  2c0acd:	75 d8                	jne    2c0aa7 <memmove+0x51>
    if (s < d && s + n > d) {
  2c0acf:	eb 2e                	jmp    2c0aff <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c0ad1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0ad5:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0ad9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0add:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0ae1:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0ae5:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c0ae9:	0f b6 12             	movzbl (%rdx),%edx
  2c0aec:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0aee:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0af2:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0af6:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0afa:	48 85 c0             	test   %rax,%rax
  2c0afd:	75 d2                	jne    2c0ad1 <memmove+0x7b>
        }
    }
    return dst;
  2c0aff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0b03:	c9                   	leave  
  2c0b04:	c3                   	ret    

00000000002c0b05 <memset>:

void* memset(void* v, int c, size_t n) {
  2c0b05:	55                   	push   %rbp
  2c0b06:	48 89 e5             	mov    %rsp,%rbp
  2c0b09:	48 83 ec 28          	sub    $0x28,%rsp
  2c0b0d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0b11:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c0b14:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0b18:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0b1c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0b20:	eb 15                	jmp    2c0b37 <memset+0x32>
        *p = c;
  2c0b22:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0b25:	89 c2                	mov    %eax,%edx
  2c0b27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0b2b:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0b2d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0b32:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0b37:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0b3c:	75 e4                	jne    2c0b22 <memset+0x1d>
    }
    return v;
  2c0b3e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0b42:	c9                   	leave  
  2c0b43:	c3                   	ret    

00000000002c0b44 <strlen>:

size_t strlen(const char* s) {
  2c0b44:	55                   	push   %rbp
  2c0b45:	48 89 e5             	mov    %rsp,%rbp
  2c0b48:	48 83 ec 18          	sub    $0x18,%rsp
  2c0b4c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c0b50:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0b57:	00 
  2c0b58:	eb 0a                	jmp    2c0b64 <strlen+0x20>
        ++n;
  2c0b5a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c0b5f:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0b64:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0b68:	0f b6 00             	movzbl (%rax),%eax
  2c0b6b:	84 c0                	test   %al,%al
  2c0b6d:	75 eb                	jne    2c0b5a <strlen+0x16>
    }
    return n;
  2c0b6f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0b73:	c9                   	leave  
  2c0b74:	c3                   	ret    

00000000002c0b75 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c0b75:	55                   	push   %rbp
  2c0b76:	48 89 e5             	mov    %rsp,%rbp
  2c0b79:	48 83 ec 20          	sub    $0x20,%rsp
  2c0b7d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0b81:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0b85:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0b8c:	00 
  2c0b8d:	eb 0a                	jmp    2c0b99 <strnlen+0x24>
        ++n;
  2c0b8f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0b94:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0b99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0b9d:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c0ba1:	74 0b                	je     2c0bae <strnlen+0x39>
  2c0ba3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0ba7:	0f b6 00             	movzbl (%rax),%eax
  2c0baa:	84 c0                	test   %al,%al
  2c0bac:	75 e1                	jne    2c0b8f <strnlen+0x1a>
    }
    return n;
  2c0bae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0bb2:	c9                   	leave  
  2c0bb3:	c3                   	ret    

00000000002c0bb4 <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c0bb4:	55                   	push   %rbp
  2c0bb5:	48 89 e5             	mov    %rsp,%rbp
  2c0bb8:	48 83 ec 20          	sub    $0x20,%rsp
  2c0bbc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0bc0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c0bc4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0bc8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c0bcc:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c0bd0:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0bd4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c0bd8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0bdc:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0be0:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c0be4:	0f b6 12             	movzbl (%rdx),%edx
  2c0be7:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c0be9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0bed:	48 83 e8 01          	sub    $0x1,%rax
  2c0bf1:	0f b6 00             	movzbl (%rax),%eax
  2c0bf4:	84 c0                	test   %al,%al
  2c0bf6:	75 d4                	jne    2c0bcc <strcpy+0x18>
    return dst;
  2c0bf8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0bfc:	c9                   	leave  
  2c0bfd:	c3                   	ret    

00000000002c0bfe <strcmp>:

int strcmp(const char* a, const char* b) {
  2c0bfe:	55                   	push   %rbp
  2c0bff:	48 89 e5             	mov    %rsp,%rbp
  2c0c02:	48 83 ec 10          	sub    $0x10,%rsp
  2c0c06:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0c0a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0c0e:	eb 0a                	jmp    2c0c1a <strcmp+0x1c>
        ++a, ++b;
  2c0c10:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0c15:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0c1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c1e:	0f b6 00             	movzbl (%rax),%eax
  2c0c21:	84 c0                	test   %al,%al
  2c0c23:	74 1d                	je     2c0c42 <strcmp+0x44>
  2c0c25:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0c29:	0f b6 00             	movzbl (%rax),%eax
  2c0c2c:	84 c0                	test   %al,%al
  2c0c2e:	74 12                	je     2c0c42 <strcmp+0x44>
  2c0c30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c34:	0f b6 10             	movzbl (%rax),%edx
  2c0c37:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0c3b:	0f b6 00             	movzbl (%rax),%eax
  2c0c3e:	38 c2                	cmp    %al,%dl
  2c0c40:	74 ce                	je     2c0c10 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c0c42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c46:	0f b6 00             	movzbl (%rax),%eax
  2c0c49:	89 c2                	mov    %eax,%edx
  2c0c4b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0c4f:	0f b6 00             	movzbl (%rax),%eax
  2c0c52:	38 d0                	cmp    %dl,%al
  2c0c54:	0f 92 c0             	setb   %al
  2c0c57:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c0c5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c5e:	0f b6 00             	movzbl (%rax),%eax
  2c0c61:	89 c1                	mov    %eax,%ecx
  2c0c63:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0c67:	0f b6 00             	movzbl (%rax),%eax
  2c0c6a:	38 c1                	cmp    %al,%cl
  2c0c6c:	0f 92 c0             	setb   %al
  2c0c6f:	0f b6 c0             	movzbl %al,%eax
  2c0c72:	29 c2                	sub    %eax,%edx
  2c0c74:	89 d0                	mov    %edx,%eax
}
  2c0c76:	c9                   	leave  
  2c0c77:	c3                   	ret    

00000000002c0c78 <strchr>:

char* strchr(const char* s, int c) {
  2c0c78:	55                   	push   %rbp
  2c0c79:	48 89 e5             	mov    %rsp,%rbp
  2c0c7c:	48 83 ec 10          	sub    $0x10,%rsp
  2c0c80:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0c84:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c0c87:	eb 05                	jmp    2c0c8e <strchr+0x16>
        ++s;
  2c0c89:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c0c8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c92:	0f b6 00             	movzbl (%rax),%eax
  2c0c95:	84 c0                	test   %al,%al
  2c0c97:	74 0e                	je     2c0ca7 <strchr+0x2f>
  2c0c99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c9d:	0f b6 00             	movzbl (%rax),%eax
  2c0ca0:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0ca3:	38 d0                	cmp    %dl,%al
  2c0ca5:	75 e2                	jne    2c0c89 <strchr+0x11>
    }
    if (*s == (char) c) {
  2c0ca7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0cab:	0f b6 00             	movzbl (%rax),%eax
  2c0cae:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0cb1:	38 d0                	cmp    %dl,%al
  2c0cb3:	75 06                	jne    2c0cbb <strchr+0x43>
        return (char*) s;
  2c0cb5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0cb9:	eb 05                	jmp    2c0cc0 <strchr+0x48>
    } else {
        return NULL;
  2c0cbb:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c0cc0:	c9                   	leave  
  2c0cc1:	c3                   	ret    

00000000002c0cc2 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c0cc2:	55                   	push   %rbp
  2c0cc3:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c0cc6:	8b 05 54 13 00 00    	mov    0x1354(%rip),%eax        # 2c2020 <rand_seed_set>
  2c0ccc:	85 c0                	test   %eax,%eax
  2c0cce:	75 0a                	jne    2c0cda <rand+0x18>
        srand(819234718U);
  2c0cd0:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c0cd5:	e8 24 00 00 00       	call   2c0cfe <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c0cda:	8b 05 44 13 00 00    	mov    0x1344(%rip),%eax        # 2c2024 <rand_seed>
  2c0ce0:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c0ce6:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c0ceb:	89 05 33 13 00 00    	mov    %eax,0x1333(%rip)        # 2c2024 <rand_seed>
    return rand_seed & RAND_MAX;
  2c0cf1:	8b 05 2d 13 00 00    	mov    0x132d(%rip),%eax        # 2c2024 <rand_seed>
  2c0cf7:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c0cfc:	5d                   	pop    %rbp
  2c0cfd:	c3                   	ret    

00000000002c0cfe <srand>:

void srand(unsigned seed) {
  2c0cfe:	55                   	push   %rbp
  2c0cff:	48 89 e5             	mov    %rsp,%rbp
  2c0d02:	48 83 ec 08          	sub    $0x8,%rsp
  2c0d06:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c0d09:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c0d0c:	89 05 12 13 00 00    	mov    %eax,0x1312(%rip)        # 2c2024 <rand_seed>
    rand_seed_set = 1;
  2c0d12:	c7 05 04 13 00 00 01 	movl   $0x1,0x1304(%rip)        # 2c2020 <rand_seed_set>
  2c0d19:	00 00 00 
}
  2c0d1c:	90                   	nop
  2c0d1d:	c9                   	leave  
  2c0d1e:	c3                   	ret    

00000000002c0d1f <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c0d1f:	55                   	push   %rbp
  2c0d20:	48 89 e5             	mov    %rsp,%rbp
  2c0d23:	48 83 ec 28          	sub    $0x28,%rsp
  2c0d27:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0d2b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0d2f:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c0d32:	48 c7 45 f8 80 1d 2c 	movq   $0x2c1d80,-0x8(%rbp)
  2c0d39:	00 
    if (base < 0) {
  2c0d3a:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c0d3e:	79 0b                	jns    2c0d4b <fill_numbuf+0x2c>
        digits = lower_digits;
  2c0d40:	48 c7 45 f8 a0 1d 2c 	movq   $0x2c1da0,-0x8(%rbp)
  2c0d47:	00 
        base = -base;
  2c0d48:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c0d4b:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0d50:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0d54:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c0d57:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0d5a:	48 63 c8             	movslq %eax,%rcx
  2c0d5d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0d61:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0d66:	48 f7 f1             	div    %rcx
  2c0d69:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0d6d:	48 01 d0             	add    %rdx,%rax
  2c0d70:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0d75:	0f b6 10             	movzbl (%rax),%edx
  2c0d78:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0d7c:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c0d7e:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0d81:	48 63 f0             	movslq %eax,%rsi
  2c0d84:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0d88:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0d8d:	48 f7 f6             	div    %rsi
  2c0d90:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c0d94:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c0d99:	75 bc                	jne    2c0d57 <fill_numbuf+0x38>
    return numbuf_end;
  2c0d9b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0d9f:	c9                   	leave  
  2c0da0:	c3                   	ret    

00000000002c0da1 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c0da1:	55                   	push   %rbp
  2c0da2:	48 89 e5             	mov    %rsp,%rbp
  2c0da5:	53                   	push   %rbx
  2c0da6:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c0dad:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c0db4:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c0dba:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0dc1:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c0dc8:	e9 8a 09 00 00       	jmp    2c1757 <printer_vprintf+0x9b6>
        if (*format != '%') {
  2c0dcd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0dd4:	0f b6 00             	movzbl (%rax),%eax
  2c0dd7:	3c 25                	cmp    $0x25,%al
  2c0dd9:	74 31                	je     2c0e0c <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  2c0ddb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0de2:	4c 8b 00             	mov    (%rax),%r8
  2c0de5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0dec:	0f b6 00             	movzbl (%rax),%eax
  2c0def:	0f b6 c8             	movzbl %al,%ecx
  2c0df2:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c0df8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0dff:	89 ce                	mov    %ecx,%esi
  2c0e01:	48 89 c7             	mov    %rax,%rdi
  2c0e04:	41 ff d0             	call   *%r8
            continue;
  2c0e07:	e9 43 09 00 00       	jmp    2c174f <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  2c0e0c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0e13:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0e1a:	01 
  2c0e1b:	eb 44                	jmp    2c0e61 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  2c0e1d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e24:	0f b6 00             	movzbl (%rax),%eax
  2c0e27:	0f be c0             	movsbl %al,%eax
  2c0e2a:	89 c6                	mov    %eax,%esi
  2c0e2c:	bf a0 1b 2c 00       	mov    $0x2c1ba0,%edi
  2c0e31:	e8 42 fe ff ff       	call   2c0c78 <strchr>
  2c0e36:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c0e3a:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c0e3f:	74 30                	je     2c0e71 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  2c0e41:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c0e45:	48 2d a0 1b 2c 00    	sub    $0x2c1ba0,%rax
  2c0e4b:	ba 01 00 00 00       	mov    $0x1,%edx
  2c0e50:	89 c1                	mov    %eax,%ecx
  2c0e52:	d3 e2                	shl    %cl,%edx
  2c0e54:	89 d0                	mov    %edx,%eax
  2c0e56:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0e59:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0e60:	01 
  2c0e61:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e68:	0f b6 00             	movzbl (%rax),%eax
  2c0e6b:	84 c0                	test   %al,%al
  2c0e6d:	75 ae                	jne    2c0e1d <printer_vprintf+0x7c>
  2c0e6f:	eb 01                	jmp    2c0e72 <printer_vprintf+0xd1>
            } else {
                break;
  2c0e71:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c0e72:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c0e79:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e80:	0f b6 00             	movzbl (%rax),%eax
  2c0e83:	3c 30                	cmp    $0x30,%al
  2c0e85:	7e 67                	jle    2c0eee <printer_vprintf+0x14d>
  2c0e87:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e8e:	0f b6 00             	movzbl (%rax),%eax
  2c0e91:	3c 39                	cmp    $0x39,%al
  2c0e93:	7f 59                	jg     2c0eee <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0e95:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c0e9c:	eb 2e                	jmp    2c0ecc <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  2c0e9e:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c0ea1:	89 d0                	mov    %edx,%eax
  2c0ea3:	c1 e0 02             	shl    $0x2,%eax
  2c0ea6:	01 d0                	add    %edx,%eax
  2c0ea8:	01 c0                	add    %eax,%eax
  2c0eaa:	89 c1                	mov    %eax,%ecx
  2c0eac:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0eb3:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0eb7:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0ebe:	0f b6 00             	movzbl (%rax),%eax
  2c0ec1:	0f be c0             	movsbl %al,%eax
  2c0ec4:	01 c8                	add    %ecx,%eax
  2c0ec6:	83 e8 30             	sub    $0x30,%eax
  2c0ec9:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0ecc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ed3:	0f b6 00             	movzbl (%rax),%eax
  2c0ed6:	3c 2f                	cmp    $0x2f,%al
  2c0ed8:	0f 8e 85 00 00 00    	jle    2c0f63 <printer_vprintf+0x1c2>
  2c0ede:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ee5:	0f b6 00             	movzbl (%rax),%eax
  2c0ee8:	3c 39                	cmp    $0x39,%al
  2c0eea:	7e b2                	jle    2c0e9e <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  2c0eec:	eb 75                	jmp    2c0f63 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  2c0eee:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ef5:	0f b6 00             	movzbl (%rax),%eax
  2c0ef8:	3c 2a                	cmp    $0x2a,%al
  2c0efa:	75 68                	jne    2c0f64 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  2c0efc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f03:	8b 00                	mov    (%rax),%eax
  2c0f05:	83 f8 2f             	cmp    $0x2f,%eax
  2c0f08:	77 30                	ja     2c0f3a <printer_vprintf+0x199>
  2c0f0a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f11:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0f15:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f1c:	8b 00                	mov    (%rax),%eax
  2c0f1e:	89 c0                	mov    %eax,%eax
  2c0f20:	48 01 d0             	add    %rdx,%rax
  2c0f23:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f2a:	8b 12                	mov    (%rdx),%edx
  2c0f2c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0f2f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f36:	89 0a                	mov    %ecx,(%rdx)
  2c0f38:	eb 1a                	jmp    2c0f54 <printer_vprintf+0x1b3>
  2c0f3a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f41:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0f45:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0f49:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f50:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0f54:	8b 00                	mov    (%rax),%eax
  2c0f56:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c0f59:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0f60:	01 
  2c0f61:	eb 01                	jmp    2c0f64 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  2c0f63:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c0f64:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c0f6b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0f72:	0f b6 00             	movzbl (%rax),%eax
  2c0f75:	3c 2e                	cmp    $0x2e,%al
  2c0f77:	0f 85 00 01 00 00    	jne    2c107d <printer_vprintf+0x2dc>
            ++format;
  2c0f7d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0f84:	01 
            if (*format >= '0' && *format <= '9') {
  2c0f85:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0f8c:	0f b6 00             	movzbl (%rax),%eax
  2c0f8f:	3c 2f                	cmp    $0x2f,%al
  2c0f91:	7e 67                	jle    2c0ffa <printer_vprintf+0x259>
  2c0f93:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0f9a:	0f b6 00             	movzbl (%rax),%eax
  2c0f9d:	3c 39                	cmp    $0x39,%al
  2c0f9f:	7f 59                	jg     2c0ffa <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0fa1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c0fa8:	eb 2e                	jmp    2c0fd8 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  2c0faa:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c0fad:	89 d0                	mov    %edx,%eax
  2c0faf:	c1 e0 02             	shl    $0x2,%eax
  2c0fb2:	01 d0                	add    %edx,%eax
  2c0fb4:	01 c0                	add    %eax,%eax
  2c0fb6:	89 c1                	mov    %eax,%ecx
  2c0fb8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0fbf:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0fc3:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0fca:	0f b6 00             	movzbl (%rax),%eax
  2c0fcd:	0f be c0             	movsbl %al,%eax
  2c0fd0:	01 c8                	add    %ecx,%eax
  2c0fd2:	83 e8 30             	sub    $0x30,%eax
  2c0fd5:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0fd8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0fdf:	0f b6 00             	movzbl (%rax),%eax
  2c0fe2:	3c 2f                	cmp    $0x2f,%al
  2c0fe4:	0f 8e 85 00 00 00    	jle    2c106f <printer_vprintf+0x2ce>
  2c0fea:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ff1:	0f b6 00             	movzbl (%rax),%eax
  2c0ff4:	3c 39                	cmp    $0x39,%al
  2c0ff6:	7e b2                	jle    2c0faa <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  2c0ff8:	eb 75                	jmp    2c106f <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  2c0ffa:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1001:	0f b6 00             	movzbl (%rax),%eax
  2c1004:	3c 2a                	cmp    $0x2a,%al
  2c1006:	75 68                	jne    2c1070 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  2c1008:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c100f:	8b 00                	mov    (%rax),%eax
  2c1011:	83 f8 2f             	cmp    $0x2f,%eax
  2c1014:	77 30                	ja     2c1046 <printer_vprintf+0x2a5>
  2c1016:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c101d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1021:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1028:	8b 00                	mov    (%rax),%eax
  2c102a:	89 c0                	mov    %eax,%eax
  2c102c:	48 01 d0             	add    %rdx,%rax
  2c102f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1036:	8b 12                	mov    (%rdx),%edx
  2c1038:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c103b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1042:	89 0a                	mov    %ecx,(%rdx)
  2c1044:	eb 1a                	jmp    2c1060 <printer_vprintf+0x2bf>
  2c1046:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c104d:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1051:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1055:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c105c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1060:	8b 00                	mov    (%rax),%eax
  2c1062:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c1065:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c106c:	01 
  2c106d:	eb 01                	jmp    2c1070 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  2c106f:	90                   	nop
            }
            if (precision < 0) {
  2c1070:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c1074:	79 07                	jns    2c107d <printer_vprintf+0x2dc>
                precision = 0;
  2c1076:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c107d:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c1084:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c108b:	00 
        int length = 0;
  2c108c:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c1093:	48 c7 45 c8 a6 1b 2c 	movq   $0x2c1ba6,-0x38(%rbp)
  2c109a:	00 
    again:
        switch (*format) {
  2c109b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c10a2:	0f b6 00             	movzbl (%rax),%eax
  2c10a5:	0f be c0             	movsbl %al,%eax
  2c10a8:	83 e8 43             	sub    $0x43,%eax
  2c10ab:	83 f8 37             	cmp    $0x37,%eax
  2c10ae:	0f 87 9f 03 00 00    	ja     2c1453 <printer_vprintf+0x6b2>
  2c10b4:	89 c0                	mov    %eax,%eax
  2c10b6:	48 8b 04 c5 b8 1b 2c 	mov    0x2c1bb8(,%rax,8),%rax
  2c10bd:	00 
  2c10be:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  2c10c0:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c10c7:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c10ce:	01 
            goto again;
  2c10cf:	eb ca                	jmp    2c109b <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c10d1:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c10d5:	74 5d                	je     2c1134 <printer_vprintf+0x393>
  2c10d7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10de:	8b 00                	mov    (%rax),%eax
  2c10e0:	83 f8 2f             	cmp    $0x2f,%eax
  2c10e3:	77 30                	ja     2c1115 <printer_vprintf+0x374>
  2c10e5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10ec:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c10f0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10f7:	8b 00                	mov    (%rax),%eax
  2c10f9:	89 c0                	mov    %eax,%eax
  2c10fb:	48 01 d0             	add    %rdx,%rax
  2c10fe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1105:	8b 12                	mov    (%rdx),%edx
  2c1107:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c110a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1111:	89 0a                	mov    %ecx,(%rdx)
  2c1113:	eb 1a                	jmp    2c112f <printer_vprintf+0x38e>
  2c1115:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c111c:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1120:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1124:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c112b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c112f:	48 8b 00             	mov    (%rax),%rax
  2c1132:	eb 5c                	jmp    2c1190 <printer_vprintf+0x3ef>
  2c1134:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c113b:	8b 00                	mov    (%rax),%eax
  2c113d:	83 f8 2f             	cmp    $0x2f,%eax
  2c1140:	77 30                	ja     2c1172 <printer_vprintf+0x3d1>
  2c1142:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1149:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c114d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1154:	8b 00                	mov    (%rax),%eax
  2c1156:	89 c0                	mov    %eax,%eax
  2c1158:	48 01 d0             	add    %rdx,%rax
  2c115b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1162:	8b 12                	mov    (%rdx),%edx
  2c1164:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1167:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c116e:	89 0a                	mov    %ecx,(%rdx)
  2c1170:	eb 1a                	jmp    2c118c <printer_vprintf+0x3eb>
  2c1172:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1179:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c117d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1181:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1188:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c118c:	8b 00                	mov    (%rax),%eax
  2c118e:	48 98                	cltq   
  2c1190:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c1194:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1198:	48 c1 f8 38          	sar    $0x38,%rax
  2c119c:	25 80 00 00 00       	and    $0x80,%eax
  2c11a1:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c11a4:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c11a8:	74 09                	je     2c11b3 <printer_vprintf+0x412>
  2c11aa:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c11ae:	48 f7 d8             	neg    %rax
  2c11b1:	eb 04                	jmp    2c11b7 <printer_vprintf+0x416>
  2c11b3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c11b7:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c11bb:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c11be:	83 c8 60             	or     $0x60,%eax
  2c11c1:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c11c4:	e9 cf 02 00 00       	jmp    2c1498 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c11c9:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c11cd:	74 5d                	je     2c122c <printer_vprintf+0x48b>
  2c11cf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11d6:	8b 00                	mov    (%rax),%eax
  2c11d8:	83 f8 2f             	cmp    $0x2f,%eax
  2c11db:	77 30                	ja     2c120d <printer_vprintf+0x46c>
  2c11dd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11e4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c11e8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11ef:	8b 00                	mov    (%rax),%eax
  2c11f1:	89 c0                	mov    %eax,%eax
  2c11f3:	48 01 d0             	add    %rdx,%rax
  2c11f6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c11fd:	8b 12                	mov    (%rdx),%edx
  2c11ff:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1202:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1209:	89 0a                	mov    %ecx,(%rdx)
  2c120b:	eb 1a                	jmp    2c1227 <printer_vprintf+0x486>
  2c120d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1214:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1218:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c121c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1223:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1227:	48 8b 00             	mov    (%rax),%rax
  2c122a:	eb 5c                	jmp    2c1288 <printer_vprintf+0x4e7>
  2c122c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1233:	8b 00                	mov    (%rax),%eax
  2c1235:	83 f8 2f             	cmp    $0x2f,%eax
  2c1238:	77 30                	ja     2c126a <printer_vprintf+0x4c9>
  2c123a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1241:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1245:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c124c:	8b 00                	mov    (%rax),%eax
  2c124e:	89 c0                	mov    %eax,%eax
  2c1250:	48 01 d0             	add    %rdx,%rax
  2c1253:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c125a:	8b 12                	mov    (%rdx),%edx
  2c125c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c125f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1266:	89 0a                	mov    %ecx,(%rdx)
  2c1268:	eb 1a                	jmp    2c1284 <printer_vprintf+0x4e3>
  2c126a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1271:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1275:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1279:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1280:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1284:	8b 00                	mov    (%rax),%eax
  2c1286:	89 c0                	mov    %eax,%eax
  2c1288:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c128c:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c1290:	e9 03 02 00 00       	jmp    2c1498 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  2c1295:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c129c:	e9 28 ff ff ff       	jmp    2c11c9 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  2c12a1:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c12a8:	e9 1c ff ff ff       	jmp    2c11c9 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c12ad:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c12b4:	8b 00                	mov    (%rax),%eax
  2c12b6:	83 f8 2f             	cmp    $0x2f,%eax
  2c12b9:	77 30                	ja     2c12eb <printer_vprintf+0x54a>
  2c12bb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c12c2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c12c6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c12cd:	8b 00                	mov    (%rax),%eax
  2c12cf:	89 c0                	mov    %eax,%eax
  2c12d1:	48 01 d0             	add    %rdx,%rax
  2c12d4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c12db:	8b 12                	mov    (%rdx),%edx
  2c12dd:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c12e0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c12e7:	89 0a                	mov    %ecx,(%rdx)
  2c12e9:	eb 1a                	jmp    2c1305 <printer_vprintf+0x564>
  2c12eb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c12f2:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c12f6:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c12fa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1301:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1305:	48 8b 00             	mov    (%rax),%rax
  2c1308:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c130c:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c1313:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c131a:	e9 79 01 00 00       	jmp    2c1498 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  2c131f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1326:	8b 00                	mov    (%rax),%eax
  2c1328:	83 f8 2f             	cmp    $0x2f,%eax
  2c132b:	77 30                	ja     2c135d <printer_vprintf+0x5bc>
  2c132d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1334:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1338:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c133f:	8b 00                	mov    (%rax),%eax
  2c1341:	89 c0                	mov    %eax,%eax
  2c1343:	48 01 d0             	add    %rdx,%rax
  2c1346:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c134d:	8b 12                	mov    (%rdx),%edx
  2c134f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1352:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1359:	89 0a                	mov    %ecx,(%rdx)
  2c135b:	eb 1a                	jmp    2c1377 <printer_vprintf+0x5d6>
  2c135d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1364:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1368:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c136c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1373:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1377:	48 8b 00             	mov    (%rax),%rax
  2c137a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c137e:	e9 15 01 00 00       	jmp    2c1498 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  2c1383:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c138a:	8b 00                	mov    (%rax),%eax
  2c138c:	83 f8 2f             	cmp    $0x2f,%eax
  2c138f:	77 30                	ja     2c13c1 <printer_vprintf+0x620>
  2c1391:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1398:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c139c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13a3:	8b 00                	mov    (%rax),%eax
  2c13a5:	89 c0                	mov    %eax,%eax
  2c13a7:	48 01 d0             	add    %rdx,%rax
  2c13aa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c13b1:	8b 12                	mov    (%rdx),%edx
  2c13b3:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c13b6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c13bd:	89 0a                	mov    %ecx,(%rdx)
  2c13bf:	eb 1a                	jmp    2c13db <printer_vprintf+0x63a>
  2c13c1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13c8:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c13cc:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c13d0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c13d7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c13db:	8b 00                	mov    (%rax),%eax
  2c13dd:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c13e3:	e9 67 03 00 00       	jmp    2c174f <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  2c13e8:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c13ec:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c13f0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13f7:	8b 00                	mov    (%rax),%eax
  2c13f9:	83 f8 2f             	cmp    $0x2f,%eax
  2c13fc:	77 30                	ja     2c142e <printer_vprintf+0x68d>
  2c13fe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1405:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1409:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1410:	8b 00                	mov    (%rax),%eax
  2c1412:	89 c0                	mov    %eax,%eax
  2c1414:	48 01 d0             	add    %rdx,%rax
  2c1417:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c141e:	8b 12                	mov    (%rdx),%edx
  2c1420:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1423:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c142a:	89 0a                	mov    %ecx,(%rdx)
  2c142c:	eb 1a                	jmp    2c1448 <printer_vprintf+0x6a7>
  2c142e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1435:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1439:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c143d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1444:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1448:	8b 00                	mov    (%rax),%eax
  2c144a:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c144d:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c1451:	eb 45                	jmp    2c1498 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  2c1453:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c1457:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c145b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1462:	0f b6 00             	movzbl (%rax),%eax
  2c1465:	84 c0                	test   %al,%al
  2c1467:	74 0c                	je     2c1475 <printer_vprintf+0x6d4>
  2c1469:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1470:	0f b6 00             	movzbl (%rax),%eax
  2c1473:	eb 05                	jmp    2c147a <printer_vprintf+0x6d9>
  2c1475:	b8 25 00 00 00       	mov    $0x25,%eax
  2c147a:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c147d:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c1481:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1488:	0f b6 00             	movzbl (%rax),%eax
  2c148b:	84 c0                	test   %al,%al
  2c148d:	75 08                	jne    2c1497 <printer_vprintf+0x6f6>
                format--;
  2c148f:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c1496:	01 
            }
            break;
  2c1497:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c1498:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c149b:	83 e0 20             	and    $0x20,%eax
  2c149e:	85 c0                	test   %eax,%eax
  2c14a0:	74 1e                	je     2c14c0 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c14a2:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c14a6:	48 83 c0 18          	add    $0x18,%rax
  2c14aa:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c14ad:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c14b1:	48 89 ce             	mov    %rcx,%rsi
  2c14b4:	48 89 c7             	mov    %rax,%rdi
  2c14b7:	e8 63 f8 ff ff       	call   2c0d1f <fill_numbuf>
  2c14bc:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c14c0:	48 c7 45 c0 a6 1b 2c 	movq   $0x2c1ba6,-0x40(%rbp)
  2c14c7:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c14c8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c14cb:	83 e0 20             	and    $0x20,%eax
  2c14ce:	85 c0                	test   %eax,%eax
  2c14d0:	74 48                	je     2c151a <printer_vprintf+0x779>
  2c14d2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c14d5:	83 e0 40             	and    $0x40,%eax
  2c14d8:	85 c0                	test   %eax,%eax
  2c14da:	74 3e                	je     2c151a <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  2c14dc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c14df:	25 80 00 00 00       	and    $0x80,%eax
  2c14e4:	85 c0                	test   %eax,%eax
  2c14e6:	74 0a                	je     2c14f2 <printer_vprintf+0x751>
                prefix = "-";
  2c14e8:	48 c7 45 c0 a7 1b 2c 	movq   $0x2c1ba7,-0x40(%rbp)
  2c14ef:	00 
            if (flags & FLAG_NEGATIVE) {
  2c14f0:	eb 73                	jmp    2c1565 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c14f2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c14f5:	83 e0 10             	and    $0x10,%eax
  2c14f8:	85 c0                	test   %eax,%eax
  2c14fa:	74 0a                	je     2c1506 <printer_vprintf+0x765>
                prefix = "+";
  2c14fc:	48 c7 45 c0 a9 1b 2c 	movq   $0x2c1ba9,-0x40(%rbp)
  2c1503:	00 
            if (flags & FLAG_NEGATIVE) {
  2c1504:	eb 5f                	jmp    2c1565 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c1506:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1509:	83 e0 08             	and    $0x8,%eax
  2c150c:	85 c0                	test   %eax,%eax
  2c150e:	74 55                	je     2c1565 <printer_vprintf+0x7c4>
                prefix = " ";
  2c1510:	48 c7 45 c0 ab 1b 2c 	movq   $0x2c1bab,-0x40(%rbp)
  2c1517:	00 
            if (flags & FLAG_NEGATIVE) {
  2c1518:	eb 4b                	jmp    2c1565 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c151a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c151d:	83 e0 20             	and    $0x20,%eax
  2c1520:	85 c0                	test   %eax,%eax
  2c1522:	74 42                	je     2c1566 <printer_vprintf+0x7c5>
  2c1524:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1527:	83 e0 01             	and    $0x1,%eax
  2c152a:	85 c0                	test   %eax,%eax
  2c152c:	74 38                	je     2c1566 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  2c152e:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c1532:	74 06                	je     2c153a <printer_vprintf+0x799>
  2c1534:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c1538:	75 2c                	jne    2c1566 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  2c153a:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c153f:	75 0c                	jne    2c154d <printer_vprintf+0x7ac>
  2c1541:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1544:	25 00 01 00 00       	and    $0x100,%eax
  2c1549:	85 c0                	test   %eax,%eax
  2c154b:	74 19                	je     2c1566 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  2c154d:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c1551:	75 07                	jne    2c155a <printer_vprintf+0x7b9>
  2c1553:	b8 ad 1b 2c 00       	mov    $0x2c1bad,%eax
  2c1558:	eb 05                	jmp    2c155f <printer_vprintf+0x7be>
  2c155a:	b8 b0 1b 2c 00       	mov    $0x2c1bb0,%eax
  2c155f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c1563:	eb 01                	jmp    2c1566 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  2c1565:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c1566:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c156a:	78 24                	js     2c1590 <printer_vprintf+0x7ef>
  2c156c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c156f:	83 e0 20             	and    $0x20,%eax
  2c1572:	85 c0                	test   %eax,%eax
  2c1574:	75 1a                	jne    2c1590 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  2c1576:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1579:	48 63 d0             	movslq %eax,%rdx
  2c157c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1580:	48 89 d6             	mov    %rdx,%rsi
  2c1583:	48 89 c7             	mov    %rax,%rdi
  2c1586:	e8 ea f5 ff ff       	call   2c0b75 <strnlen>
  2c158b:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c158e:	eb 0f                	jmp    2c159f <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  2c1590:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1594:	48 89 c7             	mov    %rax,%rdi
  2c1597:	e8 a8 f5 ff ff       	call   2c0b44 <strlen>
  2c159c:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c159f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c15a2:	83 e0 20             	and    $0x20,%eax
  2c15a5:	85 c0                	test   %eax,%eax
  2c15a7:	74 20                	je     2c15c9 <printer_vprintf+0x828>
  2c15a9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c15ad:	78 1a                	js     2c15c9 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  2c15af:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c15b2:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c15b5:	7e 08                	jle    2c15bf <printer_vprintf+0x81e>
  2c15b7:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c15ba:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c15bd:	eb 05                	jmp    2c15c4 <printer_vprintf+0x823>
  2c15bf:	b8 00 00 00 00       	mov    $0x0,%eax
  2c15c4:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c15c7:	eb 5c                	jmp    2c1625 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c15c9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c15cc:	83 e0 20             	and    $0x20,%eax
  2c15cf:	85 c0                	test   %eax,%eax
  2c15d1:	74 4b                	je     2c161e <printer_vprintf+0x87d>
  2c15d3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c15d6:	83 e0 02             	and    $0x2,%eax
  2c15d9:	85 c0                	test   %eax,%eax
  2c15db:	74 41                	je     2c161e <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c15dd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c15e0:	83 e0 04             	and    $0x4,%eax
  2c15e3:	85 c0                	test   %eax,%eax
  2c15e5:	75 37                	jne    2c161e <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  2c15e7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c15eb:	48 89 c7             	mov    %rax,%rdi
  2c15ee:	e8 51 f5 ff ff       	call   2c0b44 <strlen>
  2c15f3:	89 c2                	mov    %eax,%edx
  2c15f5:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c15f8:	01 d0                	add    %edx,%eax
  2c15fa:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c15fd:	7e 1f                	jle    2c161e <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  2c15ff:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c1602:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c1605:	89 c3                	mov    %eax,%ebx
  2c1607:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c160b:	48 89 c7             	mov    %rax,%rdi
  2c160e:	e8 31 f5 ff ff       	call   2c0b44 <strlen>
  2c1613:	89 c2                	mov    %eax,%edx
  2c1615:	89 d8                	mov    %ebx,%eax
  2c1617:	29 d0                	sub    %edx,%eax
  2c1619:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c161c:	eb 07                	jmp    2c1625 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  2c161e:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c1625:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c1628:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c162b:	01 d0                	add    %edx,%eax
  2c162d:	48 63 d8             	movslq %eax,%rbx
  2c1630:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1634:	48 89 c7             	mov    %rax,%rdi
  2c1637:	e8 08 f5 ff ff       	call   2c0b44 <strlen>
  2c163c:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c1640:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c1643:	29 d0                	sub    %edx,%eax
  2c1645:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c1648:	eb 25                	jmp    2c166f <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  2c164a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1651:	48 8b 08             	mov    (%rax),%rcx
  2c1654:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c165a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1661:	be 20 00 00 00       	mov    $0x20,%esi
  2c1666:	48 89 c7             	mov    %rax,%rdi
  2c1669:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c166b:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c166f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1672:	83 e0 04             	and    $0x4,%eax
  2c1675:	85 c0                	test   %eax,%eax
  2c1677:	75 36                	jne    2c16af <printer_vprintf+0x90e>
  2c1679:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c167d:	7f cb                	jg     2c164a <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  2c167f:	eb 2e                	jmp    2c16af <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  2c1681:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1688:	4c 8b 00             	mov    (%rax),%r8
  2c168b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c168f:	0f b6 00             	movzbl (%rax),%eax
  2c1692:	0f b6 c8             	movzbl %al,%ecx
  2c1695:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c169b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c16a2:	89 ce                	mov    %ecx,%esi
  2c16a4:	48 89 c7             	mov    %rax,%rdi
  2c16a7:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c16aa:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c16af:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c16b3:	0f b6 00             	movzbl (%rax),%eax
  2c16b6:	84 c0                	test   %al,%al
  2c16b8:	75 c7                	jne    2c1681 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  2c16ba:	eb 25                	jmp    2c16e1 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  2c16bc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c16c3:	48 8b 08             	mov    (%rax),%rcx
  2c16c6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c16cc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c16d3:	be 30 00 00 00       	mov    $0x30,%esi
  2c16d8:	48 89 c7             	mov    %rax,%rdi
  2c16db:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c16dd:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c16e1:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c16e5:	7f d5                	jg     2c16bc <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  2c16e7:	eb 32                	jmp    2c171b <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  2c16e9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c16f0:	4c 8b 00             	mov    (%rax),%r8
  2c16f3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c16f7:	0f b6 00             	movzbl (%rax),%eax
  2c16fa:	0f b6 c8             	movzbl %al,%ecx
  2c16fd:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1703:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c170a:	89 ce                	mov    %ecx,%esi
  2c170c:	48 89 c7             	mov    %rax,%rdi
  2c170f:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c1712:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c1717:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c171b:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c171f:	7f c8                	jg     2c16e9 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  2c1721:	eb 25                	jmp    2c1748 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  2c1723:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c172a:	48 8b 08             	mov    (%rax),%rcx
  2c172d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1733:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c173a:	be 20 00 00 00       	mov    $0x20,%esi
  2c173f:	48 89 c7             	mov    %rax,%rdi
  2c1742:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c1744:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c1748:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c174c:	7f d5                	jg     2c1723 <printer_vprintf+0x982>
        }
    done: ;
  2c174e:	90                   	nop
    for (; *format; ++format) {
  2c174f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c1756:	01 
  2c1757:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c175e:	0f b6 00             	movzbl (%rax),%eax
  2c1761:	84 c0                	test   %al,%al
  2c1763:	0f 85 64 f6 ff ff    	jne    2c0dcd <printer_vprintf+0x2c>
    }
}
  2c1769:	90                   	nop
  2c176a:	90                   	nop
  2c176b:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c176f:	c9                   	leave  
  2c1770:	c3                   	ret    

00000000002c1771 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c1771:	55                   	push   %rbp
  2c1772:	48 89 e5             	mov    %rsp,%rbp
  2c1775:	48 83 ec 20          	sub    $0x20,%rsp
  2c1779:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c177d:	89 f0                	mov    %esi,%eax
  2c177f:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1782:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c1785:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1789:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c178d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1791:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1795:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  2c179a:	48 39 d0             	cmp    %rdx,%rax
  2c179d:	72 0c                	jb     2c17ab <console_putc+0x3a>
        cp->cursor = console;
  2c179f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c17a3:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  2c17aa:	00 
    }
    if (c == '\n') {
  2c17ab:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c17af:	75 78                	jne    2c1829 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  2c17b1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c17b5:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c17b9:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c17bf:	48 d1 f8             	sar    %rax
  2c17c2:	48 89 c1             	mov    %rax,%rcx
  2c17c5:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c17cc:	66 66 66 
  2c17cf:	48 89 c8             	mov    %rcx,%rax
  2c17d2:	48 f7 ea             	imul   %rdx
  2c17d5:	48 c1 fa 05          	sar    $0x5,%rdx
  2c17d9:	48 89 c8             	mov    %rcx,%rax
  2c17dc:	48 c1 f8 3f          	sar    $0x3f,%rax
  2c17e0:	48 29 c2             	sub    %rax,%rdx
  2c17e3:	48 89 d0             	mov    %rdx,%rax
  2c17e6:	48 c1 e0 02          	shl    $0x2,%rax
  2c17ea:	48 01 d0             	add    %rdx,%rax
  2c17ed:	48 c1 e0 04          	shl    $0x4,%rax
  2c17f1:	48 29 c1             	sub    %rax,%rcx
  2c17f4:	48 89 ca             	mov    %rcx,%rdx
  2c17f7:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c17fa:	eb 25                	jmp    2c1821 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  2c17fc:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c17ff:	83 c8 20             	or     $0x20,%eax
  2c1802:	89 c6                	mov    %eax,%esi
  2c1804:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1808:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c180c:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1810:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c1814:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1818:	89 f2                	mov    %esi,%edx
  2c181a:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c181d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1821:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c1825:	75 d5                	jne    2c17fc <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c1827:	eb 24                	jmp    2c184d <console_putc+0xdc>
        *cp->cursor++ = c | color;
  2c1829:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  2c182d:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c1830:	09 d0                	or     %edx,%eax
  2c1832:	89 c6                	mov    %eax,%esi
  2c1834:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1838:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c183c:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1840:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c1844:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1848:	89 f2                	mov    %esi,%edx
  2c184a:	66 89 10             	mov    %dx,(%rax)
}
  2c184d:	90                   	nop
  2c184e:	c9                   	leave  
  2c184f:	c3                   	ret    

00000000002c1850 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c1850:	55                   	push   %rbp
  2c1851:	48 89 e5             	mov    %rsp,%rbp
  2c1854:	48 83 ec 30          	sub    $0x30,%rsp
  2c1858:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c185b:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c185e:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c1862:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c1866:	48 c7 45 f0 71 17 2c 	movq   $0x2c1771,-0x10(%rbp)
  2c186d:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c186e:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c1872:	78 09                	js     2c187d <console_vprintf+0x2d>
  2c1874:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c187b:	7e 07                	jle    2c1884 <console_vprintf+0x34>
        cpos = 0;
  2c187d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c1884:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1887:	48 98                	cltq   
  2c1889:	48 01 c0             	add    %rax,%rax
  2c188c:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  2c1892:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c1896:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c189a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c189e:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c18a1:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c18a5:	48 89 c7             	mov    %rax,%rdi
  2c18a8:	e8 f4 f4 ff ff       	call   2c0da1 <printer_vprintf>
    return cp.cursor - console;
  2c18ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c18b1:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c18b7:	48 d1 f8             	sar    %rax
}
  2c18ba:	c9                   	leave  
  2c18bb:	c3                   	ret    

00000000002c18bc <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c18bc:	55                   	push   %rbp
  2c18bd:	48 89 e5             	mov    %rsp,%rbp
  2c18c0:	48 83 ec 60          	sub    $0x60,%rsp
  2c18c4:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c18c7:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c18ca:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c18ce:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c18d2:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c18d6:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c18da:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c18e1:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c18e5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c18e9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c18ed:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c18f1:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c18f5:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c18f9:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c18fc:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c18ff:	89 c7                	mov    %eax,%edi
  2c1901:	e8 4a ff ff ff       	call   2c1850 <console_vprintf>
  2c1906:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c1909:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c190c:	c9                   	leave  
  2c190d:	c3                   	ret    

00000000002c190e <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c190e:	55                   	push   %rbp
  2c190f:	48 89 e5             	mov    %rsp,%rbp
  2c1912:	48 83 ec 20          	sub    $0x20,%rsp
  2c1916:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c191a:	89 f0                	mov    %esi,%eax
  2c191c:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c191f:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c1922:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1926:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c192a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c192e:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c1932:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1936:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c193a:	48 39 c2             	cmp    %rax,%rdx
  2c193d:	73 1a                	jae    2c1959 <string_putc+0x4b>
        *sp->s++ = c;
  2c193f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1943:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1947:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c194b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c194f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1953:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c1957:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c1959:	90                   	nop
  2c195a:	c9                   	leave  
  2c195b:	c3                   	ret    

00000000002c195c <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c195c:	55                   	push   %rbp
  2c195d:	48 89 e5             	mov    %rsp,%rbp
  2c1960:	48 83 ec 40          	sub    $0x40,%rsp
  2c1964:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c1968:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c196c:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c1970:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c1974:	48 c7 45 e8 0e 19 2c 	movq   $0x2c190e,-0x18(%rbp)
  2c197b:	00 
    sp.s = s;
  2c197c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1980:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c1984:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c1989:	74 33                	je     2c19be <vsnprintf+0x62>
        sp.end = s + size - 1;
  2c198b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c198f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c1993:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1997:	48 01 d0             	add    %rdx,%rax
  2c199a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c199e:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c19a2:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c19a6:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c19aa:	be 00 00 00 00       	mov    $0x0,%esi
  2c19af:	48 89 c7             	mov    %rax,%rdi
  2c19b2:	e8 ea f3 ff ff       	call   2c0da1 <printer_vprintf>
        *sp.s = 0;
  2c19b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c19bb:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c19be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c19c2:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c19c6:	c9                   	leave  
  2c19c7:	c3                   	ret    

00000000002c19c8 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c19c8:	55                   	push   %rbp
  2c19c9:	48 89 e5             	mov    %rsp,%rbp
  2c19cc:	48 83 ec 70          	sub    $0x70,%rsp
  2c19d0:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c19d4:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c19d8:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c19dc:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c19e0:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c19e4:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c19e8:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c19ef:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c19f3:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c19f7:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c19fb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c19ff:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c1a03:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c1a07:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c1a0b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1a0f:	48 89 c7             	mov    %rax,%rdi
  2c1a12:	e8 45 ff ff ff       	call   2c195c <vsnprintf>
  2c1a17:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c1a1a:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c1a1d:	c9                   	leave  
  2c1a1e:	c3                   	ret    

00000000002c1a1f <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c1a1f:	55                   	push   %rbp
  2c1a20:	48 89 e5             	mov    %rsp,%rbp
  2c1a23:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c1a27:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c1a2e:	eb 13                	jmp    2c1a43 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  2c1a30:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c1a33:	48 98                	cltq   
  2c1a35:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  2c1a3c:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c1a3f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1a43:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c1a4a:	7e e4                	jle    2c1a30 <console_clear+0x11>
    }
    cursorpos = 0;
  2c1a4c:	c7 05 a6 75 df ff 00 	movl   $0x0,-0x208a5a(%rip)        # b8ffc <cursorpos>
  2c1a53:	00 00 00 
}
  2c1a56:	90                   	nop
  2c1a57:	c9                   	leave  
  2c1a58:	c3                   	ret    
