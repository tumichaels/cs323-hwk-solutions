
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
   400be:	e8 e2 06 00 00       	call   407a5 <exception>

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
   40173:	e8 f4 13 00 00       	call   4156c <hardware_init>
    pageinfo_init();
   40178:	e8 53 0a 00 00       	call   40bd0 <pageinfo_init>
    console_clear();
   4017d:	e8 a6 3d 00 00       	call   43f28 <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 cc 18 00 00       	call   41a58 <timer_init>

    // use virtual_memory_map to remove user permissions for kernel memory
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4018c:	48 8b 05 6d 3e 01 00 	mov    0x13e6d(%rip),%rax        # 54000 <kernel_pagetable>
   40193:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   40199:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4019e:	ba 00 00 00 00       	mov    $0x0,%edx
   401a3:	be 00 00 00 00       	mov    $0x0,%esi
   401a8:	48 89 c7             	mov    %rax,%rdi
   401ab:	e8 06 26 00 00       	call   427b6 <virtual_memory_map>
					   PROC_START_ADDR, PTE_P | PTE_W);
   
    // return user permissions to console
    virtual_memory_map(kernel_pagetable, (uintptr_t) CONSOLE_ADDR, (uintptr_t) CONSOLE_ADDR,
   401b0:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   401b5:	be 00 80 0b 00       	mov    $0xb8000,%esi
   401ba:	48 8b 05 3f 3e 01 00 	mov    0x13e3f(%rip),%rax        # 54000 <kernel_pagetable>
   401c1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   401c7:	b9 00 10 00 00       	mov    $0x1000,%ecx
   401cc:	48 89 c7             	mov    %rax,%rdi
   401cf:	e8 e2 25 00 00       	call   427b6 <virtual_memory_map>
	// to all memory before the start of ANY processes. This means that 
	// the assign_page function is never capable of assigning this memory
	// to a process.

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   401d4:	ba 00 0e 00 00       	mov    $0xe00,%edx
   401d9:	be 00 00 00 00       	mov    $0x0,%esi
   401de:	bf 20 10 05 00       	mov    $0x51020,%edi
   401e3:	e8 26 2e 00 00       	call   4300e <memset>
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
   40246:	be 80 3f 04 00       	mov    $0x43f80,%esi
   4024b:	48 89 c7             	mov    %rax,%rdi
   4024e:	e8 b4 2e 00 00       	call   43107 <strcmp>
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
   40276:	be 85 3f 04 00       	mov    $0x43f85,%esi
   4027b:	48 89 c7             	mov    %rax,%rdi
   4027e:	e8 84 2e 00 00       	call   43107 <strcmp>
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
   402a6:	be 8e 3f 04 00       	mov    $0x43f8e,%esi
   402ab:	48 89 c7             	mov    %rax,%rdi
   402ae:	e8 54 2e 00 00       	call   43107 <strcmp>
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
   402d3:	be 93 3f 04 00       	mov    $0x43f93,%esi
   402d8:	48 89 c7             	mov    %rax,%rdi
   402db:	e8 27 2e 00 00       	call   43107 <strcmp>
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
   40332:	e8 3c 08 00 00       	call   40b73 <run>

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
   40420:	e8 e9 2b 00 00       	call   4300e <memset>
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

    processes[pid].p_pagetable = (x86_64_pagetable *) pagetable_pages[0];
   4046c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40470:	48 89 c1             	mov    %rax,%rcx
   40473:	8b 45 cc             	mov    -0x34(%rbp),%eax
   40476:	48 63 d0             	movslq %eax,%rdx
   40479:	48 89 d0             	mov    %rdx,%rax
   4047c:	48 c1 e0 03          	shl    $0x3,%rax
   40480:	48 29 d0             	sub    %rdx,%rax
   40483:	48 c1 e0 05          	shl    $0x5,%rax
   40487:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   4048d:	48 89 08             	mov    %rcx,(%rax)

   
    memcpy((void *)pagetable_pages[3], &kernel_pagetable[3], 
   40490:	48 8b 05 69 3b 01 00 	mov    0x13b69(%rip),%rax        # 54000 <kernel_pagetable>
   40497:	48 05 00 30 00 00    	add    $0x3000,%rax
   4049d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   404a1:	48 89 d1             	mov    %rdx,%rcx
   404a4:	ba 00 08 00 00       	mov    $0x800,%edx
   404a9:	48 89 c6             	mov    %rax,%rsi
   404ac:	48 89 cf             	mov    %rcx,%rdi
   404af:	e8 5c 2a 00 00       	call   42f10 <memcpy>
	   sizeof(x86_64_pageentry_t)*PAGENUMBER(PROC_START_ADDR));
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
   404bb:	48 83 ec 20          	sub    $0x20,%rsp
   404bf:	89 7d ec             	mov    %edi,-0x14(%rbp)
   404c2:	89 75 e8             	mov    %esi,-0x18(%rbp)
    process_init(&processes[pid], 0);
   404c5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   404c8:	48 63 d0             	movslq %eax,%rdx
   404cb:	48 89 d0             	mov    %rdx,%rax
   404ce:	48 c1 e0 03          	shl    $0x3,%rax
   404d2:	48 29 d0             	sub    %rdx,%rax
   404d5:	48 c1 e0 05          	shl    $0x5,%rax
   404d9:	48 05 20 10 05 00    	add    $0x51020,%rax
   404df:	be 00 00 00 00       	mov    $0x0,%esi
   404e4:	48 89 c7             	mov    %rax,%rdi
   404e7:	e8 fd 17 00 00       	call   41ce9 <process_init>
    //processes[pid].p_pagetable = kernel_pagetable;
    //++pageinfo[PAGENUMBER(kernel_pagetable)].refcount; //increase refcount since kernel_pagetable was used

    pagetable_setup(pid);
   404ec:	8b 45 ec             	mov    -0x14(%rbp),%eax
   404ef:	89 c7                	mov    %eax,%edi
   404f1:	e8 ab fe ff ff       	call   403a1 <pagetable_setup>

    int r = program_load(&processes[pid], program_number, NULL);
   404f6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   404f9:	48 63 d0             	movslq %eax,%rdx
   404fc:	48 89 d0             	mov    %rdx,%rax
   404ff:	48 c1 e0 03          	shl    $0x3,%rax
   40503:	48 29 d0             	sub    %rdx,%rax
   40506:	48 c1 e0 05          	shl    $0x5,%rax
   4050a:	48 8d 88 20 10 05 00 	lea    0x51020(%rax),%rcx
   40511:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40514:	ba 00 00 00 00       	mov    $0x0,%edx
   40519:	89 c6                	mov    %eax,%esi
   4051b:	48 89 cf             	mov    %rcx,%rdi
   4051e:	e8 50 27 00 00       	call   42c73 <program_load>
   40523:	89 45 fc             	mov    %eax,-0x4(%rbp)
    assert(r >= 0);
   40526:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4052a:	79 14                	jns    40540 <process_setup+0x89>
   4052c:	ba 99 3f 04 00       	mov    $0x43f99,%edx
   40531:	be c2 00 00 00       	mov    $0xc2,%esi
   40536:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   4053b:	e8 77 1f 00 00       	call   424b7 <assert_fail>

    processes[pid].p_registers.reg_rsp = PROC_START_ADDR + PROC_SIZE * pid;
   40540:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40543:	83 c0 04             	add    $0x4,%eax
   40546:	c1 e0 12             	shl    $0x12,%eax
   40549:	48 63 c8             	movslq %eax,%rcx
   4054c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4054f:	48 63 d0             	movslq %eax,%rdx
   40552:	48 89 d0             	mov    %rdx,%rax
   40555:	48 c1 e0 03          	shl    $0x3,%rax
   40559:	48 29 d0             	sub    %rdx,%rax
   4055c:	48 c1 e0 05          	shl    $0x5,%rax
   40560:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   40566:	48 89 08             	mov    %rcx,(%rax)
    uintptr_t stack_page = processes[pid].p_registers.reg_rsp - PAGESIZE;
   40569:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4056c:	48 63 d0             	movslq %eax,%rdx
   4056f:	48 89 d0             	mov    %rdx,%rax
   40572:	48 c1 e0 03          	shl    $0x3,%rax
   40576:	48 29 d0             	sub    %rdx,%rax
   40579:	48 c1 e0 05          	shl    $0x5,%rax
   4057d:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   40583:	48 8b 00             	mov    (%rax),%rax
   40586:	48 2d 00 10 00 00    	sub    $0x1000,%rax
   4058c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assign_physical_page(stack_page, pid);
   40590:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40593:	0f be d0             	movsbl %al,%edx
   40596:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4059a:	89 d6                	mov    %edx,%esi
   4059c:	48 89 c7             	mov    %rax,%rdi
   4059f:	e8 5b 00 00 00       	call   405ff <assign_physical_page>
    virtual_memory_map(processes[pid].p_pagetable, stack_page, stack_page,
   405a4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   405a7:	48 63 d0             	movslq %eax,%rdx
   405aa:	48 89 d0             	mov    %rdx,%rax
   405ad:	48 c1 e0 03          	shl    $0x3,%rax
   405b1:	48 29 d0             	sub    %rdx,%rax
   405b4:	48 c1 e0 05          	shl    $0x5,%rax
   405b8:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   405be:	48 8b 00             	mov    (%rax),%rax
   405c1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   405c5:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   405c9:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   405cf:	b9 00 10 00 00       	mov    $0x1000,%ecx
   405d4:	48 89 c7             	mov    %rax,%rdi
   405d7:	e8 da 21 00 00       	call   427b6 <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);
    processes[pid].p_state = P_RUNNABLE;
   405dc:	8b 45 ec             	mov    -0x14(%rbp),%eax
   405df:	48 63 d0             	movslq %eax,%rdx
   405e2:	48 89 d0             	mov    %rdx,%rax
   405e5:	48 c1 e0 03          	shl    $0x3,%rax
   405e9:	48 29 d0             	sub    %rdx,%rax
   405ec:	48 c1 e0 05          	shl    $0x5,%rax
   405f0:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   405f6:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   405fc:	90                   	nop
   405fd:	c9                   	leave  
   405fe:	c3                   	ret    

00000000000405ff <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   405ff:	55                   	push   %rbp
   40600:	48 89 e5             	mov    %rsp,%rbp
   40603:	48 83 ec 10          	sub    $0x10,%rsp
   40607:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4060b:	89 f0                	mov    %esi,%eax
   4060d:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0								 // this check is that the permission bits are 0
   40610:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40614:	25 ff 0f 00 00       	and    $0xfff,%eax
   40619:	48 85 c0             	test   %rax,%rax
   4061c:	75 20                	jne    4063e <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   4061e:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40625:	00 
   40626:	77 16                	ja     4063e <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   40628:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4062c:	48 c1 e8 0c          	shr    $0xc,%rax
   40630:	48 98                	cltq   
   40632:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   40639:	00 
   4063a:	84 c0                	test   %al,%al
   4063c:	74 07                	je     40645 <assign_physical_page+0x46>
        return -1;
   4063e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40643:	eb 2c                	jmp    40671 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   40645:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40649:	48 c1 e8 0c          	shr    $0xc,%rax
   4064d:	48 98                	cltq   
   4064f:	c6 84 00 41 1e 05 00 	movb   $0x1,0x51e41(%rax,%rax,1)
   40656:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40657:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4065b:	48 c1 e8 0c          	shr    $0xc,%rax
   4065f:	48 98                	cltq   
   40661:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   40665:	88 94 00 40 1e 05 00 	mov    %dl,0x51e40(%rax,%rax,1)
        return 0;
   4066c:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40671:	c9                   	leave  
   40672:	c3                   	ret    

0000000000040673 <syscall_mapping>:

void syscall_mapping(proc* p){
   40673:	55                   	push   %rbp
   40674:	48 89 e5             	mov    %rsp,%rbp
   40677:	48 83 ec 70          	sub    $0x70,%rsp
   4067b:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   4067f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40683:	48 8b 40 38          	mov    0x38(%rax),%rax
   40687:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   4068b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4068f:	48 8b 40 30          	mov    0x30(%rax),%rax
   40693:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   40697:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4069b:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   406a2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   406a6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   406aa:	48 89 ce             	mov    %rcx,%rsi
   406ad:	48 89 c7             	mov    %rax,%rdi
   406b0:	e8 c7 24 00 00       	call   42b7c <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   406b5:	8b 45 e0             	mov    -0x20(%rbp),%eax
   406b8:	48 98                	cltq   
   406ba:	83 e0 06             	and    $0x6,%eax
   406bd:	48 83 f8 06          	cmp    $0x6,%rax
   406c1:	75 73                	jne    40736 <syscall_mapping+0xc3>
	return;
    uintptr_t endaddr = map.pa + sizeof(vamapping) - 1;
   406c3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   406c7:	48 83 c0 17          	add    $0x17,%rax
   406cb:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   406cf:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406d3:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   406da:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   406de:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   406e2:	48 89 ce             	mov    %rcx,%rsi
   406e5:	48 89 c7             	mov    %rax,%rdi
   406e8:	e8 8f 24 00 00       	call   42b7c <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   406ed:	8b 45 c8             	mov    -0x38(%rbp),%eax
   406f0:	48 98                	cltq   
   406f2:	83 e0 03             	and    $0x3,%eax
   406f5:	48 83 f8 03          	cmp    $0x3,%rax
   406f9:	75 3e                	jne    40739 <syscall_mapping+0xc6>
	return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   406fb:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406ff:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40706:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4070a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4070e:	48 89 ce             	mov    %rcx,%rsi
   40711:	48 89 c7             	mov    %rax,%rdi
   40714:	e8 63 24 00 00       	call   42b7c <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40719:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4071d:	48 89 c1             	mov    %rax,%rcx
   40720:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40724:	ba 18 00 00 00       	mov    $0x18,%edx
   40729:	48 89 c6             	mov    %rax,%rsi
   4072c:	48 89 cf             	mov    %rcx,%rdi
   4072f:	e8 dc 27 00 00       	call   42f10 <memcpy>
   40734:	eb 04                	jmp    4073a <syscall_mapping+0xc7>
	return;
   40736:	90                   	nop
   40737:	eb 01                	jmp    4073a <syscall_mapping+0xc7>
	return;
   40739:	90                   	nop
}
   4073a:	c9                   	leave  
   4073b:	c3                   	ret    

000000000004073c <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   4073c:	55                   	push   %rbp
   4073d:	48 89 e5             	mov    %rsp,%rbp
   40740:	48 83 ec 18          	sub    $0x18,%rsp
   40744:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   40748:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4074c:	48 8b 40 38          	mov    0x38(%rax),%rax
   40750:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   40753:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40757:	75 14                	jne    4076d <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   40759:	0f b6 05 a0 48 00 00 	movzbl 0x48a0(%rip),%eax        # 45000 <disp_global>
   40760:	84 c0                	test   %al,%al
   40762:	0f 94 c0             	sete   %al
   40765:	88 05 95 48 00 00    	mov    %al,0x4895(%rip)        # 45000 <disp_global>
   4076b:	eb 36                	jmp    407a3 <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   4076d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40771:	78 2f                	js     407a2 <syscall_mem_tog+0x66>
   40773:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   40777:	7f 29                	jg     407a2 <syscall_mem_tog+0x66>
   40779:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4077d:	8b 00                	mov    (%rax),%eax
   4077f:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   40782:	75 1e                	jne    407a2 <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   40784:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40788:	0f b6 80 d8 00 00 00 	movzbl 0xd8(%rax),%eax
   4078f:	84 c0                	test   %al,%al
   40791:	0f 94 c0             	sete   %al
   40794:	89 c2                	mov    %eax,%edx
   40796:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4079a:	88 90 d8 00 00 00    	mov    %dl,0xd8(%rax)
   407a0:	eb 01                	jmp    407a3 <syscall_mem_tog+0x67>
            return;
   407a2:	90                   	nop
    }
}
   407a3:	c9                   	leave  
   407a4:	c3                   	ret    

00000000000407a5 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   407a5:	55                   	push   %rbp
   407a6:	48 89 e5             	mov    %rsp,%rbp
   407a9:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
   407b0:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   407b7:	48 8b 05 42 08 01 00 	mov    0x10842(%rip),%rax        # 51000 <current>
   407be:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
   407c5:	48 83 c0 08          	add    $0x8,%rax
   407c9:	48 89 d6             	mov    %rdx,%rsi
   407cc:	ba 18 00 00 00       	mov    $0x18,%edx
   407d1:	48 89 c7             	mov    %rax,%rdi
   407d4:	48 89 d1             	mov    %rdx,%rcx
   407d7:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   407da:	48 8b 05 1f 38 01 00 	mov    0x1381f(%rip),%rax        # 54000 <kernel_pagetable>
   407e1:	48 89 c7             	mov    %rax,%rdi
   407e4:	e8 9c 1e 00 00       	call   42685 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   407e9:	8b 05 0d 88 07 00    	mov    0x7880d(%rip),%eax        # b8ffc <cursorpos>
   407ef:	89 c7                	mov    %eax,%edi
   407f1:	e8 bd 15 00 00       	call   41db3 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   407f6:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   407fd:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40804:	48 83 f8 0e          	cmp    $0xe,%rax
   40808:	74 14                	je     4081e <exception+0x79>
   4080a:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40811:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40818:	48 83 f8 0d          	cmp    $0xd,%rax
   4081c:	75 16                	jne    40834 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   4081e:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40825:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   4082c:	83 e0 04             	and    $0x4,%eax
   4082f:	48 85 c0             	test   %rax,%rax
   40832:	74 1a                	je     4084e <exception+0xa9>
    {
        check_virtual_memory();
   40834:	e8 2e 07 00 00       	call   40f67 <check_virtual_memory>
        if(disp_global){
   40839:	0f b6 05 c0 47 00 00 	movzbl 0x47c0(%rip),%eax        # 45000 <disp_global>
   40840:	84 c0                	test   %al,%al
   40842:	74 0a                	je     4084e <exception+0xa9>
            memshow_physical();
   40844:	e8 96 08 00 00       	call   410df <memshow_physical>
            memshow_virtual_animate();
   40849:	e8 c0 0b 00 00       	call   4140e <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   4084e:	e8 43 1a 00 00       	call   42296 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40853:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4085a:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40861:	48 83 e8 0e          	sub    $0xe,%rax
   40865:	48 83 f8 2a          	cmp    $0x2a,%rax
   40869:	0f 87 55 02 00 00    	ja     40ac4 <exception+0x31f>
   4086f:	48 8b 04 c5 40 40 04 	mov    0x44040(,%rax,8),%rax
   40876:	00 
   40877:	ff e0                	jmp    *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   40879:	48 8b 05 80 07 01 00 	mov    0x10780(%rip),%rax        # 51000 <current>
   40880:	48 8b 40 38          	mov    0x38(%rax),%rax
   40884:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		if((void *)addr == NULL)
   40888:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4088d:	75 0f                	jne    4089e <exception+0xf9>
		    panic(NULL);
   4088f:	bf 00 00 00 00       	mov    $0x0,%edi
   40894:	b8 00 00 00 00       	mov    $0x0,%eax
   40899:	e8 39 1b 00 00       	call   423d7 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   4089e:	48 8b 05 5b 07 01 00 	mov    0x1075b(%rip),%rax        # 51000 <current>
   408a5:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   408ac:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   408b0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   408b4:	48 89 ce             	mov    %rcx,%rsi
   408b7:	48 89 c7             	mov    %rax,%rdi
   408ba:	e8 bd 22 00 00       	call   42b7c <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   408bf:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   408c3:	48 89 c1             	mov    %rax,%rcx
   408c6:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   408cd:	ba a0 00 00 00       	mov    $0xa0,%edx
   408d2:	48 89 ce             	mov    %rcx,%rsi
   408d5:	48 89 c7             	mov    %rax,%rdi
   408d8:	e8 33 26 00 00       	call   42f10 <memcpy>
		panic(msg);
   408dd:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   408e4:	48 89 c7             	mov    %rax,%rdi
   408e7:	b8 00 00 00 00       	mov    $0x0,%eax
   408ec:	e8 e6 1a 00 00       	call   423d7 <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   408f1:	48 8b 05 08 07 01 00 	mov    0x10708(%rip),%rax        # 51000 <current>
   408f8:	8b 10                	mov    (%rax),%edx
   408fa:	48 8b 05 ff 06 01 00 	mov    0x106ff(%rip),%rax        # 51000 <current>
   40901:	48 63 d2             	movslq %edx,%rdx
   40904:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40908:	e9 c7 01 00 00       	jmp    40ad4 <exception+0x32f>

    case INT_SYS_YIELD:
        schedule();
   4090d:	e8 eb 01 00 00       	call   40afd <schedule>
        break;                  /* will not be reached */
   40912:	e9 bd 01 00 00       	jmp    40ad4 <exception+0x32f>

    case INT_SYS_PAGE_ALLOC: {
        uintptr_t addr = current->p_registers.reg_rdi;
   40917:	48 8b 05 e2 06 01 00 	mov    0x106e2(%rip),%rax        # 51000 <current>
   4091e:	48 8b 40 38          	mov    0x38(%rax),%rax
   40922:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
		// changes the owner of addr to the given process,
		// i'm still unsure what the security risk is?
        int r = assign_physical_page(addr, current->p_pid); 
   40926:	48 8b 05 d3 06 01 00 	mov    0x106d3(%rip),%rax        # 51000 <current>
   4092d:	8b 00                	mov    (%rax),%eax
   4092f:	0f be d0             	movsbl %al,%edx
   40932:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40936:	89 d6                	mov    %edx,%esi
   40938:	48 89 c7             	mov    %rax,%rdi
   4093b:	e8 bf fc ff ff       	call   405ff <assign_physical_page>
   40940:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (r >= 0) {
   40943:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40947:	78 29                	js     40972 <exception+0x1cd>
            virtual_memory_map(current->p_pagetable, addr, addr,
   40949:	48 8b 05 b0 06 01 00 	mov    0x106b0(%rip),%rax        # 51000 <current>
   40950:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40957:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4095b:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   4095f:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40965:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4096a:	48 89 c7             	mov    %rax,%rdi
   4096d:	e8 44 1e 00 00       	call   427b6 <virtual_memory_map>
                               PAGESIZE, PTE_P | PTE_W | PTE_U);
        }
        current->p_registers.reg_rax = r;
   40972:	48 8b 05 87 06 01 00 	mov    0x10687(%rip),%rax        # 51000 <current>
   40979:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4097c:	48 63 d2             	movslq %edx,%rdx
   4097f:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40983:	e9 4c 01 00 00       	jmp    40ad4 <exception+0x32f>
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   40988:	48 8b 05 71 06 01 00 	mov    0x10671(%rip),%rax        # 51000 <current>
   4098f:	48 89 c7             	mov    %rax,%rdi
   40992:	e8 dc fc ff ff       	call   40673 <syscall_mapping>
            break;
   40997:	e9 38 01 00 00       	jmp    40ad4 <exception+0x32f>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   4099c:	48 8b 05 5d 06 01 00 	mov    0x1065d(%rip),%rax        # 51000 <current>
   409a3:	48 89 c7             	mov    %rax,%rdi
   409a6:	e8 91 fd ff ff       	call   4073c <syscall_mem_tog>
	    break;
   409ab:	e9 24 01 00 00       	jmp    40ad4 <exception+0x32f>
	}

    case INT_TIMER:
        ++ticks;
   409b0:	8b 05 6a 14 01 00    	mov    0x1146a(%rip),%eax        # 51e20 <ticks>
   409b6:	83 c0 01             	add    $0x1,%eax
   409b9:	89 05 61 14 01 00    	mov    %eax,0x11461(%rip)        # 51e20 <ticks>
        schedule();
   409bf:	e8 39 01 00 00       	call   40afd <schedule>
        break;                  /* will not be reached */
   409c4:	e9 0b 01 00 00       	jmp    40ad4 <exception+0x32f>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   409c9:	0f 20 d0             	mov    %cr2,%rax
   409cc:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    return val;
   409d0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   409d4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   409d8:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   409df:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   409e6:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   409e9:	48 85 c0             	test   %rax,%rax
   409ec:	74 07                	je     409f5 <exception+0x250>
   409ee:	b8 b0 3f 04 00       	mov    $0x43fb0,%eax
   409f3:	eb 05                	jmp    409fa <exception+0x255>
   409f5:	b8 b6 3f 04 00       	mov    $0x43fb6,%eax
        const char* operation = reg->reg_err & PFERR_WRITE
   409fa:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   409fe:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40a05:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a0c:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   40a0f:	48 85 c0             	test   %rax,%rax
   40a12:	74 07                	je     40a1b <exception+0x276>
   40a14:	b8 bb 3f 04 00       	mov    $0x43fbb,%eax
   40a19:	eb 05                	jmp    40a20 <exception+0x27b>
   40a1b:	b8 ce 3f 04 00       	mov    $0x43fce,%eax
        const char* problem = reg->reg_err & PFERR_PRESENT
   40a20:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   40a24:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40a2b:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a32:	83 e0 04             	and    $0x4,%eax
   40a35:	48 85 c0             	test   %rax,%rax
   40a38:	75 2f                	jne    40a69 <exception+0x2c4>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40a3a:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40a41:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40a48:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   40a4c:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40a50:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40a54:	49 89 f0             	mov    %rsi,%r8
   40a57:	48 89 c6             	mov    %rax,%rsi
   40a5a:	bf e0 3f 04 00       	mov    $0x43fe0,%edi
   40a5f:	b8 00 00 00 00       	mov    $0x0,%eax
   40a64:	e8 6e 19 00 00       	call   423d7 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   40a69:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40a70:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   40a77:	48 8b 05 82 05 01 00 	mov    0x10582(%rip),%rax        # 51000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   40a7e:	8b 00                	mov    (%rax),%eax
   40a80:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
   40a84:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   40a88:	52                   	push   %rdx
   40a89:	ff 75 d0             	push   -0x30(%rbp)
   40a8c:	49 89 f1             	mov    %rsi,%r9
   40a8f:	49 89 c8             	mov    %rcx,%r8
   40a92:	89 c1                	mov    %eax,%ecx
   40a94:	ba 10 40 04 00       	mov    $0x44010,%edx
   40a99:	be 00 0c 00 00       	mov    $0xc00,%esi
   40a9e:	bf 80 07 00 00       	mov    $0x780,%edi
   40aa3:	b8 00 00 00 00       	mov    $0x0,%eax
   40aa8:	e8 18 33 00 00       	call   43dc5 <console_printf>
   40aad:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   40ab1:	48 8b 05 48 05 01 00 	mov    0x10548(%rip),%rax        # 51000 <current>
   40ab8:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   40abf:	00 00 00 
        break;
   40ac2:	eb 10                	jmp    40ad4 <exception+0x32f>
    }

    default:
        default_exception(current);
   40ac4:	48 8b 05 35 05 01 00 	mov    0x10535(%rip),%rax        # 51000 <current>
   40acb:	48 89 c7             	mov    %rax,%rdi
   40ace:	e8 14 1a 00 00       	call   424e7 <default_exception>
        break;                  /* will not be reached */
   40ad3:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40ad4:	48 8b 05 25 05 01 00 	mov    0x10525(%rip),%rax        # 51000 <current>
   40adb:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40ae1:	83 f8 01             	cmp    $0x1,%eax
   40ae4:	75 0f                	jne    40af5 <exception+0x350>
        run(current);
   40ae6:	48 8b 05 13 05 01 00 	mov    0x10513(%rip),%rax        # 51000 <current>
   40aed:	48 89 c7             	mov    %rax,%rdi
   40af0:	e8 7e 00 00 00       	call   40b73 <run>
    } else {
        schedule();
   40af5:	e8 03 00 00 00       	call   40afd <schedule>
    }
}
   40afa:	90                   	nop
   40afb:	c9                   	leave  
   40afc:	c3                   	ret    

