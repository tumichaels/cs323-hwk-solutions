
obj/kernel.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000040000 <entry_from_boot>:
# The entry_from_boot routine sets the stack pointer to the top of the
# OS kernel stack, then jumps to the `kernel` routine.

.globl entry_from_boot
entry_from_boot:
        movq $0x80000, %rsp
   40000:	48 c7 c4 00 00 08 00 	mov    $0x80000,%rsp
        movq %rsp, %rbp
   40007:	48 89 e5             	mov    %rsp,%rbp
        pushq $0
   4000a:	6a 00                	push   $0x0
        popfq
   4000c:	9d                   	popf   
        // Check for multiboot command line; if found pass it along.
        cmpl $0x2BADB002, %eax
   4000d:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
        jne 1f
   40012:	75 0d                	jne    40021 <entry_from_boot+0x21>
        testl $4, (%rbx)
   40014:	f7 03 04 00 00 00    	testl  $0x4,(%rbx)
        je 1f
   4001a:	74 05                	je     40021 <entry_from_boot+0x21>
        movl 16(%rbx), %edi
   4001c:	8b 7b 10             	mov    0x10(%rbx),%edi
        jmp 2f
   4001f:	eb 07                	jmp    40028 <entry_from_boot+0x28>
1:      movq $0, %rdi
   40021:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
2:      jmp kernel
   40028:	e9 3a 01 00 00       	jmp    40167 <kernel>
   4002d:	90                   	nop

000000000004002e <gpf_int_handler>:
# Interrupt handlers
.align 2

        .globl gpf_int_handler
gpf_int_handler:
        pushq $13               // trap number
   4002e:	6a 0d                	push   $0xd
        jmp generic_exception_handler
   40030:	eb 6e                	jmp    400a0 <generic_exception_handler>

0000000000040032 <pagefault_int_handler>:

        .globl pagefault_int_handler
pagefault_int_handler:
        pushq $14
   40032:	6a 0e                	push   $0xe
        jmp generic_exception_handler
   40034:	eb 6a                	jmp    400a0 <generic_exception_handler>

0000000000040036 <timer_int_handler>:

        .globl timer_int_handler
timer_int_handler:
        pushq $0                // error code
   40036:	6a 00                	push   $0x0
        pushq $32
   40038:	6a 20                	push   $0x20
        jmp generic_exception_handler
   4003a:	eb 64                	jmp    400a0 <generic_exception_handler>

000000000004003c <sys48_int_handler>:

sys48_int_handler:
        pushq $0
   4003c:	6a 00                	push   $0x0
        pushq $48
   4003e:	6a 30                	push   $0x30
        jmp generic_exception_handler
   40040:	eb 5e                	jmp    400a0 <generic_exception_handler>

0000000000040042 <sys49_int_handler>:

sys49_int_handler:
        pushq $0
   40042:	6a 00                	push   $0x0
        pushq $49
   40044:	6a 31                	push   $0x31
        jmp generic_exception_handler
   40046:	eb 58                	jmp    400a0 <generic_exception_handler>

0000000000040048 <sys50_int_handler>:

sys50_int_handler:
        pushq $0
   40048:	6a 00                	push   $0x0
        pushq $50
   4004a:	6a 32                	push   $0x32
        jmp generic_exception_handler
   4004c:	eb 52                	jmp    400a0 <generic_exception_handler>

000000000004004e <sys51_int_handler>:

sys51_int_handler:
        pushq $0
   4004e:	6a 00                	push   $0x0
        pushq $51
   40050:	6a 33                	push   $0x33
        jmp generic_exception_handler
   40052:	eb 4c                	jmp    400a0 <generic_exception_handler>

0000000000040054 <sys52_int_handler>:

sys52_int_handler:
        pushq $0
   40054:	6a 00                	push   $0x0
        pushq $52
   40056:	6a 34                	push   $0x34
        jmp generic_exception_handler
   40058:	eb 46                	jmp    400a0 <generic_exception_handler>

000000000004005a <sys53_int_handler>:

sys53_int_handler:
        pushq $0
   4005a:	6a 00                	push   $0x0
        pushq $53
   4005c:	6a 35                	push   $0x35
        jmp generic_exception_handler
   4005e:	eb 40                	jmp    400a0 <generic_exception_handler>

0000000000040060 <sys54_int_handler>:

sys54_int_handler:
        pushq $0
   40060:	6a 00                	push   $0x0
        pushq $54
   40062:	6a 36                	push   $0x36
        jmp generic_exception_handler
   40064:	eb 3a                	jmp    400a0 <generic_exception_handler>

0000000000040066 <sys55_int_handler>:

sys55_int_handler:
        pushq $0
   40066:	6a 00                	push   $0x0
        pushq $55
   40068:	6a 37                	push   $0x37
        jmp generic_exception_handler
   4006a:	eb 34                	jmp    400a0 <generic_exception_handler>

000000000004006c <sys56_int_handler>:

sys56_int_handler:
        pushq $0
   4006c:	6a 00                	push   $0x0
        pushq $56
   4006e:	6a 38                	push   $0x38
        jmp generic_exception_handler
   40070:	eb 2e                	jmp    400a0 <generic_exception_handler>

0000000000040072 <sys57_int_handler>:

sys57_int_handler:
        pushq $0
   40072:	6a 00                	push   $0x0
        pushq $57
   40074:	6a 39                	push   $0x39
        jmp generic_exception_handler
   40076:	eb 28                	jmp    400a0 <generic_exception_handler>

0000000000040078 <sys58_int_handler>:

sys58_int_handler:
        pushq $0
   40078:	6a 00                	push   $0x0
        pushq $58
   4007a:	6a 3a                	push   $0x3a
        jmp generic_exception_handler
   4007c:	eb 22                	jmp    400a0 <generic_exception_handler>

000000000004007e <sys59_int_handler>:

sys59_int_handler:
        pushq $0
   4007e:	6a 00                	push   $0x0
        pushq $59
   40080:	6a 3b                	push   $0x3b
        jmp generic_exception_handler
   40082:	eb 1c                	jmp    400a0 <generic_exception_handler>

0000000000040084 <sys60_int_handler>:

sys60_int_handler:
        pushq $0
   40084:	6a 00                	push   $0x0
        pushq $60
   40086:	6a 3c                	push   $0x3c
        jmp generic_exception_handler
   40088:	eb 16                	jmp    400a0 <generic_exception_handler>

000000000004008a <sys61_int_handler>:

sys61_int_handler:
        pushq $0
   4008a:	6a 00                	push   $0x0
        pushq $61
   4008c:	6a 3d                	push   $0x3d
        jmp generic_exception_handler
   4008e:	eb 10                	jmp    400a0 <generic_exception_handler>

0000000000040090 <sys62_int_handler>:

sys62_int_handler:
        pushq $0
   40090:	6a 00                	push   $0x0
        pushq $62
   40092:	6a 3e                	push   $0x3e
        jmp generic_exception_handler
   40094:	eb 0a                	jmp    400a0 <generic_exception_handler>

0000000000040096 <sys63_int_handler>:

sys63_int_handler:
        pushq $0
   40096:	6a 00                	push   $0x0
        pushq $63
   40098:	6a 3f                	push   $0x3f
        jmp generic_exception_handler
   4009a:	eb 04                	jmp    400a0 <generic_exception_handler>

000000000004009c <default_int_handler>:

        .globl default_int_handler
default_int_handler:
        pushq $0
   4009c:	6a 00                	push   $0x0
        jmp generic_exception_handler
   4009e:	eb 00                	jmp    400a0 <generic_exception_handler>

00000000000400a0 <generic_exception_handler>:


generic_exception_handler:
        pushq %gs
   400a0:	0f a8                	push   %gs
        pushq %fs
   400a2:	0f a0                	push   %fs
        pushq %r15
   400a4:	41 57                	push   %r15
        pushq %r14
   400a6:	41 56                	push   %r14
        pushq %r13
   400a8:	41 55                	push   %r13
        pushq %r12
   400aa:	41 54                	push   %r12
        pushq %r11
   400ac:	41 53                	push   %r11
        pushq %r10
   400ae:	41 52                	push   %r10
        pushq %r9
   400b0:	41 51                	push   %r9
        pushq %r8
   400b2:	41 50                	push   %r8
        pushq %rdi
   400b4:	57                   	push   %rdi
        pushq %rsi
   400b5:	56                   	push   %rsi
        pushq %rbp
   400b6:	55                   	push   %rbp
        pushq %rbx
   400b7:	53                   	push   %rbx
        pushq %rdx
   400b8:	52                   	push   %rdx
        pushq %rcx
   400b9:	51                   	push   %rcx
        pushq %rax
   400ba:	50                   	push   %rax
        movq %rsp, %rdi
   400bb:	48 89 e7             	mov    %rsp,%rdi
        call exception
   400be:	e8 d0 0a 00 00       	call   40b93 <exception>

00000000000400c3 <exception_return>:
        # `exception` should never return.


        .globl exception_return
exception_return:
        movq %rdi, %rsp
   400c3:	48 89 fc             	mov    %rdi,%rsp
        popq %rax
   400c6:	58                   	pop    %rax
        popq %rcx
   400c7:	59                   	pop    %rcx
        popq %rdx
   400c8:	5a                   	pop    %rdx
        popq %rbx
   400c9:	5b                   	pop    %rbx
        popq %rbp
   400ca:	5d                   	pop    %rbp
        popq %rsi
   400cb:	5e                   	pop    %rsi
        popq %rdi
   400cc:	5f                   	pop    %rdi
        popq %r8
   400cd:	41 58                	pop    %r8
        popq %r9
   400cf:	41 59                	pop    %r9
        popq %r10
   400d1:	41 5a                	pop    %r10
        popq %r11
   400d3:	41 5b                	pop    %r11
        popq %r12
   400d5:	41 5c                	pop    %r12
        popq %r13
   400d7:	41 5d                	pop    %r13
        popq %r14
   400d9:	41 5e                	pop    %r14
        popq %r15
   400db:	41 5f                	pop    %r15
        popq %fs
   400dd:	0f a1                	pop    %fs
        popq %gs
   400df:	0f a9                	pop    %gs
        addq $16, %rsp
   400e1:	48 83 c4 10          	add    $0x10,%rsp
        iretq
   400e5:	48 cf                	iretq  

00000000000400e7 <sys_int_handlers>:
   400e7:	3c 00                	cmp    $0x0,%al
   400e9:	04 00                	add    $0x0,%al
   400eb:	00 00                	add    %al,(%rax)
   400ed:	00 00                	add    %al,(%rax)
   400ef:	42 00 04 00          	add    %al,(%rax,%r8,1)
   400f3:	00 00                	add    %al,(%rax)
   400f5:	00 00                	add    %al,(%rax)
   400f7:	48 00 04 00          	rex.W add %al,(%rax,%rax,1)
   400fb:	00 00                	add    %al,(%rax)
   400fd:	00 00                	add    %al,(%rax)
   400ff:	4e 00 04 00          	rex.WRX add %r8b,(%rax,%r8,1)
   40103:	00 00                	add    %al,(%rax)
   40105:	00 00                	add    %al,(%rax)
   40107:	54                   	push   %rsp
   40108:	00 04 00             	add    %al,(%rax,%rax,1)
   4010b:	00 00                	add    %al,(%rax)
   4010d:	00 00                	add    %al,(%rax)
   4010f:	5a                   	pop    %rdx
   40110:	00 04 00             	add    %al,(%rax,%rax,1)
   40113:	00 00                	add    %al,(%rax)
   40115:	00 00                	add    %al,(%rax)
   40117:	60                   	(bad)  
   40118:	00 04 00             	add    %al,(%rax,%rax,1)
   4011b:	00 00                	add    %al,(%rax)
   4011d:	00 00                	add    %al,(%rax)
   4011f:	66 00 04 00          	data16 add %al,(%rax,%rax,1)
   40123:	00 00                	add    %al,(%rax)
   40125:	00 00                	add    %al,(%rax)
   40127:	6c                   	insb   (%dx),%es:(%rdi)
   40128:	00 04 00             	add    %al,(%rax,%rax,1)
   4012b:	00 00                	add    %al,(%rax)
   4012d:	00 00                	add    %al,(%rax)
   4012f:	72 00                	jb     40131 <sys_int_handlers+0x4a>
   40131:	04 00                	add    $0x0,%al
   40133:	00 00                	add    %al,(%rax)
   40135:	00 00                	add    %al,(%rax)
   40137:	78 00                	js     40139 <sys_int_handlers+0x52>
   40139:	04 00                	add    $0x0,%al
   4013b:	00 00                	add    %al,(%rax)
   4013d:	00 00                	add    %al,(%rax)
   4013f:	7e 00                	jle    40141 <sys_int_handlers+0x5a>
   40141:	04 00                	add    $0x0,%al
   40143:	00 00                	add    %al,(%rax)
   40145:	00 00                	add    %al,(%rax)
   40147:	84 00                	test   %al,(%rax)
   40149:	04 00                	add    $0x0,%al
   4014b:	00 00                	add    %al,(%rax)
   4014d:	00 00                	add    %al,(%rax)
   4014f:	8a 00                	mov    (%rax),%al
   40151:	04 00                	add    $0x0,%al
   40153:	00 00                	add    %al,(%rax)
   40155:	00 00                	add    %al,(%rax)
   40157:	90                   	nop
   40158:	00 04 00             	add    %al,(%rax,%rax,1)
   4015b:	00 00                	add    %al,(%rax)
   4015d:	00 00                	add    %al,(%rax)
   4015f:	96                   	xchg   %eax,%esi
   40160:	00 04 00             	add    %al,(%rax,%rax,1)
   40163:	00 00                	add    %al,(%rax)
	...

0000000000040167 <kernel>:
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

static void process_setup(pid_t pid, int program_number);

