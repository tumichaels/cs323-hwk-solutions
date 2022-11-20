
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
   400be:	e8 30 07 00 00       	call   407f3 <exception>

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
   40173:	e8 95 16 00 00       	call   4180d <hardware_init>
    pageinfo_init();
   40178:	e8 f4 0c 00 00       	call   40e71 <pageinfo_init>
    console_clear();
   4017d:	e8 cb 40 00 00       	call   4424d <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 6d 1b 00 00       	call   41cf9 <timer_init>

    // use virtual_memory_map to remove user permissions for kernel memory
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4018c:	48 8b 05 6d 3e 01 00 	mov    0x13e6d(%rip),%rax        # 54000 <kernel_pagetable>
   40193:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   40199:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4019e:	ba 00 00 00 00       	mov    $0x0,%edx
   401a3:	be 00 00 00 00       	mov    $0x0,%esi
   401a8:	48 89 c7             	mov    %rax,%rdi
   401ab:	e8 a7 28 00 00       	call   42a57 <virtual_memory_map>
					   PROC_START_ADDR, PTE_P | PTE_W);
   
    // return user permissions to console
    virtual_memory_map(kernel_pagetable, (uintptr_t) CONSOLE_ADDR, (uintptr_t) CONSOLE_ADDR,
   401b0:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   401b5:	be 00 80 0b 00       	mov    $0xb8000,%esi
   401ba:	48 8b 05 3f 3e 01 00 	mov    0x13e3f(%rip),%rax        # 54000 <kernel_pagetable>
   401c1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   401c7:	b9 00 10 00 00       	mov    $0x1000,%ecx
   401cc:	48 89 c7             	mov    %rax,%rdi
   401cf:	e8 83 28 00 00       	call   42a57 <virtual_memory_map>
	// to all memory before the start of ANY processes. This means that 
	// the assign_page function is never capable of assigning this memory
	// to a process.

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   401d4:	ba 00 0e 00 00       	mov    $0xe00,%edx
   401d9:	be 00 00 00 00       	mov    $0x0,%esi
   401de:	bf 20 10 05 00       	mov    $0x51020,%edi
   401e3:	e8 4b 31 00 00       	call   43333 <memset>
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
   40205:	48 8d 90 20 10 05 00 	lea    0x51020(%rax),%rdx
   4020c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4020f:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   40211:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40214:	48 63 d0             	movslq %eax,%rdx
   40217:	48 89 d0             	mov    %rdx,%rax
   4021a:	48 c1 e0 03          	shl    $0x3,%rax
   4021e:	48 29 d0             	sub    %rdx,%rax
   40221:	48 c1 e0 05          	shl    $0x5,%rax
   40225:	48 05 e8 10 05 00    	add    $0x510e8,%rax
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
   40246:	be a0 42 04 00       	mov    $0x442a0,%esi
   4024b:	48 89 c7             	mov    %rax,%rdi
   4024e:	e8 d9 31 00 00       	call   4342c <strcmp>
   40253:	85 c0                	test   %eax,%eax
   40255:	75 14                	jne    4026b <kernel+0x104>
        process_setup(1, 4);
   40257:	be 04 00 00 00       	mov    $0x4,%esi
   4025c:	bf 01 00 00 00       	mov    $0x1,%edi
   40261:	e8 51 02 00 00       	call   404b7 <process_setup>
   40266:	e9 c2 00 00 00       	jmp    4032d <kernel+0x1c6>
    } else if (command && strcmp(command, "forkexit") == 0) {
   4026b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40270:	74 29                	je     4029b <kernel+0x134>
   40272:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40276:	be a5 42 04 00       	mov    $0x442a5,%esi
   4027b:	48 89 c7             	mov    %rax,%rdi
   4027e:	e8 a9 31 00 00       	call   4342c <strcmp>
   40283:	85 c0                	test   %eax,%eax
   40285:	75 14                	jne    4029b <kernel+0x134>
        process_setup(1, 5);
   40287:	be 05 00 00 00       	mov    $0x5,%esi
   4028c:	bf 01 00 00 00       	mov    $0x1,%edi
   40291:	e8 21 02 00 00       	call   404b7 <process_setup>
   40296:	e9 92 00 00 00       	jmp    4032d <kernel+0x1c6>
    } else if (command && strcmp(command, "test") == 0) {
   4029b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402a0:	74 26                	je     402c8 <kernel+0x161>
   402a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402a6:	be ae 42 04 00       	mov    $0x442ae,%esi
   402ab:	48 89 c7             	mov    %rax,%rdi
   402ae:	e8 79 31 00 00       	call   4342c <strcmp>
   402b3:	85 c0                	test   %eax,%eax
   402b5:	75 11                	jne    402c8 <kernel+0x161>
        process_setup(1, 6);
   402b7:	be 06 00 00 00       	mov    $0x6,%esi
   402bc:	bf 01 00 00 00       	mov    $0x1,%edi
   402c1:	e8 f1 01 00 00       	call   404b7 <process_setup>
   402c6:	eb 65                	jmp    4032d <kernel+0x1c6>
    } else if (command && strcmp(command, "test2") == 0) {
   402c8:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402cd:	74 39                	je     40308 <kernel+0x1a1>
   402cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402d3:	be b3 42 04 00       	mov    $0x442b3,%esi
   402d8:	48 89 c7             	mov    %rax,%rdi
   402db:	e8 4c 31 00 00       	call   4342c <strcmp>
   402e0:	85 c0                	test   %eax,%eax
   402e2:	75 24                	jne    40308 <kernel+0x1a1>
        for (pid_t i = 1; i <= 2; ++i) {
   402e4:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402eb:	eb 13                	jmp    40300 <kernel+0x199>
            process_setup(i, 6);
   402ed:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402f0:	be 06 00 00 00       	mov    $0x6,%esi
   402f5:	89 c7                	mov    %eax,%edi
   402f7:	e8 bb 01 00 00       	call   404b7 <process_setup>
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
   4031e:	e8 94 01 00 00       	call   404b7 <process_setup>
        for (pid_t i = 1; i <= 4; ++i) {
   40323:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40327:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
   4032b:	7e e4                	jle    40311 <kernel+0x1aa>
        }
    }


    // Switch to the first process using run()
    run(&processes[1]);
   4032d:	bf 00 11 05 00       	mov    $0x51100,%edi
   40332:	e8 dd 0a 00 00       	call   40e14 <run>

0000000000040337 <next_free_page>:

// next_free_page(uintptr_t *)
//    loads uintptr_t * with the address of the next free page
//    returns 0 on success, -1 on failure

int next_free_page(uintptr_t *fill) {
   40337:	55                   	push   %rbp
   40338:	48 89 e5             	mov    %rsp,%rbp
   4033b:	48 83 ec 18          	sub    $0x18,%rsp
   4033f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
	for (uintptr_t pa = 0; pa += PAGESIZE; pa < PROC_START_ADDR) {
   40343:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4034a:	00 
   4034b:	eb 3e                	jmp    4038b <next_free_page+0x54>
		if (pageinfo[PAGENUMBER(pa)].owner == PO_FREE && // i'm confused by owner now
   4034d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40351:	48 c1 e8 0c          	shr    $0xc,%rax
   40355:	48 98                	cltq   
   40357:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   4035e:	00 
   4035f:	84 c0                	test   %al,%al
   40361:	75 28                	jne    4038b <next_free_page+0x54>
		    pageinfo[PAGENUMBER(pa)].refcount == 0) {
   40363:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40367:	48 c1 e8 0c          	shr    $0xc,%rax
   4036b:	48 98                	cltq   
   4036d:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   40374:	00 
		if (pageinfo[PAGENUMBER(pa)].owner == PO_FREE && // i'm confused by owner now
   40375:	84 c0                	test   %al,%al
   40377:	75 12                	jne    4038b <next_free_page+0x54>
			*fill = pa;
   40379:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4037d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40381:	48 89 10             	mov    %rdx,(%rax)
		    return 0;
   40384:	b8 00 00 00 00       	mov    $0x0,%eax
   40389:	eb 14                	jmp    4039f <next_free_page+0x68>
	for (uintptr_t pa = 0; pa += PAGESIZE; pa < PROC_START_ADDR) {
   4038b:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40392:	00 
   40393:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   40398:	75 b3                	jne    4034d <next_free_page+0x16>
		}
	}
	return -1;
   4039a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   4039f:	c9                   	leave  
   403a0:	c3                   	ret    

00000000000403a1 <pagetable_setup>:

// pagetable_setup(pid)
//    given a process, sets up pagetable in the kernel space

void pagetable_setup(pid_t pid) {
   403a1:	55                   	push   %rbp
   403a2:	48 89 e5             	mov    %rsp,%rbp
   403a5:	48 83 ec 40          	sub    $0x40,%rsp
   403a9:	89 7d cc             	mov    %edi,-0x34(%rbp)
    uintptr_t pagetable_pages[5];

    for (int i = 0; i< 5; i++) {
   403ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   403b3:	eb 74                	jmp    40429 <pagetable_setup+0x88>
		if (next_free_page(&pagetable_pages[i]) == 0) {
   403b5:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   403b9:	8b 55 fc             	mov    -0x4(%rbp),%edx
   403bc:	48 63 d2             	movslq %edx,%rdx
   403bf:	48 c1 e2 03          	shl    $0x3,%rdx
   403c3:	48 01 d0             	add    %rdx,%rax
   403c6:	48 89 c7             	mov    %rax,%rdi
   403c9:	e8 69 ff ff ff       	call   40337 <next_free_page>
   403ce:	85 c0                	test   %eax,%eax
   403d0:	75 53                	jne    40425 <pagetable_setup+0x84>
			pageinfo[PAGENUMBER(pagetable_pages[i])].owner = pid;
   403d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   403d5:	48 98                	cltq   
   403d7:	48 8b 44 c5 d0       	mov    -0x30(%rbp,%rax,8),%rax
   403dc:	48 c1 e8 0c          	shr    $0xc,%rax
   403e0:	89 c1                	mov    %eax,%ecx
   403e2:	8b 45 cc             	mov    -0x34(%rbp),%eax
   403e5:	89 c2                	mov    %eax,%edx
   403e7:	48 63 c1             	movslq %ecx,%rax
   403ea:	88 94 00 40 1e 05 00 	mov    %dl,0x51e40(%rax,%rax,1)
			pageinfo[PAGENUMBER(pagetable_pages[i])].refcount = 1;
   403f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   403f4:	48 98                	cltq   
   403f6:	48 8b 44 c5 d0       	mov    -0x30(%rbp,%rax,8),%rax
   403fb:	48 c1 e8 0c          	shr    $0xc,%rax
   403ff:	48 98                	cltq   
   40401:	c6 84 00 41 1e 05 00 	movb   $0x1,0x51e41(%rax,%rax,1)
   40408:	01 
			memset((void *) pagetable_pages[i], 0, PAGESIZE);
   40409:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4040c:	48 98                	cltq   
   4040e:	48 8b 44 c5 d0       	mov    -0x30(%rbp,%rax,8),%rax
   40413:	ba 00 10 00 00       	mov    $0x1000,%edx
   40418:	be 00 00 00 00       	mov    $0x0,%esi
   4041d:	48 89 c7             	mov    %rax,%rdi
   40420:	e8 0e 2f 00 00       	call   43333 <memset>
    for (int i = 0; i< 5; i++) {
   40425:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40429:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
   4042d:	7e 86                	jle    403b5 <pagetable_setup+0x14>
		}
    }

    ((x86_64_pagetable *) pagetable_pages[0])->entry[0] =
        (x86_64_pageentry_t) pagetable_pages[1] | PTE_P | PTE_W | PTE_U;
   4042f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    ((x86_64_pagetable *) pagetable_pages[0])->entry[0] =
   40433:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
        (x86_64_pageentry_t) pagetable_pages[1] | PTE_P | PTE_W | PTE_U;
   40437:	48 83 c8 07          	or     $0x7,%rax
    ((x86_64_pagetable *) pagetable_pages[0])->entry[0] =
   4043b:	48 89 02             	mov    %rax,(%rdx)
    
    ((x86_64_pagetable *) pagetable_pages[1])->entry[0] =
        (x86_64_pageentry_t) pagetable_pages[2] | PTE_P | PTE_W | PTE_U;
   4043e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    ((x86_64_pagetable *) pagetable_pages[1])->entry[0] =
   40442:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
        (x86_64_pageentry_t) pagetable_pages[2] | PTE_P | PTE_W | PTE_U;
   40446:	48 83 c8 07          	or     $0x7,%rax
    ((x86_64_pagetable *) pagetable_pages[1])->entry[0] =
   4044a:	48 89 02             	mov    %rax,(%rdx)

    ((x86_64_pagetable *) pagetable_pages[2])->entry[0] =
        (x86_64_pageentry_t) pagetable_pages[3] | PTE_P | PTE_W | PTE_U;
   4044d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    ((x86_64_pagetable *) pagetable_pages[2])->entry[0] =
   40451:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
        (x86_64_pageentry_t) pagetable_pages[3] | PTE_P | PTE_W | PTE_U;
   40455:	48 83 c8 07          	or     $0x7,%rax
    ((x86_64_pagetable *) pagetable_pages[2])->entry[0] =
   40459:	48 89 02             	mov    %rax,(%rdx)

    ((x86_64_pagetable *) pagetable_pages[2])->entry[1] =
        (x86_64_pageentry_t) pagetable_pages[4] | PTE_P | PTE_W | PTE_U;
   4045c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    ((x86_64_pagetable *) pagetable_pages[2])->entry[1] =
   40460:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
        (x86_64_pageentry_t) pagetable_pages[4] | PTE_P | PTE_W | PTE_U;
   40464:	48 83 c8 07          	or     $0x7,%rax
    ((x86_64_pagetable *) pagetable_pages[2])->entry[1] =
   40468:	48 89 42 08          	mov    %rax,0x8(%rdx)

   
    memcpy((void *)pagetable_pages[3], &kernel_pagetable[3], 
   4046c:	48 8b 05 8d 3b 01 00 	mov    0x13b8d(%rip),%rax        # 54000 <kernel_pagetable>
   40473:	48 05 00 30 00 00    	add    $0x3000,%rax
   40479:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4047d:	48 89 d1             	mov    %rdx,%rcx
   40480:	ba 00 08 00 00       	mov    $0x800,%edx
   40485:	48 89 c6             	mov    %rax,%rsi
   40488:	48 89 cf             	mov    %rcx,%rdi
   4048b:	e8 a5 2d 00 00       	call   43235 <memcpy>
	   sizeof(x86_64_pageentry_t) * PAGENUMBER(PROC_START_ADDR));

    processes[pid].p_pagetable = (x86_64_pagetable *) pagetable_pages[0];
   40490:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40494:	48 89 c1             	mov    %rax,%rcx
   40497:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4049a:	48 63 d0             	movslq %eax,%rdx
   4049d:	48 89 d0             	mov    %rdx,%rax
   404a0:	48 c1 e0 03          	shl    $0x3,%rax
   404a4:	48 29 d0             	sub    %rdx,%rax
   404a7:	48 c1 e0 05          	shl    $0x5,%rax
   404ab:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   404b1:	48 89 08             	mov    %rcx,(%rax)
}
   404b4:	90                   	nop
   404b5:	c9                   	leave  
   404b6:	c3                   	ret    

00000000000404b7 <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   404b7:	55                   	push   %rbp
   404b8:	48 89 e5             	mov    %rsp,%rbp
   404bb:	48 83 ec 30          	sub    $0x30,%rsp
   404bf:	89 7d dc             	mov    %edi,-0x24(%rbp)
   404c2:	89 75 d8             	mov    %esi,-0x28(%rbp)
    process_init(&processes[pid], 0);
   404c5:	8b 45 dc             	mov    -0x24(%rbp),%eax
   404c8:	48 63 d0             	movslq %eax,%rdx
   404cb:	48 89 d0             	mov    %rdx,%rax
   404ce:	48 c1 e0 03          	shl    $0x3,%rax
   404d2:	48 29 d0             	sub    %rdx,%rax
   404d5:	48 c1 e0 05          	shl    $0x5,%rax
   404d9:	48 05 20 10 05 00    	add    $0x51020,%rax
   404df:	be 00 00 00 00       	mov    $0x0,%esi
   404e4:	48 89 c7             	mov    %rax,%rdi
   404e7:	e8 9e 1a 00 00       	call   41f8a <process_init>
    //processes[pid].p_pagetable = kernel_pagetable;
    //++pageinfo[PAGENUMBER(kernel_pagetable)].refcount; //increase refcount since kernel_pagetable was used

    pagetable_setup(pid);
   404ec:	8b 45 dc             	mov    -0x24(%rbp),%eax
   404ef:	89 c7                	mov    %eax,%edi
   404f1:	e8 ab fe ff ff       	call   403a1 <pagetable_setup>

    int r = program_load(&processes[pid], program_number, NULL);
   404f6:	8b 45 dc             	mov    -0x24(%rbp),%eax
   404f9:	48 63 d0             	movslq %eax,%rdx
   404fc:	48 89 d0             	mov    %rdx,%rax
   404ff:	48 c1 e0 03          	shl    $0x3,%rax
   40503:	48 29 d0             	sub    %rdx,%rax
   40506:	48 c1 e0 05          	shl    $0x5,%rax
   4050a:	48 8d 88 20 10 05 00 	lea    0x51020(%rax),%rcx
   40511:	8b 45 d8             	mov    -0x28(%rbp),%eax
   40514:	ba 00 00 00 00       	mov    $0x0,%edx
   40519:	89 c6                	mov    %eax,%esi
   4051b:	48 89 cf             	mov    %rcx,%rdi
   4051e:	e8 f1 29 00 00       	call   42f14 <program_load>
   40523:	89 45 fc             	mov    %eax,-0x4(%rbp)
    assert(r >= 0);
   40526:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4052a:	79 14                	jns    40540 <process_setup+0x89>
   4052c:	ba b9 42 04 00       	mov    $0x442b9,%edx
   40531:	be c2 00 00 00       	mov    $0xc2,%esi
   40536:	bf c0 42 04 00       	mov    $0x442c0,%edi
   4053b:	e8 18 22 00 00       	call   42758 <assert_fail>

    processes[pid].p_registers.reg_rsp = MEMSIZE_VIRTUAL; 
   40540:	8b 45 dc             	mov    -0x24(%rbp),%eax
   40543:	48 63 d0             	movslq %eax,%rdx
   40546:	48 89 d0             	mov    %rdx,%rax
   40549:	48 c1 e0 03          	shl    $0x3,%rax
   4054d:	48 29 d0             	sub    %rdx,%rax
   40550:	48 c1 e0 05          	shl    $0x5,%rax
   40554:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   4055a:	48 c7 00 00 00 30 00 	movq   $0x300000,(%rax)
    uintptr_t stack_page_va = processes[pid].p_registers.reg_rsp - PAGESIZE;
   40561:	8b 45 dc             	mov    -0x24(%rbp),%eax
   40564:	48 63 d0             	movslq %eax,%rdx
   40567:	48 89 d0             	mov    %rdx,%rax
   4056a:	48 c1 e0 03          	shl    $0x3,%rax
   4056e:	48 29 d0             	sub    %rdx,%rax
   40571:	48 c1 e0 05          	shl    $0x5,%rax
   40575:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   4057b:	48 8b 00             	mov    (%rax),%rax
   4057e:	48 2d 00 10 00 00    	sub    $0x1000,%rax
   40584:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    uintptr_t stack_page_pa;
    next_free_page(&stack_page_pa);
   40588:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   4058c:	48 89 c7             	mov    %rax,%rdi
   4058f:	e8 a3 fd ff ff       	call   40337 <next_free_page>
    assign_physical_page(stack_page_pa, pid);
   40594:	8b 45 dc             	mov    -0x24(%rbp),%eax
   40597:	0f be d0             	movsbl %al,%edx
   4059a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4059e:	89 d6                	mov    %edx,%esi
   405a0:	48 89 c7             	mov    %rax,%rdi
   405a3:	e8 5e 00 00 00       	call   40606 <assign_physical_page>
    virtual_memory_map(processes[pid].p_pagetable, stack_page_va, stack_page_pa,
   405a8:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   405ac:	8b 45 dc             	mov    -0x24(%rbp),%eax
   405af:	48 63 d0             	movslq %eax,%rdx
   405b2:	48 89 d0             	mov    %rdx,%rax
   405b5:	48 c1 e0 03          	shl    $0x3,%rax
   405b9:	48 29 d0             	sub    %rdx,%rax
   405bc:	48 c1 e0 05          	shl    $0x5,%rax
   405c0:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   405c6:	48 8b 00             	mov    (%rax),%rax
   405c9:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   405cd:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   405d3:	b9 00 10 00 00       	mov    $0x1000,%ecx
   405d8:	48 89 fa             	mov    %rdi,%rdx
   405db:	48 89 c7             	mov    %rax,%rdi
   405de:	e8 74 24 00 00       	call   42a57 <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);
    processes[pid].p_state = P_RUNNABLE;
   405e3:	8b 45 dc             	mov    -0x24(%rbp),%eax
   405e6:	48 63 d0             	movslq %eax,%rdx
   405e9:	48 89 d0             	mov    %rdx,%rax
   405ec:	48 c1 e0 03          	shl    $0x3,%rax
   405f0:	48 29 d0             	sub    %rdx,%rax
   405f3:	48 c1 e0 05          	shl    $0x5,%rax
   405f7:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   405fd:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   40603:	90                   	nop
   40604:	c9                   	leave  
   40605:	c3                   	ret    

0000000000040606 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   40606:	55                   	push   %rbp
   40607:	48 89 e5             	mov    %rsp,%rbp
   4060a:	48 83 ec 10          	sub    $0x10,%rsp
   4060e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   40612:	89 f0                	mov    %esi,%eax
   40614:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0								 // this check is that the permission bits are 0
   40617:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4061b:	25 ff 0f 00 00       	and    $0xfff,%eax
   40620:	48 85 c0             	test   %rax,%rax
   40623:	75 20                	jne    40645 <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   40625:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4062c:	00 
   4062d:	77 16                	ja     40645 <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   4062f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40633:	48 c1 e8 0c          	shr    $0xc,%rax
   40637:	48 98                	cltq   
   40639:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   40640:	00 
   40641:	84 c0                	test   %al,%al
   40643:	74 07                	je     4064c <assign_physical_page+0x46>
        return -1;
   40645:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4064a:	eb 2c                	jmp    40678 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   4064c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40650:	48 c1 e8 0c          	shr    $0xc,%rax
   40654:	48 98                	cltq   
   40656:	c6 84 00 41 1e 05 00 	movb   $0x1,0x51e41(%rax,%rax,1)
   4065d:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4065e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40662:	48 c1 e8 0c          	shr    $0xc,%rax
   40666:	48 98                	cltq   
   40668:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   4066c:	88 94 00 40 1e 05 00 	mov    %dl,0x51e40(%rax,%rax,1)
        return 0;
   40673:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40678:	c9                   	leave  
   40679:	c3                   	ret    

000000000004067a <syscall_mapping>:

void syscall_mapping(proc* p){
   4067a:	55                   	push   %rbp
   4067b:	48 89 e5             	mov    %rsp,%rbp
   4067e:	48 83 ec 70          	sub    $0x70,%rsp
   40682:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   40686:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4068a:	48 8b 40 38          	mov    0x38(%rax),%rax
   4068e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   40692:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40696:	48 8b 40 30          	mov    0x30(%rax),%rax
   4069a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   4069e:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406a2:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   406a9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   406ad:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   406b1:	48 89 ce             	mov    %rcx,%rsi
   406b4:	48 89 c7             	mov    %rax,%rdi
   406b7:	e8 61 27 00 00       	call   42e1d <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   406bc:	8b 45 e0             	mov    -0x20(%rbp),%eax
   406bf:	48 98                	cltq   
   406c1:	83 e0 06             	and    $0x6,%eax
   406c4:	48 83 f8 06          	cmp    $0x6,%rax
   406c8:	75 73                	jne    4073d <syscall_mapping+0xc3>
	return;
    uintptr_t endaddr = map.pa + sizeof(vamapping) - 1;
   406ca:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   406ce:	48 83 c0 17          	add    $0x17,%rax
   406d2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   406d6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406da:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   406e1:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   406e5:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   406e9:	48 89 ce             	mov    %rcx,%rsi
   406ec:	48 89 c7             	mov    %rax,%rdi
   406ef:	e8 29 27 00 00       	call   42e1d <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   406f4:	8b 45 c8             	mov    -0x38(%rbp),%eax
   406f7:	48 98                	cltq   
   406f9:	83 e0 03             	and    $0x3,%eax
   406fc:	48 83 f8 03          	cmp    $0x3,%rax
   40700:	75 3e                	jne    40740 <syscall_mapping+0xc6>
	return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   40702:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40706:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   4070d:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40711:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40715:	48 89 ce             	mov    %rcx,%rsi
   40718:	48 89 c7             	mov    %rax,%rdi
   4071b:	e8 fd 26 00 00       	call   42e1d <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40720:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40724:	48 89 c1             	mov    %rax,%rcx
   40727:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4072b:	ba 18 00 00 00       	mov    $0x18,%edx
   40730:	48 89 c6             	mov    %rax,%rsi
   40733:	48 89 cf             	mov    %rcx,%rdi
   40736:	e8 fa 2a 00 00       	call   43235 <memcpy>
   4073b:	eb 04                	jmp    40741 <syscall_mapping+0xc7>
	return;
   4073d:	90                   	nop
   4073e:	eb 01                	jmp    40741 <syscall_mapping+0xc7>
	return;
   40740:	90                   	nop
}
   40741:	c9                   	leave  
   40742:	c3                   	ret    

0000000000040743 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   40743:	55                   	push   %rbp
   40744:	48 89 e5             	mov    %rsp,%rbp
   40747:	48 83 ec 18          	sub    $0x18,%rsp
   4074b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   4074f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40753:	48 8b 40 38          	mov    0x38(%rax),%rax
   40757:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   4075a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4075e:	75 14                	jne    40774 <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   40760:	0f b6 05 99 48 00 00 	movzbl 0x4899(%rip),%eax        # 45000 <disp_global>
   40767:	84 c0                	test   %al,%al
   40769:	0f 94 c0             	sete   %al
   4076c:	88 05 8e 48 00 00    	mov    %al,0x488e(%rip)        # 45000 <disp_global>
   40772:	eb 36                	jmp    407aa <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   40774:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40778:	78 2f                	js     407a9 <syscall_mem_tog+0x66>
   4077a:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   4077e:	7f 29                	jg     407a9 <syscall_mem_tog+0x66>
   40780:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40784:	8b 00                	mov    (%rax),%eax
   40786:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   40789:	75 1e                	jne    407a9 <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   4078b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4078f:	0f b6 80 d8 00 00 00 	movzbl 0xd8(%rax),%eax
   40796:	84 c0                	test   %al,%al
   40798:	0f 94 c0             	sete   %al
   4079b:	89 c2                	mov    %eax,%edx
   4079d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   407a1:	88 90 d8 00 00 00    	mov    %dl,0xd8(%rax)
   407a7:	eb 01                	jmp    407aa <syscall_mem_tog+0x67>
            return;
   407a9:	90                   	nop
    }
}
   407aa:	c9                   	leave  
   407ab:	c3                   	ret    

00000000000407ac <next_free_pid>:
// ---------- FORK HELPERS ----------

// next_free_process(void)
//    returns the next free pid, -1 if there aren't any

pid_t next_free_pid(void) {
   407ac:	55                   	push   %rbp
   407ad:	48 89 e5             	mov    %rsp,%rbp
   407b0:	48 83 ec 10          	sub    $0x10,%rsp
	for (pid_t pid = 1; pid < NPROC; pid++)
   407b4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   407bb:	eb 29                	jmp    407e6 <next_free_pid+0x3a>
		if (processes[pid].p_state == P_FREE)
   407bd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   407c0:	48 63 d0             	movslq %eax,%rdx
   407c3:	48 89 d0             	mov    %rdx,%rax
   407c6:	48 c1 e0 03          	shl    $0x3,%rax
   407ca:	48 29 d0             	sub    %rdx,%rax
   407cd:	48 c1 e0 05          	shl    $0x5,%rax
   407d1:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   407d7:	8b 00                	mov    (%rax),%eax
   407d9:	85 c0                	test   %eax,%eax
   407db:	75 05                	jne    407e2 <next_free_pid+0x36>
			return pid;
   407dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   407e0:	eb 0f                	jmp    407f1 <next_free_pid+0x45>
	for (pid_t pid = 1; pid < NPROC; pid++)
   407e2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   407e6:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   407ea:	7e d1                	jle    407bd <next_free_pid+0x11>
	return -1;
   407ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   407f1:	c9                   	leave  
   407f2:	c3                   	ret    

00000000000407f3 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   407f3:	55                   	push   %rbp
   407f4:	48 89 e5             	mov    %rsp,%rbp
   407f7:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
   407fe:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40805:	48 8b 05 f4 07 01 00 	mov    0x107f4(%rip),%rax        # 51000 <current>
   4080c:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
   40813:	48 83 c0 08          	add    $0x8,%rax
   40817:	48 89 d6             	mov    %rdx,%rsi
   4081a:	ba 18 00 00 00       	mov    $0x18,%edx
   4081f:	48 89 c7             	mov    %rax,%rdi
   40822:	48 89 d1             	mov    %rdx,%rcx
   40825:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40828:	48 8b 05 d1 37 01 00 	mov    0x137d1(%rip),%rax        # 54000 <kernel_pagetable>
   4082f:	48 89 c7             	mov    %rax,%rdi
   40832:	e8 ef 20 00 00       	call   42926 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40837:	8b 05 bf 87 07 00    	mov    0x787bf(%rip),%eax        # b8ffc <cursorpos>
   4083d:	89 c7                	mov    %eax,%edi
   4083f:	e8 10 18 00 00       	call   42054 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   40844:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   4084b:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40852:	48 83 f8 0e          	cmp    $0xe,%rax
   40856:	74 14                	je     4086c <exception+0x79>
   40858:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   4085f:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40866:	48 83 f8 0d          	cmp    $0xd,%rax
   4086a:	75 16                	jne    40882 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   4086c:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   40873:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   4087a:	83 e0 04             	and    $0x4,%eax
   4087d:	48 85 c0             	test   %rax,%rax
   40880:	74 1a                	je     4089c <exception+0xa9>
    {
        check_virtual_memory();
   40882:	e8 81 09 00 00       	call   41208 <check_virtual_memory>
        if(disp_global){
   40887:	0f b6 05 72 47 00 00 	movzbl 0x4772(%rip),%eax        # 45000 <disp_global>
   4088e:	84 c0                	test   %al,%al
   40890:	74 0a                	je     4089c <exception+0xa9>
            memshow_physical();
   40892:	e8 e9 0a 00 00       	call   41380 <memshow_physical>
            memshow_virtual_animate();
   40897:	e8 13 0e 00 00       	call   416af <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   4089c:	e8 96 1c 00 00       	call   42537 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   408a1:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   408a8:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   408af:	48 83 e8 0e          	sub    $0xe,%rax
   408b3:	48 83 f8 2a          	cmp    $0x2a,%rax
   408b7:	0f 87 a8 04 00 00    	ja     40d65 <exception+0x572>
   408bd:	48 8b 04 c5 78 43 04 	mov    0x44378(,%rax,8),%rax
   408c4:	00 
   408c5:	ff e0                	jmp    *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   408c7:	48 8b 05 32 07 01 00 	mov    0x10732(%rip),%rax        # 51000 <current>
   408ce:	48 8b 40 38          	mov    0x38(%rax),%rax
   408d2:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
		if((void *)addr == NULL)
   408d6:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   408db:	75 0f                	jne    408ec <exception+0xf9>
		    panic(NULL);
   408dd:	bf 00 00 00 00       	mov    $0x0,%edi
   408e2:	b8 00 00 00 00       	mov    $0x0,%eax
   408e7:	e8 8c 1d 00 00       	call   42678 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   408ec:	48 8b 05 0d 07 01 00 	mov    0x1070d(%rip),%rax        # 51000 <current>
   408f3:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   408fa:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   408fe:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40902:	48 89 ce             	mov    %rcx,%rsi
   40905:	48 89 c7             	mov    %rax,%rdi
   40908:	e8 10 25 00 00       	call   42e1d <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   4090d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40911:	48 89 c1             	mov    %rax,%rcx
   40914:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
   4091b:	ba a0 00 00 00       	mov    $0xa0,%edx
   40920:	48 89 ce             	mov    %rcx,%rsi
   40923:	48 89 c7             	mov    %rax,%rdi
   40926:	e8 0a 29 00 00       	call   43235 <memcpy>
		panic(msg);
   4092b:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
   40932:	48 89 c7             	mov    %rax,%rdi
   40935:	b8 00 00 00 00       	mov    $0x0,%eax
   4093a:	e8 39 1d 00 00       	call   42678 <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   4093f:	48 8b 05 ba 06 01 00 	mov    0x106ba(%rip),%rax        # 51000 <current>
   40946:	8b 10                	mov    (%rax),%edx
   40948:	48 8b 05 b1 06 01 00 	mov    0x106b1(%rip),%rax        # 51000 <current>
   4094f:	48 63 d2             	movslq %edx,%rdx
   40952:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40956:	e9 1a 04 00 00       	jmp    40d75 <exception+0x582>

    case INT_SYS_YIELD:
        schedule();
   4095b:	e8 3e 04 00 00       	call   40d9e <schedule>
        break;                  /* will not be reached */
   40960:	e9 10 04 00 00       	jmp    40d75 <exception+0x582>

    case INT_SYS_PAGE_ALLOC: {
        uintptr_t va = current->p_registers.reg_rdi;
   40965:	48 8b 05 94 06 01 00 	mov    0x10694(%rip),%rax        # 51000 <current>
   4096c:	48 8b 40 38          	mov    0x38(%rax),%rax
   40970:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		uintptr_t pa;
		next_free_page(&pa);
   40974:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   40978:	48 89 c7             	mov    %rax,%rdi
   4097b:	e8 b7 f9 ff ff       	call   40337 <next_free_page>
        int r = assign_physical_page(pa, current->p_pid); 
   40980:	48 8b 05 79 06 01 00 	mov    0x10679(%rip),%rax        # 51000 <current>
   40987:	8b 00                	mov    (%rax),%eax
   40989:	0f be d0             	movsbl %al,%edx
   4098c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40990:	89 d6                	mov    %edx,%esi
   40992:	48 89 c7             	mov    %rax,%rdi
   40995:	e8 6c fc ff ff       	call   40606 <assign_physical_page>
   4099a:	89 45 e4             	mov    %eax,-0x1c(%rbp)
        if (r >= 0) {
   4099d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   409a1:	78 2b                	js     409ce <exception+0x1db>
            virtual_memory_map(current->p_pagetable, va, pa,
   409a3:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   409a7:	48 8b 05 52 06 01 00 	mov    0x10652(%rip),%rax        # 51000 <current>
   409ae:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   409b5:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   409b9:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   409bf:	b9 00 10 00 00       	mov    $0x1000,%ecx
   409c4:	48 89 c7             	mov    %rax,%rdi
   409c7:	e8 8b 20 00 00       	call   42a57 <virtual_memory_map>
   409cc:	eb 19                	jmp    409e7 <exception+0x1f4>
                               PAGESIZE, PTE_P | PTE_W | PTE_U);
        }
	else
		console_printf(CPOS(23, 0), 0x0400, "Out of physical memory!\n");	
   409ce:	ba d0 42 04 00       	mov    $0x442d0,%edx
   409d3:	be 00 04 00 00       	mov    $0x400,%esi
   409d8:	bf 30 07 00 00       	mov    $0x730,%edi
   409dd:	b8 00 00 00 00       	mov    $0x0,%eax
   409e2:	e8 03 37 00 00       	call   440ea <console_printf>
        current->p_registers.reg_rax = r;
   409e7:	48 8b 05 12 06 01 00 	mov    0x10612(%rip),%rax        # 51000 <current>
   409ee:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   409f1:	48 63 d2             	movslq %edx,%rdx
   409f4:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   409f8:	e9 78 03 00 00       	jmp    40d75 <exception+0x582>
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   409fd:	48 8b 05 fc 05 01 00 	mov    0x105fc(%rip),%rax        # 51000 <current>
   40a04:	48 89 c7             	mov    %rax,%rdi
   40a07:	e8 6e fc ff ff       	call   4067a <syscall_mapping>
            break;
   40a0c:	e9 64 03 00 00       	jmp    40d75 <exception+0x582>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   40a11:	48 8b 05 e8 05 01 00 	mov    0x105e8(%rip),%rax        # 51000 <current>
   40a18:	48 89 c7             	mov    %rax,%rdi
   40a1b:	e8 23 fd ff ff       	call   40743 <syscall_mem_tog>
	    break;
   40a20:	e9 50 03 00 00       	jmp    40d75 <exception+0x582>
	}

    case INT_TIMER:
        ++ticks;
   40a25:	8b 05 f5 13 01 00    	mov    0x113f5(%rip),%eax        # 51e20 <ticks>
   40a2b:	83 c0 01             	add    $0x1,%eax
   40a2e:	89 05 ec 13 01 00    	mov    %eax,0x113ec(%rip)        # 51e20 <ticks>
        schedule();
   40a34:	e8 65 03 00 00       	call   40d9e <schedule>
        break;                  /* will not be reached */
   40a39:	e9 37 03 00 00       	jmp    40d75 <exception+0x582>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40a3e:	0f 20 d0             	mov    %cr2,%rax
   40a41:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    return val;
   40a45:	48 8b 45 b8          	mov    -0x48(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   40a49:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   40a4d:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   40a54:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a5b:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   40a5e:	48 85 c0             	test   %rax,%rax
   40a61:	74 07                	je     40a6a <exception+0x277>
   40a63:	b8 e9 42 04 00       	mov    $0x442e9,%eax
   40a68:	eb 05                	jmp    40a6f <exception+0x27c>
   40a6a:	b8 ef 42 04 00       	mov    $0x442ef,%eax
        const char* operation = reg->reg_err & PFERR_WRITE
   40a6f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   40a73:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   40a7a:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a81:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   40a84:	48 85 c0             	test   %rax,%rax
   40a87:	74 07                	je     40a90 <exception+0x29d>
   40a89:	b8 f4 42 04 00       	mov    $0x442f4,%eax
   40a8e:	eb 05                	jmp    40a95 <exception+0x2a2>
   40a90:	b8 07 43 04 00       	mov    $0x44307,%eax
        const char* problem = reg->reg_err & PFERR_PRESENT
   40a95:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   40a99:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   40aa0:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40aa7:	83 e0 04             	and    $0x4,%eax
   40aaa:	48 85 c0             	test   %rax,%rax
   40aad:	75 2f                	jne    40ade <exception+0x2eb>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40aaf:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   40ab6:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40abd:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   40ac1:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40ac5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40ac9:	49 89 f0             	mov    %rsi,%r8
   40acc:	48 89 c6             	mov    %rax,%rsi
   40acf:	bf 18 43 04 00       	mov    $0x44318,%edi
   40ad4:	b8 00 00 00 00       	mov    $0x0,%eax
   40ad9:	e8 9a 1b 00 00       	call   42678 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   40ade:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   40ae5:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   40aec:	48 8b 05 0d 05 01 00 	mov    0x1050d(%rip),%rax        # 51000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   40af3:	8b 00                	mov    (%rax),%eax
   40af5:	48 8b 75 c8          	mov    -0x38(%rbp),%rsi
   40af9:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   40afd:	52                   	push   %rdx
   40afe:	ff 75 c0             	push   -0x40(%rbp)
   40b01:	49 89 f1             	mov    %rsi,%r9
   40b04:	49 89 c8             	mov    %rcx,%r8
   40b07:	89 c1                	mov    %eax,%ecx
   40b09:	ba 48 43 04 00       	mov    $0x44348,%edx
   40b0e:	be 00 0c 00 00       	mov    $0xc00,%esi
   40b13:	bf 80 07 00 00       	mov    $0x780,%edi
   40b18:	b8 00 00 00 00       	mov    $0x0,%eax
   40b1d:	e8 c8 35 00 00       	call   440ea <console_printf>
   40b22:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   40b26:	48 8b 05 d3 04 01 00 	mov    0x104d3(%rip),%rax        # 51000 <current>
   40b2d:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   40b34:	00 00 00 
        break;
   40b37:	e9 39 02 00 00       	jmp    40d75 <exception+0x582>
    }

	case INT_SYS_FORK:
		// first look for position in processes array
		pid_t child_pid;
		if ((child_pid = next_free_pid()) == -1) {
   40b3c:	e8 6b fc ff ff       	call   407ac <next_free_pid>
   40b41:	89 45 f4             	mov    %eax,-0xc(%rbp)
   40b44:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   40b48:	75 14                	jne    40b5e <exception+0x36b>
			current->p_registers.reg_rax = -1;
   40b4a:	48 8b 05 af 04 01 00 	mov    0x104af(%rip),%rax        # 51000 <current>
   40b51:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40b58:	ff 
			break;
   40b59:	e9 17 02 00 00       	jmp    40d75 <exception+0x582>
		}

		// copy the state of parent into child
		processes[child_pid] = processes[current->p_pid];
   40b5e:	48 8b 05 9b 04 01 00 	mov    0x1049b(%rip),%rax        # 51000 <current>
   40b65:	8b 08                	mov    (%rax),%ecx
   40b67:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40b6a:	48 63 d0             	movslq %eax,%rdx
   40b6d:	48 89 d0             	mov    %rdx,%rax
   40b70:	48 c1 e0 03          	shl    $0x3,%rax
   40b74:	48 29 d0             	sub    %rdx,%rax
   40b77:	48 c1 e0 05          	shl    $0x5,%rax
   40b7b:	48 8d b0 20 10 05 00 	lea    0x51020(%rax),%rsi
   40b82:	48 63 d1             	movslq %ecx,%rdx
   40b85:	48 89 d0             	mov    %rdx,%rax
   40b88:	48 c1 e0 03          	shl    $0x3,%rax
   40b8c:	48 29 d0             	sub    %rdx,%rax
   40b8f:	48 c1 e0 05          	shl    $0x5,%rax
   40b93:	48 05 20 10 05 00    	add    $0x51020,%rax
   40b99:	48 89 f2             	mov    %rsi,%rdx
   40b9c:	48 89 c6             	mov    %rax,%rsi
   40b9f:	b8 1c 00 00 00       	mov    $0x1c,%eax
   40ba4:	48 89 d7             	mov    %rdx,%rdi
   40ba7:	48 89 c1             	mov    %rax,%rcx
   40baa:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
		processes[child_pid].p_pid = child_pid;
   40bad:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40bb0:	48 63 d0             	movslq %eax,%rdx
   40bb3:	48 89 d0             	mov    %rdx,%rax
   40bb6:	48 c1 e0 03          	shl    $0x3,%rax
   40bba:	48 29 d0             	sub    %rdx,%rax
   40bbd:	48 c1 e0 05          	shl    $0x5,%rax
   40bc1:	48 8d 90 20 10 05 00 	lea    0x51020(%rax),%rdx
   40bc8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40bcb:	89 02                	mov    %eax,(%rdx)

		// copy old pagetable into new pagetable
		pagetable_setup(child_pid);
   40bcd:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40bd0:	89 c7                	mov    %eax,%edi
   40bd2:	e8 ca f7 ff ff       	call   403a1 <pagetable_setup>
		for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40bd7:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   40bde:	00 
   40bdf:	e9 3f 01 00 00       	jmp    40d23 <exception+0x530>
			vamapping map = virtual_memory_lookup(current->p_pagetable, va); // examining addr page by page
   40be4:	48 8b 05 15 04 01 00 	mov    0x10415(%rip),%rax        # 51000 <current>
   40beb:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40bf2:	48 8d 45 80          	lea    -0x80(%rbp),%rax
   40bf6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40bfa:	48 89 ce             	mov    %rcx,%rsi
   40bfd:	48 89 c7             	mov    %rax,%rdi
   40c00:	e8 18 22 00 00       	call   42e1d <virtual_memory_lookup>
			
			if (map.pn == -1) { // unused va
   40c05:	8b 45 80             	mov    -0x80(%rbp),%eax
   40c08:	83 f8 ff             	cmp    $0xffffffff,%eax
   40c0b:	0f 84 09 01 00 00    	je     40d1a <exception+0x527>
				continue;
			}
			else if ((map.perm & PTE_P) && !(map.perm & PTE_W) && (map.perm & PTE_U)) { // how to detect readonly memory?
   40c11:	8b 45 90             	mov    -0x70(%rbp),%eax
   40c14:	48 98                	cltq   
   40c16:	83 e0 01             	and    $0x1,%eax
   40c19:	48 85 c0             	test   %rax,%rax
   40c1c:	74 74                	je     40c92 <exception+0x49f>
   40c1e:	8b 45 90             	mov    -0x70(%rbp),%eax
   40c21:	48 98                	cltq   
   40c23:	83 e0 02             	and    $0x2,%eax
   40c26:	48 85 c0             	test   %rax,%rax
   40c29:	75 67                	jne    40c92 <exception+0x49f>
   40c2b:	8b 45 90             	mov    -0x70(%rbp),%eax
   40c2e:	48 98                	cltq   
   40c30:	83 e0 04             	and    $0x4,%eax
   40c33:	48 85 c0             	test   %rax,%rax
   40c36:	74 5a                	je     40c92 <exception+0x49f>
				pageinfo[map.pn].refcount++;	
   40c38:	8b 45 80             	mov    -0x80(%rbp),%eax
   40c3b:	48 63 d0             	movslq %eax,%rdx
   40c3e:	0f b6 94 12 41 1e 05 	movzbl 0x51e41(%rdx,%rdx,1),%edx
   40c45:	00 
   40c46:	83 c2 01             	add    $0x1,%edx
   40c49:	48 98                	cltq   
   40c4b:	88 94 00 41 1e 05 00 	mov    %dl,0x51e41(%rax,%rax,1)
				virtual_memory_map(processes[child_pid].p_pagetable, va, map.pa, PAGESIZE, map.perm);
   40c52:	8b 4d 90             	mov    -0x70(%rbp),%ecx
   40c55:	48 8b 7d 88          	mov    -0x78(%rbp),%rdi
   40c59:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40c5c:	48 63 d0             	movslq %eax,%rdx
   40c5f:	48 89 d0             	mov    %rdx,%rax
   40c62:	48 c1 e0 03          	shl    $0x3,%rax
   40c66:	48 29 d0             	sub    %rdx,%rax
   40c69:	48 c1 e0 05          	shl    $0x5,%rax
   40c6d:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   40c73:	48 8b 00             	mov    (%rax),%rax
   40c76:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40c7a:	41 89 c8             	mov    %ecx,%r8d
   40c7d:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40c82:	48 89 fa             	mov    %rdi,%rdx
   40c85:	48 89 c7             	mov    %rax,%rdi
   40c88:	e8 ca 1d 00 00       	call   42a57 <virtual_memory_map>
   40c8d:	e9 89 00 00 00       	jmp    40d1b <exception+0x528>
			}
			else {
				uintptr_t free_page;
				if (next_free_page(&free_page) == 0) {
   40c92:	48 8d 85 78 ff ff ff 	lea    -0x88(%rbp),%rax
   40c99:	48 89 c7             	mov    %rax,%rdi
   40c9c:	e8 96 f6 ff ff       	call   40337 <next_free_page>
   40ca1:	85 c0                	test   %eax,%eax
   40ca3:	75 76                	jne    40d1b <exception+0x528>
					assign_physical_page(free_page, child_pid);
   40ca5:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40ca8:	0f be d0             	movsbl %al,%edx
   40cab:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   40cb2:	89 d6                	mov    %edx,%esi
   40cb4:	48 89 c7             	mov    %rax,%rdi
   40cb7:	e8 4a f9 ff ff       	call   40606 <assign_physical_page>
					virtual_memory_map(processes[child_pid].p_pagetable, va, free_page, PAGESIZE, map.perm);
   40cbc:	8b 4d 90             	mov    -0x70(%rbp),%ecx
   40cbf:	48 8b bd 78 ff ff ff 	mov    -0x88(%rbp),%rdi
   40cc6:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40cc9:	48 63 d0             	movslq %eax,%rdx
   40ccc:	48 89 d0             	mov    %rdx,%rax
   40ccf:	48 c1 e0 03          	shl    $0x3,%rax
   40cd3:	48 29 d0             	sub    %rdx,%rax
   40cd6:	48 c1 e0 05          	shl    $0x5,%rax
   40cda:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   40ce0:	48 8b 00             	mov    (%rax),%rax
   40ce3:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40ce7:	41 89 c8             	mov    %ecx,%r8d
   40cea:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40cef:	48 89 fa             	mov    %rdi,%rdx
   40cf2:	48 89 c7             	mov    %rax,%rdi
   40cf5:	e8 5d 1d 00 00       	call   42a57 <virtual_memory_map>
					memcpy((void *) free_page, (void *) map.pa, PAGESIZE);
   40cfa:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   40cfe:	48 89 c1             	mov    %rax,%rcx
   40d01:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   40d08:	ba 00 10 00 00       	mov    $0x1000,%edx
   40d0d:	48 89 ce             	mov    %rcx,%rsi
   40d10:	48 89 c7             	mov    %rax,%rdi
   40d13:	e8 1d 25 00 00       	call   43235 <memcpy>
   40d18:	eb 01                	jmp    40d1b <exception+0x528>
				continue;
   40d1a:	90                   	nop
		for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40d1b:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40d22:	00 
   40d23:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   40d2a:	00 
   40d2b:	0f 86 b3 fe ff ff    	jbe    40be4 <exception+0x3f1>
			//	}
			//}
		}

		// set return values
		processes[child_pid].p_registers.reg_rax = 0;
   40d31:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40d34:	48 63 d0             	movslq %eax,%rdx
   40d37:	48 89 d0             	mov    %rdx,%rax
   40d3a:	48 c1 e0 03          	shl    $0x3,%rax
   40d3e:	48 29 d0             	sub    %rdx,%rax
   40d41:	48 c1 e0 05          	shl    $0x5,%rax
   40d45:	48 05 28 10 05 00    	add    $0x51028,%rax
   40d4b:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
		current->p_registers.reg_rax = child_pid;
   40d52:	48 8b 05 a7 02 01 00 	mov    0x102a7(%rip),%rax        # 51000 <current>
   40d59:	8b 55 f4             	mov    -0xc(%rbp),%edx
   40d5c:	48 63 d2             	movslq %edx,%rdx
   40d5f:	48 89 50 08          	mov    %rdx,0x8(%rax)
		break;
   40d63:	eb 10                	jmp    40d75 <exception+0x582>

    default:
        default_exception(current);
   40d65:	48 8b 05 94 02 01 00 	mov    0x10294(%rip),%rax        # 51000 <current>
   40d6c:	48 89 c7             	mov    %rax,%rdi
   40d6f:	e8 14 1a 00 00       	call   42788 <default_exception>
        break;                  /* will not be reached */
   40d74:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40d75:	48 8b 05 84 02 01 00 	mov    0x10284(%rip),%rax        # 51000 <current>
   40d7c:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40d82:	83 f8 01             	cmp    $0x1,%eax
   40d85:	75 0f                	jne    40d96 <exception+0x5a3>
        run(current);
   40d87:	48 8b 05 72 02 01 00 	mov    0x10272(%rip),%rax        # 51000 <current>
   40d8e:	48 89 c7             	mov    %rax,%rdi
   40d91:	e8 7e 00 00 00       	call   40e14 <run>
    } else {
        schedule();
   40d96:	e8 03 00 00 00       	call   40d9e <schedule>
    }
}
   40d9b:	90                   	nop
   40d9c:	c9                   	leave  
   40d9d:	c3                   	ret    

0000000000040d9e <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40d9e:	55                   	push   %rbp
   40d9f:	48 89 e5             	mov    %rsp,%rbp
   40da2:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40da6:	48 8b 05 53 02 01 00 	mov    0x10253(%rip),%rax        # 51000 <current>
   40dad:	8b 00                	mov    (%rax),%eax
   40daf:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40db2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40db5:	8d 50 01             	lea    0x1(%rax),%edx
   40db8:	89 d0                	mov    %edx,%eax
   40dba:	c1 f8 1f             	sar    $0x1f,%eax
   40dbd:	c1 e8 1c             	shr    $0x1c,%eax
   40dc0:	01 c2                	add    %eax,%edx
   40dc2:	83 e2 0f             	and    $0xf,%edx
   40dc5:	29 c2                	sub    %eax,%edx
   40dc7:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40dca:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40dcd:	48 63 d0             	movslq %eax,%rdx
   40dd0:	48 89 d0             	mov    %rdx,%rax
   40dd3:	48 c1 e0 03          	shl    $0x3,%rax
   40dd7:	48 29 d0             	sub    %rdx,%rax
   40dda:	48 c1 e0 05          	shl    $0x5,%rax
   40dde:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   40de4:	8b 00                	mov    (%rax),%eax
   40de6:	83 f8 01             	cmp    $0x1,%eax
   40de9:	75 22                	jne    40e0d <schedule+0x6f>
            run(&processes[pid]);
   40deb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40dee:	48 63 d0             	movslq %eax,%rdx
   40df1:	48 89 d0             	mov    %rdx,%rax
   40df4:	48 c1 e0 03          	shl    $0x3,%rax
   40df8:	48 29 d0             	sub    %rdx,%rax
   40dfb:	48 c1 e0 05          	shl    $0x5,%rax
   40dff:	48 05 20 10 05 00    	add    $0x51020,%rax
   40e05:	48 89 c7             	mov    %rax,%rdi
   40e08:	e8 07 00 00 00       	call   40e14 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40e0d:	e8 25 17 00 00       	call   42537 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40e12:	eb 9e                	jmp    40db2 <schedule+0x14>

0000000000040e14 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40e14:	55                   	push   %rbp
   40e15:	48 89 e5             	mov    %rsp,%rbp
   40e18:	48 83 ec 10          	sub    $0x10,%rsp
   40e1c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40e20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e24:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40e2a:	83 f8 01             	cmp    $0x1,%eax
   40e2d:	74 14                	je     40e43 <run+0x2f>
   40e2f:	ba d0 44 04 00       	mov    $0x444d0,%edx
   40e34:	be dc 01 00 00       	mov    $0x1dc,%esi
   40e39:	bf c0 42 04 00       	mov    $0x442c0,%edi
   40e3e:	e8 15 19 00 00       	call   42758 <assert_fail>
    current = p;
   40e43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e47:	48 89 05 b2 01 01 00 	mov    %rax,0x101b2(%rip)        # 51000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40e4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e52:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40e59:	48 89 c7             	mov    %rax,%rdi
   40e5c:	e8 c5 1a 00 00       	call   42926 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40e61:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e65:	48 83 c0 08          	add    $0x8,%rax
   40e69:	48 89 c7             	mov    %rax,%rdi
   40e6c:	e8 52 f2 ff ff       	call   400c3 <exception_return>

0000000000040e71 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40e71:	55                   	push   %rbp
   40e72:	48 89 e5             	mov    %rsp,%rbp
   40e75:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40e79:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40e80:	00 
   40e81:	e9 81 00 00 00       	jmp    40f07 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40e86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e8a:	48 89 c7             	mov    %rax,%rdi
   40e8d:	e8 33 0f 00 00       	call   41dc5 <physical_memory_isreserved>
   40e92:	85 c0                	test   %eax,%eax
   40e94:	74 09                	je     40e9f <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40e96:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40e9d:	eb 2f                	jmp    40ece <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40e9f:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40ea6:	00 
   40ea7:	76 0b                	jbe    40eb4 <pageinfo_init+0x43>
   40ea9:	b8 08 a0 05 00       	mov    $0x5a008,%eax
   40eae:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40eb2:	72 0a                	jb     40ebe <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40eb4:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40ebb:	00 
   40ebc:	75 09                	jne    40ec7 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40ebe:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40ec5:	eb 07                	jmp    40ece <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40ec7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40ece:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ed2:	48 c1 e8 0c          	shr    $0xc,%rax
   40ed6:	89 c1                	mov    %eax,%ecx
   40ed8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40edb:	89 c2                	mov    %eax,%edx
   40edd:	48 63 c1             	movslq %ecx,%rax
   40ee0:	88 94 00 40 1e 05 00 	mov    %dl,0x51e40(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40ee7:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40eeb:	0f 95 c2             	setne  %dl
   40eee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ef2:	48 c1 e8 0c          	shr    $0xc,%rax
   40ef6:	48 98                	cltq   
   40ef8:	88 94 00 41 1e 05 00 	mov    %dl,0x51e41(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40eff:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40f06:	00 
   40f07:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40f0e:	00 
   40f0f:	0f 86 71 ff ff ff    	jbe    40e86 <pageinfo_init+0x15>
    }
}
   40f15:	90                   	nop
   40f16:	90                   	nop
   40f17:	c9                   	leave  
   40f18:	c3                   	ret    

0000000000040f19 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40f19:	55                   	push   %rbp
   40f1a:	48 89 e5             	mov    %rsp,%rbp
   40f1d:	48 83 ec 50          	sub    $0x50,%rsp
   40f21:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40f25:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40f29:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40f2f:	48 89 c2             	mov    %rax,%rdx
   40f32:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40f36:	48 39 c2             	cmp    %rax,%rdx
   40f39:	74 14                	je     40f4f <check_page_table_mappings+0x36>
   40f3b:	ba f0 44 04 00       	mov    $0x444f0,%edx
   40f40:	be 06 02 00 00       	mov    $0x206,%esi
   40f45:	bf c0 42 04 00       	mov    $0x442c0,%edi
   40f4a:	e8 09 18 00 00       	call   42758 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40f4f:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40f56:	00 
   40f57:	e9 9a 00 00 00       	jmp    40ff6 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40f5c:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40f60:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40f64:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40f68:	48 89 ce             	mov    %rcx,%rsi
   40f6b:	48 89 c7             	mov    %rax,%rdi
   40f6e:	e8 aa 1e 00 00       	call   42e1d <virtual_memory_lookup>
        if (vam.pa != va) {
   40f73:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40f77:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f7b:	74 27                	je     40fa4 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40f7d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40f81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40f85:	49 89 d0             	mov    %rdx,%r8
   40f88:	48 89 c1             	mov    %rax,%rcx
   40f8b:	ba 0f 45 04 00       	mov    $0x4450f,%edx
   40f90:	be 00 c0 00 00       	mov    $0xc000,%esi
   40f95:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40f9a:	b8 00 00 00 00       	mov    $0x0,%eax
   40f9f:	e8 46 31 00 00       	call   440ea <console_printf>
        }
        assert(vam.pa == va);
   40fa4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40fa8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40fac:	74 14                	je     40fc2 <check_page_table_mappings+0xa9>
   40fae:	ba 19 45 04 00       	mov    $0x44519,%edx
   40fb3:	be 0f 02 00 00       	mov    $0x20f,%esi
   40fb8:	bf c0 42 04 00       	mov    $0x442c0,%edi
   40fbd:	e8 96 17 00 00       	call   42758 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40fc2:	b8 00 50 04 00       	mov    $0x45000,%eax
   40fc7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40fcb:	72 21                	jb     40fee <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40fcd:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40fd0:	48 98                	cltq   
   40fd2:	83 e0 02             	and    $0x2,%eax
   40fd5:	48 85 c0             	test   %rax,%rax
   40fd8:	75 14                	jne    40fee <check_page_table_mappings+0xd5>
   40fda:	ba 26 45 04 00       	mov    $0x44526,%edx
   40fdf:	be 11 02 00 00       	mov    $0x211,%esi
   40fe4:	bf c0 42 04 00       	mov    $0x442c0,%edi
   40fe9:	e8 6a 17 00 00       	call   42758 <assert_fail>
         va += PAGESIZE) {
   40fee:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40ff5:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40ff6:	b8 08 a0 05 00       	mov    $0x5a008,%eax
   40ffb:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40fff:	0f 82 57 ff ff ff    	jb     40f5c <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   41005:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   4100c:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   4100d:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   41011:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   41015:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   41019:	48 89 ce             	mov    %rcx,%rsi
   4101c:	48 89 c7             	mov    %rax,%rdi
   4101f:	e8 f9 1d 00 00       	call   42e1d <virtual_memory_lookup>
    assert(vam.pa == kstack);
   41024:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41028:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   4102c:	74 14                	je     41042 <check_page_table_mappings+0x129>
   4102e:	ba 37 45 04 00       	mov    $0x44537,%edx
   41033:	be 18 02 00 00       	mov    $0x218,%esi
   41038:	bf c0 42 04 00       	mov    $0x442c0,%edi
   4103d:	e8 16 17 00 00       	call   42758 <assert_fail>
    assert(vam.perm & PTE_W);
   41042:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41045:	48 98                	cltq   
   41047:	83 e0 02             	and    $0x2,%eax
   4104a:	48 85 c0             	test   %rax,%rax
   4104d:	75 14                	jne    41063 <check_page_table_mappings+0x14a>
   4104f:	ba 26 45 04 00       	mov    $0x44526,%edx
   41054:	be 19 02 00 00       	mov    $0x219,%esi
   41059:	bf c0 42 04 00       	mov    $0x442c0,%edi
   4105e:	e8 f5 16 00 00       	call   42758 <assert_fail>
}
   41063:	90                   	nop
   41064:	c9                   	leave  
   41065:	c3                   	ret    

0000000000041066 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   41066:	55                   	push   %rbp
   41067:	48 89 e5             	mov    %rsp,%rbp
   4106a:	48 83 ec 20          	sub    $0x20,%rsp
   4106e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41072:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   41075:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41078:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   4107b:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   41082:	48 8b 05 77 2f 01 00 	mov    0x12f77(%rip),%rax        # 54000 <kernel_pagetable>
   41089:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   4108d:	75 67                	jne    410f6 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   4108f:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   41096:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   4109d:	eb 51                	jmp    410f0 <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   4109f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   410a2:	48 63 d0             	movslq %eax,%rdx
   410a5:	48 89 d0             	mov    %rdx,%rax
   410a8:	48 c1 e0 03          	shl    $0x3,%rax
   410ac:	48 29 d0             	sub    %rdx,%rax
   410af:	48 c1 e0 05          	shl    $0x5,%rax
   410b3:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   410b9:	8b 00                	mov    (%rax),%eax
   410bb:	85 c0                	test   %eax,%eax
   410bd:	74 2d                	je     410ec <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   410bf:	8b 45 f4             	mov    -0xc(%rbp),%eax
   410c2:	48 63 d0             	movslq %eax,%rdx
   410c5:	48 89 d0             	mov    %rdx,%rax
   410c8:	48 c1 e0 03          	shl    $0x3,%rax
   410cc:	48 29 d0             	sub    %rdx,%rax
   410cf:	48 c1 e0 05          	shl    $0x5,%rax
   410d3:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   410d9:	48 8b 10             	mov    (%rax),%rdx
   410dc:	48 8b 05 1d 2f 01 00 	mov    0x12f1d(%rip),%rax        # 54000 <kernel_pagetable>
   410e3:	48 39 c2             	cmp    %rax,%rdx
   410e6:	75 04                	jne    410ec <check_page_table_ownership+0x86>
                ++expected_refcount;
   410e8:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   410ec:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   410f0:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   410f4:	7e a9                	jle    4109f <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   410f6:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   410f9:	8b 55 fc             	mov    -0x4(%rbp),%edx
   410fc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41100:	be 00 00 00 00       	mov    $0x0,%esi
   41105:	48 89 c7             	mov    %rax,%rdi
   41108:	e8 03 00 00 00       	call   41110 <check_page_table_ownership_level>
}
   4110d:	90                   	nop
   4110e:	c9                   	leave  
   4110f:	c3                   	ret    

0000000000041110 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   41110:	55                   	push   %rbp
   41111:	48 89 e5             	mov    %rsp,%rbp
   41114:	48 83 ec 30          	sub    $0x30,%rsp
   41118:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4111c:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   4111f:	89 55 e0             	mov    %edx,-0x20(%rbp)
   41122:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   41125:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41129:	48 c1 e8 0c          	shr    $0xc,%rax
   4112d:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   41132:	7e 14                	jle    41148 <check_page_table_ownership_level+0x38>
   41134:	ba 48 45 04 00       	mov    $0x44548,%edx
   41139:	be 36 02 00 00       	mov    $0x236,%esi
   4113e:	bf c0 42 04 00       	mov    $0x442c0,%edi
   41143:	e8 10 16 00 00       	call   42758 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   41148:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4114c:	48 c1 e8 0c          	shr    $0xc,%rax
   41150:	48 98                	cltq   
   41152:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   41159:	00 
   4115a:	0f be c0             	movsbl %al,%eax
   4115d:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   41160:	74 14                	je     41176 <check_page_table_ownership_level+0x66>
   41162:	ba 60 45 04 00       	mov    $0x44560,%edx
   41167:	be 37 02 00 00       	mov    $0x237,%esi
   4116c:	bf c0 42 04 00       	mov    $0x442c0,%edi
   41171:	e8 e2 15 00 00       	call   42758 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   41176:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4117a:	48 c1 e8 0c          	shr    $0xc,%rax
   4117e:	48 98                	cltq   
   41180:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   41187:	00 
   41188:	0f be c0             	movsbl %al,%eax
   4118b:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   4118e:	74 14                	je     411a4 <check_page_table_ownership_level+0x94>
   41190:	ba 88 45 04 00       	mov    $0x44588,%edx
   41195:	be 38 02 00 00       	mov    $0x238,%esi
   4119a:	bf c0 42 04 00       	mov    $0x442c0,%edi
   4119f:	e8 b4 15 00 00       	call   42758 <assert_fail>
    if (level < 3) {
   411a4:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   411a8:	7f 5b                	jg     41205 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   411aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   411b1:	eb 49                	jmp    411fc <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   411b3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   411b7:	8b 55 fc             	mov    -0x4(%rbp),%edx
   411ba:	48 63 d2             	movslq %edx,%rdx
   411bd:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   411c1:	48 85 c0             	test   %rax,%rax
   411c4:	74 32                	je     411f8 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   411c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   411ca:	8b 55 fc             	mov    -0x4(%rbp),%edx
   411cd:	48 63 d2             	movslq %edx,%rdx
   411d0:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   411d4:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   411da:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   411de:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   411e1:	8d 70 01             	lea    0x1(%rax),%esi
   411e4:	8b 55 e0             	mov    -0x20(%rbp),%edx
   411e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   411eb:	b9 01 00 00 00       	mov    $0x1,%ecx
   411f0:	48 89 c7             	mov    %rax,%rdi
   411f3:	e8 18 ff ff ff       	call   41110 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   411f8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   411fc:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41203:	7e ae                	jle    411b3 <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   41205:	90                   	nop
   41206:	c9                   	leave  
   41207:	c3                   	ret    

0000000000041208 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   41208:	55                   	push   %rbp
   41209:	48 89 e5             	mov    %rsp,%rbp
   4120c:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   41210:	8b 05 d2 fe 00 00    	mov    0xfed2(%rip),%eax        # 510e8 <processes+0xc8>
   41216:	85 c0                	test   %eax,%eax
   41218:	74 14                	je     4122e <check_virtual_memory+0x26>
   4121a:	ba b8 45 04 00       	mov    $0x445b8,%edx
   4121f:	be 4b 02 00 00       	mov    $0x24b,%esi
   41224:	bf c0 42 04 00       	mov    $0x442c0,%edi
   41229:	e8 2a 15 00 00       	call   42758 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   4122e:	48 8b 05 cb 2d 01 00 	mov    0x12dcb(%rip),%rax        # 54000 <kernel_pagetable>
   41235:	48 89 c7             	mov    %rax,%rdi
   41238:	e8 dc fc ff ff       	call   40f19 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   4123d:	48 8b 05 bc 2d 01 00 	mov    0x12dbc(%rip),%rax        # 54000 <kernel_pagetable>
   41244:	be ff ff ff ff       	mov    $0xffffffff,%esi
   41249:	48 89 c7             	mov    %rax,%rdi
   4124c:	e8 15 fe ff ff       	call   41066 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   41251:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41258:	e9 9c 00 00 00       	jmp    412f9 <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   4125d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41260:	48 63 d0             	movslq %eax,%rdx
   41263:	48 89 d0             	mov    %rdx,%rax
   41266:	48 c1 e0 03          	shl    $0x3,%rax
   4126a:	48 29 d0             	sub    %rdx,%rax
   4126d:	48 c1 e0 05          	shl    $0x5,%rax
   41271:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   41277:	8b 00                	mov    (%rax),%eax
   41279:	85 c0                	test   %eax,%eax
   4127b:	74 78                	je     412f5 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   4127d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41280:	48 63 d0             	movslq %eax,%rdx
   41283:	48 89 d0             	mov    %rdx,%rax
   41286:	48 c1 e0 03          	shl    $0x3,%rax
   4128a:	48 29 d0             	sub    %rdx,%rax
   4128d:	48 c1 e0 05          	shl    $0x5,%rax
   41291:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   41297:	48 8b 10             	mov    (%rax),%rdx
   4129a:	48 8b 05 5f 2d 01 00 	mov    0x12d5f(%rip),%rax        # 54000 <kernel_pagetable>
   412a1:	48 39 c2             	cmp    %rax,%rdx
   412a4:	74 4f                	je     412f5 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   412a6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412a9:	48 63 d0             	movslq %eax,%rdx
   412ac:	48 89 d0             	mov    %rdx,%rax
   412af:	48 c1 e0 03          	shl    $0x3,%rax
   412b3:	48 29 d0             	sub    %rdx,%rax
   412b6:	48 c1 e0 05          	shl    $0x5,%rax
   412ba:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   412c0:	48 8b 00             	mov    (%rax),%rax
   412c3:	48 89 c7             	mov    %rax,%rdi
   412c6:	e8 4e fc ff ff       	call   40f19 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   412cb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412ce:	48 63 d0             	movslq %eax,%rdx
   412d1:	48 89 d0             	mov    %rdx,%rax
   412d4:	48 c1 e0 03          	shl    $0x3,%rax
   412d8:	48 29 d0             	sub    %rdx,%rax
   412db:	48 c1 e0 05          	shl    $0x5,%rax
   412df:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   412e5:	48 8b 00             	mov    (%rax),%rax
   412e8:	8b 55 fc             	mov    -0x4(%rbp),%edx
   412eb:	89 d6                	mov    %edx,%esi
   412ed:	48 89 c7             	mov    %rax,%rdi
   412f0:	e8 71 fd ff ff       	call   41066 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   412f5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   412f9:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   412fd:	0f 8e 5a ff ff ff    	jle    4125d <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41303:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   4130a:	eb 67                	jmp    41373 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   4130c:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4130f:	48 98                	cltq   
   41311:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   41318:	00 
   41319:	84 c0                	test   %al,%al
   4131b:	7e 52                	jle    4136f <check_virtual_memory+0x167>
   4131d:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41320:	48 98                	cltq   
   41322:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   41329:	00 
   4132a:	84 c0                	test   %al,%al
   4132c:	78 41                	js     4136f <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   4132e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41331:	48 98                	cltq   
   41333:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   4133a:	00 
   4133b:	0f be c0             	movsbl %al,%eax
   4133e:	48 63 d0             	movslq %eax,%rdx
   41341:	48 89 d0             	mov    %rdx,%rax
   41344:	48 c1 e0 03          	shl    $0x3,%rax
   41348:	48 29 d0             	sub    %rdx,%rax
   4134b:	48 c1 e0 05          	shl    $0x5,%rax
   4134f:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   41355:	8b 00                	mov    (%rax),%eax
   41357:	85 c0                	test   %eax,%eax
   41359:	75 14                	jne    4136f <check_virtual_memory+0x167>
   4135b:	ba d8 45 04 00       	mov    $0x445d8,%edx
   41360:	be 62 02 00 00       	mov    $0x262,%esi
   41365:	bf c0 42 04 00       	mov    $0x442c0,%edi
   4136a:	e8 e9 13 00 00       	call   42758 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4136f:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41373:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   4137a:	7e 90                	jle    4130c <check_virtual_memory+0x104>
        }
    }
}
   4137c:	90                   	nop
   4137d:	90                   	nop
   4137e:	c9                   	leave  
   4137f:	c3                   	ret    

0000000000041380 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   41380:	55                   	push   %rbp
   41381:	48 89 e5             	mov    %rsp,%rbp
   41384:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   41388:	ba 46 46 04 00       	mov    $0x44646,%edx
   4138d:	be 00 0f 00 00       	mov    $0xf00,%esi
   41392:	bf 20 00 00 00       	mov    $0x20,%edi
   41397:	b8 00 00 00 00       	mov    $0x0,%eax
   4139c:	e8 49 2d 00 00       	call   440ea <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   413a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   413a8:	e9 f8 00 00 00       	jmp    414a5 <memshow_physical+0x125>
        if (pn % 64 == 0) {
   413ad:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413b0:	83 e0 3f             	and    $0x3f,%eax
   413b3:	85 c0                	test   %eax,%eax
   413b5:	75 3c                	jne    413f3 <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   413b7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413ba:	c1 e0 0c             	shl    $0xc,%eax
   413bd:	89 c1                	mov    %eax,%ecx
   413bf:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413c2:	8d 50 3f             	lea    0x3f(%rax),%edx
   413c5:	85 c0                	test   %eax,%eax
   413c7:	0f 48 c2             	cmovs  %edx,%eax
   413ca:	c1 f8 06             	sar    $0x6,%eax
   413cd:	8d 50 01             	lea    0x1(%rax),%edx
   413d0:	89 d0                	mov    %edx,%eax
   413d2:	c1 e0 02             	shl    $0x2,%eax
   413d5:	01 d0                	add    %edx,%eax
   413d7:	c1 e0 04             	shl    $0x4,%eax
   413da:	83 c0 03             	add    $0x3,%eax
   413dd:	ba 56 46 04 00       	mov    $0x44656,%edx
   413e2:	be 00 0f 00 00       	mov    $0xf00,%esi
   413e7:	89 c7                	mov    %eax,%edi
   413e9:	b8 00 00 00 00       	mov    $0x0,%eax
   413ee:	e8 f7 2c 00 00       	call   440ea <console_printf>
        }

        int owner = pageinfo[pn].owner;
   413f3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413f6:	48 98                	cltq   
   413f8:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   413ff:	00 
   41400:	0f be c0             	movsbl %al,%eax
   41403:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41406:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41409:	48 98                	cltq   
   4140b:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   41412:	00 
   41413:	84 c0                	test   %al,%al
   41415:	75 07                	jne    4141e <memshow_physical+0x9e>
            owner = PO_FREE;
   41417:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   4141e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41421:	83 c0 02             	add    $0x2,%eax
   41424:	48 98                	cltq   
   41426:	0f b7 84 00 20 46 04 	movzwl 0x44620(%rax,%rax,1),%eax
   4142d:	00 
   4142e:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41432:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41435:	48 98                	cltq   
   41437:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   4143e:	00 
   4143f:	3c 01                	cmp    $0x1,%al
   41441:	7e 1a                	jle    4145d <memshow_physical+0xdd>
   41443:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41448:	48 c1 e8 0c          	shr    $0xc,%rax
   4144c:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4144f:	74 0c                	je     4145d <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41451:	b8 53 00 00 00       	mov    $0x53,%eax
   41456:	80 cc 0f             	or     $0xf,%ah
   41459:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   4145d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41460:	8d 50 3f             	lea    0x3f(%rax),%edx
   41463:	85 c0                	test   %eax,%eax
   41465:	0f 48 c2             	cmovs  %edx,%eax
   41468:	c1 f8 06             	sar    $0x6,%eax
   4146b:	8d 50 01             	lea    0x1(%rax),%edx
   4146e:	89 d0                	mov    %edx,%eax
   41470:	c1 e0 02             	shl    $0x2,%eax
   41473:	01 d0                	add    %edx,%eax
   41475:	c1 e0 04             	shl    $0x4,%eax
   41478:	89 c1                	mov    %eax,%ecx
   4147a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4147d:	89 d0                	mov    %edx,%eax
   4147f:	c1 f8 1f             	sar    $0x1f,%eax
   41482:	c1 e8 1a             	shr    $0x1a,%eax
   41485:	01 c2                	add    %eax,%edx
   41487:	83 e2 3f             	and    $0x3f,%edx
   4148a:	29 c2                	sub    %eax,%edx
   4148c:	89 d0                	mov    %edx,%eax
   4148e:	83 c0 0c             	add    $0xc,%eax
   41491:	01 c8                	add    %ecx,%eax
   41493:	48 98                	cltq   
   41495:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   41499:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   414a0:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   414a1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   414a5:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   414ac:	0f 8e fb fe ff ff    	jle    413ad <memshow_physical+0x2d>
    }
}
   414b2:	90                   	nop
   414b3:	90                   	nop
   414b4:	c9                   	leave  
   414b5:	c3                   	ret    

