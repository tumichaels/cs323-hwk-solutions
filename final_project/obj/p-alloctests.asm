
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
  2c0016:	e8 eb 0c 00 00       	call   2c0d06 <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001b:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0020:	e8 c5 04 00 00       	call   2c04ea <malloc>
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
  2c003f:	e8 9b 05 00 00       	call   2c05df <realloc>
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
  2c0067:	e8 40 05 00 00       	call   2c05ac <calloc>
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
  2c0086:	e8 d9 07 00 00       	call   2c0864 <heap_info>
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
  2c00b7:	ba 70 1a 2c 00       	mov    $0x2c1a70,%edx
  2c00bc:	be 1a 00 00 00       	mov    $0x1a,%esi
  2c00c1:	bf 7e 1a 2c 00       	mov    $0x2c1a7e,%edi
  2c00c6:	e8 13 02 00 00       	call   2c02de <assert_fail>
	assert(array2[i] == 0);
  2c00cb:	ba 94 1a 2c 00       	mov    $0x2c1a94,%edx
  2c00d0:	be 22 00 00 00       	mov    $0x22,%esi
  2c00d5:	bf 7e 1a 2c 00       	mov    $0x2c1a7e,%edi
  2c00da:	e8 ff 01 00 00       	call   2c02de <assert_fail>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00df:	ba b8 1a 2c 00       	mov    $0x2c1ab8,%edx
  2c00e4:	be 29 00 00 00       	mov    $0x29,%esi
  2c00e9:	bf 7e 1a 2c 00       	mov    $0x2c1a7e,%edi
  2c00ee:	e8 eb 01 00 00       	call   2c02de <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c00f3:	be a3 1a 2c 00       	mov    $0x2c1aa3,%esi
  2c00f8:	bf 00 00 00 00       	mov    $0x0,%edi
  2c00fd:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0102:	e8 79 00 00 00       	call   2c0180 <app_printf>
    }
    
    // free array, array2
    free(array);
  2c0107:	4c 89 ef             	mov    %r13,%rdi
  2c010a:	e8 78 02 00 00       	call   2c0387 <free>
    free(array2);
  2c010f:	4c 89 f7             	mov    %r14,%rdi
  2c0112:	e8 70 02 00 00       	call   2c0387 <free>

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
  2c0130:	e8 b5 03 00 00       	call   2c04ea <malloc>
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
  2c016a:	be e8 1a 2c 00       	mov    $0x2c1ae8,%esi
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
  2c01c8:	0f b6 b7 4d 1b 2c 00 	movzbl 0x2c1b4d(%rdi),%esi
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
  2c01f6:	e8 5d 16 00 00       	call   2c1858 <console_vprintf>
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
  2c024f:	be 18 1b 2c 00       	mov    $0x2c1b18,%esi
  2c0254:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  2c025b:	e8 af 07 00 00       	call   2c0a0f <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0260:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0264:	48 89 da             	mov    %rbx,%rdx
  2c0267:	be 99 00 00 00       	mov    $0x99,%esi
  2c026c:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c0273:	e8 ec 16 00 00       	call   2c1964 <vsnprintf>
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
  2c0298:	ba 20 1b 2c 00       	mov    $0x2c1b20,%edx
  2c029d:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02a2:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02a7:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ac:	e8 13 16 00 00       	call   2c18c4 <console_printf>
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
  2c02d2:	be b3 1a 2c 00       	mov    $0x2c1ab3,%esi
  2c02d7:	e8 e0 08 00 00       	call   2c0bbc <strcpy>
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
  2c02eb:	ba 28 1b 2c 00       	mov    $0x2c1b28,%edx
  2c02f0:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02f5:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02fa:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ff:	e8 c0 15 00 00       	call   2c18c4 <console_printf>
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
  2c0314:	48 89 05 05 1d 00 00 	mov    %rax,0x1d05(%rip)        # 2c2020 <result.0>
  2c031b:	bf 08 00 00 00       	mov    $0x8,%edi
  2c0320:	cd 3a                	int    $0x3a
  2c0322:	48 89 05 f7 1c 00 00 	mov    %rax,0x1cf7(%rip)        # 2c2020 <result.0>
// want to try and optimize this 
void heap_init(void) {

	// prologue block
	sbrk(sizeof(block_header) + sizeof(block_header));
	prologue_block = sbrk(sizeof(block_footer));
  2c0329:	48 89 05 e0 1c 00 00 	mov    %rax,0x1ce0(%rip)        # 2c2010 <prologue_block>
	PUT(HDRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  2c0330:	48 c7 40 f8 11 00 00 	movq   $0x11,-0x8(%rax)
  2c0337:	00 
	PUT(FTRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  2c0338:	48 8b 15 d1 1c 00 00 	mov    0x1cd1(%rip),%rdx        # 2c2010 <prologue_block>
  2c033f:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  2c0343:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c0347:	48 c7 44 02 f0 11 00 	movq   $0x11,-0x10(%rdx,%rax,1)
  2c034e:	00 00 
  2c0350:	cd 3a                	int    $0x3a
  2c0352:	48 89 05 c7 1c 00 00 	mov    %rax,0x1cc7(%rip)        # 2c2020 <result.0>

	// terminal block
	sbrk(sizeof(block_header));
	PUT(HDRP(NEXT_BLKP(prologue_block)), PACK(0, 1));	
  2c0359:	48 8b 15 b0 1c 00 00 	mov    0x1cb0(%rip),%rdx        # 2c2010 <prologue_block>
  2c0360:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  2c0364:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c0368:	48 c7 44 02 f8 01 00 	movq   $0x1,-0x8(%rdx,%rax,1)
  2c036f:	00 00 

	free_list = NULL;
  2c0371:	48 c7 05 8c 1c 00 00 	movq   $0x0,0x1c8c(%rip)        # 2c2008 <free_list>
  2c0378:	00 00 00 00 

	initialized_heap = 1;
  2c037c:	c7 05 92 1c 00 00 01 	movl   $0x1,0x1c92(%rip)        # 2c2018 <initialized_heap>
  2c0383:	00 00 00 
}
  2c0386:	c3                   	ret    

00000000002c0387 <free>:

void free(void *firstbyte) {
	if (firstbyte == NULL)
  2c0387:	48 85 ff             	test   %rdi,%rdi
  2c038a:	74 3d                	je     2c03c9 <free+0x42>
		return;

	// setup free things: alloc, list ptrs, footer
	PUT(HDRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  2c038c:	48 8b 47 f8          	mov    -0x8(%rdi),%rax
  2c0390:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c0394:	48 89 47 f8          	mov    %rax,-0x8(%rdi)
	NEXT_FPTR(firstbyte) = free_list;
  2c0398:	48 8b 15 69 1c 00 00 	mov    0x1c69(%rip),%rdx        # 2c2008 <free_list>
  2c039f:	48 89 17             	mov    %rdx,(%rdi)
	PREV_FPTR(firstbyte) = NULL;
  2c03a2:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  2c03a9:	00 
	PUT(FTRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  2c03aa:	48 89 44 07 f0       	mov    %rax,-0x10(%rdi,%rax,1)

	// add to free_list
	PREV_FPTR(free_list) = firstbyte;
  2c03af:	48 8b 05 52 1c 00 00 	mov    0x1c52(%rip),%rax        # 2c2008 <free_list>
  2c03b6:	48 89 78 08          	mov    %rdi,0x8(%rax)
	free_list = firstbyte;
  2c03ba:	48 89 3d 47 1c 00 00 	mov    %rdi,0x1c47(%rip)        # 2c2008 <free_list>

	num_allocs--;
  2c03c1:	48 83 2d 37 1c 00 00 	subq   $0x1,0x1c37(%rip)        # 2c2000 <num_allocs>
  2c03c8:	01 

	return;
}
  2c03c9:	c3                   	ret    

00000000002c03ca <extend>:
//
//	the reason allocating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
int extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  2c03ca:	48 81 c7 ff 3f 00 00 	add    $0x3fff,%rdi
  2c03d1:	48 81 e7 00 c0 ff ff 	and    $0xffffffffffffc000,%rdi
  2c03d8:	cd 3a                	int    $0x3a
  2c03da:	48 89 05 3f 1c 00 00 	mov    %rax,0x1c3f(%rip)        # 2c2020 <result.0>
	void *bp = sbrk(chunk_aligned_size);
	if (bp == (void *)-1)
  2c03e1:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c03e5:	74 49                	je     2c0430 <extend+0x66>
		return -1;

	// setup pointer
	PUT(HDRP(bp), PACK(chunk_aligned_size, 0));	
  2c03e7:	48 89 78 f8          	mov    %rdi,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  2c03eb:	48 8b 15 16 1c 00 00 	mov    0x1c16(%rip),%rdx        # 2c2008 <free_list>
  2c03f2:	48 89 10             	mov    %rdx,(%rax)
	PREV_FPTR(bp) = NULL;
  2c03f5:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  2c03fc:	00 
	PUT(FTRP(bp), PACK(chunk_aligned_size, 0));	
  2c03fd:	48 89 7c 07 f0       	mov    %rdi,-0x10(%rdi,%rax,1)
	
	// add to head of free_list
	if (free_list)
  2c0402:	48 8b 15 ff 1b 00 00 	mov    0x1bff(%rip),%rdx        # 2c2008 <free_list>
  2c0409:	48 85 d2             	test   %rdx,%rdx
  2c040c:	74 04                	je     2c0412 <extend+0x48>
		PREV_FPTR(free_list) = bp;
  2c040e:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  2c0412:	48 89 05 ef 1b 00 00 	mov    %rax,0x1bef(%rip)        # 2c2008 <free_list>

	// update terminal block
	PUT(HDRP(NEXT_BLKP(bp)), PACK(0, 1));	
  2c0419:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c041d:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c0421:	48 c7 44 10 f8 01 00 	movq   $0x1,-0x8(%rax,%rdx,1)
  2c0428:	00 00 

	return 0;
  2c042a:	b8 00 00 00 00       	mov    $0x0,%eax
  2c042f:	c3                   	ret    
		return -1;
  2c0430:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  2c0435:	c3                   	ret    

00000000002c0436 <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
  2c0436:	48 89 f8             	mov    %rdi,%rax
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  2c0439:	48 8b 57 f8          	mov    -0x8(%rdi),%rdx
  2c043d:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c0441:	48 29 f2             	sub    %rsi,%rdx

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  2c0444:	48 83 fa 20          	cmp    $0x20,%rdx
  2c0448:	76 5b                	jbe    2c04a5 <set_allocated+0x6f>
		PUT(HDRP(bp), PACK(size, 1));
  2c044a:	48 89 f1             	mov    %rsi,%rcx
  2c044d:	48 83 c9 01          	or     $0x1,%rcx
  2c0451:	48 89 4f f8          	mov    %rcx,-0x8(%rdi)

		void *leftover_mem_ptr = NEXT_BLKP(bp);
  2c0455:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  2c0459:	48 01 fe             	add    %rdi,%rsi

		PUT(HDRP(leftover_mem_ptr), PACK(extra_size, 0));	
  2c045c:	48 89 56 f8          	mov    %rdx,-0x8(%rsi)
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp); // pointers to the next free blocks
  2c0460:	48 8b 0f             	mov    (%rdi),%rcx
  2c0463:	48 89 0e             	mov    %rcx,(%rsi)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  2c0466:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  2c046a:	48 89 4e 08          	mov    %rcx,0x8(%rsi)
		PUT(FTRP(leftover_mem_ptr), PACK(extra_size, 0));	
  2c046e:	48 89 d1             	mov    %rdx,%rcx
  2c0471:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  2c0475:	48 89 54 0e f0       	mov    %rdx,-0x10(%rsi,%rcx,1)

		// update the free list
		if (free_list == bp)
  2c047a:	48 39 3d 87 1b 00 00 	cmp    %rdi,0x1b87(%rip)        # 2c2008 <free_list>
  2c0481:	74 19                	je     2c049c <set_allocated+0x66>
			free_list = leftover_mem_ptr;

		if (PREV_FPTR(bp))
  2c0483:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c0487:	48 85 d2             	test   %rdx,%rdx
  2c048a:	74 03                	je     2c048f <set_allocated+0x59>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  2c048c:	48 89 32             	mov    %rsi,(%rdx)

		if (NEXT_FPTR(bp))
  2c048f:	48 8b 00             	mov    (%rax),%rax
  2c0492:	48 85 c0             	test   %rax,%rax
  2c0495:	74 46                	je     2c04dd <set_allocated+0xa7>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  2c0497:	48 89 70 08          	mov    %rsi,0x8(%rax)
  2c049b:	c3                   	ret    
			free_list = leftover_mem_ptr;
  2c049c:	48 89 35 65 1b 00 00 	mov    %rsi,0x1b65(%rip)        # 2c2008 <free_list>
  2c04a3:	eb de                	jmp    2c0483 <set_allocated+0x4d>
								    
	}
	else {
		// update the free list
		if (free_list == bp)
  2c04a5:	48 39 3d 5c 1b 00 00 	cmp    %rdi,0x1b5c(%rip)        # 2c2008 <free_list>
  2c04ac:	74 30                	je     2c04de <set_allocated+0xa8>
			free_list = NEXT_FPTR(bp);

		if (PREV_FPTR(bp))
  2c04ae:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c04b2:	48 85 d2             	test   %rdx,%rdx
  2c04b5:	74 06                	je     2c04bd <set_allocated+0x87>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  2c04b7:	48 8b 08             	mov    (%rax),%rcx
  2c04ba:	48 89 0a             	mov    %rcx,(%rdx)
		if (NEXT_FPTR(bp))
  2c04bd:	48 8b 10             	mov    (%rax),%rdx
  2c04c0:	48 85 d2             	test   %rdx,%rdx
  2c04c3:	74 08                	je     2c04cd <set_allocated+0x97>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  2c04c5:	48 8b 48 08          	mov    0x8(%rax),%rcx
  2c04c9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)

		PUT(HDRP(bp), PACK(GET_SIZE(HDRP(bp)), 1));	
  2c04cd:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c04d1:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c04d5:	48 83 ca 01          	or     $0x1,%rdx
  2c04d9:	48 89 50 f8          	mov    %rdx,-0x8(%rax)
	}
}
  2c04dd:	c3                   	ret    
			free_list = NEXT_FPTR(bp);
  2c04de:	48 8b 17             	mov    (%rdi),%rdx
  2c04e1:	48 89 15 20 1b 00 00 	mov    %rdx,0x1b20(%rip)        # 2c2008 <free_list>
  2c04e8:	eb c4                	jmp    2c04ae <set_allocated+0x78>

