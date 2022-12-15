
obj/p-malloc.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	53                   	push   %rbx
  100005:	48 83 ec 08          	sub    $0x8,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100009:	cd 31                	int    $0x31
  10000b:	89 c3                	mov    %eax,%ebx
    pid_t p = getpid();

    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10000d:	b8 3f 30 10 00       	mov    $0x10303f,%eax
  100012:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100018:	48 89 05 e9 1f 00 00 	mov    %rax,0x1fe9(%rip)        # 102008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10001f:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100022:	48 83 e8 01          	sub    $0x1,%rax
  100026:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10002c:	48 89 05 cd 1f 00 00 	mov    %rax,0x1fcd(%rip)        # 102000 <stack_bottom>
  100033:	eb 02                	jmp    100037 <process_main+0x37>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  100035:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
	if ((rand() % ALLOC_SLOWDOWN) < p) {
  100037:	e8 25 0b 00 00       	call   100b61 <rand>
  10003c:	48 63 d0             	movslq %eax,%rdx
  10003f:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  100046:	48 c1 fa 25          	sar    $0x25,%rdx
  10004a:	89 c1                	mov    %eax,%ecx
  10004c:	c1 f9 1f             	sar    $0x1f,%ecx
  10004f:	29 ca                	sub    %ecx,%edx
  100051:	6b d2 64             	imul   $0x64,%edx,%edx
  100054:	29 d0                	sub    %edx,%eax
  100056:	39 d8                	cmp    %ebx,%eax
  100058:	7d db                	jge    100035 <process_main+0x35>
	    void * ret = malloc(PAGESIZE);
  10005a:	bf 00 10 00 00       	mov    $0x1000,%edi
  10005f:	e8 77 03 00 00       	call   1003db <malloc>
	    if(ret == NULL)
  100064:	48 85 c0             	test   %rax,%rax
  100067:	74 04                	je     10006d <process_main+0x6d>
		break;
	    *((int*)ret) = p;       // check we have write access
  100069:	89 18                	mov    %ebx,(%rax)
  10006b:	eb c8                	jmp    100035 <process_main+0x35>
  10006d:	cd 32                	int    $0x32
  10006f:	eb fc                	jmp    10006d <process_main+0x6d>

0000000000100071 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100071:	55                   	push   %rbp
  100072:	48 89 e5             	mov    %rsp,%rbp
  100075:	48 83 ec 50          	sub    $0x50,%rsp
  100079:	49 89 f2             	mov    %rsi,%r10
  10007c:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100080:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100084:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100088:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  10008c:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100091:	85 ff                	test   %edi,%edi
  100093:	78 2e                	js     1000c3 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  100095:	48 63 ff             	movslq %edi,%rdi
  100098:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  10009f:	cc cc cc 
  1000a2:	48 89 f8             	mov    %rdi,%rax
  1000a5:	48 f7 e2             	mul    %rdx
  1000a8:	48 89 d0             	mov    %rdx,%rax
  1000ab:	48 c1 e8 02          	shr    $0x2,%rax
  1000af:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  1000b3:	48 01 c2             	add    %rax,%rdx
  1000b6:	48 29 d7             	sub    %rdx,%rdi
  1000b9:	0f b6 b7 35 19 10 00 	movzbl 0x101935(%rdi),%esi
  1000c0:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  1000c3:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  1000ca:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1000ce:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1000d2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1000d6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  1000da:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1000de:	4c 89 d2             	mov    %r10,%rdx
  1000e1:	8b 3d 15 8f fb ff    	mov    -0x470eb(%rip),%edi        # b8ffc <cursorpos>
  1000e7:	e8 03 16 00 00       	call   1016ef <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  1000ec:	3d 30 07 00 00       	cmp    $0x730,%eax
  1000f1:	ba 00 00 00 00       	mov    $0x0,%edx
  1000f6:	0f 4d c2             	cmovge %edx,%eax
  1000f9:	89 05 fd 8e fb ff    	mov    %eax,-0x47103(%rip)        # b8ffc <cursorpos>
    }
}
  1000ff:	c9                   	leave  
  100100:	c3                   	ret    

0000000000100101 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  100101:	55                   	push   %rbp
  100102:	48 89 e5             	mov    %rsp,%rbp
  100105:	53                   	push   %rbx
  100106:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  10010d:	48 89 fb             	mov    %rdi,%rbx
  100110:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100114:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  100118:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  10011c:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100120:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  100124:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  10012b:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10012f:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100133:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  100137:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  10013b:	ba 07 00 00 00       	mov    $0x7,%edx
  100140:	be 00 19 10 00       	mov    $0x101900,%esi
  100145:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  10014c:	e8 55 07 00 00       	call   1008a6 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100151:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100155:	48 89 da             	mov    %rbx,%rdx
  100158:	be 99 00 00 00       	mov    $0x99,%esi
  10015d:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100164:	e8 92 16 00 00       	call   1017fb <vsnprintf>
  100169:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  10016c:	85 d2                	test   %edx,%edx
  10016e:	7e 0f                	jle    10017f <kernel_panic+0x7e>
  100170:	83 c0 06             	add    $0x6,%eax
  100173:	48 98                	cltq   
  100175:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  10017c:	0a 
  10017d:	75 2a                	jne    1001a9 <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  10017f:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  100186:	48 89 d9             	mov    %rbx,%rcx
  100189:	ba 08 19 10 00       	mov    $0x101908,%edx
  10018e:	be 00 c0 00 00       	mov    $0xc000,%esi
  100193:	bf 30 07 00 00       	mov    $0x730,%edi
  100198:	b8 00 00 00 00       	mov    $0x0,%eax
  10019d:	e8 b9 15 00 00       	call   10175b <console_printf>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  1001a2:	48 89 df             	mov    %rbx,%rdi
  1001a5:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  1001a7:	eb fe                	jmp    1001a7 <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  1001a9:	48 63 c2             	movslq %edx,%rax
  1001ac:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  1001b2:	0f 94 c2             	sete   %dl
  1001b5:	0f b6 d2             	movzbl %dl,%edx
  1001b8:	48 29 d0             	sub    %rdx,%rax
  1001bb:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  1001c2:	ff 
  1001c3:	be 4a 19 10 00       	mov    $0x10194a,%esi
  1001c8:	e8 86 08 00 00       	call   100a53 <strcpy>
  1001cd:	eb b0                	jmp    10017f <kernel_panic+0x7e>