0000000000040afd <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40afd:	55                   	push   %rbp
   40afe:	48 89 e5             	mov    %rsp,%rbp
   40b01:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40b05:	48 8b 05 f4 04 01 00 	mov    0x104f4(%rip),%rax        # 51000 <current>
   40b0c:	8b 00                	mov    (%rax),%eax
   40b0e:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40b11:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40b14:	8d 50 01             	lea    0x1(%rax),%edx
   40b17:	89 d0                	mov    %edx,%eax
   40b19:	c1 f8 1f             	sar    $0x1f,%eax
   40b1c:	c1 e8 1c             	shr    $0x1c,%eax
   40b1f:	01 c2                	add    %eax,%edx
   40b21:	83 e2 0f             	and    $0xf,%edx
   40b24:	29 c2                	sub    %eax,%edx
   40b26:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40b29:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40b2c:	48 63 d0             	movslq %eax,%rdx
   40b2f:	48 89 d0             	mov    %rdx,%rax
   40b32:	48 c1 e0 03          	shl    $0x3,%rax
   40b36:	48 29 d0             	sub    %rdx,%rax
   40b39:	48 c1 e0 05          	shl    $0x5,%rax
   40b3d:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   40b43:	8b 00                	mov    (%rax),%eax
   40b45:	83 f8 01             	cmp    $0x1,%eax
   40b48:	75 22                	jne    40b6c <schedule+0x6f>
            run(&processes[pid]);
   40b4a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40b4d:	48 63 d0             	movslq %eax,%rdx
   40b50:	48 89 d0             	mov    %rdx,%rax
   40b53:	48 c1 e0 03          	shl    $0x3,%rax
   40b57:	48 29 d0             	sub    %rdx,%rax
   40b5a:	48 c1 e0 05          	shl    $0x5,%rax
   40b5e:	48 05 20 10 05 00    	add    $0x51020,%rax
   40b64:	48 89 c7             	mov    %rax,%rdi
   40b67:	e8 07 00 00 00       	call   40b73 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40b6c:	e8 25 17 00 00       	call   42296 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40b71:	eb 9e                	jmp    40b11 <schedule+0x14>

0000000000040b73 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40b73:	55                   	push   %rbp
   40b74:	48 89 e5             	mov    %rsp,%rbp
   40b77:	48 83 ec 10          	sub    $0x10,%rsp
   40b7b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40b7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40b83:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40b89:	83 f8 01             	cmp    $0x1,%eax
   40b8c:	74 14                	je     40ba2 <run+0x2f>
   40b8e:	ba 98 41 04 00       	mov    $0x44198,%edx
   40b93:	be 99 01 00 00       	mov    $0x199,%esi
   40b98:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   40b9d:	e8 15 19 00 00       	call   424b7 <assert_fail>
    current = p;
   40ba2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ba6:	48 89 05 53 04 01 00 	mov    %rax,0x10453(%rip)        # 51000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40bad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40bb1:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40bb8:	48 89 c7             	mov    %rax,%rdi
   40bbb:	e8 c5 1a 00 00       	call   42685 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40bc0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40bc4:	48 83 c0 08          	add    $0x8,%rax
   40bc8:	48 89 c7             	mov    %rax,%rdi
   40bcb:	e8 f3 f4 ff ff       	call   400c3 <exception_return>

0000000000040bd0 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40bd0:	55                   	push   %rbp
   40bd1:	48 89 e5             	mov    %rsp,%rbp
   40bd4:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40bd8:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40bdf:	00 
   40be0:	e9 81 00 00 00       	jmp    40c66 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40be5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40be9:	48 89 c7             	mov    %rax,%rdi
   40bec:	e8 33 0f 00 00       	call   41b24 <physical_memory_isreserved>
   40bf1:	85 c0                	test   %eax,%eax
   40bf3:	74 09                	je     40bfe <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40bf5:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40bfc:	eb 2f                	jmp    40c2d <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40bfe:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40c05:	00 
   40c06:	76 0b                	jbe    40c13 <pageinfo_init+0x43>
   40c08:	b8 08 a0 05 00       	mov    $0x5a008,%eax
   40c0d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40c11:	72 0a                	jb     40c1d <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40c13:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40c1a:	00 
   40c1b:	75 09                	jne    40c26 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40c1d:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40c24:	eb 07                	jmp    40c2d <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40c26:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40c2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c31:	48 c1 e8 0c          	shr    $0xc,%rax
   40c35:	89 c1                	mov    %eax,%ecx
   40c37:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40c3a:	89 c2                	mov    %eax,%edx
   40c3c:	48 63 c1             	movslq %ecx,%rax
   40c3f:	88 94 00 40 1e 05 00 	mov    %dl,0x51e40(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40c46:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40c4a:	0f 95 c2             	setne  %dl
   40c4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c51:	48 c1 e8 0c          	shr    $0xc,%rax
   40c55:	48 98                	cltq   
   40c57:	88 94 00 41 1e 05 00 	mov    %dl,0x51e41(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40c5e:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40c65:	00 
   40c66:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40c6d:	00 
   40c6e:	0f 86 71 ff ff ff    	jbe    40be5 <pageinfo_init+0x15>
    }
}
   40c74:	90                   	nop
   40c75:	90                   	nop
   40c76:	c9                   	leave  
   40c77:	c3                   	ret    

0000000000040c78 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40c78:	55                   	push   %rbp
   40c79:	48 89 e5             	mov    %rsp,%rbp
   40c7c:	48 83 ec 50          	sub    $0x50,%rsp
   40c80:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40c84:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40c88:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40c8e:	48 89 c2             	mov    %rax,%rdx
   40c91:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40c95:	48 39 c2             	cmp    %rax,%rdx
   40c98:	74 14                	je     40cae <check_page_table_mappings+0x36>
   40c9a:	ba b8 41 04 00       	mov    $0x441b8,%edx
   40c9f:	be c3 01 00 00       	mov    $0x1c3,%esi
   40ca4:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   40ca9:	e8 09 18 00 00       	call   424b7 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40cae:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40cb5:	00 
   40cb6:	e9 9a 00 00 00       	jmp    40d55 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40cbb:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40cbf:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40cc3:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40cc7:	48 89 ce             	mov    %rcx,%rsi
   40cca:	48 89 c7             	mov    %rax,%rdi
   40ccd:	e8 aa 1e 00 00       	call   42b7c <virtual_memory_lookup>
        if (vam.pa != va) {
   40cd2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40cd6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40cda:	74 27                	je     40d03 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40cdc:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40ce0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ce4:	49 89 d0             	mov    %rdx,%r8
   40ce7:	48 89 c1             	mov    %rax,%rcx
   40cea:	ba d7 41 04 00       	mov    $0x441d7,%edx
   40cef:	be 00 c0 00 00       	mov    $0xc000,%esi
   40cf4:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40cf9:	b8 00 00 00 00       	mov    $0x0,%eax
   40cfe:	e8 c2 30 00 00       	call   43dc5 <console_printf>
        }
        assert(vam.pa == va);
   40d03:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40d07:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40d0b:	74 14                	je     40d21 <check_page_table_mappings+0xa9>
   40d0d:	ba e1 41 04 00       	mov    $0x441e1,%edx
   40d12:	be cc 01 00 00       	mov    $0x1cc,%esi
   40d17:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   40d1c:	e8 96 17 00 00       	call   424b7 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40d21:	b8 00 50 04 00       	mov    $0x45000,%eax
   40d26:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40d2a:	72 21                	jb     40d4d <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40d2c:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40d2f:	48 98                	cltq   
   40d31:	83 e0 02             	and    $0x2,%eax
   40d34:	48 85 c0             	test   %rax,%rax
   40d37:	75 14                	jne    40d4d <check_page_table_mappings+0xd5>
   40d39:	ba ee 41 04 00       	mov    $0x441ee,%edx
   40d3e:	be ce 01 00 00       	mov    $0x1ce,%esi
   40d43:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   40d48:	e8 6a 17 00 00       	call   424b7 <assert_fail>
         va += PAGESIZE) {
   40d4d:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40d54:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40d55:	b8 08 a0 05 00       	mov    $0x5a008,%eax
   40d5a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40d5e:	0f 82 57 ff ff ff    	jb     40cbb <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40d64:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40d6b:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40d6c:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40d70:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40d74:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40d78:	48 89 ce             	mov    %rcx,%rsi
   40d7b:	48 89 c7             	mov    %rax,%rdi
   40d7e:	e8 f9 1d 00 00       	call   42b7c <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40d83:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40d87:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40d8b:	74 14                	je     40da1 <check_page_table_mappings+0x129>
   40d8d:	ba ff 41 04 00       	mov    $0x441ff,%edx
   40d92:	be d5 01 00 00       	mov    $0x1d5,%esi
   40d97:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   40d9c:	e8 16 17 00 00       	call   424b7 <assert_fail>
    assert(vam.perm & PTE_W);
   40da1:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40da4:	48 98                	cltq   
   40da6:	83 e0 02             	and    $0x2,%eax
   40da9:	48 85 c0             	test   %rax,%rax
   40dac:	75 14                	jne    40dc2 <check_page_table_mappings+0x14a>
   40dae:	ba ee 41 04 00       	mov    $0x441ee,%edx
   40db3:	be d6 01 00 00       	mov    $0x1d6,%esi
   40db8:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   40dbd:	e8 f5 16 00 00       	call   424b7 <assert_fail>
}
   40dc2:	90                   	nop
   40dc3:	c9                   	leave  
   40dc4:	c3                   	ret    

0000000000040dc5 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40dc5:	55                   	push   %rbp
   40dc6:	48 89 e5             	mov    %rsp,%rbp
   40dc9:	48 83 ec 20          	sub    $0x20,%rsp
   40dcd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40dd1:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40dd4:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40dd7:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40dda:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40de1:	48 8b 05 18 32 01 00 	mov    0x13218(%rip),%rax        # 54000 <kernel_pagetable>
   40de8:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40dec:	75 67                	jne    40e55 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40dee:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40df5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40dfc:	eb 51                	jmp    40e4f <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40dfe:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40e01:	48 63 d0             	movslq %eax,%rdx
   40e04:	48 89 d0             	mov    %rdx,%rax
   40e07:	48 c1 e0 03          	shl    $0x3,%rax
   40e0b:	48 29 d0             	sub    %rdx,%rax
   40e0e:	48 c1 e0 05          	shl    $0x5,%rax
   40e12:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   40e18:	8b 00                	mov    (%rax),%eax
   40e1a:	85 c0                	test   %eax,%eax
   40e1c:	74 2d                	je     40e4b <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40e1e:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40e21:	48 63 d0             	movslq %eax,%rdx
   40e24:	48 89 d0             	mov    %rdx,%rax
   40e27:	48 c1 e0 03          	shl    $0x3,%rax
   40e2b:	48 29 d0             	sub    %rdx,%rax
   40e2e:	48 c1 e0 05          	shl    $0x5,%rax
   40e32:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   40e38:	48 8b 10             	mov    (%rax),%rdx
   40e3b:	48 8b 05 be 31 01 00 	mov    0x131be(%rip),%rax        # 54000 <kernel_pagetable>
   40e42:	48 39 c2             	cmp    %rax,%rdx
   40e45:	75 04                	jne    40e4b <check_page_table_ownership+0x86>
                ++expected_refcount;
   40e47:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40e4b:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40e4f:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40e53:	7e a9                	jle    40dfe <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40e55:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40e58:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40e5b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40e5f:	be 00 00 00 00       	mov    $0x0,%esi
   40e64:	48 89 c7             	mov    %rax,%rdi
   40e67:	e8 03 00 00 00       	call   40e6f <check_page_table_ownership_level>
}
   40e6c:	90                   	nop
   40e6d:	c9                   	leave  
   40e6e:	c3                   	ret    

0000000000040e6f <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40e6f:	55                   	push   %rbp
   40e70:	48 89 e5             	mov    %rsp,%rbp
   40e73:	48 83 ec 30          	sub    $0x30,%rsp
   40e77:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40e7b:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40e7e:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40e81:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40e84:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40e88:	48 c1 e8 0c          	shr    $0xc,%rax
   40e8c:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40e91:	7e 14                	jle    40ea7 <check_page_table_ownership_level+0x38>
   40e93:	ba 10 42 04 00       	mov    $0x44210,%edx
   40e98:	be f3 01 00 00       	mov    $0x1f3,%esi
   40e9d:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   40ea2:	e8 10 16 00 00       	call   424b7 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   40ea7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40eab:	48 c1 e8 0c          	shr    $0xc,%rax
   40eaf:	48 98                	cltq   
   40eb1:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   40eb8:	00 
   40eb9:	0f be c0             	movsbl %al,%eax
   40ebc:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   40ebf:	74 14                	je     40ed5 <check_page_table_ownership_level+0x66>
   40ec1:	ba 28 42 04 00       	mov    $0x44228,%edx
   40ec6:	be f4 01 00 00       	mov    $0x1f4,%esi
   40ecb:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   40ed0:	e8 e2 15 00 00       	call   424b7 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   40ed5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40ed9:	48 c1 e8 0c          	shr    $0xc,%rax
   40edd:	48 98                	cltq   
   40edf:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   40ee6:	00 
   40ee7:	0f be c0             	movsbl %al,%eax
   40eea:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   40eed:	74 14                	je     40f03 <check_page_table_ownership_level+0x94>
   40eef:	ba 50 42 04 00       	mov    $0x44250,%edx
   40ef4:	be f5 01 00 00       	mov    $0x1f5,%esi
   40ef9:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   40efe:	e8 b4 15 00 00       	call   424b7 <assert_fail>
    if (level < 3) {
   40f03:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   40f07:	7f 5b                	jg     40f64 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40f09:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40f10:	eb 49                	jmp    40f5b <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   40f12:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f16:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40f19:	48 63 d2             	movslq %edx,%rdx
   40f1c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40f20:	48 85 c0             	test   %rax,%rax
   40f23:	74 32                	je     40f57 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   40f25:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f29:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40f2c:	48 63 d2             	movslq %edx,%rdx
   40f2f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40f33:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   40f39:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   40f3d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40f40:	8d 70 01             	lea    0x1(%rax),%esi
   40f43:	8b 55 e0             	mov    -0x20(%rbp),%edx
   40f46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40f4a:	b9 01 00 00 00       	mov    $0x1,%ecx
   40f4f:	48 89 c7             	mov    %rax,%rdi
   40f52:	e8 18 ff ff ff       	call   40e6f <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40f57:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40f5b:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   40f62:	7e ae                	jle    40f12 <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   40f64:	90                   	nop
   40f65:	c9                   	leave  
   40f66:	c3                   	ret    

0000000000040f67 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   40f67:	55                   	push   %rbp
   40f68:	48 89 e5             	mov    %rsp,%rbp
   40f6b:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   40f6f:	8b 05 73 01 01 00    	mov    0x10173(%rip),%eax        # 510e8 <processes+0xc8>
   40f75:	85 c0                	test   %eax,%eax
   40f77:	74 14                	je     40f8d <check_virtual_memory+0x26>
   40f79:	ba 80 42 04 00       	mov    $0x44280,%edx
   40f7e:	be 08 02 00 00       	mov    $0x208,%esi
   40f83:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   40f88:	e8 2a 15 00 00       	call   424b7 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   40f8d:	48 8b 05 6c 30 01 00 	mov    0x1306c(%rip),%rax        # 54000 <kernel_pagetable>
   40f94:	48 89 c7             	mov    %rax,%rdi
   40f97:	e8 dc fc ff ff       	call   40c78 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   40f9c:	48 8b 05 5d 30 01 00 	mov    0x1305d(%rip),%rax        # 54000 <kernel_pagetable>
   40fa3:	be ff ff ff ff       	mov    $0xffffffff,%esi
   40fa8:	48 89 c7             	mov    %rax,%rdi
   40fab:	e8 15 fe ff ff       	call   40dc5 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   40fb0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40fb7:	e9 9c 00 00 00       	jmp    41058 <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   40fbc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fbf:	48 63 d0             	movslq %eax,%rdx
   40fc2:	48 89 d0             	mov    %rdx,%rax
   40fc5:	48 c1 e0 03          	shl    $0x3,%rax
   40fc9:	48 29 d0             	sub    %rdx,%rax
   40fcc:	48 c1 e0 05          	shl    $0x5,%rax
   40fd0:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   40fd6:	8b 00                	mov    (%rax),%eax
   40fd8:	85 c0                	test   %eax,%eax
   40fda:	74 78                	je     41054 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   40fdc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fdf:	48 63 d0             	movslq %eax,%rdx
   40fe2:	48 89 d0             	mov    %rdx,%rax
   40fe5:	48 c1 e0 03          	shl    $0x3,%rax
   40fe9:	48 29 d0             	sub    %rdx,%rax
   40fec:	48 c1 e0 05          	shl    $0x5,%rax
   40ff0:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   40ff6:	48 8b 10             	mov    (%rax),%rdx
   40ff9:	48 8b 05 00 30 01 00 	mov    0x13000(%rip),%rax        # 54000 <kernel_pagetable>
   41000:	48 39 c2             	cmp    %rax,%rdx
   41003:	74 4f                	je     41054 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   41005:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41008:	48 63 d0             	movslq %eax,%rdx
   4100b:	48 89 d0             	mov    %rdx,%rax
   4100e:	48 c1 e0 03          	shl    $0x3,%rax
   41012:	48 29 d0             	sub    %rdx,%rax
   41015:	48 c1 e0 05          	shl    $0x5,%rax
   41019:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   4101f:	48 8b 00             	mov    (%rax),%rax
   41022:	48 89 c7             	mov    %rax,%rdi
   41025:	e8 4e fc ff ff       	call   40c78 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   4102a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4102d:	48 63 d0             	movslq %eax,%rdx
   41030:	48 89 d0             	mov    %rdx,%rax
   41033:	48 c1 e0 03          	shl    $0x3,%rax
   41037:	48 29 d0             	sub    %rdx,%rax
   4103a:	48 c1 e0 05          	shl    $0x5,%rax
   4103e:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   41044:	48 8b 00             	mov    (%rax),%rax
   41047:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4104a:	89 d6                	mov    %edx,%esi
   4104c:	48 89 c7             	mov    %rax,%rdi
   4104f:	e8 71 fd ff ff       	call   40dc5 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   41054:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41058:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   4105c:	0f 8e 5a ff ff ff    	jle    40fbc <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41062:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41069:	eb 67                	jmp    410d2 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   4106b:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4106e:	48 98                	cltq   
   41070:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   41077:	00 
   41078:	84 c0                	test   %al,%al
   4107a:	7e 52                	jle    410ce <check_virtual_memory+0x167>
   4107c:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4107f:	48 98                	cltq   
   41081:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   41088:	00 
   41089:	84 c0                	test   %al,%al
   4108b:	78 41                	js     410ce <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   4108d:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41090:	48 98                	cltq   
   41092:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   41099:	00 
   4109a:	0f be c0             	movsbl %al,%eax
   4109d:	48 63 d0             	movslq %eax,%rdx
   410a0:	48 89 d0             	mov    %rdx,%rax
   410a3:	48 c1 e0 03          	shl    $0x3,%rax
   410a7:	48 29 d0             	sub    %rdx,%rax
   410aa:	48 c1 e0 05          	shl    $0x5,%rax
   410ae:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   410b4:	8b 00                	mov    (%rax),%eax
   410b6:	85 c0                	test   %eax,%eax
   410b8:	75 14                	jne    410ce <check_virtual_memory+0x167>
   410ba:	ba a0 42 04 00       	mov    $0x442a0,%edx
   410bf:	be 1f 02 00 00       	mov    $0x21f,%esi
   410c4:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   410c9:	e8 e9 13 00 00       	call   424b7 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   410ce:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   410d2:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   410d9:	7e 90                	jle    4106b <check_virtual_memory+0x104>
        }
    }
}
   410db:	90                   	nop
   410dc:	90                   	nop
   410dd:	c9                   	leave  
   410de:	c3                   	ret    

