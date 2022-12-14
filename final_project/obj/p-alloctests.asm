
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
  2c0016:	e8 5c 08 00 00       	call   2c0877 <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001b:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0020:	e8 ac 04 00 00       	call   2c04d1 <malloc>
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
  2c003f:	e8 2f 05 00 00       	call   2c0573 <realloc>
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
  2c0067:	e8 01 05 00 00       	call   2c056d <calloc>
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
  2c0086:	e8 ef 04 00 00       	call   2c057a <heap_info>
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
  2c00b7:	ba e0 15 2c 00       	mov    $0x2c15e0,%edx
  2c00bc:	be 19 00 00 00       	mov    $0x19,%esi
  2c00c1:	bf ee 15 2c 00       	mov    $0x2c15ee,%edi
  2c00c6:	e8 13 02 00 00       	call   2c02de <assert_fail>
	assert(array2[i] == 0);
  2c00cb:	ba 04 16 2c 00       	mov    $0x2c1604,%edx
  2c00d0:	be 21 00 00 00       	mov    $0x21,%esi
  2c00d5:	bf ee 15 2c 00       	mov    $0x2c15ee,%edi
  2c00da:	e8 ff 01 00 00       	call   2c02de <assert_fail>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00df:	ba 28 16 2c 00       	mov    $0x2c1628,%edx
  2c00e4:	be 28 00 00 00       	mov    $0x28,%esi
  2c00e9:	bf ee 15 2c 00       	mov    $0x2c15ee,%edi
  2c00ee:	e8 eb 01 00 00       	call   2c02de <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c00f3:	be 13 16 2c 00       	mov    $0x2c1613,%esi
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
  2c0130:	e8 9c 03 00 00       	call   2c04d1 <malloc>
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
  2c016a:	be 58 16 2c 00       	mov    $0x2c1658,%esi
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
  2c01c8:	0f b6 b7 bd 16 2c 00 	movzbl 0x2c16bd(%rdi),%esi
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
  2c01f6:	e8 ce 11 00 00       	call   2c13c9 <console_vprintf>
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
  2c024f:	be 88 16 2c 00       	mov    $0x2c1688,%esi
  2c0254:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  2c025b:	e8 20 03 00 00       	call   2c0580 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0260:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0264:	48 89 da             	mov    %rbx,%rdx
  2c0267:	be 99 00 00 00       	mov    $0x99,%esi
  2c026c:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c0273:	e8 5d 12 00 00       	call   2c14d5 <vsnprintf>
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
  2c0298:	ba 90 16 2c 00       	mov    $0x2c1690,%edx
  2c029d:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02a2:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02a7:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ac:	e8 84 11 00 00       	call   2c1435 <console_printf>
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
  2c02d2:	be 23 16 2c 00       	mov    $0x2c1623,%esi
  2c02d7:	e8 51 04 00 00       	call   2c072d <strcpy>
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
  2c02eb:	ba 98 16 2c 00       	mov    $0x2c1698,%edx
  2c02f0:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02f5:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02fa:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ff:	e8 31 11 00 00       	call   2c1435 <console_printf>
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
	if (firstbyte == NULL)
  2c039b:	48 85 ff             	test   %rdi,%rdi
  2c039e:	74 29                	je     2c03c9 <free+0x2e>
		return;

	// setup free things: alloc, list ptrs, footer
	GET_ALLOC(HDRP(firstbyte)) = 0;
  2c03a0:	c7 47 f8 00 00 00 00 	movl   $0x0,-0x8(%rdi)
	NEXT_FPTR(firstbyte) = free_list;
  2c03a7:	48 8b 05 52 1c 00 00 	mov    0x1c52(%rip),%rax        # 2c2000 <free_list>
  2c03ae:	48 89 07             	mov    %rax,(%rdi)
	PREV_FPTR(firstbyte) = NULL;
  2c03b1:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  2c03b8:	00 
	GET_SIZE(FTRP(firstbyte)) = GET_SIZE(HDRP(firstbyte));
  2c03b9:	48 8b 47 f0          	mov    -0x10(%rdi),%rax
  2c03bd:	48 89 44 07 e0       	mov    %rax,-0x20(%rdi,%rax,1)

	// add to free_list
	free_list = firstbyte;
  2c03c2:	48 89 3d 37 1c 00 00 	mov    %rdi,0x1c37(%rip)        # 2c2000 <free_list>

	return;
}
  2c03c9:	c3                   	ret    

00000000002c03ca <extend>:
//
//	the reason alloating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
void extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  2c03ca:	48 81 c7 ff 3f 00 00 	add    $0x3fff,%rdi
  2c03d1:	48 81 e7 00 c0 ff ff 	and    $0xffffffffffffc000,%rdi
  2c03d8:	cd 3a                	int    $0x3a
  2c03da:	48 89 05 37 1c 00 00 	mov    %rax,0x1c37(%rip)        # 2c2018 <result.0>
	void *bp = sbrk(chunk_aligned_size);

	// setup pointer
	GET_SIZE(HDRP(bp)) = chunk_aligned_size;
  2c03e1:	48 89 78 f0          	mov    %rdi,-0x10(%rax)
	GET_ALLOC(HDRP(bp)) = 0;
  2c03e5:	c7 40 f8 00 00 00 00 	movl   $0x0,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  2c03ec:	48 8b 15 0d 1c 00 00 	mov    0x1c0d(%rip),%rdx        # 2c2000 <free_list>
  2c03f3:	48 89 10             	mov    %rdx,(%rax)
	PREV_FPTR(bp) = NULL;
  2c03f6:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  2c03fd:	00 
	GET_SIZE(FTRP(bp)) = chunk_aligned_size;
  2c03fe:	48 89 7c 07 e0       	mov    %rdi,-0x20(%rdi,%rax,1)

	// add to head of free_list
	if (free_list)
  2c0403:	48 8b 15 f6 1b 00 00 	mov    0x1bf6(%rip),%rdx        # 2c2000 <free_list>
  2c040a:	48 85 d2             	test   %rdx,%rdx
  2c040d:	74 04                	je     2c0413 <extend+0x49>
		PREV_FPTR(free_list) = bp;
  2c040f:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  2c0413:	48 89 05 e6 1b 00 00 	mov    %rax,0x1be6(%rip)        # 2c2000 <free_list>

	// update terminal block
	GET_SIZE(HDRP(NEXT_BLKP(bp))) = 0;
  2c041a:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  2c041e:	48 c7 44 10 f0 00 00 	movq   $0x0,-0x10(%rax,%rdx,1)
  2c0425:	00 00 
	GET_ALLOC(HDRP(NEXT_BLKP(bp))) = 1;
  2c0427:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  2c042b:	c7 44 10 f8 01 00 00 	movl   $0x1,-0x8(%rax,%rdx,1)
  2c0432:	00 
}
  2c0433:	c3                   	ret    