00000000000414b6 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   414b6:	55                   	push   %rbp
   414b7:	48 89 e5             	mov    %rsp,%rbp
   414ba:	48 83 ec 40          	sub    $0x40,%rsp
   414be:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   414c2:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   414c6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   414ca:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   414d0:	48 89 c2             	mov    %rax,%rdx
   414d3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   414d7:	48 39 c2             	cmp    %rax,%rdx
   414da:	74 14                	je     414f0 <memshow_virtual+0x3a>
   414dc:	ba 60 46 04 00       	mov    $0x44660,%edx
   414e1:	be 93 02 00 00       	mov    $0x293,%esi
   414e6:	bf c0 42 04 00       	mov    $0x442c0,%edi
   414eb:	e8 68 12 00 00       	call   42758 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   414f0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   414f4:	48 89 c1             	mov    %rax,%rcx
   414f7:	ba 8d 46 04 00       	mov    $0x4468d,%edx
   414fc:	be 00 0f 00 00       	mov    $0xf00,%esi
   41501:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41506:	b8 00 00 00 00       	mov    $0x0,%eax
   4150b:	e8 da 2b 00 00       	call   440ea <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41510:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41517:	00 
   41518:	e9 80 01 00 00       	jmp    4169d <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   4151d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41521:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41525:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41529:	48 89 ce             	mov    %rcx,%rsi
   4152c:	48 89 c7             	mov    %rax,%rdi
   4152f:	e8 e9 18 00 00       	call   42e1d <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41534:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41537:	85 c0                	test   %eax,%eax
   41539:	79 0b                	jns    41546 <memshow_virtual+0x90>
            color = ' ';
   4153b:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41541:	e9 d7 00 00 00       	jmp    4161d <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41546:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4154a:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41550:	76 14                	jbe    41566 <memshow_virtual+0xb0>
   41552:	ba aa 46 04 00       	mov    $0x446aa,%edx
   41557:	be 9c 02 00 00       	mov    $0x29c,%esi
   4155c:	bf c0 42 04 00       	mov    $0x442c0,%edi
   41561:	e8 f2 11 00 00       	call   42758 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41566:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41569:	48 98                	cltq   
   4156b:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   41572:	00 
   41573:	0f be c0             	movsbl %al,%eax
   41576:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41579:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4157c:	48 98                	cltq   
   4157e:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   41585:	00 
   41586:	84 c0                	test   %al,%al
   41588:	75 07                	jne    41591 <memshow_virtual+0xdb>
                owner = PO_FREE;
   4158a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41591:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41594:	83 c0 02             	add    $0x2,%eax
   41597:	48 98                	cltq   
   41599:	0f b7 84 00 20 46 04 	movzwl 0x44620(%rax,%rax,1),%eax
   415a0:	00 
   415a1:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   415a5:	8b 45 e0             	mov    -0x20(%rbp),%eax
   415a8:	48 98                	cltq   
   415aa:	83 e0 04             	and    $0x4,%eax
   415ad:	48 85 c0             	test   %rax,%rax
   415b0:	74 27                	je     415d9 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   415b2:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   415b6:	c1 e0 04             	shl    $0x4,%eax
   415b9:	66 25 00 f0          	and    $0xf000,%ax
   415bd:	89 c2                	mov    %eax,%edx
   415bf:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   415c3:	c1 f8 04             	sar    $0x4,%eax
   415c6:	66 25 00 0f          	and    $0xf00,%ax
   415ca:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   415cc:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   415d0:	0f b6 c0             	movzbl %al,%eax
   415d3:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   415d5:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   415d9:	8b 45 d0             	mov    -0x30(%rbp),%eax
   415dc:	48 98                	cltq   
   415de:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   415e5:	00 
   415e6:	3c 01                	cmp    $0x1,%al
   415e8:	7e 33                	jle    4161d <memshow_virtual+0x167>
   415ea:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   415ef:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   415f3:	74 28                	je     4161d <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   415f5:	b8 53 00 00 00       	mov    $0x53,%eax
   415fa:	89 c2                	mov    %eax,%edx
   415fc:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41600:	66 25 00 f0          	and    $0xf000,%ax
   41604:	09 d0                	or     %edx,%eax
   41606:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   4160a:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4160d:	48 98                	cltq   
   4160f:	83 e0 04             	and    $0x4,%eax
   41612:	48 85 c0             	test   %rax,%rax
   41615:	75 06                	jne    4161d <memshow_virtual+0x167>
                    color = color | 0x0F00;
   41617:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   4161d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41621:	48 c1 e8 0c          	shr    $0xc,%rax
   41625:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41628:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4162b:	83 e0 3f             	and    $0x3f,%eax
   4162e:	85 c0                	test   %eax,%eax
   41630:	75 34                	jne    41666 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41632:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41635:	c1 e8 06             	shr    $0x6,%eax
   41638:	89 c2                	mov    %eax,%edx
   4163a:	89 d0                	mov    %edx,%eax
   4163c:	c1 e0 02             	shl    $0x2,%eax
   4163f:	01 d0                	add    %edx,%eax
   41641:	c1 e0 04             	shl    $0x4,%eax
   41644:	05 73 03 00 00       	add    $0x373,%eax
   41649:	89 c7                	mov    %eax,%edi
   4164b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4164f:	48 89 c1             	mov    %rax,%rcx
   41652:	ba 56 46 04 00       	mov    $0x44656,%edx
   41657:	be 00 0f 00 00       	mov    $0xf00,%esi
   4165c:	b8 00 00 00 00       	mov    $0x0,%eax
   41661:	e8 84 2a 00 00       	call   440ea <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41666:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41669:	c1 e8 06             	shr    $0x6,%eax
   4166c:	89 c2                	mov    %eax,%edx
   4166e:	89 d0                	mov    %edx,%eax
   41670:	c1 e0 02             	shl    $0x2,%eax
   41673:	01 d0                	add    %edx,%eax
   41675:	c1 e0 04             	shl    $0x4,%eax
   41678:	89 c2                	mov    %eax,%edx
   4167a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4167d:	83 e0 3f             	and    $0x3f,%eax
   41680:	01 d0                	add    %edx,%eax
   41682:	05 7c 03 00 00       	add    $0x37c,%eax
   41687:	89 c2                	mov    %eax,%edx
   41689:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4168d:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   41694:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41695:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4169c:	00 
   4169d:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   416a4:	00 
   416a5:	0f 86 72 fe ff ff    	jbe    4151d <memshow_virtual+0x67>
    }
}
   416ab:	90                   	nop
   416ac:	90                   	nop
   416ad:	c9                   	leave  
   416ae:	c3                   	ret    