void kernel(const char* command) {
   40167:	55                   	push   %rbp
   40168:	48 89 e5             	mov    %rsp,%rbp
   4016b:	48 83 ec 20          	sub    $0x20,%rsp
   4016f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    hardware_init();
   40173:	e8 97 1a 00 00       	call   41c0f <hardware_init>
    pageinfo_init();
   40178:	e8 a8 10 00 00       	call   41225 <pageinfo_init>
    console_clear();
   4017d:	e8 cd 44 00 00       	call   4464f <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 6f 1f 00 00       	call   420fb <timer_init>

    // use virtual_memory_map to remove user permissions for kernel memory
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4018c:	48 8b 05 6d 4e 01 00 	mov    0x14e6d(%rip),%rax        # 55000 <kernel_pagetable>
   40193:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   40199:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4019e:	ba 00 00 00 00       	mov    $0x0,%edx
   401a3:	be 00 00 00 00       	mov    $0x0,%esi
   401a8:	48 89 c7             	mov    %rax,%rdi
   401ab:	e8 a9 2c 00 00       	call   42e59 <virtual_memory_map>
					   PROC_START_ADDR, PTE_P | PTE_W);
   
    // return user permissions to console
    virtual_memory_map(kernel_pagetable, (uintptr_t) CONSOLE_ADDR, (uintptr_t) CONSOLE_ADDR,
   401b0:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   401b5:	be 00 80 0b 00       	mov    $0xb8000,%esi
   401ba:	48 8b 05 3f 4e 01 00 	mov    0x14e3f(%rip),%rax        # 55000 <kernel_pagetable>
   401c1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   401c7:	b9 00 10 00 00       	mov    $0x1000,%ecx
   401cc:	48 89 c7             	mov    %rax,%rdi
   401cf:	e8 85 2c 00 00       	call   42e59 <virtual_memory_map>
	// to all memory before the start of ANY processes. This means that 
	// the assign_page function is never capable of assigning this memory
	// to a process.

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   401d4:	ba 00 0e 00 00       	mov    $0xe00,%edx
   401d9:	be 00 00 00 00       	mov    $0x0,%esi
   401de:	bf 20 20 05 00       	mov    $0x52020,%edi
   401e3:	e8 4d 35 00 00       	call   43735 <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   401e8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401ef:	eb 44                	jmp    40235 <kernel+0xce>
        processes[i].p_pid = i;
   401f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401f4:	48 63 d0             	movslq %eax,%rdx
   401f7:	48 89 d0             	mov    %rdx,%rax
   401fa:	48 c1 e0 03          	shl    $0x3,%rax
   401fe:	48 29 d0             	sub    %rdx,%rax
   40201:	48 c1 e0 05          	shl    $0x5,%rax
   40205:	48 8d 90 20 20 05 00 	lea    0x52020(%rax),%rdx
   4020c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4020f:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   40211:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40214:	48 63 d0             	movslq %eax,%rdx
   40217:	48 89 d0             	mov    %rdx,%rax
   4021a:	48 c1 e0 03          	shl    $0x3,%rax
   4021e:	48 29 d0             	sub    %rdx,%rax
   40221:	48 c1 e0 05          	shl    $0x5,%rax
   40225:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   4022b:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    for (pid_t i = 0; i < NPROC; i++) {
   40231:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40235:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   40239:	7e b6                	jle    401f1 <kernel+0x8a>
    }

    if (command && strcmp(command, "fork") == 0) {
   4023b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40240:	74 29                	je     4026b <kernel+0x104>
   40242:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40246:	be a0 46 04 00       	mov    $0x446a0,%esi
   4024b:	48 89 c7             	mov    %rax,%rdi
   4024e:	e8 db 35 00 00       	call   4382e <strcmp>
   40253:	85 c0                	test   %eax,%eax
   40255:	75 14                	jne    4026b <kernel+0x104>
        process_setup(1, 4);
   40257:	be 04 00 00 00       	mov    $0x4,%esi
   4025c:	bf 01 00 00 00       	mov    $0x1,%edi
   40261:	e8 82 02 00 00       	call   404e8 <process_setup>
   40266:	e9 c2 00 00 00       	jmp    4032d <kernel+0x1c6>
    } else if (command && strcmp(command, "forkexit") == 0) {
   4026b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40270:	74 29                	je     4029b <kernel+0x134>
   40272:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40276:	be a5 46 04 00       	mov    $0x446a5,%esi
   4027b:	48 89 c7             	mov    %rax,%rdi
   4027e:	e8 ab 35 00 00       	call   4382e <strcmp>
   40283:	85 c0                	test   %eax,%eax
   40285:	75 14                	jne    4029b <kernel+0x134>
        process_setup(1, 5);
   40287:	be 05 00 00 00       	mov    $0x5,%esi
   4028c:	bf 01 00 00 00       	mov    $0x1,%edi
   40291:	e8 52 02 00 00       	call   404e8 <process_setup>
   40296:	e9 92 00 00 00       	jmp    4032d <kernel+0x1c6>
    } else if (command && strcmp(command, "test") == 0) {
   4029b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402a0:	74 26                	je     402c8 <kernel+0x161>
   402a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402a6:	be ae 46 04 00       	mov    $0x446ae,%esi
   402ab:	48 89 c7             	mov    %rax,%rdi
   402ae:	e8 7b 35 00 00       	call   4382e <strcmp>
   402b3:	85 c0                	test   %eax,%eax
   402b5:	75 11                	jne    402c8 <kernel+0x161>
        process_setup(1, 6);
   402b7:	be 06 00 00 00       	mov    $0x6,%esi
   402bc:	bf 01 00 00 00       	mov    $0x1,%edi
   402c1:	e8 22 02 00 00       	call   404e8 <process_setup>
   402c6:	eb 65                	jmp    4032d <kernel+0x1c6>
    } else if (command && strcmp(command, "test2") == 0) {
   402c8:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402cd:	74 39                	je     40308 <kernel+0x1a1>
   402cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402d3:	be b3 46 04 00       	mov    $0x446b3,%esi
   402d8:	48 89 c7             	mov    %rax,%rdi
   402db:	e8 4e 35 00 00       	call   4382e <strcmp>
   402e0:	85 c0                	test   %eax,%eax
   402e2:	75 24                	jne    40308 <kernel+0x1a1>
        for (pid_t i = 1; i <= 2; ++i) {
   402e4:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402eb:	eb 13                	jmp    40300 <kernel+0x199>
            process_setup(i, 6);
   402ed:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402f0:	be 06 00 00 00       	mov    $0x6,%esi
   402f5:	89 c7                	mov    %eax,%edi
   402f7:	e8 ec 01 00 00       	call   404e8 <process_setup>
        for (pid_t i = 1; i <= 2; ++i) {
   402fc:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   40300:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
   40304:	7e e7                	jle    402ed <kernel+0x186>
   40306:	eb 25                	jmp    4032d <kernel+0x1c6>
        }
    } else {
        for (pid_t i = 1; i <= 4; ++i) {
   40308:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
   4030f:	eb 16                	jmp    40327 <kernel+0x1c0>
            process_setup(i, i - 1);
   40311:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40314:	8d 50 ff             	lea    -0x1(%rax),%edx
   40317:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4031a:	89 d6                	mov    %edx,%esi
   4031c:	89 c7                	mov    %eax,%edi
   4031e:	e8 c5 01 00 00       	call   404e8 <process_setup>
        for (pid_t i = 1; i <= 4; ++i) {
   40323:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40327:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
   4032b:	7e e4                	jle    40311 <kernel+0x1aa>
        }
    }


    // Switch to the first process using run()
    run(&processes[1]);
   4032d:	bf 00 21 05 00       	mov    $0x52100,%edi
   40332:	e8 91 0e 00 00       	call   411c8 <run>

0000000000040337 <next_free_pages>:

// next_free_pages(uintptr_t *, int)
//    loads uintptr_t * with the address of the next n free pages in the kernel
//    returns 0 on success, -1 on failure

int next_free_pages(uintptr_t *fill, int n) {
   40337:	55                   	push   %rbp
   40338:	48 89 e5             	mov    %rsp,%rbp
   4033b:	48 83 ec 20          	sub    $0x20,%rsp
   4033f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40343:	89 75 e4             	mov    %esi,-0x1c(%rbp)
	int c = 0;
   40346:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
	for (uintptr_t pa = 0; pa < MEMSIZE_PHYSICAL; pa += PAGESIZE) {
   4034d:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   40354:	00 
   40355:	eb 62                	jmp    403b9 <next_free_pages+0x82>
		if (pageinfo[PAGENUMBER(pa)].owner == PO_FREE 
   40357:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4035b:	48 c1 e8 0c          	shr    $0xc,%rax
   4035f:	48 98                	cltq   
   40361:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   40368:	00 
   40369:	84 c0                	test   %al,%al
   4036b:	75 35                	jne    403a2 <next_free_pages+0x6b>
			&& pageinfo[PAGENUMBER(pa)].refcount == 0) {
   4036d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40371:	48 c1 e8 0c          	shr    $0xc,%rax
   40375:	48 98                	cltq   
   40377:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   4037e:	00 
   4037f:	84 c0                	test   %al,%al
   40381:	75 1f                	jne    403a2 <next_free_pages+0x6b>
			fill[c] = pa;
   40383:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40386:	48 98                	cltq   
   40388:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   4038f:	00 
   40390:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40394:	48 01 c2             	add    %rax,%rdx
   40397:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4039b:	48 89 02             	mov    %rax,(%rdx)
			c++;
   4039e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
		}

		if (c == n)
   403a2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   403a5:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
   403a8:	75 07                	jne    403b1 <next_free_pages+0x7a>
			return 0;
   403aa:	b8 00 00 00 00       	mov    $0x0,%eax
   403af:	eb 17                	jmp    403c8 <next_free_pages+0x91>
	for (uintptr_t pa = 0; pa < MEMSIZE_PHYSICAL; pa += PAGESIZE) {
   403b1:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   403b8:	00 
   403b9:	48 81 7d f0 ff ff 1f 	cmpq   $0x1fffff,-0x10(%rbp)
   403c0:	00 
   403c1:	76 94                	jbe    40357 <next_free_pages+0x20>
	}
	return -1;
   403c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   403c8:	c9                   	leave  
   403c9:	c3                   	ret    

00000000000403ca <next_free_page>:

// next_free_page(uintptr_t *)
//    loads uintptr_t * with the address of the next free page in the kernel
//    returns 0 on success, -1 on failure

int next_free_page(uintptr_t *fill) {
   403ca:	55                   	push   %rbp
   403cb:	48 89 e5             	mov    %rsp,%rbp
   403ce:	48 83 ec 08          	sub    $0x8,%rsp
   403d2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
	return next_free_pages(fill, 1);
   403d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403da:	be 01 00 00 00       	mov    $0x1,%esi
   403df:	48 89 c7             	mov    %rax,%rdi
   403e2:	e8 50 ff ff ff       	call   40337 <next_free_pages>
}
   403e7:	c9                   	leave  
   403e8:	c3                   	ret    

00000000000403e9 <pagetable_setup>:
// pagetable_setup(pid)
//    given a process, sets up pagetable in the kernel space
//
//    returns 0 on success, -1 on failure

int pagetable_setup(pid_t pid) {
   403e9:	55                   	push   %rbp
   403ea:	48 89 e5             	mov    %rsp,%rbp
   403ed:	48 83 ec 40          	sub    $0x40,%rsp
   403f1:	89 7d cc             	mov    %edi,-0x34(%rbp)
    uintptr_t pagetable_pages[5];

    if (next_free_pages(pagetable_pages, 5))
   403f4:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   403f8:	be 05 00 00 00       	mov    $0x5,%esi
   403fd:	48 89 c7             	mov    %rax,%rdi
   40400:	e8 32 ff ff ff       	call   40337 <next_free_pages>
   40405:	85 c0                	test   %eax,%eax
   40407:	74 0a                	je     40413 <pagetable_setup+0x2a>
	    return -1;
   40409:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4040e:	e9 d3 00 00 00       	jmp    404e6 <pagetable_setup+0xfd>

    for (int i = 0; i< 5; i++) {
   40413:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4041a:	eb 3a                	jmp    40456 <pagetable_setup+0x6d>
	assign_physical_page(pagetable_pages[i], pid);
   4041c:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4041f:	0f be d0             	movsbl %al,%edx
   40422:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40425:	48 98                	cltq   
   40427:	48 8b 44 c5 d0       	mov    -0x30(%rbp,%rax,8),%rax
   4042c:	89 d6                	mov    %edx,%esi
   4042e:	48 89 c7             	mov    %rax,%rdi
   40431:	e8 01 02 00 00       	call   40637 <assign_physical_page>
	memset((void *) pagetable_pages[i], 0, PAGESIZE);
   40436:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40439:	48 98                	cltq   
   4043b:	48 8b 44 c5 d0       	mov    -0x30(%rbp,%rax,8),%rax
   40440:	ba 00 10 00 00       	mov    $0x1000,%edx
   40445:	be 00 00 00 00       	mov    $0x0,%esi
   4044a:	48 89 c7             	mov    %rax,%rdi
   4044d:	e8 e3 32 00 00       	call   43735 <memset>
    for (int i = 0; i< 5; i++) {
   40452:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40456:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
   4045a:	7e c0                	jle    4041c <pagetable_setup+0x33>
    }

    ((x86_64_pagetable *) pagetable_pages[0])->entry[0] =
        (x86_64_pageentry_t) pagetable_pages[1] | PTE_P | PTE_W | PTE_U;
   4045c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    ((x86_64_pagetable *) pagetable_pages[0])->entry[0] =
   40460:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
        (x86_64_pageentry_t) pagetable_pages[1] | PTE_P | PTE_W | PTE_U;
   40464:	48 83 c8 07          	or     $0x7,%rax
    ((x86_64_pagetable *) pagetable_pages[0])->entry[0] =
   40468:	48 89 02             	mov    %rax,(%rdx)
    
    ((x86_64_pagetable *) pagetable_pages[1])->entry[0] =
        (x86_64_pageentry_t) pagetable_pages[2] | PTE_P | PTE_W | PTE_U;
   4046b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    ((x86_64_pagetable *) pagetable_pages[1])->entry[0] =
   4046f:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
        (x86_64_pageentry_t) pagetable_pages[2] | PTE_P | PTE_W | PTE_U;
   40473:	48 83 c8 07          	or     $0x7,%rax
    ((x86_64_pagetable *) pagetable_pages[1])->entry[0] =
   40477:	48 89 02             	mov    %rax,(%rdx)

    ((x86_64_pagetable *) pagetable_pages[2])->entry[0] =
        (x86_64_pageentry_t) pagetable_pages[3] | PTE_P | PTE_W | PTE_U;
   4047a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    ((x86_64_pagetable *) pagetable_pages[2])->entry[0] =
   4047e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
        (x86_64_pageentry_t) pagetable_pages[3] | PTE_P | PTE_W | PTE_U;
   40482:	48 83 c8 07          	or     $0x7,%rax
    ((x86_64_pagetable *) pagetable_pages[2])->entry[0] =
   40486:	48 89 02             	mov    %rax,(%rdx)

    ((x86_64_pagetable *) pagetable_pages[2])->entry[1] =
        (x86_64_pageentry_t) pagetable_pages[4] | PTE_P | PTE_W | PTE_U;
   40489:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    ((x86_64_pagetable *) pagetable_pages[2])->entry[1] =
   4048d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
        (x86_64_pageentry_t) pagetable_pages[4] | PTE_P | PTE_W | PTE_U;
   40491:	48 83 c8 07          	or     $0x7,%rax
    ((x86_64_pagetable *) pagetable_pages[2])->entry[1] =
   40495:	48 89 42 08          	mov    %rax,0x8(%rdx)

   
    memcpy((void *)pagetable_pages[3], &kernel_pagetable[3], 
   40499:	48 8b 05 60 4b 01 00 	mov    0x14b60(%rip),%rax        # 55000 <kernel_pagetable>
   404a0:	48 05 00 30 00 00    	add    $0x3000,%rax
   404a6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   404aa:	48 89 d1             	mov    %rdx,%rcx
   404ad:	ba 00 08 00 00       	mov    $0x800,%edx
   404b2:	48 89 c6             	mov    %rax,%rsi
   404b5:	48 89 cf             	mov    %rcx,%rdi
   404b8:	e8 7a 31 00 00       	call   43637 <memcpy>
	   sizeof(x86_64_pageentry_t) * PAGENUMBER(PROC_START_ADDR));

    processes[pid].p_pagetable = (x86_64_pagetable *) pagetable_pages[0];
   404bd:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   404c1:	48 89 c1             	mov    %rax,%rcx
   404c4:	8b 45 cc             	mov    -0x34(%rbp),%eax
   404c7:	48 63 d0             	movslq %eax,%rdx
   404ca:	48 89 d0             	mov    %rdx,%rax
   404cd:	48 c1 e0 03          	shl    $0x3,%rax
   404d1:	48 29 d0             	sub    %rdx,%rax
   404d4:	48 c1 e0 05          	shl    $0x5,%rax
   404d8:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   404de:	48 89 08             	mov    %rcx,(%rax)

    return 0;
   404e1:	b8 00 00 00 00       	mov    $0x0,%eax
}
   404e6:	c9                   	leave  
   404e7:	c3                   	ret    

00000000000404e8 <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   404e8:	55                   	push   %rbp
   404e9:	48 89 e5             	mov    %rsp,%rbp
   404ec:	48 83 ec 30          	sub    $0x30,%rsp
   404f0:	89 7d dc             	mov    %edi,-0x24(%rbp)
   404f3:	89 75 d8             	mov    %esi,-0x28(%rbp)
    process_init(&processes[pid], 0);
   404f6:	8b 45 dc             	mov    -0x24(%rbp),%eax
   404f9:	48 63 d0             	movslq %eax,%rdx
   404fc:	48 89 d0             	mov    %rdx,%rax
   404ff:	48 c1 e0 03          	shl    $0x3,%rax
   40503:	48 29 d0             	sub    %rdx,%rax
   40506:	48 c1 e0 05          	shl    $0x5,%rax
   4050a:	48 05 20 20 05 00    	add    $0x52020,%rax
   40510:	be 00 00 00 00       	mov    $0x0,%esi
   40515:	48 89 c7             	mov    %rax,%rdi
   40518:	e8 6f 1e 00 00       	call   4238c <process_init>
    //processes[pid].p_pagetable = kernel_pagetable;
    //++pageinfo[PAGENUMBER(kernel_pagetable)].refcount; //increase refcount since kernel_pagetable was used

    pagetable_setup(pid);
   4051d:	8b 45 dc             	mov    -0x24(%rbp),%eax
   40520:	89 c7                	mov    %eax,%edi
   40522:	e8 c2 fe ff ff       	call   403e9 <pagetable_setup>

    int r = program_load(&processes[pid], program_number, NULL);
   40527:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4052a:	48 63 d0             	movslq %eax,%rdx
   4052d:	48 89 d0             	mov    %rdx,%rax
   40530:	48 c1 e0 03          	shl    $0x3,%rax
   40534:	48 29 d0             	sub    %rdx,%rax
   40537:	48 c1 e0 05          	shl    $0x5,%rax
   4053b:	48 8d 88 20 20 05 00 	lea    0x52020(%rax),%rcx
   40542:	8b 45 d8             	mov    -0x28(%rbp),%eax
   40545:	ba 00 00 00 00       	mov    $0x0,%edx
   4054a:	89 c6                	mov    %eax,%esi
   4054c:	48 89 cf             	mov    %rcx,%rdi
   4054f:	e8 c2 2d 00 00       	call   43316 <program_load>
   40554:	89 45 fc             	mov    %eax,-0x4(%rbp)
    assert(r >= 0);
   40557:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4055b:	79 14                	jns    40571 <process_setup+0x89>
   4055d:	ba b9 46 04 00       	mov    $0x446b9,%edx
   40562:	be d7 00 00 00       	mov    $0xd7,%esi
   40567:	bf c0 46 04 00       	mov    $0x446c0,%edi
   4056c:	e8 e9 25 00 00       	call   42b5a <assert_fail>

    processes[pid].p_registers.reg_rsp = MEMSIZE_VIRTUAL; 
   40571:	8b 45 dc             	mov    -0x24(%rbp),%eax
   40574:	48 63 d0             	movslq %eax,%rdx
   40577:	48 89 d0             	mov    %rdx,%rax
   4057a:	48 c1 e0 03          	shl    $0x3,%rax
   4057e:	48 29 d0             	sub    %rdx,%rax
   40581:	48 c1 e0 05          	shl    $0x5,%rax
   40585:	48 05 d8 20 05 00    	add    $0x520d8,%rax
   4058b:	48 c7 00 00 00 30 00 	movq   $0x300000,(%rax)
    uintptr_t stack_page_va = processes[pid].p_registers.reg_rsp - PAGESIZE;
   40592:	8b 45 dc             	mov    -0x24(%rbp),%eax
   40595:	48 63 d0             	movslq %eax,%rdx
   40598:	48 89 d0             	mov    %rdx,%rax
   4059b:	48 c1 e0 03          	shl    $0x3,%rax
   4059f:	48 29 d0             	sub    %rdx,%rax
   405a2:	48 c1 e0 05          	shl    $0x5,%rax
   405a6:	48 05 d8 20 05 00    	add    $0x520d8,%rax
   405ac:	48 8b 00             	mov    (%rax),%rax
   405af:	48 2d 00 10 00 00    	sub    $0x1000,%rax
   405b5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    uintptr_t stack_page_pa;
    next_free_page(&stack_page_pa);
   405b9:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   405bd:	48 89 c7             	mov    %rax,%rdi
   405c0:	e8 05 fe ff ff       	call   403ca <next_free_page>
    assign_physical_page(stack_page_pa, pid);
   405c5:	8b 45 dc             	mov    -0x24(%rbp),%eax
   405c8:	0f be d0             	movsbl %al,%edx
   405cb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405cf:	89 d6                	mov    %edx,%esi
   405d1:	48 89 c7             	mov    %rax,%rdi
   405d4:	e8 5e 00 00 00       	call   40637 <assign_physical_page>
    virtual_memory_map(processes[pid].p_pagetable, stack_page_va, stack_page_pa,
   405d9:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   405dd:	8b 45 dc             	mov    -0x24(%rbp),%eax
   405e0:	48 63 d0             	movslq %eax,%rdx
   405e3:	48 89 d0             	mov    %rdx,%rax
   405e6:	48 c1 e0 03          	shl    $0x3,%rax
   405ea:	48 29 d0             	sub    %rdx,%rax
   405ed:	48 c1 e0 05          	shl    $0x5,%rax
   405f1:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   405f7:	48 8b 00             	mov    (%rax),%rax
   405fa:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   405fe:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40604:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40609:	48 89 fa             	mov    %rdi,%rdx
   4060c:	48 89 c7             	mov    %rax,%rdi
   4060f:	e8 45 28 00 00       	call   42e59 <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);
    processes[pid].p_state = P_RUNNABLE;
   40614:	8b 45 dc             	mov    -0x24(%rbp),%eax
   40617:	48 63 d0             	movslq %eax,%rdx
   4061a:	48 89 d0             	mov    %rdx,%rax
   4061d:	48 c1 e0 03          	shl    $0x3,%rax
   40621:	48 29 d0             	sub    %rdx,%rax
   40624:	48 c1 e0 05          	shl    $0x5,%rax
   40628:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   4062e:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   40634:	90                   	nop
   40635:	c9                   	leave  
   40636:	c3                   	ret    

0000000000040637 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   40637:	55                   	push   %rbp
   40638:	48 89 e5             	mov    %rsp,%rbp
   4063b:	48 83 ec 10          	sub    $0x10,%rsp
   4063f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   40643:	89 f0                	mov    %esi,%eax
   40645:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0								 // this check is that the permission bits are 0
   40648:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4064c:	25 ff 0f 00 00       	and    $0xfff,%eax
   40651:	48 85 c0             	test   %rax,%rax
   40654:	75 20                	jne    40676 <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   40656:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4065d:	00 
   4065e:	77 16                	ja     40676 <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   40660:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40664:	48 c1 e8 0c          	shr    $0xc,%rax
   40668:	48 98                	cltq   
   4066a:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   40671:	00 
   40672:	84 c0                	test   %al,%al
   40674:	74 07                	je     4067d <assign_physical_page+0x46>
        return -1;
   40676:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4067b:	eb 2c                	jmp    406a9 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   4067d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40681:	48 c1 e8 0c          	shr    $0xc,%rax
   40685:	48 98                	cltq   
   40687:	c6 84 00 41 2e 05 00 	movb   $0x1,0x52e41(%rax,%rax,1)
   4068e:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4068f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40693:	48 c1 e8 0c          	shr    $0xc,%rax
   40697:	48 98                	cltq   
   40699:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   4069d:	88 94 00 40 2e 05 00 	mov    %dl,0x52e40(%rax,%rax,1)
        return 0;
   406a4:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   406a9:	c9                   	leave  
   406aa:	c3                   	ret    

00000000000406ab <syscall_mapping>:

void syscall_mapping(proc* p){
   406ab:	55                   	push   %rbp
   406ac:	48 89 e5             	mov    %rsp,%rbp
   406af:	48 83 ec 70          	sub    $0x70,%rsp
   406b3:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   406b7:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406bb:	48 8b 40 38          	mov    0x38(%rax),%rax
   406bf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   406c3:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406c7:	48 8b 40 30          	mov    0x30(%rax),%rax
   406cb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   406cf:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406d3:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   406da:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   406de:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   406e2:	48 89 ce             	mov    %rcx,%rsi
   406e5:	48 89 c7             	mov    %rax,%rdi
   406e8:	e8 32 2b 00 00       	call   4321f <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   406ed:	8b 45 e0             	mov    -0x20(%rbp),%eax
   406f0:	48 98                	cltq   
   406f2:	83 e0 06             	and    $0x6,%eax
   406f5:	48 83 f8 06          	cmp    $0x6,%rax
   406f9:	75 73                	jne    4076e <syscall_mapping+0xc3>
	return;
    uintptr_t endaddr = map.pa + sizeof(vamapping) - 1;
   406fb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   406ff:	48 83 c0 17          	add    $0x17,%rax
   40703:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   40707:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4070b:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40712:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40716:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4071a:	48 89 ce             	mov    %rcx,%rsi
   4071d:	48 89 c7             	mov    %rax,%rdi
   40720:	e8 fa 2a 00 00       	call   4321f <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   40725:	8b 45 c8             	mov    -0x38(%rbp),%eax
   40728:	48 98                	cltq   
   4072a:	83 e0 03             	and    $0x3,%eax
   4072d:	48 83 f8 03          	cmp    $0x3,%rax
   40731:	75 3e                	jne    40771 <syscall_mapping+0xc6>
	return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   40733:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40737:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   4073e:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40742:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40746:	48 89 ce             	mov    %rcx,%rsi
   40749:	48 89 c7             	mov    %rax,%rdi
   4074c:	e8 ce 2a 00 00       	call   4321f <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40751:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40755:	48 89 c1             	mov    %rax,%rcx
   40758:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4075c:	ba 18 00 00 00       	mov    $0x18,%edx
   40761:	48 89 c6             	mov    %rax,%rsi
   40764:	48 89 cf             	mov    %rcx,%rdi
   40767:	e8 cb 2e 00 00       	call   43637 <memcpy>
   4076c:	eb 04                	jmp    40772 <syscall_mapping+0xc7>
	return;
   4076e:	90                   	nop
   4076f:	eb 01                	jmp    40772 <syscall_mapping+0xc7>
	return;
   40771:	90                   	nop
}
   40772:	c9                   	leave  
   40773:	c3                   	ret    

0000000000040774 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   40774:	55                   	push   %rbp
   40775:	48 89 e5             	mov    %rsp,%rbp
   40778:	48 83 ec 18          	sub    $0x18,%rsp
   4077c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   40780:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40784:	48 8b 40 38          	mov    0x38(%rax),%rax
   40788:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   4078b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4078f:	75 14                	jne    407a5 <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   40791:	0f b6 05 68 58 00 00 	movzbl 0x5868(%rip),%eax        # 46000 <disp_global>
   40798:	84 c0                	test   %al,%al
   4079a:	0f 94 c0             	sete   %al
   4079d:	88 05 5d 58 00 00    	mov    %al,0x585d(%rip)        # 46000 <disp_global>
   407a3:	eb 36                	jmp    407db <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   407a5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   407a9:	78 2f                	js     407da <syscall_mem_tog+0x66>
   407ab:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   407af:	7f 29                	jg     407da <syscall_mem_tog+0x66>
   407b1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   407b5:	8b 00                	mov    (%rax),%eax
   407b7:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   407ba:	75 1e                	jne    407da <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   407bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   407c0:	0f b6 80 d8 00 00 00 	movzbl 0xd8(%rax),%eax
   407c7:	84 c0                	test   %al,%al
   407c9:	0f 94 c0             	sete   %al
   407cc:	89 c2                	mov    %eax,%edx
   407ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   407d2:	88 90 d8 00 00 00    	mov    %dl,0xd8(%rax)
   407d8:	eb 01                	jmp    407db <syscall_mem_tog+0x67>
            return;
   407da:	90                   	nop
    }
}
   407db:	c9                   	leave  
   407dc:	c3                   	ret    

00000000000407dd <next_free_pid>:
// ---------- FORK HELPERS ----------

// next_free_process(void)
//    returns the next free pid, -1 if there aren't any

pid_t next_free_pid(void) {
   407dd:	55                   	push   %rbp
   407de:	48 89 e5             	mov    %rsp,%rbp
   407e1:	48 83 ec 10          	sub    $0x10,%rsp
	for (pid_t pid = 1; pid < NPROC; pid++)
   407e5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   407ec:	eb 29                	jmp    40817 <next_free_pid+0x3a>
		if (processes[pid].p_state == P_FREE)
   407ee:	8b 45 fc             	mov    -0x4(%rbp),%eax
   407f1:	48 63 d0             	movslq %eax,%rdx
   407f4:	48 89 d0             	mov    %rdx,%rax
   407f7:	48 c1 e0 03          	shl    $0x3,%rax
   407fb:	48 29 d0             	sub    %rdx,%rax
   407fe:	48 c1 e0 05          	shl    $0x5,%rax
   40802:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   40808:	8b 00                	mov    (%rax),%eax
   4080a:	85 c0                	test   %eax,%eax
   4080c:	75 05                	jne    40813 <next_free_pid+0x36>
			return pid;
   4080e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40811:	eb 0f                	jmp    40822 <next_free_pid+0x45>
	for (pid_t pid = 1; pid < NPROC; pid++)
   40813:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40817:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   4081b:	7e d1                	jle    407ee <next_free_pid+0x11>
	return -1;
   4081d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   40822:	c9                   	leave  
   40823:	c3                   	ret    

0000000000040824 <copy_pagetable>:
//		address is readonly, updates page ref
//		otherwise, copies contents to a new physical page
//
//		returns 0 on success, -1 on failure

int copy_pagetable(proc *dest, proc *src) {
   40824:	55                   	push   %rbp
   40825:	48 89 e5             	mov    %rsp,%rbp
   40828:	48 83 ec 40          	sub    $0x40,%rsp
   4082c:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   40830:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
	for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40834:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   4083b:	00 
   4083c:	e9 15 01 00 00       	jmp    40956 <copy_pagetable+0x132>
		vamapping map = virtual_memory_lookup(src->p_pagetable, va); // examining addr page by page
   40841:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   40845:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   4084c:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   40850:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40854:	48 89 ce             	mov    %rcx,%rsi
   40857:	48 89 c7             	mov    %rax,%rdi
   4085a:	e8 c0 29 00 00       	call   4321f <virtual_memory_lookup>
		
		if (map.pn == -1) { // unused va
   4085f:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40862:	83 f8 ff             	cmp    $0xffffffff,%eax
   40865:	0f 84 e2 00 00 00    	je     4094d <copy_pagetable+0x129>
			continue;
		}
		else if ((map.perm & PTE_P) && !(map.perm & PTE_W) && (map.perm & PTE_U)) { // how to detect readonly memory?
   4086b:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4086e:	48 98                	cltq   
   40870:	83 e0 01             	and    $0x1,%eax
   40873:	48 85 c0             	test   %rax,%rax
   40876:	74 5c                	je     408d4 <copy_pagetable+0xb0>
   40878:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4087b:	48 98                	cltq   
   4087d:	83 e0 02             	and    $0x2,%eax
   40880:	48 85 c0             	test   %rax,%rax
   40883:	75 4f                	jne    408d4 <copy_pagetable+0xb0>
   40885:	8b 45 f0             	mov    -0x10(%rbp),%eax
   40888:	48 98                	cltq   
   4088a:	83 e0 04             	and    $0x4,%eax
   4088d:	48 85 c0             	test   %rax,%rax
   40890:	74 42                	je     408d4 <copy_pagetable+0xb0>
			pageinfo[map.pn].refcount++;	
   40892:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40895:	48 63 d0             	movslq %eax,%rdx
   40898:	0f b6 94 12 41 2e 05 	movzbl 0x52e41(%rdx,%rdx,1),%edx
   4089f:	00 
   408a0:	83 c2 01             	add    $0x1,%edx
   408a3:	48 98                	cltq   
   408a5:	88 94 00 41 2e 05 00 	mov    %dl,0x52e41(%rax,%rax,1)
			virtual_memory_map(dest->p_pagetable, va, map.pa, PAGESIZE, map.perm);
   408ac:	8b 4d f0             	mov    -0x10(%rbp),%ecx
   408af:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   408b3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   408b7:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   408be:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   408c2:	41 89 c8             	mov    %ecx,%r8d
   408c5:	b9 00 10 00 00       	mov    $0x1000,%ecx
   408ca:	48 89 c7             	mov    %rax,%rdi
   408cd:	e8 87 25 00 00       	call   42e59 <virtual_memory_map>
   408d2:	eb 7a                	jmp    4094e <copy_pagetable+0x12a>
			//	console_printf(CPOS(23, 0), 0x1100, "proc 1 code page owner: %d, proc 1 code page refcount: %d\n", pageinfo[PAGENUMBER(0x7000)].owner, pageinfo[PAGENUMBER(0x7000)].refcount); 
			//}
		}
		else {
			uintptr_t free_page;
			if (next_free_page(&free_page)
   408d4:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   408d8:	48 89 c7             	mov    %rax,%rdi
   408db:	e8 ea fa ff ff       	call   403ca <next_free_page>
   408e0:	85 c0                	test   %eax,%eax
   408e2:	75 45                	jne    40929 <copy_pagetable+0x105>
				|| assign_physical_page(free_page, dest->p_pid)
   408e4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   408e8:	8b 00                	mov    (%rax),%eax
   408ea:	0f be d0             	movsbl %al,%edx
   408ed:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   408f1:	89 d6                	mov    %edx,%esi
   408f3:	48 89 c7             	mov    %rax,%rdi
   408f6:	e8 3c fd ff ff       	call   40637 <assign_physical_page>
   408fb:	85 c0                	test   %eax,%eax
   408fd:	75 2a                	jne    40929 <copy_pagetable+0x105>
				|| virtual_memory_map(dest->p_pagetable, va, free_page, PAGESIZE, map.perm)) {
   408ff:	8b 4d f0             	mov    -0x10(%rbp),%ecx
   40902:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40906:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4090a:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40911:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40915:	41 89 c8             	mov    %ecx,%r8d
   40918:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4091d:	48 89 c7             	mov    %rax,%rdi
   40920:	e8 34 25 00 00       	call   42e59 <virtual_memory_map>
   40925:	85 c0                	test   %eax,%eax
   40927:	74 07                	je     40930 <copy_pagetable+0x10c>

				// failure conditions are 
				//  no free page, 
				//  no allocated l1 pagetable <-- i don't think we'll ever actually run into this 

				return -1;
   40929:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4092e:	eb 39                	jmp    40969 <copy_pagetable+0x145>
			}
			else {
				memcpy((void *) free_page, (void *) map.pa, PAGESIZE);
   40930:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40934:	48 89 c1             	mov    %rax,%rcx
   40937:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4093b:	ba 00 10 00 00       	mov    $0x1000,%edx
   40940:	48 89 ce             	mov    %rcx,%rsi
   40943:	48 89 c7             	mov    %rax,%rdi
   40946:	e8 ec 2c 00 00       	call   43637 <memcpy>
   4094b:	eb 01                	jmp    4094e <copy_pagetable+0x12a>
			continue;
   4094d:	90                   	nop
	for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   4094e:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40955:	00 
   40956:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   4095d:	00 
   4095e:	0f 86 dd fe ff ff    	jbe    40841 <copy_pagetable+0x1d>
			}
		}
	}

	return 0;
   40964:	b8 00 00 00 00       	mov    $0x0,%eax
}
   40969:	c9                   	leave  
   4096a:	c3                   	ret    

000000000004096b <free_pagetable_pages>:
//		pages!
//
//		in practice, this function frees pagetable pages


void free_pagetable_pages(proc *p) {
   4096b:	55                   	push   %rbp
   4096c:	48 89 e5             	mov    %rsp,%rbp
   4096f:	48 83 ec 18          	sub    $0x18,%rsp
   40973:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
	x86_64_pagetable *page = p->p_pagetable;
   40977:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4097b:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40982:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

	// l4 pagetable	
	pageinfo[PAGENUMBER(page)].owner = PO_FREE;
   40986:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4098a:	48 c1 e8 0c          	shr    $0xc,%rax
   4098e:	48 98                	cltq   
   40990:	c6 84 00 40 2e 05 00 	movb   $0x0,0x52e40(%rax,%rax,1)
   40997:	00 
	--pageinfo[PAGENUMBER(page)].refcount;
   40998:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4099c:	48 c1 e8 0c          	shr    $0xc,%rax
   409a0:	89 c2                	mov    %eax,%edx
   409a2:	48 63 c2             	movslq %edx,%rax
   409a5:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   409ac:	00 
   409ad:	83 e8 01             	sub    $0x1,%eax
   409b0:	89 c1                	mov    %eax,%ecx
   409b2:	48 63 c2             	movslq %edx,%rax
   409b5:	88 8c 00 41 2e 05 00 	mov    %cl,0x52e41(%rax,%rax,1)

	// l3 pagetable
	page = (x86_64_pagetable *) PTE_ADDR(page->entry[0]);
   409bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   409c0:	48 8b 00             	mov    (%rax),%rax
   409c3:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   409c9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
	pageinfo[PAGENUMBER(page)].owner = PO_FREE;
   409cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   409d1:	48 c1 e8 0c          	shr    $0xc,%rax
   409d5:	48 98                	cltq   
   409d7:	c6 84 00 40 2e 05 00 	movb   $0x0,0x52e40(%rax,%rax,1)
   409de:	00 
	--pageinfo[PAGENUMBER(page)].refcount;
   409df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   409e3:	48 c1 e8 0c          	shr    $0xc,%rax
   409e7:	89 c2                	mov    %eax,%edx
   409e9:	48 63 c2             	movslq %edx,%rax
   409ec:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   409f3:	00 
   409f4:	83 e8 01             	sub    $0x1,%eax
   409f7:	89 c1                	mov    %eax,%ecx
   409f9:	48 63 c2             	movslq %edx,%rax
   409fc:	88 8c 00 41 2e 05 00 	mov    %cl,0x52e41(%rax,%rax,1)

	// l2 pagetable
	page = (x86_64_pagetable *) PTE_ADDR(page->entry[0]); 
   40a03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a07:	48 8b 00             	mov    (%rax),%rax
   40a0a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40a10:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
	pageinfo[PAGENUMBER(page)].owner = PO_FREE;
   40a14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a18:	48 c1 e8 0c          	shr    $0xc,%rax
   40a1c:	48 98                	cltq   
   40a1e:	c6 84 00 40 2e 05 00 	movb   $0x0,0x52e40(%rax,%rax,1)
   40a25:	00 
	--pageinfo[PAGENUMBER(page)].refcount;
   40a26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a2a:	48 c1 e8 0c          	shr    $0xc,%rax
   40a2e:	89 c2                	mov    %eax,%edx
   40a30:	48 63 c2             	movslq %edx,%rax
   40a33:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   40a3a:	00 
   40a3b:	83 e8 01             	sub    $0x1,%eax
   40a3e:	89 c1                	mov    %eax,%ecx
   40a40:	48 63 c2             	movslq %edx,%rax
   40a43:	88 8c 00 41 2e 05 00 	mov    %cl,0x52e41(%rax,%rax,1)

	// l1 pagetables
	x86_64_pagetable *l1 = (x86_64_pagetable *) PTE_ADDR(page->entry[0]);
   40a4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a4e:	48 8b 00             	mov    (%rax),%rax
   40a51:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40a57:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
	pageinfo[PAGENUMBER(l1)].owner = PO_FREE;
   40a5b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40a5f:	48 c1 e8 0c          	shr    $0xc,%rax
   40a63:	48 98                	cltq   
   40a65:	c6 84 00 40 2e 05 00 	movb   $0x0,0x52e40(%rax,%rax,1)
   40a6c:	00 
	--pageinfo[PAGENUMBER(l1)].refcount;
   40a6d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40a71:	48 c1 e8 0c          	shr    $0xc,%rax
   40a75:	89 c2                	mov    %eax,%edx
   40a77:	48 63 c2             	movslq %edx,%rax
   40a7a:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   40a81:	00 
   40a82:	83 e8 01             	sub    $0x1,%eax
   40a85:	89 c1                	mov    %eax,%ecx
   40a87:	48 63 c2             	movslq %edx,%rax
   40a8a:	88 8c 00 41 2e 05 00 	mov    %cl,0x52e41(%rax,%rax,1)
	
	l1 = (x86_64_pagetable *) PTE_ADDR(page->entry[1]);
   40a91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a95:	48 8b 40 08          	mov    0x8(%rax),%rax
   40a99:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40a9f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
	pageinfo[PAGENUMBER(l1)].owner = PO_FREE;
   40aa3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40aa7:	48 c1 e8 0c          	shr    $0xc,%rax
   40aab:	48 98                	cltq   
   40aad:	c6 84 00 40 2e 05 00 	movb   $0x0,0x52e40(%rax,%rax,1)
   40ab4:	00 
	--pageinfo[PAGENUMBER(l1)].refcount;
   40ab5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40ab9:	48 c1 e8 0c          	shr    $0xc,%rax
   40abd:	89 c2                	mov    %eax,%edx
   40abf:	48 63 c2             	movslq %edx,%rax
   40ac2:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   40ac9:	00 
   40aca:	83 e8 01             	sub    $0x1,%eax
   40acd:	89 c1                	mov    %eax,%ecx
   40acf:	48 63 c2             	movslq %edx,%rax
   40ad2:	88 8c 00 41 2e 05 00 	mov    %cl,0x52e41(%rax,%rax,1)
}
   40ad9:	90                   	nop
   40ada:	c9                   	leave  
   40adb:	c3                   	ret    

0000000000040adc <free_pages_va>:

// free_process_pages(pid_t pid)
//		frees physical pages allocated to the process with pid

void free_pages_va(proc *p) {
   40adc:	55                   	push   %rbp
   40add:	48 89 e5             	mov    %rsp,%rbp
   40ae0:	48 83 ec 30          	sub    $0x30,%rsp
   40ae4:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
	for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40ae8:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   40aef:	00 
   40af0:	e9 8c 00 00 00       	jmp    40b81 <free_pages_va+0xa5>
		vamapping map = virtual_memory_lookup(p->p_pagetable, va); // examining addr page by page
   40af5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40af9:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40b00:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   40b04:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40b08:	48 89 ce             	mov    %rcx,%rsi
   40b0b:	48 89 c7             	mov    %rax,%rdi
   40b0e:	e8 0c 27 00 00       	call   4321f <virtual_memory_lookup>
		
		if (map.pn == -1) { // unused va
   40b13:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40b16:	83 f8 ff             	cmp    $0xffffffff,%eax
   40b19:	74 5d                	je     40b78 <free_pages_va+0x9c>
			continue;
		}
		else if ((map.perm & PTE_P) && (map.perm & PTE_U)) {
   40b1b:	8b 45 f0             	mov    -0x10(%rbp),%eax
   40b1e:	48 98                	cltq   
   40b20:	83 e0 01             	and    $0x1,%eax
   40b23:	48 85 c0             	test   %rax,%rax
   40b26:	74 51                	je     40b79 <free_pages_va+0x9d>
   40b28:	8b 45 f0             	mov    -0x10(%rbp),%eax
   40b2b:	48 98                	cltq   
   40b2d:	83 e0 04             	and    $0x4,%eax
   40b30:	48 85 c0             	test   %rax,%rax
   40b33:	74 44                	je     40b79 <free_pages_va+0x9d>
			if (pageinfo[map.pn].owner == p->p_pid)
   40b35:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40b38:	48 98                	cltq   
   40b3a:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   40b41:	00 
   40b42:	0f be d0             	movsbl %al,%edx
   40b45:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40b49:	8b 00                	mov    (%rax),%eax
   40b4b:	39 c2                	cmp    %eax,%edx
   40b4d:	75 0d                	jne    40b5c <free_pages_va+0x80>
				pageinfo[map.pn].owner = PO_FREE;
   40b4f:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40b52:	48 98                	cltq   
   40b54:	c6 84 00 40 2e 05 00 	movb   $0x0,0x52e40(%rax,%rax,1)
   40b5b:	00 
			--pageinfo[map.pn].refcount;	
   40b5c:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40b5f:	48 63 d0             	movslq %eax,%rdx
   40b62:	0f b6 94 12 41 2e 05 	movzbl 0x52e41(%rdx,%rdx,1),%edx
   40b69:	00 
   40b6a:	83 ea 01             	sub    $0x1,%edx
   40b6d:	48 98                	cltq   
   40b6f:	88 94 00 41 2e 05 00 	mov    %dl,0x52e41(%rax,%rax,1)
   40b76:	eb 01                	jmp    40b79 <free_pages_va+0x9d>
			continue;
   40b78:	90                   	nop
	for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40b79:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40b80:	00 
   40b81:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   40b88:	00 
   40b89:	0f 86 66 ff ff ff    	jbe    40af5 <free_pages_va+0x19>
			//	console_printf(CPOS(23, 0), 0x0, 0);	
			//	console_printf(CPOS(23, 0), 0x1100, "proc 1 code page owner: %d, proc 1 code page refcount: %d\n", pageinfo[PAGENUMBER(0x7000)].owner, pageinfo[PAGENUMBER(0x7000)].refcount); 
			//}
		}
	}
}
   40b8f:	90                   	nop
   40b90:	90                   	nop
   40b91:	c9                   	leave  
   40b92:	c3                   	ret    

0000000000040b93 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   40b93:	55                   	push   %rbp
   40b94:	48 89 e5             	mov    %rsp,%rbp
   40b97:	48 81 ec 30 01 00 00 	sub    $0x130,%rsp
   40b9e:	48 89 bd d8 fe ff ff 	mov    %rdi,-0x128(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40ba5:	48 8b 05 54 14 01 00 	mov    0x11454(%rip),%rax        # 52000 <current>
   40bac:	48 8b 95 d8 fe ff ff 	mov    -0x128(%rbp),%rdx
   40bb3:	48 83 c0 08          	add    $0x8,%rax
   40bb7:	48 89 d6             	mov    %rdx,%rsi
   40bba:	ba 18 00 00 00       	mov    $0x18,%edx
   40bbf:	48 89 c7             	mov    %rax,%rdi
   40bc2:	48 89 d1             	mov    %rdx,%rcx
   40bc5:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40bc8:	48 8b 05 31 44 01 00 	mov    0x14431(%rip),%rax        # 55000 <kernel_pagetable>
   40bcf:	48 89 c7             	mov    %rax,%rdi
   40bd2:	e8 51 21 00 00       	call   42d28 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40bd7:	8b 05 1f 84 07 00    	mov    0x7841f(%rip),%eax        # b8ffc <cursorpos>
   40bdd:	89 c7                	mov    %eax,%edi
   40bdf:	e8 72 18 00 00       	call   42456 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   40be4:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40beb:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40bf2:	48 83 f8 0e          	cmp    $0xe,%rax
   40bf6:	74 14                	je     40c0c <exception+0x79>
   40bf8:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40bff:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40c06:	48 83 f8 0d          	cmp    $0xd,%rax
   40c0a:	75 16                	jne    40c22 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   40c0c:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40c13:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40c1a:	83 e0 04             	and    $0x4,%eax
   40c1d:	48 85 c0             	test   %rax,%rax
   40c20:	74 1a                	je     40c3c <exception+0xa9>
    {
        check_virtual_memory();
   40c22:	e8 e3 09 00 00       	call   4160a <check_virtual_memory>
        if(disp_global){
   40c27:	0f b6 05 d2 53 00 00 	movzbl 0x53d2(%rip),%eax        # 46000 <disp_global>
   40c2e:	84 c0                	test   %al,%al
   40c30:	74 0a                	je     40c3c <exception+0xa9>
            memshow_physical();
   40c32:	e8 4b 0b 00 00       	call   41782 <memshow_physical>
            memshow_virtual_animate();
   40c37:	e8 75 0e 00 00       	call   41ab1 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40c3c:	e8 f8 1c 00 00       	call   42939 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40c41:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40c48:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40c4f:	48 83 e8 0e          	sub    $0xe,%rax
   40c53:	48 83 f8 2a          	cmp    $0x2a,%rax
   40c57:	0f 87 bc 04 00 00    	ja     41119 <exception+0x586>
   40c5d:	48 8b 04 c5 98 47 04 	mov    0x44798(,%rax,8),%rax
   40c64:	00 
   40c65:	ff e0                	jmp    *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   40c67:	48 8b 05 92 13 01 00 	mov    0x11392(%rip),%rax        # 52000 <current>
   40c6e:	48 8b 40 38          	mov    0x38(%rax),%rax
   40c72:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
		if((void *)addr == NULL)
   40c76:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   40c7b:	75 0f                	jne    40c8c <exception+0xf9>
		    panic(NULL);
   40c7d:	bf 00 00 00 00       	mov    $0x0,%edi
   40c82:	b8 00 00 00 00       	mov    $0x0,%eax
   40c87:	e8 ee 1d 00 00       	call   42a7a <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40c8c:	48 8b 05 6d 13 01 00 	mov    0x1136d(%rip),%rax        # 52000 <current>
   40c93:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40c9a:	48 8d 45 90          	lea    -0x70(%rbp),%rax
   40c9e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40ca2:	48 89 ce             	mov    %rcx,%rsi
   40ca5:	48 89 c7             	mov    %rax,%rdi
   40ca8:	e8 72 25 00 00       	call   4321f <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   40cad:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40cb1:	48 89 c1             	mov    %rax,%rcx
   40cb4:	48 8d 85 e8 fe ff ff 	lea    -0x118(%rbp),%rax
   40cbb:	ba a0 00 00 00       	mov    $0xa0,%edx
   40cc0:	48 89 ce             	mov    %rcx,%rsi
   40cc3:	48 89 c7             	mov    %rax,%rdi
   40cc6:	e8 6c 29 00 00       	call   43637 <memcpy>
		panic(msg);
   40ccb:	48 8d 85 e8 fe ff ff 	lea    -0x118(%rbp),%rax
   40cd2:	48 89 c7             	mov    %rax,%rdi
   40cd5:	b8 00 00 00 00       	mov    $0x0,%eax
   40cda:	e8 9b 1d 00 00       	call   42a7a <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   40cdf:	48 8b 05 1a 13 01 00 	mov    0x1131a(%rip),%rax        # 52000 <current>
   40ce6:	8b 10                	mov    (%rax),%edx
   40ce8:	48 8b 05 11 13 01 00 	mov    0x11311(%rip),%rax        # 52000 <current>
   40cef:	48 63 d2             	movslq %edx,%rdx
   40cf2:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40cf6:	e9 2e 04 00 00       	jmp    41129 <exception+0x596>

    case INT_SYS_YIELD:
        schedule();
   40cfb:	e8 52 04 00 00       	call   41152 <schedule>
        break;                  /* will not be reached */
   40d00:	e9 24 04 00 00       	jmp    41129 <exception+0x596>

    case INT_SYS_PAGE_ALLOC: 
	{
        uintptr_t va = current->p_registers.reg_rdi; 
   40d05:	48 8b 05 f4 12 01 00 	mov    0x112f4(%rip),%rax        # 52000 <current>
   40d0c:	48 8b 40 38          	mov    0x38(%rax),%rax
   40d10:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		uintptr_t pa;
		int r = 0;
   40d14:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
		if (va % PAGESIZE != 0) {
   40d1b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d1f:	25 ff 0f 00 00       	and    $0xfff,%eax
   40d24:	48 85 c0             	test   %rax,%rax
   40d27:	74 0c                	je     40d35 <exception+0x1a2>
			r = -1;
   40d29:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   40d30:	e9 cf 00 00 00       	jmp    40e04 <exception+0x271>
		}
		else if (va >= MEMSIZE_VIRTUAL + PAGESIZE) {
   40d35:	48 81 7d e8 ff 0f 30 	cmpq   $0x300fff,-0x18(%rbp)
   40d3c:	00 
   40d3d:	76 0c                	jbe    40d4b <exception+0x1b8>
			r = -1;
   40d3f:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   40d46:	e9 b9 00 00 00       	jmp    40e04 <exception+0x271>
		}
		else if (virtual_memory_lookup(current->p_pagetable, va).pn != -1) {
   40d4b:	48 8b 05 ae 12 01 00 	mov    0x112ae(%rip),%rax        # 52000 <current>
   40d52:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40d59:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   40d5d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40d61:	48 89 ce             	mov    %rcx,%rsi
   40d64:	48 89 c7             	mov    %rax,%rdi
   40d67:	e8 b3 24 00 00       	call   4321f <virtual_memory_lookup>
   40d6c:	8b 45 a8             	mov    -0x58(%rbp),%eax
   40d6f:	83 f8 ff             	cmp    $0xffffffff,%eax
   40d72:	74 0c                	je     40d80 <exception+0x1ed>
			r = -1;
   40d74:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   40d7b:	e9 84 00 00 00       	jmp    40e04 <exception+0x271>
		}
		else if (next_free_page(&pa) || assign_physical_page(pa, current->p_pid)) {
   40d80:	48 8d 45 88          	lea    -0x78(%rbp),%rax
   40d84:	48 89 c7             	mov    %rax,%rdi
   40d87:	e8 3e f6 ff ff       	call   403ca <next_free_page>
   40d8c:	85 c0                	test   %eax,%eax
   40d8e:	75 1e                	jne    40dae <exception+0x21b>
   40d90:	48 8b 05 69 12 01 00 	mov    0x11269(%rip),%rax        # 52000 <current>
   40d97:	8b 00                	mov    (%rax),%eax
   40d99:	0f be d0             	movsbl %al,%edx
   40d9c:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   40da0:	89 d6                	mov    %edx,%esi
   40da2:	48 89 c7             	mov    %rax,%rdi
   40da5:	e8 8d f8 ff ff       	call   40637 <assign_physical_page>
   40daa:	85 c0                	test   %eax,%eax
   40dac:	74 22                	je     40dd0 <exception+0x23d>
			console_printf(CPOS(23, 0), 0x0400, "Out of physical memory!\n");	
   40dae:	ba d0 46 04 00       	mov    $0x446d0,%edx
   40db3:	be 00 04 00 00       	mov    $0x400,%esi
   40db8:	bf 30 07 00 00       	mov    $0x730,%edi
   40dbd:	b8 00 00 00 00       	mov    $0x0,%eax
   40dc2:	e8 25 37 00 00       	call   444ec <console_printf>
			r = -1;
   40dc7:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   40dce:	eb 34                	jmp    40e04 <exception+0x271>
		}
		else if (virtual_memory_map(current->p_pagetable, va, pa, PAGESIZE, PTE_P | PTE_W | PTE_U)) {
   40dd0:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   40dd4:	48 8b 05 25 12 01 00 	mov    0x11225(%rip),%rax        # 52000 <current>
   40ddb:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40de2:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   40de6:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40dec:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40df1:	48 89 c7             	mov    %rax,%rdi
   40df4:	e8 60 20 00 00       	call   42e59 <virtual_memory_map>
   40df9:	85 c0                	test   %eax,%eax
   40dfb:	74 07                	je     40e04 <exception+0x271>
			r = -1;
   40dfd:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
		}

        current->p_registers.reg_rax = r;
   40e04:	48 8b 05 f5 11 01 00 	mov    0x111f5(%rip),%rax        # 52000 <current>
   40e0b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40e0e:	48 63 d2             	movslq %edx,%rdx
   40e11:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40e15:	e9 0f 03 00 00       	jmp    41129 <exception+0x596>
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   40e1a:	48 8b 05 df 11 01 00 	mov    0x111df(%rip),%rax        # 52000 <current>
   40e21:	48 89 c7             	mov    %rax,%rdi
   40e24:	e8 82 f8 ff ff       	call   406ab <syscall_mapping>
            break;
   40e29:	e9 fb 02 00 00       	jmp    41129 <exception+0x596>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   40e2e:	48 8b 05 cb 11 01 00 	mov    0x111cb(%rip),%rax        # 52000 <current>
   40e35:	48 89 c7             	mov    %rax,%rdi
   40e38:	e8 37 f9 ff ff       	call   40774 <syscall_mem_tog>
	    break;
   40e3d:	e9 e7 02 00 00       	jmp    41129 <exception+0x596>
	}

    case INT_TIMER:
        ++ticks;
   40e42:	8b 05 d8 1f 01 00    	mov    0x11fd8(%rip),%eax        # 52e20 <ticks>
   40e48:	83 c0 01             	add    $0x1,%eax
   40e4b:	89 05 cf 1f 01 00    	mov    %eax,0x11fcf(%rip)        # 52e20 <ticks>
        schedule();
   40e51:	e8 fc 02 00 00       	call   41152 <schedule>
        break;                  /* will not be reached */
   40e56:	e9 ce 02 00 00       	jmp    41129 <exception+0x596>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40e5b:	0f 20 d0             	mov    %cr2,%rax
   40e5e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    return val;
   40e62:	48 8b 45 c0          	mov    -0x40(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   40e66:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   40e6a:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40e71:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40e78:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   40e7b:	48 85 c0             	test   %rax,%rax
   40e7e:	74 07                	je     40e87 <exception+0x2f4>
   40e80:	b8 e9 46 04 00       	mov    $0x446e9,%eax
   40e85:	eb 05                	jmp    40e8c <exception+0x2f9>
   40e87:	b8 ef 46 04 00       	mov    $0x446ef,%eax
        const char* operation = reg->reg_err & PFERR_WRITE
   40e8c:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   40e90:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40e97:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40e9e:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   40ea1:	48 85 c0             	test   %rax,%rax
   40ea4:	74 07                	je     40ead <exception+0x31a>
   40ea6:	b8 f4 46 04 00       	mov    $0x446f4,%eax
   40eab:	eb 05                	jmp    40eb2 <exception+0x31f>
   40ead:	b8 07 47 04 00       	mov    $0x44707,%eax
        const char* problem = reg->reg_err & PFERR_PRESENT
   40eb2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   40eb6:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40ebd:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40ec4:	83 e0 04             	and    $0x4,%eax
   40ec7:	48 85 c0             	test   %rax,%rax
   40eca:	75 2f                	jne    40efb <exception+0x368>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40ecc:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40ed3:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40eda:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   40ede:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   40ee2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40ee6:	49 89 f0             	mov    %rsi,%r8
   40ee9:	48 89 c6             	mov    %rax,%rsi
   40eec:	bf 18 47 04 00       	mov    $0x44718,%edi
   40ef1:	b8 00 00 00 00       	mov    $0x0,%eax
   40ef6:	e8 7f 1b 00 00       	call   42a7a <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   40efb:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40f02:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   40f09:	48 8b 05 f0 10 01 00 	mov    0x110f0(%rip),%rax        # 52000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   40f10:	8b 00                	mov    (%rax),%eax
   40f12:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
   40f16:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   40f1a:	52                   	push   %rdx
   40f1b:	ff 75 c8             	push   -0x38(%rbp)
   40f1e:	49 89 f1             	mov    %rsi,%r9
   40f21:	49 89 c8             	mov    %rcx,%r8
   40f24:	89 c1                	mov    %eax,%ecx
   40f26:	ba 48 47 04 00       	mov    $0x44748,%edx
   40f2b:	be 00 0c 00 00       	mov    $0xc00,%esi
   40f30:	bf 80 07 00 00       	mov    $0x780,%edi
   40f35:	b8 00 00 00 00       	mov    $0x0,%eax
   40f3a:	e8 ad 35 00 00       	call   444ec <console_printf>
   40f3f:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   40f43:	48 8b 05 b6 10 01 00 	mov    0x110b6(%rip),%rax        # 52000 <current>
   40f4a:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   40f51:	00 00 00 
        break;
   40f54:	e9 d0 01 00 00       	jmp    41129 <exception+0x596>
    }

	case INT_SYS_FORK:
		// find free pid
		pid_t child_pid;
		if ((child_pid = next_free_pid()) == -1) {
   40f59:	e8 7f f8 ff ff       	call   407dd <next_free_pid>
   40f5e:	89 45 f8             	mov    %eax,-0x8(%rbp)
   40f61:	83 7d f8 ff          	cmpl   $0xffffffff,-0x8(%rbp)
   40f65:	75 32                	jne    40f99 <exception+0x406>
			console_printf(CPOS(23, 0), 0x0400, "Max processes (%d) reached!\n", NPROC);	
   40f67:	b9 10 00 00 00       	mov    $0x10,%ecx
   40f6c:	ba 77 47 04 00       	mov    $0x44777,%edx
   40f71:	be 00 04 00 00       	mov    $0x400,%esi
   40f76:	bf 30 07 00 00       	mov    $0x730,%edi
   40f7b:	b8 00 00 00 00       	mov    $0x0,%eax
   40f80:	e8 67 35 00 00       	call   444ec <console_printf>
			current->p_registers.reg_rax = -1;
   40f85:	48 8b 05 74 10 01 00 	mov    0x11074(%rip),%rax        # 52000 <current>
   40f8c:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40f93:	ff 
			break;
   40f94:	e9 90 01 00 00       	jmp    41129 <exception+0x596>
		}

		proc *child_proc = &processes[child_pid];
   40f99:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40f9c:	48 63 d0             	movslq %eax,%rdx
   40f9f:	48 89 d0             	mov    %rdx,%rax
   40fa2:	48 c1 e0 03          	shl    $0x3,%rax
   40fa6:	48 29 d0             	sub    %rdx,%rax
   40fa9:	48 c1 e0 05          	shl    $0x5,%rax
   40fad:	48 05 20 20 05 00    	add    $0x52020,%rax
   40fb3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

		// copy the state of parent into child
		*child_proc = processes[current->p_pid];
   40fb7:	48 8b 05 42 10 01 00 	mov    0x11042(%rip),%rax        # 52000 <current>
   40fbe:	8b 00                	mov    (%rax),%eax
   40fc0:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
   40fc4:	48 63 d0             	movslq %eax,%rdx
   40fc7:	48 89 d0             	mov    %rdx,%rax
   40fca:	48 c1 e0 03          	shl    $0x3,%rax
   40fce:	48 29 d0             	sub    %rdx,%rax
   40fd1:	48 c1 e0 05          	shl    $0x5,%rax
   40fd5:	48 05 20 20 05 00    	add    $0x52020,%rax
   40fdb:	48 89 ca             	mov    %rcx,%rdx
   40fde:	48 89 c6             	mov    %rax,%rsi
   40fe1:	b8 1c 00 00 00       	mov    $0x1c,%eax
   40fe6:	48 89 d7             	mov    %rdx,%rdi
   40fe9:	48 89 c1             	mov    %rax,%rcx
   40fec:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
		child_proc->p_pid = child_pid;
   40fef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40ff3:	8b 55 f8             	mov    -0x8(%rbp),%edx
   40ff6:	89 10                	mov    %edx,(%rax)

		
		// setup and copy the pagetable
		if (pagetable_setup(child_proc->p_pid)) {
   40ff8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40ffc:	8b 00                	mov    (%rax),%eax
   40ffe:	89 c7                	mov    %eax,%edi
   41000:	e8 e4 f3 ff ff       	call   403e9 <pagetable_setup>
   41005:	85 c0                	test   %eax,%eax
   41007:	74 2a                	je     41033 <exception+0x4a0>
			memset(child_proc, 0, sizeof(*child_proc));
   41009:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4100d:	ba e0 00 00 00       	mov    $0xe0,%edx
   41012:	be 00 00 00 00       	mov    $0x0,%esi
   41017:	48 89 c7             	mov    %rax,%rdi
   4101a:	e8 16 27 00 00       	call   43735 <memset>
			current->p_registers.reg_rax = -1;
   4101f:	48 8b 05 da 0f 01 00 	mov    0x10fda(%rip),%rax        # 52000 <current>
   41026:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   4102d:	ff 
			break;
   4102e:	e9 f6 00 00 00       	jmp    41129 <exception+0x596>
		}
		else if (copy_pagetable(child_proc, current)) {
   41033:	48 8b 15 c6 0f 01 00 	mov    0x10fc6(%rip),%rdx        # 52000 <current>
   4103a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4103e:	48 89 d6             	mov    %rdx,%rsi
   41041:	48 89 c7             	mov    %rax,%rdi
   41044:	e8 db f7 ff ff       	call   40824 <copy_pagetable>
   41049:	85 c0                	test   %eax,%eax
   4104b:	74 42                	je     4108f <exception+0x4fc>
			free_pages_va(child_proc);		    // goes through all va and frees corresponding physical page
   4104d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41051:	48 89 c7             	mov    %rax,%rdi
   41054:	e8 83 fa ff ff       	call   40adc <free_pages_va>
			free_pagetable_pages(child_proc);	    // goes through all pa and frees ones that belong to child_proc
   41059:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4105d:	48 89 c7             	mov    %rax,%rdi
   41060:	e8 06 f9 ff ff       	call   4096b <free_pagetable_pages>

			memset(child_proc, 0, sizeof(*child_proc));
   41065:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41069:	ba e0 00 00 00       	mov    $0xe0,%edx
   4106e:	be 00 00 00 00       	mov    $0x0,%esi
   41073:	48 89 c7             	mov    %rax,%rdi
   41076:	e8 ba 26 00 00       	call   43735 <memset>
			current->p_registers.reg_rax = -1;
   4107b:	48 8b 05 7e 0f 01 00 	mov    0x10f7e(%rip),%rax        # 52000 <current>
   41082:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   41089:	ff 
			break;
   4108a:	e9 9a 00 00 00       	jmp    41129 <exception+0x596>
		}


		// successful fork! set return registers
                console_printf(CPOS(24, 0), 0, "\n");
   4108f:	ba 94 47 04 00       	mov    $0x44794,%edx
   41094:	be 00 00 00 00       	mov    $0x0,%esi
   41099:	bf 80 07 00 00       	mov    $0x780,%edi
   4109e:	b8 00 00 00 00       	mov    $0x0,%eax
   410a3:	e8 44 34 00 00       	call   444ec <console_printf>

		child_proc->p_registers.reg_rax = 0;
   410a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   410ac:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   410b3:	00 
		current->p_registers.reg_rax = child_pid;
   410b4:	48 8b 05 45 0f 01 00 	mov    0x10f45(%rip),%rax        # 52000 <current>
   410bb:	8b 55 f8             	mov    -0x8(%rbp),%edx
   410be:	48 63 d2             	movslq %edx,%rdx
   410c1:	48 89 50 08          	mov    %rdx,0x8(%rax)
		break;
   410c5:	eb 62                	jmp    41129 <exception+0x596>

	case INT_SYS_EXIT:
		free_pages_va(current);			// goes through all va and frees corresponding physical page
   410c7:	48 8b 05 32 0f 01 00 	mov    0x10f32(%rip),%rax        # 52000 <current>
   410ce:	48 89 c7             	mov    %rax,%rdi
   410d1:	e8 06 fa ff ff       	call   40adc <free_pages_va>
		free_pagetable_pages(current);	// goes through all pa and frees ones that belong to child_proc
   410d6:	48 8b 05 23 0f 01 00 	mov    0x10f23(%rip),%rax        # 52000 <current>
   410dd:	48 89 c7             	mov    %rax,%rdi
   410e0:	e8 86 f8 ff ff       	call   4096b <free_pagetable_pages>
		memset(&processes[current->p_pid], 0, sizeof(*current));
   410e5:	48 8b 05 14 0f 01 00 	mov    0x10f14(%rip),%rax        # 52000 <current>
   410ec:	8b 00                	mov    (%rax),%eax
   410ee:	48 63 d0             	movslq %eax,%rdx
   410f1:	48 89 d0             	mov    %rdx,%rax
   410f4:	48 c1 e0 03          	shl    $0x3,%rax
   410f8:	48 29 d0             	sub    %rdx,%rax
   410fb:	48 c1 e0 05          	shl    $0x5,%rax
   410ff:	48 05 20 20 05 00    	add    $0x52020,%rax
   41105:	ba e0 00 00 00       	mov    $0xe0,%edx
   4110a:	be 00 00 00 00       	mov    $0x0,%esi
   4110f:	48 89 c7             	mov    %rax,%rdi
   41112:	e8 1e 26 00 00       	call   43735 <memset>
		break;
   41117:	eb 10                	jmp    41129 <exception+0x596>

    default:
        default_exception(current);
   41119:	48 8b 05 e0 0e 01 00 	mov    0x10ee0(%rip),%rax        # 52000 <current>
   41120:	48 89 c7             	mov    %rax,%rdi
   41123:	e8 62 1a 00 00       	call   42b8a <default_exception>
        break;                  /* will not be reached */
   41128:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   41129:	48 8b 05 d0 0e 01 00 	mov    0x10ed0(%rip),%rax        # 52000 <current>
   41130:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   41136:	83 f8 01             	cmp    $0x1,%eax
   41139:	75 0f                	jne    4114a <exception+0x5b7>
        run(current);
   4113b:	48 8b 05 be 0e 01 00 	mov    0x10ebe(%rip),%rax        # 52000 <current>
   41142:	48 89 c7             	mov    %rax,%rdi
   41145:	e8 7e 00 00 00       	call   411c8 <run>
    } else {
        schedule();
   4114a:	e8 03 00 00 00       	call   41152 <schedule>
    }
}
   4114f:	90                   	nop
   41150:	c9                   	leave  
   41151:	c3                   	ret    

0000000000041152 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   41152:	55                   	push   %rbp
   41153:	48 89 e5             	mov    %rsp,%rbp
   41156:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   4115a:	48 8b 05 9f 0e 01 00 	mov    0x10e9f(%rip),%rax        # 52000 <current>
   41161:	8b 00                	mov    (%rax),%eax
   41163:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   41166:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41169:	8d 50 01             	lea    0x1(%rax),%edx
   4116c:	89 d0                	mov    %edx,%eax
   4116e:	c1 f8 1f             	sar    $0x1f,%eax
   41171:	c1 e8 1c             	shr    $0x1c,%eax
   41174:	01 c2                	add    %eax,%edx
   41176:	83 e2 0f             	and    $0xf,%edx
   41179:	29 c2                	sub    %eax,%edx
   4117b:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   4117e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41181:	48 63 d0             	movslq %eax,%rdx
   41184:	48 89 d0             	mov    %rdx,%rax
   41187:	48 c1 e0 03          	shl    $0x3,%rax
   4118b:	48 29 d0             	sub    %rdx,%rax
   4118e:	48 c1 e0 05          	shl    $0x5,%rax
   41192:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41198:	8b 00                	mov    (%rax),%eax
   4119a:	83 f8 01             	cmp    $0x1,%eax
   4119d:	75 22                	jne    411c1 <schedule+0x6f>
            run(&processes[pid]);
   4119f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411a2:	48 63 d0             	movslq %eax,%rdx
   411a5:	48 89 d0             	mov    %rdx,%rax
   411a8:	48 c1 e0 03          	shl    $0x3,%rax
   411ac:	48 29 d0             	sub    %rdx,%rax
   411af:	48 c1 e0 05          	shl    $0x5,%rax
   411b3:	48 05 20 20 05 00    	add    $0x52020,%rax
   411b9:	48 89 c7             	mov    %rax,%rdi
   411bc:	e8 07 00 00 00       	call   411c8 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   411c1:	e8 73 17 00 00       	call   42939 <check_keyboard>
        pid = (pid + 1) % NPROC;
   411c6:	eb 9e                	jmp    41166 <schedule+0x14>

00000000000411c8 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   411c8:	55                   	push   %rbp
   411c9:	48 89 e5             	mov    %rsp,%rbp
   411cc:	48 83 ec 10          	sub    $0x10,%rsp
   411d0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   411d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   411d8:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   411de:	83 f8 01             	cmp    $0x1,%eax
   411e1:	74 14                	je     411f7 <run+0x2f>
   411e3:	ba f0 48 04 00       	mov    $0x448f0,%edx
   411e8:	be 63 02 00 00       	mov    $0x263,%esi
   411ed:	bf c0 46 04 00       	mov    $0x446c0,%edi
   411f2:	e8 63 19 00 00       	call   42b5a <assert_fail>
    current = p;
   411f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   411fb:	48 89 05 fe 0d 01 00 	mov    %rax,0x10dfe(%rip)        # 52000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   41202:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41206:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   4120d:	48 89 c7             	mov    %rax,%rdi
   41210:	e8 13 1b 00 00       	call   42d28 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   41215:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41219:	48 83 c0 08          	add    $0x8,%rax
   4121d:	48 89 c7             	mov    %rax,%rdi
   41220:	e8 9e ee ff ff       	call   400c3 <exception_return>

0000000000041225 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   41225:	55                   	push   %rbp
   41226:	48 89 e5             	mov    %rsp,%rbp
   41229:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   4122d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41234:	00 
   41235:	e9 81 00 00 00       	jmp    412bb <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   4123a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4123e:	48 89 c7             	mov    %rax,%rdi
   41241:	e8 81 0f 00 00       	call   421c7 <physical_memory_isreserved>
   41246:	85 c0                	test   %eax,%eax
   41248:	74 09                	je     41253 <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   4124a:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   41251:	eb 2f                	jmp    41282 <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   41253:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   4125a:	00 
   4125b:	76 0b                	jbe    41268 <pageinfo_init+0x43>
   4125d:	b8 08 b0 05 00       	mov    $0x5b008,%eax
   41262:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41266:	72 0a                	jb     41272 <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   41268:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   4126f:	00 
   41270:	75 09                	jne    4127b <pageinfo_init+0x56>
            owner = PO_KERNEL;
   41272:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   41279:	eb 07                	jmp    41282 <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   4127b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   41282:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41286:	48 c1 e8 0c          	shr    $0xc,%rax
   4128a:	89 c1                	mov    %eax,%ecx
   4128c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4128f:	89 c2                	mov    %eax,%edx
   41291:	48 63 c1             	movslq %ecx,%rax
   41294:	88 94 00 40 2e 05 00 	mov    %dl,0x52e40(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   4129b:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4129f:	0f 95 c2             	setne  %dl
   412a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   412a6:	48 c1 e8 0c          	shr    $0xc,%rax
   412aa:	48 98                	cltq   
   412ac:	88 94 00 41 2e 05 00 	mov    %dl,0x52e41(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   412b3:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   412ba:	00 
   412bb:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   412c2:	00 
   412c3:	0f 86 71 ff ff ff    	jbe    4123a <pageinfo_init+0x15>
    }
}
   412c9:	90                   	nop
   412ca:	90                   	nop
   412cb:	c9                   	leave  
   412cc:	c3                   	ret    

00000000000412cd <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   412cd:	55                   	push   %rbp
   412ce:	48 89 e5             	mov    %rsp,%rbp
   412d1:	48 83 ec 50          	sub    $0x50,%rsp
   412d5:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   412d9:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   412dd:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   412e3:	48 89 c2             	mov    %rax,%rdx
   412e6:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   412ea:	48 39 c2             	cmp    %rax,%rdx
   412ed:	74 14                	je     41303 <check_page_table_mappings+0x36>
   412ef:	ba 10 49 04 00       	mov    $0x44910,%edx
   412f4:	be 8d 02 00 00       	mov    $0x28d,%esi
   412f9:	bf c0 46 04 00       	mov    $0x446c0,%edi
   412fe:	e8 57 18 00 00       	call   42b5a <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   41303:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   4130a:	00 
   4130b:	e9 9a 00 00 00       	jmp    413aa <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   41310:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   41314:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41318:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   4131c:	48 89 ce             	mov    %rcx,%rsi
   4131f:	48 89 c7             	mov    %rax,%rdi
   41322:	e8 f8 1e 00 00       	call   4321f <virtual_memory_lookup>
        if (vam.pa != va) {
   41327:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4132b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4132f:	74 27                	je     41358 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   41331:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   41335:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41339:	49 89 d0             	mov    %rdx,%r8
   4133c:	48 89 c1             	mov    %rax,%rcx
   4133f:	ba 2f 49 04 00       	mov    $0x4492f,%edx
   41344:	be 00 c0 00 00       	mov    $0xc000,%esi
   41349:	bf e0 06 00 00       	mov    $0x6e0,%edi
   4134e:	b8 00 00 00 00       	mov    $0x0,%eax
   41353:	e8 94 31 00 00       	call   444ec <console_printf>
        }
        assert(vam.pa == va);
   41358:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4135c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41360:	74 14                	je     41376 <check_page_table_mappings+0xa9>
   41362:	ba 39 49 04 00       	mov    $0x44939,%edx
   41367:	be 96 02 00 00       	mov    $0x296,%esi
   4136c:	bf c0 46 04 00       	mov    $0x446c0,%edi
   41371:	e8 e4 17 00 00       	call   42b5a <assert_fail>
        if (va >= (uintptr_t) start_data) {
   41376:	b8 00 60 04 00       	mov    $0x46000,%eax
   4137b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4137f:	72 21                	jb     413a2 <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   41381:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41384:	48 98                	cltq   
   41386:	83 e0 02             	and    $0x2,%eax
   41389:	48 85 c0             	test   %rax,%rax
   4138c:	75 14                	jne    413a2 <check_page_table_mappings+0xd5>
   4138e:	ba 46 49 04 00       	mov    $0x44946,%edx
   41393:	be 98 02 00 00       	mov    $0x298,%esi
   41398:	bf c0 46 04 00       	mov    $0x446c0,%edi
   4139d:	e8 b8 17 00 00       	call   42b5a <assert_fail>
         va += PAGESIZE) {
   413a2:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   413a9:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   413aa:	b8 08 b0 05 00       	mov    $0x5b008,%eax
   413af:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   413b3:	0f 82 57 ff ff ff    	jb     41310 <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   413b9:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   413c0:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   413c1:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   413c5:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   413c9:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   413cd:	48 89 ce             	mov    %rcx,%rsi
   413d0:	48 89 c7             	mov    %rax,%rdi
   413d3:	e8 47 1e 00 00       	call   4321f <virtual_memory_lookup>
    assert(vam.pa == kstack);
   413d8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   413dc:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   413e0:	74 14                	je     413f6 <check_page_table_mappings+0x129>
   413e2:	ba 57 49 04 00       	mov    $0x44957,%edx
   413e7:	be 9f 02 00 00       	mov    $0x29f,%esi
   413ec:	bf c0 46 04 00       	mov    $0x446c0,%edi
   413f1:	e8 64 17 00 00       	call   42b5a <assert_fail>
    assert(vam.perm & PTE_W);
   413f6:	8b 45 e8             	mov    -0x18(%rbp),%eax
   413f9:	48 98                	cltq   
   413fb:	83 e0 02             	and    $0x2,%eax
   413fe:	48 85 c0             	test   %rax,%rax
   41401:	75 14                	jne    41417 <check_page_table_mappings+0x14a>
   41403:	ba 46 49 04 00       	mov    $0x44946,%edx
   41408:	be a0 02 00 00       	mov    $0x2a0,%esi
   4140d:	bf c0 46 04 00       	mov    $0x446c0,%edi
   41412:	e8 43 17 00 00       	call   42b5a <assert_fail>
}
   41417:	90                   	nop
   41418:	c9                   	leave  
   41419:	c3                   	ret    

000000000004141a <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   4141a:	55                   	push   %rbp
   4141b:	48 89 e5             	mov    %rsp,%rbp
   4141e:	48 83 ec 20          	sub    $0x20,%rsp
   41422:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41426:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   41429:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4142c:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   4142f:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   41436:	48 8b 05 c3 3b 01 00 	mov    0x13bc3(%rip),%rax        # 55000 <kernel_pagetable>
   4143d:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   41441:	75 67                	jne    414aa <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   41443:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   4144a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41451:	eb 51                	jmp    414a4 <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   41453:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41456:	48 63 d0             	movslq %eax,%rdx
   41459:	48 89 d0             	mov    %rdx,%rax
   4145c:	48 c1 e0 03          	shl    $0x3,%rax
   41460:	48 29 d0             	sub    %rdx,%rax
   41463:	48 c1 e0 05          	shl    $0x5,%rax
   41467:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   4146d:	8b 00                	mov    (%rax),%eax
   4146f:	85 c0                	test   %eax,%eax
   41471:	74 2d                	je     414a0 <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   41473:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41476:	48 63 d0             	movslq %eax,%rdx
   41479:	48 89 d0             	mov    %rdx,%rax
   4147c:	48 c1 e0 03          	shl    $0x3,%rax
   41480:	48 29 d0             	sub    %rdx,%rax
   41483:	48 c1 e0 05          	shl    $0x5,%rax
   41487:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   4148d:	48 8b 10             	mov    (%rax),%rdx
   41490:	48 8b 05 69 3b 01 00 	mov    0x13b69(%rip),%rax        # 55000 <kernel_pagetable>
   41497:	48 39 c2             	cmp    %rax,%rdx
   4149a:	75 04                	jne    414a0 <check_page_table_ownership+0x86>
                ++expected_refcount;
   4149c:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   414a0:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   414a4:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   414a8:	7e a9                	jle    41453 <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   414aa:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   414ad:	8b 55 fc             	mov    -0x4(%rbp),%edx
   414b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   414b4:	be 00 00 00 00       	mov    $0x0,%esi
   414b9:	48 89 c7             	mov    %rax,%rdi
   414bc:	e8 03 00 00 00       	call   414c4 <check_page_table_ownership_level>
}
   414c1:	90                   	nop
   414c2:	c9                   	leave  
   414c3:	c3                   	ret    

00000000000414c4 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   414c4:	55                   	push   %rbp
   414c5:	48 89 e5             	mov    %rsp,%rbp
   414c8:	48 83 ec 30          	sub    $0x30,%rsp
   414cc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   414d0:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   414d3:	89 55 e0             	mov    %edx,-0x20(%rbp)
   414d6:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   414d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   414dd:	48 c1 e8 0c          	shr    $0xc,%rax
   414e1:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   414e6:	7e 14                	jle    414fc <check_page_table_ownership_level+0x38>
   414e8:	ba 68 49 04 00       	mov    $0x44968,%edx
   414ed:	be bd 02 00 00       	mov    $0x2bd,%esi
   414f2:	bf c0 46 04 00       	mov    $0x446c0,%edi
   414f7:	e8 5e 16 00 00       	call   42b5a <assert_fail>
    if (pageinfo[PAGENUMBER(pt)].owner != owner) {
   414fc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41500:	48 c1 e8 0c          	shr    $0xc,%rax
   41504:	48 98                	cltq   
   41506:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   4150d:	00 
   4150e:	0f be c0             	movsbl %al,%eax
   41511:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   41514:	74 34                	je     4154a <check_page_table_ownership_level+0x86>
	panic("pt addr: %p, supposed owner of pt: %d, actual owner of pt: %d, refcount: %d", pt, owner, pageinfo[PAGENUMBER(pt)].owner,
   41516:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4151a:	48 c1 e8 0c          	shr    $0xc,%rax
   4151e:	48 98                	cltq   
   41520:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   41527:	00 
   41528:	0f be c8             	movsbl %al,%ecx
   4152b:	8b 75 dc             	mov    -0x24(%rbp),%esi
   4152e:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41531:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41535:	41 89 f0             	mov    %esi,%r8d
   41538:	48 89 c6             	mov    %rax,%rsi
   4153b:	bf 80 49 04 00       	mov    $0x44980,%edi
   41540:	b8 00 00 00 00       	mov    $0x0,%eax
   41545:	e8 30 15 00 00       	call   42a7a <panic>
			refcount);
    }
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   4154a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4154e:	48 c1 e8 0c          	shr    $0xc,%rax
   41552:	48 98                	cltq   
   41554:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   4155b:	00 
   4155c:	0f be c0             	movsbl %al,%eax
   4155f:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   41562:	74 14                	je     41578 <check_page_table_ownership_level+0xb4>
   41564:	ba d0 49 04 00       	mov    $0x449d0,%edx
   41569:	be c2 02 00 00       	mov    $0x2c2,%esi
   4156e:	bf c0 46 04 00       	mov    $0x446c0,%edi
   41573:	e8 e2 15 00 00       	call   42b5a <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   41578:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4157c:	48 c1 e8 0c          	shr    $0xc,%rax
   41580:	48 98                	cltq   
   41582:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   41589:	00 
   4158a:	0f be c0             	movsbl %al,%eax
   4158d:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   41590:	74 14                	je     415a6 <check_page_table_ownership_level+0xe2>
   41592:	ba f8 49 04 00       	mov    $0x449f8,%edx
   41597:	be c3 02 00 00       	mov    $0x2c3,%esi
   4159c:	bf c0 46 04 00       	mov    $0x446c0,%edi
   415a1:	e8 b4 15 00 00       	call   42b5a <assert_fail>
    if (level < 3) {
   415a6:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   415aa:	7f 5b                	jg     41607 <check_page_table_ownership_level+0x143>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   415ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   415b3:	eb 49                	jmp    415fe <check_page_table_ownership_level+0x13a>
            if (pt->entry[index]) {
   415b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   415b9:	8b 55 fc             	mov    -0x4(%rbp),%edx
   415bc:	48 63 d2             	movslq %edx,%rdx
   415bf:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   415c3:	48 85 c0             	test   %rax,%rax
   415c6:	74 32                	je     415fa <check_page_table_ownership_level+0x136>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   415c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   415cc:	8b 55 fc             	mov    -0x4(%rbp),%edx
   415cf:	48 63 d2             	movslq %edx,%rdx
   415d2:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   415d6:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   415dc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   415e0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   415e3:	8d 70 01             	lea    0x1(%rax),%esi
   415e6:	8b 55 e0             	mov    -0x20(%rbp),%edx
   415e9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   415ed:	b9 01 00 00 00       	mov    $0x1,%ecx
   415f2:	48 89 c7             	mov    %rax,%rdi
   415f5:	e8 ca fe ff ff       	call   414c4 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   415fa:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   415fe:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41605:	7e ae                	jle    415b5 <check_page_table_ownership_level+0xf1>
            }
        }
    }
}
   41607:	90                   	nop
   41608:	c9                   	leave  
   41609:	c3                   	ret    

000000000004160a <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   4160a:	55                   	push   %rbp
   4160b:	48 89 e5             	mov    %rsp,%rbp
   4160e:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   41612:	8b 05 d0 0a 01 00    	mov    0x10ad0(%rip),%eax        # 520e8 <processes+0xc8>
   41618:	85 c0                	test   %eax,%eax
   4161a:	74 14                	je     41630 <check_virtual_memory+0x26>
   4161c:	ba 28 4a 04 00       	mov    $0x44a28,%edx
   41621:	be d6 02 00 00       	mov    $0x2d6,%esi
   41626:	bf c0 46 04 00       	mov    $0x446c0,%edi
   4162b:	e8 2a 15 00 00       	call   42b5a <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   41630:	48 8b 05 c9 39 01 00 	mov    0x139c9(%rip),%rax        # 55000 <kernel_pagetable>
   41637:	48 89 c7             	mov    %rax,%rdi
   4163a:	e8 8e fc ff ff       	call   412cd <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   4163f:	48 8b 05 ba 39 01 00 	mov    0x139ba(%rip),%rax        # 55000 <kernel_pagetable>
   41646:	be ff ff ff ff       	mov    $0xffffffff,%esi
   4164b:	48 89 c7             	mov    %rax,%rdi
   4164e:	e8 c7 fd ff ff       	call   4141a <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   41653:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4165a:	e9 9c 00 00 00       	jmp    416fb <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   4165f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41662:	48 63 d0             	movslq %eax,%rdx
   41665:	48 89 d0             	mov    %rdx,%rax
   41668:	48 c1 e0 03          	shl    $0x3,%rax
   4166c:	48 29 d0             	sub    %rdx,%rax
   4166f:	48 c1 e0 05          	shl    $0x5,%rax
   41673:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41679:	8b 00                	mov    (%rax),%eax
   4167b:	85 c0                	test   %eax,%eax
   4167d:	74 78                	je     416f7 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   4167f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41682:	48 63 d0             	movslq %eax,%rdx
   41685:	48 89 d0             	mov    %rdx,%rax
   41688:	48 c1 e0 03          	shl    $0x3,%rax
   4168c:	48 29 d0             	sub    %rdx,%rax
   4168f:	48 c1 e0 05          	shl    $0x5,%rax
   41693:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   41699:	48 8b 10             	mov    (%rax),%rdx
   4169c:	48 8b 05 5d 39 01 00 	mov    0x1395d(%rip),%rax        # 55000 <kernel_pagetable>
   416a3:	48 39 c2             	cmp    %rax,%rdx
   416a6:	74 4f                	je     416f7 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   416a8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   416ab:	48 63 d0             	movslq %eax,%rdx
   416ae:	48 89 d0             	mov    %rdx,%rax
   416b1:	48 c1 e0 03          	shl    $0x3,%rax
   416b5:	48 29 d0             	sub    %rdx,%rax
   416b8:	48 c1 e0 05          	shl    $0x5,%rax
   416bc:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   416c2:	48 8b 00             	mov    (%rax),%rax
   416c5:	48 89 c7             	mov    %rax,%rdi
   416c8:	e8 00 fc ff ff       	call   412cd <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   416cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   416d0:	48 63 d0             	movslq %eax,%rdx
   416d3:	48 89 d0             	mov    %rdx,%rax
   416d6:	48 c1 e0 03          	shl    $0x3,%rax
   416da:	48 29 d0             	sub    %rdx,%rax
   416dd:	48 c1 e0 05          	shl    $0x5,%rax
   416e1:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   416e7:	48 8b 00             	mov    (%rax),%rax
   416ea:	8b 55 fc             	mov    -0x4(%rbp),%edx
   416ed:	89 d6                	mov    %edx,%esi
   416ef:	48 89 c7             	mov    %rax,%rdi
   416f2:	e8 23 fd ff ff       	call   4141a <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   416f7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   416fb:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   416ff:	0f 8e 5a ff ff ff    	jle    4165f <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41705:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   4170c:	eb 67                	jmp    41775 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   4170e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41711:	48 98                	cltq   
   41713:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   4171a:	00 
   4171b:	84 c0                	test   %al,%al
   4171d:	7e 52                	jle    41771 <check_virtual_memory+0x167>
   4171f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41722:	48 98                	cltq   
   41724:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   4172b:	00 
   4172c:	84 c0                	test   %al,%al
   4172e:	78 41                	js     41771 <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   41730:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41733:	48 98                	cltq   
   41735:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   4173c:	00 
   4173d:	0f be c0             	movsbl %al,%eax
   41740:	48 63 d0             	movslq %eax,%rdx
   41743:	48 89 d0             	mov    %rdx,%rax
   41746:	48 c1 e0 03          	shl    $0x3,%rax
   4174a:	48 29 d0             	sub    %rdx,%rax
   4174d:	48 c1 e0 05          	shl    $0x5,%rax
   41751:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41757:	8b 00                	mov    (%rax),%eax
   41759:	85 c0                	test   %eax,%eax
   4175b:	75 14                	jne    41771 <check_virtual_memory+0x167>
   4175d:	ba 48 4a 04 00       	mov    $0x44a48,%edx
   41762:	be ed 02 00 00       	mov    $0x2ed,%esi
   41767:	bf c0 46 04 00       	mov    $0x446c0,%edi
   4176c:	e8 e9 13 00 00       	call   42b5a <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41771:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41775:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   4177c:	7e 90                	jle    4170e <check_virtual_memory+0x104>
        }
    }
}
   4177e:	90                   	nop
   4177f:	90                   	nop
   41780:	c9                   	leave  
   41781:	c3                   	ret    