00000000000410df <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   410df:	55                   	push   %rbp
   410e0:	48 89 e5             	mov    %rsp,%rbp
   410e3:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   410e7:	ba 06 43 04 00       	mov    $0x44306,%edx
   410ec:	be 00 0f 00 00       	mov    $0xf00,%esi
   410f1:	bf 20 00 00 00       	mov    $0x20,%edi
   410f6:	b8 00 00 00 00       	mov    $0x0,%eax
   410fb:	e8 c5 2c 00 00       	call   43dc5 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41100:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41107:	e9 f8 00 00 00       	jmp    41204 <memshow_physical+0x125>
        if (pn % 64 == 0) {
   4110c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4110f:	83 e0 3f             	and    $0x3f,%eax
   41112:	85 c0                	test   %eax,%eax
   41114:	75 3c                	jne    41152 <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   41116:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41119:	c1 e0 0c             	shl    $0xc,%eax
   4111c:	89 c1                	mov    %eax,%ecx
   4111e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41121:	8d 50 3f             	lea    0x3f(%rax),%edx
   41124:	85 c0                	test   %eax,%eax
   41126:	0f 48 c2             	cmovs  %edx,%eax
   41129:	c1 f8 06             	sar    $0x6,%eax
   4112c:	8d 50 01             	lea    0x1(%rax),%edx
   4112f:	89 d0                	mov    %edx,%eax
   41131:	c1 e0 02             	shl    $0x2,%eax
   41134:	01 d0                	add    %edx,%eax
   41136:	c1 e0 04             	shl    $0x4,%eax
   41139:	83 c0 03             	add    $0x3,%eax
   4113c:	ba 16 43 04 00       	mov    $0x44316,%edx
   41141:	be 00 0f 00 00       	mov    $0xf00,%esi
   41146:	89 c7                	mov    %eax,%edi
   41148:	b8 00 00 00 00       	mov    $0x0,%eax
   4114d:	e8 73 2c 00 00       	call   43dc5 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41152:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41155:	48 98                	cltq   
   41157:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   4115e:	00 
   4115f:	0f be c0             	movsbl %al,%eax
   41162:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41165:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41168:	48 98                	cltq   
   4116a:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   41171:	00 
   41172:	84 c0                	test   %al,%al
   41174:	75 07                	jne    4117d <memshow_physical+0x9e>
            owner = PO_FREE;
   41176:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   4117d:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41180:	83 c0 02             	add    $0x2,%eax
   41183:	48 98                	cltq   
   41185:	0f b7 84 00 e0 42 04 	movzwl 0x442e0(%rax,%rax,1),%eax
   4118c:	00 
   4118d:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41191:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41194:	48 98                	cltq   
   41196:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   4119d:	00 
   4119e:	3c 01                	cmp    $0x1,%al
   411a0:	7e 1a                	jle    411bc <memshow_physical+0xdd>
   411a2:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   411a7:	48 c1 e8 0c          	shr    $0xc,%rax
   411ab:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   411ae:	74 0c                	je     411bc <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   411b0:	b8 53 00 00 00       	mov    $0x53,%eax
   411b5:	80 cc 0f             	or     $0xf,%ah
   411b8:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   411bc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411bf:	8d 50 3f             	lea    0x3f(%rax),%edx
   411c2:	85 c0                	test   %eax,%eax
   411c4:	0f 48 c2             	cmovs  %edx,%eax
   411c7:	c1 f8 06             	sar    $0x6,%eax
   411ca:	8d 50 01             	lea    0x1(%rax),%edx
   411cd:	89 d0                	mov    %edx,%eax
   411cf:	c1 e0 02             	shl    $0x2,%eax
   411d2:	01 d0                	add    %edx,%eax
   411d4:	c1 e0 04             	shl    $0x4,%eax
   411d7:	89 c1                	mov    %eax,%ecx
   411d9:	8b 55 fc             	mov    -0x4(%rbp),%edx
   411dc:	89 d0                	mov    %edx,%eax
   411de:	c1 f8 1f             	sar    $0x1f,%eax
   411e1:	c1 e8 1a             	shr    $0x1a,%eax
   411e4:	01 c2                	add    %eax,%edx
   411e6:	83 e2 3f             	and    $0x3f,%edx
   411e9:	29 c2                	sub    %eax,%edx
   411eb:	89 d0                	mov    %edx,%eax
   411ed:	83 c0 0c             	add    $0xc,%eax
   411f0:	01 c8                	add    %ecx,%eax
   411f2:	48 98                	cltq   
   411f4:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   411f8:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   411ff:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41200:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41204:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   4120b:	0f 8e fb fe ff ff    	jle    4110c <memshow_physical+0x2d>
    }
}
   41211:	90                   	nop
   41212:	90                   	nop
   41213:	c9                   	leave  
   41214:	c3                   	ret    

0000000000041215 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41215:	55                   	push   %rbp
   41216:	48 89 e5             	mov    %rsp,%rbp
   41219:	48 83 ec 40          	sub    $0x40,%rsp
   4121d:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41221:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41225:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41229:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4122f:	48 89 c2             	mov    %rax,%rdx
   41232:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41236:	48 39 c2             	cmp    %rax,%rdx
   41239:	74 14                	je     4124f <memshow_virtual+0x3a>
   4123b:	ba 20 43 04 00       	mov    $0x44320,%edx
   41240:	be 50 02 00 00       	mov    $0x250,%esi
   41245:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   4124a:	e8 68 12 00 00       	call   424b7 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   4124f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41253:	48 89 c1             	mov    %rax,%rcx
   41256:	ba 4d 43 04 00       	mov    $0x4434d,%edx
   4125b:	be 00 0f 00 00       	mov    $0xf00,%esi
   41260:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41265:	b8 00 00 00 00       	mov    $0x0,%eax
   4126a:	e8 56 2b 00 00       	call   43dc5 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   4126f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41276:	00 
   41277:	e9 80 01 00 00       	jmp    413fc <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   4127c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41280:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41284:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41288:	48 89 ce             	mov    %rcx,%rsi
   4128b:	48 89 c7             	mov    %rax,%rdi
   4128e:	e8 e9 18 00 00       	call   42b7c <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41293:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41296:	85 c0                	test   %eax,%eax
   41298:	79 0b                	jns    412a5 <memshow_virtual+0x90>
            color = ' ';
   4129a:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   412a0:	e9 d7 00 00 00       	jmp    4137c <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   412a5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   412a9:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   412af:	76 14                	jbe    412c5 <memshow_virtual+0xb0>
   412b1:	ba 6a 43 04 00       	mov    $0x4436a,%edx
   412b6:	be 59 02 00 00       	mov    $0x259,%esi
   412bb:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   412c0:	e8 f2 11 00 00       	call   424b7 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   412c5:	8b 45 d0             	mov    -0x30(%rbp),%eax
   412c8:	48 98                	cltq   
   412ca:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   412d1:	00 
   412d2:	0f be c0             	movsbl %al,%eax
   412d5:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   412d8:	8b 45 d0             	mov    -0x30(%rbp),%eax
   412db:	48 98                	cltq   
   412dd:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   412e4:	00 
   412e5:	84 c0                	test   %al,%al
   412e7:	75 07                	jne    412f0 <memshow_virtual+0xdb>
                owner = PO_FREE;
   412e9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   412f0:	8b 45 f0             	mov    -0x10(%rbp),%eax
   412f3:	83 c0 02             	add    $0x2,%eax
   412f6:	48 98                	cltq   
   412f8:	0f b7 84 00 e0 42 04 	movzwl 0x442e0(%rax,%rax,1),%eax
   412ff:	00 
   41300:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41304:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41307:	48 98                	cltq   
   41309:	83 e0 04             	and    $0x4,%eax
   4130c:	48 85 c0             	test   %rax,%rax
   4130f:	74 27                	je     41338 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41311:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41315:	c1 e0 04             	shl    $0x4,%eax
   41318:	66 25 00 f0          	and    $0xf000,%ax
   4131c:	89 c2                	mov    %eax,%edx
   4131e:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41322:	c1 f8 04             	sar    $0x4,%eax
   41325:	66 25 00 0f          	and    $0xf00,%ax
   41329:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   4132b:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4132f:	0f b6 c0             	movzbl %al,%eax
   41332:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41334:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   41338:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4133b:	48 98                	cltq   
   4133d:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   41344:	00 
   41345:	3c 01                	cmp    $0x1,%al
   41347:	7e 33                	jle    4137c <memshow_virtual+0x167>
   41349:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   4134e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41352:	74 28                	je     4137c <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41354:	b8 53 00 00 00       	mov    $0x53,%eax
   41359:	89 c2                	mov    %eax,%edx
   4135b:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4135f:	66 25 00 f0          	and    $0xf000,%ax
   41363:	09 d0                	or     %edx,%eax
   41365:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41369:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4136c:	48 98                	cltq   
   4136e:	83 e0 04             	and    $0x4,%eax
   41371:	48 85 c0             	test   %rax,%rax
   41374:	75 06                	jne    4137c <memshow_virtual+0x167>
                    color = color | 0x0F00;
   41376:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   4137c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41380:	48 c1 e8 0c          	shr    $0xc,%rax
   41384:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41387:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4138a:	83 e0 3f             	and    $0x3f,%eax
   4138d:	85 c0                	test   %eax,%eax
   4138f:	75 34                	jne    413c5 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41391:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41394:	c1 e8 06             	shr    $0x6,%eax
   41397:	89 c2                	mov    %eax,%edx
   41399:	89 d0                	mov    %edx,%eax
   4139b:	c1 e0 02             	shl    $0x2,%eax
   4139e:	01 d0                	add    %edx,%eax
   413a0:	c1 e0 04             	shl    $0x4,%eax
   413a3:	05 73 03 00 00       	add    $0x373,%eax
   413a8:	89 c7                	mov    %eax,%edi
   413aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   413ae:	48 89 c1             	mov    %rax,%rcx
   413b1:	ba 16 43 04 00       	mov    $0x44316,%edx
   413b6:	be 00 0f 00 00       	mov    $0xf00,%esi
   413bb:	b8 00 00 00 00       	mov    $0x0,%eax
   413c0:	e8 00 2a 00 00       	call   43dc5 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   413c5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   413c8:	c1 e8 06             	shr    $0x6,%eax
   413cb:	89 c2                	mov    %eax,%edx
   413cd:	89 d0                	mov    %edx,%eax
   413cf:	c1 e0 02             	shl    $0x2,%eax
   413d2:	01 d0                	add    %edx,%eax
   413d4:	c1 e0 04             	shl    $0x4,%eax
   413d7:	89 c2                	mov    %eax,%edx
   413d9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   413dc:	83 e0 3f             	and    $0x3f,%eax
   413df:	01 d0                	add    %edx,%eax
   413e1:	05 7c 03 00 00       	add    $0x37c,%eax
   413e6:	89 c2                	mov    %eax,%edx
   413e8:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413ec:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   413f3:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   413f4:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   413fb:	00 
   413fc:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41403:	00 
   41404:	0f 86 72 fe ff ff    	jbe    4127c <memshow_virtual+0x67>
    }
}
   4140a:	90                   	nop
   4140b:	90                   	nop
   4140c:	c9                   	leave  
   4140d:	c3                   	ret    

000000000004140e <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   4140e:	55                   	push   %rbp
   4140f:	48 89 e5             	mov    %rsp,%rbp
   41412:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41416:	8b 05 24 0e 01 00    	mov    0x10e24(%rip),%eax        # 52240 <last_ticks.1>
   4141c:	85 c0                	test   %eax,%eax
   4141e:	74 13                	je     41433 <memshow_virtual_animate+0x25>
   41420:	8b 15 fa 09 01 00    	mov    0x109fa(%rip),%edx        # 51e20 <ticks>
   41426:	8b 05 14 0e 01 00    	mov    0x10e14(%rip),%eax        # 52240 <last_ticks.1>
   4142c:	29 c2                	sub    %eax,%edx
   4142e:	83 fa 31             	cmp    $0x31,%edx
   41431:	76 2c                	jbe    4145f <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   41433:	8b 05 e7 09 01 00    	mov    0x109e7(%rip),%eax        # 51e20 <ticks>
   41439:	89 05 01 0e 01 00    	mov    %eax,0x10e01(%rip)        # 52240 <last_ticks.1>
        ++showing;
   4143f:	8b 05 bf 3b 00 00    	mov    0x3bbf(%rip),%eax        # 45004 <showing.0>
   41445:	83 c0 01             	add    $0x1,%eax
   41448:	89 05 b6 3b 00 00    	mov    %eax,0x3bb6(%rip)        # 45004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   4144e:	eb 0f                	jmp    4145f <memshow_virtual_animate+0x51>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   41450:	8b 05 ae 3b 00 00    	mov    0x3bae(%rip),%eax        # 45004 <showing.0>
   41456:	83 c0 01             	add    $0x1,%eax
   41459:	89 05 a5 3b 00 00    	mov    %eax,0x3ba5(%rip)        # 45004 <showing.0>
    while (showing <= 2*NPROC
   4145f:	8b 05 9f 3b 00 00    	mov    0x3b9f(%rip),%eax        # 45004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   41465:	83 f8 20             	cmp    $0x20,%eax
   41468:	7f 6d                	jg     414d7 <memshow_virtual_animate+0xc9>
   4146a:	8b 15 94 3b 00 00    	mov    0x3b94(%rip),%edx        # 45004 <showing.0>
   41470:	89 d0                	mov    %edx,%eax
   41472:	c1 f8 1f             	sar    $0x1f,%eax
   41475:	c1 e8 1c             	shr    $0x1c,%eax
   41478:	01 c2                	add    %eax,%edx
   4147a:	83 e2 0f             	and    $0xf,%edx
   4147d:	29 c2                	sub    %eax,%edx
   4147f:	89 d0                	mov    %edx,%eax
   41481:	48 63 d0             	movslq %eax,%rdx
   41484:	48 89 d0             	mov    %rdx,%rax
   41487:	48 c1 e0 03          	shl    $0x3,%rax
   4148b:	48 29 d0             	sub    %rdx,%rax
   4148e:	48 c1 e0 05          	shl    $0x5,%rax
   41492:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   41498:	8b 00                	mov    (%rax),%eax
   4149a:	85 c0                	test   %eax,%eax
   4149c:	74 b2                	je     41450 <memshow_virtual_animate+0x42>
   4149e:	8b 15 60 3b 00 00    	mov    0x3b60(%rip),%edx        # 45004 <showing.0>
   414a4:	89 d0                	mov    %edx,%eax
   414a6:	c1 f8 1f             	sar    $0x1f,%eax
   414a9:	c1 e8 1c             	shr    $0x1c,%eax
   414ac:	01 c2                	add    %eax,%edx
   414ae:	83 e2 0f             	and    $0xf,%edx
   414b1:	29 c2                	sub    %eax,%edx
   414b3:	89 d0                	mov    %edx,%eax
   414b5:	48 63 d0             	movslq %eax,%rdx
   414b8:	48 89 d0             	mov    %rdx,%rax
   414bb:	48 c1 e0 03          	shl    $0x3,%rax
   414bf:	48 29 d0             	sub    %rdx,%rax
   414c2:	48 c1 e0 05          	shl    $0x5,%rax
   414c6:	48 05 f8 10 05 00    	add    $0x510f8,%rax
   414cc:	0f b6 00             	movzbl (%rax),%eax
   414cf:	84 c0                	test   %al,%al
   414d1:	0f 84 79 ff ff ff    	je     41450 <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   414d7:	8b 15 27 3b 00 00    	mov    0x3b27(%rip),%edx        # 45004 <showing.0>
   414dd:	89 d0                	mov    %edx,%eax
   414df:	c1 f8 1f             	sar    $0x1f,%eax
   414e2:	c1 e8 1c             	shr    $0x1c,%eax
   414e5:	01 c2                	add    %eax,%edx
   414e7:	83 e2 0f             	and    $0xf,%edx
   414ea:	29 c2                	sub    %eax,%edx
   414ec:	89 d0                	mov    %edx,%eax
   414ee:	89 05 10 3b 00 00    	mov    %eax,0x3b10(%rip)        # 45004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   414f4:	8b 05 0a 3b 00 00    	mov    0x3b0a(%rip),%eax        # 45004 <showing.0>
   414fa:	48 63 d0             	movslq %eax,%rdx
   414fd:	48 89 d0             	mov    %rdx,%rax
   41500:	48 c1 e0 03          	shl    $0x3,%rax
   41504:	48 29 d0             	sub    %rdx,%rax
   41507:	48 c1 e0 05          	shl    $0x5,%rax
   4150b:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   41511:	8b 00                	mov    (%rax),%eax
   41513:	85 c0                	test   %eax,%eax
   41515:	74 52                	je     41569 <memshow_virtual_animate+0x15b>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41517:	8b 15 e7 3a 00 00    	mov    0x3ae7(%rip),%edx        # 45004 <showing.0>
   4151d:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41521:	89 d1                	mov    %edx,%ecx
   41523:	ba 84 43 04 00       	mov    $0x44384,%edx
   41528:	be 04 00 00 00       	mov    $0x4,%esi
   4152d:	48 89 c7             	mov    %rax,%rdi
   41530:	b8 00 00 00 00       	mov    $0x0,%eax
   41535:	e8 97 29 00 00       	call   43ed1 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   4153a:	8b 05 c4 3a 00 00    	mov    0x3ac4(%rip),%eax        # 45004 <showing.0>
   41540:	48 63 d0             	movslq %eax,%rdx
   41543:	48 89 d0             	mov    %rdx,%rax
   41546:	48 c1 e0 03          	shl    $0x3,%rax
   4154a:	48 29 d0             	sub    %rdx,%rax
   4154d:	48 c1 e0 05          	shl    $0x5,%rax
   41551:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   41557:	48 8b 00             	mov    (%rax),%rax
   4155a:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   4155e:	48 89 d6             	mov    %rdx,%rsi
   41561:	48 89 c7             	mov    %rax,%rdi
   41564:	e8 ac fc ff ff       	call   41215 <memshow_virtual>
    }
}
   41569:	90                   	nop
   4156a:	c9                   	leave  
   4156b:	c3                   	ret    

000000000004156c <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   4156c:	55                   	push   %rbp
   4156d:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41570:	e8 4f 01 00 00       	call   416c4 <segments_init>
    interrupt_init();
   41575:	e8 d0 03 00 00       	call   4194a <interrupt_init>
    virtual_memory_init();
   4157a:	e8 f3 0f 00 00       	call   42572 <virtual_memory_init>
}
   4157f:	90                   	nop
   41580:	5d                   	pop    %rbp
   41581:	c3                   	ret    

0000000000041582 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41582:	55                   	push   %rbp
   41583:	48 89 e5             	mov    %rsp,%rbp
   41586:	48 83 ec 18          	sub    $0x18,%rsp
   4158a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4158e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41592:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41595:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41598:	48 98                	cltq   
   4159a:	48 c1 e0 2d          	shl    $0x2d,%rax
   4159e:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   415a2:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   415a9:	90 00 00 
   415ac:	48 09 c2             	or     %rax,%rdx
    *segment = type
   415af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   415b3:	48 89 10             	mov    %rdx,(%rax)
}
   415b6:	90                   	nop
   415b7:	c9                   	leave  
   415b8:	c3                   	ret    

00000000000415b9 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   415b9:	55                   	push   %rbp
   415ba:	48 89 e5             	mov    %rsp,%rbp
   415bd:	48 83 ec 28          	sub    $0x28,%rsp
   415c1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   415c5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   415c9:	89 55 ec             	mov    %edx,-0x14(%rbp)
   415cc:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   415d0:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   415d4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   415d8:	48 c1 e0 10          	shl    $0x10,%rax
   415dc:	48 89 c2             	mov    %rax,%rdx
   415df:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   415e6:	00 00 00 
   415e9:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   415ec:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   415f0:	48 c1 e0 20          	shl    $0x20,%rax
   415f4:	48 89 c1             	mov    %rax,%rcx
   415f7:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   415fe:	00 00 ff 
   41601:	48 21 c8             	and    %rcx,%rax
   41604:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41607:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4160b:	48 83 e8 01          	sub    $0x1,%rax
   4160f:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41612:	48 09 d0             	or     %rdx,%rax
        | type
   41615:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41619:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4161c:	48 63 d2             	movslq %edx,%rdx
   4161f:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41623:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41626:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   4162d:	80 00 00 
   41630:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41633:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41637:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   4163a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4163e:	48 83 c0 08          	add    $0x8,%rax
   41642:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41646:	48 c1 ea 20          	shr    $0x20,%rdx
   4164a:	48 89 10             	mov    %rdx,(%rax)
}
   4164d:	90                   	nop
   4164e:	c9                   	leave  
   4164f:	c3                   	ret    

0000000000041650 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41650:	55                   	push   %rbp
   41651:	48 89 e5             	mov    %rsp,%rbp
   41654:	48 83 ec 20          	sub    $0x20,%rsp
   41658:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4165c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41660:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41663:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41667:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4166b:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   4166e:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41672:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41675:	48 63 d2             	movslq %edx,%rdx
   41678:	48 c1 e2 2d          	shl    $0x2d,%rdx
   4167c:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   4167f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41683:	48 c1 e0 20          	shl    $0x20,%rax
   41687:	48 89 c1             	mov    %rax,%rcx
   4168a:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41691:	00 ff ff 
   41694:	48 21 c8             	and    %rcx,%rax
   41697:	48 09 c2             	or     %rax,%rdx
   4169a:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   416a1:	80 00 00 
   416a4:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   416a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416ab:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   416ae:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   416b2:	48 c1 e8 20          	shr    $0x20,%rax
   416b6:	48 89 c2             	mov    %rax,%rdx
   416b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416bd:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   416c1:	90                   	nop
   416c2:	c9                   	leave  
   416c3:	c3                   	ret    

00000000000416c4 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   416c4:	55                   	push   %rbp
   416c5:	48 89 e5             	mov    %rsp,%rbp
   416c8:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   416cc:	48 c7 05 89 0b 01 00 	movq   $0x0,0x10b89(%rip)        # 52260 <segments>
   416d3:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   416d7:	ba 00 00 00 00       	mov    $0x0,%edx
   416dc:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   416e3:	08 20 00 
   416e6:	48 89 c6             	mov    %rax,%rsi
   416e9:	bf 68 22 05 00       	mov    $0x52268,%edi
   416ee:	e8 8f fe ff ff       	call   41582 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   416f3:	ba 03 00 00 00       	mov    $0x3,%edx
   416f8:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   416ff:	08 20 00 
   41702:	48 89 c6             	mov    %rax,%rsi
   41705:	bf 70 22 05 00       	mov    $0x52270,%edi
   4170a:	e8 73 fe ff ff       	call   41582 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   4170f:	ba 00 00 00 00       	mov    $0x0,%edx
   41714:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   4171b:	02 00 00 
   4171e:	48 89 c6             	mov    %rax,%rsi
   41721:	bf 78 22 05 00       	mov    $0x52278,%edi
   41726:	e8 57 fe ff ff       	call   41582 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   4172b:	ba 03 00 00 00       	mov    $0x3,%edx
   41730:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41737:	02 00 00 
   4173a:	48 89 c6             	mov    %rax,%rsi
   4173d:	bf 80 22 05 00       	mov    $0x52280,%edi
   41742:	e8 3b fe ff ff       	call   41582 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41747:	b8 a0 32 05 00       	mov    $0x532a0,%eax
   4174c:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41752:	48 89 c1             	mov    %rax,%rcx
   41755:	ba 00 00 00 00       	mov    $0x0,%edx
   4175a:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41761:	09 00 00 
   41764:	48 89 c6             	mov    %rax,%rsi
   41767:	bf 88 22 05 00       	mov    $0x52288,%edi
   4176c:	e8 48 fe ff ff       	call   415b9 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41771:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41777:	b8 60 22 05 00       	mov    $0x52260,%eax
   4177c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41780:	ba 60 00 00 00       	mov    $0x60,%edx
   41785:	be 00 00 00 00       	mov    $0x0,%esi
   4178a:	bf a0 32 05 00       	mov    $0x532a0,%edi
   4178f:	e8 7a 18 00 00       	call   4300e <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41794:	48 c7 05 05 1b 01 00 	movq   $0x80000,0x11b05(%rip)        # 532a4 <kernel_task_descriptor+0x4>
   4179b:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   4179f:	ba 00 10 00 00       	mov    $0x1000,%edx
   417a4:	be 00 00 00 00       	mov    $0x0,%esi
   417a9:	bf a0 22 05 00       	mov    $0x522a0,%edi
   417ae:	e8 5b 18 00 00       	call   4300e <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   417b3:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   417ba:	eb 30                	jmp    417ec <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   417bc:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   417c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   417c4:	48 c1 e0 04          	shl    $0x4,%rax
   417c8:	48 05 a0 22 05 00    	add    $0x522a0,%rax
   417ce:	48 89 d1             	mov    %rdx,%rcx
   417d1:	ba 00 00 00 00       	mov    $0x0,%edx
   417d6:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   417dd:	0e 00 00 
   417e0:	48 89 c7             	mov    %rax,%rdi
   417e3:	e8 68 fe ff ff       	call   41650 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   417e8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   417ec:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   417f3:	76 c7                	jbe    417bc <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   417f5:	b8 36 00 04 00       	mov    $0x40036,%eax
   417fa:	48 89 c1             	mov    %rax,%rcx
   417fd:	ba 00 00 00 00       	mov    $0x0,%edx
   41802:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41809:	0e 00 00 
   4180c:	48 89 c6             	mov    %rax,%rsi
   4180f:	bf a0 24 05 00       	mov    $0x524a0,%edi
   41814:	e8 37 fe ff ff       	call   41650 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41819:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   4181e:	48 89 c1             	mov    %rax,%rcx
   41821:	ba 00 00 00 00       	mov    $0x0,%edx
   41826:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   4182d:	0e 00 00 
   41830:	48 89 c6             	mov    %rax,%rsi
   41833:	bf 70 23 05 00       	mov    $0x52370,%edi
   41838:	e8 13 fe ff ff       	call   41650 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   4183d:	b8 32 00 04 00       	mov    $0x40032,%eax
   41842:	48 89 c1             	mov    %rax,%rcx
   41845:	ba 00 00 00 00       	mov    $0x0,%edx
   4184a:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41851:	0e 00 00 
   41854:	48 89 c6             	mov    %rax,%rsi
   41857:	bf 80 23 05 00       	mov    $0x52380,%edi
   4185c:	e8 ef fd ff ff       	call   41650 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41861:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41868:	eb 3e                	jmp    418a8 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   4186a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4186d:	83 e8 30             	sub    $0x30,%eax
   41870:	89 c0                	mov    %eax,%eax
   41872:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41879:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   4187a:	48 89 c2             	mov    %rax,%rdx
   4187d:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41880:	48 c1 e0 04          	shl    $0x4,%rax
   41884:	48 05 a0 22 05 00    	add    $0x522a0,%rax
   4188a:	48 89 d1             	mov    %rdx,%rcx
   4188d:	ba 03 00 00 00       	mov    $0x3,%edx
   41892:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41899:	0e 00 00 
   4189c:	48 89 c7             	mov    %rax,%rdi
   4189f:	e8 ac fd ff ff       	call   41650 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   418a4:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   418a8:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   418ac:	76 bc                	jbe    4186a <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   418ae:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   418b4:	b8 a0 22 05 00       	mov    $0x522a0,%eax
   418b9:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   418bd:	b8 28 00 00 00       	mov    $0x28,%eax
   418c2:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   418c6:	0f 00 d8             	ltr    %ax
   418c9:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   418cd:	0f 20 c0             	mov    %cr0,%rax
   418d0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   418d4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   418d8:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   418db:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   418e2:	8b 45 f4             	mov    -0xc(%rbp),%eax
   418e5:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   418e8:	8b 45 f0             	mov    -0x10(%rbp),%eax
   418eb:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   418ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   418f3:	0f 22 c0             	mov    %rax,%cr0
}
   418f6:	90                   	nop
    lcr0(cr0);
}
   418f7:	90                   	nop
   418f8:	c9                   	leave  
   418f9:	c3                   	ret    