00000000000416af <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   416af:	55                   	push   %rbp
   416b0:	48 89 e5             	mov    %rsp,%rbp
   416b3:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   416b7:	8b 05 83 0b 01 00    	mov    0x10b83(%rip),%eax        # 52240 <last_ticks.1>
   416bd:	85 c0                	test   %eax,%eax
   416bf:	74 13                	je     416d4 <memshow_virtual_animate+0x25>
   416c1:	8b 15 59 07 01 00    	mov    0x10759(%rip),%edx        # 51e20 <ticks>
   416c7:	8b 05 73 0b 01 00    	mov    0x10b73(%rip),%eax        # 52240 <last_ticks.1>
   416cd:	29 c2                	sub    %eax,%edx
   416cf:	83 fa 31             	cmp    $0x31,%edx
   416d2:	76 2c                	jbe    41700 <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   416d4:	8b 05 46 07 01 00    	mov    0x10746(%rip),%eax        # 51e20 <ticks>
   416da:	89 05 60 0b 01 00    	mov    %eax,0x10b60(%rip)        # 52240 <last_ticks.1>
        ++showing;
   416e0:	8b 05 1e 39 00 00    	mov    0x391e(%rip),%eax        # 45004 <showing.0>
   416e6:	83 c0 01             	add    $0x1,%eax
   416e9:	89 05 15 39 00 00    	mov    %eax,0x3915(%rip)        # 45004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   416ef:	eb 0f                	jmp    41700 <memshow_virtual_animate+0x51>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   416f1:	8b 05 0d 39 00 00    	mov    0x390d(%rip),%eax        # 45004 <showing.0>
   416f7:	83 c0 01             	add    $0x1,%eax
   416fa:	89 05 04 39 00 00    	mov    %eax,0x3904(%rip)        # 45004 <showing.0>
    while (showing <= 2*NPROC
   41700:	8b 05 fe 38 00 00    	mov    0x38fe(%rip),%eax        # 45004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   41706:	83 f8 20             	cmp    $0x20,%eax
   41709:	7f 6d                	jg     41778 <memshow_virtual_animate+0xc9>
   4170b:	8b 15 f3 38 00 00    	mov    0x38f3(%rip),%edx        # 45004 <showing.0>
   41711:	89 d0                	mov    %edx,%eax
   41713:	c1 f8 1f             	sar    $0x1f,%eax
   41716:	c1 e8 1c             	shr    $0x1c,%eax
   41719:	01 c2                	add    %eax,%edx
   4171b:	83 e2 0f             	and    $0xf,%edx
   4171e:	29 c2                	sub    %eax,%edx
   41720:	89 d0                	mov    %edx,%eax
   41722:	48 63 d0             	movslq %eax,%rdx
   41725:	48 89 d0             	mov    %rdx,%rax
   41728:	48 c1 e0 03          	shl    $0x3,%rax
   4172c:	48 29 d0             	sub    %rdx,%rax
   4172f:	48 c1 e0 05          	shl    $0x5,%rax
   41733:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   41739:	8b 00                	mov    (%rax),%eax
   4173b:	85 c0                	test   %eax,%eax
   4173d:	74 b2                	je     416f1 <memshow_virtual_animate+0x42>
   4173f:	8b 15 bf 38 00 00    	mov    0x38bf(%rip),%edx        # 45004 <showing.0>
   41745:	89 d0                	mov    %edx,%eax
   41747:	c1 f8 1f             	sar    $0x1f,%eax
   4174a:	c1 e8 1c             	shr    $0x1c,%eax
   4174d:	01 c2                	add    %eax,%edx
   4174f:	83 e2 0f             	and    $0xf,%edx
   41752:	29 c2                	sub    %eax,%edx
   41754:	89 d0                	mov    %edx,%eax
   41756:	48 63 d0             	movslq %eax,%rdx
   41759:	48 89 d0             	mov    %rdx,%rax
   4175c:	48 c1 e0 03          	shl    $0x3,%rax
   41760:	48 29 d0             	sub    %rdx,%rax
   41763:	48 c1 e0 05          	shl    $0x5,%rax
   41767:	48 05 f8 10 05 00    	add    $0x510f8,%rax
   4176d:	0f b6 00             	movzbl (%rax),%eax
   41770:	84 c0                	test   %al,%al
   41772:	0f 84 79 ff ff ff    	je     416f1 <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   41778:	8b 15 86 38 00 00    	mov    0x3886(%rip),%edx        # 45004 <showing.0>
   4177e:	89 d0                	mov    %edx,%eax
   41780:	c1 f8 1f             	sar    $0x1f,%eax
   41783:	c1 e8 1c             	shr    $0x1c,%eax
   41786:	01 c2                	add    %eax,%edx
   41788:	83 e2 0f             	and    $0xf,%edx
   4178b:	29 c2                	sub    %eax,%edx
   4178d:	89 d0                	mov    %edx,%eax
   4178f:	89 05 6f 38 00 00    	mov    %eax,0x386f(%rip)        # 45004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41795:	8b 05 69 38 00 00    	mov    0x3869(%rip),%eax        # 45004 <showing.0>
   4179b:	48 63 d0             	movslq %eax,%rdx
   4179e:	48 89 d0             	mov    %rdx,%rax
   417a1:	48 c1 e0 03          	shl    $0x3,%rax
   417a5:	48 29 d0             	sub    %rdx,%rax
   417a8:	48 c1 e0 05          	shl    $0x5,%rax
   417ac:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   417b2:	8b 00                	mov    (%rax),%eax
   417b4:	85 c0                	test   %eax,%eax
   417b6:	74 52                	je     4180a <memshow_virtual_animate+0x15b>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   417b8:	8b 15 46 38 00 00    	mov    0x3846(%rip),%edx        # 45004 <showing.0>
   417be:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   417c2:	89 d1                	mov    %edx,%ecx
   417c4:	ba c4 46 04 00       	mov    $0x446c4,%edx
   417c9:	be 04 00 00 00       	mov    $0x4,%esi
   417ce:	48 89 c7             	mov    %rax,%rdi
   417d1:	b8 00 00 00 00       	mov    $0x0,%eax
   417d6:	e8 1b 2a 00 00       	call   441f6 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   417db:	8b 05 23 38 00 00    	mov    0x3823(%rip),%eax        # 45004 <showing.0>
   417e1:	48 63 d0             	movslq %eax,%rdx
   417e4:	48 89 d0             	mov    %rdx,%rax
   417e7:	48 c1 e0 03          	shl    $0x3,%rax
   417eb:	48 29 d0             	sub    %rdx,%rax
   417ee:	48 c1 e0 05          	shl    $0x5,%rax
   417f2:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   417f8:	48 8b 00             	mov    (%rax),%rax
   417fb:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   417ff:	48 89 d6             	mov    %rdx,%rsi
   41802:	48 89 c7             	mov    %rax,%rdi
   41805:	e8 ac fc ff ff       	call   414b6 <memshow_virtual>
    }
}
   4180a:	90                   	nop
   4180b:	c9                   	leave  
   4180c:	c3                   	ret    