00000000002c04ea <malloc>:

void *malloc(uint64_t numbytes) {
  2c04ea:	55                   	push   %rbp
  2c04eb:	48 89 e5             	mov    %rsp,%rbp
  2c04ee:	41 55                	push   %r13
  2c04f0:	41 54                	push   %r12
  2c04f2:	53                   	push   %rbx
  2c04f3:	48 83 ec 08          	sub    $0x8,%rsp
  2c04f7:	49 89 fc             	mov    %rdi,%r12
	if (!initialized_heap)
  2c04fa:	83 3d 17 1b 00 00 00 	cmpl   $0x0,0x1b17(%rip)        # 2c2018 <initialized_heap>
  2c0501:	74 73                	je     2c0576 <malloc+0x8c>
		heap_init();

	if (numbytes == 0)
  2c0503:	4d 85 e4             	test   %r12,%r12
  2c0506:	0f 84 92 00 00 00    	je     2c059e <malloc+0xb4>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  2c050c:	49 83 c4 17          	add    $0x17,%r12
  2c0510:	49 83 e4 f0          	and    $0xfffffffffffffff0,%r12
  2c0514:	b8 20 00 00 00       	mov    $0x20,%eax
  2c0519:	49 39 c4             	cmp    %rax,%r12
  2c051c:	4c 0f 42 e0          	cmovb  %rax,%r12
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);
	
	void *bp = free_list;
  2c0520:	48 8b 1d e1 1a 00 00 	mov    0x1ae1(%rip),%rbx        # 2c2008 <free_list>
	while (bp) {
  2c0527:	48 85 db             	test   %rbx,%rbx
  2c052a:	74 15                	je     2c0541 <malloc+0x57>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  2c052c:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  2c0530:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c0534:	4c 39 e0             	cmp    %r12,%rax
  2c0537:	73 44                	jae    2c057d <malloc+0x93>
			set_allocated(bp, aligned_size);
			num_allocs++;
			return bp;
		}

		bp = NEXT_FPTR(bp);
  2c0539:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  2c053c:	48 85 db             	test   %rbx,%rbx
  2c053f:	75 eb                	jne    2c052c <malloc+0x42>
  2c0541:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0546:	cd 3a                	int    $0x3a
  2c0548:	49 89 c5             	mov    %rax,%r13
  2c054b:	48 89 05 ce 1a 00 00 	mov    %rax,0x1ace(%rip)        # 2c2020 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  2c0552:	48 89 c3             	mov    %rax,%rbx
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	if (extend(aligned_size)) {
  2c0555:	4c 89 e7             	mov    %r12,%rdi
  2c0558:	e8 6d fe ff ff       	call   2c03ca <extend>
  2c055d:	85 c0                	test   %eax,%eax
  2c055f:	75 44                	jne    2c05a5 <malloc+0xbb>
		return NULL;
	}
	set_allocated(bp, aligned_size);
  2c0561:	4c 89 e6             	mov    %r12,%rsi
  2c0564:	4c 89 ef             	mov    %r13,%rdi
  2c0567:	e8 ca fe ff ff       	call   2c0436 <set_allocated>
	num_allocs++;
  2c056c:	48 83 05 8c 1a 00 00 	addq   $0x1,0x1a8c(%rip)        # 2c2000 <num_allocs>
  2c0573:	01 
    return bp;
  2c0574:	eb 1a                	jmp    2c0590 <malloc+0xa6>
		heap_init();
  2c0576:	e8 92 fd ff ff       	call   2c030d <heap_init>
  2c057b:	eb 86                	jmp    2c0503 <malloc+0x19>
			set_allocated(bp, aligned_size);
  2c057d:	4c 89 e6             	mov    %r12,%rsi
  2c0580:	48 89 df             	mov    %rbx,%rdi
  2c0583:	e8 ae fe ff ff       	call   2c0436 <set_allocated>
			num_allocs++;
  2c0588:	48 83 05 70 1a 00 00 	addq   $0x1,0x1a70(%rip)        # 2c2000 <num_allocs>
  2c058f:	01 
}
  2c0590:	48 89 d8             	mov    %rbx,%rax
  2c0593:	48 83 c4 08          	add    $0x8,%rsp
  2c0597:	5b                   	pop    %rbx
  2c0598:	41 5c                	pop    %r12
  2c059a:	41 5d                	pop    %r13
  2c059c:	5d                   	pop    %rbp
  2c059d:	c3                   	ret    
		return NULL;
  2c059e:	bb 00 00 00 00       	mov    $0x0,%ebx
  2c05a3:	eb eb                	jmp    2c0590 <malloc+0xa6>
		return NULL;
  2c05a5:	bb 00 00 00 00       	mov    $0x0,%ebx
  2c05aa:	eb e4                	jmp    2c0590 <malloc+0xa6>

00000000002c05ac <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  2c05ac:	55                   	push   %rbp
  2c05ad:	48 89 e5             	mov    %rsp,%rbp
  2c05b0:	41 54                	push   %r12
  2c05b2:	53                   	push   %rbx
	void *bp = malloc(num * sz);
  2c05b3:	48 0f af fe          	imul   %rsi,%rdi
  2c05b7:	49 89 fc             	mov    %rdi,%r12
  2c05ba:	e8 2b ff ff ff       	call   2c04ea <malloc>
  2c05bf:	48 89 c3             	mov    %rax,%rbx
	if (bp)							// protect against num=0 or size=0
  2c05c2:	48 85 c0             	test   %rax,%rax
  2c05c5:	74 10                	je     2c05d7 <calloc+0x2b>
		memset(bp, 0, num * sz);
  2c05c7:	4c 89 e2             	mov    %r12,%rdx
  2c05ca:	be 00 00 00 00       	mov    $0x0,%esi
  2c05cf:	48 89 c7             	mov    %rax,%rdi
  2c05d2:	e8 36 05 00 00       	call   2c0b0d <memset>
	return bp;
}
  2c05d7:	48 89 d8             	mov    %rbx,%rax
  2c05da:	5b                   	pop    %rbx
  2c05db:	41 5c                	pop    %r12
  2c05dd:	5d                   	pop    %rbp
  2c05de:	c3                   	ret    

00000000002c05df <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  2c05df:	55                   	push   %rbp
  2c05e0:	48 89 e5             	mov    %rsp,%rbp
  2c05e3:	41 54                	push   %r12
  2c05e5:	53                   	push   %rbx
  2c05e6:	48 89 fb             	mov    %rdi,%rbx
  2c05e9:	48 89 f7             	mov    %rsi,%rdi
	// first check if there's enough space in the block already (and that it's actually valid ptr)
	if (ptr && GET_SIZE(HDRP(ptr)) >= sz)
  2c05ec:	48 85 db             	test   %rbx,%rbx
  2c05ef:	74 10                	je     2c0601 <realloc+0x22>
  2c05f1:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  2c05f5:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
		return ptr;
  2c05f9:	49 89 dc             	mov    %rbx,%r12
	if (ptr && GET_SIZE(HDRP(ptr)) >= sz)
  2c05fc:	48 39 f0             	cmp    %rsi,%rax
  2c05ff:	73 23                	jae    2c0624 <realloc+0x45>

	// else find or add a big enough block, which is what malloc does
	void *bigger_ptr = malloc(sz);
  2c0601:	e8 e4 fe ff ff       	call   2c04ea <malloc>
  2c0606:	49 89 c4             	mov    %rax,%r12
	memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
  2c0609:	48 8b 53 f8          	mov    -0x8(%rbx),%rdx
  2c060d:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c0611:	48 89 de             	mov    %rbx,%rsi
  2c0614:	48 89 c7             	mov    %rax,%rdi
  2c0617:	e8 f3 03 00 00       	call   2c0a0f <memcpy>
	free(ptr);
  2c061c:	48 89 df             	mov    %rbx,%rdi
  2c061f:	e8 63 fd ff ff       	call   2c0387 <free>

    return bigger_ptr;
}
  2c0624:	4c 89 e0             	mov    %r12,%rax
  2c0627:	5b                   	pop    %rbx
  2c0628:	41 5c                	pop    %r12
  2c062a:	5d                   	pop    %rbp
  2c062b:	c3                   	ret    

00000000002c062c <defrag>:

void defrag() {
	void *fp = free_list;
  2c062c:	48 8b 05 d5 19 00 00 	mov    0x19d5(%rip),%rax        # 2c2008 <free_list>
	while (fp != NULL) {
  2c0633:	48 85 c0             	test   %rax,%rax
  2c0636:	75 50                	jne    2c0688 <defrag+0x5c>
			PUT(FTRP(prev_block), PACK(GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp)), 0));	
		}

		fp = NEXT_FPTR(fp);
	}
}
  2c0638:	c3                   	ret    
				free_list = NEXT_FPTR(next_block);
  2c0639:	48 8b 0a             	mov    (%rdx),%rcx
  2c063c:	48 89 0d c5 19 00 00 	mov    %rcx,0x19c5(%rip)        # 2c2008 <free_list>
  2c0643:	eb 5d                	jmp    2c06a2 <defrag+0x76>
			fp = NEXT_FPTR(fp);
  2c0645:	48 8b 00             	mov    (%rax),%rax
			continue;
  2c0648:	eb 39                	jmp    2c0683 <defrag+0x57>
				free_list = NEXT_FPTR(fp);
  2c064a:	48 8b 08             	mov    (%rax),%rcx
  2c064d:	48 89 0d b4 19 00 00 	mov    %rcx,0x19b4(%rip)        # 2c2008 <free_list>
  2c0654:	e9 d0 00 00 00       	jmp    2c0729 <defrag+0xfd>
			PUT(HDRP(prev_block), PACK(GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp)), 0));	
  2c0659:	48 8b 4a f8          	mov    -0x8(%rdx),%rcx
  2c065d:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  2c0661:	48 8b 70 f8          	mov    -0x8(%rax),%rsi
  2c0665:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  2c0669:	48 01 f1             	add    %rsi,%rcx
  2c066c:	48 89 4a f8          	mov    %rcx,-0x8(%rdx)
			PUT(FTRP(prev_block), PACK(GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp)), 0));	
  2c0670:	48 8b 70 f8          	mov    -0x8(%rax),%rsi
  2c0674:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  2c0678:	48 01 ce             	add    %rcx,%rsi
  2c067b:	48 89 74 0a f0       	mov    %rsi,-0x10(%rdx,%rcx,1)
		fp = NEXT_FPTR(fp);
  2c0680:	48 8b 00             	mov    (%rax),%rax
	while (fp != NULL) {
  2c0683:	48 85 c0             	test   %rax,%rax
  2c0686:	74 b0                	je     2c0638 <defrag+0xc>
		void *next_block = NEXT_BLKP(fp);
  2c0688:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c068c:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c0690:	48 01 c2             	add    %rax,%rdx
		if (!GET_ALLOC(HDRP(next_block))) {
  2c0693:	f6 42 f8 01          	testb  $0x1,-0x8(%rdx)
  2c0697:	75 4f                	jne    2c06e8 <defrag+0xbc>
			if (free_list == next_block)
  2c0699:	48 39 15 68 19 00 00 	cmp    %rdx,0x1968(%rip)        # 2c2008 <free_list>
  2c06a0:	74 97                	je     2c0639 <defrag+0xd>
			if (PREV_FPTR(next_block)) 
  2c06a2:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  2c06a6:	48 85 c9             	test   %rcx,%rcx
  2c06a9:	74 06                	je     2c06b1 <defrag+0x85>
				NEXT_FPTR(PREV_FPTR(next_block)) = NEXT_FPTR(next_block);
  2c06ab:	48 8b 32             	mov    (%rdx),%rsi
  2c06ae:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(next_block)) 
  2c06b1:	48 8b 0a             	mov    (%rdx),%rcx
  2c06b4:	48 85 c9             	test   %rcx,%rcx
  2c06b7:	74 08                	je     2c06c1 <defrag+0x95>
				PREV_FPTR(NEXT_FPTR(next_block)) = PREV_FPTR(next_block);
  2c06b9:	48 8b 72 08          	mov    0x8(%rdx),%rsi
  2c06bd:	48 89 71 08          	mov    %rsi,0x8(%rcx)
			PUT(HDRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  2c06c1:	48 8b 48 f8          	mov    -0x8(%rax),%rcx
  2c06c5:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  2c06c9:	48 8b 72 f8          	mov    -0x8(%rdx),%rsi
  2c06cd:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  2c06d1:	48 01 f1             	add    %rsi,%rcx
  2c06d4:	48 89 48 f8          	mov    %rcx,-0x8(%rax)
			PUT(FTRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  2c06d8:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  2c06dc:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c06e0:	48 01 ca             	add    %rcx,%rdx
  2c06e3:	48 89 54 08 f0       	mov    %rdx,-0x10(%rax,%rcx,1)
		void *prev_block = PREV_BLKP(fp);
  2c06e8:	48 8b 48 f0          	mov    -0x10(%rax),%rcx
  2c06ec:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  2c06f0:	48 89 c2             	mov    %rax,%rdx
  2c06f3:	48 29 ca             	sub    %rcx,%rdx
		if (GET_SIZE(HDRP(prev_block)) != GET_SIZE(FTRP(prev_block))){
  2c06f6:	48 8b 4a f8          	mov    -0x8(%rdx),%rcx
  2c06fa:	48 89 ce             	mov    %rcx,%rsi
  2c06fd:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  2c0701:	48 89 cf             	mov    %rcx,%rdi
  2c0704:	48 33 7c 32 f0       	xor    -0x10(%rdx,%rsi,1),%rdi
  2c0709:	48 83 ff 0f          	cmp    $0xf,%rdi
  2c070d:	0f 87 32 ff ff ff    	ja     2c0645 <defrag+0x19>
		if (!GET_ALLOC(HDRP(prev_block))) {
  2c0713:	f6 c1 01             	test   $0x1,%cl
  2c0716:	0f 85 64 ff ff ff    	jne    2c0680 <defrag+0x54>
			if (free_list == fp)
  2c071c:	48 39 05 e5 18 00 00 	cmp    %rax,0x18e5(%rip)        # 2c2008 <free_list>
  2c0723:	0f 84 21 ff ff ff    	je     2c064a <defrag+0x1e>
			if (PREV_FPTR(fp)) 
  2c0729:	48 8b 48 08          	mov    0x8(%rax),%rcx
  2c072d:	48 85 c9             	test   %rcx,%rcx
  2c0730:	74 06                	je     2c0738 <defrag+0x10c>
				NEXT_FPTR(PREV_FPTR(fp)) = NEXT_FPTR(fp);
  2c0732:	48 8b 30             	mov    (%rax),%rsi
  2c0735:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(fp)) 
  2c0738:	48 8b 08             	mov    (%rax),%rcx
  2c073b:	48 85 c9             	test   %rcx,%rcx
  2c073e:	0f 84 15 ff ff ff    	je     2c0659 <defrag+0x2d>
				PREV_FPTR(NEXT_FPTR(fp)) = PREV_FPTR(fp);
  2c0744:	48 8b 70 08          	mov    0x8(%rax),%rsi
  2c0748:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  2c074c:	e9 08 ff ff ff       	jmp    2c0659 <defrag+0x2d>

00000000002c0751 <sift_down>:
// heap sort stuff that operates on the pointer array
#define LEFT_CHILD(x) (2*x + 1)
#define RIGHT_CHILD(x) (2*x + 2)
#define PARENT(x) ((x-1)/2)

void sift_down(void **arr, size_t pos, size_t arr_len) {
  2c0751:	48 89 f1             	mov    %rsi,%rcx
  2c0754:	49 89 d3             	mov    %rdx,%r11
	while(LEFT_CHILD(pos) < arr_len) {
  2c0757:	48 8d 74 36 01       	lea    0x1(%rsi,%rsi,1),%rsi
  2c075c:	48 39 d6             	cmp    %rdx,%rsi
  2c075f:	72 3a                	jb     2c079b <sift_down+0x4a>
  2c0761:	c3                   	ret    
  2c0762:	48 89 f0             	mov    %rsi,%rax
		size_t smaller = LEFT_CHILD(pos);
		if (RIGHT_CHILD(pos) < arr_len && GET_SIZE(HDRP(arr[RIGHT_CHILD(pos)])) < GET_SIZE(HDRP(arr[LEFT_CHILD(pos)]))) 
			smaller = RIGHT_CHILD(pos);

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
	while(LEFT_CHILD(pos) < arr_len) {
  2c078e:	48 8d 74 00 01       	lea    0x1(%rax,%rax,1),%rsi
  2c0793:	4c 39 de             	cmp    %r11,%rsi
  2c0796:	73 36                	jae    2c07ce <sift_down+0x7d>
			pos = smaller;
  2c0798:	48 89 c1             	mov    %rax,%rcx
		if (RIGHT_CHILD(pos) < arr_len && GET_SIZE(HDRP(arr[RIGHT_CHILD(pos)])) < GET_SIZE(HDRP(arr[LEFT_CHILD(pos)]))) 
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
		else{
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
	int index = arr_len - 1;
	while(index >= 0) {
  2c07da:	41 89 f5             	mov    %esi,%r13d
  2c07dd:	41 83 ed 01          	sub    $0x1,%r13d
  2c07e1:	78 28                	js     2c080b <heapify+0x3c>
  2c07e3:	49 89 fe             	mov    %rdi,%r14
  2c07e6:	49 89 f4             	mov    %rsi,%r12
  2c07e9:	49 63 c5             	movslq %r13d,%rax
  2c07ec:	48 89 c3             	mov    %rax,%rbx
  2c07ef:	41 29 c5             	sub    %eax,%r13d
		sift_down(arr, index, arr_len);	
  2c07f2:	4c 89 e2             	mov    %r12,%rdx
  2c07f5:	48 89 de             	mov    %rbx,%rsi
  2c07f8:	4c 89 f7             	mov    %r14,%rdi
  2c07fb:	e8 51 ff ff ff       	call   2c0751 <sift_down>
	while(index >= 0) {
  2c0800:	48 83 eb 01          	sub    $0x1,%rbx
  2c0804:	44 89 e8             	mov    %r13d,%eax
  2c0807:	01 d8                	add    %ebx,%eax
  2c0809:	79 e7                	jns    2c07f2 <heapify+0x23>
		index--;
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
  2c0829:	74 34                	je     2c085f <heapsort+0x4b>
		return;
	for (size_t i = arr_len - 1; i > 1; i--) {
  2c082b:	48 83 eb 01          	sub    $0x1,%rbx
  2c082f:	48 83 fb 01          	cmp    $0x1,%rbx
  2c0833:	76 2a                	jbe    2c085f <heapsort+0x4b>
		void *temp = arr[0];
  2c0835:	49 8b 04 24          	mov    (%r12),%rax
		arr[0] = arr[i];
  2c0839:	49 8b 14 dc          	mov    (%r12,%rbx,8),%rdx
  2c083d:	49 89 14 24          	mov    %rdx,(%r12)
		arr[i] = temp;
  2c0841:	49 89 04 dc          	mov    %rax,(%r12,%rbx,8)
		sift_down(arr, 0, i);
  2c0845:	48 89 da             	mov    %rbx,%rdx
  2c0848:	be 00 00 00 00       	mov    $0x0,%esi
  2c084d:	4c 89 e7             	mov    %r12,%rdi
  2c0850:	e8 fc fe ff ff       	call   2c0751 <sift_down>
	for (size_t i = arr_len - 1; i > 1; i--) {
  2c0855:	48 83 eb 01          	sub    $0x1,%rbx
  2c0859:	48 83 fb 01          	cmp    $0x1,%rbx
  2c085d:	75 d6                	jne    2c0835 <heapsort+0x21>
	}
}
  2c085f:	5b                   	pop    %rbx
  2c0860:	41 5c                	pop    %r12
  2c0862:	5d                   	pop    %rbp
  2c0863:	c3                   	ret    

00000000002c0864 <heap_info>:

int heap_info(heap_info_struct *info) {
  2c0864:	55                   	push   %rbp
  2c0865:	48 89 e5             	mov    %rsp,%rbp
  2c0868:	53                   	push   %rbx
  2c0869:	48 83 ec 08          	sub    $0x8,%rsp
  2c086d:	48 89 fb             	mov    %rdi,%rbx
	info->num_allocs = num_allocs+2;		// +2 for the two arrays we need
  2c0870:	8b 05 8a 17 00 00    	mov    0x178a(%rip),%eax        # 2c2000 <num_allocs>
  2c0876:	83 c0 02             	add    $0x2,%eax
  2c0879:	89 07                	mov    %eax,(%rdi)
	info->free_space = 0;
  2c087b:	c7 47 18 00 00 00 00 	movl   $0x0,0x18(%rdi)
	info->largest_free_chunk = 0;
  2c0882:	c7 47 1c 00 00 00 00 	movl   $0x0,0x1c(%rdi)

	info->size_array = sbrk(ALIGN(info->num_allocs * sizeof(long) + OVERHEAD));
  2c0889:	48 98                	cltq   
  2c088b:	48 8d 3c c5 17 00 00 	lea    0x17(,%rax,8),%rdi
  2c0892:	00 
  2c0893:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
    asm volatile ("int %1" :  "=a" (result)
  2c0897:	cd 3a                	int    $0x3a
  2c0899:	48 89 05 80 17 00 00 	mov    %rax,0x1780(%rip)        # 2c2020 <result.0>
  2c08a0:	48 89 43 08          	mov    %rax,0x8(%rbx)
	if (info->ptr_array == (void *)-1) { // nothing happens on failure
  2c08a4:	48 83 7b 10 ff       	cmpq   $0xffffffffffffffff,0x10(%rbx)
  2c08a9:	0f 84 52 01 00 00    	je     2c0a01 <heap_info+0x19d>
		return -1;
	}
	info->ptr_array = sbrk(ALIGN(info->num_allocs * sizeof(void *) + OVERHEAD));
  2c08af:	48 63 03             	movslq (%rbx),%rax
  2c08b2:	48 8d 3c c5 17 00 00 	lea    0x17(,%rax,8),%rdi
  2c08b9:	00 
  2c08ba:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
  2c08be:	cd 3a                	int    $0x3a
  2c08c0:	48 89 05 59 17 00 00 	mov    %rax,0x1759(%rip)        # 2c2020 <result.0>
  2c08c7:	48 89 43 10          	mov    %rax,0x10(%rbx)
	if (info->ptr_array == (void *)-1) {
  2c08cb:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c08cf:	74 72                	je     2c0943 <heap_info+0xdf>
		sbrk(-ALIGN(info->num_allocs * sizeof(long) + OVERHEAD));
		return -1;
	}

	// we manually fill in array metadata
	PUT(HDRP(info->size_array), PACK(ALIGN(info->num_allocs * sizeof(long) + OVERHEAD), 1));
  2c08d1:	48 8b 53 08          	mov    0x8(%rbx),%rdx
  2c08d5:	48 63 03             	movslq (%rbx),%rax
  2c08d8:	48 8d 04 c5 17 00 00 	lea    0x17(,%rax,8),%rax
  2c08df:	00 
  2c08e0:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c08e4:	48 83 c8 01          	or     $0x1,%rax
  2c08e8:	48 89 42 f8          	mov    %rax,-0x8(%rdx)
	PUT(HDRP(info->ptr_array), PACK(ALIGN(info->num_allocs * sizeof(void *) + OVERHEAD), 1));
  2c08ec:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  2c08f0:	48 63 03             	movslq (%rbx),%rax
  2c08f3:	48 8d 04 c5 17 00 00 	lea    0x17(,%rax,8),%rax
  2c08fa:	00 
  2c08fb:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c08ff:	48 83 c8 01          	or     $0x1,%rax
  2c0903:	48 89 42 f8          	mov    %rax,-0x8(%rdx)

	// terminal block
	PUT(HDRP(NEXT_BLKP(info->ptr_array)), PACK(0, 1));
  2c0907:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  2c090b:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  2c090f:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c0913:	48 c7 44 02 f8 01 00 	movq   $0x1,-0x8(%rdx,%rax,1)
  2c091a:	00 00 

	// collect all the information by traversing through the heap
	void *bp = NEXT_BLKP(prologue_block); // because the prologue isn't actually allocated
  2c091c:	48 8b 05 ed 16 00 00 	mov    0x16ed(%rip),%rax        # 2c2010 <prologue_block>
  2c0923:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c0927:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c092b:	48 01 d0             	add    %rdx,%rax
	size_t arr_index = 0;
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  2c092e:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c0932:	48 83 fa 0f          	cmp    $0xf,%rdx
  2c0936:	0f 86 84 00 00 00    	jbe    2c09c0 <heap_info+0x15c>
	size_t arr_index = 0;
  2c093c:	b9 00 00 00 00       	mov    $0x0,%ecx
  2c0941:	eb 5a                	jmp    2c099d <heap_info+0x139>
		sbrk(-ALIGN(info->num_allocs * sizeof(long) + OVERHEAD));
  2c0943:	48 63 03             	movslq (%rbx),%rax
  2c0946:	48 8d 3c c5 17 00 00 	lea    0x17(,%rax,8),%rdi
  2c094d:	00 
  2c094e:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
  2c0952:	48 f7 df             	neg    %rdi
  2c0955:	cd 3a                	int    $0x3a
  2c0957:	48 89 05 c2 16 00 00 	mov    %rax,0x16c2(%rip)        # 2c2020 <result.0>
		return -1;
  2c095e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2c0963:	e9 93 00 00 00       	jmp    2c09fb <heap_info+0x197>
			info->ptr_array[arr_index] = bp;
			info->size_array[arr_index] = GET_SIZE(HDRP(bp));
			arr_index++;
		}
		else {
			info->free_space += GET_SIZE(HDRP(bp));
  2c0968:	83 e2 f0             	and    $0xfffffff0,%edx
  2c096b:	01 53 18             	add    %edx,0x18(%rbx)
			if(GET_SIZE(HDRP(bp)) > (size_t) (info->largest_free_chunk)) {
  2c096e:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c0972:	48 89 d6             	mov    %rdx,%rsi
  2c0975:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  2c0979:	48 63 7b 1c          	movslq 0x1c(%rbx),%rdi
  2c097d:	48 39 f7             	cmp    %rsi,%rdi
  2c0980:	73 06                	jae    2c0988 <heap_info+0x124>
				info->largest_free_chunk = GET_SIZE(HDRP(bp));
  2c0982:	83 e2 f0             	and    $0xfffffff0,%edx
  2c0985:	89 53 1c             	mov    %edx,0x1c(%rbx)
			}
		}

		bp = NEXT_BLKP(bp);
  2c0988:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c098c:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c0990:	48 01 d0             	add    %rdx,%rax
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  2c0993:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c0997:	48 83 fa 0f          	cmp    $0xf,%rdx
  2c099b:	76 23                	jbe    2c09c0 <heap_info+0x15c>
		if (GET_ALLOC(HDRP(bp))) {
  2c099d:	f6 c2 01             	test   $0x1,%dl
  2c09a0:	74 c6                	je     2c0968 <heap_info+0x104>
			info->ptr_array[arr_index] = bp;
  2c09a2:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  2c09a6:	48 89 04 ca          	mov    %rax,(%rdx,%rcx,8)
			info->size_array[arr_index] = GET_SIZE(HDRP(bp));
  2c09aa:	48 8b 73 08          	mov    0x8(%rbx),%rsi
  2c09ae:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c09b2:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c09b6:	48 89 14 ce          	mov    %rdx,(%rsi,%rcx,8)
			arr_index++;
  2c09ba:	48 83 c1 01          	add    $0x1,%rcx
  2c09be:	eb c8                	jmp    2c0988 <heap_info+0x124>
	}

	// we just need to sort the arrays...
	// we'll use heapsort
	heapsort(info->ptr_array, info->num_allocs);
  2c09c0:	48 63 33             	movslq (%rbx),%rsi
  2c09c3:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
  2c09c7:	e8 48 fe ff ff       	call   2c0814 <heapsort>
	for (int i = 0; i < info->num_allocs; i++)
  2c09cc:	83 3b 00             	cmpl   $0x0,(%rbx)
  2c09cf:	7e 37                	jle    2c0a08 <heap_info+0x1a4>
  2c09d1:	b8 00 00 00 00       	mov    $0x0,%eax
		info->size_array[i] = GET_SIZE(HDRP(info->ptr_array[i]));
  2c09d6:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
  2c09da:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  2c09de:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
  2c09e2:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  2c09e6:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  2c09ea:	48 89 14 c1          	mov    %rdx,(%rcx,%rax,8)
	for (int i = 0; i < info->num_allocs; i++)
  2c09ee:	48 83 c0 01          	add    $0x1,%rax
  2c09f2:	39 03                	cmp    %eax,(%rbx)
  2c09f4:	7f e0                	jg     2c09d6 <heap_info+0x172>

    return 0;
  2c09f6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  2c09fb:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c09ff:	c9                   	leave  
  2c0a00:	c3                   	ret    
		return -1;
  2c0a01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2c0a06:	eb f3                	jmp    2c09fb <heap_info+0x197>
    return 0;
  2c0a08:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0a0d:	eb ec                	jmp    2c09fb <heap_info+0x197>

00000000002c0a0f <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c0a0f:	55                   	push   %rbp
  2c0a10:	48 89 e5             	mov    %rsp,%rbp
  2c0a13:	48 83 ec 28          	sub    $0x28,%rsp
  2c0a17:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0a1b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0a1f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0a23:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0a27:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0a2b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0a2f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c0a33:	eb 1c                	jmp    2c0a51 <memcpy+0x42>
        *d = *s;
  2c0a35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a39:	0f b6 10             	movzbl (%rax),%edx
  2c0a3c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0a40:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0a42:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0a47:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0a4c:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c0a51:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0a56:	75 dd                	jne    2c0a35 <memcpy+0x26>
    }
    return dst;
  2c0a58:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0a5c:	c9                   	leave  
  2c0a5d:	c3                   	ret    

00000000002c0a5e <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c0a5e:	55                   	push   %rbp
  2c0a5f:	48 89 e5             	mov    %rsp,%rbp
  2c0a62:	48 83 ec 28          	sub    $0x28,%rsp
  2c0a66:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0a6a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0a6e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0a72:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0a76:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c0a7a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0a7e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c0a82:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a86:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c0a8a:	73 6a                	jae    2c0af6 <memmove+0x98>
  2c0a8c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0a90:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0a94:	48 01 d0             	add    %rdx,%rax
  2c0a97:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c0a9b:	73 59                	jae    2c0af6 <memmove+0x98>
        s += n, d += n;
  2c0a9d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0aa1:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c0aa5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0aa9:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c0aad:	eb 17                	jmp    2c0ac6 <memmove+0x68>
            *--d = *--s;
  2c0aaf:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c0ab4:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c0ab9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0abd:	0f b6 10             	movzbl (%rax),%edx
  2c0ac0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0ac4:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0ac6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0aca:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0ace:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0ad2:	48 85 c0             	test   %rax,%rax
  2c0ad5:	75 d8                	jne    2c0aaf <memmove+0x51>
    if (s < d && s + n > d) {
  2c0ad7:	eb 2e                	jmp    2c0b07 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c0ad9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0add:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0ae1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0ae5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0ae9:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0aed:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c0af1:	0f b6 12             	movzbl (%rdx),%edx
  2c0af4:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0af6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0afa:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0afe:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0b02:	48 85 c0             	test   %rax,%rax
  2c0b05:	75 d2                	jne    2c0ad9 <memmove+0x7b>
        }
    }
    return dst;
  2c0b07:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0b0b:	c9                   	leave  
  2c0b0c:	c3                   	ret    

00000000002c0b0d <memset>:

void* memset(void* v, int c, size_t n) {
  2c0b0d:	55                   	push   %rbp
  2c0b0e:	48 89 e5             	mov    %rsp,%rbp
  2c0b11:	48 83 ec 28          	sub    $0x28,%rsp
  2c0b15:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0b19:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c0b1c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0b20:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0b24:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0b28:	eb 15                	jmp    2c0b3f <memset+0x32>
        *p = c;
  2c0b2a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0b2d:	89 c2                	mov    %eax,%edx
  2c0b2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0b33:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0b35:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0b3a:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0b3f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0b44:	75 e4                	jne    2c0b2a <memset+0x1d>
    }
    return v;
  2c0b46:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0b4a:	c9                   	leave  
  2c0b4b:	c3                   	ret    

00000000002c0b4c <strlen>:

size_t strlen(const char* s) {
  2c0b4c:	55                   	push   %rbp
  2c0b4d:	48 89 e5             	mov    %rsp,%rbp
  2c0b50:	48 83 ec 18          	sub    $0x18,%rsp
  2c0b54:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c0b58:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0b5f:	00 
  2c0b60:	eb 0a                	jmp    2c0b6c <strlen+0x20>
        ++n;
  2c0b62:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c0b67:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0b6c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0b70:	0f b6 00             	movzbl (%rax),%eax
  2c0b73:	84 c0                	test   %al,%al
  2c0b75:	75 eb                	jne    2c0b62 <strlen+0x16>
    }
    return n;
  2c0b77:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0b7b:	c9                   	leave  
  2c0b7c:	c3                   	ret    

00000000002c0b7d <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c0b7d:	55                   	push   %rbp
  2c0b7e:	48 89 e5             	mov    %rsp,%rbp
  2c0b81:	48 83 ec 20          	sub    $0x20,%rsp
  2c0b85:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0b89:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0b8d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0b94:	00 
  2c0b95:	eb 0a                	jmp    2c0ba1 <strnlen+0x24>
        ++n;
  2c0b97:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0b9c:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0ba1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0ba5:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c0ba9:	74 0b                	je     2c0bb6 <strnlen+0x39>
  2c0bab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0baf:	0f b6 00             	movzbl (%rax),%eax
  2c0bb2:	84 c0                	test   %al,%al
  2c0bb4:	75 e1                	jne    2c0b97 <strnlen+0x1a>
    }
    return n;
  2c0bb6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0bba:	c9                   	leave  
  2c0bbb:	c3                   	ret    

00000000002c0bbc <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c0bbc:	55                   	push   %rbp
  2c0bbd:	48 89 e5             	mov    %rsp,%rbp
  2c0bc0:	48 83 ec 20          	sub    $0x20,%rsp
  2c0bc4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0bc8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c0bcc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0bd0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c0bd4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c0bd8:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0bdc:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c0be0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0be4:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0be8:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c0bec:	0f b6 12             	movzbl (%rdx),%edx
  2c0bef:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c0bf1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0bf5:	48 83 e8 01          	sub    $0x1,%rax
  2c0bf9:	0f b6 00             	movzbl (%rax),%eax
  2c0bfc:	84 c0                	test   %al,%al
  2c0bfe:	75 d4                	jne    2c0bd4 <strcpy+0x18>
    return dst;
  2c0c00:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0c04:	c9                   	leave  
  2c0c05:	c3                   	ret    

00000000002c0c06 <strcmp>:

int strcmp(const char* a, const char* b) {
  2c0c06:	55                   	push   %rbp
  2c0c07:	48 89 e5             	mov    %rsp,%rbp
  2c0c0a:	48 83 ec 10          	sub    $0x10,%rsp
  2c0c0e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0c12:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0c16:	eb 0a                	jmp    2c0c22 <strcmp+0x1c>
        ++a, ++b;
  2c0c18:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0c1d:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0c22:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c26:	0f b6 00             	movzbl (%rax),%eax
  2c0c29:	84 c0                	test   %al,%al
  2c0c2b:	74 1d                	je     2c0c4a <strcmp+0x44>
  2c0c2d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0c31:	0f b6 00             	movzbl (%rax),%eax
  2c0c34:	84 c0                	test   %al,%al
  2c0c36:	74 12                	je     2c0c4a <strcmp+0x44>
  2c0c38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c3c:	0f b6 10             	movzbl (%rax),%edx
  2c0c3f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0c43:	0f b6 00             	movzbl (%rax),%eax
  2c0c46:	38 c2                	cmp    %al,%dl
  2c0c48:	74 ce                	je     2c0c18 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c0c4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c4e:	0f b6 00             	movzbl (%rax),%eax
  2c0c51:	89 c2                	mov    %eax,%edx
  2c0c53:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0c57:	0f b6 00             	movzbl (%rax),%eax
  2c0c5a:	38 d0                	cmp    %dl,%al
  2c0c5c:	0f 92 c0             	setb   %al
  2c0c5f:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c0c62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c66:	0f b6 00             	movzbl (%rax),%eax
  2c0c69:	89 c1                	mov    %eax,%ecx
  2c0c6b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0c6f:	0f b6 00             	movzbl (%rax),%eax
  2c0c72:	38 c1                	cmp    %al,%cl
  2c0c74:	0f 92 c0             	setb   %al
  2c0c77:	0f b6 c0             	movzbl %al,%eax
  2c0c7a:	29 c2                	sub    %eax,%edx
  2c0c7c:	89 d0                	mov    %edx,%eax
}
  2c0c7e:	c9                   	leave  
  2c0c7f:	c3                   	ret    

00000000002c0c80 <strchr>:

char* strchr(const char* s, int c) {
  2c0c80:	55                   	push   %rbp
  2c0c81:	48 89 e5             	mov    %rsp,%rbp
  2c0c84:	48 83 ec 10          	sub    $0x10,%rsp
  2c0c88:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0c8c:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c0c8f:	eb 05                	jmp    2c0c96 <strchr+0x16>
        ++s;
  2c0c91:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c0c96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c9a:	0f b6 00             	movzbl (%rax),%eax
  2c0c9d:	84 c0                	test   %al,%al
  2c0c9f:	74 0e                	je     2c0caf <strchr+0x2f>
  2c0ca1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0ca5:	0f b6 00             	movzbl (%rax),%eax
  2c0ca8:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0cab:	38 d0                	cmp    %dl,%al
  2c0cad:	75 e2                	jne    2c0c91 <strchr+0x11>
    }
    if (*s == (char) c) {
  2c0caf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0cb3:	0f b6 00             	movzbl (%rax),%eax
  2c0cb6:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0cb9:	38 d0                	cmp    %dl,%al
  2c0cbb:	75 06                	jne    2c0cc3 <strchr+0x43>
        return (char*) s;
  2c0cbd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0cc1:	eb 05                	jmp    2c0cc8 <strchr+0x48>
    } else {
        return NULL;
  2c0cc3:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c0cc8:	c9                   	leave  
  2c0cc9:	c3                   	ret    

00000000002c0cca <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c0cca:	55                   	push   %rbp
  2c0ccb:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c0cce:	8b 05 54 13 00 00    	mov    0x1354(%rip),%eax        # 2c2028 <rand_seed_set>
  2c0cd4:	85 c0                	test   %eax,%eax
  2c0cd6:	75 0a                	jne    2c0ce2 <rand+0x18>
        srand(819234718U);
  2c0cd8:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c0cdd:	e8 24 00 00 00       	call   2c0d06 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c0ce2:	8b 05 44 13 00 00    	mov    0x1344(%rip),%eax        # 2c202c <rand_seed>
  2c0ce8:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c0cee:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c0cf3:	89 05 33 13 00 00    	mov    %eax,0x1333(%rip)        # 2c202c <rand_seed>
    return rand_seed & RAND_MAX;
  2c0cf9:	8b 05 2d 13 00 00    	mov    0x132d(%rip),%eax        # 2c202c <rand_seed>
  2c0cff:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c0d04:	5d                   	pop    %rbp
  2c0d05:	c3                   	ret    

00000000002c0d06 <srand>:

void srand(unsigned seed) {
  2c0d06:	55                   	push   %rbp
  2c0d07:	48 89 e5             	mov    %rsp,%rbp
  2c0d0a:	48 83 ec 08          	sub    $0x8,%rsp
  2c0d0e:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c0d11:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c0d14:	89 05 12 13 00 00    	mov    %eax,0x1312(%rip)        # 2c202c <rand_seed>
    rand_seed_set = 1;
  2c0d1a:	c7 05 04 13 00 00 01 	movl   $0x1,0x1304(%rip)        # 2c2028 <rand_seed_set>
  2c0d21:	00 00 00 
}
  2c0d24:	90                   	nop
  2c0d25:	c9                   	leave  
  2c0d26:	c3                   	ret    

00000000002c0d27 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c0d27:	55                   	push   %rbp
  2c0d28:	48 89 e5             	mov    %rsp,%rbp
  2c0d2b:	48 83 ec 28          	sub    $0x28,%rsp
  2c0d2f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0d33:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0d37:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c0d3a:	48 c7 45 f8 40 1d 2c 	movq   $0x2c1d40,-0x8(%rbp)
  2c0d41:	00 
    if (base < 0) {
  2c0d42:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c0d46:	79 0b                	jns    2c0d53 <fill_numbuf+0x2c>
        digits = lower_digits;
  2c0d48:	48 c7 45 f8 60 1d 2c 	movq   $0x2c1d60,-0x8(%rbp)
  2c0d4f:	00 
        base = -base;
  2c0d50:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c0d53:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0d58:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0d5c:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c0d5f:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0d62:	48 63 c8             	movslq %eax,%rcx
  2c0d65:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0d69:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0d6e:	48 f7 f1             	div    %rcx
  2c0d71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0d75:	48 01 d0             	add    %rdx,%rax
  2c0d78:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0d7d:	0f b6 10             	movzbl (%rax),%edx
  2c0d80:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0d84:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c0d86:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0d89:	48 63 f0             	movslq %eax,%rsi
  2c0d8c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0d90:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0d95:	48 f7 f6             	div    %rsi
  2c0d98:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c0d9c:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c0da1:	75 bc                	jne    2c0d5f <fill_numbuf+0x38>
    return numbuf_end;
  2c0da3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0da7:	c9                   	leave  
  2c0da8:	c3                   	ret    

00000000002c0da9 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c0da9:	55                   	push   %rbp
  2c0daa:	48 89 e5             	mov    %rsp,%rbp
  2c0dad:	53                   	push   %rbx
  2c0dae:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c0db5:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c0dbc:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c0dc2:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0dc9:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c0dd0:	e9 8a 09 00 00       	jmp    2c175f <printer_vprintf+0x9b6>
        if (*format != '%') {
  2c0dd5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ddc:	0f b6 00             	movzbl (%rax),%eax
  2c0ddf:	3c 25                	cmp    $0x25,%al
  2c0de1:	74 31                	je     2c0e14 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  2c0de3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0dea:	4c 8b 00             	mov    (%rax),%r8
  2c0ded:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0df4:	0f b6 00             	movzbl (%rax),%eax
  2c0df7:	0f b6 c8             	movzbl %al,%ecx
  2c0dfa:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c0e00:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0e07:	89 ce                	mov    %ecx,%esi
  2c0e09:	48 89 c7             	mov    %rax,%rdi
  2c0e0c:	41 ff d0             	call   *%r8
            continue;
  2c0e0f:	e9 43 09 00 00       	jmp    2c1757 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  2c0e14:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0e1b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0e22:	01 
  2c0e23:	eb 44                	jmp    2c0e69 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  2c0e25:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e2c:	0f b6 00             	movzbl (%rax),%eax
  2c0e2f:	0f be c0             	movsbl %al,%eax
  2c0e32:	89 c6                	mov    %eax,%esi
  2c0e34:	bf 60 1b 2c 00       	mov    $0x2c1b60,%edi
  2c0e39:	e8 42 fe ff ff       	call   2c0c80 <strchr>
  2c0e3e:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c0e42:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c0e47:	74 30                	je     2c0e79 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  2c0e49:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c0e4d:	48 2d 60 1b 2c 00    	sub    $0x2c1b60,%rax
  2c0e53:	ba 01 00 00 00       	mov    $0x1,%edx
  2c0e58:	89 c1                	mov    %eax,%ecx
  2c0e5a:	d3 e2                	shl    %cl,%edx
  2c0e5c:	89 d0                	mov    %edx,%eax
  2c0e5e:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0e61:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0e68:	01 
  2c0e69:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e70:	0f b6 00             	movzbl (%rax),%eax
  2c0e73:	84 c0                	test   %al,%al
  2c0e75:	75 ae                	jne    2c0e25 <printer_vprintf+0x7c>
  2c0e77:	eb 01                	jmp    2c0e7a <printer_vprintf+0xd1>
            } else {
                break;
  2c0e79:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c0e7a:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c0e81:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e88:	0f b6 00             	movzbl (%rax),%eax
  2c0e8b:	3c 30                	cmp    $0x30,%al
  2c0e8d:	7e 67                	jle    2c0ef6 <printer_vprintf+0x14d>
  2c0e8f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e96:	0f b6 00             	movzbl (%rax),%eax
  2c0e99:	3c 39                	cmp    $0x39,%al
  2c0e9b:	7f 59                	jg     2c0ef6 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0e9d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c0ea4:	eb 2e                	jmp    2c0ed4 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  2c0ea6:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c0ea9:	89 d0                	mov    %edx,%eax
  2c0eab:	c1 e0 02             	shl    $0x2,%eax
  2c0eae:	01 d0                	add    %edx,%eax
  2c0eb0:	01 c0                	add    %eax,%eax
  2c0eb2:	89 c1                	mov    %eax,%ecx
  2c0eb4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ebb:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0ebf:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0ec6:	0f b6 00             	movzbl (%rax),%eax
  2c0ec9:	0f be c0             	movsbl %al,%eax
  2c0ecc:	01 c8                	add    %ecx,%eax
  2c0ece:	83 e8 30             	sub    $0x30,%eax
  2c0ed1:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0ed4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0edb:	0f b6 00             	movzbl (%rax),%eax
  2c0ede:	3c 2f                	cmp    $0x2f,%al
  2c0ee0:	0f 8e 85 00 00 00    	jle    2c0f6b <printer_vprintf+0x1c2>
  2c0ee6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0eed:	0f b6 00             	movzbl (%rax),%eax
  2c0ef0:	3c 39                	cmp    $0x39,%al
  2c0ef2:	7e b2                	jle    2c0ea6 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  2c0ef4:	eb 75                	jmp    2c0f6b <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  2c0ef6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0efd:	0f b6 00             	movzbl (%rax),%eax
  2c0f00:	3c 2a                	cmp    $0x2a,%al
  2c0f02:	75 68                	jne    2c0f6c <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  2c0f04:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f0b:	8b 00                	mov    (%rax),%eax
  2c0f0d:	83 f8 2f             	cmp    $0x2f,%eax
  2c0f10:	77 30                	ja     2c0f42 <printer_vprintf+0x199>
  2c0f12:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f19:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0f1d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f24:	8b 00                	mov    (%rax),%eax
  2c0f26:	89 c0                	mov    %eax,%eax
  2c0f28:	48 01 d0             	add    %rdx,%rax
  2c0f2b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f32:	8b 12                	mov    (%rdx),%edx
  2c0f34:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0f37:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f3e:	89 0a                	mov    %ecx,(%rdx)
  2c0f40:	eb 1a                	jmp    2c0f5c <printer_vprintf+0x1b3>
  2c0f42:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f49:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0f4d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0f51:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f58:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0f5c:	8b 00                	mov    (%rax),%eax
  2c0f5e:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c0f61:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0f68:	01 
  2c0f69:	eb 01                	jmp    2c0f6c <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  2c0f6b:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c0f6c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c0f73:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0f7a:	0f b6 00             	movzbl (%rax),%eax
  2c0f7d:	3c 2e                	cmp    $0x2e,%al
  2c0f7f:	0f 85 00 01 00 00    	jne    2c1085 <printer_vprintf+0x2dc>
            ++format;
  2c0f85:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0f8c:	01 
            if (*format >= '0' && *format <= '9') {
  2c0f8d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0f94:	0f b6 00             	movzbl (%rax),%eax
  2c0f97:	3c 2f                	cmp    $0x2f,%al
  2c0f99:	7e 67                	jle    2c1002 <printer_vprintf+0x259>
  2c0f9b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0fa2:	0f b6 00             	movzbl (%rax),%eax
  2c0fa5:	3c 39                	cmp    $0x39,%al
  2c0fa7:	7f 59                	jg     2c1002 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0fa9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c0fb0:	eb 2e                	jmp    2c0fe0 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  2c0fb2:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c0fb5:	89 d0                	mov    %edx,%eax
  2c0fb7:	c1 e0 02             	shl    $0x2,%eax
  2c0fba:	01 d0                	add    %edx,%eax
  2c0fbc:	01 c0                	add    %eax,%eax
  2c0fbe:	89 c1                	mov    %eax,%ecx
  2c0fc0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0fc7:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0fcb:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0fd2:	0f b6 00             	movzbl (%rax),%eax
  2c0fd5:	0f be c0             	movsbl %al,%eax
  2c0fd8:	01 c8                	add    %ecx,%eax
  2c0fda:	83 e8 30             	sub    $0x30,%eax
  2c0fdd:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0fe0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0fe7:	0f b6 00             	movzbl (%rax),%eax
  2c0fea:	3c 2f                	cmp    $0x2f,%al
  2c0fec:	0f 8e 85 00 00 00    	jle    2c1077 <printer_vprintf+0x2ce>
  2c0ff2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ff9:	0f b6 00             	movzbl (%rax),%eax
  2c0ffc:	3c 39                	cmp    $0x39,%al
  2c0ffe:	7e b2                	jle    2c0fb2 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  2c1000:	eb 75                	jmp    2c1077 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  2c1002:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1009:	0f b6 00             	movzbl (%rax),%eax
  2c100c:	3c 2a                	cmp    $0x2a,%al
  2c100e:	75 68                	jne    2c1078 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  2c1010:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1017:	8b 00                	mov    (%rax),%eax
  2c1019:	83 f8 2f             	cmp    $0x2f,%eax
  2c101c:	77 30                	ja     2c104e <printer_vprintf+0x2a5>
  2c101e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1025:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1029:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1030:	8b 00                	mov    (%rax),%eax
  2c1032:	89 c0                	mov    %eax,%eax
  2c1034:	48 01 d0             	add    %rdx,%rax
  2c1037:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c103e:	8b 12                	mov    (%rdx),%edx
  2c1040:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1043:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c104a:	89 0a                	mov    %ecx,(%rdx)
  2c104c:	eb 1a                	jmp    2c1068 <printer_vprintf+0x2bf>
  2c104e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1055:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1059:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c105d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1064:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1068:	8b 00                	mov    (%rax),%eax
  2c106a:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c106d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c1074:	01 
  2c1075:	eb 01                	jmp    2c1078 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  2c1077:	90                   	nop
            }
            if (precision < 0) {
  2c1078:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c107c:	79 07                	jns    2c1085 <printer_vprintf+0x2dc>
                precision = 0;
  2c107e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c1085:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c108c:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c1093:	00 
        int length = 0;
  2c1094:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c109b:	48 c7 45 c8 66 1b 2c 	movq   $0x2c1b66,-0x38(%rbp)
  2c10a2:	00 
    again:
        switch (*format) {
  2c10a3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c10aa:	0f b6 00             	movzbl (%rax),%eax
  2c10ad:	0f be c0             	movsbl %al,%eax
  2c10b0:	83 e8 43             	sub    $0x43,%eax
  2c10b3:	83 f8 37             	cmp    $0x37,%eax
  2c10b6:	0f 87 9f 03 00 00    	ja     2c145b <printer_vprintf+0x6b2>
  2c10bc:	89 c0                	mov    %eax,%eax
  2c10be:	48 8b 04 c5 78 1b 2c 	mov    0x2c1b78(,%rax,8),%rax
  2c10c5:	00 
  2c10c6:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  2c10c8:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c10cf:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c10d6:	01 
            goto again;
  2c10d7:	eb ca                	jmp    2c10a3 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c10d9:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c10dd:	74 5d                	je     2c113c <printer_vprintf+0x393>
  2c10df:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10e6:	8b 00                	mov    (%rax),%eax
  2c10e8:	83 f8 2f             	cmp    $0x2f,%eax
  2c10eb:	77 30                	ja     2c111d <printer_vprintf+0x374>
  2c10ed:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10f4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c10f8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10ff:	8b 00                	mov    (%rax),%eax
  2c1101:	89 c0                	mov    %eax,%eax
  2c1103:	48 01 d0             	add    %rdx,%rax
  2c1106:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c110d:	8b 12                	mov    (%rdx),%edx
  2c110f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1112:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1119:	89 0a                	mov    %ecx,(%rdx)
  2c111b:	eb 1a                	jmp    2c1137 <printer_vprintf+0x38e>
  2c111d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1124:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1128:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c112c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1133:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1137:	48 8b 00             	mov    (%rax),%rax
  2c113a:	eb 5c                	jmp    2c1198 <printer_vprintf+0x3ef>
  2c113c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1143:	8b 00                	mov    (%rax),%eax
  2c1145:	83 f8 2f             	cmp    $0x2f,%eax
  2c1148:	77 30                	ja     2c117a <printer_vprintf+0x3d1>
  2c114a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1151:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1155:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c115c:	8b 00                	mov    (%rax),%eax
  2c115e:	89 c0                	mov    %eax,%eax
  2c1160:	48 01 d0             	add    %rdx,%rax
  2c1163:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c116a:	8b 12                	mov    (%rdx),%edx
  2c116c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c116f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1176:	89 0a                	mov    %ecx,(%rdx)
  2c1178:	eb 1a                	jmp    2c1194 <printer_vprintf+0x3eb>
  2c117a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1181:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1185:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1189:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1190:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1194:	8b 00                	mov    (%rax),%eax
  2c1196:	48 98                	cltq   
  2c1198:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c119c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c11a0:	48 c1 f8 38          	sar    $0x38,%rax
  2c11a4:	25 80 00 00 00       	and    $0x80,%eax
  2c11a9:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c11ac:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c11b0:	74 09                	je     2c11bb <printer_vprintf+0x412>
  2c11b2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c11b6:	48 f7 d8             	neg    %rax
  2c11b9:	eb 04                	jmp    2c11bf <printer_vprintf+0x416>
  2c11bb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c11bf:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c11c3:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c11c6:	83 c8 60             	or     $0x60,%eax
  2c11c9:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c11cc:	e9 cf 02 00 00       	jmp    2c14a0 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c11d1:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c11d5:	74 5d                	je     2c1234 <printer_vprintf+0x48b>
  2c11d7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11de:	8b 00                	mov    (%rax),%eax
  2c11e0:	83 f8 2f             	cmp    $0x2f,%eax
  2c11e3:	77 30                	ja     2c1215 <printer_vprintf+0x46c>
  2c11e5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11ec:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c11f0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11f7:	8b 00                	mov    (%rax),%eax
  2c11f9:	89 c0                	mov    %eax,%eax
  2c11fb:	48 01 d0             	add    %rdx,%rax
  2c11fe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1205:	8b 12                	mov    (%rdx),%edx
  2c1207:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c120a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1211:	89 0a                	mov    %ecx,(%rdx)
  2c1213:	eb 1a                	jmp    2c122f <printer_vprintf+0x486>
  2c1215:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c121c:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1220:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1224:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c122b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c122f:	48 8b 00             	mov    (%rax),%rax
  2c1232:	eb 5c                	jmp    2c1290 <printer_vprintf+0x4e7>
  2c1234:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c123b:	8b 00                	mov    (%rax),%eax
  2c123d:	83 f8 2f             	cmp    $0x2f,%eax
  2c1240:	77 30                	ja     2c1272 <printer_vprintf+0x4c9>
  2c1242:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1249:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c124d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1254:	8b 00                	mov    (%rax),%eax
  2c1256:	89 c0                	mov    %eax,%eax
  2c1258:	48 01 d0             	add    %rdx,%rax
  2c125b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1262:	8b 12                	mov    (%rdx),%edx
  2c1264:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1267:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c126e:	89 0a                	mov    %ecx,(%rdx)
  2c1270:	eb 1a                	jmp    2c128c <printer_vprintf+0x4e3>
  2c1272:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1279:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c127d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1281:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1288:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c128c:	8b 00                	mov    (%rax),%eax
  2c128e:	89 c0                	mov    %eax,%eax
  2c1290:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c1294:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c1298:	e9 03 02 00 00       	jmp    2c14a0 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  2c129d:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c12a4:	e9 28 ff ff ff       	jmp    2c11d1 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  2c12a9:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c12b0:	e9 1c ff ff ff       	jmp    2c11d1 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c12b5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c12bc:	8b 00                	mov    (%rax),%eax
  2c12be:	83 f8 2f             	cmp    $0x2f,%eax
  2c12c1:	77 30                	ja     2c12f3 <printer_vprintf+0x54a>
  2c12c3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c12ca:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c12ce:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c12d5:	8b 00                	mov    (%rax),%eax
  2c12d7:	89 c0                	mov    %eax,%eax
  2c12d9:	48 01 d0             	add    %rdx,%rax
  2c12dc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c12e3:	8b 12                	mov    (%rdx),%edx
  2c12e5:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c12e8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c12ef:	89 0a                	mov    %ecx,(%rdx)
  2c12f1:	eb 1a                	jmp    2c130d <printer_vprintf+0x564>
  2c12f3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c12fa:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c12fe:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1302:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1309:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c130d:	48 8b 00             	mov    (%rax),%rax
  2c1310:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c1314:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c131b:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c1322:	e9 79 01 00 00       	jmp    2c14a0 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  2c1327:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c132e:	8b 00                	mov    (%rax),%eax
  2c1330:	83 f8 2f             	cmp    $0x2f,%eax
  2c1333:	77 30                	ja     2c1365 <printer_vprintf+0x5bc>
  2c1335:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c133c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1340:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1347:	8b 00                	mov    (%rax),%eax
  2c1349:	89 c0                	mov    %eax,%eax
  2c134b:	48 01 d0             	add    %rdx,%rax
  2c134e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1355:	8b 12                	mov    (%rdx),%edx
  2c1357:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c135a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1361:	89 0a                	mov    %ecx,(%rdx)
  2c1363:	eb 1a                	jmp    2c137f <printer_vprintf+0x5d6>
  2c1365:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c136c:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1370:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1374:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c137b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c137f:	48 8b 00             	mov    (%rax),%rax
  2c1382:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c1386:	e9 15 01 00 00       	jmp    2c14a0 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  2c138b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1392:	8b 00                	mov    (%rax),%eax
  2c1394:	83 f8 2f             	cmp    $0x2f,%eax
  2c1397:	77 30                	ja     2c13c9 <printer_vprintf+0x620>
  2c1399:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13a0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c13a4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13ab:	8b 00                	mov    (%rax),%eax
  2c13ad:	89 c0                	mov    %eax,%eax
  2c13af:	48 01 d0             	add    %rdx,%rax
  2c13b2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c13b9:	8b 12                	mov    (%rdx),%edx
  2c13bb:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c13be:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c13c5:	89 0a                	mov    %ecx,(%rdx)
  2c13c7:	eb 1a                	jmp    2c13e3 <printer_vprintf+0x63a>
  2c13c9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13d0:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c13d4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c13d8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c13df:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c13e3:	8b 00                	mov    (%rax),%eax
  2c13e5:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c13eb:	e9 67 03 00 00       	jmp    2c1757 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  2c13f0:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c13f4:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c13f8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13ff:	8b 00                	mov    (%rax),%eax
  2c1401:	83 f8 2f             	cmp    $0x2f,%eax
  2c1404:	77 30                	ja     2c1436 <printer_vprintf+0x68d>
  2c1406:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c140d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1411:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1418:	8b 00                	mov    (%rax),%eax
  2c141a:	89 c0                	mov    %eax,%eax
  2c141c:	48 01 d0             	add    %rdx,%rax
  2c141f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1426:	8b 12                	mov    (%rdx),%edx
  2c1428:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c142b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1432:	89 0a                	mov    %ecx,(%rdx)
  2c1434:	eb 1a                	jmp    2c1450 <printer_vprintf+0x6a7>
  2c1436:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c143d:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1441:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1445:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c144c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1450:	8b 00                	mov    (%rax),%eax
  2c1452:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c1455:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c1459:	eb 45                	jmp    2c14a0 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  2c145b:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c145f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c1463:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c146a:	0f b6 00             	movzbl (%rax),%eax
  2c146d:	84 c0                	test   %al,%al
  2c146f:	74 0c                	je     2c147d <printer_vprintf+0x6d4>
  2c1471:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1478:	0f b6 00             	movzbl (%rax),%eax
  2c147b:	eb 05                	jmp    2c1482 <printer_vprintf+0x6d9>
  2c147d:	b8 25 00 00 00       	mov    $0x25,%eax
  2c1482:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c1485:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c1489:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1490:	0f b6 00             	movzbl (%rax),%eax
  2c1493:	84 c0                	test   %al,%al
  2c1495:	75 08                	jne    2c149f <printer_vprintf+0x6f6>
                format--;
  2c1497:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c149e:	01 
            }
            break;
  2c149f:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c14a0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c14a3:	83 e0 20             	and    $0x20,%eax
  2c14a6:	85 c0                	test   %eax,%eax
  2c14a8:	74 1e                	je     2c14c8 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c14aa:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c14ae:	48 83 c0 18          	add    $0x18,%rax
  2c14b2:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c14b5:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c14b9:	48 89 ce             	mov    %rcx,%rsi
  2c14bc:	48 89 c7             	mov    %rax,%rdi
  2c14bf:	e8 63 f8 ff ff       	call   2c0d27 <fill_numbuf>
  2c14c4:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c14c8:	48 c7 45 c0 66 1b 2c 	movq   $0x2c1b66,-0x40(%rbp)
  2c14cf:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c14d0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c14d3:	83 e0 20             	and    $0x20,%eax
  2c14d6:	85 c0                	test   %eax,%eax
  2c14d8:	74 48                	je     2c1522 <printer_vprintf+0x779>
  2c14da:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c14dd:	83 e0 40             	and    $0x40,%eax
  2c14e0:	85 c0                	test   %eax,%eax
  2c14e2:	74 3e                	je     2c1522 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  2c14e4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c14e7:	25 80 00 00 00       	and    $0x80,%eax
  2c14ec:	85 c0                	test   %eax,%eax
  2c14ee:	74 0a                	je     2c14fa <printer_vprintf+0x751>
                prefix = "-";
  2c14f0:	48 c7 45 c0 67 1b 2c 	movq   $0x2c1b67,-0x40(%rbp)
  2c14f7:	00 
            if (flags & FLAG_NEGATIVE) {
  2c14f8:	eb 73                	jmp    2c156d <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c14fa:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c14fd:	83 e0 10             	and    $0x10,%eax
  2c1500:	85 c0                	test   %eax,%eax
  2c1502:	74 0a                	je     2c150e <printer_vprintf+0x765>
                prefix = "+";
  2c1504:	48 c7 45 c0 69 1b 2c 	movq   $0x2c1b69,-0x40(%rbp)
  2c150b:	00 
            if (flags & FLAG_NEGATIVE) {
  2c150c:	eb 5f                	jmp    2c156d <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c150e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1511:	83 e0 08             	and    $0x8,%eax
  2c1514:	85 c0                	test   %eax,%eax
  2c1516:	74 55                	je     2c156d <printer_vprintf+0x7c4>
                prefix = " ";
  2c1518:	48 c7 45 c0 6b 1b 2c 	movq   $0x2c1b6b,-0x40(%rbp)
  2c151f:	00 
            if (flags & FLAG_NEGATIVE) {
  2c1520:	eb 4b                	jmp    2c156d <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c1522:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1525:	83 e0 20             	and    $0x20,%eax
  2c1528:	85 c0                	test   %eax,%eax
  2c152a:	74 42                	je     2c156e <printer_vprintf+0x7c5>
  2c152c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c152f:	83 e0 01             	and    $0x1,%eax
  2c1532:	85 c0                	test   %eax,%eax
  2c1534:	74 38                	je     2c156e <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  2c1536:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c153a:	74 06                	je     2c1542 <printer_vprintf+0x799>
  2c153c:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c1540:	75 2c                	jne    2c156e <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  2c1542:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c1547:	75 0c                	jne    2c1555 <printer_vprintf+0x7ac>
  2c1549:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c154c:	25 00 01 00 00       	and    $0x100,%eax
  2c1551:	85 c0                	test   %eax,%eax
  2c1553:	74 19                	je     2c156e <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  2c1555:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c1559:	75 07                	jne    2c1562 <printer_vprintf+0x7b9>
  2c155b:	b8 6d 1b 2c 00       	mov    $0x2c1b6d,%eax
  2c1560:	eb 05                	jmp    2c1567 <printer_vprintf+0x7be>
  2c1562:	b8 70 1b 2c 00       	mov    $0x2c1b70,%eax
  2c1567:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c156b:	eb 01                	jmp    2c156e <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  2c156d:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c156e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c1572:	78 24                	js     2c1598 <printer_vprintf+0x7ef>
  2c1574:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1577:	83 e0 20             	and    $0x20,%eax
  2c157a:	85 c0                	test   %eax,%eax
  2c157c:	75 1a                	jne    2c1598 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  2c157e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1581:	48 63 d0             	movslq %eax,%rdx
  2c1584:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1588:	48 89 d6             	mov    %rdx,%rsi
  2c158b:	48 89 c7             	mov    %rax,%rdi
  2c158e:	e8 ea f5 ff ff       	call   2c0b7d <strnlen>
  2c1593:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c1596:	eb 0f                	jmp    2c15a7 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  2c1598:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c159c:	48 89 c7             	mov    %rax,%rdi
  2c159f:	e8 a8 f5 ff ff       	call   2c0b4c <strlen>
  2c15a4:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c15a7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c15aa:	83 e0 20             	and    $0x20,%eax
  2c15ad:	85 c0                	test   %eax,%eax
  2c15af:	74 20                	je     2c15d1 <printer_vprintf+0x828>
  2c15b1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c15b5:	78 1a                	js     2c15d1 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  2c15b7:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c15ba:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c15bd:	7e 08                	jle    2c15c7 <printer_vprintf+0x81e>
  2c15bf:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c15c2:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c15c5:	eb 05                	jmp    2c15cc <printer_vprintf+0x823>
  2c15c7:	b8 00 00 00 00       	mov    $0x0,%eax
  2c15cc:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c15cf:	eb 5c                	jmp    2c162d <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c15d1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c15d4:	83 e0 20             	and    $0x20,%eax
  2c15d7:	85 c0                	test   %eax,%eax
  2c15d9:	74 4b                	je     2c1626 <printer_vprintf+0x87d>
  2c15db:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c15de:	83 e0 02             	and    $0x2,%eax
  2c15e1:	85 c0                	test   %eax,%eax
  2c15e3:	74 41                	je     2c1626 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c15e5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c15e8:	83 e0 04             	and    $0x4,%eax
  2c15eb:	85 c0                	test   %eax,%eax
  2c15ed:	75 37                	jne    2c1626 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  2c15ef:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c15f3:	48 89 c7             	mov    %rax,%rdi
  2c15f6:	e8 51 f5 ff ff       	call   2c0b4c <strlen>
  2c15fb:	89 c2                	mov    %eax,%edx
  2c15fd:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c1600:	01 d0                	add    %edx,%eax
  2c1602:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c1605:	7e 1f                	jle    2c1626 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  2c1607:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c160a:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c160d:	89 c3                	mov    %eax,%ebx
  2c160f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1613:	48 89 c7             	mov    %rax,%rdi
  2c1616:	e8 31 f5 ff ff       	call   2c0b4c <strlen>
  2c161b:	89 c2                	mov    %eax,%edx
  2c161d:	89 d8                	mov    %ebx,%eax
  2c161f:	29 d0                	sub    %edx,%eax
  2c1621:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c1624:	eb 07                	jmp    2c162d <printer_vprintf+0x884>
        } else {
            zeros = 0;
  2c1626:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c162d:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c1630:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c1633:	01 d0                	add    %edx,%eax
  2c1635:	48 63 d8             	movslq %eax,%rbx
  2c1638:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c163c:	48 89 c7             	mov    %rax,%rdi
  2c163f:	e8 08 f5 ff ff       	call   2c0b4c <strlen>
  2c1644:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c1648:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c164b:	29 d0                	sub    %edx,%eax
  2c164d:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c1650:	eb 25                	jmp    2c1677 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  2c1652:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1659:	48 8b 08             	mov    (%rax),%rcx
  2c165c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1662:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1669:	be 20 00 00 00       	mov    $0x20,%esi
  2c166e:	48 89 c7             	mov    %rax,%rdi
  2c1671:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c1673:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c1677:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c167a:	83 e0 04             	and    $0x4,%eax
  2c167d:	85 c0                	test   %eax,%eax
  2c167f:	75 36                	jne    2c16b7 <printer_vprintf+0x90e>
  2c1681:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1685:	7f cb                	jg     2c1652 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  2c1687:	eb 2e                	jmp    2c16b7 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  2c1689:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1690:	4c 8b 00             	mov    (%rax),%r8
  2c1693:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1697:	0f b6 00             	movzbl (%rax),%eax
  2c169a:	0f b6 c8             	movzbl %al,%ecx
  2c169d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c16a3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c16aa:	89 ce                	mov    %ecx,%esi
  2c16ac:	48 89 c7             	mov    %rax,%rdi
  2c16af:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c16b2:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c16b7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c16bb:	0f b6 00             	movzbl (%rax),%eax
  2c16be:	84 c0                	test   %al,%al
  2c16c0:	75 c7                	jne    2c1689 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  2c16c2:	eb 25                	jmp    2c16e9 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  2c16c4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c16cb:	48 8b 08             	mov    (%rax),%rcx
  2c16ce:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c16d4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c16db:	be 30 00 00 00       	mov    $0x30,%esi
  2c16e0:	48 89 c7             	mov    %rax,%rdi
  2c16e3:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c16e5:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c16e9:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c16ed:	7f d5                	jg     2c16c4 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  2c16ef:	eb 32                	jmp    2c1723 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  2c16f1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c16f8:	4c 8b 00             	mov    (%rax),%r8
  2c16fb:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c16ff:	0f b6 00             	movzbl (%rax),%eax
  2c1702:	0f b6 c8             	movzbl %al,%ecx
  2c1705:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c170b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1712:	89 ce                	mov    %ecx,%esi
  2c1714:	48 89 c7             	mov    %rax,%rdi
  2c1717:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c171a:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c171f:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c1723:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c1727:	7f c8                	jg     2c16f1 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  2c1729:	eb 25                	jmp    2c1750 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  2c172b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1732:	48 8b 08             	mov    (%rax),%rcx
  2c1735:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c173b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1742:	be 20 00 00 00       	mov    $0x20,%esi
  2c1747:	48 89 c7             	mov    %rax,%rdi
  2c174a:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c174c:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c1750:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1754:	7f d5                	jg     2c172b <printer_vprintf+0x982>
        }
    done: ;
  2c1756:	90                   	nop
    for (; *format; ++format) {
  2c1757:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c175e:	01 
  2c175f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1766:	0f b6 00             	movzbl (%rax),%eax
  2c1769:	84 c0                	test   %al,%al
  2c176b:	0f 85 64 f6 ff ff    	jne    2c0dd5 <printer_vprintf+0x2c>
    }
}
  2c1771:	90                   	nop
  2c1772:	90                   	nop
  2c1773:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c1777:	c9                   	leave  
  2c1778:	c3                   	ret    

00000000002c1779 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c1779:	55                   	push   %rbp
  2c177a:	48 89 e5             	mov    %rsp,%rbp
  2c177d:	48 83 ec 20          	sub    $0x20,%rsp
  2c1781:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c1785:	89 f0                	mov    %esi,%eax
  2c1787:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c178a:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c178d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1791:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1795:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1799:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c179d:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  2c17a2:	48 39 d0             	cmp    %rdx,%rax
  2c17a5:	72 0c                	jb     2c17b3 <console_putc+0x3a>
        cp->cursor = console;
  2c17a7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c17ab:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  2c17b2:	00 
    }
    if (c == '\n') {
  2c17b3:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c17b7:	75 78                	jne    2c1831 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  2c17b9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c17bd:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c17c1:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c17c7:	48 d1 f8             	sar    %rax
  2c17ca:	48 89 c1             	mov    %rax,%rcx
  2c17cd:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c17d4:	66 66 66 
  2c17d7:	48 89 c8             	mov    %rcx,%rax
  2c17da:	48 f7 ea             	imul   %rdx
  2c17dd:	48 c1 fa 05          	sar    $0x5,%rdx
  2c17e1:	48 89 c8             	mov    %rcx,%rax
  2c17e4:	48 c1 f8 3f          	sar    $0x3f,%rax
  2c17e8:	48 29 c2             	sub    %rax,%rdx
  2c17eb:	48 89 d0             	mov    %rdx,%rax
  2c17ee:	48 c1 e0 02          	shl    $0x2,%rax
  2c17f2:	48 01 d0             	add    %rdx,%rax
  2c17f5:	48 c1 e0 04          	shl    $0x4,%rax
  2c17f9:	48 29 c1             	sub    %rax,%rcx
  2c17fc:	48 89 ca             	mov    %rcx,%rdx
  2c17ff:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c1802:	eb 25                	jmp    2c1829 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  2c1804:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c1807:	83 c8 20             	or     $0x20,%eax
  2c180a:	89 c6                	mov    %eax,%esi
  2c180c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1810:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1814:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1818:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c181c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1820:	89 f2                	mov    %esi,%edx
  2c1822:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c1825:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1829:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c182d:	75 d5                	jne    2c1804 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c182f:	eb 24                	jmp    2c1855 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  2c1831:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  2c1835:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c1838:	09 d0                	or     %edx,%eax
  2c183a:	89 c6                	mov    %eax,%esi
  2c183c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1840:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1844:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1848:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c184c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1850:	89 f2                	mov    %esi,%edx
  2c1852:	66 89 10             	mov    %dx,(%rax)
}
  2c1855:	90                   	nop
  2c1856:	c9                   	leave  
  2c1857:	c3                   	ret    

00000000002c1858 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c1858:	55                   	push   %rbp
  2c1859:	48 89 e5             	mov    %rsp,%rbp
  2c185c:	48 83 ec 30          	sub    $0x30,%rsp
  2c1860:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c1863:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c1866:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c186a:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c186e:	48 c7 45 f0 79 17 2c 	movq   $0x2c1779,-0x10(%rbp)
  2c1875:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1876:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c187a:	78 09                	js     2c1885 <console_vprintf+0x2d>
  2c187c:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c1883:	7e 07                	jle    2c188c <console_vprintf+0x34>
        cpos = 0;
  2c1885:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c188c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c188f:	48 98                	cltq   
  2c1891:	48 01 c0             	add    %rax,%rax
  2c1894:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  2c189a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c189e:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c18a2:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c18a6:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c18a9:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c18ad:	48 89 c7             	mov    %rax,%rdi
  2c18b0:	e8 f4 f4 ff ff       	call   2c0da9 <printer_vprintf>
    return cp.cursor - console;
  2c18b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c18b9:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c18bf:	48 d1 f8             	sar    %rax
}
  2c18c2:	c9                   	leave  
  2c18c3:	c3                   	ret    

00000000002c18c4 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c18c4:	55                   	push   %rbp
  2c18c5:	48 89 e5             	mov    %rsp,%rbp
  2c18c8:	48 83 ec 60          	sub    $0x60,%rsp
  2c18cc:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c18cf:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c18d2:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c18d6:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c18da:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c18de:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c18e2:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c18e9:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c18ed:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c18f1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c18f5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c18f9:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c18fd:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c1901:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c1904:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c1907:	89 c7                	mov    %eax,%edi
  2c1909:	e8 4a ff ff ff       	call   2c1858 <console_vprintf>
  2c190e:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c1911:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c1914:	c9                   	leave  
  2c1915:	c3                   	ret    

00000000002c1916 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c1916:	55                   	push   %rbp
  2c1917:	48 89 e5             	mov    %rsp,%rbp
  2c191a:	48 83 ec 20          	sub    $0x20,%rsp
  2c191e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c1922:	89 f0                	mov    %esi,%eax
  2c1924:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1927:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c192a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c192e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c1932:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1936:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c193a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c193e:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c1942:	48 39 c2             	cmp    %rax,%rdx
  2c1945:	73 1a                	jae    2c1961 <string_putc+0x4b>
        *sp->s++ = c;
  2c1947:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c194b:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c194f:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c1953:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c1957:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c195b:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c195f:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c1961:	90                   	nop
  2c1962:	c9                   	leave  
  2c1963:	c3                   	ret    

00000000002c1964 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c1964:	55                   	push   %rbp
  2c1965:	48 89 e5             	mov    %rsp,%rbp
  2c1968:	48 83 ec 40          	sub    $0x40,%rsp
  2c196c:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c1970:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c1974:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c1978:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c197c:	48 c7 45 e8 16 19 2c 	movq   $0x2c1916,-0x18(%rbp)
  2c1983:	00 
    sp.s = s;
  2c1984:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1988:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c198c:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c1991:	74 33                	je     2c19c6 <vsnprintf+0x62>
        sp.end = s + size - 1;
  2c1993:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c1997:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c199b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c199f:	48 01 d0             	add    %rdx,%rax
  2c19a2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c19a6:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c19aa:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c19ae:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c19b2:	be 00 00 00 00       	mov    $0x0,%esi
  2c19b7:	48 89 c7             	mov    %rax,%rdi
  2c19ba:	e8 ea f3 ff ff       	call   2c0da9 <printer_vprintf>
        *sp.s = 0;
  2c19bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c19c3:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c19c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c19ca:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c19ce:	c9                   	leave  
  2c19cf:	c3                   	ret    

00000000002c19d0 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c19d0:	55                   	push   %rbp
  2c19d1:	48 89 e5             	mov    %rsp,%rbp
  2c19d4:	48 83 ec 70          	sub    $0x70,%rsp
  2c19d8:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c19dc:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c19e0:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c19e4:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c19e8:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c19ec:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c19f0:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c19f7:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c19fb:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c19ff:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c1a03:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c1a07:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c1a0b:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c1a0f:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c1a13:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1a17:	48 89 c7             	mov    %rax,%rdi
  2c1a1a:	e8 45 ff ff ff       	call   2c1964 <vsnprintf>
  2c1a1f:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c1a22:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c1a25:	c9                   	leave  
  2c1a26:	c3                   	ret    

00000000002c1a27 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c1a27:	55                   	push   %rbp
  2c1a28:	48 89 e5             	mov    %rsp,%rbp
  2c1a2b:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c1a2f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c1a36:	eb 13                	jmp    2c1a4b <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  2c1a38:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c1a3b:	48 98                	cltq   
  2c1a3d:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  2c1a44:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c1a47:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1a4b:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c1a52:	7e e4                	jle    2c1a38 <console_clear+0x11>
    }
    cursorpos = 0;
  2c1a54:	c7 05 9e 75 df ff 00 	movl   $0x0,-0x208a62(%rip)        # b8ffc <cursorpos>
  2c1a5b:	00 00 00 
}
  2c1a5e:	90                   	nop
  2c1a5f:	c9                   	leave  
  2c1a60:	c3                   	ret    