0000000000041782 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   41782:	55                   	push   %rbp
   41783:	48 89 e5             	mov    %rsp,%rbp
   41786:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   4178a:	ba a6 4a 04 00       	mov    $0x44aa6,%edx
   4178f:	be 00 0f 00 00       	mov    $0xf00,%esi
   41794:	bf 20 00 00 00       	mov    $0x20,%edi
   41799:	b8 00 00 00 00       	mov    $0x0,%eax
   4179e:	e8 49 2d 00 00       	call   444ec <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   417a3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   417aa:	e9 f8 00 00 00       	jmp    418a7 <memshow_physical+0x125>
        if (pn % 64 == 0) {
   417af:	8b 45 fc             	mov    -0x4(%rbp),%eax
   417b2:	83 e0 3f             	and    $0x3f,%eax
   417b5:	85 c0                	test   %eax,%eax
   417b7:	75 3c                	jne    417f5 <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   417b9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   417bc:	c1 e0 0c             	shl    $0xc,%eax
   417bf:	89 c1                	mov    %eax,%ecx
   417c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   417c4:	8d 50 3f             	lea    0x3f(%rax),%edx
   417c7:	85 c0                	test   %eax,%eax
   417c9:	0f 48 c2             	cmovs  %edx,%eax
   417cc:	c1 f8 06             	sar    $0x6,%eax
   417cf:	8d 50 01             	lea    0x1(%rax),%edx
   417d2:	89 d0                	mov    %edx,%eax
   417d4:	c1 e0 02             	shl    $0x2,%eax
   417d7:	01 d0                	add    %edx,%eax
   417d9:	c1 e0 04             	shl    $0x4,%eax
   417dc:	83 c0 03             	add    $0x3,%eax
   417df:	ba b6 4a 04 00       	mov    $0x44ab6,%edx
   417e4:	be 00 0f 00 00       	mov    $0xf00,%esi
   417e9:	89 c7                	mov    %eax,%edi
   417eb:	b8 00 00 00 00       	mov    $0x0,%eax
   417f0:	e8 f7 2c 00 00       	call   444ec <console_printf>
        }

        int owner = pageinfo[pn].owner;
   417f5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   417f8:	48 98                	cltq   
   417fa:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   41801:	00 
   41802:	0f be c0             	movsbl %al,%eax
   41805:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41808:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4180b:	48 98                	cltq   
   4180d:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   41814:	00 
   41815:	84 c0                	test   %al,%al
   41817:	75 07                	jne    41820 <memshow_physical+0x9e>
            owner = PO_FREE;
   41819:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   41820:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41823:	83 c0 02             	add    $0x2,%eax
   41826:	48 98                	cltq   
   41828:	0f b7 84 00 80 4a 04 	movzwl 0x44a80(%rax,%rax,1),%eax
   4182f:	00 
   41830:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41834:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41837:	48 98                	cltq   
   41839:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   41840:	00 
   41841:	3c 01                	cmp    $0x1,%al
   41843:	7e 1a                	jle    4185f <memshow_physical+0xdd>
   41845:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   4184a:	48 c1 e8 0c          	shr    $0xc,%rax
   4184e:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   41851:	74 0c                	je     4185f <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41853:	b8 53 00 00 00       	mov    $0x53,%eax
   41858:	80 cc 0f             	or     $0xf,%ah
   4185b:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   4185f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41862:	8d 50 3f             	lea    0x3f(%rax),%edx
   41865:	85 c0                	test   %eax,%eax
   41867:	0f 48 c2             	cmovs  %edx,%eax
   4186a:	c1 f8 06             	sar    $0x6,%eax
   4186d:	8d 50 01             	lea    0x1(%rax),%edx
   41870:	89 d0                	mov    %edx,%eax
   41872:	c1 e0 02             	shl    $0x2,%eax
   41875:	01 d0                	add    %edx,%eax
   41877:	c1 e0 04             	shl    $0x4,%eax
   4187a:	89 c1                	mov    %eax,%ecx
   4187c:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4187f:	89 d0                	mov    %edx,%eax
   41881:	c1 f8 1f             	sar    $0x1f,%eax
   41884:	c1 e8 1a             	shr    $0x1a,%eax
   41887:	01 c2                	add    %eax,%edx
   41889:	83 e2 3f             	and    $0x3f,%edx
   4188c:	29 c2                	sub    %eax,%edx
   4188e:	89 d0                	mov    %edx,%eax
   41890:	83 c0 0c             	add    $0xc,%eax
   41893:	01 c8                	add    %ecx,%eax
   41895:	48 98                	cltq   
   41897:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   4189b:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   418a2:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   418a3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   418a7:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   418ae:	0f 8e fb fe ff ff    	jle    417af <memshow_physical+0x2d>
    }
}
   418b4:	90                   	nop
   418b5:	90                   	nop
   418b6:	c9                   	leave  
   418b7:	c3                   	ret    