000000000004180d <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   4180d:	55                   	push   %rbp
   4180e:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41811:	e8 4f 01 00 00       	call   41965 <segments_init>
    interrupt_init();
   41816:	e8 d0 03 00 00       	call   41beb <interrupt_init>
    virtual_memory_init();
   4181b:	e8 f3 0f 00 00       	call   42813 <virtual_memory_init>
}
   41820:	90                   	nop
   41821:	5d                   	pop    %rbp
   41822:	c3                   	ret    

0000000000041823 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41823:	55                   	push   %rbp
   41824:	48 89 e5             	mov    %rsp,%rbp
   41827:	48 83 ec 18          	sub    $0x18,%rsp
   4182b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4182f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41833:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41836:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41839:	48 98                	cltq   
   4183b:	48 c1 e0 2d          	shl    $0x2d,%rax
   4183f:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41843:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   4184a:	90 00 00 
   4184d:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41850:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41854:	48 89 10             	mov    %rdx,(%rax)
}
   41857:	90                   	nop
   41858:	c9                   	leave  
   41859:	c3                   	ret    

000000000004185a <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   4185a:	55                   	push   %rbp
   4185b:	48 89 e5             	mov    %rsp,%rbp
   4185e:	48 83 ec 28          	sub    $0x28,%rsp
   41862:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41866:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4186a:	89 55 ec             	mov    %edx,-0x14(%rbp)
   4186d:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41871:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41875:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41879:	48 c1 e0 10          	shl    $0x10,%rax
   4187d:	48 89 c2             	mov    %rax,%rdx
   41880:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41887:	00 00 00 
   4188a:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   4188d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41891:	48 c1 e0 20          	shl    $0x20,%rax
   41895:	48 89 c1             	mov    %rax,%rcx
   41898:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   4189f:	00 00 ff 
   418a2:	48 21 c8             	and    %rcx,%rax
   418a5:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   418a8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   418ac:	48 83 e8 01          	sub    $0x1,%rax
   418b0:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   418b3:	48 09 d0             	or     %rdx,%rax
        | type
   418b6:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   418ba:	8b 55 ec             	mov    -0x14(%rbp),%edx
   418bd:	48 63 d2             	movslq %edx,%rdx
   418c0:	48 c1 e2 2d          	shl    $0x2d,%rdx
   418c4:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   418c7:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   418ce:	80 00 00 
   418d1:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   418d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   418d8:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   418db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   418df:	48 83 c0 08          	add    $0x8,%rax
   418e3:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   418e7:	48 c1 ea 20          	shr    $0x20,%rdx
   418eb:	48 89 10             	mov    %rdx,(%rax)
}
   418ee:	90                   	nop
   418ef:	c9                   	leave  
   418f0:	c3                   	ret    

00000000000418f1 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   418f1:	55                   	push   %rbp
   418f2:	48 89 e5             	mov    %rsp,%rbp
   418f5:	48 83 ec 20          	sub    $0x20,%rsp
   418f9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   418fd:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41901:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41904:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41908:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4190c:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   4190f:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41913:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41916:	48 63 d2             	movslq %edx,%rdx
   41919:	48 c1 e2 2d          	shl    $0x2d,%rdx
   4191d:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41920:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41924:	48 c1 e0 20          	shl    $0x20,%rax
   41928:	48 89 c1             	mov    %rax,%rcx
   4192b:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41932:	00 ff ff 
   41935:	48 21 c8             	and    %rcx,%rax
   41938:	48 09 c2             	or     %rax,%rdx
   4193b:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41942:	80 00 00 
   41945:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41948:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4194c:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   4194f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41953:	48 c1 e8 20          	shr    $0x20,%rax
   41957:	48 89 c2             	mov    %rax,%rdx
   4195a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4195e:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41962:	90                   	nop
   41963:	c9                   	leave  
   41964:	c3                   	ret    

0000000000041965 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41965:	55                   	push   %rbp
   41966:	48 89 e5             	mov    %rsp,%rbp
   41969:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   4196d:	48 c7 05 e8 08 01 00 	movq   $0x0,0x108e8(%rip)        # 52260 <segments>
   41974:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41978:	ba 00 00 00 00       	mov    $0x0,%edx
   4197d:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41984:	08 20 00 
   41987:	48 89 c6             	mov    %rax,%rsi
   4198a:	bf 68 22 05 00       	mov    $0x52268,%edi
   4198f:	e8 8f fe ff ff       	call   41823 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41994:	ba 03 00 00 00       	mov    $0x3,%edx
   41999:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   419a0:	08 20 00 
   419a3:	48 89 c6             	mov    %rax,%rsi
   419a6:	bf 70 22 05 00       	mov    $0x52270,%edi
   419ab:	e8 73 fe ff ff       	call   41823 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   419b0:	ba 00 00 00 00       	mov    $0x0,%edx
   419b5:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   419bc:	02 00 00 
   419bf:	48 89 c6             	mov    %rax,%rsi
   419c2:	bf 78 22 05 00       	mov    $0x52278,%edi
   419c7:	e8 57 fe ff ff       	call   41823 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   419cc:	ba 03 00 00 00       	mov    $0x3,%edx
   419d1:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   419d8:	02 00 00 
   419db:	48 89 c6             	mov    %rax,%rsi
   419de:	bf 80 22 05 00       	mov    $0x52280,%edi
   419e3:	e8 3b fe ff ff       	call   41823 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   419e8:	b8 a0 32 05 00       	mov    $0x532a0,%eax
   419ed:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   419f3:	48 89 c1             	mov    %rax,%rcx
   419f6:	ba 00 00 00 00       	mov    $0x0,%edx
   419fb:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41a02:	09 00 00 
   41a05:	48 89 c6             	mov    %rax,%rsi
   41a08:	bf 88 22 05 00       	mov    $0x52288,%edi
   41a0d:	e8 48 fe ff ff       	call   4185a <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41a12:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41a18:	b8 60 22 05 00       	mov    $0x52260,%eax
   41a1d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41a21:	ba 60 00 00 00       	mov    $0x60,%edx
   41a26:	be 00 00 00 00       	mov    $0x0,%esi
   41a2b:	bf a0 32 05 00       	mov    $0x532a0,%edi
   41a30:	e8 fe 18 00 00       	call   43333 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41a35:	48 c7 05 64 18 01 00 	movq   $0x80000,0x11864(%rip)        # 532a4 <kernel_task_descriptor+0x4>
   41a3c:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41a40:	ba 00 10 00 00       	mov    $0x1000,%edx
   41a45:	be 00 00 00 00       	mov    $0x0,%esi
   41a4a:	bf a0 22 05 00       	mov    $0x522a0,%edi
   41a4f:	e8 df 18 00 00       	call   43333 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41a54:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41a5b:	eb 30                	jmp    41a8d <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41a5d:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41a62:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a65:	48 c1 e0 04          	shl    $0x4,%rax
   41a69:	48 05 a0 22 05 00    	add    $0x522a0,%rax
   41a6f:	48 89 d1             	mov    %rdx,%rcx
   41a72:	ba 00 00 00 00       	mov    $0x0,%edx
   41a77:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41a7e:	0e 00 00 
   41a81:	48 89 c7             	mov    %rax,%rdi
   41a84:	e8 68 fe ff ff       	call   418f1 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41a89:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41a8d:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41a94:	76 c7                	jbe    41a5d <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41a96:	b8 36 00 04 00       	mov    $0x40036,%eax
   41a9b:	48 89 c1             	mov    %rax,%rcx
   41a9e:	ba 00 00 00 00       	mov    $0x0,%edx
   41aa3:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41aaa:	0e 00 00 
   41aad:	48 89 c6             	mov    %rax,%rsi
   41ab0:	bf a0 24 05 00       	mov    $0x524a0,%edi
   41ab5:	e8 37 fe ff ff       	call   418f1 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41aba:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   41abf:	48 89 c1             	mov    %rax,%rcx
   41ac2:	ba 00 00 00 00       	mov    $0x0,%edx
   41ac7:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41ace:	0e 00 00 
   41ad1:	48 89 c6             	mov    %rax,%rsi
   41ad4:	bf 70 23 05 00       	mov    $0x52370,%edi
   41ad9:	e8 13 fe ff ff       	call   418f1 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41ade:	b8 32 00 04 00       	mov    $0x40032,%eax
   41ae3:	48 89 c1             	mov    %rax,%rcx
   41ae6:	ba 00 00 00 00       	mov    $0x0,%edx
   41aeb:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41af2:	0e 00 00 
   41af5:	48 89 c6             	mov    %rax,%rsi
   41af8:	bf 80 23 05 00       	mov    $0x52380,%edi
   41afd:	e8 ef fd ff ff       	call   418f1 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41b02:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41b09:	eb 3e                	jmp    41b49 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41b0b:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41b0e:	83 e8 30             	sub    $0x30,%eax
   41b11:	89 c0                	mov    %eax,%eax
   41b13:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41b1a:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41b1b:	48 89 c2             	mov    %rax,%rdx
   41b1e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41b21:	48 c1 e0 04          	shl    $0x4,%rax
   41b25:	48 05 a0 22 05 00    	add    $0x522a0,%rax
   41b2b:	48 89 d1             	mov    %rdx,%rcx
   41b2e:	ba 03 00 00 00       	mov    $0x3,%edx
   41b33:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41b3a:	0e 00 00 
   41b3d:	48 89 c7             	mov    %rax,%rdi
   41b40:	e8 ac fd ff ff       	call   418f1 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41b45:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41b49:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41b4d:	76 bc                	jbe    41b0b <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41b4f:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41b55:	b8 a0 22 05 00       	mov    $0x522a0,%eax
   41b5a:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41b5e:	b8 28 00 00 00       	mov    $0x28,%eax
   41b63:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41b67:	0f 00 d8             	ltr    %ax
   41b6a:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41b6e:	0f 20 c0             	mov    %cr0,%rax
   41b71:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41b75:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41b79:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41b7c:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41b83:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41b86:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41b89:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41b8c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41b90:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41b94:	0f 22 c0             	mov    %rax,%cr0
}
   41b97:	90                   	nop
    lcr0(cr0);
}
   41b98:	90                   	nop
   41b99:	c9                   	leave  
   41b9a:	c3                   	ret    

0000000000041b9b <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41b9b:	55                   	push   %rbp
   41b9c:	48 89 e5             	mov    %rsp,%rbp
   41b9f:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41ba3:	0f b7 05 56 17 01 00 	movzwl 0x11756(%rip),%eax        # 53300 <interrupts_enabled>
   41baa:	f7 d0                	not    %eax
   41bac:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41bb0:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41bb4:	0f b6 c0             	movzbl %al,%eax
   41bb7:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41bbe:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bc1:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41bc5:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41bc8:	ee                   	out    %al,(%dx)
}
   41bc9:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41bca:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41bce:	66 c1 e8 08          	shr    $0x8,%ax
   41bd2:	0f b6 c0             	movzbl %al,%eax
   41bd5:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41bdc:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bdf:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41be3:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41be6:	ee                   	out    %al,(%dx)
}
   41be7:	90                   	nop
}
   41be8:	90                   	nop
   41be9:	c9                   	leave  
   41bea:	c3                   	ret    

0000000000041beb <interrupt_init>:

void interrupt_init(void) {
   41beb:	55                   	push   %rbp
   41bec:	48 89 e5             	mov    %rsp,%rbp
   41bef:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41bf3:	66 c7 05 04 17 01 00 	movw   $0x0,0x11704(%rip)        # 53300 <interrupts_enabled>
   41bfa:	00 00 
    interrupt_mask();
   41bfc:	e8 9a ff ff ff       	call   41b9b <interrupt_mask>
   41c01:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41c08:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c0c:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41c10:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41c13:	ee                   	out    %al,(%dx)
}
   41c14:	90                   	nop
   41c15:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41c1c:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c20:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41c24:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41c27:	ee                   	out    %al,(%dx)
}
   41c28:	90                   	nop
   41c29:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41c30:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c34:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41c38:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41c3b:	ee                   	out    %al,(%dx)
}
   41c3c:	90                   	nop
   41c3d:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41c44:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c48:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41c4c:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41c4f:	ee                   	out    %al,(%dx)
}
   41c50:	90                   	nop
   41c51:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41c58:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c5c:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41c60:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41c63:	ee                   	out    %al,(%dx)
}
   41c64:	90                   	nop
   41c65:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41c6c:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c70:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41c74:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41c77:	ee                   	out    %al,(%dx)
}
   41c78:	90                   	nop
   41c79:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41c80:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c84:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41c88:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41c8b:	ee                   	out    %al,(%dx)
}
   41c8c:	90                   	nop
   41c8d:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41c94:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c98:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41c9c:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41c9f:	ee                   	out    %al,(%dx)
}
   41ca0:	90                   	nop
   41ca1:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41ca8:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cac:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41cb0:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41cb3:	ee                   	out    %al,(%dx)
}
   41cb4:	90                   	nop
   41cb5:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41cbc:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cc0:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41cc4:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41cc7:	ee                   	out    %al,(%dx)
}
   41cc8:	90                   	nop
   41cc9:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41cd0:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cd4:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41cd8:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41cdb:	ee                   	out    %al,(%dx)
}
   41cdc:	90                   	nop
   41cdd:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41ce4:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ce8:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41cec:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41cef:	ee                   	out    %al,(%dx)
}
   41cf0:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41cf1:	e8 a5 fe ff ff       	call   41b9b <interrupt_mask>
}
   41cf6:	90                   	nop
   41cf7:	c9                   	leave  
   41cf8:	c3                   	ret    

0000000000041cf9 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41cf9:	55                   	push   %rbp
   41cfa:	48 89 e5             	mov    %rsp,%rbp
   41cfd:	48 83 ec 28          	sub    $0x28,%rsp
   41d01:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41d04:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41d08:	0f 8e 9e 00 00 00    	jle    41dac <timer_init+0xb3>
   41d0e:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41d15:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d19:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41d1d:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41d20:	ee                   	out    %al,(%dx)
}
   41d21:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41d22:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41d25:	89 c2                	mov    %eax,%edx
   41d27:	c1 ea 1f             	shr    $0x1f,%edx
   41d2a:	01 d0                	add    %edx,%eax
   41d2c:	d1 f8                	sar    %eax
   41d2e:	05 de 34 12 00       	add    $0x1234de,%eax
   41d33:	99                   	cltd   
   41d34:	f7 7d dc             	idivl  -0x24(%rbp)
   41d37:	89 c2                	mov    %eax,%edx
   41d39:	89 d0                	mov    %edx,%eax
   41d3b:	c1 f8 1f             	sar    $0x1f,%eax
   41d3e:	c1 e8 18             	shr    $0x18,%eax
   41d41:	01 c2                	add    %eax,%edx
   41d43:	0f b6 d2             	movzbl %dl,%edx
   41d46:	29 c2                	sub    %eax,%edx
   41d48:	89 d0                	mov    %edx,%eax
   41d4a:	0f b6 c0             	movzbl %al,%eax
   41d4d:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41d54:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d57:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41d5b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41d5e:	ee                   	out    %al,(%dx)
}
   41d5f:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41d60:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41d63:	89 c2                	mov    %eax,%edx
   41d65:	c1 ea 1f             	shr    $0x1f,%edx
   41d68:	01 d0                	add    %edx,%eax
   41d6a:	d1 f8                	sar    %eax
   41d6c:	05 de 34 12 00       	add    $0x1234de,%eax
   41d71:	99                   	cltd   
   41d72:	f7 7d dc             	idivl  -0x24(%rbp)
   41d75:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41d7b:	85 c0                	test   %eax,%eax
   41d7d:	0f 48 c2             	cmovs  %edx,%eax
   41d80:	c1 f8 08             	sar    $0x8,%eax
   41d83:	0f b6 c0             	movzbl %al,%eax
   41d86:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41d8d:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d90:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41d94:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41d97:	ee                   	out    %al,(%dx)
}
   41d98:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41d99:	0f b7 05 60 15 01 00 	movzwl 0x11560(%rip),%eax        # 53300 <interrupts_enabled>
   41da0:	83 c8 01             	or     $0x1,%eax
   41da3:	66 89 05 56 15 01 00 	mov    %ax,0x11556(%rip)        # 53300 <interrupts_enabled>
   41daa:	eb 11                	jmp    41dbd <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41dac:	0f b7 05 4d 15 01 00 	movzwl 0x1154d(%rip),%eax        # 53300 <interrupts_enabled>
   41db3:	83 e0 fe             	and    $0xfffffffe,%eax
   41db6:	66 89 05 43 15 01 00 	mov    %ax,0x11543(%rip)        # 53300 <interrupts_enabled>
    }
    interrupt_mask();
   41dbd:	e8 d9 fd ff ff       	call   41b9b <interrupt_mask>
}
   41dc2:	90                   	nop
   41dc3:	c9                   	leave  
   41dc4:	c3                   	ret    

0000000000041dc5 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41dc5:	55                   	push   %rbp
   41dc6:	48 89 e5             	mov    %rsp,%rbp
   41dc9:	48 83 ec 08          	sub    $0x8,%rsp
   41dcd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41dd1:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41dd6:	74 14                	je     41dec <physical_memory_isreserved+0x27>
   41dd8:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41ddf:	00 
   41de0:	76 11                	jbe    41df3 <physical_memory_isreserved+0x2e>
   41de2:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41de9:	00 
   41dea:	77 07                	ja     41df3 <physical_memory_isreserved+0x2e>
   41dec:	b8 01 00 00 00       	mov    $0x1,%eax
   41df1:	eb 05                	jmp    41df8 <physical_memory_isreserved+0x33>
   41df3:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41df8:	c9                   	leave  
   41df9:	c3                   	ret    

0000000000041dfa <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41dfa:	55                   	push   %rbp
   41dfb:	48 89 e5             	mov    %rsp,%rbp
   41dfe:	48 83 ec 10          	sub    $0x10,%rsp
   41e02:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41e05:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41e08:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41e0b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e0e:	c1 e0 10             	shl    $0x10,%eax
   41e11:	89 c2                	mov    %eax,%edx
   41e13:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41e16:	c1 e0 0b             	shl    $0xb,%eax
   41e19:	09 c2                	or     %eax,%edx
   41e1b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e1e:	c1 e0 08             	shl    $0x8,%eax
   41e21:	09 d0                	or     %edx,%eax
}
   41e23:	c9                   	leave  
   41e24:	c3                   	ret    

0000000000041e25 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41e25:	55                   	push   %rbp
   41e26:	48 89 e5             	mov    %rsp,%rbp
   41e29:	48 83 ec 18          	sub    $0x18,%rsp
   41e2d:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41e30:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41e33:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41e36:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41e39:	09 d0                	or     %edx,%eax
   41e3b:	0d 00 00 00 80       	or     $0x80000000,%eax
   41e40:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41e47:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41e4a:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41e4d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41e50:	ef                   	out    %eax,(%dx)
}
   41e51:	90                   	nop
   41e52:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41e59:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e5c:	89 c2                	mov    %eax,%edx
   41e5e:	ed                   	in     (%dx),%eax
   41e5f:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41e62:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41e65:	c9                   	leave  
   41e66:	c3                   	ret    

0000000000041e67 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41e67:	55                   	push   %rbp
   41e68:	48 89 e5             	mov    %rsp,%rbp
   41e6b:	48 83 ec 28          	sub    $0x28,%rsp
   41e6f:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41e72:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41e75:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41e7c:	eb 73                	jmp    41ef1 <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41e7e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41e85:	eb 60                	jmp    41ee7 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41e87:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41e8e:	eb 4a                	jmp    41eda <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41e90:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41e93:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41e96:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e99:	89 ce                	mov    %ecx,%esi
   41e9b:	89 c7                	mov    %eax,%edi
   41e9d:	e8 58 ff ff ff       	call   41dfa <pci_make_configaddr>
   41ea2:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41ea5:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41ea8:	be 00 00 00 00       	mov    $0x0,%esi
   41ead:	89 c7                	mov    %eax,%edi
   41eaf:	e8 71 ff ff ff       	call   41e25 <pci_config_readl>
   41eb4:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41eb7:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41eba:	c1 e0 10             	shl    $0x10,%eax
   41ebd:	0b 45 dc             	or     -0x24(%rbp),%eax
   41ec0:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41ec3:	75 05                	jne    41eca <pci_find_device+0x63>
                    return configaddr;
   41ec5:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41ec8:	eb 35                	jmp    41eff <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41eca:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41ece:	75 06                	jne    41ed6 <pci_find_device+0x6f>
   41ed0:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41ed4:	74 0c                	je     41ee2 <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41ed6:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41eda:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41ede:	75 b0                	jne    41e90 <pci_find_device+0x29>
   41ee0:	eb 01                	jmp    41ee3 <pci_find_device+0x7c>
                    break;
   41ee2:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41ee3:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41ee7:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41eeb:	75 9a                	jne    41e87 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41eed:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41ef1:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41ef8:	75 84                	jne    41e7e <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41efa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41eff:	c9                   	leave  
   41f00:	c3                   	ret    