00000000001001cf <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  1001cf:	55                   	push   %rbp
  1001d0:	48 89 e5             	mov    %rsp,%rbp
  1001d3:	48 89 f9             	mov    %rdi,%rcx
  1001d6:	41 89 f0             	mov    %esi,%r8d
  1001d9:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  1001dc:	ba 10 19 10 00       	mov    $0x101910,%edx
  1001e1:	be 00 c0 00 00       	mov    $0xc000,%esi
  1001e6:	bf 30 07 00 00       	mov    $0x730,%edi
  1001eb:	b8 00 00 00 00       	mov    $0x0,%eax
  1001f0:	e8 66 15 00 00       	call   10175b <console_printf>
    asm volatile ("int %0" : /* no result */
  1001f5:	bf 00 00 00 00       	mov    $0x0,%edi
  1001fa:	cd 30                	int    $0x30
 loop: goto loop;
  1001fc:	eb fe                	jmp    1001fc <assert_fail+0x2d>

00000000001001fe <heap_init>:
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  1001fe:	bf 10 00 00 00       	mov    $0x10,%edi
  100203:	cd 3a                	int    $0x3a
  100205:	48 89 05 24 1e 00 00 	mov    %rax,0x1e24(%rip)        # 102030 <result.0>
  10020c:	bf 08 00 00 00       	mov    $0x8,%edi
  100211:	cd 3a                	int    $0x3a
  100213:	48 89 05 16 1e 00 00 	mov    %rax,0x1e16(%rip)        # 102030 <result.0>
// want to try and optimize this 
void heap_init(void) {

	// prologue block
	sbrk(sizeof(block_header) + sizeof(block_header));
	prologue_block = sbrk(sizeof(block_footer));
  10021a:	48 89 05 ff 1d 00 00 	mov    %rax,0x1dff(%rip)        # 102020 <prologue_block>
	PUT(HDRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  100221:	48 c7 40 f8 11 00 00 	movq   $0x11,-0x8(%rax)
  100228:	00 
	PUT(FTRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  100229:	48 8b 15 f0 1d 00 00 	mov    0x1df0(%rip),%rdx        # 102020 <prologue_block>
  100230:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  100234:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100238:	48 c7 44 02 f0 11 00 	movq   $0x11,-0x10(%rdx,%rax,1)
  10023f:	00 00 
  100241:	cd 3a                	int    $0x3a
  100243:	48 89 05 e6 1d 00 00 	mov    %rax,0x1de6(%rip)        # 102030 <result.0>

	// terminal block
	sbrk(sizeof(block_header));
	PUT(HDRP(NEXT_BLKP(prologue_block)), PACK(0, 1));	
  10024a:	48 8b 15 cf 1d 00 00 	mov    0x1dcf(%rip),%rdx        # 102020 <prologue_block>
  100251:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  100255:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100259:	48 c7 44 02 f8 01 00 	movq   $0x1,-0x8(%rdx,%rax,1)
  100260:	00 00 

	free_list = NULL;
  100262:	48 c7 05 ab 1d 00 00 	movq   $0x0,0x1dab(%rip)        # 102018 <free_list>
  100269:	00 00 00 00 

	initialized_heap = 1;
  10026d:	c7 05 b1 1d 00 00 01 	movl   $0x1,0x1db1(%rip)        # 102028 <initialized_heap>
  100274:	00 00 00 
}
  100277:	c3                   	ret    

0000000000100278 <free>:

void free(void *firstbyte) {
	if (firstbyte == NULL)
  100278:	48 85 ff             	test   %rdi,%rdi
  10027b:	74 3d                	je     1002ba <free+0x42>
		return;

	// setup free things: alloc, list ptrs, footer
	PUT(HDRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  10027d:	48 8b 47 f8          	mov    -0x8(%rdi),%rax
  100281:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100285:	48 89 47 f8          	mov    %rax,-0x8(%rdi)
	NEXT_FPTR(firstbyte) = free_list;
  100289:	48 8b 15 88 1d 00 00 	mov    0x1d88(%rip),%rdx        # 102018 <free_list>
  100290:	48 89 17             	mov    %rdx,(%rdi)
	PREV_FPTR(firstbyte) = NULL;
  100293:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  10029a:	00 
	PUT(FTRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  10029b:	48 89 44 07 f0       	mov    %rax,-0x10(%rdi,%rax,1)

	// add to free_list
	PREV_FPTR(free_list) = firstbyte;
  1002a0:	48 8b 05 71 1d 00 00 	mov    0x1d71(%rip),%rax        # 102018 <free_list>
  1002a7:	48 89 78 08          	mov    %rdi,0x8(%rax)
	free_list = firstbyte;
  1002ab:	48 89 3d 66 1d 00 00 	mov    %rdi,0x1d66(%rip)        # 102018 <free_list>

	num_allocs--;
  1002b2:	48 83 2d 56 1d 00 00 	subq   $0x1,0x1d56(%rip)        # 102010 <num_allocs>
  1002b9:	01 

	return;
}
  1002ba:	c3                   	ret    

00000000001002bb <extend>:
//
//	the reason allocating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
int extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  1002bb:	48 81 c7 ff 3f 00 00 	add    $0x3fff,%rdi
  1002c2:	48 81 e7 00 c0 ff ff 	and    $0xffffffffffffc000,%rdi
  1002c9:	cd 3a                	int    $0x3a
  1002cb:	48 89 05 5e 1d 00 00 	mov    %rax,0x1d5e(%rip)        # 102030 <result.0>
	void *bp = sbrk(chunk_aligned_size);
	if (bp == (void *)-1)
  1002d2:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  1002d6:	74 49                	je     100321 <extend+0x66>
		return -1;

	// setup pointer
	PUT(HDRP(bp), PACK(chunk_aligned_size, 0));	
  1002d8:	48 89 78 f8          	mov    %rdi,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  1002dc:	48 8b 15 35 1d 00 00 	mov    0x1d35(%rip),%rdx        # 102018 <free_list>
  1002e3:	48 89 10             	mov    %rdx,(%rax)
	PREV_FPTR(bp) = NULL;
  1002e6:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  1002ed:	00 
	PUT(FTRP(bp), PACK(chunk_aligned_size, 0));	
  1002ee:	48 89 7c 07 f0       	mov    %rdi,-0x10(%rdi,%rax,1)
	
	// add to head of free_list
	if (free_list)
  1002f3:	48 8b 15 1e 1d 00 00 	mov    0x1d1e(%rip),%rdx        # 102018 <free_list>
  1002fa:	48 85 d2             	test   %rdx,%rdx
  1002fd:	74 04                	je     100303 <extend+0x48>
		PREV_FPTR(free_list) = bp;
  1002ff:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  100303:	48 89 05 0e 1d 00 00 	mov    %rax,0x1d0e(%rip)        # 102018 <free_list>

	// update terminal block
	PUT(HDRP(NEXT_BLKP(bp)), PACK(0, 1));	
  10030a:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  10030e:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100312:	48 c7 44 10 f8 01 00 	movq   $0x1,-0x8(%rax,%rdx,1)
  100319:	00 00 

	return 0;
  10031b:	b8 00 00 00 00       	mov    $0x0,%eax
  100320:	c3                   	ret    
		return -1;
  100321:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  100326:	c3                   	ret    

0000000000100327 <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
  100327:	48 89 f8             	mov    %rdi,%rax
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  10032a:	48 8b 57 f8          	mov    -0x8(%rdi),%rdx
  10032e:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100332:	48 29 f2             	sub    %rsi,%rdx

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  100335:	48 83 fa 20          	cmp    $0x20,%rdx
  100339:	76 5b                	jbe    100396 <set_allocated+0x6f>
		PUT(HDRP(bp), PACK(size, 1));
  10033b:	48 89 f1             	mov    %rsi,%rcx
  10033e:	48 83 c9 01          	or     $0x1,%rcx
  100342:	48 89 4f f8          	mov    %rcx,-0x8(%rdi)

		void *leftover_mem_ptr = NEXT_BLKP(bp);
  100346:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  10034a:	48 01 fe             	add    %rdi,%rsi

		PUT(HDRP(leftover_mem_ptr), PACK(extra_size, 0));	
  10034d:	48 89 56 f8          	mov    %rdx,-0x8(%rsi)
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp); // pointers to the next free blocks
  100351:	48 8b 0f             	mov    (%rdi),%rcx
  100354:	48 89 0e             	mov    %rcx,(%rsi)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  100357:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  10035b:	48 89 4e 08          	mov    %rcx,0x8(%rsi)
		PUT(FTRP(leftover_mem_ptr), PACK(extra_size, 0));	
  10035f:	48 89 d1             	mov    %rdx,%rcx
  100362:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  100366:	48 89 54 0e f0       	mov    %rdx,-0x10(%rsi,%rcx,1)

		// update the free list
		if (free_list == bp)
  10036b:	48 39 3d a6 1c 00 00 	cmp    %rdi,0x1ca6(%rip)        # 102018 <free_list>
  100372:	74 19                	je     10038d <set_allocated+0x66>
			free_list = leftover_mem_ptr;

		if (PREV_FPTR(bp))
  100374:	48 8b 50 08          	mov    0x8(%rax),%rdx
  100378:	48 85 d2             	test   %rdx,%rdx
  10037b:	74 03                	je     100380 <set_allocated+0x59>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  10037d:	48 89 32             	mov    %rsi,(%rdx)

		if (NEXT_FPTR(bp))
  100380:	48 8b 00             	mov    (%rax),%rax
  100383:	48 85 c0             	test   %rax,%rax
  100386:	74 46                	je     1003ce <set_allocated+0xa7>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  100388:	48 89 70 08          	mov    %rsi,0x8(%rax)
  10038c:	c3                   	ret    
			free_list = leftover_mem_ptr;
  10038d:	48 89 35 84 1c 00 00 	mov    %rsi,0x1c84(%rip)        # 102018 <free_list>
  100394:	eb de                	jmp    100374 <set_allocated+0x4d>
								    
	}
	else {
		// update the free list
		if (free_list == bp)
  100396:	48 39 3d 7b 1c 00 00 	cmp    %rdi,0x1c7b(%rip)        # 102018 <free_list>
  10039d:	74 30                	je     1003cf <set_allocated+0xa8>
			free_list = NEXT_FPTR(bp);

		if (PREV_FPTR(bp))
  10039f:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1003a3:	48 85 d2             	test   %rdx,%rdx
  1003a6:	74 06                	je     1003ae <set_allocated+0x87>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  1003a8:	48 8b 08             	mov    (%rax),%rcx
  1003ab:	48 89 0a             	mov    %rcx,(%rdx)
		if (NEXT_FPTR(bp))
  1003ae:	48 8b 10             	mov    (%rax),%rdx
  1003b1:	48 85 d2             	test   %rdx,%rdx
  1003b4:	74 08                	je     1003be <set_allocated+0x97>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  1003b6:	48 8b 48 08          	mov    0x8(%rax),%rcx
  1003ba:	48 89 4a 08          	mov    %rcx,0x8(%rdx)

		PUT(HDRP(bp), PACK(GET_SIZE(HDRP(bp)), 1));	
  1003be:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1003c2:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1003c6:	48 83 ca 01          	or     $0x1,%rdx
  1003ca:	48 89 50 f8          	mov    %rdx,-0x8(%rax)
	}
}
  1003ce:	c3                   	ret    
			free_list = NEXT_FPTR(bp);
  1003cf:	48 8b 17             	mov    (%rdi),%rdx
  1003d2:	48 89 15 3f 1c 00 00 	mov    %rdx,0x1c3f(%rip)        # 102018 <free_list>
  1003d9:	eb c4                	jmp    10039f <set_allocated+0x78>

00000000001003db <malloc>:

void *malloc(uint64_t numbytes) {
  1003db:	55                   	push   %rbp
  1003dc:	48 89 e5             	mov    %rsp,%rbp
  1003df:	41 55                	push   %r13
  1003e1:	41 54                	push   %r12
  1003e3:	53                   	push   %rbx
  1003e4:	48 83 ec 08          	sub    $0x8,%rsp
  1003e8:	49 89 fc             	mov    %rdi,%r12
	if (!initialized_heap)
  1003eb:	83 3d 36 1c 00 00 00 	cmpl   $0x0,0x1c36(%rip)        # 102028 <initialized_heap>
  1003f2:	74 73                	je     100467 <malloc+0x8c>
		heap_init();

	if (numbytes == 0)
  1003f4:	4d 85 e4             	test   %r12,%r12
  1003f7:	0f 84 92 00 00 00    	je     10048f <malloc+0xb4>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  1003fd:	49 83 c4 17          	add    $0x17,%r12
  100401:	49 83 e4 f0          	and    $0xfffffffffffffff0,%r12
  100405:	b8 20 00 00 00       	mov    $0x20,%eax
  10040a:	49 39 c4             	cmp    %rax,%r12
  10040d:	4c 0f 42 e0          	cmovb  %rax,%r12
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);
	
	void *bp = free_list;
  100411:	48 8b 1d 00 1c 00 00 	mov    0x1c00(%rip),%rbx        # 102018 <free_list>
	while (bp) {
  100418:	48 85 db             	test   %rbx,%rbx
  10041b:	74 15                	je     100432 <malloc+0x57>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  10041d:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  100421:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100425:	4c 39 e0             	cmp    %r12,%rax
  100428:	73 44                	jae    10046e <malloc+0x93>
			set_allocated(bp, aligned_size);
			num_allocs++;
			return bp;
		}

		bp = NEXT_FPTR(bp);
  10042a:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  10042d:	48 85 db             	test   %rbx,%rbx
  100430:	75 eb                	jne    10041d <malloc+0x42>
  100432:	bf 00 00 00 00       	mov    $0x0,%edi
  100437:	cd 3a                	int    $0x3a
  100439:	49 89 c5             	mov    %rax,%r13
  10043c:	48 89 05 ed 1b 00 00 	mov    %rax,0x1bed(%rip)        # 102030 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  100443:	48 89 c3             	mov    %rax,%rbx
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	if (extend(aligned_size)) {
  100446:	4c 89 e7             	mov    %r12,%rdi
  100449:	e8 6d fe ff ff       	call   1002bb <extend>
  10044e:	85 c0                	test   %eax,%eax
  100450:	75 44                	jne    100496 <malloc+0xbb>
		return NULL;
	}
	set_allocated(bp, aligned_size);
  100452:	4c 89 e6             	mov    %r12,%rsi
  100455:	4c 89 ef             	mov    %r13,%rdi
  100458:	e8 ca fe ff ff       	call   100327 <set_allocated>
	num_allocs++;
  10045d:	48 83 05 ab 1b 00 00 	addq   $0x1,0x1bab(%rip)        # 102010 <num_allocs>
  100464:	01 
    return bp;
  100465:	eb 1a                	jmp    100481 <malloc+0xa6>
		heap_init();
  100467:	e8 92 fd ff ff       	call   1001fe <heap_init>
  10046c:	eb 86                	jmp    1003f4 <malloc+0x19>
			set_allocated(bp, aligned_size);
  10046e:	4c 89 e6             	mov    %r12,%rsi
  100471:	48 89 df             	mov    %rbx,%rdi
  100474:	e8 ae fe ff ff       	call   100327 <set_allocated>
			num_allocs++;
  100479:	48 83 05 8f 1b 00 00 	addq   $0x1,0x1b8f(%rip)        # 102010 <num_allocs>
  100480:	01 
}
  100481:	48 89 d8             	mov    %rbx,%rax
  100484:	48 83 c4 08          	add    $0x8,%rsp
  100488:	5b                   	pop    %rbx
  100489:	41 5c                	pop    %r12
  10048b:	41 5d                	pop    %r13
  10048d:	5d                   	pop    %rbp
  10048e:	c3                   	ret    
		return NULL;
  10048f:	bb 00 00 00 00       	mov    $0x0,%ebx
  100494:	eb eb                	jmp    100481 <malloc+0xa6>
		return NULL;
  100496:	bb 00 00 00 00       	mov    $0x0,%ebx
  10049b:	eb e4                	jmp    100481 <malloc+0xa6>

000000000010049d <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  10049d:	55                   	push   %rbp
  10049e:	48 89 e5             	mov    %rsp,%rbp
  1004a1:	41 54                	push   %r12
  1004a3:	53                   	push   %rbx
	void *bp = malloc(num * sz);
  1004a4:	48 0f af fe          	imul   %rsi,%rdi
  1004a8:	49 89 fc             	mov    %rdi,%r12
  1004ab:	e8 2b ff ff ff       	call   1003db <malloc>
  1004b0:	48 89 c3             	mov    %rax,%rbx
	if (bp)							// protect against num=0 or size=0
  1004b3:	48 85 c0             	test   %rax,%rax
  1004b6:	74 10                	je     1004c8 <calloc+0x2b>
		memset(bp, 0, num * sz);
  1004b8:	4c 89 e2             	mov    %r12,%rdx
  1004bb:	be 00 00 00 00       	mov    $0x0,%esi
  1004c0:	48 89 c7             	mov    %rax,%rdi
  1004c3:	e8 dc 04 00 00       	call   1009a4 <memset>
	return bp;
}
  1004c8:	48 89 d8             	mov    %rbx,%rax
  1004cb:	5b                   	pop    %rbx
  1004cc:	41 5c                	pop    %r12
  1004ce:	5d                   	pop    %rbp
  1004cf:	c3                   	ret    