00000000002c0434 <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
  2c0434:	48 89 f8             	mov    %rdi,%rax
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  2c0437:	48 8b 57 f0          	mov    -0x10(%rdi),%rdx
  2c043b:	48 29 f2             	sub    %rsi,%rdx

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  2c043e:	48 83 fa 30          	cmp    $0x30,%rdx
  2c0442:	76 57                	jbe    2c049b <set_allocated+0x67>
		GET_SIZE(HDRP(bp)) = size;
  2c0444:	48 89 77 f0          	mov    %rsi,-0x10(%rdi)
		void *leftover_mem_ptr = NEXT_BLKP(bp);
  2c0448:	48 01 fe             	add    %rdi,%rsi

		GET_SIZE(HDRP(leftover_mem_ptr)) = extra_size;
  2c044b:	48 89 56 f0          	mov    %rdx,-0x10(%rsi)
		GET_ALLOC(HDRP(leftover_mem_ptr)) = 0;
  2c044f:	c7 46 f8 00 00 00 00 	movl   $0x0,-0x8(%rsi)

		// add pointers to previous and next free block
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp);
  2c0456:	48 8b 0f             	mov    (%rdi),%rcx
  2c0459:	48 89 0e             	mov    %rcx,(%rsi)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  2c045c:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  2c0460:	48 89 4e 08          	mov    %rcx,0x8(%rsi)
	
		GET_SIZE(FTRP(leftover_mem_ptr)) = extra_size;
  2c0464:	48 89 54 16 e0       	mov    %rdx,-0x20(%rsi,%rdx,1)

		// update the free list
		if (free_list == bp)
  2c0469:	48 39 3d 90 1b 00 00 	cmp    %rdi,0x1b90(%rip)        # 2c2000 <free_list>
  2c0470:	74 20                	je     2c0492 <set_allocated+0x5e>
			free_list = leftover_mem_ptr;

		if (PREV_FPTR(bp))
  2c0472:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c0476:	48 85 d2             	test   %rdx,%rdx
  2c0479:	74 03                	je     2c047e <set_allocated+0x4a>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  2c047b:	48 89 32             	mov    %rsi,(%rdx)
		if (NEXT_FPTR(bp))
  2c047e:	48 8b 10             	mov    (%rax),%rdx
  2c0481:	48 85 d2             	test   %rdx,%rdx
  2c0484:	74 04                	je     2c048a <set_allocated+0x56>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  2c0486:	48 89 72 08          	mov    %rsi,0x8(%rdx)
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
		if (NEXT_FPTR(bp))
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
	}
	
	GET_ALLOC(HDRP(bp)) = 1;
  2c048a:	c7 40 f8 01 00 00 00 	movl   $0x1,-0x8(%rax)
}
  2c0491:	c3                   	ret    
			free_list = leftover_mem_ptr;
  2c0492:	48 89 35 67 1b 00 00 	mov    %rsi,0x1b67(%rip)        # 2c2000 <free_list>
  2c0499:	eb d7                	jmp    2c0472 <set_allocated+0x3e>
		if (free_list == bp)
  2c049b:	48 39 3d 5e 1b 00 00 	cmp    %rdi,0x1b5e(%rip)        # 2c2000 <free_list>
  2c04a2:	74 21                	je     2c04c5 <set_allocated+0x91>
		if (PREV_FPTR(bp))
  2c04a4:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c04a8:	48 85 d2             	test   %rdx,%rdx
  2c04ab:	74 06                	je     2c04b3 <set_allocated+0x7f>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  2c04ad:	48 8b 08             	mov    (%rax),%rcx
  2c04b0:	48 89 0a             	mov    %rcx,(%rdx)
		if (NEXT_FPTR(bp))
  2c04b3:	48 8b 10             	mov    (%rax),%rdx
  2c04b6:	48 85 d2             	test   %rdx,%rdx
  2c04b9:	74 cf                	je     2c048a <set_allocated+0x56>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  2c04bb:	48 8b 48 08          	mov    0x8(%rax),%rcx
  2c04bf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c04c3:	eb c5                	jmp    2c048a <set_allocated+0x56>
			free_list = NEXT_FPTR(bp);
  2c04c5:	48 8b 17             	mov    (%rdi),%rdx
  2c04c8:	48 89 15 31 1b 00 00 	mov    %rdx,0x1b31(%rip)        # 2c2000 <free_list>
  2c04cf:	eb d3                	jmp    2c04a4 <set_allocated+0x70>

00000000002c04d1 <malloc>:

void *malloc(uint64_t numbytes) {
  2c04d1:	55                   	push   %rbp
  2c04d2:	48 89 e5             	mov    %rsp,%rbp
  2c04d5:	41 55                	push   %r13
  2c04d7:	41 54                	push   %r12
  2c04d9:	53                   	push   %rbx
  2c04da:	48 83 ec 08          	sub    $0x8,%rsp
  2c04de:	49 89 fc             	mov    %rdi,%r12
	if (!initialized_heap)
  2c04e1:	83 3d 28 1b 00 00 00 	cmpl   $0x0,0x1b28(%rip)        # 2c2010 <initialized_heap>
  2c04e8:	74 68                	je     2c0552 <malloc+0x81>
		heap_init();

	if (numbytes == 0)
  2c04ea:	4d 85 e4             	test   %r12,%r12
  2c04ed:	74 77                	je     2c0566 <malloc+0x95>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  2c04ef:	49 83 c4 1f          	add    $0x1f,%r12
  2c04f3:	49 83 e4 f0          	and    $0xfffffffffffffff0,%r12
  2c04f7:	b8 30 00 00 00       	mov    $0x30,%eax
  2c04fc:	49 39 c4             	cmp    %rax,%r12
  2c04ff:	4c 0f 42 e0          	cmovb  %rax,%r12
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);

	void *bp = free_list;
  2c0503:	48 8b 1d f6 1a 00 00 	mov    0x1af6(%rip),%rbx        # 2c2000 <free_list>
	while (bp) {
  2c050a:	48 85 db             	test   %rbx,%rbx
  2c050d:	74 0e                	je     2c051d <malloc+0x4c>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  2c050f:	4c 39 63 f0          	cmp    %r12,-0x10(%rbx)
  2c0513:	73 44                	jae    2c0559 <malloc+0x88>
			set_allocated(bp, aligned_size);
			return bp;
		}

		bp = NEXT_FPTR(bp);
  2c0515:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  2c0518:	48 85 db             	test   %rbx,%rbx
  2c051b:	75 f2                	jne    2c050f <malloc+0x3e>
  2c051d:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0522:	cd 3a                	int    $0x3a
  2c0524:	49 89 c5             	mov    %rax,%r13
  2c0527:	48 89 05 ea 1a 00 00 	mov    %rax,0x1aea(%rip)        # 2c2018 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  2c052e:	48 89 c3             	mov    %rax,%rbx
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	extend(aligned_size);
  2c0531:	4c 89 e7             	mov    %r12,%rdi
  2c0534:	e8 91 fe ff ff       	call   2c03ca <extend>
	set_allocated(bp, aligned_size);
  2c0539:	4c 89 e6             	mov    %r12,%rsi
  2c053c:	4c 89 ef             	mov    %r13,%rdi
  2c053f:	e8 f0 fe ff ff       	call   2c0434 <set_allocated>
    return bp;
}
  2c0544:	48 89 d8             	mov    %rbx,%rax
  2c0547:	48 83 c4 08          	add    $0x8,%rsp
  2c054b:	5b                   	pop    %rbx
  2c054c:	41 5c                	pop    %r12
  2c054e:	41 5d                	pop    %r13
  2c0550:	5d                   	pop    %rbp
  2c0551:	c3                   	ret    
		heap_init();
  2c0552:	e8 b6 fd ff ff       	call   2c030d <heap_init>
  2c0557:	eb 91                	jmp    2c04ea <malloc+0x19>
			set_allocated(bp, aligned_size);
  2c0559:	4c 89 e6             	mov    %r12,%rsi
  2c055c:	48 89 df             	mov    %rbx,%rdi
  2c055f:	e8 d0 fe ff ff       	call   2c0434 <set_allocated>
			return bp;
  2c0564:	eb de                	jmp    2c0544 <malloc+0x73>
		return NULL;
  2c0566:	bb 00 00 00 00       	mov    $0x0,%ebx
  2c056b:	eb d7                	jmp    2c0544 <malloc+0x73>

00000000002c056d <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
    return 0;
}
  2c056d:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0572:	c3                   	ret    

00000000002c0573 <realloc>:

void *realloc(void * ptr, uint64_t sz) {
    return 0;
}
  2c0573:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0578:	c3                   	ret    

00000000002c0579 <defrag>:

void defrag() {
}
  2c0579:	c3                   	ret    

00000000002c057a <heap_info>:

int heap_info(heap_info_struct * info) {
    return 0;
}
  2c057a:	b8 00 00 00 00       	mov    $0x0,%eax
  2c057f:	c3                   	ret    

00000000002c0580 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c0580:	55                   	push   %rbp
  2c0581:	48 89 e5             	mov    %rsp,%rbp
  2c0584:	48 83 ec 28          	sub    $0x28,%rsp
  2c0588:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c058c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0590:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0594:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0598:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c059c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c05a0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c05a4:	eb 1c                	jmp    2c05c2 <memcpy+0x42>
        *d = *s;
  2c05a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c05aa:	0f b6 10             	movzbl (%rax),%edx
  2c05ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c05b1:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c05b3:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c05b8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c05bd:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c05c2:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c05c7:	75 dd                	jne    2c05a6 <memcpy+0x26>
    }
    return dst;
  2c05c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c05cd:	c9                   	leave  
  2c05ce:	c3                   	ret    