00000000000418b8 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   418b8:	55                   	push   %rbp
   418b9:	48 89 e5             	mov    %rsp,%rbp
   418bc:	48 83 ec 40          	sub    $0x40,%rsp
   418c0:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   418c4:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   418c8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   418cc:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   418d2:	48 89 c2             	mov    %rax,%rdx
   418d5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   418d9:	48 39 c2             	cmp    %rax,%rdx
   418dc:	74 14                	je     418f2 <memshow_virtual+0x3a>
   418de:	ba c0 4a 04 00       	mov    $0x44ac0,%edx
   418e3:	be 1e 03 00 00       	mov    $0x31e,%esi
   418e8:	bf c0 46 04 00       	mov    $0x446c0,%edi
   418ed:	e8 68 12 00 00       	call   42b5a <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   418f2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   418f6:	48 89 c1             	mov    %rax,%rcx
   418f9:	ba ed 4a 04 00       	mov    $0x44aed,%edx
   418fe:	be 00 0f 00 00       	mov    $0xf00,%esi
   41903:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41908:	b8 00 00 00 00       	mov    $0x0,%eax
   4190d:	e8 da 2b 00 00       	call   444ec <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41912:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41919:	00 
   4191a:	e9 80 01 00 00       	jmp    41a9f <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   4191f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41923:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41927:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4192b:	48 89 ce             	mov    %rcx,%rsi
   4192e:	48 89 c7             	mov    %rax,%rdi
   41931:	e8 e9 18 00 00       	call   4321f <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41936:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41939:	85 c0                	test   %eax,%eax
   4193b:	79 0b                	jns    41948 <memshow_virtual+0x90>
            color = ' ';
   4193d:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41943:	e9 d7 00 00 00       	jmp    41a1f <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41948:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4194c:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41952:	76 14                	jbe    41968 <memshow_virtual+0xb0>
   41954:	ba 0a 4b 04 00       	mov    $0x44b0a,%edx
   41959:	be 27 03 00 00       	mov    $0x327,%esi
   4195e:	bf c0 46 04 00       	mov    $0x446c0,%edi
   41963:	e8 f2 11 00 00       	call   42b5a <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41968:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4196b:	48 98                	cltq   
   4196d:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   41974:	00 
   41975:	0f be c0             	movsbl %al,%eax
   41978:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   4197b:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4197e:	48 98                	cltq   
   41980:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   41987:	00 
   41988:	84 c0                	test   %al,%al
   4198a:	75 07                	jne    41993 <memshow_virtual+0xdb>
                owner = PO_FREE;
   4198c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41993:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41996:	83 c0 02             	add    $0x2,%eax
   41999:	48 98                	cltq   
   4199b:	0f b7 84 00 80 4a 04 	movzwl 0x44a80(%rax,%rax,1),%eax
   419a2:	00 
   419a3:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   419a7:	8b 45 e0             	mov    -0x20(%rbp),%eax
   419aa:	48 98                	cltq   
   419ac:	83 e0 04             	and    $0x4,%eax
   419af:	48 85 c0             	test   %rax,%rax
   419b2:	74 27                	je     419db <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   419b4:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   419b8:	c1 e0 04             	shl    $0x4,%eax
   419bb:	66 25 00 f0          	and    $0xf000,%ax
   419bf:	89 c2                	mov    %eax,%edx
   419c1:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   419c5:	c1 f8 04             	sar    $0x4,%eax
   419c8:	66 25 00 0f          	and    $0xf00,%ax
   419cc:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   419ce:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   419d2:	0f b6 c0             	movzbl %al,%eax
   419d5:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   419d7:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   419db:	8b 45 d0             	mov    -0x30(%rbp),%eax
   419de:	48 98                	cltq   
   419e0:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   419e7:	00 
   419e8:	3c 01                	cmp    $0x1,%al
   419ea:	7e 33                	jle    41a1f <memshow_virtual+0x167>
   419ec:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   419f1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   419f5:	74 28                	je     41a1f <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   419f7:	b8 53 00 00 00       	mov    $0x53,%eax
   419fc:	89 c2                	mov    %eax,%edx
   419fe:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41a02:	66 25 00 f0          	and    $0xf000,%ax
   41a06:	09 d0                	or     %edx,%eax
   41a08:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41a0c:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41a0f:	48 98                	cltq   
   41a11:	83 e0 04             	and    $0x4,%eax
   41a14:	48 85 c0             	test   %rax,%rax
   41a17:	75 06                	jne    41a1f <memshow_virtual+0x167>
                    color = color | 0x0F00;
   41a19:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41a1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41a23:	48 c1 e8 0c          	shr    $0xc,%rax
   41a27:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41a2a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41a2d:	83 e0 3f             	and    $0x3f,%eax
   41a30:	85 c0                	test   %eax,%eax
   41a32:	75 34                	jne    41a68 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41a34:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41a37:	c1 e8 06             	shr    $0x6,%eax
   41a3a:	89 c2                	mov    %eax,%edx
   41a3c:	89 d0                	mov    %edx,%eax
   41a3e:	c1 e0 02             	shl    $0x2,%eax
   41a41:	01 d0                	add    %edx,%eax
   41a43:	c1 e0 04             	shl    $0x4,%eax
   41a46:	05 73 03 00 00       	add    $0x373,%eax
   41a4b:	89 c7                	mov    %eax,%edi
   41a4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41a51:	48 89 c1             	mov    %rax,%rcx
   41a54:	ba b6 4a 04 00       	mov    $0x44ab6,%edx
   41a59:	be 00 0f 00 00       	mov    $0xf00,%esi
   41a5e:	b8 00 00 00 00       	mov    $0x0,%eax
   41a63:	e8 84 2a 00 00       	call   444ec <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41a68:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41a6b:	c1 e8 06             	shr    $0x6,%eax
   41a6e:	89 c2                	mov    %eax,%edx
   41a70:	89 d0                	mov    %edx,%eax
   41a72:	c1 e0 02             	shl    $0x2,%eax
   41a75:	01 d0                	add    %edx,%eax
   41a77:	c1 e0 04             	shl    $0x4,%eax
   41a7a:	89 c2                	mov    %eax,%edx
   41a7c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41a7f:	83 e0 3f             	and    $0x3f,%eax
   41a82:	01 d0                	add    %edx,%eax
   41a84:	05 7c 03 00 00       	add    $0x37c,%eax
   41a89:	89 c2                	mov    %eax,%edx
   41a8b:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41a8f:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   41a96:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41a97:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41a9e:	00 
   41a9f:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41aa6:	00 
   41aa7:	0f 86 72 fe ff ff    	jbe    4191f <memshow_virtual+0x67>
    }
}
   41aad:	90                   	nop
   41aae:	90                   	nop
   41aaf:	c9                   	leave  
   41ab0:	c3                   	ret    

0000000000041ab1 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41ab1:	55                   	push   %rbp
   41ab2:	48 89 e5             	mov    %rsp,%rbp
   41ab5:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41ab9:	8b 05 81 17 01 00    	mov    0x11781(%rip),%eax        # 53240 <last_ticks.1>
   41abf:	85 c0                	test   %eax,%eax
   41ac1:	74 13                	je     41ad6 <memshow_virtual_animate+0x25>
   41ac3:	8b 15 57 13 01 00    	mov    0x11357(%rip),%edx        # 52e20 <ticks>
   41ac9:	8b 05 71 17 01 00    	mov    0x11771(%rip),%eax        # 53240 <last_ticks.1>
   41acf:	29 c2                	sub    %eax,%edx
   41ad1:	83 fa 31             	cmp    $0x31,%edx
   41ad4:	76 2c                	jbe    41b02 <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   41ad6:	8b 05 44 13 01 00    	mov    0x11344(%rip),%eax        # 52e20 <ticks>
   41adc:	89 05 5e 17 01 00    	mov    %eax,0x1175e(%rip)        # 53240 <last_ticks.1>
        ++showing;
   41ae2:	8b 05 1c 45 00 00    	mov    0x451c(%rip),%eax        # 46004 <showing.0>
   41ae8:	83 c0 01             	add    $0x1,%eax
   41aeb:	89 05 13 45 00 00    	mov    %eax,0x4513(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   41af1:	eb 0f                	jmp    41b02 <memshow_virtual_animate+0x51>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   41af3:	8b 05 0b 45 00 00    	mov    0x450b(%rip),%eax        # 46004 <showing.0>
   41af9:	83 c0 01             	add    $0x1,%eax
   41afc:	89 05 02 45 00 00    	mov    %eax,0x4502(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   41b02:	8b 05 fc 44 00 00    	mov    0x44fc(%rip),%eax        # 46004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   41b08:	83 f8 20             	cmp    $0x20,%eax
   41b0b:	7f 6d                	jg     41b7a <memshow_virtual_animate+0xc9>
   41b0d:	8b 15 f1 44 00 00    	mov    0x44f1(%rip),%edx        # 46004 <showing.0>
   41b13:	89 d0                	mov    %edx,%eax
   41b15:	c1 f8 1f             	sar    $0x1f,%eax
   41b18:	c1 e8 1c             	shr    $0x1c,%eax
   41b1b:	01 c2                	add    %eax,%edx
   41b1d:	83 e2 0f             	and    $0xf,%edx
   41b20:	29 c2                	sub    %eax,%edx
   41b22:	89 d0                	mov    %edx,%eax
   41b24:	48 63 d0             	movslq %eax,%rdx
   41b27:	48 89 d0             	mov    %rdx,%rax
   41b2a:	48 c1 e0 03          	shl    $0x3,%rax
   41b2e:	48 29 d0             	sub    %rdx,%rax
   41b31:	48 c1 e0 05          	shl    $0x5,%rax
   41b35:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41b3b:	8b 00                	mov    (%rax),%eax
   41b3d:	85 c0                	test   %eax,%eax
   41b3f:	74 b2                	je     41af3 <memshow_virtual_animate+0x42>
   41b41:	8b 15 bd 44 00 00    	mov    0x44bd(%rip),%edx        # 46004 <showing.0>
   41b47:	89 d0                	mov    %edx,%eax
   41b49:	c1 f8 1f             	sar    $0x1f,%eax
   41b4c:	c1 e8 1c             	shr    $0x1c,%eax
   41b4f:	01 c2                	add    %eax,%edx
   41b51:	83 e2 0f             	and    $0xf,%edx
   41b54:	29 c2                	sub    %eax,%edx
   41b56:	89 d0                	mov    %edx,%eax
   41b58:	48 63 d0             	movslq %eax,%rdx
   41b5b:	48 89 d0             	mov    %rdx,%rax
   41b5e:	48 c1 e0 03          	shl    $0x3,%rax
   41b62:	48 29 d0             	sub    %rdx,%rax
   41b65:	48 c1 e0 05          	shl    $0x5,%rax
   41b69:	48 05 f8 20 05 00    	add    $0x520f8,%rax
   41b6f:	0f b6 00             	movzbl (%rax),%eax
   41b72:	84 c0                	test   %al,%al
   41b74:	0f 84 79 ff ff ff    	je     41af3 <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   41b7a:	8b 15 84 44 00 00    	mov    0x4484(%rip),%edx        # 46004 <showing.0>
   41b80:	89 d0                	mov    %edx,%eax
   41b82:	c1 f8 1f             	sar    $0x1f,%eax
   41b85:	c1 e8 1c             	shr    $0x1c,%eax
   41b88:	01 c2                	add    %eax,%edx
   41b8a:	83 e2 0f             	and    $0xf,%edx
   41b8d:	29 c2                	sub    %eax,%edx
   41b8f:	89 d0                	mov    %edx,%eax
   41b91:	89 05 6d 44 00 00    	mov    %eax,0x446d(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41b97:	8b 05 67 44 00 00    	mov    0x4467(%rip),%eax        # 46004 <showing.0>
   41b9d:	48 63 d0             	movslq %eax,%rdx
   41ba0:	48 89 d0             	mov    %rdx,%rax
   41ba3:	48 c1 e0 03          	shl    $0x3,%rax
   41ba7:	48 29 d0             	sub    %rdx,%rax
   41baa:	48 c1 e0 05          	shl    $0x5,%rax
   41bae:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41bb4:	8b 00                	mov    (%rax),%eax
   41bb6:	85 c0                	test   %eax,%eax
   41bb8:	74 52                	je     41c0c <memshow_virtual_animate+0x15b>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41bba:	8b 15 44 44 00 00    	mov    0x4444(%rip),%edx        # 46004 <showing.0>
   41bc0:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41bc4:	89 d1                	mov    %edx,%ecx
   41bc6:	ba 24 4b 04 00       	mov    $0x44b24,%edx
   41bcb:	be 04 00 00 00       	mov    $0x4,%esi
   41bd0:	48 89 c7             	mov    %rax,%rdi
   41bd3:	b8 00 00 00 00       	mov    $0x0,%eax
   41bd8:	e8 1b 2a 00 00       	call   445f8 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41bdd:	8b 05 21 44 00 00    	mov    0x4421(%rip),%eax        # 46004 <showing.0>
   41be3:	48 63 d0             	movslq %eax,%rdx
   41be6:	48 89 d0             	mov    %rdx,%rax
   41be9:	48 c1 e0 03          	shl    $0x3,%rax
   41bed:	48 29 d0             	sub    %rdx,%rax
   41bf0:	48 c1 e0 05          	shl    $0x5,%rax
   41bf4:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   41bfa:	48 8b 00             	mov    (%rax),%rax
   41bfd:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41c01:	48 89 d6             	mov    %rdx,%rsi
   41c04:	48 89 c7             	mov    %rax,%rdi
   41c07:	e8 ac fc ff ff       	call   418b8 <memshow_virtual>
    }
}
   41c0c:	90                   	nop
   41c0d:	c9                   	leave  
   41c0e:	c3                   	ret    

0000000000041c0f <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41c0f:	55                   	push   %rbp
   41c10:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41c13:	e8 4f 01 00 00       	call   41d67 <segments_init>
    interrupt_init();
   41c18:	e8 d0 03 00 00       	call   41fed <interrupt_init>
    virtual_memory_init();
   41c1d:	e8 f3 0f 00 00       	call   42c15 <virtual_memory_init>
}
   41c22:	90                   	nop
   41c23:	5d                   	pop    %rbp
   41c24:	c3                   	ret    

0000000000041c25 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41c25:	55                   	push   %rbp
   41c26:	48 89 e5             	mov    %rsp,%rbp
   41c29:	48 83 ec 18          	sub    $0x18,%rsp
   41c2d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41c31:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41c35:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41c38:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41c3b:	48 98                	cltq   
   41c3d:	48 c1 e0 2d          	shl    $0x2d,%rax
   41c41:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41c45:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41c4c:	90 00 00 
   41c4f:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41c52:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c56:	48 89 10             	mov    %rdx,(%rax)
}
   41c59:	90                   	nop
   41c5a:	c9                   	leave  
   41c5b:	c3                   	ret    

0000000000041c5c <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41c5c:	55                   	push   %rbp
   41c5d:	48 89 e5             	mov    %rsp,%rbp
   41c60:	48 83 ec 28          	sub    $0x28,%rsp
   41c64:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41c68:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41c6c:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41c6f:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41c73:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41c77:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41c7b:	48 c1 e0 10          	shl    $0x10,%rax
   41c7f:	48 89 c2             	mov    %rax,%rdx
   41c82:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41c89:	00 00 00 
   41c8c:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41c8f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41c93:	48 c1 e0 20          	shl    $0x20,%rax
   41c97:	48 89 c1             	mov    %rax,%rcx
   41c9a:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41ca1:	00 00 ff 
   41ca4:	48 21 c8             	and    %rcx,%rax
   41ca7:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41caa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41cae:	48 83 e8 01          	sub    $0x1,%rax
   41cb2:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41cb5:	48 09 d0             	or     %rdx,%rax
        | type
   41cb8:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41cbc:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41cbf:	48 63 d2             	movslq %edx,%rdx
   41cc2:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41cc6:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41cc9:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41cd0:	80 00 00 
   41cd3:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41cd6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41cda:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41cdd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ce1:	48 83 c0 08          	add    $0x8,%rax
   41ce5:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41ce9:	48 c1 ea 20          	shr    $0x20,%rdx
   41ced:	48 89 10             	mov    %rdx,(%rax)
}
   41cf0:	90                   	nop
   41cf1:	c9                   	leave  
   41cf2:	c3                   	ret    

0000000000041cf3 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41cf3:	55                   	push   %rbp
   41cf4:	48 89 e5             	mov    %rsp,%rbp
   41cf7:	48 83 ec 20          	sub    $0x20,%rsp
   41cfb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41cff:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41d03:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41d06:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41d0a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41d0e:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41d11:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41d15:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41d18:	48 63 d2             	movslq %edx,%rdx
   41d1b:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41d1f:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41d22:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41d26:	48 c1 e0 20          	shl    $0x20,%rax
   41d2a:	48 89 c1             	mov    %rax,%rcx
   41d2d:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41d34:	00 ff ff 
   41d37:	48 21 c8             	and    %rcx,%rax
   41d3a:	48 09 c2             	or     %rax,%rdx
   41d3d:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41d44:	80 00 00 
   41d47:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41d4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d4e:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41d51:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41d55:	48 c1 e8 20          	shr    $0x20,%rax
   41d59:	48 89 c2             	mov    %rax,%rdx
   41d5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d60:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41d64:	90                   	nop
   41d65:	c9                   	leave  
   41d66:	c3                   	ret    

