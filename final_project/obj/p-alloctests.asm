
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
  2c0016:	e8 ed 07 00 00       	call   2c0808 <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001b:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0020:	e8 5c 04 00 00       	call   2c0481 <malloc>
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
  2c003f:	e8 c0 04 00 00       	call   2c0504 <realloc>
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
  2c0067:	e8 92 04 00 00       	call   2c04fe <calloc>
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
  2c0086:	e8 80 04 00 00       	call   2c050b <heap_info>
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
  2c00b7:	ba 70 15 2c 00       	mov    $0x2c1570,%edx
  2c00bc:	be 19 00 00 00       	mov    $0x19,%esi
  2c00c1:	bf 7e 15 2c 00       	mov    $0x2c157e,%edi
  2c00c6:	e8 13 02 00 00       	call   2c02de <assert_fail>
	assert(array2[i] == 0);
  2c00cb:	ba 94 15 2c 00       	mov    $0x2c1594,%edx
  2c00d0:	be 21 00 00 00       	mov    $0x21,%esi
  2c00d5:	bf 7e 15 2c 00       	mov    $0x2c157e,%edi
  2c00da:	e8 ff 01 00 00       	call   2c02de <assert_fail>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00df:	ba b8 15 2c 00       	mov    $0x2c15b8,%edx
  2c00e4:	be 28 00 00 00       	mov    $0x28,%esi
  2c00e9:	bf 7e 15 2c 00       	mov    $0x2c157e,%edi
  2c00ee:	e8 eb 01 00 00       	call   2c02de <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c00f3:	be a3 15 2c 00       	mov    $0x2c15a3,%esi
  2c00f8:	bf 00 00 00 00       	mov    $0x0,%edi
  2c00fd:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0102:	e8 79 00 00 00       	call   2c0180 <app_printf>
    }
    
    // free array, array2
    free(array);
  2c0107:	4c 89 ef             	mov    %r13,%rdi
  2c010a:	e8 8c 02 00 00       	call   2c039b <free>
    free(array2);
  2c010f:	4c 89 f7             	mov    %r14,%rdi
  2c0112:	e8 84 02 00 00       	call   2c039b <free>

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
  2c0130:	e8 4c 03 00 00       	call   2c0481 <malloc>
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
  2c016a:	be e8 15 2c 00       	mov    $0x2c15e8,%esi
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
  2c01c8:	0f b6 b7 4d 16 2c 00 	movzbl 0x2c164d(%rdi),%esi
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
  2c01f6:	e8 5f 11 00 00       	call   2c135a <console_vprintf>
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
  2c024f:	be 18 16 2c 00       	mov    $0x2c1618,%esi
  2c0254:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  2c025b:	e8 b1 02 00 00       	call   2c0511 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0260:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0264:	48 89 da             	mov    %rbx,%rdx
  2c0267:	be 99 00 00 00       	mov    $0x99,%esi
  2c026c:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c0273:	e8 ee 11 00 00       	call   2c1466 <vsnprintf>
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
  2c0298:	ba 20 16 2c 00       	mov    $0x2c1620,%edx
  2c029d:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02a2:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02a7:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ac:	e8 15 11 00 00       	call   2c13c6 <console_printf>
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
  2c02d2:	be b3 15 2c 00       	mov    $0x2c15b3,%esi
  2c02d7:	e8 e2 03 00 00       	call   2c06be <strcpy>
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
  2c02eb:	ba 28 16 2c 00       	mov    $0x2c1628,%edx
  2c02f0:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02f5:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02fa:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ff:	e8 c2 10 00 00       	call   2c13c6 <console_printf>
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
  2c0314:	48 89 05 fd 1c 00 00 	mov    %rax,0x1cfd(%rip)        # 2c2018 <result.0>
  2c031b:	cd 3a                	int    $0x3a
  2c031d:	48 89 05 f4 1c 00 00 	mov    %rax,0x1cf4(%rip)        # 2c2018 <result.0>
// want to try and optimize this 
void heap_init(void) {

	// prologue block
	sbrk(sizeof(block_header));
	prologue_block = sbrk(sizeof(block_footer));
  2c0324:	48 89 05 dd 1c 00 00 	mov    %rax,0x1cdd(%rip)        # 2c2008 <prologue_block>

	GET_SIZE(HDRP(prologue_block)) = sizeof(block_header) + sizeof(block_footer);
  2c032b:	48 c7 40 f0 20 00 00 	movq   $0x20,-0x10(%rax)
  2c0332:	00 
	GET_ALLOC(HDRP(prologue_block)) = 1;
  2c0333:	48 8b 05 ce 1c 00 00 	mov    0x1cce(%rip),%rax        # 2c2008 <prologue_block>
  2c033a:	c7 40 f8 01 00 00 00 	movl   $0x1,-0x8(%rax)
	GET_SIZE(FTRP(prologue_block)) = sizeof(block_header) + sizeof(block_footer);
  2c0341:	48 8b 05 c0 1c 00 00 	mov    0x1cc0(%rip),%rax        # 2c2008 <prologue_block>
  2c0348:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  2c034c:	48 c7 44 10 e0 20 00 	movq   $0x20,-0x20(%rax,%rdx,1)
  2c0353:	00 00 
  2c0355:	cd 3a                	int    $0x3a
  2c0357:	48 89 05 ba 1c 00 00 	mov    %rax,0x1cba(%rip)        # 2c2018 <result.0>

	// terminal block
	sbrk(sizeof(block_header));
	GET_SIZE(HDRP(NEXT_BLKP(prologue_block))) = 0;
  2c035e:	48 8b 05 a3 1c 00 00 	mov    0x1ca3(%rip),%rax        # 2c2008 <prologue_block>
  2c0365:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  2c0369:	48 c7 44 10 f0 00 00 	movq   $0x0,-0x10(%rax,%rdx,1)
  2c0370:	00 00 
	GET_ALLOC(HDRP(NEXT_BLKP(prologue_block))) = 0;
  2c0372:	48 8b 05 8f 1c 00 00 	mov    0x1c8f(%rip),%rax        # 2c2008 <prologue_block>
  2c0379:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  2c037d:	c7 44 10 f8 00 00 00 	movl   $0x0,-0x8(%rax,%rdx,1)
  2c0384:	00 

	free_list = NULL;
  2c0385:	48 c7 05 70 1c 00 00 	movq   $0x0,0x1c70(%rip)        # 2c2000 <free_list>
  2c038c:	00 00 00 00 

	initialized_heap = 1;
  2c0390:	c7 05 76 1c 00 00 01 	movl   $0x1,0x1c76(%rip)        # 2c2010 <initialized_heap>
  2c0397:	00 00 00 
}
  2c039a:	c3                   	ret    

00000000002c039b <free>:

void free(void *firstbyte) {
	return;
}
  2c039b:	c3                   	ret    