00000000000418fa <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   418fa:	55                   	push   %rbp
   418fb:	48 89 e5             	mov    %rsp,%rbp
   418fe:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41902:	0f b7 05 f7 19 01 00 	movzwl 0x119f7(%rip),%eax        # 53300 <interrupts_enabled>
   41909:	f7 d0                	not    %eax
   4190b:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   4190f:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41913:	0f b6 c0             	movzbl %al,%eax
   41916:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   4191d:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41920:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41924:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41927:	ee                   	out    %al,(%dx)
}
   41928:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41929:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   4192d:	66 c1 e8 08          	shr    $0x8,%ax
   41931:	0f b6 c0             	movzbl %al,%eax
   41934:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   4193b:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4193e:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41942:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41945:	ee                   	out    %al,(%dx)
}
   41946:	90                   	nop
}
   41947:	90                   	nop
   41948:	c9                   	leave  
   41949:	c3                   	ret    

000000000004194a <interrupt_init>:

void interrupt_init(void) {
   4194a:	55                   	push   %rbp
   4194b:	48 89 e5             	mov    %rsp,%rbp
   4194e:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41952:	66 c7 05 a5 19 01 00 	movw   $0x0,0x119a5(%rip)        # 53300 <interrupts_enabled>
   41959:	00 00 
    interrupt_mask();
   4195b:	e8 9a ff ff ff       	call   418fa <interrupt_mask>
   41960:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41967:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4196b:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   4196f:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41972:	ee                   	out    %al,(%dx)
}
   41973:	90                   	nop
   41974:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   4197b:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4197f:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41983:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41986:	ee                   	out    %al,(%dx)
}
   41987:	90                   	nop
   41988:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   4198f:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41993:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41997:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   4199a:	ee                   	out    %al,(%dx)
}
   4199b:	90                   	nop
   4199c:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   419a3:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419a7:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   419ab:	8b 55 bc             	mov    -0x44(%rbp),%edx
   419ae:	ee                   	out    %al,(%dx)
}
   419af:	90                   	nop
   419b0:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   419b7:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419bb:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   419bf:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   419c2:	ee                   	out    %al,(%dx)
}
   419c3:	90                   	nop
   419c4:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   419cb:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419cf:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   419d3:	8b 55 cc             	mov    -0x34(%rbp),%edx
   419d6:	ee                   	out    %al,(%dx)
}
   419d7:	90                   	nop
   419d8:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   419df:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419e3:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   419e7:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   419ea:	ee                   	out    %al,(%dx)
}
   419eb:	90                   	nop
   419ec:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   419f3:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419f7:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   419fb:	8b 55 dc             	mov    -0x24(%rbp),%edx
   419fe:	ee                   	out    %al,(%dx)
}
   419ff:	90                   	nop
   41a00:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41a07:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a0b:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41a0f:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41a12:	ee                   	out    %al,(%dx)
}
   41a13:	90                   	nop
   41a14:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41a1b:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a1f:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41a23:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41a26:	ee                   	out    %al,(%dx)
}
   41a27:	90                   	nop
   41a28:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41a2f:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a33:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41a37:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41a3a:	ee                   	out    %al,(%dx)
}
   41a3b:	90                   	nop
   41a3c:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41a43:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a47:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41a4b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41a4e:	ee                   	out    %al,(%dx)
}
   41a4f:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41a50:	e8 a5 fe ff ff       	call   418fa <interrupt_mask>
}
   41a55:	90                   	nop
   41a56:	c9                   	leave  
   41a57:	c3                   	ret    

0000000000041a58 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41a58:	55                   	push   %rbp
   41a59:	48 89 e5             	mov    %rsp,%rbp
   41a5c:	48 83 ec 28          	sub    $0x28,%rsp
   41a60:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41a63:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41a67:	0f 8e 9e 00 00 00    	jle    41b0b <timer_init+0xb3>
   41a6d:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41a74:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a78:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41a7c:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41a7f:	ee                   	out    %al,(%dx)
}
   41a80:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41a81:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41a84:	89 c2                	mov    %eax,%edx
   41a86:	c1 ea 1f             	shr    $0x1f,%edx
   41a89:	01 d0                	add    %edx,%eax
   41a8b:	d1 f8                	sar    %eax
   41a8d:	05 de 34 12 00       	add    $0x1234de,%eax
   41a92:	99                   	cltd   
   41a93:	f7 7d dc             	idivl  -0x24(%rbp)
   41a96:	89 c2                	mov    %eax,%edx
   41a98:	89 d0                	mov    %edx,%eax
   41a9a:	c1 f8 1f             	sar    $0x1f,%eax
   41a9d:	c1 e8 18             	shr    $0x18,%eax
   41aa0:	01 c2                	add    %eax,%edx
   41aa2:	0f b6 d2             	movzbl %dl,%edx
   41aa5:	29 c2                	sub    %eax,%edx
   41aa7:	89 d0                	mov    %edx,%eax
   41aa9:	0f b6 c0             	movzbl %al,%eax
   41aac:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41ab3:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ab6:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41aba:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41abd:	ee                   	out    %al,(%dx)
}
   41abe:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41abf:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41ac2:	89 c2                	mov    %eax,%edx
   41ac4:	c1 ea 1f             	shr    $0x1f,%edx
   41ac7:	01 d0                	add    %edx,%eax
   41ac9:	d1 f8                	sar    %eax
   41acb:	05 de 34 12 00       	add    $0x1234de,%eax
   41ad0:	99                   	cltd   
   41ad1:	f7 7d dc             	idivl  -0x24(%rbp)
   41ad4:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41ada:	85 c0                	test   %eax,%eax
   41adc:	0f 48 c2             	cmovs  %edx,%eax
   41adf:	c1 f8 08             	sar    $0x8,%eax
   41ae2:	0f b6 c0             	movzbl %al,%eax
   41ae5:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41aec:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41aef:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41af3:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41af6:	ee                   	out    %al,(%dx)
}
   41af7:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41af8:	0f b7 05 01 18 01 00 	movzwl 0x11801(%rip),%eax        # 53300 <interrupts_enabled>
   41aff:	83 c8 01             	or     $0x1,%eax
   41b02:	66 89 05 f7 17 01 00 	mov    %ax,0x117f7(%rip)        # 53300 <interrupts_enabled>
   41b09:	eb 11                	jmp    41b1c <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41b0b:	0f b7 05 ee 17 01 00 	movzwl 0x117ee(%rip),%eax        # 53300 <interrupts_enabled>
   41b12:	83 e0 fe             	and    $0xfffffffe,%eax
   41b15:	66 89 05 e4 17 01 00 	mov    %ax,0x117e4(%rip)        # 53300 <interrupts_enabled>
    }
    interrupt_mask();
   41b1c:	e8 d9 fd ff ff       	call   418fa <interrupt_mask>
}
   41b21:	90                   	nop
   41b22:	c9                   	leave  
   41b23:	c3                   	ret    

0000000000041b24 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41b24:	55                   	push   %rbp
   41b25:	48 89 e5             	mov    %rsp,%rbp
   41b28:	48 83 ec 08          	sub    $0x8,%rsp
   41b2c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41b30:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41b35:	74 14                	je     41b4b <physical_memory_isreserved+0x27>
   41b37:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41b3e:	00 
   41b3f:	76 11                	jbe    41b52 <physical_memory_isreserved+0x2e>
   41b41:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41b48:	00 
   41b49:	77 07                	ja     41b52 <physical_memory_isreserved+0x2e>
   41b4b:	b8 01 00 00 00       	mov    $0x1,%eax
   41b50:	eb 05                	jmp    41b57 <physical_memory_isreserved+0x33>
   41b52:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41b57:	c9                   	leave  
   41b58:	c3                   	ret    

0000000000041b59 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41b59:	55                   	push   %rbp
   41b5a:	48 89 e5             	mov    %rsp,%rbp
   41b5d:	48 83 ec 10          	sub    $0x10,%rsp
   41b61:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41b64:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41b67:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41b6a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41b6d:	c1 e0 10             	shl    $0x10,%eax
   41b70:	89 c2                	mov    %eax,%edx
   41b72:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41b75:	c1 e0 0b             	shl    $0xb,%eax
   41b78:	09 c2                	or     %eax,%edx
   41b7a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41b7d:	c1 e0 08             	shl    $0x8,%eax
   41b80:	09 d0                	or     %edx,%eax
}
   41b82:	c9                   	leave  
   41b83:	c3                   	ret    

0000000000041b84 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41b84:	55                   	push   %rbp
   41b85:	48 89 e5             	mov    %rsp,%rbp
   41b88:	48 83 ec 18          	sub    $0x18,%rsp
   41b8c:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41b8f:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41b92:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41b95:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41b98:	09 d0                	or     %edx,%eax
   41b9a:	0d 00 00 00 80       	or     $0x80000000,%eax
   41b9f:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41ba6:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41ba9:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41bac:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41baf:	ef                   	out    %eax,(%dx)
}
   41bb0:	90                   	nop
   41bb1:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41bb8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41bbb:	89 c2                	mov    %eax,%edx
   41bbd:	ed                   	in     (%dx),%eax
   41bbe:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41bc1:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41bc4:	c9                   	leave  
   41bc5:	c3                   	ret    

0000000000041bc6 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41bc6:	55                   	push   %rbp
   41bc7:	48 89 e5             	mov    %rsp,%rbp
   41bca:	48 83 ec 28          	sub    $0x28,%rsp
   41bce:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41bd1:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41bd4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41bdb:	eb 73                	jmp    41c50 <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41bdd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41be4:	eb 60                	jmp    41c46 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41be6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41bed:	eb 4a                	jmp    41c39 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41bef:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41bf2:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41bf5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41bf8:	89 ce                	mov    %ecx,%esi
   41bfa:	89 c7                	mov    %eax,%edi
   41bfc:	e8 58 ff ff ff       	call   41b59 <pci_make_configaddr>
   41c01:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41c04:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41c07:	be 00 00 00 00       	mov    $0x0,%esi
   41c0c:	89 c7                	mov    %eax,%edi
   41c0e:	e8 71 ff ff ff       	call   41b84 <pci_config_readl>
   41c13:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41c16:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41c19:	c1 e0 10             	shl    $0x10,%eax
   41c1c:	0b 45 dc             	or     -0x24(%rbp),%eax
   41c1f:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41c22:	75 05                	jne    41c29 <pci_find_device+0x63>
                    return configaddr;
   41c24:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41c27:	eb 35                	jmp    41c5e <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41c29:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41c2d:	75 06                	jne    41c35 <pci_find_device+0x6f>
   41c2f:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41c33:	74 0c                	je     41c41 <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41c35:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41c39:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41c3d:	75 b0                	jne    41bef <pci_find_device+0x29>
   41c3f:	eb 01                	jmp    41c42 <pci_find_device+0x7c>
                    break;
   41c41:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41c42:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41c46:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41c4a:	75 9a                	jne    41be6 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41c4c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41c50:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41c57:	75 84                	jne    41bdd <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41c59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41c5e:	c9                   	leave  
   41c5f:	c3                   	ret    

0000000000041c60 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41c60:	55                   	push   %rbp
   41c61:	48 89 e5             	mov    %rsp,%rbp
   41c64:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41c68:	be 13 71 00 00       	mov    $0x7113,%esi
   41c6d:	bf 86 80 00 00       	mov    $0x8086,%edi
   41c72:	e8 4f ff ff ff       	call   41bc6 <pci_find_device>
   41c77:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41c7a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41c7e:	78 30                	js     41cb0 <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41c80:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41c83:	be 40 00 00 00       	mov    $0x40,%esi
   41c88:	89 c7                	mov    %eax,%edi
   41c8a:	e8 f5 fe ff ff       	call   41b84 <pci_config_readl>
   41c8f:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41c94:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41c97:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41c9a:	83 c0 04             	add    $0x4,%eax
   41c9d:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41ca0:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41ca6:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41caa:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41cad:	66 ef                	out    %ax,(%dx)
}
   41caf:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41cb0:	ba a0 43 04 00       	mov    $0x443a0,%edx
   41cb5:	be 00 c0 00 00       	mov    $0xc000,%esi
   41cba:	bf 80 07 00 00       	mov    $0x780,%edi
   41cbf:	b8 00 00 00 00       	mov    $0x0,%eax
   41cc4:	e8 fc 20 00 00       	call   43dc5 <console_printf>
 spinloop: goto spinloop;
   41cc9:	eb fe                	jmp    41cc9 <poweroff+0x69>

0000000000041ccb <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41ccb:	55                   	push   %rbp
   41ccc:	48 89 e5             	mov    %rsp,%rbp
   41ccf:	48 83 ec 10          	sub    $0x10,%rsp
   41cd3:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41cda:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cde:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ce2:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41ce5:	ee                   	out    %al,(%dx)
}
   41ce6:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41ce7:	eb fe                	jmp    41ce7 <reboot+0x1c>

0000000000041ce9 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41ce9:	55                   	push   %rbp
   41cea:	48 89 e5             	mov    %rsp,%rbp
   41ced:	48 83 ec 10          	sub    $0x10,%rsp
   41cf1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41cf5:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41cf8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41cfc:	48 83 c0 08          	add    $0x8,%rax
   41d00:	ba c0 00 00 00       	mov    $0xc0,%edx
   41d05:	be 00 00 00 00       	mov    $0x0,%esi
   41d0a:	48 89 c7             	mov    %rax,%rdi
   41d0d:	e8 fc 12 00 00       	call   4300e <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41d12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d16:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   41d1d:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41d1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d23:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   41d2a:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41d2e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d32:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   41d39:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41d3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d41:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   41d48:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41d4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d4e:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   41d55:	00 02 00 00 
    p->display_status = 1;
   41d59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d5d:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41d64:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41d67:	83 e0 01             	and    $0x1,%eax
   41d6a:	85 c0                	test   %eax,%eax
   41d6c:	74 1c                	je     41d8a <process_init+0xa1>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41d6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d72:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   41d79:	80 cc 30             	or     $0x30,%ah
   41d7c:	48 89 c2             	mov    %rax,%rdx
   41d7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d83:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41d8a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41d8d:	83 e0 02             	and    $0x2,%eax
   41d90:	85 c0                	test   %eax,%eax
   41d92:	74 1c                	je     41db0 <process_init+0xc7>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41d94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d98:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   41d9f:	80 e4 fd             	and    $0xfd,%ah
   41da2:	48 89 c2             	mov    %rax,%rdx
   41da5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41da9:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   41db0:	90                   	nop
   41db1:	c9                   	leave  
   41db2:	c3                   	ret    

0000000000041db3 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41db3:	55                   	push   %rbp
   41db4:	48 89 e5             	mov    %rsp,%rbp
   41db7:	48 83 ec 28          	sub    $0x28,%rsp
   41dbb:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41dbe:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41dc2:	78 09                	js     41dcd <console_show_cursor+0x1a>
   41dc4:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41dcb:	7e 07                	jle    41dd4 <console_show_cursor+0x21>
        cpos = 0;
   41dcd:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41dd4:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41ddb:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ddf:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41de3:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41de6:	ee                   	out    %al,(%dx)
}
   41de7:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41de8:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41deb:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41df1:	85 c0                	test   %eax,%eax
   41df3:	0f 48 c2             	cmovs  %edx,%eax
   41df6:	c1 f8 08             	sar    $0x8,%eax
   41df9:	0f b6 c0             	movzbl %al,%eax
   41dfc:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41e03:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e06:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41e0a:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41e0d:	ee                   	out    %al,(%dx)
}
   41e0e:	90                   	nop
   41e0f:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41e16:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e1a:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41e1e:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41e21:	ee                   	out    %al,(%dx)
}
   41e22:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41e23:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41e26:	89 d0                	mov    %edx,%eax
   41e28:	c1 f8 1f             	sar    $0x1f,%eax
   41e2b:	c1 e8 18             	shr    $0x18,%eax
   41e2e:	01 c2                	add    %eax,%edx
   41e30:	0f b6 d2             	movzbl %dl,%edx
   41e33:	29 c2                	sub    %eax,%edx
   41e35:	89 d0                	mov    %edx,%eax
   41e37:	0f b6 c0             	movzbl %al,%eax
   41e3a:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   41e41:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e44:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41e48:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41e4b:	ee                   	out    %al,(%dx)
}
   41e4c:	90                   	nop
}
   41e4d:	90                   	nop
   41e4e:	c9                   	leave  
   41e4f:	c3                   	ret    

0000000000041e50 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   41e50:	55                   	push   %rbp
   41e51:	48 89 e5             	mov    %rsp,%rbp
   41e54:	48 83 ec 20          	sub    $0x20,%rsp
   41e58:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41e5f:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41e62:	89 c2                	mov    %eax,%edx
   41e64:	ec                   	in     (%dx),%al
   41e65:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41e68:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   41e6c:	0f b6 c0             	movzbl %al,%eax
   41e6f:	83 e0 01             	and    $0x1,%eax
   41e72:	85 c0                	test   %eax,%eax
   41e74:	75 0a                	jne    41e80 <keyboard_readc+0x30>
        return -1;
   41e76:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41e7b:	e9 e7 01 00 00       	jmp    42067 <keyboard_readc+0x217>
   41e80:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41e87:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41e8a:	89 c2                	mov    %eax,%edx
   41e8c:	ec                   	in     (%dx),%al
   41e8d:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   41e90:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   41e94:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   41e97:	0f b6 05 64 14 01 00 	movzbl 0x11464(%rip),%eax        # 53302 <last_escape.2>
   41e9e:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   41ea1:	c6 05 5a 14 01 00 00 	movb   $0x0,0x1145a(%rip)        # 53302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   41ea8:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   41eac:	75 11                	jne    41ebf <keyboard_readc+0x6f>
        last_escape = 0x80;
   41eae:	c6 05 4d 14 01 00 80 	movb   $0x80,0x1144d(%rip)        # 53302 <last_escape.2>
        return 0;
   41eb5:	b8 00 00 00 00       	mov    $0x0,%eax
   41eba:	e9 a8 01 00 00       	jmp    42067 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   41ebf:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ec3:	84 c0                	test   %al,%al
   41ec5:	79 60                	jns    41f27 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   41ec7:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ecb:	83 e0 7f             	and    $0x7f,%eax
   41ece:	89 c2                	mov    %eax,%edx
   41ed0:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   41ed4:	09 d0                	or     %edx,%eax
   41ed6:	48 98                	cltq   
   41ed8:	0f b6 80 c0 43 04 00 	movzbl 0x443c0(%rax),%eax
   41edf:	0f b6 c0             	movzbl %al,%eax
   41ee2:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   41ee5:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   41eec:	7e 2f                	jle    41f1d <keyboard_readc+0xcd>
   41eee:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   41ef5:	7f 26                	jg     41f1d <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   41ef7:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41efa:	2d fa 00 00 00       	sub    $0xfa,%eax
   41eff:	ba 01 00 00 00       	mov    $0x1,%edx
   41f04:	89 c1                	mov    %eax,%ecx
   41f06:	d3 e2                	shl    %cl,%edx
   41f08:	89 d0                	mov    %edx,%eax
   41f0a:	f7 d0                	not    %eax
   41f0c:	89 c2                	mov    %eax,%edx
   41f0e:	0f b6 05 ee 13 01 00 	movzbl 0x113ee(%rip),%eax        # 53303 <modifiers.1>
   41f15:	21 d0                	and    %edx,%eax
   41f17:	88 05 e6 13 01 00    	mov    %al,0x113e6(%rip)        # 53303 <modifiers.1>
        }
        return 0;
   41f1d:	b8 00 00 00 00       	mov    $0x0,%eax
   41f22:	e9 40 01 00 00       	jmp    42067 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   41f27:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f2b:	0a 45 fa             	or     -0x6(%rbp),%al
   41f2e:	0f b6 c0             	movzbl %al,%eax
   41f31:	48 98                	cltq   
   41f33:	0f b6 80 c0 43 04 00 	movzbl 0x443c0(%rax),%eax
   41f3a:	0f b6 c0             	movzbl %al,%eax
   41f3d:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   41f40:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   41f44:	7e 57                	jle    41f9d <keyboard_readc+0x14d>
   41f46:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   41f4a:	7f 51                	jg     41f9d <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   41f4c:	0f b6 05 b0 13 01 00 	movzbl 0x113b0(%rip),%eax        # 53303 <modifiers.1>
   41f53:	0f b6 c0             	movzbl %al,%eax
   41f56:	83 e0 02             	and    $0x2,%eax
   41f59:	85 c0                	test   %eax,%eax
   41f5b:	74 09                	je     41f66 <keyboard_readc+0x116>
            ch -= 0x60;
   41f5d:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   41f61:	e9 fd 00 00 00       	jmp    42063 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   41f66:	0f b6 05 96 13 01 00 	movzbl 0x11396(%rip),%eax        # 53303 <modifiers.1>
   41f6d:	0f b6 c0             	movzbl %al,%eax
   41f70:	83 e0 01             	and    $0x1,%eax
   41f73:	85 c0                	test   %eax,%eax
   41f75:	0f 94 c2             	sete   %dl
   41f78:	0f b6 05 84 13 01 00 	movzbl 0x11384(%rip),%eax        # 53303 <modifiers.1>
   41f7f:	0f b6 c0             	movzbl %al,%eax
   41f82:	83 e0 08             	and    $0x8,%eax
   41f85:	85 c0                	test   %eax,%eax
   41f87:	0f 94 c0             	sete   %al
   41f8a:	31 d0                	xor    %edx,%eax
   41f8c:	84 c0                	test   %al,%al
   41f8e:	0f 84 cf 00 00 00    	je     42063 <keyboard_readc+0x213>
            ch -= 0x20;
   41f94:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   41f98:	e9 c6 00 00 00       	jmp    42063 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   41f9d:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   41fa4:	7e 30                	jle    41fd6 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   41fa6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41fa9:	2d fa 00 00 00       	sub    $0xfa,%eax
   41fae:	ba 01 00 00 00       	mov    $0x1,%edx
   41fb3:	89 c1                	mov    %eax,%ecx
   41fb5:	d3 e2                	shl    %cl,%edx
   41fb7:	89 d0                	mov    %edx,%eax
   41fb9:	89 c2                	mov    %eax,%edx
   41fbb:	0f b6 05 41 13 01 00 	movzbl 0x11341(%rip),%eax        # 53303 <modifiers.1>
   41fc2:	31 d0                	xor    %edx,%eax
   41fc4:	88 05 39 13 01 00    	mov    %al,0x11339(%rip)        # 53303 <modifiers.1>
        ch = 0;
   41fca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41fd1:	e9 8e 00 00 00       	jmp    42064 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   41fd6:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   41fdd:	7e 2d                	jle    4200c <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   41fdf:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41fe2:	2d fa 00 00 00       	sub    $0xfa,%eax
   41fe7:	ba 01 00 00 00       	mov    $0x1,%edx
   41fec:	89 c1                	mov    %eax,%ecx
   41fee:	d3 e2                	shl    %cl,%edx
   41ff0:	89 d0                	mov    %edx,%eax
   41ff2:	89 c2                	mov    %eax,%edx
   41ff4:	0f b6 05 08 13 01 00 	movzbl 0x11308(%rip),%eax        # 53303 <modifiers.1>
   41ffb:	09 d0                	or     %edx,%eax
   41ffd:	88 05 00 13 01 00    	mov    %al,0x11300(%rip)        # 53303 <modifiers.1>
        ch = 0;
   42003:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4200a:	eb 58                	jmp    42064 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   4200c:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42010:	7e 31                	jle    42043 <keyboard_readc+0x1f3>
   42012:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   42019:	7f 28                	jg     42043 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   4201b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4201e:	8d 50 80             	lea    -0x80(%rax),%edx
   42021:	0f b6 05 db 12 01 00 	movzbl 0x112db(%rip),%eax        # 53303 <modifiers.1>
   42028:	0f b6 c0             	movzbl %al,%eax
   4202b:	83 e0 03             	and    $0x3,%eax
   4202e:	48 98                	cltq   
   42030:	48 63 d2             	movslq %edx,%rdx
   42033:	0f b6 84 90 c0 44 04 	movzbl 0x444c0(%rax,%rdx,4),%eax
   4203a:	00 
   4203b:	0f b6 c0             	movzbl %al,%eax
   4203e:	89 45 fc             	mov    %eax,-0x4(%rbp)
   42041:	eb 21                	jmp    42064 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   42043:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42047:	7f 1b                	jg     42064 <keyboard_readc+0x214>
   42049:	0f b6 05 b3 12 01 00 	movzbl 0x112b3(%rip),%eax        # 53303 <modifiers.1>
   42050:	0f b6 c0             	movzbl %al,%eax
   42053:	83 e0 02             	and    $0x2,%eax
   42056:	85 c0                	test   %eax,%eax
   42058:	74 0a                	je     42064 <keyboard_readc+0x214>
        ch = 0;
   4205a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42061:	eb 01                	jmp    42064 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   42063:	90                   	nop
    }

    return ch;
   42064:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   42067:	c9                   	leave  
   42068:	c3                   	ret    

