
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
  2c0018:	e8 31 0d 00 00       	call   2c0d4e <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001d:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0022:	e8 65 05 00 00       	call   2c058c <malloc>
  2c0027:	48 89 c3             	mov    %rax,%rbx
    app_printf(0x800, "array 1: %p\n", array);
  2c002a:	48 89 c2             	mov    %rax,%rdx
  2c002d:	be ba 1a 2c 00       	mov    $0x2c1aba,%esi
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
  2c005b:	e8 21 06 00 00       	call   2c0681 <realloc>
  2c0060:	49 89 c5             	mov    %rax,%r13
    app_printf(0x800, "realloc'd array 1: %p\n", array);
  2c0063:	48 89 c2             	mov    %rax,%rdx
  2c0066:	be b0 1a 2c 00       	mov    $0x2c1ab0,%esi
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
  2c009e:	e8 ab 05 00 00       	call   2c064e <calloc>
  2c00a3:	49 89 c6             	mov    %rax,%r14
    app_printf(0x900, "array 2: %p\n", array2);
  2c00a6:	48 89 c2             	mov    %rax,%rdx
  2c00a9:	be eb 1a 2c 00       	mov    $0x2c1aeb,%esi
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
  2c00db:	e8 80 07 00 00       	call   2c0860 <heap_info>
  2c00e0:	85 c0                	test   %eax,%eax
  2c00e2:	0f 85 ad 00 00 00    	jne    2c0195 <process_main+0x195>
	// check if allocations are in sorted order
	app_printf(0x700, "alloc'd regions:\n");
  2c00e8:	be 07 1b 2c 00       	mov    $0x2c1b07,%esi
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
  2c0114:	be 19 1b 2c 00       	mov    $0x2c1b19,%esi
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
  2c0159:	ba c7 1a 2c 00       	mov    $0x2c1ac7,%edx
  2c015e:	be 1c 00 00 00       	mov    $0x1c,%esi
  2c0163:	bf d5 1a 2c 00       	mov    $0x2c1ad5,%edi
  2c0168:	e8 13 02 00 00       	call   2c0380 <assert_fail>
	assert(array2[i] == 0);
  2c016d:	ba f8 1a 2c 00       	mov    $0x2c1af8,%edx
  2c0172:	be 25 00 00 00       	mov    $0x25,%esi
  2c0177:	bf d5 1a 2c 00       	mov    $0x2c1ad5,%edi
  2c017c:	e8 ff 01 00 00       	call   2c0380 <assert_fail>
	    assert(info.size_array[i] <= info.size_array[i-1]);
  2c0181:	ba 48 1b 2c 00       	mov    $0x2c1b48,%edx
  2c0186:	be 30 00 00 00       	mov    $0x30,%esi
  2c018b:	bf d5 1a 2c 00       	mov    $0x2c1ad5,%edi
  2c0190:	e8 eb 01 00 00       	call   2c0380 <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c0195:	be 33 1b 2c 00       	mov    $0x2c1b33,%esi
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
  2c01d2:	e8 b5 03 00 00       	call   2c058c <malloc>
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
  2c020c:	be 78 1b 2c 00       	mov    $0x2c1b78,%esi
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
  2c026a:	0f b6 b7 dd 1b 2c 00 	movzbl 0x2c1bdd(%rdi),%esi
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
  2c0298:	e8 03 16 00 00       	call   2c18a0 <console_vprintf>
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
  2c02f1:	be a8 1b 2c 00       	mov    $0x2c1ba8,%esi
  2c02f6:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  2c02fd:	e8 55 07 00 00       	call   2c0a57 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0302:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0306:	48 89 da             	mov    %rbx,%rdx
  2c0309:	be 99 00 00 00       	mov    $0x99,%esi
  2c030e:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c0315:	e8 92 16 00 00       	call   2c19ac <vsnprintf>
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
  2c033a:	ba b0 1b 2c 00       	mov    $0x2c1bb0,%edx
  2c033f:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c0344:	bf 30 07 00 00       	mov    $0x730,%edi
  2c0349:	b8 00 00 00 00       	mov    $0x0,%eax
  2c034e:	e8 b9 15 00 00       	call   2c190c <console_printf>
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
  2c0374:	be 17 1b 2c 00       	mov    $0x2c1b17,%esi
  2c0379:	e8 86 08 00 00       	call   2c0c04 <strcpy>
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
  2c038d:	ba b8 1b 2c 00       	mov    $0x2c1bb8,%edx
  2c0392:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c0397:	bf 30 07 00 00       	mov    $0x730,%edi
  2c039c:	b8 00 00 00 00       	mov    $0x0,%eax
  2c03a1:	e8 66 15 00 00       	call   2c190c <console_printf>
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
  2c03b6:	48 89 05 63 1c 00 00 	mov    %rax,0x1c63(%rip)        # 2c2020 <result.0>
  2c03bd:	bf 08 00 00 00       	mov    $0x8,%edi
  2c03c2:	cd 3a                	int    $0x3a
  2c03c4:	48 89 05 55 1c 00 00 	mov    %rax,0x1c55(%rip)        # 2c2020 <result.0>
// want to try and optimize this 
void heap_init(void) {

	// prologue block
	sbrk(sizeof(block_header) + sizeof(block_header));
	prologue_block = sbrk(sizeof(block_footer));
  2c03cb:	48 89 05 3e 1c 00 00 	mov    %rax,0x1c3e(%rip)        # 2c2010 <prologue_block>
	PUT(HDRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  2c03d2:	48 c7 40 f8 11 00 00 	movq   $0x11,-0x8(%rax)
  2c03d9:	00 
	PUT(FTRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  2c03da:	48 8b 15 2f 1c 00 00 	mov    0x1c2f(%rip),%rdx        # 2c2010 <prologue_block>
  2c03e1:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  2c03e5:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c03e9:	48 c7 44 02 f0 11 00 	movq   $0x11,-0x10(%rdx,%rax,1)
  2c03f0:	00 00 
  2c03f2:	cd 3a                	int    $0x3a
  2c03f4:	48 89 05 25 1c 00 00 	mov    %rax,0x1c25(%rip)        # 2c2020 <result.0>

	// terminal block
	sbrk(sizeof(block_header));
	PUT(HDRP(NEXT_BLKP(prologue_block)), PACK(0, 1));	
  2c03fb:	48 8b 15 0e 1c 00 00 	mov    0x1c0e(%rip),%rdx        # 2c2010 <prologue_block>
  2c0402:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  2c0406:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c040a:	48 c7 44 02 f8 01 00 	movq   $0x1,-0x8(%rdx,%rax,1)
  2c0411:	00 00 

	free_list = NULL;
  2c0413:	48 c7 05 ea 1b 00 00 	movq   $0x0,0x1bea(%rip)        # 2c2008 <free_list>
  2c041a:	00 00 00 00 

	initialized_heap = 1;
  2c041e:	c7 05 f0 1b 00 00 01 	movl   $0x1,0x1bf0(%rip)        # 2c2018 <initialized_heap>
  2c0425:	00 00 00 
}
  2c0428:	c3                   	ret    

00000000002c0429 <free>:

void free(void *firstbyte) {
	if (firstbyte == NULL)
  2c0429:	48 85 ff             	test   %rdi,%rdi
  2c042c:	74 3d                	je     2c046b <free+0x42>
		return;

	// setup free things: alloc, list ptrs, footer
	PUT(HDRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  2c042e:	48 8b 47 f8          	mov    -0x8(%rdi),%rax
  2c0432:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c0436:	48 89 47 f8          	mov    %rax,-0x8(%rdi)
	NEXT_FPTR(firstbyte) = free_list;
  2c043a:	48 8b 15 c7 1b 00 00 	mov    0x1bc7(%rip),%rdx        # 2c2008 <free_list>
  2c0441:	48 89 17             	mov    %rdx,(%rdi)
	PREV_FPTR(firstbyte) = NULL;
  2c0444:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  2c044b:	00 
	PUT(FTRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  2c044c:	48 89 44 07 f0       	mov    %rax,-0x10(%rdi,%rax,1)

	// add to free_list
	PREV_FPTR(free_list) = firstbyte;
  2c0451:	48 8b 05 b0 1b 00 00 	mov    0x1bb0(%rip),%rax        # 2c2008 <free_list>
  2c0458:	48 89 78 08          	mov    %rdi,0x8(%rax)
	free_list = firstbyte;
  2c045c:	48 89 3d a5 1b 00 00 	mov    %rdi,0x1ba5(%rip)        # 2c2008 <free_list>

	num_allocs--;
  2c0463:	48 83 2d 95 1b 00 00 	subq   $0x1,0x1b95(%rip)        # 2c2000 <num_allocs>
  2c046a:	01 

	return;
}
  2c046b:	c3                   	ret    

00000000002c046c <extend>:
//
//	the reason allocating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
int extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  2c046c:	48 81 c7 ff 3f 00 00 	add    $0x3fff,%rdi
  2c0473:	48 81 e7 00 c0 ff ff 	and    $0xffffffffffffc000,%rdi
  2c047a:	cd 3a                	int    $0x3a
  2c047c:	48 89 05 9d 1b 00 00 	mov    %rax,0x1b9d(%rip)        # 2c2020 <result.0>
	void *bp = sbrk(chunk_aligned_size);
	if (bp == (void *)-1)
  2c0483:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c0487:	74 49                	je     2c04d2 <extend+0x66>
		return -1;

	// setup pointer
	PUT(HDRP(bp), PACK(chunk_aligned_size, 0));	
  2c0489:	48 89 78 f8          	mov    %rdi,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  2c048d:	48 8b 15 74 1b 00 00 	mov    0x1b74(%rip),%rdx        # 2c2008 <free_list>
  2c0494:	48 89 10             	mov    %rdx,(%rax)
	PREV_FPTR(bp) = NULL;
  2c0497:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  2c049e:	00 
	PUT(FTRP(bp), PACK(chunk_aligned_size, 0));	
  2c049f:	48 89 7c 07 f0       	mov    %rdi,-0x10(%rdi,%rax,1)
	
	// add to head of free_list
	if (free_list)
  2c04a4:	48 8b 15 5d 1b 00 00 	mov    0x1b5d(%rip),%rdx        # 2c2008 <free_list>
  2c04ab:	48 85 d2             	test   %rdx,%rdx
  2c04ae:	74 04                	je     2c04b4 <extend+0x48>
		PREV_FPTR(free_list) = bp;
  2c04b0:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  2c04b4:	48 89 05 4d 1b 00 00 	mov    %rax,0x1b4d(%rip)        # 2c2008 <free_list>

	// update terminal block
	PUT(HDRP(NEXT_BLKP(bp)), PACK(0, 1));	
  2c04bb:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c04bf:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c04c3:	48 c7 44 10 f8 01 00 	movq   $0x1,-0x8(%rax,%rdx,1)
  2c04ca:	00 00 

	return 0;
  2c04cc:	b8 00 00 00 00       	mov    $0x0,%eax
  2c04d1:	c3                   	ret    
		return -1;
  2c04d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  2c04d7:	c3                   	ret    

00000000002c04d8 <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
  2c04d8:	48 89 f8             	mov    %rdi,%rax
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  2c04db:	48 8b 57 f8          	mov    -0x8(%rdi),%rdx
  2c04df:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c04e3:	48 29 f2             	sub    %rsi,%rdx

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  2c04e6:	48 83 fa 20          	cmp    $0x20,%rdx
  2c04ea:	76 5b                	jbe    2c0547 <set_allocated+0x6f>
		PUT(HDRP(bp), PACK(size, 1));
  2c04ec:	48 89 f1             	mov    %rsi,%rcx
  2c04ef:	48 83 c9 01          	or     $0x1,%rcx
  2c04f3:	48 89 4f f8          	mov    %rcx,-0x8(%rdi)

		void *leftover_mem_ptr = NEXT_BLKP(bp);
  2c04f7:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  2c04fb:	48 01 fe             	add    %rdi,%rsi

		PUT(HDRP(leftover_mem_ptr), PACK(extra_size, 0));	
  2c04fe:	48 89 56 f8          	mov    %rdx,-0x8(%rsi)
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp); // pointers to the next free blocks
  2c0502:	48 8b 0f             	mov    (%rdi),%rcx
  2c0505:	48 89 0e             	mov    %rcx,(%rsi)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  2c0508:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  2c050c:	48 89 4e 08          	mov    %rcx,0x8(%rsi)
		PUT(FTRP(leftover_mem_ptr), PACK(extra_size, 0));	
  2c0510:	48 89 d1             	mov    %rdx,%rcx
  2c0513:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  2c0517:	48 89 54 0e f0       	mov    %rdx,-0x10(%rsi,%rcx,1)

		// update the free list
		if (free_list == bp)
  2c051c:	48 39 3d e5 1a 00 00 	cmp    %rdi,0x1ae5(%rip)        # 2c2008 <free_list>
  2c0523:	74 19                	je     2c053e <set_allocated+0x66>
			free_list = leftover_mem_ptr;

		if (PREV_FPTR(bp))
  2c0525:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c0529:	48 85 d2             	test   %rdx,%rdx
  2c052c:	74 03                	je     2c0531 <set_allocated+0x59>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  2c052e:	48 89 32             	mov    %rsi,(%rdx)

		if (NEXT_FPTR(bp))
  2c0531:	48 8b 00             	mov    (%rax),%rax
  2c0534:	48 85 c0             	test   %rax,%rax
  2c0537:	74 46                	je     2c057f <set_allocated+0xa7>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  2c0539:	48 89 70 08          	mov    %rsi,0x8(%rax)
  2c053d:	c3                   	ret    
			free_list = leftover_mem_ptr;
  2c053e:	48 89 35 c3 1a 00 00 	mov    %rsi,0x1ac3(%rip)        # 2c2008 <free_list>
  2c0545:	eb de                	jmp    2c0525 <set_allocated+0x4d>
								    
	}
	else {
		// update the free list
		if (free_list == bp)
  2c0547:	48 39 3d ba 1a 00 00 	cmp    %rdi,0x1aba(%rip)        # 2c2008 <free_list>
  2c054e:	74 30                	je     2c0580 <set_allocated+0xa8>
			free_list = NEXT_FPTR(bp);

		if (PREV_FPTR(bp))
  2c0550:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c0554:	48 85 d2             	test   %rdx,%rdx
  2c0557:	74 06                	je     2c055f <set_allocated+0x87>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  2c0559:	48 8b 08             	mov    (%rax),%rcx
  2c055c:	48 89 0a             	mov    %rcx,(%rdx)
		if (NEXT_FPTR(bp))
  2c055f:	48 8b 10             	mov    (%rax),%rdx
  2c0562:	48 85 d2             	test   %rdx,%rdx
  2c0565:	74 08                	je     2c056f <set_allocated+0x97>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  2c0567:	48 8b 48 08          	mov    0x8(%rax),%rcx
  2c056b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)

		PUT(HDRP(bp), PACK(GET_SIZE(HDRP(bp)), 1));	
  2c056f:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c0573:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c0577:	48 83 ca 01          	or     $0x1,%rdx
  2c057b:	48 89 50 f8          	mov    %rdx,-0x8(%rax)
	}
}
  2c057f:	c3                   	ret    
			free_list = NEXT_FPTR(bp);
  2c0580:	48 8b 17             	mov    (%rdi),%rdx
  2c0583:	48 89 15 7e 1a 00 00 	mov    %rdx,0x1a7e(%rip)        # 2c2008 <free_list>
  2c058a:	eb c4                	jmp    2c0550 <set_allocated+0x78>