0000000000041d67 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41d67:	55                   	push   %rbp
   41d68:	48 89 e5             	mov    %rsp,%rbp
   41d6b:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41d6f:	48 c7 05 e6 14 01 00 	movq   $0x0,0x114e6(%rip)        # 53260 <segments>
   41d76:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41d7a:	ba 00 00 00 00       	mov    $0x0,%edx
   41d7f:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41d86:	08 20 00 
   41d89:	48 89 c6             	mov    %rax,%rsi
   41d8c:	bf 68 32 05 00       	mov    $0x53268,%edi
   41d91:	e8 8f fe ff ff       	call   41c25 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41d96:	ba 03 00 00 00       	mov    $0x3,%edx
   41d9b:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41da2:	08 20 00 
   41da5:	48 89 c6             	mov    %rax,%rsi
   41da8:	bf 70 32 05 00       	mov    $0x53270,%edi
   41dad:	e8 73 fe ff ff       	call   41c25 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41db2:	ba 00 00 00 00       	mov    $0x0,%edx
   41db7:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41dbe:	02 00 00 
   41dc1:	48 89 c6             	mov    %rax,%rsi
   41dc4:	bf 78 32 05 00       	mov    $0x53278,%edi
   41dc9:	e8 57 fe ff ff       	call   41c25 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41dce:	ba 03 00 00 00       	mov    $0x3,%edx
   41dd3:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41dda:	02 00 00 
   41ddd:	48 89 c6             	mov    %rax,%rsi
   41de0:	bf 80 32 05 00       	mov    $0x53280,%edi
   41de5:	e8 3b fe ff ff       	call   41c25 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41dea:	b8 a0 42 05 00       	mov    $0x542a0,%eax
   41def:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41df5:	48 89 c1             	mov    %rax,%rcx
   41df8:	ba 00 00 00 00       	mov    $0x0,%edx
   41dfd:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41e04:	09 00 00 
   41e07:	48 89 c6             	mov    %rax,%rsi
   41e0a:	bf 88 32 05 00       	mov    $0x53288,%edi
   41e0f:	e8 48 fe ff ff       	call   41c5c <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41e14:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41e1a:	b8 60 32 05 00       	mov    $0x53260,%eax
   41e1f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41e23:	ba 60 00 00 00       	mov    $0x60,%edx
   41e28:	be 00 00 00 00       	mov    $0x0,%esi
   41e2d:	bf a0 42 05 00       	mov    $0x542a0,%edi
   41e32:	e8 fe 18 00 00       	call   43735 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41e37:	48 c7 05 62 24 01 00 	movq   $0x80000,0x12462(%rip)        # 542a4 <kernel_task_descriptor+0x4>
   41e3e:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41e42:	ba 00 10 00 00       	mov    $0x1000,%edx
   41e47:	be 00 00 00 00       	mov    $0x0,%esi
   41e4c:	bf a0 32 05 00       	mov    $0x532a0,%edi
   41e51:	e8 df 18 00 00       	call   43735 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41e56:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41e5d:	eb 30                	jmp    41e8f <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41e5f:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41e64:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e67:	48 c1 e0 04          	shl    $0x4,%rax
   41e6b:	48 05 a0 32 05 00    	add    $0x532a0,%rax
   41e71:	48 89 d1             	mov    %rdx,%rcx
   41e74:	ba 00 00 00 00       	mov    $0x0,%edx
   41e79:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41e80:	0e 00 00 
   41e83:	48 89 c7             	mov    %rax,%rdi
   41e86:	e8 68 fe ff ff       	call   41cf3 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41e8b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41e8f:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41e96:	76 c7                	jbe    41e5f <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41e98:	b8 36 00 04 00       	mov    $0x40036,%eax
   41e9d:	48 89 c1             	mov    %rax,%rcx
   41ea0:	ba 00 00 00 00       	mov    $0x0,%edx
   41ea5:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41eac:	0e 00 00 
   41eaf:	48 89 c6             	mov    %rax,%rsi
   41eb2:	bf a0 34 05 00       	mov    $0x534a0,%edi
   41eb7:	e8 37 fe ff ff       	call   41cf3 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41ebc:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   41ec1:	48 89 c1             	mov    %rax,%rcx
   41ec4:	ba 00 00 00 00       	mov    $0x0,%edx
   41ec9:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41ed0:	0e 00 00 
   41ed3:	48 89 c6             	mov    %rax,%rsi
   41ed6:	bf 70 33 05 00       	mov    $0x53370,%edi
   41edb:	e8 13 fe ff ff       	call   41cf3 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41ee0:	b8 32 00 04 00       	mov    $0x40032,%eax
   41ee5:	48 89 c1             	mov    %rax,%rcx
   41ee8:	ba 00 00 00 00       	mov    $0x0,%edx
   41eed:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41ef4:	0e 00 00 
   41ef7:	48 89 c6             	mov    %rax,%rsi
   41efa:	bf 80 33 05 00       	mov    $0x53380,%edi
   41eff:	e8 ef fd ff ff       	call   41cf3 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41f04:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41f0b:	eb 3e                	jmp    41f4b <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41f0d:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41f10:	83 e8 30             	sub    $0x30,%eax
   41f13:	89 c0                	mov    %eax,%eax
   41f15:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41f1c:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41f1d:	48 89 c2             	mov    %rax,%rdx
   41f20:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41f23:	48 c1 e0 04          	shl    $0x4,%rax
   41f27:	48 05 a0 32 05 00    	add    $0x532a0,%rax
   41f2d:	48 89 d1             	mov    %rdx,%rcx
   41f30:	ba 03 00 00 00       	mov    $0x3,%edx
   41f35:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41f3c:	0e 00 00 
   41f3f:	48 89 c7             	mov    %rax,%rdi
   41f42:	e8 ac fd ff ff       	call   41cf3 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41f47:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41f4b:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41f4f:	76 bc                	jbe    41f0d <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41f51:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41f57:	b8 a0 32 05 00       	mov    $0x532a0,%eax
   41f5c:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41f60:	b8 28 00 00 00       	mov    $0x28,%eax
   41f65:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41f69:	0f 00 d8             	ltr    %ax
   41f6c:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41f70:	0f 20 c0             	mov    %cr0,%rax
   41f73:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41f77:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41f7b:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41f7e:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41f85:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41f88:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41f8b:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f8e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41f92:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41f96:	0f 22 c0             	mov    %rax,%cr0
}
   41f99:	90                   	nop
    lcr0(cr0);
}
   41f9a:	90                   	nop
   41f9b:	c9                   	leave  
   41f9c:	c3                   	ret    

0000000000041f9d <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41f9d:	55                   	push   %rbp
   41f9e:	48 89 e5             	mov    %rsp,%rbp
   41fa1:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41fa5:	0f b7 05 54 23 01 00 	movzwl 0x12354(%rip),%eax        # 54300 <interrupts_enabled>
   41fac:	f7 d0                	not    %eax
   41fae:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41fb2:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41fb6:	0f b6 c0             	movzbl %al,%eax
   41fb9:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41fc0:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41fc3:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41fc7:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41fca:	ee                   	out    %al,(%dx)
}
   41fcb:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41fcc:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41fd0:	66 c1 e8 08          	shr    $0x8,%ax
   41fd4:	0f b6 c0             	movzbl %al,%eax
   41fd7:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41fde:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41fe1:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41fe5:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41fe8:	ee                   	out    %al,(%dx)
}
   41fe9:	90                   	nop
}
   41fea:	90                   	nop
   41feb:	c9                   	leave  
   41fec:	c3                   	ret    

0000000000041fed <interrupt_init>:

void interrupt_init(void) {
   41fed:	55                   	push   %rbp
   41fee:	48 89 e5             	mov    %rsp,%rbp
   41ff1:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41ff5:	66 c7 05 02 23 01 00 	movw   $0x0,0x12302(%rip)        # 54300 <interrupts_enabled>
   41ffc:	00 00 
    interrupt_mask();
   41ffe:	e8 9a ff ff ff       	call   41f9d <interrupt_mask>
   42003:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   4200a:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4200e:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   42012:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   42015:	ee                   	out    %al,(%dx)
}
   42016:	90                   	nop
   42017:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   4201e:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42022:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   42026:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42029:	ee                   	out    %al,(%dx)
}
   4202a:	90                   	nop
   4202b:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   42032:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42036:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   4203a:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   4203d:	ee                   	out    %al,(%dx)
}
   4203e:	90                   	nop
   4203f:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   42046:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4204a:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   4204e:	8b 55 bc             	mov    -0x44(%rbp),%edx
   42051:	ee                   	out    %al,(%dx)
}
   42052:	90                   	nop
   42053:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   4205a:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4205e:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   42062:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   42065:	ee                   	out    %al,(%dx)
}
   42066:	90                   	nop
   42067:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   4206e:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42072:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   42076:	8b 55 cc             	mov    -0x34(%rbp),%edx
   42079:	ee                   	out    %al,(%dx)
}
   4207a:	90                   	nop
   4207b:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   42082:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42086:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   4208a:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   4208d:	ee                   	out    %al,(%dx)
}
   4208e:	90                   	nop
   4208f:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   42096:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4209a:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   4209e:	8b 55 dc             	mov    -0x24(%rbp),%edx
   420a1:	ee                   	out    %al,(%dx)
}
   420a2:	90                   	nop
   420a3:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   420aa:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420ae:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   420b2:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   420b5:	ee                   	out    %al,(%dx)
}
   420b6:	90                   	nop
   420b7:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   420be:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420c2:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   420c6:	8b 55 ec             	mov    -0x14(%rbp),%edx
   420c9:	ee                   	out    %al,(%dx)
}
   420ca:	90                   	nop
   420cb:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   420d2:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420d6:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   420da:	8b 55 f4             	mov    -0xc(%rbp),%edx
   420dd:	ee                   	out    %al,(%dx)
}
   420de:	90                   	nop
   420df:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   420e6:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420ea:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   420ee:	8b 55 fc             	mov    -0x4(%rbp),%edx
   420f1:	ee                   	out    %al,(%dx)
}
   420f2:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   420f3:	e8 a5 fe ff ff       	call   41f9d <interrupt_mask>
}
   420f8:	90                   	nop
   420f9:	c9                   	leave  
   420fa:	c3                   	ret    

00000000000420fb <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   420fb:	55                   	push   %rbp
   420fc:	48 89 e5             	mov    %rsp,%rbp
   420ff:	48 83 ec 28          	sub    $0x28,%rsp
   42103:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   42106:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   4210a:	0f 8e 9e 00 00 00    	jle    421ae <timer_init+0xb3>
   42110:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   42117:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4211b:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   4211f:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42122:	ee                   	out    %al,(%dx)
}
   42123:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   42124:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42127:	89 c2                	mov    %eax,%edx
   42129:	c1 ea 1f             	shr    $0x1f,%edx
   4212c:	01 d0                	add    %edx,%eax
   4212e:	d1 f8                	sar    %eax
   42130:	05 de 34 12 00       	add    $0x1234de,%eax
   42135:	99                   	cltd   
   42136:	f7 7d dc             	idivl  -0x24(%rbp)
   42139:	89 c2                	mov    %eax,%edx
   4213b:	89 d0                	mov    %edx,%eax
   4213d:	c1 f8 1f             	sar    $0x1f,%eax
   42140:	c1 e8 18             	shr    $0x18,%eax
   42143:	01 c2                	add    %eax,%edx
   42145:	0f b6 d2             	movzbl %dl,%edx
   42148:	29 c2                	sub    %eax,%edx
   4214a:	89 d0                	mov    %edx,%eax
   4214c:	0f b6 c0             	movzbl %al,%eax
   4214f:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   42156:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42159:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   4215d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42160:	ee                   	out    %al,(%dx)
}
   42161:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   42162:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42165:	89 c2                	mov    %eax,%edx
   42167:	c1 ea 1f             	shr    $0x1f,%edx
   4216a:	01 d0                	add    %edx,%eax
   4216c:	d1 f8                	sar    %eax
   4216e:	05 de 34 12 00       	add    $0x1234de,%eax
   42173:	99                   	cltd   
   42174:	f7 7d dc             	idivl  -0x24(%rbp)
   42177:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   4217d:	85 c0                	test   %eax,%eax
   4217f:	0f 48 c2             	cmovs  %edx,%eax
   42182:	c1 f8 08             	sar    $0x8,%eax
   42185:	0f b6 c0             	movzbl %al,%eax
   42188:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   4218f:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42192:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42196:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42199:	ee                   	out    %al,(%dx)
}
   4219a:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   4219b:	0f b7 05 5e 21 01 00 	movzwl 0x1215e(%rip),%eax        # 54300 <interrupts_enabled>
   421a2:	83 c8 01             	or     $0x1,%eax
   421a5:	66 89 05 54 21 01 00 	mov    %ax,0x12154(%rip)        # 54300 <interrupts_enabled>
   421ac:	eb 11                	jmp    421bf <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   421ae:	0f b7 05 4b 21 01 00 	movzwl 0x1214b(%rip),%eax        # 54300 <interrupts_enabled>
   421b5:	83 e0 fe             	and    $0xfffffffe,%eax
   421b8:	66 89 05 41 21 01 00 	mov    %ax,0x12141(%rip)        # 54300 <interrupts_enabled>
    }
    interrupt_mask();
   421bf:	e8 d9 fd ff ff       	call   41f9d <interrupt_mask>
}
   421c4:	90                   	nop
   421c5:	c9                   	leave  
   421c6:	c3                   	ret    

00000000000421c7 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   421c7:	55                   	push   %rbp
   421c8:	48 89 e5             	mov    %rsp,%rbp
   421cb:	48 83 ec 08          	sub    $0x8,%rsp
   421cf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   421d3:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   421d8:	74 14                	je     421ee <physical_memory_isreserved+0x27>
   421da:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   421e1:	00 
   421e2:	76 11                	jbe    421f5 <physical_memory_isreserved+0x2e>
   421e4:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   421eb:	00 
   421ec:	77 07                	ja     421f5 <physical_memory_isreserved+0x2e>
   421ee:	b8 01 00 00 00       	mov    $0x1,%eax
   421f3:	eb 05                	jmp    421fa <physical_memory_isreserved+0x33>
   421f5:	b8 00 00 00 00       	mov    $0x0,%eax
}
   421fa:	c9                   	leave  
   421fb:	c3                   	ret    

00000000000421fc <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   421fc:	55                   	push   %rbp
   421fd:	48 89 e5             	mov    %rsp,%rbp
   42200:	48 83 ec 10          	sub    $0x10,%rsp
   42204:	89 7d fc             	mov    %edi,-0x4(%rbp)
   42207:	89 75 f8             	mov    %esi,-0x8(%rbp)
   4220a:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   4220d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42210:	c1 e0 10             	shl    $0x10,%eax
   42213:	89 c2                	mov    %eax,%edx
   42215:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42218:	c1 e0 0b             	shl    $0xb,%eax
   4221b:	09 c2                	or     %eax,%edx
   4221d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42220:	c1 e0 08             	shl    $0x8,%eax
   42223:	09 d0                	or     %edx,%eax
}
   42225:	c9                   	leave  
   42226:	c3                   	ret    

0000000000042227 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   42227:	55                   	push   %rbp
   42228:	48 89 e5             	mov    %rsp,%rbp
   4222b:	48 83 ec 18          	sub    $0x18,%rsp
   4222f:	89 7d ec             	mov    %edi,-0x14(%rbp)
   42232:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   42235:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42238:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4223b:	09 d0                	or     %edx,%eax
   4223d:	0d 00 00 00 80       	or     $0x80000000,%eax
   42242:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   42249:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   4224c:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4224f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42252:	ef                   	out    %eax,(%dx)
}
   42253:	90                   	nop
   42254:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   4225b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4225e:	89 c2                	mov    %eax,%edx
   42260:	ed                   	in     (%dx),%eax
   42261:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   42264:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   42267:	c9                   	leave  
   42268:	c3                   	ret    

0000000000042269 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   42269:	55                   	push   %rbp
   4226a:	48 89 e5             	mov    %rsp,%rbp
   4226d:	48 83 ec 28          	sub    $0x28,%rsp
   42271:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42274:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   42277:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4227e:	eb 73                	jmp    422f3 <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   42280:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   42287:	eb 60                	jmp    422e9 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   42289:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42290:	eb 4a                	jmp    422dc <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   42292:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42295:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   42298:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4229b:	89 ce                	mov    %ecx,%esi
   4229d:	89 c7                	mov    %eax,%edi
   4229f:	e8 58 ff ff ff       	call   421fc <pci_make_configaddr>
   422a4:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   422a7:	8b 45 f0             	mov    -0x10(%rbp),%eax
   422aa:	be 00 00 00 00       	mov    $0x0,%esi
   422af:	89 c7                	mov    %eax,%edi
   422b1:	e8 71 ff ff ff       	call   42227 <pci_config_readl>
   422b6:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   422b9:	8b 45 d8             	mov    -0x28(%rbp),%eax
   422bc:	c1 e0 10             	shl    $0x10,%eax
   422bf:	0b 45 dc             	or     -0x24(%rbp),%eax
   422c2:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   422c5:	75 05                	jne    422cc <pci_find_device+0x63>
                    return configaddr;
   422c7:	8b 45 f0             	mov    -0x10(%rbp),%eax
   422ca:	eb 35                	jmp    42301 <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   422cc:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   422d0:	75 06                	jne    422d8 <pci_find_device+0x6f>
   422d2:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   422d6:	74 0c                	je     422e4 <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   422d8:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   422dc:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   422e0:	75 b0                	jne    42292 <pci_find_device+0x29>
   422e2:	eb 01                	jmp    422e5 <pci_find_device+0x7c>
                    break;
   422e4:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   422e5:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   422e9:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   422ed:	75 9a                	jne    42289 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   422ef:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   422f3:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   422fa:	75 84                	jne    42280 <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   422fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   42301:	c9                   	leave  
   42302:	c3                   	ret    

0000000000042303 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   42303:	55                   	push   %rbp
   42304:	48 89 e5             	mov    %rsp,%rbp
   42307:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   4230b:	be 13 71 00 00       	mov    $0x7113,%esi
   42310:	bf 86 80 00 00       	mov    $0x8086,%edi
   42315:	e8 4f ff ff ff       	call   42269 <pci_find_device>
   4231a:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   4231d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   42321:	78 30                	js     42353 <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   42323:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42326:	be 40 00 00 00       	mov    $0x40,%esi
   4232b:	89 c7                	mov    %eax,%edi
   4232d:	e8 f5 fe ff ff       	call   42227 <pci_config_readl>
   42332:	25 c0 ff 00 00       	and    $0xffc0,%eax
   42337:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   4233a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4233d:	83 c0 04             	add    $0x4,%eax
   42340:	89 45 f4             	mov    %eax,-0xc(%rbp)
   42343:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   42349:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   4234d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42350:	66 ef                	out    %ax,(%dx)
}
   42352:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   42353:	ba 40 4b 04 00       	mov    $0x44b40,%edx
   42358:	be 00 c0 00 00       	mov    $0xc000,%esi
   4235d:	bf 80 07 00 00       	mov    $0x780,%edi
   42362:	b8 00 00 00 00       	mov    $0x0,%eax
   42367:	e8 80 21 00 00       	call   444ec <console_printf>
 spinloop: goto spinloop;
   4236c:	eb fe                	jmp    4236c <poweroff+0x69>

000000000004236e <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   4236e:	55                   	push   %rbp
   4236f:	48 89 e5             	mov    %rsp,%rbp
   42372:	48 83 ec 10          	sub    $0x10,%rsp
   42376:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   4237d:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42381:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42385:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42388:	ee                   	out    %al,(%dx)
}
   42389:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   4238a:	eb fe                	jmp    4238a <reboot+0x1c>

000000000004238c <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   4238c:	55                   	push   %rbp
   4238d:	48 89 e5             	mov    %rsp,%rbp
   42390:	48 83 ec 10          	sub    $0x10,%rsp
   42394:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42398:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   4239b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4239f:	48 83 c0 08          	add    $0x8,%rax
   423a3:	ba c0 00 00 00       	mov    $0xc0,%edx
   423a8:	be 00 00 00 00       	mov    $0x0,%esi
   423ad:	48 89 c7             	mov    %rax,%rdi
   423b0:	e8 80 13 00 00       	call   43735 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   423b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   423b9:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   423c0:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   423c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   423c6:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   423cd:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   423d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   423d5:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   423dc:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   423e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   423e4:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   423eb:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   423ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   423f1:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   423f8:	00 02 00 00 
    p->display_status = 1;
   423fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42400:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   42407:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4240a:	83 e0 01             	and    $0x1,%eax
   4240d:	85 c0                	test   %eax,%eax
   4240f:	74 1c                	je     4242d <process_init+0xa1>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   42411:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42415:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   4241c:	80 cc 30             	or     $0x30,%ah
   4241f:	48 89 c2             	mov    %rax,%rdx
   42422:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42426:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   4242d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42430:	83 e0 02             	and    $0x2,%eax
   42433:	85 c0                	test   %eax,%eax
   42435:	74 1c                	je     42453 <process_init+0xc7>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   42437:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4243b:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   42442:	80 e4 fd             	and    $0xfd,%ah
   42445:	48 89 c2             	mov    %rax,%rdx
   42448:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4244c:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   42453:	90                   	nop
   42454:	c9                   	leave  
   42455:	c3                   	ret    

0000000000042456 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   42456:	55                   	push   %rbp
   42457:	48 89 e5             	mov    %rsp,%rbp
   4245a:	48 83 ec 28          	sub    $0x28,%rsp
   4245e:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   42461:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42465:	78 09                	js     42470 <console_show_cursor+0x1a>
   42467:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   4246e:	7e 07                	jle    42477 <console_show_cursor+0x21>
        cpos = 0;
   42470:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   42477:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   4247e:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42482:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42486:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42489:	ee                   	out    %al,(%dx)
}
   4248a:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   4248b:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4248e:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42494:	85 c0                	test   %eax,%eax
   42496:	0f 48 c2             	cmovs  %edx,%eax
   42499:	c1 f8 08             	sar    $0x8,%eax
   4249c:	0f b6 c0             	movzbl %al,%eax
   4249f:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   424a6:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   424a9:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   424ad:	8b 55 ec             	mov    -0x14(%rbp),%edx
   424b0:	ee                   	out    %al,(%dx)
}
   424b1:	90                   	nop
   424b2:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   424b9:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   424bd:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   424c1:	8b 55 f4             	mov    -0xc(%rbp),%edx
   424c4:	ee                   	out    %al,(%dx)
}
   424c5:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   424c6:	8b 55 dc             	mov    -0x24(%rbp),%edx
   424c9:	89 d0                	mov    %edx,%eax
   424cb:	c1 f8 1f             	sar    $0x1f,%eax
   424ce:	c1 e8 18             	shr    $0x18,%eax
   424d1:	01 c2                	add    %eax,%edx
   424d3:	0f b6 d2             	movzbl %dl,%edx
   424d6:	29 c2                	sub    %eax,%edx
   424d8:	89 d0                	mov    %edx,%eax
   424da:	0f b6 c0             	movzbl %al,%eax
   424dd:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   424e4:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   424e7:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   424eb:	8b 55 fc             	mov    -0x4(%rbp),%edx
   424ee:	ee                   	out    %al,(%dx)
}
   424ef:	90                   	nop
}
   424f0:	90                   	nop
   424f1:	c9                   	leave  
   424f2:	c3                   	ret    

00000000000424f3 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   424f3:	55                   	push   %rbp
   424f4:	48 89 e5             	mov    %rsp,%rbp
   424f7:	48 83 ec 20          	sub    $0x20,%rsp
   424fb:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42502:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42505:	89 c2                	mov    %eax,%edx
   42507:	ec                   	in     (%dx),%al
   42508:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   4250b:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   4250f:	0f b6 c0             	movzbl %al,%eax
   42512:	83 e0 01             	and    $0x1,%eax
   42515:	85 c0                	test   %eax,%eax
   42517:	75 0a                	jne    42523 <keyboard_readc+0x30>
        return -1;
   42519:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4251e:	e9 e7 01 00 00       	jmp    4270a <keyboard_readc+0x217>
   42523:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4252a:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4252d:	89 c2                	mov    %eax,%edx
   4252f:	ec                   	in     (%dx),%al
   42530:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   42533:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   42537:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   4253a:	0f b6 05 c1 1d 01 00 	movzbl 0x11dc1(%rip),%eax        # 54302 <last_escape.2>
   42541:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   42544:	c6 05 b7 1d 01 00 00 	movb   $0x0,0x11db7(%rip)        # 54302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   4254b:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   4254f:	75 11                	jne    42562 <keyboard_readc+0x6f>
        last_escape = 0x80;
   42551:	c6 05 aa 1d 01 00 80 	movb   $0x80,0x11daa(%rip)        # 54302 <last_escape.2>
        return 0;
   42558:	b8 00 00 00 00       	mov    $0x0,%eax
   4255d:	e9 a8 01 00 00       	jmp    4270a <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   42562:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42566:	84 c0                	test   %al,%al
   42568:	79 60                	jns    425ca <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   4256a:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4256e:	83 e0 7f             	and    $0x7f,%eax
   42571:	89 c2                	mov    %eax,%edx
   42573:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   42577:	09 d0                	or     %edx,%eax
   42579:	48 98                	cltq   
   4257b:	0f b6 80 60 4b 04 00 	movzbl 0x44b60(%rax),%eax
   42582:	0f b6 c0             	movzbl %al,%eax
   42585:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   42588:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   4258f:	7e 2f                	jle    425c0 <keyboard_readc+0xcd>
   42591:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   42598:	7f 26                	jg     425c0 <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   4259a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4259d:	2d fa 00 00 00       	sub    $0xfa,%eax
   425a2:	ba 01 00 00 00       	mov    $0x1,%edx
   425a7:	89 c1                	mov    %eax,%ecx
   425a9:	d3 e2                	shl    %cl,%edx
   425ab:	89 d0                	mov    %edx,%eax
   425ad:	f7 d0                	not    %eax
   425af:	89 c2                	mov    %eax,%edx
   425b1:	0f b6 05 4b 1d 01 00 	movzbl 0x11d4b(%rip),%eax        # 54303 <modifiers.1>
   425b8:	21 d0                	and    %edx,%eax
   425ba:	88 05 43 1d 01 00    	mov    %al,0x11d43(%rip)        # 54303 <modifiers.1>
        }
        return 0;
   425c0:	b8 00 00 00 00       	mov    $0x0,%eax
   425c5:	e9 40 01 00 00       	jmp    4270a <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   425ca:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   425ce:	0a 45 fa             	or     -0x6(%rbp),%al
   425d1:	0f b6 c0             	movzbl %al,%eax
   425d4:	48 98                	cltq   
   425d6:	0f b6 80 60 4b 04 00 	movzbl 0x44b60(%rax),%eax
   425dd:	0f b6 c0             	movzbl %al,%eax
   425e0:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   425e3:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   425e7:	7e 57                	jle    42640 <keyboard_readc+0x14d>
   425e9:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   425ed:	7f 51                	jg     42640 <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   425ef:	0f b6 05 0d 1d 01 00 	movzbl 0x11d0d(%rip),%eax        # 54303 <modifiers.1>
   425f6:	0f b6 c0             	movzbl %al,%eax
   425f9:	83 e0 02             	and    $0x2,%eax
   425fc:	85 c0                	test   %eax,%eax
   425fe:	74 09                	je     42609 <keyboard_readc+0x116>
            ch -= 0x60;
   42600:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42604:	e9 fd 00 00 00       	jmp    42706 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   42609:	0f b6 05 f3 1c 01 00 	movzbl 0x11cf3(%rip),%eax        # 54303 <modifiers.1>
   42610:	0f b6 c0             	movzbl %al,%eax
   42613:	83 e0 01             	and    $0x1,%eax
   42616:	85 c0                	test   %eax,%eax
   42618:	0f 94 c2             	sete   %dl
   4261b:	0f b6 05 e1 1c 01 00 	movzbl 0x11ce1(%rip),%eax        # 54303 <modifiers.1>
   42622:	0f b6 c0             	movzbl %al,%eax
   42625:	83 e0 08             	and    $0x8,%eax
   42628:	85 c0                	test   %eax,%eax
   4262a:	0f 94 c0             	sete   %al
   4262d:	31 d0                	xor    %edx,%eax
   4262f:	84 c0                	test   %al,%al
   42631:	0f 84 cf 00 00 00    	je     42706 <keyboard_readc+0x213>
            ch -= 0x20;
   42637:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4263b:	e9 c6 00 00 00       	jmp    42706 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   42640:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   42647:	7e 30                	jle    42679 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   42649:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4264c:	2d fa 00 00 00       	sub    $0xfa,%eax
   42651:	ba 01 00 00 00       	mov    $0x1,%edx
   42656:	89 c1                	mov    %eax,%ecx
   42658:	d3 e2                	shl    %cl,%edx
   4265a:	89 d0                	mov    %edx,%eax
   4265c:	89 c2                	mov    %eax,%edx
   4265e:	0f b6 05 9e 1c 01 00 	movzbl 0x11c9e(%rip),%eax        # 54303 <modifiers.1>
   42665:	31 d0                	xor    %edx,%eax
   42667:	88 05 96 1c 01 00    	mov    %al,0x11c96(%rip)        # 54303 <modifiers.1>
        ch = 0;
   4266d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42674:	e9 8e 00 00 00       	jmp    42707 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   42679:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   42680:	7e 2d                	jle    426af <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   42682:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42685:	2d fa 00 00 00       	sub    $0xfa,%eax
   4268a:	ba 01 00 00 00       	mov    $0x1,%edx
   4268f:	89 c1                	mov    %eax,%ecx
   42691:	d3 e2                	shl    %cl,%edx
   42693:	89 d0                	mov    %edx,%eax
   42695:	89 c2                	mov    %eax,%edx
   42697:	0f b6 05 65 1c 01 00 	movzbl 0x11c65(%rip),%eax        # 54303 <modifiers.1>
   4269e:	09 d0                	or     %edx,%eax
   426a0:	88 05 5d 1c 01 00    	mov    %al,0x11c5d(%rip)        # 54303 <modifiers.1>
        ch = 0;
   426a6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   426ad:	eb 58                	jmp    42707 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   426af:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   426b3:	7e 31                	jle    426e6 <keyboard_readc+0x1f3>
   426b5:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   426bc:	7f 28                	jg     426e6 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   426be:	8b 45 fc             	mov    -0x4(%rbp),%eax
   426c1:	8d 50 80             	lea    -0x80(%rax),%edx
   426c4:	0f b6 05 38 1c 01 00 	movzbl 0x11c38(%rip),%eax        # 54303 <modifiers.1>
   426cb:	0f b6 c0             	movzbl %al,%eax
   426ce:	83 e0 03             	and    $0x3,%eax
   426d1:	48 98                	cltq   
   426d3:	48 63 d2             	movslq %edx,%rdx
   426d6:	0f b6 84 90 60 4c 04 	movzbl 0x44c60(%rax,%rdx,4),%eax
   426dd:	00 
   426de:	0f b6 c0             	movzbl %al,%eax
   426e1:	89 45 fc             	mov    %eax,-0x4(%rbp)
   426e4:	eb 21                	jmp    42707 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   426e6:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   426ea:	7f 1b                	jg     42707 <keyboard_readc+0x214>
   426ec:	0f b6 05 10 1c 01 00 	movzbl 0x11c10(%rip),%eax        # 54303 <modifiers.1>
   426f3:	0f b6 c0             	movzbl %al,%eax
   426f6:	83 e0 02             	and    $0x2,%eax
   426f9:	85 c0                	test   %eax,%eax
   426fb:	74 0a                	je     42707 <keyboard_readc+0x214>
        ch = 0;
   426fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42704:	eb 01                	jmp    42707 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   42706:	90                   	nop
    }

    return ch;
   42707:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   4270a:	c9                   	leave  
   4270b:	c3                   	ret    

000000000004270c <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   4270c:	55                   	push   %rbp
   4270d:	48 89 e5             	mov    %rsp,%rbp
   42710:	48 83 ec 20          	sub    $0x20,%rsp
   42714:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4271b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4271e:	89 c2                	mov    %eax,%edx
   42720:	ec                   	in     (%dx),%al
   42721:	88 45 e3             	mov    %al,-0x1d(%rbp)
   42724:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   4272b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4272e:	89 c2                	mov    %eax,%edx
   42730:	ec                   	in     (%dx),%al
   42731:	88 45 eb             	mov    %al,-0x15(%rbp)
   42734:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   4273b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4273e:	89 c2                	mov    %eax,%edx
   42740:	ec                   	in     (%dx),%al
   42741:	88 45 f3             	mov    %al,-0xd(%rbp)
   42744:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   4274b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4274e:	89 c2                	mov    %eax,%edx
   42750:	ec                   	in     (%dx),%al
   42751:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   42754:	90                   	nop
   42755:	c9                   	leave  
   42756:	c3                   	ret    