0000000000041f01 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41f01:	55                   	push   %rbp
   41f02:	48 89 e5             	mov    %rsp,%rbp
   41f05:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41f09:	be 13 71 00 00       	mov    $0x7113,%esi
   41f0e:	bf 86 80 00 00       	mov    $0x8086,%edi
   41f13:	e8 4f ff ff ff       	call   41e67 <pci_find_device>
   41f18:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41f1b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41f1f:	78 30                	js     41f51 <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41f21:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41f24:	be 40 00 00 00       	mov    $0x40,%esi
   41f29:	89 c7                	mov    %eax,%edi
   41f2b:	e8 f5 fe ff ff       	call   41e25 <pci_config_readl>
   41f30:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41f35:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41f38:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41f3b:	83 c0 04             	add    $0x4,%eax
   41f3e:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41f41:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41f47:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41f4b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41f4e:	66 ef                	out    %ax,(%dx)
}
   41f50:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41f51:	ba e0 46 04 00       	mov    $0x446e0,%edx
   41f56:	be 00 c0 00 00       	mov    $0xc000,%esi
   41f5b:	bf 80 07 00 00       	mov    $0x780,%edi
   41f60:	b8 00 00 00 00       	mov    $0x0,%eax
   41f65:	e8 80 21 00 00       	call   440ea <console_printf>
 spinloop: goto spinloop;
   41f6a:	eb fe                	jmp    41f6a <poweroff+0x69>

0000000000041f6c <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41f6c:	55                   	push   %rbp
   41f6d:	48 89 e5             	mov    %rsp,%rbp
   41f70:	48 83 ec 10          	sub    $0x10,%rsp
   41f74:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41f7b:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f7f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f83:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41f86:	ee                   	out    %al,(%dx)
}
   41f87:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41f88:	eb fe                	jmp    41f88 <reboot+0x1c>

0000000000041f8a <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41f8a:	55                   	push   %rbp
   41f8b:	48 89 e5             	mov    %rsp,%rbp
   41f8e:	48 83 ec 10          	sub    $0x10,%rsp
   41f92:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41f96:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41f99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f9d:	48 83 c0 08          	add    $0x8,%rax
   41fa1:	ba c0 00 00 00       	mov    $0xc0,%edx
   41fa6:	be 00 00 00 00       	mov    $0x0,%esi
   41fab:	48 89 c7             	mov    %rax,%rdi
   41fae:	e8 80 13 00 00       	call   43333 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41fb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41fb7:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   41fbe:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41fc0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41fc4:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   41fcb:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41fcf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41fd3:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   41fda:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41fde:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41fe2:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   41fe9:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41feb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41fef:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   41ff6:	00 02 00 00 
    p->display_status = 1;
   41ffa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ffe:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   42005:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42008:	83 e0 01             	and    $0x1,%eax
   4200b:	85 c0                	test   %eax,%eax
   4200d:	74 1c                	je     4202b <process_init+0xa1>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   4200f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42013:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   4201a:	80 cc 30             	or     $0x30,%ah
   4201d:	48 89 c2             	mov    %rax,%rdx
   42020:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42024:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   4202b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4202e:	83 e0 02             	and    $0x2,%eax
   42031:	85 c0                	test   %eax,%eax
   42033:	74 1c                	je     42051 <process_init+0xc7>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   42035:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42039:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   42040:	80 e4 fd             	and    $0xfd,%ah
   42043:	48 89 c2             	mov    %rax,%rdx
   42046:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4204a:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   42051:	90                   	nop
   42052:	c9                   	leave  
   42053:	c3                   	ret    

0000000000042054 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   42054:	55                   	push   %rbp
   42055:	48 89 e5             	mov    %rsp,%rbp
   42058:	48 83 ec 28          	sub    $0x28,%rsp
   4205c:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4205f:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42063:	78 09                	js     4206e <console_show_cursor+0x1a>
   42065:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   4206c:	7e 07                	jle    42075 <console_show_cursor+0x21>
        cpos = 0;
   4206e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   42075:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   4207c:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42080:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42084:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42087:	ee                   	out    %al,(%dx)
}
   42088:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   42089:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4208c:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42092:	85 c0                	test   %eax,%eax
   42094:	0f 48 c2             	cmovs  %edx,%eax
   42097:	c1 f8 08             	sar    $0x8,%eax
   4209a:	0f b6 c0             	movzbl %al,%eax
   4209d:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   420a4:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420a7:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   420ab:	8b 55 ec             	mov    -0x14(%rbp),%edx
   420ae:	ee                   	out    %al,(%dx)
}
   420af:	90                   	nop
   420b0:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   420b7:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420bb:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   420bf:	8b 55 f4             	mov    -0xc(%rbp),%edx
   420c2:	ee                   	out    %al,(%dx)
}
   420c3:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   420c4:	8b 55 dc             	mov    -0x24(%rbp),%edx
   420c7:	89 d0                	mov    %edx,%eax
   420c9:	c1 f8 1f             	sar    $0x1f,%eax
   420cc:	c1 e8 18             	shr    $0x18,%eax
   420cf:	01 c2                	add    %eax,%edx
   420d1:	0f b6 d2             	movzbl %dl,%edx
   420d4:	29 c2                	sub    %eax,%edx
   420d6:	89 d0                	mov    %edx,%eax
   420d8:	0f b6 c0             	movzbl %al,%eax
   420db:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   420e2:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420e5:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   420e9:	8b 55 fc             	mov    -0x4(%rbp),%edx
   420ec:	ee                   	out    %al,(%dx)
}
   420ed:	90                   	nop
}
   420ee:	90                   	nop
   420ef:	c9                   	leave  
   420f0:	c3                   	ret    

00000000000420f1 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   420f1:	55                   	push   %rbp
   420f2:	48 89 e5             	mov    %rsp,%rbp
   420f5:	48 83 ec 20          	sub    $0x20,%rsp
   420f9:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42100:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42103:	89 c2                	mov    %eax,%edx
   42105:	ec                   	in     (%dx),%al
   42106:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42109:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   4210d:	0f b6 c0             	movzbl %al,%eax
   42110:	83 e0 01             	and    $0x1,%eax
   42113:	85 c0                	test   %eax,%eax
   42115:	75 0a                	jne    42121 <keyboard_readc+0x30>
        return -1;
   42117:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4211c:	e9 e7 01 00 00       	jmp    42308 <keyboard_readc+0x217>
   42121:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42128:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4212b:	89 c2                	mov    %eax,%edx
   4212d:	ec                   	in     (%dx),%al
   4212e:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   42131:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   42135:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   42138:	0f b6 05 c3 11 01 00 	movzbl 0x111c3(%rip),%eax        # 53302 <last_escape.2>
   4213f:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   42142:	c6 05 b9 11 01 00 00 	movb   $0x0,0x111b9(%rip)        # 53302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   42149:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   4214d:	75 11                	jne    42160 <keyboard_readc+0x6f>
        last_escape = 0x80;
   4214f:	c6 05 ac 11 01 00 80 	movb   $0x80,0x111ac(%rip)        # 53302 <last_escape.2>
        return 0;
   42156:	b8 00 00 00 00       	mov    $0x0,%eax
   4215b:	e9 a8 01 00 00       	jmp    42308 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   42160:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42164:	84 c0                	test   %al,%al
   42166:	79 60                	jns    421c8 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   42168:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4216c:	83 e0 7f             	and    $0x7f,%eax
   4216f:	89 c2                	mov    %eax,%edx
   42171:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   42175:	09 d0                	or     %edx,%eax
   42177:	48 98                	cltq   
   42179:	0f b6 80 00 47 04 00 	movzbl 0x44700(%rax),%eax
   42180:	0f b6 c0             	movzbl %al,%eax
   42183:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   42186:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   4218d:	7e 2f                	jle    421be <keyboard_readc+0xcd>
   4218f:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   42196:	7f 26                	jg     421be <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   42198:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4219b:	2d fa 00 00 00       	sub    $0xfa,%eax
   421a0:	ba 01 00 00 00       	mov    $0x1,%edx
   421a5:	89 c1                	mov    %eax,%ecx
   421a7:	d3 e2                	shl    %cl,%edx
   421a9:	89 d0                	mov    %edx,%eax
   421ab:	f7 d0                	not    %eax
   421ad:	89 c2                	mov    %eax,%edx
   421af:	0f b6 05 4d 11 01 00 	movzbl 0x1114d(%rip),%eax        # 53303 <modifiers.1>
   421b6:	21 d0                	and    %edx,%eax
   421b8:	88 05 45 11 01 00    	mov    %al,0x11145(%rip)        # 53303 <modifiers.1>
        }
        return 0;
   421be:	b8 00 00 00 00       	mov    $0x0,%eax
   421c3:	e9 40 01 00 00       	jmp    42308 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   421c8:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   421cc:	0a 45 fa             	or     -0x6(%rbp),%al
   421cf:	0f b6 c0             	movzbl %al,%eax
   421d2:	48 98                	cltq   
   421d4:	0f b6 80 00 47 04 00 	movzbl 0x44700(%rax),%eax
   421db:	0f b6 c0             	movzbl %al,%eax
   421de:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   421e1:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   421e5:	7e 57                	jle    4223e <keyboard_readc+0x14d>
   421e7:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   421eb:	7f 51                	jg     4223e <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   421ed:	0f b6 05 0f 11 01 00 	movzbl 0x1110f(%rip),%eax        # 53303 <modifiers.1>
   421f4:	0f b6 c0             	movzbl %al,%eax
   421f7:	83 e0 02             	and    $0x2,%eax
   421fa:	85 c0                	test   %eax,%eax
   421fc:	74 09                	je     42207 <keyboard_readc+0x116>
            ch -= 0x60;
   421fe:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42202:	e9 fd 00 00 00       	jmp    42304 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   42207:	0f b6 05 f5 10 01 00 	movzbl 0x110f5(%rip),%eax        # 53303 <modifiers.1>
   4220e:	0f b6 c0             	movzbl %al,%eax
   42211:	83 e0 01             	and    $0x1,%eax
   42214:	85 c0                	test   %eax,%eax
   42216:	0f 94 c2             	sete   %dl
   42219:	0f b6 05 e3 10 01 00 	movzbl 0x110e3(%rip),%eax        # 53303 <modifiers.1>
   42220:	0f b6 c0             	movzbl %al,%eax
   42223:	83 e0 08             	and    $0x8,%eax
   42226:	85 c0                	test   %eax,%eax
   42228:	0f 94 c0             	sete   %al
   4222b:	31 d0                	xor    %edx,%eax
   4222d:	84 c0                	test   %al,%al
   4222f:	0f 84 cf 00 00 00    	je     42304 <keyboard_readc+0x213>
            ch -= 0x20;
   42235:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42239:	e9 c6 00 00 00       	jmp    42304 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   4223e:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   42245:	7e 30                	jle    42277 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   42247:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4224a:	2d fa 00 00 00       	sub    $0xfa,%eax
   4224f:	ba 01 00 00 00       	mov    $0x1,%edx
   42254:	89 c1                	mov    %eax,%ecx
   42256:	d3 e2                	shl    %cl,%edx
   42258:	89 d0                	mov    %edx,%eax
   4225a:	89 c2                	mov    %eax,%edx
   4225c:	0f b6 05 a0 10 01 00 	movzbl 0x110a0(%rip),%eax        # 53303 <modifiers.1>
   42263:	31 d0                	xor    %edx,%eax
   42265:	88 05 98 10 01 00    	mov    %al,0x11098(%rip)        # 53303 <modifiers.1>
        ch = 0;
   4226b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42272:	e9 8e 00 00 00       	jmp    42305 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   42277:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   4227e:	7e 2d                	jle    422ad <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   42280:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42283:	2d fa 00 00 00       	sub    $0xfa,%eax
   42288:	ba 01 00 00 00       	mov    $0x1,%edx
   4228d:	89 c1                	mov    %eax,%ecx
   4228f:	d3 e2                	shl    %cl,%edx
   42291:	89 d0                	mov    %edx,%eax
   42293:	89 c2                	mov    %eax,%edx
   42295:	0f b6 05 67 10 01 00 	movzbl 0x11067(%rip),%eax        # 53303 <modifiers.1>
   4229c:	09 d0                	or     %edx,%eax
   4229e:	88 05 5f 10 01 00    	mov    %al,0x1105f(%rip)        # 53303 <modifiers.1>
        ch = 0;
   422a4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   422ab:	eb 58                	jmp    42305 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   422ad:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   422b1:	7e 31                	jle    422e4 <keyboard_readc+0x1f3>
   422b3:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   422ba:	7f 28                	jg     422e4 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   422bc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   422bf:	8d 50 80             	lea    -0x80(%rax),%edx
   422c2:	0f b6 05 3a 10 01 00 	movzbl 0x1103a(%rip),%eax        # 53303 <modifiers.1>
   422c9:	0f b6 c0             	movzbl %al,%eax
   422cc:	83 e0 03             	and    $0x3,%eax
   422cf:	48 98                	cltq   
   422d1:	48 63 d2             	movslq %edx,%rdx
   422d4:	0f b6 84 90 00 48 04 	movzbl 0x44800(%rax,%rdx,4),%eax
   422db:	00 
   422dc:	0f b6 c0             	movzbl %al,%eax
   422df:	89 45 fc             	mov    %eax,-0x4(%rbp)
   422e2:	eb 21                	jmp    42305 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   422e4:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   422e8:	7f 1b                	jg     42305 <keyboard_readc+0x214>
   422ea:	0f b6 05 12 10 01 00 	movzbl 0x11012(%rip),%eax        # 53303 <modifiers.1>
   422f1:	0f b6 c0             	movzbl %al,%eax
   422f4:	83 e0 02             	and    $0x2,%eax
   422f7:	85 c0                	test   %eax,%eax
   422f9:	74 0a                	je     42305 <keyboard_readc+0x214>
        ch = 0;
   422fb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42302:	eb 01                	jmp    42305 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   42304:	90                   	nop
    }

    return ch;
   42305:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   42308:	c9                   	leave  
   42309:	c3                   	ret    

000000000004230a <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   4230a:	55                   	push   %rbp
   4230b:	48 89 e5             	mov    %rsp,%rbp
   4230e:	48 83 ec 20          	sub    $0x20,%rsp
   42312:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42319:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4231c:	89 c2                	mov    %eax,%edx
   4231e:	ec                   	in     (%dx),%al
   4231f:	88 45 e3             	mov    %al,-0x1d(%rbp)
   42322:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42329:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4232c:	89 c2                	mov    %eax,%edx
   4232e:	ec                   	in     (%dx),%al
   4232f:	88 45 eb             	mov    %al,-0x15(%rbp)
   42332:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42339:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4233c:	89 c2                	mov    %eax,%edx
   4233e:	ec                   	in     (%dx),%al
   4233f:	88 45 f3             	mov    %al,-0xd(%rbp)
   42342:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42349:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4234c:	89 c2                	mov    %eax,%edx
   4234e:	ec                   	in     (%dx),%al
   4234f:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   42352:	90                   	nop
   42353:	c9                   	leave  
   42354:	c3                   	ret    

0000000000042355 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   42355:	55                   	push   %rbp
   42356:	48 89 e5             	mov    %rsp,%rbp
   42359:	48 83 ec 40          	sub    $0x40,%rsp
   4235d:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42361:	89 f0                	mov    %esi,%eax
   42363:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42366:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42369:	8b 05 95 0f 01 00    	mov    0x10f95(%rip),%eax        # 53304 <initialized.0>
   4236f:	85 c0                	test   %eax,%eax
   42371:	75 1e                	jne    42391 <parallel_port_putc+0x3c>
   42373:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   4237a:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4237e:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   42382:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42385:	ee                   	out    %al,(%dx)
}
   42386:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42387:	c7 05 73 0f 01 00 01 	movl   $0x1,0x10f73(%rip)        # 53304 <initialized.0>
   4238e:	00 00 00 
    }

    for (int i = 0;
   42391:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42398:	eb 09                	jmp    423a3 <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   4239a:	e8 6b ff ff ff       	call   4230a <delay>
         ++i) {
   4239f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   423a3:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   423aa:	7f 18                	jg     423c4 <parallel_port_putc+0x6f>
   423ac:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   423b3:	8b 45 f0             	mov    -0x10(%rbp),%eax
   423b6:	89 c2                	mov    %eax,%edx
   423b8:	ec                   	in     (%dx),%al
   423b9:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   423bc:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   423c0:	84 c0                	test   %al,%al
   423c2:	79 d6                	jns    4239a <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   423c4:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   423c8:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   423cf:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423d2:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   423d6:	8b 55 d8             	mov    -0x28(%rbp),%edx
   423d9:	ee                   	out    %al,(%dx)
}
   423da:	90                   	nop
   423db:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   423e2:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423e6:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   423ea:	8b 55 e0             	mov    -0x20(%rbp),%edx
   423ed:	ee                   	out    %al,(%dx)
}
   423ee:	90                   	nop
   423ef:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   423f6:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423fa:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   423fe:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42401:	ee                   	out    %al,(%dx)
}
   42402:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42403:	90                   	nop
   42404:	c9                   	leave  
   42405:	c3                   	ret    

0000000000042406 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42406:	55                   	push   %rbp
   42407:	48 89 e5             	mov    %rsp,%rbp
   4240a:	48 83 ec 20          	sub    $0x20,%rsp
   4240e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42412:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42416:	48 c7 45 f8 55 23 04 	movq   $0x42355,-0x8(%rbp)
   4241d:	00 
    printer_vprintf(&p, 0, format, val);
   4241e:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42422:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42426:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   4242a:	be 00 00 00 00       	mov    $0x0,%esi
   4242f:	48 89 c7             	mov    %rax,%rdi
   42432:	e8 98 11 00 00       	call   435cf <printer_vprintf>
}
   42437:	90                   	nop
   42438:	c9                   	leave  
   42439:	c3                   	ret    

000000000004243a <log_printf>:

void log_printf(const char* format, ...) {
   4243a:	55                   	push   %rbp
   4243b:	48 89 e5             	mov    %rsp,%rbp
   4243e:	48 83 ec 60          	sub    $0x60,%rsp
   42442:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42446:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   4244a:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4244e:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42452:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42456:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4245a:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42461:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42465:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42469:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4246d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42471:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42475:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42479:	48 89 d6             	mov    %rdx,%rsi
   4247c:	48 89 c7             	mov    %rax,%rdi
   4247f:	e8 82 ff ff ff       	call   42406 <log_vprintf>
    va_end(val);
}
   42484:	90                   	nop
   42485:	c9                   	leave  
   42486:	c3                   	ret    

0000000000042487 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42487:	55                   	push   %rbp
   42488:	48 89 e5             	mov    %rsp,%rbp
   4248b:	48 83 ec 40          	sub    $0x40,%rsp
   4248f:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42492:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42495:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42499:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   4249d:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   424a1:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   424a5:	48 8b 0a             	mov    (%rdx),%rcx
   424a8:	48 89 08             	mov    %rcx,(%rax)
   424ab:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   424af:	48 89 48 08          	mov    %rcx,0x8(%rax)
   424b3:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   424b7:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   424bb:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   424bf:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   424c3:	48 89 d6             	mov    %rdx,%rsi
   424c6:	48 89 c7             	mov    %rax,%rdi
   424c9:	e8 38 ff ff ff       	call   42406 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   424ce:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   424d2:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   424d6:	8b 75 d8             	mov    -0x28(%rbp),%esi
   424d9:	8b 45 dc             	mov    -0x24(%rbp),%eax
   424dc:	89 c7                	mov    %eax,%edi
   424de:	e8 9b 1b 00 00       	call   4407e <console_vprintf>
}
   424e3:	c9                   	leave  
   424e4:	c3                   	ret    

00000000000424e5 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   424e5:	55                   	push   %rbp
   424e6:	48 89 e5             	mov    %rsp,%rbp
   424e9:	48 83 ec 60          	sub    $0x60,%rsp
   424ed:	89 7d ac             	mov    %edi,-0x54(%rbp)
   424f0:	89 75 a8             	mov    %esi,-0x58(%rbp)
   424f3:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   424f7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   424fb:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   424ff:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42503:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   4250a:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4250e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42512:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42516:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   4251a:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4251e:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42522:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42525:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42528:	89 c7                	mov    %eax,%edi
   4252a:	e8 58 ff ff ff       	call   42487 <error_vprintf>
   4252f:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42532:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42535:	c9                   	leave  
   42536:	c3                   	ret    

0000000000042537 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42537:	55                   	push   %rbp
   42538:	48 89 e5             	mov    %rsp,%rbp
   4253b:	53                   	push   %rbx
   4253c:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42540:	e8 ac fb ff ff       	call   420f1 <keyboard_readc>
   42545:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42548:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   4254c:	74 1c                	je     4256a <check_keyboard+0x33>
   4254e:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   42552:	74 16                	je     4256a <check_keyboard+0x33>
   42554:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42558:	74 10                	je     4256a <check_keyboard+0x33>
   4255a:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   4255e:	74 0a                	je     4256a <check_keyboard+0x33>
   42560:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42564:	0f 85 e9 00 00 00    	jne    42653 <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   4256a:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42571:	00 
        memset(pt, 0, PAGESIZE * 3);
   42572:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42576:	ba 00 30 00 00       	mov    $0x3000,%edx
   4257b:	be 00 00 00 00       	mov    $0x0,%esi
   42580:	48 89 c7             	mov    %rax,%rdi
   42583:	e8 ab 0d 00 00       	call   43333 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42588:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4258c:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42593:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42597:	48 05 00 10 00 00    	add    $0x1000,%rax
   4259d:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   425a4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   425a8:	48 05 00 20 00 00    	add    $0x2000,%rax
   425ae:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   425b5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   425b9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   425bd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   425c1:	0f 22 d8             	mov    %rax,%cr3
}
   425c4:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   425c5:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   425cc:	48 c7 45 e8 58 48 04 	movq   $0x44858,-0x18(%rbp)
   425d3:	00 
        if (c == 'a') {
   425d4:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   425d8:	75 0a                	jne    425e4 <check_keyboard+0xad>
            argument = "allocator";
   425da:	48 c7 45 e8 5d 48 04 	movq   $0x4485d,-0x18(%rbp)
   425e1:	00 
   425e2:	eb 2e                	jmp    42612 <check_keyboard+0xdb>
        } else if (c == 'e') {
   425e4:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   425e8:	75 0a                	jne    425f4 <check_keyboard+0xbd>
            argument = "forkexit";
   425ea:	48 c7 45 e8 67 48 04 	movq   $0x44867,-0x18(%rbp)
   425f1:	00 
   425f2:	eb 1e                	jmp    42612 <check_keyboard+0xdb>
        }
        else if (c == 't'){
   425f4:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   425f8:	75 0a                	jne    42604 <check_keyboard+0xcd>
            argument = "test";
   425fa:	48 c7 45 e8 70 48 04 	movq   $0x44870,-0x18(%rbp)
   42601:	00 
   42602:	eb 0e                	jmp    42612 <check_keyboard+0xdb>
        }
        else if(c == '2'){
   42604:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42608:	75 08                	jne    42612 <check_keyboard+0xdb>
            argument = "test2";
   4260a:	48 c7 45 e8 75 48 04 	movq   $0x44875,-0x18(%rbp)
   42611:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42612:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42616:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   4261a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4261f:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   42623:	73 14                	jae    42639 <check_keyboard+0x102>
   42625:	ba 7b 48 04 00       	mov    $0x4487b,%edx
   4262a:	be 5d 02 00 00       	mov    $0x25d,%esi
   4262f:	bf 97 48 04 00       	mov    $0x44897,%edi
   42634:	e8 1f 01 00 00       	call   42758 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42639:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4263d:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42640:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42644:	48 89 c3             	mov    %rax,%rbx
   42647:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   4264c:	e9 af d9 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42651:	eb 11                	jmp    42664 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42653:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42657:	74 06                	je     4265f <check_keyboard+0x128>
   42659:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   4265d:	75 05                	jne    42664 <check_keyboard+0x12d>
        poweroff();
   4265f:	e8 9d f8 ff ff       	call   41f01 <poweroff>
    }
    return c;
   42664:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42667:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   4266b:	c9                   	leave  
   4266c:	c3                   	ret    

000000000004266d <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   4266d:	55                   	push   %rbp
   4266e:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42671:	e8 c1 fe ff ff       	call   42537 <check_keyboard>
   42676:	eb f9                	jmp    42671 <fail+0x4>

0000000000042678 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42678:	55                   	push   %rbp
   42679:	48 89 e5             	mov    %rsp,%rbp
   4267c:	48 83 ec 60          	sub    $0x60,%rsp
   42680:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42684:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42688:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4268c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42690:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42694:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42698:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   4269f:	48 8d 45 10          	lea    0x10(%rbp),%rax
   426a3:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   426a7:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   426ab:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   426af:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   426b4:	0f 84 80 00 00 00    	je     4273a <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   426ba:	ba ab 48 04 00       	mov    $0x448ab,%edx
   426bf:	be 00 c0 00 00       	mov    $0xc000,%esi
   426c4:	bf 30 07 00 00       	mov    $0x730,%edi
   426c9:	b8 00 00 00 00       	mov    $0x0,%eax
   426ce:	e8 12 fe ff ff       	call   424e5 <error_printf>
   426d3:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   426d6:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   426da:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   426de:	8b 45 cc             	mov    -0x34(%rbp),%eax
   426e1:	be 00 c0 00 00       	mov    $0xc000,%esi
   426e6:	89 c7                	mov    %eax,%edi
   426e8:	e8 9a fd ff ff       	call   42487 <error_vprintf>
   426ed:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   426f0:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   426f3:	48 63 c1             	movslq %ecx,%rax
   426f6:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   426fd:	48 c1 e8 20          	shr    $0x20,%rax
   42701:	89 c2                	mov    %eax,%edx
   42703:	c1 fa 05             	sar    $0x5,%edx
   42706:	89 c8                	mov    %ecx,%eax
   42708:	c1 f8 1f             	sar    $0x1f,%eax
   4270b:	29 c2                	sub    %eax,%edx
   4270d:	89 d0                	mov    %edx,%eax
   4270f:	c1 e0 02             	shl    $0x2,%eax
   42712:	01 d0                	add    %edx,%eax
   42714:	c1 e0 04             	shl    $0x4,%eax
   42717:	29 c1                	sub    %eax,%ecx
   42719:	89 ca                	mov    %ecx,%edx
   4271b:	85 d2                	test   %edx,%edx
   4271d:	74 34                	je     42753 <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   4271f:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42722:	ba b3 48 04 00       	mov    $0x448b3,%edx
   42727:	be 00 c0 00 00       	mov    $0xc000,%esi
   4272c:	89 c7                	mov    %eax,%edi
   4272e:	b8 00 00 00 00       	mov    $0x0,%eax
   42733:	e8 ad fd ff ff       	call   424e5 <error_printf>
   42738:	eb 19                	jmp    42753 <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   4273a:	ba b5 48 04 00       	mov    $0x448b5,%edx
   4273f:	be 00 c0 00 00       	mov    $0xc000,%esi
   42744:	bf 30 07 00 00       	mov    $0x730,%edi
   42749:	b8 00 00 00 00       	mov    $0x0,%eax
   4274e:	e8 92 fd ff ff       	call   424e5 <error_printf>
    }

    va_end(val);
    fail();
   42753:	e8 15 ff ff ff       	call   4266d <fail>

0000000000042758 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42758:	55                   	push   %rbp
   42759:	48 89 e5             	mov    %rsp,%rbp
   4275c:	48 83 ec 20          	sub    $0x20,%rsp
   42760:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42764:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42767:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   4276b:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   4276f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42772:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42776:	48 89 c6             	mov    %rax,%rsi
   42779:	bf bb 48 04 00       	mov    $0x448bb,%edi
   4277e:	b8 00 00 00 00       	mov    $0x0,%eax
   42783:	e8 f0 fe ff ff       	call   42678 <panic>

0000000000042788 <default_exception>:
}

