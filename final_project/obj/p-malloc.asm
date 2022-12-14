
obj/p-malloc.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	41 55                	push   %r13
  100006:	41 54                	push   %r12
  100008:	53                   	push   %rbx
  100009:	48 83 ec 08          	sub    $0x8,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  10000d:	cd 31                	int    $0x31
  10000f:	41 89 c4             	mov    %eax,%r12d
    pid_t p = getpid();

    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100012:	b8 2f 30 10 00       	mov    $0x10302f,%eax
  100017:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10001d:	48 89 05 e4 1f 00 00 	mov    %rax,0x1fe4(%rip)        # 102008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100024:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100027:	48 83 e8 01          	sub    $0x1,%rax
  10002b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100031:	48 89 05 c8 1f 00 00 	mov    %rax,0x1fc8(%rip)        # 102000 <stack_bottom>

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    int ct = 0;
  100038:	bb 00 00 00 00       	mov    $0x0,%ebx
  10003d:	eb 02                	jmp    100041 <process_main+0x41>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  10003f:	cd 32                	int    $0x32
    while (1) {
	if ((rand() % ALLOC_SLOWDOWN) < p) {
  100041:	e8 fb 08 00 00       	call   100941 <rand>
  100046:	48 63 d0             	movslq %eax,%rdx
  100049:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  100050:	48 c1 fa 25          	sar    $0x25,%rdx
  100054:	89 c1                	mov    %eax,%ecx
  100056:	c1 f9 1f             	sar    $0x1f,%ecx
  100059:	29 ca                	sub    %ecx,%edx
  10005b:	6b d2 64             	imul   $0x64,%edx,%edx
  10005e:	29 d0                	sub    %edx,%eax
  100060:	44 39 e0             	cmp    %r12d,%eax
  100063:	7d da                	jge    10003f <process_main+0x3f>
	    void * ret = malloc(PAGESIZE);
  100065:	bf 00 10 00 00       	mov    $0x1000,%edi
  10006a:	e8 ba 03 00 00       	call   100429 <malloc>
  10006f:	49 89 c5             	mov    %rax,%r13
	    ct ++;
  100072:	83 c3 01             	add    $0x1,%ebx
	    if(ret == NULL)
  100075:	48 85 c0             	test   %rax,%rax
  100078:	74 1c                	je     100096 <process_main+0x96>
		break;
	    app_printf(0x700, "%d\n", ct);
  10007a:	89 da                	mov    %ebx,%edx
  10007c:	be e0 16 10 00       	mov    $0x1016e0,%esi
  100081:	bf 00 07 00 00       	mov    $0x700,%edi
  100086:	b8 00 00 00 00       	mov    $0x0,%eax
  10008b:	e8 0a 00 00 00       	call   10009a <app_printf>
	    *((int*)ret) = p;       // check we have write access
  100090:	45 89 65 00          	mov    %r12d,0x0(%r13)
  100094:	eb a9                	jmp    10003f <process_main+0x3f>
  100096:	cd 32                	int    $0x32
  100098:	eb fc                	jmp    100096 <process_main+0x96>

000000000010009a <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  10009a:	55                   	push   %rbp
  10009b:	48 89 e5             	mov    %rsp,%rbp
  10009e:	48 83 ec 50          	sub    $0x50,%rsp
  1000a2:	49 89 f2             	mov    %rsi,%r10
  1000a5:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1000a9:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1000ad:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1000b1:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  1000b5:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  1000ba:	85 ff                	test   %edi,%edi
  1000bc:	78 2e                	js     1000ec <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  1000be:	48 63 ff             	movslq %edi,%rdi
  1000c1:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  1000c8:	cc cc cc 
  1000cb:	48 89 f8             	mov    %rdi,%rax
  1000ce:	48 f7 e2             	mul    %rdx
  1000d1:	48 89 d0             	mov    %rdx,%rax
  1000d4:	48 c1 e8 02          	shr    $0x2,%rax
  1000d8:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  1000dc:	48 01 c2             	add    %rax,%rdx
  1000df:	48 29 d7             	sub    %rdx,%rdi
  1000e2:	0f b6 b7 15 17 10 00 	movzbl 0x101715(%rdi),%esi
  1000e9:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  1000ec:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  1000f3:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1000f7:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1000fb:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1000ff:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  100103:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100107:	4c 89 d2             	mov    %r10,%rdx
  10010a:	8b 3d ec 8e fb ff    	mov    -0x47114(%rip),%edi        # b8ffc <cursorpos>
  100110:	e8 ba 13 00 00       	call   1014cf <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100115:	3d 30 07 00 00       	cmp    $0x730,%eax
  10011a:	ba 00 00 00 00       	mov    $0x0,%edx
  10011f:	0f 4d c2             	cmovge %edx,%eax
  100122:	89 05 d4 8e fb ff    	mov    %eax,-0x4712c(%rip)        # b8ffc <cursorpos>
    }
}
  100128:	c9                   	leave  
  100129:	c3                   	ret    

000000000010012a <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  10012a:	55                   	push   %rbp
  10012b:	48 89 e5             	mov    %rsp,%rbp
  10012e:	53                   	push   %rbx
  10012f:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100136:	48 89 fb             	mov    %rdi,%rbx
  100139:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  10013d:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  100141:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100145:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100149:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  10014d:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  100154:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100158:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  10015c:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  100160:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  100164:	ba 07 00 00 00       	mov    $0x7,%edx
  100169:	be e4 16 10 00       	mov    $0x1016e4,%esi
  10016e:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100175:	e8 0c 05 00 00       	call   100686 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  10017a:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  10017e:	48 89 da             	mov    %rbx,%rdx
  100181:	be 99 00 00 00       	mov    $0x99,%esi
  100186:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  10018d:	e8 49 14 00 00       	call   1015db <vsnprintf>
  100192:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100195:	85 d2                	test   %edx,%edx
  100197:	7e 0f                	jle    1001a8 <kernel_panic+0x7e>
  100199:	83 c0 06             	add    $0x6,%eax
  10019c:	48 98                	cltq   
  10019e:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  1001a5:	0a 
  1001a6:	75 2a                	jne    1001d2 <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  1001a8:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  1001af:	48 89 d9             	mov    %rbx,%rcx
  1001b2:	ba ec 16 10 00       	mov    $0x1016ec,%edx
  1001b7:	be 00 c0 00 00       	mov    $0xc000,%esi
  1001bc:	bf 30 07 00 00       	mov    $0x730,%edi
  1001c1:	b8 00 00 00 00       	mov    $0x0,%eax
  1001c6:	e8 70 13 00 00       	call   10153b <console_printf>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  1001cb:	48 89 df             	mov    %rbx,%rdi
  1001ce:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  1001d0:	eb fe                	jmp    1001d0 <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  1001d2:	48 63 c2             	movslq %edx,%rax
  1001d5:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  1001db:	0f 94 c2             	sete   %dl
  1001de:	0f b6 d2             	movzbl %dl,%edx
  1001e1:	48 29 d0             	sub    %rdx,%rax
  1001e4:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  1001eb:	ff 
  1001ec:	be e2 16 10 00       	mov    $0x1016e2,%esi
  1001f1:	e8 3d 06 00 00       	call   100833 <strcpy>
  1001f6:	eb b0                	jmp    1001a8 <kernel_panic+0x7e>