0000000000042757 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   42757:	55                   	push   %rbp
   42758:	48 89 e5             	mov    %rsp,%rbp
   4275b:	48 83 ec 40          	sub    $0x40,%rsp
   4275f:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42763:	89 f0                	mov    %esi,%eax
   42765:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42768:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   4276b:	8b 05 93 1b 01 00    	mov    0x11b93(%rip),%eax        # 54304 <initialized.0>
   42771:	85 c0                	test   %eax,%eax
   42773:	75 1e                	jne    42793 <parallel_port_putc+0x3c>
   42775:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   4277c:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42780:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   42784:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42787:	ee                   	out    %al,(%dx)
}
   42788:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42789:	c7 05 71 1b 01 00 01 	movl   $0x1,0x11b71(%rip)        # 54304 <initialized.0>
   42790:	00 00 00 
    }

    for (int i = 0;
   42793:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4279a:	eb 09                	jmp    427a5 <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   4279c:	e8 6b ff ff ff       	call   4270c <delay>
         ++i) {
   427a1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   427a5:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   427ac:	7f 18                	jg     427c6 <parallel_port_putc+0x6f>
   427ae:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   427b5:	8b 45 f0             	mov    -0x10(%rbp),%eax
   427b8:	89 c2                	mov    %eax,%edx
   427ba:	ec                   	in     (%dx),%al
   427bb:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   427be:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   427c2:	84 c0                	test   %al,%al
   427c4:	79 d6                	jns    4279c <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   427c6:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   427ca:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   427d1:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   427d4:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   427d8:	8b 55 d8             	mov    -0x28(%rbp),%edx
   427db:	ee                   	out    %al,(%dx)
}
   427dc:	90                   	nop
   427dd:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   427e4:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   427e8:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   427ec:	8b 55 e0             	mov    -0x20(%rbp),%edx
   427ef:	ee                   	out    %al,(%dx)
}
   427f0:	90                   	nop
   427f1:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   427f8:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   427fc:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   42800:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42803:	ee                   	out    %al,(%dx)
}
   42804:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42805:	90                   	nop
   42806:	c9                   	leave  
   42807:	c3                   	ret    

0000000000042808 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42808:	55                   	push   %rbp
   42809:	48 89 e5             	mov    %rsp,%rbp
   4280c:	48 83 ec 20          	sub    $0x20,%rsp
   42810:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42814:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42818:	48 c7 45 f8 57 27 04 	movq   $0x42757,-0x8(%rbp)
   4281f:	00 
    printer_vprintf(&p, 0, format, val);
   42820:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42824:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42828:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   4282c:	be 00 00 00 00       	mov    $0x0,%esi
   42831:	48 89 c7             	mov    %rax,%rdi
   42834:	e8 98 11 00 00       	call   439d1 <printer_vprintf>
}
   42839:	90                   	nop
   4283a:	c9                   	leave  
   4283b:	c3                   	ret    

000000000004283c <log_printf>:

void log_printf(const char* format, ...) {
   4283c:	55                   	push   %rbp
   4283d:	48 89 e5             	mov    %rsp,%rbp
   42840:	48 83 ec 60          	sub    $0x60,%rsp
   42844:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42848:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   4284c:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42850:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42854:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42858:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4285c:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42863:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42867:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4286b:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4286f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42873:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42877:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4287b:	48 89 d6             	mov    %rdx,%rsi
   4287e:	48 89 c7             	mov    %rax,%rdi
   42881:	e8 82 ff ff ff       	call   42808 <log_vprintf>
    va_end(val);
}
   42886:	90                   	nop
   42887:	c9                   	leave  
   42888:	c3                   	ret    

0000000000042889 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42889:	55                   	push   %rbp
   4288a:	48 89 e5             	mov    %rsp,%rbp
   4288d:	48 83 ec 40          	sub    $0x40,%rsp
   42891:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42894:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42897:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   4289b:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   4289f:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   428a3:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   428a7:	48 8b 0a             	mov    (%rdx),%rcx
   428aa:	48 89 08             	mov    %rcx,(%rax)
   428ad:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   428b1:	48 89 48 08          	mov    %rcx,0x8(%rax)
   428b5:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   428b9:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   428bd:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   428c1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   428c5:	48 89 d6             	mov    %rdx,%rsi
   428c8:	48 89 c7             	mov    %rax,%rdi
   428cb:	e8 38 ff ff ff       	call   42808 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   428d0:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   428d4:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   428d8:	8b 75 d8             	mov    -0x28(%rbp),%esi
   428db:	8b 45 dc             	mov    -0x24(%rbp),%eax
   428de:	89 c7                	mov    %eax,%edi
   428e0:	e8 9b 1b 00 00       	call   44480 <console_vprintf>
}
   428e5:	c9                   	leave  
   428e6:	c3                   	ret    

00000000000428e7 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   428e7:	55                   	push   %rbp
   428e8:	48 89 e5             	mov    %rsp,%rbp
   428eb:	48 83 ec 60          	sub    $0x60,%rsp
   428ef:	89 7d ac             	mov    %edi,-0x54(%rbp)
   428f2:	89 75 a8             	mov    %esi,-0x58(%rbp)
   428f5:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   428f9:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   428fd:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42901:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42905:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   4290c:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42910:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42914:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42918:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   4291c:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   42920:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42924:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42927:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4292a:	89 c7                	mov    %eax,%edi
   4292c:	e8 58 ff ff ff       	call   42889 <error_vprintf>
   42931:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42934:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42937:	c9                   	leave  
   42938:	c3                   	ret    

0000000000042939 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42939:	55                   	push   %rbp
   4293a:	48 89 e5             	mov    %rsp,%rbp
   4293d:	53                   	push   %rbx
   4293e:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42942:	e8 ac fb ff ff       	call   424f3 <keyboard_readc>
   42947:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   4294a:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   4294e:	74 1c                	je     4296c <check_keyboard+0x33>
   42950:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   42954:	74 16                	je     4296c <check_keyboard+0x33>
   42956:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   4295a:	74 10                	je     4296c <check_keyboard+0x33>
   4295c:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42960:	74 0a                	je     4296c <check_keyboard+0x33>
   42962:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42966:	0f 85 e9 00 00 00    	jne    42a55 <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   4296c:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42973:	00 
        memset(pt, 0, PAGESIZE * 3);
   42974:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42978:	ba 00 30 00 00       	mov    $0x3000,%edx
   4297d:	be 00 00 00 00       	mov    $0x0,%esi
   42982:	48 89 c7             	mov    %rax,%rdi
   42985:	e8 ab 0d 00 00       	call   43735 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   4298a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4298e:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42995:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42999:	48 05 00 10 00 00    	add    $0x1000,%rax
   4299f:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   429a6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   429aa:	48 05 00 20 00 00    	add    $0x2000,%rax
   429b0:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   429b7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   429bb:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   429bf:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   429c3:	0f 22 d8             	mov    %rax,%cr3
}
   429c6:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   429c7:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   429ce:	48 c7 45 e8 b8 4c 04 	movq   $0x44cb8,-0x18(%rbp)
   429d5:	00 
        if (c == 'a') {
   429d6:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   429da:	75 0a                	jne    429e6 <check_keyboard+0xad>
            argument = "allocator";
   429dc:	48 c7 45 e8 bd 4c 04 	movq   $0x44cbd,-0x18(%rbp)
   429e3:	00 
   429e4:	eb 2e                	jmp    42a14 <check_keyboard+0xdb>
        } else if (c == 'e') {
   429e6:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   429ea:	75 0a                	jne    429f6 <check_keyboard+0xbd>
            argument = "forkexit";
   429ec:	48 c7 45 e8 c7 4c 04 	movq   $0x44cc7,-0x18(%rbp)
   429f3:	00 
   429f4:	eb 1e                	jmp    42a14 <check_keyboard+0xdb>
        }
        else if (c == 't'){
   429f6:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   429fa:	75 0a                	jne    42a06 <check_keyboard+0xcd>
            argument = "test";
   429fc:	48 c7 45 e8 d0 4c 04 	movq   $0x44cd0,-0x18(%rbp)
   42a03:	00 
   42a04:	eb 0e                	jmp    42a14 <check_keyboard+0xdb>
        }
        else if(c == '2'){
   42a06:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42a0a:	75 08                	jne    42a14 <check_keyboard+0xdb>
            argument = "test2";
   42a0c:	48 c7 45 e8 d5 4c 04 	movq   $0x44cd5,-0x18(%rbp)
   42a13:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42a14:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a18:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42a1c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42a21:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   42a25:	73 14                	jae    42a3b <check_keyboard+0x102>
   42a27:	ba db 4c 04 00       	mov    $0x44cdb,%edx
   42a2c:	be 5d 02 00 00       	mov    $0x25d,%esi
   42a31:	bf f7 4c 04 00       	mov    $0x44cf7,%edi
   42a36:	e8 1f 01 00 00       	call   42b5a <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42a3b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42a3f:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42a42:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42a46:	48 89 c3             	mov    %rax,%rbx
   42a49:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42a4e:	e9 ad d5 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42a53:	eb 11                	jmp    42a66 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42a55:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42a59:	74 06                	je     42a61 <check_keyboard+0x128>
   42a5b:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42a5f:	75 05                	jne    42a66 <check_keyboard+0x12d>
        poweroff();
   42a61:	e8 9d f8 ff ff       	call   42303 <poweroff>
    }
    return c;
   42a66:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42a69:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42a6d:	c9                   	leave  
   42a6e:	c3                   	ret    

0000000000042a6f <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42a6f:	55                   	push   %rbp
   42a70:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42a73:	e8 c1 fe ff ff       	call   42939 <check_keyboard>
   42a78:	eb f9                	jmp    42a73 <fail+0x4>

0000000000042a7a <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42a7a:	55                   	push   %rbp
   42a7b:	48 89 e5             	mov    %rsp,%rbp
   42a7e:	48 83 ec 60          	sub    $0x60,%rsp
   42a82:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42a86:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42a8a:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42a8e:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42a92:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42a96:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42a9a:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42aa1:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42aa5:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42aa9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42aad:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42ab1:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42ab6:	0f 84 80 00 00 00    	je     42b3c <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42abc:	ba 0b 4d 04 00       	mov    $0x44d0b,%edx
   42ac1:	be 00 c0 00 00       	mov    $0xc000,%esi
   42ac6:	bf 30 07 00 00       	mov    $0x730,%edi
   42acb:	b8 00 00 00 00       	mov    $0x0,%eax
   42ad0:	e8 12 fe ff ff       	call   428e7 <error_printf>
   42ad5:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42ad8:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42adc:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42ae0:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42ae3:	be 00 c0 00 00       	mov    $0xc000,%esi
   42ae8:	89 c7                	mov    %eax,%edi
   42aea:	e8 9a fd ff ff       	call   42889 <error_vprintf>
   42aef:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42af2:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42af5:	48 63 c1             	movslq %ecx,%rax
   42af8:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42aff:	48 c1 e8 20          	shr    $0x20,%rax
   42b03:	89 c2                	mov    %eax,%edx
   42b05:	c1 fa 05             	sar    $0x5,%edx
   42b08:	89 c8                	mov    %ecx,%eax
   42b0a:	c1 f8 1f             	sar    $0x1f,%eax
   42b0d:	29 c2                	sub    %eax,%edx
   42b0f:	89 d0                	mov    %edx,%eax
   42b11:	c1 e0 02             	shl    $0x2,%eax
   42b14:	01 d0                	add    %edx,%eax
   42b16:	c1 e0 04             	shl    $0x4,%eax
   42b19:	29 c1                	sub    %eax,%ecx
   42b1b:	89 ca                	mov    %ecx,%edx
   42b1d:	85 d2                	test   %edx,%edx
   42b1f:	74 34                	je     42b55 <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   42b21:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42b24:	ba 13 4d 04 00       	mov    $0x44d13,%edx
   42b29:	be 00 c0 00 00       	mov    $0xc000,%esi
   42b2e:	89 c7                	mov    %eax,%edi
   42b30:	b8 00 00 00 00       	mov    $0x0,%eax
   42b35:	e8 ad fd ff ff       	call   428e7 <error_printf>
   42b3a:	eb 19                	jmp    42b55 <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42b3c:	ba 15 4d 04 00       	mov    $0x44d15,%edx
   42b41:	be 00 c0 00 00       	mov    $0xc000,%esi
   42b46:	bf 30 07 00 00       	mov    $0x730,%edi
   42b4b:	b8 00 00 00 00       	mov    $0x0,%eax
   42b50:	e8 92 fd ff ff       	call   428e7 <error_printf>
    }

    va_end(val);
    fail();
   42b55:	e8 15 ff ff ff       	call   42a6f <fail>

0000000000042b5a <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42b5a:	55                   	push   %rbp
   42b5b:	48 89 e5             	mov    %rsp,%rbp
   42b5e:	48 83 ec 20          	sub    $0x20,%rsp
   42b62:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42b66:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42b69:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42b6d:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42b71:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42b74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42b78:	48 89 c6             	mov    %rax,%rsi
   42b7b:	bf 1b 4d 04 00       	mov    $0x44d1b,%edi
   42b80:	b8 00 00 00 00       	mov    $0x0,%eax
   42b85:	e8 f0 fe ff ff       	call   42a7a <panic>

0000000000042b8a <default_exception>:
}

void default_exception(proc* p){
   42b8a:	55                   	push   %rbp
   42b8b:	48 89 e5             	mov    %rsp,%rbp
   42b8e:	48 83 ec 20          	sub    $0x20,%rsp
   42b92:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42b96:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b9a:	48 83 c0 08          	add    $0x8,%rax
   42b9e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42ba2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42ba6:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42bad:	48 89 c6             	mov    %rax,%rsi
   42bb0:	bf 39 4d 04 00       	mov    $0x44d39,%edi
   42bb5:	b8 00 00 00 00       	mov    $0x0,%eax
   42bba:	e8 bb fe ff ff       	call   42a7a <panic>

0000000000042bbf <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42bbf:	55                   	push   %rbp
   42bc0:	48 89 e5             	mov    %rsp,%rbp
   42bc3:	48 83 ec 10          	sub    $0x10,%rsp
   42bc7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42bcb:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42bce:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42bd2:	78 06                	js     42bda <pageindex+0x1b>
   42bd4:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42bd8:	7e 14                	jle    42bee <pageindex+0x2f>
   42bda:	ba 58 4d 04 00       	mov    $0x44d58,%edx
   42bdf:	be 1e 00 00 00       	mov    $0x1e,%esi
   42be4:	bf 71 4d 04 00       	mov    $0x44d71,%edi
   42be9:	e8 6c ff ff ff       	call   42b5a <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42bee:	b8 03 00 00 00       	mov    $0x3,%eax
   42bf3:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42bf6:	89 c2                	mov    %eax,%edx
   42bf8:	89 d0                	mov    %edx,%eax
   42bfa:	c1 e0 03             	shl    $0x3,%eax
   42bfd:	01 d0                	add    %edx,%eax
   42bff:	83 c0 0c             	add    $0xc,%eax
   42c02:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42c06:	89 c1                	mov    %eax,%ecx
   42c08:	48 d3 ea             	shr    %cl,%rdx
   42c0b:	48 89 d0             	mov    %rdx,%rax
   42c0e:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42c13:	c9                   	leave  
   42c14:	c3                   	ret    

0000000000042c15 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42c15:	55                   	push   %rbp
   42c16:	48 89 e5             	mov    %rsp,%rbp
   42c19:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42c1d:	48 c7 05 d8 23 01 00 	movq   $0x56000,0x123d8(%rip)        # 55000 <kernel_pagetable>
   42c24:	00 60 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42c28:	ba 00 50 00 00       	mov    $0x5000,%edx
   42c2d:	be 00 00 00 00       	mov    $0x0,%esi
   42c32:	bf 00 60 05 00       	mov    $0x56000,%edi
   42c37:	e8 f9 0a 00 00       	call   43735 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42c3c:	b8 00 70 05 00       	mov    $0x57000,%eax
   42c41:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42c45:	48 89 05 b4 33 01 00 	mov    %rax,0x133b4(%rip)        # 56000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42c4c:	b8 00 80 05 00       	mov    $0x58000,%eax
   42c51:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42c55:	48 89 05 a4 43 01 00 	mov    %rax,0x143a4(%rip)        # 57000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42c5c:	b8 00 90 05 00       	mov    $0x59000,%eax
   42c61:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42c65:	48 89 05 94 53 01 00 	mov    %rax,0x15394(%rip)        # 58000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42c6c:	b8 00 a0 05 00       	mov    $0x5a000,%eax
   42c71:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42c75:	48 89 05 8c 53 01 00 	mov    %rax,0x1538c(%rip)        # 58008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42c7c:	48 8b 05 7d 23 01 00 	mov    0x1237d(%rip),%rax        # 55000 <kernel_pagetable>
   42c83:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42c89:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42c8e:	ba 00 00 00 00       	mov    $0x0,%edx
   42c93:	be 00 00 00 00       	mov    $0x0,%esi
   42c98:	48 89 c7             	mov    %rax,%rdi
   42c9b:	e8 b9 01 00 00       	call   42e59 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42ca0:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42ca7:	00 
   42ca8:	eb 62                	jmp    42d0c <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42caa:	48 8b 0d 4f 23 01 00 	mov    0x1234f(%rip),%rcx        # 55000 <kernel_pagetable>
   42cb1:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42cb5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42cb9:	48 89 ce             	mov    %rcx,%rsi
   42cbc:	48 89 c7             	mov    %rax,%rdi
   42cbf:	e8 5b 05 00 00       	call   4321f <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   42cc4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42cc8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42ccc:	74 14                	je     42ce2 <virtual_memory_init+0xcd>
   42cce:	ba 85 4d 04 00       	mov    $0x44d85,%edx
   42cd3:	be 2d 00 00 00       	mov    $0x2d,%esi
   42cd8:	bf 95 4d 04 00       	mov    $0x44d95,%edi
   42cdd:	e8 78 fe ff ff       	call   42b5a <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42ce2:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42ce5:	48 98                	cltq   
   42ce7:	83 e0 03             	and    $0x3,%eax
   42cea:	48 83 f8 03          	cmp    $0x3,%rax
   42cee:	74 14                	je     42d04 <virtual_memory_init+0xef>
   42cf0:	ba a8 4d 04 00       	mov    $0x44da8,%edx
   42cf5:	be 2e 00 00 00       	mov    $0x2e,%esi
   42cfa:	bf 95 4d 04 00       	mov    $0x44d95,%edi
   42cff:	e8 56 fe ff ff       	call   42b5a <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42d04:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42d0b:	00 
   42d0c:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42d13:	00 
   42d14:	76 94                	jbe    42caa <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42d16:	48 8b 05 e3 22 01 00 	mov    0x122e3(%rip),%rax        # 55000 <kernel_pagetable>
   42d1d:	48 89 c7             	mov    %rax,%rdi
   42d20:	e8 03 00 00 00       	call   42d28 <set_pagetable>
}
   42d25:	90                   	nop
   42d26:	c9                   	leave  
   42d27:	c3                   	ret    

0000000000042d28 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42d28:	55                   	push   %rbp
   42d29:	48 89 e5             	mov    %rsp,%rbp
   42d2c:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42d30:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42d34:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42d38:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d3d:	48 85 c0             	test   %rax,%rax
   42d40:	74 14                	je     42d56 <set_pagetable+0x2e>
   42d42:	ba d5 4d 04 00       	mov    $0x44dd5,%edx
   42d47:	be 3d 00 00 00       	mov    $0x3d,%esi
   42d4c:	bf 95 4d 04 00       	mov    $0x44d95,%edi
   42d51:	e8 04 fe ff ff       	call   42b5a <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42d56:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42d5b:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42d5f:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42d63:	48 89 ce             	mov    %rcx,%rsi
   42d66:	48 89 c7             	mov    %rax,%rdi
   42d69:	e8 b1 04 00 00       	call   4321f <virtual_memory_lookup>
   42d6e:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42d72:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42d77:	48 39 d0             	cmp    %rdx,%rax
   42d7a:	74 14                	je     42d90 <set_pagetable+0x68>
   42d7c:	ba f0 4d 04 00       	mov    $0x44df0,%edx
   42d81:	be 3f 00 00 00       	mov    $0x3f,%esi
   42d86:	bf 95 4d 04 00       	mov    $0x44d95,%edi
   42d8b:	e8 ca fd ff ff       	call   42b5a <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42d90:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42d94:	48 8b 0d 65 22 01 00 	mov    0x12265(%rip),%rcx        # 55000 <kernel_pagetable>
   42d9b:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42d9f:	48 89 ce             	mov    %rcx,%rsi
   42da2:	48 89 c7             	mov    %rax,%rdi
   42da5:	e8 75 04 00 00       	call   4321f <virtual_memory_lookup>
   42daa:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42dae:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42db2:	48 39 c2             	cmp    %rax,%rdx
   42db5:	74 14                	je     42dcb <set_pagetable+0xa3>
   42db7:	ba 58 4e 04 00       	mov    $0x44e58,%edx
   42dbc:	be 41 00 00 00       	mov    $0x41,%esi
   42dc1:	bf 95 4d 04 00       	mov    $0x44d95,%edi
   42dc6:	e8 8f fd ff ff       	call   42b5a <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42dcb:	48 8b 05 2e 22 01 00 	mov    0x1222e(%rip),%rax        # 55000 <kernel_pagetable>
   42dd2:	48 89 c2             	mov    %rax,%rdx
   42dd5:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42dd9:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42ddd:	48 89 ce             	mov    %rcx,%rsi
   42de0:	48 89 c7             	mov    %rax,%rdi
   42de3:	e8 37 04 00 00       	call   4321f <virtual_memory_lookup>
   42de8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42dec:	48 8b 15 0d 22 01 00 	mov    0x1220d(%rip),%rdx        # 55000 <kernel_pagetable>
   42df3:	48 39 d0             	cmp    %rdx,%rax
   42df6:	74 14                	je     42e0c <set_pagetable+0xe4>
   42df8:	ba b8 4e 04 00       	mov    $0x44eb8,%edx
   42dfd:	be 43 00 00 00       	mov    $0x43,%esi
   42e02:	bf 95 4d 04 00       	mov    $0x44d95,%edi
   42e07:	e8 4e fd ff ff       	call   42b5a <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42e0c:	ba 59 2e 04 00       	mov    $0x42e59,%edx
   42e11:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42e15:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42e19:	48 89 ce             	mov    %rcx,%rsi
   42e1c:	48 89 c7             	mov    %rax,%rdi
   42e1f:	e8 fb 03 00 00       	call   4321f <virtual_memory_lookup>
   42e24:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e28:	ba 59 2e 04 00       	mov    $0x42e59,%edx
   42e2d:	48 39 d0             	cmp    %rdx,%rax
   42e30:	74 14                	je     42e46 <set_pagetable+0x11e>
   42e32:	ba 20 4f 04 00       	mov    $0x44f20,%edx
   42e37:	be 45 00 00 00       	mov    $0x45,%esi
   42e3c:	bf 95 4d 04 00       	mov    $0x44d95,%edi
   42e41:	e8 14 fd ff ff       	call   42b5a <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42e46:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42e4a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42e4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42e52:	0f 22 d8             	mov    %rax,%cr3
}
   42e55:	90                   	nop
}
   42e56:	90                   	nop
   42e57:	c9                   	leave  
   42e58:	c3                   	ret    

0000000000042e59 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42e59:	55                   	push   %rbp
   42e5a:	48 89 e5             	mov    %rsp,%rbp
   42e5d:	41 54                	push   %r12
   42e5f:	53                   	push   %rbx
   42e60:	48 83 ec 50          	sub    $0x50,%rsp
   42e64:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42e68:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42e6c:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42e70:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   42e74:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42e78:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42e7c:	25 ff 0f 00 00       	and    $0xfff,%eax
   42e81:	48 85 c0             	test   %rax,%rax
   42e84:	74 14                	je     42e9a <virtual_memory_map+0x41>
   42e86:	ba 86 4f 04 00       	mov    $0x44f86,%edx
   42e8b:	be 66 00 00 00       	mov    $0x66,%esi
   42e90:	bf 95 4d 04 00       	mov    $0x44d95,%edi
   42e95:	e8 c0 fc ff ff       	call   42b5a <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42e9a:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42e9e:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ea3:	48 85 c0             	test   %rax,%rax
   42ea6:	74 14                	je     42ebc <virtual_memory_map+0x63>
   42ea8:	ba 99 4f 04 00       	mov    $0x44f99,%edx
   42ead:	be 67 00 00 00       	mov    $0x67,%esi
   42eb2:	bf 95 4d 04 00       	mov    $0x44d95,%edi
   42eb7:	e8 9e fc ff ff       	call   42b5a <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42ebc:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42ec0:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42ec4:	48 01 d0             	add    %rdx,%rax
   42ec7:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   42ecb:	73 24                	jae    42ef1 <virtual_memory_map+0x98>
   42ecd:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42ed1:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42ed5:	48 01 d0             	add    %rdx,%rax
   42ed8:	48 85 c0             	test   %rax,%rax
   42edb:	74 14                	je     42ef1 <virtual_memory_map+0x98>
   42edd:	ba ac 4f 04 00       	mov    $0x44fac,%edx
   42ee2:	be 68 00 00 00       	mov    $0x68,%esi
   42ee7:	bf 95 4d 04 00       	mov    $0x44d95,%edi
   42eec:	e8 69 fc ff ff       	call   42b5a <assert_fail>
    if (perm & PTE_P) {
   42ef1:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42ef4:	48 98                	cltq   
   42ef6:	83 e0 01             	and    $0x1,%eax
   42ef9:	48 85 c0             	test   %rax,%rax
   42efc:	74 6e                	je     42f6c <virtual_memory_map+0x113>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42efe:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42f02:	25 ff 0f 00 00       	and    $0xfff,%eax
   42f07:	48 85 c0             	test   %rax,%rax
   42f0a:	74 14                	je     42f20 <virtual_memory_map+0xc7>
   42f0c:	ba ca 4f 04 00       	mov    $0x44fca,%edx
   42f11:	be 6a 00 00 00       	mov    $0x6a,%esi
   42f16:	bf 95 4d 04 00       	mov    $0x44d95,%edi
   42f1b:	e8 3a fc ff ff       	call   42b5a <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42f20:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42f24:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42f28:	48 01 d0             	add    %rdx,%rax
   42f2b:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   42f2f:	73 14                	jae    42f45 <virtual_memory_map+0xec>
   42f31:	ba dd 4f 04 00       	mov    $0x44fdd,%edx
   42f36:	be 6b 00 00 00       	mov    $0x6b,%esi
   42f3b:	bf 95 4d 04 00       	mov    $0x44d95,%edi
   42f40:	e8 15 fc ff ff       	call   42b5a <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42f45:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42f49:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42f4d:	48 01 d0             	add    %rdx,%rax
   42f50:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42f56:	76 14                	jbe    42f6c <virtual_memory_map+0x113>
   42f58:	ba eb 4f 04 00       	mov    $0x44feb,%edx
   42f5d:	be 6c 00 00 00       	mov    $0x6c,%esi
   42f62:	bf 95 4d 04 00       	mov    $0x44d95,%edi
   42f67:	e8 ee fb ff ff       	call   42b5a <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42f6c:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42f70:	78 09                	js     42f7b <virtual_memory_map+0x122>
   42f72:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42f79:	7e 14                	jle    42f8f <virtual_memory_map+0x136>
   42f7b:	ba 07 50 04 00       	mov    $0x45007,%edx
   42f80:	be 6e 00 00 00       	mov    $0x6e,%esi
   42f85:	bf 95 4d 04 00       	mov    $0x44d95,%edi
   42f8a:	e8 cb fb ff ff       	call   42b5a <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42f8f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42f93:	25 ff 0f 00 00       	and    $0xfff,%eax
   42f98:	48 85 c0             	test   %rax,%rax
   42f9b:	74 14                	je     42fb1 <virtual_memory_map+0x158>
   42f9d:	ba 28 50 04 00       	mov    $0x45028,%edx
   42fa2:	be 6f 00 00 00       	mov    $0x6f,%esi
   42fa7:	bf 95 4d 04 00       	mov    $0x44d95,%edi
   42fac:	e8 a9 fb ff ff       	call   42b5a <assert_fail>

    int last_index123 = -1;
   42fb1:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   42fb8:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42fbf:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42fc0:	e9 e7 00 00 00       	jmp    430ac <virtual_memory_map+0x253>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42fc5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42fc9:	48 c1 e8 15          	shr    $0x15,%rax
   42fcd:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42fd0:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42fd3:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42fd6:	74 20                	je     42ff8 <virtual_memory_map+0x19f>
            // TODO --> done
            // find pointer to last level pagetable for current va

			l1pagetable = lookup_l1pagetable(pagetable, va, perm);	
   42fd8:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42fdb:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42fdf:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42fe3:	48 89 ce             	mov    %rcx,%rsi
   42fe6:	48 89 c7             	mov    %rax,%rdi
   42fe9:	e8 d7 00 00 00       	call   430c5 <lookup_l1pagetable>
   42fee:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

            last_index123 = cur_index123;
   42ff2:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42ff5:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42ff8:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42ffb:	48 98                	cltq   
   42ffd:	83 e0 01             	and    $0x1,%eax
   43000:	48 85 c0             	test   %rax,%rax
   43003:	74 3a                	je     4303f <virtual_memory_map+0x1e6>
   43005:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   4300a:	74 33                	je     4303f <virtual_memory_map+0x1e6>
            // TODO --> done
            // map `pa` at appropriate entry with permissions `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] =  (0x00000000FFFFFFFF & pa) | perm;
   4300c:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   43010:	41 89 c4             	mov    %eax,%r12d
   43013:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43016:	48 63 d8             	movslq %eax,%rbx
   43019:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4301d:	be 03 00 00 00       	mov    $0x3,%esi
   43022:	48 89 c7             	mov    %rax,%rdi
   43025:	e8 95 fb ff ff       	call   42bbf <pageindex>
   4302a:	89 c2                	mov    %eax,%edx
   4302c:	4c 89 e1             	mov    %r12,%rcx
   4302f:	48 09 d9             	or     %rbx,%rcx
   43032:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43036:	48 63 d2             	movslq %edx,%rdx
   43039:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   4303d:	eb 55                	jmp    43094 <virtual_memory_map+0x23b>

        } else if (l1pagetable) { // if page is NOT marked present
   4303f:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43044:	74 26                	je     4306c <virtual_memory_map+0x213>
            // TODO --> done
            // map to address 0 with `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] = 0 | perm;
   43046:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4304a:	be 03 00 00 00       	mov    $0x3,%esi
   4304f:	48 89 c7             	mov    %rax,%rdi
   43052:	e8 68 fb ff ff       	call   42bbf <pageindex>
   43057:	89 c2                	mov    %eax,%edx
   43059:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4305c:	48 63 c8             	movslq %eax,%rcx
   4305f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43063:	48 63 d2             	movslq %edx,%rdx
   43066:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   4306a:	eb 28                	jmp    43094 <virtual_memory_map+0x23b>

        } else if (perm & PTE_P) {
   4306c:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4306f:	48 98                	cltq   
   43071:	83 e0 01             	and    $0x1,%eax
   43074:	48 85 c0             	test   %rax,%rax
   43077:	74 1b                	je     43094 <virtual_memory_map+0x23b>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   43079:	be 8b 00 00 00       	mov    $0x8b,%esi
   4307e:	bf 50 50 04 00       	mov    $0x45050,%edi
   43083:	b8 00 00 00 00       	mov    $0x0,%eax
   43088:	e8 af f7 ff ff       	call   4283c <log_printf>
            return -1;
   4308d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43092:	eb 28                	jmp    430bc <virtual_memory_map+0x263>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   43094:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   4309b:	00 
   4309c:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   430a3:	00 
   430a4:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   430ab:	00 
   430ac:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   430b1:	0f 85 0e ff ff ff    	jne    42fc5 <virtual_memory_map+0x16c>
        }
    }
    return 0;
   430b7:	b8 00 00 00 00       	mov    $0x0,%eax
}
   430bc:	48 83 c4 50          	add    $0x50,%rsp
   430c0:	5b                   	pop    %rbx
   430c1:	41 5c                	pop    %r12
   430c3:	5d                   	pop    %rbp
   430c4:	c3                   	ret    