00000000002c039c <extend>:
//
//	the reason alloating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
void extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  2c039c:	48 81 c7 ff 3f 00 00 	add    $0x3fff,%rdi
  2c03a3:	48 81 e7 00 c0 ff ff 	and    $0xffffffffffffc000,%rdi
  2c03aa:	cd 3a                	int    $0x3a
  2c03ac:	48 89 05 65 1c 00 00 	mov    %rax,0x1c65(%rip)        # 2c2018 <result.0>
	void *bp = sbrk(chunk_aligned_size);

	// setup pointer
	GET_SIZE(HDRP(bp)) = chunk_aligned_size;
  2c03b3:	48 89 78 f0          	mov    %rdi,-0x10(%rax)
	GET_ALLOC(HDRP(bp)) = 0;
  2c03b7:	c7 40 f8 00 00 00 00 	movl   $0x0,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  2c03be:	48 8b 15 3b 1c 00 00 	mov    0x1c3b(%rip),%rdx        # 2c2000 <free_list>
  2c03c5:	48 89 10             	mov    %rdx,(%rax)
	PREV_FPTR(bp) = NULL;
  2c03c8:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  2c03cf:	00 
	GET_SIZE(FTRP(bp)) = chunk_aligned_size;
  2c03d0:	48 89 7c 07 e0       	mov    %rdi,-0x20(%rdi,%rax,1)

	// add to head of free_list
	if (free_list)
  2c03d5:	48 8b 15 24 1c 00 00 	mov    0x1c24(%rip),%rdx        # 2c2000 <free_list>
  2c03dc:	48 85 d2             	test   %rdx,%rdx
  2c03df:	74 04                	je     2c03e5 <extend+0x49>
		PREV_FPTR(free_list) = bp;
  2c03e1:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  2c03e5:	48 89 05 14 1c 00 00 	mov    %rax,0x1c14(%rip)        # 2c2000 <free_list>

	// update terminal block
	GET_SIZE(HDRP(NEXT_BLKP(bp))) = 0;
  2c03ec:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  2c03f0:	48 c7 44 10 f0 00 00 	movq   $0x0,-0x10(%rax,%rdx,1)
  2c03f7:	00 00 
	GET_ALLOC(HDRP(NEXT_BLKP(bp))) = 1;
  2c03f9:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  2c03fd:	c7 44 10 f8 01 00 00 	movl   $0x1,-0x8(%rax,%rdx,1)
  2c0404:	00 
    asm volatile ("int %0" : /* no result */
  2c0405:	bf 52 16 2c 00       	mov    $0x2c1652,%edi
  2c040a:	cd 30                	int    $0x30
 loop: goto loop;
  2c040c:	eb fe                	jmp    2c040c <extend+0x70>

00000000002c040e <set_allocated>:
}

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  2c040e:	48 8b 47 f0          	mov    -0x10(%rdi),%rax
  2c0412:	48 29 f0             	sub    %rsi,%rax

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  2c0415:	48 83 f8 30          	cmp    $0x30,%rax
  2c0419:	76 45                	jbe    2c0460 <set_allocated+0x52>
		GET_SIZE(HDRP(bp)) = size;
  2c041b:	48 89 77 f0          	mov    %rsi,-0x10(%rdi)
		void *leftover_mem_ptr = NEXT_BLKP(bp);
  2c041f:	48 01 fe             	add    %rdi,%rsi

		GET_SIZE(HDRP(leftover_mem_ptr)) = extra_size;
  2c0422:	48 89 46 f0          	mov    %rax,-0x10(%rsi)
		GET_ALLOC(HDRP(leftover_mem_ptr)) = 0;
  2c0426:	c7 46 f8 00 00 00 00 	movl   $0x0,-0x8(%rsi)

		// add pointers to previous and next free block
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp);
  2c042d:	48 8b 17             	mov    (%rdi),%rdx
  2c0430:	48 89 16             	mov    %rdx,(%rsi)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  2c0433:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c0437:	48 89 56 08          	mov    %rdx,0x8(%rsi)
	
		GET_SIZE(FTRP(leftover_mem_ptr)) = extra_size;
  2c043b:	48 89 44 06 e0       	mov    %rax,-0x20(%rsi,%rax,1)

		// update the pointers in previous and next free block to the leftover, as long as they aren't null
		if (PREV_FPTR(bp))
  2c0440:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c0444:	48 85 c0             	test   %rax,%rax
  2c0447:	74 03                	je     2c044c <set_allocated+0x3e>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  2c0449:	48 89 30             	mov    %rsi,(%rax)
		if (NEXT_FPTR(bp))
  2c044c:	48 8b 07             	mov    (%rdi),%rax
  2c044f:	48 85 c0             	test   %rax,%rax
  2c0452:	74 04                	je     2c0458 <set_allocated+0x4a>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  2c0454:	48 89 70 08          	mov    %rsi,0x8(%rax)
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
		if (NEXT_FPTR(bp))
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
	}
	
	GET_ALLOC(HDRP(bp)) = 1;
  2c0458:	c7 47 f8 01 00 00 00 	movl   $0x1,-0x8(%rdi)
}
  2c045f:	c3                   	ret    
		if (PREV_FPTR(bp))
  2c0460:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c0464:	48 85 c0             	test   %rax,%rax
  2c0467:	74 06                	je     2c046f <set_allocated+0x61>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  2c0469:	48 8b 17             	mov    (%rdi),%rdx
  2c046c:	48 89 10             	mov    %rdx,(%rax)
		if (NEXT_FPTR(bp))
  2c046f:	48 8b 07             	mov    (%rdi),%rax
  2c0472:	48 85 c0             	test   %rax,%rax
  2c0475:	74 e1                	je     2c0458 <set_allocated+0x4a>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  2c0477:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c047b:	48 89 50 08          	mov    %rdx,0x8(%rax)
  2c047f:	eb d7                	jmp    2c0458 <set_allocated+0x4a>

00000000002c0481 <malloc>:

void *malloc(uint64_t numbytes) {
  2c0481:	55                   	push   %rbp
  2c0482:	48 89 e5             	mov    %rsp,%rbp
  2c0485:	53                   	push   %rbx
  2c0486:	48 83 ec 08          	sub    $0x8,%rsp
  2c048a:	48 89 fb             	mov    %rdi,%rbx
	if (!initialized_heap)
  2c048d:	83 3d 7c 1b 00 00 00 	cmpl   $0x0,0x1b7c(%rip)        # 2c2010 <initialized_heap>
  2c0494:	74 49                	je     2c04df <malloc+0x5e>
		heap_init();

	if (numbytes == 0)
  2c0496:	48 85 db             	test   %rbx,%rbx
  2c0499:	74 5c                	je     2c04f7 <malloc+0x76>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  2c049b:	48 8d 73 1f          	lea    0x1f(%rbx),%rsi
  2c049f:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  2c04a3:	b8 30 00 00 00       	mov    $0x30,%eax
  2c04a8:	48 39 c6             	cmp    %rax,%rsi
  2c04ab:	48 0f 42 f0          	cmovb  %rax,%rsi
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);

	void *bp = free_list;
  2c04af:	48 8b 1d 4a 1b 00 00 	mov    0x1b4a(%rip),%rbx        # 2c2000 <free_list>
	while (bp) {
  2c04b6:	48 85 db             	test   %rbx,%rbx
  2c04b9:	74 0e                	je     2c04c9 <malloc+0x48>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  2c04bb:	48 39 73 f0          	cmp    %rsi,-0x10(%rbx)
  2c04bf:	73 25                	jae    2c04e6 <malloc+0x65>
			set_allocated(bp, aligned_size);
			return bp;
		}

		bp = NEXT_FPTR(bp);
  2c04c1:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  2c04c4:	48 85 db             	test   %rbx,%rbx
  2c04c7:	75 f2                	jne    2c04bb <malloc+0x3a>
    asm volatile ("int %1" :  "=a" (result)
  2c04c9:	bf 00 00 00 00       	mov    $0x0,%edi
  2c04ce:	cd 3a                	int    $0x3a
  2c04d0:	48 89 05 41 1b 00 00 	mov    %rax,0x1b41(%rip)        # 2c2018 <result.0>
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0) - OVERHEAD;
	extend(aligned_size);
  2c04d7:	48 89 f7             	mov    %rsi,%rdi
  2c04da:	e8 bd fe ff ff       	call   2c039c <extend>
		heap_init();
  2c04df:	e8 29 fe ff ff       	call   2c030d <heap_init>
  2c04e4:	eb b0                	jmp    2c0496 <malloc+0x15>
			set_allocated(bp, aligned_size);
  2c04e6:	48 89 df             	mov    %rbx,%rdi
  2c04e9:	e8 20 ff ff ff       	call   2c040e <set_allocated>
	set_allocated(bp, aligned_size);
    return bp;
}
  2c04ee:	48 89 d8             	mov    %rbx,%rax
  2c04f1:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c04f5:	c9                   	leave  
  2c04f6:	c3                   	ret    
		return NULL;
  2c04f7:	bb 00 00 00 00       	mov    $0x0,%ebx
  2c04fc:	eb f0                	jmp    2c04ee <malloc+0x6d>

00000000002c04fe <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
    return 0;
}
  2c04fe:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0503:	c3                   	ret    

00000000002c0504 <realloc>:

void *realloc(void * ptr, uint64_t sz) {
    return 0;
}
  2c0504:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0509:	c3                   	ret    

00000000002c050a <defrag>:

void defrag() {
}
  2c050a:	c3                   	ret    

00000000002c050b <heap_info>:

int heap_info(heap_info_struct * info) {
    return 0;
}
  2c050b:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0510:	c3                   	ret    