00000000001001f8 <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  1001f8:	55                   	push   %rbp
  1001f9:	48 89 e5             	mov    %rsp,%rbp
  1001fc:	48 89 f9             	mov    %rdi,%rcx
  1001ff:	41 89 f0             	mov    %esi,%r8d
  100202:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100205:	ba f0 16 10 00       	mov    $0x1016f0,%edx
  10020a:	be 00 c0 00 00       	mov    $0xc000,%esi
  10020f:	bf 30 07 00 00       	mov    $0x730,%edi
  100214:	b8 00 00 00 00       	mov    $0x0,%eax
  100219:	e8 1d 13 00 00       	call   10153b <console_printf>
    asm volatile ("int %0" : /* no result */
  10021e:	bf 00 00 00 00       	mov    $0x0,%edi
  100223:	cd 30                	int    $0x30
 loop: goto loop;
  100225:	eb fe                	jmp    100225 <assert_fail+0x2d>

0000000000100227 <heap_init>:
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  100227:	bf 10 00 00 00       	mov    $0x10,%edi
  10022c:	cd 3a                	int    $0x3a
  10022e:	48 89 05 eb 1d 00 00 	mov    %rax,0x1deb(%rip)        # 102020 <result.0>
  100235:	bf 08 00 00 00       	mov    $0x8,%edi
  10023a:	cd 3a                	int    $0x3a
  10023c:	48 89 c2             	mov    %rax,%rdx
  10023f:	48 89 05 da 1d 00 00 	mov    %rax,0x1dda(%rip)        # 102020 <result.0>

	// prologue block
	void *prologue_block;
	sbrk(sizeof(block_header) + sizeof(block_header));
	prologue_block = sbrk(sizeof(block_footer));
	PUT(HDRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  100246:	48 c7 40 f8 11 00 00 	movq   $0x11,-0x8(%rax)
  10024d:	00 
	PUT(FTRP(prologue_block), PACK(sizeof(block_header) + sizeof(block_footer), 1));	
  10024e:	48 c7 00 11 00 00 00 	movq   $0x11,(%rax)
  100255:	cd 3a                	int    $0x3a
  100257:	48 89 05 c2 1d 00 00 	mov    %rax,0x1dc2(%rip)        # 102020 <result.0>

	// terminal block
	sbrk(sizeof(block_header));
	PUT(HDRP(NEXT_BLKP(prologue_block)), PACK(0, 1));	
  10025e:	48 8b 42 f8          	mov    -0x8(%rdx),%rax
  100262:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100266:	48 c7 44 02 f8 01 00 	movq   $0x1,-0x8(%rdx,%rax,1)
  10026d:	00 00 

	free_list = NULL;
  10026f:	48 c7 05 96 1d 00 00 	movq   $0x0,0x1d96(%rip)        # 102010 <free_list>
  100276:	00 00 00 00 

	initialized_heap = 1;
  10027a:	c7 05 94 1d 00 00 01 	movl   $0x1,0x1d94(%rip)        # 102018 <initialized_heap>
  100281:	00 00 00 
}
  100284:	c3                   	ret    

0000000000100285 <free>:

void free(void *firstbyte) {
	if (firstbyte == NULL)
  100285:	48 85 ff             	test   %rdi,%rdi
  100288:	74 35                	je     1002bf <free+0x3a>
		return;

	// setup free things: alloc, list ptrs, footer
	PUT(HDRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  10028a:	48 8b 47 f8          	mov    -0x8(%rdi),%rax
  10028e:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100292:	48 89 47 f8          	mov    %rax,-0x8(%rdi)
	NEXT_FPTR(firstbyte) = free_list;
  100296:	48 8b 15 73 1d 00 00 	mov    0x1d73(%rip),%rdx        # 102010 <free_list>
  10029d:	48 89 17             	mov    %rdx,(%rdi)
	PREV_FPTR(firstbyte) = NULL;
  1002a0:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  1002a7:	00 
	PUT(FTRP(firstbyte), PACK(GET_SIZE(HDRP(firstbyte)), 0));	
  1002a8:	48 89 44 07 f0       	mov    %rax,-0x10(%rdi,%rax,1)

	// add to free_list
	PREV_FPTR(free_list) = firstbyte;
  1002ad:	48 8b 05 5c 1d 00 00 	mov    0x1d5c(%rip),%rax        # 102010 <free_list>
  1002b4:	48 89 78 08          	mov    %rdi,0x8(%rax)
	free_list = firstbyte;
  1002b8:	48 89 3d 51 1d 00 00 	mov    %rdi,0x1d51(%rip)        # 102010 <free_list>

	return;
}
  1002bf:	c3                   	ret    

00000000001002c0 <extend>:
//
//	the reason alloating in units of chunks (4 pages) isn't super wasteful
//	is due to lazy allocation -- the memory is available for the user
//	but won't be actually assigned to them until they try to write to it
int extend(size_t new_size) {
	size_t chunk_aligned_size = CHUNK_ALIGN(new_size); 
  1002c0:	48 81 c7 ff 3f 00 00 	add    $0x3fff,%rdi
  1002c7:	48 81 e7 00 c0 ff ff 	and    $0xffffffffffffc000,%rdi
  1002ce:	cd 3a                	int    $0x3a
  1002d0:	48 89 05 49 1d 00 00 	mov    %rax,0x1d49(%rip)        # 102020 <result.0>
	void *bp = sbrk(chunk_aligned_size);
	if (bp == (void *)-1)
  1002d7:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  1002db:	74 51                	je     10032e <extend+0x6e>
		return -1;

	// setup pointer
	PUT(HDRP(bp), PACK(GET_SIZE(HDRP(bp)), 0));	
  1002dd:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1002e1:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1002e5:	48 89 50 f8          	mov    %rdx,-0x8(%rax)
	NEXT_FPTR(bp) = free_list;	
  1002e9:	48 8b 0d 20 1d 00 00 	mov    0x1d20(%rip),%rcx        # 102010 <free_list>
  1002f0:	48 89 08             	mov    %rcx,(%rax)
	PREV_FPTR(bp) = NULL;
  1002f3:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  1002fa:	00 
	PUT(FTRP(bp), PACK(GET_SIZE(HDRP(bp)), 0));	
  1002fb:	48 89 54 02 f0       	mov    %rdx,-0x10(%rdx,%rax,1)
	
	// add to head of free_list
	if (free_list)
  100300:	48 8b 15 09 1d 00 00 	mov    0x1d09(%rip),%rdx        # 102010 <free_list>
  100307:	48 85 d2             	test   %rdx,%rdx
  10030a:	74 04                	je     100310 <extend+0x50>
		PREV_FPTR(free_list) = bp;
  10030c:	48 89 42 08          	mov    %rax,0x8(%rdx)
	free_list = bp;
  100310:	48 89 05 f9 1c 00 00 	mov    %rax,0x1cf9(%rip)        # 102010 <free_list>

	// update terminal block
	PUT(HDRP(NEXT_BLKP(bp)), PACK(0, 1));	
  100317:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  10031b:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  10031f:	48 c7 44 10 f8 01 00 	movq   $0x1,-0x8(%rax,%rdx,1)
  100326:	00 00 

	return 0;
  100328:	b8 00 00 00 00       	mov    $0x0,%eax
  10032d:	c3                   	ret    
		return -1;
  10032e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  100333:	c3                   	ret    

0000000000100334 <set_allocated>:

// remember all the sizes are always aligned, so I should be safe
//	i hope i got all the sizing stuff right
void set_allocated(void *bp, size_t size) {
  100334:	55                   	push   %rbp
  100335:	48 89 e5             	mov    %rsp,%rbp
  100338:	41 55                	push   %r13
  10033a:	41 54                	push   %r12
  10033c:	53                   	push   %rbx
  10033d:	48 83 ec 08          	sub    $0x8,%rsp
  100341:	48 89 fb             	mov    %rdi,%rbx
	size_t extra_size = GET_SIZE(HDRP(bp)) - size;
  100344:	4c 8b 6f f8          	mov    -0x8(%rdi),%r13
  100348:	49 83 e5 f0          	and    $0xfffffffffffffff0,%r13
  10034c:	49 29 f5             	sub    %rsi,%r13

	if (extra_size > OVERHEAD + MIN_PAYLOAD_SIZE) {
  10034f:	49 83 fd 20          	cmp    $0x20,%r13
  100353:	77 47                	ja     10039c <set_allocated+0x68>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
								    
	}
	else {
		// update the free list
		if (free_list == bp)
  100355:	48 39 3d b4 1c 00 00 	cmp    %rdi,0x1cb4(%rip)        # 102010 <free_list>
  10035c:	0f 84 b8 00 00 00    	je     10041a <set_allocated+0xe6>
			free_list = NEXT_FPTR(bp);

		if (PREV_FPTR(bp))
  100362:	48 8b 43 08          	mov    0x8(%rbx),%rax
  100366:	48 85 c0             	test   %rax,%rax
  100369:	74 06                	je     100371 <set_allocated+0x3d>
			NEXT_FPTR(PREV_FPTR(bp)) = NEXT_FPTR(bp);
  10036b:	48 8b 13             	mov    (%rbx),%rdx
  10036e:	48 89 10             	mov    %rdx,(%rax)
		if (NEXT_FPTR(bp))
  100371:	48 8b 03             	mov    (%rbx),%rax
  100374:	48 85 c0             	test   %rax,%rax
  100377:	74 08                	je     100381 <set_allocated+0x4d>
			PREV_FPTR(NEXT_FPTR(bp)) = PREV_FPTR(bp); 
  100379:	48 8b 53 08          	mov    0x8(%rbx),%rdx
  10037d:	48 89 50 08          	mov    %rdx,0x8(%rax)

		PUT(HDRP(bp), PACK(GET_SIZE(HDRP(bp)), 1));	
  100381:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  100385:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100389:	48 83 c8 01          	or     $0x1,%rax
  10038d:	48 89 43 f8          	mov    %rax,-0x8(%rbx)
	}
}
  100391:	48 83 c4 08          	add    $0x8,%rsp
  100395:	5b                   	pop    %rbx
  100396:	41 5c                	pop    %r12
  100398:	41 5d                	pop    %r13
  10039a:	5d                   	pop    %rbp
  10039b:	c3                   	ret    
		PUT(HDRP(bp), PACK(size, 1));
  10039c:	48 89 f0             	mov    %rsi,%rax
  10039f:	48 83 c8 01          	or     $0x1,%rax
  1003a3:	48 89 47 f8          	mov    %rax,-0x8(%rdi)
		void *leftover_mem_ptr = NEXT_BLKP(bp);
  1003a7:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  1003ab:	4c 8d 24 37          	lea    (%rdi,%rsi,1),%r12
    asm volatile ("int %0" : /* no result */
  1003af:	bf 01 00 00 00       	mov    $0x1,%edi
  1003b4:	cd 38                	int    $0x38
			app_printf(0x700,"%p ", bp);	
  1003b6:	48 89 da             	mov    %rbx,%rdx
  1003b9:	be 1a 17 10 00       	mov    $0x10171a,%esi
  1003be:	bf 00 07 00 00       	mov    $0x700,%edi
  1003c3:	b8 00 00 00 00       	mov    $0x0,%eax
  1003c8:	e8 cd fc ff ff       	call   10009a <app_printf>
		PUT(HDRP(leftover_mem_ptr), PACK(extra_size, 0));	
  1003cd:	4d 89 6c 24 f8       	mov    %r13,-0x8(%r12)
		NEXT_FPTR(leftover_mem_ptr) = NEXT_FPTR(bp); // pointers to the next free blocks
  1003d2:	48 8b 03             	mov    (%rbx),%rax
  1003d5:	49 89 04 24          	mov    %rax,(%r12)
		PREV_FPTR(leftover_mem_ptr) = PREV_FPTR(bp);
  1003d9:	48 8b 43 08          	mov    0x8(%rbx),%rax
  1003dd:	49 89 44 24 08       	mov    %rax,0x8(%r12)
		PUT(FTRP(leftover_mem_ptr), PACK(extra_size, 0));	
  1003e2:	4c 89 e8             	mov    %r13,%rax
  1003e5:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  1003e9:	4d 89 6c 04 f0       	mov    %r13,-0x10(%r12,%rax,1)
		if (free_list == bp)
  1003ee:	48 39 1d 1b 1c 00 00 	cmp    %rbx,0x1c1b(%rip)        # 102010 <free_list>
  1003f5:	74 1a                	je     100411 <set_allocated+0xdd>
		if (PREV_FPTR(bp))
  1003f7:	48 8b 43 08          	mov    0x8(%rbx),%rax
  1003fb:	48 85 c0             	test   %rax,%rax
  1003fe:	74 03                	je     100403 <set_allocated+0xcf>
			NEXT_FPTR(PREV_FPTR(bp)) = leftover_mem_ptr; // this the free block that went to bp
  100400:	4c 89 20             	mov    %r12,(%rax)
		if (NEXT_FPTR(bp))
  100403:	48 8b 03             	mov    (%rbx),%rax
  100406:	48 85 c0             	test   %rax,%rax
  100409:	74 86                	je     100391 <set_allocated+0x5d>
			PREV_FPTR(NEXT_FPTR(bp)) = leftover_mem_ptr; // this is the free block that came from bp
  10040b:	4c 89 60 08          	mov    %r12,0x8(%rax)
  10040f:	eb 80                	jmp    100391 <set_allocated+0x5d>
			free_list = leftover_mem_ptr;
  100411:	4c 89 25 f8 1b 00 00 	mov    %r12,0x1bf8(%rip)        # 102010 <free_list>
  100418:	eb dd                	jmp    1003f7 <set_allocated+0xc3>
			free_list = NEXT_FPTR(bp);
  10041a:	48 8b 07             	mov    (%rdi),%rax
  10041d:	48 89 05 ec 1b 00 00 	mov    %rax,0x1bec(%rip)        # 102010 <free_list>
  100424:	e9 39 ff ff ff       	jmp    100362 <set_allocated+0x2e>

0000000000100429 <malloc>:

void *malloc(uint64_t numbytes) {
  100429:	55                   	push   %rbp
  10042a:	48 89 e5             	mov    %rsp,%rbp
  10042d:	41 55                	push   %r13
  10042f:	41 54                	push   %r12
  100431:	53                   	push   %rbx
  100432:	48 83 ec 08          	sub    $0x8,%rsp
  100436:	49 89 fc             	mov    %rdi,%r12
	if (!initialized_heap)
  100439:	83 3d d8 1b 00 00 00 	cmpl   $0x0,0x1bd8(%rip)        # 102018 <initialized_heap>
  100440:	74 6b                	je     1004ad <malloc+0x84>
		heap_init();

	if (numbytes == 0)
  100442:	4d 85 e4             	test   %r12,%r12
  100445:	0f 84 82 00 00 00    	je     1004cd <malloc+0xa4>
		return NULL;

	size_t aligned_size = (OVERHEAD + MIN_PAYLOAD_SIZE > ALIGN(numbytes + OVERHEAD)) 
  10044b:	49 83 c4 17          	add    $0x17,%r12
  10044f:	49 83 e4 f0          	and    $0xfffffffffffffff0,%r12
  100453:	b8 20 00 00 00       	mov    $0x20,%eax
  100458:	49 39 c4             	cmp    %rax,%r12
  10045b:	4c 0f 42 e0          	cmovb  %rax,%r12
						? OVERHEAD + MIN_PAYLOAD_SIZE 
						: ALIGN(numbytes + OVERHEAD);


	void *bp = free_list;
  10045f:	48 8b 1d aa 1b 00 00 	mov    0x1baa(%rip),%rbx        # 102010 <free_list>
	while (bp) {
  100466:	48 85 db             	test   %rbx,%rbx
  100469:	74 15                	je     100480 <malloc+0x57>
		if (GET_SIZE(HDRP(bp)) >= aligned_size) {
  10046b:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  10046f:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100473:	4c 39 e0             	cmp    %r12,%rax
  100476:	73 3c                	jae    1004b4 <malloc+0x8b>
			set_allocated(bp, aligned_size);
			return bp;
		}

		bp = NEXT_FPTR(bp);
  100478:	48 8b 1b             	mov    (%rbx),%rbx
	while (bp) {
  10047b:	48 85 db             	test   %rbx,%rbx
  10047e:	75 eb                	jne    10046b <malloc+0x42>
    asm volatile ("int %1" :  "=a" (result)
  100480:	bf 00 00 00 00       	mov    $0x0,%edi
  100485:	cd 3a                	int    $0x3a
  100487:	49 89 c5             	mov    %rax,%r13
  10048a:	48 89 05 8f 1b 00 00 	mov    %rax,0x1b8f(%rip)        # 102020 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  100491:	48 89 c3             	mov    %rax,%rbx
	}

	// no preexisting space big enough, so only space is at top of stack
	bp = sbrk(0);
	if (extend(aligned_size)) {
  100494:	4c 89 e7             	mov    %r12,%rdi
  100497:	e8 24 fe ff ff       	call   1002c0 <extend>
  10049c:	85 c0                	test   %eax,%eax
  10049e:	75 34                	jne    1004d4 <malloc+0xab>
		return NULL;
	}
	set_allocated(bp, aligned_size);
  1004a0:	4c 89 e6             	mov    %r12,%rsi
  1004a3:	4c 89 ef             	mov    %r13,%rdi
  1004a6:	e8 89 fe ff ff       	call   100334 <set_allocated>
    return bp;
  1004ab:	eb 12                	jmp    1004bf <malloc+0x96>
		heap_init();
  1004ad:	e8 75 fd ff ff       	call   100227 <heap_init>
  1004b2:	eb 8e                	jmp    100442 <malloc+0x19>
			set_allocated(bp, aligned_size);
  1004b4:	4c 89 e6             	mov    %r12,%rsi
  1004b7:	48 89 df             	mov    %rbx,%rdi
  1004ba:	e8 75 fe ff ff       	call   100334 <set_allocated>
}
  1004bf:	48 89 d8             	mov    %rbx,%rax
  1004c2:	48 83 c4 08          	add    $0x8,%rsp
  1004c6:	5b                   	pop    %rbx
  1004c7:	41 5c                	pop    %r12
  1004c9:	41 5d                	pop    %r13
  1004cb:	5d                   	pop    %rbp
  1004cc:	c3                   	ret    
		return NULL;
  1004cd:	bb 00 00 00 00       	mov    $0x0,%ebx
  1004d2:	eb eb                	jmp    1004bf <malloc+0x96>
		return NULL;
  1004d4:	bb 00 00 00 00       	mov    $0x0,%ebx
  1004d9:	eb e4                	jmp    1004bf <malloc+0x96>

00000000001004db <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  1004db:	55                   	push   %rbp
  1004dc:	48 89 e5             	mov    %rsp,%rbp
  1004df:	41 54                	push   %r12
  1004e1:	53                   	push   %rbx
	void *bp = malloc(num * sz);
  1004e2:	48 0f af fe          	imul   %rsi,%rdi
  1004e6:	49 89 fc             	mov    %rdi,%r12
  1004e9:	e8 3b ff ff ff       	call   100429 <malloc>
  1004ee:	48 89 c3             	mov    %rax,%rbx
	if (bp)							// protect against num=0 or size=0
  1004f1:	48 85 c0             	test   %rax,%rax
  1004f4:	74 10                	je     100506 <calloc+0x2b>
		memset(bp, 0, num * sz);
  1004f6:	4c 89 e2             	mov    %r12,%rdx
  1004f9:	be 00 00 00 00       	mov    $0x0,%esi
  1004fe:	48 89 c7             	mov    %rax,%rdi
  100501:	e8 7e 02 00 00       	call   100784 <memset>
	return bp;
}
  100506:	48 89 d8             	mov    %rbx,%rax
  100509:	5b                   	pop    %rbx
  10050a:	41 5c                	pop    %r12
  10050c:	5d                   	pop    %rbp
  10050d:	c3                   	ret    

000000000010050e <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  10050e:	55                   	push   %rbp
  10050f:	48 89 e5             	mov    %rsp,%rbp
  100512:	41 54                	push   %r12
  100514:	53                   	push   %rbx
  100515:	48 89 fb             	mov    %rdi,%rbx
  100518:	48 89 f7             	mov    %rsi,%rdi
	// first check if there's enough space in the block already (and that it's actually valid ptr)
	if (ptr && GET_SIZE(HDRP(ptr)) >= sz)
  10051b:	48 85 db             	test   %rbx,%rbx
  10051e:	74 10                	je     100530 <realloc+0x22>
  100520:	48 8b 43 f8          	mov    -0x8(%rbx),%rax
  100524:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
		return ptr;
  100528:	49 89 dc             	mov    %rbx,%r12
	if (ptr && GET_SIZE(HDRP(ptr)) >= sz)
  10052b:	48 39 f0             	cmp    %rsi,%rax
  10052e:	73 23                	jae    100553 <realloc+0x45>

	// else find or add a big enough block, which is what malloc does
	void *bigger_ptr = malloc(sz);
  100530:	e8 f4 fe ff ff       	call   100429 <malloc>
  100535:	49 89 c4             	mov    %rax,%r12
	memcpy(bigger_ptr, ptr, GET_SIZE(HDRP(ptr)));
  100538:	48 8b 53 f8          	mov    -0x8(%rbx),%rdx
  10053c:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  100540:	48 89 de             	mov    %rbx,%rsi
  100543:	48 89 c7             	mov    %rax,%rdi
  100546:	e8 3b 01 00 00       	call   100686 <memcpy>
	free(ptr);
  10054b:	48 89 df             	mov    %rbx,%rdi
  10054e:	e8 32 fd ff ff       	call   100285 <free>

    return bigger_ptr;
}
  100553:	4c 89 e0             	mov    %r12,%rax
  100556:	5b                   	pop    %rbx
  100557:	41 5c                	pop    %r12
  100559:	5d                   	pop    %rbp
  10055a:	c3                   	ret    

000000000010055b <defrag>:

void defrag() {
	void *fp = free_list;
  10055b:	48 8b 05 ae 1a 00 00 	mov    0x1aae(%rip),%rax        # 102010 <free_list>
	while (fp != NULL) {
  100562:	48 85 c0             	test   %rax,%rax
  100565:	75 50                	jne    1005b7 <defrag+0x5c>
			PUT(FTRP(prev_block), PACK(GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp)), 0));	
		}

		fp = NEXT_FPTR(fp);
	}
}
  100567:	c3                   	ret    
				free_list = NEXT_FPTR(next_block);
  100568:	48 8b 0a             	mov    (%rdx),%rcx
  10056b:	48 89 0d 9e 1a 00 00 	mov    %rcx,0x1a9e(%rip)        # 102010 <free_list>
  100572:	eb 5d                	jmp    1005d1 <defrag+0x76>
			fp = NEXT_FPTR(fp);
  100574:	48 8b 00             	mov    (%rax),%rax
			continue;
  100577:	eb 39                	jmp    1005b2 <defrag+0x57>
				free_list = NEXT_FPTR(fp);
  100579:	48 8b 08             	mov    (%rax),%rcx
  10057c:	48 89 0d 8d 1a 00 00 	mov    %rcx,0x1a8d(%rip)        # 102010 <free_list>
  100583:	e9 d0 00 00 00       	jmp    100658 <defrag+0xfd>
			PUT(HDRP(prev_block), PACK(GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp)), 0));	
  100588:	48 8b 4a f8          	mov    -0x8(%rdx),%rcx
  10058c:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  100590:	48 8b 70 f8          	mov    -0x8(%rax),%rsi
  100594:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  100598:	48 01 f1             	add    %rsi,%rcx
  10059b:	48 89 4a f8          	mov    %rcx,-0x8(%rdx)
			PUT(FTRP(prev_block), PACK(GET_SIZE(HDRP(prev_block)) + GET_SIZE(HDRP(fp)), 0));	
  10059f:	48 8b 70 f8          	mov    -0x8(%rax),%rsi
  1005a3:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  1005a7:	48 01 ce             	add    %rcx,%rsi
  1005aa:	48 89 74 0a f0       	mov    %rsi,-0x10(%rdx,%rcx,1)
		fp = NEXT_FPTR(fp);
  1005af:	48 8b 00             	mov    (%rax),%rax
	while (fp != NULL) {
  1005b2:	48 85 c0             	test   %rax,%rax
  1005b5:	74 b0                	je     100567 <defrag+0xc>
		void *next_block = NEXT_BLKP(fp);
  1005b7:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1005bb:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  1005bf:	48 01 c2             	add    %rax,%rdx
		if (!GET_ALLOC(HDRP(next_block))) {
  1005c2:	f6 42 f8 01          	testb  $0x1,-0x8(%rdx)
  1005c6:	75 4f                	jne    100617 <defrag+0xbc>
			if (free_list == next_block)
  1005c8:	48 39 15 41 1a 00 00 	cmp    %rdx,0x1a41(%rip)        # 102010 <free_list>
  1005cf:	74 97                	je     100568 <defrag+0xd>
			if (PREV_FPTR(next_block)) 
  1005d1:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  1005d5:	48 85 c9             	test   %rcx,%rcx
  1005d8:	74 06                	je     1005e0 <defrag+0x85>
				NEXT_FPTR(PREV_FPTR(next_block)) = NEXT_FPTR(next_block);
  1005da:	48 8b 32             	mov    (%rdx),%rsi
  1005dd:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(next_block)) 
  1005e0:	48 8b 0a             	mov    (%rdx),%rcx
  1005e3:	48 85 c9             	test   %rcx,%rcx
  1005e6:	74 08                	je     1005f0 <defrag+0x95>
				PREV_FPTR(NEXT_FPTR(next_block)) = PREV_FPTR(next_block);
  1005e8:	48 8b 72 08          	mov    0x8(%rdx),%rsi
  1005ec:	48 89 71 08          	mov    %rsi,0x8(%rcx)
			PUT(HDRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  1005f0:	48 8b 48 f8          	mov    -0x8(%rax),%rcx
  1005f4:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  1005f8:	48 8b 72 f8          	mov    -0x8(%rdx),%rsi
  1005fc:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  100600:	48 01 f1             	add    %rsi,%rcx
  100603:	48 89 48 f8          	mov    %rcx,-0x8(%rax)
			PUT(FTRP(fp), PACK(GET_SIZE(HDRP(fp)) + GET_SIZE(HDRP(next_block)), 0));	
  100607:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
  10060b:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
  10060f:	48 01 ca             	add    %rcx,%rdx
  100612:	48 89 54 08 f0       	mov    %rdx,-0x10(%rax,%rcx,1)
		void *prev_block = PREV_BLKP(fp);
  100617:	48 8b 48 f0          	mov    -0x10(%rax),%rcx
  10061b:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
  10061f:	48 89 c2             	mov    %rax,%rdx
  100622:	48 29 ca             	sub    %rcx,%rdx
		if (GET_SIZE(HDRP(prev_block)) != GET_SIZE(FTRP(prev_block))){
  100625:	48 8b 4a f8          	mov    -0x8(%rdx),%rcx
  100629:	48 89 ce             	mov    %rcx,%rsi
  10062c:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  100630:	48 89 cf             	mov    %rcx,%rdi
  100633:	48 33 7c 32 f0       	xor    -0x10(%rdx,%rsi,1),%rdi
  100638:	48 83 ff 0f          	cmp    $0xf,%rdi
  10063c:	0f 87 32 ff ff ff    	ja     100574 <defrag+0x19>
		if (!GET_ALLOC(HDRP(prev_block))) {
  100642:	f6 c1 01             	test   $0x1,%cl
  100645:	0f 85 64 ff ff ff    	jne    1005af <defrag+0x54>
			if (free_list == fp)
  10064b:	48 39 05 be 19 00 00 	cmp    %rax,0x19be(%rip)        # 102010 <free_list>
  100652:	0f 84 21 ff ff ff    	je     100579 <defrag+0x1e>
			if (PREV_FPTR(fp)) 
  100658:	48 8b 48 08          	mov    0x8(%rax),%rcx
  10065c:	48 85 c9             	test   %rcx,%rcx
  10065f:	74 06                	je     100667 <defrag+0x10c>
				NEXT_FPTR(PREV_FPTR(fp)) = NEXT_FPTR(fp);
  100661:	48 8b 30             	mov    (%rax),%rsi
  100664:	48 89 31             	mov    %rsi,(%rcx)
			if (NEXT_FPTR(fp)) 
  100667:	48 8b 08             	mov    (%rax),%rcx
  10066a:	48 85 c9             	test   %rcx,%rcx
  10066d:	0f 84 15 ff ff ff    	je     100588 <defrag+0x2d>
				PREV_FPTR(NEXT_FPTR(fp)) = PREV_FPTR(fp);
  100673:	48 8b 70 08          	mov    0x8(%rax),%rsi
  100677:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  10067b:	e9 08 ff ff ff       	jmp    100588 <defrag+0x2d>

0000000000100680 <heap_info>:

int heap_info(heap_info_struct *info) {
    return 0;
}
  100680:	b8 00 00 00 00       	mov    $0x0,%eax
  100685:	c3                   	ret    

0000000000100686 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100686:	55                   	push   %rbp
  100687:	48 89 e5             	mov    %rsp,%rbp
  10068a:	48 83 ec 28          	sub    $0x28,%rsp
  10068e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100692:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100696:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10069a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10069e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1006a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1006a6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  1006aa:	eb 1c                	jmp    1006c8 <memcpy+0x42>
        *d = *s;
  1006ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006b0:	0f b6 10             	movzbl (%rax),%edx
  1006b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1006b7:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1006b9:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1006be:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1006c3:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1006c8:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1006cd:	75 dd                	jne    1006ac <memcpy+0x26>
    }
    return dst;
  1006cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1006d3:	c9                   	leave  
  1006d4:	c3                   	ret    

00000000001006d5 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1006d5:	55                   	push   %rbp
  1006d6:	48 89 e5             	mov    %rsp,%rbp
  1006d9:	48 83 ec 28          	sub    $0x28,%rsp
  1006dd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1006e1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1006e5:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1006e9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1006ed:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  1006f1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1006f5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  1006f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006fd:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  100701:	73 6a                	jae    10076d <memmove+0x98>
  100703:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100707:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10070b:	48 01 d0             	add    %rdx,%rax
  10070e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100712:	73 59                	jae    10076d <memmove+0x98>
        s += n, d += n;
  100714:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100718:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  10071c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100720:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  100724:	eb 17                	jmp    10073d <memmove+0x68>
            *--d = *--s;
  100726:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  10072b:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100730:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100734:	0f b6 10             	movzbl (%rax),%edx
  100737:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10073b:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  10073d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100741:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100745:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100749:	48 85 c0             	test   %rax,%rax
  10074c:	75 d8                	jne    100726 <memmove+0x51>
    if (s < d && s + n > d) {
  10074e:	eb 2e                	jmp    10077e <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100750:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100754:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100758:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10075c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100760:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100764:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100768:	0f b6 12             	movzbl (%rdx),%edx
  10076b:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  10076d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100771:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100775:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100779:	48 85 c0             	test   %rax,%rax
  10077c:	75 d2                	jne    100750 <memmove+0x7b>
        }
    }
    return dst;
  10077e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100782:	c9                   	leave  
  100783:	c3                   	ret    

0000000000100784 <memset>:

void* memset(void* v, int c, size_t n) {
  100784:	55                   	push   %rbp
  100785:	48 89 e5             	mov    %rsp,%rbp
  100788:	48 83 ec 28          	sub    $0x28,%rsp
  10078c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100790:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100793:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100797:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10079b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10079f:	eb 15                	jmp    1007b6 <memset+0x32>
        *p = c;
  1007a1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1007a4:	89 c2                	mov    %eax,%edx
  1007a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007aa:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1007ac:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1007b1:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1007b6:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1007bb:	75 e4                	jne    1007a1 <memset+0x1d>
    }
    return v;
  1007bd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1007c1:	c9                   	leave  
  1007c2:	c3                   	ret    

00000000001007c3 <strlen>:

size_t strlen(const char* s) {
  1007c3:	55                   	push   %rbp
  1007c4:	48 89 e5             	mov    %rsp,%rbp
  1007c7:	48 83 ec 18          	sub    $0x18,%rsp
  1007cb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  1007cf:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1007d6:	00 
  1007d7:	eb 0a                	jmp    1007e3 <strlen+0x20>
        ++n;
  1007d9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  1007de:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1007e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1007e7:	0f b6 00             	movzbl (%rax),%eax
  1007ea:	84 c0                	test   %al,%al
  1007ec:	75 eb                	jne    1007d9 <strlen+0x16>
    }
    return n;
  1007ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1007f2:	c9                   	leave  
  1007f3:	c3                   	ret    

00000000001007f4 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  1007f4:	55                   	push   %rbp
  1007f5:	48 89 e5             	mov    %rsp,%rbp
  1007f8:	48 83 ec 20          	sub    $0x20,%rsp
  1007fc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100800:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100804:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  10080b:	00 
  10080c:	eb 0a                	jmp    100818 <strnlen+0x24>
        ++n;
  10080e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100813:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100818:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10081c:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100820:	74 0b                	je     10082d <strnlen+0x39>
  100822:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100826:	0f b6 00             	movzbl (%rax),%eax
  100829:	84 c0                	test   %al,%al
  10082b:	75 e1                	jne    10080e <strnlen+0x1a>
    }
    return n;
  10082d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100831:	c9                   	leave  
  100832:	c3                   	ret    

0000000000100833 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100833:	55                   	push   %rbp
  100834:	48 89 e5             	mov    %rsp,%rbp
  100837:	48 83 ec 20          	sub    $0x20,%rsp
  10083b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10083f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  100843:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100847:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  10084b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  10084f:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100853:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100857:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10085b:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10085f:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100863:	0f b6 12             	movzbl (%rdx),%edx
  100866:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100868:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10086c:	48 83 e8 01          	sub    $0x1,%rax
  100870:	0f b6 00             	movzbl (%rax),%eax
  100873:	84 c0                	test   %al,%al
  100875:	75 d4                	jne    10084b <strcpy+0x18>
    return dst;
  100877:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10087b:	c9                   	leave  
  10087c:	c3                   	ret    

000000000010087d <strcmp>:

int strcmp(const char* a, const char* b) {
  10087d:	55                   	push   %rbp
  10087e:	48 89 e5             	mov    %rsp,%rbp
  100881:	48 83 ec 10          	sub    $0x10,%rsp
  100885:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100889:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10088d:	eb 0a                	jmp    100899 <strcmp+0x1c>
        ++a, ++b;
  10088f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100894:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100899:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10089d:	0f b6 00             	movzbl (%rax),%eax
  1008a0:	84 c0                	test   %al,%al
  1008a2:	74 1d                	je     1008c1 <strcmp+0x44>
  1008a4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1008a8:	0f b6 00             	movzbl (%rax),%eax
  1008ab:	84 c0                	test   %al,%al
  1008ad:	74 12                	je     1008c1 <strcmp+0x44>
  1008af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008b3:	0f b6 10             	movzbl (%rax),%edx
  1008b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1008ba:	0f b6 00             	movzbl (%rax),%eax
  1008bd:	38 c2                	cmp    %al,%dl
  1008bf:	74 ce                	je     10088f <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  1008c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008c5:	0f b6 00             	movzbl (%rax),%eax
  1008c8:	89 c2                	mov    %eax,%edx
  1008ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1008ce:	0f b6 00             	movzbl (%rax),%eax
  1008d1:	38 d0                	cmp    %dl,%al
  1008d3:	0f 92 c0             	setb   %al
  1008d6:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  1008d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008dd:	0f b6 00             	movzbl (%rax),%eax
  1008e0:	89 c1                	mov    %eax,%ecx
  1008e2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1008e6:	0f b6 00             	movzbl (%rax),%eax
  1008e9:	38 c1                	cmp    %al,%cl
  1008eb:	0f 92 c0             	setb   %al
  1008ee:	0f b6 c0             	movzbl %al,%eax
  1008f1:	29 c2                	sub    %eax,%edx
  1008f3:	89 d0                	mov    %edx,%eax
}
  1008f5:	c9                   	leave  
  1008f6:	c3                   	ret    

00000000001008f7 <strchr>:

char* strchr(const char* s, int c) {
  1008f7:	55                   	push   %rbp
  1008f8:	48 89 e5             	mov    %rsp,%rbp
  1008fb:	48 83 ec 10          	sub    $0x10,%rsp
  1008ff:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100903:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100906:	eb 05                	jmp    10090d <strchr+0x16>
        ++s;
  100908:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  10090d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100911:	0f b6 00             	movzbl (%rax),%eax
  100914:	84 c0                	test   %al,%al
  100916:	74 0e                	je     100926 <strchr+0x2f>
  100918:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10091c:	0f b6 00             	movzbl (%rax),%eax
  10091f:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100922:	38 d0                	cmp    %dl,%al
  100924:	75 e2                	jne    100908 <strchr+0x11>
    }
    if (*s == (char) c) {
  100926:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10092a:	0f b6 00             	movzbl (%rax),%eax
  10092d:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100930:	38 d0                	cmp    %dl,%al
  100932:	75 06                	jne    10093a <strchr+0x43>
        return (char*) s;
  100934:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100938:	eb 05                	jmp    10093f <strchr+0x48>
    } else {
        return NULL;
  10093a:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  10093f:	c9                   	leave  
  100940:	c3                   	ret    

0000000000100941 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100941:	55                   	push   %rbp
  100942:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  100945:	8b 05 dd 16 00 00    	mov    0x16dd(%rip),%eax        # 102028 <rand_seed_set>
  10094b:	85 c0                	test   %eax,%eax
  10094d:	75 0a                	jne    100959 <rand+0x18>
        srand(819234718U);
  10094f:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100954:	e8 24 00 00 00       	call   10097d <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100959:	8b 05 cd 16 00 00    	mov    0x16cd(%rip),%eax        # 10202c <rand_seed>
  10095f:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100965:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  10096a:	89 05 bc 16 00 00    	mov    %eax,0x16bc(%rip)        # 10202c <rand_seed>
    return rand_seed & RAND_MAX;
  100970:	8b 05 b6 16 00 00    	mov    0x16b6(%rip),%eax        # 10202c <rand_seed>
  100976:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  10097b:	5d                   	pop    %rbp
  10097c:	c3                   	ret    

000000000010097d <srand>:

void srand(unsigned seed) {
  10097d:	55                   	push   %rbp
  10097e:	48 89 e5             	mov    %rsp,%rbp
  100981:	48 83 ec 08          	sub    $0x8,%rsp
  100985:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100988:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10098b:	89 05 9b 16 00 00    	mov    %eax,0x169b(%rip)        # 10202c <rand_seed>
    rand_seed_set = 1;
  100991:	c7 05 8d 16 00 00 01 	movl   $0x1,0x168d(%rip)        # 102028 <rand_seed_set>
  100998:	00 00 00 
}
  10099b:	90                   	nop
  10099c:	c9                   	leave  
  10099d:	c3                   	ret    

000000000010099e <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  10099e:	55                   	push   %rbp
  10099f:	48 89 e5             	mov    %rsp,%rbp
  1009a2:	48 83 ec 28          	sub    $0x28,%rsp
  1009a6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1009aa:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1009ae:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  1009b1:	48 c7 45 f8 00 19 10 	movq   $0x101900,-0x8(%rbp)
  1009b8:	00 
    if (base < 0) {
  1009b9:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  1009bd:	79 0b                	jns    1009ca <fill_numbuf+0x2c>
        digits = lower_digits;
  1009bf:	48 c7 45 f8 20 19 10 	movq   $0x101920,-0x8(%rbp)
  1009c6:	00 
        base = -base;
  1009c7:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  1009ca:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1009cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1009d3:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  1009d6:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1009d9:	48 63 c8             	movslq %eax,%rcx
  1009dc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1009e0:	ba 00 00 00 00       	mov    $0x0,%edx
  1009e5:	48 f7 f1             	div    %rcx
  1009e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009ec:	48 01 d0             	add    %rdx,%rax
  1009ef:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1009f4:	0f b6 10             	movzbl (%rax),%edx
  1009f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1009fb:	88 10                	mov    %dl,(%rax)
        val /= base;
  1009fd:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100a00:	48 63 f0             	movslq %eax,%rsi
  100a03:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100a07:	ba 00 00 00 00       	mov    $0x0,%edx
  100a0c:	48 f7 f6             	div    %rsi
  100a0f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100a13:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100a18:	75 bc                	jne    1009d6 <fill_numbuf+0x38>
    return numbuf_end;
  100a1a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100a1e:	c9                   	leave  
  100a1f:	c3                   	ret    

0000000000100a20 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100a20:	55                   	push   %rbp
  100a21:	48 89 e5             	mov    %rsp,%rbp
  100a24:	53                   	push   %rbx
  100a25:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100a2c:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100a33:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100a39:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100a40:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100a47:	e9 8a 09 00 00       	jmp    1013d6 <printer_vprintf+0x9b6>
        if (*format != '%') {
  100a4c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a53:	0f b6 00             	movzbl (%rax),%eax
  100a56:	3c 25                	cmp    $0x25,%al
  100a58:	74 31                	je     100a8b <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  100a5a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100a61:	4c 8b 00             	mov    (%rax),%r8
  100a64:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a6b:	0f b6 00             	movzbl (%rax),%eax
  100a6e:	0f b6 c8             	movzbl %al,%ecx
  100a71:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100a77:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100a7e:	89 ce                	mov    %ecx,%esi
  100a80:	48 89 c7             	mov    %rax,%rdi
  100a83:	41 ff d0             	call   *%r8
            continue;
  100a86:	e9 43 09 00 00       	jmp    1013ce <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100a8b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100a92:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100a99:	01 
  100a9a:	eb 44                	jmp    100ae0 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  100a9c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100aa3:	0f b6 00             	movzbl (%rax),%eax
  100aa6:	0f be c0             	movsbl %al,%eax
  100aa9:	89 c6                	mov    %eax,%esi
  100aab:	bf 20 17 10 00       	mov    $0x101720,%edi
  100ab0:	e8 42 fe ff ff       	call   1008f7 <strchr>
  100ab5:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100ab9:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100abe:	74 30                	je     100af0 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  100ac0:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100ac4:	48 2d 20 17 10 00    	sub    $0x101720,%rax
  100aca:	ba 01 00 00 00       	mov    $0x1,%edx
  100acf:	89 c1                	mov    %eax,%ecx
  100ad1:	d3 e2                	shl    %cl,%edx
  100ad3:	89 d0                	mov    %edx,%eax
  100ad5:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100ad8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100adf:	01 
  100ae0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ae7:	0f b6 00             	movzbl (%rax),%eax
  100aea:	84 c0                	test   %al,%al
  100aec:	75 ae                	jne    100a9c <printer_vprintf+0x7c>
  100aee:	eb 01                	jmp    100af1 <printer_vprintf+0xd1>
            } else {
                break;
  100af0:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100af1:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100af8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100aff:	0f b6 00             	movzbl (%rax),%eax
  100b02:	3c 30                	cmp    $0x30,%al
  100b04:	7e 67                	jle    100b6d <printer_vprintf+0x14d>
  100b06:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b0d:	0f b6 00             	movzbl (%rax),%eax
  100b10:	3c 39                	cmp    $0x39,%al
  100b12:	7f 59                	jg     100b6d <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100b14:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100b1b:	eb 2e                	jmp    100b4b <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100b1d:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100b20:	89 d0                	mov    %edx,%eax
  100b22:	c1 e0 02             	shl    $0x2,%eax
  100b25:	01 d0                	add    %edx,%eax
  100b27:	01 c0                	add    %eax,%eax
  100b29:	89 c1                	mov    %eax,%ecx
  100b2b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b32:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100b36:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100b3d:	0f b6 00             	movzbl (%rax),%eax
  100b40:	0f be c0             	movsbl %al,%eax
  100b43:	01 c8                	add    %ecx,%eax
  100b45:	83 e8 30             	sub    $0x30,%eax
  100b48:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100b4b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b52:	0f b6 00             	movzbl (%rax),%eax
  100b55:	3c 2f                	cmp    $0x2f,%al
  100b57:	0f 8e 85 00 00 00    	jle    100be2 <printer_vprintf+0x1c2>
  100b5d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b64:	0f b6 00             	movzbl (%rax),%eax
  100b67:	3c 39                	cmp    $0x39,%al
  100b69:	7e b2                	jle    100b1d <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100b6b:	eb 75                	jmp    100be2 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100b6d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b74:	0f b6 00             	movzbl (%rax),%eax
  100b77:	3c 2a                	cmp    $0x2a,%al
  100b79:	75 68                	jne    100be3 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100b7b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b82:	8b 00                	mov    (%rax),%eax
  100b84:	83 f8 2f             	cmp    $0x2f,%eax
  100b87:	77 30                	ja     100bb9 <printer_vprintf+0x199>
  100b89:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b90:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b94:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b9b:	8b 00                	mov    (%rax),%eax
  100b9d:	89 c0                	mov    %eax,%eax
  100b9f:	48 01 d0             	add    %rdx,%rax
  100ba2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ba9:	8b 12                	mov    (%rdx),%edx
  100bab:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bae:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bb5:	89 0a                	mov    %ecx,(%rdx)
  100bb7:	eb 1a                	jmp    100bd3 <printer_vprintf+0x1b3>
  100bb9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bc0:	48 8b 40 08          	mov    0x8(%rax),%rax
  100bc4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100bc8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bcf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100bd3:	8b 00                	mov    (%rax),%eax
  100bd5:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100bd8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100bdf:	01 
  100be0:	eb 01                	jmp    100be3 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100be2:	90                   	nop
        }

        // process precision
        int precision = -1;
  100be3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100bea:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bf1:	0f b6 00             	movzbl (%rax),%eax
  100bf4:	3c 2e                	cmp    $0x2e,%al
  100bf6:	0f 85 00 01 00 00    	jne    100cfc <printer_vprintf+0x2dc>
            ++format;
  100bfc:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100c03:	01 
            if (*format >= '0' && *format <= '9') {
  100c04:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c0b:	0f b6 00             	movzbl (%rax),%eax
  100c0e:	3c 2f                	cmp    $0x2f,%al
  100c10:	7e 67                	jle    100c79 <printer_vprintf+0x259>
  100c12:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c19:	0f b6 00             	movzbl (%rax),%eax
  100c1c:	3c 39                	cmp    $0x39,%al
  100c1e:	7f 59                	jg     100c79 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100c20:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100c27:	eb 2e                	jmp    100c57 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100c29:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100c2c:	89 d0                	mov    %edx,%eax
  100c2e:	c1 e0 02             	shl    $0x2,%eax
  100c31:	01 d0                	add    %edx,%eax
  100c33:	01 c0                	add    %eax,%eax
  100c35:	89 c1                	mov    %eax,%ecx
  100c37:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c3e:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100c42:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100c49:	0f b6 00             	movzbl (%rax),%eax
  100c4c:	0f be c0             	movsbl %al,%eax
  100c4f:	01 c8                	add    %ecx,%eax
  100c51:	83 e8 30             	sub    $0x30,%eax
  100c54:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100c57:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c5e:	0f b6 00             	movzbl (%rax),%eax
  100c61:	3c 2f                	cmp    $0x2f,%al
  100c63:	0f 8e 85 00 00 00    	jle    100cee <printer_vprintf+0x2ce>
  100c69:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c70:	0f b6 00             	movzbl (%rax),%eax
  100c73:	3c 39                	cmp    $0x39,%al
  100c75:	7e b2                	jle    100c29 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100c77:	eb 75                	jmp    100cee <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100c79:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c80:	0f b6 00             	movzbl (%rax),%eax
  100c83:	3c 2a                	cmp    $0x2a,%al
  100c85:	75 68                	jne    100cef <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100c87:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c8e:	8b 00                	mov    (%rax),%eax
  100c90:	83 f8 2f             	cmp    $0x2f,%eax
  100c93:	77 30                	ja     100cc5 <printer_vprintf+0x2a5>
  100c95:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c9c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ca0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ca7:	8b 00                	mov    (%rax),%eax
  100ca9:	89 c0                	mov    %eax,%eax
  100cab:	48 01 d0             	add    %rdx,%rax
  100cae:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cb5:	8b 12                	mov    (%rdx),%edx
  100cb7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100cba:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cc1:	89 0a                	mov    %ecx,(%rdx)
  100cc3:	eb 1a                	jmp    100cdf <printer_vprintf+0x2bf>
  100cc5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ccc:	48 8b 40 08          	mov    0x8(%rax),%rax
  100cd0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100cd4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cdb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100cdf:	8b 00                	mov    (%rax),%eax
  100ce1:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100ce4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ceb:	01 
  100cec:	eb 01                	jmp    100cef <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100cee:	90                   	nop
            }
            if (precision < 0) {
  100cef:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100cf3:	79 07                	jns    100cfc <printer_vprintf+0x2dc>
                precision = 0;
  100cf5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100cfc:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100d03:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100d0a:	00 
        int length = 0;
  100d0b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100d12:	48 c7 45 c8 26 17 10 	movq   $0x101726,-0x38(%rbp)
  100d19:	00 
    again:
        switch (*format) {
  100d1a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d21:	0f b6 00             	movzbl (%rax),%eax
  100d24:	0f be c0             	movsbl %al,%eax
  100d27:	83 e8 43             	sub    $0x43,%eax
  100d2a:	83 f8 37             	cmp    $0x37,%eax
  100d2d:	0f 87 9f 03 00 00    	ja     1010d2 <printer_vprintf+0x6b2>
  100d33:	89 c0                	mov    %eax,%eax
  100d35:	48 8b 04 c5 38 17 10 	mov    0x101738(,%rax,8),%rax
  100d3c:	00 
  100d3d:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100d3f:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100d46:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100d4d:	01 
            goto again;
  100d4e:	eb ca                	jmp    100d1a <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100d50:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100d54:	74 5d                	je     100db3 <printer_vprintf+0x393>
  100d56:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d5d:	8b 00                	mov    (%rax),%eax
  100d5f:	83 f8 2f             	cmp    $0x2f,%eax
  100d62:	77 30                	ja     100d94 <printer_vprintf+0x374>
  100d64:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d6b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d6f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d76:	8b 00                	mov    (%rax),%eax
  100d78:	89 c0                	mov    %eax,%eax
  100d7a:	48 01 d0             	add    %rdx,%rax
  100d7d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d84:	8b 12                	mov    (%rdx),%edx
  100d86:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d89:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d90:	89 0a                	mov    %ecx,(%rdx)
  100d92:	eb 1a                	jmp    100dae <printer_vprintf+0x38e>
  100d94:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d9b:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d9f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100da3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100daa:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100dae:	48 8b 00             	mov    (%rax),%rax
  100db1:	eb 5c                	jmp    100e0f <printer_vprintf+0x3ef>
  100db3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dba:	8b 00                	mov    (%rax),%eax
  100dbc:	83 f8 2f             	cmp    $0x2f,%eax
  100dbf:	77 30                	ja     100df1 <printer_vprintf+0x3d1>
  100dc1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dc8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100dcc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dd3:	8b 00                	mov    (%rax),%eax
  100dd5:	89 c0                	mov    %eax,%eax
  100dd7:	48 01 d0             	add    %rdx,%rax
  100dda:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100de1:	8b 12                	mov    (%rdx),%edx
  100de3:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100de6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ded:	89 0a                	mov    %ecx,(%rdx)
  100def:	eb 1a                	jmp    100e0b <printer_vprintf+0x3eb>
  100df1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100df8:	48 8b 40 08          	mov    0x8(%rax),%rax
  100dfc:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e00:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e07:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e0b:	8b 00                	mov    (%rax),%eax
  100e0d:	48 98                	cltq   
  100e0f:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100e13:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100e17:	48 c1 f8 38          	sar    $0x38,%rax
  100e1b:	25 80 00 00 00       	and    $0x80,%eax
  100e20:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100e23:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100e27:	74 09                	je     100e32 <printer_vprintf+0x412>
  100e29:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100e2d:	48 f7 d8             	neg    %rax
  100e30:	eb 04                	jmp    100e36 <printer_vprintf+0x416>
  100e32:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100e36:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100e3a:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100e3d:	83 c8 60             	or     $0x60,%eax
  100e40:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100e43:	e9 cf 02 00 00       	jmp    101117 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100e48:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100e4c:	74 5d                	je     100eab <printer_vprintf+0x48b>
  100e4e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e55:	8b 00                	mov    (%rax),%eax
  100e57:	83 f8 2f             	cmp    $0x2f,%eax
  100e5a:	77 30                	ja     100e8c <printer_vprintf+0x46c>
  100e5c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e63:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e67:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e6e:	8b 00                	mov    (%rax),%eax
  100e70:	89 c0                	mov    %eax,%eax
  100e72:	48 01 d0             	add    %rdx,%rax
  100e75:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e7c:	8b 12                	mov    (%rdx),%edx
  100e7e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e81:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e88:	89 0a                	mov    %ecx,(%rdx)
  100e8a:	eb 1a                	jmp    100ea6 <printer_vprintf+0x486>
  100e8c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e93:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e97:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e9b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ea2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ea6:	48 8b 00             	mov    (%rax),%rax
  100ea9:	eb 5c                	jmp    100f07 <printer_vprintf+0x4e7>
  100eab:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100eb2:	8b 00                	mov    (%rax),%eax
  100eb4:	83 f8 2f             	cmp    $0x2f,%eax
  100eb7:	77 30                	ja     100ee9 <printer_vprintf+0x4c9>
  100eb9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ec0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ec4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ecb:	8b 00                	mov    (%rax),%eax
  100ecd:	89 c0                	mov    %eax,%eax
  100ecf:	48 01 d0             	add    %rdx,%rax
  100ed2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ed9:	8b 12                	mov    (%rdx),%edx
  100edb:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ede:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ee5:	89 0a                	mov    %ecx,(%rdx)
  100ee7:	eb 1a                	jmp    100f03 <printer_vprintf+0x4e3>
  100ee9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ef0:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ef4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ef8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100eff:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f03:	8b 00                	mov    (%rax),%eax
  100f05:	89 c0                	mov    %eax,%eax
  100f07:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100f0b:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100f0f:	e9 03 02 00 00       	jmp    101117 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100f14:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100f1b:	e9 28 ff ff ff       	jmp    100e48 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100f20:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100f27:	e9 1c ff ff ff       	jmp    100e48 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100f2c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f33:	8b 00                	mov    (%rax),%eax
  100f35:	83 f8 2f             	cmp    $0x2f,%eax
  100f38:	77 30                	ja     100f6a <printer_vprintf+0x54a>
  100f3a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f41:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100f45:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f4c:	8b 00                	mov    (%rax),%eax
  100f4e:	89 c0                	mov    %eax,%eax
  100f50:	48 01 d0             	add    %rdx,%rax
  100f53:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f5a:	8b 12                	mov    (%rdx),%edx
  100f5c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100f5f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f66:	89 0a                	mov    %ecx,(%rdx)
  100f68:	eb 1a                	jmp    100f84 <printer_vprintf+0x564>
  100f6a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f71:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f75:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f79:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f80:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f84:	48 8b 00             	mov    (%rax),%rax
  100f87:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100f8b:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100f92:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100f99:	e9 79 01 00 00       	jmp    101117 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100f9e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fa5:	8b 00                	mov    (%rax),%eax
  100fa7:	83 f8 2f             	cmp    $0x2f,%eax
  100faa:	77 30                	ja     100fdc <printer_vprintf+0x5bc>
  100fac:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fb3:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100fb7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fbe:	8b 00                	mov    (%rax),%eax
  100fc0:	89 c0                	mov    %eax,%eax
  100fc2:	48 01 d0             	add    %rdx,%rax
  100fc5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fcc:	8b 12                	mov    (%rdx),%edx
  100fce:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100fd1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fd8:	89 0a                	mov    %ecx,(%rdx)
  100fda:	eb 1a                	jmp    100ff6 <printer_vprintf+0x5d6>
  100fdc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fe3:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fe7:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100feb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ff2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ff6:	48 8b 00             	mov    (%rax),%rax
  100ff9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100ffd:	e9 15 01 00 00       	jmp    101117 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  101002:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101009:	8b 00                	mov    (%rax),%eax
  10100b:	83 f8 2f             	cmp    $0x2f,%eax
  10100e:	77 30                	ja     101040 <printer_vprintf+0x620>
  101010:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101017:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10101b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101022:	8b 00                	mov    (%rax),%eax
  101024:	89 c0                	mov    %eax,%eax
  101026:	48 01 d0             	add    %rdx,%rax
  101029:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101030:	8b 12                	mov    (%rdx),%edx
  101032:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101035:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10103c:	89 0a                	mov    %ecx,(%rdx)
  10103e:	eb 1a                	jmp    10105a <printer_vprintf+0x63a>
  101040:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101047:	48 8b 40 08          	mov    0x8(%rax),%rax
  10104b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10104f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101056:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10105a:	8b 00                	mov    (%rax),%eax
  10105c:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  101062:	e9 67 03 00 00       	jmp    1013ce <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  101067:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  10106b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  10106f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101076:	8b 00                	mov    (%rax),%eax
  101078:	83 f8 2f             	cmp    $0x2f,%eax
  10107b:	77 30                	ja     1010ad <printer_vprintf+0x68d>
  10107d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101084:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101088:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10108f:	8b 00                	mov    (%rax),%eax
  101091:	89 c0                	mov    %eax,%eax
  101093:	48 01 d0             	add    %rdx,%rax
  101096:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10109d:	8b 12                	mov    (%rdx),%edx
  10109f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1010a2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010a9:	89 0a                	mov    %ecx,(%rdx)
  1010ab:	eb 1a                	jmp    1010c7 <printer_vprintf+0x6a7>
  1010ad:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010b4:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010b8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1010bc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010c3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1010c7:	8b 00                	mov    (%rax),%eax
  1010c9:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  1010cc:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  1010d0:	eb 45                	jmp    101117 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  1010d2:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1010d6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  1010da:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1010e1:	0f b6 00             	movzbl (%rax),%eax
  1010e4:	84 c0                	test   %al,%al
  1010e6:	74 0c                	je     1010f4 <printer_vprintf+0x6d4>
  1010e8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1010ef:	0f b6 00             	movzbl (%rax),%eax
  1010f2:	eb 05                	jmp    1010f9 <printer_vprintf+0x6d9>
  1010f4:	b8 25 00 00 00       	mov    $0x25,%eax
  1010f9:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  1010fc:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  101100:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101107:	0f b6 00             	movzbl (%rax),%eax
  10110a:	84 c0                	test   %al,%al
  10110c:	75 08                	jne    101116 <printer_vprintf+0x6f6>
                format--;
  10110e:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  101115:	01 
            }
            break;
  101116:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  101117:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10111a:	83 e0 20             	and    $0x20,%eax
  10111d:	85 c0                	test   %eax,%eax
  10111f:	74 1e                	je     10113f <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  101121:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101125:	48 83 c0 18          	add    $0x18,%rax
  101129:	8b 55 e0             	mov    -0x20(%rbp),%edx
  10112c:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101130:	48 89 ce             	mov    %rcx,%rsi
  101133:	48 89 c7             	mov    %rax,%rdi
  101136:	e8 63 f8 ff ff       	call   10099e <fill_numbuf>
  10113b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  10113f:	48 c7 45 c0 26 17 10 	movq   $0x101726,-0x40(%rbp)
  101146:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  101147:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10114a:	83 e0 20             	and    $0x20,%eax
  10114d:	85 c0                	test   %eax,%eax
  10114f:	74 48                	je     101199 <printer_vprintf+0x779>
  101151:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101154:	83 e0 40             	and    $0x40,%eax
  101157:	85 c0                	test   %eax,%eax
  101159:	74 3e                	je     101199 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  10115b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10115e:	25 80 00 00 00       	and    $0x80,%eax
  101163:	85 c0                	test   %eax,%eax
  101165:	74 0a                	je     101171 <printer_vprintf+0x751>
                prefix = "-";
  101167:	48 c7 45 c0 27 17 10 	movq   $0x101727,-0x40(%rbp)
  10116e:	00 
            if (flags & FLAG_NEGATIVE) {
  10116f:	eb 73                	jmp    1011e4 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  101171:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101174:	83 e0 10             	and    $0x10,%eax
  101177:	85 c0                	test   %eax,%eax
  101179:	74 0a                	je     101185 <printer_vprintf+0x765>
                prefix = "+";
  10117b:	48 c7 45 c0 29 17 10 	movq   $0x101729,-0x40(%rbp)
  101182:	00 
            if (flags & FLAG_NEGATIVE) {
  101183:	eb 5f                	jmp    1011e4 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  101185:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101188:	83 e0 08             	and    $0x8,%eax
  10118b:	85 c0                	test   %eax,%eax
  10118d:	74 55                	je     1011e4 <printer_vprintf+0x7c4>
                prefix = " ";
  10118f:	48 c7 45 c0 2b 17 10 	movq   $0x10172b,-0x40(%rbp)
  101196:	00 
            if (flags & FLAG_NEGATIVE) {
  101197:	eb 4b                	jmp    1011e4 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  101199:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10119c:	83 e0 20             	and    $0x20,%eax
  10119f:	85 c0                	test   %eax,%eax
  1011a1:	74 42                	je     1011e5 <printer_vprintf+0x7c5>
  1011a3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011a6:	83 e0 01             	and    $0x1,%eax
  1011a9:	85 c0                	test   %eax,%eax
  1011ab:	74 38                	je     1011e5 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  1011ad:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  1011b1:	74 06                	je     1011b9 <printer_vprintf+0x799>
  1011b3:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1011b7:	75 2c                	jne    1011e5 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  1011b9:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1011be:	75 0c                	jne    1011cc <printer_vprintf+0x7ac>
  1011c0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011c3:	25 00 01 00 00       	and    $0x100,%eax
  1011c8:	85 c0                	test   %eax,%eax
  1011ca:	74 19                	je     1011e5 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  1011cc:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1011d0:	75 07                	jne    1011d9 <printer_vprintf+0x7b9>
  1011d2:	b8 2d 17 10 00       	mov    $0x10172d,%eax
  1011d7:	eb 05                	jmp    1011de <printer_vprintf+0x7be>
  1011d9:	b8 30 17 10 00       	mov    $0x101730,%eax
  1011de:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1011e2:	eb 01                	jmp    1011e5 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  1011e4:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  1011e5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1011e9:	78 24                	js     10120f <printer_vprintf+0x7ef>
  1011eb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011ee:	83 e0 20             	and    $0x20,%eax
  1011f1:	85 c0                	test   %eax,%eax
  1011f3:	75 1a                	jne    10120f <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  1011f5:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1011f8:	48 63 d0             	movslq %eax,%rdx
  1011fb:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1011ff:	48 89 d6             	mov    %rdx,%rsi
  101202:	48 89 c7             	mov    %rax,%rdi
  101205:	e8 ea f5 ff ff       	call   1007f4 <strnlen>
  10120a:	89 45 bc             	mov    %eax,-0x44(%rbp)
  10120d:	eb 0f                	jmp    10121e <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  10120f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101213:	48 89 c7             	mov    %rax,%rdi
  101216:	e8 a8 f5 ff ff       	call   1007c3 <strlen>
  10121b:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  10121e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101221:	83 e0 20             	and    $0x20,%eax
  101224:	85 c0                	test   %eax,%eax
  101226:	74 20                	je     101248 <printer_vprintf+0x828>
  101228:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  10122c:	78 1a                	js     101248 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  10122e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101231:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  101234:	7e 08                	jle    10123e <printer_vprintf+0x81e>
  101236:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101239:	2b 45 bc             	sub    -0x44(%rbp),%eax
  10123c:	eb 05                	jmp    101243 <printer_vprintf+0x823>
  10123e:	b8 00 00 00 00       	mov    $0x0,%eax
  101243:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101246:	eb 5c                	jmp    1012a4 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  101248:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10124b:	83 e0 20             	and    $0x20,%eax
  10124e:	85 c0                	test   %eax,%eax
  101250:	74 4b                	je     10129d <printer_vprintf+0x87d>
  101252:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101255:	83 e0 02             	and    $0x2,%eax
  101258:	85 c0                	test   %eax,%eax
  10125a:	74 41                	je     10129d <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  10125c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10125f:	83 e0 04             	and    $0x4,%eax
  101262:	85 c0                	test   %eax,%eax
  101264:	75 37                	jne    10129d <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  101266:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10126a:	48 89 c7             	mov    %rax,%rdi
  10126d:	e8 51 f5 ff ff       	call   1007c3 <strlen>
  101272:	89 c2                	mov    %eax,%edx
  101274:	8b 45 bc             	mov    -0x44(%rbp),%eax
  101277:	01 d0                	add    %edx,%eax
  101279:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  10127c:	7e 1f                	jle    10129d <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  10127e:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101281:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101284:	89 c3                	mov    %eax,%ebx
  101286:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10128a:	48 89 c7             	mov    %rax,%rdi
  10128d:	e8 31 f5 ff ff       	call   1007c3 <strlen>
  101292:	89 c2                	mov    %eax,%edx
  101294:	89 d8                	mov    %ebx,%eax
  101296:	29 d0                	sub    %edx,%eax
  101298:	89 45 b8             	mov    %eax,-0x48(%rbp)
  10129b:	eb 07                	jmp    1012a4 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  10129d:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  1012a4:	8b 55 bc             	mov    -0x44(%rbp),%edx
  1012a7:	8b 45 b8             	mov    -0x48(%rbp),%eax
  1012aa:	01 d0                	add    %edx,%eax
  1012ac:	48 63 d8             	movslq %eax,%rbx
  1012af:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1012b3:	48 89 c7             	mov    %rax,%rdi
  1012b6:	e8 08 f5 ff ff       	call   1007c3 <strlen>
  1012bb:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  1012bf:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1012c2:	29 d0                	sub    %edx,%eax
  1012c4:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1012c7:	eb 25                	jmp    1012ee <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  1012c9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012d0:	48 8b 08             	mov    (%rax),%rcx
  1012d3:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1012d9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012e0:	be 20 00 00 00       	mov    $0x20,%esi
  1012e5:	48 89 c7             	mov    %rax,%rdi
  1012e8:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1012ea:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1012ee:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1012f1:	83 e0 04             	and    $0x4,%eax
  1012f4:	85 c0                	test   %eax,%eax
  1012f6:	75 36                	jne    10132e <printer_vprintf+0x90e>
  1012f8:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1012fc:	7f cb                	jg     1012c9 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  1012fe:	eb 2e                	jmp    10132e <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  101300:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101307:	4c 8b 00             	mov    (%rax),%r8
  10130a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10130e:	0f b6 00             	movzbl (%rax),%eax
  101311:	0f b6 c8             	movzbl %al,%ecx
  101314:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10131a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101321:	89 ce                	mov    %ecx,%esi
  101323:	48 89 c7             	mov    %rax,%rdi
  101326:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  101329:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  10132e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101332:	0f b6 00             	movzbl (%rax),%eax
  101335:	84 c0                	test   %al,%al
  101337:	75 c7                	jne    101300 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  101339:	eb 25                	jmp    101360 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  10133b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101342:	48 8b 08             	mov    (%rax),%rcx
  101345:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10134b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101352:	be 30 00 00 00       	mov    $0x30,%esi
  101357:	48 89 c7             	mov    %rax,%rdi
  10135a:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  10135c:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  101360:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  101364:	7f d5                	jg     10133b <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  101366:	eb 32                	jmp    10139a <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  101368:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10136f:	4c 8b 00             	mov    (%rax),%r8
  101372:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101376:	0f b6 00             	movzbl (%rax),%eax
  101379:	0f b6 c8             	movzbl %al,%ecx
  10137c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101382:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101389:	89 ce                	mov    %ecx,%esi
  10138b:	48 89 c7             	mov    %rax,%rdi
  10138e:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  101391:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  101396:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  10139a:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  10139e:	7f c8                	jg     101368 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  1013a0:	eb 25                	jmp    1013c7 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  1013a2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1013a9:	48 8b 08             	mov    (%rax),%rcx
  1013ac:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1013b2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1013b9:	be 20 00 00 00       	mov    $0x20,%esi
  1013be:	48 89 c7             	mov    %rax,%rdi
  1013c1:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  1013c3:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1013c7:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1013cb:	7f d5                	jg     1013a2 <printer_vprintf+0x982>
        }
    done: ;
  1013cd:	90                   	nop
    for (; *format; ++format) {
  1013ce:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1013d5:	01 
  1013d6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1013dd:	0f b6 00             	movzbl (%rax),%eax
  1013e0:	84 c0                	test   %al,%al
  1013e2:	0f 85 64 f6 ff ff    	jne    100a4c <printer_vprintf+0x2c>
    }
}
  1013e8:	90                   	nop
  1013e9:	90                   	nop
  1013ea:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1013ee:	c9                   	leave  
  1013ef:	c3                   	ret    

00000000001013f0 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1013f0:	55                   	push   %rbp
  1013f1:	48 89 e5             	mov    %rsp,%rbp
  1013f4:	48 83 ec 20          	sub    $0x20,%rsp
  1013f8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1013fc:	89 f0                	mov    %esi,%eax
  1013fe:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101401:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  101404:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101408:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10140c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101410:	48 8b 40 08          	mov    0x8(%rax),%rax
  101414:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  101419:	48 39 d0             	cmp    %rdx,%rax
  10141c:	72 0c                	jb     10142a <console_putc+0x3a>
        cp->cursor = console;
  10141e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101422:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  101429:	00 
    }
    if (c == '\n') {
  10142a:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  10142e:	75 78                	jne    1014a8 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  101430:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101434:	48 8b 40 08          	mov    0x8(%rax),%rax
  101438:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  10143e:	48 d1 f8             	sar    %rax
  101441:	48 89 c1             	mov    %rax,%rcx
  101444:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  10144b:	66 66 66 
  10144e:	48 89 c8             	mov    %rcx,%rax
  101451:	48 f7 ea             	imul   %rdx
  101454:	48 c1 fa 05          	sar    $0x5,%rdx
  101458:	48 89 c8             	mov    %rcx,%rax
  10145b:	48 c1 f8 3f          	sar    $0x3f,%rax
  10145f:	48 29 c2             	sub    %rax,%rdx
  101462:	48 89 d0             	mov    %rdx,%rax
  101465:	48 c1 e0 02          	shl    $0x2,%rax
  101469:	48 01 d0             	add    %rdx,%rax
  10146c:	48 c1 e0 04          	shl    $0x4,%rax
  101470:	48 29 c1             	sub    %rax,%rcx
  101473:	48 89 ca             	mov    %rcx,%rdx
  101476:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101479:	eb 25                	jmp    1014a0 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  10147b:	8b 45 e0             	mov    -0x20(%rbp),%eax
  10147e:	83 c8 20             	or     $0x20,%eax
  101481:	89 c6                	mov    %eax,%esi
  101483:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101487:	48 8b 40 08          	mov    0x8(%rax),%rax
  10148b:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10148f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101493:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101497:	89 f2                	mov    %esi,%edx
  101499:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  10149c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1014a0:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  1014a4:	75 d5                	jne    10147b <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  1014a6:	eb 24                	jmp    1014cc <console_putc+0xdc>
        *cp->cursor++ = c | color;
  1014a8:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  1014ac:	8b 55 e0             	mov    -0x20(%rbp),%edx
  1014af:	09 d0                	or     %edx,%eax
  1014b1:	89 c6                	mov    %eax,%esi
  1014b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1014b7:	48 8b 40 08          	mov    0x8(%rax),%rax
  1014bb:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1014bf:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1014c3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1014c7:	89 f2                	mov    %esi,%edx
  1014c9:	66 89 10             	mov    %dx,(%rax)
}
  1014cc:	90                   	nop
  1014cd:	c9                   	leave  
  1014ce:	c3                   	ret    

00000000001014cf <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1014cf:	55                   	push   %rbp
  1014d0:	48 89 e5             	mov    %rsp,%rbp
  1014d3:	48 83 ec 30          	sub    $0x30,%rsp
  1014d7:	89 7d ec             	mov    %edi,-0x14(%rbp)
  1014da:	89 75 e8             	mov    %esi,-0x18(%rbp)
  1014dd:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1014e1:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  1014e5:	48 c7 45 f0 f0 13 10 	movq   $0x1013f0,-0x10(%rbp)
  1014ec:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1014ed:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  1014f1:	78 09                	js     1014fc <console_vprintf+0x2d>
  1014f3:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  1014fa:	7e 07                	jle    101503 <console_vprintf+0x34>
        cpos = 0;
  1014fc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  101503:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101506:	48 98                	cltq   
  101508:	48 01 c0             	add    %rax,%rax
  10150b:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  101511:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101515:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101519:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  10151d:	8b 75 e8             	mov    -0x18(%rbp),%esi
  101520:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101524:	48 89 c7             	mov    %rax,%rdi
  101527:	e8 f4 f4 ff ff       	call   100a20 <printer_vprintf>
    return cp.cursor - console;
  10152c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101530:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  101536:	48 d1 f8             	sar    %rax
}
  101539:	c9                   	leave  
  10153a:	c3                   	ret    

000000000010153b <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  10153b:	55                   	push   %rbp
  10153c:	48 89 e5             	mov    %rsp,%rbp
  10153f:	48 83 ec 60          	sub    $0x60,%rsp
  101543:	89 7d ac             	mov    %edi,-0x54(%rbp)
  101546:	89 75 a8             	mov    %esi,-0x58(%rbp)
  101549:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  10154d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101551:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101555:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101559:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101560:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101564:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101568:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10156c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101570:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101574:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101578:	8b 75 a8             	mov    -0x58(%rbp),%esi
  10157b:	8b 45 ac             	mov    -0x54(%rbp),%eax
  10157e:	89 c7                	mov    %eax,%edi
  101580:	e8 4a ff ff ff       	call   1014cf <console_vprintf>
  101585:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101588:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  10158b:	c9                   	leave  
  10158c:	c3                   	ret    

000000000010158d <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  10158d:	55                   	push   %rbp
  10158e:	48 89 e5             	mov    %rsp,%rbp
  101591:	48 83 ec 20          	sub    $0x20,%rsp
  101595:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101599:	89 f0                	mov    %esi,%eax
  10159b:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10159e:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  1015a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1015a5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  1015a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1015ad:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1015b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1015b5:	48 8b 40 10          	mov    0x10(%rax),%rax
  1015b9:	48 39 c2             	cmp    %rax,%rdx
  1015bc:	73 1a                	jae    1015d8 <string_putc+0x4b>
        *sp->s++ = c;
  1015be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1015c2:	48 8b 40 08          	mov    0x8(%rax),%rax
  1015c6:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1015ca:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1015ce:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1015d2:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1015d6:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1015d8:	90                   	nop
  1015d9:	c9                   	leave  
  1015da:	c3                   	ret    

00000000001015db <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1015db:	55                   	push   %rbp
  1015dc:	48 89 e5             	mov    %rsp,%rbp
  1015df:	48 83 ec 40          	sub    $0x40,%rsp
  1015e3:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  1015e7:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  1015eb:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  1015ef:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1015f3:	48 c7 45 e8 8d 15 10 	movq   $0x10158d,-0x18(%rbp)
  1015fa:	00 
    sp.s = s;
  1015fb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1015ff:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  101603:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  101608:	74 33                	je     10163d <vsnprintf+0x62>
        sp.end = s + size - 1;
  10160a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  10160e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101612:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101616:	48 01 d0             	add    %rdx,%rax
  101619:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  10161d:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101621:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101625:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101629:	be 00 00 00 00       	mov    $0x0,%esi
  10162e:	48 89 c7             	mov    %rax,%rdi
  101631:	e8 ea f3 ff ff       	call   100a20 <printer_vprintf>
        *sp.s = 0;
  101636:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10163a:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  10163d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101641:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  101645:	c9                   	leave  
  101646:	c3                   	ret    

0000000000101647 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  101647:	55                   	push   %rbp
  101648:	48 89 e5             	mov    %rsp,%rbp
  10164b:	48 83 ec 70          	sub    $0x70,%rsp
  10164f:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101653:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  101657:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  10165b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10165f:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101663:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101667:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  10166e:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101672:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101676:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10167a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  10167e:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101682:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101686:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  10168a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10168e:	48 89 c7             	mov    %rax,%rdi
  101691:	e8 45 ff ff ff       	call   1015db <vsnprintf>
  101696:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101699:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  10169c:	c9                   	leave  
  10169d:	c3                   	ret    

000000000010169e <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  10169e:	55                   	push   %rbp
  10169f:	48 89 e5             	mov    %rsp,%rbp
  1016a2:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1016a6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  1016ad:	eb 13                	jmp    1016c2 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  1016af:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1016b2:	48 98                	cltq   
  1016b4:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  1016bb:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1016be:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1016c2:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1016c9:	7e e4                	jle    1016af <console_clear+0x11>
    }
    cursorpos = 0;
  1016cb:	c7 05 27 79 fb ff 00 	movl   $0x0,-0x486d9(%rip)        # b8ffc <cursorpos>
  1016d2:	00 00 00 
}
  1016d5:	90                   	nop
  1016d6:	c9                   	leave  
  1016d7:	c3                   	ret    