00000000000430c5 <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   430c5:	55                   	push   %rbp
   430c6:	48 89 e5             	mov    %rsp,%rbp
   430c9:	48 83 ec 40          	sub    $0x40,%rsp
   430cd:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   430d1:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   430d5:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   430d8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   430dc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   430e0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   430e7:	e9 23 01 00 00       	jmp    4320f <lookup_l1pagetable+0x14a>
        // TODO --> done
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)]; // replace this
   430ec:	8b 55 f4             	mov    -0xc(%rbp),%edx
   430ef:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   430f3:	89 d6                	mov    %edx,%esi
   430f5:	48 89 c7             	mov    %rax,%rdi
   430f8:	e8 c2 fa ff ff       	call   42bbf <pageindex>
   430fd:	89 c2                	mov    %eax,%edx
   430ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43103:	48 63 d2             	movslq %edx,%rdx
   43106:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   4310a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   4310e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43112:	83 e0 01             	and    $0x1,%eax
   43115:	48 85 c0             	test   %rax,%rax
   43118:	75 63                	jne    4317d <lookup_l1pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   4311a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4311d:	8d 48 02             	lea    0x2(%rax),%ecx
   43120:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43124:	25 ff 0f 00 00       	and    $0xfff,%eax
   43129:	48 89 c2             	mov    %rax,%rdx
   4312c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43130:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43136:	48 89 c6             	mov    %rax,%rsi
   43139:	bf 98 50 04 00       	mov    $0x45098,%edi
   4313e:	b8 00 00 00 00       	mov    $0x0,%eax
   43143:	e8 f4 f6 ff ff       	call   4283c <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   43148:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4314b:	48 98                	cltq   
   4314d:	83 e0 01             	and    $0x1,%eax
   43150:	48 85 c0             	test   %rax,%rax
   43153:	75 0a                	jne    4315f <lookup_l1pagetable+0x9a>
                return NULL;
   43155:	b8 00 00 00 00       	mov    $0x0,%eax
   4315a:	e9 be 00 00 00       	jmp    4321d <lookup_l1pagetable+0x158>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   4315f:	be af 00 00 00       	mov    $0xaf,%esi
   43164:	bf 00 51 04 00       	mov    $0x45100,%edi
   43169:	b8 00 00 00 00       	mov    $0x0,%eax
   4316e:	e8 c9 f6 ff ff       	call   4283c <log_printf>
            return NULL;
   43173:	b8 00 00 00 00       	mov    $0x0,%eax
   43178:	e9 a0 00 00 00       	jmp    4321d <lookup_l1pagetable+0x158>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   4317d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43181:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43187:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   4318d:	76 14                	jbe    431a3 <lookup_l1pagetable+0xde>
   4318f:	ba 48 51 04 00       	mov    $0x45148,%edx
   43194:	be b4 00 00 00       	mov    $0xb4,%esi
   43199:	bf 95 4d 04 00       	mov    $0x44d95,%edi
   4319e:	e8 b7 f9 ff ff       	call   42b5a <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   431a3:	8b 45 cc             	mov    -0x34(%rbp),%eax
   431a6:	48 98                	cltq   
   431a8:	83 e0 02             	and    $0x2,%eax
   431ab:	48 85 c0             	test   %rax,%rax
   431ae:	74 20                	je     431d0 <lookup_l1pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   431b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   431b4:	83 e0 02             	and    $0x2,%eax
   431b7:	48 85 c0             	test   %rax,%rax
   431ba:	75 14                	jne    431d0 <lookup_l1pagetable+0x10b>
   431bc:	ba 68 51 04 00       	mov    $0x45168,%edx
   431c1:	be b6 00 00 00       	mov    $0xb6,%esi
   431c6:	bf 95 4d 04 00       	mov    $0x44d95,%edi
   431cb:	e8 8a f9 ff ff       	call   42b5a <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   431d0:	8b 45 cc             	mov    -0x34(%rbp),%eax
   431d3:	48 98                	cltq   
   431d5:	83 e0 04             	and    $0x4,%eax
   431d8:	48 85 c0             	test   %rax,%rax
   431db:	74 20                	je     431fd <lookup_l1pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   431dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   431e1:	83 e0 04             	and    $0x4,%eax
   431e4:	48 85 c0             	test   %rax,%rax
   431e7:	75 14                	jne    431fd <lookup_l1pagetable+0x138>
   431e9:	ba 73 51 04 00       	mov    $0x45173,%edx
   431ee:	be b9 00 00 00       	mov    $0xb9,%esi
   431f3:	bf 95 4d 04 00       	mov    $0x44d95,%edi
   431f8:	e8 5d f9 ff ff       	call   42b5a <assert_fail>
        }

        // TODO --> done
        // set pt to physical address to next pagetable using `pe`
        pt = (x86_64_pagetable *) PTE_ADDR(pe); // replace this
   431fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43201:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43207:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   4320b:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   4320f:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   43213:	0f 8e d3 fe ff ff    	jle    430ec <lookup_l1pagetable+0x27>
    }
    return pt;
   43219:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   4321d:	c9                   	leave  
   4321e:	c3                   	ret    

000000000004321f <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   4321f:	55                   	push   %rbp
   43220:	48 89 e5             	mov    %rsp,%rbp
   43223:	48 83 ec 50          	sub    $0x50,%rsp
   43227:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4322b:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   4322f:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   43233:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43237:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   4323b:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   43242:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   43243:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   4324a:	eb 41                	jmp    4328d <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   4324c:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4324f:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   43253:	89 d6                	mov    %edx,%esi
   43255:	48 89 c7             	mov    %rax,%rdi
   43258:	e8 62 f9 ff ff       	call   42bbf <pageindex>
   4325d:	89 c2                	mov    %eax,%edx
   4325f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43263:	48 63 d2             	movslq %edx,%rdx
   43266:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   4326a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4326e:	83 e0 06             	and    $0x6,%eax
   43271:	48 f7 d0             	not    %rax
   43274:	48 21 d0             	and    %rdx,%rax
   43277:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   4327b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4327f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43285:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   43289:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   4328d:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   43291:	7f 0c                	jg     4329f <virtual_memory_lookup+0x80>
   43293:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43297:	83 e0 01             	and    $0x1,%eax
   4329a:	48 85 c0             	test   %rax,%rax
   4329d:	75 ad                	jne    4324c <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   4329f:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   432a6:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   432ad:	ff 
   432ae:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   432b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432b9:	83 e0 01             	and    $0x1,%eax
   432bc:	48 85 c0             	test   %rax,%rax
   432bf:	74 34                	je     432f5 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   432c1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432c5:	48 c1 e8 0c          	shr    $0xc,%rax
   432c9:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   432cc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432d0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   432d6:	48 89 c2             	mov    %rax,%rdx
   432d9:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   432dd:	25 ff 0f 00 00       	and    $0xfff,%eax
   432e2:	48 09 d0             	or     %rdx,%rax
   432e5:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   432e9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432ed:	25 ff 0f 00 00       	and    $0xfff,%eax
   432f2:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   432f5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   432f9:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   432fd:	48 89 10             	mov    %rdx,(%rax)
   43300:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   43304:	48 89 50 08          	mov    %rdx,0x8(%rax)
   43308:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4330c:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   43310:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43314:	c9                   	leave  
   43315:	c3                   	ret    

0000000000043316 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   43316:	55                   	push   %rbp
   43317:	48 89 e5             	mov    %rsp,%rbp
   4331a:	48 83 ec 40          	sub    $0x40,%rsp
   4331e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   43322:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   43325:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   43329:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   43330:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43334:	78 08                	js     4333e <program_load+0x28>
   43336:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   43339:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   4333c:	7c 14                	jl     43352 <program_load+0x3c>
   4333e:	ba 80 51 04 00       	mov    $0x45180,%edx
   43343:	be 37 00 00 00       	mov    $0x37,%esi
   43348:	bf b0 51 04 00       	mov    $0x451b0,%edi
   4334d:	e8 08 f8 ff ff       	call   42b5a <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   43352:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   43355:	48 98                	cltq   
   43357:	48 c1 e0 04          	shl    $0x4,%rax
   4335b:	48 05 20 60 04 00    	add    $0x46020,%rax
   43361:	48 8b 00             	mov    (%rax),%rax
   43364:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   43368:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4336c:	8b 00                	mov    (%rax),%eax
   4336e:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   43373:	74 14                	je     43389 <program_load+0x73>
   43375:	ba c2 51 04 00       	mov    $0x451c2,%edx
   4337a:	be 39 00 00 00       	mov    $0x39,%esi
   4337f:	bf b0 51 04 00       	mov    $0x451b0,%edi
   43384:	e8 d1 f7 ff ff       	call   42b5a <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   43389:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4338d:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43391:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43395:	48 01 d0             	add    %rdx,%rax
   43398:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   4339c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   433a3:	e9 94 00 00 00       	jmp    4343c <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   433a8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   433ab:	48 63 d0             	movslq %eax,%rdx
   433ae:	48 89 d0             	mov    %rdx,%rax
   433b1:	48 c1 e0 03          	shl    $0x3,%rax
   433b5:	48 29 d0             	sub    %rdx,%rax
   433b8:	48 c1 e0 03          	shl    $0x3,%rax
   433bc:	48 89 c2             	mov    %rax,%rdx
   433bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433c3:	48 01 d0             	add    %rdx,%rax
   433c6:	8b 00                	mov    (%rax),%eax
   433c8:	83 f8 01             	cmp    $0x1,%eax
   433cb:	75 6b                	jne    43438 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   433cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   433d0:	48 63 d0             	movslq %eax,%rdx
   433d3:	48 89 d0             	mov    %rdx,%rax
   433d6:	48 c1 e0 03          	shl    $0x3,%rax
   433da:	48 29 d0             	sub    %rdx,%rax
   433dd:	48 c1 e0 03          	shl    $0x3,%rax
   433e1:	48 89 c2             	mov    %rax,%rdx
   433e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433e8:	48 01 d0             	add    %rdx,%rax
   433eb:	48 8b 50 08          	mov    0x8(%rax),%rdx
   433ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   433f3:	48 01 d0             	add    %rdx,%rax
   433f6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   433fa:	8b 45 fc             	mov    -0x4(%rbp),%eax
   433fd:	48 63 d0             	movslq %eax,%rdx
   43400:	48 89 d0             	mov    %rdx,%rax
   43403:	48 c1 e0 03          	shl    $0x3,%rax
   43407:	48 29 d0             	sub    %rdx,%rax
   4340a:	48 c1 e0 03          	shl    $0x3,%rax
   4340e:	48 89 c2             	mov    %rax,%rdx
   43411:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43415:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   43419:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4341d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43421:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43425:	48 89 c7             	mov    %rax,%rdi
   43428:	e8 3d 00 00 00       	call   4346a <program_load_segment>
   4342d:	85 c0                	test   %eax,%eax
   4342f:	79 07                	jns    43438 <program_load+0x122>
                return -1;
   43431:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43436:	eb 30                	jmp    43468 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   43438:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4343c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43440:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   43444:	0f b7 c0             	movzwl %ax,%eax
   43447:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4344a:	0f 8c 58 ff ff ff    	jl     433a8 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   43450:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43454:	48 8b 50 18          	mov    0x18(%rax),%rdx
   43458:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4345c:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   43463:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43468:	c9                   	leave  
   43469:	c3                   	ret    

000000000004346a <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   4346a:	55                   	push   %rbp
   4346b:	48 89 e5             	mov    %rsp,%rbp
   4346e:	48 83 ec 70          	sub    $0x70,%rsp
   43472:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   43476:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   4347a:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   4347e:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   43482:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43486:	48 8b 40 10          	mov    0x10(%rax),%rax
   4348a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   4348e:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43492:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43496:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4349a:	48 01 d0             	add    %rdx,%rax
   4349d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   434a1:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   434a5:	48 8b 50 28          	mov    0x28(%rax),%rdx
   434a9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   434ad:	48 01 d0             	add    %rdx,%rax
   434b0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   434b4:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   434bb:	ff 

	// virtual addressing
	for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   434bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   434c0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   434c4:	e9 8f 00 00 00       	jmp    43558 <program_load_segment+0xee>
		uintptr_t pa;
		if (next_free_page(&pa) < 0
   434c9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   434cd:	48 89 c7             	mov    %rax,%rdi
   434d0:	e8 f5 ce ff ff       	call   403ca <next_free_page>
   434d5:	85 c0                	test   %eax,%eax
   434d7:	78 45                	js     4351e <program_load_segment+0xb4>
			|| assign_physical_page(pa, p->p_pid) < 0
   434d9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   434dd:	8b 00                	mov    (%rax),%eax
   434df:	0f be d0             	movsbl %al,%edx
   434e2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   434e6:	89 d6                	mov    %edx,%esi
   434e8:	48 89 c7             	mov    %rax,%rdi
   434eb:	e8 47 d1 ff ff       	call   40637 <assign_physical_page>
   434f0:	85 c0                	test   %eax,%eax
   434f2:	78 2a                	js     4351e <program_load_segment+0xb4>
			|| virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE, PTE_P | PTE_W | PTE_U) < 0) {
   434f4:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   434f8:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   434fc:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43503:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43507:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4350d:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43512:	48 89 c7             	mov    %rax,%rdi
   43515:	e8 3f f9 ff ff       	call   42e59 <virtual_memory_map>
   4351a:	85 c0                	test   %eax,%eax
   4351c:	79 32                	jns    43550 <program_load_segment+0xe6>

			console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   4351e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43522:	8b 00                	mov    (%rax),%eax
   43524:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43528:	49 89 d0             	mov    %rdx,%r8
   4352b:	89 c1                	mov    %eax,%ecx
   4352d:	ba e0 51 04 00       	mov    $0x451e0,%edx
   43532:	be 00 c0 00 00       	mov    $0xc000,%esi
   43537:	bf e0 06 00 00       	mov    $0x6e0,%edi
   4353c:	b8 00 00 00 00       	mov    $0x0,%eax
   43541:	e8 a6 0f 00 00       	call   444ec <console_printf>
			return -1;
   43546:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4354b:	e9 e5 00 00 00       	jmp    43635 <program_load_segment+0x1cb>
	for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43550:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43557:	00 
   43558:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4355c:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   43560:	0f 82 63 ff ff ff    	jb     434c9 <program_load_segment+0x5f>
    *     }
    * }
	*/

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43566:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4356a:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43571:	48 89 c7             	mov    %rax,%rdi
   43574:	e8 af f7 ff ff       	call   42d28 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   43579:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4357d:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   43581:	48 89 c2             	mov    %rax,%rdx
   43584:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43588:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   4358c:	48 89 ce             	mov    %rcx,%rsi
   4358f:	48 89 c7             	mov    %rax,%rdi
   43592:	e8 a0 00 00 00       	call   43637 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   43597:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4359b:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   4359f:	48 89 c2             	mov    %rax,%rdx
   435a2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   435a6:	be 00 00 00 00       	mov    $0x0,%esi
   435ab:	48 89 c7             	mov    %rax,%rdi
   435ae:	e8 82 01 00 00       	call   43735 <memset>

	// change to readonly permissions
	if ((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   435b3:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   435b7:	8b 40 04             	mov    0x4(%rax),%eax
   435ba:	83 e0 02             	and    $0x2,%eax
   435bd:	85 c0                	test   %eax,%eax
   435bf:	75 60                	jne    43621 <program_load_segment+0x1b7>
		for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   435c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435c5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   435c9:	eb 4c                	jmp    43617 <program_load_segment+0x1ad>
			vamapping map = virtual_memory_lookup(p->p_pagetable, addr);
   435cb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   435cf:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   435d6:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   435da:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   435de:	48 89 ce             	mov    %rcx,%rsi
   435e1:	48 89 c7             	mov    %rax,%rdi
   435e4:	e8 36 fc ff ff       	call   4321f <virtual_memory_lookup>
			virtual_memory_map(p->p_pagetable, addr, map.pa, PAGESIZE, PTE_P | PTE_U );
   435e9:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   435ed:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   435f1:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   435f8:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   435fc:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43602:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43607:	48 89 c7             	mov    %rax,%rdi
   4360a:	e8 4a f8 ff ff       	call   42e59 <virtual_memory_map>
		for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4360f:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   43616:	00 
   43617:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4361b:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   4361f:	72 aa                	jb     435cb <program_load_segment+0x161>
		}
	}

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   43621:	48 8b 05 d8 19 01 00 	mov    0x119d8(%rip),%rax        # 55000 <kernel_pagetable>
   43628:	48 89 c7             	mov    %rax,%rdi
   4362b:	e8 f8 f6 ff ff       	call   42d28 <set_pagetable>
    return 0;
   43630:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43635:	c9                   	leave  
   43636:	c3                   	ret    

0000000000043637 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43637:	55                   	push   %rbp
   43638:	48 89 e5             	mov    %rsp,%rbp
   4363b:	48 83 ec 28          	sub    $0x28,%rsp
   4363f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43643:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43647:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   4364b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4364f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43653:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43657:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4365b:	eb 1c                	jmp    43679 <memcpy+0x42>
        *d = *s;
   4365d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43661:	0f b6 10             	movzbl (%rax),%edx
   43664:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43668:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   4366a:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   4366f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43674:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43679:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4367e:	75 dd                	jne    4365d <memcpy+0x26>
    }
    return dst;
   43680:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43684:	c9                   	leave  
   43685:	c3                   	ret    

0000000000043686 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43686:	55                   	push   %rbp
   43687:	48 89 e5             	mov    %rsp,%rbp
   4368a:	48 83 ec 28          	sub    $0x28,%rsp
   4368e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43692:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43696:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   4369a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4369e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   436a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   436a6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   436aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436ae:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   436b2:	73 6a                	jae    4371e <memmove+0x98>
   436b4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   436b8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   436bc:	48 01 d0             	add    %rdx,%rax
   436bf:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   436c3:	73 59                	jae    4371e <memmove+0x98>
        s += n, d += n;
   436c5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   436c9:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   436cd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   436d1:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   436d5:	eb 17                	jmp    436ee <memmove+0x68>
            *--d = *--s;
   436d7:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   436dc:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   436e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436e5:	0f b6 10             	movzbl (%rax),%edx
   436e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436ec:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   436ee:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   436f2:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   436f6:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   436fa:	48 85 c0             	test   %rax,%rax
   436fd:	75 d8                	jne    436d7 <memmove+0x51>
    if (s < d && s + n > d) {
   436ff:	eb 2e                	jmp    4372f <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   43701:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43705:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43709:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4370d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43711:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43715:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43719:	0f b6 12             	movzbl (%rdx),%edx
   4371c:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   4371e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43722:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43726:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   4372a:	48 85 c0             	test   %rax,%rax
   4372d:	75 d2                	jne    43701 <memmove+0x7b>
        }
    }
    return dst;
   4372f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43733:	c9                   	leave  
   43734:	c3                   	ret    

0000000000043735 <memset>:

void* memset(void* v, int c, size_t n) {
   43735:	55                   	push   %rbp
   43736:	48 89 e5             	mov    %rsp,%rbp
   43739:	48 83 ec 28          	sub    $0x28,%rsp
   4373d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43741:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43744:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43748:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4374c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43750:	eb 15                	jmp    43767 <memset+0x32>
        *p = c;
   43752:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43755:	89 c2                	mov    %eax,%edx
   43757:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4375b:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   4375d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43762:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43767:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4376c:	75 e4                	jne    43752 <memset+0x1d>
    }
    return v;
   4376e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43772:	c9                   	leave  
   43773:	c3                   	ret    

0000000000043774 <strlen>:

size_t strlen(const char* s) {
   43774:	55                   	push   %rbp
   43775:	48 89 e5             	mov    %rsp,%rbp
   43778:	48 83 ec 18          	sub    $0x18,%rsp
   4377c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43780:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43787:	00 
   43788:	eb 0a                	jmp    43794 <strlen+0x20>
        ++n;
   4378a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   4378f:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43794:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43798:	0f b6 00             	movzbl (%rax),%eax
   4379b:	84 c0                	test   %al,%al
   4379d:	75 eb                	jne    4378a <strlen+0x16>
    }
    return n;
   4379f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   437a3:	c9                   	leave  
   437a4:	c3                   	ret    

00000000000437a5 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   437a5:	55                   	push   %rbp
   437a6:	48 89 e5             	mov    %rsp,%rbp
   437a9:	48 83 ec 20          	sub    $0x20,%rsp
   437ad:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   437b1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   437b5:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   437bc:	00 
   437bd:	eb 0a                	jmp    437c9 <strnlen+0x24>
        ++n;
   437bf:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   437c4:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   437c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   437cd:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   437d1:	74 0b                	je     437de <strnlen+0x39>
   437d3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437d7:	0f b6 00             	movzbl (%rax),%eax
   437da:	84 c0                	test   %al,%al
   437dc:	75 e1                	jne    437bf <strnlen+0x1a>
    }
    return n;
   437de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   437e2:	c9                   	leave  
   437e3:	c3                   	ret    

00000000000437e4 <strcpy>:

char* strcpy(char* dst, const char* src) {
   437e4:	55                   	push   %rbp
   437e5:	48 89 e5             	mov    %rsp,%rbp
   437e8:	48 83 ec 20          	sub    $0x20,%rsp
   437ec:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   437f0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   437f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437f8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   437fc:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43800:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43804:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43808:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4380c:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43810:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43814:	0f b6 12             	movzbl (%rdx),%edx
   43817:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43819:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4381d:	48 83 e8 01          	sub    $0x1,%rax
   43821:	0f b6 00             	movzbl (%rax),%eax
   43824:	84 c0                	test   %al,%al
   43826:	75 d4                	jne    437fc <strcpy+0x18>
    return dst;
   43828:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4382c:	c9                   	leave  
   4382d:	c3                   	ret    

000000000004382e <strcmp>:

int strcmp(const char* a, const char* b) {
   4382e:	55                   	push   %rbp
   4382f:	48 89 e5             	mov    %rsp,%rbp
   43832:	48 83 ec 10          	sub    $0x10,%rsp
   43836:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4383a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   4383e:	eb 0a                	jmp    4384a <strcmp+0x1c>
        ++a, ++b;
   43840:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43845:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   4384a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4384e:	0f b6 00             	movzbl (%rax),%eax
   43851:	84 c0                	test   %al,%al
   43853:	74 1d                	je     43872 <strcmp+0x44>
   43855:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43859:	0f b6 00             	movzbl (%rax),%eax
   4385c:	84 c0                	test   %al,%al
   4385e:	74 12                	je     43872 <strcmp+0x44>
   43860:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43864:	0f b6 10             	movzbl (%rax),%edx
   43867:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4386b:	0f b6 00             	movzbl (%rax),%eax
   4386e:	38 c2                	cmp    %al,%dl
   43870:	74 ce                	je     43840 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43872:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43876:	0f b6 00             	movzbl (%rax),%eax
   43879:	89 c2                	mov    %eax,%edx
   4387b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4387f:	0f b6 00             	movzbl (%rax),%eax
   43882:	38 d0                	cmp    %dl,%al
   43884:	0f 92 c0             	setb   %al
   43887:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   4388a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4388e:	0f b6 00             	movzbl (%rax),%eax
   43891:	89 c1                	mov    %eax,%ecx
   43893:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43897:	0f b6 00             	movzbl (%rax),%eax
   4389a:	38 c1                	cmp    %al,%cl
   4389c:	0f 92 c0             	setb   %al
   4389f:	0f b6 c0             	movzbl %al,%eax
   438a2:	29 c2                	sub    %eax,%edx
   438a4:	89 d0                	mov    %edx,%eax
}
   438a6:	c9                   	leave  
   438a7:	c3                   	ret    

00000000000438a8 <strchr>:

char* strchr(const char* s, int c) {
   438a8:	55                   	push   %rbp
   438a9:	48 89 e5             	mov    %rsp,%rbp
   438ac:	48 83 ec 10          	sub    $0x10,%rsp
   438b0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   438b4:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   438b7:	eb 05                	jmp    438be <strchr+0x16>
        ++s;
   438b9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   438be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   438c2:	0f b6 00             	movzbl (%rax),%eax
   438c5:	84 c0                	test   %al,%al
   438c7:	74 0e                	je     438d7 <strchr+0x2f>
   438c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   438cd:	0f b6 00             	movzbl (%rax),%eax
   438d0:	8b 55 f4             	mov    -0xc(%rbp),%edx
   438d3:	38 d0                	cmp    %dl,%al
   438d5:	75 e2                	jne    438b9 <strchr+0x11>
    }
    if (*s == (char) c) {
   438d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   438db:	0f b6 00             	movzbl (%rax),%eax
   438de:	8b 55 f4             	mov    -0xc(%rbp),%edx
   438e1:	38 d0                	cmp    %dl,%al
   438e3:	75 06                	jne    438eb <strchr+0x43>
        return (char*) s;
   438e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   438e9:	eb 05                	jmp    438f0 <strchr+0x48>
    } else {
        return NULL;
   438eb:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   438f0:	c9                   	leave  
   438f1:	c3                   	ret    

00000000000438f2 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   438f2:	55                   	push   %rbp
   438f3:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   438f6:	8b 05 04 77 01 00    	mov    0x17704(%rip),%eax        # 5b000 <rand_seed_set>
   438fc:	85 c0                	test   %eax,%eax
   438fe:	75 0a                	jne    4390a <rand+0x18>
        srand(819234718U);
   43900:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43905:	e8 24 00 00 00       	call   4392e <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   4390a:	8b 05 f4 76 01 00    	mov    0x176f4(%rip),%eax        # 5b004 <rand_seed>
   43910:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43916:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   4391b:	89 05 e3 76 01 00    	mov    %eax,0x176e3(%rip)        # 5b004 <rand_seed>
    return rand_seed & RAND_MAX;
   43921:	8b 05 dd 76 01 00    	mov    0x176dd(%rip),%eax        # 5b004 <rand_seed>
   43927:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   4392c:	5d                   	pop    %rbp
   4392d:	c3                   	ret    

000000000004392e <srand>:

void srand(unsigned seed) {
   4392e:	55                   	push   %rbp
   4392f:	48 89 e5             	mov    %rsp,%rbp
   43932:	48 83 ec 08          	sub    $0x8,%rsp
   43936:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43939:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4393c:	89 05 c2 76 01 00    	mov    %eax,0x176c2(%rip)        # 5b004 <rand_seed>
    rand_seed_set = 1;
   43942:	c7 05 b4 76 01 00 01 	movl   $0x1,0x176b4(%rip)        # 5b000 <rand_seed_set>
   43949:	00 00 00 
}
   4394c:	90                   	nop
   4394d:	c9                   	leave  
   4394e:	c3                   	ret    

000000000004394f <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   4394f:	55                   	push   %rbp
   43950:	48 89 e5             	mov    %rsp,%rbp
   43953:	48 83 ec 28          	sub    $0x28,%rsp
   43957:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4395b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   4395f:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43962:	48 c7 45 f8 00 54 04 	movq   $0x45400,-0x8(%rbp)
   43969:	00 
    if (base < 0) {
   4396a:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   4396e:	79 0b                	jns    4397b <fill_numbuf+0x2c>
        digits = lower_digits;
   43970:	48 c7 45 f8 20 54 04 	movq   $0x45420,-0x8(%rbp)
   43977:	00 
        base = -base;
   43978:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   4397b:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43980:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43984:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43987:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4398a:	48 63 c8             	movslq %eax,%rcx
   4398d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43991:	ba 00 00 00 00       	mov    $0x0,%edx
   43996:	48 f7 f1             	div    %rcx
   43999:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4399d:	48 01 d0             	add    %rdx,%rax
   439a0:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   439a5:	0f b6 10             	movzbl (%rax),%edx
   439a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   439ac:	88 10                	mov    %dl,(%rax)
        val /= base;
   439ae:	8b 45 dc             	mov    -0x24(%rbp),%eax
   439b1:	48 63 f0             	movslq %eax,%rsi
   439b4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   439b8:	ba 00 00 00 00       	mov    $0x0,%edx
   439bd:	48 f7 f6             	div    %rsi
   439c0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   439c4:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   439c9:	75 bc                	jne    43987 <fill_numbuf+0x38>
    return numbuf_end;
   439cb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   439cf:	c9                   	leave  
   439d0:	c3                   	ret    

00000000000439d1 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   439d1:	55                   	push   %rbp
   439d2:	48 89 e5             	mov    %rsp,%rbp
   439d5:	53                   	push   %rbx
   439d6:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   439dd:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   439e4:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   439ea:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   439f1:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   439f8:	e9 8a 09 00 00       	jmp    44387 <printer_vprintf+0x9b6>
        if (*format != '%') {
   439fd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a04:	0f b6 00             	movzbl (%rax),%eax
   43a07:	3c 25                	cmp    $0x25,%al
   43a09:	74 31                	je     43a3c <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   43a0b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43a12:	4c 8b 00             	mov    (%rax),%r8
   43a15:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a1c:	0f b6 00             	movzbl (%rax),%eax
   43a1f:	0f b6 c8             	movzbl %al,%ecx
   43a22:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43a28:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43a2f:	89 ce                	mov    %ecx,%esi
   43a31:	48 89 c7             	mov    %rax,%rdi
   43a34:	41 ff d0             	call   *%r8
            continue;
   43a37:	e9 43 09 00 00       	jmp    4437f <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   43a3c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   43a43:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43a4a:	01 
   43a4b:	eb 44                	jmp    43a91 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   43a4d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a54:	0f b6 00             	movzbl (%rax),%eax
   43a57:	0f be c0             	movsbl %al,%eax
   43a5a:	89 c6                	mov    %eax,%esi
   43a5c:	bf 20 52 04 00       	mov    $0x45220,%edi
   43a61:	e8 42 fe ff ff       	call   438a8 <strchr>
   43a66:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43a6a:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43a6f:	74 30                	je     43aa1 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   43a71:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43a75:	48 2d 20 52 04 00    	sub    $0x45220,%rax
   43a7b:	ba 01 00 00 00       	mov    $0x1,%edx
   43a80:	89 c1                	mov    %eax,%ecx
   43a82:	d3 e2                	shl    %cl,%edx
   43a84:	89 d0                	mov    %edx,%eax
   43a86:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   43a89:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43a90:	01 
   43a91:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a98:	0f b6 00             	movzbl (%rax),%eax
   43a9b:	84 c0                	test   %al,%al
   43a9d:	75 ae                	jne    43a4d <printer_vprintf+0x7c>
   43a9f:	eb 01                	jmp    43aa2 <printer_vprintf+0xd1>
            } else {
                break;
   43aa1:	90                   	nop
            }
        }

        // process width
        int width = -1;
   43aa2:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   43aa9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ab0:	0f b6 00             	movzbl (%rax),%eax
   43ab3:	3c 30                	cmp    $0x30,%al
   43ab5:	7e 67                	jle    43b1e <printer_vprintf+0x14d>
   43ab7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43abe:	0f b6 00             	movzbl (%rax),%eax
   43ac1:	3c 39                	cmp    $0x39,%al
   43ac3:	7f 59                	jg     43b1e <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43ac5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   43acc:	eb 2e                	jmp    43afc <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   43ace:	8b 55 e8             	mov    -0x18(%rbp),%edx
   43ad1:	89 d0                	mov    %edx,%eax
   43ad3:	c1 e0 02             	shl    $0x2,%eax
   43ad6:	01 d0                	add    %edx,%eax
   43ad8:	01 c0                	add    %eax,%eax
   43ada:	89 c1                	mov    %eax,%ecx
   43adc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ae3:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43ae7:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43aee:	0f b6 00             	movzbl (%rax),%eax
   43af1:	0f be c0             	movsbl %al,%eax
   43af4:	01 c8                	add    %ecx,%eax
   43af6:	83 e8 30             	sub    $0x30,%eax
   43af9:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43afc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43b03:	0f b6 00             	movzbl (%rax),%eax
   43b06:	3c 2f                	cmp    $0x2f,%al
   43b08:	0f 8e 85 00 00 00    	jle    43b93 <printer_vprintf+0x1c2>
   43b0e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43b15:	0f b6 00             	movzbl (%rax),%eax
   43b18:	3c 39                	cmp    $0x39,%al
   43b1a:	7e b2                	jle    43ace <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   43b1c:	eb 75                	jmp    43b93 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   43b1e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43b25:	0f b6 00             	movzbl (%rax),%eax
   43b28:	3c 2a                	cmp    $0x2a,%al
   43b2a:	75 68                	jne    43b94 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   43b2c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b33:	8b 00                	mov    (%rax),%eax
   43b35:	83 f8 2f             	cmp    $0x2f,%eax
   43b38:	77 30                	ja     43b6a <printer_vprintf+0x199>
   43b3a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b41:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43b45:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b4c:	8b 00                	mov    (%rax),%eax
   43b4e:	89 c0                	mov    %eax,%eax
   43b50:	48 01 d0             	add    %rdx,%rax
   43b53:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b5a:	8b 12                	mov    (%rdx),%edx
   43b5c:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43b5f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b66:	89 0a                	mov    %ecx,(%rdx)
   43b68:	eb 1a                	jmp    43b84 <printer_vprintf+0x1b3>
   43b6a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b71:	48 8b 40 08          	mov    0x8(%rax),%rax
   43b75:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43b79:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b80:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43b84:	8b 00                	mov    (%rax),%eax
   43b86:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   43b89:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43b90:	01 
   43b91:	eb 01                	jmp    43b94 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   43b93:	90                   	nop
        }

        // process precision
        int precision = -1;
   43b94:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   43b9b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ba2:	0f b6 00             	movzbl (%rax),%eax
   43ba5:	3c 2e                	cmp    $0x2e,%al
   43ba7:	0f 85 00 01 00 00    	jne    43cad <printer_vprintf+0x2dc>
            ++format;
   43bad:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43bb4:	01 
            if (*format >= '0' && *format <= '9') {
   43bb5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43bbc:	0f b6 00             	movzbl (%rax),%eax
   43bbf:	3c 2f                	cmp    $0x2f,%al
   43bc1:	7e 67                	jle    43c2a <printer_vprintf+0x259>
   43bc3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43bca:	0f b6 00             	movzbl (%rax),%eax
   43bcd:	3c 39                	cmp    $0x39,%al
   43bcf:	7f 59                	jg     43c2a <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43bd1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   43bd8:	eb 2e                	jmp    43c08 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   43bda:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   43bdd:	89 d0                	mov    %edx,%eax
   43bdf:	c1 e0 02             	shl    $0x2,%eax
   43be2:	01 d0                	add    %edx,%eax
   43be4:	01 c0                	add    %eax,%eax
   43be6:	89 c1                	mov    %eax,%ecx
   43be8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43bef:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43bf3:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43bfa:	0f b6 00             	movzbl (%rax),%eax
   43bfd:	0f be c0             	movsbl %al,%eax
   43c00:	01 c8                	add    %ecx,%eax
   43c02:	83 e8 30             	sub    $0x30,%eax
   43c05:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43c08:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43c0f:	0f b6 00             	movzbl (%rax),%eax
   43c12:	3c 2f                	cmp    $0x2f,%al
   43c14:	0f 8e 85 00 00 00    	jle    43c9f <printer_vprintf+0x2ce>
   43c1a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43c21:	0f b6 00             	movzbl (%rax),%eax
   43c24:	3c 39                	cmp    $0x39,%al
   43c26:	7e b2                	jle    43bda <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   43c28:	eb 75                	jmp    43c9f <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   43c2a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43c31:	0f b6 00             	movzbl (%rax),%eax
   43c34:	3c 2a                	cmp    $0x2a,%al
   43c36:	75 68                	jne    43ca0 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   43c38:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c3f:	8b 00                	mov    (%rax),%eax
   43c41:	83 f8 2f             	cmp    $0x2f,%eax
   43c44:	77 30                	ja     43c76 <printer_vprintf+0x2a5>
   43c46:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c4d:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43c51:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c58:	8b 00                	mov    (%rax),%eax
   43c5a:	89 c0                	mov    %eax,%eax
   43c5c:	48 01 d0             	add    %rdx,%rax
   43c5f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c66:	8b 12                	mov    (%rdx),%edx
   43c68:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43c6b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c72:	89 0a                	mov    %ecx,(%rdx)
   43c74:	eb 1a                	jmp    43c90 <printer_vprintf+0x2bf>
   43c76:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c7d:	48 8b 40 08          	mov    0x8(%rax),%rax
   43c81:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43c85:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c8c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43c90:	8b 00                	mov    (%rax),%eax
   43c92:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   43c95:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43c9c:	01 
   43c9d:	eb 01                	jmp    43ca0 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   43c9f:	90                   	nop
            }
            if (precision < 0) {
   43ca0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43ca4:	79 07                	jns    43cad <printer_vprintf+0x2dc>
                precision = 0;
   43ca6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   43cad:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   43cb4:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   43cbb:	00 
        int length = 0;
   43cbc:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   43cc3:	48 c7 45 c8 26 52 04 	movq   $0x45226,-0x38(%rbp)
   43cca:	00 
    again:
        switch (*format) {
   43ccb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43cd2:	0f b6 00             	movzbl (%rax),%eax
   43cd5:	0f be c0             	movsbl %al,%eax
   43cd8:	83 e8 43             	sub    $0x43,%eax
   43cdb:	83 f8 37             	cmp    $0x37,%eax
   43cde:	0f 87 9f 03 00 00    	ja     44083 <printer_vprintf+0x6b2>
   43ce4:	89 c0                	mov    %eax,%eax
   43ce6:	48 8b 04 c5 38 52 04 	mov    0x45238(,%rax,8),%rax
   43ced:	00 
   43cee:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   43cf0:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   43cf7:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43cfe:	01 
            goto again;
   43cff:	eb ca                	jmp    43ccb <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43d01:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43d05:	74 5d                	je     43d64 <printer_vprintf+0x393>
   43d07:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d0e:	8b 00                	mov    (%rax),%eax
   43d10:	83 f8 2f             	cmp    $0x2f,%eax
   43d13:	77 30                	ja     43d45 <printer_vprintf+0x374>
   43d15:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d1c:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43d20:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d27:	8b 00                	mov    (%rax),%eax
   43d29:	89 c0                	mov    %eax,%eax
   43d2b:	48 01 d0             	add    %rdx,%rax
   43d2e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d35:	8b 12                	mov    (%rdx),%edx
   43d37:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43d3a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d41:	89 0a                	mov    %ecx,(%rdx)
   43d43:	eb 1a                	jmp    43d5f <printer_vprintf+0x38e>
   43d45:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d4c:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d50:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43d54:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d5b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43d5f:	48 8b 00             	mov    (%rax),%rax
   43d62:	eb 5c                	jmp    43dc0 <printer_vprintf+0x3ef>
   43d64:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d6b:	8b 00                	mov    (%rax),%eax
   43d6d:	83 f8 2f             	cmp    $0x2f,%eax
   43d70:	77 30                	ja     43da2 <printer_vprintf+0x3d1>
   43d72:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d79:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43d7d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d84:	8b 00                	mov    (%rax),%eax
   43d86:	89 c0                	mov    %eax,%eax
   43d88:	48 01 d0             	add    %rdx,%rax
   43d8b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d92:	8b 12                	mov    (%rdx),%edx
   43d94:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43d97:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d9e:	89 0a                	mov    %ecx,(%rdx)
   43da0:	eb 1a                	jmp    43dbc <printer_vprintf+0x3eb>
   43da2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43da9:	48 8b 40 08          	mov    0x8(%rax),%rax
   43dad:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43db1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43db8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43dbc:	8b 00                	mov    (%rax),%eax
   43dbe:	48 98                	cltq   
   43dc0:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   43dc4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43dc8:	48 c1 f8 38          	sar    $0x38,%rax
   43dcc:	25 80 00 00 00       	and    $0x80,%eax
   43dd1:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   43dd4:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   43dd8:	74 09                	je     43de3 <printer_vprintf+0x412>
   43dda:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43dde:	48 f7 d8             	neg    %rax
   43de1:	eb 04                	jmp    43de7 <printer_vprintf+0x416>
   43de3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43de7:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   43deb:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   43dee:	83 c8 60             	or     $0x60,%eax
   43df1:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   43df4:	e9 cf 02 00 00       	jmp    440c8 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43df9:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43dfd:	74 5d                	je     43e5c <printer_vprintf+0x48b>
   43dff:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e06:	8b 00                	mov    (%rax),%eax
   43e08:	83 f8 2f             	cmp    $0x2f,%eax
   43e0b:	77 30                	ja     43e3d <printer_vprintf+0x46c>
   43e0d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e14:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43e18:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e1f:	8b 00                	mov    (%rax),%eax
   43e21:	89 c0                	mov    %eax,%eax
   43e23:	48 01 d0             	add    %rdx,%rax
   43e26:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e2d:	8b 12                	mov    (%rdx),%edx
   43e2f:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43e32:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e39:	89 0a                	mov    %ecx,(%rdx)
   43e3b:	eb 1a                	jmp    43e57 <printer_vprintf+0x486>
   43e3d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e44:	48 8b 40 08          	mov    0x8(%rax),%rax
   43e48:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43e4c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e53:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43e57:	48 8b 00             	mov    (%rax),%rax
   43e5a:	eb 5c                	jmp    43eb8 <printer_vprintf+0x4e7>
   43e5c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e63:	8b 00                	mov    (%rax),%eax
   43e65:	83 f8 2f             	cmp    $0x2f,%eax
   43e68:	77 30                	ja     43e9a <printer_vprintf+0x4c9>
   43e6a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e71:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43e75:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e7c:	8b 00                	mov    (%rax),%eax
   43e7e:	89 c0                	mov    %eax,%eax
   43e80:	48 01 d0             	add    %rdx,%rax
   43e83:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e8a:	8b 12                	mov    (%rdx),%edx
   43e8c:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43e8f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e96:	89 0a                	mov    %ecx,(%rdx)
   43e98:	eb 1a                	jmp    43eb4 <printer_vprintf+0x4e3>
   43e9a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ea1:	48 8b 40 08          	mov    0x8(%rax),%rax
   43ea5:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43ea9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43eb0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43eb4:	8b 00                	mov    (%rax),%eax
   43eb6:	89 c0                	mov    %eax,%eax
   43eb8:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   43ebc:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   43ec0:	e9 03 02 00 00       	jmp    440c8 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   43ec5:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   43ecc:	e9 28 ff ff ff       	jmp    43df9 <printer_vprintf+0x428>
        case 'X':
            base = 16;
   43ed1:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   43ed8:	e9 1c ff ff ff       	jmp    43df9 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   43edd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ee4:	8b 00                	mov    (%rax),%eax
   43ee6:	83 f8 2f             	cmp    $0x2f,%eax
   43ee9:	77 30                	ja     43f1b <printer_vprintf+0x54a>
   43eeb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ef2:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43ef6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43efd:	8b 00                	mov    (%rax),%eax
   43eff:	89 c0                	mov    %eax,%eax
   43f01:	48 01 d0             	add    %rdx,%rax
   43f04:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f0b:	8b 12                	mov    (%rdx),%edx
   43f0d:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43f10:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f17:	89 0a                	mov    %ecx,(%rdx)
   43f19:	eb 1a                	jmp    43f35 <printer_vprintf+0x564>
   43f1b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f22:	48 8b 40 08          	mov    0x8(%rax),%rax
   43f26:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43f2a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f31:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43f35:	48 8b 00             	mov    (%rax),%rax
   43f38:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   43f3c:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   43f43:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   43f4a:	e9 79 01 00 00       	jmp    440c8 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   43f4f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f56:	8b 00                	mov    (%rax),%eax
   43f58:	83 f8 2f             	cmp    $0x2f,%eax
   43f5b:	77 30                	ja     43f8d <printer_vprintf+0x5bc>
   43f5d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f64:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43f68:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f6f:	8b 00                	mov    (%rax),%eax
   43f71:	89 c0                	mov    %eax,%eax
   43f73:	48 01 d0             	add    %rdx,%rax
   43f76:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f7d:	8b 12                	mov    (%rdx),%edx
   43f7f:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43f82:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f89:	89 0a                	mov    %ecx,(%rdx)
   43f8b:	eb 1a                	jmp    43fa7 <printer_vprintf+0x5d6>
   43f8d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f94:	48 8b 40 08          	mov    0x8(%rax),%rax
   43f98:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43f9c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43fa3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43fa7:	48 8b 00             	mov    (%rax),%rax
   43faa:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   43fae:	e9 15 01 00 00       	jmp    440c8 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   43fb3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43fba:	8b 00                	mov    (%rax),%eax
   43fbc:	83 f8 2f             	cmp    $0x2f,%eax
   43fbf:	77 30                	ja     43ff1 <printer_vprintf+0x620>
   43fc1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43fc8:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43fcc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43fd3:	8b 00                	mov    (%rax),%eax
   43fd5:	89 c0                	mov    %eax,%eax
   43fd7:	48 01 d0             	add    %rdx,%rax
   43fda:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43fe1:	8b 12                	mov    (%rdx),%edx
   43fe3:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43fe6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43fed:	89 0a                	mov    %ecx,(%rdx)
   43fef:	eb 1a                	jmp    4400b <printer_vprintf+0x63a>
   43ff1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ff8:	48 8b 40 08          	mov    0x8(%rax),%rax
   43ffc:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44000:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44007:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4400b:	8b 00                	mov    (%rax),%eax
   4400d:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   44013:	e9 67 03 00 00       	jmp    4437f <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   44018:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   4401c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   44020:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44027:	8b 00                	mov    (%rax),%eax
   44029:	83 f8 2f             	cmp    $0x2f,%eax
   4402c:	77 30                	ja     4405e <printer_vprintf+0x68d>
   4402e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44035:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44039:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44040:	8b 00                	mov    (%rax),%eax
   44042:	89 c0                	mov    %eax,%eax
   44044:	48 01 d0             	add    %rdx,%rax
   44047:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4404e:	8b 12                	mov    (%rdx),%edx
   44050:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44053:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4405a:	89 0a                	mov    %ecx,(%rdx)
   4405c:	eb 1a                	jmp    44078 <printer_vprintf+0x6a7>
   4405e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44065:	48 8b 40 08          	mov    0x8(%rax),%rax
   44069:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4406d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44074:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44078:	8b 00                	mov    (%rax),%eax
   4407a:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   4407d:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   44081:	eb 45                	jmp    440c8 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   44083:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44087:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   4408b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44092:	0f b6 00             	movzbl (%rax),%eax
   44095:	84 c0                	test   %al,%al
   44097:	74 0c                	je     440a5 <printer_vprintf+0x6d4>
   44099:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440a0:	0f b6 00             	movzbl (%rax),%eax
   440a3:	eb 05                	jmp    440aa <printer_vprintf+0x6d9>
   440a5:	b8 25 00 00 00       	mov    $0x25,%eax
   440aa:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   440ad:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   440b1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440b8:	0f b6 00             	movzbl (%rax),%eax
   440bb:	84 c0                	test   %al,%al
   440bd:	75 08                	jne    440c7 <printer_vprintf+0x6f6>
                format--;
   440bf:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   440c6:	01 
            }
            break;
   440c7:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   440c8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440cb:	83 e0 20             	and    $0x20,%eax
   440ce:	85 c0                	test   %eax,%eax
   440d0:	74 1e                	je     440f0 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   440d2:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   440d6:	48 83 c0 18          	add    $0x18,%rax
   440da:	8b 55 e0             	mov    -0x20(%rbp),%edx
   440dd:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   440e1:	48 89 ce             	mov    %rcx,%rsi
   440e4:	48 89 c7             	mov    %rax,%rdi
   440e7:	e8 63 f8 ff ff       	call   4394f <fill_numbuf>
   440ec:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   440f0:	48 c7 45 c0 26 52 04 	movq   $0x45226,-0x40(%rbp)
   440f7:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   440f8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440fb:	83 e0 20             	and    $0x20,%eax
   440fe:	85 c0                	test   %eax,%eax
   44100:	74 48                	je     4414a <printer_vprintf+0x779>
   44102:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44105:	83 e0 40             	and    $0x40,%eax
   44108:	85 c0                	test   %eax,%eax
   4410a:	74 3e                	je     4414a <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   4410c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4410f:	25 80 00 00 00       	and    $0x80,%eax
   44114:	85 c0                	test   %eax,%eax
   44116:	74 0a                	je     44122 <printer_vprintf+0x751>
                prefix = "-";
   44118:	48 c7 45 c0 27 52 04 	movq   $0x45227,-0x40(%rbp)
   4411f:	00 
            if (flags & FLAG_NEGATIVE) {
   44120:	eb 73                	jmp    44195 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   44122:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44125:	83 e0 10             	and    $0x10,%eax
   44128:	85 c0                	test   %eax,%eax
   4412a:	74 0a                	je     44136 <printer_vprintf+0x765>
                prefix = "+";
   4412c:	48 c7 45 c0 29 52 04 	movq   $0x45229,-0x40(%rbp)
   44133:	00 
            if (flags & FLAG_NEGATIVE) {
   44134:	eb 5f                	jmp    44195 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   44136:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44139:	83 e0 08             	and    $0x8,%eax
   4413c:	85 c0                	test   %eax,%eax
   4413e:	74 55                	je     44195 <printer_vprintf+0x7c4>
                prefix = " ";
   44140:	48 c7 45 c0 2b 52 04 	movq   $0x4522b,-0x40(%rbp)
   44147:	00 
            if (flags & FLAG_NEGATIVE) {
   44148:	eb 4b                	jmp    44195 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   4414a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4414d:	83 e0 20             	and    $0x20,%eax
   44150:	85 c0                	test   %eax,%eax
   44152:	74 42                	je     44196 <printer_vprintf+0x7c5>
   44154:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44157:	83 e0 01             	and    $0x1,%eax
   4415a:	85 c0                	test   %eax,%eax
   4415c:	74 38                	je     44196 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   4415e:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   44162:	74 06                	je     4416a <printer_vprintf+0x799>
   44164:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44168:	75 2c                	jne    44196 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   4416a:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4416f:	75 0c                	jne    4417d <printer_vprintf+0x7ac>
   44171:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44174:	25 00 01 00 00       	and    $0x100,%eax
   44179:	85 c0                	test   %eax,%eax
   4417b:	74 19                	je     44196 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   4417d:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44181:	75 07                	jne    4418a <printer_vprintf+0x7b9>
   44183:	b8 2d 52 04 00       	mov    $0x4522d,%eax
   44188:	eb 05                	jmp    4418f <printer_vprintf+0x7be>
   4418a:	b8 30 52 04 00       	mov    $0x45230,%eax
   4418f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44193:	eb 01                	jmp    44196 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   44195:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   44196:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   4419a:	78 24                	js     441c0 <printer_vprintf+0x7ef>
   4419c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4419f:	83 e0 20             	and    $0x20,%eax
   441a2:	85 c0                	test   %eax,%eax
   441a4:	75 1a                	jne    441c0 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   441a6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   441a9:	48 63 d0             	movslq %eax,%rdx
   441ac:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   441b0:	48 89 d6             	mov    %rdx,%rsi
   441b3:	48 89 c7             	mov    %rax,%rdi
   441b6:	e8 ea f5 ff ff       	call   437a5 <strnlen>
   441bb:	89 45 bc             	mov    %eax,-0x44(%rbp)
   441be:	eb 0f                	jmp    441cf <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   441c0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   441c4:	48 89 c7             	mov    %rax,%rdi
   441c7:	e8 a8 f5 ff ff       	call   43774 <strlen>
   441cc:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   441cf:	8b 45 ec             	mov    -0x14(%rbp),%eax
   441d2:	83 e0 20             	and    $0x20,%eax
   441d5:	85 c0                	test   %eax,%eax
   441d7:	74 20                	je     441f9 <printer_vprintf+0x828>
   441d9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   441dd:	78 1a                	js     441f9 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   441df:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   441e2:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   441e5:	7e 08                	jle    441ef <printer_vprintf+0x81e>
   441e7:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   441ea:	2b 45 bc             	sub    -0x44(%rbp),%eax
   441ed:	eb 05                	jmp    441f4 <printer_vprintf+0x823>
   441ef:	b8 00 00 00 00       	mov    $0x0,%eax
   441f4:	89 45 b8             	mov    %eax,-0x48(%rbp)
   441f7:	eb 5c                	jmp    44255 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   441f9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   441fc:	83 e0 20             	and    $0x20,%eax
   441ff:	85 c0                	test   %eax,%eax
   44201:	74 4b                	je     4424e <printer_vprintf+0x87d>
   44203:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44206:	83 e0 02             	and    $0x2,%eax
   44209:	85 c0                	test   %eax,%eax
   4420b:	74 41                	je     4424e <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   4420d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44210:	83 e0 04             	and    $0x4,%eax
   44213:	85 c0                	test   %eax,%eax
   44215:	75 37                	jne    4424e <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   44217:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4421b:	48 89 c7             	mov    %rax,%rdi
   4421e:	e8 51 f5 ff ff       	call   43774 <strlen>
   44223:	89 c2                	mov    %eax,%edx
   44225:	8b 45 bc             	mov    -0x44(%rbp),%eax
   44228:	01 d0                	add    %edx,%eax
   4422a:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   4422d:	7e 1f                	jle    4424e <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   4422f:	8b 45 e8             	mov    -0x18(%rbp),%eax
   44232:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44235:	89 c3                	mov    %eax,%ebx
   44237:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4423b:	48 89 c7             	mov    %rax,%rdi
   4423e:	e8 31 f5 ff ff       	call   43774 <strlen>
   44243:	89 c2                	mov    %eax,%edx
   44245:	89 d8                	mov    %ebx,%eax
   44247:	29 d0                	sub    %edx,%eax
   44249:	89 45 b8             	mov    %eax,-0x48(%rbp)
   4424c:	eb 07                	jmp    44255 <printer_vprintf+0x884>
        } else {
            zeros = 0;
   4424e:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   44255:	8b 55 bc             	mov    -0x44(%rbp),%edx
   44258:	8b 45 b8             	mov    -0x48(%rbp),%eax
   4425b:	01 d0                	add    %edx,%eax
   4425d:	48 63 d8             	movslq %eax,%rbx
   44260:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44264:	48 89 c7             	mov    %rax,%rdi
   44267:	e8 08 f5 ff ff       	call   43774 <strlen>
   4426c:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   44270:	8b 45 e8             	mov    -0x18(%rbp),%eax
   44273:	29 d0                	sub    %edx,%eax
   44275:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44278:	eb 25                	jmp    4429f <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   4427a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44281:	48 8b 08             	mov    (%rax),%rcx
   44284:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4428a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44291:	be 20 00 00 00       	mov    $0x20,%esi
   44296:	48 89 c7             	mov    %rax,%rdi
   44299:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   4429b:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   4429f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   442a2:	83 e0 04             	and    $0x4,%eax
   442a5:	85 c0                	test   %eax,%eax
   442a7:	75 36                	jne    442df <printer_vprintf+0x90e>
   442a9:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   442ad:	7f cb                	jg     4427a <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   442af:	eb 2e                	jmp    442df <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   442b1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   442b8:	4c 8b 00             	mov    (%rax),%r8
   442bb:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   442bf:	0f b6 00             	movzbl (%rax),%eax
   442c2:	0f b6 c8             	movzbl %al,%ecx
   442c5:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   442cb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   442d2:	89 ce                	mov    %ecx,%esi
   442d4:	48 89 c7             	mov    %rax,%rdi
   442d7:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   442da:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   442df:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   442e3:	0f b6 00             	movzbl (%rax),%eax
   442e6:	84 c0                	test   %al,%al
   442e8:	75 c7                	jne    442b1 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   442ea:	eb 25                	jmp    44311 <printer_vprintf+0x940>
            p->putc(p, '0', color);
   442ec:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   442f3:	48 8b 08             	mov    (%rax),%rcx
   442f6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   442fc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44303:	be 30 00 00 00       	mov    $0x30,%esi
   44308:	48 89 c7             	mov    %rax,%rdi
   4430b:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   4430d:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   44311:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   44315:	7f d5                	jg     442ec <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   44317:	eb 32                	jmp    4434b <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   44319:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44320:	4c 8b 00             	mov    (%rax),%r8
   44323:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44327:	0f b6 00             	movzbl (%rax),%eax
   4432a:	0f b6 c8             	movzbl %al,%ecx
   4432d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44333:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4433a:	89 ce                	mov    %ecx,%esi
   4433c:	48 89 c7             	mov    %rax,%rdi
   4433f:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   44342:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   44347:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   4434b:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   4434f:	7f c8                	jg     44319 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   44351:	eb 25                	jmp    44378 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   44353:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4435a:	48 8b 08             	mov    (%rax),%rcx
   4435d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44363:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4436a:	be 20 00 00 00       	mov    $0x20,%esi
   4436f:	48 89 c7             	mov    %rax,%rdi
   44372:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   44374:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44378:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   4437c:	7f d5                	jg     44353 <printer_vprintf+0x982>
        }
    done: ;
   4437e:	90                   	nop
    for (; *format; ++format) {
   4437f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44386:	01 
   44387:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4438e:	0f b6 00             	movzbl (%rax),%eax
   44391:	84 c0                	test   %al,%al
   44393:	0f 85 64 f6 ff ff    	jne    439fd <printer_vprintf+0x2c>
    }
}
   44399:	90                   	nop
   4439a:	90                   	nop
   4439b:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   4439f:	c9                   	leave  
   443a0:	c3                   	ret    

00000000000443a1 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   443a1:	55                   	push   %rbp
   443a2:	48 89 e5             	mov    %rsp,%rbp
   443a5:	48 83 ec 20          	sub    $0x20,%rsp
   443a9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   443ad:	89 f0                	mov    %esi,%eax
   443af:	89 55 e0             	mov    %edx,-0x20(%rbp)
   443b2:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   443b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   443b9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   443bd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   443c1:	48 8b 40 08          	mov    0x8(%rax),%rax
   443c5:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   443ca:	48 39 d0             	cmp    %rdx,%rax
   443cd:	72 0c                	jb     443db <console_putc+0x3a>
        cp->cursor = console;
   443cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   443d3:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   443da:	00 
    }
    if (c == '\n') {
   443db:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   443df:	75 78                	jne    44459 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   443e1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   443e5:	48 8b 40 08          	mov    0x8(%rax),%rax
   443e9:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   443ef:	48 d1 f8             	sar    %rax
   443f2:	48 89 c1             	mov    %rax,%rcx
   443f5:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   443fc:	66 66 66 
   443ff:	48 89 c8             	mov    %rcx,%rax
   44402:	48 f7 ea             	imul   %rdx
   44405:	48 c1 fa 05          	sar    $0x5,%rdx
   44409:	48 89 c8             	mov    %rcx,%rax
   4440c:	48 c1 f8 3f          	sar    $0x3f,%rax
   44410:	48 29 c2             	sub    %rax,%rdx
   44413:	48 89 d0             	mov    %rdx,%rax
   44416:	48 c1 e0 02          	shl    $0x2,%rax
   4441a:	48 01 d0             	add    %rdx,%rax
   4441d:	48 c1 e0 04          	shl    $0x4,%rax
   44421:	48 29 c1             	sub    %rax,%rcx
   44424:	48 89 ca             	mov    %rcx,%rdx
   44427:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   4442a:	eb 25                	jmp    44451 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   4442c:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4442f:	83 c8 20             	or     $0x20,%eax
   44432:	89 c6                	mov    %eax,%esi
   44434:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44438:	48 8b 40 08          	mov    0x8(%rax),%rax
   4443c:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44440:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44444:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44448:	89 f2                	mov    %esi,%edx
   4444a:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   4444d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44451:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   44455:	75 d5                	jne    4442c <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   44457:	eb 24                	jmp    4447d <console_putc+0xdc>
        *cp->cursor++ = c | color;
   44459:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   4445d:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44460:	09 d0                	or     %edx,%eax
   44462:	89 c6                	mov    %eax,%esi
   44464:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44468:	48 8b 40 08          	mov    0x8(%rax),%rax
   4446c:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44470:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44474:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44478:	89 f2                	mov    %esi,%edx
   4447a:	66 89 10             	mov    %dx,(%rax)
}
   4447d:	90                   	nop
   4447e:	c9                   	leave  
   4447f:	c3                   	ret    

0000000000044480 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44480:	55                   	push   %rbp
   44481:	48 89 e5             	mov    %rsp,%rbp
   44484:	48 83 ec 30          	sub    $0x30,%rsp
   44488:	89 7d ec             	mov    %edi,-0x14(%rbp)
   4448b:	89 75 e8             	mov    %esi,-0x18(%rbp)
   4448e:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44492:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44496:	48 c7 45 f0 a1 43 04 	movq   $0x443a1,-0x10(%rbp)
   4449d:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4449e:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   444a2:	78 09                	js     444ad <console_vprintf+0x2d>
   444a4:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   444ab:	7e 07                	jle    444b4 <console_vprintf+0x34>
        cpos = 0;
   444ad:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   444b4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   444b7:	48 98                	cltq   
   444b9:	48 01 c0             	add    %rax,%rax
   444bc:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   444c2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   444c6:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   444ca:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   444ce:	8b 75 e8             	mov    -0x18(%rbp),%esi
   444d1:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   444d5:	48 89 c7             	mov    %rax,%rdi
   444d8:	e8 f4 f4 ff ff       	call   439d1 <printer_vprintf>
    return cp.cursor - console;
   444dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   444e1:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   444e7:	48 d1 f8             	sar    %rax
}
   444ea:	c9                   	leave  
   444eb:	c3                   	ret    

00000000000444ec <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   444ec:	55                   	push   %rbp
   444ed:	48 89 e5             	mov    %rsp,%rbp
   444f0:	48 83 ec 60          	sub    $0x60,%rsp
   444f4:	89 7d ac             	mov    %edi,-0x54(%rbp)
   444f7:	89 75 a8             	mov    %esi,-0x58(%rbp)
   444fa:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   444fe:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44502:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44506:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4450a:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44511:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44515:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44519:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4451d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44521:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44525:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44529:	8b 75 a8             	mov    -0x58(%rbp),%esi
   4452c:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4452f:	89 c7                	mov    %eax,%edi
   44531:	e8 4a ff ff ff       	call   44480 <console_vprintf>
   44536:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44539:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   4453c:	c9                   	leave  
   4453d:	c3                   	ret    

000000000004453e <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   4453e:	55                   	push   %rbp
   4453f:	48 89 e5             	mov    %rsp,%rbp
   44542:	48 83 ec 20          	sub    $0x20,%rsp
   44546:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4454a:	89 f0                	mov    %esi,%eax
   4454c:	89 55 e0             	mov    %edx,-0x20(%rbp)
   4454f:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   44552:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44556:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   4455a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4455e:	48 8b 50 08          	mov    0x8(%rax),%rdx
   44562:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44566:	48 8b 40 10          	mov    0x10(%rax),%rax
   4456a:	48 39 c2             	cmp    %rax,%rdx
   4456d:	73 1a                	jae    44589 <string_putc+0x4b>
        *sp->s++ = c;
   4456f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44573:	48 8b 40 08          	mov    0x8(%rax),%rax
   44577:	48 8d 48 01          	lea    0x1(%rax),%rcx
   4457b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4457f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44583:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44587:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44589:	90                   	nop
   4458a:	c9                   	leave  
   4458b:	c3                   	ret    

000000000004458c <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   4458c:	55                   	push   %rbp
   4458d:	48 89 e5             	mov    %rsp,%rbp
   44590:	48 83 ec 40          	sub    $0x40,%rsp
   44594:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44598:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   4459c:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   445a0:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   445a4:	48 c7 45 e8 3e 45 04 	movq   $0x4453e,-0x18(%rbp)
   445ab:	00 
    sp.s = s;
   445ac:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   445b0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   445b4:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   445b9:	74 33                	je     445ee <vsnprintf+0x62>
        sp.end = s + size - 1;
   445bb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   445bf:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   445c3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   445c7:	48 01 d0             	add    %rdx,%rax
   445ca:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   445ce:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   445d2:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   445d6:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   445da:	be 00 00 00 00       	mov    $0x0,%esi
   445df:	48 89 c7             	mov    %rax,%rdi
   445e2:	e8 ea f3 ff ff       	call   439d1 <printer_vprintf>
        *sp.s = 0;
   445e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   445eb:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   445ee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   445f2:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   445f6:	c9                   	leave  
   445f7:	c3                   	ret    

00000000000445f8 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   445f8:	55                   	push   %rbp
   445f9:	48 89 e5             	mov    %rsp,%rbp
   445fc:	48 83 ec 70          	sub    $0x70,%rsp
   44600:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44604:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   44608:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   4460c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44610:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44614:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44618:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   4461f:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44623:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44627:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4462b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   4462f:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44633:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44637:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   4463b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4463f:	48 89 c7             	mov    %rax,%rdi
   44642:	e8 45 ff ff ff       	call   4458c <vsnprintf>
   44647:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   4464a:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   4464d:	c9                   	leave  
   4464e:	c3                   	ret    

000000000004464f <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   4464f:	55                   	push   %rbp
   44650:	48 89 e5             	mov    %rsp,%rbp
   44653:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44657:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4465e:	eb 13                	jmp    44673 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   44660:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44663:	48 98                	cltq   
   44665:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   4466c:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   4466f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44673:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   4467a:	7e e4                	jle    44660 <console_clear+0x11>
    }
    cursorpos = 0;
   4467c:	c7 05 76 49 07 00 00 	movl   $0x0,0x74976(%rip)        # b8ffc <cursorpos>
   44683:	00 00 00 
}
   44686:	90                   	nop
   44687:	c9                   	leave  
   44688:	c3                   	ret    