00000000002c05cf <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c05cf:	55                   	push   %rbp
  2c05d0:	48 89 e5             	mov    %rsp,%rbp
  2c05d3:	48 83 ec 28          	sub    $0x28,%rsp
  2c05d7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c05db:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c05df:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c05e3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c05e7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c05eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c05ef:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c05f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c05f7:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c05fb:	73 6a                	jae    2c0667 <memmove+0x98>
  2c05fd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0601:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0605:	48 01 d0             	add    %rdx,%rax
  2c0608:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c060c:	73 59                	jae    2c0667 <memmove+0x98>
        s += n, d += n;
  2c060e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0612:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c0616:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c061a:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c061e:	eb 17                	jmp    2c0637 <memmove+0x68>
            *--d = *--s;
  2c0620:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c0625:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c062a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c062e:	0f b6 10             	movzbl (%rax),%edx
  2c0631:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0635:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0637:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c063b:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c063f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0643:	48 85 c0             	test   %rax,%rax
  2c0646:	75 d8                	jne    2c0620 <memmove+0x51>
    if (s < d && s + n > d) {
  2c0648:	eb 2e                	jmp    2c0678 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c064a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c064e:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0652:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0656:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c065a:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c065e:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c0662:	0f b6 12             	movzbl (%rdx),%edx
  2c0665:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0667:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c066b:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c066f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0673:	48 85 c0             	test   %rax,%rax
  2c0676:	75 d2                	jne    2c064a <memmove+0x7b>
        }
    }
    return dst;
  2c0678:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c067c:	c9                   	leave  
  2c067d:	c3                   	ret    

00000000002c067e <memset>:

void* memset(void* v, int c, size_t n) {
  2c067e:	55                   	push   %rbp
  2c067f:	48 89 e5             	mov    %rsp,%rbp
  2c0682:	48 83 ec 28          	sub    $0x28,%rsp
  2c0686:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c068a:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c068d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0691:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0695:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0699:	eb 15                	jmp    2c06b0 <memset+0x32>
        *p = c;
  2c069b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c069e:	89 c2                	mov    %eax,%edx
  2c06a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c06a4:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c06a6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c06ab:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c06b0:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c06b5:	75 e4                	jne    2c069b <memset+0x1d>
    }
    return v;
  2c06b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c06bb:	c9                   	leave  
  2c06bc:	c3                   	ret    

00000000002c06bd <strlen>:

size_t strlen(const char* s) {
  2c06bd:	55                   	push   %rbp
  2c06be:	48 89 e5             	mov    %rsp,%rbp
  2c06c1:	48 83 ec 18          	sub    $0x18,%rsp
  2c06c5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c06c9:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c06d0:	00 
  2c06d1:	eb 0a                	jmp    2c06dd <strlen+0x20>
        ++n;
  2c06d3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c06d8:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c06dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c06e1:	0f b6 00             	movzbl (%rax),%eax
  2c06e4:	84 c0                	test   %al,%al
  2c06e6:	75 eb                	jne    2c06d3 <strlen+0x16>
    }
    return n;
  2c06e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c06ec:	c9                   	leave  
  2c06ed:	c3                   	ret    

00000000002c06ee <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c06ee:	55                   	push   %rbp
  2c06ef:	48 89 e5             	mov    %rsp,%rbp
  2c06f2:	48 83 ec 20          	sub    $0x20,%rsp
  2c06f6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c06fa:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c06fe:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0705:	00 
  2c0706:	eb 0a                	jmp    2c0712 <strnlen+0x24>
        ++n;
  2c0708:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c070d:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0712:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0716:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c071a:	74 0b                	je     2c0727 <strnlen+0x39>
  2c071c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0720:	0f b6 00             	movzbl (%rax),%eax
  2c0723:	84 c0                	test   %al,%al
  2c0725:	75 e1                	jne    2c0708 <strnlen+0x1a>
    }
    return n;
  2c0727:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c072b:	c9                   	leave  
  2c072c:	c3                   	ret    

00000000002c072d <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c072d:	55                   	push   %rbp
  2c072e:	48 89 e5             	mov    %rsp,%rbp
  2c0731:	48 83 ec 20          	sub    $0x20,%rsp
  2c0735:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0739:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c073d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0741:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c0745:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c0749:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c074d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c0751:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0755:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0759:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c075d:	0f b6 12             	movzbl (%rdx),%edx
  2c0760:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c0762:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0766:	48 83 e8 01          	sub    $0x1,%rax
  2c076a:	0f b6 00             	movzbl (%rax),%eax
  2c076d:	84 c0                	test   %al,%al
  2c076f:	75 d4                	jne    2c0745 <strcpy+0x18>
    return dst;
  2c0771:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0775:	c9                   	leave  
  2c0776:	c3                   	ret    

00000000002c0777 <strcmp>:

int strcmp(const char* a, const char* b) {
  2c0777:	55                   	push   %rbp
  2c0778:	48 89 e5             	mov    %rsp,%rbp
  2c077b:	48 83 ec 10          	sub    $0x10,%rsp
  2c077f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0783:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0787:	eb 0a                	jmp    2c0793 <strcmp+0x1c>
        ++a, ++b;
  2c0789:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c078e:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0793:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0797:	0f b6 00             	movzbl (%rax),%eax
  2c079a:	84 c0                	test   %al,%al
  2c079c:	74 1d                	je     2c07bb <strcmp+0x44>
  2c079e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c07a2:	0f b6 00             	movzbl (%rax),%eax
  2c07a5:	84 c0                	test   %al,%al
  2c07a7:	74 12                	je     2c07bb <strcmp+0x44>
  2c07a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c07ad:	0f b6 10             	movzbl (%rax),%edx
  2c07b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c07b4:	0f b6 00             	movzbl (%rax),%eax
  2c07b7:	38 c2                	cmp    %al,%dl
  2c07b9:	74 ce                	je     2c0789 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c07bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c07bf:	0f b6 00             	movzbl (%rax),%eax
  2c07c2:	89 c2                	mov    %eax,%edx
  2c07c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c07c8:	0f b6 00             	movzbl (%rax),%eax
  2c07cb:	38 d0                	cmp    %dl,%al
  2c07cd:	0f 92 c0             	setb   %al
  2c07d0:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c07d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c07d7:	0f b6 00             	movzbl (%rax),%eax
  2c07da:	89 c1                	mov    %eax,%ecx
  2c07dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c07e0:	0f b6 00             	movzbl (%rax),%eax
  2c07e3:	38 c1                	cmp    %al,%cl
  2c07e5:	0f 92 c0             	setb   %al
  2c07e8:	0f b6 c0             	movzbl %al,%eax
  2c07eb:	29 c2                	sub    %eax,%edx
  2c07ed:	89 d0                	mov    %edx,%eax
}
  2c07ef:	c9                   	leave  
  2c07f0:	c3                   	ret    

00000000002c07f1 <strchr>:

char* strchr(const char* s, int c) {
  2c07f1:	55                   	push   %rbp
  2c07f2:	48 89 e5             	mov    %rsp,%rbp
  2c07f5:	48 83 ec 10          	sub    $0x10,%rsp
  2c07f9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c07fd:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c0800:	eb 05                	jmp    2c0807 <strchr+0x16>
        ++s;
  2c0802:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c0807:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c080b:	0f b6 00             	movzbl (%rax),%eax
  2c080e:	84 c0                	test   %al,%al
  2c0810:	74 0e                	je     2c0820 <strchr+0x2f>
  2c0812:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0816:	0f b6 00             	movzbl (%rax),%eax
  2c0819:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c081c:	38 d0                	cmp    %dl,%al
  2c081e:	75 e2                	jne    2c0802 <strchr+0x11>
    }
    if (*s == (char) c) {
  2c0820:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0824:	0f b6 00             	movzbl (%rax),%eax
  2c0827:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c082a:	38 d0                	cmp    %dl,%al
  2c082c:	75 06                	jne    2c0834 <strchr+0x43>
        return (char*) s;
  2c082e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0832:	eb 05                	jmp    2c0839 <strchr+0x48>
    } else {
        return NULL;
  2c0834:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c0839:	c9                   	leave  
  2c083a:	c3                   	ret    

00000000002c083b <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c083b:	55                   	push   %rbp
  2c083c:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c083f:	8b 05 db 17 00 00    	mov    0x17db(%rip),%eax        # 2c2020 <rand_seed_set>
  2c0845:	85 c0                	test   %eax,%eax
  2c0847:	75 0a                	jne    2c0853 <rand+0x18>
        srand(819234718U);
  2c0849:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c084e:	e8 24 00 00 00       	call   2c0877 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c0853:	8b 05 cb 17 00 00    	mov    0x17cb(%rip),%eax        # 2c2024 <rand_seed>
  2c0859:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c085f:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c0864:	89 05 ba 17 00 00    	mov    %eax,0x17ba(%rip)        # 2c2024 <rand_seed>
    return rand_seed & RAND_MAX;
  2c086a:	8b 05 b4 17 00 00    	mov    0x17b4(%rip),%eax        # 2c2024 <rand_seed>
  2c0870:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c0875:	5d                   	pop    %rbp
  2c0876:	c3                   	ret    

00000000002c0877 <srand>:

void srand(unsigned seed) {
  2c0877:	55                   	push   %rbp
  2c0878:	48 89 e5             	mov    %rsp,%rbp
  2c087b:	48 83 ec 08          	sub    $0x8,%rsp
  2c087f:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c0882:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c0885:	89 05 99 17 00 00    	mov    %eax,0x1799(%rip)        # 2c2024 <rand_seed>
    rand_seed_set = 1;
  2c088b:	c7 05 8b 17 00 00 01 	movl   $0x1,0x178b(%rip)        # 2c2020 <rand_seed_set>
  2c0892:	00 00 00 
}
  2c0895:	90                   	nop
  2c0896:	c9                   	leave  
  2c0897:	c3                   	ret    

00000000002c0898 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c0898:	55                   	push   %rbp
  2c0899:	48 89 e5             	mov    %rsp,%rbp
  2c089c:	48 83 ec 28          	sub    $0x28,%rsp
  2c08a0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c08a4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c08a8:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c08ab:	48 c7 45 f8 b0 18 2c 	movq   $0x2c18b0,-0x8(%rbp)
  2c08b2:	00 
    if (base < 0) {
  2c08b3:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c08b7:	79 0b                	jns    2c08c4 <fill_numbuf+0x2c>
        digits = lower_digits;
  2c08b9:	48 c7 45 f8 d0 18 2c 	movq   $0x2c18d0,-0x8(%rbp)
  2c08c0:	00 
        base = -base;
  2c08c1:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c08c4:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c08c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c08cd:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c08d0:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c08d3:	48 63 c8             	movslq %eax,%rcx
  2c08d6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c08da:	ba 00 00 00 00       	mov    $0x0,%edx
  2c08df:	48 f7 f1             	div    %rcx
  2c08e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c08e6:	48 01 d0             	add    %rdx,%rax
  2c08e9:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c08ee:	0f b6 10             	movzbl (%rax),%edx
  2c08f1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c08f5:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c08f7:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c08fa:	48 63 f0             	movslq %eax,%rsi
  2c08fd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0901:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0906:	48 f7 f6             	div    %rsi
  2c0909:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c090d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c0912:	75 bc                	jne    2c08d0 <fill_numbuf+0x38>
    return numbuf_end;
  2c0914:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0918:	c9                   	leave  
  2c0919:	c3                   	ret    

00000000002c091a <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c091a:	55                   	push   %rbp
  2c091b:	48 89 e5             	mov    %rsp,%rbp
  2c091e:	53                   	push   %rbx
  2c091f:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c0926:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c092d:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c0933:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c093a:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c0941:	e9 8a 09 00 00       	jmp    2c12d0 <printer_vprintf+0x9b6>
        if (*format != '%') {
  2c0946:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c094d:	0f b6 00             	movzbl (%rax),%eax
  2c0950:	3c 25                	cmp    $0x25,%al
  2c0952:	74 31                	je     2c0985 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  2c0954:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c095b:	4c 8b 00             	mov    (%rax),%r8
  2c095e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0965:	0f b6 00             	movzbl (%rax),%eax
  2c0968:	0f b6 c8             	movzbl %al,%ecx
  2c096b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c0971:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0978:	89 ce                	mov    %ecx,%esi
  2c097a:	48 89 c7             	mov    %rax,%rdi
  2c097d:	41 ff d0             	call   *%r8
            continue;
  2c0980:	e9 43 09 00 00       	jmp    2c12c8 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  2c0985:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c098c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0993:	01 
  2c0994:	eb 44                	jmp    2c09da <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  2c0996:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c099d:	0f b6 00             	movzbl (%rax),%eax
  2c09a0:	0f be c0             	movsbl %al,%eax
  2c09a3:	89 c6                	mov    %eax,%esi
  2c09a5:	bf d0 16 2c 00       	mov    $0x2c16d0,%edi
  2c09aa:	e8 42 fe ff ff       	call   2c07f1 <strchr>
  2c09af:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c09b3:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c09b8:	74 30                	je     2c09ea <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  2c09ba:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c09be:	48 2d d0 16 2c 00    	sub    $0x2c16d0,%rax
  2c09c4:	ba 01 00 00 00       	mov    $0x1,%edx
  2c09c9:	89 c1                	mov    %eax,%ecx
  2c09cb:	d3 e2                	shl    %cl,%edx
  2c09cd:	89 d0                	mov    %edx,%eax
  2c09cf:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c09d2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c09d9:	01 
  2c09da:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c09e1:	0f b6 00             	movzbl (%rax),%eax
  2c09e4:	84 c0                	test   %al,%al
  2c09e6:	75 ae                	jne    2c0996 <printer_vprintf+0x7c>
  2c09e8:	eb 01                	jmp    2c09eb <printer_vprintf+0xd1>
            } else {
                break;
  2c09ea:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c09eb:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c09f2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c09f9:	0f b6 00             	movzbl (%rax),%eax
  2c09fc:	3c 30                	cmp    $0x30,%al
  2c09fe:	7e 67                	jle    2c0a67 <printer_vprintf+0x14d>
  2c0a00:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a07:	0f b6 00             	movzbl (%rax),%eax
  2c0a0a:	3c 39                	cmp    $0x39,%al
  2c0a0c:	7f 59                	jg     2c0a67 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0a0e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c0a15:	eb 2e                	jmp    2c0a45 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  2c0a17:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c0a1a:	89 d0                	mov    %edx,%eax
  2c0a1c:	c1 e0 02             	shl    $0x2,%eax
  2c0a1f:	01 d0                	add    %edx,%eax
  2c0a21:	01 c0                	add    %eax,%eax
  2c0a23:	89 c1                	mov    %eax,%ecx
  2c0a25:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a2c:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0a30:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0a37:	0f b6 00             	movzbl (%rax),%eax
  2c0a3a:	0f be c0             	movsbl %al,%eax
  2c0a3d:	01 c8                	add    %ecx,%eax
  2c0a3f:	83 e8 30             	sub    $0x30,%eax
  2c0a42:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0a45:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a4c:	0f b6 00             	movzbl (%rax),%eax
  2c0a4f:	3c 2f                	cmp    $0x2f,%al
  2c0a51:	0f 8e 85 00 00 00    	jle    2c0adc <printer_vprintf+0x1c2>
  2c0a57:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a5e:	0f b6 00             	movzbl (%rax),%eax
  2c0a61:	3c 39                	cmp    $0x39,%al
  2c0a63:	7e b2                	jle    2c0a17 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  2c0a65:	eb 75                	jmp    2c0adc <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  2c0a67:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a6e:	0f b6 00             	movzbl (%rax),%eax
  2c0a71:	3c 2a                	cmp    $0x2a,%al
  2c0a73:	75 68                	jne    2c0add <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  2c0a75:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0a7c:	8b 00                	mov    (%rax),%eax
  2c0a7e:	83 f8 2f             	cmp    $0x2f,%eax
  2c0a81:	77 30                	ja     2c0ab3 <printer_vprintf+0x199>
  2c0a83:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0a8a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0a8e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0a95:	8b 00                	mov    (%rax),%eax
  2c0a97:	89 c0                	mov    %eax,%eax
  2c0a99:	48 01 d0             	add    %rdx,%rax
  2c0a9c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0aa3:	8b 12                	mov    (%rdx),%edx
  2c0aa5:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0aa8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0aaf:	89 0a                	mov    %ecx,(%rdx)
  2c0ab1:	eb 1a                	jmp    2c0acd <printer_vprintf+0x1b3>
  2c0ab3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0aba:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0abe:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0ac2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ac9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0acd:	8b 00                	mov    (%rax),%eax
  2c0acf:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c0ad2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0ad9:	01 
  2c0ada:	eb 01                	jmp    2c0add <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  2c0adc:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c0add:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c0ae4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0aeb:	0f b6 00             	movzbl (%rax),%eax
  2c0aee:	3c 2e                	cmp    $0x2e,%al
  2c0af0:	0f 85 00 01 00 00    	jne    2c0bf6 <printer_vprintf+0x2dc>
            ++format;
  2c0af6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0afd:	01 
            if (*format >= '0' && *format <= '9') {
  2c0afe:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b05:	0f b6 00             	movzbl (%rax),%eax
  2c0b08:	3c 2f                	cmp    $0x2f,%al
  2c0b0a:	7e 67                	jle    2c0b73 <printer_vprintf+0x259>
  2c0b0c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b13:	0f b6 00             	movzbl (%rax),%eax
  2c0b16:	3c 39                	cmp    $0x39,%al
  2c0b18:	7f 59                	jg     2c0b73 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0b1a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c0b21:	eb 2e                	jmp    2c0b51 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  2c0b23:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c0b26:	89 d0                	mov    %edx,%eax
  2c0b28:	c1 e0 02             	shl    $0x2,%eax
  2c0b2b:	01 d0                	add    %edx,%eax
  2c0b2d:	01 c0                	add    %eax,%eax
  2c0b2f:	89 c1                	mov    %eax,%ecx
  2c0b31:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b38:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0b3c:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0b43:	0f b6 00             	movzbl (%rax),%eax
  2c0b46:	0f be c0             	movsbl %al,%eax
  2c0b49:	01 c8                	add    %ecx,%eax
  2c0b4b:	83 e8 30             	sub    $0x30,%eax
  2c0b4e:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0b51:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b58:	0f b6 00             	movzbl (%rax),%eax
  2c0b5b:	3c 2f                	cmp    $0x2f,%al
  2c0b5d:	0f 8e 85 00 00 00    	jle    2c0be8 <printer_vprintf+0x2ce>
  2c0b63:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b6a:	0f b6 00             	movzbl (%rax),%eax
  2c0b6d:	3c 39                	cmp    $0x39,%al
  2c0b6f:	7e b2                	jle    2c0b23 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  2c0b71:	eb 75                	jmp    2c0be8 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  2c0b73:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b7a:	0f b6 00             	movzbl (%rax),%eax
  2c0b7d:	3c 2a                	cmp    $0x2a,%al
  2c0b7f:	75 68                	jne    2c0be9 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  2c0b81:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b88:	8b 00                	mov    (%rax),%eax
  2c0b8a:	83 f8 2f             	cmp    $0x2f,%eax
  2c0b8d:	77 30                	ja     2c0bbf <printer_vprintf+0x2a5>
  2c0b8f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b96:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0b9a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ba1:	8b 00                	mov    (%rax),%eax
  2c0ba3:	89 c0                	mov    %eax,%eax
  2c0ba5:	48 01 d0             	add    %rdx,%rax
  2c0ba8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0baf:	8b 12                	mov    (%rdx),%edx
  2c0bb1:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0bb4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0bbb:	89 0a                	mov    %ecx,(%rdx)
  2c0bbd:	eb 1a                	jmp    2c0bd9 <printer_vprintf+0x2bf>
  2c0bbf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bc6:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0bca:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0bce:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0bd5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0bd9:	8b 00                	mov    (%rax),%eax
  2c0bdb:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c0bde:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0be5:	01 
  2c0be6:	eb 01                	jmp    2c0be9 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  2c0be8:	90                   	nop
            }
            if (precision < 0) {
  2c0be9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c0bed:	79 07                	jns    2c0bf6 <printer_vprintf+0x2dc>
                precision = 0;
  2c0bef:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c0bf6:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c0bfd:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c0c04:	00 
        int length = 0;
  2c0c05:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c0c0c:	48 c7 45 c8 d6 16 2c 	movq   $0x2c16d6,-0x38(%rbp)
  2c0c13:	00 
    again:
        switch (*format) {
  2c0c14:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c1b:	0f b6 00             	movzbl (%rax),%eax
  2c0c1e:	0f be c0             	movsbl %al,%eax
  2c0c21:	83 e8 43             	sub    $0x43,%eax
  2c0c24:	83 f8 37             	cmp    $0x37,%eax
  2c0c27:	0f 87 9f 03 00 00    	ja     2c0fcc <printer_vprintf+0x6b2>
  2c0c2d:	89 c0                	mov    %eax,%eax
  2c0c2f:	48 8b 04 c5 e8 16 2c 	mov    0x2c16e8(,%rax,8),%rax
  2c0c36:	00 
  2c0c37:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  2c0c39:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c0c40:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0c47:	01 
            goto again;
  2c0c48:	eb ca                	jmp    2c0c14 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c0c4a:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0c4e:	74 5d                	je     2c0cad <printer_vprintf+0x393>
  2c0c50:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c57:	8b 00                	mov    (%rax),%eax
  2c0c59:	83 f8 2f             	cmp    $0x2f,%eax
  2c0c5c:	77 30                	ja     2c0c8e <printer_vprintf+0x374>
  2c0c5e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c65:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0c69:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c70:	8b 00                	mov    (%rax),%eax
  2c0c72:	89 c0                	mov    %eax,%eax
  2c0c74:	48 01 d0             	add    %rdx,%rax
  2c0c77:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c7e:	8b 12                	mov    (%rdx),%edx
  2c0c80:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0c83:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c8a:	89 0a                	mov    %ecx,(%rdx)
  2c0c8c:	eb 1a                	jmp    2c0ca8 <printer_vprintf+0x38e>
  2c0c8e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c95:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0c99:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0c9d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ca4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0ca8:	48 8b 00             	mov    (%rax),%rax
  2c0cab:	eb 5c                	jmp    2c0d09 <printer_vprintf+0x3ef>
  2c0cad:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cb4:	8b 00                	mov    (%rax),%eax
  2c0cb6:	83 f8 2f             	cmp    $0x2f,%eax
  2c0cb9:	77 30                	ja     2c0ceb <printer_vprintf+0x3d1>
  2c0cbb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cc2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0cc6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ccd:	8b 00                	mov    (%rax),%eax
  2c0ccf:	89 c0                	mov    %eax,%eax
  2c0cd1:	48 01 d0             	add    %rdx,%rax
  2c0cd4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0cdb:	8b 12                	mov    (%rdx),%edx
  2c0cdd:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0ce0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ce7:	89 0a                	mov    %ecx,(%rdx)
  2c0ce9:	eb 1a                	jmp    2c0d05 <printer_vprintf+0x3eb>
  2c0ceb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cf2:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0cf6:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0cfa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d01:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0d05:	8b 00                	mov    (%rax),%eax
  2c0d07:	48 98                	cltq   
  2c0d09:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c0d0d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0d11:	48 c1 f8 38          	sar    $0x38,%rax
  2c0d15:	25 80 00 00 00       	and    $0x80,%eax
  2c0d1a:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c0d1d:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c0d21:	74 09                	je     2c0d2c <printer_vprintf+0x412>
  2c0d23:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0d27:	48 f7 d8             	neg    %rax
  2c0d2a:	eb 04                	jmp    2c0d30 <printer_vprintf+0x416>
  2c0d2c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0d30:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c0d34:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c0d37:	83 c8 60             	or     $0x60,%eax
  2c0d3a:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c0d3d:	e9 cf 02 00 00       	jmp    2c1011 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c0d42:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0d46:	74 5d                	je     2c0da5 <printer_vprintf+0x48b>
  2c0d48:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d4f:	8b 00                	mov    (%rax),%eax
  2c0d51:	83 f8 2f             	cmp    $0x2f,%eax
  2c0d54:	77 30                	ja     2c0d86 <printer_vprintf+0x46c>
  2c0d56:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d5d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0d61:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d68:	8b 00                	mov    (%rax),%eax
  2c0d6a:	89 c0                	mov    %eax,%eax
  2c0d6c:	48 01 d0             	add    %rdx,%rax
  2c0d6f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d76:	8b 12                	mov    (%rdx),%edx
  2c0d78:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0d7b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d82:	89 0a                	mov    %ecx,(%rdx)
  2c0d84:	eb 1a                	jmp    2c0da0 <printer_vprintf+0x486>
  2c0d86:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d8d:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0d91:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0d95:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d9c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0da0:	48 8b 00             	mov    (%rax),%rax
  2c0da3:	eb 5c                	jmp    2c0e01 <printer_vprintf+0x4e7>
  2c0da5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dac:	8b 00                	mov    (%rax),%eax
  2c0dae:	83 f8 2f             	cmp    $0x2f,%eax
  2c0db1:	77 30                	ja     2c0de3 <printer_vprintf+0x4c9>
  2c0db3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dba:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0dbe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dc5:	8b 00                	mov    (%rax),%eax
  2c0dc7:	89 c0                	mov    %eax,%eax
  2c0dc9:	48 01 d0             	add    %rdx,%rax
  2c0dcc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0dd3:	8b 12                	mov    (%rdx),%edx
  2c0dd5:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0dd8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ddf:	89 0a                	mov    %ecx,(%rdx)
  2c0de1:	eb 1a                	jmp    2c0dfd <printer_vprintf+0x4e3>
  2c0de3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dea:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0dee:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0df2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0df9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0dfd:	8b 00                	mov    (%rax),%eax
  2c0dff:	89 c0                	mov    %eax,%eax
  2c0e01:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c0e05:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c0e09:	e9 03 02 00 00       	jmp    2c1011 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  2c0e0e:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c0e15:	e9 28 ff ff ff       	jmp    2c0d42 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  2c0e1a:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c0e21:	e9 1c ff ff ff       	jmp    2c0d42 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c0e26:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e2d:	8b 00                	mov    (%rax),%eax
  2c0e2f:	83 f8 2f             	cmp    $0x2f,%eax
  2c0e32:	77 30                	ja     2c0e64 <printer_vprintf+0x54a>
  2c0e34:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e3b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0e3f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e46:	8b 00                	mov    (%rax),%eax
  2c0e48:	89 c0                	mov    %eax,%eax
  2c0e4a:	48 01 d0             	add    %rdx,%rax
  2c0e4d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e54:	8b 12                	mov    (%rdx),%edx
  2c0e56:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0e59:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e60:	89 0a                	mov    %ecx,(%rdx)
  2c0e62:	eb 1a                	jmp    2c0e7e <printer_vprintf+0x564>
  2c0e64:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e6b:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0e6f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0e73:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e7a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0e7e:	48 8b 00             	mov    (%rax),%rax
  2c0e81:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c0e85:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c0e8c:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c0e93:	e9 79 01 00 00       	jmp    2c1011 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  2c0e98:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e9f:	8b 00                	mov    (%rax),%eax
  2c0ea1:	83 f8 2f             	cmp    $0x2f,%eax
  2c0ea4:	77 30                	ja     2c0ed6 <printer_vprintf+0x5bc>
  2c0ea6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ead:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0eb1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0eb8:	8b 00                	mov    (%rax),%eax
  2c0eba:	89 c0                	mov    %eax,%eax
  2c0ebc:	48 01 d0             	add    %rdx,%rax
  2c0ebf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ec6:	8b 12                	mov    (%rdx),%edx
  2c0ec8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0ecb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ed2:	89 0a                	mov    %ecx,(%rdx)
  2c0ed4:	eb 1a                	jmp    2c0ef0 <printer_vprintf+0x5d6>
  2c0ed6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0edd:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0ee1:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0ee5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0eec:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0ef0:	48 8b 00             	mov    (%rax),%rax
  2c0ef3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c0ef7:	e9 15 01 00 00       	jmp    2c1011 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  2c0efc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f03:	8b 00                	mov    (%rax),%eax
  2c0f05:	83 f8 2f             	cmp    $0x2f,%eax
  2c0f08:	77 30                	ja     2c0f3a <printer_vprintf+0x620>
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
  2c0f38:	eb 1a                	jmp    2c0f54 <printer_vprintf+0x63a>
  2c0f3a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f41:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0f45:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0f49:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f50:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0f54:	8b 00                	mov    (%rax),%eax
  2c0f56:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c0f5c:	e9 67 03 00 00       	jmp    2c12c8 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  2c0f61:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c0f65:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c0f69:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f70:	8b 00                	mov    (%rax),%eax
  2c0f72:	83 f8 2f             	cmp    $0x2f,%eax
  2c0f75:	77 30                	ja     2c0fa7 <printer_vprintf+0x68d>
  2c0f77:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f7e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0f82:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f89:	8b 00                	mov    (%rax),%eax
  2c0f8b:	89 c0                	mov    %eax,%eax
  2c0f8d:	48 01 d0             	add    %rdx,%rax
  2c0f90:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f97:	8b 12                	mov    (%rdx),%edx
  2c0f99:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0f9c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0fa3:	89 0a                	mov    %ecx,(%rdx)
  2c0fa5:	eb 1a                	jmp    2c0fc1 <printer_vprintf+0x6a7>
  2c0fa7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fae:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0fb2:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0fb6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0fbd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0fc1:	8b 00                	mov    (%rax),%eax
  2c0fc3:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c0fc6:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c0fca:	eb 45                	jmp    2c1011 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  2c0fcc:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c0fd0:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c0fd4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0fdb:	0f b6 00             	movzbl (%rax),%eax
  2c0fde:	84 c0                	test   %al,%al
  2c0fe0:	74 0c                	je     2c0fee <printer_vprintf+0x6d4>
  2c0fe2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0fe9:	0f b6 00             	movzbl (%rax),%eax
  2c0fec:	eb 05                	jmp    2c0ff3 <printer_vprintf+0x6d9>
  2c0fee:	b8 25 00 00 00       	mov    $0x25,%eax
  2c0ff3:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c0ff6:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c0ffa:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1001:	0f b6 00             	movzbl (%rax),%eax
  2c1004:	84 c0                	test   %al,%al
  2c1006:	75 08                	jne    2c1010 <printer_vprintf+0x6f6>
                format--;
  2c1008:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c100f:	01 
            }
            break;
  2c1010:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c1011:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1014:	83 e0 20             	and    $0x20,%eax
  2c1017:	85 c0                	test   %eax,%eax
  2c1019:	74 1e                	je     2c1039 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c101b:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c101f:	48 83 c0 18          	add    $0x18,%rax
  2c1023:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c1026:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c102a:	48 89 ce             	mov    %rcx,%rsi
  2c102d:	48 89 c7             	mov    %rax,%rdi
  2c1030:	e8 63 f8 ff ff       	call   2c0898 <fill_numbuf>
  2c1035:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c1039:	48 c7 45 c0 d6 16 2c 	movq   $0x2c16d6,-0x40(%rbp)
  2c1040:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c1041:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1044:	83 e0 20             	and    $0x20,%eax
  2c1047:	85 c0                	test   %eax,%eax
  2c1049:	74 48                	je     2c1093 <printer_vprintf+0x779>
  2c104b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c104e:	83 e0 40             	and    $0x40,%eax
  2c1051:	85 c0                	test   %eax,%eax
  2c1053:	74 3e                	je     2c1093 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  2c1055:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1058:	25 80 00 00 00       	and    $0x80,%eax
  2c105d:	85 c0                	test   %eax,%eax
  2c105f:	74 0a                	je     2c106b <printer_vprintf+0x751>
                prefix = "-";
  2c1061:	48 c7 45 c0 d7 16 2c 	movq   $0x2c16d7,-0x40(%rbp)
  2c1068:	00 
            if (flags & FLAG_NEGATIVE) {
  2c1069:	eb 73                	jmp    2c10de <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c106b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c106e:	83 e0 10             	and    $0x10,%eax
  2c1071:	85 c0                	test   %eax,%eax
  2c1073:	74 0a                	je     2c107f <printer_vprintf+0x765>
                prefix = "+";
  2c1075:	48 c7 45 c0 d9 16 2c 	movq   $0x2c16d9,-0x40(%rbp)
  2c107c:	00 
            if (flags & FLAG_NEGATIVE) {
  2c107d:	eb 5f                	jmp    2c10de <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c107f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1082:	83 e0 08             	and    $0x8,%eax
  2c1085:	85 c0                	test   %eax,%eax
  2c1087:	74 55                	je     2c10de <printer_vprintf+0x7c4>
                prefix = " ";
  2c1089:	48 c7 45 c0 db 16 2c 	movq   $0x2c16db,-0x40(%rbp)
  2c1090:	00 
            if (flags & FLAG_NEGATIVE) {
  2c1091:	eb 4b                	jmp    2c10de <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c1093:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1096:	83 e0 20             	and    $0x20,%eax
  2c1099:	85 c0                	test   %eax,%eax
  2c109b:	74 42                	je     2c10df <printer_vprintf+0x7c5>
  2c109d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c10a0:	83 e0 01             	and    $0x1,%eax
  2c10a3:	85 c0                	test   %eax,%eax
  2c10a5:	74 38                	je     2c10df <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  2c10a7:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c10ab:	74 06                	je     2c10b3 <printer_vprintf+0x799>
  2c10ad:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c10b1:	75 2c                	jne    2c10df <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  2c10b3:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c10b8:	75 0c                	jne    2c10c6 <printer_vprintf+0x7ac>
  2c10ba:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c10bd:	25 00 01 00 00       	and    $0x100,%eax
  2c10c2:	85 c0                	test   %eax,%eax
  2c10c4:	74 19                	je     2c10df <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  2c10c6:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c10ca:	75 07                	jne    2c10d3 <printer_vprintf+0x7b9>
  2c10cc:	b8 dd 16 2c 00       	mov    $0x2c16dd,%eax
  2c10d1:	eb 05                	jmp    2c10d8 <printer_vprintf+0x7be>
  2c10d3:	b8 e0 16 2c 00       	mov    $0x2c16e0,%eax
  2c10d8:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c10dc:	eb 01                	jmp    2c10df <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  2c10de:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c10df:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c10e3:	78 24                	js     2c1109 <printer_vprintf+0x7ef>
  2c10e5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c10e8:	83 e0 20             	and    $0x20,%eax
  2c10eb:	85 c0                	test   %eax,%eax
  2c10ed:	75 1a                	jne    2c1109 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  2c10ef:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c10f2:	48 63 d0             	movslq %eax,%rdx
  2c10f5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c10f9:	48 89 d6             	mov    %rdx,%rsi
  2c10fc:	48 89 c7             	mov    %rax,%rdi
  2c10ff:	e8 ea f5 ff ff       	call   2c06ee <strnlen>
  2c1104:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c1107:	eb 0f                	jmp    2c1118 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  2c1109:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c110d:	48 89 c7             	mov    %rax,%rdi
  2c1110:	e8 a8 f5 ff ff       	call   2c06bd <strlen>
  2c1115:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c1118:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c111b:	83 e0 20             	and    $0x20,%eax
  2c111e:	85 c0                	test   %eax,%eax
  2c1120:	74 20                	je     2c1142 <printer_vprintf+0x828>
  2c1122:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c1126:	78 1a                	js     2c1142 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  2c1128:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c112b:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c112e:	7e 08                	jle    2c1138 <printer_vprintf+0x81e>
  2c1130:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1133:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c1136:	eb 05                	jmp    2c113d <printer_vprintf+0x823>
  2c1138:	b8 00 00 00 00       	mov    $0x0,%eax
  2c113d:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c1140:	eb 5c                	jmp    2c119e <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c1142:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1145:	83 e0 20             	and    $0x20,%eax
  2c1148:	85 c0                	test   %eax,%eax
  2c114a:	74 4b                	je     2c1197 <printer_vprintf+0x87d>
  2c114c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c114f:	83 e0 02             	and    $0x2,%eax
  2c1152:	85 c0                	test   %eax,%eax
  2c1154:	74 41                	je     2c1197 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c1156:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1159:	83 e0 04             	and    $0x4,%eax
  2c115c:	85 c0                	test   %eax,%eax
  2c115e:	75 37                	jne    2c1197 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  2c1160:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1164:	48 89 c7             	mov    %rax,%rdi
  2c1167:	e8 51 f5 ff ff       	call   2c06bd <strlen>
  2c116c:	89 c2                	mov    %eax,%edx
  2c116e:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c1171:	01 d0                	add    %edx,%eax
  2c1173:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c1176:	7e 1f                	jle    2c1197 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  2c1178:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c117b:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c117e:	89 c3                	mov    %eax,%ebx
  2c1180:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1184:	48 89 c7             	mov    %rax,%rdi
  2c1187:	e8 31 f5 ff ff       	call   2c06bd <strlen>
  2c118c:	89 c2                	mov    %eax,%edx
  2c118e:	89 d8                	mov    %ebx,%eax
  2c1190:	29 d0                	sub    %edx,%eax
  2c1192:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c1195:	eb 07                	jmp    2c119e <printer_vprintf+0x884>
        } else {
            zeros = 0;
  2c1197:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c119e:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c11a1:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c11a4:	01 d0                	add    %edx,%eax
  2c11a6:	48 63 d8             	movslq %eax,%rbx
  2c11a9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c11ad:	48 89 c7             	mov    %rax,%rdi
  2c11b0:	e8 08 f5 ff ff       	call   2c06bd <strlen>
  2c11b5:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c11b9:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c11bc:	29 d0                	sub    %edx,%eax
  2c11be:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c11c1:	eb 25                	jmp    2c11e8 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  2c11c3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c11ca:	48 8b 08             	mov    (%rax),%rcx
  2c11cd:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c11d3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c11da:	be 20 00 00 00       	mov    $0x20,%esi
  2c11df:	48 89 c7             	mov    %rax,%rdi
  2c11e2:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c11e4:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c11e8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11eb:	83 e0 04             	and    $0x4,%eax
  2c11ee:	85 c0                	test   %eax,%eax
  2c11f0:	75 36                	jne    2c1228 <printer_vprintf+0x90e>
  2c11f2:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c11f6:	7f cb                	jg     2c11c3 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  2c11f8:	eb 2e                	jmp    2c1228 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  2c11fa:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1201:	4c 8b 00             	mov    (%rax),%r8
  2c1204:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1208:	0f b6 00             	movzbl (%rax),%eax
  2c120b:	0f b6 c8             	movzbl %al,%ecx
  2c120e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1214:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c121b:	89 ce                	mov    %ecx,%esi
  2c121d:	48 89 c7             	mov    %rax,%rdi
  2c1220:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c1223:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c1228:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c122c:	0f b6 00             	movzbl (%rax),%eax
  2c122f:	84 c0                	test   %al,%al
  2c1231:	75 c7                	jne    2c11fa <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  2c1233:	eb 25                	jmp    2c125a <printer_vprintf+0x940>
            p->putc(p, '0', color);
  2c1235:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c123c:	48 8b 08             	mov    (%rax),%rcx
  2c123f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1245:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c124c:	be 30 00 00 00       	mov    $0x30,%esi
  2c1251:	48 89 c7             	mov    %rax,%rdi
  2c1254:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c1256:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c125a:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c125e:	7f d5                	jg     2c1235 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  2c1260:	eb 32                	jmp    2c1294 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  2c1262:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1269:	4c 8b 00             	mov    (%rax),%r8
  2c126c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1270:	0f b6 00             	movzbl (%rax),%eax
  2c1273:	0f b6 c8             	movzbl %al,%ecx
  2c1276:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c127c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1283:	89 ce                	mov    %ecx,%esi
  2c1285:	48 89 c7             	mov    %rax,%rdi
  2c1288:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c128b:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c1290:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c1294:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c1298:	7f c8                	jg     2c1262 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  2c129a:	eb 25                	jmp    2c12c1 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  2c129c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c12a3:	48 8b 08             	mov    (%rax),%rcx
  2c12a6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c12ac:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c12b3:	be 20 00 00 00       	mov    $0x20,%esi
  2c12b8:	48 89 c7             	mov    %rax,%rdi
  2c12bb:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c12bd:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c12c1:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c12c5:	7f d5                	jg     2c129c <printer_vprintf+0x982>
        }
    done: ;
  2c12c7:	90                   	nop
    for (; *format; ++format) {
  2c12c8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c12cf:	01 
  2c12d0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c12d7:	0f b6 00             	movzbl (%rax),%eax
  2c12da:	84 c0                	test   %al,%al
  2c12dc:	0f 85 64 f6 ff ff    	jne    2c0946 <printer_vprintf+0x2c>
    }
}
  2c12e2:	90                   	nop
  2c12e3:	90                   	nop
  2c12e4:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c12e8:	c9                   	leave  
  2c12e9:	c3                   	ret    

00000000002c12ea <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c12ea:	55                   	push   %rbp
  2c12eb:	48 89 e5             	mov    %rsp,%rbp
  2c12ee:	48 83 ec 20          	sub    $0x20,%rsp
  2c12f2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c12f6:	89 f0                	mov    %esi,%eax
  2c12f8:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c12fb:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c12fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1302:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1306:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c130a:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c130e:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  2c1313:	48 39 d0             	cmp    %rdx,%rax
  2c1316:	72 0c                	jb     2c1324 <console_putc+0x3a>
        cp->cursor = console;
  2c1318:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c131c:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  2c1323:	00 
    }
    if (c == '\n') {
  2c1324:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c1328:	75 78                	jne    2c13a2 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  2c132a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c132e:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1332:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c1338:	48 d1 f8             	sar    %rax
  2c133b:	48 89 c1             	mov    %rax,%rcx
  2c133e:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c1345:	66 66 66 
  2c1348:	48 89 c8             	mov    %rcx,%rax
  2c134b:	48 f7 ea             	imul   %rdx
  2c134e:	48 c1 fa 05          	sar    $0x5,%rdx
  2c1352:	48 89 c8             	mov    %rcx,%rax
  2c1355:	48 c1 f8 3f          	sar    $0x3f,%rax
  2c1359:	48 29 c2             	sub    %rax,%rdx
  2c135c:	48 89 d0             	mov    %rdx,%rax
  2c135f:	48 c1 e0 02          	shl    $0x2,%rax
  2c1363:	48 01 d0             	add    %rdx,%rax
  2c1366:	48 c1 e0 04          	shl    $0x4,%rax
  2c136a:	48 29 c1             	sub    %rax,%rcx
  2c136d:	48 89 ca             	mov    %rcx,%rdx
  2c1370:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c1373:	eb 25                	jmp    2c139a <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  2c1375:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c1378:	83 c8 20             	or     $0x20,%eax
  2c137b:	89 c6                	mov    %eax,%esi
  2c137d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1381:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1385:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1389:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c138d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1391:	89 f2                	mov    %esi,%edx
  2c1393:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c1396:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c139a:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c139e:	75 d5                	jne    2c1375 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c13a0:	eb 24                	jmp    2c13c6 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  2c13a2:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  2c13a6:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c13a9:	09 d0                	or     %edx,%eax
  2c13ab:	89 c6                	mov    %eax,%esi
  2c13ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c13b1:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c13b5:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c13b9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c13bd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c13c1:	89 f2                	mov    %esi,%edx
  2c13c3:	66 89 10             	mov    %dx,(%rax)
}
  2c13c6:	90                   	nop
  2c13c7:	c9                   	leave  
  2c13c8:	c3                   	ret    

00000000002c13c9 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c13c9:	55                   	push   %rbp
  2c13ca:	48 89 e5             	mov    %rsp,%rbp
  2c13cd:	48 83 ec 30          	sub    $0x30,%rsp
  2c13d1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c13d4:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c13d7:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c13db:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c13df:	48 c7 45 f0 ea 12 2c 	movq   $0x2c12ea,-0x10(%rbp)
  2c13e6:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c13e7:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c13eb:	78 09                	js     2c13f6 <console_vprintf+0x2d>
  2c13ed:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c13f4:	7e 07                	jle    2c13fd <console_vprintf+0x34>
        cpos = 0;
  2c13f6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c13fd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1400:	48 98                	cltq   
  2c1402:	48 01 c0             	add    %rax,%rax
  2c1405:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  2c140b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c140f:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c1413:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c1417:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c141a:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c141e:	48 89 c7             	mov    %rax,%rdi
  2c1421:	e8 f4 f4 ff ff       	call   2c091a <printer_vprintf>
    return cp.cursor - console;
  2c1426:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c142a:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c1430:	48 d1 f8             	sar    %rax
}
  2c1433:	c9                   	leave  
  2c1434:	c3                   	ret    

00000000002c1435 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c1435:	55                   	push   %rbp
  2c1436:	48 89 e5             	mov    %rsp,%rbp
  2c1439:	48 83 ec 60          	sub    $0x60,%rsp
  2c143d:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c1440:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c1443:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c1447:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c144b:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c144f:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c1453:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c145a:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c145e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c1462:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c1466:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c146a:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c146e:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c1472:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c1475:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c1478:	89 c7                	mov    %eax,%edi
  2c147a:	e8 4a ff ff ff       	call   2c13c9 <console_vprintf>
  2c147f:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c1482:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c1485:	c9                   	leave  
  2c1486:	c3                   	ret    

00000000002c1487 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c1487:	55                   	push   %rbp
  2c1488:	48 89 e5             	mov    %rsp,%rbp
  2c148b:	48 83 ec 20          	sub    $0x20,%rsp
  2c148f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c1493:	89 f0                	mov    %esi,%eax
  2c1495:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1498:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c149b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c149f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c14a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c14a7:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c14ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c14af:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c14b3:	48 39 c2             	cmp    %rax,%rdx
  2c14b6:	73 1a                	jae    2c14d2 <string_putc+0x4b>
        *sp->s++ = c;
  2c14b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c14bc:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c14c0:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c14c4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c14c8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c14cc:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c14d0:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c14d2:	90                   	nop
  2c14d3:	c9                   	leave  
  2c14d4:	c3                   	ret    

00000000002c14d5 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c14d5:	55                   	push   %rbp
  2c14d6:	48 89 e5             	mov    %rsp,%rbp
  2c14d9:	48 83 ec 40          	sub    $0x40,%rsp
  2c14dd:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c14e1:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c14e5:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c14e9:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c14ed:	48 c7 45 e8 87 14 2c 	movq   $0x2c1487,-0x18(%rbp)
  2c14f4:	00 
    sp.s = s;
  2c14f5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c14f9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c14fd:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c1502:	74 33                	je     2c1537 <vsnprintf+0x62>
        sp.end = s + size - 1;
  2c1504:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c1508:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c150c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1510:	48 01 d0             	add    %rdx,%rax
  2c1513:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c1517:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c151b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c151f:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c1523:	be 00 00 00 00       	mov    $0x0,%esi
  2c1528:	48 89 c7             	mov    %rax,%rdi
  2c152b:	e8 ea f3 ff ff       	call   2c091a <printer_vprintf>
        *sp.s = 0;
  2c1530:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1534:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c1537:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c153b:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c153f:	c9                   	leave  
  2c1540:	c3                   	ret    

00000000002c1541 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c1541:	55                   	push   %rbp
  2c1542:	48 89 e5             	mov    %rsp,%rbp
  2c1545:	48 83 ec 70          	sub    $0x70,%rsp
  2c1549:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c154d:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c1551:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c1555:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1559:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c155d:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c1561:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c1568:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c156c:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c1570:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c1574:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c1578:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c157c:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c1580:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c1584:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1588:	48 89 c7             	mov    %rax,%rdi
  2c158b:	e8 45 ff ff ff       	call   2c14d5 <vsnprintf>
  2c1590:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c1593:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c1596:	c9                   	leave  
  2c1597:	c3                   	ret    

00000000002c1598 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c1598:	55                   	push   %rbp
  2c1599:	48 89 e5             	mov    %rsp,%rbp
  2c159c:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c15a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c15a7:	eb 13                	jmp    2c15bc <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  2c15a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c15ac:	48 98                	cltq   
  2c15ae:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  2c15b5:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c15b8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c15bc:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c15c3:	7e e4                	jle    2c15a9 <console_clear+0x11>
    }
    cursorpos = 0;
  2c15c5:	c7 05 2d 7a df ff 00 	movl   $0x0,-0x2085d3(%rip)        # b8ffc <cursorpos>
  2c15cc:	00 00 00 
}
  2c15cf:	90                   	nop
  2c15d0:	c9                   	leave  
  2c15d1:	c3                   	ret    