00000000002c058c <malloc>:

void *malloc(uint64_t numbytes) {
  2c058c:	55                   	push   %rbp
  2c058d:	48 89 e5             	mov    %rsp,%rbp
  2c0590:	41 55                	push   %r13
  2c0592:	41 54                	push   %r12
  2c0594:	53                   	push   %rbx
  2c0595:	48 83 ec 08          	sub    $0x8,%rsp
  2c0599:	49 89 fc             	mov    %rdi,%r12
	if (!initialized_heap)
  2c059c:	83 3d 75 1a 00 00 00 	cmpl   $0x0,0x1a75(%rip)        # 2c2018 <initialized_heap>
  2c05a3:	74 73                	je     2c0618 <malloc+0x8c>
		heap_init();

	if (numbytes == 0)
  2c05a5:	4d 85 e4             	test   %r12,%r12
  2c05a8:	0f 84 92 00 00 00    	je     2c0640 <malloc+0xb4>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  2c05ae:	49 83 c4 17          	add    $0x17,%r12
  2c05b2:	49 83 e4 f0          	and    $0xfffffffffffffff0,%r12
  2c05b6:	b8 20 00 00 00       	mov    $0x20,%eax
  2c05bb:	49 39 c4             	cmp    %rax,%r12
  2c05be:	4c 0f 42 e0          	cmovb  %rax,%r12
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);
	
	void *bp = free_list;
  2c05c2:	48 8b 1d 3f 1a 00 00 	mov    0x1a3f(%rip),%rbx        # 2c2008 <free_list>
	while (bp) {
  2c05c9:	48 85 db             	test   %rbx,%rbx
  2c05cc:	74 15                	je     2c05e3 <malloc+0x57>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  2c05ce:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  2c05d2:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c05d6:	4c 39 e0             	cmp    %r12,%rax
  2c05d9:	73 44                	jae    2c061f <malloc+0x93>
			set_allocated(bp, aligned_size);
			num_allocs++;
			return bp;
		}

		bp = NEXT_FPTR(bp);
  2c05db:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  2c05de:	48 85 db             	test   %rbx,%rbx
  2c05e1:	75 eb                	jne    2c05ce <malloc+0x42>
  2c05e3:	bf 00 00 00 00       	mov    $0x0,%edi
  2c05e8:	cd 3a                	int    $0x3a
  2c05ea:	49 89 c5             	mov    %rax,%r13
  2c05ed:	48 89 05 2c 1a 00 00 	mov    %rax,0x1a2c(%rip)        # 2c2020 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  2c05f4:	48 89 c3             	mov    %rax,%rbx
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	if (extend(aligned_size)) {
  2c05f7:	4c 89 e7             	mov    %r12,%rdi
  2c05fa:	e8 6d fe ff ff       	call   2c046c <extend>
  2c05ff:	85 c0                	test   %eax,%eax
  2c0601:	75 44                	jne    2c0647 <malloc+0xbb>
		return NULL;
	}
	set_allocated(bp, aligned_size);
  2c0603:	4c 89 e6             	mov    %r12,%rsi
  2c0606:	4c 89 ef             	mov    %r13,%rdi
  2c0609:	e8 ca fe ff ff       	call   2c04d8 <set_allocated>
	num_allocs++;
  2c060e:	48 83 05 ea 19 00 00 	addq   $0x1,0x19ea(%rip)        # 2c2000 <num_allocs>
  2c0615:	01 
    return bp;
  2c0616:	eb 1a                	jmp    2c0632 <malloc+0xa6>
		heap_init();
  2c0618:	e8 92 fd ff ff       	call   2c03af <heap_init>
  2c061d:	eb 86                	jmp    2c05a5 <malloc+0x19>
			set_allocated(bp, aligned_size);
  2c061f:	4c 89 e6             	mov    %r12,%rsi
  2c0622:	48 89 df             	mov    %rbx,%rdi
  2c0625:	e8 ae fe ff ff       	call   2c04d8 <set_allocated>
			num_allocs++;
  2c062a:	48 83 05 ce 19 00 00 	addq   $0x1,0x19ce(%rip)        # 2c2000 <num_allocs>
  2c0631:	01 
}
  2c0632:	48 89 d8             	mov    %rbx,%rax
  2c0635:	48 83 c4 08          	add    $0x8,%rsp
  2c0639:	5b                   	pop    %rbx
  2c063a:	41 5c                	pop    %r12
  2c063c:	41 5d                	pop    %r13
  2c063e:	5d                   	pop    %rbp
  2c063f:	c3                   	ret    
		return NULL;
  2c0640:	bb 00 00 00 00       	mov    $0x0,%ebx
  2c0645:	eb eb                	jmp    2c0632 <malloc+0xa6>
		return NULL;
  2c0647:	bb 00 00 00 00       	mov    $0x0,%ebx
  2c064c:	eb e4                	jmp    2c0632 <malloc+0xa6>

00000000002c064e <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  2c064e:	55                   	push   %rbp
  2c064f:	48 89 e5             	mov    %rsp,%rbp
  2c0652:	41 54                	push   %r12
  2c0654:	53                   	push   %rbx
	void *bp = malloc(num * sz);
  2c0655:	48 0f af fe          	imul   %rsi,%rdi
  2c0659:	49 89 fc             	mov    %rdi,%r12
  2c065c:	e8 2b ff ff ff       	call   2c058c <malloc>
  2c0661:	48 89 c3             	mov    %rax,%rbx
	if (bp)							// protect against num=0 or size=0
  2c0664:	48 85 c0             	test   %rax,%rax
  2c0667:	74 10                	je     2c0679 <calloc+0x2b>
		memset(bp, 0, num * sz);
  2c0669:	4c 89 e2             	mov    %r12,%rdx
  2c066c:	be 00 00 00 00       	mov    $0x0,%esi
  2c0671:	48 89 c7             	mov    %rax,%rdi
  2c0674:	e8 dc 04 00 00       	call   2c0b55 <memset>
	return bp;
}
  2c0679:	48 89 d8             	mov    %rbx,%rax
  2c067c:	5b                   	pop    %rbx
  2c067d:	41 5c                	pop    %r12
  2c067f:	5d                   	pop    %rbp
  2c0680:	c3                   	ret    

00000000002c0681 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  2c0681:	55                   	push   %rbp
  2c0682:	48 89 e5             	mov    %rsp,%rbp
  2c0685:	41 54                	push   %r12
  2c0687:	53                   	push   %rbx
  2c0688:	48 89 fb             	mov    %rdi,%rbx
  2c068b:	48 89 f7             	mov    %rsi,%rdi
	// first check if there's enough space in the block already (and that it's actually valid ptr)
	if (ptr && GET_SIZE(HDRP(ptr)) >= sz)
  2c068e:	48 85 db             	test   %rbx,%rbx
  2c0691:	74 10                	je     2c06a3 <realloc+0x22>
  2c0693:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  2c0697:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
		return ptr;
  2c069b:	49 89 dc             	mov    %rbx,%r12
	if (ptr && GET_SIZE(HDRP(ptr)) >= sz)
  2c069e:	48 39 f0             	cmp    %rsi,%rax
  2c06a1:	73 23                	jae    2c06c6 <realloc+0x45>

	// else find or add a big enough block, which is what malloc does
	void *bigger_ptr = malloc(sz);
  2c06a3:	e8 e4 fe ff ff       	call   2c058c <malloc>
  2c06a8:	49 89 c4             	mov    %rax,%r12
	memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
  2c06ab:	48 8b 53 f8          	mov    -0x8(%rbx),%rdx
  2c06af:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c06b3:	48 89 de             	mov    %rbx,%rsi
  2c06b6:	48 89 c7             	mov    %rax,%rdi
  2c06b9:	e8 99 03 00 00       	call   2c0a57 <memcpy>
	free(ptr);
  2c06be:	48 89 df             	mov    %rbx,%rdi
  2c06c1:	e8 63 fd ff ff       	call   2c0429 <free>

    return bigger_ptr;
}
  2c06c6:	4c 89 e0             	mov    %r12,%rax
  2c06c9:	5b                   	pop    %rbx
  2c06ca:	41 5c                	pop    %r12
  2c06cc:	5d                   	pop    %rbp
  2c06cd:	c3                   	ret    

00000000002c06ce <defrag>:

void defrag() {
	void *fp = free_list;
  2c06ce:	48 8b 15 33 19 00 00 	mov    0x1933(%rip),%rdx        # 2c2008 <free_list>
	while (fp != NULL) {
  2c06d5:	48 85 d2             	test   %rdx,%rdx
  2c06d8:	75 3c                	jne    2c0716 <defrag+0x48>
		// you only need to check the block after, because if the block before is free, you'll
		// bet there by traversing the free list

		fp = NEXT_FPTR(fp);
	}
}
  2c06da:	c3                   	ret    
				free_list = NEXT_FPTR(next_block);
  2c06db:	48 8b 08             	mov    (%rax),%rcx
  2c06de:	48 89 0d 23 19 00 00 	mov    %rcx,0x1923(%rip)        # 2c2008 <free_list>
  2c06e5:	eb 49                	jmp    2c0730 <defrag+0x62>
			PUT(HDRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  2c06e7:	48 8b 4a f8          	mov    -0x8(%rdx),%rcx
  2c06eb:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  2c06ef:	48 8b 70 f8          	mov    -0x8(%rax),%rsi
  2c06f3:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  2c06f7:	48 01 f1             	add    %rsi,%rcx
  2c06fa:	48 89 4a f8          	mov    %rcx,-0x8(%rdx)
			PUT(FTRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  2c06fe:	48 8b 40 f8          	mov    -0x8(%rax),%rax
  2c0702:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c0706:	48 01 c8             	add    %rcx,%rax
  2c0709:	48 89 44 0a f0       	mov    %rax,-0x10(%rdx,%rcx,1)
		fp = NEXT_FPTR(fp);
  2c070e:	48 8b 12             	mov    (%rdx),%rdx
	while (fp != NULL) {
  2c0711:	48 85 d2             	test   %rdx,%rdx
  2c0714:	74 c4                	je     2c06da <defrag+0xc>
		void *next_block = NEXT_BLKP(fp);
  2c0716:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  2c071a:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c071e:	48 01 d0             	add    %rdx,%rax
		if (!GET_ALLOC(HDRP(next_block))) {
  2c0721:	f6 40 f8 01          	testb  $0x1,-0x8(%rax)
  2c0725:	75 e7                	jne    2c070e <defrag+0x40>
			if (free_list == next_block)
  2c0727:	48 39 05 da 18 00 00 	cmp    %rax,0x18da(%rip)        # 2c2008 <free_list>
  2c072e:	74 ab                	je     2c06db <defrag+0xd>
			if (PREV_FPTR(next_block)) 
  2c0730:	48 8b 48 08          	mov    0x8(%rax),%rcx
  2c0734:	48 85 c9             	test   %rcx,%rcx
  2c0737:	74 06                	je     2c073f <defrag+0x71>
				NEXT_FPTR(PREV_FPTR(next_block)) = NEXT_FPTR(next_block);
  2c0739:	48 8b 30             	mov    (%rax),%rsi
  2c073c:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(next_block)) 
  2c073f:	48 8b 08             	mov    (%rax),%rcx
  2c0742:	48 85 c9             	test   %rcx,%rcx
  2c0745:	74 a0                	je     2c06e7 <defrag+0x19>
				PREV_FPTR(NEXT_FPTR(next_block)) = PREV_FPTR(next_block);
  2c0747:	48 8b 70 08          	mov    0x8(%rax),%rsi
  2c074b:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  2c074f:	eb 96                	jmp    2c06e7 <defrag+0x19>

00000000002c0751 <sift_down>:
// heap sort stuff that operates on the pointer array
#define LEFT_CHILD(x) (2*x + 1)
#define RIGHT_CHILD(x) (2*x + 2)
#define PARENT(x) ((x-1)/2)

void sift_down(void **arr, size_t pos, size_t arr_len) {
  2c0751:	48 89 f1             	mov    %rsi,%rcx
  2c0754:	49 89 d3             	mov    %rdx,%r11
	while (LEFT_CHILD(pos) < arr_len) {
  2c0757:	48 8d 74 36 01       	lea    0x1(%rsi,%rsi,1),%rsi
  2c075c:	48 39 d6             	cmp    %rdx,%rsi
  2c075f:	72 3a                	jb     2c079b <sift_down+0x4a>
  2c0761:	c3                   	ret    
  2c0762:	48 89 f0             	mov    %rsi,%rax
		size_t smaller = LEFT_CHILD(pos);
		if (RIGHT_CHILD(pos) < arr_len && GET_SIZE(HDRP(arr[RIGHT_CHILD(pos)])) < GET_SIZE(HDRP(arr[LEFT_CHILD(pos)]))){
			smaller = RIGHT_CHILD(pos);
		}

		if (GET_SIZE(HDRP(arr[pos])) > GET_SIZE(HDRP(arr[smaller]))) {
  2c0765:	4c 8d 0c cf          	lea    (%rdi,%rcx,8),%r9
  2c0769:	4d 8b 01             	mov    (%r9),%r8
  2c076c:	48 8d 34 c7          	lea    (%rdi,%rax,8),%rsi
  2c0770:	4c 8b 16             	mov    (%rsi),%r10
  2c0773:	49 8b 50 f8          	mov    -0x8(%r8),%rdx
  2c0777:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c077b:	49 8b 4a f8          	mov    -0x8(%r10),%rcx
  2c077f:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  2c0783:	48 39 d1             	cmp    %rdx,%rcx
  2c0786:	73 46                	jae    2c07ce <sift_down+0x7d>
			void *temp = arr[pos];
			arr[pos] = arr[smaller];
  2c0788:	4d 89 11             	mov    %r10,(%r9)
			arr[smaller] = temp;
  2c078b:	4c 89 06             	mov    %r8,(%rsi)
	while (LEFT_CHILD(pos) < arr_len) {
  2c078e:	48 8d 74 00 01       	lea    0x1(%rax,%rax,1),%rsi
  2c0793:	4c 39 de             	cmp    %r11,%rsi
  2c0796:	73 36                	jae    2c07ce <sift_down+0x7d>
			pos = smaller;
  2c0798:	48 89 c1             	mov    %rax,%rcx
		if (RIGHT_CHILD(pos) < arr_len && GET_SIZE(HDRP(arr[RIGHT_CHILD(pos)])) < GET_SIZE(HDRP(arr[LEFT_CHILD(pos)]))){
  2c079b:	48 8d 51 01          	lea    0x1(%rcx),%rdx
  2c079f:	48 8d 04 12          	lea    (%rdx,%rdx,1),%rax
  2c07a3:	4c 39 d8             	cmp    %r11,%rax
  2c07a6:	73 ba                	jae    2c0762 <sift_down+0x11>
  2c07a8:	48 c1 e2 04          	shl    $0x4,%rdx
  2c07ac:	4c 8b 04 17          	mov    (%rdi,%rdx,1),%r8
  2c07b0:	4d 8b 40 f8          	mov    -0x8(%r8),%r8
  2c07b4:	49 83 e0 f0          	and    $0xfffffffffffffff0,%r8
  2c07b8:	48 8b 54 17 f8       	mov    -0x8(%rdi,%rdx,1),%rdx
  2c07bd:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  2c07c1:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c07c5:	49 39 d0             	cmp    %rdx,%r8
  2c07c8:	48 0f 43 c6          	cmovae %rsi,%rax
  2c07cc:	eb 97                	jmp    2c0765 <sift_down+0x14>
		}
		else {
			break;
		}
	}
}
  2c07ce:	c3                   	ret    

00000000002c07cf <heapify>:

void heapify(void **arr, size_t arr_len) {
  2c07cf:	55                   	push   %rbp
  2c07d0:	48 89 e5             	mov    %rsp,%rbp
  2c07d3:	41 56                	push   %r14
  2c07d5:	41 55                	push   %r13
  2c07d7:	41 54                	push   %r12
  2c07d9:	53                   	push   %rbx
	for (int i = arr_len - 1; i >= 0; i--) {
  2c07da:	41 89 f5             	mov    %esi,%r13d
  2c07dd:	41 83 ed 01          	sub    $0x1,%r13d
  2c07e1:	78 28                	js     2c080b <heapify+0x3c>
  2c07e3:	49 89 fe             	mov    %rdi,%r14
  2c07e6:	49 89 f4             	mov    %rsi,%r12
  2c07e9:	49 63 c5             	movslq %r13d,%rax
  2c07ec:	48 89 c3             	mov    %rax,%rbx
  2c07ef:	41 29 c5             	sub    %eax,%r13d
		sift_down(arr, i, arr_len);
  2c07f2:	4c 89 e2             	mov    %r12,%rdx
  2c07f5:	48 89 de             	mov    %rbx,%rsi
  2c07f8:	4c 89 f7             	mov    %r14,%rdi
  2c07fb:	e8 51 ff ff ff       	call   2c0751 <sift_down>
	for (int i = arr_len - 1; i >= 0; i--) {
  2c0800:	48 83 eb 01          	sub    $0x1,%rbx
  2c0804:	44 89 e8             	mov    %r13d,%eax
  2c0807:	01 d8                	add    %ebx,%eax
  2c0809:	79 e7                	jns    2c07f2 <heapify+0x23>
	}
}
  2c080b:	5b                   	pop    %rbx
  2c080c:	41 5c                	pop    %r12
  2c080e:	41 5d                	pop    %r13
  2c0810:	41 5e                	pop    %r14
  2c0812:	5d                   	pop    %rbp
  2c0813:	c3                   	ret    

00000000002c0814 <heapsort>:

void heapsort(void **arr, size_t arr_len) {
  2c0814:	55                   	push   %rbp
  2c0815:	48 89 e5             	mov    %rsp,%rbp
  2c0818:	41 54                	push   %r12
  2c081a:	53                   	push   %rbx
  2c081b:	49 89 fc             	mov    %rdi,%r12
  2c081e:	48 89 f3             	mov    %rsi,%rbx
	heapify(arr, arr_len);
  2c0821:	e8 a9 ff ff ff       	call   2c07cf <heapify>
	if (arr_len == 0)
  2c0826:	48 85 db             	test   %rbx,%rbx
  2c0829:	74 30                	je     2c085b <heapsort+0x47>
		return;
	for (int i = arr_len - 1; i >= 0; i--) {
  2c082b:	83 eb 01             	sub    $0x1,%ebx
  2c082e:	78 2b                	js     2c085b <heapsort+0x47>
  2c0830:	48 63 db             	movslq %ebx,%rbx
		void *temp = arr[0];
  2c0833:	49 8b 04 24          	mov    (%r12),%rax
		arr[0] = arr[i];
  2c0837:	49 8b 14 dc          	mov    (%r12,%rbx,8),%rdx
  2c083b:	49 89 14 24          	mov    %rdx,(%r12)
		arr[i] = temp;
  2c083f:	49 89 04 dc          	mov    %rax,(%r12,%rbx,8)
		sift_down(arr, 0, i);
  2c0843:	48 89 da             	mov    %rbx,%rdx
  2c0846:	be 00 00 00 00       	mov    $0x0,%esi
  2c084b:	4c 89 e7             	mov    %r12,%rdi
  2c084e:	e8 fe fe ff ff       	call   2c0751 <sift_down>
	for (int i = arr_len - 1; i >= 0; i--) {
  2c0853:	48 83 eb 01          	sub    $0x1,%rbx
  2c0857:	85 db                	test   %ebx,%ebx
  2c0859:	79 d8                	jns    2c0833 <heapsort+0x1f>
	}
}
  2c085b:	5b                   	pop    %rbx
  2c085c:	41 5c                	pop    %r12
  2c085e:	5d                   	pop    %rbp
  2c085f:	c3                   	ret    

00000000002c0860 <heap_info>:

int heap_info(heap_info_struct *info) {
  2c0860:	55                   	push   %rbp
  2c0861:	48 89 e5             	mov    %rsp,%rbp
  2c0864:	41 54                	push   %r12
  2c0866:	53                   	push   %rbx
  2c0867:	48 89 fb             	mov    %rdi,%rbx
	info->num_allocs = num_allocs+2;		// +2 for the two arrays we need
  2c086a:	8b 05 90 17 00 00    	mov    0x1790(%rip),%eax        # 2c2000 <num_allocs>
  2c0870:	83 c0 02             	add    $0x2,%eax
  2c0873:	89 07                	mov    %eax,(%rdi)
	info->free_space = 0;
  2c0875:	c7 47 18 00 00 00 00 	movl   $0x0,0x18(%rdi)
	info->largest_free_chunk = 0;
  2c087c:	c7 47 1c 00 00 00 00 	movl   $0x0,0x1c(%rdi)

	info->size_array = sbrk(ALIGN(info->num_allocs * sizeof(long) + OVERHEAD));
  2c0883:	48 98                	cltq   
  2c0885:	48 8d 3c c5 17 00 00 	lea    0x17(,%rax,8),%rdi
  2c088c:	00 
  2c088d:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
    asm volatile ("int %1" :  "=a" (result)
  2c0891:	cd 3a                	int    $0x3a
  2c0893:	48 89 05 86 17 00 00 	mov    %rax,0x1786(%rip)        # 2c2020 <result.0>
  2c089a:	48 89 43 08          	mov    %rax,0x8(%rbx)
	if (info->ptr_array == (void *)-1) { // nothing happens on failure
  2c089e:	48 83 7b 10 ff       	cmpq   $0xffffffffffffffff,0x10(%rbx)
  2c08a3:	0f 84 a0 01 00 00    	je     2c0a49 <heap_info+0x1e9>
		return -1;
	}
	info->ptr_array = sbrk(ALIGN(info->num_allocs * sizeof(void *) + OVERHEAD));
  2c08a9:	48 63 03             	movslq (%rbx),%rax
  2c08ac:	48 8d 3c c5 17 00 00 	lea    0x17(,%rax,8),%rdi
  2c08b3:	00 
  2c08b4:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
  2c08b8:	cd 3a                	int    $0x3a
  2c08ba:	48 89 05 5f 17 00 00 	mov    %rax,0x175f(%rip)        # 2c2020 <result.0>
  2c08c1:	48 89 43 10          	mov    %rax,0x10(%rbx)
	if (info->ptr_array == (void *)-1) {
  2c08c5:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c08c9:	74 72                	je     2c093d <heap_info+0xdd>
		sbrk(-ALIGN(info->num_allocs * sizeof(long) + OVERHEAD));
		return -1;
	}

	// we manually fill in array metadata
	PUT(HDRP(info->size_array), PACK(ALIGN(info->num_allocs * sizeof(long) + OVERHEAD), 1));
  2c08cb:	48 8b 53 08          	mov    0x8(%rbx),%rdx
  2c08cf:	48 63 03             	movslq (%rbx),%rax
  2c08d2:	48 8d 04 c5 17 00 00 	lea    0x17(,%rax,8),%rax
  2c08d9:	00 
  2c08da:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c08de:	48 83 c8 01          	or     $0x1,%rax
  2c08e2:	48 89 42 f8          	mov    %rax,-0x8(%rdx)
	PUT(HDRP(info->ptr_array), PACK(ALIGN(info->num_allocs * sizeof(void *) + OVERHEAD), 1));
  2c08e6:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  2c08ea:	48 63 03             	movslq (%rbx),%rax
  2c08ed:	48 8d 04 c5 17 00 00 	lea    0x17(,%rax,8),%rax
  2c08f4:	00 
  2c08f5:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c08f9:	48 83 c8 01          	or     $0x1,%rax
  2c08fd:	48 89 42 f8          	mov    %rax,-0x8(%rdx)

	// terminal block
	PUT(HDRP(NEXT_BLKP(info->ptr_array)), PACK(0, 1));
  2c0901:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  2c0905:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  2c0909:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c090d:	48 c7 44 02 f8 01 00 	movq   $0x1,-0x8(%rdx,%rax,1)
  2c0914:	00 00 

	// collect all the information by traversing through the heap
	void *bp = NEXT_BLKP(prologue_block); // because the prologue isn't actually allocated
  2c0916:	48 8b 05 f3 16 00 00 	mov    0x16f3(%rip),%rax        # 2c2010 <prologue_block>
  2c091d:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c0921:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c0925:	48 01 d0             	add    %rdx,%rax
	size_t arr_index = 0;
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  2c0928:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c092c:	48 83 fa 0f          	cmp    $0xf,%rdx
  2c0930:	0f 86 84 00 00 00    	jbe    2c09ba <heap_info+0x15a>
	size_t arr_index = 0;
  2c0936:	b9 00 00 00 00       	mov    $0x0,%ecx
  2c093b:	eb 5a                	jmp    2c0997 <heap_info+0x137>
		sbrk(-ALIGN(info->num_allocs * sizeof(long) + OVERHEAD));
  2c093d:	48 63 03             	movslq (%rbx),%rax
  2c0940:	48 8d 3c c5 17 00 00 	lea    0x17(,%rax,8),%rdi
  2c0947:	00 
  2c0948:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
  2c094c:	48 f7 df             	neg    %rdi
  2c094f:	cd 3a                	int    $0x3a
  2c0951:	48 89 05 c8 16 00 00 	mov    %rax,0x16c8(%rip)        # 2c2020 <result.0>
		return -1;
  2c0958:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2c095d:	e9 e2 00 00 00       	jmp    2c0a44 <heap_info+0x1e4>
			info->ptr_array[arr_index] = bp;
			info->size_array[arr_index] = GET_SIZE(HDRP(bp));
			arr_index++;
		}
		else {
			info->free_space += GET_SIZE(HDRP(bp));
  2c0962:	83 e2 f0             	and    $0xfffffff0,%edx
  2c0965:	01 53 18             	add    %edx,0x18(%rbx)
			if(GET_SIZE(HDRP(bp)) > (size_t) (info->largest_free_chunk)) {
  2c0968:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c096c:	48 89 d6             	mov    %rdx,%rsi
  2c096f:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  2c0973:	48 63 7b 1c          	movslq 0x1c(%rbx),%rdi
  2c0977:	48 39 f7             	cmp    %rsi,%rdi
  2c097a:	73 06                	jae    2c0982 <heap_info+0x122>
				info->largest_free_chunk = GET_SIZE(HDRP(bp));
  2c097c:	83 e2 f0             	and    $0xfffffff0,%edx
  2c097f:	89 53 1c             	mov    %edx,0x1c(%rbx)
			}
		}

		bp = NEXT_BLKP(bp);
  2c0982:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c0986:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c098a:	48 01 d0             	add    %rdx,%rax
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  2c098d:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c0991:	48 83 fa 0f          	cmp    $0xf,%rdx
  2c0995:	76 23                	jbe    2c09ba <heap_info+0x15a>
		if (GET_ALLOC(HDRP(bp))) {
  2c0997:	f6 c2 01             	test   $0x1,%dl
  2c099a:	74 c6                	je     2c0962 <heap_info+0x102>
			info->ptr_array[arr_index] = bp;
  2c099c:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  2c09a0:	48 89 04 ca          	mov    %rax,(%rdx,%rcx,8)
			info->size_array[arr_index] = GET_SIZE(HDRP(bp));
  2c09a4:	48 8b 73 08          	mov    0x8(%rbx),%rsi
  2c09a8:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c09ac:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c09b0:	48 89 14 ce          	mov    %rdx,(%rsi,%rcx,8)
			arr_index++;
  2c09b4:	48 83 c1 01          	add    $0x1,%rcx
  2c09b8:	eb c8                	jmp    2c0982 <heap_info+0x122>
	}

	app_printf(0xa00, "heap_info print:\n");
  2c09ba:	be e2 1b 2c 00       	mov    $0x2c1be2,%esi
  2c09bf:	bf 00 0a 00 00       	mov    $0xa00,%edi
  2c09c4:	b8 00 00 00 00       	mov    $0x0,%eax
  2c09c9:	e8 54 f8 ff ff       	call   2c0222 <app_printf>
	for(int  i = 0 ; i < info->num_allocs; i++){
  2c09ce:	8b 33                	mov    (%rbx),%esi
  2c09d0:	85 f6                	test   %esi,%esi
  2c09d2:	7e 35                	jle    2c0a09 <heap_info+0x1a9>
  2c09d4:	41 bc 00 00 00 00    	mov    $0x0,%r12d
		app_printf(0x700, "    ptr: %p, size: 0x%lx\n", info->ptr_array[i], info->size_array[i]);;
  2c09da:	48 8b 43 08          	mov    0x8(%rbx),%rax
  2c09de:	4a 8b 0c e0          	mov    (%rax,%r12,8),%rcx
  2c09e2:	48 8b 43 10          	mov    0x10(%rbx),%rax
  2c09e6:	4a 8b 14 e0          	mov    (%rax,%r12,8),%rdx
  2c09ea:	be 19 1b 2c 00       	mov    $0x2c1b19,%esi
  2c09ef:	bf 00 07 00 00       	mov    $0x700,%edi
  2c09f4:	b8 00 00 00 00       	mov    $0x0,%eax
  2c09f9:	e8 24 f8 ff ff       	call   2c0222 <app_printf>
	for(int  i = 0 ; i < info->num_allocs; i++){
  2c09fe:	8b 33                	mov    (%rbx),%esi
  2c0a00:	49 83 c4 01          	add    $0x1,%r12
  2c0a04:	44 39 e6             	cmp    %r12d,%esi
  2c0a07:	7f d1                	jg     2c09da <heap_info+0x17a>
	}
	// we just need to sort the arrays...
	// we'll use heapsort
	heapsort(info->ptr_array, info->num_allocs);
  2c0a09:	48 63 f6             	movslq %esi,%rsi
  2c0a0c:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
  2c0a10:	e8 ff fd ff ff       	call   2c0814 <heapsort>
	for (int i = 0; i < info->num_allocs; i++)
  2c0a15:	83 3b 00             	cmpl   $0x0,(%rbx)
  2c0a18:	7e 36                	jle    2c0a50 <heap_info+0x1f0>
  2c0a1a:	b8 00 00 00 00       	mov    $0x0,%eax
		info->size_array[i] = GET_SIZE(HDRP(info->ptr_array[i]));
  2c0a1f:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
  2c0a23:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  2c0a27:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
  2c0a2b:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  2c0a2f:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c0a33:	48 89 14 c1          	mov    %rdx,(%rcx,%rax,8)
	for (int i = 0; i < info->num_allocs; i++)
  2c0a37:	48 83 c0 01          	add    $0x1,%rax
  2c0a3b:	39 03                	cmp    %eax,(%rbx)
  2c0a3d:	7f e0                	jg     2c0a1f <heap_info+0x1bf>

    return 0;
  2c0a3f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  2c0a44:	5b                   	pop    %rbx
  2c0a45:	41 5c                	pop    %r12
  2c0a47:	5d                   	pop    %rbp
  2c0a48:	c3                   	ret    
		return -1;
  2c0a49:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2c0a4e:	eb f4                	jmp    2c0a44 <heap_info+0x1e4>
    return 0;
  2c0a50:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0a55:	eb ed                	jmp    2c0a44 <heap_info+0x1e4>

00000000002c0a57 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c0a57:	55                   	push   %rbp
  2c0a58:	48 89 e5             	mov    %rsp,%rbp
  2c0a5b:	48 83 ec 28          	sub    $0x28,%rsp
  2c0a5f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0a63:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0a67:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0a6b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0a6f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0a73:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0a77:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c0a7b:	eb 1c                	jmp    2c0a99 <memcpy+0x42>
        *d = *s;
  2c0a7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a81:	0f b6 10             	movzbl (%rax),%edx
  2c0a84:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0a88:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0a8a:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0a8f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0a94:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c0a99:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0a9e:	75 dd                	jne    2c0a7d <memcpy+0x26>
    }
    return dst;
  2c0aa0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0aa4:	c9                   	leave  
  2c0aa5:	c3                   	ret    

00000000002c0aa6 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c0aa6:	55                   	push   %rbp
  2c0aa7:	48 89 e5             	mov    %rsp,%rbp
  2c0aaa:	48 83 ec 28          	sub    $0x28,%rsp
  2c0aae:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0ab2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0ab6:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0aba:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0abe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c0ac2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0ac6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c0aca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0ace:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c0ad2:	73 6a                	jae    2c0b3e <memmove+0x98>
  2c0ad4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0ad8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0adc:	48 01 d0             	add    %rdx,%rax
  2c0adf:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c0ae3:	73 59                	jae    2c0b3e <memmove+0x98>
        s += n, d += n;
  2c0ae5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0ae9:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c0aed:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0af1:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c0af5:	eb 17                	jmp    2c0b0e <memmove+0x68>
            *--d = *--s;
  2c0af7:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c0afc:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c0b01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0b05:	0f b6 10             	movzbl (%rax),%edx
  2c0b08:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0b0c:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0b0e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0b12:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0b16:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0b1a:	48 85 c0             	test   %rax,%rax
  2c0b1d:	75 d8                	jne    2c0af7 <memmove+0x51>
    if (s < d && s + n > d) {
  2c0b1f:	eb 2e                	jmp    2c0b4f <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c0b21:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0b25:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0b29:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0b2d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0b31:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0b35:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c0b39:	0f b6 12             	movzbl (%rdx),%edx
  2c0b3c:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0b3e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0b42:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0b46:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0b4a:	48 85 c0             	test   %rax,%rax
  2c0b4d:	75 d2                	jne    2c0b21 <memmove+0x7b>
        }
    }
    return dst;
  2c0b4f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0b53:	c9                   	leave  
  2c0b54:	c3                   	ret    

00000000002c0b55 <memset>:

void* memset(void* v, int c, size_t n) {
  2c0b55:	55                   	push   %rbp
  2c0b56:	48 89 e5             	mov    %rsp,%rbp
  2c0b59:	48 83 ec 28          	sub    $0x28,%rsp
  2c0b5d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0b61:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c0b64:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0b68:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0b6c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0b70:	eb 15                	jmp    2c0b87 <memset+0x32>
        *p = c;
  2c0b72:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0b75:	89 c2                	mov    %eax,%edx
  2c0b77:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0b7b:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0b7d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0b82:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0b87:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0b8c:	75 e4                	jne    2c0b72 <memset+0x1d>
    }
    return v;
  2c0b8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0b92:	c9                   	leave  
  2c0b93:	c3                   	ret    

00000000002c0b94 <strlen>:

size_t strlen(const char* s) {
  2c0b94:	55                   	push   %rbp
  2c0b95:	48 89 e5             	mov    %rsp,%rbp
  2c0b98:	48 83 ec 18          	sub    $0x18,%rsp
  2c0b9c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c0ba0:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0ba7:	00 
  2c0ba8:	eb 0a                	jmp    2c0bb4 <strlen+0x20>
        ++n;
  2c0baa:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c0baf:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0bb4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0bb8:	0f b6 00             	movzbl (%rax),%eax
  2c0bbb:	84 c0                	test   %al,%al
  2c0bbd:	75 eb                	jne    2c0baa <strlen+0x16>
    }
    return n;
  2c0bbf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0bc3:	c9                   	leave  
  2c0bc4:	c3                   	ret    

00000000002c0bc5 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c0bc5:	55                   	push   %rbp
  2c0bc6:	48 89 e5             	mov    %rsp,%rbp
  2c0bc9:	48 83 ec 20          	sub    $0x20,%rsp
  2c0bcd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0bd1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0bd5:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0bdc:	00 
  2c0bdd:	eb 0a                	jmp    2c0be9 <strnlen+0x24>
        ++n;
  2c0bdf:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0be4:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0be9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0bed:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c0bf1:	74 0b                	je     2c0bfe <strnlen+0x39>
  2c0bf3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0bf7:	0f b6 00             	movzbl (%rax),%eax
  2c0bfa:	84 c0                	test   %al,%al
  2c0bfc:	75 e1                	jne    2c0bdf <strnlen+0x1a>
    }
    return n;
  2c0bfe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0c02:	c9                   	leave  
  2c0c03:	c3                   	ret    

00000000002c0c04 <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c0c04:	55                   	push   %rbp
  2c0c05:	48 89 e5             	mov    %rsp,%rbp
  2c0c08:	48 83 ec 20          	sub    $0x20,%rsp
  2c0c0c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0c10:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c0c14:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0c18:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c0c1c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c0c20:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0c24:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c0c28:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c2c:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0c30:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c0c34:	0f b6 12             	movzbl (%rdx),%edx
  2c0c37:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c0c39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c3d:	48 83 e8 01          	sub    $0x1,%rax
  2c0c41:	0f b6 00             	movzbl (%rax),%eax
  2c0c44:	84 c0                	test   %al,%al
  2c0c46:	75 d4                	jne    2c0c1c <strcpy+0x18>
    return dst;
  2c0c48:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0c4c:	c9                   	leave  
  2c0c4d:	c3                   	ret    

00000000002c0c4e <strcmp>:

int strcmp(const char* a, const char* b) {
  2c0c4e:	55                   	push   %rbp
  2c0c4f:	48 89 e5             	mov    %rsp,%rbp
  2c0c52:	48 83 ec 10          	sub    $0x10,%rsp
  2c0c56:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0c5a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0c5e:	eb 0a                	jmp    2c0c6a <strcmp+0x1c>
        ++a, ++b;
  2c0c60:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0c65:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0c6a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c6e:	0f b6 00             	movzbl (%rax),%eax
  2c0c71:	84 c0                	test   %al,%al
  2c0c73:	74 1d                	je     2c0c92 <strcmp+0x44>
  2c0c75:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0c79:	0f b6 00             	movzbl (%rax),%eax
  2c0c7c:	84 c0                	test   %al,%al
  2c0c7e:	74 12                	je     2c0c92 <strcmp+0x44>
  2c0c80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c84:	0f b6 10             	movzbl (%rax),%edx
  2c0c87:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0c8b:	0f b6 00             	movzbl (%rax),%eax
  2c0c8e:	38 c2                	cmp    %al,%dl
  2c0c90:	74 ce                	je     2c0c60 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c0c92:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c96:	0f b6 00             	movzbl (%rax),%eax
  2c0c99:	89 c2                	mov    %eax,%edx
  2c0c9b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0c9f:	0f b6 00             	movzbl (%rax),%eax
  2c0ca2:	38 d0                	cmp    %dl,%al
  2c0ca4:	0f 92 c0             	setb   %al
  2c0ca7:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c0caa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0cae:	0f b6 00             	movzbl (%rax),%eax
  2c0cb1:	89 c1                	mov    %eax,%ecx
  2c0cb3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0cb7:	0f b6 00             	movzbl (%rax),%eax
  2c0cba:	38 c1                	cmp    %al,%cl
  2c0cbc:	0f 92 c0             	setb   %al
  2c0cbf:	0f b6 c0             	movzbl %al,%eax
  2c0cc2:	29 c2                	sub    %eax,%edx
  2c0cc4:	89 d0                	mov    %edx,%eax
}
  2c0cc6:	c9                   	leave  
  2c0cc7:	c3                   	ret    

00000000002c0cc8 <strchr>:

char* strchr(const char* s, int c) {
  2c0cc8:	55                   	push   %rbp
  2c0cc9:	48 89 e5             	mov    %rsp,%rbp
  2c0ccc:	48 83 ec 10          	sub    $0x10,%rsp
  2c0cd0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0cd4:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c0cd7:	eb 05                	jmp    2c0cde <strchr+0x16>
        ++s;
  2c0cd9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c0cde:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0ce2:	0f b6 00             	movzbl (%rax),%eax
  2c0ce5:	84 c0                	test   %al,%al
  2c0ce7:	74 0e                	je     2c0cf7 <strchr+0x2f>
  2c0ce9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0ced:	0f b6 00             	movzbl (%rax),%eax
  2c0cf0:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0cf3:	38 d0                	cmp    %dl,%al
  2c0cf5:	75 e2                	jne    2c0cd9 <strchr+0x11>
    }
    if (*s == (char) c) {
  2c0cf7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0cfb:	0f b6 00             	movzbl (%rax),%eax
  2c0cfe:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0d01:	38 d0                	cmp    %dl,%al
  2c0d03:	75 06                	jne    2c0d0b <strchr+0x43>
        return (char*) s;
  2c0d05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0d09:	eb 05                	jmp    2c0d10 <strchr+0x48>
    } else {
        return NULL;
  2c0d0b:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c0d10:	c9                   	leave  
  2c0d11:	c3                   	ret    

00000000002c0d12 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c0d12:	55                   	push   %rbp
  2c0d13:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c0d16:	8b 05 0c 13 00 00    	mov    0x130c(%rip),%eax        # 2c2028 <rand_seed_set>
  2c0d1c:	85 c0                	test   %eax,%eax
  2c0d1e:	75 0a                	jne    2c0d2a <rand+0x18>
        srand(819234718U);
  2c0d20:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c0d25:	e8 24 00 00 00       	call   2c0d4e <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c0d2a:	8b 05 fc 12 00 00    	mov    0x12fc(%rip),%eax        # 2c202c <rand_seed>
  2c0d30:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c0d36:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c0d3b:	89 05 eb 12 00 00    	mov    %eax,0x12eb(%rip)        # 2c202c <rand_seed>
    return rand_seed & RAND_MAX;
  2c0d41:	8b 05 e5 12 00 00    	mov    0x12e5(%rip),%eax        # 2c202c <rand_seed>
  2c0d47:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c0d4c:	5d                   	pop    %rbp
  2c0d4d:	c3                   	ret    

00000000002c0d4e <srand>:

void srand(unsigned seed) {
  2c0d4e:	55                   	push   %rbp
  2c0d4f:	48 89 e5             	mov    %rsp,%rbp
  2c0d52:	48 83 ec 08          	sub    $0x8,%rsp
  2c0d56:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c0d59:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c0d5c:	89 05 ca 12 00 00    	mov    %eax,0x12ca(%rip)        # 2c202c <rand_seed>
    rand_seed_set = 1;
  2c0d62:	c7 05 bc 12 00 00 01 	movl   $0x1,0x12bc(%rip)        # 2c2028 <rand_seed_set>
  2c0d69:	00 00 00 
}
  2c0d6c:	90                   	nop
  2c0d6d:	c9                   	leave  
  2c0d6e:	c3                   	ret    

00000000002c0d6f <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c0d6f:	55                   	push   %rbp
  2c0d70:	48 89 e5             	mov    %rsp,%rbp
  2c0d73:	48 83 ec 28          	sub    $0x28,%rsp
  2c0d77:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0d7b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0d7f:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c0d82:	48 c7 45 f8 e0 1d 2c 	movq   $0x2c1de0,-0x8(%rbp)
  2c0d89:	00 
    if (base < 0) {
  2c0d8a:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c0d8e:	79 0b                	jns    2c0d9b <fill_numbuf+0x2c>
        digits = lower_digits;
  2c0d90:	48 c7 45 f8 00 1e 2c 	movq   $0x2c1e00,-0x8(%rbp)
  2c0d97:	00 
        base = -base;
  2c0d98:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c0d9b:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0da0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0da4:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c0da7:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0daa:	48 63 c8             	movslq %eax,%rcx
  2c0dad:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0db1:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0db6:	48 f7 f1             	div    %rcx
  2c0db9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0dbd:	48 01 d0             	add    %rdx,%rax
  2c0dc0:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0dc5:	0f b6 10             	movzbl (%rax),%edx
  2c0dc8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0dcc:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c0dce:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0dd1:	48 63 f0             	movslq %eax,%rsi
  2c0dd4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0dd8:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0ddd:	48 f7 f6             	div    %rsi
  2c0de0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c0de4:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c0de9:	75 bc                	jne    2c0da7 <fill_numbuf+0x38>
    return numbuf_end;
  2c0deb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0def:	c9                   	leave  
  2c0df0:	c3                   	ret    

00000000002c0df1 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c0df1:	55                   	push   %rbp
  2c0df2:	48 89 e5             	mov    %rsp,%rbp
  2c0df5:	53                   	push   %rbx
  2c0df6:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c0dfd:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c0e04:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c0e0a:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0e11:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c0e18:	e9 8a 09 00 00       	jmp    2c17a7 <printer_vprintf+0x9b6>
        if (*format != '%') {
  2c0e1d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e24:	0f b6 00             	movzbl (%rax),%eax
  2c0e27:	3c 25                	cmp    $0x25,%al
  2c0e29:	74 31                	je     2c0e5c <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  2c0e2b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0e32:	4c 8b 00             	mov    (%rax),%r8
  2c0e35:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e3c:	0f b6 00             	movzbl (%rax),%eax
  2c0e3f:	0f b6 c8             	movzbl %al,%ecx
  2c0e42:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c0e48:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0e4f:	89 ce                	mov    %ecx,%esi
  2c0e51:	48 89 c7             	mov    %rax,%rdi
  2c0e54:	41 ff d0             	call   *%r8
            continue;
  2c0e57:	e9 43 09 00 00       	jmp    2c179f <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  2c0e5c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0e63:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0e6a:	01 
  2c0e6b:	eb 44                	jmp    2c0eb1 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  2c0e6d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e74:	0f b6 00             	movzbl (%rax),%eax
  2c0e77:	0f be c0             	movsbl %al,%eax
  2c0e7a:	89 c6                	mov    %eax,%esi
  2c0e7c:	bf 00 1c 2c 00       	mov    $0x2c1c00,%edi
  2c0e81:	e8 42 fe ff ff       	call   2c0cc8 <strchr>
  2c0e86:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c0e8a:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c0e8f:	74 30                	je     2c0ec1 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  2c0e91:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c0e95:	48 2d 00 1c 2c 00    	sub    $0x2c1c00,%rax
  2c0e9b:	ba 01 00 00 00       	mov    $0x1,%edx
  2c0ea0:	89 c1                	mov    %eax,%ecx
  2c0ea2:	d3 e2                	shl    %cl,%edx
  2c0ea4:	89 d0                	mov    %edx,%eax
  2c0ea6:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0ea9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0eb0:	01 
  2c0eb1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0eb8:	0f b6 00             	movzbl (%rax),%eax
  2c0ebb:	84 c0                	test   %al,%al
  2c0ebd:	75 ae                	jne    2c0e6d <printer_vprintf+0x7c>
  2c0ebf:	eb 01                	jmp    2c0ec2 <printer_vprintf+0xd1>
            } else {
                break;
  2c0ec1:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c0ec2:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c0ec9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ed0:	0f b6 00             	movzbl (%rax),%eax
  2c0ed3:	3c 30                	cmp    $0x30,%al
  2c0ed5:	7e 67                	jle    2c0f3e <printer_vprintf+0x14d>
  2c0ed7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ede:	0f b6 00             	movzbl (%rax),%eax
  2c0ee1:	3c 39                	cmp    $0x39,%al
  2c0ee3:	7f 59                	jg     2c0f3e <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0ee5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c0eec:	eb 2e                	jmp    2c0f1c <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  2c0eee:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c0ef1:	89 d0                	mov    %edx,%eax
  2c0ef3:	c1 e0 02             	shl    $0x2,%eax
  2c0ef6:	01 d0                	add    %edx,%eax
  2c0ef8:	01 c0                	add    %eax,%eax
  2c0efa:	89 c1                	mov    %eax,%ecx
  2c0efc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0f03:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0f07:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0f0e:	0f b6 00             	movzbl (%rax),%eax
  2c0f11:	0f be c0             	movsbl %al,%eax
  2c0f14:	01 c8                	add    %ecx,%eax
  2c0f16:	83 e8 30             	sub    $0x30,%eax
  2c0f19:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0f1c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0f23:	0f b6 00             	movzbl (%rax),%eax
  2c0f26:	3c 2f                	cmp    $0x2f,%al
  2c0f28:	0f 8e 85 00 00 00    	jle    2c0fb3 <printer_vprintf+0x1c2>
  2c0f2e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0f35:	0f b6 00             	movzbl (%rax),%eax
  2c0f38:	3c 39                	cmp    $0x39,%al
  2c0f3a:	7e b2                	jle    2c0eee <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  2c0f3c:	eb 75                	jmp    2c0fb3 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  2c0f3e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0f45:	0f b6 00             	movzbl (%rax),%eax
  2c0f48:	3c 2a                	cmp    $0x2a,%al
  2c0f4a:	75 68                	jne    2c0fb4 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  2c0f4c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f53:	8b 00                	mov    (%rax),%eax
  2c0f55:	83 f8 2f             	cmp    $0x2f,%eax
  2c0f58:	77 30                	ja     2c0f8a <printer_vprintf+0x199>
  2c0f5a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f61:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0f65:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f6c:	8b 00                	mov    (%rax),%eax
  2c0f6e:	89 c0                	mov    %eax,%eax
  2c0f70:	48 01 d0             	add    %rdx,%rax
  2c0f73:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f7a:	8b 12                	mov    (%rdx),%edx
  2c0f7c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0f7f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f86:	89 0a                	mov    %ecx,(%rdx)
  2c0f88:	eb 1a                	jmp    2c0fa4 <printer_vprintf+0x1b3>
  2c0f8a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f91:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0f95:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0f99:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0fa0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0fa4:	8b 00                	mov    (%rax),%eax
  2c0fa6:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c0fa9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0fb0:	01 
  2c0fb1:	eb 01                	jmp    2c0fb4 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  2c0fb3:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c0fb4:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c0fbb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0fc2:	0f b6 00             	movzbl (%rax),%eax
  2c0fc5:	3c 2e                	cmp    $0x2e,%al
  2c0fc7:	0f 85 00 01 00 00    	jne    2c10cd <printer_vprintf+0x2dc>
            ++format;
  2c0fcd:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0fd4:	01 
            if (*format >= '0' && *format <= '9') {
  2c0fd5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0fdc:	0f b6 00             	movzbl (%rax),%eax
  2c0fdf:	3c 2f                	cmp    $0x2f,%al
  2c0fe1:	7e 67                	jle    2c104a <printer_vprintf+0x259>
  2c0fe3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0fea:	0f b6 00             	movzbl (%rax),%eax
  2c0fed:	3c 39                	cmp    $0x39,%al
  2c0fef:	7f 59                	jg     2c104a <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0ff1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c0ff8:	eb 2e                	jmp    2c1028 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  2c0ffa:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c0ffd:	89 d0                	mov    %edx,%eax
  2c0fff:	c1 e0 02             	shl    $0x2,%eax
  2c1002:	01 d0                	add    %edx,%eax
  2c1004:	01 c0                	add    %eax,%eax
  2c1006:	89 c1                	mov    %eax,%ecx
  2c1008:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c100f:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c1013:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c101a:	0f b6 00             	movzbl (%rax),%eax
  2c101d:	0f be c0             	movsbl %al,%eax
  2c1020:	01 c8                	add    %ecx,%eax
  2c1022:	83 e8 30             	sub    $0x30,%eax
  2c1025:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c1028:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c102f:	0f b6 00             	movzbl (%rax),%eax
  2c1032:	3c 2f                	cmp    $0x2f,%al
  2c1034:	0f 8e 85 00 00 00    	jle    2c10bf <printer_vprintf+0x2ce>
  2c103a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1041:	0f b6 00             	movzbl (%rax),%eax
  2c1044:	3c 39                	cmp    $0x39,%al
  2c1046:	7e b2                	jle    2c0ffa <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  2c1048:	eb 75                	jmp    2c10bf <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  2c104a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1051:	0f b6 00             	movzbl (%rax),%eax
  2c1054:	3c 2a                	cmp    $0x2a,%al
  2c1056:	75 68                	jne    2c10c0 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  2c1058:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c105f:	8b 00                	mov    (%rax),%eax
  2c1061:	83 f8 2f             	cmp    $0x2f,%eax
  2c1064:	77 30                	ja     2c1096 <printer_vprintf+0x2a5>
  2c1066:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c106d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1071:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1078:	8b 00                	mov    (%rax),%eax
  2c107a:	89 c0                	mov    %eax,%eax
  2c107c:	48 01 d0             	add    %rdx,%rax
  2c107f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1086:	8b 12                	mov    (%rdx),%edx
  2c1088:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c108b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1092:	89 0a                	mov    %ecx,(%rdx)
  2c1094:	eb 1a                	jmp    2c10b0 <printer_vprintf+0x2bf>
  2c1096:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c109d:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c10a1:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c10a5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10ac:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c10b0:	8b 00                	mov    (%rax),%eax
  2c10b2:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c10b5:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c10bc:	01 
  2c10bd:	eb 01                	jmp    2c10c0 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  2c10bf:	90                   	nop
            }
            if (precision < 0) {
  2c10c0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c10c4:	79 07                	jns    2c10cd <printer_vprintf+0x2dc>
                precision = 0;
  2c10c6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c10cd:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c10d4:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c10db:	00 
        int length = 0;
  2c10dc:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c10e3:	48 c7 45 c8 06 1c 2c 	movq   $0x2c1c06,-0x38(%rbp)
  2c10ea:	00 
    again:
        switch (*format) {
  2c10eb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c10f2:	0f b6 00             	movzbl (%rax),%eax
  2c10f5:	0f be c0             	movsbl %al,%eax
  2c10f8:	83 e8 43             	sub    $0x43,%eax
  2c10fb:	83 f8 37             	cmp    $0x37,%eax
  2c10fe:	0f 87 9f 03 00 00    	ja     2c14a3 <printer_vprintf+0x6b2>
  2c1104:	89 c0                	mov    %eax,%eax
  2c1106:	48 8b 04 c5 18 1c 2c 	mov    0x2c1c18(,%rax,8),%rax
  2c110d:	00 
  2c110e:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  2c1110:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c1117:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c111e:	01 
            goto again;
  2c111f:	eb ca                	jmp    2c10eb <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c1121:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c1125:	74 5d                	je     2c1184 <printer_vprintf+0x393>
  2c1127:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c112e:	8b 00                	mov    (%rax),%eax
  2c1130:	83 f8 2f             	cmp    $0x2f,%eax
  2c1133:	77 30                	ja     2c1165 <printer_vprintf+0x374>
  2c1135:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c113c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1140:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1147:	8b 00                	mov    (%rax),%eax
  2c1149:	89 c0                	mov    %eax,%eax
  2c114b:	48 01 d0             	add    %rdx,%rax
  2c114e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1155:	8b 12                	mov    (%rdx),%edx
  2c1157:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c115a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1161:	89 0a                	mov    %ecx,(%rdx)
  2c1163:	eb 1a                	jmp    2c117f <printer_vprintf+0x38e>
  2c1165:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c116c:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1170:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1174:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c117b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c117f:	48 8b 00             	mov    (%rax),%rax
  2c1182:	eb 5c                	jmp    2c11e0 <printer_vprintf+0x3ef>
  2c1184:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c118b:	8b 00                	mov    (%rax),%eax
  2c118d:	83 f8 2f             	cmp    $0x2f,%eax
  2c1190:	77 30                	ja     2c11c2 <printer_vprintf+0x3d1>
  2c1192:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1199:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c119d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11a4:	8b 00                	mov    (%rax),%eax
  2c11a6:	89 c0                	mov    %eax,%eax
  2c11a8:	48 01 d0             	add    %rdx,%rax
  2c11ab:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c11b2:	8b 12                	mov    (%rdx),%edx
  2c11b4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c11b7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c11be:	89 0a                	mov    %ecx,(%rdx)
  2c11c0:	eb 1a                	jmp    2c11dc <printer_vprintf+0x3eb>
  2c11c2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11c9:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c11cd:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c11d1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c11d8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c11dc:	8b 00                	mov    (%rax),%eax
  2c11de:	48 98                	cltq   
  2c11e0:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c11e4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c11e8:	48 c1 f8 38          	sar    $0x38,%rax
  2c11ec:	25 80 00 00 00       	and    $0x80,%eax
  2c11f1:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c11f4:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c11f8:	74 09                	je     2c1203 <printer_vprintf+0x412>
  2c11fa:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c11fe:	48 f7 d8             	neg    %rax
  2c1201:	eb 04                	jmp    2c1207 <printer_vprintf+0x416>
  2c1203:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1207:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c120b:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c120e:	83 c8 60             	or     $0x60,%eax
  2c1211:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c1214:	e9 cf 02 00 00       	jmp    2c14e8 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c1219:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c121d:	74 5d                	je     2c127c <printer_vprintf+0x48b>
  2c121f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1226:	8b 00                	mov    (%rax),%eax
  2c1228:	83 f8 2f             	cmp    $0x2f,%eax
  2c122b:	77 30                	ja     2c125d <printer_vprintf+0x46c>
  2c122d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1234:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1238:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c123f:	8b 00                	mov    (%rax),%eax
  2c1241:	89 c0                	mov    %eax,%eax
  2c1243:	48 01 d0             	add    %rdx,%rax
  2c1246:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c124d:	8b 12                	mov    (%rdx),%edx
  2c124f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1252:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1259:	89 0a                	mov    %ecx,(%rdx)
  2c125b:	eb 1a                	jmp    2c1277 <printer_vprintf+0x486>
  2c125d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1264:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1268:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c126c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1273:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1277:	48 8b 00             	mov    (%rax),%rax
  2c127a:	eb 5c                	jmp    2c12d8 <printer_vprintf+0x4e7>
  2c127c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1283:	8b 00                	mov    (%rax),%eax
  2c1285:	83 f8 2f             	cmp    $0x2f,%eax
  2c1288:	77 30                	ja     2c12ba <printer_vprintf+0x4c9>
  2c128a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1291:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1295:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c129c:	8b 00                	mov    (%rax),%eax
  2c129e:	89 c0                	mov    %eax,%eax
  2c12a0:	48 01 d0             	add    %rdx,%rax
  2c12a3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c12aa:	8b 12                	mov    (%rdx),%edx
  2c12ac:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c12af:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c12b6:	89 0a                	mov    %ecx,(%rdx)
  2c12b8:	eb 1a                	jmp    2c12d4 <printer_vprintf+0x4e3>
  2c12ba:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c12c1:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c12c5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c12c9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c12d0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c12d4:	8b 00                	mov    (%rax),%eax
  2c12d6:	89 c0                	mov    %eax,%eax
  2c12d8:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c12dc:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c12e0:	e9 03 02 00 00       	jmp    2c14e8 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  2c12e5:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c12ec:	e9 28 ff ff ff       	jmp    2c1219 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  2c12f1:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c12f8:	e9 1c ff ff ff       	jmp    2c1219 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c12fd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1304:	8b 00                	mov    (%rax),%eax
  2c1306:	83 f8 2f             	cmp    $0x2f,%eax
  2c1309:	77 30                	ja     2c133b <printer_vprintf+0x54a>
  2c130b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1312:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1316:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c131d:	8b 00                	mov    (%rax),%eax
  2c131f:	89 c0                	mov    %eax,%eax
  2c1321:	48 01 d0             	add    %rdx,%rax
  2c1324:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c132b:	8b 12                	mov    (%rdx),%edx
  2c132d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1330:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1337:	89 0a                	mov    %ecx,(%rdx)
  2c1339:	eb 1a                	jmp    2c1355 <printer_vprintf+0x564>
  2c133b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1342:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1346:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c134a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1351:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1355:	48 8b 00             	mov    (%rax),%rax
  2c1358:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c135c:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c1363:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c136a:	e9 79 01 00 00       	jmp    2c14e8 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  2c136f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1376:	8b 00                	mov    (%rax),%eax
  2c1378:	83 f8 2f             	cmp    $0x2f,%eax
  2c137b:	77 30                	ja     2c13ad <printer_vprintf+0x5bc>
  2c137d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1384:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1388:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c138f:	8b 00                	mov    (%rax),%eax
  2c1391:	89 c0                	mov    %eax,%eax
  2c1393:	48 01 d0             	add    %rdx,%rax
  2c1396:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c139d:	8b 12                	mov    (%rdx),%edx
  2c139f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c13a2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c13a9:	89 0a                	mov    %ecx,(%rdx)
  2c13ab:	eb 1a                	jmp    2c13c7 <printer_vprintf+0x5d6>
  2c13ad:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13b4:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c13b8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c13bc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c13c3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c13c7:	48 8b 00             	mov    (%rax),%rax
  2c13ca:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c13ce:	e9 15 01 00 00       	jmp    2c14e8 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  2c13d3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13da:	8b 00                	mov    (%rax),%eax
  2c13dc:	83 f8 2f             	cmp    $0x2f,%eax
  2c13df:	77 30                	ja     2c1411 <printer_vprintf+0x620>
  2c13e1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13e8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c13ec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13f3:	8b 00                	mov    (%rax),%eax
  2c13f5:	89 c0                	mov    %eax,%eax
  2c13f7:	48 01 d0             	add    %rdx,%rax
  2c13fa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1401:	8b 12                	mov    (%rdx),%edx
  2c1403:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1406:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c140d:	89 0a                	mov    %ecx,(%rdx)
  2c140f:	eb 1a                	jmp    2c142b <printer_vprintf+0x63a>
  2c1411:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1418:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c141c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1420:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1427:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c142b:	8b 00                	mov    (%rax),%eax
  2c142d:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c1433:	e9 67 03 00 00       	jmp    2c179f <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  2c1438:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c143c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c1440:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1447:	8b 00                	mov    (%rax),%eax
  2c1449:	83 f8 2f             	cmp    $0x2f,%eax
  2c144c:	77 30                	ja     2c147e <printer_vprintf+0x68d>
  2c144e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1455:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1459:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1460:	8b 00                	mov    (%rax),%eax
  2c1462:	89 c0                	mov    %eax,%eax
  2c1464:	48 01 d0             	add    %rdx,%rax
  2c1467:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c146e:	8b 12                	mov    (%rdx),%edx
  2c1470:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1473:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c147a:	89 0a                	mov    %ecx,(%rdx)
  2c147c:	eb 1a                	jmp    2c1498 <printer_vprintf+0x6a7>
  2c147e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1485:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1489:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c148d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1494:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1498:	8b 00                	mov    (%rax),%eax
  2c149a:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c149d:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c14a1:	eb 45                	jmp    2c14e8 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  2c14a3:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c14a7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c14ab:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c14b2:	0f b6 00             	movzbl (%rax),%eax
  2c14b5:	84 c0                	test   %al,%al
  2c14b7:	74 0c                	je     2c14c5 <printer_vprintf+0x6d4>
  2c14b9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c14c0:	0f b6 00             	movzbl (%rax),%eax
  2c14c3:	eb 05                	jmp    2c14ca <printer_vprintf+0x6d9>
  2c14c5:	b8 25 00 00 00       	mov    $0x25,%eax
  2c14ca:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c14cd:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c14d1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c14d8:	0f b6 00             	movzbl (%rax),%eax
  2c14db:	84 c0                	test   %al,%al
  2c14dd:	75 08                	jne    2c14e7 <printer_vprintf+0x6f6>
                format--;
  2c14df:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c14e6:	01 
            }
            break;
  2c14e7:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c14e8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c14eb:	83 e0 20             	and    $0x20,%eax
  2c14ee:	85 c0                	test   %eax,%eax
  2c14f0:	74 1e                	je     2c1510 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c14f2:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c14f6:	48 83 c0 18          	add    $0x18,%rax
  2c14fa:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c14fd:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c1501:	48 89 ce             	mov    %rcx,%rsi
  2c1504:	48 89 c7             	mov    %rax,%rdi
  2c1507:	e8 63 f8 ff ff       	call   2c0d6f <fill_numbuf>
  2c150c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c1510:	48 c7 45 c0 06 1c 2c 	movq   $0x2c1c06,-0x40(%rbp)
  2c1517:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c1518:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c151b:	83 e0 20             	and    $0x20,%eax
  2c151e:	85 c0                	test   %eax,%eax
  2c1520:	74 48                	je     2c156a <printer_vprintf+0x779>
  2c1522:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1525:	83 e0 40             	and    $0x40,%eax
  2c1528:	85 c0                	test   %eax,%eax
  2c152a:	74 3e                	je     2c156a <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  2c152c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c152f:	25 80 00 00 00       	and    $0x80,%eax
  2c1534:	85 c0                	test   %eax,%eax
  2c1536:	74 0a                	je     2c1542 <printer_vprintf+0x751>
                prefix = "-";
  2c1538:	48 c7 45 c0 07 1c 2c 	movq   $0x2c1c07,-0x40(%rbp)
  2c153f:	00 
            if (flags & FLAG_NEGATIVE) {
  2c1540:	eb 73                	jmp    2c15b5 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c1542:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1545:	83 e0 10             	and    $0x10,%eax
  2c1548:	85 c0                	test   %eax,%eax
  2c154a:	74 0a                	je     2c1556 <printer_vprintf+0x765>
                prefix = "+";
  2c154c:	48 c7 45 c0 09 1c 2c 	movq   $0x2c1c09,-0x40(%rbp)
  2c1553:	00 
            if (flags & FLAG_NEGATIVE) {
  2c1554:	eb 5f                	jmp    2c15b5 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c1556:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1559:	83 e0 08             	and    $0x8,%eax
  2c155c:	85 c0                	test   %eax,%eax
  2c155e:	74 55                	je     2c15b5 <printer_vprintf+0x7c4>
                prefix = " ";
  2c1560:	48 c7 45 c0 0b 1c 2c 	movq   $0x2c1c0b,-0x40(%rbp)
  2c1567:	00 
            if (flags & FLAG_NEGATIVE) {
  2c1568:	eb 4b                	jmp    2c15b5 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c156a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c156d:	83 e0 20             	and    $0x20,%eax
  2c1570:	85 c0                	test   %eax,%eax
  2c1572:	74 42                	je     2c15b6 <printer_vprintf+0x7c5>
  2c1574:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1577:	83 e0 01             	and    $0x1,%eax
  2c157a:	85 c0                	test   %eax,%eax
  2c157c:	74 38                	je     2c15b6 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  2c157e:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c1582:	74 06                	je     2c158a <printer_vprintf+0x799>
  2c1584:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c1588:	75 2c                	jne    2c15b6 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  2c158a:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c158f:	75 0c                	jne    2c159d <printer_vprintf+0x7ac>
  2c1591:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1594:	25 00 01 00 00       	and    $0x100,%eax
  2c1599:	85 c0                	test   %eax,%eax
  2c159b:	74 19                	je     2c15b6 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  2c159d:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c15a1:	75 07                	jne    2c15aa <printer_vprintf+0x7b9>
  2c15a3:	b8 0d 1c 2c 00       	mov    $0x2c1c0d,%eax
  2c15a8:	eb 05                	jmp    2c15af <printer_vprintf+0x7be>
  2c15aa:	b8 10 1c 2c 00       	mov    $0x2c1c10,%eax
  2c15af:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c15b3:	eb 01                	jmp    2c15b6 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  2c15b5:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c15b6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c15ba:	78 24                	js     2c15e0 <printer_vprintf+0x7ef>
  2c15bc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c15bf:	83 e0 20             	and    $0x20,%eax
  2c15c2:	85 c0                	test   %eax,%eax
  2c15c4:	75 1a                	jne    2c15e0 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  2c15c6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c15c9:	48 63 d0             	movslq %eax,%rdx
  2c15cc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c15d0:	48 89 d6             	mov    %rdx,%rsi
  2c15d3:	48 89 c7             	mov    %rax,%rdi
  2c15d6:	e8 ea f5 ff ff       	call   2c0bc5 <strnlen>
  2c15db:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c15de:	eb 0f                	jmp    2c15ef <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  2c15e0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c15e4:	48 89 c7             	mov    %rax,%rdi
  2c15e7:	e8 a8 f5 ff ff       	call   2c0b94 <strlen>
  2c15ec:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c15ef:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c15f2:	83 e0 20             	and    $0x20,%eax
  2c15f5:	85 c0                	test   %eax,%eax
  2c15f7:	74 20                	je     2c1619 <printer_vprintf+0x828>
  2c15f9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c15fd:	78 1a                	js     2c1619 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  2c15ff:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1602:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c1605:	7e 08                	jle    2c160f <printer_vprintf+0x81e>
  2c1607:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c160a:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c160d:	eb 05                	jmp    2c1614 <printer_vprintf+0x823>
  2c160f:	b8 00 00 00 00       	mov    $0x0,%eax
  2c1614:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c1617:	eb 5c                	jmp    2c1675 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c1619:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c161c:	83 e0 20             	and    $0x20,%eax
  2c161f:	85 c0                	test   %eax,%eax
  2c1621:	74 4b                	je     2c166e <printer_vprintf+0x87d>
  2c1623:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1626:	83 e0 02             	and    $0x2,%eax
  2c1629:	85 c0                	test   %eax,%eax
  2c162b:	74 41                	je     2c166e <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c162d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1630:	83 e0 04             	and    $0x4,%eax
  2c1633:	85 c0                	test   %eax,%eax
  2c1635:	75 37                	jne    2c166e <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  2c1637:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c163b:	48 89 c7             	mov    %rax,%rdi
  2c163e:	e8 51 f5 ff ff       	call   2c0b94 <strlen>
  2c1643:	89 c2                	mov    %eax,%edx
  2c1645:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c1648:	01 d0                	add    %edx,%eax
  2c164a:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c164d:	7e 1f                	jle    2c166e <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  2c164f:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c1652:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c1655:	89 c3                	mov    %eax,%ebx
  2c1657:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c165b:	48 89 c7             	mov    %rax,%rdi
  2c165e:	e8 31 f5 ff ff       	call   2c0b94 <strlen>
  2c1663:	89 c2                	mov    %eax,%edx
  2c1665:	89 d8                	mov    %ebx,%eax
  2c1667:	29 d0                	sub    %edx,%eax
  2c1669:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c166c:	eb 07                	jmp    2c1675 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  2c166e:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c1675:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c1678:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c167b:	01 d0                	add    %edx,%eax
  2c167d:	48 63 d8             	movslq %eax,%rbx
  2c1680:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1684:	48 89 c7             	mov    %rax,%rdi
  2c1687:	e8 08 f5 ff ff       	call   2c0b94 <strlen>
  2c168c:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c1690:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c1693:	29 d0                	sub    %edx,%eax
  2c1695:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c1698:	eb 25                	jmp    2c16bf <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  2c169a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c16a1:	48 8b 08             	mov    (%rax),%rcx
  2c16a4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c16aa:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c16b1:	be 20 00 00 00       	mov    $0x20,%esi
  2c16b6:	48 89 c7             	mov    %rax,%rdi
  2c16b9:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c16bb:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c16bf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c16c2:	83 e0 04             	and    $0x4,%eax
  2c16c5:	85 c0                	test   %eax,%eax
  2c16c7:	75 36                	jne    2c16ff <printer_vprintf+0x90e>
  2c16c9:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c16cd:	7f cb                	jg     2c169a <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  2c16cf:	eb 2e                	jmp    2c16ff <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  2c16d1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c16d8:	4c 8b 00             	mov    (%rax),%r8
  2c16db:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c16df:	0f b6 00             	movzbl (%rax),%eax
  2c16e2:	0f b6 c8             	movzbl %al,%ecx
  2c16e5:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c16eb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c16f2:	89 ce                	mov    %ecx,%esi
  2c16f4:	48 89 c7             	mov    %rax,%rdi
  2c16f7:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c16fa:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c16ff:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1703:	0f b6 00             	movzbl (%rax),%eax
  2c1706:	84 c0                	test   %al,%al
  2c1708:	75 c7                	jne    2c16d1 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  2c170a:	eb 25                	jmp    2c1731 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  2c170c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1713:	48 8b 08             	mov    (%rax),%rcx
  2c1716:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c171c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1723:	be 30 00 00 00       	mov    $0x30,%esi
  2c1728:	48 89 c7             	mov    %rax,%rdi
  2c172b:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c172d:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c1731:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c1735:	7f d5                	jg     2c170c <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  2c1737:	eb 32                	jmp    2c176b <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  2c1739:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1740:	4c 8b 00             	mov    (%rax),%r8
  2c1743:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1747:	0f b6 00             	movzbl (%rax),%eax
  2c174a:	0f b6 c8             	movzbl %al,%ecx
  2c174d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1753:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c175a:	89 ce                	mov    %ecx,%esi
  2c175c:	48 89 c7             	mov    %rax,%rdi
  2c175f:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c1762:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c1767:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c176b:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c176f:	7f c8                	jg     2c1739 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  2c1771:	eb 25                	jmp    2c1798 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  2c1773:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c177a:	48 8b 08             	mov    (%rax),%rcx
  2c177d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1783:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c178a:	be 20 00 00 00       	mov    $0x20,%esi
  2c178f:	48 89 c7             	mov    %rax,%rdi
  2c1792:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c1794:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c1798:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c179c:	7f d5                	jg     2c1773 <printer_vprintf+0x982>
        }
    done: ;
  2c179e:	90                   	nop
    for (; *format; ++format) {
  2c179f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c17a6:	01 
  2c17a7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c17ae:	0f b6 00             	movzbl (%rax),%eax
  2c17b1:	84 c0                	test   %al,%al
  2c17b3:	0f 85 64 f6 ff ff    	jne    2c0e1d <printer_vprintf+0x2c>
    }
}
  2c17b9:	90                   	nop
  2c17ba:	90                   	nop
  2c17bb:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c17bf:	c9                   	leave  
  2c17c0:	c3                   	ret    

00000000002c17c1 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c17c1:	55                   	push   %rbp
  2c17c2:	48 89 e5             	mov    %rsp,%rbp
  2c17c5:	48 83 ec 20          	sub    $0x20,%rsp
  2c17c9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c17cd:	89 f0                	mov    %esi,%eax
  2c17cf:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c17d2:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c17d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c17d9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c17dd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c17e1:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c17e5:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  2c17ea:	48 39 d0             	cmp    %rdx,%rax
  2c17ed:	72 0c                	jb     2c17fb <console_putc+0x3a>
        cp->cursor = console;
  2c17ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c17f3:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  2c17fa:	00 
    }
    if (c == '\n') {
  2c17fb:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c17ff:	75 78                	jne    2c1879 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  2c1801:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1805:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1809:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c180f:	48 d1 f8             	sar    %rax
  2c1812:	48 89 c1             	mov    %rax,%rcx
  2c1815:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c181c:	66 66 66 
  2c181f:	48 89 c8             	mov    %rcx,%rax
  2c1822:	48 f7 ea             	imul   %rdx
  2c1825:	48 c1 fa 05          	sar    $0x5,%rdx
  2c1829:	48 89 c8             	mov    %rcx,%rax
  2c182c:	48 c1 f8 3f          	sar    $0x3f,%rax
  2c1830:	48 29 c2             	sub    %rax,%rdx
  2c1833:	48 89 d0             	mov    %rdx,%rax
  2c1836:	48 c1 e0 02          	shl    $0x2,%rax
  2c183a:	48 01 d0             	add    %rdx,%rax
  2c183d:	48 c1 e0 04          	shl    $0x4,%rax
  2c1841:	48 29 c1             	sub    %rax,%rcx
  2c1844:	48 89 ca             	mov    %rcx,%rdx
  2c1847:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c184a:	eb 25                	jmp    2c1871 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  2c184c:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c184f:	83 c8 20             	or     $0x20,%eax
  2c1852:	89 c6                	mov    %eax,%esi
  2c1854:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1858:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c185c:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1860:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c1864:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1868:	89 f2                	mov    %esi,%edx
  2c186a:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c186d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1871:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c1875:	75 d5                	jne    2c184c <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c1877:	eb 24                	jmp    2c189d <console_putc+0xdc>
        *cp->cursor++ = c | color;
  2c1879:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  2c187d:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c1880:	09 d0                	or     %edx,%eax
  2c1882:	89 c6                	mov    %eax,%esi
  2c1884:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1888:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c188c:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1890:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c1894:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1898:	89 f2                	mov    %esi,%edx
  2c189a:	66 89 10             	mov    %dx,(%rax)
}
  2c189d:	90                   	nop
  2c189e:	c9                   	leave  
  2c189f:	c3                   	ret    

00000000002c18a0 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c18a0:	55                   	push   %rbp
  2c18a1:	48 89 e5             	mov    %rsp,%rbp
  2c18a4:	48 83 ec 30          	sub    $0x30,%rsp
  2c18a8:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c18ab:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c18ae:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c18b2:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c18b6:	48 c7 45 f0 c1 17 2c 	movq   $0x2c17c1,-0x10(%rbp)
  2c18bd:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c18be:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c18c2:	78 09                	js     2c18cd <console_vprintf+0x2d>
  2c18c4:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c18cb:	7e 07                	jle    2c18d4 <console_vprintf+0x34>
        cpos = 0;
  2c18cd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c18d4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c18d7:	48 98                	cltq   
  2c18d9:	48 01 c0             	add    %rax,%rax
  2c18dc:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  2c18e2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c18e6:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c18ea:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c18ee:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c18f1:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c18f5:	48 89 c7             	mov    %rax,%rdi
  2c18f8:	e8 f4 f4 ff ff       	call   2c0df1 <printer_vprintf>
    return cp.cursor - console;
  2c18fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1901:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c1907:	48 d1 f8             	sar    %rax
}
  2c190a:	c9                   	leave  
  2c190b:	c3                   	ret    

00000000002c190c <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c190c:	55                   	push   %rbp
  2c190d:	48 89 e5             	mov    %rsp,%rbp
  2c1910:	48 83 ec 60          	sub    $0x60,%rsp
  2c1914:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c1917:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c191a:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c191e:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1922:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c1926:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c192a:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c1931:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1935:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c1939:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c193d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c1941:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c1945:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c1949:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c194c:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c194f:	89 c7                	mov    %eax,%edi
  2c1951:	e8 4a ff ff ff       	call   2c18a0 <console_vprintf>
  2c1956:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c1959:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c195c:	c9                   	leave  
  2c195d:	c3                   	ret    

00000000002c195e <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c195e:	55                   	push   %rbp
  2c195f:	48 89 e5             	mov    %rsp,%rbp
  2c1962:	48 83 ec 20          	sub    $0x20,%rsp
  2c1966:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c196a:	89 f0                	mov    %esi,%eax
  2c196c:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c196f:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c1972:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1976:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c197a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c197e:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c1982:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1986:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c198a:	48 39 c2             	cmp    %rax,%rdx
  2c198d:	73 1a                	jae    2c19a9 <string_putc+0x4b>
        *sp->s++ = c;
  2c198f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1993:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1997:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c199b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c199f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c19a3:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c19a7:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c19a9:	90                   	nop
  2c19aa:	c9                   	leave  
  2c19ab:	c3                   	ret    

00000000002c19ac <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c19ac:	55                   	push   %rbp
  2c19ad:	48 89 e5             	mov    %rsp,%rbp
  2c19b0:	48 83 ec 40          	sub    $0x40,%rsp
  2c19b4:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c19b8:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c19bc:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c19c0:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c19c4:	48 c7 45 e8 5e 19 2c 	movq   $0x2c195e,-0x18(%rbp)
  2c19cb:	00 
    sp.s = s;
  2c19cc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c19d0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c19d4:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c19d9:	74 33                	je     2c1a0e <vsnprintf+0x62>
        sp.end = s + size - 1;
  2c19db:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c19df:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c19e3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c19e7:	48 01 d0             	add    %rdx,%rax
  2c19ea:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c19ee:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c19f2:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c19f6:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c19fa:	be 00 00 00 00       	mov    $0x0,%esi
  2c19ff:	48 89 c7             	mov    %rax,%rdi
  2c1a02:	e8 ea f3 ff ff       	call   2c0df1 <printer_vprintf>
        *sp.s = 0;
  2c1a07:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1a0b:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c1a0e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1a12:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c1a16:	c9                   	leave  
  2c1a17:	c3                   	ret    

00000000002c1a18 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c1a18:	55                   	push   %rbp
  2c1a19:	48 89 e5             	mov    %rsp,%rbp
  2c1a1c:	48 83 ec 70          	sub    $0x70,%rsp
  2c1a20:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c1a24:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c1a28:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c1a2c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1a30:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c1a34:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c1a38:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c1a3f:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1a43:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c1a47:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c1a4b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c1a4f:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c1a53:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c1a57:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c1a5b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1a5f:	48 89 c7             	mov    %rax,%rdi
  2c1a62:	e8 45 ff ff ff       	call   2c19ac <vsnprintf>
  2c1a67:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c1a6a:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c1a6d:	c9                   	leave  
  2c1a6e:	c3                   	ret    

00000000002c1a6f <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c1a6f:	55                   	push   %rbp
  2c1a70:	48 89 e5             	mov    %rsp,%rbp
  2c1a73:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c1a77:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c1a7e:	eb 13                	jmp    2c1a93 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  2c1a80:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c1a83:	48 98                	cltq   
  2c1a85:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  2c1a8c:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c1a8f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1a93:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c1a9a:	7e e4                	jle    2c1a80 <console_clear+0x11>
    }
    cursorpos = 0;
  2c1a9c:	c7 05 56 75 df ff 00 	movl   $0x0,-0x208aaa(%rip)        # b8ffc <cursorpos>
  2c1aa3:	00 00 00 
}
  2c1aa6:	90                   	nop
  2c1aa7:	c9                   	leave  
  2c1aa8:	c3                   	ret    