0000000000042069 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   42069:	55                   	push   %rbp
   4206a:	48 89 e5             	mov    %rsp,%rbp
   4206d:	48 83 ec 20          	sub    $0x20,%rsp
   42071:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42078:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4207b:	89 c2                	mov    %eax,%edx
   4207d:	ec                   	in     (%dx),%al
   4207e:	88 45 e3             	mov    %al,-0x1d(%rbp)
   42081:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42088:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4208b:	89 c2                	mov    %eax,%edx
   4208d:	ec                   	in     (%dx),%al
   4208e:	88 45 eb             	mov    %al,-0x15(%rbp)
   42091:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42098:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4209b:	89 c2                	mov    %eax,%edx
   4209d:	ec                   	in     (%dx),%al
   4209e:	88 45 f3             	mov    %al,-0xd(%rbp)
   420a1:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   420a8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   420ab:	89 c2                	mov    %eax,%edx
   420ad:	ec                   	in     (%dx),%al
   420ae:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   420b1:	90                   	nop
   420b2:	c9                   	leave  
   420b3:	c3                   	ret    

00000000000420b4 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   420b4:	55                   	push   %rbp
   420b5:	48 89 e5             	mov    %rsp,%rbp
   420b8:	48 83 ec 40          	sub    $0x40,%rsp
   420bc:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   420c0:	89 f0                	mov    %esi,%eax
   420c2:	89 55 c0             	mov    %edx,-0x40(%rbp)
   420c5:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   420c8:	8b 05 36 12 01 00    	mov    0x11236(%rip),%eax        # 53304 <initialized.0>
   420ce:	85 c0                	test   %eax,%eax
   420d0:	75 1e                	jne    420f0 <parallel_port_putc+0x3c>
   420d2:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   420d9:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420dd:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   420e1:	8b 55 f8             	mov    -0x8(%rbp),%edx
   420e4:	ee                   	out    %al,(%dx)
}
   420e5:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   420e6:	c7 05 14 12 01 00 01 	movl   $0x1,0x11214(%rip)        # 53304 <initialized.0>
   420ed:	00 00 00 
    }

    for (int i = 0;
   420f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   420f7:	eb 09                	jmp    42102 <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   420f9:	e8 6b ff ff ff       	call   42069 <delay>
         ++i) {
   420fe:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   42102:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42109:	7f 18                	jg     42123 <parallel_port_putc+0x6f>
   4210b:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42112:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42115:	89 c2                	mov    %eax,%edx
   42117:	ec                   	in     (%dx),%al
   42118:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   4211b:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   4211f:	84 c0                	test   %al,%al
   42121:	79 d6                	jns    420f9 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   42123:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   42127:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   4212e:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42131:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   42135:	8b 55 d8             	mov    -0x28(%rbp),%edx
   42138:	ee                   	out    %al,(%dx)
}
   42139:	90                   	nop
   4213a:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   42141:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42145:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42149:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4214c:	ee                   	out    %al,(%dx)
}
   4214d:	90                   	nop
   4214e:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42155:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42159:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   4215d:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42160:	ee                   	out    %al,(%dx)
}
   42161:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42162:	90                   	nop
   42163:	c9                   	leave  
   42164:	c3                   	ret    

0000000000042165 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42165:	55                   	push   %rbp
   42166:	48 89 e5             	mov    %rsp,%rbp
   42169:	48 83 ec 20          	sub    $0x20,%rsp
   4216d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42171:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42175:	48 c7 45 f8 b4 20 04 	movq   $0x420b4,-0x8(%rbp)
   4217c:	00 
    printer_vprintf(&p, 0, format, val);
   4217d:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42181:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42185:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42189:	be 00 00 00 00       	mov    $0x0,%esi
   4218e:	48 89 c7             	mov    %rax,%rdi
   42191:	e8 14 11 00 00       	call   432aa <printer_vprintf>
}
   42196:	90                   	nop
   42197:	c9                   	leave  
   42198:	c3                   	ret    

0000000000042199 <log_printf>:

void log_printf(const char* format, ...) {
   42199:	55                   	push   %rbp
   4219a:	48 89 e5             	mov    %rsp,%rbp
   4219d:	48 83 ec 60          	sub    $0x60,%rsp
   421a1:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   421a5:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   421a9:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   421ad:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   421b1:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   421b5:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   421b9:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   421c0:	48 8d 45 10          	lea    0x10(%rbp),%rax
   421c4:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   421c8:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   421cc:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   421d0:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   421d4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   421d8:	48 89 d6             	mov    %rdx,%rsi
   421db:	48 89 c7             	mov    %rax,%rdi
   421de:	e8 82 ff ff ff       	call   42165 <log_vprintf>
    va_end(val);
}
   421e3:	90                   	nop
   421e4:	c9                   	leave  
   421e5:	c3                   	ret    

00000000000421e6 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   421e6:	55                   	push   %rbp
   421e7:	48 89 e5             	mov    %rsp,%rbp
   421ea:	48 83 ec 40          	sub    $0x40,%rsp
   421ee:	89 7d dc             	mov    %edi,-0x24(%rbp)
   421f1:	89 75 d8             	mov    %esi,-0x28(%rbp)
   421f4:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   421f8:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   421fc:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   42200:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42204:	48 8b 0a             	mov    (%rdx),%rcx
   42207:	48 89 08             	mov    %rcx,(%rax)
   4220a:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   4220e:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42212:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42216:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   4221a:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   4221e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42222:	48 89 d6             	mov    %rdx,%rsi
   42225:	48 89 c7             	mov    %rax,%rdi
   42228:	e8 38 ff ff ff       	call   42165 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   4222d:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42231:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42235:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42238:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4223b:	89 c7                	mov    %eax,%edi
   4223d:	e8 17 1b 00 00       	call   43d59 <console_vprintf>
}
   42242:	c9                   	leave  
   42243:	c3                   	ret    

0000000000042244 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42244:	55                   	push   %rbp
   42245:	48 89 e5             	mov    %rsp,%rbp
   42248:	48 83 ec 60          	sub    $0x60,%rsp
   4224c:	89 7d ac             	mov    %edi,-0x54(%rbp)
   4224f:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42252:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42256:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4225a:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4225e:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42262:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42269:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4226d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42271:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42275:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42279:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4227d:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42281:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42284:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42287:	89 c7                	mov    %eax,%edi
   42289:	e8 58 ff ff ff       	call   421e6 <error_vprintf>
   4228e:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42291:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42294:	c9                   	leave  
   42295:	c3                   	ret    

0000000000042296 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42296:	55                   	push   %rbp
   42297:	48 89 e5             	mov    %rsp,%rbp
   4229a:	53                   	push   %rbx
   4229b:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   4229f:	e8 ac fb ff ff       	call   41e50 <keyboard_readc>
   422a4:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   422a7:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   422ab:	74 1c                	je     422c9 <check_keyboard+0x33>
   422ad:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   422b1:	74 16                	je     422c9 <check_keyboard+0x33>
   422b3:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   422b7:	74 10                	je     422c9 <check_keyboard+0x33>
   422b9:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   422bd:	74 0a                	je     422c9 <check_keyboard+0x33>
   422bf:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   422c3:	0f 85 e9 00 00 00    	jne    423b2 <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   422c9:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   422d0:	00 
        memset(pt, 0, PAGESIZE * 3);
   422d1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   422d5:	ba 00 30 00 00       	mov    $0x3000,%edx
   422da:	be 00 00 00 00       	mov    $0x0,%esi
   422df:	48 89 c7             	mov    %rax,%rdi
   422e2:	e8 27 0d 00 00       	call   4300e <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   422e7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   422eb:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   422f2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   422f6:	48 05 00 10 00 00    	add    $0x1000,%rax
   422fc:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42303:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42307:	48 05 00 20 00 00    	add    $0x2000,%rax
   4230d:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42314:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42318:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   4231c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42320:	0f 22 d8             	mov    %rax,%cr3
}
   42323:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42324:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   4232b:	48 c7 45 e8 18 45 04 	movq   $0x44518,-0x18(%rbp)
   42332:	00 
        if (c == 'a') {
   42333:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42337:	75 0a                	jne    42343 <check_keyboard+0xad>
            argument = "allocator";
   42339:	48 c7 45 e8 1d 45 04 	movq   $0x4451d,-0x18(%rbp)
   42340:	00 
   42341:	eb 2e                	jmp    42371 <check_keyboard+0xdb>
        } else if (c == 'e') {
   42343:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42347:	75 0a                	jne    42353 <check_keyboard+0xbd>
            argument = "forkexit";
   42349:	48 c7 45 e8 27 45 04 	movq   $0x44527,-0x18(%rbp)
   42350:	00 
   42351:	eb 1e                	jmp    42371 <check_keyboard+0xdb>
        }
        else if (c == 't'){
   42353:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42357:	75 0a                	jne    42363 <check_keyboard+0xcd>
            argument = "test";
   42359:	48 c7 45 e8 30 45 04 	movq   $0x44530,-0x18(%rbp)
   42360:	00 
   42361:	eb 0e                	jmp    42371 <check_keyboard+0xdb>
        }
        else if(c == '2'){
   42363:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42367:	75 08                	jne    42371 <check_keyboard+0xdb>
            argument = "test2";
   42369:	48 c7 45 e8 35 45 04 	movq   $0x44535,-0x18(%rbp)
   42370:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42371:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42375:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42379:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4237e:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   42382:	73 14                	jae    42398 <check_keyboard+0x102>
   42384:	ba 3b 45 04 00       	mov    $0x4453b,%edx
   42389:	be 5d 02 00 00       	mov    $0x25d,%esi
   4238e:	bf 57 45 04 00       	mov    $0x44557,%edi
   42393:	e8 1f 01 00 00       	call   424b7 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42398:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4239c:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   4239f:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   423a3:	48 89 c3             	mov    %rax,%rbx
   423a6:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   423ab:	e9 50 dc ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   423b0:	eb 11                	jmp    423c3 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   423b2:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   423b6:	74 06                	je     423be <check_keyboard+0x128>
   423b8:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   423bc:	75 05                	jne    423c3 <check_keyboard+0x12d>
        poweroff();
   423be:	e8 9d f8 ff ff       	call   41c60 <poweroff>
    }
    return c;
   423c3:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   423c6:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   423ca:	c9                   	leave  
   423cb:	c3                   	ret    

00000000000423cc <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   423cc:	55                   	push   %rbp
   423cd:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   423d0:	e8 c1 fe ff ff       	call   42296 <check_keyboard>
   423d5:	eb f9                	jmp    423d0 <fail+0x4>

00000000000423d7 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   423d7:	55                   	push   %rbp
   423d8:	48 89 e5             	mov    %rsp,%rbp
   423db:	48 83 ec 60          	sub    $0x60,%rsp
   423df:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   423e3:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   423e7:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   423eb:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   423ef:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   423f3:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   423f7:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   423fe:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42402:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42406:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4240a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   4240e:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42413:	0f 84 80 00 00 00    	je     42499 <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42419:	ba 6b 45 04 00       	mov    $0x4456b,%edx
   4241e:	be 00 c0 00 00       	mov    $0xc000,%esi
   42423:	bf 30 07 00 00       	mov    $0x730,%edi
   42428:	b8 00 00 00 00       	mov    $0x0,%eax
   4242d:	e8 12 fe ff ff       	call   42244 <error_printf>
   42432:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42435:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42439:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   4243d:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42440:	be 00 c0 00 00       	mov    $0xc000,%esi
   42445:	89 c7                	mov    %eax,%edi
   42447:	e8 9a fd ff ff       	call   421e6 <error_vprintf>
   4244c:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   4244f:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42452:	48 63 c1             	movslq %ecx,%rax
   42455:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   4245c:	48 c1 e8 20          	shr    $0x20,%rax
   42460:	89 c2                	mov    %eax,%edx
   42462:	c1 fa 05             	sar    $0x5,%edx
   42465:	89 c8                	mov    %ecx,%eax
   42467:	c1 f8 1f             	sar    $0x1f,%eax
   4246a:	29 c2                	sub    %eax,%edx
   4246c:	89 d0                	mov    %edx,%eax
   4246e:	c1 e0 02             	shl    $0x2,%eax
   42471:	01 d0                	add    %edx,%eax
   42473:	c1 e0 04             	shl    $0x4,%eax
   42476:	29 c1                	sub    %eax,%ecx
   42478:	89 ca                	mov    %ecx,%edx
   4247a:	85 d2                	test   %edx,%edx
   4247c:	74 34                	je     424b2 <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   4247e:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42481:	ba 73 45 04 00       	mov    $0x44573,%edx
   42486:	be 00 c0 00 00       	mov    $0xc000,%esi
   4248b:	89 c7                	mov    %eax,%edi
   4248d:	b8 00 00 00 00       	mov    $0x0,%eax
   42492:	e8 ad fd ff ff       	call   42244 <error_printf>
   42497:	eb 19                	jmp    424b2 <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42499:	ba 75 45 04 00       	mov    $0x44575,%edx
   4249e:	be 00 c0 00 00       	mov    $0xc000,%esi
   424a3:	bf 30 07 00 00       	mov    $0x730,%edi
   424a8:	b8 00 00 00 00       	mov    $0x0,%eax
   424ad:	e8 92 fd ff ff       	call   42244 <error_printf>
    }

    va_end(val);
    fail();
   424b2:	e8 15 ff ff ff       	call   423cc <fail>

00000000000424b7 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   424b7:	55                   	push   %rbp
   424b8:	48 89 e5             	mov    %rsp,%rbp
   424bb:	48 83 ec 20          	sub    $0x20,%rsp
   424bf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   424c3:	89 75 f4             	mov    %esi,-0xc(%rbp)
   424c6:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   424ca:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   424ce:	8b 55 f4             	mov    -0xc(%rbp),%edx
   424d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   424d5:	48 89 c6             	mov    %rax,%rsi
   424d8:	bf 7b 45 04 00       	mov    $0x4457b,%edi
   424dd:	b8 00 00 00 00       	mov    $0x0,%eax
   424e2:	e8 f0 fe ff ff       	call   423d7 <panic>

00000000000424e7 <default_exception>:
}

void default_exception(proc* p){
   424e7:	55                   	push   %rbp
   424e8:	48 89 e5             	mov    %rsp,%rbp
   424eb:	48 83 ec 20          	sub    $0x20,%rsp
   424ef:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   424f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   424f7:	48 83 c0 08          	add    $0x8,%rax
   424fb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   424ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42503:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4250a:	48 89 c6             	mov    %rax,%rsi
   4250d:	bf 99 45 04 00       	mov    $0x44599,%edi
   42512:	b8 00 00 00 00       	mov    $0x0,%eax
   42517:	e8 bb fe ff ff       	call   423d7 <panic>

000000000004251c <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   4251c:	55                   	push   %rbp
   4251d:	48 89 e5             	mov    %rsp,%rbp
   42520:	48 83 ec 10          	sub    $0x10,%rsp
   42524:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42528:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   4252b:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4252f:	78 06                	js     42537 <pageindex+0x1b>
   42531:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42535:	7e 14                	jle    4254b <pageindex+0x2f>
   42537:	ba b8 45 04 00       	mov    $0x445b8,%edx
   4253c:	be 1e 00 00 00       	mov    $0x1e,%esi
   42541:	bf d1 45 04 00       	mov    $0x445d1,%edi
   42546:	e8 6c ff ff ff       	call   424b7 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   4254b:	b8 03 00 00 00       	mov    $0x3,%eax
   42550:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42553:	89 c2                	mov    %eax,%edx
   42555:	89 d0                	mov    %edx,%eax
   42557:	c1 e0 03             	shl    $0x3,%eax
   4255a:	01 d0                	add    %edx,%eax
   4255c:	83 c0 0c             	add    $0xc,%eax
   4255f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42563:	89 c1                	mov    %eax,%ecx
   42565:	48 d3 ea             	shr    %cl,%rdx
   42568:	48 89 d0             	mov    %rdx,%rax
   4256b:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42570:	c9                   	leave  
   42571:	c3                   	ret    

0000000000042572 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42572:	55                   	push   %rbp
   42573:	48 89 e5             	mov    %rsp,%rbp
   42576:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   4257a:	48 c7 05 7b 1a 01 00 	movq   $0x55000,0x11a7b(%rip)        # 54000 <kernel_pagetable>
   42581:	00 50 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42585:	ba 00 50 00 00       	mov    $0x5000,%edx
   4258a:	be 00 00 00 00       	mov    $0x0,%esi
   4258f:	bf 00 50 05 00       	mov    $0x55000,%edi
   42594:	e8 75 0a 00 00       	call   4300e <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42599:	b8 00 60 05 00       	mov    $0x56000,%eax
   4259e:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   425a2:	48 89 05 57 2a 01 00 	mov    %rax,0x12a57(%rip)        # 55000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   425a9:	b8 00 70 05 00       	mov    $0x57000,%eax
   425ae:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   425b2:	48 89 05 47 3a 01 00 	mov    %rax,0x13a47(%rip)        # 56000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   425b9:	b8 00 80 05 00       	mov    $0x58000,%eax
   425be:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   425c2:	48 89 05 37 4a 01 00 	mov    %rax,0x14a37(%rip)        # 57000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   425c9:	b8 00 90 05 00       	mov    $0x59000,%eax
   425ce:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   425d2:	48 89 05 2f 4a 01 00 	mov    %rax,0x14a2f(%rip)        # 57008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   425d9:	48 8b 05 20 1a 01 00 	mov    0x11a20(%rip),%rax        # 54000 <kernel_pagetable>
   425e0:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   425e6:	b9 00 00 20 00       	mov    $0x200000,%ecx
   425eb:	ba 00 00 00 00       	mov    $0x0,%edx
   425f0:	be 00 00 00 00       	mov    $0x0,%esi
   425f5:	48 89 c7             	mov    %rax,%rdi
   425f8:	e8 b9 01 00 00       	call   427b6 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   425fd:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42604:	00 
   42605:	eb 62                	jmp    42669 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42607:	48 8b 0d f2 19 01 00 	mov    0x119f2(%rip),%rcx        # 54000 <kernel_pagetable>
   4260e:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42612:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42616:	48 89 ce             	mov    %rcx,%rsi
   42619:	48 89 c7             	mov    %rax,%rdi
   4261c:	e8 5b 05 00 00       	call   42b7c <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   42621:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42625:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42629:	74 14                	je     4263f <virtual_memory_init+0xcd>
   4262b:	ba e5 45 04 00       	mov    $0x445e5,%edx
   42630:	be 2d 00 00 00       	mov    $0x2d,%esi
   42635:	bf f5 45 04 00       	mov    $0x445f5,%edi
   4263a:	e8 78 fe ff ff       	call   424b7 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   4263f:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42642:	48 98                	cltq   
   42644:	83 e0 03             	and    $0x3,%eax
   42647:	48 83 f8 03          	cmp    $0x3,%rax
   4264b:	74 14                	je     42661 <virtual_memory_init+0xef>
   4264d:	ba 08 46 04 00       	mov    $0x44608,%edx
   42652:	be 2e 00 00 00       	mov    $0x2e,%esi
   42657:	bf f5 45 04 00       	mov    $0x445f5,%edi
   4265c:	e8 56 fe ff ff       	call   424b7 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42661:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42668:	00 
   42669:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42670:	00 
   42671:	76 94                	jbe    42607 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42673:	48 8b 05 86 19 01 00 	mov    0x11986(%rip),%rax        # 54000 <kernel_pagetable>
   4267a:	48 89 c7             	mov    %rax,%rdi
   4267d:	e8 03 00 00 00       	call   42685 <set_pagetable>
}
   42682:	90                   	nop
   42683:	c9                   	leave  
   42684:	c3                   	ret    

0000000000042685 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42685:	55                   	push   %rbp
   42686:	48 89 e5             	mov    %rsp,%rbp
   42689:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   4268d:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42691:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42695:	25 ff 0f 00 00       	and    $0xfff,%eax
   4269a:	48 85 c0             	test   %rax,%rax
   4269d:	74 14                	je     426b3 <set_pagetable+0x2e>
   4269f:	ba 35 46 04 00       	mov    $0x44635,%edx
   426a4:	be 3d 00 00 00       	mov    $0x3d,%esi
   426a9:	bf f5 45 04 00       	mov    $0x445f5,%edi
   426ae:	e8 04 fe ff ff       	call   424b7 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   426b3:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   426b8:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   426bc:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   426c0:	48 89 ce             	mov    %rcx,%rsi
   426c3:	48 89 c7             	mov    %rax,%rdi
   426c6:	e8 b1 04 00 00       	call   42b7c <virtual_memory_lookup>
   426cb:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   426cf:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   426d4:	48 39 d0             	cmp    %rdx,%rax
   426d7:	74 14                	je     426ed <set_pagetable+0x68>
   426d9:	ba 50 46 04 00       	mov    $0x44650,%edx
   426de:	be 3f 00 00 00       	mov    $0x3f,%esi
   426e3:	bf f5 45 04 00       	mov    $0x445f5,%edi
   426e8:	e8 ca fd ff ff       	call   424b7 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   426ed:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   426f1:	48 8b 0d 08 19 01 00 	mov    0x11908(%rip),%rcx        # 54000 <kernel_pagetable>
   426f8:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   426fc:	48 89 ce             	mov    %rcx,%rsi
   426ff:	48 89 c7             	mov    %rax,%rdi
   42702:	e8 75 04 00 00       	call   42b7c <virtual_memory_lookup>
   42707:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   4270b:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4270f:	48 39 c2             	cmp    %rax,%rdx
   42712:	74 14                	je     42728 <set_pagetable+0xa3>
   42714:	ba b8 46 04 00       	mov    $0x446b8,%edx
   42719:	be 41 00 00 00       	mov    $0x41,%esi
   4271e:	bf f5 45 04 00       	mov    $0x445f5,%edi
   42723:	e8 8f fd ff ff       	call   424b7 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42728:	48 8b 05 d1 18 01 00 	mov    0x118d1(%rip),%rax        # 54000 <kernel_pagetable>
   4272f:	48 89 c2             	mov    %rax,%rdx
   42732:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42736:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4273a:	48 89 ce             	mov    %rcx,%rsi
   4273d:	48 89 c7             	mov    %rax,%rdi
   42740:	e8 37 04 00 00       	call   42b7c <virtual_memory_lookup>
   42745:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42749:	48 8b 15 b0 18 01 00 	mov    0x118b0(%rip),%rdx        # 54000 <kernel_pagetable>
   42750:	48 39 d0             	cmp    %rdx,%rax
   42753:	74 14                	je     42769 <set_pagetable+0xe4>
   42755:	ba 18 47 04 00       	mov    $0x44718,%edx
   4275a:	be 43 00 00 00       	mov    $0x43,%esi
   4275f:	bf f5 45 04 00       	mov    $0x445f5,%edi
   42764:	e8 4e fd ff ff       	call   424b7 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42769:	ba b6 27 04 00       	mov    $0x427b6,%edx
   4276e:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42772:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42776:	48 89 ce             	mov    %rcx,%rsi
   42779:	48 89 c7             	mov    %rax,%rdi
   4277c:	e8 fb 03 00 00       	call   42b7c <virtual_memory_lookup>
   42781:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42785:	ba b6 27 04 00       	mov    $0x427b6,%edx
   4278a:	48 39 d0             	cmp    %rdx,%rax
   4278d:	74 14                	je     427a3 <set_pagetable+0x11e>
   4278f:	ba 80 47 04 00       	mov    $0x44780,%edx
   42794:	be 45 00 00 00       	mov    $0x45,%esi
   42799:	bf f5 45 04 00       	mov    $0x445f5,%edi
   4279e:	e8 14 fd ff ff       	call   424b7 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   427a3:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   427a7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   427ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   427af:	0f 22 d8             	mov    %rax,%cr3
}
   427b2:	90                   	nop
}
   427b3:	90                   	nop
   427b4:	c9                   	leave  
   427b5:	c3                   	ret    

