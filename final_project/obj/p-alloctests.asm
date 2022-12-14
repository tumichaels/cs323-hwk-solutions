
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
  2c0016:	e8 f6 06 00 00       	call   2c0711 <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001b:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0020:	e8 97 03 00 00       	call   2c03bc <malloc>
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
  2c003f:	e8 c9 03 00 00       	call   2c040d <realloc>
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
  2c0067:	e8 9b 03 00 00       	call   2c0407 <calloc>
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
  2c0086:	e8 89 03 00 00       	call   2c0414 <heap_info>
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
  2c00b7:	ba 70 14 2c 00       	mov    $0x2c1470,%edx
  2c00bc:	be 19 00 00 00       	mov    $0x19,%esi
  2c00c1:	bf 7e 14 2c 00       	mov    $0x2c147e,%edi
  2c00c6:	e8 13 02 00 00       	call   2c02de <assert_fail>
	assert(array2[i] == 0);
  2c00cb:	ba 94 14 2c 00       	mov    $0x2c1494,%edx
  2c00d0:	be 21 00 00 00       	mov    $0x21,%esi
  2c00d5:	bf 7e 14 2c 00       	mov    $0x2c147e,%edi
  2c00da:	e8 ff 01 00 00       	call   2c02de <assert_fail>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00df:	ba b8 14 2c 00       	mov    $0x2c14b8,%edx
  2c00e4:	be 28 00 00 00       	mov    $0x28,%esi
  2c00e9:	bf 7e 14 2c 00       	mov    $0x2c147e,%edi
  2c00ee:	e8 eb 01 00 00       	call   2c02de <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c00f3:	be a3 14 2c 00       	mov    $0x2c14a3,%esi
  2c00f8:	bf 00 00 00 00       	mov    $0x0,%edi
  2c00fd:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0102:	e8 79 00 00 00       	call   2c0180 <app_printf>
    }
    
    // free array, array2
    free(array);
  2c0107:	4c 89 ef             	mov    %r13,%rdi
  2c010a:	e8 81 02 00 00       	call   2c0390 <free>
    free(array2);
  2c010f:	4c 89 f7             	mov    %r14,%rdi
  2c0112:	e8 79 02 00 00       	call   2c0390 <free>

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
  2c0130:	e8 87 02 00 00       	call   2c03bc <malloc>
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
  2c016a:	be e8 14 2c 00       	mov    $0x2c14e8,%esi
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
  2c01c8:	0f b6 b7 4d 15 2c 00 	movzbl 0x2c154d(%rdi),%esi
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
  2c01f6:	e8 68 10 00 00       	call   2c1263 <console_vprintf>
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
  2c024f:	be 18 15 2c 00       	mov    $0x2c1518,%esi
  2c0254:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  2c025b:	e8 ba 01 00 00       	call   2c041a <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0260:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0264:	48 89 da             	mov    %rbx,%rdx
  2c0267:	be 99 00 00 00       	mov    $0x99,%esi
  2c026c:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c0273:	e8 f7 10 00 00       	call   2c136f <vsnprintf>
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
  2c0298:	ba 20 15 2c 00       	mov    $0x2c1520,%edx
  2c029d:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02a2:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02a7:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ac:	e8 1e 10 00 00       	call   2c12cf <console_printf>
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
  2c02d2:	be b3 14 2c 00       	mov    $0x2c14b3,%esi
  2c02d7:	e8 eb 02 00 00       	call   2c05c7 <strcpy>
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
  2c02eb:	ba 28 15 2c 00       	mov    $0x2c1528,%edx
  2c02f0:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02f5:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02fa:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ff:	e8 cb 0f 00 00       	call   2c12cf <console_printf>
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
	first_block_payload = sbrk(sizeof(block_footer));
  2c0324:	48 89 05 dd 1c 00 00 	mov    %rax,0x1cdd(%rip)        # 2c2008 <first_block_payload>

	GET_SIZE(HDRP(first_block_payload)) = sizeof(block_header) + sizeof(block_footer);
  2c032b:	48 c7 40 f0 20 00 00 	movq   $0x20,-0x10(%rax)
  2c0332:	00 
	GET_ALLOC(HDRP(first_block_payload)) = 1;
  2c0333:	48 8b 05 ce 1c 00 00 	mov    0x1cce(%rip),%rax        # 2c2008 <first_block_payload>
  2c033a:	c7 40 f8 01 00 00 00 	movl   $0x1,-0x8(%rax)
	GET_SIZE(FTRP(first_block_payload)) = sizeof(block_header) + sizeof(block_footer);
  2c0341:	48 8b 05 c0 1c 00 00 	mov    0x1cc0(%rip),%rax        # 2c2008 <first_block_payload>
  2c0348:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  2c034c:	48 c7 44 10 e0 20 00 	movq   $0x20,-0x20(%rax,%rdx,1)
  2c0353:	00 00 
  2c0355:	cd 3a                	int    $0x3a
  2c0357:	48 89 05 ba 1c 00 00 	mov    %rax,0x1cba(%rip)        # 2c2018 <result.0>

	// terminal block
	sbrk(sizeof(block_header));
	GET_SIZE(HDRP(NEXT_BLKP(first_block_payload))) = 0;
  2c035e:	48 8b 05 a3 1c 00 00 	mov    0x1ca3(%rip),%rax        # 2c2008 <first_block_payload>
  2c0365:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  2c0369:	48 c7 44 10 f0 00 00 	movq   $0x0,-0x10(%rax,%rdx,1)
  2c0370:	00 00 
	GET_ALLOC(HDRP(NEXT_BLKP(first_block_payload))) = 1;
  2c0372:	48 8b 05 8f 1c 00 00 	mov    0x1c8f(%rip),%rax        # 2c2008 <first_block_payload>
  2c0379:	48 8b 50 f0          	mov    -0x10(%rax),%rdx
  2c037d:	c7 44 10 f8 01 00 00 	movl   $0x1,-0x8(%rax,%rdx,1)
  2c0384:	00 

	initialized_heap = 1;
  2c0385:	c7 05 81 1c 00 00 01 	movl   $0x1,0x1c81(%rip)        # 2c2010 <initialized_heap>
  2c038c:	00 00 00 
}
  2c038f:	c3                   	ret    

00000000002c0390 <free>:

void free(void *firstbyte) {
	return;
}
  2c0390:	c3                   	ret    

00000000002c0391 <extend>:

// extend is called when you don't have a free block big enough
//	we call extend inside malloc, so it should only ever be
//	called with new_size >= MIN_PAYLOAD_SIZE 
void extend(size_t new_size) {
}
  2c0391:	c3                   	ret    

00000000002c0392 <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  2c0392:	48 8b 47 f0          	mov    -0x10(%rdi),%rax
  2c0396:	48 29 f0             	sub    %rsi,%rax

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  2c0399:	48 83 f8 30          	cmp    $0x30,%rax
  2c039d:	76 15                	jbe    2c03b4 <set_allocated+0x22>
		GET_SIZE(HDRP(bp)) = size;
  2c039f:	48 89 77 f0          	mov    %rsi,-0x10(%rdi)
		GET_SIZE(HDRP(NEXT_BLKP(bp))) = extra_size;
  2c03a3:	48 89 44 37 f0       	mov    %rax,-0x10(%rdi,%rsi,1)
		GET_ALLOC(HDRP(NEXT_BLKP(bp))) = 0;
  2c03a8:	48 8b 47 f0          	mov    -0x10(%rdi),%rax
  2c03ac:	c7 44 07 f8 00 00 00 	movl   $0x0,-0x8(%rdi,%rax,1)
  2c03b3:	00 
		// NEXT_FPTR(NEXT_BLKP(bp)) = NEXT_FPTR(bp);
		// PREV_FPTR(NEXT_BLKP(bp)) = PREV_FPTR(bp);
		// GET_SIZE(FTRP(NEXT_BLKP(bp))) = extra_size;
	}

	GET_ALLOC(HDRP(bp)) = 1;
  2c03b4:	c7 47 f8 01 00 00 00 	movl   $0x1,-0x8(%rdi)
}
  2c03bb:	c3                   	ret    