void default_exception(proc* p){
   42788:	55                   	push   %rbp
   42789:	48 89 e5             	mov    %rsp,%rbp
   4278c:	48 83 ec 20          	sub    $0x20,%rsp
   42790:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42794:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42798:	48 83 c0 08          	add    $0x8,%rax
   4279c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   427a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   427a4:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   427ab:	48 89 c6             	mov    %rax,%rsi
   427ae:	bf d9 48 04 00       	mov    $0x448d9,%edi
   427b3:	b8 00 00 00 00       	mov    $0x0,%eax
   427b8:	e8 bb fe ff ff       	call   42678 <panic>

00000000000427bd <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   427bd:	55                   	push   %rbp
   427be:	48 89 e5             	mov    %rsp,%rbp
   427c1:	48 83 ec 10          	sub    $0x10,%rsp
   427c5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   427c9:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   427cc:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   427d0:	78 06                	js     427d8 <pageindex+0x1b>
   427d2:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   427d6:	7e 14                	jle    427ec <pageindex+0x2f>
   427d8:	ba f8 48 04 00       	mov    $0x448f8,%edx
   427dd:	be 1e 00 00 00       	mov    $0x1e,%esi
   427e2:	bf 11 49 04 00       	mov    $0x44911,%edi
   427e7:	e8 6c ff ff ff       	call   42758 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   427ec:	b8 03 00 00 00       	mov    $0x3,%eax
   427f1:	2b 45 f4             	sub    -0xc(%rbp),%eax
   427f4:	89 c2                	mov    %eax,%edx
   427f6:	89 d0                	mov    %edx,%eax
   427f8:	c1 e0 03             	shl    $0x3,%eax
   427fb:	01 d0                	add    %edx,%eax
   427fd:	83 c0 0c             	add    $0xc,%eax
   42800:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42804:	89 c1                	mov    %eax,%ecx
   42806:	48 d3 ea             	shr    %cl,%rdx
   42809:	48 89 d0             	mov    %rdx,%rax
   4280c:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42811:	c9                   	leave  
   42812:	c3                   	ret    

0000000000042813 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42813:	55                   	push   %rbp
   42814:	48 89 e5             	mov    %rsp,%rbp
   42817:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   4281b:	48 c7 05 da 17 01 00 	movq   $0x55000,0x117da(%rip)        # 54000 <kernel_pagetable>
   42822:	00 50 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42826:	ba 00 50 00 00       	mov    $0x5000,%edx
   4282b:	be 00 00 00 00       	mov    $0x0,%esi
   42830:	bf 00 50 05 00       	mov    $0x55000,%edi
   42835:	e8 f9 0a 00 00       	call   43333 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   4283a:	b8 00 60 05 00       	mov    $0x56000,%eax
   4283f:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42843:	48 89 05 b6 27 01 00 	mov    %rax,0x127b6(%rip)        # 55000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   4284a:	b8 00 70 05 00       	mov    $0x57000,%eax
   4284f:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42853:	48 89 05 a6 37 01 00 	mov    %rax,0x137a6(%rip)        # 56000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   4285a:	b8 00 80 05 00       	mov    $0x58000,%eax
   4285f:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42863:	48 89 05 96 47 01 00 	mov    %rax,0x14796(%rip)        # 57000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   4286a:	b8 00 90 05 00       	mov    $0x59000,%eax
   4286f:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42873:	48 89 05 8e 47 01 00 	mov    %rax,0x1478e(%rip)        # 57008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4287a:	48 8b 05 7f 17 01 00 	mov    0x1177f(%rip),%rax        # 54000 <kernel_pagetable>
   42881:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42887:	b9 00 00 20 00       	mov    $0x200000,%ecx
   4288c:	ba 00 00 00 00       	mov    $0x0,%edx
   42891:	be 00 00 00 00       	mov    $0x0,%esi
   42896:	48 89 c7             	mov    %rax,%rdi
   42899:	e8 b9 01 00 00       	call   42a57 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4289e:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   428a5:	00 
   428a6:	eb 62                	jmp    4290a <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   428a8:	48 8b 0d 51 17 01 00 	mov    0x11751(%rip),%rcx        # 54000 <kernel_pagetable>
   428af:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   428b3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   428b7:	48 89 ce             	mov    %rcx,%rsi
   428ba:	48 89 c7             	mov    %rax,%rdi
   428bd:	e8 5b 05 00 00       	call   42e1d <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   428c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   428c6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   428ca:	74 14                	je     428e0 <virtual_memory_init+0xcd>
   428cc:	ba 25 49 04 00       	mov    $0x44925,%edx
   428d1:	be 2d 00 00 00       	mov    $0x2d,%esi
   428d6:	bf 35 49 04 00       	mov    $0x44935,%edi
   428db:	e8 78 fe ff ff       	call   42758 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   428e0:	8b 45 f0             	mov    -0x10(%rbp),%eax
   428e3:	48 98                	cltq   
   428e5:	83 e0 03             	and    $0x3,%eax
   428e8:	48 83 f8 03          	cmp    $0x3,%rax
   428ec:	74 14                	je     42902 <virtual_memory_init+0xef>
   428ee:	ba 48 49 04 00       	mov    $0x44948,%edx
   428f3:	be 2e 00 00 00       	mov    $0x2e,%esi
   428f8:	bf 35 49 04 00       	mov    $0x44935,%edi
   428fd:	e8 56 fe ff ff       	call   42758 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42902:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42909:	00 
   4290a:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42911:	00 
   42912:	76 94                	jbe    428a8 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42914:	48 8b 05 e5 16 01 00 	mov    0x116e5(%rip),%rax        # 54000 <kernel_pagetable>
   4291b:	48 89 c7             	mov    %rax,%rdi
   4291e:	e8 03 00 00 00       	call   42926 <set_pagetable>
}
   42923:	90                   	nop
   42924:	c9                   	leave  
   42925:	c3                   	ret    

0000000000042926 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42926:	55                   	push   %rbp
   42927:	48 89 e5             	mov    %rsp,%rbp
   4292a:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   4292e:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42932:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42936:	25 ff 0f 00 00       	and    $0xfff,%eax
   4293b:	48 85 c0             	test   %rax,%rax
   4293e:	74 14                	je     42954 <set_pagetable+0x2e>
   42940:	ba 75 49 04 00       	mov    $0x44975,%edx
   42945:	be 3d 00 00 00       	mov    $0x3d,%esi
   4294a:	bf 35 49 04 00       	mov    $0x44935,%edi
   4294f:	e8 04 fe ff ff       	call   42758 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42954:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42959:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   4295d:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42961:	48 89 ce             	mov    %rcx,%rsi
   42964:	48 89 c7             	mov    %rax,%rdi
   42967:	e8 b1 04 00 00       	call   42e1d <virtual_memory_lookup>
   4296c:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42970:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42975:	48 39 d0             	cmp    %rdx,%rax
   42978:	74 14                	je     4298e <set_pagetable+0x68>
   4297a:	ba 90 49 04 00       	mov    $0x44990,%edx
   4297f:	be 3f 00 00 00       	mov    $0x3f,%esi
   42984:	bf 35 49 04 00       	mov    $0x44935,%edi
   42989:	e8 ca fd ff ff       	call   42758 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   4298e:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42992:	48 8b 0d 67 16 01 00 	mov    0x11667(%rip),%rcx        # 54000 <kernel_pagetable>
   42999:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   4299d:	48 89 ce             	mov    %rcx,%rsi
   429a0:	48 89 c7             	mov    %rax,%rdi
   429a3:	e8 75 04 00 00       	call   42e1d <virtual_memory_lookup>
   429a8:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   429ac:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   429b0:	48 39 c2             	cmp    %rax,%rdx
   429b3:	74 14                	je     429c9 <set_pagetable+0xa3>
   429b5:	ba f8 49 04 00       	mov    $0x449f8,%edx
   429ba:	be 41 00 00 00       	mov    $0x41,%esi
   429bf:	bf 35 49 04 00       	mov    $0x44935,%edi
   429c4:	e8 8f fd ff ff       	call   42758 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   429c9:	48 8b 05 30 16 01 00 	mov    0x11630(%rip),%rax        # 54000 <kernel_pagetable>
   429d0:	48 89 c2             	mov    %rax,%rdx
   429d3:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   429d7:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   429db:	48 89 ce             	mov    %rcx,%rsi
   429de:	48 89 c7             	mov    %rax,%rdi
   429e1:	e8 37 04 00 00       	call   42e1d <virtual_memory_lookup>
   429e6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   429ea:	48 8b 15 0f 16 01 00 	mov    0x1160f(%rip),%rdx        # 54000 <kernel_pagetable>
   429f1:	48 39 d0             	cmp    %rdx,%rax
   429f4:	74 14                	je     42a0a <set_pagetable+0xe4>
   429f6:	ba 58 4a 04 00       	mov    $0x44a58,%edx
   429fb:	be 43 00 00 00       	mov    $0x43,%esi
   42a00:	bf 35 49 04 00       	mov    $0x44935,%edi
   42a05:	e8 4e fd ff ff       	call   42758 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42a0a:	ba 57 2a 04 00       	mov    $0x42a57,%edx
   42a0f:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42a13:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42a17:	48 89 ce             	mov    %rcx,%rsi
   42a1a:	48 89 c7             	mov    %rax,%rdi
   42a1d:	e8 fb 03 00 00       	call   42e1d <virtual_memory_lookup>
   42a22:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a26:	ba 57 2a 04 00       	mov    $0x42a57,%edx
   42a2b:	48 39 d0             	cmp    %rdx,%rax
   42a2e:	74 14                	je     42a44 <set_pagetable+0x11e>
   42a30:	ba c0 4a 04 00       	mov    $0x44ac0,%edx
   42a35:	be 45 00 00 00       	mov    $0x45,%esi
   42a3a:	bf 35 49 04 00       	mov    $0x44935,%edi
   42a3f:	e8 14 fd ff ff       	call   42758 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42a44:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42a48:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42a4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42a50:	0f 22 d8             	mov    %rax,%cr3
}
   42a53:	90                   	nop
}
   42a54:	90                   	nop
   42a55:	c9                   	leave  
   42a56:	c3                   	ret    

0000000000042a57 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42a57:	55                   	push   %rbp
   42a58:	48 89 e5             	mov    %rsp,%rbp
   42a5b:	41 54                	push   %r12
   42a5d:	53                   	push   %rbx
   42a5e:	48 83 ec 50          	sub    $0x50,%rsp
   42a62:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42a66:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42a6a:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42a6e:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   42a72:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42a76:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a7a:	25 ff 0f 00 00       	and    $0xfff,%eax
   42a7f:	48 85 c0             	test   %rax,%rax
   42a82:	74 14                	je     42a98 <virtual_memory_map+0x41>
   42a84:	ba 26 4b 04 00       	mov    $0x44b26,%edx
   42a89:	be 66 00 00 00       	mov    $0x66,%esi
   42a8e:	bf 35 49 04 00       	mov    $0x44935,%edi
   42a93:	e8 c0 fc ff ff       	call   42758 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42a98:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42a9c:	25 ff 0f 00 00       	and    $0xfff,%eax
   42aa1:	48 85 c0             	test   %rax,%rax
   42aa4:	74 14                	je     42aba <virtual_memory_map+0x63>
   42aa6:	ba 39 4b 04 00       	mov    $0x44b39,%edx
   42aab:	be 67 00 00 00       	mov    $0x67,%esi
   42ab0:	bf 35 49 04 00       	mov    $0x44935,%edi
   42ab5:	e8 9e fc ff ff       	call   42758 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42aba:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42abe:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42ac2:	48 01 d0             	add    %rdx,%rax
   42ac5:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   42ac9:	73 24                	jae    42aef <virtual_memory_map+0x98>
   42acb:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42acf:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42ad3:	48 01 d0             	add    %rdx,%rax
   42ad6:	48 85 c0             	test   %rax,%rax
   42ad9:	74 14                	je     42aef <virtual_memory_map+0x98>
   42adb:	ba 4c 4b 04 00       	mov    $0x44b4c,%edx
   42ae0:	be 68 00 00 00       	mov    $0x68,%esi
   42ae5:	bf 35 49 04 00       	mov    $0x44935,%edi
   42aea:	e8 69 fc ff ff       	call   42758 <assert_fail>
    if (perm & PTE_P) {
   42aef:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42af2:	48 98                	cltq   
   42af4:	83 e0 01             	and    $0x1,%eax
   42af7:	48 85 c0             	test   %rax,%rax
   42afa:	74 6e                	je     42b6a <virtual_memory_map+0x113>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42afc:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42b00:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b05:	48 85 c0             	test   %rax,%rax
   42b08:	74 14                	je     42b1e <virtual_memory_map+0xc7>
   42b0a:	ba 6a 4b 04 00       	mov    $0x44b6a,%edx
   42b0f:	be 6a 00 00 00       	mov    $0x6a,%esi
   42b14:	bf 35 49 04 00       	mov    $0x44935,%edi
   42b19:	e8 3a fc ff ff       	call   42758 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42b1e:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42b22:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42b26:	48 01 d0             	add    %rdx,%rax
   42b29:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   42b2d:	73 14                	jae    42b43 <virtual_memory_map+0xec>
   42b2f:	ba 7d 4b 04 00       	mov    $0x44b7d,%edx
   42b34:	be 6b 00 00 00       	mov    $0x6b,%esi
   42b39:	bf 35 49 04 00       	mov    $0x44935,%edi
   42b3e:	e8 15 fc ff ff       	call   42758 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42b43:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42b47:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42b4b:	48 01 d0             	add    %rdx,%rax
   42b4e:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42b54:	76 14                	jbe    42b6a <virtual_memory_map+0x113>
   42b56:	ba 8b 4b 04 00       	mov    $0x44b8b,%edx
   42b5b:	be 6c 00 00 00       	mov    $0x6c,%esi
   42b60:	bf 35 49 04 00       	mov    $0x44935,%edi
   42b65:	e8 ee fb ff ff       	call   42758 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42b6a:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42b6e:	78 09                	js     42b79 <virtual_memory_map+0x122>
   42b70:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42b77:	7e 14                	jle    42b8d <virtual_memory_map+0x136>
   42b79:	ba a7 4b 04 00       	mov    $0x44ba7,%edx
   42b7e:	be 6e 00 00 00       	mov    $0x6e,%esi
   42b83:	bf 35 49 04 00       	mov    $0x44935,%edi
   42b88:	e8 cb fb ff ff       	call   42758 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42b8d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42b91:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b96:	48 85 c0             	test   %rax,%rax
   42b99:	74 14                	je     42baf <virtual_memory_map+0x158>
   42b9b:	ba c8 4b 04 00       	mov    $0x44bc8,%edx
   42ba0:	be 6f 00 00 00       	mov    $0x6f,%esi
   42ba5:	bf 35 49 04 00       	mov    $0x44935,%edi
   42baa:	e8 a9 fb ff ff       	call   42758 <assert_fail>

    int last_index123 = -1;
   42baf:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   42bb6:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42bbd:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42bbe:	e9 e7 00 00 00       	jmp    42caa <virtual_memory_map+0x253>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42bc3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42bc7:	48 c1 e8 15          	shr    $0x15,%rax
   42bcb:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42bce:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42bd1:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42bd4:	74 20                	je     42bf6 <virtual_memory_map+0x19f>
            // TODO --> done
            // find pointer to last level pagetable for current va

			l1pagetable = lookup_l1pagetable(pagetable, va, perm);	
   42bd6:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42bd9:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42bdd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42be1:	48 89 ce             	mov    %rcx,%rsi
   42be4:	48 89 c7             	mov    %rax,%rdi
   42be7:	e8 d7 00 00 00       	call   42cc3 <lookup_l1pagetable>
   42bec:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

            last_index123 = cur_index123;
   42bf0:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42bf3:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42bf6:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42bf9:	48 98                	cltq   
   42bfb:	83 e0 01             	and    $0x1,%eax
   42bfe:	48 85 c0             	test   %rax,%rax
   42c01:	74 3a                	je     42c3d <virtual_memory_map+0x1e6>
   42c03:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42c08:	74 33                	je     42c3d <virtual_memory_map+0x1e6>
            // TODO --> done
            // map `pa` at appropriate entry with permissions `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] =  (0x00000000FFFFFFFF & pa) | perm;
   42c0a:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42c0e:	41 89 c4             	mov    %eax,%r12d
   42c11:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42c14:	48 63 d8             	movslq %eax,%rbx
   42c17:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42c1b:	be 03 00 00 00       	mov    $0x3,%esi
   42c20:	48 89 c7             	mov    %rax,%rdi
   42c23:	e8 95 fb ff ff       	call   427bd <pageindex>
   42c28:	89 c2                	mov    %eax,%edx
   42c2a:	4c 89 e1             	mov    %r12,%rcx
   42c2d:	48 09 d9             	or     %rbx,%rcx
   42c30:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42c34:	48 63 d2             	movslq %edx,%rdx
   42c37:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42c3b:	eb 55                	jmp    42c92 <virtual_memory_map+0x23b>

        } else if (l1pagetable) { // if page is NOT marked present
   42c3d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42c42:	74 26                	je     42c6a <virtual_memory_map+0x213>
            // TODO --> done
            // map to address 0 with `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] = 0 | perm;
   42c44:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42c48:	be 03 00 00 00       	mov    $0x3,%esi
   42c4d:	48 89 c7             	mov    %rax,%rdi
   42c50:	e8 68 fb ff ff       	call   427bd <pageindex>
   42c55:	89 c2                	mov    %eax,%edx
   42c57:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42c5a:	48 63 c8             	movslq %eax,%rcx
   42c5d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42c61:	48 63 d2             	movslq %edx,%rdx
   42c64:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42c68:	eb 28                	jmp    42c92 <virtual_memory_map+0x23b>

        } else if (perm & PTE_P) {
   42c6a:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42c6d:	48 98                	cltq   
   42c6f:	83 e0 01             	and    $0x1,%eax
   42c72:	48 85 c0             	test   %rax,%rax
   42c75:	74 1b                	je     42c92 <virtual_memory_map+0x23b>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   42c77:	be 8b 00 00 00       	mov    $0x8b,%esi
   42c7c:	bf f0 4b 04 00       	mov    $0x44bf0,%edi
   42c81:	b8 00 00 00 00       	mov    $0x0,%eax
   42c86:	e8 af f7 ff ff       	call   4243a <log_printf>
            return -1;
   42c8b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42c90:	eb 28                	jmp    42cba <virtual_memory_map+0x263>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42c92:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42c99:	00 
   42c9a:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42ca1:	00 
   42ca2:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42ca9:	00 
   42caa:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42caf:	0f 85 0e ff ff ff    	jne    42bc3 <virtual_memory_map+0x16c>
        }
    }
    return 0;
   42cb5:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42cba:	48 83 c4 50          	add    $0x50,%rsp
   42cbe:	5b                   	pop    %rbx
   42cbf:	41 5c                	pop    %r12
   42cc1:	5d                   	pop    %rbp
   42cc2:	c3                   	ret    

0000000000042cc3 <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42cc3:	55                   	push   %rbp
   42cc4:	48 89 e5             	mov    %rsp,%rbp
   42cc7:	48 83 ec 40          	sub    $0x40,%rsp
   42ccb:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42ccf:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42cd3:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42cd6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42cda:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42cde:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42ce5:	e9 23 01 00 00       	jmp    42e0d <lookup_l1pagetable+0x14a>
        // TODO --> done
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)]; // replace this
   42cea:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42ced:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42cf1:	89 d6                	mov    %edx,%esi
   42cf3:	48 89 c7             	mov    %rax,%rdi
   42cf6:	e8 c2 fa ff ff       	call   427bd <pageindex>
   42cfb:	89 c2                	mov    %eax,%edx
   42cfd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42d01:	48 63 d2             	movslq %edx,%rdx
   42d04:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42d08:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42d0c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d10:	83 e0 01             	and    $0x1,%eax
   42d13:	48 85 c0             	test   %rax,%rax
   42d16:	75 63                	jne    42d7b <lookup_l1pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   42d18:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42d1b:	8d 48 02             	lea    0x2(%rax),%ecx
   42d1e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d22:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d27:	48 89 c2             	mov    %rax,%rdx
   42d2a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d2e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42d34:	48 89 c6             	mov    %rax,%rsi
   42d37:	bf 38 4c 04 00       	mov    $0x44c38,%edi
   42d3c:	b8 00 00 00 00       	mov    $0x0,%eax
   42d41:	e8 f4 f6 ff ff       	call   4243a <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42d46:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42d49:	48 98                	cltq   
   42d4b:	83 e0 01             	and    $0x1,%eax
   42d4e:	48 85 c0             	test   %rax,%rax
   42d51:	75 0a                	jne    42d5d <lookup_l1pagetable+0x9a>
                return NULL;
   42d53:	b8 00 00 00 00       	mov    $0x0,%eax
   42d58:	e9 be 00 00 00       	jmp    42e1b <lookup_l1pagetable+0x158>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42d5d:	be af 00 00 00       	mov    $0xaf,%esi
   42d62:	bf a0 4c 04 00       	mov    $0x44ca0,%edi
   42d67:	b8 00 00 00 00       	mov    $0x0,%eax
   42d6c:	e8 c9 f6 ff ff       	call   4243a <log_printf>
            return NULL;
   42d71:	b8 00 00 00 00       	mov    $0x0,%eax
   42d76:	e9 a0 00 00 00       	jmp    42e1b <lookup_l1pagetable+0x158>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42d7b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d7f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42d85:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42d8b:	76 14                	jbe    42da1 <lookup_l1pagetable+0xde>
   42d8d:	ba e8 4c 04 00       	mov    $0x44ce8,%edx
   42d92:	be b4 00 00 00       	mov    $0xb4,%esi
   42d97:	bf 35 49 04 00       	mov    $0x44935,%edi
   42d9c:	e8 b7 f9 ff ff       	call   42758 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42da1:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42da4:	48 98                	cltq   
   42da6:	83 e0 02             	and    $0x2,%eax
   42da9:	48 85 c0             	test   %rax,%rax
   42dac:	74 20                	je     42dce <lookup_l1pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42dae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42db2:	83 e0 02             	and    $0x2,%eax
   42db5:	48 85 c0             	test   %rax,%rax
   42db8:	75 14                	jne    42dce <lookup_l1pagetable+0x10b>
   42dba:	ba 08 4d 04 00       	mov    $0x44d08,%edx
   42dbf:	be b6 00 00 00       	mov    $0xb6,%esi
   42dc4:	bf 35 49 04 00       	mov    $0x44935,%edi
   42dc9:	e8 8a f9 ff ff       	call   42758 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42dce:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42dd1:	48 98                	cltq   
   42dd3:	83 e0 04             	and    $0x4,%eax
   42dd6:	48 85 c0             	test   %rax,%rax
   42dd9:	74 20                	je     42dfb <lookup_l1pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42ddb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ddf:	83 e0 04             	and    $0x4,%eax
   42de2:	48 85 c0             	test   %rax,%rax
   42de5:	75 14                	jne    42dfb <lookup_l1pagetable+0x138>
   42de7:	ba 13 4d 04 00       	mov    $0x44d13,%edx
   42dec:	be b9 00 00 00       	mov    $0xb9,%esi
   42df1:	bf 35 49 04 00       	mov    $0x44935,%edi
   42df6:	e8 5d f9 ff ff       	call   42758 <assert_fail>
        }

        // TODO --> done
        // set pt to physical address to next pagetable using `pe`
        pt = (x86_64_pagetable *) PTE_ADDR(pe); // replace this
   42dfb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42dff:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42e05:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42e09:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42e0d:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42e11:	0f 8e d3 fe ff ff    	jle    42cea <lookup_l1pagetable+0x27>
    }
    return pt;
   42e17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42e1b:	c9                   	leave  
   42e1c:	c3                   	ret    

0000000000042e1d <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42e1d:	55                   	push   %rbp
   42e1e:	48 89 e5             	mov    %rsp,%rbp
   42e21:	48 83 ec 50          	sub    $0x50,%rsp
   42e25:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42e29:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42e2d:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42e31:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42e35:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42e39:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42e40:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42e41:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42e48:	eb 41                	jmp    42e8b <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42e4a:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42e4d:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42e51:	89 d6                	mov    %edx,%esi
   42e53:	48 89 c7             	mov    %rax,%rdi
   42e56:	e8 62 f9 ff ff       	call   427bd <pageindex>
   42e5b:	89 c2                	mov    %eax,%edx
   42e5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42e61:	48 63 d2             	movslq %edx,%rdx
   42e64:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42e68:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e6c:	83 e0 06             	and    $0x6,%eax
   42e6f:	48 f7 d0             	not    %rax
   42e72:	48 21 d0             	and    %rdx,%rax
   42e75:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42e79:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e7d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42e83:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42e87:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42e8b:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42e8f:	7f 0c                	jg     42e9d <virtual_memory_lookup+0x80>
   42e91:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e95:	83 e0 01             	and    $0x1,%eax
   42e98:	48 85 c0             	test   %rax,%rax
   42e9b:	75 ad                	jne    42e4a <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42e9d:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42ea4:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42eab:	ff 
   42eac:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42eb3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42eb7:	83 e0 01             	and    $0x1,%eax
   42eba:	48 85 c0             	test   %rax,%rax
   42ebd:	74 34                	je     42ef3 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42ebf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ec3:	48 c1 e8 0c          	shr    $0xc,%rax
   42ec7:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42eca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ece:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42ed4:	48 89 c2             	mov    %rax,%rdx
   42ed7:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42edb:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ee0:	48 09 d0             	or     %rdx,%rax
   42ee3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42ee7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42eeb:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ef0:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42ef3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42ef7:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42efb:	48 89 10             	mov    %rdx,(%rax)
   42efe:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42f02:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42f06:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42f0a:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42f0e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42f12:	c9                   	leave  
   42f13:	c3                   	ret    

0000000000042f14 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42f14:	55                   	push   %rbp
   42f15:	48 89 e5             	mov    %rsp,%rbp
   42f18:	48 83 ec 40          	sub    $0x40,%rsp
   42f1c:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42f20:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42f23:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42f27:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42f2e:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42f32:	78 08                	js     42f3c <program_load+0x28>
   42f34:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42f37:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42f3a:	7c 14                	jl     42f50 <program_load+0x3c>
   42f3c:	ba 20 4d 04 00       	mov    $0x44d20,%edx
   42f41:	be 37 00 00 00       	mov    $0x37,%esi
   42f46:	bf 50 4d 04 00       	mov    $0x44d50,%edi
   42f4b:	e8 08 f8 ff ff       	call   42758 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42f50:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42f53:	48 98                	cltq   
   42f55:	48 c1 e0 04          	shl    $0x4,%rax
   42f59:	48 05 20 50 04 00    	add    $0x45020,%rax
   42f5f:	48 8b 00             	mov    (%rax),%rax
   42f62:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42f66:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f6a:	8b 00                	mov    (%rax),%eax
   42f6c:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42f71:	74 14                	je     42f87 <program_load+0x73>
   42f73:	ba 62 4d 04 00       	mov    $0x44d62,%edx
   42f78:	be 39 00 00 00       	mov    $0x39,%esi
   42f7d:	bf 50 4d 04 00       	mov    $0x44d50,%edi
   42f82:	e8 d1 f7 ff ff       	call   42758 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42f87:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f8b:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42f8f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f93:	48 01 d0             	add    %rdx,%rax
   42f96:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42f9a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42fa1:	e9 94 00 00 00       	jmp    4303a <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42fa6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42fa9:	48 63 d0             	movslq %eax,%rdx
   42fac:	48 89 d0             	mov    %rdx,%rax
   42faf:	48 c1 e0 03          	shl    $0x3,%rax
   42fb3:	48 29 d0             	sub    %rdx,%rax
   42fb6:	48 c1 e0 03          	shl    $0x3,%rax
   42fba:	48 89 c2             	mov    %rax,%rdx
   42fbd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fc1:	48 01 d0             	add    %rdx,%rax
   42fc4:	8b 00                	mov    (%rax),%eax
   42fc6:	83 f8 01             	cmp    $0x1,%eax
   42fc9:	75 6b                	jne    43036 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42fcb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42fce:	48 63 d0             	movslq %eax,%rdx
   42fd1:	48 89 d0             	mov    %rdx,%rax
   42fd4:	48 c1 e0 03          	shl    $0x3,%rax
   42fd8:	48 29 d0             	sub    %rdx,%rax
   42fdb:	48 c1 e0 03          	shl    $0x3,%rax
   42fdf:	48 89 c2             	mov    %rax,%rdx
   42fe2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fe6:	48 01 d0             	add    %rdx,%rax
   42fe9:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42fed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ff1:	48 01 d0             	add    %rdx,%rax
   42ff4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42ff8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42ffb:	48 63 d0             	movslq %eax,%rdx
   42ffe:	48 89 d0             	mov    %rdx,%rax
   43001:	48 c1 e0 03          	shl    $0x3,%rax
   43005:	48 29 d0             	sub    %rdx,%rax
   43008:	48 c1 e0 03          	shl    $0x3,%rax
   4300c:	48 89 c2             	mov    %rax,%rdx
   4300f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43013:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   43017:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4301b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4301f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43023:	48 89 c7             	mov    %rax,%rdi
   43026:	e8 3d 00 00 00       	call   43068 <program_load_segment>
   4302b:	85 c0                	test   %eax,%eax
   4302d:	79 07                	jns    43036 <program_load+0x122>
                return -1;
   4302f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43034:	eb 30                	jmp    43066 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   43036:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4303a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4303e:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   43042:	0f b7 c0             	movzwl %ax,%eax
   43045:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   43048:	0f 8c 58 ff ff ff    	jl     42fa6 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   4304e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43052:	48 8b 50 18          	mov    0x18(%rax),%rdx
   43056:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4305a:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   43061:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43066:	c9                   	leave  
   43067:	c3                   	ret    