00000000000427b6 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   427b6:	55                   	push   %rbp
   427b7:	48 89 e5             	mov    %rsp,%rbp
   427ba:	41 54                	push   %r12
   427bc:	53                   	push   %rbx
   427bd:	48 83 ec 50          	sub    $0x50,%rsp
   427c1:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   427c5:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   427c9:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   427cd:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   427d1:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   427d5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   427d9:	25 ff 0f 00 00       	and    $0xfff,%eax
   427de:	48 85 c0             	test   %rax,%rax
   427e1:	74 14                	je     427f7 <virtual_memory_map+0x41>
   427e3:	ba e6 47 04 00       	mov    $0x447e6,%edx
   427e8:	be 66 00 00 00       	mov    $0x66,%esi
   427ed:	bf f5 45 04 00       	mov    $0x445f5,%edi
   427f2:	e8 c0 fc ff ff       	call   424b7 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   427f7:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   427fb:	25 ff 0f 00 00       	and    $0xfff,%eax
   42800:	48 85 c0             	test   %rax,%rax
   42803:	74 14                	je     42819 <virtual_memory_map+0x63>
   42805:	ba f9 47 04 00       	mov    $0x447f9,%edx
   4280a:	be 67 00 00 00       	mov    $0x67,%esi
   4280f:	bf f5 45 04 00       	mov    $0x445f5,%edi
   42814:	e8 9e fc ff ff       	call   424b7 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42819:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   4281d:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42821:	48 01 d0             	add    %rdx,%rax
   42824:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   42828:	73 24                	jae    4284e <virtual_memory_map+0x98>
   4282a:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   4282e:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42832:	48 01 d0             	add    %rdx,%rax
   42835:	48 85 c0             	test   %rax,%rax
   42838:	74 14                	je     4284e <virtual_memory_map+0x98>
   4283a:	ba 0c 48 04 00       	mov    $0x4480c,%edx
   4283f:	be 68 00 00 00       	mov    $0x68,%esi
   42844:	bf f5 45 04 00       	mov    $0x445f5,%edi
   42849:	e8 69 fc ff ff       	call   424b7 <assert_fail>
    if (perm & PTE_P) {
   4284e:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42851:	48 98                	cltq   
   42853:	83 e0 01             	and    $0x1,%eax
   42856:	48 85 c0             	test   %rax,%rax
   42859:	74 6e                	je     428c9 <virtual_memory_map+0x113>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   4285b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4285f:	25 ff 0f 00 00       	and    $0xfff,%eax
   42864:	48 85 c0             	test   %rax,%rax
   42867:	74 14                	je     4287d <virtual_memory_map+0xc7>
   42869:	ba 2a 48 04 00       	mov    $0x4482a,%edx
   4286e:	be 6a 00 00 00       	mov    $0x6a,%esi
   42873:	bf f5 45 04 00       	mov    $0x445f5,%edi
   42878:	e8 3a fc ff ff       	call   424b7 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   4287d:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42881:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42885:	48 01 d0             	add    %rdx,%rax
   42888:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   4288c:	73 14                	jae    428a2 <virtual_memory_map+0xec>
   4288e:	ba 3d 48 04 00       	mov    $0x4483d,%edx
   42893:	be 6b 00 00 00       	mov    $0x6b,%esi
   42898:	bf f5 45 04 00       	mov    $0x445f5,%edi
   4289d:	e8 15 fc ff ff       	call   424b7 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   428a2:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   428a6:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428aa:	48 01 d0             	add    %rdx,%rax
   428ad:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   428b3:	76 14                	jbe    428c9 <virtual_memory_map+0x113>
   428b5:	ba 4b 48 04 00       	mov    $0x4484b,%edx
   428ba:	be 6c 00 00 00       	mov    $0x6c,%esi
   428bf:	bf f5 45 04 00       	mov    $0x445f5,%edi
   428c4:	e8 ee fb ff ff       	call   424b7 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   428c9:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   428cd:	78 09                	js     428d8 <virtual_memory_map+0x122>
   428cf:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   428d6:	7e 14                	jle    428ec <virtual_memory_map+0x136>
   428d8:	ba 67 48 04 00       	mov    $0x44867,%edx
   428dd:	be 6e 00 00 00       	mov    $0x6e,%esi
   428e2:	bf f5 45 04 00       	mov    $0x445f5,%edi
   428e7:	e8 cb fb ff ff       	call   424b7 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   428ec:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   428f0:	25 ff 0f 00 00       	and    $0xfff,%eax
   428f5:	48 85 c0             	test   %rax,%rax
   428f8:	74 14                	je     4290e <virtual_memory_map+0x158>
   428fa:	ba 88 48 04 00       	mov    $0x44888,%edx
   428ff:	be 6f 00 00 00       	mov    $0x6f,%esi
   42904:	bf f5 45 04 00       	mov    $0x445f5,%edi
   42909:	e8 a9 fb ff ff       	call   424b7 <assert_fail>

    int last_index123 = -1;
   4290e:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   42915:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   4291c:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   4291d:	e9 e7 00 00 00       	jmp    42a09 <virtual_memory_map+0x253>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42922:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42926:	48 c1 e8 15          	shr    $0x15,%rax
   4292a:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   4292d:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42930:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42933:	74 20                	je     42955 <virtual_memory_map+0x19f>
            // TODO --> done
            // find pointer to last level pagetable for current va

			l1pagetable = lookup_l1pagetable(pagetable, va, perm);	
   42935:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42938:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   4293c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42940:	48 89 ce             	mov    %rcx,%rsi
   42943:	48 89 c7             	mov    %rax,%rdi
   42946:	e8 d7 00 00 00       	call   42a22 <lookup_l1pagetable>
   4294b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

            last_index123 = cur_index123;
   4294f:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42952:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42955:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42958:	48 98                	cltq   
   4295a:	83 e0 01             	and    $0x1,%eax
   4295d:	48 85 c0             	test   %rax,%rax
   42960:	74 3a                	je     4299c <virtual_memory_map+0x1e6>
   42962:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42967:	74 33                	je     4299c <virtual_memory_map+0x1e6>
            // TODO --> done
            // map `pa` at appropriate entry with permissions `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] =  (0x00000000FFFFFFFF & pa) | perm;
   42969:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4296d:	41 89 c4             	mov    %eax,%r12d
   42970:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42973:	48 63 d8             	movslq %eax,%rbx
   42976:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4297a:	be 03 00 00 00       	mov    $0x3,%esi
   4297f:	48 89 c7             	mov    %rax,%rdi
   42982:	e8 95 fb ff ff       	call   4251c <pageindex>
   42987:	89 c2                	mov    %eax,%edx
   42989:	4c 89 e1             	mov    %r12,%rcx
   4298c:	48 09 d9             	or     %rbx,%rcx
   4298f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42993:	48 63 d2             	movslq %edx,%rdx
   42996:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   4299a:	eb 55                	jmp    429f1 <virtual_memory_map+0x23b>

        } else if (l1pagetable) { // if page is NOT marked present
   4299c:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   429a1:	74 26                	je     429c9 <virtual_memory_map+0x213>
            // TODO --> done
            // map to address 0 with `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] = 0 | perm;
   429a3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   429a7:	be 03 00 00 00       	mov    $0x3,%esi
   429ac:	48 89 c7             	mov    %rax,%rdi
   429af:	e8 68 fb ff ff       	call   4251c <pageindex>
   429b4:	89 c2                	mov    %eax,%edx
   429b6:	8b 45 ac             	mov    -0x54(%rbp),%eax
   429b9:	48 63 c8             	movslq %eax,%rcx
   429bc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   429c0:	48 63 d2             	movslq %edx,%rdx
   429c3:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   429c7:	eb 28                	jmp    429f1 <virtual_memory_map+0x23b>

        } else if (perm & PTE_P) {
   429c9:	8b 45 ac             	mov    -0x54(%rbp),%eax
   429cc:	48 98                	cltq   
   429ce:	83 e0 01             	and    $0x1,%eax
   429d1:	48 85 c0             	test   %rax,%rax
   429d4:	74 1b                	je     429f1 <virtual_memory_map+0x23b>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   429d6:	be 8b 00 00 00       	mov    $0x8b,%esi
   429db:	bf b0 48 04 00       	mov    $0x448b0,%edi
   429e0:	b8 00 00 00 00       	mov    $0x0,%eax
   429e5:	e8 af f7 ff ff       	call   42199 <log_printf>
            return -1;
   429ea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   429ef:	eb 28                	jmp    42a19 <virtual_memory_map+0x263>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   429f1:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   429f8:	00 
   429f9:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42a00:	00 
   42a01:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42a08:	00 
   42a09:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42a0e:	0f 85 0e ff ff ff    	jne    42922 <virtual_memory_map+0x16c>
        }
    }
    return 0;
   42a14:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42a19:	48 83 c4 50          	add    $0x50,%rsp
   42a1d:	5b                   	pop    %rbx
   42a1e:	41 5c                	pop    %r12
   42a20:	5d                   	pop    %rbp
   42a21:	c3                   	ret    

0000000000042a22 <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42a22:	55                   	push   %rbp
   42a23:	48 89 e5             	mov    %rsp,%rbp
   42a26:	48 83 ec 40          	sub    $0x40,%rsp
   42a2a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42a2e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42a32:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42a35:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42a39:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42a3d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42a44:	e9 23 01 00 00       	jmp    42b6c <lookup_l1pagetable+0x14a>
        // TODO --> done
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)]; // replace this
   42a49:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42a4c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42a50:	89 d6                	mov    %edx,%esi
   42a52:	48 89 c7             	mov    %rax,%rdi
   42a55:	e8 c2 fa ff ff       	call   4251c <pageindex>
   42a5a:	89 c2                	mov    %eax,%edx
   42a5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42a60:	48 63 d2             	movslq %edx,%rdx
   42a63:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42a67:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42a6b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a6f:	83 e0 01             	and    $0x1,%eax
   42a72:	48 85 c0             	test   %rax,%rax
   42a75:	75 63                	jne    42ada <lookup_l1pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   42a77:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42a7a:	8d 48 02             	lea    0x2(%rax),%ecx
   42a7d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a81:	25 ff 0f 00 00       	and    $0xfff,%eax
   42a86:	48 89 c2             	mov    %rax,%rdx
   42a89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a8d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42a93:	48 89 c6             	mov    %rax,%rsi
   42a96:	bf f8 48 04 00       	mov    $0x448f8,%edi
   42a9b:	b8 00 00 00 00       	mov    $0x0,%eax
   42aa0:	e8 f4 f6 ff ff       	call   42199 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42aa5:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42aa8:	48 98                	cltq   
   42aaa:	83 e0 01             	and    $0x1,%eax
   42aad:	48 85 c0             	test   %rax,%rax
   42ab0:	75 0a                	jne    42abc <lookup_l1pagetable+0x9a>
                return NULL;
   42ab2:	b8 00 00 00 00       	mov    $0x0,%eax
   42ab7:	e9 be 00 00 00       	jmp    42b7a <lookup_l1pagetable+0x158>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42abc:	be af 00 00 00       	mov    $0xaf,%esi
   42ac1:	bf 60 49 04 00       	mov    $0x44960,%edi
   42ac6:	b8 00 00 00 00       	mov    $0x0,%eax
   42acb:	e8 c9 f6 ff ff       	call   42199 <log_printf>
            return NULL;
   42ad0:	b8 00 00 00 00       	mov    $0x0,%eax
   42ad5:	e9 a0 00 00 00       	jmp    42b7a <lookup_l1pagetable+0x158>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42ada:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ade:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42ae4:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42aea:	76 14                	jbe    42b00 <lookup_l1pagetable+0xde>
   42aec:	ba a8 49 04 00       	mov    $0x449a8,%edx
   42af1:	be b4 00 00 00       	mov    $0xb4,%esi
   42af6:	bf f5 45 04 00       	mov    $0x445f5,%edi
   42afb:	e8 b7 f9 ff ff       	call   424b7 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42b00:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42b03:	48 98                	cltq   
   42b05:	83 e0 02             	and    $0x2,%eax
   42b08:	48 85 c0             	test   %rax,%rax
   42b0b:	74 20                	je     42b2d <lookup_l1pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42b0d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b11:	83 e0 02             	and    $0x2,%eax
   42b14:	48 85 c0             	test   %rax,%rax
   42b17:	75 14                	jne    42b2d <lookup_l1pagetable+0x10b>
   42b19:	ba c8 49 04 00       	mov    $0x449c8,%edx
   42b1e:	be b6 00 00 00       	mov    $0xb6,%esi
   42b23:	bf f5 45 04 00       	mov    $0x445f5,%edi
   42b28:	e8 8a f9 ff ff       	call   424b7 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42b2d:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42b30:	48 98                	cltq   
   42b32:	83 e0 04             	and    $0x4,%eax
   42b35:	48 85 c0             	test   %rax,%rax
   42b38:	74 20                	je     42b5a <lookup_l1pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42b3a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b3e:	83 e0 04             	and    $0x4,%eax
   42b41:	48 85 c0             	test   %rax,%rax
   42b44:	75 14                	jne    42b5a <lookup_l1pagetable+0x138>
   42b46:	ba d3 49 04 00       	mov    $0x449d3,%edx
   42b4b:	be b9 00 00 00       	mov    $0xb9,%esi
   42b50:	bf f5 45 04 00       	mov    $0x445f5,%edi
   42b55:	e8 5d f9 ff ff       	call   424b7 <assert_fail>
        }

        // TODO --> done
        // set pt to physical address to next pagetable using `pe`
        pt = (x86_64_pagetable *) PTE_ADDR(pe); // replace this
   42b5a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b5e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42b64:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42b68:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42b6c:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42b70:	0f 8e d3 fe ff ff    	jle    42a49 <lookup_l1pagetable+0x27>
    }
    return pt;
   42b76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42b7a:	c9                   	leave  
   42b7b:	c3                   	ret    

0000000000042b7c <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42b7c:	55                   	push   %rbp
   42b7d:	48 89 e5             	mov    %rsp,%rbp
   42b80:	48 83 ec 50          	sub    $0x50,%rsp
   42b84:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42b88:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42b8c:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42b90:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42b94:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42b98:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42b9f:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42ba0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42ba7:	eb 41                	jmp    42bea <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42ba9:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42bac:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42bb0:	89 d6                	mov    %edx,%esi
   42bb2:	48 89 c7             	mov    %rax,%rdi
   42bb5:	e8 62 f9 ff ff       	call   4251c <pageindex>
   42bba:	89 c2                	mov    %eax,%edx
   42bbc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42bc0:	48 63 d2             	movslq %edx,%rdx
   42bc3:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42bc7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42bcb:	83 e0 06             	and    $0x6,%eax
   42bce:	48 f7 d0             	not    %rax
   42bd1:	48 21 d0             	and    %rdx,%rax
   42bd4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42bd8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42bdc:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42be2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42be6:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42bea:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42bee:	7f 0c                	jg     42bfc <virtual_memory_lookup+0x80>
   42bf0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42bf4:	83 e0 01             	and    $0x1,%eax
   42bf7:	48 85 c0             	test   %rax,%rax
   42bfa:	75 ad                	jne    42ba9 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42bfc:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42c03:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42c0a:	ff 
   42c0b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42c12:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c16:	83 e0 01             	and    $0x1,%eax
   42c19:	48 85 c0             	test   %rax,%rax
   42c1c:	74 34                	je     42c52 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42c1e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c22:	48 c1 e8 0c          	shr    $0xc,%rax
   42c26:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42c29:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c2d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42c33:	48 89 c2             	mov    %rax,%rdx
   42c36:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42c3a:	25 ff 0f 00 00       	and    $0xfff,%eax
   42c3f:	48 09 d0             	or     %rdx,%rax
   42c42:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42c46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c4a:	25 ff 0f 00 00       	and    $0xfff,%eax
   42c4f:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42c52:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42c56:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42c5a:	48 89 10             	mov    %rdx,(%rax)
   42c5d:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42c61:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42c65:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42c69:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42c6d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42c71:	c9                   	leave  
   42c72:	c3                   	ret    

0000000000042c73 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42c73:	55                   	push   %rbp
   42c74:	48 89 e5             	mov    %rsp,%rbp
   42c77:	48 83 ec 40          	sub    $0x40,%rsp
   42c7b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42c7f:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42c82:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42c86:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42c8d:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42c91:	78 08                	js     42c9b <program_load+0x28>
   42c93:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42c96:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42c99:	7c 14                	jl     42caf <program_load+0x3c>
   42c9b:	ba e0 49 04 00       	mov    $0x449e0,%edx
   42ca0:	be 37 00 00 00       	mov    $0x37,%esi
   42ca5:	bf 10 4a 04 00       	mov    $0x44a10,%edi
   42caa:	e8 08 f8 ff ff       	call   424b7 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42caf:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42cb2:	48 98                	cltq   
   42cb4:	48 c1 e0 04          	shl    $0x4,%rax
   42cb8:	48 05 20 50 04 00    	add    $0x45020,%rax
   42cbe:	48 8b 00             	mov    (%rax),%rax
   42cc1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42cc5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cc9:	8b 00                	mov    (%rax),%eax
   42ccb:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42cd0:	74 14                	je     42ce6 <program_load+0x73>
   42cd2:	ba 22 4a 04 00       	mov    $0x44a22,%edx
   42cd7:	be 39 00 00 00       	mov    $0x39,%esi
   42cdc:	bf 10 4a 04 00       	mov    $0x44a10,%edi
   42ce1:	e8 d1 f7 ff ff       	call   424b7 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42ce6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cea:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42cee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cf2:	48 01 d0             	add    %rdx,%rax
   42cf5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42cf9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42d00:	e9 94 00 00 00       	jmp    42d99 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42d05:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42d08:	48 63 d0             	movslq %eax,%rdx
   42d0b:	48 89 d0             	mov    %rdx,%rax
   42d0e:	48 c1 e0 03          	shl    $0x3,%rax
   42d12:	48 29 d0             	sub    %rdx,%rax
   42d15:	48 c1 e0 03          	shl    $0x3,%rax
   42d19:	48 89 c2             	mov    %rax,%rdx
   42d1c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d20:	48 01 d0             	add    %rdx,%rax
   42d23:	8b 00                	mov    (%rax),%eax
   42d25:	83 f8 01             	cmp    $0x1,%eax
   42d28:	75 6b                	jne    42d95 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42d2a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42d2d:	48 63 d0             	movslq %eax,%rdx
   42d30:	48 89 d0             	mov    %rdx,%rax
   42d33:	48 c1 e0 03          	shl    $0x3,%rax
   42d37:	48 29 d0             	sub    %rdx,%rax
   42d3a:	48 c1 e0 03          	shl    $0x3,%rax
   42d3e:	48 89 c2             	mov    %rax,%rdx
   42d41:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d45:	48 01 d0             	add    %rdx,%rax
   42d48:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42d4c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d50:	48 01 d0             	add    %rdx,%rax
   42d53:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42d57:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42d5a:	48 63 d0             	movslq %eax,%rdx
   42d5d:	48 89 d0             	mov    %rdx,%rax
   42d60:	48 c1 e0 03          	shl    $0x3,%rax
   42d64:	48 29 d0             	sub    %rdx,%rax
   42d67:	48 c1 e0 03          	shl    $0x3,%rax
   42d6b:	48 89 c2             	mov    %rax,%rdx
   42d6e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d72:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42d76:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42d7a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42d7e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42d82:	48 89 c7             	mov    %rax,%rdi
   42d85:	e8 3d 00 00 00       	call   42dc7 <program_load_segment>
   42d8a:	85 c0                	test   %eax,%eax
   42d8c:	79 07                	jns    42d95 <program_load+0x122>
                return -1;
   42d8e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42d93:	eb 30                	jmp    42dc5 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42d95:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42d99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d9d:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42da1:	0f b7 c0             	movzwl %ax,%eax
   42da4:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42da7:	0f 8c 58 ff ff ff    	jl     42d05 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42dad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42db1:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42db5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42db9:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   42dc0:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42dc5:	c9                   	leave  
   42dc6:	c3                   	ret    

0000000000042dc7 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42dc7:	55                   	push   %rbp
   42dc8:	48 89 e5             	mov    %rsp,%rbp
   42dcb:	48 83 ec 40          	sub    $0x40,%rsp
   42dcf:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42dd3:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42dd7:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   42ddb:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42ddf:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42de3:	48 8b 40 10          	mov    0x10(%rax),%rax
   42de7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42deb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42def:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42df3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42df7:	48 01 d0             	add    %rdx,%rax
   42dfa:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42dfe:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42e02:	48 8b 50 28          	mov    0x28(%rax),%rdx
   42e06:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e0a:	48 01 d0             	add    %rdx,%rax
   42e0d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   42e11:	48 81 65 f0 00 f0 ff 	andq   $0xfffffffffffff000,-0x10(%rbp)
   42e18:	ff 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42e19:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e1d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42e21:	eb 7c                	jmp    42e9f <program_load_segment+0xd8>
        if (assign_physical_page(addr, p->p_pid) < 0
   42e23:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e27:	8b 00                	mov    (%rax),%eax
   42e29:	0f be d0             	movsbl %al,%edx
   42e2c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42e30:	89 d6                	mov    %edx,%esi
   42e32:	48 89 c7             	mov    %rax,%rdi
   42e35:	e8 c5 d7 ff ff       	call   405ff <assign_physical_page>
   42e3a:	85 c0                	test   %eax,%eax
   42e3c:	78 2a                	js     42e68 <program_load_segment+0xa1>
            || virtual_memory_map(p->p_pagetable, addr, addr, PAGESIZE,
   42e3e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e42:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   42e49:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42e4d:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   42e51:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42e57:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42e5c:	48 89 c7             	mov    %rax,%rdi
   42e5f:	e8 52 f9 ff ff       	call   427b6 <virtual_memory_map>
   42e64:	85 c0                	test   %eax,%eax
   42e66:	79 2f                	jns    42e97 <program_load_segment+0xd0>
                                  PTE_P | PTE_W | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   42e68:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e6c:	8b 00                	mov    (%rax),%eax
   42e6e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42e72:	49 89 d0             	mov    %rdx,%r8
   42e75:	89 c1                	mov    %eax,%ecx
   42e77:	ba 40 4a 04 00       	mov    $0x44a40,%edx
   42e7c:	be 00 c0 00 00       	mov    $0xc000,%esi
   42e81:	bf e0 06 00 00       	mov    $0x6e0,%edi
   42e86:	b8 00 00 00 00       	mov    $0x0,%eax
   42e8b:	e8 35 0f 00 00       	call   43dc5 <console_printf>
            return -1;
   42e90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42e95:	eb 77                	jmp    42f0e <program_load_segment+0x147>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42e97:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42e9e:	00 
   42e9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42ea3:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   42ea7:	0f 82 76 ff ff ff    	jb     42e23 <program_load_segment+0x5c>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   42ead:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42eb1:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   42eb8:	48 89 c7             	mov    %rax,%rdi
   42ebb:	e8 c5 f7 ff ff       	call   42685 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   42ec0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ec4:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
   42ec8:	48 89 c2             	mov    %rax,%rdx
   42ecb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ecf:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42ed3:	48 89 ce             	mov    %rcx,%rsi
   42ed6:	48 89 c7             	mov    %rax,%rdi
   42ed9:	e8 32 00 00 00       	call   42f10 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   42ede:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42ee2:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   42ee6:	48 89 c2             	mov    %rax,%rdx
   42ee9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42eed:	be 00 00 00 00       	mov    $0x0,%esi
   42ef2:	48 89 c7             	mov    %rax,%rdi
   42ef5:	e8 14 01 00 00       	call   4300e <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   42efa:	48 8b 05 ff 10 01 00 	mov    0x110ff(%rip),%rax        # 54000 <kernel_pagetable>
   42f01:	48 89 c7             	mov    %rax,%rdi
   42f04:	e8 7c f7 ff ff       	call   42685 <set_pagetable>
    return 0;
   42f09:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42f0e:	c9                   	leave  
   42f0f:	c3                   	ret    

0000000000042f10 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   42f10:	55                   	push   %rbp
   42f11:	48 89 e5             	mov    %rsp,%rbp
   42f14:	48 83 ec 28          	sub    $0x28,%rsp
   42f18:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42f1c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   42f20:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   42f24:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f28:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   42f2c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f30:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   42f34:	eb 1c                	jmp    42f52 <memcpy+0x42>
        *d = *s;
   42f36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f3a:	0f b6 10             	movzbl (%rax),%edx
   42f3d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f41:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   42f43:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   42f48:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   42f4d:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   42f52:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   42f57:	75 dd                	jne    42f36 <memcpy+0x26>
    }
    return dst;
   42f59:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   42f5d:	c9                   	leave  
   42f5e:	c3                   	ret    

0000000000042f5f <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   42f5f:	55                   	push   %rbp
   42f60:	48 89 e5             	mov    %rsp,%rbp
   42f63:	48 83 ec 28          	sub    $0x28,%rsp
   42f67:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42f6b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   42f6f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   42f73:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f77:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   42f7b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f7f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   42f83:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f87:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   42f8b:	73 6a                	jae    42ff7 <memmove+0x98>
   42f8d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42f91:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42f95:	48 01 d0             	add    %rdx,%rax
   42f98:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   42f9c:	73 59                	jae    42ff7 <memmove+0x98>
        s += n, d += n;
   42f9e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42fa2:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   42fa6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42faa:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   42fae:	eb 17                	jmp    42fc7 <memmove+0x68>
            *--d = *--s;
   42fb0:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   42fb5:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   42fba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42fbe:	0f b6 10             	movzbl (%rax),%edx
   42fc1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42fc5:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   42fc7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42fcb:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   42fcf:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   42fd3:	48 85 c0             	test   %rax,%rax
   42fd6:	75 d8                	jne    42fb0 <memmove+0x51>
    if (s < d && s + n > d) {
   42fd8:	eb 2e                	jmp    43008 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   42fda:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42fde:	48 8d 42 01          	lea    0x1(%rdx),%rax
   42fe2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42fe6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42fea:	48 8d 48 01          	lea    0x1(%rax),%rcx
   42fee:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   42ff2:	0f b6 12             	movzbl (%rdx),%edx
   42ff5:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   42ff7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42ffb:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   42fff:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43003:	48 85 c0             	test   %rax,%rax
   43006:	75 d2                	jne    42fda <memmove+0x7b>
        }
    }
    return dst;
   43008:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4300c:	c9                   	leave  
   4300d:	c3                   	ret    