00000000002c03bc <malloc>:

void *malloc(uint64_t numbytes) {
  2c03bc:	55                   	push   %rbp
  2c03bd:	48 89 e5             	mov    %rsp,%rbp
  2c03c0:	53                   	push   %rbx
  2c03c1:	48 83 ec 08          	sub    $0x8,%rsp
  2c03c5:	48 89 fb             	mov    %rdi,%rbx
	if (!initialized_heap)
  2c03c8:	83 3d 41 1c 00 00 00 	cmpl   $0x0,0x1c41(%rip)        # 2c2010 <initialized_heap>
  2c03cf:	74 28                	je     2c03f9 <malloc+0x3d>
		heap_init();

	if (numbytes == 0)
  2c03d1:	48 85 db             	test   %rbx,%rbx
  2c03d4:	74 2a                	je     2c0400 <malloc+0x44>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  2c03d6:	48 8d 7b 1f          	lea    0x1f(%rbx),%rdi
  2c03da:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
  2c03de:	b8 30 00 00 00       	mov    $0x30,%eax
  2c03e3:	48 39 c7             	cmp    %rax,%rdi
  2c03e6:	48 0f 42 f8          	cmovb  %rax,%rdi
  2c03ea:	cd 3a                	int    $0x3a
  2c03ec:	48 89 05 25 1c 00 00 	mov    %rax,0x1c25(%rip)        # 2c2018 <result.0>
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);

	void *bp = sbrk(aligned_size);
    return bp;
}
  2c03f3:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c03f7:	c9                   	leave  
  2c03f8:	c3                   	ret    
		heap_init();
  2c03f9:	e8 0f ff ff ff       	call   2c030d <heap_init>
  2c03fe:	eb d1                	jmp    2c03d1 <malloc+0x15>
		return NULL;
  2c0400:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0405:	eb ec                	jmp    2c03f3 <malloc+0x37>

00000000002c0407 <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
    return 0;
}
  2c0407:	b8 00 00 00 00       	mov    $0x0,%eax
  2c040c:	c3                   	ret    

00000000002c040d <realloc>:

void *realloc(void * ptr, uint64_t sz) {
    return 0;
}
  2c040d:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0412:	c3                   	ret    

00000000002c0413 <defrag>:

void defrag() {
}
  2c0413:	c3                   	ret    

00000000002c0414 <heap_info>:

int heap_info(heap_info_struct * info) {
    return 0;
}
  2c0414:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0419:	c3                   	ret    

00000000002c041a <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c041a:	55                   	push   %rbp
  2c041b:	48 89 e5             	mov    %rsp,%rbp
  2c041e:	48 83 ec 28          	sub    $0x28,%rsp
  2c0422:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0426:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c042a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c042e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0432:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0436:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c043a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c043e:	eb 1c                	jmp    2c045c <memcpy+0x42>
        *d = *s;
  2c0440:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0444:	0f b6 10             	movzbl (%rax),%edx
  2c0447:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c044b:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c044d:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0452:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0457:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c045c:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0461:	75 dd                	jne    2c0440 <memcpy+0x26>
    }
    return dst;
  2c0463:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0467:	c9                   	leave  
  2c0468:	c3                   	ret    

00000000002c0469 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c0469:	55                   	push   %rbp
  2c046a:	48 89 e5             	mov    %rsp,%rbp
  2c046d:	48 83 ec 28          	sub    $0x28,%rsp
  2c0471:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0475:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0479:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c047d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0481:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c0485:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0489:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c048d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0491:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c0495:	73 6a                	jae    2c0501 <memmove+0x98>
  2c0497:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c049b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c049f:	48 01 d0             	add    %rdx,%rax
  2c04a2:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c04a6:	73 59                	jae    2c0501 <memmove+0x98>
        s += n, d += n;
  2c04a8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c04ac:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c04b0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c04b4:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c04b8:	eb 17                	jmp    2c04d1 <memmove+0x68>
            *--d = *--s;
  2c04ba:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c04bf:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c04c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c04c8:	0f b6 10             	movzbl (%rax),%edx
  2c04cb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c04cf:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c04d1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c04d5:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c04d9:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c04dd:	48 85 c0             	test   %rax,%rax
  2c04e0:	75 d8                	jne    2c04ba <memmove+0x51>
    if (s < d && s + n > d) {
  2c04e2:	eb 2e                	jmp    2c0512 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c04e4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c04e8:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c04ec:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c04f0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c04f4:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c04f8:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c04fc:	0f b6 12             	movzbl (%rdx),%edx
  2c04ff:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0501:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0505:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0509:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c050d:	48 85 c0             	test   %rax,%rax
  2c0510:	75 d2                	jne    2c04e4 <memmove+0x7b>
        }
    }
    return dst;
  2c0512:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0516:	c9                   	leave  
  2c0517:	c3                   	ret    

00000000002c0518 <memset>:

void* memset(void* v, int c, size_t n) {
  2c0518:	55                   	push   %rbp
  2c0519:	48 89 e5             	mov    %rsp,%rbp
  2c051c:	48 83 ec 28          	sub    $0x28,%rsp
  2c0520:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0524:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c0527:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c052b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c052f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0533:	eb 15                	jmp    2c054a <memset+0x32>
        *p = c;
  2c0535:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0538:	89 c2                	mov    %eax,%edx
  2c053a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c053e:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0540:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0545:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c054a:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c054f:	75 e4                	jne    2c0535 <memset+0x1d>
    }
    return v;
  2c0551:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0555:	c9                   	leave  
  2c0556:	c3                   	ret    

00000000002c0557 <strlen>:

size_t strlen(const char* s) {
  2c0557:	55                   	push   %rbp
  2c0558:	48 89 e5             	mov    %rsp,%rbp
  2c055b:	48 83 ec 18          	sub    $0x18,%rsp
  2c055f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c0563:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c056a:	00 
  2c056b:	eb 0a                	jmp    2c0577 <strlen+0x20>
        ++n;
  2c056d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c0572:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0577:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c057b:	0f b6 00             	movzbl (%rax),%eax
  2c057e:	84 c0                	test   %al,%al
  2c0580:	75 eb                	jne    2c056d <strlen+0x16>
    }
    return n;
  2c0582:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0586:	c9                   	leave  
  2c0587:	c3                   	ret    

00000000002c0588 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c0588:	55                   	push   %rbp
  2c0589:	48 89 e5             	mov    %rsp,%rbp
  2c058c:	48 83 ec 20          	sub    $0x20,%rsp
  2c0590:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0594:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0598:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c059f:	00 
  2c05a0:	eb 0a                	jmp    2c05ac <strnlen+0x24>
        ++n;
  2c05a2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c05a7:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c05ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c05b0:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c05b4:	74 0b                	je     2c05c1 <strnlen+0x39>
  2c05b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c05ba:	0f b6 00             	movzbl (%rax),%eax
  2c05bd:	84 c0                	test   %al,%al
  2c05bf:	75 e1                	jne    2c05a2 <strnlen+0x1a>
    }
    return n;
  2c05c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c05c5:	c9                   	leave  
  2c05c6:	c3                   	ret    

