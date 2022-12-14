
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
  2c0016:	e8 48 0a 00 00       	call   2c0a63 <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001b:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0020:	e8 ea 04 00 00       	call   2c050f <malloc>
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
  2c003f:	e8 b0 05 00 00       	call   2c05f4 <realloc>
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
  2c0067:	e8 55 05 00 00       	call   2c05c1 <calloc>
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
  2c0086:	e8 db 06 00 00       	call   2c0766 <heap_info>
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
  2c00b7:	ba c0 17 2c 00       	mov    $0x2c17c0,%edx
  2c00bc:	be 1a 00 00 00       	mov    $0x1a,%esi
  2c00c1:	bf ce 17 2c 00       	mov    $0x2c17ce,%edi
  2c00c6:	e8 13 02 00 00       	call   2c02de <assert_fail>
	assert(array2[i] == 0);
  2c00cb:	ba e4 17 2c 00       	mov    $0x2c17e4,%edx
  2c00d0:	be 22 00 00 00       	mov    $0x22,%esi
  2c00d5:	bf ce 17 2c 00       	mov    $0x2c17ce,%edi
  2c00da:	e8 ff 01 00 00       	call   2c02de <assert_fail>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00df:	ba 08 18 2c 00       	mov    $0x2c1808,%edx
  2c00e4:	be 29 00 00 00       	mov    $0x29,%esi
  2c00e9:	bf ce 17 2c 00       	mov    $0x2c17ce,%edi
  2c00ee:	e8 eb 01 00 00       	call   2c02de <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c00f3:	be f3 17 2c 00       	mov    $0x2c17f3,%esi
  2c00f8:	bf 00 00 00 00       	mov    $0x0,%edi
  2c00fd:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0102:	e8 79 00 00 00       	call   2c0180 <app_printf>
    }
    
    // free array, array2
    free(array);
  2c0107:	4c 89 ef             	mov    %r13,%rdi
  2c010a:	e8 5c 02 00 00       	call   2c036b <free>
    free(array2);
  2c010f:	4c 89 f7             	mov    %r14,%rdi
  2c0112:	e8 54 02 00 00       	call   2c036b <free>

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
  2c0130:	e8 da 03 00 00       	call   2c050f <malloc>
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
  2c016a:	be 38 18 2c 00       	mov    $0x2c1838,%esi
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
  2c01c8:	0f b6 b7 9d 18 2c 00 	movzbl 0x2c189d(%rdi),%esi
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
  2c01f6:	e8 ba 13 00 00       	call   2c15b5 <console_vprintf>
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
  2c024f:	be 68 18 2c 00       	mov    $0x2c1868,%esi
  2c0254:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  2c025b:	e8 0c 05 00 00       	call   2c076c <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0260:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0264:	48 89 da             	mov    %rbx,%rdx
  2c0267:	be 99 00 00 00       	mov    $0x99,%esi
  2c026c:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c0273:	e8 49 14 00 00       	call   2c16c1 <vsnprintf>
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
  2c0298:	ba 70 18 2c 00       	mov    $0x2c1870,%edx
  2c029d:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02a2:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02a7:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ac:	e8 70 13 00 00       	call   2c1621 <console_printf>
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
  2c02d2:	be 03 18 2c 00       	mov    $0x2c1803,%esi
  2c02d7:	e8 3d 06 00 00       	call   2c0919 <strcpy>
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
  2c02eb:	ba 78 18 2c 00       	mov    $0x2c1878,%edx
  2c02f0:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02f5:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02fa:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ff:	e8 1d 13 00 00       	call   2c1621 <console_printf>
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
  2c031b:	bf 08 00 00 00       	mov    $0x8,%edi
  2c0320:	cd 3a                	int    $0x3a
  2c0322:	48 89 c2             	mov    %rax,%rdx
  2c0325:	48 89 05 e4 1c 00 00 	mov    %rax,0x1ce4(%rip)        # 2c2010 <result.0>

	// prologue block
	void *prologue_block;
	sbrk(sizeof(block_header) + sizeof(block_header));
	prologue_block = sbrk(sizeof(block_footer));
	PUT(HDRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  2c032c:	48 c7 40 f8 11 00 00 	movq   $0x11,-0x8(%rax)
  2c0333:	00 
	PUT(FTRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  2c0334:	48 c7 00 11 00 00 00 	movq   $0x11,(%rax)
  2c033b:	cd 3a                	int    $0x3a
  2c033d:	48 89 05 cc 1c 00 00 	mov    %rax,0x1ccc(%rip)        # 2c2010 <result.0>

	// terminal block
	sbrk(sizeof(block_header));
	PUT(HDRP(NEXT_BLKP(prologue_block)), PACK(0, 1));	
  2c0344:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  2c0348:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c034c:	48 c7 44 02 f8 01 00 	movq   $0x1,-0x8(%rdx,%rax,1)
  2c0353:	00 00 

	free_list = NULL;
  2c0355:	48 c7 05 a0 1c 00 00 	movq   $0x0,0x1ca0(%rip)        # 2c2000 <free_list>
  2c035c:	00 00 00 00 

	initialized_heap = 1;
  2c0360:	c7 05 9e 1c 00 00 01 	movl   $0x1,0x1c9e(%rip)        # 2c2008 <initialized_heap>
  2c0367:	00 00 00 
}
  2c036a:	c3                   	ret    

00000000002c036b <free>:

void free(void *firstbyte) {
	if (firstbyte == NULL)
  2c036b:	48 85 ff             	test   %rdi,%rdi
  2c036e:	74 35                	je     2c03a5 <free+0x3a>
		return;

	// setup free things: alloc, list ptrs, footer
	PUT(HDRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  2c0370:	48 8b 47 f8          	mov    -0x8(%rdi),%rax
  2c0374:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c0378:	48 89 47 f8          	mov    %rax,-0x8(%rdi)
	NEXT_FPTR(firstbyte) = free_list;
  2c037c:	48 8b 15 7d 1c 00 00 	mov    0x1c7d(%rip),%rdx        # 2c2000 <free_list>
  2c0383:	48 89 17             	mov    %rdx,(%rdi)
	PREV_FPTR(firstbyte) = NULL;
  2c0386:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  2c038d:	00 
	PUT(FTRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  2c038e:	48 89 44 07 f0       	mov    %rax,-0x10(%rdi,%rax,1)

	// add to free_list
	PREV_FPTR(free_list) = firstbyte;
  2c0393:	48 8b 05 66 1c 00 00 	mov    0x1c66(%rip),%rax        # 2c2000 <free_list>
  2c039a:	48 89 78 08          	mov    %rdi,0x8(%rax)
	free_list = firstbyte;
  2c039e:	48 89 3d 5b 1c 00 00 	mov    %rdi,0x1c5b(%rip)        # 2c2000 <free_list>

	return;
}
  2c03a5:	c3                   	ret    

00000000002c03a6 <extend>:
//
//	the reason alloating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
int extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  2c03a6:	48 81 c7 ff 3f 00 00 	add    $0x3fff,%rdi
  2c03ad:	48 81 e7 00 c0 ff ff 	and    $0xffffffffffffc000,%rdi
  2c03b4:	cd 3a                	int    $0x3a
  2c03b6:	48 89 05 53 1c 00 00 	mov    %rax,0x1c53(%rip)        # 2c2010 <result.0>
	void *bp = sbrk(chunk_aligned_size);
	if (bp == (void *)-1)
  2c03bd:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c03c1:	74 51                	je     2c0414 <extend+0x6e>
		return -1;

	// setup pointer
	PUT(HDRP(bp), PACK(GET_SIZE(HDRP(bp)), 0));	
  2c03c3:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c03c7:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c03cb:	48 89 50 f8          	mov    %rdx,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  2c03cf:	48 8b 0d 2a 1c 00 00 	mov    0x1c2a(%rip),%rcx        # 2c2000 <free_list>
  2c03d6:	48 89 08             	mov    %rcx,(%rax)
	PREV_FPTR(bp) = NULL;
  2c03d9:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  2c03e0:	00 
	PUT(FTRP(bp), PACK(GET_SIZE(HDRP(bp)), 0));	
  2c03e1:	48 89 54 02 f0       	mov    %rdx,-0x10(%rdx,%rax,1)
	
	// add to head of free_list
	if (free_list)
  2c03e6:	48 8b 15 13 1c 00 00 	mov    0x1c13(%rip),%rdx        # 2c2000 <free_list>
  2c03ed:	48 85 d2             	test   %rdx,%rdx
  2c03f0:	74 04                	je     2c03f6 <extend+0x50>
		PREV_FPTR(free_list) = bp;
  2c03f2:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  2c03f6:	48 89 05 03 1c 00 00 	mov    %rax,0x1c03(%rip)        # 2c2000 <free_list>

	// update terminal block
	PUT(HDRP(NEXT_BLKP(bp)), PACK(0, 1));	
  2c03fd:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c0401:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c0405:	48 c7 44 10 f8 01 00 	movq   $0x1,-0x8(%rax,%rdx,1)
  2c040c:	00 00 

	return 0;
  2c040e:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0413:	c3                   	ret    
		return -1;
  2c0414:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  2c0419:	c3                   	ret    

00000000002c041a <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
  2c041a:	55                   	push   %rbp
  2c041b:	48 89 e5             	mov    %rsp,%rbp
  2c041e:	41 55                	push   %r13
  2c0420:	41 54                	push   %r12
  2c0422:	53                   	push   %rbx
  2c0423:	48 83 ec 08          	sub    $0x8,%rsp
  2c0427:	48 89 fb             	mov    %rdi,%rbx
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  2c042a:	4c 8b 6f f8          	mov    -0x8(%rdi),%r13
  2c042e:	49 83 e5 f0          	and    $0xfffffffffffffff0,%r13
  2c0432:	49 29 f5             	sub    %rsi,%r13

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  2c0435:	49 83 fd 20          	cmp    $0x20,%r13
  2c0439:	77 47                	ja     2c0482 <set_allocated+0x68>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
								    
	}
	else {
		// update the free list
		if (free_list == bp)
  2c043b:	48 39 3d be 1b 00 00 	cmp    %rdi,0x1bbe(%rip)        # 2c2000 <free_list>
  2c0442:	0f 84 b8 00 00 00    	je     2c0500 <set_allocated+0xe6>
			free_list = NEXT_FPTR(bp);

		if (PREV_FPTR(bp))
  2c0448:	48 8b 43 08          	mov    0x8(%rbx),%rax
  2c044c:	48 85 c0             	test   %rax,%rax
  2c044f:	74 06                	je     2c0457 <set_allocated+0x3d>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  2c0451:	48 8b 13             	mov    (%rbx),%rdx
  2c0454:	48 89 10             	mov    %rdx,(%rax)
		if (NEXT_FPTR(bp))
  2c0457:	48 8b 03             	mov    (%rbx),%rax
  2c045a:	48 85 c0             	test   %rax,%rax
  2c045d:	74 08                	je     2c0467 <set_allocated+0x4d>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  2c045f:	48 8b 53 08          	mov    0x8(%rbx),%rdx
  2c0463:	48 89 50 08          	mov    %rdx,0x8(%rax)

		PUT(HDRP(bp), PACK(GET_SIZE(HDRP(bp)), 1));	
  2c0467:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  2c046b:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c046f:	48 83 c8 01          	or     $0x1,%rax
  2c0473:	48 89 43 f8          	mov    %rax,-0x8(%rbx)
	}
}
  2c0477:	48 83 c4 08          	add    $0x8,%rsp
  2c047b:	5b                   	pop    %rbx
  2c047c:	41 5c                	pop    %r12
  2c047e:	41 5d                	pop    %r13
  2c0480:	5d                   	pop    %rbp
  2c0481:	c3                   	ret    
		PUT(HDRP(bp), PACK(size, 1));
  2c0482:	48 89 f0             	mov    %rsi,%rax
  2c0485:	48 83 c8 01          	or     $0x1,%rax
  2c0489:	48 89 47 f8          	mov    %rax,-0x8(%rdi)
		void *leftover_mem_ptr = NEXT_BLKP(bp);
  2c048d:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  2c0491:	4c 8d 24 37          	lea    (%rdi,%rsi,1),%r12
    asm volatile ("int %0" : /* no result */
  2c0495:	bf 01 00 00 00       	mov    $0x1,%edi
  2c049a:	cd 38                	int    $0x38
			app_printf(0x700,"%p ", bp);	
  2c049c:	48 89 da             	mov    %rbx,%rdx
  2c049f:	be a2 18 2c 00       	mov    $0x2c18a2,%esi
  2c04a4:	bf 00 07 00 00       	mov    $0x700,%edi
  2c04a9:	b8 00 00 00 00       	mov    $0x0,%eax
  2c04ae:	e8 cd fc ff ff       	call   2c0180 <app_printf>
		PUT(HDRP(leftover_mem_ptr), PACK(extra_size, 0));	
  2c04b3:	4d 89 6c 24 f8       	mov    %r13,-0x8(%r12)
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp); // pointers to the next free blocks
  2c04b8:	48 8b 03             	mov    (%rbx),%rax
  2c04bb:	49 89 04 24          	mov    %rax,(%r12)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  2c04bf:	48 8b 43 08          	mov    0x8(%rbx),%rax
  2c04c3:	49 89 44 24 08       	mov    %rax,0x8(%r12)
		PUT(FTRP(leftover_mem_ptr), PACK(extra_size, 0));	
  2c04c8:	4c 89 e8             	mov    %r13,%rax
  2c04cb:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c04cf:	4d 89 6c 04 f0       	mov    %r13,-0x10(%r12,%rax,1)
		if (free_list == bp)
  2c04d4:	48 39 1d 25 1b 00 00 	cmp    %rbx,0x1b25(%rip)        # 2c2000 <free_list>
  2c04db:	74 1a                	je     2c04f7 <set_allocated+0xdd>
		if (PREV_FPTR(bp))
  2c04dd:	48 8b 43 08          	mov    0x8(%rbx),%rax
  2c04e1:	48 85 c0             	test   %rax,%rax
  2c04e4:	74 03                	je     2c04e9 <set_allocated+0xcf>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  2c04e6:	4c 89 20             	mov    %r12,(%rax)
		if (NEXT_FPTR(bp))
  2c04e9:	48 8b 03             	mov    (%rbx),%rax
  2c04ec:	48 85 c0             	test   %rax,%rax
  2c04ef:	74 86                	je     2c0477 <set_allocated+0x5d>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  2c04f1:	4c 89 60 08          	mov    %r12,0x8(%rax)
  2c04f5:	eb 80                	jmp    2c0477 <set_allocated+0x5d>
			free_list = leftover_mem_ptr;
  2c04f7:	4c 89 25 02 1b 00 00 	mov    %r12,0x1b02(%rip)        # 2c2000 <free_list>
  2c04fe:	eb dd                	jmp    2c04dd <set_allocated+0xc3>
			free_list = NEXT_FPTR(bp);
  2c0500:	48 8b 07             	mov    (%rdi),%rax
  2c0503:	48 89 05 f6 1a 00 00 	mov    %rax,0x1af6(%rip)        # 2c2000 <free_list>
  2c050a:	e9 39 ff ff ff       	jmp    2c0448 <set_allocated+0x2e>

00000000002c050f <malloc>:

void *malloc(uint64_t numbytes) {
  2c050f:	55                   	push   %rbp
  2c0510:	48 89 e5             	mov    %rsp,%rbp
  2c0513:	41 55                	push   %r13
  2c0515:	41 54                	push   %r12
  2c0517:	53                   	push   %rbx
  2c0518:	48 83 ec 08          	sub    $0x8,%rsp
  2c051c:	49 89 fc             	mov    %rdi,%r12
	if (!initialized_heap)
  2c051f:	83 3d e2 1a 00 00 00 	cmpl   $0x0,0x1ae2(%rip)        # 2c2008 <initialized_heap>
  2c0526:	74 6b                	je     2c0593 <malloc+0x84>
		heap_init();

	if (numbytes == 0)
  2c0528:	4d 85 e4             	test   %r12,%r12
  2c052b:	0f 84 82 00 00 00    	je     2c05b3 <malloc+0xa4>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  2c0531:	49 83 c4 17          	add    $0x17,%r12
  2c0535:	49 83 e4 f0          	and    $0xfffffffffffffff0,%r12
  2c0539:	b8 20 00 00 00       	mov    $0x20,%eax
  2c053e:	49 39 c4             	cmp    %rax,%r12
  2c0541:	4c 0f 42 e0          	cmovb  %rax,%r12
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);


	void *bp = free_list;
  2c0545:	48 8b 1d b4 1a 00 00 	mov    0x1ab4(%rip),%rbx        # 2c2000 <free_list>
	while (bp) {
  2c054c:	48 85 db             	test   %rbx,%rbx
  2c054f:	74 15                	je     2c0566 <malloc+0x57>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  2c0551:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  2c0555:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c0559:	4c 39 e0             	cmp    %r12,%rax
  2c055c:	73 3c                	jae    2c059a <malloc+0x8b>
			set_allocated(bp, aligned_size);
			return bp;
		}

		bp = NEXT_FPTR(bp);
  2c055e:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  2c0561:	48 85 db             	test   %rbx,%rbx
  2c0564:	75 eb                	jne    2c0551 <malloc+0x42>
    asm volatile ("int %1" :  "=a" (result)
  2c0566:	bf 00 00 00 00       	mov    $0x0,%edi
  2c056b:	cd 3a                	int    $0x3a
  2c056d:	49 89 c5             	mov    %rax,%r13
  2c0570:	48 89 05 99 1a 00 00 	mov    %rax,0x1a99(%rip)        # 2c2010 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  2c0577:	48 89 c3             	mov    %rax,%rbx
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	if (extend(aligned_size)) {
  2c057a:	4c 89 e7             	mov    %r12,%rdi
  2c057d:	e8 24 fe ff ff       	call   2c03a6 <extend>
  2c0582:	85 c0                	test   %eax,%eax
  2c0584:	75 34                	jne    2c05ba <malloc+0xab>
		return NULL;
	}
	set_allocated(bp, aligned_size);
  2c0586:	4c 89 e6             	mov    %r12,%rsi
  2c0589:	4c 89 ef             	mov    %r13,%rdi
  2c058c:	e8 89 fe ff ff       	call   2c041a <set_allocated>
    return bp;
  2c0591:	eb 12                	jmp    2c05a5 <malloc+0x96>
		heap_init();
  2c0593:	e8 75 fd ff ff       	call   2c030d <heap_init>
  2c0598:	eb 8e                	jmp    2c0528 <malloc+0x19>
			set_allocated(bp, aligned_size);
  2c059a:	4c 89 e6             	mov    %r12,%rsi
  2c059d:	48 89 df             	mov    %rbx,%rdi
  2c05a0:	e8 75 fe ff ff       	call   2c041a <set_allocated>
}
  2c05a5:	48 89 d8             	mov    %rbx,%rax
  2c05a8:	48 83 c4 08          	add    $0x8,%rsp
  2c05ac:	5b                   	pop    %rbx
  2c05ad:	41 5c                	pop    %r12
  2c05af:	41 5d                	pop    %r13
  2c05b1:	5d                   	pop    %rbp
  2c05b2:	c3                   	ret    
		return NULL;
  2c05b3:	bb 00 00 00 00       	mov    $0x0,%ebx
  2c05b8:	eb eb                	jmp    2c05a5 <malloc+0x96>
		return NULL;
  2c05ba:	bb 00 00 00 00       	mov    $0x0,%ebx
  2c05bf:	eb e4                	jmp    2c05a5 <malloc+0x96>

00000000002c05c1 <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  2c05c1:	55                   	push   %rbp
  2c05c2:	48 89 e5             	mov    %rsp,%rbp
  2c05c5:	41 54                	push   %r12
  2c05c7:	53                   	push   %rbx
	void *bp = malloc(num * sz);
  2c05c8:	48 0f af fe          	imul   %rsi,%rdi
  2c05cc:	49 89 fc             	mov    %rdi,%r12
  2c05cf:	e8 3b ff ff ff       	call   2c050f <malloc>
  2c05d4:	48 89 c3             	mov    %rax,%rbx
	if (bp)							// protect against num=0 or size=0
  2c05d7:	48 85 c0             	test   %rax,%rax
  2c05da:	74 10                	je     2c05ec <calloc+0x2b>
		memset(bp, 0, num * sz);
  2c05dc:	4c 89 e2             	mov    %r12,%rdx
  2c05df:	be 00 00 00 00       	mov    $0x0,%esi
  2c05e4:	48 89 c7             	mov    %rax,%rdi
  2c05e7:	e8 7e 02 00 00       	call   2c086a <memset>
	return bp;
}
  2c05ec:	48 89 d8             	mov    %rbx,%rax
  2c05ef:	5b                   	pop    %rbx
  2c05f0:	41 5c                	pop    %r12
  2c05f2:	5d                   	pop    %rbp
  2c05f3:	c3                   	ret    