000000000004300e <memset>:

void* memset(void* v, int c, size_t n) {
   4300e:	55                   	push   %rbp
   4300f:	48 89 e5             	mov    %rsp,%rbp
   43012:	48 83 ec 28          	sub    $0x28,%rsp
   43016:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4301a:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   4301d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43021:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43025:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43029:	eb 15                	jmp    43040 <memset+0x32>
        *p = c;
   4302b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4302e:	89 c2                	mov    %eax,%edx
   43030:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43034:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43036:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   4303b:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43040:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43045:	75 e4                	jne    4302b <memset+0x1d>
    }
    return v;
   43047:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4304b:	c9                   	leave  
   4304c:	c3                   	ret    

000000000004304d <strlen>:

size_t strlen(const char* s) {
   4304d:	55                   	push   %rbp
   4304e:	48 89 e5             	mov    %rsp,%rbp
   43051:	48 83 ec 18          	sub    $0x18,%rsp
   43055:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43059:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43060:	00 
   43061:	eb 0a                	jmp    4306d <strlen+0x20>
        ++n;
   43063:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43068:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   4306d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43071:	0f b6 00             	movzbl (%rax),%eax
   43074:	84 c0                	test   %al,%al
   43076:	75 eb                	jne    43063 <strlen+0x16>
    }
    return n;
   43078:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   4307c:	c9                   	leave  
   4307d:	c3                   	ret    

000000000004307e <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   4307e:	55                   	push   %rbp
   4307f:	48 89 e5             	mov    %rsp,%rbp
   43082:	48 83 ec 20          	sub    $0x20,%rsp
   43086:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4308a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   4308e:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43095:	00 
   43096:	eb 0a                	jmp    430a2 <strnlen+0x24>
        ++n;
   43098:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   4309d:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   430a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   430a6:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   430aa:	74 0b                	je     430b7 <strnlen+0x39>
   430ac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430b0:	0f b6 00             	movzbl (%rax),%eax
   430b3:	84 c0                	test   %al,%al
   430b5:	75 e1                	jne    43098 <strnlen+0x1a>
    }
    return n;
   430b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   430bb:	c9                   	leave  
   430bc:	c3                   	ret    

00000000000430bd <strcpy>:

char* strcpy(char* dst, const char* src) {
   430bd:	55                   	push   %rbp
   430be:	48 89 e5             	mov    %rsp,%rbp
   430c1:	48 83 ec 20          	sub    $0x20,%rsp
   430c5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   430c9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   430cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430d1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   430d5:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   430d9:	48 8d 42 01          	lea    0x1(%rdx),%rax
   430dd:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   430e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   430e5:	48 8d 48 01          	lea    0x1(%rax),%rcx
   430e9:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   430ed:	0f b6 12             	movzbl (%rdx),%edx
   430f0:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   430f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   430f6:	48 83 e8 01          	sub    $0x1,%rax
   430fa:	0f b6 00             	movzbl (%rax),%eax
   430fd:	84 c0                	test   %al,%al
   430ff:	75 d4                	jne    430d5 <strcpy+0x18>
    return dst;
   43101:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43105:	c9                   	leave  
   43106:	c3                   	ret    

0000000000043107 <strcmp>:

int strcmp(const char* a, const char* b) {
   43107:	55                   	push   %rbp
   43108:	48 89 e5             	mov    %rsp,%rbp
   4310b:	48 83 ec 10          	sub    $0x10,%rsp
   4310f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43113:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43117:	eb 0a                	jmp    43123 <strcmp+0x1c>
        ++a, ++b;
   43119:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   4311e:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43123:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43127:	0f b6 00             	movzbl (%rax),%eax
   4312a:	84 c0                	test   %al,%al
   4312c:	74 1d                	je     4314b <strcmp+0x44>
   4312e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43132:	0f b6 00             	movzbl (%rax),%eax
   43135:	84 c0                	test   %al,%al
   43137:	74 12                	je     4314b <strcmp+0x44>
   43139:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4313d:	0f b6 10             	movzbl (%rax),%edx
   43140:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43144:	0f b6 00             	movzbl (%rax),%eax
   43147:	38 c2                	cmp    %al,%dl
   43149:	74 ce                	je     43119 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   4314b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4314f:	0f b6 00             	movzbl (%rax),%eax
   43152:	89 c2                	mov    %eax,%edx
   43154:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43158:	0f b6 00             	movzbl (%rax),%eax
   4315b:	38 d0                	cmp    %dl,%al
   4315d:	0f 92 c0             	setb   %al
   43160:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43163:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43167:	0f b6 00             	movzbl (%rax),%eax
   4316a:	89 c1                	mov    %eax,%ecx
   4316c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43170:	0f b6 00             	movzbl (%rax),%eax
   43173:	38 c1                	cmp    %al,%cl
   43175:	0f 92 c0             	setb   %al
   43178:	0f b6 c0             	movzbl %al,%eax
   4317b:	29 c2                	sub    %eax,%edx
   4317d:	89 d0                	mov    %edx,%eax
}
   4317f:	c9                   	leave  
   43180:	c3                   	ret    

0000000000043181 <strchr>:

char* strchr(const char* s, int c) {
   43181:	55                   	push   %rbp
   43182:	48 89 e5             	mov    %rsp,%rbp
   43185:	48 83 ec 10          	sub    $0x10,%rsp
   43189:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4318d:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43190:	eb 05                	jmp    43197 <strchr+0x16>
        ++s;
   43192:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43197:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4319b:	0f b6 00             	movzbl (%rax),%eax
   4319e:	84 c0                	test   %al,%al
   431a0:	74 0e                	je     431b0 <strchr+0x2f>
   431a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   431a6:	0f b6 00             	movzbl (%rax),%eax
   431a9:	8b 55 f4             	mov    -0xc(%rbp),%edx
   431ac:	38 d0                	cmp    %dl,%al
   431ae:	75 e2                	jne    43192 <strchr+0x11>
    }
    if (*s == (char) c) {
   431b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   431b4:	0f b6 00             	movzbl (%rax),%eax
   431b7:	8b 55 f4             	mov    -0xc(%rbp),%edx
   431ba:	38 d0                	cmp    %dl,%al
   431bc:	75 06                	jne    431c4 <strchr+0x43>
        return (char*) s;
   431be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   431c2:	eb 05                	jmp    431c9 <strchr+0x48>
    } else {
        return NULL;
   431c4:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   431c9:	c9                   	leave  
   431ca:	c3                   	ret    

00000000000431cb <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   431cb:	55                   	push   %rbp
   431cc:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   431cf:	8b 05 2b 6e 01 00    	mov    0x16e2b(%rip),%eax        # 5a000 <rand_seed_set>
   431d5:	85 c0                	test   %eax,%eax
   431d7:	75 0a                	jne    431e3 <rand+0x18>
        srand(819234718U);
   431d9:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   431de:	e8 24 00 00 00       	call   43207 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   431e3:	8b 05 1b 6e 01 00    	mov    0x16e1b(%rip),%eax        # 5a004 <rand_seed>
   431e9:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   431ef:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   431f4:	89 05 0a 6e 01 00    	mov    %eax,0x16e0a(%rip)        # 5a004 <rand_seed>
    return rand_seed & RAND_MAX;
   431fa:	8b 05 04 6e 01 00    	mov    0x16e04(%rip),%eax        # 5a004 <rand_seed>
   43200:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43205:	5d                   	pop    %rbp
   43206:	c3                   	ret    

0000000000043207 <srand>:

void srand(unsigned seed) {
   43207:	55                   	push   %rbp
   43208:	48 89 e5             	mov    %rsp,%rbp
   4320b:	48 83 ec 08          	sub    $0x8,%rsp
   4320f:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43212:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43215:	89 05 e9 6d 01 00    	mov    %eax,0x16de9(%rip)        # 5a004 <rand_seed>
    rand_seed_set = 1;
   4321b:	c7 05 db 6d 01 00 01 	movl   $0x1,0x16ddb(%rip)        # 5a000 <rand_seed_set>
   43222:	00 00 00 
}
   43225:	90                   	nop
   43226:	c9                   	leave  
   43227:	c3                   	ret    

0000000000043228 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43228:	55                   	push   %rbp
   43229:	48 89 e5             	mov    %rsp,%rbp
   4322c:	48 83 ec 28          	sub    $0x28,%rsp
   43230:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43234:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43238:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   4323b:	48 c7 45 f8 60 4c 04 	movq   $0x44c60,-0x8(%rbp)
   43242:	00 
    if (base < 0) {
   43243:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43247:	79 0b                	jns    43254 <fill_numbuf+0x2c>
        digits = lower_digits;
   43249:	48 c7 45 f8 80 4c 04 	movq   $0x44c80,-0x8(%rbp)
   43250:	00 
        base = -base;
   43251:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43254:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43259:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4325d:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43260:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43263:	48 63 c8             	movslq %eax,%rcx
   43266:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4326a:	ba 00 00 00 00       	mov    $0x0,%edx
   4326f:	48 f7 f1             	div    %rcx
   43272:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43276:	48 01 d0             	add    %rdx,%rax
   43279:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   4327e:	0f b6 10             	movzbl (%rax),%edx
   43281:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43285:	88 10                	mov    %dl,(%rax)
        val /= base;
   43287:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4328a:	48 63 f0             	movslq %eax,%rsi
   4328d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43291:	ba 00 00 00 00       	mov    $0x0,%edx
   43296:	48 f7 f6             	div    %rsi
   43299:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   4329d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   432a2:	75 bc                	jne    43260 <fill_numbuf+0x38>
    return numbuf_end;
   432a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   432a8:	c9                   	leave  
   432a9:	c3                   	ret    

00000000000432aa <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   432aa:	55                   	push   %rbp
   432ab:	48 89 e5             	mov    %rsp,%rbp
   432ae:	53                   	push   %rbx
   432af:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   432b6:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   432bd:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   432c3:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   432ca:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   432d1:	e9 8a 09 00 00       	jmp    43c60 <printer_vprintf+0x9b6>
        if (*format != '%') {
   432d6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   432dd:	0f b6 00             	movzbl (%rax),%eax
   432e0:	3c 25                	cmp    $0x25,%al
   432e2:	74 31                	je     43315 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   432e4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   432eb:	4c 8b 00             	mov    (%rax),%r8
   432ee:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   432f5:	0f b6 00             	movzbl (%rax),%eax
   432f8:	0f b6 c8             	movzbl %al,%ecx
   432fb:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43301:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43308:	89 ce                	mov    %ecx,%esi
   4330a:	48 89 c7             	mov    %rax,%rdi
   4330d:	41 ff d0             	call   *%r8
            continue;
   43310:	e9 43 09 00 00       	jmp    43c58 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   43315:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   4331c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43323:	01 
   43324:	eb 44                	jmp    4336a <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   43326:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4332d:	0f b6 00             	movzbl (%rax),%eax
   43330:	0f be c0             	movsbl %al,%eax
   43333:	89 c6                	mov    %eax,%esi
   43335:	bf 80 4a 04 00       	mov    $0x44a80,%edi
   4333a:	e8 42 fe ff ff       	call   43181 <strchr>
   4333f:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43343:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43348:	74 30                	je     4337a <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   4334a:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4334e:	48 2d 80 4a 04 00    	sub    $0x44a80,%rax
   43354:	ba 01 00 00 00       	mov    $0x1,%edx
   43359:	89 c1                	mov    %eax,%ecx
   4335b:	d3 e2                	shl    %cl,%edx
   4335d:	89 d0                	mov    %edx,%eax
   4335f:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   43362:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43369:	01 
   4336a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43371:	0f b6 00             	movzbl (%rax),%eax
   43374:	84 c0                	test   %al,%al
   43376:	75 ae                	jne    43326 <printer_vprintf+0x7c>
   43378:	eb 01                	jmp    4337b <printer_vprintf+0xd1>
            } else {
                break;
   4337a:	90                   	nop
            }
        }

        // process width
        int width = -1;
   4337b:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   43382:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43389:	0f b6 00             	movzbl (%rax),%eax
   4338c:	3c 30                	cmp    $0x30,%al
   4338e:	7e 67                	jle    433f7 <printer_vprintf+0x14d>
   43390:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43397:	0f b6 00             	movzbl (%rax),%eax
   4339a:	3c 39                	cmp    $0x39,%al
   4339c:	7f 59                	jg     433f7 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4339e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   433a5:	eb 2e                	jmp    433d5 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   433a7:	8b 55 e8             	mov    -0x18(%rbp),%edx
   433aa:	89 d0                	mov    %edx,%eax
   433ac:	c1 e0 02             	shl    $0x2,%eax
   433af:	01 d0                	add    %edx,%eax
   433b1:	01 c0                	add    %eax,%eax
   433b3:	89 c1                	mov    %eax,%ecx
   433b5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   433bc:	48 8d 50 01          	lea    0x1(%rax),%rdx
   433c0:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   433c7:	0f b6 00             	movzbl (%rax),%eax
   433ca:	0f be c0             	movsbl %al,%eax
   433cd:	01 c8                	add    %ecx,%eax
   433cf:	83 e8 30             	sub    $0x30,%eax
   433d2:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   433d5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   433dc:	0f b6 00             	movzbl (%rax),%eax
   433df:	3c 2f                	cmp    $0x2f,%al
   433e1:	0f 8e 85 00 00 00    	jle    4346c <printer_vprintf+0x1c2>
   433e7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   433ee:	0f b6 00             	movzbl (%rax),%eax
   433f1:	3c 39                	cmp    $0x39,%al
   433f3:	7e b2                	jle    433a7 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   433f5:	eb 75                	jmp    4346c <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   433f7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   433fe:	0f b6 00             	movzbl (%rax),%eax
   43401:	3c 2a                	cmp    $0x2a,%al
   43403:	75 68                	jne    4346d <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   43405:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4340c:	8b 00                	mov    (%rax),%eax
   4340e:	83 f8 2f             	cmp    $0x2f,%eax
   43411:	77 30                	ja     43443 <printer_vprintf+0x199>
   43413:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4341a:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4341e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43425:	8b 00                	mov    (%rax),%eax
   43427:	89 c0                	mov    %eax,%eax
   43429:	48 01 d0             	add    %rdx,%rax
   4342c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43433:	8b 12                	mov    (%rdx),%edx
   43435:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43438:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4343f:	89 0a                	mov    %ecx,(%rdx)
   43441:	eb 1a                	jmp    4345d <printer_vprintf+0x1b3>
   43443:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4344a:	48 8b 40 08          	mov    0x8(%rax),%rax
   4344e:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43452:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43459:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4345d:	8b 00                	mov    (%rax),%eax
   4345f:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   43462:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43469:	01 
   4346a:	eb 01                	jmp    4346d <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   4346c:	90                   	nop
        }

        // process precision
        int precision = -1;
   4346d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   43474:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4347b:	0f b6 00             	movzbl (%rax),%eax
   4347e:	3c 2e                	cmp    $0x2e,%al
   43480:	0f 85 00 01 00 00    	jne    43586 <printer_vprintf+0x2dc>
            ++format;
   43486:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4348d:	01 
            if (*format >= '0' && *format <= '9') {
   4348e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43495:	0f b6 00             	movzbl (%rax),%eax
   43498:	3c 2f                	cmp    $0x2f,%al
   4349a:	7e 67                	jle    43503 <printer_vprintf+0x259>
   4349c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   434a3:	0f b6 00             	movzbl (%rax),%eax
   434a6:	3c 39                	cmp    $0x39,%al
   434a8:	7f 59                	jg     43503 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   434aa:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   434b1:	eb 2e                	jmp    434e1 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   434b3:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   434b6:	89 d0                	mov    %edx,%eax
   434b8:	c1 e0 02             	shl    $0x2,%eax
   434bb:	01 d0                	add    %edx,%eax
   434bd:	01 c0                	add    %eax,%eax
   434bf:	89 c1                	mov    %eax,%ecx
   434c1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   434c8:	48 8d 50 01          	lea    0x1(%rax),%rdx
   434cc:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   434d3:	0f b6 00             	movzbl (%rax),%eax
   434d6:	0f be c0             	movsbl %al,%eax
   434d9:	01 c8                	add    %ecx,%eax
   434db:	83 e8 30             	sub    $0x30,%eax
   434de:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   434e1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   434e8:	0f b6 00             	movzbl (%rax),%eax
   434eb:	3c 2f                	cmp    $0x2f,%al
   434ed:	0f 8e 85 00 00 00    	jle    43578 <printer_vprintf+0x2ce>
   434f3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   434fa:	0f b6 00             	movzbl (%rax),%eax
   434fd:	3c 39                	cmp    $0x39,%al
   434ff:	7e b2                	jle    434b3 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   43501:	eb 75                	jmp    43578 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   43503:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4350a:	0f b6 00             	movzbl (%rax),%eax
   4350d:	3c 2a                	cmp    $0x2a,%al
   4350f:	75 68                	jne    43579 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   43511:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43518:	8b 00                	mov    (%rax),%eax
   4351a:	83 f8 2f             	cmp    $0x2f,%eax
   4351d:	77 30                	ja     4354f <printer_vprintf+0x2a5>
   4351f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43526:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4352a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43531:	8b 00                	mov    (%rax),%eax
   43533:	89 c0                	mov    %eax,%eax
   43535:	48 01 d0             	add    %rdx,%rax
   43538:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4353f:	8b 12                	mov    (%rdx),%edx
   43541:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43544:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4354b:	89 0a                	mov    %ecx,(%rdx)
   4354d:	eb 1a                	jmp    43569 <printer_vprintf+0x2bf>
   4354f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43556:	48 8b 40 08          	mov    0x8(%rax),%rax
   4355a:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4355e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43565:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43569:	8b 00                	mov    (%rax),%eax
   4356b:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   4356e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43575:	01 
   43576:	eb 01                	jmp    43579 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   43578:	90                   	nop
            }
            if (precision < 0) {
   43579:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   4357d:	79 07                	jns    43586 <printer_vprintf+0x2dc>
                precision = 0;
   4357f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   43586:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   4358d:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   43594:	00 
        int length = 0;
   43595:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   4359c:	48 c7 45 c8 86 4a 04 	movq   $0x44a86,-0x38(%rbp)
   435a3:	00 
    again:
        switch (*format) {
   435a4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   435ab:	0f b6 00             	movzbl (%rax),%eax
   435ae:	0f be c0             	movsbl %al,%eax
   435b1:	83 e8 43             	sub    $0x43,%eax
   435b4:	83 f8 37             	cmp    $0x37,%eax
   435b7:	0f 87 9f 03 00 00    	ja     4395c <printer_vprintf+0x6b2>
   435bd:	89 c0                	mov    %eax,%eax
   435bf:	48 8b 04 c5 98 4a 04 	mov    0x44a98(,%rax,8),%rax
   435c6:	00 
   435c7:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   435c9:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   435d0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   435d7:	01 
            goto again;
   435d8:	eb ca                	jmp    435a4 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   435da:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   435de:	74 5d                	je     4363d <printer_vprintf+0x393>
   435e0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   435e7:	8b 00                	mov    (%rax),%eax
   435e9:	83 f8 2f             	cmp    $0x2f,%eax
   435ec:	77 30                	ja     4361e <printer_vprintf+0x374>
   435ee:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   435f5:	48 8b 50 10          	mov    0x10(%rax),%rdx
   435f9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43600:	8b 00                	mov    (%rax),%eax
   43602:	89 c0                	mov    %eax,%eax
   43604:	48 01 d0             	add    %rdx,%rax
   43607:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4360e:	8b 12                	mov    (%rdx),%edx
   43610:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43613:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4361a:	89 0a                	mov    %ecx,(%rdx)
   4361c:	eb 1a                	jmp    43638 <printer_vprintf+0x38e>
   4361e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43625:	48 8b 40 08          	mov    0x8(%rax),%rax
   43629:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4362d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43634:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43638:	48 8b 00             	mov    (%rax),%rax
   4363b:	eb 5c                	jmp    43699 <printer_vprintf+0x3ef>
   4363d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43644:	8b 00                	mov    (%rax),%eax
   43646:	83 f8 2f             	cmp    $0x2f,%eax
   43649:	77 30                	ja     4367b <printer_vprintf+0x3d1>
   4364b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43652:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43656:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4365d:	8b 00                	mov    (%rax),%eax
   4365f:	89 c0                	mov    %eax,%eax
   43661:	48 01 d0             	add    %rdx,%rax
   43664:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4366b:	8b 12                	mov    (%rdx),%edx
   4366d:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43670:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43677:	89 0a                	mov    %ecx,(%rdx)
   43679:	eb 1a                	jmp    43695 <printer_vprintf+0x3eb>
   4367b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43682:	48 8b 40 08          	mov    0x8(%rax),%rax
   43686:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4368a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43691:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43695:	8b 00                	mov    (%rax),%eax
   43697:	48 98                	cltq   
   43699:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   4369d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   436a1:	48 c1 f8 38          	sar    $0x38,%rax
   436a5:	25 80 00 00 00       	and    $0x80,%eax
   436aa:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   436ad:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   436b1:	74 09                	je     436bc <printer_vprintf+0x412>
   436b3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   436b7:	48 f7 d8             	neg    %rax
   436ba:	eb 04                	jmp    436c0 <printer_vprintf+0x416>
   436bc:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   436c0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   436c4:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   436c7:	83 c8 60             	or     $0x60,%eax
   436ca:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   436cd:	e9 cf 02 00 00       	jmp    439a1 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   436d2:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   436d6:	74 5d                	je     43735 <printer_vprintf+0x48b>
   436d8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   436df:	8b 00                	mov    (%rax),%eax
   436e1:	83 f8 2f             	cmp    $0x2f,%eax
   436e4:	77 30                	ja     43716 <printer_vprintf+0x46c>
   436e6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   436ed:	48 8b 50 10          	mov    0x10(%rax),%rdx
   436f1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   436f8:	8b 00                	mov    (%rax),%eax
   436fa:	89 c0                	mov    %eax,%eax
   436fc:	48 01 d0             	add    %rdx,%rax
   436ff:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43706:	8b 12                	mov    (%rdx),%edx
   43708:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4370b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43712:	89 0a                	mov    %ecx,(%rdx)
   43714:	eb 1a                	jmp    43730 <printer_vprintf+0x486>
   43716:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4371d:	48 8b 40 08          	mov    0x8(%rax),%rax
   43721:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43725:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4372c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43730:	48 8b 00             	mov    (%rax),%rax
   43733:	eb 5c                	jmp    43791 <printer_vprintf+0x4e7>
   43735:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4373c:	8b 00                	mov    (%rax),%eax
   4373e:	83 f8 2f             	cmp    $0x2f,%eax
   43741:	77 30                	ja     43773 <printer_vprintf+0x4c9>
   43743:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4374a:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4374e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43755:	8b 00                	mov    (%rax),%eax
   43757:	89 c0                	mov    %eax,%eax
   43759:	48 01 d0             	add    %rdx,%rax
   4375c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43763:	8b 12                	mov    (%rdx),%edx
   43765:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43768:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4376f:	89 0a                	mov    %ecx,(%rdx)
   43771:	eb 1a                	jmp    4378d <printer_vprintf+0x4e3>
   43773:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4377a:	48 8b 40 08          	mov    0x8(%rax),%rax
   4377e:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43782:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43789:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4378d:	8b 00                	mov    (%rax),%eax
   4378f:	89 c0                	mov    %eax,%eax
   43791:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   43795:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   43799:	e9 03 02 00 00       	jmp    439a1 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   4379e:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   437a5:	e9 28 ff ff ff       	jmp    436d2 <printer_vprintf+0x428>
        case 'X':
            base = 16;
   437aa:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   437b1:	e9 1c ff ff ff       	jmp    436d2 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   437b6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437bd:	8b 00                	mov    (%rax),%eax
   437bf:	83 f8 2f             	cmp    $0x2f,%eax
   437c2:	77 30                	ja     437f4 <printer_vprintf+0x54a>
   437c4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437cb:	48 8b 50 10          	mov    0x10(%rax),%rdx
   437cf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437d6:	8b 00                	mov    (%rax),%eax
   437d8:	89 c0                	mov    %eax,%eax
   437da:	48 01 d0             	add    %rdx,%rax
   437dd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   437e4:	8b 12                	mov    (%rdx),%edx
   437e6:	8d 4a 08             	lea    0x8(%rdx),%ecx
   437e9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   437f0:	89 0a                	mov    %ecx,(%rdx)
   437f2:	eb 1a                	jmp    4380e <printer_vprintf+0x564>
   437f4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437fb:	48 8b 40 08          	mov    0x8(%rax),%rax
   437ff:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43803:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4380a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4380e:	48 8b 00             	mov    (%rax),%rax
   43811:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   43815:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   4381c:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   43823:	e9 79 01 00 00       	jmp    439a1 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   43828:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4382f:	8b 00                	mov    (%rax),%eax
   43831:	83 f8 2f             	cmp    $0x2f,%eax
   43834:	77 30                	ja     43866 <printer_vprintf+0x5bc>
   43836:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4383d:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43841:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43848:	8b 00                	mov    (%rax),%eax
   4384a:	89 c0                	mov    %eax,%eax
   4384c:	48 01 d0             	add    %rdx,%rax
   4384f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43856:	8b 12                	mov    (%rdx),%edx
   43858:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4385b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43862:	89 0a                	mov    %ecx,(%rdx)
   43864:	eb 1a                	jmp    43880 <printer_vprintf+0x5d6>
   43866:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4386d:	48 8b 40 08          	mov    0x8(%rax),%rax
   43871:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43875:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4387c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43880:	48 8b 00             	mov    (%rax),%rax
   43883:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   43887:	e9 15 01 00 00       	jmp    439a1 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   4388c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43893:	8b 00                	mov    (%rax),%eax
   43895:	83 f8 2f             	cmp    $0x2f,%eax
   43898:	77 30                	ja     438ca <printer_vprintf+0x620>
   4389a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   438a1:	48 8b 50 10          	mov    0x10(%rax),%rdx
   438a5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   438ac:	8b 00                	mov    (%rax),%eax
   438ae:	89 c0                	mov    %eax,%eax
   438b0:	48 01 d0             	add    %rdx,%rax
   438b3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   438ba:	8b 12                	mov    (%rdx),%edx
   438bc:	8d 4a 08             	lea    0x8(%rdx),%ecx
   438bf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   438c6:	89 0a                	mov    %ecx,(%rdx)
   438c8:	eb 1a                	jmp    438e4 <printer_vprintf+0x63a>
   438ca:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   438d1:	48 8b 40 08          	mov    0x8(%rax),%rax
   438d5:	48 8d 48 08          	lea    0x8(%rax),%rcx
   438d9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   438e0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   438e4:	8b 00                	mov    (%rax),%eax
   438e6:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   438ec:	e9 67 03 00 00       	jmp    43c58 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   438f1:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   438f5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   438f9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43900:	8b 00                	mov    (%rax),%eax
   43902:	83 f8 2f             	cmp    $0x2f,%eax
   43905:	77 30                	ja     43937 <printer_vprintf+0x68d>
   43907:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4390e:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43912:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43919:	8b 00                	mov    (%rax),%eax
   4391b:	89 c0                	mov    %eax,%eax
   4391d:	48 01 d0             	add    %rdx,%rax
   43920:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43927:	8b 12                	mov    (%rdx),%edx
   43929:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4392c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43933:	89 0a                	mov    %ecx,(%rdx)
   43935:	eb 1a                	jmp    43951 <printer_vprintf+0x6a7>
   43937:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4393e:	48 8b 40 08          	mov    0x8(%rax),%rax
   43942:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43946:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4394d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43951:	8b 00                	mov    (%rax),%eax
   43953:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43956:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   4395a:	eb 45                	jmp    439a1 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   4395c:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43960:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   43964:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4396b:	0f b6 00             	movzbl (%rax),%eax
   4396e:	84 c0                	test   %al,%al
   43970:	74 0c                	je     4397e <printer_vprintf+0x6d4>
   43972:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43979:	0f b6 00             	movzbl (%rax),%eax
   4397c:	eb 05                	jmp    43983 <printer_vprintf+0x6d9>
   4397e:	b8 25 00 00 00       	mov    $0x25,%eax
   43983:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43986:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   4398a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43991:	0f b6 00             	movzbl (%rax),%eax
   43994:	84 c0                	test   %al,%al
   43996:	75 08                	jne    439a0 <printer_vprintf+0x6f6>
                format--;
   43998:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   4399f:	01 
            }
            break;
   439a0:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   439a1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   439a4:	83 e0 20             	and    $0x20,%eax
   439a7:	85 c0                	test   %eax,%eax
   439a9:	74 1e                	je     439c9 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   439ab:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   439af:	48 83 c0 18          	add    $0x18,%rax
   439b3:	8b 55 e0             	mov    -0x20(%rbp),%edx
   439b6:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   439ba:	48 89 ce             	mov    %rcx,%rsi
   439bd:	48 89 c7             	mov    %rax,%rdi
   439c0:	e8 63 f8 ff ff       	call   43228 <fill_numbuf>
   439c5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   439c9:	48 c7 45 c0 86 4a 04 	movq   $0x44a86,-0x40(%rbp)
   439d0:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   439d1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   439d4:	83 e0 20             	and    $0x20,%eax
   439d7:	85 c0                	test   %eax,%eax
   439d9:	74 48                	je     43a23 <printer_vprintf+0x779>
   439db:	8b 45 ec             	mov    -0x14(%rbp),%eax
   439de:	83 e0 40             	and    $0x40,%eax
   439e1:	85 c0                	test   %eax,%eax
   439e3:	74 3e                	je     43a23 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   439e5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   439e8:	25 80 00 00 00       	and    $0x80,%eax
   439ed:	85 c0                	test   %eax,%eax
   439ef:	74 0a                	je     439fb <printer_vprintf+0x751>
                prefix = "-";
   439f1:	48 c7 45 c0 87 4a 04 	movq   $0x44a87,-0x40(%rbp)
   439f8:	00 
            if (flags & FLAG_NEGATIVE) {
   439f9:	eb 73                	jmp    43a6e <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   439fb:	8b 45 ec             	mov    -0x14(%rbp),%eax
   439fe:	83 e0 10             	and    $0x10,%eax
   43a01:	85 c0                	test   %eax,%eax
   43a03:	74 0a                	je     43a0f <printer_vprintf+0x765>
                prefix = "+";
   43a05:	48 c7 45 c0 89 4a 04 	movq   $0x44a89,-0x40(%rbp)
   43a0c:	00 
            if (flags & FLAG_NEGATIVE) {
   43a0d:	eb 5f                	jmp    43a6e <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   43a0f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43a12:	83 e0 08             	and    $0x8,%eax
   43a15:	85 c0                	test   %eax,%eax
   43a17:	74 55                	je     43a6e <printer_vprintf+0x7c4>
                prefix = " ";
   43a19:	48 c7 45 c0 8b 4a 04 	movq   $0x44a8b,-0x40(%rbp)
   43a20:	00 
            if (flags & FLAG_NEGATIVE) {
   43a21:	eb 4b                	jmp    43a6e <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43a23:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43a26:	83 e0 20             	and    $0x20,%eax
   43a29:	85 c0                	test   %eax,%eax
   43a2b:	74 42                	je     43a6f <printer_vprintf+0x7c5>
   43a2d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43a30:	83 e0 01             	and    $0x1,%eax
   43a33:	85 c0                	test   %eax,%eax
   43a35:	74 38                	je     43a6f <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   43a37:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   43a3b:	74 06                	je     43a43 <printer_vprintf+0x799>
   43a3d:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   43a41:	75 2c                	jne    43a6f <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   43a43:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43a48:	75 0c                	jne    43a56 <printer_vprintf+0x7ac>
   43a4a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43a4d:	25 00 01 00 00       	and    $0x100,%eax
   43a52:	85 c0                	test   %eax,%eax
   43a54:	74 19                	je     43a6f <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   43a56:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   43a5a:	75 07                	jne    43a63 <printer_vprintf+0x7b9>
   43a5c:	b8 8d 4a 04 00       	mov    $0x44a8d,%eax
   43a61:	eb 05                	jmp    43a68 <printer_vprintf+0x7be>
   43a63:	b8 90 4a 04 00       	mov    $0x44a90,%eax
   43a68:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43a6c:	eb 01                	jmp    43a6f <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   43a6e:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   43a6f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43a73:	78 24                	js     43a99 <printer_vprintf+0x7ef>
   43a75:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43a78:	83 e0 20             	and    $0x20,%eax
   43a7b:	85 c0                	test   %eax,%eax
   43a7d:	75 1a                	jne    43a99 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   43a7f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43a82:	48 63 d0             	movslq %eax,%rdx
   43a85:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43a89:	48 89 d6             	mov    %rdx,%rsi
   43a8c:	48 89 c7             	mov    %rax,%rdi
   43a8f:	e8 ea f5 ff ff       	call   4307e <strnlen>
   43a94:	89 45 bc             	mov    %eax,-0x44(%rbp)
   43a97:	eb 0f                	jmp    43aa8 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   43a99:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43a9d:	48 89 c7             	mov    %rax,%rdi
   43aa0:	e8 a8 f5 ff ff       	call   4304d <strlen>
   43aa5:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   43aa8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43aab:	83 e0 20             	and    $0x20,%eax
   43aae:	85 c0                	test   %eax,%eax
   43ab0:	74 20                	je     43ad2 <printer_vprintf+0x828>
   43ab2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43ab6:	78 1a                	js     43ad2 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   43ab8:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43abb:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   43abe:	7e 08                	jle    43ac8 <printer_vprintf+0x81e>
   43ac0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43ac3:	2b 45 bc             	sub    -0x44(%rbp),%eax
   43ac6:	eb 05                	jmp    43acd <printer_vprintf+0x823>
   43ac8:	b8 00 00 00 00       	mov    $0x0,%eax
   43acd:	89 45 b8             	mov    %eax,-0x48(%rbp)
   43ad0:	eb 5c                	jmp    43b2e <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   43ad2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43ad5:	83 e0 20             	and    $0x20,%eax
   43ad8:	85 c0                	test   %eax,%eax
   43ada:	74 4b                	je     43b27 <printer_vprintf+0x87d>
   43adc:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43adf:	83 e0 02             	and    $0x2,%eax
   43ae2:	85 c0                	test   %eax,%eax
   43ae4:	74 41                	je     43b27 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   43ae6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43ae9:	83 e0 04             	and    $0x4,%eax
   43aec:	85 c0                	test   %eax,%eax
   43aee:	75 37                	jne    43b27 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   43af0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43af4:	48 89 c7             	mov    %rax,%rdi
   43af7:	e8 51 f5 ff ff       	call   4304d <strlen>
   43afc:	89 c2                	mov    %eax,%edx
   43afe:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43b01:	01 d0                	add    %edx,%eax
   43b03:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   43b06:	7e 1f                	jle    43b27 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   43b08:	8b 45 e8             	mov    -0x18(%rbp),%eax
   43b0b:	2b 45 bc             	sub    -0x44(%rbp),%eax
   43b0e:	89 c3                	mov    %eax,%ebx
   43b10:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43b14:	48 89 c7             	mov    %rax,%rdi
   43b17:	e8 31 f5 ff ff       	call   4304d <strlen>
   43b1c:	89 c2                	mov    %eax,%edx
   43b1e:	89 d8                	mov    %ebx,%eax
   43b20:	29 d0                	sub    %edx,%eax
   43b22:	89 45 b8             	mov    %eax,-0x48(%rbp)
   43b25:	eb 07                	jmp    43b2e <printer_vprintf+0x884>
        } else {
            zeros = 0;
   43b27:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   43b2e:	8b 55 bc             	mov    -0x44(%rbp),%edx
   43b31:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43b34:	01 d0                	add    %edx,%eax
   43b36:	48 63 d8             	movslq %eax,%rbx
   43b39:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43b3d:	48 89 c7             	mov    %rax,%rdi
   43b40:	e8 08 f5 ff ff       	call   4304d <strlen>
   43b45:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   43b49:	8b 45 e8             	mov    -0x18(%rbp),%eax
   43b4c:	29 d0                	sub    %edx,%eax
   43b4e:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43b51:	eb 25                	jmp    43b78 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   43b53:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43b5a:	48 8b 08             	mov    (%rax),%rcx
   43b5d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43b63:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43b6a:	be 20 00 00 00       	mov    $0x20,%esi
   43b6f:	48 89 c7             	mov    %rax,%rdi
   43b72:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43b74:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   43b78:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43b7b:	83 e0 04             	and    $0x4,%eax
   43b7e:	85 c0                	test   %eax,%eax
   43b80:	75 36                	jne    43bb8 <printer_vprintf+0x90e>
   43b82:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   43b86:	7f cb                	jg     43b53 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   43b88:	eb 2e                	jmp    43bb8 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   43b8a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43b91:	4c 8b 00             	mov    (%rax),%r8
   43b94:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43b98:	0f b6 00             	movzbl (%rax),%eax
   43b9b:	0f b6 c8             	movzbl %al,%ecx
   43b9e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43ba4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43bab:	89 ce                	mov    %ecx,%esi
   43bad:	48 89 c7             	mov    %rax,%rdi
   43bb0:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   43bb3:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   43bb8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43bbc:	0f b6 00             	movzbl (%rax),%eax
   43bbf:	84 c0                	test   %al,%al
   43bc1:	75 c7                	jne    43b8a <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   43bc3:	eb 25                	jmp    43bea <printer_vprintf+0x940>
            p->putc(p, '0', color);
   43bc5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43bcc:	48 8b 08             	mov    (%rax),%rcx
   43bcf:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43bd5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43bdc:	be 30 00 00 00       	mov    $0x30,%esi
   43be1:	48 89 c7             	mov    %rax,%rdi
   43be4:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   43be6:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   43bea:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   43bee:	7f d5                	jg     43bc5 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   43bf0:	eb 32                	jmp    43c24 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   43bf2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43bf9:	4c 8b 00             	mov    (%rax),%r8
   43bfc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43c00:	0f b6 00             	movzbl (%rax),%eax
   43c03:	0f b6 c8             	movzbl %al,%ecx
   43c06:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43c0c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43c13:	89 ce                	mov    %ecx,%esi
   43c15:	48 89 c7             	mov    %rax,%rdi
   43c18:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   43c1b:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   43c20:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   43c24:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   43c28:	7f c8                	jg     43bf2 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   43c2a:	eb 25                	jmp    43c51 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   43c2c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43c33:	48 8b 08             	mov    (%rax),%rcx
   43c36:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43c3c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43c43:	be 20 00 00 00       	mov    $0x20,%esi
   43c48:	48 89 c7             	mov    %rax,%rdi
   43c4b:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   43c4d:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   43c51:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   43c55:	7f d5                	jg     43c2c <printer_vprintf+0x982>
        }
    done: ;
   43c57:	90                   	nop
    for (; *format; ++format) {
   43c58:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43c5f:	01 
   43c60:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43c67:	0f b6 00             	movzbl (%rax),%eax
   43c6a:	84 c0                	test   %al,%al
   43c6c:	0f 85 64 f6 ff ff    	jne    432d6 <printer_vprintf+0x2c>
    }
}
   43c72:	90                   	nop
   43c73:	90                   	nop
   43c74:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   43c78:	c9                   	leave  
   43c79:	c3                   	ret    

0000000000043c7a <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   43c7a:	55                   	push   %rbp
   43c7b:	48 89 e5             	mov    %rsp,%rbp
   43c7e:	48 83 ec 20          	sub    $0x20,%rsp
   43c82:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43c86:	89 f0                	mov    %esi,%eax
   43c88:	89 55 e0             	mov    %edx,-0x20(%rbp)
   43c8b:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   43c8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c92:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43c96:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c9a:	48 8b 40 08          	mov    0x8(%rax),%rax
   43c9e:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   43ca3:	48 39 d0             	cmp    %rdx,%rax
   43ca6:	72 0c                	jb     43cb4 <console_putc+0x3a>
        cp->cursor = console;
   43ca8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43cac:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   43cb3:	00 
    }
    if (c == '\n') {
   43cb4:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   43cb8:	75 78                	jne    43d32 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   43cba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43cbe:	48 8b 40 08          	mov    0x8(%rax),%rax
   43cc2:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   43cc8:	48 d1 f8             	sar    %rax
   43ccb:	48 89 c1             	mov    %rax,%rcx
   43cce:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   43cd5:	66 66 66 
   43cd8:	48 89 c8             	mov    %rcx,%rax
   43cdb:	48 f7 ea             	imul   %rdx
   43cde:	48 c1 fa 05          	sar    $0x5,%rdx
   43ce2:	48 89 c8             	mov    %rcx,%rax
   43ce5:	48 c1 f8 3f          	sar    $0x3f,%rax
   43ce9:	48 29 c2             	sub    %rax,%rdx
   43cec:	48 89 d0             	mov    %rdx,%rax
   43cef:	48 c1 e0 02          	shl    $0x2,%rax
   43cf3:	48 01 d0             	add    %rdx,%rax
   43cf6:	48 c1 e0 04          	shl    $0x4,%rax
   43cfa:	48 29 c1             	sub    %rax,%rcx
   43cfd:	48 89 ca             	mov    %rcx,%rdx
   43d00:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   43d03:	eb 25                	jmp    43d2a <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   43d05:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43d08:	83 c8 20             	or     $0x20,%eax
   43d0b:	89 c6                	mov    %eax,%esi
   43d0d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d11:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d15:	48 8d 48 02          	lea    0x2(%rax),%rcx
   43d19:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   43d1d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43d21:	89 f2                	mov    %esi,%edx
   43d23:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   43d26:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43d2a:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   43d2e:	75 d5                	jne    43d05 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   43d30:	eb 24                	jmp    43d56 <console_putc+0xdc>
        *cp->cursor++ = c | color;
   43d32:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   43d36:	8b 55 e0             	mov    -0x20(%rbp),%edx
   43d39:	09 d0                	or     %edx,%eax
   43d3b:	89 c6                	mov    %eax,%esi
   43d3d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d41:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d45:	48 8d 48 02          	lea    0x2(%rax),%rcx
   43d49:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   43d4d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43d51:	89 f2                	mov    %esi,%edx
   43d53:	66 89 10             	mov    %dx,(%rax)
}
   43d56:	90                   	nop
   43d57:	c9                   	leave  
   43d58:	c3                   	ret    

0000000000043d59 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   43d59:	55                   	push   %rbp
   43d5a:	48 89 e5             	mov    %rsp,%rbp
   43d5d:	48 83 ec 30          	sub    $0x30,%rsp
   43d61:	89 7d ec             	mov    %edi,-0x14(%rbp)
   43d64:	89 75 e8             	mov    %esi,-0x18(%rbp)
   43d67:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   43d6b:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   43d6f:	48 c7 45 f0 7a 3c 04 	movq   $0x43c7a,-0x10(%rbp)
   43d76:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43d77:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   43d7b:	78 09                	js     43d86 <console_vprintf+0x2d>
   43d7d:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   43d84:	7e 07                	jle    43d8d <console_vprintf+0x34>
        cpos = 0;
   43d86:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   43d8d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d90:	48 98                	cltq   
   43d92:	48 01 c0             	add    %rax,%rax
   43d95:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   43d9b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   43d9f:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   43da3:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43da7:	8b 75 e8             	mov    -0x18(%rbp),%esi
   43daa:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   43dae:	48 89 c7             	mov    %rax,%rdi
   43db1:	e8 f4 f4 ff ff       	call   432aa <printer_vprintf>
    return cp.cursor - console;
   43db6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43dba:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   43dc0:	48 d1 f8             	sar    %rax
}
   43dc3:	c9                   	leave  
   43dc4:	c3                   	ret    

0000000000043dc5 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   43dc5:	55                   	push   %rbp
   43dc6:	48 89 e5             	mov    %rsp,%rbp
   43dc9:	48 83 ec 60          	sub    $0x60,%rsp
   43dcd:	89 7d ac             	mov    %edi,-0x54(%rbp)
   43dd0:	89 75 a8             	mov    %esi,-0x58(%rbp)
   43dd3:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   43dd7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43ddb:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43ddf:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   43de3:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   43dea:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43dee:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43df2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43df6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   43dfa:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   43dfe:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   43e02:	8b 75 a8             	mov    -0x58(%rbp),%esi
   43e05:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43e08:	89 c7                	mov    %eax,%edi
   43e0a:	e8 4a ff ff ff       	call   43d59 <console_vprintf>
   43e0f:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   43e12:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   43e15:	c9                   	leave  
   43e16:	c3                   	ret    

0000000000043e17 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   43e17:	55                   	push   %rbp
   43e18:	48 89 e5             	mov    %rsp,%rbp
   43e1b:	48 83 ec 20          	sub    $0x20,%rsp
   43e1f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43e23:	89 f0                	mov    %esi,%eax
   43e25:	89 55 e0             	mov    %edx,-0x20(%rbp)
   43e28:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   43e2b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e2f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   43e33:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e37:	48 8b 50 08          	mov    0x8(%rax),%rdx
   43e3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e3f:	48 8b 40 10          	mov    0x10(%rax),%rax
   43e43:	48 39 c2             	cmp    %rax,%rdx
   43e46:	73 1a                	jae    43e62 <string_putc+0x4b>
        *sp->s++ = c;
   43e48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e4c:	48 8b 40 08          	mov    0x8(%rax),%rax
   43e50:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43e54:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43e58:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43e5c:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   43e60:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   43e62:	90                   	nop
   43e63:	c9                   	leave  
   43e64:	c3                   	ret    

0000000000043e65 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   43e65:	55                   	push   %rbp
   43e66:	48 89 e5             	mov    %rsp,%rbp
   43e69:	48 83 ec 40          	sub    $0x40,%rsp
   43e6d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   43e71:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   43e75:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   43e79:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   43e7d:	48 c7 45 e8 17 3e 04 	movq   $0x43e17,-0x18(%rbp)
   43e84:	00 
    sp.s = s;
   43e85:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43e89:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   43e8d:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   43e92:	74 33                	je     43ec7 <vsnprintf+0x62>
        sp.end = s + size - 1;
   43e94:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43e98:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43e9c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43ea0:	48 01 d0             	add    %rdx,%rax
   43ea3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   43ea7:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   43eab:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   43eaf:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   43eb3:	be 00 00 00 00       	mov    $0x0,%esi
   43eb8:	48 89 c7             	mov    %rax,%rdi
   43ebb:	e8 ea f3 ff ff       	call   432aa <printer_vprintf>
        *sp.s = 0;
   43ec0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ec4:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   43ec7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ecb:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   43ecf:	c9                   	leave  
   43ed0:	c3                   	ret    

0000000000043ed1 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   43ed1:	55                   	push   %rbp
   43ed2:	48 89 e5             	mov    %rsp,%rbp
   43ed5:	48 83 ec 70          	sub    $0x70,%rsp
   43ed9:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   43edd:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   43ee1:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   43ee5:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43ee9:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43eed:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   43ef1:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   43ef8:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43efc:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   43f00:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43f04:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   43f08:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   43f0c:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   43f10:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   43f14:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43f18:	48 89 c7             	mov    %rax,%rdi
   43f1b:	e8 45 ff ff ff       	call   43e65 <vsnprintf>
   43f20:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   43f23:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   43f26:	c9                   	leave  
   43f27:	c3                   	ret    

0000000000043f28 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   43f28:	55                   	push   %rbp
   43f29:	48 89 e5             	mov    %rsp,%rbp
   43f2c:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43f30:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43f37:	eb 13                	jmp    43f4c <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   43f39:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43f3c:	48 98                	cltq   
   43f3e:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   43f45:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43f48:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43f4c:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   43f53:	7e e4                	jle    43f39 <console_clear+0x11>
    }
    cursorpos = 0;
   43f55:	c7 05 9d 50 07 00 00 	movl   $0x0,0x7509d(%rip)        # b8ffc <cursorpos>
   43f5c:	00 00 00 
}
   43f5f:	90                   	nop
   43f60:	c9                   	leave  
   43f61:	c3                   	ret    