0000000000043068 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   43068:	55                   	push   %rbp
   43069:	48 89 e5             	mov    %rsp,%rbp
   4306c:	48 83 ec 70          	sub    $0x70,%rsp
   43070:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   43074:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   43078:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   4307c:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   43080:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43084:	48 8b 40 10          	mov    0x10(%rax),%rax
   43088:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   4308c:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43090:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43094:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43098:	48 01 d0             	add    %rdx,%rax
   4309b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4309f:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   430a3:	48 8b 50 28          	mov    0x28(%rax),%rdx
   430a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430ab:	48 01 d0             	add    %rdx,%rax
   430ae:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   430b2:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   430b9:	ff 

	// virtual addressing
	for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   430ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430be:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   430c2:	e9 8f 00 00 00       	jmp    43156 <program_load_segment+0xee>
		uintptr_t pa;
		if (next_free_page(&pa) < 0
   430c7:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   430cb:	48 89 c7             	mov    %rax,%rdi
   430ce:	e8 64 d2 ff ff       	call   40337 <next_free_page>
   430d3:	85 c0                	test   %eax,%eax
   430d5:	78 45                	js     4311c <program_load_segment+0xb4>
			|| assign_physical_page(pa, p->p_pid) < 0
   430d7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   430db:	8b 00                	mov    (%rax),%eax
   430dd:	0f be d0             	movsbl %al,%edx
   430e0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   430e4:	89 d6                	mov    %edx,%esi
   430e6:	48 89 c7             	mov    %rax,%rdi
   430e9:	e8 18 d5 ff ff       	call   40606 <assign_physical_page>
   430ee:	85 c0                	test   %eax,%eax
   430f0:	78 2a                	js     4311c <program_load_segment+0xb4>
			|| virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE, PTE_P | PTE_W | PTE_U) < 0) {
   430f2:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   430f6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   430fa:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43101:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43105:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4310b:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43110:	48 89 c7             	mov    %rax,%rdi
   43113:	e8 3f f9 ff ff       	call   42a57 <virtual_memory_map>
   43118:	85 c0                	test   %eax,%eax
   4311a:	79 32                	jns    4314e <program_load_segment+0xe6>

			console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   4311c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43120:	8b 00                	mov    (%rax),%eax
   43122:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43126:	49 89 d0             	mov    %rdx,%r8
   43129:	89 c1                	mov    %eax,%ecx
   4312b:	ba 80 4d 04 00       	mov    $0x44d80,%edx
   43130:	be 00 c0 00 00       	mov    $0xc000,%esi
   43135:	bf e0 06 00 00       	mov    $0x6e0,%edi
   4313a:	b8 00 00 00 00       	mov    $0x0,%eax
   4313f:	e8 a6 0f 00 00       	call   440ea <console_printf>
			return -1;
   43144:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43149:	e9 e5 00 00 00       	jmp    43233 <program_load_segment+0x1cb>
	for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4314e:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43155:	00 
   43156:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4315a:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   4315e:	0f 82 63 ff ff ff    	jb     430c7 <program_load_segment+0x5f>
    *     }
    * }
	*/

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43164:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43168:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   4316f:	48 89 c7             	mov    %rax,%rdi
   43172:	e8 af f7 ff ff       	call   42926 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   43177:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4317b:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   4317f:	48 89 c2             	mov    %rax,%rdx
   43182:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43186:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   4318a:	48 89 ce             	mov    %rcx,%rsi
   4318d:	48 89 c7             	mov    %rax,%rdi
   43190:	e8 a0 00 00 00       	call   43235 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   43195:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43199:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   4319d:	48 89 c2             	mov    %rax,%rdx
   431a0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   431a4:	be 00 00 00 00       	mov    $0x0,%esi
   431a9:	48 89 c7             	mov    %rax,%rdi
   431ac:	e8 82 01 00 00       	call   43333 <memset>

	// change to readonly permissions
	if ((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   431b1:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   431b5:	8b 40 04             	mov    0x4(%rax),%eax
   431b8:	83 e0 02             	and    $0x2,%eax
   431bb:	85 c0                	test   %eax,%eax
   431bd:	75 60                	jne    4321f <program_load_segment+0x1b7>
		for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   431bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   431c3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   431c7:	eb 4c                	jmp    43215 <program_load_segment+0x1ad>
			vamapping map = virtual_memory_lookup(p->p_pagetable, addr);
   431c9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   431cd:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   431d4:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   431d8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   431dc:	48 89 ce             	mov    %rcx,%rsi
   431df:	48 89 c7             	mov    %rax,%rdi
   431e2:	e8 36 fc ff ff       	call   42e1d <virtual_memory_lookup>
			virtual_memory_map(p->p_pagetable, addr, map.pa, PAGESIZE, PTE_P | PTE_U );
   431e7:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   431eb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   431ef:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   431f6:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   431fa:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43200:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43205:	48 89 c7             	mov    %rax,%rdi
   43208:	e8 4a f8 ff ff       	call   42a57 <virtual_memory_map>
		for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4320d:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   43214:	00 
   43215:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43219:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   4321d:	72 aa                	jb     431c9 <program_load_segment+0x161>
		}
	}

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   4321f:	48 8b 05 da 0d 01 00 	mov    0x10dda(%rip),%rax        # 54000 <kernel_pagetable>
   43226:	48 89 c7             	mov    %rax,%rdi
   43229:	e8 f8 f6 ff ff       	call   42926 <set_pagetable>
    return 0;
   4322e:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43233:	c9                   	leave  
   43234:	c3                   	ret    

0000000000043235 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43235:	55                   	push   %rbp
   43236:	48 89 e5             	mov    %rsp,%rbp
   43239:	48 83 ec 28          	sub    $0x28,%rsp
   4323d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43241:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43245:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43249:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4324d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43251:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43255:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43259:	eb 1c                	jmp    43277 <memcpy+0x42>
        *d = *s;
   4325b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4325f:	0f b6 10             	movzbl (%rax),%edx
   43262:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43266:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43268:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   4326d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43272:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43277:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4327c:	75 dd                	jne    4325b <memcpy+0x26>
    }
    return dst;
   4327e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43282:	c9                   	leave  
   43283:	c3                   	ret    

0000000000043284 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43284:	55                   	push   %rbp
   43285:	48 89 e5             	mov    %rsp,%rbp
   43288:	48 83 ec 28          	sub    $0x28,%rsp
   4328c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43290:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43294:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43298:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4329c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   432a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432a4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   432a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   432ac:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   432b0:	73 6a                	jae    4331c <memmove+0x98>
   432b2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   432b6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432ba:	48 01 d0             	add    %rdx,%rax
   432bd:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   432c1:	73 59                	jae    4331c <memmove+0x98>
        s += n, d += n;
   432c3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432c7:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   432cb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432cf:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   432d3:	eb 17                	jmp    432ec <memmove+0x68>
            *--d = *--s;
   432d5:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   432da:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   432df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   432e3:	0f b6 10             	movzbl (%rax),%edx
   432e6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432ea:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   432ec:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432f0:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   432f4:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   432f8:	48 85 c0             	test   %rax,%rax
   432fb:	75 d8                	jne    432d5 <memmove+0x51>
    if (s < d && s + n > d) {
   432fd:	eb 2e                	jmp    4332d <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   432ff:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43303:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43307:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4330b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4330f:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43313:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43317:	0f b6 12             	movzbl (%rdx),%edx
   4331a:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   4331c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43320:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43324:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43328:	48 85 c0             	test   %rax,%rax
   4332b:	75 d2                	jne    432ff <memmove+0x7b>
        }
    }
    return dst;
   4332d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43331:	c9                   	leave  
   43332:	c3                   	ret    

0000000000043333 <memset>:

void* memset(void* v, int c, size_t n) {
   43333:	55                   	push   %rbp
   43334:	48 89 e5             	mov    %rsp,%rbp
   43337:	48 83 ec 28          	sub    $0x28,%rsp
   4333b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4333f:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43342:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43346:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4334a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4334e:	eb 15                	jmp    43365 <memset+0x32>
        *p = c;
   43350:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43353:	89 c2                	mov    %eax,%edx
   43355:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43359:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   4335b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43360:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43365:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4336a:	75 e4                	jne    43350 <memset+0x1d>
    }
    return v;
   4336c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43370:	c9                   	leave  
   43371:	c3                   	ret    

0000000000043372 <strlen>:

size_t strlen(const char* s) {
   43372:	55                   	push   %rbp
   43373:	48 89 e5             	mov    %rsp,%rbp
   43376:	48 83 ec 18          	sub    $0x18,%rsp
   4337a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   4337e:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43385:	00 
   43386:	eb 0a                	jmp    43392 <strlen+0x20>
        ++n;
   43388:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   4338d:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43392:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43396:	0f b6 00             	movzbl (%rax),%eax
   43399:	84 c0                	test   %al,%al
   4339b:	75 eb                	jne    43388 <strlen+0x16>
    }
    return n;
   4339d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   433a1:	c9                   	leave  
   433a2:	c3                   	ret    

00000000000433a3 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   433a3:	55                   	push   %rbp
   433a4:	48 89 e5             	mov    %rsp,%rbp
   433a7:	48 83 ec 20          	sub    $0x20,%rsp
   433ab:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   433af:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   433b3:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   433ba:	00 
   433bb:	eb 0a                	jmp    433c7 <strnlen+0x24>
        ++n;
   433bd:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   433c2:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   433c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   433cb:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   433cf:	74 0b                	je     433dc <strnlen+0x39>
   433d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433d5:	0f b6 00             	movzbl (%rax),%eax
   433d8:	84 c0                	test   %al,%al
   433da:	75 e1                	jne    433bd <strnlen+0x1a>
    }
    return n;
   433dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   433e0:	c9                   	leave  
   433e1:	c3                   	ret    

00000000000433e2 <strcpy>:

char* strcpy(char* dst, const char* src) {
   433e2:	55                   	push   %rbp
   433e3:	48 89 e5             	mov    %rsp,%rbp
   433e6:	48 83 ec 20          	sub    $0x20,%rsp
   433ea:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   433ee:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   433f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433f6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   433fa:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   433fe:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43402:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43406:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4340a:	48 8d 48 01          	lea    0x1(%rax),%rcx
   4340e:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43412:	0f b6 12             	movzbl (%rdx),%edx
   43415:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43417:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4341b:	48 83 e8 01          	sub    $0x1,%rax
   4341f:	0f b6 00             	movzbl (%rax),%eax
   43422:	84 c0                	test   %al,%al
   43424:	75 d4                	jne    433fa <strcpy+0x18>
    return dst;
   43426:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4342a:	c9                   	leave  
   4342b:	c3                   	ret    

000000000004342c <strcmp>:

int strcmp(const char* a, const char* b) {
   4342c:	55                   	push   %rbp
   4342d:	48 89 e5             	mov    %rsp,%rbp
   43430:	48 83 ec 10          	sub    $0x10,%rsp
   43434:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43438:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   4343c:	eb 0a                	jmp    43448 <strcmp+0x1c>
        ++a, ++b;
   4343e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43443:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43448:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4344c:	0f b6 00             	movzbl (%rax),%eax
   4344f:	84 c0                	test   %al,%al
   43451:	74 1d                	je     43470 <strcmp+0x44>
   43453:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43457:	0f b6 00             	movzbl (%rax),%eax
   4345a:	84 c0                	test   %al,%al
   4345c:	74 12                	je     43470 <strcmp+0x44>
   4345e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43462:	0f b6 10             	movzbl (%rax),%edx
   43465:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43469:	0f b6 00             	movzbl (%rax),%eax
   4346c:	38 c2                	cmp    %al,%dl
   4346e:	74 ce                	je     4343e <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43470:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43474:	0f b6 00             	movzbl (%rax),%eax
   43477:	89 c2                	mov    %eax,%edx
   43479:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4347d:	0f b6 00             	movzbl (%rax),%eax
   43480:	38 d0                	cmp    %dl,%al
   43482:	0f 92 c0             	setb   %al
   43485:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43488:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4348c:	0f b6 00             	movzbl (%rax),%eax
   4348f:	89 c1                	mov    %eax,%ecx
   43491:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43495:	0f b6 00             	movzbl (%rax),%eax
   43498:	38 c1                	cmp    %al,%cl
   4349a:	0f 92 c0             	setb   %al
   4349d:	0f b6 c0             	movzbl %al,%eax
   434a0:	29 c2                	sub    %eax,%edx
   434a2:	89 d0                	mov    %edx,%eax
}
   434a4:	c9                   	leave  
   434a5:	c3                   	ret    

00000000000434a6 <strchr>:

char* strchr(const char* s, int c) {
   434a6:	55                   	push   %rbp
   434a7:	48 89 e5             	mov    %rsp,%rbp
   434aa:	48 83 ec 10          	sub    $0x10,%rsp
   434ae:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   434b2:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   434b5:	eb 05                	jmp    434bc <strchr+0x16>
        ++s;
   434b7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   434bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434c0:	0f b6 00             	movzbl (%rax),%eax
   434c3:	84 c0                	test   %al,%al
   434c5:	74 0e                	je     434d5 <strchr+0x2f>
   434c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434cb:	0f b6 00             	movzbl (%rax),%eax
   434ce:	8b 55 f4             	mov    -0xc(%rbp),%edx
   434d1:	38 d0                	cmp    %dl,%al
   434d3:	75 e2                	jne    434b7 <strchr+0x11>
    }
    if (*s == (char) c) {
   434d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434d9:	0f b6 00             	movzbl (%rax),%eax
   434dc:	8b 55 f4             	mov    -0xc(%rbp),%edx
   434df:	38 d0                	cmp    %dl,%al
   434e1:	75 06                	jne    434e9 <strchr+0x43>
        return (char*) s;
   434e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434e7:	eb 05                	jmp    434ee <strchr+0x48>
    } else {
        return NULL;
   434e9:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   434ee:	c9                   	leave  
   434ef:	c3                   	ret    

00000000000434f0 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   434f0:	55                   	push   %rbp
   434f1:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   434f4:	8b 05 06 6b 01 00    	mov    0x16b06(%rip),%eax        # 5a000 <rand_seed_set>
   434fa:	85 c0                	test   %eax,%eax
   434fc:	75 0a                	jne    43508 <rand+0x18>
        srand(819234718U);
   434fe:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43503:	e8 24 00 00 00       	call   4352c <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43508:	8b 05 f6 6a 01 00    	mov    0x16af6(%rip),%eax        # 5a004 <rand_seed>
   4350e:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43514:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43519:	89 05 e5 6a 01 00    	mov    %eax,0x16ae5(%rip)        # 5a004 <rand_seed>
    return rand_seed & RAND_MAX;
   4351f:	8b 05 df 6a 01 00    	mov    0x16adf(%rip),%eax        # 5a004 <rand_seed>
   43525:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   4352a:	5d                   	pop    %rbp
   4352b:	c3                   	ret    

000000000004352c <srand>:

void srand(unsigned seed) {
   4352c:	55                   	push   %rbp
   4352d:	48 89 e5             	mov    %rsp,%rbp
   43530:	48 83 ec 08          	sub    $0x8,%rsp
   43534:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43537:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4353a:	89 05 c4 6a 01 00    	mov    %eax,0x16ac4(%rip)        # 5a004 <rand_seed>
    rand_seed_set = 1;
   43540:	c7 05 b6 6a 01 00 01 	movl   $0x1,0x16ab6(%rip)        # 5a000 <rand_seed_set>
   43547:	00 00 00 
}
   4354a:	90                   	nop
   4354b:	c9                   	leave  
   4354c:	c3                   	ret    

000000000004354d <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   4354d:	55                   	push   %rbp
   4354e:	48 89 e5             	mov    %rsp,%rbp
   43551:	48 83 ec 28          	sub    $0x28,%rsp
   43555:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43559:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   4355d:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43560:	48 c7 45 f8 a0 4f 04 	movq   $0x44fa0,-0x8(%rbp)
   43567:	00 
    if (base < 0) {
   43568:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   4356c:	79 0b                	jns    43579 <fill_numbuf+0x2c>
        digits = lower_digits;
   4356e:	48 c7 45 f8 c0 4f 04 	movq   $0x44fc0,-0x8(%rbp)
   43575:	00 
        base = -base;
   43576:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43579:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   4357e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43582:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43585:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43588:	48 63 c8             	movslq %eax,%rcx
   4358b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4358f:	ba 00 00 00 00       	mov    $0x0,%edx
   43594:	48 f7 f1             	div    %rcx
   43597:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4359b:	48 01 d0             	add    %rdx,%rax
   4359e:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   435a3:	0f b6 10             	movzbl (%rax),%edx
   435a6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435aa:	88 10                	mov    %dl,(%rax)
        val /= base;
   435ac:	8b 45 dc             	mov    -0x24(%rbp),%eax
   435af:	48 63 f0             	movslq %eax,%rsi
   435b2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   435b6:	ba 00 00 00 00       	mov    $0x0,%edx
   435bb:	48 f7 f6             	div    %rsi
   435be:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   435c2:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   435c7:	75 bc                	jne    43585 <fill_numbuf+0x38>
    return numbuf_end;
   435c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   435cd:	c9                   	leave  
   435ce:	c3                   	ret    

00000000000435cf <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   435cf:	55                   	push   %rbp
   435d0:	48 89 e5             	mov    %rsp,%rbp
   435d3:	53                   	push   %rbx
   435d4:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   435db:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   435e2:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   435e8:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   435ef:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   435f6:	e9 8a 09 00 00       	jmp    43f85 <printer_vprintf+0x9b6>
        if (*format != '%') {
   435fb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43602:	0f b6 00             	movzbl (%rax),%eax
   43605:	3c 25                	cmp    $0x25,%al
   43607:	74 31                	je     4363a <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   43609:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43610:	4c 8b 00             	mov    (%rax),%r8
   43613:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4361a:	0f b6 00             	movzbl (%rax),%eax
   4361d:	0f b6 c8             	movzbl %al,%ecx
   43620:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43626:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4362d:	89 ce                	mov    %ecx,%esi
   4362f:	48 89 c7             	mov    %rax,%rdi
   43632:	41 ff d0             	call   *%r8
            continue;
   43635:	e9 43 09 00 00       	jmp    43f7d <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   4363a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   43641:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43648:	01 
   43649:	eb 44                	jmp    4368f <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   4364b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43652:	0f b6 00             	movzbl (%rax),%eax
   43655:	0f be c0             	movsbl %al,%eax
   43658:	89 c6                	mov    %eax,%esi
   4365a:	bf c0 4d 04 00       	mov    $0x44dc0,%edi
   4365f:	e8 42 fe ff ff       	call   434a6 <strchr>
   43664:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43668:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   4366d:	74 30                	je     4369f <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   4366f:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43673:	48 2d c0 4d 04 00    	sub    $0x44dc0,%rax
   43679:	ba 01 00 00 00       	mov    $0x1,%edx
   4367e:	89 c1                	mov    %eax,%ecx
   43680:	d3 e2                	shl    %cl,%edx
   43682:	89 d0                	mov    %edx,%eax
   43684:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   43687:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4368e:	01 
   4368f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43696:	0f b6 00             	movzbl (%rax),%eax
   43699:	84 c0                	test   %al,%al
   4369b:	75 ae                	jne    4364b <printer_vprintf+0x7c>
   4369d:	eb 01                	jmp    436a0 <printer_vprintf+0xd1>
            } else {
                break;
   4369f:	90                   	nop
            }
        }

        // process width
        int width = -1;
   436a0:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   436a7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   436ae:	0f b6 00             	movzbl (%rax),%eax
   436b1:	3c 30                	cmp    $0x30,%al
   436b3:	7e 67                	jle    4371c <printer_vprintf+0x14d>
   436b5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   436bc:	0f b6 00             	movzbl (%rax),%eax
   436bf:	3c 39                	cmp    $0x39,%al
   436c1:	7f 59                	jg     4371c <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   436c3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   436ca:	eb 2e                	jmp    436fa <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   436cc:	8b 55 e8             	mov    -0x18(%rbp),%edx
   436cf:	89 d0                	mov    %edx,%eax
   436d1:	c1 e0 02             	shl    $0x2,%eax
   436d4:	01 d0                	add    %edx,%eax
   436d6:	01 c0                	add    %eax,%eax
   436d8:	89 c1                	mov    %eax,%ecx
   436da:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   436e1:	48 8d 50 01          	lea    0x1(%rax),%rdx
   436e5:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   436ec:	0f b6 00             	movzbl (%rax),%eax
   436ef:	0f be c0             	movsbl %al,%eax
   436f2:	01 c8                	add    %ecx,%eax
   436f4:	83 e8 30             	sub    $0x30,%eax
   436f7:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   436fa:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43701:	0f b6 00             	movzbl (%rax),%eax
   43704:	3c 2f                	cmp    $0x2f,%al
   43706:	0f 8e 85 00 00 00    	jle    43791 <printer_vprintf+0x1c2>
   4370c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43713:	0f b6 00             	movzbl (%rax),%eax
   43716:	3c 39                	cmp    $0x39,%al
   43718:	7e b2                	jle    436cc <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   4371a:	eb 75                	jmp    43791 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   4371c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43723:	0f b6 00             	movzbl (%rax),%eax
   43726:	3c 2a                	cmp    $0x2a,%al
   43728:	75 68                	jne    43792 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   4372a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43731:	8b 00                	mov    (%rax),%eax
   43733:	83 f8 2f             	cmp    $0x2f,%eax
   43736:	77 30                	ja     43768 <printer_vprintf+0x199>
   43738:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4373f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43743:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4374a:	8b 00                	mov    (%rax),%eax
   4374c:	89 c0                	mov    %eax,%eax
   4374e:	48 01 d0             	add    %rdx,%rax
   43751:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43758:	8b 12                	mov    (%rdx),%edx
   4375a:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4375d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43764:	89 0a                	mov    %ecx,(%rdx)
   43766:	eb 1a                	jmp    43782 <printer_vprintf+0x1b3>
   43768:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4376f:	48 8b 40 08          	mov    0x8(%rax),%rax
   43773:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43777:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4377e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43782:	8b 00                	mov    (%rax),%eax
   43784:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   43787:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4378e:	01 
   4378f:	eb 01                	jmp    43792 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   43791:	90                   	nop
        }

        // process precision
        int precision = -1;
   43792:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   43799:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   437a0:	0f b6 00             	movzbl (%rax),%eax
   437a3:	3c 2e                	cmp    $0x2e,%al
   437a5:	0f 85 00 01 00 00    	jne    438ab <printer_vprintf+0x2dc>
            ++format;
   437ab:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   437b2:	01 
            if (*format >= '0' && *format <= '9') {
   437b3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   437ba:	0f b6 00             	movzbl (%rax),%eax
   437bd:	3c 2f                	cmp    $0x2f,%al
   437bf:	7e 67                	jle    43828 <printer_vprintf+0x259>
   437c1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   437c8:	0f b6 00             	movzbl (%rax),%eax
   437cb:	3c 39                	cmp    $0x39,%al
   437cd:	7f 59                	jg     43828 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   437cf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   437d6:	eb 2e                	jmp    43806 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   437d8:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   437db:	89 d0                	mov    %edx,%eax
   437dd:	c1 e0 02             	shl    $0x2,%eax
   437e0:	01 d0                	add    %edx,%eax
   437e2:	01 c0                	add    %eax,%eax
   437e4:	89 c1                	mov    %eax,%ecx
   437e6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   437ed:	48 8d 50 01          	lea    0x1(%rax),%rdx
   437f1:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   437f8:	0f b6 00             	movzbl (%rax),%eax
   437fb:	0f be c0             	movsbl %al,%eax
   437fe:	01 c8                	add    %ecx,%eax
   43800:	83 e8 30             	sub    $0x30,%eax
   43803:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43806:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4380d:	0f b6 00             	movzbl (%rax),%eax
   43810:	3c 2f                	cmp    $0x2f,%al
   43812:	0f 8e 85 00 00 00    	jle    4389d <printer_vprintf+0x2ce>
   43818:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4381f:	0f b6 00             	movzbl (%rax),%eax
   43822:	3c 39                	cmp    $0x39,%al
   43824:	7e b2                	jle    437d8 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   43826:	eb 75                	jmp    4389d <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   43828:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4382f:	0f b6 00             	movzbl (%rax),%eax
   43832:	3c 2a                	cmp    $0x2a,%al
   43834:	75 68                	jne    4389e <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   43836:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4383d:	8b 00                	mov    (%rax),%eax
   4383f:	83 f8 2f             	cmp    $0x2f,%eax
   43842:	77 30                	ja     43874 <printer_vprintf+0x2a5>
   43844:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4384b:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4384f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43856:	8b 00                	mov    (%rax),%eax
   43858:	89 c0                	mov    %eax,%eax
   4385a:	48 01 d0             	add    %rdx,%rax
   4385d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43864:	8b 12                	mov    (%rdx),%edx
   43866:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43869:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43870:	89 0a                	mov    %ecx,(%rdx)
   43872:	eb 1a                	jmp    4388e <printer_vprintf+0x2bf>
   43874:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4387b:	48 8b 40 08          	mov    0x8(%rax),%rax
   4387f:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43883:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4388a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4388e:	8b 00                	mov    (%rax),%eax
   43890:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   43893:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4389a:	01 
   4389b:	eb 01                	jmp    4389e <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   4389d:	90                   	nop
            }
            if (precision < 0) {
   4389e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   438a2:	79 07                	jns    438ab <printer_vprintf+0x2dc>
                precision = 0;
   438a4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   438ab:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   438b2:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   438b9:	00 
        int length = 0;
   438ba:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   438c1:	48 c7 45 c8 c6 4d 04 	movq   $0x44dc6,-0x38(%rbp)
   438c8:	00 
    again:
        switch (*format) {
   438c9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   438d0:	0f b6 00             	movzbl (%rax),%eax
   438d3:	0f be c0             	movsbl %al,%eax
   438d6:	83 e8 43             	sub    $0x43,%eax
   438d9:	83 f8 37             	cmp    $0x37,%eax
   438dc:	0f 87 9f 03 00 00    	ja     43c81 <printer_vprintf+0x6b2>
   438e2:	89 c0                	mov    %eax,%eax
   438e4:	48 8b 04 c5 d8 4d 04 	mov    0x44dd8(,%rax,8),%rax
   438eb:	00 
   438ec:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   438ee:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   438f5:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   438fc:	01 
            goto again;
   438fd:	eb ca                	jmp    438c9 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   438ff:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43903:	74 5d                	je     43962 <printer_vprintf+0x393>
   43905:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4390c:	8b 00                	mov    (%rax),%eax
   4390e:	83 f8 2f             	cmp    $0x2f,%eax
   43911:	77 30                	ja     43943 <printer_vprintf+0x374>
   43913:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4391a:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4391e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43925:	8b 00                	mov    (%rax),%eax
   43927:	89 c0                	mov    %eax,%eax
   43929:	48 01 d0             	add    %rdx,%rax
   4392c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43933:	8b 12                	mov    (%rdx),%edx
   43935:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43938:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4393f:	89 0a                	mov    %ecx,(%rdx)
   43941:	eb 1a                	jmp    4395d <printer_vprintf+0x38e>
   43943:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4394a:	48 8b 40 08          	mov    0x8(%rax),%rax
   4394e:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43952:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43959:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4395d:	48 8b 00             	mov    (%rax),%rax
   43960:	eb 5c                	jmp    439be <printer_vprintf+0x3ef>
   43962:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43969:	8b 00                	mov    (%rax),%eax
   4396b:	83 f8 2f             	cmp    $0x2f,%eax
   4396e:	77 30                	ja     439a0 <printer_vprintf+0x3d1>
   43970:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43977:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4397b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43982:	8b 00                	mov    (%rax),%eax
   43984:	89 c0                	mov    %eax,%eax
   43986:	48 01 d0             	add    %rdx,%rax
   43989:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43990:	8b 12                	mov    (%rdx),%edx
   43992:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43995:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4399c:	89 0a                	mov    %ecx,(%rdx)
   4399e:	eb 1a                	jmp    439ba <printer_vprintf+0x3eb>
   439a0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439a7:	48 8b 40 08          	mov    0x8(%rax),%rax
   439ab:	48 8d 48 08          	lea    0x8(%rax),%rcx
   439af:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   439b6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   439ba:	8b 00                	mov    (%rax),%eax
   439bc:	48 98                	cltq   
   439be:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   439c2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   439c6:	48 c1 f8 38          	sar    $0x38,%rax
   439ca:	25 80 00 00 00       	and    $0x80,%eax
   439cf:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   439d2:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   439d6:	74 09                	je     439e1 <printer_vprintf+0x412>
   439d8:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   439dc:	48 f7 d8             	neg    %rax
   439df:	eb 04                	jmp    439e5 <printer_vprintf+0x416>
   439e1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   439e5:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   439e9:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   439ec:	83 c8 60             	or     $0x60,%eax
   439ef:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   439f2:	e9 cf 02 00 00       	jmp    43cc6 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   439f7:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   439fb:	74 5d                	je     43a5a <printer_vprintf+0x48b>
   439fd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a04:	8b 00                	mov    (%rax),%eax
   43a06:	83 f8 2f             	cmp    $0x2f,%eax
   43a09:	77 30                	ja     43a3b <printer_vprintf+0x46c>
   43a0b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a12:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43a16:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a1d:	8b 00                	mov    (%rax),%eax
   43a1f:	89 c0                	mov    %eax,%eax
   43a21:	48 01 d0             	add    %rdx,%rax
   43a24:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a2b:	8b 12                	mov    (%rdx),%edx
   43a2d:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43a30:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a37:	89 0a                	mov    %ecx,(%rdx)
   43a39:	eb 1a                	jmp    43a55 <printer_vprintf+0x486>
   43a3b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a42:	48 8b 40 08          	mov    0x8(%rax),%rax
   43a46:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43a4a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a51:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43a55:	48 8b 00             	mov    (%rax),%rax
   43a58:	eb 5c                	jmp    43ab6 <printer_vprintf+0x4e7>
   43a5a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a61:	8b 00                	mov    (%rax),%eax
   43a63:	83 f8 2f             	cmp    $0x2f,%eax
   43a66:	77 30                	ja     43a98 <printer_vprintf+0x4c9>
   43a68:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a6f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43a73:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a7a:	8b 00                	mov    (%rax),%eax
   43a7c:	89 c0                	mov    %eax,%eax
   43a7e:	48 01 d0             	add    %rdx,%rax
   43a81:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a88:	8b 12                	mov    (%rdx),%edx
   43a8a:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43a8d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a94:	89 0a                	mov    %ecx,(%rdx)
   43a96:	eb 1a                	jmp    43ab2 <printer_vprintf+0x4e3>
   43a98:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a9f:	48 8b 40 08          	mov    0x8(%rax),%rax
   43aa3:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43aa7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43aae:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43ab2:	8b 00                	mov    (%rax),%eax
   43ab4:	89 c0                	mov    %eax,%eax
   43ab6:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   43aba:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   43abe:	e9 03 02 00 00       	jmp    43cc6 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   43ac3:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   43aca:	e9 28 ff ff ff       	jmp    439f7 <printer_vprintf+0x428>
        case 'X':
            base = 16;
   43acf:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   43ad6:	e9 1c ff ff ff       	jmp    439f7 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   43adb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ae2:	8b 00                	mov    (%rax),%eax
   43ae4:	83 f8 2f             	cmp    $0x2f,%eax
   43ae7:	77 30                	ja     43b19 <printer_vprintf+0x54a>
   43ae9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43af0:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43af4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43afb:	8b 00                	mov    (%rax),%eax
   43afd:	89 c0                	mov    %eax,%eax
   43aff:	48 01 d0             	add    %rdx,%rax
   43b02:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b09:	8b 12                	mov    (%rdx),%edx
   43b0b:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43b0e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b15:	89 0a                	mov    %ecx,(%rdx)
   43b17:	eb 1a                	jmp    43b33 <printer_vprintf+0x564>
   43b19:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b20:	48 8b 40 08          	mov    0x8(%rax),%rax
   43b24:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43b28:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b2f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43b33:	48 8b 00             	mov    (%rax),%rax
   43b36:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   43b3a:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   43b41:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   43b48:	e9 79 01 00 00       	jmp    43cc6 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   43b4d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b54:	8b 00                	mov    (%rax),%eax
   43b56:	83 f8 2f             	cmp    $0x2f,%eax
   43b59:	77 30                	ja     43b8b <printer_vprintf+0x5bc>
   43b5b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b62:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43b66:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b6d:	8b 00                	mov    (%rax),%eax
   43b6f:	89 c0                	mov    %eax,%eax
   43b71:	48 01 d0             	add    %rdx,%rax
   43b74:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b7b:	8b 12                	mov    (%rdx),%edx
   43b7d:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43b80:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b87:	89 0a                	mov    %ecx,(%rdx)
   43b89:	eb 1a                	jmp    43ba5 <printer_vprintf+0x5d6>
   43b8b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b92:	48 8b 40 08          	mov    0x8(%rax),%rax
   43b96:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43b9a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ba1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43ba5:	48 8b 00             	mov    (%rax),%rax
   43ba8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   43bac:	e9 15 01 00 00       	jmp    43cc6 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   43bb1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bb8:	8b 00                	mov    (%rax),%eax
   43bba:	83 f8 2f             	cmp    $0x2f,%eax
   43bbd:	77 30                	ja     43bef <printer_vprintf+0x620>
   43bbf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bc6:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43bca:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bd1:	8b 00                	mov    (%rax),%eax
   43bd3:	89 c0                	mov    %eax,%eax
   43bd5:	48 01 d0             	add    %rdx,%rax
   43bd8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43bdf:	8b 12                	mov    (%rdx),%edx
   43be1:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43be4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43beb:	89 0a                	mov    %ecx,(%rdx)
   43bed:	eb 1a                	jmp    43c09 <printer_vprintf+0x63a>
   43bef:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bf6:	48 8b 40 08          	mov    0x8(%rax),%rax
   43bfa:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43bfe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c05:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43c09:	8b 00                	mov    (%rax),%eax
   43c0b:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   43c11:	e9 67 03 00 00       	jmp    43f7d <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   43c16:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43c1a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   43c1e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c25:	8b 00                	mov    (%rax),%eax
   43c27:	83 f8 2f             	cmp    $0x2f,%eax
   43c2a:	77 30                	ja     43c5c <printer_vprintf+0x68d>
   43c2c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c33:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43c37:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c3e:	8b 00                	mov    (%rax),%eax
   43c40:	89 c0                	mov    %eax,%eax
   43c42:	48 01 d0             	add    %rdx,%rax
   43c45:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c4c:	8b 12                	mov    (%rdx),%edx
   43c4e:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43c51:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c58:	89 0a                	mov    %ecx,(%rdx)
   43c5a:	eb 1a                	jmp    43c76 <printer_vprintf+0x6a7>
   43c5c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c63:	48 8b 40 08          	mov    0x8(%rax),%rax
   43c67:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43c6b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c72:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43c76:	8b 00                	mov    (%rax),%eax
   43c78:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43c7b:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   43c7f:	eb 45                	jmp    43cc6 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   43c81:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43c85:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   43c89:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43c90:	0f b6 00             	movzbl (%rax),%eax
   43c93:	84 c0                	test   %al,%al
   43c95:	74 0c                	je     43ca3 <printer_vprintf+0x6d4>
   43c97:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43c9e:	0f b6 00             	movzbl (%rax),%eax
   43ca1:	eb 05                	jmp    43ca8 <printer_vprintf+0x6d9>
   43ca3:	b8 25 00 00 00       	mov    $0x25,%eax
   43ca8:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43cab:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   43caf:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43cb6:	0f b6 00             	movzbl (%rax),%eax
   43cb9:	84 c0                	test   %al,%al
   43cbb:	75 08                	jne    43cc5 <printer_vprintf+0x6f6>
                format--;
   43cbd:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   43cc4:	01 
            }
            break;
   43cc5:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   43cc6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43cc9:	83 e0 20             	and    $0x20,%eax
   43ccc:	85 c0                	test   %eax,%eax
   43cce:	74 1e                	je     43cee <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   43cd0:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43cd4:	48 83 c0 18          	add    $0x18,%rax
   43cd8:	8b 55 e0             	mov    -0x20(%rbp),%edx
   43cdb:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   43cdf:	48 89 ce             	mov    %rcx,%rsi
   43ce2:	48 89 c7             	mov    %rax,%rdi
   43ce5:	e8 63 f8 ff ff       	call   4354d <fill_numbuf>
   43cea:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   43cee:	48 c7 45 c0 c6 4d 04 	movq   $0x44dc6,-0x40(%rbp)
   43cf5:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   43cf6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43cf9:	83 e0 20             	and    $0x20,%eax
   43cfc:	85 c0                	test   %eax,%eax
   43cfe:	74 48                	je     43d48 <printer_vprintf+0x779>
   43d00:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d03:	83 e0 40             	and    $0x40,%eax
   43d06:	85 c0                	test   %eax,%eax
   43d08:	74 3e                	je     43d48 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   43d0a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d0d:	25 80 00 00 00       	and    $0x80,%eax
   43d12:	85 c0                	test   %eax,%eax
   43d14:	74 0a                	je     43d20 <printer_vprintf+0x751>
                prefix = "-";
   43d16:	48 c7 45 c0 c7 4d 04 	movq   $0x44dc7,-0x40(%rbp)
   43d1d:	00 
            if (flags & FLAG_NEGATIVE) {
   43d1e:	eb 73                	jmp    43d93 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   43d20:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d23:	83 e0 10             	and    $0x10,%eax
   43d26:	85 c0                	test   %eax,%eax
   43d28:	74 0a                	je     43d34 <printer_vprintf+0x765>
                prefix = "+";
   43d2a:	48 c7 45 c0 c9 4d 04 	movq   $0x44dc9,-0x40(%rbp)
   43d31:	00 
            if (flags & FLAG_NEGATIVE) {
   43d32:	eb 5f                	jmp    43d93 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   43d34:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d37:	83 e0 08             	and    $0x8,%eax
   43d3a:	85 c0                	test   %eax,%eax
   43d3c:	74 55                	je     43d93 <printer_vprintf+0x7c4>
                prefix = " ";
   43d3e:	48 c7 45 c0 cb 4d 04 	movq   $0x44dcb,-0x40(%rbp)
   43d45:	00 
            if (flags & FLAG_NEGATIVE) {
   43d46:	eb 4b                	jmp    43d93 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43d48:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d4b:	83 e0 20             	and    $0x20,%eax
   43d4e:	85 c0                	test   %eax,%eax
   43d50:	74 42                	je     43d94 <printer_vprintf+0x7c5>
   43d52:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d55:	83 e0 01             	and    $0x1,%eax
   43d58:	85 c0                	test   %eax,%eax
   43d5a:	74 38                	je     43d94 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   43d5c:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   43d60:	74 06                	je     43d68 <printer_vprintf+0x799>
   43d62:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   43d66:	75 2c                	jne    43d94 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   43d68:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43d6d:	75 0c                	jne    43d7b <printer_vprintf+0x7ac>
   43d6f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d72:	25 00 01 00 00       	and    $0x100,%eax
   43d77:	85 c0                	test   %eax,%eax
   43d79:	74 19                	je     43d94 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   43d7b:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   43d7f:	75 07                	jne    43d88 <printer_vprintf+0x7b9>
   43d81:	b8 cd 4d 04 00       	mov    $0x44dcd,%eax
   43d86:	eb 05                	jmp    43d8d <printer_vprintf+0x7be>
   43d88:	b8 d0 4d 04 00       	mov    $0x44dd0,%eax
   43d8d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43d91:	eb 01                	jmp    43d94 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   43d93:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   43d94:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43d98:	78 24                	js     43dbe <printer_vprintf+0x7ef>
   43d9a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d9d:	83 e0 20             	and    $0x20,%eax
   43da0:	85 c0                	test   %eax,%eax
   43da2:	75 1a                	jne    43dbe <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   43da4:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43da7:	48 63 d0             	movslq %eax,%rdx
   43daa:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43dae:	48 89 d6             	mov    %rdx,%rsi
   43db1:	48 89 c7             	mov    %rax,%rdi
   43db4:	e8 ea f5 ff ff       	call   433a3 <strnlen>
   43db9:	89 45 bc             	mov    %eax,-0x44(%rbp)
   43dbc:	eb 0f                	jmp    43dcd <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   43dbe:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43dc2:	48 89 c7             	mov    %rax,%rdi
   43dc5:	e8 a8 f5 ff ff       	call   43372 <strlen>
   43dca:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   43dcd:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43dd0:	83 e0 20             	and    $0x20,%eax
   43dd3:	85 c0                	test   %eax,%eax
   43dd5:	74 20                	je     43df7 <printer_vprintf+0x828>
   43dd7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43ddb:	78 1a                	js     43df7 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   43ddd:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43de0:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   43de3:	7e 08                	jle    43ded <printer_vprintf+0x81e>
   43de5:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43de8:	2b 45 bc             	sub    -0x44(%rbp),%eax
   43deb:	eb 05                	jmp    43df2 <printer_vprintf+0x823>
   43ded:	b8 00 00 00 00       	mov    $0x0,%eax
   43df2:	89 45 b8             	mov    %eax,-0x48(%rbp)
   43df5:	eb 5c                	jmp    43e53 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   43df7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43dfa:	83 e0 20             	and    $0x20,%eax
   43dfd:	85 c0                	test   %eax,%eax
   43dff:	74 4b                	je     43e4c <printer_vprintf+0x87d>
   43e01:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43e04:	83 e0 02             	and    $0x2,%eax
   43e07:	85 c0                	test   %eax,%eax
   43e09:	74 41                	je     43e4c <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   43e0b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43e0e:	83 e0 04             	and    $0x4,%eax
   43e11:	85 c0                	test   %eax,%eax
   43e13:	75 37                	jne    43e4c <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   43e15:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43e19:	48 89 c7             	mov    %rax,%rdi
   43e1c:	e8 51 f5 ff ff       	call   43372 <strlen>
   43e21:	89 c2                	mov    %eax,%edx
   43e23:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43e26:	01 d0                	add    %edx,%eax
   43e28:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   43e2b:	7e 1f                	jle    43e4c <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   43e2d:	8b 45 e8             	mov    -0x18(%rbp),%eax
   43e30:	2b 45 bc             	sub    -0x44(%rbp),%eax
   43e33:	89 c3                	mov    %eax,%ebx
   43e35:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43e39:	48 89 c7             	mov    %rax,%rdi
   43e3c:	e8 31 f5 ff ff       	call   43372 <strlen>
   43e41:	89 c2                	mov    %eax,%edx
   43e43:	89 d8                	mov    %ebx,%eax
   43e45:	29 d0                	sub    %edx,%eax
   43e47:	89 45 b8             	mov    %eax,-0x48(%rbp)
   43e4a:	eb 07                	jmp    43e53 <printer_vprintf+0x884>
        } else {
            zeros = 0;
   43e4c:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   43e53:	8b 55 bc             	mov    -0x44(%rbp),%edx
   43e56:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43e59:	01 d0                	add    %edx,%eax
   43e5b:	48 63 d8             	movslq %eax,%rbx
   43e5e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43e62:	48 89 c7             	mov    %rax,%rdi
   43e65:	e8 08 f5 ff ff       	call   43372 <strlen>
   43e6a:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   43e6e:	8b 45 e8             	mov    -0x18(%rbp),%eax
   43e71:	29 d0                	sub    %edx,%eax
   43e73:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43e76:	eb 25                	jmp    43e9d <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   43e78:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43e7f:	48 8b 08             	mov    (%rax),%rcx
   43e82:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43e88:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43e8f:	be 20 00 00 00       	mov    $0x20,%esi
   43e94:	48 89 c7             	mov    %rax,%rdi
   43e97:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43e99:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   43e9d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43ea0:	83 e0 04             	and    $0x4,%eax
   43ea3:	85 c0                	test   %eax,%eax
   43ea5:	75 36                	jne    43edd <printer_vprintf+0x90e>
   43ea7:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   43eab:	7f cb                	jg     43e78 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   43ead:	eb 2e                	jmp    43edd <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   43eaf:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43eb6:	4c 8b 00             	mov    (%rax),%r8
   43eb9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43ebd:	0f b6 00             	movzbl (%rax),%eax
   43ec0:	0f b6 c8             	movzbl %al,%ecx
   43ec3:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43ec9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43ed0:	89 ce                	mov    %ecx,%esi
   43ed2:	48 89 c7             	mov    %rax,%rdi
   43ed5:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   43ed8:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   43edd:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43ee1:	0f b6 00             	movzbl (%rax),%eax
   43ee4:	84 c0                	test   %al,%al
   43ee6:	75 c7                	jne    43eaf <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   43ee8:	eb 25                	jmp    43f0f <printer_vprintf+0x940>
            p->putc(p, '0', color);
   43eea:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43ef1:	48 8b 08             	mov    (%rax),%rcx
   43ef4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43efa:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f01:	be 30 00 00 00       	mov    $0x30,%esi
   43f06:	48 89 c7             	mov    %rax,%rdi
   43f09:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   43f0b:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   43f0f:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   43f13:	7f d5                	jg     43eea <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   43f15:	eb 32                	jmp    43f49 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   43f17:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f1e:	4c 8b 00             	mov    (%rax),%r8
   43f21:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43f25:	0f b6 00             	movzbl (%rax),%eax
   43f28:	0f b6 c8             	movzbl %al,%ecx
   43f2b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43f31:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f38:	89 ce                	mov    %ecx,%esi
   43f3a:	48 89 c7             	mov    %rax,%rdi
   43f3d:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   43f40:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   43f45:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   43f49:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   43f4d:	7f c8                	jg     43f17 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   43f4f:	eb 25                	jmp    43f76 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   43f51:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f58:	48 8b 08             	mov    (%rax),%rcx
   43f5b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43f61:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f68:	be 20 00 00 00       	mov    $0x20,%esi
   43f6d:	48 89 c7             	mov    %rax,%rdi
   43f70:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   43f72:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   43f76:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   43f7a:	7f d5                	jg     43f51 <printer_vprintf+0x982>
        }
    done: ;
   43f7c:	90                   	nop
    for (; *format; ++format) {
   43f7d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43f84:	01 
   43f85:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f8c:	0f b6 00             	movzbl (%rax),%eax
   43f8f:	84 c0                	test   %al,%al
   43f91:	0f 85 64 f6 ff ff    	jne    435fb <printer_vprintf+0x2c>
    }
}
   43f97:	90                   	nop
   43f98:	90                   	nop
   43f99:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   43f9d:	c9                   	leave  
   43f9e:	c3                   	ret    

0000000000043f9f <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   43f9f:	55                   	push   %rbp
   43fa0:	48 89 e5             	mov    %rsp,%rbp
   43fa3:	48 83 ec 20          	sub    $0x20,%rsp
   43fa7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43fab:	89 f0                	mov    %esi,%eax
   43fad:	89 55 e0             	mov    %edx,-0x20(%rbp)
   43fb0:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   43fb3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43fb7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43fbb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43fbf:	48 8b 40 08          	mov    0x8(%rax),%rax
   43fc3:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   43fc8:	48 39 d0             	cmp    %rdx,%rax
   43fcb:	72 0c                	jb     43fd9 <console_putc+0x3a>
        cp->cursor = console;
   43fcd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43fd1:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   43fd8:	00 
    }
    if (c == '\n') {
   43fd9:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   43fdd:	75 78                	jne    44057 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   43fdf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43fe3:	48 8b 40 08          	mov    0x8(%rax),%rax
   43fe7:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   43fed:	48 d1 f8             	sar    %rax
   43ff0:	48 89 c1             	mov    %rax,%rcx
   43ff3:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   43ffa:	66 66 66 
   43ffd:	48 89 c8             	mov    %rcx,%rax
   44000:	48 f7 ea             	imul   %rdx
   44003:	48 c1 fa 05          	sar    $0x5,%rdx
   44007:	48 89 c8             	mov    %rcx,%rax
   4400a:	48 c1 f8 3f          	sar    $0x3f,%rax
   4400e:	48 29 c2             	sub    %rax,%rdx
   44011:	48 89 d0             	mov    %rdx,%rax
   44014:	48 c1 e0 02          	shl    $0x2,%rax
   44018:	48 01 d0             	add    %rdx,%rax
   4401b:	48 c1 e0 04          	shl    $0x4,%rax
   4401f:	48 29 c1             	sub    %rax,%rcx
   44022:	48 89 ca             	mov    %rcx,%rdx
   44025:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   44028:	eb 25                	jmp    4404f <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   4402a:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4402d:	83 c8 20             	or     $0x20,%eax
   44030:	89 c6                	mov    %eax,%esi
   44032:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44036:	48 8b 40 08          	mov    0x8(%rax),%rax
   4403a:	48 8d 48 02          	lea    0x2(%rax),%rcx
   4403e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44042:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44046:	89 f2                	mov    %esi,%edx
   44048:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   4404b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4404f:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   44053:	75 d5                	jne    4402a <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   44055:	eb 24                	jmp    4407b <console_putc+0xdc>
        *cp->cursor++ = c | color;
   44057:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   4405b:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4405e:	09 d0                	or     %edx,%eax
   44060:	89 c6                	mov    %eax,%esi
   44062:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44066:	48 8b 40 08          	mov    0x8(%rax),%rax
   4406a:	48 8d 48 02          	lea    0x2(%rax),%rcx
   4406e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44072:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44076:	89 f2                	mov    %esi,%edx
   44078:	66 89 10             	mov    %dx,(%rax)
}
   4407b:	90                   	nop
   4407c:	c9                   	leave  
   4407d:	c3                   	ret    

000000000004407e <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   4407e:	55                   	push   %rbp
   4407f:	48 89 e5             	mov    %rsp,%rbp
   44082:	48 83 ec 30          	sub    $0x30,%rsp
   44086:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44089:	89 75 e8             	mov    %esi,-0x18(%rbp)
   4408c:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44090:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44094:	48 c7 45 f0 9f 3f 04 	movq   $0x43f9f,-0x10(%rbp)
   4409b:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4409c:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   440a0:	78 09                	js     440ab <console_vprintf+0x2d>
   440a2:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   440a9:	7e 07                	jle    440b2 <console_vprintf+0x34>
        cpos = 0;
   440ab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   440b2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440b5:	48 98                	cltq   
   440b7:	48 01 c0             	add    %rax,%rax
   440ba:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   440c0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   440c4:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   440c8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   440cc:	8b 75 e8             	mov    -0x18(%rbp),%esi
   440cf:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   440d3:	48 89 c7             	mov    %rax,%rdi
   440d6:	e8 f4 f4 ff ff       	call   435cf <printer_vprintf>
    return cp.cursor - console;
   440db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   440df:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   440e5:	48 d1 f8             	sar    %rax
}
   440e8:	c9                   	leave  
   440e9:	c3                   	ret    

00000000000440ea <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   440ea:	55                   	push   %rbp
   440eb:	48 89 e5             	mov    %rsp,%rbp
   440ee:	48 83 ec 60          	sub    $0x60,%rsp
   440f2:	89 7d ac             	mov    %edi,-0x54(%rbp)
   440f5:	89 75 a8             	mov    %esi,-0x58(%rbp)
   440f8:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   440fc:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44100:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44104:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44108:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   4410f:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44113:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44117:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4411b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   4411f:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44123:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44127:	8b 75 a8             	mov    -0x58(%rbp),%esi
   4412a:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4412d:	89 c7                	mov    %eax,%edi
   4412f:	e8 4a ff ff ff       	call   4407e <console_vprintf>
   44134:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44137:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   4413a:	c9                   	leave  
   4413b:	c3                   	ret    

000000000004413c <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   4413c:	55                   	push   %rbp
   4413d:	48 89 e5             	mov    %rsp,%rbp
   44140:	48 83 ec 20          	sub    $0x20,%rsp
   44144:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44148:	89 f0                	mov    %esi,%eax
   4414a:	89 55 e0             	mov    %edx,-0x20(%rbp)
   4414d:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   44150:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44154:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44158:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4415c:	48 8b 50 08          	mov    0x8(%rax),%rdx
   44160:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44164:	48 8b 40 10          	mov    0x10(%rax),%rax
   44168:	48 39 c2             	cmp    %rax,%rdx
   4416b:	73 1a                	jae    44187 <string_putc+0x4b>
        *sp->s++ = c;
   4416d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44171:	48 8b 40 08          	mov    0x8(%rax),%rax
   44175:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44179:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4417d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44181:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44185:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44187:	90                   	nop
   44188:	c9                   	leave  
   44189:	c3                   	ret    

000000000004418a <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   4418a:	55                   	push   %rbp
   4418b:	48 89 e5             	mov    %rsp,%rbp
   4418e:	48 83 ec 40          	sub    $0x40,%rsp
   44192:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44196:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   4419a:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   4419e:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   441a2:	48 c7 45 e8 3c 41 04 	movq   $0x4413c,-0x18(%rbp)
   441a9:	00 
    sp.s = s;
   441aa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   441ae:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   441b2:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   441b7:	74 33                	je     441ec <vsnprintf+0x62>
        sp.end = s + size - 1;
   441b9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   441bd:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   441c1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   441c5:	48 01 d0             	add    %rdx,%rax
   441c8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   441cc:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   441d0:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   441d4:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   441d8:	be 00 00 00 00       	mov    $0x0,%esi
   441dd:	48 89 c7             	mov    %rax,%rdi
   441e0:	e8 ea f3 ff ff       	call   435cf <printer_vprintf>
        *sp.s = 0;
   441e5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   441e9:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   441ec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   441f0:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   441f4:	c9                   	leave  
   441f5:	c3                   	ret    

00000000000441f6 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   441f6:	55                   	push   %rbp
   441f7:	48 89 e5             	mov    %rsp,%rbp
   441fa:	48 83 ec 70          	sub    $0x70,%rsp
   441fe:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44202:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   44206:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   4420a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4420e:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44212:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44216:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   4421d:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44221:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44225:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44229:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   4422d:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44231:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44235:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44239:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4423d:	48 89 c7             	mov    %rax,%rdi
   44240:	e8 45 ff ff ff       	call   4418a <vsnprintf>
   44245:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44248:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   4424b:	c9                   	leave  
   4424c:	c3                   	ret    

000000000004424d <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   4424d:	55                   	push   %rbp
   4424e:	48 89 e5             	mov    %rsp,%rbp
   44251:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44255:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4425c:	eb 13                	jmp    44271 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   4425e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44261:	48 98                	cltq   
   44263:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   4426a:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   4426d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44271:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44278:	7e e4                	jle    4425e <console_clear+0x11>
    }
    cursorpos = 0;
   4427a:	c7 05 78 4d 07 00 00 	movl   $0x0,0x74d78(%rip)        # b8ffc <cursorpos>
   44281:	00 00 00 
}
   44284:	90                   	nop
   44285:	c9                   	leave  
   44286:	c3                   	ret    