00000000002c05f4 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  2c05f4:	55                   	push   %rbp
  2c05f5:	48 89 e5             	mov    %rsp,%rbp
  2c05f8:	41 54                	push   %r12
  2c05fa:	53                   	push   %rbx
  2c05fb:	48 89 fb             	mov    %rdi,%rbx
  2c05fe:	48 89 f7             	mov    %rsi,%rdi
	// first check if there's enough space in the block already (and that it's actually valid ptr)
	if (ptr && GET_SIZE(HDRP(ptr)) >= sz)
  2c0601:	48 85 db             	test   %rbx,%rbx
  2c0604:	74 10                	je     2c0616 <realloc+0x22>
  2c0606:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  2c060a:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
		return ptr;
  2c060e:	49 89 dc             	mov    %rbx,%r12
	if (ptr && GET_SIZE(HDRP(ptr)) >= sz)
  2c0611:	48 39 f0             	cmp    %rsi,%rax
  2c0614:	73 23                	jae    2c0639 <realloc+0x45>

	// else find or add a big enough block, which is what malloc does
	void *bigger_ptr = malloc(sz);
  2c0616:	e8 f4 fe ff ff       	call   2c050f <malloc>
  2c061b:	49 89 c4             	mov    %rax,%r12
	memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
  2c061e:	48 8b 53 f8          	mov    -0x8(%rbx),%rdx
  2c0622:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c0626:	48 89 de             	mov    %rbx,%rsi
  2c0629:	48 89 c7             	mov    %rax,%rdi
  2c062c:	e8 3b 01 00 00       	call   2c076c <memcpy>
	free(ptr);
  2c0631:	48 89 df             	mov    %rbx,%rdi
  2c0634:	e8 32 fd ff ff       	call   2c036b <free>

    return bigger_ptr;
}
  2c0639:	4c 89 e0             	mov    %r12,%rax
  2c063c:	5b                   	pop    %rbx
  2c063d:	41 5c                	pop    %r12
  2c063f:	5d                   	pop    %rbp
  2c0640:	c3                   	ret    