00000000001004d0 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  1004d0:	55                   	push   %rbp
  1004d1:	48 89 e5             	mov    %rsp,%rbp
  1004d4:	41 54                	push   %r12
  1004d6:	53                   	push   %rbx
  1004d7:	48 89 fb             	mov    %rdi,%rbx
  1004da:	48 89 f7             	mov    %rsi,%rdi
	// first check if there's enough space in the block already (and that it's actually valid ptr)
	if (ptr && GET_SIZE(HDRP(ptr)) >= sz)
  1004dd:	48 85 db             	test   %rbx,%rbx
  1004e0:	74 10                	je     1004f2 <realloc+0x22>
  1004e2:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  1004e6:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
		return ptr;
  1004ea:	49 89 dc             	mov    %rbx,%r12
	if (ptr && GET_SIZE(HDRP(ptr)) >= sz)
  1004ed:	48 39 f0             	cmp    %rsi,%rax
  1004f0:	73 23                	jae    100515 <realloc+0x45>

	// else find or add a big enough block, which is what malloc does
	void *bigger_ptr = malloc(sz);
  1004f2:	e8 e4 fe ff ff       	call   1003db <malloc>
  1004f7:	49 89 c4             	mov    %rax,%r12
	memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
  1004fa:	48 8b 53 f8          	mov    -0x8(%rbx),%rdx
  1004fe:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100502:	48 89 de             	mov    %rbx,%rsi
  100505:	48 89 c7             	mov    %rax,%rdi
  100508:	e8 99 03 00 00       	call   1008a6 <memcpy>
	free(ptr);
  10050d:	48 89 df             	mov    %rbx,%rdi
  100510:	e8 63 fd ff ff       	call   100278 <free>

    return bigger_ptr;
}
  100515:	4c 89 e0             	mov    %r12,%rax
  100518:	5b                   	pop    %rbx
  100519:	41 5c                	pop    %r12
  10051b:	5d                   	pop    %rbp
  10051c:	c3                   	ret    

000000000010051d <defrag>:

void defrag() {
	void *fp = free_list;
  10051d:	48 8b 15 f4 1a 00 00 	mov    0x1af4(%rip),%rdx        # 102018 <free_list>
	while (fp != NULL) {
  100524:	48 85 d2             	test   %rdx,%rdx
  100527:	75 3c                	jne    100565 <defrag+0x48>
		// you only need to check the block after, because if the block before is free, you'll
		// bet there by traversing the free list

		fp = NEXT_FPTR(fp);
	}
}
  100529:	c3                   	ret    
				free_list = NEXT_FPTR(next_block);
  10052a:	48 8b 08             	mov    (%rax),%rcx
  10052d:	48 89 0d e4 1a 00 00 	mov    %rcx,0x1ae4(%rip)        # 102018 <free_list>
  100534:	eb 49                	jmp    10057f <defrag+0x62>
			PUT(HDRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  100536:	48 8b 4a f8          	mov    -0x8(%rdx),%rcx
  10053a:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  10053e:	48 8b 70 f8          	mov    -0x8(%rax),%rsi
  100542:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  100546:	48 01 f1             	add    %rsi,%rcx
  100549:	48 89 4a f8          	mov    %rcx,-0x8(%rdx)
			PUT(FTRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  10054d:	48 8b 40 f8          	mov    -0x8(%rax),%rax
  100551:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100555:	48 01 c8             	add    %rcx,%rax
  100558:	48 89 44 0a f0       	mov    %rax,-0x10(%rdx,%rcx,1)
		fp = NEXT_FPTR(fp);
  10055d:	48 8b 12             	mov    (%rdx),%rdx
	while (fp != NULL) {
  100560:	48 85 d2             	test   %rdx,%rdx
  100563:	74 c4                	je     100529 <defrag+0xc>
		void *next_block = NEXT_BLKP(fp);
  100565:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  100569:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  10056d:	48 01 d0             	add    %rdx,%rax
		if (!GET_ALLOC(HDRP(next_block))) {
  100570:	f6 40 f8 01          	testb  $0x1,-0x8(%rax)
  100574:	75 e7                	jne    10055d <defrag+0x40>
			if (free_list == next_block)
  100576:	48 39 05 9b 1a 00 00 	cmp    %rax,0x1a9b(%rip)        # 102018 <free_list>
  10057d:	74 ab                	je     10052a <defrag+0xd>
			if (PREV_FPTR(next_block)) 
  10057f:	48 8b 48 08          	mov    0x8(%rax),%rcx
  100583:	48 85 c9             	test   %rcx,%rcx
  100586:	74 06                	je     10058e <defrag+0x71>
				NEXT_FPTR(PREV_FPTR(next_block)) = NEXT_FPTR(next_block);
  100588:	48 8b 30             	mov    (%rax),%rsi
  10058b:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(next_block)) 
  10058e:	48 8b 08             	mov    (%rax),%rcx
  100591:	48 85 c9             	test   %rcx,%rcx
  100594:	74 a0                	je     100536 <defrag+0x19>
				PREV_FPTR(NEXT_FPTR(next_block)) = PREV_FPTR(next_block);
  100596:	48 8b 70 08          	mov    0x8(%rax),%rsi
  10059a:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  10059e:	eb 96                	jmp    100536 <defrag+0x19>

00000000001005a0 <sift_down>:
// heap sort stuff that operates on the pointer array
#define LEFT_CHILD(x) (2*x + 1)
#define RIGHT_CHILD(x) (2*x + 2)
#define PARENT(x) ((x-1)/2)

void sift_down(void **arr, size_t pos, size_t arr_len) {
  1005a0:	48 89 f1             	mov    %rsi,%rcx
  1005a3:	49 89 d3             	mov    %rdx,%r11
	while (LEFT_CHILD(pos) < arr_len) {
  1005a6:	48 8d 74 36 01       	lea    0x1(%rsi,%rsi,1),%rsi
  1005ab:	48 39 d6             	cmp    %rdx,%rsi
  1005ae:	72 3a                	jb     1005ea <sift_down+0x4a>
  1005b0:	c3                   	ret    
  1005b1:	48 89 f0             	mov    %rsi,%rax
		size_t smaller = LEFT_CHILD(pos);
		if (RIGHT_CHILD(pos) < arr_len && GET_SIZE(HDRP(arr[RIGHT_CHILD(pos)])) < GET_SIZE(HDRP(arr[LEFT_CHILD(pos)]))){
			smaller = RIGHT_CHILD(pos);
		}

		if (GET_SIZE(HDRP(arr[pos])) > GET_SIZE(HDRP(arr[smaller]))) {
  1005b4:	4c 8d 0c cf          	lea    (%rdi,%rcx,8),%r9
  1005b8:	4d 8b 01             	mov    (%r9),%r8
  1005bb:	48 8d 34 c7          	lea    (%rdi,%rax,8),%rsi
  1005bf:	4c 8b 16             	mov    (%rsi),%r10
  1005c2:	49 8b 50 f8          	mov    -0x8(%r8),%rdx
  1005c6:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1005ca:	49 8b 4a f8          	mov    -0x8(%r10),%rcx
  1005ce:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  1005d2:	48 39 d1             	cmp    %rdx,%rcx
  1005d5:	73 46                	jae    10061d <sift_down+0x7d>
			void *temp = arr[pos];
			arr[pos] = arr[smaller];
  1005d7:	4d 89 11             	mov    %r10,(%r9)
			arr[smaller] = temp;
  1005da:	4c 89 06             	mov    %r8,(%rsi)
	while (LEFT_CHILD(pos) < arr_len) {
  1005dd:	48 8d 74 00 01       	lea    0x1(%rax,%rax,1),%rsi
  1005e2:	4c 39 de             	cmp    %r11,%rsi
  1005e5:	73 36                	jae    10061d <sift_down+0x7d>
			pos = smaller;
  1005e7:	48 89 c1             	mov    %rax,%rcx
		if (RIGHT_CHILD(pos) < arr_len && GET_SIZE(HDRP(arr[RIGHT_CHILD(pos)])) < GET_SIZE(HDRP(arr[LEFT_CHILD(pos)]))){
  1005ea:	48 8d 51 01          	lea    0x1(%rcx),%rdx
  1005ee:	48 8d 04 12          	lea    (%rdx,%rdx,1),%rax
  1005f2:	4c 39 d8             	cmp    %r11,%rax
  1005f5:	73 ba                	jae    1005b1 <sift_down+0x11>
  1005f7:	48 c1 e2 04          	shl    $0x4,%rdx
  1005fb:	4c 8b 04 17          	mov    (%rdi,%rdx,1),%r8
  1005ff:	4d 8b 40 f8          	mov    -0x8(%r8),%r8
  100603:	49 83 e0 f0          	and    $0xfffffffffffffff0,%r8
  100607:	48 8b 54 17 f8       	mov    -0x8(%rdi,%rdx,1),%rdx
  10060c:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  100610:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100614:	49 39 d0             	cmp    %rdx,%r8
  100617:	48 0f 43 c6          	cmovae %rsi,%rax
  10061b:	eb 97                	jmp    1005b4 <sift_down+0x14>
		}
		else {
			break;
		}
	}
}
  10061d:	c3                   	ret    

000000000010061e <heapify>:

void heapify(void **arr, size_t arr_len) {
  10061e:	55                   	push   %rbp
  10061f:	48 89 e5             	mov    %rsp,%rbp
  100622:	41 56                	push   %r14
  100624:	41 55                	push   %r13
  100626:	41 54                	push   %r12
  100628:	53                   	push   %rbx
	for (int i = arr_len - 1; i >= 0; i--) {
  100629:	41 89 f5             	mov    %esi,%r13d
  10062c:	41 83 ed 01          	sub    $0x1,%r13d
  100630:	78 28                	js     10065a <heapify+0x3c>
  100632:	49 89 fe             	mov    %rdi,%r14
  100635:	49 89 f4             	mov    %rsi,%r12
  100638:	49 63 c5             	movslq %r13d,%rax
  10063b:	48 89 c3             	mov    %rax,%rbx
  10063e:	41 29 c5             	sub    %eax,%r13d
		sift_down(arr, i, arr_len);
  100641:	4c 89 e2             	mov    %r12,%rdx
  100644:	48 89 de             	mov    %rbx,%rsi
  100647:	4c 89 f7             	mov    %r14,%rdi
  10064a:	e8 51 ff ff ff       	call   1005a0 <sift_down>
	for (int i = arr_len - 1; i >= 0; i--) {
  10064f:	48 83 eb 01          	sub    $0x1,%rbx
  100653:	44 89 e8             	mov    %r13d,%eax
  100656:	01 d8                	add    %ebx,%eax
  100658:	79 e7                	jns    100641 <heapify+0x23>
	}
}
  10065a:	5b                   	pop    %rbx
  10065b:	41 5c                	pop    %r12
  10065d:	41 5d                	pop    %r13
  10065f:	41 5e                	pop    %r14
  100661:	5d                   	pop    %rbp
  100662:	c3                   	ret    

0000000000100663 <heapsort>:

void heapsort(void **arr, size_t arr_len) {
  100663:	55                   	push   %rbp
  100664:	48 89 e5             	mov    %rsp,%rbp
  100667:	41 54                	push   %r12
  100669:	53                   	push   %rbx
  10066a:	49 89 fc             	mov    %rdi,%r12
  10066d:	48 89 f3             	mov    %rsi,%rbx
	heapify(arr, arr_len);
  100670:	e8 a9 ff ff ff       	call   10061e <heapify>
	if (arr_len == 0)
  100675:	48 85 db             	test   %rbx,%rbx
  100678:	74 30                	je     1006aa <heapsort+0x47>
		return;
	for (int i = arr_len - 1; i >= 0; i--) {
  10067a:	83 eb 01             	sub    $0x1,%ebx
  10067d:	78 2b                	js     1006aa <heapsort+0x47>
  10067f:	48 63 db             	movslq %ebx,%rbx
		void *temp = arr[0];
  100682:	49 8b 04 24          	mov    (%r12),%rax
		arr[0] = arr[i];
  100686:	49 8b 14 dc          	mov    (%r12,%rbx,8),%rdx
  10068a:	49 89 14 24          	mov    %rdx,(%r12)
		arr[i] = temp;
  10068e:	49 89 04 dc          	mov    %rax,(%r12,%rbx,8)
		sift_down(arr, 0, i);
  100692:	48 89 da             	mov    %rbx,%rdx
  100695:	be 00 00 00 00       	mov    $0x0,%esi
  10069a:	4c 89 e7             	mov    %r12,%rdi
  10069d:	e8 fe fe ff ff       	call   1005a0 <sift_down>
	for (int i = arr_len - 1; i >= 0; i--) {
  1006a2:	48 83 eb 01          	sub    $0x1,%rbx
  1006a6:	85 db                	test   %ebx,%ebx
  1006a8:	79 d8                	jns    100682 <heapsort+0x1f>
	}
}
  1006aa:	5b                   	pop    %rbx
  1006ab:	41 5c                	pop    %r12
  1006ad:	5d                   	pop    %rbp
  1006ae:	c3                   	ret    

00000000001006af <heap_info>:

int heap_info(heap_info_struct *info) {
  1006af:	55                   	push   %rbp
  1006b0:	48 89 e5             	mov    %rsp,%rbp
  1006b3:	41 54                	push   %r12
  1006b5:	53                   	push   %rbx
  1006b6:	48 89 fb             	mov    %rdi,%rbx
	info->num_allocs = num_allocs+2;		// +2 for the two arrays we need
  1006b9:	8b 05 51 19 00 00    	mov    0x1951(%rip),%eax        # 102010 <num_allocs>
  1006bf:	83 c0 02             	add    $0x2,%eax
  1006c2:	89 07                	mov    %eax,(%rdi)
	info->free_space = 0;
  1006c4:	c7 47 18 00 00 00 00 	movl   $0x0,0x18(%rdi)
	info->largest_free_chunk = 0;
  1006cb:	c7 47 1c 00 00 00 00 	movl   $0x0,0x1c(%rdi)

	info->size_array = sbrk(ALIGN(info->num_allocs * sizeof(long) + OVERHEAD));
  1006d2:	48 98                	cltq   
  1006d4:	48 8d 3c c5 17 00 00 	lea    0x17(,%rax,8),%rdi
  1006db:	00 
  1006dc:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
    asm volatile ("int %1" :  "=a" (result)
  1006e0:	cd 3a                	int    $0x3a
  1006e2:	48 89 05 47 19 00 00 	mov    %rax,0x1947(%rip)        # 102030 <result.0>
  1006e9:	48 89 43 08          	mov    %rax,0x8(%rbx)
	if (info->ptr_array == (void *)-1) { // nothing happens on failure
  1006ed:	48 83 7b 10 ff       	cmpq   $0xffffffffffffffff,0x10(%rbx)
  1006f2:	0f 84 a0 01 00 00    	je     100898 <heap_info+0x1e9>
		return -1;
	}
	info->ptr_array = sbrk(ALIGN(info->num_allocs * sizeof(void *) + OVERHEAD));
  1006f8:	48 63 03             	movslq (%rbx),%rax
  1006fb:	48 8d 3c c5 17 00 00 	lea    0x17(,%rax,8),%rdi
  100702:	00 
  100703:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
  100707:	cd 3a                	int    $0x3a
  100709:	48 89 05 20 19 00 00 	mov    %rax,0x1920(%rip)        # 102030 <result.0>
  100710:	48 89 43 10          	mov    %rax,0x10(%rbx)
	if (info->ptr_array == (void *)-1) {
  100714:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  100718:	74 72                	je     10078c <heap_info+0xdd>
		sbrk(-ALIGN(info->num_allocs * sizeof(long) + OVERHEAD));
		return -1;
	}

	// we manually fill in array metadata
	PUT(HDRP(info->size_array), PACK(ALIGN(info->num_allocs * sizeof(long) + OVERHEAD), 1));
  10071a:	48 8b 53 08          	mov    0x8(%rbx),%rdx
  10071e:	48 63 03             	movslq (%rbx),%rax
  100721:	48 8d 04 c5 17 00 00 	lea    0x17(,%rax,8),%rax
  100728:	00 
  100729:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  10072d:	48 83 c8 01          	or     $0x1,%rax
  100731:	48 89 42 f8          	mov    %rax,-0x8(%rdx)
	PUT(HDRP(info->ptr_array), PACK(ALIGN(info->num_allocs * sizeof(void *) + OVERHEAD), 1));
  100735:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  100739:	48 63 03             	movslq (%rbx),%rax
  10073c:	48 8d 04 c5 17 00 00 	lea    0x17(,%rax,8),%rax
  100743:	00 
  100744:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100748:	48 83 c8 01          	or     $0x1,%rax
  10074c:	48 89 42 f8          	mov    %rax,-0x8(%rdx)

	// terminal block
	PUT(HDRP(NEXT_BLKP(info->ptr_array)), PACK(0, 1));
  100750:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  100754:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  100758:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  10075c:	48 c7 44 02 f8 01 00 	movq   $0x1,-0x8(%rdx,%rax,1)
  100763:	00 00 

	// collect all the information by traversing through the heap
	void *bp = NEXT_BLKP(prologue_block); // because the prologue isn't actually allocated
  100765:	48 8b 05 b4 18 00 00 	mov    0x18b4(%rip),%rax        # 102020 <prologue_block>
  10076c:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  100770:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100774:	48 01 d0             	add    %rdx,%rax
	size_t arr_index = 0;
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  100777:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  10077b:	48 83 fa 0f          	cmp    $0xf,%rdx
  10077f:	0f 86 84 00 00 00    	jbe    100809 <heap_info+0x15a>
	size_t arr_index = 0;
  100785:	b9 00 00 00 00       	mov    $0x0,%ecx
  10078a:	eb 5a                	jmp    1007e6 <heap_info+0x137>
		sbrk(-ALIGN(info->num_allocs * sizeof(long) + OVERHEAD));
  10078c:	48 63 03             	movslq (%rbx),%rax
  10078f:	48 8d 3c c5 17 00 00 	lea    0x17(,%rax,8),%rdi
  100796:	00 
  100797:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
  10079b:	48 f7 df             	neg    %rdi
  10079e:	cd 3a                	int    $0x3a
  1007a0:	48 89 05 89 18 00 00 	mov    %rax,0x1889(%rip)        # 102030 <result.0>
		return -1;
  1007a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1007ac:	e9 e2 00 00 00       	jmp    100893 <heap_info+0x1e4>
			info->ptr_array[arr_index] = bp;
			info->size_array[arr_index] = GET_SIZE(HDRP(bp));
			arr_index++;
		}
		else {
			info->free_space += GET_SIZE(HDRP(bp));
  1007b1:	83 e2 f0             	and    $0xfffffff0,%edx
  1007b4:	01 53 18             	add    %edx,0x18(%rbx)
			if(GET_SIZE(HDRP(bp)) > (size_t) (info->largest_free_chunk)) {
  1007b7:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1007bb:	48 89 d6             	mov    %rdx,%rsi
  1007be:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  1007c2:	48 63 7b 1c          	movslq 0x1c(%rbx),%rdi
  1007c6:	48 39 f7             	cmp    %rsi,%rdi
  1007c9:	73 06                	jae    1007d1 <heap_info+0x122>
				info->largest_free_chunk = GET_SIZE(HDRP(bp));
  1007cb:	83 e2 f0             	and    $0xfffffff0,%edx
  1007ce:	89 53 1c             	mov    %edx,0x1c(%rbx)
			}
		}

		bp = NEXT_BLKP(bp);
  1007d1:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1007d5:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1007d9:	48 01 d0             	add    %rdx,%rax
	while (GET_SIZE(HDRP(bp))) { // because the terminal block has size 0
  1007dc:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1007e0:	48 83 fa 0f          	cmp    $0xf,%rdx
  1007e4:	76 23                	jbe    100809 <heap_info+0x15a>
		if (GET_ALLOC(HDRP(bp))) {
  1007e6:	f6 c2 01             	test   $0x1,%dl
  1007e9:	74 c6                	je     1007b1 <heap_info+0x102>
			info->ptr_array[arr_index] = bp;
  1007eb:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  1007ef:	48 89 04 ca          	mov    %rax,(%rdx,%rcx,8)
			info->size_array[arr_index] = GET_SIZE(HDRP(bp));
  1007f3:	48 8b 73 08          	mov    0x8(%rbx),%rsi
  1007f7:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1007fb:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1007ff:	48 89 14 ce          	mov    %rdx,(%rsi,%rcx,8)
			arr_index++;
  100803:	48 83 c1 01          	add    $0x1,%rcx
  100807:	eb c8                	jmp    1007d1 <heap_info+0x122>
	}

	app_printf(0xa00, "heap_info print:\n");
  100809:	be 3a 19 10 00       	mov    $0x10193a,%esi
  10080e:	bf 00 0a 00 00       	mov    $0xa00,%edi
  100813:	b8 00 00 00 00       	mov    $0x0,%eax
  100818:	e8 54 f8 ff ff       	call   100071 <app_printf>
	for(int  i = 0 ; i < info->num_allocs; i++){
  10081d:	8b 33                	mov    (%rbx),%esi
  10081f:	85 f6                	test   %esi,%esi
  100821:	7e 35                	jle    100858 <heap_info+0x1a9>
  100823:	41 bc 00 00 00 00    	mov    $0x0,%r12d
		app_printf(0x700, "    ptr: %p, size: 0x%lx\n", info->ptr_array[i], info->size_array[i]);;
  100829:	48 8b 43 08          	mov    0x8(%rbx),%rax
  10082d:	4a 8b 0c e0          	mov    (%rax,%r12,8),%rcx
  100831:	48 8b 43 10          	mov    0x10(%rbx),%rax
  100835:	4a 8b 14 e0          	mov    (%rax,%r12,8),%rdx
  100839:	be 4c 19 10 00       	mov    $0x10194c,%esi
  10083e:	bf 00 07 00 00       	mov    $0x700,%edi
  100843:	b8 00 00 00 00       	mov    $0x0,%eax
  100848:	e8 24 f8 ff ff       	call   100071 <app_printf>
	for(int  i = 0 ; i < info->num_allocs; i++){
  10084d:	8b 33                	mov    (%rbx),%esi
  10084f:	49 83 c4 01          	add    $0x1,%r12
  100853:	44 39 e6             	cmp    %r12d,%esi
  100856:	7f d1                	jg     100829 <heap_info+0x17a>
	}
	// we just need to sort the arrays...
	// we'll use heapsort
	heapsort(info->ptr_array, info->num_allocs);
  100858:	48 63 f6             	movslq %esi,%rsi
  10085b:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
  10085f:	e8 ff fd ff ff       	call   100663 <heapsort>
	for (int i = 0; i < info->num_allocs; i++)
  100864:	83 3b 00             	cmpl   $0x0,(%rbx)
  100867:	7e 36                	jle    10089f <heap_info+0x1f0>
  100869:	b8 00 00 00 00       	mov    $0x0,%eax
		info->size_array[i] = GET_SIZE(HDRP(info->ptr_array[i]));
  10086e:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
  100872:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  100876:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
  10087a:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  10087e:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100882:	48 89 14 c1          	mov    %rdx,(%rcx,%rax,8)
	for (int i = 0; i < info->num_allocs; i++)
  100886:	48 83 c0 01          	add    $0x1,%rax
  10088a:	39 03                	cmp    %eax,(%rbx)
  10088c:	7f e0                	jg     10086e <heap_info+0x1bf>

    return 0;
  10088e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100893:	5b                   	pop    %rbx
  100894:	41 5c                	pop    %r12
  100896:	5d                   	pop    %rbp
  100897:	c3                   	ret    
		return -1;
  100898:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10089d:	eb f4                	jmp    100893 <heap_info+0x1e4>
    return 0;
  10089f:	b8 00 00 00 00       	mov    $0x0,%eax
  1008a4:	eb ed                	jmp    100893 <heap_info+0x1e4>

00000000001008a6 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  1008a6:	55                   	push   %rbp
  1008a7:	48 89 e5             	mov    %rsp,%rbp
  1008aa:	48 83 ec 28          	sub    $0x28,%rsp
  1008ae:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1008b2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1008b6:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1008ba:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1008be:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1008c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1008c6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  1008ca:	eb 1c                	jmp    1008e8 <memcpy+0x42>
        *d = *s;
  1008cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008d0:	0f b6 10             	movzbl (%rax),%edx
  1008d3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1008d7:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1008d9:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1008de:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1008e3:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1008e8:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1008ed:	75 dd                	jne    1008cc <memcpy+0x26>
    }
    return dst;
  1008ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1008f3:	c9                   	leave  
  1008f4:	c3                   	ret    

00000000001008f5 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1008f5:	55                   	push   %rbp
  1008f6:	48 89 e5             	mov    %rsp,%rbp
  1008f9:	48 83 ec 28          	sub    $0x28,%rsp
  1008fd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100901:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100905:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100909:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10090d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  100911:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100915:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100919:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10091d:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  100921:	73 6a                	jae    10098d <memmove+0x98>
  100923:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100927:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10092b:	48 01 d0             	add    %rdx,%rax
  10092e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100932:	73 59                	jae    10098d <memmove+0x98>
        s += n, d += n;
  100934:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100938:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  10093c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100940:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  100944:	eb 17                	jmp    10095d <memmove+0x68>
            *--d = *--s;
  100946:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  10094b:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100950:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100954:	0f b6 10             	movzbl (%rax),%edx
  100957:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10095b:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  10095d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100961:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100965:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100969:	48 85 c0             	test   %rax,%rax
  10096c:	75 d8                	jne    100946 <memmove+0x51>
    if (s < d && s + n > d) {
  10096e:	eb 2e                	jmp    10099e <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100970:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100974:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100978:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10097c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100980:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100984:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100988:	0f b6 12             	movzbl (%rdx),%edx
  10098b:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  10098d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100991:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100995:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100999:	48 85 c0             	test   %rax,%rax
  10099c:	75 d2                	jne    100970 <memmove+0x7b>
        }
    }
    return dst;
  10099e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1009a2:	c9                   	leave  
  1009a3:	c3                   	ret    

00000000001009a4 <memset>:

void* memset(void* v, int c, size_t n) {
  1009a4:	55                   	push   %rbp
  1009a5:	48 89 e5             	mov    %rsp,%rbp
  1009a8:	48 83 ec 28          	sub    $0x28,%rsp
  1009ac:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1009b0:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  1009b3:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1009b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1009bb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1009bf:	eb 15                	jmp    1009d6 <memset+0x32>
        *p = c;
  1009c1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1009c4:	89 c2                	mov    %eax,%edx
  1009c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009ca:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1009cc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1009d1:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1009d6:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1009db:	75 e4                	jne    1009c1 <memset+0x1d>
    }
    return v;
  1009dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1009e1:	c9                   	leave  
  1009e2:	c3                   	ret    

00000000001009e3 <strlen>:

size_t strlen(const char* s) {
  1009e3:	55                   	push   %rbp
  1009e4:	48 89 e5             	mov    %rsp,%rbp
  1009e7:	48 83 ec 18          	sub    $0x18,%rsp
  1009eb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  1009ef:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1009f6:	00 
  1009f7:	eb 0a                	jmp    100a03 <strlen+0x20>
        ++n;
  1009f9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  1009fe:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100a03:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100a07:	0f b6 00             	movzbl (%rax),%eax
  100a0a:	84 c0                	test   %al,%al
  100a0c:	75 eb                	jne    1009f9 <strlen+0x16>
    }
    return n;
  100a0e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100a12:	c9                   	leave  
  100a13:	c3                   	ret    

0000000000100a14 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100a14:	55                   	push   %rbp
  100a15:	48 89 e5             	mov    %rsp,%rbp
  100a18:	48 83 ec 20          	sub    $0x20,%rsp
  100a1c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100a20:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100a24:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100a2b:	00 
  100a2c:	eb 0a                	jmp    100a38 <strnlen+0x24>
        ++n;
  100a2e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100a33:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100a38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a3c:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100a40:	74 0b                	je     100a4d <strnlen+0x39>
  100a42:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100a46:	0f b6 00             	movzbl (%rax),%eax
  100a49:	84 c0                	test   %al,%al
  100a4b:	75 e1                	jne    100a2e <strnlen+0x1a>
    }
    return n;
  100a4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100a51:	c9                   	leave  
  100a52:	c3                   	ret    

0000000000100a53 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100a53:	55                   	push   %rbp
  100a54:	48 89 e5             	mov    %rsp,%rbp
  100a57:	48 83 ec 20          	sub    $0x20,%rsp
  100a5b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100a5f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  100a63:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100a67:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100a6b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100a6f:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100a73:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100a77:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a7b:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100a7f:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100a83:	0f b6 12             	movzbl (%rdx),%edx
  100a86:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100a88:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a8c:	48 83 e8 01          	sub    $0x1,%rax
  100a90:	0f b6 00             	movzbl (%rax),%eax
  100a93:	84 c0                	test   %al,%al
  100a95:	75 d4                	jne    100a6b <strcpy+0x18>
    return dst;
  100a97:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100a9b:	c9                   	leave  
  100a9c:	c3                   	ret    

0000000000100a9d <strcmp>:

int strcmp(const char* a, const char* b) {
  100a9d:	55                   	push   %rbp
  100a9e:	48 89 e5             	mov    %rsp,%rbp
  100aa1:	48 83 ec 10          	sub    $0x10,%rsp
  100aa5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100aa9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100aad:	eb 0a                	jmp    100ab9 <strcmp+0x1c>
        ++a, ++b;
  100aaf:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100ab4:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100ab9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100abd:	0f b6 00             	movzbl (%rax),%eax
  100ac0:	84 c0                	test   %al,%al
  100ac2:	74 1d                	je     100ae1 <strcmp+0x44>
  100ac4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100ac8:	0f b6 00             	movzbl (%rax),%eax
  100acb:	84 c0                	test   %al,%al
  100acd:	74 12                	je     100ae1 <strcmp+0x44>
  100acf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100ad3:	0f b6 10             	movzbl (%rax),%edx
  100ad6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100ada:	0f b6 00             	movzbl (%rax),%eax
  100add:	38 c2                	cmp    %al,%dl
  100adf:	74 ce                	je     100aaf <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100ae1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100ae5:	0f b6 00             	movzbl (%rax),%eax
  100ae8:	89 c2                	mov    %eax,%edx
  100aea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100aee:	0f b6 00             	movzbl (%rax),%eax
  100af1:	38 d0                	cmp    %dl,%al
  100af3:	0f 92 c0             	setb   %al
  100af6:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100af9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100afd:	0f b6 00             	movzbl (%rax),%eax
  100b00:	89 c1                	mov    %eax,%ecx
  100b02:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100b06:	0f b6 00             	movzbl (%rax),%eax
  100b09:	38 c1                	cmp    %al,%cl
  100b0b:	0f 92 c0             	setb   %al
  100b0e:	0f b6 c0             	movzbl %al,%eax
  100b11:	29 c2                	sub    %eax,%edx
  100b13:	89 d0                	mov    %edx,%eax
}
  100b15:	c9                   	leave  
  100b16:	c3                   	ret    

0000000000100b17 <strchr>:

char* strchr(const char* s, int c) {
  100b17:	55                   	push   %rbp
  100b18:	48 89 e5             	mov    %rsp,%rbp
  100b1b:	48 83 ec 10          	sub    $0x10,%rsp
  100b1f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100b23:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100b26:	eb 05                	jmp    100b2d <strchr+0x16>
        ++s;
  100b28:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100b2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b31:	0f b6 00             	movzbl (%rax),%eax
  100b34:	84 c0                	test   %al,%al
  100b36:	74 0e                	je     100b46 <strchr+0x2f>
  100b38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b3c:	0f b6 00             	movzbl (%rax),%eax
  100b3f:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100b42:	38 d0                	cmp    %dl,%al
  100b44:	75 e2                	jne    100b28 <strchr+0x11>
    }
    if (*s == (char) c) {
  100b46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b4a:	0f b6 00             	movzbl (%rax),%eax
  100b4d:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100b50:	38 d0                	cmp    %dl,%al
  100b52:	75 06                	jne    100b5a <strchr+0x43>
        return (char*) s;
  100b54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b58:	eb 05                	jmp    100b5f <strchr+0x48>
    } else {
        return NULL;
  100b5a:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100b5f:	c9                   	leave  
  100b60:	c3                   	ret    

0000000000100b61 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100b61:	55                   	push   %rbp
  100b62:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  100b65:	8b 05 cd 14 00 00    	mov    0x14cd(%rip),%eax        # 102038 <rand_seed_set>
  100b6b:	85 c0                	test   %eax,%eax
  100b6d:	75 0a                	jne    100b79 <rand+0x18>
        srand(819234718U);
  100b6f:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100b74:	e8 24 00 00 00       	call   100b9d <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100b79:	8b 05 bd 14 00 00    	mov    0x14bd(%rip),%eax        # 10203c <rand_seed>
  100b7f:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100b85:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100b8a:	89 05 ac 14 00 00    	mov    %eax,0x14ac(%rip)        # 10203c <rand_seed>
    return rand_seed & RAND_MAX;
  100b90:	8b 05 a6 14 00 00    	mov    0x14a6(%rip),%eax        # 10203c <rand_seed>
  100b96:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100b9b:	5d                   	pop    %rbp
  100b9c:	c3                   	ret    

0000000000100b9d <srand>:

void srand(unsigned seed) {
  100b9d:	55                   	push   %rbp
  100b9e:	48 89 e5             	mov    %rsp,%rbp
  100ba1:	48 83 ec 08          	sub    $0x8,%rsp
  100ba5:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100ba8:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100bab:	89 05 8b 14 00 00    	mov    %eax,0x148b(%rip)        # 10203c <rand_seed>
    rand_seed_set = 1;
  100bb1:	c7 05 7d 14 00 00 01 	movl   $0x1,0x147d(%rip)        # 102038 <rand_seed_set>
  100bb8:	00 00 00 
}
  100bbb:	90                   	nop
  100bbc:	c9                   	leave  
  100bbd:	c3                   	ret    

0000000000100bbe <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100bbe:	55                   	push   %rbp
  100bbf:	48 89 e5             	mov    %rsp,%rbp
  100bc2:	48 83 ec 28          	sub    $0x28,%rsp
  100bc6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100bca:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100bce:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100bd1:	48 c7 45 f8 50 1b 10 	movq   $0x101b50,-0x8(%rbp)
  100bd8:	00 
    if (base < 0) {
  100bd9:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100bdd:	79 0b                	jns    100bea <fill_numbuf+0x2c>
        digits = lower_digits;
  100bdf:	48 c7 45 f8 70 1b 10 	movq   $0x101b70,-0x8(%rbp)
  100be6:	00 
        base = -base;
  100be7:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100bea:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100bef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100bf3:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100bf6:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100bf9:	48 63 c8             	movslq %eax,%rcx
  100bfc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100c00:	ba 00 00 00 00       	mov    $0x0,%edx
  100c05:	48 f7 f1             	div    %rcx
  100c08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c0c:	48 01 d0             	add    %rdx,%rax
  100c0f:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100c14:	0f b6 10             	movzbl (%rax),%edx
  100c17:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100c1b:	88 10                	mov    %dl,(%rax)
        val /= base;
  100c1d:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100c20:	48 63 f0             	movslq %eax,%rsi
  100c23:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100c27:	ba 00 00 00 00       	mov    $0x0,%edx
  100c2c:	48 f7 f6             	div    %rsi
  100c2f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100c33:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100c38:	75 bc                	jne    100bf6 <fill_numbuf+0x38>
    return numbuf_end;
  100c3a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100c3e:	c9                   	leave  
  100c3f:	c3                   	ret    

0000000000100c40 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100c40:	55                   	push   %rbp
  100c41:	48 89 e5             	mov    %rsp,%rbp
  100c44:	53                   	push   %rbx
  100c45:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100c4c:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100c53:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100c59:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100c60:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100c67:	e9 8a 09 00 00       	jmp    1015f6 <printer_vprintf+0x9b6>
        if (*format != '%') {
  100c6c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c73:	0f b6 00             	movzbl (%rax),%eax
  100c76:	3c 25                	cmp    $0x25,%al
  100c78:	74 31                	je     100cab <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  100c7a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100c81:	4c 8b 00             	mov    (%rax),%r8
  100c84:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c8b:	0f b6 00             	movzbl (%rax),%eax
  100c8e:	0f b6 c8             	movzbl %al,%ecx
  100c91:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100c97:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100c9e:	89 ce                	mov    %ecx,%esi
  100ca0:	48 89 c7             	mov    %rax,%rdi
  100ca3:	41 ff d0             	call   *%r8
            continue;
  100ca6:	e9 43 09 00 00       	jmp    1015ee <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100cab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100cb2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100cb9:	01 
  100cba:	eb 44                	jmp    100d00 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  100cbc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100cc3:	0f b6 00             	movzbl (%rax),%eax
  100cc6:	0f be c0             	movsbl %al,%eax
  100cc9:	89 c6                	mov    %eax,%esi
  100ccb:	bf 70 19 10 00       	mov    $0x101970,%edi
  100cd0:	e8 42 fe ff ff       	call   100b17 <strchr>
  100cd5:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100cd9:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100cde:	74 30                	je     100d10 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  100ce0:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100ce4:	48 2d 70 19 10 00    	sub    $0x101970,%rax
  100cea:	ba 01 00 00 00       	mov    $0x1,%edx
  100cef:	89 c1                	mov    %eax,%ecx
  100cf1:	d3 e2                	shl    %cl,%edx
  100cf3:	89 d0                	mov    %edx,%eax
  100cf5:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100cf8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100cff:	01 
  100d00:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d07:	0f b6 00             	movzbl (%rax),%eax
  100d0a:	84 c0                	test   %al,%al
  100d0c:	75 ae                	jne    100cbc <printer_vprintf+0x7c>
  100d0e:	eb 01                	jmp    100d11 <printer_vprintf+0xd1>
            } else {
                break;
  100d10:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100d11:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100d18:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d1f:	0f b6 00             	movzbl (%rax),%eax
  100d22:	3c 30                	cmp    $0x30,%al
  100d24:	7e 67                	jle    100d8d <printer_vprintf+0x14d>
  100d26:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d2d:	0f b6 00             	movzbl (%rax),%eax
  100d30:	3c 39                	cmp    $0x39,%al
  100d32:	7f 59                	jg     100d8d <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100d34:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100d3b:	eb 2e                	jmp    100d6b <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100d3d:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100d40:	89 d0                	mov    %edx,%eax
  100d42:	c1 e0 02             	shl    $0x2,%eax
  100d45:	01 d0                	add    %edx,%eax
  100d47:	01 c0                	add    %eax,%eax
  100d49:	89 c1                	mov    %eax,%ecx
  100d4b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d52:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100d56:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100d5d:	0f b6 00             	movzbl (%rax),%eax
  100d60:	0f be c0             	movsbl %al,%eax
  100d63:	01 c8                	add    %ecx,%eax
  100d65:	83 e8 30             	sub    $0x30,%eax
  100d68:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100d6b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d72:	0f b6 00             	movzbl (%rax),%eax
  100d75:	3c 2f                	cmp    $0x2f,%al
  100d77:	0f 8e 85 00 00 00    	jle    100e02 <printer_vprintf+0x1c2>
  100d7d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d84:	0f b6 00             	movzbl (%rax),%eax
  100d87:	3c 39                	cmp    $0x39,%al
  100d89:	7e b2                	jle    100d3d <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100d8b:	eb 75                	jmp    100e02 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100d8d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d94:	0f b6 00             	movzbl (%rax),%eax
  100d97:	3c 2a                	cmp    $0x2a,%al
  100d99:	75 68                	jne    100e03 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100d9b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100da2:	8b 00                	mov    (%rax),%eax
  100da4:	83 f8 2f             	cmp    $0x2f,%eax
  100da7:	77 30                	ja     100dd9 <printer_vprintf+0x199>
  100da9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100db0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100db4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dbb:	8b 00                	mov    (%rax),%eax
  100dbd:	89 c0                	mov    %eax,%eax
  100dbf:	48 01 d0             	add    %rdx,%rax
  100dc2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dc9:	8b 12                	mov    (%rdx),%edx
  100dcb:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100dce:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dd5:	89 0a                	mov    %ecx,(%rdx)
  100dd7:	eb 1a                	jmp    100df3 <printer_vprintf+0x1b3>
  100dd9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100de0:	48 8b 40 08          	mov    0x8(%rax),%rax
  100de4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100de8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100def:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100df3:	8b 00                	mov    (%rax),%eax
  100df5:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100df8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100dff:	01 
  100e00:	eb 01                	jmp    100e03 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100e02:	90                   	nop
        }

        // process precision
        int precision = -1;
  100e03:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100e0a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e11:	0f b6 00             	movzbl (%rax),%eax
  100e14:	3c 2e                	cmp    $0x2e,%al
  100e16:	0f 85 00 01 00 00    	jne    100f1c <printer_vprintf+0x2dc>
            ++format;
  100e1c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100e23:	01 
            if (*format >= '0' && *format <= '9') {
  100e24:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e2b:	0f b6 00             	movzbl (%rax),%eax
  100e2e:	3c 2f                	cmp    $0x2f,%al
  100e30:	7e 67                	jle    100e99 <printer_vprintf+0x259>
  100e32:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e39:	0f b6 00             	movzbl (%rax),%eax
  100e3c:	3c 39                	cmp    $0x39,%al
  100e3e:	7f 59                	jg     100e99 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100e40:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100e47:	eb 2e                	jmp    100e77 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100e49:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100e4c:	89 d0                	mov    %edx,%eax
  100e4e:	c1 e0 02             	shl    $0x2,%eax
  100e51:	01 d0                	add    %edx,%eax
  100e53:	01 c0                	add    %eax,%eax
  100e55:	89 c1                	mov    %eax,%ecx
  100e57:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e5e:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100e62:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100e69:	0f b6 00             	movzbl (%rax),%eax
  100e6c:	0f be c0             	movsbl %al,%eax
  100e6f:	01 c8                	add    %ecx,%eax
  100e71:	83 e8 30             	sub    $0x30,%eax
  100e74:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100e77:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e7e:	0f b6 00             	movzbl (%rax),%eax
  100e81:	3c 2f                	cmp    $0x2f,%al
  100e83:	0f 8e 85 00 00 00    	jle    100f0e <printer_vprintf+0x2ce>
  100e89:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e90:	0f b6 00             	movzbl (%rax),%eax
  100e93:	3c 39                	cmp    $0x39,%al
  100e95:	7e b2                	jle    100e49 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100e97:	eb 75                	jmp    100f0e <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100e99:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ea0:	0f b6 00             	movzbl (%rax),%eax
  100ea3:	3c 2a                	cmp    $0x2a,%al
  100ea5:	75 68                	jne    100f0f <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100ea7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100eae:	8b 00                	mov    (%rax),%eax
  100eb0:	83 f8 2f             	cmp    $0x2f,%eax
  100eb3:	77 30                	ja     100ee5 <printer_vprintf+0x2a5>
  100eb5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ebc:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ec0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ec7:	8b 00                	mov    (%rax),%eax
  100ec9:	89 c0                	mov    %eax,%eax
  100ecb:	48 01 d0             	add    %rdx,%rax
  100ece:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ed5:	8b 12                	mov    (%rdx),%edx
  100ed7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100eda:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ee1:	89 0a                	mov    %ecx,(%rdx)
  100ee3:	eb 1a                	jmp    100eff <printer_vprintf+0x2bf>
  100ee5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100eec:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ef0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ef4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100efb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100eff:	8b 00                	mov    (%rax),%eax
  100f01:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100f04:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100f0b:	01 
  100f0c:	eb 01                	jmp    100f0f <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100f0e:	90                   	nop
            }
            if (precision < 0) {
  100f0f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100f13:	79 07                	jns    100f1c <printer_vprintf+0x2dc>
                precision = 0;
  100f15:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100f1c:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100f23:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100f2a:	00 
        int length = 0;
  100f2b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100f32:	48 c7 45 c8 76 19 10 	movq   $0x101976,-0x38(%rbp)
  100f39:	00 
    again:
        switch (*format) {
  100f3a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f41:	0f b6 00             	movzbl (%rax),%eax
  100f44:	0f be c0             	movsbl %al,%eax
  100f47:	83 e8 43             	sub    $0x43,%eax
  100f4a:	83 f8 37             	cmp    $0x37,%eax
  100f4d:	0f 87 9f 03 00 00    	ja     1012f2 <printer_vprintf+0x6b2>
  100f53:	89 c0                	mov    %eax,%eax
  100f55:	48 8b 04 c5 88 19 10 	mov    0x101988(,%rax,8),%rax
  100f5c:	00 
  100f5d:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100f5f:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100f66:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100f6d:	01 
            goto again;
  100f6e:	eb ca                	jmp    100f3a <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100f70:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100f74:	74 5d                	je     100fd3 <printer_vprintf+0x393>
  100f76:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f7d:	8b 00                	mov    (%rax),%eax
  100f7f:	83 f8 2f             	cmp    $0x2f,%eax
  100f82:	77 30                	ja     100fb4 <printer_vprintf+0x374>
  100f84:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f8b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100f8f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f96:	8b 00                	mov    (%rax),%eax
  100f98:	89 c0                	mov    %eax,%eax
  100f9a:	48 01 d0             	add    %rdx,%rax
  100f9d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fa4:	8b 12                	mov    (%rdx),%edx
  100fa6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100fa9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fb0:	89 0a                	mov    %ecx,(%rdx)
  100fb2:	eb 1a                	jmp    100fce <printer_vprintf+0x38e>
  100fb4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fbb:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fbf:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100fc3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fca:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100fce:	48 8b 00             	mov    (%rax),%rax
  100fd1:	eb 5c                	jmp    10102f <printer_vprintf+0x3ef>
  100fd3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fda:	8b 00                	mov    (%rax),%eax
  100fdc:	83 f8 2f             	cmp    $0x2f,%eax
  100fdf:	77 30                	ja     101011 <printer_vprintf+0x3d1>
  100fe1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fe8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100fec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ff3:	8b 00                	mov    (%rax),%eax
  100ff5:	89 c0                	mov    %eax,%eax
  100ff7:	48 01 d0             	add    %rdx,%rax
  100ffa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101001:	8b 12                	mov    (%rdx),%edx
  101003:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101006:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10100d:	89 0a                	mov    %ecx,(%rdx)
  10100f:	eb 1a                	jmp    10102b <printer_vprintf+0x3eb>
  101011:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101018:	48 8b 40 08          	mov    0x8(%rax),%rax
  10101c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101020:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101027:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10102b:	8b 00                	mov    (%rax),%eax
  10102d:	48 98                	cltq   
  10102f:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  101033:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101037:	48 c1 f8 38          	sar    $0x38,%rax
  10103b:	25 80 00 00 00       	and    $0x80,%eax
  101040:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  101043:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  101047:	74 09                	je     101052 <printer_vprintf+0x412>
  101049:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10104d:	48 f7 d8             	neg    %rax
  101050:	eb 04                	jmp    101056 <printer_vprintf+0x416>
  101052:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101056:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  10105a:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  10105d:	83 c8 60             	or     $0x60,%eax
  101060:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  101063:	e9 cf 02 00 00       	jmp    101337 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  101068:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  10106c:	74 5d                	je     1010cb <printer_vprintf+0x48b>
  10106e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101075:	8b 00                	mov    (%rax),%eax
  101077:	83 f8 2f             	cmp    $0x2f,%eax
  10107a:	77 30                	ja     1010ac <printer_vprintf+0x46c>
  10107c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101083:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101087:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10108e:	8b 00                	mov    (%rax),%eax
  101090:	89 c0                	mov    %eax,%eax
  101092:	48 01 d0             	add    %rdx,%rax
  101095:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10109c:	8b 12                	mov    (%rdx),%edx
  10109e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1010a1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010a8:	89 0a                	mov    %ecx,(%rdx)
  1010aa:	eb 1a                	jmp    1010c6 <printer_vprintf+0x486>
  1010ac:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010b3:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010b7:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1010bb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010c2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1010c6:	48 8b 00             	mov    (%rax),%rax
  1010c9:	eb 5c                	jmp    101127 <printer_vprintf+0x4e7>
  1010cb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010d2:	8b 00                	mov    (%rax),%eax
  1010d4:	83 f8 2f             	cmp    $0x2f,%eax
  1010d7:	77 30                	ja     101109 <printer_vprintf+0x4c9>
  1010d9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010e0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1010e4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010eb:	8b 00                	mov    (%rax),%eax
  1010ed:	89 c0                	mov    %eax,%eax
  1010ef:	48 01 d0             	add    %rdx,%rax
  1010f2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010f9:	8b 12                	mov    (%rdx),%edx
  1010fb:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1010fe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101105:	89 0a                	mov    %ecx,(%rdx)
  101107:	eb 1a                	jmp    101123 <printer_vprintf+0x4e3>
  101109:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101110:	48 8b 40 08          	mov    0x8(%rax),%rax
  101114:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101118:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10111f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101123:	8b 00                	mov    (%rax),%eax
  101125:	89 c0                	mov    %eax,%eax
  101127:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  10112b:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  10112f:	e9 03 02 00 00       	jmp    101337 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  101134:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  10113b:	e9 28 ff ff ff       	jmp    101068 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  101140:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  101147:	e9 1c ff ff ff       	jmp    101068 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  10114c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101153:	8b 00                	mov    (%rax),%eax
  101155:	83 f8 2f             	cmp    $0x2f,%eax
  101158:	77 30                	ja     10118a <printer_vprintf+0x54a>
  10115a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101161:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101165:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10116c:	8b 00                	mov    (%rax),%eax
  10116e:	89 c0                	mov    %eax,%eax
  101170:	48 01 d0             	add    %rdx,%rax
  101173:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10117a:	8b 12                	mov    (%rdx),%edx
  10117c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10117f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101186:	89 0a                	mov    %ecx,(%rdx)
  101188:	eb 1a                	jmp    1011a4 <printer_vprintf+0x564>
  10118a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101191:	48 8b 40 08          	mov    0x8(%rax),%rax
  101195:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101199:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011a0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1011a4:	48 8b 00             	mov    (%rax),%rax
  1011a7:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  1011ab:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  1011b2:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  1011b9:	e9 79 01 00 00       	jmp    101337 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  1011be:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011c5:	8b 00                	mov    (%rax),%eax
  1011c7:	83 f8 2f             	cmp    $0x2f,%eax
  1011ca:	77 30                	ja     1011fc <printer_vprintf+0x5bc>
  1011cc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011d3:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1011d7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011de:	8b 00                	mov    (%rax),%eax
  1011e0:	89 c0                	mov    %eax,%eax
  1011e2:	48 01 d0             	add    %rdx,%rax
  1011e5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011ec:	8b 12                	mov    (%rdx),%edx
  1011ee:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1011f1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011f8:	89 0a                	mov    %ecx,(%rdx)
  1011fa:	eb 1a                	jmp    101216 <printer_vprintf+0x5d6>
  1011fc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101203:	48 8b 40 08          	mov    0x8(%rax),%rax
  101207:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10120b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101212:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101216:	48 8b 00             	mov    (%rax),%rax
  101219:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  10121d:	e9 15 01 00 00       	jmp    101337 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  101222:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101229:	8b 00                	mov    (%rax),%eax
  10122b:	83 f8 2f             	cmp    $0x2f,%eax
  10122e:	77 30                	ja     101260 <printer_vprintf+0x620>
  101230:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101237:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10123b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101242:	8b 00                	mov    (%rax),%eax
  101244:	89 c0                	mov    %eax,%eax
  101246:	48 01 d0             	add    %rdx,%rax
  101249:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101250:	8b 12                	mov    (%rdx),%edx
  101252:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101255:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10125c:	89 0a                	mov    %ecx,(%rdx)
  10125e:	eb 1a                	jmp    10127a <printer_vprintf+0x63a>
  101260:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101267:	48 8b 40 08          	mov    0x8(%rax),%rax
  10126b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10126f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101276:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10127a:	8b 00                	mov    (%rax),%eax
  10127c:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  101282:	e9 67 03 00 00       	jmp    1015ee <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  101287:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  10128b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  10128f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101296:	8b 00                	mov    (%rax),%eax
  101298:	83 f8 2f             	cmp    $0x2f,%eax
  10129b:	77 30                	ja     1012cd <printer_vprintf+0x68d>
  10129d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012a4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1012a8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012af:	8b 00                	mov    (%rax),%eax
  1012b1:	89 c0                	mov    %eax,%eax
  1012b3:	48 01 d0             	add    %rdx,%rax
  1012b6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012bd:	8b 12                	mov    (%rdx),%edx
  1012bf:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1012c2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012c9:	89 0a                	mov    %ecx,(%rdx)
  1012cb:	eb 1a                	jmp    1012e7 <printer_vprintf+0x6a7>
  1012cd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012d4:	48 8b 40 08          	mov    0x8(%rax),%rax
  1012d8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1012dc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012e3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1012e7:	8b 00                	mov    (%rax),%eax
  1012e9:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  1012ec:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  1012f0:	eb 45                	jmp    101337 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  1012f2:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1012f6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  1012fa:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101301:	0f b6 00             	movzbl (%rax),%eax
  101304:	84 c0                	test   %al,%al
  101306:	74 0c                	je     101314 <printer_vprintf+0x6d4>
  101308:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10130f:	0f b6 00             	movzbl (%rax),%eax
  101312:	eb 05                	jmp    101319 <printer_vprintf+0x6d9>
  101314:	b8 25 00 00 00       	mov    $0x25,%eax
  101319:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  10131c:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  101320:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101327:	0f b6 00             	movzbl (%rax),%eax
  10132a:	84 c0                	test   %al,%al
  10132c:	75 08                	jne    101336 <printer_vprintf+0x6f6>
                format--;
  10132e:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  101335:	01 
            }
            break;
  101336:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  101337:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10133a:	83 e0 20             	and    $0x20,%eax
  10133d:	85 c0                	test   %eax,%eax
  10133f:	74 1e                	je     10135f <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  101341:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101345:	48 83 c0 18          	add    $0x18,%rax
  101349:	8b 55 e0             	mov    -0x20(%rbp),%edx
  10134c:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101350:	48 89 ce             	mov    %rcx,%rsi
  101353:	48 89 c7             	mov    %rax,%rdi
  101356:	e8 63 f8 ff ff       	call   100bbe <fill_numbuf>
  10135b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  10135f:	48 c7 45 c0 76 19 10 	movq   $0x101976,-0x40(%rbp)
  101366:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  101367:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10136a:	83 e0 20             	and    $0x20,%eax
  10136d:	85 c0                	test   %eax,%eax
  10136f:	74 48                	je     1013b9 <printer_vprintf+0x779>
  101371:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101374:	83 e0 40             	and    $0x40,%eax
  101377:	85 c0                	test   %eax,%eax
  101379:	74 3e                	je     1013b9 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  10137b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10137e:	25 80 00 00 00       	and    $0x80,%eax
  101383:	85 c0                	test   %eax,%eax
  101385:	74 0a                	je     101391 <printer_vprintf+0x751>
                prefix = "-";
  101387:	48 c7 45 c0 77 19 10 	movq   $0x101977,-0x40(%rbp)
  10138e:	00 
            if (flags & FLAG_NEGATIVE) {
  10138f:	eb 73                	jmp    101404 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  101391:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101394:	83 e0 10             	and    $0x10,%eax
  101397:	85 c0                	test   %eax,%eax
  101399:	74 0a                	je     1013a5 <printer_vprintf+0x765>
                prefix = "+";
  10139b:	48 c7 45 c0 79 19 10 	movq   $0x101979,-0x40(%rbp)
  1013a2:	00 
            if (flags & FLAG_NEGATIVE) {
  1013a3:	eb 5f                	jmp    101404 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  1013a5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1013a8:	83 e0 08             	and    $0x8,%eax
  1013ab:	85 c0                	test   %eax,%eax
  1013ad:	74 55                	je     101404 <printer_vprintf+0x7c4>
                prefix = " ";
  1013af:	48 c7 45 c0 7b 19 10 	movq   $0x10197b,-0x40(%rbp)
  1013b6:	00 
            if (flags & FLAG_NEGATIVE) {
  1013b7:	eb 4b                	jmp    101404 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1013b9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1013bc:	83 e0 20             	and    $0x20,%eax
  1013bf:	85 c0                	test   %eax,%eax
  1013c1:	74 42                	je     101405 <printer_vprintf+0x7c5>
  1013c3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1013c6:	83 e0 01             	and    $0x1,%eax
  1013c9:	85 c0                	test   %eax,%eax
  1013cb:	74 38                	je     101405 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  1013cd:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  1013d1:	74 06                	je     1013d9 <printer_vprintf+0x799>
  1013d3:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1013d7:	75 2c                	jne    101405 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  1013d9:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1013de:	75 0c                	jne    1013ec <printer_vprintf+0x7ac>
  1013e0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1013e3:	25 00 01 00 00       	and    $0x100,%eax
  1013e8:	85 c0                	test   %eax,%eax
  1013ea:	74 19                	je     101405 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  1013ec:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1013f0:	75 07                	jne    1013f9 <printer_vprintf+0x7b9>
  1013f2:	b8 7d 19 10 00       	mov    $0x10197d,%eax
  1013f7:	eb 05                	jmp    1013fe <printer_vprintf+0x7be>
  1013f9:	b8 80 19 10 00       	mov    $0x101980,%eax
  1013fe:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101402:	eb 01                	jmp    101405 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  101404:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  101405:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101409:	78 24                	js     10142f <printer_vprintf+0x7ef>
  10140b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10140e:	83 e0 20             	and    $0x20,%eax
  101411:	85 c0                	test   %eax,%eax
  101413:	75 1a                	jne    10142f <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  101415:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101418:	48 63 d0             	movslq %eax,%rdx
  10141b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  10141f:	48 89 d6             	mov    %rdx,%rsi
  101422:	48 89 c7             	mov    %rax,%rdi
  101425:	e8 ea f5 ff ff       	call   100a14 <strnlen>
  10142a:	89 45 bc             	mov    %eax,-0x44(%rbp)
  10142d:	eb 0f                	jmp    10143e <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  10142f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101433:	48 89 c7             	mov    %rax,%rdi
  101436:	e8 a8 f5 ff ff       	call   1009e3 <strlen>
  10143b:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  10143e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101441:	83 e0 20             	and    $0x20,%eax
  101444:	85 c0                	test   %eax,%eax
  101446:	74 20                	je     101468 <printer_vprintf+0x828>
  101448:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  10144c:	78 1a                	js     101468 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  10144e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101451:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  101454:	7e 08                	jle    10145e <printer_vprintf+0x81e>
  101456:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101459:	2b 45 bc             	sub    -0x44(%rbp),%eax
  10145c:	eb 05                	jmp    101463 <printer_vprintf+0x823>
  10145e:	b8 00 00 00 00       	mov    $0x0,%eax
  101463:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101466:	eb 5c                	jmp    1014c4 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  101468:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10146b:	83 e0 20             	and    $0x20,%eax
  10146e:	85 c0                	test   %eax,%eax
  101470:	74 4b                	je     1014bd <printer_vprintf+0x87d>
  101472:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101475:	83 e0 02             	and    $0x2,%eax
  101478:	85 c0                	test   %eax,%eax
  10147a:	74 41                	je     1014bd <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  10147c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10147f:	83 e0 04             	and    $0x4,%eax
  101482:	85 c0                	test   %eax,%eax
  101484:	75 37                	jne    1014bd <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  101486:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10148a:	48 89 c7             	mov    %rax,%rdi
  10148d:	e8 51 f5 ff ff       	call   1009e3 <strlen>
  101492:	89 c2                	mov    %eax,%edx
  101494:	8b 45 bc             	mov    -0x44(%rbp),%eax
  101497:	01 d0                	add    %edx,%eax
  101499:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  10149c:	7e 1f                	jle    1014bd <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  10149e:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1014a1:	2b 45 bc             	sub    -0x44(%rbp),%eax
  1014a4:	89 c3                	mov    %eax,%ebx
  1014a6:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1014aa:	48 89 c7             	mov    %rax,%rdi
  1014ad:	e8 31 f5 ff ff       	call   1009e3 <strlen>
  1014b2:	89 c2                	mov    %eax,%edx
  1014b4:	89 d8                	mov    %ebx,%eax
  1014b6:	29 d0                	sub    %edx,%eax
  1014b8:	89 45 b8             	mov    %eax,-0x48(%rbp)
  1014bb:	eb 07                	jmp    1014c4 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  1014bd:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  1014c4:	8b 55 bc             	mov    -0x44(%rbp),%edx
  1014c7:	8b 45 b8             	mov    -0x48(%rbp),%eax
  1014ca:	01 d0                	add    %edx,%eax
  1014cc:	48 63 d8             	movslq %eax,%rbx
  1014cf:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1014d3:	48 89 c7             	mov    %rax,%rdi
  1014d6:	e8 08 f5 ff ff       	call   1009e3 <strlen>
  1014db:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  1014df:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1014e2:	29 d0                	sub    %edx,%eax
  1014e4:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1014e7:	eb 25                	jmp    10150e <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  1014e9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1014f0:	48 8b 08             	mov    (%rax),%rcx
  1014f3:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1014f9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101500:	be 20 00 00 00       	mov    $0x20,%esi
  101505:	48 89 c7             	mov    %rax,%rdi
  101508:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10150a:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  10150e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101511:	83 e0 04             	and    $0x4,%eax
  101514:	85 c0                	test   %eax,%eax
  101516:	75 36                	jne    10154e <printer_vprintf+0x90e>
  101518:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  10151c:	7f cb                	jg     1014e9 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  10151e:	eb 2e                	jmp    10154e <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  101520:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101527:	4c 8b 00             	mov    (%rax),%r8
  10152a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10152e:	0f b6 00             	movzbl (%rax),%eax
  101531:	0f b6 c8             	movzbl %al,%ecx
  101534:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10153a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101541:	89 ce                	mov    %ecx,%esi
  101543:	48 89 c7             	mov    %rax,%rdi
  101546:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  101549:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  10154e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101552:	0f b6 00             	movzbl (%rax),%eax
  101555:	84 c0                	test   %al,%al
  101557:	75 c7                	jne    101520 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  101559:	eb 25                	jmp    101580 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  10155b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101562:	48 8b 08             	mov    (%rax),%rcx
  101565:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10156b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101572:	be 30 00 00 00       	mov    $0x30,%esi
  101577:	48 89 c7             	mov    %rax,%rdi
  10157a:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  10157c:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  101580:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  101584:	7f d5                	jg     10155b <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  101586:	eb 32                	jmp    1015ba <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  101588:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10158f:	4c 8b 00             	mov    (%rax),%r8
  101592:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101596:	0f b6 00             	movzbl (%rax),%eax
  101599:	0f b6 c8             	movzbl %al,%ecx
  10159c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1015a2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1015a9:	89 ce                	mov    %ecx,%esi
  1015ab:	48 89 c7             	mov    %rax,%rdi
  1015ae:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  1015b1:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  1015b6:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  1015ba:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  1015be:	7f c8                	jg     101588 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  1015c0:	eb 25                	jmp    1015e7 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  1015c2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1015c9:	48 8b 08             	mov    (%rax),%rcx
  1015cc:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1015d2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1015d9:	be 20 00 00 00       	mov    $0x20,%esi
  1015de:	48 89 c7             	mov    %rax,%rdi
  1015e1:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  1015e3:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1015e7:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1015eb:	7f d5                	jg     1015c2 <printer_vprintf+0x982>
        }
    done: ;
  1015ed:	90                   	nop
    for (; *format; ++format) {
  1015ee:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1015f5:	01 
  1015f6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1015fd:	0f b6 00             	movzbl (%rax),%eax
  101600:	84 c0                	test   %al,%al
  101602:	0f 85 64 f6 ff ff    	jne    100c6c <printer_vprintf+0x2c>
    }
}
  101608:	90                   	nop
  101609:	90                   	nop
  10160a:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  10160e:	c9                   	leave  
  10160f:	c3                   	ret    

0000000000101610 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  101610:	55                   	push   %rbp
  101611:	48 89 e5             	mov    %rsp,%rbp
  101614:	48 83 ec 20          	sub    $0x20,%rsp
  101618:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10161c:	89 f0                	mov    %esi,%eax
  10161e:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101621:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  101624:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101628:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10162c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101630:	48 8b 40 08          	mov    0x8(%rax),%rax
  101634:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  101639:	48 39 d0             	cmp    %rdx,%rax
  10163c:	72 0c                	jb     10164a <console_putc+0x3a>
        cp->cursor = console;
  10163e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101642:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  101649:	00 
    }
    if (c == '\n') {
  10164a:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  10164e:	75 78                	jne    1016c8 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  101650:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101654:	48 8b 40 08          	mov    0x8(%rax),%rax
  101658:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  10165e:	48 d1 f8             	sar    %rax
  101661:	48 89 c1             	mov    %rax,%rcx
  101664:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  10166b:	66 66 66 
  10166e:	48 89 c8             	mov    %rcx,%rax
  101671:	48 f7 ea             	imul   %rdx
  101674:	48 c1 fa 05          	sar    $0x5,%rdx
  101678:	48 89 c8             	mov    %rcx,%rax
  10167b:	48 c1 f8 3f          	sar    $0x3f,%rax
  10167f:	48 29 c2             	sub    %rax,%rdx
  101682:	48 89 d0             	mov    %rdx,%rax
  101685:	48 c1 e0 02          	shl    $0x2,%rax
  101689:	48 01 d0             	add    %rdx,%rax
  10168c:	48 c1 e0 04          	shl    $0x4,%rax
  101690:	48 29 c1             	sub    %rax,%rcx
  101693:	48 89 ca             	mov    %rcx,%rdx
  101696:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101699:	eb 25                	jmp    1016c0 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  10169b:	8b 45 e0             	mov    -0x20(%rbp),%eax
  10169e:	83 c8 20             	or     $0x20,%eax
  1016a1:	89 c6                	mov    %eax,%esi
  1016a3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1016a7:	48 8b 40 08          	mov    0x8(%rax),%rax
  1016ab:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1016af:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1016b3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1016b7:	89 f2                	mov    %esi,%edx
  1016b9:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  1016bc:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1016c0:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  1016c4:	75 d5                	jne    10169b <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  1016c6:	eb 24                	jmp    1016ec <console_putc+0xdc>
        *cp->cursor++ = c | color;
  1016c8:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  1016cc:	8b 55 e0             	mov    -0x20(%rbp),%edx
  1016cf:	09 d0                	or     %edx,%eax
  1016d1:	89 c6                	mov    %eax,%esi
  1016d3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1016d7:	48 8b 40 08          	mov    0x8(%rax),%rax
  1016db:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1016df:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1016e3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1016e7:	89 f2                	mov    %esi,%edx
  1016e9:	66 89 10             	mov    %dx,(%rax)
}
  1016ec:	90                   	nop
  1016ed:	c9                   	leave  
  1016ee:	c3                   	ret    

00000000001016ef <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1016ef:	55                   	push   %rbp
  1016f0:	48 89 e5             	mov    %rsp,%rbp
  1016f3:	48 83 ec 30          	sub    $0x30,%rsp
  1016f7:	89 7d ec             	mov    %edi,-0x14(%rbp)
  1016fa:	89 75 e8             	mov    %esi,-0x18(%rbp)
  1016fd:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101701:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  101705:	48 c7 45 f0 10 16 10 	movq   $0x101610,-0x10(%rbp)
  10170c:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10170d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  101711:	78 09                	js     10171c <console_vprintf+0x2d>
  101713:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  10171a:	7e 07                	jle    101723 <console_vprintf+0x34>
        cpos = 0;
  10171c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  101723:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101726:	48 98                	cltq   
  101728:	48 01 c0             	add    %rax,%rax
  10172b:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  101731:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101735:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101739:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  10173d:	8b 75 e8             	mov    -0x18(%rbp),%esi
  101740:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101744:	48 89 c7             	mov    %rax,%rdi
  101747:	e8 f4 f4 ff ff       	call   100c40 <printer_vprintf>
    return cp.cursor - console;
  10174c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101750:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  101756:	48 d1 f8             	sar    %rax
}
  101759:	c9                   	leave  
  10175a:	c3                   	ret    

000000000010175b <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  10175b:	55                   	push   %rbp
  10175c:	48 89 e5             	mov    %rsp,%rbp
  10175f:	48 83 ec 60          	sub    $0x60,%rsp
  101763:	89 7d ac             	mov    %edi,-0x54(%rbp)
  101766:	89 75 a8             	mov    %esi,-0x58(%rbp)
  101769:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  10176d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101771:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101775:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101779:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101780:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101784:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101788:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10178c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101790:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101794:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101798:	8b 75 a8             	mov    -0x58(%rbp),%esi
  10179b:	8b 45 ac             	mov    -0x54(%rbp),%eax
  10179e:	89 c7                	mov    %eax,%edi
  1017a0:	e8 4a ff ff ff       	call   1016ef <console_vprintf>
  1017a5:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  1017a8:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  1017ab:	c9                   	leave  
  1017ac:	c3                   	ret    

00000000001017ad <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  1017ad:	55                   	push   %rbp
  1017ae:	48 89 e5             	mov    %rsp,%rbp
  1017b1:	48 83 ec 20          	sub    $0x20,%rsp
  1017b5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1017b9:	89 f0                	mov    %esi,%eax
  1017bb:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1017be:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  1017c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1017c5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  1017c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1017cd:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1017d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1017d5:	48 8b 40 10          	mov    0x10(%rax),%rax
  1017d9:	48 39 c2             	cmp    %rax,%rdx
  1017dc:	73 1a                	jae    1017f8 <string_putc+0x4b>
        *sp->s++ = c;
  1017de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1017e2:	48 8b 40 08          	mov    0x8(%rax),%rax
  1017e6:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1017ea:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1017ee:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1017f2:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1017f6:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1017f8:	90                   	nop
  1017f9:	c9                   	leave  
  1017fa:	c3                   	ret    

00000000001017fb <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1017fb:	55                   	push   %rbp
  1017fc:	48 89 e5             	mov    %rsp,%rbp
  1017ff:	48 83 ec 40          	sub    $0x40,%rsp
  101803:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101807:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  10180b:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  10180f:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101813:	48 c7 45 e8 ad 17 10 	movq   $0x1017ad,-0x18(%rbp)
  10181a:	00 
    sp.s = s;
  10181b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10181f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  101823:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  101828:	74 33                	je     10185d <vsnprintf+0x62>
        sp.end = s + size - 1;
  10182a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  10182e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101832:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101836:	48 01 d0             	add    %rdx,%rax
  101839:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  10183d:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101841:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101845:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101849:	be 00 00 00 00       	mov    $0x0,%esi
  10184e:	48 89 c7             	mov    %rax,%rdi
  101851:	e8 ea f3 ff ff       	call   100c40 <printer_vprintf>
        *sp.s = 0;
  101856:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10185a:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  10185d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101861:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  101865:	c9                   	leave  
  101866:	c3                   	ret    

0000000000101867 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  101867:	55                   	push   %rbp
  101868:	48 89 e5             	mov    %rsp,%rbp
  10186b:	48 83 ec 70          	sub    $0x70,%rsp
  10186f:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101873:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  101877:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  10187b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10187f:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101883:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101887:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  10188e:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101892:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101896:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10189a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  10189e:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  1018a2:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  1018a6:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  1018aa:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1018ae:	48 89 c7             	mov    %rax,%rdi
  1018b1:	e8 45 ff ff ff       	call   1017fb <vsnprintf>
  1018b6:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  1018b9:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  1018bc:	c9                   	leave  
  1018bd:	c3                   	ret    

00000000001018be <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  1018be:	55                   	push   %rbp
  1018bf:	48 89 e5             	mov    %rsp,%rbp
  1018c2:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1018c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  1018cd:	eb 13                	jmp    1018e2 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  1018cf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1018d2:	48 98                	cltq   
  1018d4:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  1018db:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1018de:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1018e2:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1018e9:	7e e4                	jle    1018cf <console_clear+0x11>
    }
    cursorpos = 0;
  1018eb:	c7 05 07 77 fb ff 00 	movl   $0x0,-0x488f9(%rip)        # b8ffc <cursorpos>
  1018f2:	00 00 00 
}
  1018f5:	90                   	nop
  1018f6:	c9                   	leave  
  1018f7:	c3                   	ret    