00000000002c05c7 <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c05c7:	55                   	push   %rbp
  2c05c8:	48 89 e5             	mov    %rsp,%rbp
  2c05cb:	48 83 ec 20          	sub    $0x20,%rsp
  2c05cf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c05d3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c05d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c05db:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c05df:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c05e3:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c05e7:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c05eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c05ef:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c05f3:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c05f7:	0f b6 12             	movzbl (%rdx),%edx
  2c05fa:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c05fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0600:	48 83 e8 01          	sub    $0x1,%rax
  2c0604:	0f b6 00             	movzbl (%rax),%eax
  2c0607:	84 c0                	test   %al,%al
  2c0609:	75 d4                	jne    2c05df <strcpy+0x18>
    return dst;
  2c060b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c060f:	c9                   	leave  
  2c0610:	c3                   	ret    

00000000002c0611 <strcmp>:

int strcmp(const char* a, const char* b) {
  2c0611:	55                   	push   %rbp
  2c0612:	48 89 e5             	mov    %rsp,%rbp
  2c0615:	48 83 ec 10          	sub    $0x10,%rsp
  2c0619:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c061d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0621:	eb 0a                	jmp    2c062d <strcmp+0x1c>
        ++a, ++b;
  2c0623:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0628:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c062d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0631:	0f b6 00             	movzbl (%rax),%eax
  2c0634:	84 c0                	test   %al,%al
  2c0636:	74 1d                	je     2c0655 <strcmp+0x44>
  2c0638:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c063c:	0f b6 00             	movzbl (%rax),%eax
  2c063f:	84 c0                	test   %al,%al
  2c0641:	74 12                	je     2c0655 <strcmp+0x44>
  2c0643:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0647:	0f b6 10             	movzbl (%rax),%edx
  2c064a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c064e:	0f b6 00             	movzbl (%rax),%eax
  2c0651:	38 c2                	cmp    %al,%dl
  2c0653:	74 ce                	je     2c0623 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c0655:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0659:	0f b6 00             	movzbl (%rax),%eax
  2c065c:	89 c2                	mov    %eax,%edx
  2c065e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0662:	0f b6 00             	movzbl (%rax),%eax
  2c0665:	38 d0                	cmp    %dl,%al
  2c0667:	0f 92 c0             	setb   %al
  2c066a:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c066d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0671:	0f b6 00             	movzbl (%rax),%eax
  2c0674:	89 c1                	mov    %eax,%ecx
  2c0676:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c067a:	0f b6 00             	movzbl (%rax),%eax
  2c067d:	38 c1                	cmp    %al,%cl
  2c067f:	0f 92 c0             	setb   %al
  2c0682:	0f b6 c0             	movzbl %al,%eax
  2c0685:	29 c2                	sub    %eax,%edx
  2c0687:	89 d0                	mov    %edx,%eax
}
  2c0689:	c9                   	leave  
  2c068a:	c3                   	ret    

00000000002c068b <strchr>:

char* strchr(const char* s, int c) {
  2c068b:	55                   	push   %rbp
  2c068c:	48 89 e5             	mov    %rsp,%rbp
  2c068f:	48 83 ec 10          	sub    $0x10,%rsp
  2c0693:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0697:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c069a:	eb 05                	jmp    2c06a1 <strchr+0x16>
        ++s;
  2c069c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c06a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c06a5:	0f b6 00             	movzbl (%rax),%eax
  2c06a8:	84 c0                	test   %al,%al
  2c06aa:	74 0e                	je     2c06ba <strchr+0x2f>
  2c06ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c06b0:	0f b6 00             	movzbl (%rax),%eax
  2c06b3:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c06b6:	38 d0                	cmp    %dl,%al
  2c06b8:	75 e2                	jne    2c069c <strchr+0x11>
    }
    if (*s == (char) c) {
  2c06ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c06be:	0f b6 00             	movzbl (%rax),%eax
  2c06c1:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c06c4:	38 d0                	cmp    %dl,%al
  2c06c6:	75 06                	jne    2c06ce <strchr+0x43>
        return (char*) s;
  2c06c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c06cc:	eb 05                	jmp    2c06d3 <strchr+0x48>
    } else {
        return NULL;
  2c06ce:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c06d3:	c9                   	leave  
  2c06d4:	c3                   	ret    

00000000002c06d5 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c06d5:	55                   	push   %rbp
  2c06d6:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c06d9:	8b 05 41 19 00 00    	mov    0x1941(%rip),%eax        # 2c2020 <rand_seed_set>
  2c06df:	85 c0                	test   %eax,%eax
  2c06e1:	75 0a                	jne    2c06ed <rand+0x18>
        srand(819234718U);
  2c06e3:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c06e8:	e8 24 00 00 00       	call   2c0711 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c06ed:	8b 05 31 19 00 00    	mov    0x1931(%rip),%eax        # 2c2024 <rand_seed>
  2c06f3:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c06f9:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c06fe:	89 05 20 19 00 00    	mov    %eax,0x1920(%rip)        # 2c2024 <rand_seed>
    return rand_seed & RAND_MAX;
  2c0704:	8b 05 1a 19 00 00    	mov    0x191a(%rip),%eax        # 2c2024 <rand_seed>
  2c070a:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c070f:	5d                   	pop    %rbp
  2c0710:	c3                   	ret    

00000000002c0711 <srand>:

void srand(unsigned seed) {
  2c0711:	55                   	push   %rbp
  2c0712:	48 89 e5             	mov    %rsp,%rbp
  2c0715:	48 83 ec 08          	sub    $0x8,%rsp
  2c0719:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c071c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c071f:	89 05 ff 18 00 00    	mov    %eax,0x18ff(%rip)        # 2c2024 <rand_seed>
    rand_seed_set = 1;
  2c0725:	c7 05 f1 18 00 00 01 	movl   $0x1,0x18f1(%rip)        # 2c2020 <rand_seed_set>
  2c072c:	00 00 00 
}
  2c072f:	90                   	nop
  2c0730:	c9                   	leave  
  2c0731:	c3                   	ret    

00000000002c0732 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c0732:	55                   	push   %rbp
  2c0733:	48 89 e5             	mov    %rsp,%rbp
  2c0736:	48 83 ec 28          	sub    $0x28,%rsp
  2c073a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c073e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0742:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c0745:	48 c7 45 f8 40 17 2c 	movq   $0x2c1740,-0x8(%rbp)
  2c074c:	00 
    if (base < 0) {
  2c074d:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c0751:	79 0b                	jns    2c075e <fill_numbuf+0x2c>
        digits = lower_digits;
  2c0753:	48 c7 45 f8 60 17 2c 	movq   $0x2c1760,-0x8(%rbp)
  2c075a:	00 
        base = -base;
  2c075b:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c075e:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0763:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0767:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c076a:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c076d:	48 63 c8             	movslq %eax,%rcx
  2c0770:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0774:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0779:	48 f7 f1             	div    %rcx
  2c077c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0780:	48 01 d0             	add    %rdx,%rax
  2c0783:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0788:	0f b6 10             	movzbl (%rax),%edx
  2c078b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c078f:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c0791:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0794:	48 63 f0             	movslq %eax,%rsi
  2c0797:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c079b:	ba 00 00 00 00       	mov    $0x0,%edx
  2c07a0:	48 f7 f6             	div    %rsi
  2c07a3:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c07a7:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c07ac:	75 bc                	jne    2c076a <fill_numbuf+0x38>
    return numbuf_end;
  2c07ae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c07b2:	c9                   	leave  
  2c07b3:	c3                   	ret    

00000000002c07b4 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c07b4:	55                   	push   %rbp
  2c07b5:	48 89 e5             	mov    %rsp,%rbp
  2c07b8:	53                   	push   %rbx
  2c07b9:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c07c0:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c07c7:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c07cd:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c07d4:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c07db:	e9 8a 09 00 00       	jmp    2c116a <printer_vprintf+0x9b6>
        if (*format != '%') {
  2c07e0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c07e7:	0f b6 00             	movzbl (%rax),%eax
  2c07ea:	3c 25                	cmp    $0x25,%al
  2c07ec:	74 31                	je     2c081f <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  2c07ee:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c07f5:	4c 8b 00             	mov    (%rax),%r8
  2c07f8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c07ff:	0f b6 00             	movzbl (%rax),%eax
  2c0802:	0f b6 c8             	movzbl %al,%ecx
  2c0805:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c080b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0812:	89 ce                	mov    %ecx,%esi
  2c0814:	48 89 c7             	mov    %rax,%rdi
  2c0817:	41 ff d0             	call   *%r8
            continue;
  2c081a:	e9 43 09 00 00       	jmp    2c1162 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  2c081f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0826:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c082d:	01 
  2c082e:	eb 44                	jmp    2c0874 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  2c0830:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0837:	0f b6 00             	movzbl (%rax),%eax
  2c083a:	0f be c0             	movsbl %al,%eax
  2c083d:	89 c6                	mov    %eax,%esi
  2c083f:	bf 60 15 2c 00       	mov    $0x2c1560,%edi
  2c0844:	e8 42 fe ff ff       	call   2c068b <strchr>
  2c0849:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c084d:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c0852:	74 30                	je     2c0884 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  2c0854:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c0858:	48 2d 60 15 2c 00    	sub    $0x2c1560,%rax
  2c085e:	ba 01 00 00 00       	mov    $0x1,%edx
  2c0863:	89 c1                	mov    %eax,%ecx
  2c0865:	d3 e2                	shl    %cl,%edx
  2c0867:	89 d0                	mov    %edx,%eax
  2c0869:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c086c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0873:	01 
  2c0874:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c087b:	0f b6 00             	movzbl (%rax),%eax
  2c087e:	84 c0                	test   %al,%al
  2c0880:	75 ae                	jne    2c0830 <printer_vprintf+0x7c>
  2c0882:	eb 01                	jmp    2c0885 <printer_vprintf+0xd1>
            } else {
                break;
  2c0884:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c0885:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c088c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0893:	0f b6 00             	movzbl (%rax),%eax
  2c0896:	3c 30                	cmp    $0x30,%al
  2c0898:	7e 67                	jle    2c0901 <printer_vprintf+0x14d>
  2c089a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c08a1:	0f b6 00             	movzbl (%rax),%eax
  2c08a4:	3c 39                	cmp    $0x39,%al
  2c08a6:	7f 59                	jg     2c0901 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c08a8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c08af:	eb 2e                	jmp    2c08df <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  2c08b1:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c08b4:	89 d0                	mov    %edx,%eax
  2c08b6:	c1 e0 02             	shl    $0x2,%eax
  2c08b9:	01 d0                	add    %edx,%eax
  2c08bb:	01 c0                	add    %eax,%eax
  2c08bd:	89 c1                	mov    %eax,%ecx
  2c08bf:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c08c6:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c08ca:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c08d1:	0f b6 00             	movzbl (%rax),%eax
  2c08d4:	0f be c0             	movsbl %al,%eax
  2c08d7:	01 c8                	add    %ecx,%eax
  2c08d9:	83 e8 30             	sub    $0x30,%eax
  2c08dc:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c08df:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c08e6:	0f b6 00             	movzbl (%rax),%eax
  2c08e9:	3c 2f                	cmp    $0x2f,%al
  2c08eb:	0f 8e 85 00 00 00    	jle    2c0976 <printer_vprintf+0x1c2>
  2c08f1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c08f8:	0f b6 00             	movzbl (%rax),%eax
  2c08fb:	3c 39                	cmp    $0x39,%al
  2c08fd:	7e b2                	jle    2c08b1 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  2c08ff:	eb 75                	jmp    2c0976 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  2c0901:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0908:	0f b6 00             	movzbl (%rax),%eax
  2c090b:	3c 2a                	cmp    $0x2a,%al
  2c090d:	75 68                	jne    2c0977 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  2c090f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0916:	8b 00                	mov    (%rax),%eax
  2c0918:	83 f8 2f             	cmp    $0x2f,%eax
  2c091b:	77 30                	ja     2c094d <printer_vprintf+0x199>
  2c091d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0924:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0928:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c092f:	8b 00                	mov    (%rax),%eax
  2c0931:	89 c0                	mov    %eax,%eax
  2c0933:	48 01 d0             	add    %rdx,%rax
  2c0936:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c093d:	8b 12                	mov    (%rdx),%edx
  2c093f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0942:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0949:	89 0a                	mov    %ecx,(%rdx)
  2c094b:	eb 1a                	jmp    2c0967 <printer_vprintf+0x1b3>
  2c094d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0954:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0958:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c095c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0963:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0967:	8b 00                	mov    (%rax),%eax
  2c0969:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c096c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0973:	01 
  2c0974:	eb 01                	jmp    2c0977 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  2c0976:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c0977:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c097e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0985:	0f b6 00             	movzbl (%rax),%eax
  2c0988:	3c 2e                	cmp    $0x2e,%al
  2c098a:	0f 85 00 01 00 00    	jne    2c0a90 <printer_vprintf+0x2dc>
            ++format;
  2c0990:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0997:	01 
            if (*format >= '0' && *format <= '9') {
  2c0998:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c099f:	0f b6 00             	movzbl (%rax),%eax
  2c09a2:	3c 2f                	cmp    $0x2f,%al
  2c09a4:	7e 67                	jle    2c0a0d <printer_vprintf+0x259>
  2c09a6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c09ad:	0f b6 00             	movzbl (%rax),%eax
  2c09b0:	3c 39                	cmp    $0x39,%al
  2c09b2:	7f 59                	jg     2c0a0d <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c09b4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c09bb:	eb 2e                	jmp    2c09eb <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  2c09bd:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c09c0:	89 d0                	mov    %edx,%eax
  2c09c2:	c1 e0 02             	shl    $0x2,%eax
  2c09c5:	01 d0                	add    %edx,%eax
  2c09c7:	01 c0                	add    %eax,%eax
  2c09c9:	89 c1                	mov    %eax,%ecx
  2c09cb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c09d2:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c09d6:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c09dd:	0f b6 00             	movzbl (%rax),%eax
  2c09e0:	0f be c0             	movsbl %al,%eax
  2c09e3:	01 c8                	add    %ecx,%eax
  2c09e5:	83 e8 30             	sub    $0x30,%eax
  2c09e8:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c09eb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c09f2:	0f b6 00             	movzbl (%rax),%eax
  2c09f5:	3c 2f                	cmp    $0x2f,%al
  2c09f7:	0f 8e 85 00 00 00    	jle    2c0a82 <printer_vprintf+0x2ce>
  2c09fd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a04:	0f b6 00             	movzbl (%rax),%eax
  2c0a07:	3c 39                	cmp    $0x39,%al
  2c0a09:	7e b2                	jle    2c09bd <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  2c0a0b:	eb 75                	jmp    2c0a82 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  2c0a0d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a14:	0f b6 00             	movzbl (%rax),%eax
  2c0a17:	3c 2a                	cmp    $0x2a,%al
  2c0a19:	75 68                	jne    2c0a83 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  2c0a1b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0a22:	8b 00                	mov    (%rax),%eax
  2c0a24:	83 f8 2f             	cmp    $0x2f,%eax
  2c0a27:	77 30                	ja     2c0a59 <printer_vprintf+0x2a5>
  2c0a29:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0a30:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0a34:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0a3b:	8b 00                	mov    (%rax),%eax
  2c0a3d:	89 c0                	mov    %eax,%eax
  2c0a3f:	48 01 d0             	add    %rdx,%rax
  2c0a42:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0a49:	8b 12                	mov    (%rdx),%edx
  2c0a4b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0a4e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0a55:	89 0a                	mov    %ecx,(%rdx)
  2c0a57:	eb 1a                	jmp    2c0a73 <printer_vprintf+0x2bf>
  2c0a59:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0a60:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0a64:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0a68:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0a6f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0a73:	8b 00                	mov    (%rax),%eax
  2c0a75:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c0a78:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0a7f:	01 
  2c0a80:	eb 01                	jmp    2c0a83 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  2c0a82:	90                   	nop
            }
            if (precision < 0) {
  2c0a83:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c0a87:	79 07                	jns    2c0a90 <printer_vprintf+0x2dc>
                precision = 0;
  2c0a89:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c0a90:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c0a97:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c0a9e:	00 
        int length = 0;
  2c0a9f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c0aa6:	48 c7 45 c8 66 15 2c 	movq   $0x2c1566,-0x38(%rbp)
  2c0aad:	00 
    again:
        switch (*format) {
  2c0aae:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ab5:	0f b6 00             	movzbl (%rax),%eax
  2c0ab8:	0f be c0             	movsbl %al,%eax
  2c0abb:	83 e8 43             	sub    $0x43,%eax
  2c0abe:	83 f8 37             	cmp    $0x37,%eax
  2c0ac1:	0f 87 9f 03 00 00    	ja     2c0e66 <printer_vprintf+0x6b2>
  2c0ac7:	89 c0                	mov    %eax,%eax
  2c0ac9:	48 8b 04 c5 78 15 2c 	mov    0x2c1578(,%rax,8),%rax
  2c0ad0:	00 
  2c0ad1:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  2c0ad3:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c0ada:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0ae1:	01 
            goto again;
  2c0ae2:	eb ca                	jmp    2c0aae <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c0ae4:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0ae8:	74 5d                	je     2c0b47 <printer_vprintf+0x393>
  2c0aea:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0af1:	8b 00                	mov    (%rax),%eax
  2c0af3:	83 f8 2f             	cmp    $0x2f,%eax
  2c0af6:	77 30                	ja     2c0b28 <printer_vprintf+0x374>
  2c0af8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0aff:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0b03:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b0a:	8b 00                	mov    (%rax),%eax
  2c0b0c:	89 c0                	mov    %eax,%eax
  2c0b0e:	48 01 d0             	add    %rdx,%rax
  2c0b11:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0b18:	8b 12                	mov    (%rdx),%edx
  2c0b1a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0b1d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0b24:	89 0a                	mov    %ecx,(%rdx)
  2c0b26:	eb 1a                	jmp    2c0b42 <printer_vprintf+0x38e>
  2c0b28:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b2f:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0b33:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0b37:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0b3e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0b42:	48 8b 00             	mov    (%rax),%rax
  2c0b45:	eb 5c                	jmp    2c0ba3 <printer_vprintf+0x3ef>
  2c0b47:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b4e:	8b 00                	mov    (%rax),%eax
  2c0b50:	83 f8 2f             	cmp    $0x2f,%eax
  2c0b53:	77 30                	ja     2c0b85 <printer_vprintf+0x3d1>
  2c0b55:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b5c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0b60:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b67:	8b 00                	mov    (%rax),%eax
  2c0b69:	89 c0                	mov    %eax,%eax
  2c0b6b:	48 01 d0             	add    %rdx,%rax
  2c0b6e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0b75:	8b 12                	mov    (%rdx),%edx
  2c0b77:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0b7a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0b81:	89 0a                	mov    %ecx,(%rdx)
  2c0b83:	eb 1a                	jmp    2c0b9f <printer_vprintf+0x3eb>
  2c0b85:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b8c:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0b90:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0b94:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0b9b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0b9f:	8b 00                	mov    (%rax),%eax
  2c0ba1:	48 98                	cltq   
  2c0ba3:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c0ba7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0bab:	48 c1 f8 38          	sar    $0x38,%rax
  2c0baf:	25 80 00 00 00       	and    $0x80,%eax
  2c0bb4:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c0bb7:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c0bbb:	74 09                	je     2c0bc6 <printer_vprintf+0x412>
  2c0bbd:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0bc1:	48 f7 d8             	neg    %rax
  2c0bc4:	eb 04                	jmp    2c0bca <printer_vprintf+0x416>
  2c0bc6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0bca:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c0bce:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c0bd1:	83 c8 60             	or     $0x60,%eax
  2c0bd4:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c0bd7:	e9 cf 02 00 00       	jmp    2c0eab <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c0bdc:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0be0:	74 5d                	je     2c0c3f <printer_vprintf+0x48b>
  2c0be2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0be9:	8b 00                	mov    (%rax),%eax
  2c0beb:	83 f8 2f             	cmp    $0x2f,%eax
  2c0bee:	77 30                	ja     2c0c20 <printer_vprintf+0x46c>
  2c0bf0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bf7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0bfb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c02:	8b 00                	mov    (%rax),%eax
  2c0c04:	89 c0                	mov    %eax,%eax
  2c0c06:	48 01 d0             	add    %rdx,%rax
  2c0c09:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c10:	8b 12                	mov    (%rdx),%edx
  2c0c12:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0c15:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c1c:	89 0a                	mov    %ecx,(%rdx)
  2c0c1e:	eb 1a                	jmp    2c0c3a <printer_vprintf+0x486>
  2c0c20:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c27:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0c2b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0c2f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c36:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0c3a:	48 8b 00             	mov    (%rax),%rax
  2c0c3d:	eb 5c                	jmp    2c0c9b <printer_vprintf+0x4e7>
  2c0c3f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c46:	8b 00                	mov    (%rax),%eax
  2c0c48:	83 f8 2f             	cmp    $0x2f,%eax
  2c0c4b:	77 30                	ja     2c0c7d <printer_vprintf+0x4c9>
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
  2c0c7b:	eb 1a                	jmp    2c0c97 <printer_vprintf+0x4e3>
  2c0c7d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c84:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0c88:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0c8c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c93:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0c97:	8b 00                	mov    (%rax),%eax
  2c0c99:	89 c0                	mov    %eax,%eax
  2c0c9b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c0c9f:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c0ca3:	e9 03 02 00 00       	jmp    2c0eab <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  2c0ca8:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c0caf:	e9 28 ff ff ff       	jmp    2c0bdc <printer_vprintf+0x428>
        case 'X':
            base = 16;
  2c0cb4:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c0cbb:	e9 1c ff ff ff       	jmp    2c0bdc <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c0cc0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cc7:	8b 00                	mov    (%rax),%eax
  2c0cc9:	83 f8 2f             	cmp    $0x2f,%eax
  2c0ccc:	77 30                	ja     2c0cfe <printer_vprintf+0x54a>
  2c0cce:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cd5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0cd9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ce0:	8b 00                	mov    (%rax),%eax
  2c0ce2:	89 c0                	mov    %eax,%eax
  2c0ce4:	48 01 d0             	add    %rdx,%rax
  2c0ce7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0cee:	8b 12                	mov    (%rdx),%edx
  2c0cf0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0cf3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0cfa:	89 0a                	mov    %ecx,(%rdx)
  2c0cfc:	eb 1a                	jmp    2c0d18 <printer_vprintf+0x564>
  2c0cfe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d05:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0d09:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0d0d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d14:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0d18:	48 8b 00             	mov    (%rax),%rax
  2c0d1b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c0d1f:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c0d26:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c0d2d:	e9 79 01 00 00       	jmp    2c0eab <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  2c0d32:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d39:	8b 00                	mov    (%rax),%eax
  2c0d3b:	83 f8 2f             	cmp    $0x2f,%eax
  2c0d3e:	77 30                	ja     2c0d70 <printer_vprintf+0x5bc>
  2c0d40:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d47:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0d4b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d52:	8b 00                	mov    (%rax),%eax
  2c0d54:	89 c0                	mov    %eax,%eax
  2c0d56:	48 01 d0             	add    %rdx,%rax
  2c0d59:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d60:	8b 12                	mov    (%rdx),%edx
  2c0d62:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0d65:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d6c:	89 0a                	mov    %ecx,(%rdx)
  2c0d6e:	eb 1a                	jmp    2c0d8a <printer_vprintf+0x5d6>
  2c0d70:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d77:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0d7b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0d7f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d86:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0d8a:	48 8b 00             	mov    (%rax),%rax
  2c0d8d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c0d91:	e9 15 01 00 00       	jmp    2c0eab <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  2c0d96:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d9d:	8b 00                	mov    (%rax),%eax
  2c0d9f:	83 f8 2f             	cmp    $0x2f,%eax
  2c0da2:	77 30                	ja     2c0dd4 <printer_vprintf+0x620>
  2c0da4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dab:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0daf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0db6:	8b 00                	mov    (%rax),%eax
  2c0db8:	89 c0                	mov    %eax,%eax
  2c0dba:	48 01 d0             	add    %rdx,%rax
  2c0dbd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0dc4:	8b 12                	mov    (%rdx),%edx
  2c0dc6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0dc9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0dd0:	89 0a                	mov    %ecx,(%rdx)
  2c0dd2:	eb 1a                	jmp    2c0dee <printer_vprintf+0x63a>
  2c0dd4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ddb:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0ddf:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0de3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0dea:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0dee:	8b 00                	mov    (%rax),%eax
  2c0df0:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c0df6:	e9 67 03 00 00       	jmp    2c1162 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  2c0dfb:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c0dff:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c0e03:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e0a:	8b 00                	mov    (%rax),%eax
  2c0e0c:	83 f8 2f             	cmp    $0x2f,%eax
  2c0e0f:	77 30                	ja     2c0e41 <printer_vprintf+0x68d>
  2c0e11:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e18:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0e1c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e23:	8b 00                	mov    (%rax),%eax
  2c0e25:	89 c0                	mov    %eax,%eax
  2c0e27:	48 01 d0             	add    %rdx,%rax
  2c0e2a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e31:	8b 12                	mov    (%rdx),%edx
  2c0e33:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0e36:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e3d:	89 0a                	mov    %ecx,(%rdx)
  2c0e3f:	eb 1a                	jmp    2c0e5b <printer_vprintf+0x6a7>
  2c0e41:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e48:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0e4c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0e50:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e57:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0e5b:	8b 00                	mov    (%rax),%eax
  2c0e5d:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c0e60:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c0e64:	eb 45                	jmp    2c0eab <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  2c0e66:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c0e6a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c0e6e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e75:	0f b6 00             	movzbl (%rax),%eax
  2c0e78:	84 c0                	test   %al,%al
  2c0e7a:	74 0c                	je     2c0e88 <printer_vprintf+0x6d4>
  2c0e7c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e83:	0f b6 00             	movzbl (%rax),%eax
  2c0e86:	eb 05                	jmp    2c0e8d <printer_vprintf+0x6d9>
  2c0e88:	b8 25 00 00 00       	mov    $0x25,%eax
  2c0e8d:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c0e90:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c0e94:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e9b:	0f b6 00             	movzbl (%rax),%eax
  2c0e9e:	84 c0                	test   %al,%al
  2c0ea0:	75 08                	jne    2c0eaa <printer_vprintf+0x6f6>
                format--;
  2c0ea2:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c0ea9:	01 
            }
            break;
  2c0eaa:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c0eab:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0eae:	83 e0 20             	and    $0x20,%eax
  2c0eb1:	85 c0                	test   %eax,%eax
  2c0eb3:	74 1e                	je     2c0ed3 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c0eb5:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c0eb9:	48 83 c0 18          	add    $0x18,%rax
  2c0ebd:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c0ec0:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c0ec4:	48 89 ce             	mov    %rcx,%rsi
  2c0ec7:	48 89 c7             	mov    %rax,%rdi
  2c0eca:	e8 63 f8 ff ff       	call   2c0732 <fill_numbuf>
  2c0ecf:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c0ed3:	48 c7 45 c0 66 15 2c 	movq   $0x2c1566,-0x40(%rbp)
  2c0eda:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c0edb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0ede:	83 e0 20             	and    $0x20,%eax
  2c0ee1:	85 c0                	test   %eax,%eax
  2c0ee3:	74 48                	je     2c0f2d <printer_vprintf+0x779>
  2c0ee5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0ee8:	83 e0 40             	and    $0x40,%eax
  2c0eeb:	85 c0                	test   %eax,%eax
  2c0eed:	74 3e                	je     2c0f2d <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  2c0eef:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0ef2:	25 80 00 00 00       	and    $0x80,%eax
  2c0ef7:	85 c0                	test   %eax,%eax
  2c0ef9:	74 0a                	je     2c0f05 <printer_vprintf+0x751>
                prefix = "-";
  2c0efb:	48 c7 45 c0 67 15 2c 	movq   $0x2c1567,-0x40(%rbp)
  2c0f02:	00 
            if (flags & FLAG_NEGATIVE) {
  2c0f03:	eb 73                	jmp    2c0f78 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c0f05:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0f08:	83 e0 10             	and    $0x10,%eax
  2c0f0b:	85 c0                	test   %eax,%eax
  2c0f0d:	74 0a                	je     2c0f19 <printer_vprintf+0x765>
                prefix = "+";
  2c0f0f:	48 c7 45 c0 69 15 2c 	movq   $0x2c1569,-0x40(%rbp)
  2c0f16:	00 
            if (flags & FLAG_NEGATIVE) {
  2c0f17:	eb 5f                	jmp    2c0f78 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c0f19:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0f1c:	83 e0 08             	and    $0x8,%eax
  2c0f1f:	85 c0                	test   %eax,%eax
  2c0f21:	74 55                	je     2c0f78 <printer_vprintf+0x7c4>
                prefix = " ";
  2c0f23:	48 c7 45 c0 6b 15 2c 	movq   $0x2c156b,-0x40(%rbp)
  2c0f2a:	00 
            if (flags & FLAG_NEGATIVE) {
  2c0f2b:	eb 4b                	jmp    2c0f78 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c0f2d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0f30:	83 e0 20             	and    $0x20,%eax
  2c0f33:	85 c0                	test   %eax,%eax
  2c0f35:	74 42                	je     2c0f79 <printer_vprintf+0x7c5>
  2c0f37:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0f3a:	83 e0 01             	and    $0x1,%eax
  2c0f3d:	85 c0                	test   %eax,%eax
  2c0f3f:	74 38                	je     2c0f79 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  2c0f41:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c0f45:	74 06                	je     2c0f4d <printer_vprintf+0x799>
  2c0f47:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c0f4b:	75 2c                	jne    2c0f79 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  2c0f4d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0f52:	75 0c                	jne    2c0f60 <printer_vprintf+0x7ac>
  2c0f54:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0f57:	25 00 01 00 00       	and    $0x100,%eax
  2c0f5c:	85 c0                	test   %eax,%eax
  2c0f5e:	74 19                	je     2c0f79 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  2c0f60:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c0f64:	75 07                	jne    2c0f6d <printer_vprintf+0x7b9>
  2c0f66:	b8 6d 15 2c 00       	mov    $0x2c156d,%eax
  2c0f6b:	eb 05                	jmp    2c0f72 <printer_vprintf+0x7be>
  2c0f6d:	b8 70 15 2c 00       	mov    $0x2c1570,%eax
  2c0f72:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c0f76:	eb 01                	jmp    2c0f79 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  2c0f78:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c0f79:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c0f7d:	78 24                	js     2c0fa3 <printer_vprintf+0x7ef>
  2c0f7f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0f82:	83 e0 20             	and    $0x20,%eax
  2c0f85:	85 c0                	test   %eax,%eax
  2c0f87:	75 1a                	jne    2c0fa3 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  2c0f89:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0f8c:	48 63 d0             	movslq %eax,%rdx
  2c0f8f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c0f93:	48 89 d6             	mov    %rdx,%rsi
  2c0f96:	48 89 c7             	mov    %rax,%rdi
  2c0f99:	e8 ea f5 ff ff       	call   2c0588 <strnlen>
  2c0f9e:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c0fa1:	eb 0f                	jmp    2c0fb2 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  2c0fa3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c0fa7:	48 89 c7             	mov    %rax,%rdi
  2c0faa:	e8 a8 f5 ff ff       	call   2c0557 <strlen>
  2c0faf:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c0fb2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0fb5:	83 e0 20             	and    $0x20,%eax
  2c0fb8:	85 c0                	test   %eax,%eax
  2c0fba:	74 20                	je     2c0fdc <printer_vprintf+0x828>
  2c0fbc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c0fc0:	78 1a                	js     2c0fdc <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  2c0fc2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0fc5:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c0fc8:	7e 08                	jle    2c0fd2 <printer_vprintf+0x81e>
  2c0fca:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0fcd:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c0fd0:	eb 05                	jmp    2c0fd7 <printer_vprintf+0x823>
  2c0fd2:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0fd7:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c0fda:	eb 5c                	jmp    2c1038 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c0fdc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0fdf:	83 e0 20             	and    $0x20,%eax
  2c0fe2:	85 c0                	test   %eax,%eax
  2c0fe4:	74 4b                	je     2c1031 <printer_vprintf+0x87d>
  2c0fe6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0fe9:	83 e0 02             	and    $0x2,%eax
  2c0fec:	85 c0                	test   %eax,%eax
  2c0fee:	74 41                	je     2c1031 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c0ff0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0ff3:	83 e0 04             	and    $0x4,%eax
  2c0ff6:	85 c0                	test   %eax,%eax
  2c0ff8:	75 37                	jne    2c1031 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  2c0ffa:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c0ffe:	48 89 c7             	mov    %rax,%rdi
  2c1001:	e8 51 f5 ff ff       	call   2c0557 <strlen>
  2c1006:	89 c2                	mov    %eax,%edx
  2c1008:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c100b:	01 d0                	add    %edx,%eax
  2c100d:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c1010:	7e 1f                	jle    2c1031 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  2c1012:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c1015:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c1018:	89 c3                	mov    %eax,%ebx
  2c101a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c101e:	48 89 c7             	mov    %rax,%rdi
  2c1021:	e8 31 f5 ff ff       	call   2c0557 <strlen>
  2c1026:	89 c2                	mov    %eax,%edx
  2c1028:	89 d8                	mov    %ebx,%eax
  2c102a:	29 d0                	sub    %edx,%eax
  2c102c:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c102f:	eb 07                	jmp    2c1038 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  2c1031:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c1038:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c103b:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c103e:	01 d0                	add    %edx,%eax
  2c1040:	48 63 d8             	movslq %eax,%rbx
  2c1043:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1047:	48 89 c7             	mov    %rax,%rdi
  2c104a:	e8 08 f5 ff ff       	call   2c0557 <strlen>
  2c104f:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c1053:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c1056:	29 d0                	sub    %edx,%eax
  2c1058:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c105b:	eb 25                	jmp    2c1082 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  2c105d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1064:	48 8b 08             	mov    (%rax),%rcx
  2c1067:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c106d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1074:	be 20 00 00 00       	mov    $0x20,%esi
  2c1079:	48 89 c7             	mov    %rax,%rdi
  2c107c:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c107e:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c1082:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1085:	83 e0 04             	and    $0x4,%eax
  2c1088:	85 c0                	test   %eax,%eax
  2c108a:	75 36                	jne    2c10c2 <printer_vprintf+0x90e>
  2c108c:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1090:	7f cb                	jg     2c105d <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  2c1092:	eb 2e                	jmp    2c10c2 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  2c1094:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c109b:	4c 8b 00             	mov    (%rax),%r8
  2c109e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c10a2:	0f b6 00             	movzbl (%rax),%eax
  2c10a5:	0f b6 c8             	movzbl %al,%ecx
  2c10a8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c10ae:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c10b5:	89 ce                	mov    %ecx,%esi
  2c10b7:	48 89 c7             	mov    %rax,%rdi
  2c10ba:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c10bd:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c10c2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c10c6:	0f b6 00             	movzbl (%rax),%eax
  2c10c9:	84 c0                	test   %al,%al
  2c10cb:	75 c7                	jne    2c1094 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  2c10cd:	eb 25                	jmp    2c10f4 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  2c10cf:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c10d6:	48 8b 08             	mov    (%rax),%rcx
  2c10d9:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c10df:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c10e6:	be 30 00 00 00       	mov    $0x30,%esi
  2c10eb:	48 89 c7             	mov    %rax,%rdi
  2c10ee:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c10f0:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c10f4:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c10f8:	7f d5                	jg     2c10cf <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  2c10fa:	eb 32                	jmp    2c112e <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  2c10fc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1103:	4c 8b 00             	mov    (%rax),%r8
  2c1106:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c110a:	0f b6 00             	movzbl (%rax),%eax
  2c110d:	0f b6 c8             	movzbl %al,%ecx
  2c1110:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1116:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c111d:	89 ce                	mov    %ecx,%esi
  2c111f:	48 89 c7             	mov    %rax,%rdi
  2c1122:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c1125:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c112a:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c112e:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c1132:	7f c8                	jg     2c10fc <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  2c1134:	eb 25                	jmp    2c115b <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  2c1136:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c113d:	48 8b 08             	mov    (%rax),%rcx
  2c1140:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1146:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c114d:	be 20 00 00 00       	mov    $0x20,%esi
  2c1152:	48 89 c7             	mov    %rax,%rdi
  2c1155:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c1157:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c115b:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c115f:	7f d5                	jg     2c1136 <printer_vprintf+0x982>
        }
    done: ;
  2c1161:	90                   	nop
    for (; *format; ++format) {
  2c1162:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c1169:	01 
  2c116a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1171:	0f b6 00             	movzbl (%rax),%eax
  2c1174:	84 c0                	test   %al,%al
  2c1176:	0f 85 64 f6 ff ff    	jne    2c07e0 <printer_vprintf+0x2c>
    }
}
  2c117c:	90                   	nop
  2c117d:	90                   	nop
  2c117e:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c1182:	c9                   	leave  
  2c1183:	c3                   	ret    

00000000002c1184 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c1184:	55                   	push   %rbp
  2c1185:	48 89 e5             	mov    %rsp,%rbp
  2c1188:	48 83 ec 20          	sub    $0x20,%rsp
  2c118c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c1190:	89 f0                	mov    %esi,%eax
  2c1192:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1195:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c1198:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c119c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c11a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c11a4:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c11a8:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  2c11ad:	48 39 d0             	cmp    %rdx,%rax
  2c11b0:	72 0c                	jb     2c11be <console_putc+0x3a>
        cp->cursor = console;
  2c11b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c11b6:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  2c11bd:	00 
    }
    if (c == '\n') {
  2c11be:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c11c2:	75 78                	jne    2c123c <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  2c11c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c11c8:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c11cc:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c11d2:	48 d1 f8             	sar    %rax
  2c11d5:	48 89 c1             	mov    %rax,%rcx
  2c11d8:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c11df:	66 66 66 
  2c11e2:	48 89 c8             	mov    %rcx,%rax
  2c11e5:	48 f7 ea             	imul   %rdx
  2c11e8:	48 c1 fa 05          	sar    $0x5,%rdx
  2c11ec:	48 89 c8             	mov    %rcx,%rax
  2c11ef:	48 c1 f8 3f          	sar    $0x3f,%rax
  2c11f3:	48 29 c2             	sub    %rax,%rdx
  2c11f6:	48 89 d0             	mov    %rdx,%rax
  2c11f9:	48 c1 e0 02          	shl    $0x2,%rax
  2c11fd:	48 01 d0             	add    %rdx,%rax
  2c1200:	48 c1 e0 04          	shl    $0x4,%rax
  2c1204:	48 29 c1             	sub    %rax,%rcx
  2c1207:	48 89 ca             	mov    %rcx,%rdx
  2c120a:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c120d:	eb 25                	jmp    2c1234 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  2c120f:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c1212:	83 c8 20             	or     $0x20,%eax
  2c1215:	89 c6                	mov    %eax,%esi
  2c1217:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c121b:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c121f:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1223:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c1227:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c122b:	89 f2                	mov    %esi,%edx
  2c122d:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c1230:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1234:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c1238:	75 d5                	jne    2c120f <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c123a:	eb 24                	jmp    2c1260 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  2c123c:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  2c1240:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c1243:	09 d0                	or     %edx,%eax
  2c1245:	89 c6                	mov    %eax,%esi
  2c1247:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c124b:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c124f:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1253:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c1257:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c125b:	89 f2                	mov    %esi,%edx
  2c125d:	66 89 10             	mov    %dx,(%rax)
}
  2c1260:	90                   	nop
  2c1261:	c9                   	leave  
  2c1262:	c3                   	ret    

00000000002c1263 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c1263:	55                   	push   %rbp
  2c1264:	48 89 e5             	mov    %rsp,%rbp
  2c1267:	48 83 ec 30          	sub    $0x30,%rsp
  2c126b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c126e:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c1271:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c1275:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c1279:	48 c7 45 f0 84 11 2c 	movq   $0x2c1184,-0x10(%rbp)
  2c1280:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1281:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c1285:	78 09                	js     2c1290 <console_vprintf+0x2d>
  2c1287:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c128e:	7e 07                	jle    2c1297 <console_vprintf+0x34>
        cpos = 0;
  2c1290:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c1297:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c129a:	48 98                	cltq   
  2c129c:	48 01 c0             	add    %rax,%rax
  2c129f:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  2c12a5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c12a9:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c12ad:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c12b1:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c12b4:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c12b8:	48 89 c7             	mov    %rax,%rdi
  2c12bb:	e8 f4 f4 ff ff       	call   2c07b4 <printer_vprintf>
    return cp.cursor - console;
  2c12c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c12c4:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c12ca:	48 d1 f8             	sar    %rax
}
  2c12cd:	c9                   	leave  
  2c12ce:	c3                   	ret    

00000000002c12cf <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c12cf:	55                   	push   %rbp
  2c12d0:	48 89 e5             	mov    %rsp,%rbp
  2c12d3:	48 83 ec 60          	sub    $0x60,%rsp
  2c12d7:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c12da:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c12dd:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c12e1:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c12e5:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c12e9:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c12ed:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c12f4:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c12f8:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c12fc:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c1300:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c1304:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c1308:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c130c:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c130f:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c1312:	89 c7                	mov    %eax,%edi
  2c1314:	e8 4a ff ff ff       	call   2c1263 <console_vprintf>
  2c1319:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c131c:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c131f:	c9                   	leave  
  2c1320:	c3                   	ret    

00000000002c1321 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c1321:	55                   	push   %rbp
  2c1322:	48 89 e5             	mov    %rsp,%rbp
  2c1325:	48 83 ec 20          	sub    $0x20,%rsp
  2c1329:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c132d:	89 f0                	mov    %esi,%eax
  2c132f:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1332:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c1335:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1339:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c133d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1341:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c1345:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1349:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c134d:	48 39 c2             	cmp    %rax,%rdx
  2c1350:	73 1a                	jae    2c136c <string_putc+0x4b>
        *sp->s++ = c;
  2c1352:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1356:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c135a:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c135e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c1362:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1366:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c136a:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c136c:	90                   	nop
  2c136d:	c9                   	leave  
  2c136e:	c3                   	ret    

00000000002c136f <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c136f:	55                   	push   %rbp
  2c1370:	48 89 e5             	mov    %rsp,%rbp
  2c1373:	48 83 ec 40          	sub    $0x40,%rsp
  2c1377:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c137b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c137f:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c1383:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c1387:	48 c7 45 e8 21 13 2c 	movq   $0x2c1321,-0x18(%rbp)
  2c138e:	00 
    sp.s = s;
  2c138f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1393:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c1397:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c139c:	74 33                	je     2c13d1 <vsnprintf+0x62>
        sp.end = s + size - 1;
  2c139e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c13a2:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c13a6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c13aa:	48 01 d0             	add    %rdx,%rax
  2c13ad:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c13b1:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c13b5:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c13b9:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c13bd:	be 00 00 00 00       	mov    $0x0,%esi
  2c13c2:	48 89 c7             	mov    %rax,%rdi
  2c13c5:	e8 ea f3 ff ff       	call   2c07b4 <printer_vprintf>
        *sp.s = 0;
  2c13ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c13ce:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c13d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c13d5:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c13d9:	c9                   	leave  
  2c13da:	c3                   	ret    

00000000002c13db <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c13db:	55                   	push   %rbp
  2c13dc:	48 89 e5             	mov    %rsp,%rbp
  2c13df:	48 83 ec 70          	sub    $0x70,%rsp
  2c13e3:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c13e7:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c13eb:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c13ef:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c13f3:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c13f7:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c13fb:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c1402:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1406:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c140a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c140e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c1412:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c1416:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c141a:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c141e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1422:	48 89 c7             	mov    %rax,%rdi
  2c1425:	e8 45 ff ff ff       	call   2c136f <vsnprintf>
  2c142a:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c142d:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c1430:	c9                   	leave  
  2c1431:	c3                   	ret    

00000000002c1432 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c1432:	55                   	push   %rbp
  2c1433:	48 89 e5             	mov    %rsp,%rbp
  2c1436:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c143a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c1441:	eb 13                	jmp    2c1456 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  2c1443:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c1446:	48 98                	cltq   
  2c1448:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  2c144f:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c1452:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1456:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c145d:	7e e4                	jle    2c1443 <console_clear+0x11>
    }
    cursorpos = 0;
  2c145f:	c7 05 93 7b df ff 00 	movl   $0x0,-0x20846d(%rip)        # b8ffc <cursorpos>
  2c1466:	00 00 00 
}
  2c1469:	90                   	nop
  2c146a:	c9                   	leave  
  2c146b:	c3                   	ret    