00000000002c0641 <defrag>:

void defrag() {
	void *fp = free_list;
  2c0641:	48 8b 05 b8 19 00 00 	mov    0x19b8(%rip),%rax        # 2c2000 <free_list>
	while (fp != NULL) {
  2c0648:	48 85 c0             	test   %rax,%rax
  2c064b:	75 50                	jne    2c069d <defrag+0x5c>
			PUT(FTRP(prev_block), PACK(GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp)), 0));	
		}

		fp = NEXT_FPTR(fp);
	}
}
  2c064d:	c3                   	ret    
				free_list = NEXT_FPTR(next_block);
  2c064e:	48 8b 0a             	mov    (%rdx),%rcx
  2c0651:	48 89 0d a8 19 00 00 	mov    %rcx,0x19a8(%rip)        # 2c2000 <free_list>
  2c0658:	eb 5d                	jmp    2c06b7 <defrag+0x76>
			fp = NEXT_FPTR(fp);
  2c065a:	48 8b 00             	mov    (%rax),%rax
			continue;
  2c065d:	eb 39                	jmp    2c0698 <defrag+0x57>
				free_list = NEXT_FPTR(fp);
  2c065f:	48 8b 08             	mov    (%rax),%rcx
  2c0662:	48 89 0d 97 19 00 00 	mov    %rcx,0x1997(%rip)        # 2c2000 <free_list>
  2c0669:	e9 d0 00 00 00       	jmp    2c073e <defrag+0xfd>
			PUT(HDRP(prev_block), PACK(GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp)), 0));	
  2c066e:	48 8b 4a f8          	mov    -0x8(%rdx),%rcx
  2c0672:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  2c0676:	48 8b 70 f8          	mov    -0x8(%rax),%rsi
  2c067a:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  2c067e:	48 01 f1             	add    %rsi,%rcx
  2c0681:	48 89 4a f8          	mov    %rcx,-0x8(%rdx)
			PUT(FTRP(prev_block), PACK(GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp)), 0));	
  2c0685:	48 8b 70 f8          	mov    -0x8(%rax),%rsi
  2c0689:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  2c068d:	48 01 ce             	add    %rcx,%rsi
  2c0690:	48 89 74 0a f0       	mov    %rsi,-0x10(%rdx,%rcx,1)
		fp = NEXT_FPTR(fp);
  2c0695:	48 8b 00             	mov    (%rax),%rax
	while (fp != NULL) {
  2c0698:	48 85 c0             	test   %rax,%rax
  2c069b:	74 b0                	je     2c064d <defrag+0xc>
		void *next_block = NEXT_BLKP(fp);
  2c069d:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c06a1:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c06a5:	48 01 c2             	add    %rax,%rdx
		if (!GET_ALLOC(HDRP(next_block))) {
  2c06a8:	f6 42 f8 01          	testb  $0x1,-0x8(%rdx)
  2c06ac:	75 4f                	jne    2c06fd <defrag+0xbc>
			if (free_list == next_block)
  2c06ae:	48 39 15 4b 19 00 00 	cmp    %rdx,0x194b(%rip)        # 2c2000 <free_list>
  2c06b5:	74 97                	je     2c064e <defrag+0xd>
			if (PREV_FPTR(next_block)) 
  2c06b7:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  2c06bb:	48 85 c9             	test   %rcx,%rcx
  2c06be:	74 06                	je     2c06c6 <defrag+0x85>
				NEXT_FPTR(PREV_FPTR(next_block)) = NEXT_FPTR(next_block);
  2c06c0:	48 8b 32             	mov    (%rdx),%rsi
  2c06c3:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(next_block)) 
  2c06c6:	48 8b 0a             	mov    (%rdx),%rcx
  2c06c9:	48 85 c9             	test   %rcx,%rcx
  2c06cc:	74 08                	je     2c06d6 <defrag+0x95>
				PREV_FPTR(NEXT_FPTR(next_block)) = PREV_FPTR(next_block);
  2c06ce:	48 8b 72 08          	mov    0x8(%rdx),%rsi
  2c06d2:	48 89 71 08          	mov    %rsi,0x8(%rcx)
			PUT(HDRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  2c06d6:	48 8b 48 f8          	mov    -0x8(%rax),%rcx
  2c06da:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  2c06de:	48 8b 72 f8          	mov    -0x8(%rdx),%rsi
  2c06e2:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  2c06e6:	48 01 f1             	add    %rsi,%rcx
  2c06e9:	48 89 48 f8          	mov    %rcx,-0x8(%rax)
			PUT(FTRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  2c06ed:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  2c06f1:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c06f5:	48 01 ca             	add    %rcx,%rdx
  2c06f8:	48 89 54 08 f0       	mov    %rdx,-0x10(%rax,%rcx,1)
		void *prev_block = PREV_BLKP(fp);
  2c06fd:	48 8b 48 f0          	mov    -0x10(%rax),%rcx
  2c0701:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  2c0705:	48 89 c2             	mov    %rax,%rdx
  2c0708:	48 29 ca             	sub    %rcx,%rdx
		if (GET_SIZE(HDRP(prev_block)) != GET_SIZE(FTRP(prev_block))){
  2c070b:	48 8b 4a f8          	mov    -0x8(%rdx),%rcx
  2c070f:	48 89 ce             	mov    %rcx,%rsi
  2c0712:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  2c0716:	48 89 cf             	mov    %rcx,%rdi
  2c0719:	48 33 7c 32 f0       	xor    -0x10(%rdx,%rsi,1),%rdi
  2c071e:	48 83 ff 0f          	cmp    $0xf,%rdi
  2c0722:	0f 87 32 ff ff ff    	ja     2c065a <defrag+0x19>
		if (!GET_ALLOC(HDRP(prev_block))) {
  2c0728:	f6 c1 01             	test   $0x1,%cl
  2c072b:	0f 85 64 ff ff ff    	jne    2c0695 <defrag+0x54>
			if (free_list == fp)
  2c0731:	48 39 05 c8 18 00 00 	cmp    %rax,0x18c8(%rip)        # 2c2000 <free_list>
  2c0738:	0f 84 21 ff ff ff    	je     2c065f <defrag+0x1e>
			if (PREV_FPTR(fp)) 
  2c073e:	48 8b 48 08          	mov    0x8(%rax),%rcx
  2c0742:	48 85 c9             	test   %rcx,%rcx
  2c0745:	74 06                	je     2c074d <defrag+0x10c>
				NEXT_FPTR(PREV_FPTR(fp)) = NEXT_FPTR(fp);
  2c0747:	48 8b 30             	mov    (%rax),%rsi
  2c074a:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(fp)) 
  2c074d:	48 8b 08             	mov    (%rax),%rcx
  2c0750:	48 85 c9             	test   %rcx,%rcx
  2c0753:	0f 84 15 ff ff ff    	je     2c066e <defrag+0x2d>
				PREV_FPTR(NEXT_FPTR(fp)) = PREV_FPTR(fp);
  2c0759:	48 8b 70 08          	mov    0x8(%rax),%rsi
  2c075d:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  2c0761:	e9 08 ff ff ff       	jmp    2c066e <defrag+0x2d>

00000000002c0766 <heap_info>:

int heap_info(heap_info_struct *info) {
    return 0;
}
  2c0766:	b8 00 00 00 00       	mov    $0x0,%eax
  2c076b:	c3                   	ret    

00000000002c076c <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c076c:	55                   	push   %rbp
  2c076d:	48 89 e5             	mov    %rsp,%rbp
  2c0770:	48 83 ec 28          	sub    $0x28,%rsp
  2c0774:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0778:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c077c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0780:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0784:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0788:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c078c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c0790:	eb 1c                	jmp    2c07ae <memcpy+0x42>
        *d = *s;
  2c0792:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0796:	0f b6 10             	movzbl (%rax),%edx
  2c0799:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c079d:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c079f:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c07a4:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c07a9:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c07ae:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c07b3:	75 dd                	jne    2c0792 <memcpy+0x26>
    }
    return dst;
  2c07b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c07b9:	c9                   	leave  
  2c07ba:	c3                   	ret    

00000000002c07bb <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c07bb:	55                   	push   %rbp
  2c07bc:	48 89 e5             	mov    %rsp,%rbp
  2c07bf:	48 83 ec 28          	sub    $0x28,%rsp
  2c07c3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c07c7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c07cb:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c07cf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c07d3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c07d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c07db:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c07df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c07e3:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c07e7:	73 6a                	jae    2c0853 <memmove+0x98>
  2c07e9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c07ed:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c07f1:	48 01 d0             	add    %rdx,%rax
  2c07f4:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c07f8:	73 59                	jae    2c0853 <memmove+0x98>
        s += n, d += n;
  2c07fa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c07fe:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c0802:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0806:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c080a:	eb 17                	jmp    2c0823 <memmove+0x68>
            *--d = *--s;
  2c080c:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c0811:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c0816:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c081a:	0f b6 10             	movzbl (%rax),%edx
  2c081d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0821:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0823:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0827:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c082b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c082f:	48 85 c0             	test   %rax,%rax
  2c0832:	75 d8                	jne    2c080c <memmove+0x51>
    if (s < d && s + n > d) {
  2c0834:	eb 2e                	jmp    2c0864 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c0836:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c083a:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c083e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0842:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0846:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c084a:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c084e:	0f b6 12             	movzbl (%rdx),%edx
  2c0851:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0853:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0857:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c085b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c085f:	48 85 c0             	test   %rax,%rax
  2c0862:	75 d2                	jne    2c0836 <memmove+0x7b>
        }
    }
    return dst;
  2c0864:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0868:	c9                   	leave  
  2c0869:	c3                   	ret    

00000000002c086a <memset>:

void* memset(void* v, int c, size_t n) {
  2c086a:	55                   	push   %rbp
  2c086b:	48 89 e5             	mov    %rsp,%rbp
  2c086e:	48 83 ec 28          	sub    $0x28,%rsp
  2c0872:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0876:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c0879:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c087d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0881:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0885:	eb 15                	jmp    2c089c <memset+0x32>
        *p = c;
  2c0887:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c088a:	89 c2                	mov    %eax,%edx
  2c088c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0890:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0892:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0897:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c089c:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c08a1:	75 e4                	jne    2c0887 <memset+0x1d>
    }
    return v;
  2c08a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c08a7:	c9                   	leave  
  2c08a8:	c3                   	ret    

00000000002c08a9 <strlen>:

size_t strlen(const char* s) {
  2c08a9:	55                   	push   %rbp
  2c08aa:	48 89 e5             	mov    %rsp,%rbp
  2c08ad:	48 83 ec 18          	sub    $0x18,%rsp
  2c08b1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c08b5:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c08bc:	00 
  2c08bd:	eb 0a                	jmp    2c08c9 <strlen+0x20>
        ++n;
  2c08bf:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c08c4:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c08c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c08cd:	0f b6 00             	movzbl (%rax),%eax
  2c08d0:	84 c0                	test   %al,%al
  2c08d2:	75 eb                	jne    2c08bf <strlen+0x16>
    }
    return n;
  2c08d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c08d8:	c9                   	leave  
  2c08d9:	c3                   	ret    

00000000002c08da <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c08da:	55                   	push   %rbp
  2c08db:	48 89 e5             	mov    %rsp,%rbp
  2c08de:	48 83 ec 20          	sub    $0x20,%rsp
  2c08e2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c08e6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c08ea:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c08f1:	00 
  2c08f2:	eb 0a                	jmp    2c08fe <strnlen+0x24>
        ++n;
  2c08f4:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c08f9:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c08fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0902:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c0906:	74 0b                	je     2c0913 <strnlen+0x39>
  2c0908:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c090c:	0f b6 00             	movzbl (%rax),%eax
  2c090f:	84 c0                	test   %al,%al
  2c0911:	75 e1                	jne    2c08f4 <strnlen+0x1a>
    }
    return n;
  2c0913:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0917:	c9                   	leave  
  2c0918:	c3                   	ret    

00000000002c0919 <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c0919:	55                   	push   %rbp
  2c091a:	48 89 e5             	mov    %rsp,%rbp
  2c091d:	48 83 ec 20          	sub    $0x20,%rsp
  2c0921:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0925:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c0929:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c092d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c0931:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c0935:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0939:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c093d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0941:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0945:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c0949:	0f b6 12             	movzbl (%rdx),%edx
  2c094c:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c094e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0952:	48 83 e8 01          	sub    $0x1,%rax
  2c0956:	0f b6 00             	movzbl (%rax),%eax
  2c0959:	84 c0                	test   %al,%al
  2c095b:	75 d4                	jne    2c0931 <strcpy+0x18>
    return dst;
  2c095d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0961:	c9                   	leave  
  2c0962:	c3                   	ret    

00000000002c0963 <strcmp>:

int strcmp(const char* a, const char* b) {
  2c0963:	55                   	push   %rbp
  2c0964:	48 89 e5             	mov    %rsp,%rbp
  2c0967:	48 83 ec 10          	sub    $0x10,%rsp
  2c096b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c096f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0973:	eb 0a                	jmp    2c097f <strcmp+0x1c>
        ++a, ++b;
  2c0975:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c097a:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c097f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0983:	0f b6 00             	movzbl (%rax),%eax
  2c0986:	84 c0                	test   %al,%al
  2c0988:	74 1d                	je     2c09a7 <strcmp+0x44>
  2c098a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c098e:	0f b6 00             	movzbl (%rax),%eax
  2c0991:	84 c0                	test   %al,%al
  2c0993:	74 12                	je     2c09a7 <strcmp+0x44>
  2c0995:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0999:	0f b6 10             	movzbl (%rax),%edx
  2c099c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c09a0:	0f b6 00             	movzbl (%rax),%eax
  2c09a3:	38 c2                	cmp    %al,%dl
  2c09a5:	74 ce                	je     2c0975 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c09a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c09ab:	0f b6 00             	movzbl (%rax),%eax
  2c09ae:	89 c2                	mov    %eax,%edx
  2c09b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c09b4:	0f b6 00             	movzbl (%rax),%eax
  2c09b7:	38 d0                	cmp    %dl,%al
  2c09b9:	0f 92 c0             	setb   %al
  2c09bc:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c09bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c09c3:	0f b6 00             	movzbl (%rax),%eax
  2c09c6:	89 c1                	mov    %eax,%ecx
  2c09c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c09cc:	0f b6 00             	movzbl (%rax),%eax
  2c09cf:	38 c1                	cmp    %al,%cl
  2c09d1:	0f 92 c0             	setb   %al
  2c09d4:	0f b6 c0             	movzbl %al,%eax
  2c09d7:	29 c2                	sub    %eax,%edx
  2c09d9:	89 d0                	mov    %edx,%eax
}
  2c09db:	c9                   	leave  
  2c09dc:	c3                   	ret    

00000000002c09dd <strchr>:

char* strchr(const char* s, int c) {
  2c09dd:	55                   	push   %rbp
  2c09de:	48 89 e5             	mov    %rsp,%rbp
  2c09e1:	48 83 ec 10          	sub    $0x10,%rsp
  2c09e5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c09e9:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c09ec:	eb 05                	jmp    2c09f3 <strchr+0x16>
        ++s;
  2c09ee:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c09f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c09f7:	0f b6 00             	movzbl (%rax),%eax
  2c09fa:	84 c0                	test   %al,%al
  2c09fc:	74 0e                	je     2c0a0c <strchr+0x2f>
  2c09fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a02:	0f b6 00             	movzbl (%rax),%eax
  2c0a05:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0a08:	38 d0                	cmp    %dl,%al
  2c0a0a:	75 e2                	jne    2c09ee <strchr+0x11>
    }
    if (*s == (char) c) {
  2c0a0c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a10:	0f b6 00             	movzbl (%rax),%eax
  2c0a13:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0a16:	38 d0                	cmp    %dl,%al
  2c0a18:	75 06                	jne    2c0a20 <strchr+0x43>
        return (char*) s;
  2c0a1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a1e:	eb 05                	jmp    2c0a25 <strchr+0x48>
    } else {
        return NULL;
  2c0a20:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c0a25:	c9                   	leave  
  2c0a26:	c3                   	ret    

00000000002c0a27 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c0a27:	55                   	push   %rbp
  2c0a28:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c0a2b:	8b 05 e7 15 00 00    	mov    0x15e7(%rip),%eax        # 2c2018 <rand_seed_set>
  2c0a31:	85 c0                	test   %eax,%eax
  2c0a33:	75 0a                	jne    2c0a3f <rand+0x18>
        srand(819234718U);
  2c0a35:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c0a3a:	e8 24 00 00 00       	call   2c0a63 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c0a3f:	8b 05 d7 15 00 00    	mov    0x15d7(%rip),%eax        # 2c201c <rand_seed>
  2c0a45:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c0a4b:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c0a50:	89 05 c6 15 00 00    	mov    %eax,0x15c6(%rip)        # 2c201c <rand_seed>
    return rand_seed & RAND_MAX;
  2c0a56:	8b 05 c0 15 00 00    	mov    0x15c0(%rip),%eax        # 2c201c <rand_seed>
  2c0a5c:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c0a61:	5d                   	pop    %rbp
  2c0a62:	c3                   	ret    

00000000002c0a63 <srand>:

void srand(unsigned seed) {
  2c0a63:	55                   	push   %rbp
  2c0a64:	48 89 e5             	mov    %rsp,%rbp
  2c0a67:	48 83 ec 08          	sub    $0x8,%rsp
  2c0a6b:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c0a6e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c0a71:	89 05 a5 15 00 00    	mov    %eax,0x15a5(%rip)        # 2c201c <rand_seed>
    rand_seed_set = 1;
  2c0a77:	c7 05 97 15 00 00 01 	movl   $0x1,0x1597(%rip)        # 2c2018 <rand_seed_set>
  2c0a7e:	00 00 00 
}
  2c0a81:	90                   	nop
  2c0a82:	c9                   	leave  
  2c0a83:	c3                   	ret    

00000000002c0a84 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c0a84:	55                   	push   %rbp
  2c0a85:	48 89 e5             	mov    %rsp,%rbp
  2c0a88:	48 83 ec 28          	sub    $0x28,%rsp
  2c0a8c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0a90:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0a94:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c0a97:	48 c7 45 f8 90 1a 2c 	movq   $0x2c1a90,-0x8(%rbp)
  2c0a9e:	00 
    if (base < 0) {
  2c0a9f:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c0aa3:	79 0b                	jns    2c0ab0 <fill_numbuf+0x2c>
        digits = lower_digits;
  2c0aa5:	48 c7 45 f8 b0 1a 2c 	movq   $0x2c1ab0,-0x8(%rbp)
  2c0aac:	00 
        base = -base;
  2c0aad:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c0ab0:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0ab5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0ab9:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c0abc:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0abf:	48 63 c8             	movslq %eax,%rcx
  2c0ac2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0ac6:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0acb:	48 f7 f1             	div    %rcx
  2c0ace:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0ad2:	48 01 d0             	add    %rdx,%rax
  2c0ad5:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0ada:	0f b6 10             	movzbl (%rax),%edx
  2c0add:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0ae1:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c0ae3:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0ae6:	48 63 f0             	movslq %eax,%rsi
  2c0ae9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0aed:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0af2:	48 f7 f6             	div    %rsi
  2c0af5:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c0af9:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c0afe:	75 bc                	jne    2c0abc <fill_numbuf+0x38>
    return numbuf_end;
  2c0b00:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0b04:	c9                   	leave  
  2c0b05:	c3                   	ret    

00000000002c0b06 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c0b06:	55                   	push   %rbp
  2c0b07:	48 89 e5             	mov    %rsp,%rbp
  2c0b0a:	53                   	push   %rbx
  2c0b0b:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c0b12:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c0b19:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c0b1f:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0b26:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c0b2d:	e9 8a 09 00 00       	jmp    2c14bc <printer_vprintf+0x9b6>
        if (*format != '%') {
  2c0b32:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b39:	0f b6 00             	movzbl (%rax),%eax
  2c0b3c:	3c 25                	cmp    $0x25,%al
  2c0b3e:	74 31                	je     2c0b71 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  2c0b40:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0b47:	4c 8b 00             	mov    (%rax),%r8
  2c0b4a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b51:	0f b6 00             	movzbl (%rax),%eax
  2c0b54:	0f b6 c8             	movzbl %al,%ecx
  2c0b57:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c0b5d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0b64:	89 ce                	mov    %ecx,%esi
  2c0b66:	48 89 c7             	mov    %rax,%rdi
  2c0b69:	41 ff d0             	call   *%r8
            continue;
  2c0b6c:	e9 43 09 00 00       	jmp    2c14b4 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  2c0b71:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0b78:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0b7f:	01 
  2c0b80:	eb 44                	jmp    2c0bc6 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  2c0b82:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b89:	0f b6 00             	movzbl (%rax),%eax
  2c0b8c:	0f be c0             	movsbl %al,%eax
  2c0b8f:	89 c6                	mov    %eax,%esi
  2c0b91:	bf b0 18 2c 00       	mov    $0x2c18b0,%edi
  2c0b96:	e8 42 fe ff ff       	call   2c09dd <strchr>
  2c0b9b:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c0b9f:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c0ba4:	74 30                	je     2c0bd6 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  2c0ba6:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c0baa:	48 2d b0 18 2c 00    	sub    $0x2c18b0,%rax
  2c0bb0:	ba 01 00 00 00       	mov    $0x1,%edx
  2c0bb5:	89 c1                	mov    %eax,%ecx
  2c0bb7:	d3 e2                	shl    %cl,%edx
  2c0bb9:	89 d0                	mov    %edx,%eax
  2c0bbb:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0bbe:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0bc5:	01 
  2c0bc6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0bcd:	0f b6 00             	movzbl (%rax),%eax
  2c0bd0:	84 c0                	test   %al,%al
  2c0bd2:	75 ae                	jne    2c0b82 <printer_vprintf+0x7c>
  2c0bd4:	eb 01                	jmp    2c0bd7 <printer_vprintf+0xd1>
            } else {
                break;
  2c0bd6:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c0bd7:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c0bde:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0be5:	0f b6 00             	movzbl (%rax),%eax
  2c0be8:	3c 30                	cmp    $0x30,%al
  2c0bea:	7e 67                	jle    2c0c53 <printer_vprintf+0x14d>
  2c0bec:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0bf3:	0f b6 00             	movzbl (%rax),%eax
  2c0bf6:	3c 39                	cmp    $0x39,%al
  2c0bf8:	7f 59                	jg     2c0c53 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0bfa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c0c01:	eb 2e                	jmp    2c0c31 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  2c0c03:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c0c06:	89 d0                	mov    %edx,%eax
  2c0c08:	c1 e0 02             	shl    $0x2,%eax
  2c0c0b:	01 d0                	add    %edx,%eax
  2c0c0d:	01 c0                	add    %eax,%eax
  2c0c0f:	89 c1                	mov    %eax,%ecx
  2c0c11:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c18:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0c1c:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0c23:	0f b6 00             	movzbl (%rax),%eax
  2c0c26:	0f be c0             	movsbl %al,%eax
  2c0c29:	01 c8                	add    %ecx,%eax
  2c0c2b:	83 e8 30             	sub    $0x30,%eax
  2c0c2e:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0c31:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c38:	0f b6 00             	movzbl (%rax),%eax
  2c0c3b:	3c 2f                	cmp    $0x2f,%al
  2c0c3d:	0f 8e 85 00 00 00    	jle    2c0cc8 <printer_vprintf+0x1c2>
  2c0c43:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c4a:	0f b6 00             	movzbl (%rax),%eax
  2c0c4d:	3c 39                	cmp    $0x39,%al
  2c0c4f:	7e b2                	jle    2c0c03 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  2c0c51:	eb 75                	jmp    2c0cc8 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  2c0c53:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c5a:	0f b6 00             	movzbl (%rax),%eax
  2c0c5d:	3c 2a                	cmp    $0x2a,%al
  2c0c5f:	75 68                	jne    2c0cc9 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  2c0c61:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c68:	8b 00                	mov    (%rax),%eax
  2c0c6a:	83 f8 2f             	cmp    $0x2f,%eax
  2c0c6d:	77 30                	ja     2c0c9f <printer_vprintf+0x199>
  2c0c6f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c76:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0c7a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c81:	8b 00                	mov    (%rax),%eax
  2c0c83:	89 c0                	mov    %eax,%eax
  2c0c85:	48 01 d0             	add    %rdx,%rax
  2c0c88:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c8f:	8b 12                	mov    (%rdx),%edx
  2c0c91:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0c94:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c9b:	89 0a                	mov    %ecx,(%rdx)
  2c0c9d:	eb 1a                	jmp    2c0cb9 <printer_vprintf+0x1b3>
  2c0c9f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ca6:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0caa:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0cae:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0cb5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0cb9:	8b 00                	mov    (%rax),%eax
  2c0cbb:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c0cbe:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0cc5:	01 
  2c0cc6:	eb 01                	jmp    2c0cc9 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  2c0cc8:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c0cc9:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c0cd0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0cd7:	0f b6 00             	movzbl (%rax),%eax
  2c0cda:	3c 2e                	cmp    $0x2e,%al
  2c0cdc:	0f 85 00 01 00 00    	jne    2c0de2 <printer_vprintf+0x2dc>
            ++format;
  2c0ce2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0ce9:	01 
            if (*format >= '0' && *format <= '9') {
  2c0cea:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0cf1:	0f b6 00             	movzbl (%rax),%eax
  2c0cf4:	3c 2f                	cmp    $0x2f,%al
  2c0cf6:	7e 67                	jle    2c0d5f <printer_vprintf+0x259>
  2c0cf8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0cff:	0f b6 00             	movzbl (%rax),%eax
  2c0d02:	3c 39                	cmp    $0x39,%al
  2c0d04:	7f 59                	jg     2c0d5f <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0d06:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c0d0d:	eb 2e                	jmp    2c0d3d <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  2c0d0f:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c0d12:	89 d0                	mov    %edx,%eax
  2c0d14:	c1 e0 02             	shl    $0x2,%eax
  2c0d17:	01 d0                	add    %edx,%eax
  2c0d19:	01 c0                	add    %eax,%eax
  2c0d1b:	89 c1                	mov    %eax,%ecx
  2c0d1d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d24:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0d28:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0d2f:	0f b6 00             	movzbl (%rax),%eax
  2c0d32:	0f be c0             	movsbl %al,%eax
  2c0d35:	01 c8                	add    %ecx,%eax
  2c0d37:	83 e8 30             	sub    $0x30,%eax
  2c0d3a:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0d3d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d44:	0f b6 00             	movzbl (%rax),%eax
  2c0d47:	3c 2f                	cmp    $0x2f,%al
  2c0d49:	0f 8e 85 00 00 00    	jle    2c0dd4 <printer_vprintf+0x2ce>
  2c0d4f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d56:	0f b6 00             	movzbl (%rax),%eax
  2c0d59:	3c 39                	cmp    $0x39,%al
  2c0d5b:	7e b2                	jle    2c0d0f <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  2c0d5d:	eb 75                	jmp    2c0dd4 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  2c0d5f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d66:	0f b6 00             	movzbl (%rax),%eax
  2c0d69:	3c 2a                	cmp    $0x2a,%al
  2c0d6b:	75 68                	jne    2c0dd5 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  2c0d6d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d74:	8b 00                	mov    (%rax),%eax
  2c0d76:	83 f8 2f             	cmp    $0x2f,%eax
  2c0d79:	77 30                	ja     2c0dab <printer_vprintf+0x2a5>
  2c0d7b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d82:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0d86:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d8d:	8b 00                	mov    (%rax),%eax
  2c0d8f:	89 c0                	mov    %eax,%eax
  2c0d91:	48 01 d0             	add    %rdx,%rax
  2c0d94:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d9b:	8b 12                	mov    (%rdx),%edx
  2c0d9d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0da0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0da7:	89 0a                	mov    %ecx,(%rdx)
  2c0da9:	eb 1a                	jmp    2c0dc5 <printer_vprintf+0x2bf>
  2c0dab:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0db2:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0db6:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0dba:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0dc1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0dc5:	8b 00                	mov    (%rax),%eax
  2c0dc7:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c0dca:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0dd1:	01 
  2c0dd2:	eb 01                	jmp    2c0dd5 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  2c0dd4:	90                   	nop
            }
            if (precision < 0) {
  2c0dd5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c0dd9:	79 07                	jns    2c0de2 <printer_vprintf+0x2dc>
                precision = 0;
  2c0ddb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c0de2:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c0de9:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c0df0:	00 
        int length = 0;
  2c0df1:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c0df8:	48 c7 45 c8 b6 18 2c 	movq   $0x2c18b6,-0x38(%rbp)
  2c0dff:	00 
    again:
        switch (*format) {
  2c0e00:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e07:	0f b6 00             	movzbl (%rax),%eax
  2c0e0a:	0f be c0             	movsbl %al,%eax
  2c0e0d:	83 e8 43             	sub    $0x43,%eax
  2c0e10:	83 f8 37             	cmp    $0x37,%eax
  2c0e13:	0f 87 9f 03 00 00    	ja     2c11b8 <printer_vprintf+0x6b2>
  2c0e19:	89 c0                	mov    %eax,%eax
  2c0e1b:	48 8b 04 c5 c8 18 2c 	mov    0x2c18c8(,%rax,8),%rax
  2c0e22:	00 
  2c0e23:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  2c0e25:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c0e2c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0e33:	01 
            goto again;
  2c0e34:	eb ca                	jmp    2c0e00 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c0e36:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0e3a:	74 5d                	je     2c0e99 <printer_vprintf+0x393>
  2c0e3c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e43:	8b 00                	mov    (%rax),%eax
  2c0e45:	83 f8 2f             	cmp    $0x2f,%eax
  2c0e48:	77 30                	ja     2c0e7a <printer_vprintf+0x374>
  2c0e4a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e51:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0e55:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e5c:	8b 00                	mov    (%rax),%eax
  2c0e5e:	89 c0                	mov    %eax,%eax
  2c0e60:	48 01 d0             	add    %rdx,%rax
  2c0e63:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e6a:	8b 12                	mov    (%rdx),%edx
  2c0e6c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0e6f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e76:	89 0a                	mov    %ecx,(%rdx)
  2c0e78:	eb 1a                	jmp    2c0e94 <printer_vprintf+0x38e>
  2c0e7a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e81:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0e85:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0e89:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e90:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0e94:	48 8b 00             	mov    (%rax),%rax
  2c0e97:	eb 5c                	jmp    2c0ef5 <printer_vprintf+0x3ef>
  2c0e99:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ea0:	8b 00                	mov    (%rax),%eax
  2c0ea2:	83 f8 2f             	cmp    $0x2f,%eax
  2c0ea5:	77 30                	ja     2c0ed7 <printer_vprintf+0x3d1>
  2c0ea7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0eae:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0eb2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0eb9:	8b 00                	mov    (%rax),%eax
  2c0ebb:	89 c0                	mov    %eax,%eax
  2c0ebd:	48 01 d0             	add    %rdx,%rax
  2c0ec0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ec7:	8b 12                	mov    (%rdx),%edx
  2c0ec9:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0ecc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ed3:	89 0a                	mov    %ecx,(%rdx)
  2c0ed5:	eb 1a                	jmp    2c0ef1 <printer_vprintf+0x3eb>
  2c0ed7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ede:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0ee2:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0ee6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0eed:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0ef1:	8b 00                	mov    (%rax),%eax
  2c0ef3:	48 98                	cltq   
  2c0ef5:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c0ef9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0efd:	48 c1 f8 38          	sar    $0x38,%rax
  2c0f01:	25 80 00 00 00       	and    $0x80,%eax
  2c0f06:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c0f09:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c0f0d:	74 09                	je     2c0f18 <printer_vprintf+0x412>
  2c0f0f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0f13:	48 f7 d8             	neg    %rax
  2c0f16:	eb 04                	jmp    2c0f1c <printer_vprintf+0x416>
  2c0f18:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0f1c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c0f20:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c0f23:	83 c8 60             	or     $0x60,%eax
  2c0f26:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c0f29:	e9 cf 02 00 00       	jmp    2c11fd <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c0f2e:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0f32:	74 5d                	je     2c0f91 <printer_vprintf+0x48b>
  2c0f34:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f3b:	8b 00                	mov    (%rax),%eax
  2c0f3d:	83 f8 2f             	cmp    $0x2f,%eax
  2c0f40:	77 30                	ja     2c0f72 <printer_vprintf+0x46c>
  2c0f42:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f49:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0f4d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f54:	8b 00                	mov    (%rax),%eax
  2c0f56:	89 c0                	mov    %eax,%eax
  2c0f58:	48 01 d0             	add    %rdx,%rax
  2c0f5b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f62:	8b 12                	mov    (%rdx),%edx
  2c0f64:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0f67:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f6e:	89 0a                	mov    %ecx,(%rdx)
  2c0f70:	eb 1a                	jmp    2c0f8c <printer_vprintf+0x486>
  2c0f72:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f79:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0f7d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0f81:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f88:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0f8c:	48 8b 00             	mov    (%rax),%rax
  2c0f8f:	eb 5c                	jmp    2c0fed <printer_vprintf+0x4e7>
  2c0f91:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f98:	8b 00                	mov    (%rax),%eax
  2c0f9a:	83 f8 2f             	cmp    $0x2f,%eax
  2c0f9d:	77 30                	ja     2c0fcf <printer_vprintf+0x4c9>
  2c0f9f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fa6:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0faa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fb1:	8b 00                	mov    (%rax),%eax
  2c0fb3:	89 c0                	mov    %eax,%eax
  2c0fb5:	48 01 d0             	add    %rdx,%rax
  2c0fb8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0fbf:	8b 12                	mov    (%rdx),%edx
  2c0fc1:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0fc4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0fcb:	89 0a                	mov    %ecx,(%rdx)
  2c0fcd:	eb 1a                	jmp    2c0fe9 <printer_vprintf+0x4e3>
  2c0fcf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fd6:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0fda:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0fde:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0fe5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0fe9:	8b 00                	mov    (%rax),%eax
  2c0feb:	89 c0                	mov    %eax,%eax
  2c0fed:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c0ff1:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c0ff5:	e9 03 02 00 00       	jmp    2c11fd <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  2c0ffa:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c1001:	e9 28 ff ff ff       	jmp    2c0f2e <printer_vprintf+0x428>
        case 'X':
            base = 16;
  2c1006:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c100d:	e9 1c ff ff ff       	jmp    2c0f2e <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c1012:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1019:	8b 00                	mov    (%rax),%eax
  2c101b:	83 f8 2f             	cmp    $0x2f,%eax
  2c101e:	77 30                	ja     2c1050 <printer_vprintf+0x54a>
  2c1020:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1027:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c102b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1032:	8b 00                	mov    (%rax),%eax
  2c1034:	89 c0                	mov    %eax,%eax
  2c1036:	48 01 d0             	add    %rdx,%rax
  2c1039:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1040:	8b 12                	mov    (%rdx),%edx
  2c1042:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1045:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c104c:	89 0a                	mov    %ecx,(%rdx)
  2c104e:	eb 1a                	jmp    2c106a <printer_vprintf+0x564>
  2c1050:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1057:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c105b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c105f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1066:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c106a:	48 8b 00             	mov    (%rax),%rax
  2c106d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c1071:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c1078:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c107f:	e9 79 01 00 00       	jmp    2c11fd <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  2c1084:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c108b:	8b 00                	mov    (%rax),%eax
  2c108d:	83 f8 2f             	cmp    $0x2f,%eax
  2c1090:	77 30                	ja     2c10c2 <printer_vprintf+0x5bc>
  2c1092:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1099:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c109d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10a4:	8b 00                	mov    (%rax),%eax
  2c10a6:	89 c0                	mov    %eax,%eax
  2c10a8:	48 01 d0             	add    %rdx,%rax
  2c10ab:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10b2:	8b 12                	mov    (%rdx),%edx
  2c10b4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c10b7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10be:	89 0a                	mov    %ecx,(%rdx)
  2c10c0:	eb 1a                	jmp    2c10dc <printer_vprintf+0x5d6>
  2c10c2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10c9:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c10cd:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c10d1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10d8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c10dc:	48 8b 00             	mov    (%rax),%rax
  2c10df:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c10e3:	e9 15 01 00 00       	jmp    2c11fd <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  2c10e8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10ef:	8b 00                	mov    (%rax),%eax
  2c10f1:	83 f8 2f             	cmp    $0x2f,%eax
  2c10f4:	77 30                	ja     2c1126 <printer_vprintf+0x620>
  2c10f6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10fd:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1101:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1108:	8b 00                	mov    (%rax),%eax
  2c110a:	89 c0                	mov    %eax,%eax
  2c110c:	48 01 d0             	add    %rdx,%rax
  2c110f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1116:	8b 12                	mov    (%rdx),%edx
  2c1118:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c111b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1122:	89 0a                	mov    %ecx,(%rdx)
  2c1124:	eb 1a                	jmp    2c1140 <printer_vprintf+0x63a>
  2c1126:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c112d:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1131:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1135:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c113c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1140:	8b 00                	mov    (%rax),%eax
  2c1142:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c1148:	e9 67 03 00 00       	jmp    2c14b4 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  2c114d:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c1151:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c1155:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c115c:	8b 00                	mov    (%rax),%eax
  2c115e:	83 f8 2f             	cmp    $0x2f,%eax
  2c1161:	77 30                	ja     2c1193 <printer_vprintf+0x68d>
  2c1163:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c116a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c116e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1175:	8b 00                	mov    (%rax),%eax
  2c1177:	89 c0                	mov    %eax,%eax
  2c1179:	48 01 d0             	add    %rdx,%rax
  2c117c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1183:	8b 12                	mov    (%rdx),%edx
  2c1185:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1188:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c118f:	89 0a                	mov    %ecx,(%rdx)
  2c1191:	eb 1a                	jmp    2c11ad <printer_vprintf+0x6a7>
  2c1193:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c119a:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c119e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c11a2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c11a9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c11ad:	8b 00                	mov    (%rax),%eax
  2c11af:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c11b2:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c11b6:	eb 45                	jmp    2c11fd <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  2c11b8:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c11bc:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c11c0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c11c7:	0f b6 00             	movzbl (%rax),%eax
  2c11ca:	84 c0                	test   %al,%al
  2c11cc:	74 0c                	je     2c11da <printer_vprintf+0x6d4>
  2c11ce:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c11d5:	0f b6 00             	movzbl (%rax),%eax
  2c11d8:	eb 05                	jmp    2c11df <printer_vprintf+0x6d9>
  2c11da:	b8 25 00 00 00       	mov    $0x25,%eax
  2c11df:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c11e2:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c11e6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c11ed:	0f b6 00             	movzbl (%rax),%eax
  2c11f0:	84 c0                	test   %al,%al
  2c11f2:	75 08                	jne    2c11fc <printer_vprintf+0x6f6>
                format--;
  2c11f4:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c11fb:	01 
            }
            break;
  2c11fc:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c11fd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1200:	83 e0 20             	and    $0x20,%eax
  2c1203:	85 c0                	test   %eax,%eax
  2c1205:	74 1e                	je     2c1225 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c1207:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c120b:	48 83 c0 18          	add    $0x18,%rax
  2c120f:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c1212:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c1216:	48 89 ce             	mov    %rcx,%rsi
  2c1219:	48 89 c7             	mov    %rax,%rdi
  2c121c:	e8 63 f8 ff ff       	call   2c0a84 <fill_numbuf>
  2c1221:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c1225:	48 c7 45 c0 b6 18 2c 	movq   $0x2c18b6,-0x40(%rbp)
  2c122c:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c122d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1230:	83 e0 20             	and    $0x20,%eax
  2c1233:	85 c0                	test   %eax,%eax
  2c1235:	74 48                	je     2c127f <printer_vprintf+0x779>
  2c1237:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c123a:	83 e0 40             	and    $0x40,%eax
  2c123d:	85 c0                	test   %eax,%eax
  2c123f:	74 3e                	je     2c127f <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  2c1241:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1244:	25 80 00 00 00       	and    $0x80,%eax
  2c1249:	85 c0                	test   %eax,%eax
  2c124b:	74 0a                	je     2c1257 <printer_vprintf+0x751>
                prefix = "-";
  2c124d:	48 c7 45 c0 b7 18 2c 	movq   $0x2c18b7,-0x40(%rbp)
  2c1254:	00 
            if (flags & FLAG_NEGATIVE) {
  2c1255:	eb 73                	jmp    2c12ca <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c1257:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c125a:	83 e0 10             	and    $0x10,%eax
  2c125d:	85 c0                	test   %eax,%eax
  2c125f:	74 0a                	je     2c126b <printer_vprintf+0x765>
                prefix = "+";
  2c1261:	48 c7 45 c0 b9 18 2c 	movq   $0x2c18b9,-0x40(%rbp)
  2c1268:	00 
            if (flags & FLAG_NEGATIVE) {
  2c1269:	eb 5f                	jmp    2c12ca <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c126b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c126e:	83 e0 08             	and    $0x8,%eax
  2c1271:	85 c0                	test   %eax,%eax
  2c1273:	74 55                	je     2c12ca <printer_vprintf+0x7c4>
                prefix = " ";
  2c1275:	48 c7 45 c0 bb 18 2c 	movq   $0x2c18bb,-0x40(%rbp)
  2c127c:	00 
            if (flags & FLAG_NEGATIVE) {
  2c127d:	eb 4b                	jmp    2c12ca <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c127f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1282:	83 e0 20             	and    $0x20,%eax
  2c1285:	85 c0                	test   %eax,%eax
  2c1287:	74 42                	je     2c12cb <printer_vprintf+0x7c5>
  2c1289:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c128c:	83 e0 01             	and    $0x1,%eax
  2c128f:	85 c0                	test   %eax,%eax
  2c1291:	74 38                	je     2c12cb <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  2c1293:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c1297:	74 06                	je     2c129f <printer_vprintf+0x799>
  2c1299:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c129d:	75 2c                	jne    2c12cb <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  2c129f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c12a4:	75 0c                	jne    2c12b2 <printer_vprintf+0x7ac>
  2c12a6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c12a9:	25 00 01 00 00       	and    $0x100,%eax
  2c12ae:	85 c0                	test   %eax,%eax
  2c12b0:	74 19                	je     2c12cb <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  2c12b2:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c12b6:	75 07                	jne    2c12bf <printer_vprintf+0x7b9>
  2c12b8:	b8 bd 18 2c 00       	mov    $0x2c18bd,%eax
  2c12bd:	eb 05                	jmp    2c12c4 <printer_vprintf+0x7be>
  2c12bf:	b8 c0 18 2c 00       	mov    $0x2c18c0,%eax
  2c12c4:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c12c8:	eb 01                	jmp    2c12cb <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  2c12ca:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c12cb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c12cf:	78 24                	js     2c12f5 <printer_vprintf+0x7ef>
  2c12d1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c12d4:	83 e0 20             	and    $0x20,%eax
  2c12d7:	85 c0                	test   %eax,%eax
  2c12d9:	75 1a                	jne    2c12f5 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  2c12db:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c12de:	48 63 d0             	movslq %eax,%rdx
  2c12e1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c12e5:	48 89 d6             	mov    %rdx,%rsi
  2c12e8:	48 89 c7             	mov    %rax,%rdi
  2c12eb:	e8 ea f5 ff ff       	call   2c08da <strnlen>
  2c12f0:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c12f3:	eb 0f                	jmp    2c1304 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  2c12f5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c12f9:	48 89 c7             	mov    %rax,%rdi
  2c12fc:	e8 a8 f5 ff ff       	call   2c08a9 <strlen>
  2c1301:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c1304:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1307:	83 e0 20             	and    $0x20,%eax
  2c130a:	85 c0                	test   %eax,%eax
  2c130c:	74 20                	je     2c132e <printer_vprintf+0x828>
  2c130e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c1312:	78 1a                	js     2c132e <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  2c1314:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1317:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c131a:	7e 08                	jle    2c1324 <printer_vprintf+0x81e>
  2c131c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c131f:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c1322:	eb 05                	jmp    2c1329 <printer_vprintf+0x823>
  2c1324:	b8 00 00 00 00       	mov    $0x0,%eax
  2c1329:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c132c:	eb 5c                	jmp    2c138a <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c132e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1331:	83 e0 20             	and    $0x20,%eax
  2c1334:	85 c0                	test   %eax,%eax
  2c1336:	74 4b                	je     2c1383 <printer_vprintf+0x87d>
  2c1338:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c133b:	83 e0 02             	and    $0x2,%eax
  2c133e:	85 c0                	test   %eax,%eax
  2c1340:	74 41                	je     2c1383 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c1342:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1345:	83 e0 04             	and    $0x4,%eax
  2c1348:	85 c0                	test   %eax,%eax
  2c134a:	75 37                	jne    2c1383 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  2c134c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1350:	48 89 c7             	mov    %rax,%rdi
  2c1353:	e8 51 f5 ff ff       	call   2c08a9 <strlen>
  2c1358:	89 c2                	mov    %eax,%edx
  2c135a:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c135d:	01 d0                	add    %edx,%eax
  2c135f:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c1362:	7e 1f                	jle    2c1383 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  2c1364:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c1367:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c136a:	89 c3                	mov    %eax,%ebx
  2c136c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1370:	48 89 c7             	mov    %rax,%rdi
  2c1373:	e8 31 f5 ff ff       	call   2c08a9 <strlen>
  2c1378:	89 c2                	mov    %eax,%edx
  2c137a:	89 d8                	mov    %ebx,%eax
  2c137c:	29 d0                	sub    %edx,%eax
  2c137e:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c1381:	eb 07                	jmp    2c138a <printer_vprintf+0x884>
        } else {
            zeros = 0;
  2c1383:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c138a:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c138d:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c1390:	01 d0                	add    %edx,%eax
  2c1392:	48 63 d8             	movslq %eax,%rbx
  2c1395:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1399:	48 89 c7             	mov    %rax,%rdi
  2c139c:	e8 08 f5 ff ff       	call   2c08a9 <strlen>
  2c13a1:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c13a5:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c13a8:	29 d0                	sub    %edx,%eax
  2c13aa:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c13ad:	eb 25                	jmp    2c13d4 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  2c13af:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c13b6:	48 8b 08             	mov    (%rax),%rcx
  2c13b9:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c13bf:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c13c6:	be 20 00 00 00       	mov    $0x20,%esi
  2c13cb:	48 89 c7             	mov    %rax,%rdi
  2c13ce:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c13d0:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c13d4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c13d7:	83 e0 04             	and    $0x4,%eax
  2c13da:	85 c0                	test   %eax,%eax
  2c13dc:	75 36                	jne    2c1414 <printer_vprintf+0x90e>
  2c13de:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c13e2:	7f cb                	jg     2c13af <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  2c13e4:	eb 2e                	jmp    2c1414 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  2c13e6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c13ed:	4c 8b 00             	mov    (%rax),%r8
  2c13f0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c13f4:	0f b6 00             	movzbl (%rax),%eax
  2c13f7:	0f b6 c8             	movzbl %al,%ecx
  2c13fa:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1400:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1407:	89 ce                	mov    %ecx,%esi
  2c1409:	48 89 c7             	mov    %rax,%rdi
  2c140c:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c140f:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c1414:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1418:	0f b6 00             	movzbl (%rax),%eax
  2c141b:	84 c0                	test   %al,%al
  2c141d:	75 c7                	jne    2c13e6 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  2c141f:	eb 25                	jmp    2c1446 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  2c1421:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1428:	48 8b 08             	mov    (%rax),%rcx
  2c142b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1431:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1438:	be 30 00 00 00       	mov    $0x30,%esi
  2c143d:	48 89 c7             	mov    %rax,%rdi
  2c1440:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c1442:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c1446:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c144a:	7f d5                	jg     2c1421 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  2c144c:	eb 32                	jmp    2c1480 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  2c144e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1455:	4c 8b 00             	mov    (%rax),%r8
  2c1458:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c145c:	0f b6 00             	movzbl (%rax),%eax
  2c145f:	0f b6 c8             	movzbl %al,%ecx
  2c1462:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1468:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c146f:	89 ce                	mov    %ecx,%esi
  2c1471:	48 89 c7             	mov    %rax,%rdi
  2c1474:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c1477:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c147c:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c1480:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c1484:	7f c8                	jg     2c144e <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  2c1486:	eb 25                	jmp    2c14ad <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  2c1488:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c148f:	48 8b 08             	mov    (%rax),%rcx
  2c1492:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1498:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c149f:	be 20 00 00 00       	mov    $0x20,%esi
  2c14a4:	48 89 c7             	mov    %rax,%rdi
  2c14a7:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c14a9:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c14ad:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c14b1:	7f d5                	jg     2c1488 <printer_vprintf+0x982>
        }
    done: ;
  2c14b3:	90                   	nop
    for (; *format; ++format) {
  2c14b4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c14bb:	01 
  2c14bc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c14c3:	0f b6 00             	movzbl (%rax),%eax
  2c14c6:	84 c0                	test   %al,%al
  2c14c8:	0f 85 64 f6 ff ff    	jne    2c0b32 <printer_vprintf+0x2c>
    }
}
  2c14ce:	90                   	nop
  2c14cf:	90                   	nop
  2c14d0:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c14d4:	c9                   	leave  
  2c14d5:	c3                   	ret    

00000000002c14d6 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c14d6:	55                   	push   %rbp
  2c14d7:	48 89 e5             	mov    %rsp,%rbp
  2c14da:	48 83 ec 20          	sub    $0x20,%rsp
  2c14de:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c14e2:	89 f0                	mov    %esi,%eax
  2c14e4:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c14e7:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c14ea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c14ee:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c14f2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c14f6:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c14fa:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  2c14ff:	48 39 d0             	cmp    %rdx,%rax
  2c1502:	72 0c                	jb     2c1510 <console_putc+0x3a>
        cp->cursor = console;
  2c1504:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1508:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  2c150f:	00 
    }
    if (c == '\n') {
  2c1510:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c1514:	75 78                	jne    2c158e <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  2c1516:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c151a:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c151e:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c1524:	48 d1 f8             	sar    %rax
  2c1527:	48 89 c1             	mov    %rax,%rcx
  2c152a:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c1531:	66 66 66 
  2c1534:	48 89 c8             	mov    %rcx,%rax
  2c1537:	48 f7 ea             	imul   %rdx
  2c153a:	48 c1 fa 05          	sar    $0x5,%rdx
  2c153e:	48 89 c8             	mov    %rcx,%rax
  2c1541:	48 c1 f8 3f          	sar    $0x3f,%rax
  2c1545:	48 29 c2             	sub    %rax,%rdx
  2c1548:	48 89 d0             	mov    %rdx,%rax
  2c154b:	48 c1 e0 02          	shl    $0x2,%rax
  2c154f:	48 01 d0             	add    %rdx,%rax
  2c1552:	48 c1 e0 04          	shl    $0x4,%rax
  2c1556:	48 29 c1             	sub    %rax,%rcx
  2c1559:	48 89 ca             	mov    %rcx,%rdx
  2c155c:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c155f:	eb 25                	jmp    2c1586 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  2c1561:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c1564:	83 c8 20             	or     $0x20,%eax
  2c1567:	89 c6                	mov    %eax,%esi
  2c1569:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c156d:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1571:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1575:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c1579:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c157d:	89 f2                	mov    %esi,%edx
  2c157f:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c1582:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1586:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c158a:	75 d5                	jne    2c1561 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c158c:	eb 24                	jmp    2c15b2 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  2c158e:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  2c1592:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c1595:	09 d0                	or     %edx,%eax
  2c1597:	89 c6                	mov    %eax,%esi
  2c1599:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c159d:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c15a1:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c15a5:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c15a9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c15ad:	89 f2                	mov    %esi,%edx
  2c15af:	66 89 10             	mov    %dx,(%rax)
}
  2c15b2:	90                   	nop
  2c15b3:	c9                   	leave  
  2c15b4:	c3                   	ret    

00000000002c15b5 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c15b5:	55                   	push   %rbp
  2c15b6:	48 89 e5             	mov    %rsp,%rbp
  2c15b9:	48 83 ec 30          	sub    $0x30,%rsp
  2c15bd:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c15c0:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c15c3:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c15c7:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c15cb:	48 c7 45 f0 d6 14 2c 	movq   $0x2c14d6,-0x10(%rbp)
  2c15d2:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c15d3:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c15d7:	78 09                	js     2c15e2 <console_vprintf+0x2d>
  2c15d9:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c15e0:	7e 07                	jle    2c15e9 <console_vprintf+0x34>
        cpos = 0;
  2c15e2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c15e9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c15ec:	48 98                	cltq   
  2c15ee:	48 01 c0             	add    %rax,%rax
  2c15f1:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  2c15f7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c15fb:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c15ff:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c1603:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c1606:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c160a:	48 89 c7             	mov    %rax,%rdi
  2c160d:	e8 f4 f4 ff ff       	call   2c0b06 <printer_vprintf>
    return cp.cursor - console;
  2c1612:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1616:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c161c:	48 d1 f8             	sar    %rax
}
  2c161f:	c9                   	leave  
  2c1620:	c3                   	ret    

00000000002c1621 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c1621:	55                   	push   %rbp
  2c1622:	48 89 e5             	mov    %rsp,%rbp
  2c1625:	48 83 ec 60          	sub    $0x60,%rsp
  2c1629:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c162c:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c162f:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c1633:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1637:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c163b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c163f:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c1646:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c164a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c164e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c1652:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c1656:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c165a:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c165e:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c1661:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c1664:	89 c7                	mov    %eax,%edi
  2c1666:	e8 4a ff ff ff       	call   2c15b5 <console_vprintf>
  2c166b:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c166e:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c1671:	c9                   	leave  
  2c1672:	c3                   	ret    

00000000002c1673 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c1673:	55                   	push   %rbp
  2c1674:	48 89 e5             	mov    %rsp,%rbp
  2c1677:	48 83 ec 20          	sub    $0x20,%rsp
  2c167b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c167f:	89 f0                	mov    %esi,%eax
  2c1681:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1684:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c1687:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c168b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c168f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1693:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c1697:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c169b:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c169f:	48 39 c2             	cmp    %rax,%rdx
  2c16a2:	73 1a                	jae    2c16be <string_putc+0x4b>
        *sp->s++ = c;
  2c16a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c16a8:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c16ac:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c16b0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c16b4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c16b8:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c16bc:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c16be:	90                   	nop
  2c16bf:	c9                   	leave  
  2c16c0:	c3                   	ret    

00000000002c16c1 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c16c1:	55                   	push   %rbp
  2c16c2:	48 89 e5             	mov    %rsp,%rbp
  2c16c5:	48 83 ec 40          	sub    $0x40,%rsp
  2c16c9:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c16cd:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c16d1:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c16d5:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c16d9:	48 c7 45 e8 73 16 2c 	movq   $0x2c1673,-0x18(%rbp)
  2c16e0:	00 
    sp.s = s;
  2c16e1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c16e5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c16e9:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c16ee:	74 33                	je     2c1723 <vsnprintf+0x62>
        sp.end = s + size - 1;
  2c16f0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c16f4:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c16f8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c16fc:	48 01 d0             	add    %rdx,%rax
  2c16ff:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c1703:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c1707:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c170b:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c170f:	be 00 00 00 00       	mov    $0x0,%esi
  2c1714:	48 89 c7             	mov    %rax,%rdi
  2c1717:	e8 ea f3 ff ff       	call   2c0b06 <printer_vprintf>
        *sp.s = 0;
  2c171c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1720:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c1723:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1727:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c172b:	c9                   	leave  
  2c172c:	c3                   	ret    

00000000002c172d <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c172d:	55                   	push   %rbp
  2c172e:	48 89 e5             	mov    %rsp,%rbp
  2c1731:	48 83 ec 70          	sub    $0x70,%rsp
  2c1735:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c1739:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c173d:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c1741:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1745:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c1749:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c174d:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c1754:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1758:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c175c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c1760:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c1764:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c1768:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c176c:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c1770:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1774:	48 89 c7             	mov    %rax,%rdi
  2c1777:	e8 45 ff ff ff       	call   2c16c1 <vsnprintf>
  2c177c:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c177f:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c1782:	c9                   	leave  
  2c1783:	c3                   	ret    

00000000002c1784 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c1784:	55                   	push   %rbp
  2c1785:	48 89 e5             	mov    %rsp,%rbp
  2c1788:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c178c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c1793:	eb 13                	jmp    2c17a8 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  2c1795:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c1798:	48 98                	cltq   
  2c179a:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  2c17a1:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c17a4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c17a8:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c17af:	7e e4                	jle    2c1795 <console_clear+0x11>
    }
    cursorpos = 0;
  2c17b1:	c7 05 41 78 df ff 00 	movl   $0x0,-0x2087bf(%rip)        # b8ffc <cursorpos>
  2c17b8:	00 00 00 
}
  2c17bb:	90                   	nop
  2c17bc:	c9                   	leave  
  2c17bd:	c3                   	ret    