00000000002c0511 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c0511:	55                   	push   %rbp
  2c0512:	48 89 e5             	mov    %rsp,%rbp
  2c0515:	48 83 ec 28          	sub    $0x28,%rsp
  2c0519:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c051d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0521:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0525:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0529:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c052d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0531:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c0535:	eb 1c                	jmp    2c0553 <memcpy+0x42>
        *d = *s;
  2c0537:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c053b:	0f b6 10             	movzbl (%rax),%edx
  2c053e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0542:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0544:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0549:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c054e:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c0553:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0558:	75 dd                	jne    2c0537 <memcpy+0x26>
    }
    return dst;
  2c055a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c055e:	c9                   	leave  
  2c055f:	c3                   	ret    

00000000002c0560 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c0560:	55                   	push   %rbp
  2c0561:	48 89 e5             	mov    %rsp,%rbp
  2c0564:	48 83 ec 28          	sub    $0x28,%rsp
  2c0568:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c056c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0570:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0574:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0578:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c057c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0580:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c0584:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0588:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c058c:	73 6a                	jae    2c05f8 <memmove+0x98>
  2c058e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0592:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0596:	48 01 d0             	add    %rdx,%rax
  2c0599:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c059d:	73 59                	jae    2c05f8 <memmove+0x98>
        s += n, d += n;
  2c059f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c05a3:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c05a7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c05ab:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c05af:	eb 17                	jmp    2c05c8 <memmove+0x68>
            *--d = *--s;
  2c05b1:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c05b6:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c05bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c05bf:	0f b6 10             	movzbl (%rax),%edx
  2c05c2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c05c6:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c05c8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c05cc:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c05d0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c05d4:	48 85 c0             	test   %rax,%rax
  2c05d7:	75 d8                	jne    2c05b1 <memmove+0x51>
    if (s < d && s + n > d) {
  2c05d9:	eb 2e                	jmp    2c0609 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c05db:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c05df:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c05e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c05e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c05eb:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c05ef:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c05f3:	0f b6 12             	movzbl (%rdx),%edx
  2c05f6:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c05f8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c05fc:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0600:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0604:	48 85 c0             	test   %rax,%rax
  2c0607:	75 d2                	jne    2c05db <memmove+0x7b>
        }
    }
    return dst;
  2c0609:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c060d:	c9                   	leave  
  2c060e:	c3                   	ret    

00000000002c060f <memset>:

void* memset(void* v, int c, size_t n) {
  2c060f:	55                   	push   %rbp
  2c0610:	48 89 e5             	mov    %rsp,%rbp
  2c0613:	48 83 ec 28          	sub    $0x28,%rsp
  2c0617:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c061b:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c061e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0622:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0626:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c062a:	eb 15                	jmp    2c0641 <memset+0x32>
        *p = c;
  2c062c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c062f:	89 c2                	mov    %eax,%edx
  2c0631:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0635:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0637:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c063c:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0641:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0646:	75 e4                	jne    2c062c <memset+0x1d>
    }
    return v;
  2c0648:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c064c:	c9                   	leave  
  2c064d:	c3                   	ret    

00000000002c064e <strlen>:

size_t strlen(const char* s) {
  2c064e:	55                   	push   %rbp
  2c064f:	48 89 e5             	mov    %rsp,%rbp
  2c0652:	48 83 ec 18          	sub    $0x18,%rsp
  2c0656:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c065a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0661:	00 
  2c0662:	eb 0a                	jmp    2c066e <strlen+0x20>
        ++n;
  2c0664:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c0669:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c066e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0672:	0f b6 00             	movzbl (%rax),%eax
  2c0675:	84 c0                	test   %al,%al
  2c0677:	75 eb                	jne    2c0664 <strlen+0x16>
    }
    return n;
  2c0679:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c067d:	c9                   	leave  
  2c067e:	c3                   	ret    

00000000002c067f <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c067f:	55                   	push   %rbp
  2c0680:	48 89 e5             	mov    %rsp,%rbp
  2c0683:	48 83 ec 20          	sub    $0x20,%rsp
  2c0687:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c068b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c068f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0696:	00 
  2c0697:	eb 0a                	jmp    2c06a3 <strnlen+0x24>
        ++n;
  2c0699:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c069e:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c06a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c06a7:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c06ab:	74 0b                	je     2c06b8 <strnlen+0x39>
  2c06ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c06b1:	0f b6 00             	movzbl (%rax),%eax
  2c06b4:	84 c0                	test   %al,%al
  2c06b6:	75 e1                	jne    2c0699 <strnlen+0x1a>
    }
    return n;
  2c06b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c06bc:	c9                   	leave  
  2c06bd:	c3                   	ret    

00000000002c06be <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c06be:	55                   	push   %rbp
  2c06bf:	48 89 e5             	mov    %rsp,%rbp
  2c06c2:	48 83 ec 20          	sub    $0x20,%rsp
  2c06c6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c06ca:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c06ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c06d2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c06d6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c06da:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c06de:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c06e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c06e6:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c06ea:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c06ee:	0f b6 12             	movzbl (%rdx),%edx
  2c06f1:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c06f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c06f7:	48 83 e8 01          	sub    $0x1,%rax
  2c06fb:	0f b6 00             	movzbl (%rax),%eax
  2c06fe:	84 c0                	test   %al,%al
  2c0700:	75 d4                	jne    2c06d6 <strcpy+0x18>
    return dst;
  2c0702:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0706:	c9                   	leave  
  2c0707:	c3                   	ret    

00000000002c0708 <strcmp>:

int strcmp(const char* a, const char* b) {
  2c0708:	55                   	push   %rbp
  2c0709:	48 89 e5             	mov    %rsp,%rbp
  2c070c:	48 83 ec 10          	sub    $0x10,%rsp
  2c0710:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0714:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0718:	eb 0a                	jmp    2c0724 <strcmp+0x1c>
        ++a, ++b;
  2c071a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c071f:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0724:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0728:	0f b6 00             	movzbl (%rax),%eax
  2c072b:	84 c0                	test   %al,%al
  2c072d:	74 1d                	je     2c074c <strcmp+0x44>
  2c072f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0733:	0f b6 00             	movzbl (%rax),%eax
  2c0736:	84 c0                	test   %al,%al
  2c0738:	74 12                	je     2c074c <strcmp+0x44>
  2c073a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c073e:	0f b6 10             	movzbl (%rax),%edx
  2c0741:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0745:	0f b6 00             	movzbl (%rax),%eax
  2c0748:	38 c2                	cmp    %al,%dl
  2c074a:	74 ce                	je     2c071a <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c074c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0750:	0f b6 00             	movzbl (%rax),%eax
  2c0753:	89 c2                	mov    %eax,%edx
  2c0755:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0759:	0f b6 00             	movzbl (%rax),%eax
  2c075c:	38 d0                	cmp    %dl,%al
  2c075e:	0f 92 c0             	setb   %al
  2c0761:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c0764:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0768:	0f b6 00             	movzbl (%rax),%eax
  2c076b:	89 c1                	mov    %eax,%ecx
  2c076d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0771:	0f b6 00             	movzbl (%rax),%eax
  2c0774:	38 c1                	cmp    %al,%cl
  2c0776:	0f 92 c0             	setb   %al
  2c0779:	0f b6 c0             	movzbl %al,%eax
  2c077c:	29 c2                	sub    %eax,%edx
  2c077e:	89 d0                	mov    %edx,%eax
}
  2c0780:	c9                   	leave  
  2c0781:	c3                   	ret    

00000000002c0782 <strchr>:

char* strchr(const char* s, int c) {
  2c0782:	55                   	push   %rbp
  2c0783:	48 89 e5             	mov    %rsp,%rbp
  2c0786:	48 83 ec 10          	sub    $0x10,%rsp
  2c078a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c078e:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c0791:	eb 05                	jmp    2c0798 <strchr+0x16>
        ++s;
  2c0793:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c0798:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c079c:	0f b6 00             	movzbl (%rax),%eax
  2c079f:	84 c0                	test   %al,%al
  2c07a1:	74 0e                	je     2c07b1 <strchr+0x2f>
  2c07a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c07a7:	0f b6 00             	movzbl (%rax),%eax
  2c07aa:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c07ad:	38 d0                	cmp    %dl,%al
  2c07af:	75 e2                	jne    2c0793 <strchr+0x11>
    }
    if (*s == (char) c) {
  2c07b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c07b5:	0f b6 00             	movzbl (%rax),%eax
  2c07b8:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c07bb:	38 d0                	cmp    %dl,%al
  2c07bd:	75 06                	jne    2c07c5 <strchr+0x43>
        return (char*) s;
  2c07bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c07c3:	eb 05                	jmp    2c07ca <strchr+0x48>
    } else {
        return NULL;
  2c07c5:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c07ca:	c9                   	leave  
  2c07cb:	c3                   	ret    

00000000002c07cc <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c07cc:	55                   	push   %rbp
  2c07cd:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c07d0:	8b 05 4a 18 00 00    	mov    0x184a(%rip),%eax        # 2c2020 <rand_seed_set>
  2c07d6:	85 c0                	test   %eax,%eax
  2c07d8:	75 0a                	jne    2c07e4 <rand+0x18>
        srand(819234718U);
  2c07da:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c07df:	e8 24 00 00 00       	call   2c0808 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c07e4:	8b 05 3a 18 00 00    	mov    0x183a(%rip),%eax        # 2c2024 <rand_seed>
  2c07ea:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c07f0:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c07f5:	89 05 29 18 00 00    	mov    %eax,0x1829(%rip)        # 2c2024 <rand_seed>
    return rand_seed & RAND_MAX;
  2c07fb:	8b 05 23 18 00 00    	mov    0x1823(%rip),%eax        # 2c2024 <rand_seed>
  2c0801:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c0806:	5d                   	pop    %rbp
  2c0807:	c3                   	ret    

00000000002c0808 <srand>:

void srand(unsigned seed) {
  2c0808:	55                   	push   %rbp
  2c0809:	48 89 e5             	mov    %rsp,%rbp
  2c080c:	48 83 ec 08          	sub    $0x8,%rsp
  2c0810:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c0813:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c0816:	89 05 08 18 00 00    	mov    %eax,0x1808(%rip)        # 2c2024 <rand_seed>
    rand_seed_set = 1;
  2c081c:	c7 05 fa 17 00 00 01 	movl   $0x1,0x17fa(%rip)        # 2c2020 <rand_seed_set>
  2c0823:	00 00 00 
}
  2c0826:	90                   	nop
  2c0827:	c9                   	leave  
  2c0828:	c3                   	ret    

00000000002c0829 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c0829:	55                   	push   %rbp
  2c082a:	48 89 e5             	mov    %rsp,%rbp
  2c082d:	48 83 ec 28          	sub    $0x28,%rsp
  2c0831:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0835:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0839:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c083c:	48 c7 45 f8 40 18 2c 	movq   $0x2c1840,-0x8(%rbp)
  2c0843:	00 
    if (base < 0) {
  2c0844:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c0848:	79 0b                	jns    2c0855 <fill_numbuf+0x2c>
        digits = lower_digits;
  2c084a:	48 c7 45 f8 60 18 2c 	movq   $0x2c1860,-0x8(%rbp)
  2c0851:	00 
        base = -base;
  2c0852:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c0855:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c085a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c085e:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c0861:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0864:	48 63 c8             	movslq %eax,%rcx
  2c0867:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c086b:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0870:	48 f7 f1             	div    %rcx
  2c0873:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0877:	48 01 d0             	add    %rdx,%rax
  2c087a:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c087f:	0f b6 10             	movzbl (%rax),%edx
  2c0882:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0886:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c0888:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c088b:	48 63 f0             	movslq %eax,%rsi
  2c088e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0892:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0897:	48 f7 f6             	div    %rsi
  2c089a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c089e:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c08a3:	75 bc                	jne    2c0861 <fill_numbuf+0x38>
    return numbuf_end;
  2c08a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c08a9:	c9                   	leave  
  2c08aa:	c3                   	ret    

00000000002c08ab <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c08ab:	55                   	push   %rbp
  2c08ac:	48 89 e5             	mov    %rsp,%rbp
  2c08af:	53                   	push   %rbx
  2c08b0:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c08b7:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c08be:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c08c4:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c08cb:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c08d2:	e9 8a 09 00 00       	jmp    2c1261 <printer_vprintf+0x9b6>
        if (*format != '%') {
  2c08d7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c08de:	0f b6 00             	movzbl (%rax),%eax
  2c08e1:	3c 25                	cmp    $0x25,%al
  2c08e3:	74 31                	je     2c0916 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  2c08e5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c08ec:	4c 8b 00             	mov    (%rax),%r8
  2c08ef:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c08f6:	0f b6 00             	movzbl (%rax),%eax
  2c08f9:	0f b6 c8             	movzbl %al,%ecx
  2c08fc:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c0902:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0909:	89 ce                	mov    %ecx,%esi
  2c090b:	48 89 c7             	mov    %rax,%rdi
  2c090e:	41 ff d0             	call   *%r8
            continue;
  2c0911:	e9 43 09 00 00       	jmp    2c1259 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  2c0916:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c091d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0924:	01 
  2c0925:	eb 44                	jmp    2c096b <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  2c0927:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c092e:	0f b6 00             	movzbl (%rax),%eax
  2c0931:	0f be c0             	movsbl %al,%eax
  2c0934:	89 c6                	mov    %eax,%esi
  2c0936:	bf 60 16 2c 00       	mov    $0x2c1660,%edi
  2c093b:	e8 42 fe ff ff       	call   2c0782 <strchr>
  2c0940:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c0944:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c0949:	74 30                	je     2c097b <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  2c094b:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c094f:	48 2d 60 16 2c 00    	sub    $0x2c1660,%rax
  2c0955:	ba 01 00 00 00       	mov    $0x1,%edx
  2c095a:	89 c1                	mov    %eax,%ecx
  2c095c:	d3 e2                	shl    %cl,%edx
  2c095e:	89 d0                	mov    %edx,%eax
  2c0960:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0963:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c096a:	01 
  2c096b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0972:	0f b6 00             	movzbl (%rax),%eax
  2c0975:	84 c0                	test   %al,%al
  2c0977:	75 ae                	jne    2c0927 <printer_vprintf+0x7c>
  2c0979:	eb 01                	jmp    2c097c <printer_vprintf+0xd1>
            } else {
                break;
  2c097b:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c097c:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c0983:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c098a:	0f b6 00             	movzbl (%rax),%eax
  2c098d:	3c 30                	cmp    $0x30,%al
  2c098f:	7e 67                	jle    2c09f8 <printer_vprintf+0x14d>
  2c0991:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0998:	0f b6 00             	movzbl (%rax),%eax
  2c099b:	3c 39                	cmp    $0x39,%al
  2c099d:	7f 59                	jg     2c09f8 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c099f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c09a6:	eb 2e                	jmp    2c09d6 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  2c09a8:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c09ab:	89 d0                	mov    %edx,%eax
  2c09ad:	c1 e0 02             	shl    $0x2,%eax
  2c09b0:	01 d0                	add    %edx,%eax
  2c09b2:	01 c0                	add    %eax,%eax
  2c09b4:	89 c1                	mov    %eax,%ecx
  2c09b6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c09bd:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c09c1:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c09c8:	0f b6 00             	movzbl (%rax),%eax
  2c09cb:	0f be c0             	movsbl %al,%eax
  2c09ce:	01 c8                	add    %ecx,%eax
  2c09d0:	83 e8 30             	sub    $0x30,%eax
  2c09d3:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c09d6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c09dd:	0f b6 00             	movzbl (%rax),%eax
  2c09e0:	3c 2f                	cmp    $0x2f,%al
  2c09e2:	0f 8e 85 00 00 00    	jle    2c0a6d <printer_vprintf+0x1c2>
  2c09e8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c09ef:	0f b6 00             	movzbl (%rax),%eax
  2c09f2:	3c 39                	cmp    $0x39,%al
  2c09f4:	7e b2                	jle    2c09a8 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  2c09f6:	eb 75                	jmp    2c0a6d <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  2c09f8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c09ff:	0f b6 00             	movzbl (%rax),%eax
  2c0a02:	3c 2a                	cmp    $0x2a,%al
  2c0a04:	75 68                	jne    2c0a6e <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  2c0a06:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0a0d:	8b 00                	mov    (%rax),%eax
  2c0a0f:	83 f8 2f             	cmp    $0x2f,%eax
  2c0a12:	77 30                	ja     2c0a44 <printer_vprintf+0x199>
  2c0a14:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0a1b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0a1f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0a26:	8b 00                	mov    (%rax),%eax
  2c0a28:	89 c0                	mov    %eax,%eax
  2c0a2a:	48 01 d0             	add    %rdx,%rax
  2c0a2d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0a34:	8b 12                	mov    (%rdx),%edx
  2c0a36:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0a39:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0a40:	89 0a                	mov    %ecx,(%rdx)
  2c0a42:	eb 1a                	jmp    2c0a5e <printer_vprintf+0x1b3>
  2c0a44:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0a4b:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0a4f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0a53:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0a5a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0a5e:	8b 00                	mov    (%rax),%eax
  2c0a60:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c0a63:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0a6a:	01 
  2c0a6b:	eb 01                	jmp    2c0a6e <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  2c0a6d:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c0a6e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c0a75:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a7c:	0f b6 00             	movzbl (%rax),%eax
  2c0a7f:	3c 2e                	cmp    $0x2e,%al
  2c0a81:	0f 85 00 01 00 00    	jne    2c0b87 <printer_vprintf+0x2dc>
            ++format;
  2c0a87:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0a8e:	01 
            if (*format >= '0' && *format <= '9') {
  2c0a8f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a96:	0f b6 00             	movzbl (%rax),%eax
  2c0a99:	3c 2f                	cmp    $0x2f,%al
  2c0a9b:	7e 67                	jle    2c0b04 <printer_vprintf+0x259>
  2c0a9d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0aa4:	0f b6 00             	movzbl (%rax),%eax
  2c0aa7:	3c 39                	cmp    $0x39,%al
  2c0aa9:	7f 59                	jg     2c0b04 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0aab:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c0ab2:	eb 2e                	jmp    2c0ae2 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  2c0ab4:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c0ab7:	89 d0                	mov    %edx,%eax
  2c0ab9:	c1 e0 02             	shl    $0x2,%eax
  2c0abc:	01 d0                	add    %edx,%eax
  2c0abe:	01 c0                	add    %eax,%eax
  2c0ac0:	89 c1                	mov    %eax,%ecx
  2c0ac2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ac9:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0acd:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0ad4:	0f b6 00             	movzbl (%rax),%eax
  2c0ad7:	0f be c0             	movsbl %al,%eax
  2c0ada:	01 c8                	add    %ecx,%eax
  2c0adc:	83 e8 30             	sub    $0x30,%eax
  2c0adf:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0ae2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ae9:	0f b6 00             	movzbl (%rax),%eax
  2c0aec:	3c 2f                	cmp    $0x2f,%al
  2c0aee:	0f 8e 85 00 00 00    	jle    2c0b79 <printer_vprintf+0x2ce>
  2c0af4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0afb:	0f b6 00             	movzbl (%rax),%eax
  2c0afe:	3c 39                	cmp    $0x39,%al
  2c0b00:	7e b2                	jle    2c0ab4 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  2c0b02:	eb 75                	jmp    2c0b79 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  2c0b04:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b0b:	0f b6 00             	movzbl (%rax),%eax
  2c0b0e:	3c 2a                	cmp    $0x2a,%al
  2c0b10:	75 68                	jne    2c0b7a <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  2c0b12:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b19:	8b 00                	mov    (%rax),%eax
  2c0b1b:	83 f8 2f             	cmp    $0x2f,%eax
  2c0b1e:	77 30                	ja     2c0b50 <printer_vprintf+0x2a5>
  2c0b20:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b27:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0b2b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b32:	8b 00                	mov    (%rax),%eax
  2c0b34:	89 c0                	mov    %eax,%eax
  2c0b36:	48 01 d0             	add    %rdx,%rax
  2c0b39:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0b40:	8b 12                	mov    (%rdx),%edx
  2c0b42:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0b45:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0b4c:	89 0a                	mov    %ecx,(%rdx)
  2c0b4e:	eb 1a                	jmp    2c0b6a <printer_vprintf+0x2bf>
  2c0b50:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b57:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0b5b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0b5f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0b66:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0b6a:	8b 00                	mov    (%rax),%eax
  2c0b6c:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c0b6f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0b76:	01 
  2c0b77:	eb 01                	jmp    2c0b7a <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  2c0b79:	90                   	nop
            }
            if (precision < 0) {
  2c0b7a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c0b7e:	79 07                	jns    2c0b87 <printer_vprintf+0x2dc>
                precision = 0;
  2c0b80:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c0b87:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c0b8e:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c0b95:	00 
        int length = 0;
  2c0b96:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c0b9d:	48 c7 45 c8 66 16 2c 	movq   $0x2c1666,-0x38(%rbp)
  2c0ba4:	00 
    again:
        switch (*format) {
  2c0ba5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0bac:	0f b6 00             	movzbl (%rax),%eax
  2c0baf:	0f be c0             	movsbl %al,%eax
  2c0bb2:	83 e8 43             	sub    $0x43,%eax
  2c0bb5:	83 f8 37             	cmp    $0x37,%eax
  2c0bb8:	0f 87 9f 03 00 00    	ja     2c0f5d <printer_vprintf+0x6b2>
  2c0bbe:	89 c0                	mov    %eax,%eax
  2c0bc0:	48 8b 04 c5 78 16 2c 	mov    0x2c1678(,%rax,8),%rax
  2c0bc7:	00 
  2c0bc8:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  2c0bca:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c0bd1:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0bd8:	01 
            goto again;
  2c0bd9:	eb ca                	jmp    2c0ba5 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c0bdb:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0bdf:	74 5d                	je     2c0c3e <printer_vprintf+0x393>
  2c0be1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0be8:	8b 00                	mov    (%rax),%eax
  2c0bea:	83 f8 2f             	cmp    $0x2f,%eax
  2c0bed:	77 30                	ja     2c0c1f <printer_vprintf+0x374>
  2c0bef:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bf6:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0bfa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c01:	8b 00                	mov    (%rax),%eax
  2c0c03:	89 c0                	mov    %eax,%eax
  2c0c05:	48 01 d0             	add    %rdx,%rax
  2c0c08:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c0f:	8b 12                	mov    (%rdx),%edx
  2c0c11:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0c14:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c1b:	89 0a                	mov    %ecx,(%rdx)
  2c0c1d:	eb 1a                	jmp    2c0c39 <printer_vprintf+0x38e>
  2c0c1f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c26:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0c2a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0c2e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c35:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0c39:	48 8b 00             	mov    (%rax),%rax
  2c0c3c:	eb 5c                	jmp    2c0c9a <printer_vprintf+0x3ef>
  2c0c3e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c45:	8b 00                	mov    (%rax),%eax
  2c0c47:	83 f8 2f             	cmp    $0x2f,%eax
  2c0c4a:	77 30                	ja     2c0c7c <printer_vprintf+0x3d1>
  2c0c4c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c53:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0c57:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c5e:	8b 00                	mov    (%rax),%eax
  2c0c60:	89 c0                	mov    %eax,%eax
  2c0c62:	48 01 d0             	add    %rdx,%rax
  2c0c65:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c6c:	8b 12                	mov    (%rdx),%edx
  2c0c6e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0c71:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c78:	89 0a                	mov    %ecx,(%rdx)
  2c0c7a:	eb 1a                	jmp    2c0c96 <printer_vprintf+0x3eb>
  2c0c7c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c83:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0c87:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0c8b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c92:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0c96:	8b 00                	mov    (%rax),%eax
  2c0c98:	48 98                	cltq   
  2c0c9a:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c0c9e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0ca2:	48 c1 f8 38          	sar    $0x38,%rax
  2c0ca6:	25 80 00 00 00       	and    $0x80,%eax
  2c0cab:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c0cae:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c0cb2:	74 09                	je     2c0cbd <printer_vprintf+0x412>
  2c0cb4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0cb8:	48 f7 d8             	neg    %rax
  2c0cbb:	eb 04                	jmp    2c0cc1 <printer_vprintf+0x416>
  2c0cbd:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0cc1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c0cc5:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c0cc8:	83 c8 60             	or     $0x60,%eax
  2c0ccb:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c0cce:	e9 cf 02 00 00       	jmp    2c0fa2 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c0cd3:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0cd7:	74 5d                	je     2c0d36 <printer_vprintf+0x48b>
  2c0cd9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ce0:	8b 00                	mov    (%rax),%eax
  2c0ce2:	83 f8 2f             	cmp    $0x2f,%eax
  2c0ce5:	77 30                	ja     2c0d17 <printer_vprintf+0x46c>
  2c0ce7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cee:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0cf2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cf9:	8b 00                	mov    (%rax),%eax
  2c0cfb:	89 c0                	mov    %eax,%eax
  2c0cfd:	48 01 d0             	add    %rdx,%rax
  2c0d00:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d07:	8b 12                	mov    (%rdx),%edx
  2c0d09:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0d0c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d13:	89 0a                	mov    %ecx,(%rdx)
  2c0d15:	eb 1a                	jmp    2c0d31 <printer_vprintf+0x486>
  2c0d17:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d1e:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0d22:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0d26:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d2d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0d31:	48 8b 00             	mov    (%rax),%rax
  2c0d34:	eb 5c                	jmp    2c0d92 <printer_vprintf+0x4e7>
  2c0d36:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d3d:	8b 00                	mov    (%rax),%eax
  2c0d3f:	83 f8 2f             	cmp    $0x2f,%eax
  2c0d42:	77 30                	ja     2c0d74 <printer_vprintf+0x4c9>
  2c0d44:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d4b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0d4f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d56:	8b 00                	mov    (%rax),%eax
  2c0d58:	89 c0                	mov    %eax,%eax
  2c0d5a:	48 01 d0             	add    %rdx,%rax
  2c0d5d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d64:	8b 12                	mov    (%rdx),%edx
  2c0d66:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0d69:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d70:	89 0a                	mov    %ecx,(%rdx)
  2c0d72:	eb 1a                	jmp    2c0d8e <printer_vprintf+0x4e3>
  2c0d74:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d7b:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0d7f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0d83:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d8a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0d8e:	8b 00                	mov    (%rax),%eax
  2c0d90:	89 c0                	mov    %eax,%eax
  2c0d92:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c0d96:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c0d9a:	e9 03 02 00 00       	jmp    2c0fa2 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  2c0d9f:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c0da6:	e9 28 ff ff ff       	jmp    2c0cd3 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  2c0dab:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c0db2:	e9 1c ff ff ff       	jmp    2c0cd3 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c0db7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dbe:	8b 00                	mov    (%rax),%eax
  2c0dc0:	83 f8 2f             	cmp    $0x2f,%eax
  2c0dc3:	77 30                	ja     2c0df5 <printer_vprintf+0x54a>
  2c0dc5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dcc:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0dd0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dd7:	8b 00                	mov    (%rax),%eax
  2c0dd9:	89 c0                	mov    %eax,%eax
  2c0ddb:	48 01 d0             	add    %rdx,%rax
  2c0dde:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0de5:	8b 12                	mov    (%rdx),%edx
  2c0de7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0dea:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0df1:	89 0a                	mov    %ecx,(%rdx)
  2c0df3:	eb 1a                	jmp    2c0e0f <printer_vprintf+0x564>
  2c0df5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dfc:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0e00:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0e04:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e0b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0e0f:	48 8b 00             	mov    (%rax),%rax
  2c0e12:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c0e16:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c0e1d:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c0e24:	e9 79 01 00 00       	jmp    2c0fa2 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  2c0e29:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e30:	8b 00                	mov    (%rax),%eax
  2c0e32:	83 f8 2f             	cmp    $0x2f,%eax
  2c0e35:	77 30                	ja     2c0e67 <printer_vprintf+0x5bc>
  2c0e37:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e3e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0e42:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e49:	8b 00                	mov    (%rax),%eax
  2c0e4b:	89 c0                	mov    %eax,%eax
  2c0e4d:	48 01 d0             	add    %rdx,%rax
  2c0e50:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e57:	8b 12                	mov    (%rdx),%edx
  2c0e59:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0e5c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e63:	89 0a                	mov    %ecx,(%rdx)
  2c0e65:	eb 1a                	jmp    2c0e81 <printer_vprintf+0x5d6>
  2c0e67:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e6e:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0e72:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0e76:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e7d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0e81:	48 8b 00             	mov    (%rax),%rax
  2c0e84:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c0e88:	e9 15 01 00 00       	jmp    2c0fa2 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  2c0e8d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e94:	8b 00                	mov    (%rax),%eax
  2c0e96:	83 f8 2f             	cmp    $0x2f,%eax
  2c0e99:	77 30                	ja     2c0ecb <printer_vprintf+0x620>
  2c0e9b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ea2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0ea6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ead:	8b 00                	mov    (%rax),%eax
  2c0eaf:	89 c0                	mov    %eax,%eax
  2c0eb1:	48 01 d0             	add    %rdx,%rax
  2c0eb4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ebb:	8b 12                	mov    (%rdx),%edx
  2c0ebd:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0ec0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ec7:	89 0a                	mov    %ecx,(%rdx)
  2c0ec9:	eb 1a                	jmp    2c0ee5 <printer_vprintf+0x63a>
  2c0ecb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ed2:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0ed6:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0eda:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ee1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0ee5:	8b 00                	mov    (%rax),%eax
  2c0ee7:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c0eed:	e9 67 03 00 00       	jmp    2c1259 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  2c0ef2:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c0ef6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c0efa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f01:	8b 00                	mov    (%rax),%eax
  2c0f03:	83 f8 2f             	cmp    $0x2f,%eax
  2c0f06:	77 30                	ja     2c0f38 <printer_vprintf+0x68d>
  2c0f08:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f0f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0f13:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f1a:	8b 00                	mov    (%rax),%eax
  2c0f1c:	89 c0                	mov    %eax,%eax
  2c0f1e:	48 01 d0             	add    %rdx,%rax
  2c0f21:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f28:	8b 12                	mov    (%rdx),%edx
  2c0f2a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0f2d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f34:	89 0a                	mov    %ecx,(%rdx)
  2c0f36:	eb 1a                	jmp    2c0f52 <printer_vprintf+0x6a7>
  2c0f38:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f3f:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0f43:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0f47:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f4e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0f52:	8b 00                	mov    (%rax),%eax
  2c0f54:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c0f57:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c0f5b:	eb 45                	jmp    2c0fa2 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  2c0f5d:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c0f61:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c0f65:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0f6c:	0f b6 00             	movzbl (%rax),%eax
  2c0f6f:	84 c0                	test   %al,%al
  2c0f71:	74 0c                	je     2c0f7f <printer_vprintf+0x6d4>
  2c0f73:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0f7a:	0f b6 00             	movzbl (%rax),%eax
  2c0f7d:	eb 05                	jmp    2c0f84 <printer_vprintf+0x6d9>
  2c0f7f:	b8 25 00 00 00       	mov    $0x25,%eax
  2c0f84:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c0f87:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c0f8b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0f92:	0f b6 00             	movzbl (%rax),%eax
  2c0f95:	84 c0                	test   %al,%al
  2c0f97:	75 08                	jne    2c0fa1 <printer_vprintf+0x6f6>
                format--;
  2c0f99:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c0fa0:	01 
            }
            break;
  2c0fa1:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c0fa2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0fa5:	83 e0 20             	and    $0x20,%eax
  2c0fa8:	85 c0                	test   %eax,%eax
  2c0faa:	74 1e                	je     2c0fca <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c0fac:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c0fb0:	48 83 c0 18          	add    $0x18,%rax
  2c0fb4:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c0fb7:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c0fbb:	48 89 ce             	mov    %rcx,%rsi
  2c0fbe:	48 89 c7             	mov    %rax,%rdi
  2c0fc1:	e8 63 f8 ff ff       	call   2c0829 <fill_numbuf>
  2c0fc6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c0fca:	48 c7 45 c0 66 16 2c 	movq   $0x2c1666,-0x40(%rbp)
  2c0fd1:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c0fd2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0fd5:	83 e0 20             	and    $0x20,%eax
  2c0fd8:	85 c0                	test   %eax,%eax
  2c0fda:	74 48                	je     2c1024 <printer_vprintf+0x779>
  2c0fdc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0fdf:	83 e0 40             	and    $0x40,%eax
  2c0fe2:	85 c0                	test   %eax,%eax
  2c0fe4:	74 3e                	je     2c1024 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  2c0fe6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0fe9:	25 80 00 00 00       	and    $0x80,%eax
  2c0fee:	85 c0                	test   %eax,%eax
  2c0ff0:	74 0a                	je     2c0ffc <printer_vprintf+0x751>
                prefix = "-";
  2c0ff2:	48 c7 45 c0 67 16 2c 	movq   $0x2c1667,-0x40(%rbp)
  2c0ff9:	00 
            if (flags & FLAG_NEGATIVE) {
  2c0ffa:	eb 73                	jmp    2c106f <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c0ffc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0fff:	83 e0 10             	and    $0x10,%eax
  2c1002:	85 c0                	test   %eax,%eax
  2c1004:	74 0a                	je     2c1010 <printer_vprintf+0x765>
                prefix = "+";
  2c1006:	48 c7 45 c0 69 16 2c 	movq   $0x2c1669,-0x40(%rbp)
  2c100d:	00 
            if (flags & FLAG_NEGATIVE) {
  2c100e:	eb 5f                	jmp    2c106f <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c1010:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1013:	83 e0 08             	and    $0x8,%eax
  2c1016:	85 c0                	test   %eax,%eax
  2c1018:	74 55                	je     2c106f <printer_vprintf+0x7c4>
                prefix = " ";
  2c101a:	48 c7 45 c0 6b 16 2c 	movq   $0x2c166b,-0x40(%rbp)
  2c1021:	00 
            if (flags & FLAG_NEGATIVE) {
  2c1022:	eb 4b                	jmp    2c106f <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c1024:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1027:	83 e0 20             	and    $0x20,%eax
  2c102a:	85 c0                	test   %eax,%eax
  2c102c:	74 42                	je     2c1070 <printer_vprintf+0x7c5>
  2c102e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1031:	83 e0 01             	and    $0x1,%eax
  2c1034:	85 c0                	test   %eax,%eax
  2c1036:	74 38                	je     2c1070 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  2c1038:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c103c:	74 06                	je     2c1044 <printer_vprintf+0x799>
  2c103e:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c1042:	75 2c                	jne    2c1070 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  2c1044:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c1049:	75 0c                	jne    2c1057 <printer_vprintf+0x7ac>
  2c104b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c104e:	25 00 01 00 00       	and    $0x100,%eax
  2c1053:	85 c0                	test   %eax,%eax
  2c1055:	74 19                	je     2c1070 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  2c1057:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c105b:	75 07                	jne    2c1064 <printer_vprintf+0x7b9>
  2c105d:	b8 6d 16 2c 00       	mov    $0x2c166d,%eax
  2c1062:	eb 05                	jmp    2c1069 <printer_vprintf+0x7be>
  2c1064:	b8 70 16 2c 00       	mov    $0x2c1670,%eax
  2c1069:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c106d:	eb 01                	jmp    2c1070 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  2c106f:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c1070:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c1074:	78 24                	js     2c109a <printer_vprintf+0x7ef>
  2c1076:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1079:	83 e0 20             	and    $0x20,%eax
  2c107c:	85 c0                	test   %eax,%eax
  2c107e:	75 1a                	jne    2c109a <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  2c1080:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1083:	48 63 d0             	movslq %eax,%rdx
  2c1086:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c108a:	48 89 d6             	mov    %rdx,%rsi
  2c108d:	48 89 c7             	mov    %rax,%rdi
  2c1090:	e8 ea f5 ff ff       	call   2c067f <strnlen>
  2c1095:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c1098:	eb 0f                	jmp    2c10a9 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  2c109a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c109e:	48 89 c7             	mov    %rax,%rdi
  2c10a1:	e8 a8 f5 ff ff       	call   2c064e <strlen>
  2c10a6:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c10a9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c10ac:	83 e0 20             	and    $0x20,%eax
  2c10af:	85 c0                	test   %eax,%eax
  2c10b1:	74 20                	je     2c10d3 <printer_vprintf+0x828>
  2c10b3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c10b7:	78 1a                	js     2c10d3 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  2c10b9:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c10bc:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c10bf:	7e 08                	jle    2c10c9 <printer_vprintf+0x81e>
  2c10c1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c10c4:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c10c7:	eb 05                	jmp    2c10ce <printer_vprintf+0x823>
  2c10c9:	b8 00 00 00 00       	mov    $0x0,%eax
  2c10ce:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c10d1:	eb 5c                	jmp    2c112f <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c10d3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c10d6:	83 e0 20             	and    $0x20,%eax
  2c10d9:	85 c0                	test   %eax,%eax
  2c10db:	74 4b                	je     2c1128 <printer_vprintf+0x87d>
  2c10dd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c10e0:	83 e0 02             	and    $0x2,%eax
  2c10e3:	85 c0                	test   %eax,%eax
  2c10e5:	74 41                	je     2c1128 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c10e7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c10ea:	83 e0 04             	and    $0x4,%eax
  2c10ed:	85 c0                	test   %eax,%eax
  2c10ef:	75 37                	jne    2c1128 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  2c10f1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c10f5:	48 89 c7             	mov    %rax,%rdi
  2c10f8:	e8 51 f5 ff ff       	call   2c064e <strlen>
  2c10fd:	89 c2                	mov    %eax,%edx
  2c10ff:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c1102:	01 d0                	add    %edx,%eax
  2c1104:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c1107:	7e 1f                	jle    2c1128 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  2c1109:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c110c:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c110f:	89 c3                	mov    %eax,%ebx
  2c1111:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1115:	48 89 c7             	mov    %rax,%rdi
  2c1118:	e8 31 f5 ff ff       	call   2c064e <strlen>
  2c111d:	89 c2                	mov    %eax,%edx
  2c111f:	89 d8                	mov    %ebx,%eax
  2c1121:	29 d0                	sub    %edx,%eax
  2c1123:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c1126:	eb 07                	jmp    2c112f <printer_vprintf+0x884>
        } else {
            zeros = 0;
  2c1128:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c112f:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c1132:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c1135:	01 d0                	add    %edx,%eax
  2c1137:	48 63 d8             	movslq %eax,%rbx
  2c113a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c113e:	48 89 c7             	mov    %rax,%rdi
  2c1141:	e8 08 f5 ff ff       	call   2c064e <strlen>
  2c1146:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c114a:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c114d:	29 d0                	sub    %edx,%eax
  2c114f:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c1152:	eb 25                	jmp    2c1179 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  2c1154:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c115b:	48 8b 08             	mov    (%rax),%rcx
  2c115e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1164:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c116b:	be 20 00 00 00       	mov    $0x20,%esi
  2c1170:	48 89 c7             	mov    %rax,%rdi
  2c1173:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c1175:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c1179:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c117c:	83 e0 04             	and    $0x4,%eax
  2c117f:	85 c0                	test   %eax,%eax
  2c1181:	75 36                	jne    2c11b9 <printer_vprintf+0x90e>
  2c1183:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1187:	7f cb                	jg     2c1154 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  2c1189:	eb 2e                	jmp    2c11b9 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  2c118b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1192:	4c 8b 00             	mov    (%rax),%r8
  2c1195:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1199:	0f b6 00             	movzbl (%rax),%eax
  2c119c:	0f b6 c8             	movzbl %al,%ecx
  2c119f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c11a5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c11ac:	89 ce                	mov    %ecx,%esi
  2c11ae:	48 89 c7             	mov    %rax,%rdi
  2c11b1:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c11b4:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c11b9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c11bd:	0f b6 00             	movzbl (%rax),%eax
  2c11c0:	84 c0                	test   %al,%al
  2c11c2:	75 c7                	jne    2c118b <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  2c11c4:	eb 25                	jmp    2c11eb <printer_vprintf+0x940>
            p->putc(p, '0', color);
  2c11c6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c11cd:	48 8b 08             	mov    (%rax),%rcx
  2c11d0:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c11d6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c11dd:	be 30 00 00 00       	mov    $0x30,%esi
  2c11e2:	48 89 c7             	mov    %rax,%rdi
  2c11e5:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c11e7:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c11eb:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c11ef:	7f d5                	jg     2c11c6 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  2c11f1:	eb 32                	jmp    2c1225 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  2c11f3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c11fa:	4c 8b 00             	mov    (%rax),%r8
  2c11fd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1201:	0f b6 00             	movzbl (%rax),%eax
  2c1204:	0f b6 c8             	movzbl %al,%ecx
  2c1207:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c120d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1214:	89 ce                	mov    %ecx,%esi
  2c1216:	48 89 c7             	mov    %rax,%rdi
  2c1219:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c121c:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c1221:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c1225:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c1229:	7f c8                	jg     2c11f3 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  2c122b:	eb 25                	jmp    2c1252 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  2c122d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1234:	48 8b 08             	mov    (%rax),%rcx
  2c1237:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c123d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1244:	be 20 00 00 00       	mov    $0x20,%esi
  2c1249:	48 89 c7             	mov    %rax,%rdi
  2c124c:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c124e:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c1252:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1256:	7f d5                	jg     2c122d <printer_vprintf+0x982>
        }
    done: ;
  2c1258:	90                   	nop
    for (; *format; ++format) {
  2c1259:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c1260:	01 
  2c1261:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1268:	0f b6 00             	movzbl (%rax),%eax
  2c126b:	84 c0                	test   %al,%al
  2c126d:	0f 85 64 f6 ff ff    	jne    2c08d7 <printer_vprintf+0x2c>
    }
}
  2c1273:	90                   	nop
  2c1274:	90                   	nop
  2c1275:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c1279:	c9                   	leave  
  2c127a:	c3                   	ret    

00000000002c127b <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c127b:	55                   	push   %rbp
  2c127c:	48 89 e5             	mov    %rsp,%rbp
  2c127f:	48 83 ec 20          	sub    $0x20,%rsp
  2c1283:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c1287:	89 f0                	mov    %esi,%eax
  2c1289:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c128c:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c128f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1293:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1297:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c129b:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c129f:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  2c12a4:	48 39 d0             	cmp    %rdx,%rax
  2c12a7:	72 0c                	jb     2c12b5 <console_putc+0x3a>
        cp->cursor = console;
  2c12a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c12ad:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  2c12b4:	00 
    }
    if (c == '\n') {
  2c12b5:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c12b9:	75 78                	jne    2c1333 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  2c12bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c12bf:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c12c3:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c12c9:	48 d1 f8             	sar    %rax
  2c12cc:	48 89 c1             	mov    %rax,%rcx
  2c12cf:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c12d6:	66 66 66 
  2c12d9:	48 89 c8             	mov    %rcx,%rax
  2c12dc:	48 f7 ea             	imul   %rdx
  2c12df:	48 c1 fa 05          	sar    $0x5,%rdx
  2c12e3:	48 89 c8             	mov    %rcx,%rax
  2c12e6:	48 c1 f8 3f          	sar    $0x3f,%rax
  2c12ea:	48 29 c2             	sub    %rax,%rdx
  2c12ed:	48 89 d0             	mov    %rdx,%rax
  2c12f0:	48 c1 e0 02          	shl    $0x2,%rax
  2c12f4:	48 01 d0             	add    %rdx,%rax
  2c12f7:	48 c1 e0 04          	shl    $0x4,%rax
  2c12fb:	48 29 c1             	sub    %rax,%rcx
  2c12fe:	48 89 ca             	mov    %rcx,%rdx
  2c1301:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c1304:	eb 25                	jmp    2c132b <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  2c1306:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c1309:	83 c8 20             	or     $0x20,%eax
  2c130c:	89 c6                	mov    %eax,%esi
  2c130e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1312:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1316:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c131a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c131e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1322:	89 f2                	mov    %esi,%edx
  2c1324:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c1327:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c132b:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c132f:	75 d5                	jne    2c1306 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c1331:	eb 24                	jmp    2c1357 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  2c1333:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  2c1337:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c133a:	09 d0                	or     %edx,%eax
  2c133c:	89 c6                	mov    %eax,%esi
  2c133e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1342:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1346:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c134a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c134e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1352:	89 f2                	mov    %esi,%edx
  2c1354:	66 89 10             	mov    %dx,(%rax)
}
  2c1357:	90                   	nop
  2c1358:	c9                   	leave  
  2c1359:	c3                   	ret    

00000000002c135a <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c135a:	55                   	push   %rbp
  2c135b:	48 89 e5             	mov    %rsp,%rbp
  2c135e:	48 83 ec 30          	sub    $0x30,%rsp
  2c1362:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c1365:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c1368:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c136c:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c1370:	48 c7 45 f0 7b 12 2c 	movq   $0x2c127b,-0x10(%rbp)
  2c1377:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1378:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c137c:	78 09                	js     2c1387 <console_vprintf+0x2d>
  2c137e:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c1385:	7e 07                	jle    2c138e <console_vprintf+0x34>
        cpos = 0;
  2c1387:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c138e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1391:	48 98                	cltq   
  2c1393:	48 01 c0             	add    %rax,%rax
  2c1396:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  2c139c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c13a0:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c13a4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c13a8:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c13ab:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c13af:	48 89 c7             	mov    %rax,%rdi
  2c13b2:	e8 f4 f4 ff ff       	call   2c08ab <printer_vprintf>
    return cp.cursor - console;
  2c13b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c13bb:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c13c1:	48 d1 f8             	sar    %rax
}
  2c13c4:	c9                   	leave  
  2c13c5:	c3                   	ret    

00000000002c13c6 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c13c6:	55                   	push   %rbp
  2c13c7:	48 89 e5             	mov    %rsp,%rbp
  2c13ca:	48 83 ec 60          	sub    $0x60,%rsp
  2c13ce:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c13d1:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c13d4:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c13d8:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c13dc:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c13e0:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c13e4:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c13eb:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c13ef:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c13f3:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c13f7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c13fb:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c13ff:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c1403:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c1406:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c1409:	89 c7                	mov    %eax,%edi
  2c140b:	e8 4a ff ff ff       	call   2c135a <console_vprintf>
  2c1410:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c1413:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c1416:	c9                   	leave  
  2c1417:	c3                   	ret    

00000000002c1418 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c1418:	55                   	push   %rbp
  2c1419:	48 89 e5             	mov    %rsp,%rbp
  2c141c:	48 83 ec 20          	sub    $0x20,%rsp
  2c1420:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c1424:	89 f0                	mov    %esi,%eax
  2c1426:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1429:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c142c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1430:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c1434:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1438:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c143c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1440:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c1444:	48 39 c2             	cmp    %rax,%rdx
  2c1447:	73 1a                	jae    2c1463 <string_putc+0x4b>
        *sp->s++ = c;
  2c1449:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c144d:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1451:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c1455:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c1459:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c145d:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c1461:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c1463:	90                   	nop
  2c1464:	c9                   	leave  
  2c1465:	c3                   	ret    

00000000002c1466 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c1466:	55                   	push   %rbp
  2c1467:	48 89 e5             	mov    %rsp,%rbp
  2c146a:	48 83 ec 40          	sub    $0x40,%rsp
  2c146e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c1472:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c1476:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c147a:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c147e:	48 c7 45 e8 18 14 2c 	movq   $0x2c1418,-0x18(%rbp)
  2c1485:	00 
    sp.s = s;
  2c1486:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c148a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c148e:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c1493:	74 33                	je     2c14c8 <vsnprintf+0x62>
        sp.end = s + size - 1;
  2c1495:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c1499:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c149d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c14a1:	48 01 d0             	add    %rdx,%rax
  2c14a4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c14a8:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c14ac:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c14b0:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c14b4:	be 00 00 00 00       	mov    $0x0,%esi
  2c14b9:	48 89 c7             	mov    %rax,%rdi
  2c14bc:	e8 ea f3 ff ff       	call   2c08ab <printer_vprintf>
        *sp.s = 0;
  2c14c1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c14c5:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c14c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c14cc:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c14d0:	c9                   	leave  
  2c14d1:	c3                   	ret    

00000000002c14d2 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c14d2:	55                   	push   %rbp
  2c14d3:	48 89 e5             	mov    %rsp,%rbp
  2c14d6:	48 83 ec 70          	sub    $0x70,%rsp
  2c14da:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c14de:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c14e2:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c14e6:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c14ea:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c14ee:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c14f2:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c14f9:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c14fd:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c1501:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c1505:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c1509:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c150d:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c1511:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c1515:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1519:	48 89 c7             	mov    %rax,%rdi
  2c151c:	e8 45 ff ff ff       	call   2c1466 <vsnprintf>
  2c1521:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c1524:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c1527:	c9                   	leave  
  2c1528:	c3                   	ret    

00000000002c1529 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c1529:	55                   	push   %rbp
  2c152a:	48 89 e5             	mov    %rsp,%rbp
  2c152d:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c1531:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c1538:	eb 13                	jmp    2c154d <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  2c153a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c153d:	48 98                	cltq   
  2c153f:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  2c1546:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c1549:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c154d:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c1554:	7e e4                	jle    2c153a <console_clear+0x11>
    }
    cursorpos = 0;
  2c1556:	c7 05 9c 7a df ff 00 	movl   $0x0,-0x208564(%rip)        # b8ffc <cursorpos>
  2c155d:	00 00 00 
}
  2c1560:	90                   	nop
  2c1561:	c9                   	leave  
  2c1562:	c3                   	ret    
